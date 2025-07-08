Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCDDC83F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFDT-00029R-2P; Tue, 08 Jul 2025 16:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.milosevic@9elements.com>)
 id 1uZDnI-0004Sx-9f
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:16:06 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <david.milosevic@9elements.com>)
 id 1uZDn4-00078h-K6
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:15:52 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a6f2c6715fso4235047f8f.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1752002139; x=1752606939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3P98FaovY9iwvLZaff233B7gZMlMWlgSqALv1uUW1KM=;
 b=J5bQQeR5sUIHXqljta0LZLpjDbnnEMW/c+DbZa/+KM12vmvmf9scLdqAjk0O6Z6G27
 J2tikdjRQ3UvXVMPaugKFhnVmEFh1rXSUXrDpWeUT8rRhI/G9IJGjjPZcukPI7RgJmdP
 B6Gtp2v7FYKemzP3k6e4qbvMJ2ezmrCWtffM4aT9FgueaxIIH9GIEjFRLEZtwtc/kwd3
 ZKg3n+S1WJnrrp5J2sXYO854IK5I5uvPxYzR9tA0xPcAECQ74myotnlvp2i5+CBwAB9A
 DnBqq1TDLJW7+jMu/Y5hfxoG35aeMxQy1SM0GIdxc+VshB2+tdfb/fzb41avFqxQIBmJ
 F2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752002139; x=1752606939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3P98FaovY9iwvLZaff233B7gZMlMWlgSqALv1uUW1KM=;
 b=GgSR9bLRKy+MD7lUetQfnoGQ2QpDU0uK6td8AfpYK/2dbH++lqgqqqXof0jd+XwIYZ
 OLDwbd7xK7fn29wnRryC/u1sdnpaX+xKm/zcONkU5VAcnZNd9fqStIVOFEDy+BmT/YWJ
 2qoSkYCDrOv4UX5KWAS9xb6e2NXi1MMSGm71giUGJ0ObpJGdl3plcLyGCAki6iNfCrp2
 qs0Bycf3KMMfINw+0BS45fuG9oDiLmLwakJ5OOwmIw5VEqt8IDh868tnByM3ijYm0D0X
 Q9LDN3ix2tIGbZESb1GqRJ3nS52AJmMFxH8aKvd7JolMHdrF+VByOh1/MaG3kEHk6hfS
 +piQ==
X-Gm-Message-State: AOJu0Yzr/e/cogYjiVDx+76dWqqx18mhuTPrmS5UNOxlcW71YtWWW+SG
 qsg19tV8RfXrbEwic2or9xeGWbSH8ZqEGl8ZWgiryavxXywx9nFrMxtxz9FbD63hm3Qn2HYcJLT
 L/FlqPyN/0nnc
X-Gm-Gg: ASbGncvq0XDSRE+Jycx7iC5369ThZb4edXMfKcW/1pcBFz+RFK8ms3vIWcLKk4K23bj
 77xEra1m7qUoEJcp8H9+DIeVxTdJq1opkjgPzJMZEKfjAa3vIxrW47CLxGtTiOR03Dt26iNUqLV
 nBp3hEiHlxGOmS6SgrcwVktbzi6b2IgGBzc3J5E+rUB8YkCfapA7nE4AHKuyjO6sOHiBL7nC5pb
 MaYdICuhY0+G9rbyUqwOoI746fwHVEI+Kb0Z5ywF1Iw58TTkO1PDLWLmYaJxEVAeZR7PrOaBxqL
 XkX4f1hO1qFXz5LEJ23A0BFLvV6S7K+M0uTctTYCzSAP3duPcyVpf5FFlcp4PAEyv+3dCWCr18Z
 /VZVryzODfQ90JqtN/Cu3B+EzDtQ3cru6GWIA38IiKN8y2yncBiDOQasxpWpjx8Q=
X-Google-Smtp-Source: AGHT+IHvtB6vYj6wFnyfQCYOxda0lPOaauw0FfzfauxKR2Sh68A1DlKq5h5R8xS+0gZxDP+XffSyzw==
X-Received: by 2002:a05:600c:3b11:b0:43d:ac5:11e8 with SMTP id
 5b1f17b1804b1-454b4ead65emr125189815e9.21.1751986713658; 
 Tue, 08 Jul 2025 07:58:33 -0700 (PDT)
