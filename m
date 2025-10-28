Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F54DCCF9F4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDsti-00033D-R7; Tue, 28 Oct 2025 19:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstd-00031C-BM
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:33 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstM-00017M-LY
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:31 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id F03098175F;
 Wed, 29 Oct 2025 02:14:00 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oDnXpg2bCW20-wtiMufGJ; Wed, 29 Oct 2025 02:14:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761693240;
 bh=Ic5f2KC+92lrPpzC+dJc2PdflQkRqcAGO/TiRTlcmX0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=F7rwYa3YBvKa6P25Kr2JZS4imzjPEsL/q3XnXxGm3OorKtxkNXemRTVS2oari73qX
 pO+W8h0OCfMMsHYhuYjUmZk6xbMeU//MJ7pnrHM810Ds813TEJGgP/9io8YS/L6BXr
 b1QhyJAbxlNDLDumJBkmIm4xH7i13U397o+ObC9k=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: armbru@redhat.com,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [RFC 13/22] hw/display/virtio-gpu: move to new migration APIs
Date: Wed, 29 Oct 2025 02:13:37 +0300
Message-ID: <20251028231347.194844-14-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251028231347.194844-1-vsementsov@yandex-team.ru>
References: <20251028231347.194844-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/display/virtio-gpu.c | 66 ++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 31 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 3a555125be..9356ef391a 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1220,8 +1220,9 @@ static const VMStateDescription vmstate_virtio_gpu_scanouts = {
     },
 };
 
-static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
-                           const VMStateField *field, JSONWriter *vmdesc)
+static bool virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
+                            const VMStateField *field, JSONWriter *vmdesc,
+                            Error **errp)
 {
     VirtIOGPU *g = opaque;
     struct virtio_gpu_simple_resource *res;
@@ -1248,8 +1249,7 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
     }
     qemu_put_be32(f, 0); /* end of list */
 
-    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL,
-                              &error_fatal);
+    return vmstate_save_vmsd(f, &vmstate_virtio_gpu_scanouts, g, NULL, errp);
 }
 
 static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,
@@ -1281,11 +1281,10 @@ static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,
     return true;
 }
 
-static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
-                           const VMStateField *field)
+static bool virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
+                            const VMStateField *field, Error **errp)
 {
     VirtIOGPU *g = opaque;
-    Error *err = NULL;
     struct virtio_gpu_simple_resource *res;
     uint32_t resource_id, pformat;
     int i;
@@ -1296,7 +1295,8 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
     while (resource_id != 0) {
         res = virtio_gpu_find_resource(g, resource_id);
         if (res) {
-            return -EINVAL;
+            error_setg(errp, "Failed to find resource %" PRIu32, resource_id);
+            return false;
         }
 
         res = g_new0(struct virtio_gpu_simple_resource, 1);
@@ -1310,7 +1310,8 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
         pformat = virtio_gpu_get_pixman_format(res->format);
         if (!pformat) {
             g_free(res);
-            return -EINVAL;
+            error_setg(errp, "Unknown pixman format %" PRIu32, res->format);
+            return false;
         }
 
         res->hostmem = calc_image_hostmem(pformat, res->width, res->height);
@@ -1321,10 +1322,9 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
                                              res->width,
                                              res->height,
                                              res->height ? res->hostmem / res->height : 0,
-                                             &err)) {
-            warn_report_err(err);
+                                             errp)) {
             g_free(res);
-            return -EINVAL;
+            return false;
         }
 
         res->addrs = g_new(uint64_t, res->iov_cnt);
@@ -1341,20 +1341,20 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
         if (!virtio_gpu_load_restore_mapping(g, res)) {
             pixman_image_unref(res->image);
             g_free(res);
-            return -EINVAL;
+            error_setg(errp, "Failed to load restore mapping");
+            return false;
         }
 
         resource_id = qemu_get_be32(f);
     }
 
     /* load & apply scanout state */
