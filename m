Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE65CC369A2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 11:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1kJG-0003rj-Cp; Mon, 07 Apr 2025 07:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@zilli.proxmox.com>)
 id 1u1kJE-0003qv-9C
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 07:06:32 -0400
Received: from [94.136.29.99] (helo=zilli.proxmox.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@zilli.proxmox.com>) id 1u1kJA-0006dD-Pr
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 07:06:32 -0400
Received: by zilli.proxmox.com (Postfix, from userid 1000)
 id 731B61C159C; Mon,  7 Apr 2025 12:59:51 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: qemu-devel@nongnu.org,
	marcandre.lureau@redhat.com
Cc: Dietmar Maurer <dietmar@proxmox.com>
Subject: [PATCH 2/3] add vnc h264 encoder
Date: Mon,  7 Apr 2025 12:59:38 +0200
Message-Id: <20250407105939.1997660-2-dietmar@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407105939.1997660-1-dietmar@proxmox.com>
References: <20250407105939.1997660-1-dietmar@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 94.136.29.99 (failed)
Received-SPF: none client-ip=94.136.29.99;
 envelope-from=dietmar@zilli.proxmox.com; helo=zilli.proxmox.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, NO_DNS_FOR_FROM=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
---
 ui/meson.build    |   1 +
 ui/vnc-enc-h264.c | 269 ++++++++++++++++++++++++++++++++++++++++++++++
 ui/vnc-jobs.c     |  49 ++++++---
 ui/vnc.c          |  21 ++++
 ui/vnc.h          |  21 ++++
 5 files changed, 346 insertions(+), 15 deletions(-)
 create mode 100644 ui/vnc-enc-h264.c

diff --git a/ui/meson.build b/ui/meson.build
index 35fb04cadf..34f1f33699 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -46,6 +46,7 @@ vnc_ss.add(files(
 ))
 vnc_ss.add(zlib, jpeg)
 vnc_ss.add(when: sasl, if_true: files('vnc-auth-sasl.c'))
+vnc_ss.add(when: gstreamer, if_true: files('vnc-enc-h264.c'))
 system_ss.add_all(when: [vnc, pixman], if_true: vnc_ss)
 system_ss.add(when: vnc, if_false: files('vnc-stubs.c'))
 
