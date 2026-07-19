Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEA8C4450A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 11:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlPoU-0003vA-4k; Sun, 19 Jul 2026 07:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wlPoQ-0003us-Q4
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 07:36:03 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wlPoN-0000h5-SR
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 07:36:02 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66JBZPrj082464
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 19 Jul 2026 20:35:47 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=9RVKDpQ7cgbE/KCosqIL7TgUZDSEdd2ik2QkASyWsO4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1784460947; v=1;
 b=gYapJlosaqHe6QqFjU5+3Tg6Z3qIF4CXlCMTjFDy+itkHBu6Jdn44SBAgg0FuAlF
 +mWKGK5orERzrG73tdb4yX0oLaDVVmE22Yz42evtBv7c4mXhUgWweDYTA7tWRgr/
 MO9ZwHYZ3+klFzaY0hBy89oneSm+lRoe8Ir9slHmIXW0cKBs6rzvoPLEOwXf6G3Q
 MgtvdZkyqgPkXGj+WKlegr0en4u5mbfmmg+DptN30yuw3OgV90ZP4Be2XUQVExcE
 pWxmqPTnZqpDTZe2H4QmXfVevUNRxFlyw2q+Vyy/hCYI3d6VCF9fh+CB3UD4+1M+
 fjV/hKzwd47dVVtUA1PA9g==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 19 Jul 2026 20:35:13 +0900
Subject: [PATCH] hw/display/virtio-gpu: Remove the bytes_pp field
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-bpp-v1-1-9b91946d6cf3@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y3M24rDIBSF4VcJXo9hazTGUIa+R+nFVretQ5NmN
 BkGSt+99nD5w1rfjRXKiQobmxvL9JdKus41xFfD/BnnE/EUajMJsgcjLHfLwgfosNNKRWcsq8s
 lU0z/L+VwfHfZ3A/59Xn9LDL9bpVf3zM2USn44sdm99G1BAFat1L1upPABZ8we5xDpvayZcJtn
 ymccW39dfp+ug4L8RpTWsdGWQudNXbwAYMJQ+/MYCJ5IIwioBJaeIig2fF+fwAPCJJA+QAAAA=
 =
X-Change-ID: 20260719-bpp-803a3544fb79
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-stable@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=6140;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=LvctBKT6tV1nPTKUIEvbgtKPXdYhwikwyLPWXBGiHNg=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ1bMtv4d+bPMO1mWy085eM9NqvO+gPelt9ES6w+XdN2fs
 5XFekZVRykLgxgXg6yYIktK0W5ujejaT4UJ8S0wc1iZQIYwcHEKwERCXRkZ9vd4+Xpme75fG7TT
 c9L1xX6PxJ2/3dm3WoLx0Y9K22MFKowM66feaZwZNu+xro74Ey6dtYk2az9fTzG0s9fZ8mq53FJ
 9HgA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

virtio_gpu_do_set_scanout() validates the stride field of struct
virtio_gpu_framebuffer against the bytes_pp field, but bytes_pp in the
migration stream may be inconsistent with the format field, which
pixman_image_create_bits() uses when it accesses the framebuffer.
That validation is therefore incomplete.

To avoid the trouble of synchronizing the two fields, remove bytes_pp,
and always derive its value from format. Removing bytes_pp is safe
because no released version of QEMU uses its migrated value.

Fixes: 7b5574225429 ("hw/display: check frame buffer can hold blob")
Cc: qemu-stable@nongnu.org
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Based-on: <20260715201055.2465320-1-marcandre.lureau@redhat.com>
("[PATCH] hw/display/virtio-gpu: validate stride against width on scanout")
---
 include/hw/virtio/virtio-gpu.h |  1 -
 hw/display/virtio-gpu.c        | 27 +++++++++++++++++----------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index f69fc1946273..6f889ee84a16 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -65,7 +65,6 @@ struct virtio_gpu_simple_resource {
 
 struct virtio_gpu_framebuffer {
     pixman_format_code_t format;
-    uint32_t bytes_pp;
     uint32_t width, height;
     uint32_t stride;
     uint32_t offset;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index e00fb6effa50..660191d15f78 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -617,6 +617,11 @@ void virtio_gpu_update_scanout(VirtIOGPU *g,
     scanout->fb = *fb;
 }
 
+static uint32_t virtio_gpu_format_bytes_pp(pixman_format_code_t format)
+{
+    return DIV_ROUND_UP(PIXMAN_FORMAT_BPP(format), 8);
+}
+
 static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
                                       uint32_t scanout_id,
                                       struct virtio_gpu_framebuffer *fb,
@@ -625,6 +630,7 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
                                       uint32_t *error)
 {
     struct virtio_gpu_scanout *scanout;
+    uint32_t bytes_pp = virtio_gpu_format_bytes_pp(fb->format);
     uint8_t *data;
 
     scanout = &g->parent_obj.scanout[scanout_id];
@@ -646,10 +652,10 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
         return false;
     }
 
-    if (fb->stride < (uint64_t)fb->width * fb->bytes_pp) {
+    if (fb->stride < (uint64_t)fb->width * bytes_pp) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: stride %u too small for width %u at %u bpp\n",
-                      __func__, fb->stride, fb->width, fb->bytes_pp);
+                      __func__, fb->stride, fb->width, bytes_pp);
         *error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
         return false;
     }