-    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, &error_fatal);
-
-    return 0;
+    return vmstate_load_vmsd(f, &vmstate_virtio_gpu_scanouts, g, 1, errp);
 }
 
-static int virtio_gpu_blob_save(QEMUFile *f, void *opaque, size_t size,
-                                const VMStateField *field, JSONWriter *vmdesc)
+static bool virtio_gpu_blob_save(QEMUFile *f, void *opaque, size_t size,
+                                 const VMStateField *field, JSONWriter *vmdesc,
+                                 Error **errp)
 {
     VirtIOGPU *g = opaque;
     struct virtio_gpu_simple_resource *res;
@@ -1378,11 +1378,11 @@ static int virtio_gpu_blob_save(QEMUFile *f, void *opaque, size_t size,
     }
     qemu_put_be32(f, 0); /* end of list */
 
-    return 0;
+    return true;
 }
 
-static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
-                                const VMStateField *field)
+static bool virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
+                                 const VMStateField *field, Error **errp)
 {
     VirtIOGPU *g = opaque;
     struct virtio_gpu_simple_resource *res;
@@ -1422,7 +1422,7 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
     return 0;
 }
 
-static int virtio_gpu_post_load(void *opaque, int version_id)
+static bool virtio_gpu_post_load(void *opaque, int version_id, Error **errp)
 {
     VirtIOGPU *g = opaque;
     struct virtio_gpu_scanout *scanout;
@@ -1437,7 +1437,9 @@ static int virtio_gpu_post_load(void *opaque, int version_id)
 
         res = virtio_gpu_find_resource(g, scanout->resource_id);
         if (!res) {
-            return -EINVAL;
+            error_setg(errp, "Failed to find resource %" PRIu32,
+                       scanout->resource_id);
+            return false;
         }
 
         if (scanout->fb.format != 0) {
@@ -1450,12 +1452,14 @@ static int virtio_gpu_post_load(void *opaque, int version_id)
             };
 
             if (!virtio_gpu_do_set_scanout(g, i, &scanout->fb, res, &r, &error)) {
-                return -EINVAL;
+                error_setg(errp, "Failed to set scanout");
+                return false;
             }
         } else {
             /* legacy v1 migration support */
             if (!res->image) {
-                return -EINVAL;
+                error_setg(errp, "No image");
+                return false;
             }
             scanout->ds = qemu_create_displaysurface_pixman(res->image);
             qemu_displaysurface_set_share_handle(scanout->ds, res->share_handle, 0);
@@ -1469,7 +1473,7 @@ static int virtio_gpu_post_load(void *opaque, int version_id)
         res->scanout_bitmask |= (1 << i);
     }
 
-    return 0;
+    return true;
 }
 
 void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
@@ -1638,8 +1642,8 @@ const VMStateDescription vmstate_virtio_gpu_blob_state = {
             .name = "virtio-gpu/blob",
             .info = &(const VMStateInfo) {
                 .name = "blob",
-                .get = virtio_gpu_blob_load,
-                .put = virtio_gpu_blob_save,
+                .load = virtio_gpu_blob_load,
+                .save = virtio_gpu_blob_save,
             },
             .flags = VMS_SINGLE,
         } /* device */,
@@ -1665,8 +1669,8 @@ static const VMStateDescription vmstate_virtio_gpu = {
             .name = "virtio-gpu",
             .info = &(const VMStateInfo) {
                         .name = "virtio-gpu",
-                        .get = virtio_gpu_load,
-                        .put = virtio_gpu_save,
+                        .load = virtio_gpu_load,
+                        .save = virtio_gpu_save,
             },
             .flags = VMS_SINGLE,
         } /* device */,
@@ -1676,7 +1680,7 @@ static const VMStateDescription vmstate_virtio_gpu = {
         &vmstate_virtio_gpu_blob_state,
         NULL
     },
-    .post_load = virtio_gpu_post_load,
+    .post_load_errp = virtio_gpu_post_load,
 };
 
 static const Property virtio_gpu_properties[] = {
-- 
2.48.1