diff --git a/ui/vnc-enc-h264.c b/ui/vnc-enc-h264.c
new file mode 100644
index 0000000000..ca8e206335
--- /dev/null
+++ b/ui/vnc-enc-h264.c
@@ -0,0 +1,269 @@
+#include "qemu/osdep.h"
+#include "vnc.h"
+
+#include <gst/gst.h>
+
+static void libavcodec_destroy_encoder_context(VncState *vs)
+{
+    if (!vs->h264) {
+        return;
+    }
+
+    if (vs->h264->source) {
+        gst_object_unref(vs->h264->source);
+        vs->h264->source = NULL;
+    }
+
+    if (vs->h264->convert) {
+        gst_object_unref(vs->h264->convert);
+        vs->h264->convert = NULL;
+    }
+
+    if (vs->h264->gst_encoder) {
+        gst_object_unref(vs->h264->gst_encoder);
+        vs->h264->sink = NULL;
+    }
+
+    if (vs->h264->sink) {
+        gst_object_unref(vs->h264->sink);
+        vs->h264->sink = NULL;
+    }
+
+    if (vs->h264->pipeline) {
+        gst_object_unref(vs->h264->pipeline);
+        vs->h264->pipeline = NULL;
+    }
+}
+
+static bool libavcodec_create_encoder_context(VncState *vs, int w, int h)
+{
+    g_assert(vs->h264 != NULL);
+
+    if (vs->h264->sink) {
+        if (w != vs->h264->width || h != vs->h264->height) {
+            libavcodec_destroy_encoder_context(vs);
+        }
+    }
+
+    if (vs->h264->sink) {
+        return TRUE;
+    }
+
+    vs->h264->width = w;
+    vs->h264->height = h;
+
+    vs->h264->source = gst_element_factory_make("appsrc", "source");
+    if (!vs->h264->source) {
+        VNC_DEBUG("Could not create gst source\n");
+        libavcodec_destroy_encoder_context(vs);
+        return FALSE;
+    }
+
+    vs->h264->convert = gst_element_factory_make("videoconvert", "convert");
+    if (!vs->h264->convert) {
+        VNC_DEBUG("Could not create gst convert element\n");
+        libavcodec_destroy_encoder_context(vs);
+        return FALSE;
+    }
+
+    vs->h264->gst_encoder = gst_element_factory_make("x264enc", "gst-encoder");
+    if (!vs->h264->gst_encoder) {
+        VNC_DEBUG("Could not create gst x264 encoder\n");
+        libavcodec_destroy_encoder_context(vs);
+        return FALSE;
+    }
+
+    g_object_set(vs->h264->gst_encoder, "tune", 4, NULL); /* zerolatency */
+    /* fix for zerolatency with novnc (without, noVNC displays green stripes) */
+    g_object_set(vs->h264->gst_encoder, "threads", 1, NULL);
+
+    g_object_set(vs->h264->gst_encoder, "pass", 5, NULL); /* Constant Quality */
+    g_object_set(vs->h264->gst_encoder, "quantizer", 26, NULL);
+
+    /* avoid access unit delimiters (Nal Unit Type 9) - not required */
+    g_object_set(vs->h264->gst_encoder, "aud", false, NULL);
+
+    vs->h264->sink = gst_element_factory_make("appsink", "sink");
+    if (!vs->h264->sink) {
+        VNC_DEBUG("Could not create gst sink\n");
+        libavcodec_destroy_encoder_context(vs);
+        return FALSE;
+    }
+
+    vs->h264->pipeline = gst_pipeline_new("vnc-h264-pipeline");
+    if (!vs->h264->pipeline) {
+        VNC_DEBUG("Could not create gst pipeline\n");
+        libavcodec_destroy_encoder_context(vs);
+        return FALSE;
+    }
+
+    gst_object_ref(vs->h264->source);
+    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->source)) {
+        gst_object_unref(vs->h264->source);
+        VNC_DEBUG("Could not add source to gst pipeline\n");
+        libavcodec_destroy_encoder_context(vs);
+        return FALSE;
+    }
+
+    gst_object_ref(vs->h264->convert);
+    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->convert)) {
+        gst_object_unref(vs->h264->convert);
+        VNC_DEBUG("Could not add convert to gst pipeline\n");
+        libavcodec_destroy_encoder_context(vs);
+        return FALSE;
+    }
+
+    gst_object_ref(vs->h264->gst_encoder);
+    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->gst_encoder)) {
+        gst_object_unref(vs->h264->gst_encoder);
+        VNC_DEBUG("Could not add encoder to gst pipeline\n");
+        libavcodec_destroy_encoder_context(vs);
+        return FALSE;
+    }
+
+    gst_object_ref(vs->h264->sink);
+    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->sink)) {
+        gst_object_unref(vs->h264->sink);
+        VNC_DEBUG("Could not add sink to gst pipeline\n");
+        libavcodec_destroy_encoder_context(vs);
+        return FALSE;
+    }
+
+    GstCaps *source_caps = gst_caps_new_simple(
+        "video/x-raw",
+        "format", G_TYPE_STRING, "BGRx",
+        "framerate", GST_TYPE_FRACTION, 33, 1,
+        "width", G_TYPE_INT, w,
+        "height", G_TYPE_INT, h,
+        NULL);
+
+    if (!source_caps) {
+        VNC_DEBUG("Could not create source caps filter\n");
+        libavcodec_destroy_encoder_context(vs);
+        return FALSE;
+    }
+
+    g_object_set(vs->h264->source, "caps", source_caps, NULL);
+    gst_caps_unref(source_caps);
+
+    if (gst_element_link_many(
+            vs->h264->source,
+            vs->h264->convert,
+            vs->h264->gst_encoder,
+            vs->h264->sink,
+            NULL
+        ) != TRUE) {
+        VNC_DEBUG("Elements could not be linked.\n");
+        libavcodec_destroy_encoder_context(vs);
+        return FALSE;
+    }
+
+    /* Start playing */
+    int ret = gst_element_set_state(vs->h264->pipeline, GST_STATE_PLAYING);
+    if (ret == GST_STATE_CHANGE_FAILURE) {
+        VNC_DEBUG("Unable to set the pipeline to the playing state.\n");
+        libavcodec_destroy_encoder_context(vs);
+        return FALSE;
+    }
+
+    return TRUE;
+}
+
+int vnc_h264_encoder_init(VncState *vs)
+{
+    g_assert(vs->h264 == NULL);
+
+    vs->h264 = g_malloc0(sizeof(VncH264));
+
+    return 0;
+}
+
+int vnc_h264_send_framebuffer_update(
+    VncState *vs,
+    int _x,
+    int _y,
+    int _w,
+    int _h,
+) {
+    g_assert(vs->h264 != NULL);
+    g_assert(vs->vd != NULL);
+    g_assert(vs->vd->server != NULL);
+
+    int width = pixman_image_get_width(vs->vd->server);
+    int height = pixman_image_get_height(vs->vd->server);
+
+    g_assert(width == vs->client_width);
+    g_assert(height == vs->client_height);
+
+    int rdb_h264_flags = 0;
+
+    if (vs->h264->sink) {
+        if (width != vs->h264->width || height != vs->h264->height) {
+            rdb_h264_flags = 2;
+        }
+    } else {
+        rdb_h264_flags = 2;
+    }
+
+    if (!libavcodec_create_encoder_context(vs, width, height)) {
+        VNC_DEBUG("Create encoder context failed\n");
+        return -1;
+    }
+
+    g_assert(vs->h264->sink != NULL);
+
+    uint8_t *src_data_ptr = vnc_server_fb_ptr(vs->vd, 0, 0);
+    size_t src_data_size = width * height * VNC_SERVER_FB_BYTES;
+
+    GstBuffer *buffer = gst_buffer_new_wrapped_full(
+        0, src_data_ptr, src_data_size, 0, src_data_size, NULL, NULL);
+
+    GstFlowReturn ret;
+    g_signal_emit_by_name(vs->h264->source, "push-buffer", buffer, &ret);
+
+    if (ret != GST_FLOW_OK) {
+        VNC_DEBUG("gst appsrc push buffer failed\n");
+        return -1;
+    }
+
+    GstSample *sample;
+    /* Retrieve the buffer */
+    g_signal_emit_by_name(vs->h264->sink, "pull-sample", &sample);
+    if (sample) {
+        GstBuffer *buf = gst_sample_get_buffer(sample);
+        GstMapInfo map;
+        if (gst_buffer_map(buf, &map, 0)) {
+            vnc_framebuffer_update(vs, 0, 0, width, height, VNC_ENCODING_H264);
+            vnc_write_s32(vs, map.size); /* write data length */
+            vnc_write_s32(vs, rdb_h264_flags); /* write flags */
+            rdb_h264_flags = 0;
+
+            VNC_DEBUG("GST vnc_h264_update send %ld\n", map.size);
+
+            vnc_write(vs, map.data, map.size);
+
+            gst_buffer_unmap(buf, &map);
+
+            return 1;
+        } else {
+            VNC_DEBUG("unable to map sample\n");
+        }
+        gst_sample_unref(sample);
+        return 1;
+    } else {
+        VNC_DEBUG("gst no data\n");
+        return 0;
+    }
+}
+
+void vnc_h264_clear(VncState *vs)
+{
+    if (!vs->h264) {
+        return;
+    }
+
+    libavcodec_destroy_encoder_context(vs);
+
+    g_free(vs->h264);
+    vs->h264 = NULL;
+}
diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index fcca7ec632..853a547d9a 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -193,6 +193,7 @@ static void vnc_async_encoding_start(VncState *orig, VncState *local)
     local->zlib = orig->zlib;
     local->hextile = orig->hextile;
     local->zrle = orig->zrle;
