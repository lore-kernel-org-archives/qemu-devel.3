Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDC9CCD182
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 23:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4pRd-0005Cv-Ui; Fri, 03 Oct 2025 19:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v4pRO-0005Ap-9O
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 19:43:59 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v4pRL-0001SP-IA
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 19:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759535036; x=1791071036;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+pVa50ctXP0XgCPvdpOZl48hgQZbr6set2EyPjGDxgo=;
 b=hAAwgyhxOS/NyY5m6fk8zA3Q3WsJQpI8yqwZYaZE0ha5DJj5ZW5BECRk
 0OY/51aeLAlEtBvAVCL6fTZDN1NOQsIqMYleRjjyXvnMrn3Ed5ghRn9XG
 JkKmTHpFmBLu293se1RoxPyd7Gxwlhx6y+raDv2iqAqAG/2q5OZuLbZ6A
 qfgokcGksIPbetyyFQ6scy6vt5foZB70/S5PtNRqrFCjXvvgi63gLTzQc
 GNVVzTIuid+q625V8m6TmYhvABVDJRFLqZxy1Tojc8larDP2R6k6+NkyD
 bngi6I8l8YnTBETHPsvk+r1hqaAaGHEofLABWKof0+h4sx7dEThQWi+QH A==;
X-CSE-ConnectionGUID: WISdK1bMQ/6pCGV+PUZVvQ==
X-CSE-MsgGUID: ex1gDkw4SambaBTaPzWw8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="61705034"
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; d="scan'208";a="61705034"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 16:43:38 -0700
X-CSE-ConnectionGUID: AyYOOrRnSCS2lE2zCceulQ==
X-CSE-MsgGUID: D/WGCkYbTNuJQ5mV37Ws4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; d="scan'208";a="179428146"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 16:43:38 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to identify blob
 resources
Date: Fri,  3 Oct 2025 16:35:55 -0700
Message-ID: <20251003234138.85820-3-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003234138.85820-1-vivek.kasireddy@intel.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The res->blob pointer may not be valid (non-NULL) for some blobs
where the backing storage is not memfd based. Therefore, we cannot
use it to determine if a resource is a blob or not. Instead, we
could use res->blob_size to make this determination as it is
non-zero for blob resources regardless of where their backing
storage is located.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 70e8757128..df696611a4 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -57,7 +57,7 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
     }
 
     if (res->blob_size) {
-        if (res->blob_size < (s->current_cursor->width *
+        if (!res->blob || res->blob_size < (s->current_cursor->width *
                               s->current_cursor->height * 4)) {
             return;
         }
@@ -144,7 +144,7 @@ virtio_gpu_find_check_resource(VirtIOGPU *g, uint32_t resource_id,
     }
 
     if (require_backing) {
-        if (!res->iov || (!res->image && !res->blob)) {
+        if (!res->iov || (!res->image && !res->blob_size)) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: no backing storage %d\n",
                           caller, resource_id);
             if (error) {
@@ -446,7 +446,7 @@ static void virtio_gpu_transfer_to_host_2d(VirtIOGPU *g,
 
     res = virtio_gpu_find_check_resource(g, t2d.resource_id, true,
                                          __func__, &cmd->error);
-    if (!res || res->blob) {
+    if (!res || res->blob_size) {
         return;
     }
 
@@ -509,7 +509,7 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
         return;
     }
 
-    if (res->blob) {
+    if (res->blob_size) {
         for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
             scanout = &g->parent_obj.scanout[i];
             if (scanout->resource_id == res->resource_id &&
@@ -540,7 +540,7 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
         }
     }
 
-    if (!res->blob &&
+    if (!res->blob_size &&
         (rf.r.x > res->width ||
         rf.r.y > res->height ||
         rf.r.width > res->width ||
@@ -636,7 +636,7 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
 
     g->parent_obj.enable = 1;
 
-    if (res->blob) {
+    if (res->blob_size) {
         if (console_has_gl(scanout->con)) {
             if (!virtio_gpu_update_dmabuf(g, scanout_id, res, fb, r)) {
                 virtio_gpu_update_scanout(g, scanout_id, res, fb, r);
@@ -647,13 +647,16 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
             return true;
         }
 
+        if (!res->blob) {
+            return false;
+        }
         data = res->blob;
     } else {
         data = (uint8_t *)pixman_image_get_data(res->image);
     }
 
     /* create a surface for this scanout */
-    if ((res->blob && !console_has_gl(scanout->con)) ||
+    if ((res->blob_size && !console_has_gl(scanout->con)) ||
         !scanout->ds ||
         surface_data(scanout->ds) != data + fb->offset ||
         scanout->width != r->width ||
@@ -901,7 +904,7 @@ void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
     g_free(res->addrs);
     res->addrs = NULL;
 
-    if (res->blob) {
+    if (res->blob_size) {
         virtio_gpu_fini_udmabuf(res);
     }
 }
-- 
2.50.1


