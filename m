Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D825C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 13:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVtYR-0002ar-V9; Fri, 02 Feb 2024 08:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rVtYP-0002a6-Qu
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 08:26:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rVtYO-0003x1-Ci
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 08:26:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706880359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z3zvc/4nhUPeFTpJVr8XLn0eNa/QyBk1RnLntcYPOFI=;
 b=DXgOnKNoaOc6/XdngXzrxst3P9tBWGwFo5Osd1RvTUtaEsrqE69NKY8CXeKzlDL84Fr9xM
 YV9I26RcFK5r6pxIAqAfOMLeSpqi9iD1Dh2PPB4ci+oMv9ypGB1KTmOkPeDFJNeQTWri8F
 kqYGwsxFmtK+MNolX3z2VrSmptHrQt8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-ZV0VOIhyMg6i5Z9jwZ5C2A-1; Fri,
 02 Feb 2024 08:25:56 -0500
X-MC-Unique: ZV0VOIhyMg6i5Z9jwZ5C2A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EFA8285F996;
 Fri,  2 Feb 2024 13:25:56 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 002FF1BDB1;
 Fri,  2 Feb 2024 13:25:54 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mst@redhat.com, sgarzare@redhat.com, eperezma@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH] vdpa-dev: Fix initialisation order to restore VDUSE
 compatibility
Date: Fri,  2 Feb 2024 14:25:21 +0100
Message-ID: <20240202132521.32714-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

VDUSE requires that virtqueues are first enabled before the DRIVER_OK
status flag is set; with the current API of the kernel module, it is
impossible to enable the opposite order in our block export code because
userspace is not notified when a virtqueue is enabled.

This requirement also mathces the normal initialisation order as done by
the generic vhost code in QEMU. However, commit 6c482547 accidentally
changed the order for vdpa-dev and broke access to VDUSE devices with
this.

This changes vdpa-dev to use the normal order again and use the standard
vhost callback .vhost_set_vring_enable for this. VDUSE devices can be
used with vdpa-dev again after this fix.

Cc: qemu-stable@nongnu.org
Fixes: 6c4825476a4351530bcac17abab72295b75ffe98
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/virtio/vdpa-dev.c   |  5 +----
 hw/virtio/vhost-vdpa.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index eb9ecea83b..13e87f06f6 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -253,14 +253,11 @@ static int vhost_vdpa_device_start(VirtIODevice *vdev, Error **errp)
 
     s->dev.acked_features = vdev->guest_features;
 
-    ret = vhost_dev_start(&s->dev, vdev, false);
+    ret = vhost_dev_start(&s->dev, vdev, true);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Error starting vhost");
         goto err_guest_notifiers;
     }
-    for (i = 0; i < s->dev.nvqs; ++i) {
-        vhost_vdpa_set_vring_ready(&s->vdpa, i);
-    }
     s->started = true;
 
     /*
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 3a43beb312..c4574d56c5 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -904,6 +904,22 @@ int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx)
     return r;
 }
 
+static int vhost_vdpa_set_vring_enable(struct vhost_dev *dev, int enable)
+{
+    struct vhost_vdpa *v = dev->opaque;
+    unsigned int i;
+    int ret;
+
+    for (i = 0; i < dev->nvqs; ++i) {
+        ret = vhost_vdpa_set_vring_ready(v, i);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 static int vhost_vdpa_set_config_call(struct vhost_dev *dev,
                                        int fd)
 {
@@ -1524,6 +1540,7 @@ const VhostOps vdpa_ops = {
         .vhost_set_features = vhost_vdpa_set_features,
         .vhost_reset_device = vhost_vdpa_reset_device,
         .vhost_get_vq_index = vhost_vdpa_get_vq_index,
+        .vhost_set_vring_enable = vhost_vdpa_set_vring_enable,
         .vhost_get_config  = vhost_vdpa_get_config,
         .vhost_set_config = vhost_vdpa_set_config,
         .vhost_requires_shm_log = NULL,
-- 
2.43.0