@@ -708,6 +714,7 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
     struct virtio_gpu_simple_resource *res;
     struct virtio_gpu_framebuffer fb = { 0 };
     struct virtio_gpu_set_scanout ss;
+    uint32_t bytes_pp;
 
     VIRTIO_GPU_FILL_CMD(ss);
     virtio_gpu_bswap_32(&ss, sizeof(ss));
@@ -733,11 +740,11 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
     }
 
     fb.format = pixman_image_get_format(res->image);
-    fb.bytes_pp = DIV_ROUND_UP(PIXMAN_FORMAT_BPP(fb.format), 8);
+    bytes_pp = virtio_gpu_format_bytes_pp(fb.format);
     fb.width  = pixman_image_get_width(res->image);
     fb.height = pixman_image_get_height(res->image);
     fb.stride = pixman_image_get_stride(res->image);
-    fb.offset = ss.r.x * fb.bytes_pp + ss.r.y * fb.stride;
+    fb.offset = ss.r.x * bytes_pp + ss.r.y * fb.stride;
 
     virtio_gpu_do_set_scanout(g, ss.scanout_id,
                               &fb, res, &ss.r, &cmd->error);
@@ -748,6 +755,7 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
                                    uint64_t blob_size)
 {
     uint64_t fbend;
+    uint32_t bytes_pp;
 
     fb->format = virtio_gpu_get_pixman_format(ss->format);
     if (!fb->format) {
@@ -757,19 +765,19 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
         return false;
     }
 
-    fb->bytes_pp = DIV_ROUND_UP(PIXMAN_FORMAT_BPP(fb->format), 8);
+    bytes_pp = virtio_gpu_format_bytes_pp(fb->format);
     fb->width = ss->width;
     fb->height = ss->height;
     fb->stride = ss->strides[0];
 
-    if (fb->stride < (uint64_t)fb->width * fb->bytes_pp) {
+    if (fb->stride < (uint64_t)fb->width * bytes_pp) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: stride %u too small for width %u at %u bpp\n",
-                      __func__, fb->stride, fb->width, fb->bytes_pp);
+                      __func__, fb->stride, fb->width, bytes_pp);
         return false;
     }
 
-    fb->offset = ss->offsets[0] + ss->r.x * fb->bytes_pp + ss->r.y * fb->stride;
+    fb->offset = ss->offsets[0] + ss->r.x * bytes_pp + ss->r.y * fb->stride;
 
     fbend = fb->offset;
     fbend += (uint64_t) fb->stride * ss->r.height;
@@ -1219,8 +1227,7 @@ static const VMStateDescription vmstate_virtio_gpu_scanout = {
         VMSTATE_UINT32(cursor.pos.y, struct virtio_gpu_scanout),
         VMSTATE_UINT32_TEST(fb.format, struct virtio_gpu_scanout,
                             scanout_vmstate_after_v2),
-        VMSTATE_UINT32_TEST(fb.bytes_pp, struct virtio_gpu_scanout,
-                            scanout_vmstate_after_v2),
+        VMSTATE_UNUSED_TEST(scanout_vmstate_after_v2, 4),
         VMSTATE_UINT32_TEST(fb.width, struct virtio_gpu_scanout,
                             scanout_vmstate_after_v2),
         VMSTATE_UINT32_TEST(fb.height, struct virtio_gpu_scanout,

---
base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05
change-id: 20260719-bpp-803a3544fb79
prerequisite-message-id: <20260715201055.2465320-1-marcandre.lureau@redhat.com>
prerequisite-patch-id: 2c43dfa5d6a955e0fa3e3ca39ce3038968d85e7a

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


