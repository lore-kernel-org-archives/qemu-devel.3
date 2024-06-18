Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B97C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 12:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJXor-0008E7-CR; Tue, 18 Jun 2024 08:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sJXoq-0008Dr-El
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 08:20:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sJXon-00018P-HT
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 08:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718713207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Gfx8u5PBeNIWLKuxW1PeH6OtDoIJg6SEGDvhLof9cMY=;
 b=V2DVNVt10XumzzSI6AVIAvAip1QM7LV37zB2kVOvvd2cDJ/dqIRdM0MU4eckdGT1ld8ryn
 /qiZRJqGNBVOa/MVLbv9GLfhjLNfVsQH48QsfXCtID9zvTkBsdWNYD/veH6MgZfpP4Q2pz
 +ludRnNqpll3QiGmPLRdeB/Y3EIAV6k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-AjrDRTr_MYqkXLixZmyEMw-1; Tue,
 18 Jun 2024 08:20:04 -0400
X-MC-Unique: AjrDRTr_MYqkXLixZmyEMw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4BD01956052; Tue, 18 Jun 2024 12:20:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.170])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 03DAE3000218; Tue, 18 Jun 2024 12:19:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] hw/virtio: Fix the de-initialization of vhost-user devices
Date: Tue, 18 Jun 2024 14:19:58 +0200
Message-ID: <20240618121958.88673-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The unrealize functions of the various vhost-user devices are
calling the corresponding vhost_*_set_status() functions with a
status of 0 to shut down the device correctly.

Now these vhost_*_set_status() functions all follow this scheme:

    bool should_start = virtio_device_should_start(vdev, status);

    if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
        return;
    }

    if (should_start) {
        /* ... do the initialization stuff ... */
    } else {
        /* ... do the cleanup stuff ... */
    }

The problem here is virtio_device_should_start(vdev, 0) currently
always returns "true" since it internally only looks at vdev->started
instead of looking at the "status" parameter. Thus once the device
got started once, virtio_device_should_start() always returns true
and thus the vhost_*_set_status() functions return early, without
ever doing any clean-up when being called with status == 0. This
causes e.g. problems when trying to hot-plug and hot-unplug a vhost
user devices multiple times since the de-initialization step is
completely skipped during the unplug operation.

This bug has been introduced in commit 9f6bcfd99f ("hw/virtio: move
vm_running check to virtio_device_started") which replaced

 should_start = status & VIRTIO_CONFIG_S_DRIVER_OK;

with

 should_start = virtio_device_started(vdev, status);

which later got replaced by virtio_device_should_start(). This blocked
the possibility to set should_start to false in case the status flag
VIRTIO_CONFIG_S_DRIVER_OK was not set.

Fix it by adjusting the virtio_device_should_start() function to
only consider the status flag instead of vdev->started. Since this
function is only used in the various vhost_*_set_status() functions
for exactly the same purpose, it should be fine to fix it in this
central place there without any risk to change the behavior of other
code.

Fixes: 9f6bcfd99f ("hw/virtio: move vm_running check to virtio_device_started")
Buglink: https://issues.redhat.com/browse/RHEL-40708
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/virtio/virtio.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 7d5ffdc145..2eafad17b8 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -470,9 +470,9 @@ static inline bool virtio_device_started(VirtIODevice *vdev, uint8_t status)
  * @vdev - the VirtIO device
  * @status - the devices status bits
  *
- * This is similar to virtio_device_started() but also encapsulates a
- * check on the VM status which would prevent a device starting
- * anyway.
+ * This is similar to virtio_device_started() but ignores vdev->started
+ * and also encapsulates a check on the VM status which would prevent a
+ * device from starting anyway.
  */
 static inline bool virtio_device_should_start(VirtIODevice *vdev, uint8_t status)
 {
@@ -480,7 +480,7 @@ static inline bool virtio_device_should_start(VirtIODevice *vdev, uint8_t status
         return false;
     }
 
-    return virtio_device_started(vdev, status);
+    return status & VIRTIO_CONFIG_S_DRIVER_OK;
 }
 
 static inline void virtio_set_started(VirtIODevice *vdev, bool started)
-- 
2.45.2