Received: from cbox.sec.9e.network
 (p200300f75f10f341000000000000002d.dip0.t-ipconnect.de.
 [2003:f7:5f10:f341::2d]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd3d2749sm25445735e9.25.2025.07.08.07.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 07:58:33 -0700 (PDT)
From: David Milosevic <david.milosevic@9elements.com>
X-Google-Original-From: David Milosevic <David.Milosevic@9elements.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 pizhenwei@bytedance.com, marcello.bauer@9elements.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 David Milosevic <David.Milosevic@9elements.com>
Subject: [PATCH 2/3] video: add GStreamer backend
Date: Tue,  8 Jul 2025 16:56:49 +0200
Message-ID: <20250708145828.63295-3-David.Milosevic@9elements.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250708145828.63295-1-David.Milosevic@9elements.com>
References: <20250708145828.63295-1-David.Milosevic@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=david.milosevic@9elements.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This follow-up extends the video subsystem by adding
support for a GStreamer backend.

There are some rules to follow when passing a GStreamer
pipeline to QEMU:

  - pipeline must start with a source element (for example, v4l2src)
  - pipeline must NOT end with a sink element. QEMU will dynamically
    create and append an appsink to the provided cmdline pipeline

In between, one can add an arbitrary number of converter elements to
the cmdline pipeline.

QEMU will also create a capsfilter right before its appsink, in order
to have control over streaming parameters such as pixelformat, width,
height, ...

Hence, the final pipeline looks like this:

  <------------------- qemu-cmdline -------------------><--- qemu-runtime --->
  [source] -> [converter #1] -> ... -> [converter #n] -> capsfilter -> appsink

Example usage:
  qemu-system-x86_64 \
    -device qemu-xhci \
    -videodev gstreamer,id=cam0,pipeline="v4l2src device=/dev/video0 ! videoconvert" \
    -device usb-video,videodev=cam0

Pipelines like this are also possible:
  pipeline="videotestsrc pattern=snow ! " \
           "capsfilter caps=video/x-raw^format=YUY2^width=1280^height=720^framerate=30/1"

Note the use of '^' in the GStreamer pipeline string.
QEMU's option parser does not allow commas ',' inside option values,
which makes it difficult to pass full GStreamer pipelines directly via
the command line.

To avoid modifying QEMU's core option parsing logic, we adopt a
simple workaround: users are asked to substitute commas with '^' when
specifying the pipeline.

Signed-off-by: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
Signed-off-by: David Milosevic <David.Milosevic@9elements.com>
---
 meson.build                   |  11 +
 meson_options.txt             |   2 +
 qemu-options.hx               |   3 +
 scripts/meson-buildoptions.sh |   3 +
 video/gstreamer-common.h      |  49 +++
 video/gstreamer.c             | 642 ++++++++++++++++++++++++++++++++++
 video/meson.build             |   2 +
 7 files changed, 712 insertions(+)
 create mode 100644 video/gstreamer-common.h
 create mode 100644 video/gstreamer.c

diff --git a/meson.build b/meson.build
index 9eb6349182..4eb4a93d41 100644
--- a/meson.build
+++ b/meson.build
@@ -2313,6 +2313,15 @@ if not get_option('libdw').auto() or \
                        required: get_option('libdw'))
 endif
 
+gstreamer = not_found
+gstreamer_app = not_found
+if not get_option('gstreamer').auto() or (host_os == 'linux' and have_system)
+  gstreamer = dependency('gstreamer-1.0', required: get_option('gstreamer'),
+                         method: 'pkg-config')
+  gstreamer_app = dependency('gstreamer-app-1.0', required: get_option('gstreamer'),
+                             method: 'pkg-config')
+endif
+
 v4l2 = not_found
 if not get_option('v4l2').auto() or (host_os == 'linux' and have_system)
   v4l2 = declare_dependency()
@@ -2368,6 +2377,7 @@ config_host_data.set('CONFIG_AUDIO_DRIVERS',
 
 if have_system
   video_backend_available = {
+    'gstreamer': gstreamer.found() and gstreamer_app.found(),
     'v4l2': v4l2.found(),
   }
   foreach k, v: video_backend_available
@@ -4949,6 +4959,7 @@ summary(summary_info, bool_yn: true, section: 'Network backends')
 
 # Video backends
 summary_info = {}
+summary_info += {'gstreamer support':     gstreamer.found() and gstreamer_app.found()}
 summary_info += {'v4l2 support':          v4l2}
 summary(summary_info, bool_yn: true, section: 'Video backends')
 
diff --git a/meson_options.txt b/meson_options.txt
index ec2d4236f4..cd37affda2 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -383,5 +383,7 @@ option('rust', type: 'feature', value: 'disabled',
 option('strict_rust_lints', type: 'boolean', value: false,
        description: 'Enable stricter set of Rust warnings')
 
+option('gstreamer', type: 'feature', value: 'auto',
+       description: 'gstreamer video backend support')
 option('v4l2', type: 'feature', value: 'auto',
        description: 'v4l2 video backend support')
diff --git a/qemu-options.hx b/qemu-options.hx
index 4e2cf31d88..f1a82f052d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1089,6 +1089,9 @@ SRST
 ERST
 
 DEF("videodev", HAS_ARG, QEMU_OPTION_videodev,
+#ifdef CONFIG_VIDEO_GSTREAMER
+    "-videodev gstreamer,id=id,pipeline=pipeline\n"
+#endif
 #ifdef CONFIG_VIDEO_V4L2
     "-videodev v4l2,id=id,device=path\n"
 #endif
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index b7ffa51921..80b530bf01 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -123,6 +123,7 @@ meson_options_help() {
   printf "%s\n" '  gio             use libgio for D-Bus support'
   printf "%s\n" '  glusterfs       Glusterfs block device driver'
   printf "%s\n" '  gnutls          GNUTLS cryptography support'
+  printf "%s\n" '  gstreamer       gstreamer video backend support'
   printf "%s\n" '  gtk             GTK+ user interface'
   printf "%s\n" '  gtk-clipboard   clipboard support for the gtk UI (EXPERIMENTAL, MAY HANG)'
   printf "%s\n" '  guest-agent     Build QEMU Guest Agent'
@@ -330,6 +331,8 @@ _meson_option_parse() {
     --disable-glusterfs) printf "%s" -Dglusterfs=disabled ;;
     --enable-gnutls) printf "%s" -Dgnutls=enabled ;;
     --disable-gnutls) printf "%s" -Dgnutls=disabled ;;
+    --enable-gstreamer) printf "%s" -Dgstreamer=enabled ;;
+    --disable-gstreamer) printf "%s" -Dgstreamer=disabled ;;
     --enable-gtk) printf "%s" -Dgtk=enabled ;;
     --disable-gtk) printf "%s" -Dgtk=disabled ;;
     --enable-gtk-clipboard) printf "%s" -Dgtk_clipboard=enabled ;;
