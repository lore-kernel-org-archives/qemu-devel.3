Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF68C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJs2-0005Ag-9B; Mon, 27 Jul 2026 07:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJrz-00057m-Q7
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJry-0003dz-1Y
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dmJyhOrDhL5/20s5Y4V1M8+fG41aMSEtMEwupRxEmbE=;
 b=iMc1QffviziT7VmMpMgKFAE5vDLHp4svvYmoIQZTOVECEId9YpyY3YgqGrUhFpigrJvC3R
 qlfi+2riySBYZQh8gMuOfs4xl7ktv7DsKetklJhMcwvIvCbBa/sczjQYUjhy7k+yUJCoAd
 e3laeFAr2sy0MhypEeU7w8VDD0VCuUk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-1SpNLww6NcejNW-47Y-1mw-1; Mon,
 27 Jul 2026 07:51:39 -0400
X-MC-Unique: 1SpNLww6NcejNW-47Y-1mw-1
X-Mimecast-MFC-AGG-ID: 1SpNLww6NcejNW-47Y-1mw_1785153098
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B2861955BD3; Mon, 27 Jul 2026 11:51:38 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 74901180025F; Mon, 27 Jul 2026 11:51:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:51:10 +0400
Subject: [GIT PULL 01/23] hw/display/virtio-gpu: Remove the bytes_pp field
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix-v1-1-ca3fa3851347@redhat.com>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6117;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HMZOoVecy0u+MFFPB8kxTy0tmTSpBAwIhoNPuqyS0GA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZ0Y++8GWwo/AL+H/hCWool9df/J/hkFir7LT8
 kJWkDWj/cKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamdGPgAKCRDa6OEJdZac
 5ftxD/9uiAr5CVgSgzMqiuipwTkEUkIQY9I5cvioo4oK1N8+0KF3wdO5y/J3nr99cVqStKX9zbM
 NAS0R+7OtXPw1lL8KnW52MBz0JVucH9fcCEmhaDnY+hrBok0u0ENSVX11ek1m2RBy01akNwc8bm
 iX+Bfmp8S/Wl4q/mNY6IDnEWEnEEyCd1RIYBXLCw4ZIock3ULAKu9VPlocFqL69r56PS69K1uOS
 KI3X27IOUXlHDi6Y+jUn7/N/QHlmwY0842bnmCSBQKeTaPSklcuaGevW/yRdN/isqaCdHVJKqDY
 mz9vSBDNr6z9xQH57FbxdtFLEy0at68vzXVluhe44vekAjTsI2TqM/kAJiK6TE4AFtp+pQJmDn1
 r+NOiu8js0NEQzX1MPeAyrvvvpNNLg7yLlf1sPpoanqMCPaxilimg37yGZYyprMc28WyRhJgCk+
 rfLt0yv837tv+xqMt/S99S7Q4RvoD7ELxrNZ5R5mIA+aVwpVh9dDgTQjinQN4WeQ1Y4N6E/K9C1
 mvkSFsUONoOSB4bvSqn+1LEBlirKTqH3p/FbjAoS/HsvuRoPNHVzxBy3pFWFByl7kqU0m0cV5+a
 yLZwGY4DjlwBOiK57LSFsfzSFGvpwL6ZVdyInCavf4VpIOATsVAnIiUv2dH8f1q1Og46OWHmAR2
 9k47icVAJ+jxMmw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

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
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
[ Marc-André - fix rebase conflict ]
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260719-bpp-v1-1-9b91946d6cf3@rsg.ci.i.u-tokyo.ac.jp>
---
 include/hw/virtio/virtio-gpu.h |  1 -
 hw/display/virtio-gpu.c        | 27 +++++++++++++++++----------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index b9bad27c97a8..2f60c72078b3 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -66,7 +66,6 @@ struct virtio_gpu_simple_resource {
 
 struct virtio_gpu_framebuffer {
     pixman_format_code_t format;
-    uint32_t bytes_pp;
     uint32_t width, height;
     uint32_t stride;
     uint32_t offset;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 718ba3039290..eac039c3c366 100644
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
@@ -720,6 +726,7 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
     struct virtio_gpu_simple_resource *res;
     struct virtio_gpu_framebuffer fb = { 0 };
     struct virtio_gpu_set_scanout ss;
+    uint32_t bytes_pp;
 
     VIRTIO_GPU_FILL_CMD(ss);
     virtio_gpu_bswap_32(&ss, sizeof(ss));
@@ -745,11 +752,11 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
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
@@ -760,6 +767,7 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
                                    uint64_t blob_size)
 {
     uint64_t fbend;
+    uint32_t bytes_pp;
 
     fb->format = virtio_gpu_get_pixman_format(ss->format);
     if (!fb->format) {
@@ -769,15 +777,15 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
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
 
@@ -788,7 +796,7 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
         return false;
     }
 
-    fb->offset = ss->offsets[0] + ss->r.x * fb->bytes_pp + ss->r.y * fb->stride;
+    fb->offset = ss->offsets[0] + ss->r.x * bytes_pp + ss->r.y * fb->stride;
 
     fbend = fb->offset;
     fbend += (uint64_t) fb->stride * ss->r.height;
@@ -1238,8 +1246,7 @@ static const VMStateDescription vmstate_virtio_gpu_scanout = {
         VMSTATE_UINT32(cursor.pos.y, struct virtio_gpu_scanout),
         VMSTATE_UINT32_TEST(fb.format, struct virtio_gpu_scanout,
                             scanout_vmstate_after_v2),
-        VMSTATE_UINT32_TEST(fb.bytes_pp, struct virtio_gpu_scanout,
-                            scanout_vmstate_after_v2),
+        VMSTATE_UNUSED_TEST(scanout_vmstate_after_v2, 4),
         VMSTATE_UINT32_TEST(fb.width, struct virtio_gpu_scanout,
                             scanout_vmstate_after_v2),
         VMSTATE_UINT32_TEST(fb.height, struct virtio_gpu_scanout,

-- 
2.55.0


