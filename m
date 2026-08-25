Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE191C61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypLH-0002AM-RB; Tue, 25 Aug 2026 07:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypLB-00023c-JB
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:29:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypL9-0005oc-Da
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787657354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XM1H1FHOC2W/oioIF8igGxh7G5i7VAS2DlX6Fo+p+rU=;
 b=LK4qOr7AcWd346H6pKjnZZSwnne2ULnfMnqDsH+csJ3hc9mFp8KxJoLErgWoAmgvw+ubO+
 cAN2fM5CMD06LwvIB2UhDbeFgGw7VQAxslXiyXZ0w5kxjAAk+E6QNVje6ykj7z+r3B2UEm
 p9igTpuhiONMu5Uq3g6IU0teA+aMlTc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-JYKFMGvIM-KVJg11CZRoJw-1; Tue,
 25 Aug 2026 07:29:08 -0400
X-MC-Unique: JYKFMGvIM-KVJg11CZRoJw-1
X-Mimecast-MFC-AGG-ID: JYKFMGvIM-KVJg11CZRoJw_1787657347
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEAF819539A0; Tue, 25 Aug 2026 11:29:06 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0232F1800643; Tue, 25 Aug 2026 11:29:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 15:20:54 +0400
Subject: [GIT PULL 04/19] hw/display/qxl: validate primary surface stride
 against width
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-fixes-v1-4-c59e8a620836@redhat.com>
References: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
In-Reply-To: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=10463;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=4UDCl8lex+MxXuYGkgLc9J338hwBSKTVbnExSWrIGN8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjXrURBkt8KXzcL5On+NWHlnlNmSTvn7yx85h+
 dBDs4hPI7mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao161AAKCRDa6OEJdZac
 5TPYD/40gWKCdMuMcUizGaS8rB79GY0psW7B/l/nfdLcpW9ksITYPVj1NCr6ZtrFcxbz5Z2mML5
 c3ltBUMf1q/tkhffoRPTGXDY4b213O1a3pl8XYuNlWSGaVfj4nWgIiaM/QzLxjyH/sSQGzo4ud2
 PZzQR3Aa6rA6Jgp6A3xTX3WtZDAS1Q3CSl7a2m30QsfoLb4aqofSE01+11oDdJMai55ZMnyEzUF
 fGvO0bniImdS8jrtmY03W91HK9GeQqVtyI53ffFZ6XKaff6ZrzTVGsaGx1T1Q/ONBKDG6yacSro
 TZzA1a+W+6MxxREplY8EkSJmcLFwgOZYHd5kF/ZPhmNw7ejOxukYdc4cIz1woaGJc/I1VgrF3yL
 TH5boKIPFjiO0efPpi4mGTu6xAmjHorNkgjl81Us9Fzc3uynnZcwYGDMuN3lj3yWSVPRB907edQ
 t/6uqCfJ/kCIajBtsQkpk1Y5GsbWKBxARxMZwX5KVU4Oscwm6+qEfkNdsDyXr1ppxcMYQRU9ymN
 +JIrnvIR4thcxAV0J+ZnS6+XePnDBxziJGnx8UIqmwZaNBA42EWqjPld8CPfZhLHuyajPnXvWND
 My6AzXgDniqr2iiU9Alq7iggyCqX/911UGGyza9PBTMltkBmhtcG5t7tF2RIj7O4dk8O60oFO1F
 8T0bzK+UTVP9eLw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The existing validation in qxl_create_guest_primary() checks that
abs(stride) * height fits in vgamem_size and that stride is 4-byte
aligned, but never checks that abs(stride) is large enough to hold one
row of pixels for the declared width and format.

A malicious guest can create a primary surface with a stride much
smaller than width * bytes_per_pixel (e.g. stride=4 for a 64-wide 32bpp
surface). The spice server rejects this via red_validate_surface(), but
the return is void and QEMU unconditionally proceeds to set up the local
rendering state. On the next display refresh, VNC or SDL reads width *
bytes_pp per scanline from a region backed by only stride bytes per
row, causing a host-side out-of-bounds read.

Add three checks in qxl_create_guest_primary() before creating the
surface:
 - reject unknown surface formats
 - reject zero width or height
 - reject surfaces where abs(stride) < width * bytes_per_pixel

Also fix three related issues in qxl-render.c:
 - qxl_blit() used abs_stride to advance the dst pointer into the
   DisplaySurface, but when stride is negative the DisplaySurface is a
   packed buffer whose stride may be smaller. Use surface_stride()
   instead.
 - qxl_render_update_area_unlocked() uses guest_head0_width (set via
   QXL_IO_MONITORS_CONFIG_ASYNC) without validating it against
   abs_stride, bypassing the new validation. Clamp the effective width
   to abs_stride / bytes_pp to prevent out-of-bounds access while
   tolerating the normal transient where the monitor config arrives
   before the primary surface is resized to match.
 - Similarly, guest_head0_height bypasses qxl_create_guest_primary()
   validation. Without clamping, abs_stride * height can overrun
   vgamem_size, and the product can also overflow 32 bits (e.g.
   abs_stride=16 MiB, height=256 wraps to zero), defeating the
   qxl_phys2virt() bounds check. Clamp height to
   vgamem_size / abs_stride to prevent both.

