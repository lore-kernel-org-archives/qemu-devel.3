Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FCBC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 07:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA1p3-0001dq-06; Wed, 30 Apr 2025 03:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@zilli.proxmox.com>)
 id 1uA1ox-0001c5-OI
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 03:25:31 -0400
Received: from [94.136.29.99] (helo=zilli.proxmox.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@zilli.proxmox.com>) id 1uA1ot-0004De-BY
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 03:25:31 -0400
Received: by zilli.proxmox.com (Postfix, from userid 1000)
 id 75B741C05FF; Wed, 30 Apr 2025 09:25:25 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: marcandre.lureau@redhat.com,
	qemu-devel@nongnu.org
Cc: Dietmar Maurer <dietmar@proxmox.com>
Subject: [PATCH v5 2/7] add vnc h264 encoder
Date: Wed, 30 Apr 2025 09:25:19 +0200
Message-Id: <20250430072524.3650582-3-dietmar@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250430072524.3650582-1-dietmar@proxmox.com>
References: <20250430072524.3650582-1-dietmar@proxmox.com>
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

This patch implements H264 support for VNC. The RFB protocol
extension is defined in:

https://github.com/rfbproto/rfbproto/blob/master/rfbproto.rst#open-h-264-encoding

Currently the Gstreamer x264enc plugin (software encoder) is used
to encode the video stream.

The gstreamer pipe is:

appsrc -> videoconvert -> x264enc -> appsink

Note: videoconvert is required for RGBx to YUV420 conversion.