diff --git a/video/gstreamer-common.h b/video/gstreamer-common.h
new file mode 100644
index 0000000000..c90b223f54
--- /dev/null
+++ b/video/gstreamer-common.h
@@ -0,0 +1,49 @@
+/*
+ * Copyright 2025 9elements GmbH
+ *
+ * Authors:
+ *   David Milosevic <david.milosevic@9elements.com>
+ *   Marcello Sylvester Bauer <marcello.bauer@9elements.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_VIDEO_GSTREAMER_COMMON_H
+#define QEMU_VIDEO_GSTREAMER_COMMON_H
+
+#define TYPE_VIDEODEV_GSTREAMER TYPE_VIDEODEV"-gstreamer"
+
+#include <gst/gst.h>
+#include <gst/app/gstappsink.h>
+
+/*
+ * GStreamer pipeline:
+ *
+ * <------------------- qemu-cmdline -------------------><--- qemu-runtime --->
+ * [source] -> [converter #1] -> ... -> [converter #n] -> capsfilter -> appsink
+ */
+struct GStreamerVideodev {
+
+    Videodev parent;
+
+    GstElement *pipeline; // gstreamer pipeline
+    GstElement *head;     // first element of pipeline (source)
+    GstElement *tail;     // last element of cmdline pipeline
+    GstElement *filter;   // dynamically generated capsfilter
+    GstElement *sink;     // dynamnically generated appsink
+
+    struct GStreamerVideoFrame {
+        GstSample *sample;
+        GstBuffer *buffer;
+        GstMapInfo map_info;
+    } current_frame;
+};
+typedef struct GStreamerVideodev GStreamerVideodev;
+
+DECLARE_INSTANCE_CHECKER(GStreamerVideodev, GSTREAMER_VIDEODEV, TYPE_VIDEODEV_GSTREAMER)
+
+void video_gstreamer_class_init(ObjectClass *oc, const void *data);
+char *video_gstreamer_qemu_opt_get(QemuOpts *opts, const char *name);
+
+#endif /* QEMU_VIDEO_GSTREAMER_COMMON_H */
diff --git a/video/gstreamer.c b/video/gstreamer.c
new file mode 100644
index 0000000000..25576c5e39
--- /dev/null
+++ b/video/gstreamer.c
@@ -0,0 +1,642 @@
+/*
+ * Copyright 2025 9elements GmbH
+ *
+ * Authors:
+ *   David Milosevic <david.milosevic@9elements.com>
+ *   Marcello Sylvester Bauer <marcello.bauer@9elements.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
+#include "qemu/option.h"
+#include "video/video.h"
+#include "video/gstreamer-common.h"
+
+typedef struct {
+    const char *format;
+    uint32_t fourcc;
+} FormatFourCC;
+
+FormatFourCC formatFourCCMap[] = {
+    {"YUY2", QEMU_VIDEO_PIX_FMT_YUYV},
+};
+
+typedef struct VideoGStreamerCtrl {
+    VideoControlType q;
+    const char *v;
+} VideoGStreamerCtrl;
+
+static VideoGStreamerCtrl video_gstreamer_ctrl_table[] = {
+    {
+        .q = VideoControlTypeBrightness,
+        .v = "brightness"
+    },
+    {
+        .q = VideoControlTypeContrast,
+        .v = "contrast"
+    },
+    {
+        .q = VideoControlTypeHue,
+        .v = "hue"
+    },
+    {
+        .q = VideoControlTypeSaturation,
+        .v = "saturation"
+    }
+};
+
+static const char *video_qemu_control_to_gstreamer(VideoControlType type)
+{
+    for (int i = 0; i < ARRAY_SIZE(video_gstreamer_ctrl_table); i++) {
+
+        if (video_gstreamer_ctrl_table[i].q == type) {
+            return video_gstreamer_ctrl_table[i].v;
+        }
+    }
+
+    return NULL;
+}
+
+static GstElement *video_gstreamer_pipeline_head(GstElement *tail)
+{
+    GstElement *current = tail;
+
+    while (true) {
+
+        GstPad *sink_pad, *peer_pad;
+        GstElement *prev;
+
+        sink_pad = gst_element_get_static_pad(current, "sink");
+        if (!sink_pad) {
+            /* no sink pad - source/head found */
+            break;
+        }
+
+        if (!gst_pad_is_linked(sink_pad)) {
+            /* unlinked sink pad - not a proper source */
+            gst_object_unref(sink_pad);
+            return NULL;
+        }
+
+        peer_pad = gst_pad_get_peer(sink_pad);
+        gst_object_unref(sink_pad);
+        if (!peer_pad) {
+            /* broken pipeline? */
+            return NULL;
+        }
+
+        prev = gst_pad_get_parent_element(peer_pad);
+        gst_object_unref(peer_pad);
+        if (!prev) {
+            /* broken pipeline? */
+            return NULL;
+        }
+
+        current = prev;
+    }
+
+    return current;
+}
+
+char *video_gstreamer_qemu_opt_get(QemuOpts *opts, const char *name)
+{
+    const char *qemu_opt = qemu_opt_get(opts, name);
+
+    /*
+     * QEMU's option parser forbids ',' inside option values,
+     * making it hard to pass full GStreamer pipelines over the cmdline.
+     *
+     * Users replace ',' with '^' as a workaround. This function reverses
+     * that replacement to restore the original pipeline.
+     *
+     * Use it whenever you would expect ',' within your option value.
+     */
+
+    if (qemu_opt == NULL) {
+        return NULL;
+    }
+
+    char *sanitized_opt = g_strdup(qemu_opt);
+    g_strdelimit(sanitized_opt, "^", ',');
+    return sanitized_opt;
+}
+
+static int video_gstreamer_open(Videodev *vd, QemuOpts *opts, Error **errp)
+{
+    GStreamerVideodev *gv = GSTREAMER_VIDEODEV(vd);
+    char *pipeline = video_gstreamer_qemu_opt_get(opts, "pipeline");
+    GstStateChangeReturn ret;
+    GstPad *tail_src_pad;
+    GError *error = NULL;
+
+    if (pipeline == NULL) {
+        vd_error_setg(vd, errp, QERR_MISSING_PARAMETER, "pipeline");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    if (!gst_is_initialized())
+        gst_init(NULL, NULL);
+
+    gv->pipeline = gst_parse_bin_from_description(pipeline, false, &error);
+    g_free(pipeline);
+    if (error) {
+        vd_error_setg(vd, errp, "unable to parse pipeline: %s", error->message);
+        return VIDEODEV_RC_ERROR;
+    }
+
+    tail_src_pad = gst_bin_find_unlinked_pad(GST_BIN(gv->pipeline), GST_PAD_SRC);
+    if (!tail_src_pad) {
+        vd_error_setg(vd, errp, "pipeline has no unlinked src pad");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    gv->tail = gst_pad_get_parent_element(tail_src_pad);
+    gst_object_unref(tail_src_pad);
+    if (!gv->tail) {
+        vd_error_setg(vd, errp, "failed to get pipeline's tail element");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    gv->head = video_gstreamer_pipeline_head(gv->tail);
+    if (!gv->head) {
+        vd_error_setg(vd, errp, "failed to get pipeline's head element");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    gv->filter = gst_element_factory_make("capsfilter", "filter");
+    if (!gv->filter) {
+        vd_error_setg(vd, errp, "failed to create capsfilter");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    gst_bin_add(GST_BIN(gv->pipeline), gv->filter);
+
+    if (!gst_element_link(gv->tail, gv->filter)) {
+        vd_error_setg(vd, errp, "failed to link pipeline to capsfilter");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    gv->sink = gst_element_factory_make("appsink", "sink");
+    if (!gv->sink) {
+        vd_error_setg(vd, errp, "failed to create appsink");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    gst_bin_add(GST_BIN(gv->pipeline), gv->sink);
+
+    if (!gst_element_link(gv->filter, gv->sink)) {
+        vd_error_setg(vd, errp, "failed to link pipeline to appsink");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    ret = gst_element_set_state(gv->pipeline, GST_STATE_READY);
+    if (ret == GST_STATE_CHANGE_FAILURE) {
+
+        vd_error_setg(vd, errp, "failed to set pipeline to READY");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    return VIDEODEV_RC_OK;
+}
+
+static uint32_t gst_format_to_fourcc(const char *format)
+{
+    if (!format) {
+        return 0;
+    }
+
+    for (int i = 0; i < ARRAY_SIZE(formatFourCCMap); i++) {
+
+        if (!strcmp(formatFourCCMap[i].format, format)) {
+            return formatFourCCMap[i].fourcc;
+        }
+    }
+
+    return 0;
+}
+
+static const char *gst_fourcc_to_format(const uint32_t fourcc) {
+
+    for (int i = 0; i < ARRAY_SIZE(formatFourCCMap); i++) {
+
+        if (formatFourCCMap[i].fourcc == fourcc) {
+            return formatFourCCMap[i].format;
+        }
+    }
+
+    return NULL;
+}
+
+static int video_gstreamer_enum_modes(Videodev *vd, Error **errp)
+{
+    GStreamerVideodev *gv = GSTREAMER_VIDEODEV(vd);
+    GstPad *tail_src_pad = NULL;
+    GstCaps *tail_src_caps = NULL;
+    const GstStructure *s;
+    uint32_t pixelformat;
+
+    VideoMode *mode;
+    VideoFramesize *frmsz;
+    VideoFramerate *frmival;
+
+    int i, j;
+    const gchar *name, *format;
+    const GValue *width_val, *height_val, *framerates;
+
+    tail_src_pad = gst_element_get_static_pad(gv->tail, "src");
+    if (!tail_src_pad) {
+        vd_error_setg(vd, errp, "failed to get src pad");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    tail_src_caps = gst_pad_query_caps(tail_src_pad, NULL);
+    if (!tail_src_caps) {
+        vd_error_setg(vd, errp, "failed to get capabilities from src pad");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    for (i = 0; i < gst_caps_get_size(tail_src_caps); i++) {
+        s = gst_caps_get_structure(tail_src_caps, i);
+
+        name = gst_structure_get_name(s);
+        if (strcmp(name, "video/x-raw") != 0)
+            continue;
+
+        format = gst_structure_get_string(s, "format");
+        if (!format)
+            continue;
+
+        pixelformat = gst_format_to_fourcc(format);
+        if (pixelformat == 0)
+            continue;
+
+        if (!gst_structure_has_field(s, "width") ||
+            !gst_structure_has_field(s, "height") ||
+            !gst_structure_has_field(s, "framerate"))
+            continue;
+
+        width_val = gst_structure_get_value(s, "width");
+        height_val = gst_structure_get_value(s, "height");
+        framerates = gst_structure_get_value(s, "framerate");
+
+        if (GST_VALUE_HOLDS_INT_RANGE(width_val) ||
+            GST_VALUE_HOLDS_INT_RANGE(height_val))
+            continue;
+
+        // Collect all width values
+        GArray *widths = g_array_new(FALSE, FALSE, sizeof(int));
+        if (G_VALUE_TYPE(width_val) == G_TYPE_INT) {
+            int w = g_value_get_int(width_val);
+            g_array_append_val(widths, w);
+        } else if (GST_VALUE_HOLDS_LIST(width_val)) {
+            for (j = 0; j < gst_value_list_get_size(width_val); j++) {
+                const GValue *v = gst_value_list_get_value(width_val, j);
+                if (G_VALUE_TYPE(v) == G_TYPE_INT) {
+                    int w = g_value_get_int(v);
+                    g_array_append_val(widths, w);
+                }
+            }
+        } else {
+            g_array_free(widths, TRUE);
+            continue;
+        }
+
+        // Collect all height values
+        GArray *heights = g_array_new(FALSE, FALSE, sizeof(int));
+        if (G_VALUE_TYPE(height_val) == G_TYPE_INT) {
+            int h = g_value_get_int(height_val);
+            g_array_append_val(heights, h);
+        } else if (GST_VALUE_HOLDS_LIST(height_val)) {
+            for (j = 0; j < gst_value_list_get_size(height_val); j++) {
+                const GValue *v = gst_value_list_get_value(height_val, j);
+                if (G_VALUE_TYPE(v) == G_TYPE_INT) {
+                    int h = g_value_get_int(v);
+                    g_array_append_val(heights, h);
+                }
+            }
+        } else {
+            g_array_free(widths, TRUE);
+            g_array_free(heights, TRUE);
+            continue;
+        }
+
+        // Iterate over all width × height combinations
+        for (int wi = 0; wi < widths->len; wi++) {
+            for (int hi = 0; hi < heights->len; hi++) {
+                int w = g_array_index(widths, int, wi);
+                int h = g_array_index(heights, int, hi);
+
+                // Find or create VideoMode for this pixelformat
+                mode = NULL;
+                for (j = 0; j < vd->nmodes; j++) {
+                    if (vd->modes[j].pixelformat == pixelformat) {
+                        mode = &vd->modes[j];
+                        break;
+                    }
+                }
+
+                if (!mode) {
+                    vd->nmodes++;
+                    vd->modes = g_realloc(vd->modes, vd->nmodes * sizeof(VideoMode));
+                    mode = &vd->modes[vd->nmodes - 1];
+                    mode->pixelformat = pixelformat;
+                    mode->framesizes = NULL;
+                    mode->nframesize = 0;
+                }
+
+                // Add new framesize
+                mode->nframesize++;
+                mode->framesizes = g_realloc(mode->framesizes,
+                                             mode->nframesize * sizeof(VideoFramesize));
+                frmsz = &mode->framesizes[mode->nframesize - 1];
+
+                frmsz->width = w;
+                frmsz->height = h;
+                frmsz->framerates = NULL;
+                frmsz->nframerate = 0;
+
+                // Handle framerates (list or single fraction)
+                if (GST_VALUE_HOLDS_LIST(framerates)) {
+                    for (j = 0; j < gst_value_list_get_size(framerates); j++) {
+                        const GValue *fval = gst_value_list_get_value(framerates, j);
+                        if (GST_VALUE_HOLDS_FRACTION(fval)) {
+                            frmsz->nframerate++;
+                            frmsz->framerates = g_realloc(frmsz->framerates,
+                                                          frmsz->nframerate * sizeof(VideoFramerate));
+                            frmival = &frmsz->framerates[frmsz->nframerate - 1];
+
+                            // intentionally swapped
+                            frmival->denominator = gst_value_get_fraction_numerator(fval);
+                            frmival->numerator = gst_value_get_fraction_denominator(fval);
+                        }
+                    }
+                } else if (GST_VALUE_HOLDS_FRACTION(framerates)) {
+                    frmsz->nframerate++;
+                    frmsz->framerates = g_realloc(frmsz->framerates,
+                                                  frmsz->nframerate * sizeof(VideoFramerate));
+                    frmival = &frmsz->framerates[frmsz->nframerate - 1];
+
+                    // intentionally swapped
+                    frmival->denominator = gst_value_get_fraction_numerator(framerates);
+                    frmival->numerator = gst_value_get_fraction_denominator(framerates);
+                }
+            }
+        }
+
+        g_array_free(widths, TRUE);
+        g_array_free(heights, TRUE);
+    }
+
+    if (vd->modes == NULL) {
+        vd_error_setg(vd, errp, "failed to enumerate modes");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    return VIDEODEV_RC_OK;
+}
+
+static int video_gstreamer_set_options(Videodev *vd, Error **errp)
+{
+    GStreamerVideodev *gv = GSTREAMER_VIDEODEV(vd);
+    const char *pixformat;
+    GstCaps *caps;
+
+    if ((pixformat = gst_fourcc_to_format(vd->selected.mode->pixelformat)) == NULL) {
+
+        vd_error_setg(vd, errp, "unsupported pixelformat");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    caps = gst_caps_new_simple(
+        "video/x-raw",
+        "width",     G_TYPE_INT,        vd->selected.frmsz->width,
+        "height",    G_TYPE_INT,        vd->selected.frmsz->height,
+        "format",    G_TYPE_STRING,     pixformat,
+        "framerate", GST_TYPE_FRACTION, vd->selected.frmrt.denominator,
+                                        vd->selected.frmrt.numerator, NULL
+    );
+
+    if (caps == NULL) {
+
+        vd_error_setg(vd, errp, "failed to create new caps");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    g_object_set(gv->filter, "caps", caps, NULL);
+    gst_caps_unref(caps);
+
+    return VIDEODEV_RC_OK;
+}
+
+static int video_gstreamer_stream_on(Videodev *vd, Error **errp)
+{
+    GStreamerVideodev *gv = GSTREAMER_VIDEODEV(vd);
+    GstStateChangeReturn ret;
+
+    if (gv->pipeline == NULL) {
+
+        vd_error_setg(vd, errp, "GStreamer pipeline not initialized!");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    if (video_gstreamer_set_options(vd, errp) != VIDEODEV_RC_OK) {
+        return VIDEODEV_RC_ERROR;
+    }
+
+    ret = gst_element_set_state(gv->pipeline, GST_STATE_PLAYING);
+
+    if (ret == GST_STATE_CHANGE_FAILURE) {
+
+        vd_error_setg(vd, errp, "failed to start GStreamer pipeline!");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    return VIDEODEV_RC_OK;
+}
+
+static int video_gstreamer_stream_off(Videodev *vd, Error **errp)
+{
+    GStreamerVideodev *gv = GSTREAMER_VIDEODEV(vd);
+    GstStateChangeReturn ret;
+
+    if (gv->pipeline == NULL) {
+
+        vd_error_setg(vd, errp, "GStreamer pipeline not initialized!");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    ret = gst_element_set_state(gv->pipeline, GST_STATE_READY);
+
+    if (ret == GST_STATE_CHANGE_FAILURE) {
+
+        vd_error_setg(vd, errp, "failed to stop GStreamer pipeline!");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    return VIDEODEV_RC_OK;
+}
+
+static int video_gstreamer_claim_frame(Videodev *vd, Error **errp)
+{
+    GStreamerVideodev *gv = GSTREAMER_VIDEODEV(vd);
+    GstSample *sample;
+    GstBuffer *buffer;
+
+    if ((sample = gst_app_sink_try_pull_sample(GST_APP_SINK(gv->sink), 0)) == NULL) {
+
+        vd_error_setg(vd, errp, "appsink: underrun");
+        return VIDEODEV_RC_UNDERRUN;
+    }
+
+    if ((buffer = gst_sample_get_buffer(sample)) == NULL) {
+
+        gst_sample_unref(sample);
+        vd_error_setg(vd, errp, "could not retrieve sample buffer");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    if (gst_buffer_map(buffer, &gv->current_frame.map_info, GST_MAP_READ) != TRUE) {
+
+        gst_sample_unref(sample);
+        vd_error_setg(vd, errp, "could not map sample buffer");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    gv->current_frame.sample     = sample;
+    gv->current_frame.buffer     = buffer;
+    vd->current_frame.data       = (uint8_t*) gv->current_frame.map_info.data;
+    vd->current_frame.bytes_left = gv->current_frame.map_info.size;
+
+    return VIDEODEV_RC_OK;
+}
+
+static int video_gstreamer_release_frame(Videodev *vd, Error **errp)
+{
+    GStreamerVideodev *gv = GSTREAMER_VIDEODEV(vd);
+
+    gst_buffer_unmap(gv->current_frame.buffer, &gv->current_frame.map_info);
+    gst_sample_unref(gv->current_frame.sample);
+
+    gv->current_frame.sample     = NULL;
+    gv->current_frame.buffer     = NULL;
+    vd->current_frame.data       = NULL;
+    vd->current_frame.bytes_left = 0;
+
+    return VIDEODEV_RC_OK;
+}
+
+static int video_gstreamer_probe_control(Videodev *vd, VideoGStreamerCtrl *ctrl, VideoControl *c)
+{
+    GStreamerVideodev *gv = GSTREAMER_VIDEODEV(vd);
+    GParamSpec *pspec;
+    GParamSpecInt *ispec;
+
+    /*
+     * Apparently there is no proper way to find out
+     * the real minimum and maximum of a video control.
+     *
+     * There is GParamSpec, but that one only gives us
+     * min and max of the underlying datatype.
+     *
+     * As a workaround, we could dynamically probe accepted
+     * values for a given control using g_object_get/g_object_set,
+     * but that might be an idea for the future.
+     */
+
+    pspec = g_object_class_find_property(G_OBJECT_GET_CLASS(gv->head), ctrl->v);
+
+    if (pspec == NULL) {
+        return VIDEODEV_RC_NOTSUP;
+    }
+
+    ispec = G_PARAM_SPEC_INT(pspec);
+
+    *c = (VideoControl) {
+
+        .type = ctrl->q,
+        .min  = ispec->minimum,
+        .max  = ispec->maximum,
+        .step = 1
+    };
+
+    g_object_get(G_OBJECT(gv->head), ctrl->v, &c->def, NULL);
+    return VIDEODEV_RC_OK;
+}
+
+static int video_gstreamer_enum_controls(Videodev *vd, Error **errp)
+{
+    for (int i = 0; i < ARRAY_SIZE(video_gstreamer_ctrl_table); i++) {
+
+        VideoGStreamerCtrl *ctrl;
+        VideoControl ctrl_buffer;
+
+        ctrl = &video_gstreamer_ctrl_table[i];
+
+        if (video_gstreamer_probe_control(vd, ctrl, &ctrl_buffer) != VIDEODEV_RC_OK) {
+            continue;
+        }
+
+        vd->ncontrols += 1;
+        vd->controls   = g_realloc(vd->controls, vd->ncontrols * sizeof(VideoControl));
+
+        vd->controls[vd->ncontrols - 1] = ctrl_buffer;
+    }
+
+    return VIDEODEV_RC_OK;
+}
+
+static int video_gstreamer_set_control(Videodev *vd, VideoControl *ctrl, Error **errp)
+{
+    GStreamerVideodev *gv = GSTREAMER_VIDEODEV(vd);
+    const char *property;
+    int value;
+
+    if ((property = video_qemu_control_to_gstreamer(ctrl->type)) == NULL) {
+
+        vd_error_setg(vd, errp, "invalid control property!");
+        return VIDEODEV_RC_INVAL;
+    }
+
+    g_object_set(G_OBJECT(gv->head), property, ctrl->cur, NULL);
+    g_object_get(G_OBJECT(gv->head), property, &value, NULL);
+
+    if (value != ctrl->cur) {
+
+        vd_error_setg(vd, errp, "could not apply new setting for '%s'", property);
+        return VIDEODEV_RC_INVAL;
+    }
+
+    return VIDEODEV_RC_OK;
+}
+
+void video_gstreamer_class_init(ObjectClass *oc, const void *data)
+{
+    VideodevClass *vc = VIDEODEV_CLASS(oc);
+
+    vc->open          = video_gstreamer_open;
+    vc->enum_modes    = video_gstreamer_enum_modes;
+    vc->stream_on     = video_gstreamer_stream_on;
+    vc->stream_off    = video_gstreamer_stream_off;
+    vc->claim_frame   = video_gstreamer_claim_frame;
+    vc->release_frame = video_gstreamer_release_frame;
+    vc->enum_controls = video_gstreamer_enum_controls;
+    vc->set_control   = video_gstreamer_set_control;
+}
+
+static const TypeInfo video_gstreamer_type_info = {
+    .name = TYPE_VIDEODEV_GSTREAMER,
+    .parent = TYPE_VIDEODEV,
+    .instance_size = sizeof(GStreamerVideodev),
+    .class_init = video_gstreamer_class_init,
+};
+
+static void register_types(void)
+{
+    type_register_static(&video_gstreamer_type_info);
+}
+
+type_init(register_types);
diff --git a/video/meson.build b/video/meson.build
index 278ebdc389..33da556ea4 100644
--- a/video/meson.build
+++ b/video/meson.build
@@ -9,6 +9,8 @@ files = 2
 
 video_modules = {}
 foreach m : [
+  ['gstreamer', gstreamer, files('gstreamer.c')],
+  ['gstreamer-app', gstreamer_app, files('gstreamer.c')],
   ['v4l2', v4l2, files('v4l2.c')],
 ]
   if m[dep].found()
-- 
2.47.0