While touch it, fix some endianness issues.

Fixes: CVE-2026-16271
Fixes: a19cbfb34642 ("spice: add qxl device")
Fixes: 979f7ef8966b ("qxl: use guest_monitor_config for local renderer.")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3637
Reported-by: huntr bubble
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260806094028.640676-1-marcandre.lureau@redhat.com>
---
 hw/display/qxl-render.c | 66 ++++++++++++++++++++++++++++++-------------------
 hw/display/qxl.c        | 59 +++++++++++++++++++++++++++++++++++++++++++
 hw/display/qxl.h        |  2 ++
 3 files changed, 101 insertions(+), 26 deletions(-)

diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index 4799c9e8befd..348ddba76890 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -27,6 +27,7 @@
 static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect)
 {
     DisplaySurface *surface = qemu_console_surface(qxl->vga.con);
+    int dst_stride = surface_stride(surface);
     uint8_t *dst = surface_data(surface);
     uint8_t *src;
     int len, i;
@@ -45,14 +46,14 @@ static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect)
     } else {
         src += rect->top * qxl->guest_primary.abs_stride;
     }
-    dst += rect->top  * qxl->guest_primary.abs_stride;
+    dst += rect->top  * dst_stride;
     src += rect->left * qxl->guest_primary.bytes_pp;
     dst += rect->left * qxl->guest_primary.bytes_pp;
     len  = (rect->right - rect->left) * qxl->guest_primary.bytes_pp;
 
     for (i = rect->top; i < rect->bottom; i++) {
         memcpy(dst, src, len);
-        dst += qxl->guest_primary.abs_stride;
+        dst += dst_stride;
         src += qxl->guest_primary.qxl_stride;
     }
 }
@@ -61,30 +62,13 @@ void qxl_render_resize(PCIQXLDevice *qxl)
 {
     QXLSurfaceCreate *sc = &qxl->guest_primary.surface;
 
-    qxl->guest_primary.qxl_stride = sc->stride;
-    qxl->guest_primary.abs_stride = abs(sc->stride);
+    qxl->guest_primary.qxl_stride = le32_to_cpu(sc->stride);
+    qxl->guest_primary.abs_stride = abs(qxl->guest_primary.qxl_stride);
     qxl->guest_primary.resized++;
-    switch (sc->format) {
-    case SPICE_SURFACE_FMT_16_555:
-        qxl->guest_primary.bytes_pp = 2;
-        qxl->guest_primary.bits_pp = 15;
-        break;
-    case SPICE_SURFACE_FMT_16_565:
-        qxl->guest_primary.bytes_pp = 2;
-        qxl->guest_primary.bits_pp = 16;
-        break;
-    case SPICE_SURFACE_FMT_32_xRGB:
-    case SPICE_SURFACE_FMT_32_ARGB:
-        qxl->guest_primary.bytes_pp = 4;
-        qxl->guest_primary.bits_pp = 32;
-        break;
-    default:
-        fprintf(stderr, "%s: unhandled format: %x\n", __func__,
-                qxl->guest_primary.surface.format);
-        qxl->guest_primary.bytes_pp = 4;
-        qxl->guest_primary.bits_pp = 32;
-        break;
-    }
+    /* fallback to default bpp if format is unknown */
+    qxl_format_bpp(qxl, le32_to_cpu(sc->format),
+                   &qxl->guest_primary.bytes_pp,
+                   &qxl->guest_primary.bits_pp);
 }
 
 static void qxl_set_rect_to_surface(PCIQXLDevice *qxl, QXLRect *area)
@@ -101,15 +85,45 @@ static void qxl_render_update_area_unlocked(PCIQXLDevice *qxl)
     DisplaySurface *surface;
     int width = qxl->guest_head0_width ?: qxl->guest_primary.surface.width;
     int height = qxl->guest_head0_height ?: qxl->guest_primary.surface.height;
+    uint64_t map_height;
     int i;
 
