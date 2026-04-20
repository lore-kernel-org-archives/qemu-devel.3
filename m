Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57480F5A8BB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 20:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEv74-00064i-P7; Mon, 20 Apr 2026 16:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wEv6r-000609-AS
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:20:45 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wEv6n-0006Na-QK
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:20:45 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:c00c:0:640:e0de:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 3C000805E6;
 Mon, 20 Apr 2026 23:20:39 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:54b::1:34])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id XKYwe10MOSw0-ogOWU9hW; Mon, 20 Apr 2026 23:20:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1776716438;
 bh=Lzt97Sdzbosd8ah6Nzek9EVLzTq2J3EisHziWG/rcKI=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=XR+dSqgGpUIrYdsHOhKA3LfQuQZcKSVFH8+ImEDL0EiVXTLY/vuyTyMC/KVrRHyIw
 dufSZaQOwfQiv7ajQsQp5+o0GSUtR9KsVX8+4ZTBXpgL7HAgaU94iS7z7HsRvNPg/t
 o3Dt8FL6Wk7tFPsLjyHzRcOsXiq0QW1IfMDVwpJY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH v2 02/10] vhost: use consistent naming for backend handlers
Date: Mon, 20 Apr 2026 23:20:23 +0300
Message-ID: <20260420202032.714884-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260420202032.714884-1-vsementsov@yandex-team.ru>
References: <20260420202032.714884-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index fea88afc39a..caeadd069b0 100644
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
index 6978d8ee947..78ffb25d6b1 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -3115,10 +3115,10 @@ void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status)
 
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
index 9c7634e2439..93474624898 100644
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
index 4d42f8bda41..ffd7d404cc7 100644
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
@@ -1674,7 +1674,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     r = vhost_set_backend_type(hdev, backend_type);
     assert(r >= 0);
 
-    r = hdev->vhost_ops->vhost_backend_init(hdev, opaque, errp);
+    r = hdev->vhost_ops->vhost_init(hdev, opaque, errp);
     if (r < 0) {
         goto fail;
     }
@@ -1691,7 +1691,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    limit = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
+    limit = hdev->vhost_ops->vhost_memslots_limit(hdev);
     if (limit < MEMORY_DEVICES_SAFE_MAX_MEMSLOTS &&
         memory_devices_memslot_auto_decision_active()) {
         error_setg(errp, "some memory device (like virtio-mem)"
@@ -1809,7 +1809,7 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
     if (hdev->vhost_ops) {
-        hdev->vhost_ops->vhost_backend_cleanup(hdev);
+        hdev->vhost_ops->vhost_cleanup(hdev);
     }
     assert(!hdev->log);
 
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 57497e197aa..aab6bf3ef7e 100644
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