The code still use the VNC server framebuffer change detection,
and only encodes and sends video frames if there are changes.

Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
---
 ui/meson.build    |   1 +
 ui/vnc-enc-h264.c | 255 ++++++++++++++++++++++++++++++++++++++++++++++
 ui/vnc-jobs.c     |  53 +++++++---
 ui/vnc.c          |  37 ++++++-
 ui/vnc.h          |  21 ++++
 5 files changed, 350 insertions(+), 17 deletions(-)
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
index 0000000000..26e8c19270
--- /dev/null
+++ b/ui/vnc-enc-h264.c
@@ -0,0 +1,255 @@
+/*
+ * QEMU VNC display driver: H264 encoding
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "vnc.h"
+
+#include <gst/gst.h>
+
+static void destroy_encoder_context(VncState *vs)
+{
+    gst_clear_object(&vs->h264->source);
+    gst_clear_object(&vs->h264->convert);
+    gst_clear_object(&vs->h264->gst_encoder);
+    gst_clear_object(&vs->h264->sink);
+    gst_clear_object(&vs->h264->pipeline);
+}
+
+static bool create_encoder_context(VncState *vs, int w, int h)
+{
+    g_autoptr(GstCaps) source_caps = NULL;
+    GstStateChangeReturn state_change_ret;
+
+    g_assert(vs->h264 != NULL);
+
+    if (vs->h264->sink && w == vs->h264->width && h == vs->h264->height) {
+        return TRUE;
+    }
+
+    destroy_encoder_context(vs);
+
+    vs->h264->width = w;
+    vs->h264->height = h;
+
+    vs->h264->source = gst_element_factory_make("appsrc", "source");
+    if (!vs->h264->source) {
+        VNC_DEBUG("Could not create gst source\n");
+        goto error;
+    }
+
+    vs->h264->convert = gst_element_factory_make("videoconvert", "convert");
+    if (!vs->h264->convert) {
+        VNC_DEBUG("Could not create gst convert element\n");
+        goto error;
+    }
+
+    vs->h264->gst_encoder = gst_element_factory_make("x264enc", "gst-encoder");
+    if (!vs->h264->gst_encoder) {
+        VNC_DEBUG("Could not create gst x264 encoder\n");
+        goto error;
+    }
+
+    g_object_set(
+        vs->h264->gst_encoder,
+        "tune", 4, /* zerolatency */
+        /*
+         * fix for zerolatency with novnc (without, noVNC displays
+         * green stripes)
+         */
+        "threads", 1,
+        "pass", 5, /* Constant Quality */
+        "quantizer", 26,
+        /* avoid access unit delimiters (Nal Unit Type 9) - not required */
+        "aud", false,
+        NULL);
+
+    vs->h264->sink = gst_element_factory_make("appsink", "sink");
+    if (!vs->h264->sink) {
+        VNC_DEBUG("Could not create gst sink\n");
+        goto error;
+    }
+
+    vs->h264->pipeline = gst_pipeline_new("vnc-h264-pipeline");
+    if (!vs->h264->pipeline) {
+        VNC_DEBUG("Could not create gst pipeline\n");
+        goto error;
+    }
+
+    gst_object_ref(vs->h264->source);
+    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->source)) {
+        gst_object_unref(vs->h264->source);
+        VNC_DEBUG("Could not add source to gst pipeline\n");
+        goto error;
+    }
+
+    gst_object_ref(vs->h264->convert);
+    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->convert)) {
+        gst_object_unref(vs->h264->convert);
+        VNC_DEBUG("Could not add convert to gst pipeline\n");
+        goto error;
+    }
+
+    gst_object_ref(vs->h264->gst_encoder);
+    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->gst_encoder)) {
+        gst_object_unref(vs->h264->gst_encoder);
+        VNC_DEBUG("Could not add encoder to gst pipeline\n");
+        goto error;
+    }
+
+    gst_object_ref(vs->h264->sink);
+    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->sink)) {
+        gst_object_unref(vs->h264->sink);
+        VNC_DEBUG("Could not add sink to gst pipeline\n");
+        goto error;
+    }
+
+    source_caps = gst_caps_new_simple(
+        "video/x-raw",
+        "format", G_TYPE_STRING, "BGRx",
+        "framerate", GST_TYPE_FRACTION, 33, 1,
+        "width", G_TYPE_INT, w,
+        "height", G_TYPE_INT, h,
+        NULL);
+
+    if (!source_caps) {
+        VNC_DEBUG("Could not create source caps filter\n");
+        goto error;
+    }
+
+    g_object_set(vs->h264->source, "caps", source_caps, NULL);
+
+    if (gst_element_link_many(
+            vs->h264->source,
+            vs->h264->convert,
+            vs->h264->gst_encoder,
+            vs->h264->sink,
+            NULL
+        ) != TRUE) {
+        VNC_DEBUG("Elements could not be linked.\n");
+        goto error;
+    }
+
+    /* Start playing */
+    state_change_ret = gst_element_set_state(
+        vs->h264->pipeline, GST_STATE_PLAYING);
+
+    if (state_change_ret == GST_STATE_CHANGE_FAILURE) {
+        VNC_DEBUG("Unable to set the pipeline to the playing state.\n");
+        goto error;
+    }
+
+    return TRUE;
+
+ error:
+    destroy_encoder_context(vs);
+    return FALSE;
+}
+
+bool vnc_h264_encoder_init(VncState *vs)
+{
+    g_assert(vs->h264 == NULL);
+
+    vs->h264 = g_new0(VncH264, 1);
+
+    return true;
+}
+
+/*
+ * Returns the number of generated framebuffer updates,
+ * or -1 in case of errors
+ */
+int vnc_h264_send_framebuffer_update(VncState *vs)
+{
+    int n = 0;
+    int rdb_h264_flags = 0;
+    int width, height;
+    uint8_t *src_data_ptr = NULL;
+    size_t src_data_size;
+    GstFlowReturn flow_ret = GST_FLOW_ERROR;
+    GstBuffer *src_buffer = NULL;
+
+    g_assert(vs->h264 != NULL);
+    g_assert(vs->vd != NULL);
+    g_assert(vs->vd->server != NULL);
+
+    width = pixman_image_get_width(vs->vd->server);
+    height = pixman_image_get_height(vs->vd->server);
+
+    g_assert(width == vs->client_width);
+    g_assert(height == vs->client_height);
+
+    if (vs->h264->sink) {
+        if (width != vs->h264->width || height != vs->h264->height) {
+            rdb_h264_flags = 2;
+        }
+    } else {
+        rdb_h264_flags = 2;
+    }
+
+    if (!create_encoder_context(vs, width, height)) {
+        VNC_DEBUG("Create encoder context failed\n");
+        return -1;
+    }
+
+    g_assert(vs->h264->sink != NULL);
+
+    src_data_ptr = vnc_server_fb_ptr(vs->vd, 0, 0);
+    src_data_size = width * height * VNC_SERVER_FB_BYTES;
+
+    src_buffer = gst_buffer_new_wrapped_full(
+        0, src_data_ptr, src_data_size, 0, src_data_size, NULL, NULL);
+
+    g_signal_emit_by_name(
+        vs->h264->source, "push-buffer", src_buffer, &flow_ret);
+
+    if (flow_ret != GST_FLOW_OK) {
+        VNC_DEBUG("gst appsrc push buffer failed\n");
+        return -1;
+    }
+
+    do {
+        GstSample *sample = NULL;
+        GstMapInfo map;
+        GstBuffer *out_buffer;
+
+        /* Retrieve the buffer */
+        g_signal_emit_by_name(vs->h264->sink, "try-pull-sample", 0, &sample);
+        if (!sample) {
+            break;
+        }
+        out_buffer = gst_sample_get_buffer(sample);
+        if (gst_buffer_map(out_buffer, &map, 0)) {
+            vnc_framebuffer_update(vs, 0, 0, width, height, VNC_ENCODING_H264);
+            vnc_write_s32(vs, map.size); /* write data length */
+            vnc_write_s32(vs, rdb_h264_flags); /* write flags */
+            rdb_h264_flags = 0;
+
+            VNC_DEBUG("GST vnc_h264_update send %ld\n", map.size);
+
+            vnc_write(vs, map.data, map.size);
+
+            gst_buffer_unmap(out_buffer, &map);
+
+            n += 1;
+        } else {
+            VNC_DEBUG("unable to map sample\n");
+        }
+        gst_sample_unref(sample);
+    } while (true);
+
+    return n;
+}
+
+void vnc_h264_clear(VncState *vs)
+{
+    if (!vs->h264) {
+        return;
+    }
+
+    destroy_encoder_context(vs);
+
+    g_clear_pointer(&vs->h264, g_free);
+}
diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index fcca7ec632..75a3bbed3d 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -111,7 +111,7 @@ int vnc_job_add_rect(VncJob *job, int x, int y, int w, int h)
 void vnc_job_push(VncJob *job)
 {
     vnc_lock_queue(queue);
-    if (queue->exit || QLIST_EMPTY(&job->rectangles)) {
+    if (queue->exit) {
         g_free(job);
     } else {
         QTAILQ_INSERT_TAIL(&queue->jobs, job, next);
@@ -193,6 +193,9 @@ static void vnc_async_encoding_start(VncState *orig, VncState *local)
     local->zlib = orig->zlib;
     local->hextile = orig->hextile;
     local->zrle = orig->zrle;
+#ifdef CONFIG_GSTREAMER
+    local->h264 = orig->h264;
+#endif
     local->client_width = orig->client_width;
     local->client_height = orig->client_height;
 }
@@ -204,6 +207,9 @@ static void vnc_async_encoding_end(VncState *orig, VncState *local)
     orig->zlib = local->zlib;
     orig->hextile = local->hextile;
     orig->zrle = local->zrle;
+#ifdef CONFIG_GSTREAMER
+    orig->h264 = local->h264;
+#endif
     orig->lossy_rect = local->lossy_rect;
 }
 
@@ -284,25 +290,40 @@ static int vnc_worker_thread_loop(VncJobQueue *queue)
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
+    if (QLIST_EMPTY(&job->rectangles)) {
+        /* Send full screen update (used by h264 encoder) */
+        int width = pixman_image_get_width(vs.vd->server);
+        int height = pixman_image_get_height(vs.vd->server);
+        int n = vnc_send_framebuffer_update(&vs, 0, 0, width, height);
+        if (n >= 0) {
+            n_rectangles += n;
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
index 9e097dc4b4..ba71589c6f 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -970,6 +970,11 @@ int vnc_send_framebuffer_update(VncState *vs, int x, int y, int w, int h)
         case VNC_ENCODING_ZYWRLE:
             n = vnc_zywrle_send_framebuffer_update(vs, x, y, w, h);
             break;
+#ifdef CONFIG_GSTREAMER
+        case VNC_ENCODING_H264:
+            n = vnc_h264_send_framebuffer_update(vs);
+            break;
+#endif
         default:
             vnc_framebuffer_update(vs, x, y, w, h, VNC_ENCODING_RAW);
             n = vnc_raw_send_framebuffer_update(vs, x, y, w, h);
@@ -1152,6 +1157,14 @@ static int vnc_update_client(VncState *vs, int has_dirty)
         return 0;
     }
 
+    if (vs->vnc_encoding == VNC_ENCODING_H264) {
+        vs->job_update = vs->update;
+        vs->update = VNC_STATE_UPDATE_NONE;
+        vnc_job_push(vnc_job_new(vs)); /* fullscreen update */
+        vs->has_dirty = 0;
+        return 1;
+    }
+
     vs->has_dirty += has_dirty;
     if (!vnc_should_update(vs)) {
         return 0;
@@ -1204,7 +1217,11 @@ static int vnc_update_client(VncState *vs, int has_dirty)
 
     vs->job_update = vs->update;
     vs->update = VNC_STATE_UPDATE_NONE;
-    vnc_job_push(job);
+    if (QLIST_EMPTY(&job->rectangles)) {
+        g_free(job);
+    } else {
+        vnc_job_push(job);
+    }
     vs->has_dirty = 0;
     return n;
 }
@@ -1324,6 +1341,10 @@ void vnc_disconnect_finish(VncState *vs)
     vnc_tight_clear(vs);
     vnc_zrle_clear(vs);
 
+#ifdef CONFIG_GSTREAMER
+    vnc_h264_clear(vs);
+#endif
+
 #ifdef CONFIG_VNC_SASL
     vnc_sasl_client_cleanup(vs);
 #endif /* CONFIG_VNC_SASL */
@@ -2179,6 +2200,16 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
             vnc_set_feature(vs, VNC_FEATURE_ZYWRLE);
             vs->vnc_encoding = enc;
             break;
+#ifdef CONFIG_GSTREAMER
+        case VNC_ENCODING_H264:
+            if (vnc_h264_encoder_init(vs)) {
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
@@ -4289,6 +4320,10 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
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
index acc53a2cc1..0fe9a9ab16 100644
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
 
+bool vnc_h264_encoder_init(VncState *vs);
+int vnc_h264_send_framebuffer_update(VncState *vs);
+void vnc_h264_clear(VncState *vs);
+
 /* vnc-clipboard.c */
 void vnc_server_cut_text_caps(VncState *vs);
 void vnc_client_cut_text(VncState *vs, size_t len, uint8_t *text);
-- 
2.39.5


