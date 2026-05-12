Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12656CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMu93-0004iI-Gu; Tue, 12 May 2026 16:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu8f-00046a-2S; Tue, 12 May 2026 16:55:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu8c-00038F-O7; Tue, 12 May 2026 16:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619274; bh=yBUf5mPDddwteeja6RTb3Z3+b9mfjiSs70Ddir/gUGw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bHOvzH++xhAx8AdkLQGjdOfg1CiYsBRDLfxQFDmzWJU9mQnKsvlw+1VFshTngGiGq
 /CTKAmIhQMMtWmMI0EnnnIsEQmlCiqNZoVsvgHUzFfPSc5WIuBRVLW/lnc26fZPKf7
 6tfSDeGMmga3qdhkvJEtUnY8uB8SEfHUfGmH6UVkZhXc5sOSNel8t+iA4C+2kRj7Hf
 IOnoxUJxaerF/FDTs6FVYxUwSY0fB/7SGjupjTH9BzZspF8kCubbNN2qVgZaYhhnCB
 wVVqEKiwaunjpNzQJg8sGucDD/f/sANb616+YJr8iTlRSNlg4wM++N9l+lNLYd6Z7k
 EWjGA9a/bbwAQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 355661AA2D9;
 Tue, 12 May 2026 23:54:34 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4111C3ABC4A;
 Tue, 12 May 2026 23:54:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zero Day Initiative <zdi-disclosures@trendmicro.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 013/107] virtio-gpu: fix overflow check when
 allocating 2d image
Date: Tue, 12 May 2026 23:53:00 +0300
Message-ID: <20260512205437.360850-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The calc_image_hostmem() comment says pixman_image_create_bits() checks
for overflow. However, this relied on the facts that "bits" was NULL and
it performed it when it was introduced. Since commit 9462ff4695aa, the
"bits" argument can be provided and the check is no longer applied.

Promotes the computation to uint64_t and adds an explicit overflow check
to avoid potential later OOB read/write on the image data.

Fixes: CVE-2026-3886
Fixes: ZDI-CAN-27578
Fixes: 9462ff4695aa ("virtio-gpu/win32: allocate shareable 2d resources/images")
Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-Id: <20260311-cve-v1-1-f72b4c7c1ab2@redhat.com>
(cherry picked from commit c035d5eadf400670593a76778f98f052d7482968)
(Mjt: adjust context for 10.0.x)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 7ab5221fbc..0d1e991e1c 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -227,16 +227,20 @@ void virtio_gpu_get_edid(VirtIOGPU *g,
     virtio_gpu_ctrl_response(g, cmd, &edid.hdr, sizeof(edid));
 }
 
-static uint32_t calc_image_hostmem(pixman_format_code_t pformat,
-                                   uint32_t width, uint32_t height)
+static bool calc_image_hostmem(pixman_format_code_t pformat,
+                               uint32_t width, uint32_t height,
+                               uint32_t *hostmem)
 {
-    /* Copied from pixman/pixman-bits-image.c, skip integer overflow check.
-     * pixman_image_create_bits will fail in case it overflow.
-     */
+    uint64_t bpp = PIXMAN_FORMAT_BPP(pformat);
+    uint64_t stride = (((uint64_t)width * bpp + 0x1f) >> 5) * sizeof(uint32_t);
+    uint64_t size = (uint64_t)height * stride;
 
-    int bpp = PIXMAN_FORMAT_BPP(pformat);
-    int stride = ((width * bpp + 0x1f) >> 5) * sizeof(uint32_t);
-    return height * stride;
+    if (size > UINT32_MAX) {
+        return false;
+    }
+
+    *hostmem = size;
+    return true;
 }
 
 static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
@@ -245,6 +249,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
     pixman_format_code_t pformat;
     struct virtio_gpu_simple_resource *res;
     struct virtio_gpu_resource_create_2d c2d;
+    uint32_t hostmem;
 
     VIRTIO_GPU_FILL_CMD(c2d);
     virtio_gpu_bswap_32(&c2d, sizeof(c2d));
@@ -283,7 +288,12 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
         return;
     }
 
-    res->hostmem = calc_image_hostmem(pformat, c2d.width, c2d.height);
+    if (!calc_image_hostmem(pformat, c2d.width, c2d.height, &hostmem)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: image dimensions overflow\n",
+                      __func__);
+        goto end;
+    }
+    res->hostmem = hostmem;
     if (res->hostmem + g->hostmem < g->conf_max_hostmem) {
         if (!qemu_pixman_image_new_shareable(
                 &res->image,
@@ -1283,7 +1293,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
 {
     VirtIOGPU *g = opaque;
     struct virtio_gpu_simple_resource *res;
-    uint32_t resource_id, pformat;
+    uint32_t resource_id, pformat, hostmem;
     int i;
 
     g->hostmem = 0;
@@ -1309,7 +1319,11 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
             return -EINVAL;
         }
 
-        res->hostmem = calc_image_hostmem(pformat, res->width, res->height);
+        if (!calc_image_hostmem(pformat, res->width, res->height, &hostmem)) {
+            g_free(res);
+            return -EINVAL;
+        }
+        res->hostmem = hostmem;
         if (!qemu_pixman_image_new_shareable(&res->image,
                                              &res->share_handle,
                                              "virtio-gpu res",
-- 
2.47.3