+    if (width <= 0 || height <= 0) {
+        goto end;
+    }
+
+    if (qxl->guest_primary.bytes_pp > 0) {
+        int max_width = qxl->guest_primary.abs_stride
+                        / qxl->guest_primary.bytes_pp;
+        width = MIN(width, max_width);
+    }
+
+    if (qxl->guest_primary.qxl_stride < 0) {
+        /* qxl_blit() uses the primary height to find the first scanline. */
+        height = MIN(height, (int)qxl->guest_primary.surface.height);
+    }
+
+    if (qxl->guest_primary.abs_stride > 0) {
+        int max_height = qxl->vgamem_size / qxl->guest_primary.abs_stride;
+        height = MIN(height, max_height);
+    }
+
+    /*
+     * height limits the visible update, while map_height is the guest memory
+     * span validated by qxl_phys2virt().  With a negative stride qxl_blit()
+     * addresses scanlines from the declared primary height, so a shorter
+     * monitor still requires validating the full primary surface.
+     */
+    map_height = qxl->guest_primary.qxl_stride < 0 ?
+                 qxl->guest_primary.surface.height : height;
+
     if (qxl->guest_primary.resized) {
         qxl->guest_primary.resized = 0;
         qxl->guest_primary.data = qxl_phys2virt(qxl,
                                                 qxl->guest_primary.surface.mem,
                                                 MEMSLOT_GROUP_GUEST,
                                                 qxl->guest_primary.abs_stride
-                                                * height);
+                                                * map_height);
         if (!qxl->guest_primary.data) {
             goto end;
         }
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index b7d871b9ee33..384b8767b8e6 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1489,6 +1489,47 @@ static void qxl_create_guest_primary_complete(PCIQXLDevice *qxl)
     qxl_render_resize(qxl);
 }
 
+/*
+ * Convert a SpiceSurfaceFormat to bytes per pixel and bits per pixel.
+ *
+ * Only valid for surface suitable for rendering.
+ */
+bool qxl_format_bpp(PCIQXLDevice *qxl, SpiceSurfaceFmt format,
+                    uint32_t *bytes_pp, uint32_t *bits_pp)
+{
+    uint32_t bypp = 4;
+    uint32_t bipp = 32;
+    bool ret = true;
+
+    switch (format) {
+    case SPICE_SURFACE_FMT_16_555:
+        bypp = 2;
+        bipp = 15;
+        break;
+    case SPICE_SURFACE_FMT_16_565:
+        bypp = 2;
+        bipp = 16;
+        break;
+    case SPICE_SURFACE_FMT_32_xRGB:
+    case SPICE_SURFACE_FMT_32_ARGB:
+        bypp = 4;
+        bipp = 32;
+        break;
+    default:
+        ret = false;
+        qxl_set_guest_bug(qxl, "%s: unhandled format: %x", __func__, format);
+    }
+
+    if (bytes_pp != NULL) {
+        *bytes_pp = bypp;
+    }
+    if (bits_pp != NULL) {
+        *bits_pp = bipp;
+    }
+
+    return ret;
+}
+
 static void qxl_create_guest_primary(PCIQXLDevice *qxl, int loadvm,
                                      qxl_async_io async)
 {
@@ -1496,6 +1537,7 @@ static void qxl_create_guest_primary(PCIQXLDevice *qxl, int loadvm,
     QXLSurfaceCreate *sc = &qxl->guest_primary.surface;
     uint32_t requested_height = le32_to_cpu(sc->height);
     int requested_stride = le32_to_cpu(sc->stride);
+    uint32_t bytes_pp;
 
     if (requested_stride == INT32_MIN ||
         abs(requested_stride) * (uint64_t)requested_height
@@ -1532,6 +1574,23 @@ static void qxl_create_guest_primary(PCIQXLDevice *qxl, int loadvm,
         return;
     }
 
+    if (!qxl_format_bpp(qxl, surface.format, &bytes_pp, NULL)) {
+        return;
+    }
+
+    if (surface.width == 0 || surface.height == 0) {
+        qxl_set_guest_bug(qxl, "%s: zero dimension %ux%u",
+                          __func__, surface.width, surface.height);
+        return;
+    }
+
+    if ((uint64_t)surface.width * bytes_pp > abs(surface.stride)) {
+        qxl_set_guest_bug(qxl, "%s: stride too small for width:"
+                          " stride %d width %u bpp %u",
+                          __func__, surface.stride, surface.width, bytes_pp);
+        return;
+    }
+
     surface.mouse_mode = true;
     surface.group_id   = MEMSLOT_GROUP_GUEST;
     if (loadvm) {
diff --git a/hw/display/qxl.h b/hw/display/qxl.h
index 48d664f77736..6f5b96fe86cc 100644
--- a/hw/display/qxl.h
+++ b/hw/display/qxl.h
@@ -181,6 +181,8 @@ void qxl_spice_oom(PCIQXLDevice *qxl);
 void qxl_spice_reset_memslots(PCIQXLDevice *qxl);
 void qxl_spice_reset_image_cache(PCIQXLDevice *qxl);
 void qxl_spice_reset_cursor(PCIQXLDevice *qxl);
+bool qxl_format_bpp(PCIQXLDevice *qxl, SpiceSurfaceFmt format,
+                    uint32_t *bytes_pp, uint32_t *bits_pp);
 
 /* qxl-logger.c */
 int qxl_log_cmd_cursor(PCIQXLDevice *qxl, QXLCursorCmd *cmd, int group_id);

-- 
2.55.0.543.g5ebe2ebe4ea8