+    local->h264 = orig->h264;
     local->client_width = orig->client_width;
     local->client_height = orig->client_height;
 }
@@ -204,6 +205,7 @@ static void vnc_async_encoding_end(VncState *orig, VncState *local)
     orig->zlib = local->zlib;
     orig->hextile = local->hextile;
     orig->zrle = local->zrle;
+    orig->h264 = local->h264;
     orig->lossy_rect = local->lossy_rect;
 }
 
@@ -284,25 +286,42 @@ static int vnc_worker_thread_loop(VncJobQueue *queue)
     vnc_write_u16(&vs, 0);
 
     vnc_lock_display(job->vs->vd);
-    QLIST_FOREACH_SAFE(entry, &job->rectangles, next, tmp) {
-        int n;
-
-        if (job->vs->ioc == NULL) {
-            vnc_unlock_display(job->vs->vd);
-            /* Copy persistent encoding data */
-            vnc_async_encoding_end(job->vs, &vs);
-            goto disconnected;
-        }
 
-        if (vnc_worker_clamp_rect(&vs, job, &entry->rect)) {
-            n = vnc_send_framebuffer_update(&vs, entry->rect.x, entry->rect.y,
-                                            entry->rect.w, entry->rect.h);
+    if (vs.vnc_encoding == VNC_ENCODING_H264) {
+        int width = pixman_image_get_width(vs.vd->server);
+        int height = pixman_image_get_height(vs.vd->server);
+           int n = vnc_send_framebuffer_update(&vs, 0, 0, width, height);
+        if (n >= 0) {
+            n_rectangles += n;
+        }
+        QLIST_FOREACH_SAFE(entry, &job->rectangles, next, tmp) {
+            g_free(entry);
+        }
+    } else {
+        QLIST_FOREACH_SAFE(entry, &job->rectangles, next, tmp) {
+            int n;
+
+            if (job->vs->ioc == NULL) {
+                vnc_unlock_display(job->vs->vd);
+                /* Copy persistent encoding data */
+                vnc_async_encoding_end(job->vs, &vs);
+                goto disconnected;
+            }
 
-            if (n >= 0) {
-                n_rectangles += n;
+            if (vnc_worker_clamp_rect(&vs, job, &entry->rect)) {
+                n = vnc_send_framebuffer_update(
+                    &vs,
+                    entry->rect.x,
+                    entry->rect.y,
+                    entry->rect.w,
+                    entry->rect.h);
+
+                if (n >= 0) {
+                    n_rectangles += n;
+                }
             }
+            g_free(entry);
         }
-        g_free(entry);
     }
     trace_vnc_job_nrects(&vs, job, n_rectangles);
     vnc_unlock_display(job->vs->vd);
diff --git a/ui/vnc.c b/ui/vnc.c
index 9241caaad9..2e60b55e47 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -972,6 +972,9 @@ int vnc_send_framebuffer_update(VncState *vs, int x, int y, int w, int h)
         case VNC_ENCODING_ZYWRLE:
             n = vnc_zywrle_send_framebuffer_update(vs, x, y, w, h);
             break;
+        case VNC_ENCODING_H264:
+            n = vnc_h264_send_framebuffer_update(vs, x, y, w, h);
+            break;
         default:
             vnc_framebuffer_update(vs, x, y, w, h, VNC_ENCODING_RAW);
             n = vnc_raw_send_framebuffer_update(vs, x, y, w, h);
@@ -1326,6 +1329,10 @@ void vnc_disconnect_finish(VncState *vs)
     vnc_tight_clear(vs);
     vnc_zrle_clear(vs);
 
+#ifdef CONFIG_GSTREAMER
+    vnc_h264_clear(vs);
+#endif
+
 #ifdef CONFIG_VNC_SASL
     vnc_sasl_client_cleanup(vs);
 #endif /* CONFIG_VNC_SASL */
@@ -2181,6 +2188,16 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
             vnc_set_feature(vs, VNC_FEATURE_ZYWRLE);
             vs->vnc_encoding = enc;
             break;
+#ifdef CONFIG_GSTREAMER
+        case VNC_ENCODING_H264:
+            if (vnc_h264_encoder_init(vs) == 0) {
+                vnc_set_feature(vs, VNC_FEATURE_H264);
+                vs->vnc_encoding = enc;
+            } else {
+                VNC_DEBUG("vnc_h264_encoder_init failed\n");
+            }
+            break;
+#endif
         case VNC_ENCODING_DESKTOPRESIZE:
             vnc_set_feature(vs, VNC_FEATURE_RESIZE);
             break;
@@ -4291,6 +4308,10 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
     Error *local_err = NULL;
     char *id = (char *)qemu_opts_id(opts);
 
+#ifdef CONFIG_GSTREAMER
+    gst_init(NULL, NULL);
+#endif
+
     assert(id);
     vnc_display_init(id, &local_err);
     if (local_err) {
diff --git a/ui/vnc.h b/ui/vnc.h
index acc53a2cc1..7e232f7dac 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -46,6 +46,10 @@
 #include "vnc-enc-zrle.h"
 #include "ui/kbd-state.h"
 
+#ifdef CONFIG_GSTREAMER
+#include <gst/gst.h>
+#endif
+
 // #define _VNC_DEBUG 1
 
 #ifdef _VNC_DEBUG
@@ -231,6 +235,14 @@ typedef struct VncZywrle {
     int buf[VNC_ZRLE_TILE_WIDTH * VNC_ZRLE_TILE_HEIGHT];
 } VncZywrle;
 
+#ifdef CONFIG_GSTREAMER
+typedef struct VncH264 {
+    GstElement *pipeline, *source, *gst_encoder, *sink, *convert;
+    size_t width;
+    size_t height;
+} VncH264;
+#endif
+
 struct VncRect
 {
     int x;
@@ -344,6 +356,9 @@ struct VncState
     VncHextile hextile;
     VncZrle *zrle;
     VncZywrle zywrle;
+#ifdef CONFIG_GSTREAMER
+    VncH264 *h264;
+#endif
 
     Notifier mouse_mode_notifier;
 
@@ -404,6 +419,7 @@ enum {
 #define VNC_ENCODING_TRLE                 0x0000000f
 #define VNC_ENCODING_ZRLE                 0x00000010
 #define VNC_ENCODING_ZYWRLE               0x00000011
+#define VNC_ENCODING_H264                 0x00000032 /* 50   */
 #define VNC_ENCODING_COMPRESSLEVEL0       0xFFFFFF00 /* -256 */
 #define VNC_ENCODING_QUALITYLEVEL0        0xFFFFFFE0 /* -32  */
 #define VNC_ENCODING_XCURSOR              0xFFFFFF10 /* -240 */
@@ -464,6 +480,7 @@ enum VncFeatures {
     VNC_FEATURE_XVP,
     VNC_FEATURE_CLIPBOARD_EXT,
     VNC_FEATURE_AUDIO,
+    VNC_FEATURE_H264,
 };
 
 
@@ -625,6 +642,10 @@ int vnc_zrle_send_framebuffer_update(VncState *vs, int x, int y, int w, int h);
 int vnc_zywrle_send_framebuffer_update(VncState *vs, int x, int y, int w, int h);
 void vnc_zrle_clear(VncState *vs);
 
+int vnc_h264_encoder_init(VncState *vs);
+int vnc_h264_send_framebuffer_update(VncState *vs, int x, int y, int w, int h);
+void vnc_h264_clear(VncState *vs);
+
 /* vnc-clipboard.c */
 void vnc_server_cut_text_caps(VncState *vs);
 void vnc_client_cut_text(VncState *vs, size_t len, uint8_t *text);
-- 
2.39.5


