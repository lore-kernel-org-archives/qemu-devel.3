Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0430DE7C706
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 07:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpLrp-0000q3-Mm; Mon, 09 Feb 2026 02:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vpLrh-0000n8-0G
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:39:27 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vpLrb-0004fV-Bq
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:39:23 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id D4E3D80750;
 Mon, 09 Feb 2026 10:39:14 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:129::1:13])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BdLXu72As8c0-HJP9oJY0; Mon, 09 Feb 2026 10:39:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770622754;
 bh=wR1zkaBlJ6m8/QrbNS3UX5TXoWTTPeYfvjxD/qZ1o9c=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=PW99u9DJC5hyCu+fHqUuynazLm5XAjTGfoFq749Z9/1cIgmxaZI2wjW2dOyTFqzRJ
 73N9IXuiG481M//b4tU6lVATr9EqbqRofqcmF2r90wqz+dCqY36h51eJUc5KSJsmC4
 WCyyTIwPBZQ35KJaCbr6s89f0IZGSDXWOhMeKTX8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH 02/10] vhost: use consistent naming for backend handlers
Date: Mon,  9 Feb 2026 10:38:59 +0300
Message-ID: <20260209073908.2125178-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260209073908.2125178-1-vsementsov@yandex-team.ru>
References: <20260209073908.2125178-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Most of handlers start from simply .vhost_, except for these
four, starting from .vhost_backend_. Let's rename them to be
consistent.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-backend.c         |  6 +++---
 hw/virtio/vhost-user.c            |  8 ++++----
 hw/virtio/vhost-vdpa.c            |  6 +++---
 hw/virtio/vhost.c                 | 14 +++++++-------
 include/hw/virtio/vhost-backend.h | 17 ++++++++---------
 5 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index fea88afc39..caeadd069b 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -358,9 +358,9 @@ static void vhost_kernel_set_iotlb_callback(struct vhost_dev *dev,
 
 const VhostOps kernel_ops = {
         .backend_type = VHOST_BACKEND_TYPE_KERNEL,
-        .vhost_backend_init = vhost_kernel_init,
-        .vhost_backend_cleanup = vhost_kernel_cleanup,
-        .vhost_backend_memslots_limit = vhost_kernel_memslots_limit,
+        .vhost_init = vhost_kernel_init,
+        .vhost_cleanup = vhost_kernel_cleanup,
+        .vhost_memslots_limit = vhost_kernel_memslots_limit,
         .vhost_net_set_backend = vhost_kernel_net_set_backend,
         .vhost_scsi_set_endpoint = vhost_kernel_scsi_set_endpoint,
         .vhost_scsi_clear_endpoint = vhost_kernel_scsi_clear_endpoint,
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index c750b32617..2e58f38ac5 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -3118,10 +3118,10 @@ void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status)
 
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
-        .vhost_backend_init = vhost_user_backend_init,
-        .vhost_backend_cleanup = vhost_user_backend_cleanup,
-        .vhost_backend_memslots_limit = vhost_user_memslots_limit,
-        .vhost_backend_no_private_memslots = vhost_user_no_private_memslots,
+        .vhost_init = vhost_user_backend_init,
+        .vhost_cleanup = vhost_user_backend_cleanup,
+        .vhost_memslots_limit = vhost_user_memslots_limit,
+        .vhost_no_private_memslots = vhost_user_no_private_memslots,
         .vhost_set_log_base = vhost_user_set_log_base,
         .vhost_set_mem_table = vhost_user_set_mem_table,
         .vhost_set_vring_addr = vhost_user_set_vring_addr,
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 2f8f11df86..fd9e92092d 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1590,8 +1590,8 @@ static bool  vhost_vdpa_force_iommu(struct vhost_dev *dev)
 
 const VhostOps vdpa_ops = {
         .backend_type = VHOST_BACKEND_TYPE_VDPA,
-        .vhost_backend_init = vhost_vdpa_init,
-        .vhost_backend_cleanup = vhost_vdpa_cleanup,
+        .vhost_init = vhost_vdpa_init,
+        .vhost_cleanup = vhost_vdpa_cleanup,
         .vhost_set_log_base = vhost_vdpa_set_log_base,
         .vhost_set_vring_addr = vhost_vdpa_set_vring_addr,
         .vhost_set_vring_num = vhost_vdpa_set_vring_num,
@@ -1602,7 +1602,7 @@ const VhostOps vdpa_ops = {
         .vhost_get_features = vhost_vdpa_get_features,
         .vhost_set_owner = vhost_vdpa_set_owner,
         .vhost_set_vring_endian = NULL,
-        .vhost_backend_memslots_limit = vhost_vdpa_memslots_limit,
+        .vhost_memslots_limit = vhost_vdpa_memslots_limit,
         .vhost_set_mem_table = vhost_vdpa_set_mem_table,
         .vhost_set_features = vhost_vdpa_set_features,
         .vhost_reset_device = vhost_vdpa_reset_device,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 3ee353dce0..fe63091985 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -58,7 +58,7 @@ unsigned int vhost_get_max_memslots(void)
     struct vhost_dev *hdev;
 
     QLIST_FOREACH(hdev, &vhost_devices, entry) {
-        max = MIN(max, hdev->vhost_ops->vhost_backend_memslots_limit(hdev));
+        max = MIN(max, hdev->vhost_ops->vhost_memslots_limit(hdev));
     }
     return max;
 }
@@ -69,7 +69,7 @@ unsigned int vhost_get_free_memslots(void)
     struct vhost_dev *hdev;
 
     QLIST_FOREACH(hdev, &vhost_devices, entry) {
-        unsigned int r = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
+        unsigned int r = hdev->vhost_ops->vhost_memslots_limit(hdev);
         unsigned int cur_free = r - hdev->mem->nregions;
 
         if (unlikely(r < hdev->mem->nregions)) {
@@ -664,8 +664,8 @@ static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *section)
          */
         if ((memory_region_get_fd(section->mr) < 0 ||
             !qemu_ram_is_shared(section->mr->ram_block)) &&
-            dev->vhost_ops->vhost_backend_no_private_memslots &&
-            dev->vhost_ops->vhost_backend_no_private_memslots(dev)) {
+            dev->vhost_ops->vhost_no_private_memslots &&
+            dev->vhost_ops->vhost_no_private_memslots(dev)) {
             trace_vhost_reject_section(mr->name, 2);
             return false;
         }
@@ -1677,7 +1677,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     r = vhost_set_backend_type(hdev, backend_type);
     assert(r >= 0);
 
-    r = hdev->vhost_ops->vhost_backend_init(hdev, opaque, errp);
+    r = hdev->vhost_ops->vhost_init(hdev, opaque, errp);
     if (r < 0) {
         goto fail;
     }
@@ -1694,7 +1694,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    limit = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
+    limit = hdev->vhost_ops->vhost_memslots_limit(hdev);
     if (limit < MEMORY_DEVICES_SAFE_MAX_MEMSLOTS &&
         memory_devices_memslot_auto_decision_active()) {
         error_setg(errp, "some memory device (like virtio-mem)"
@@ -1812,7 +1812,7 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
     if (hdev->vhost_ops) {
-        hdev->vhost_ops->vhost_backend_cleanup(hdev);
+        hdev->vhost_ops->vhost_cleanup(hdev);
     }
     assert(!hdev->log);
 
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 57497e197a..aab6bf3ef7 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -51,10 +51,9 @@ struct vhost_scsi_target;
 struct vhost_iotlb_msg;
 struct vhost_virtqueue;
 
-typedef int (*vhost_backend_init)(struct vhost_dev *dev, void *opaque,
-                                  Error **errp);
-typedef int (*vhost_backend_cleanup)(struct vhost_dev *dev);
-typedef int (*vhost_backend_memslots_limit)(struct vhost_dev *dev);
+typedef int (*vhost_init)(struct vhost_dev *dev, void *opaque, Error **errp);
+typedef int (*vhost_cleanup)(struct vhost_dev *dev);
+typedef int (*vhost_memslots_limit)(struct vhost_dev *dev);
 
 typedef int (*vhost_net_set_backend_op)(struct vhost_dev *dev,
                                 struct vhost_vring_file *file);
@@ -131,7 +130,7 @@ typedef int (*vhost_crypto_create_session_op)(struct vhost_dev *dev,
 typedef int (*vhost_crypto_close_session_op)(struct vhost_dev *dev,
                                              uint64_t session_id);
 
-typedef bool (*vhost_backend_no_private_memslots_op)(struct vhost_dev *dev);
+typedef bool (*vhost_no_private_memslots_op)(struct vhost_dev *dev);
 
 typedef int (*vhost_get_inflight_fd_op)(struct vhost_dev *dev,
                                         uint16_t queue_size,
@@ -166,10 +165,10 @@ typedef int (*vhost_check_device_state_op)(struct vhost_dev *dev, Error **errp);
 
 typedef struct VhostOps {
     VhostBackendType backend_type;
-    vhost_backend_init vhost_backend_init;
-    vhost_backend_cleanup vhost_backend_cleanup;
-    vhost_backend_memslots_limit vhost_backend_memslots_limit;
-    vhost_backend_no_private_memslots_op vhost_backend_no_private_memslots;
+    vhost_init vhost_init;
+    vhost_cleanup vhost_cleanup;
+    vhost_memslots_limit vhost_memslots_limit;
+    vhost_no_private_memslots_op vhost_no_private_memslots;
     vhost_net_set_backend_op vhost_net_set_backend;
     vhost_net_set_mtu_op vhost_net_set_mtu;
     vhost_scsi_set_endpoint_op vhost_scsi_set_endpoint;
-- 
2.52.0


