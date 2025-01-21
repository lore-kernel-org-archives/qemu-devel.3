Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9DEC0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 10:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taBw7-0006gt-Vu; Tue, 21 Jan 2025 05:56:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taBvz-0006ek-MX
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:56:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taBvx-00056s-7r
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737456996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=91Ph9kNYeXsoVFO6NxOH/K8Dbo3YcWqv4IxMaz5wxg8=;
 b=NJSWUZRLMOJQcDutDw3n1nMKr6nXx6pCyLfN6kW3gjaBIk7K9FVP53TAVnNp6cvZlBbg39
 LQLlN85NYLTYnNdLwt3tv9CfM+2PUubObyBvCN5I87Wpveh8fyZAC6ErGRQSqROuWrLsTb
 Pvz9wgKFDXvwZe6+6RdnHuC4jfzD9KE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-txlZHH0pOYSyvuusR7v7tA-1; Tue,
 21 Jan 2025 05:56:30 -0500
X-MC-Unique: txlZHH0pOYSyvuusR7v7tA-1
X-Mimecast-MFC-AGG-ID: txlZHH0pOYSyvuusR7v7tA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8713C195604F; Tue, 21 Jan 2025 10:56:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.56])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 047C519560A7; Tue, 21 Jan 2025 10:56:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 5/9] pc-bios/s390-ccw/virtio: Add a function to reset a virtio
 device
Date: Tue, 21 Jan 2025 11:56:07 +0100
Message-ID: <20250121105613.1286672-6-thuth@redhat.com>
In-Reply-To: <20250121105613.1286672-1-thuth@redhat.com>
References: <20250121105613.1286672-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.036,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

To be able to properly silence a virtio device after using it,
we need a global function to reset the device.

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Tested-by: Jared Rossi <jrossi@linux.ibm.com>
Message-ID: <20250116115826.192047-2-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/virtio.h | 1 +
 pc-bios/s390-ccw/virtio.c | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 9faf3986b1..f13fa6f5fe 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -274,6 +274,7 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags);
 int vr_poll(VRing *vr);
 int vring_wait_reply(void);
 int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd);
+int virtio_reset(VDev *vdev);
 int virtio_setup_ccw(VDev *vdev);
 
 int virtio_net_init(void *mac_addr);
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 8b5a370bb3..cd6c99c7e3 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -217,6 +217,11 @@ int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)
     return 0;
 }
 
+int virtio_reset(VDev *vdev)
+{
+    return run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0, false);
+}
+
 int virtio_setup_ccw(VDev *vdev)
 {
     int i, cfg_size = 0;
@@ -235,7 +240,7 @@ int virtio_setup_ccw(VDev *vdev)
     vdev->config.blk.blk_size = 0; /* mark "illegal" - setup started... */
     vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
 
-    run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0, false);
+    virtio_reset(vdev);
 
     status = VIRTIO_CONFIG_S_ACKNOWLEDGE;
     if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false)) {
-- 
2.48.1


