Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D456C83F0F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFAb-0003gu-Ux; Tue, 08 Jul 2025 16:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.milosevic@9elements.com>)
 id 1uZDm0-0003Kd-WA
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:14:43 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <david.milosevic@9elements.com>)
 id 1uZDlq-0006ag-HR
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:14:32 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-553d52cb80dso228308e87.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1752001996; x=1752606796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OxxHFyrXTltEtSu/FSF5krOD2MWtyaLZDuYFwuu/n9A=;
 b=RUYDxrQdM07yz8goVkLwrRzK9dj9p/9V6L3bGd2XMbXgPYkxuxa6PQ3DBmN9dbm2qH
 j0B5Gzq8vJgtk6LEGk93BdKfB2KQxpkJSpgTZuR6WOmVwGVblotssnExGSMfg9ng8jX/
 r0GMBMPVceCOULjFfJd81nP1qkAswB+rnagJgr/jqN5/OeVhzhKoal/LKyjEpJ/ltNQG
 rEJSuB/AfXqNHspaLwsfHxokNeJWsHeqhlqhGOzgJPnmnW/VJw5fHwUlq2XX5Ji9oGR7
 mOBH9MvpHgCcYNyebEdhnbJLFy+O1v9AV8lN4Nss+YiBYYzZ591e+gBGZFnJgv1uoksX
 0hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752001996; x=1752606796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OxxHFyrXTltEtSu/FSF5krOD2MWtyaLZDuYFwuu/n9A=;
 b=NQMph2MdK+eQf6wYMb0P9F4S9z62MIbkysq/OL50+XkGw/tmRlpOcj6NUi4yOjvy1b
 ZUgo0vCbUThndym+M8b6P/g1aJizdsDstnLLrH0itVcA1q7L6g40/q8IVFz7Mzck97wH
 TEwIpqGGMQk209Lap92lfs0xhiQgRNmfK0k6zaMPPB2DMeQgVKvE9Y8mzgyJ0zIghUt5
 Z0qruxwaoDiSMBQ1lwIuHEJzM4lxxcOsiwX5l3WOQUfRqfnBPBFsk3iC86Y71oI9Y/Y2
 MB0yTAlV8t//9S+rUGM67EnKUjaTSgvIFzfVaVnznZpHMryA7nsKgsNfxnPzziGm8CXv
 fzqw==
X-Gm-Message-State: AOJu0Ywladj2uIcf6YfetGQD3B424c3pUR8Y3XZ6FMjT1kv0sMSktRTS
 TIAqG1CkSPE9YRfxIFM/Tr+KviXQZHPtb/arUNUhHY6IC9p6YdsC+2unWeadCng4nvVCO6BE3fZ
 ueYpFv8OuQnSh
X-Gm-Gg: ASbGnctwVpYOw0fQ/YuKSIznBMoamk5vRs4+6KF8bkdq+67V70IA8XuuEG7OzEC5Ztr
 FB2oMI2TjN8vU4nt+c+cg4kroV5jYVSsZso1BH5v1ZC4znGgFcnaZiAHTQtIjse0i+tN0ARnrYZ
 /pJDbU/n2ORjDHYvMx/HgND2E0aUuhlPwSMaMbT2a+3YafZeGOZZoxVsUMDuHDyKZVhLp5apqR7
 qLQ/jEAJJLQtmZzQgms7musYrDLNYtSWpEZNx6mVeG+j2DiaB5q12B09nEtiaW4nCK4Tu96wAO5
 QWkQkvMefV2npOAIyogruMnXVg1RvwVsDgonxOBloXaDSNgN+f3ZnzLmi830xHlILUJs2WiOrC0
 fPUqFOlxd+AEwlK1P9MoBSkAQqO2s/4qFeBXDhHfP0rTit90jZhcxD5fK9QTN3+4=
X-Google-Smtp-Source: AGHT+IFr9Qe5MmXxGgNE/F84d/HE+Mw1+beWaziQOd2Mgqsqr7cld946BJqEc7vE0GPksqTO7+C7DQ==
X-Received: by 2002:a05:6000:4202:b0:3a4:eee4:cdec with SMTP id
 ffacd0b85a97d-3b5ddfb8a45mr2922637f8f.6.1751986714754; 
 Tue, 08 Jul 2025 07:58:34 -0700 (PDT)
Received: from cbox.sec.9e.network
 (p200300f75f10f341000000000000002d.dip0.t-ipconnect.de.
 [2003:f7:5f10:f341::2d]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd3d2749sm25445735e9.25.2025.07.08.07.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 07:58:34 -0700 (PDT)
From: David Milosevic <david.milosevic@9elements.com>
X-Google-Original-From: David Milosevic <David.Milosevic@9elements.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 pizhenwei@bytedance.com, marcello.bauer@9elements.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 David Milosevic <David.Milosevic@9elements.com>
Subject: [PATCH 3/3] video: add libcamera backend extension
Date: Tue,  8 Jul 2025 16:56:50 +0200
Message-ID: <20250708145828.63295-4-David.Milosevic@9elements.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250708145828.63295-1-David.Milosevic@9elements.com>
References: <20250708145828.63295-1-David.Milosevic@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=david.milosevic@9elements.com; helo=mail-lf1-x12b.google.com
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

This patch extends the GStreamer backend by implementing
the libcamera (pseudo) backend.

The Libcamera backend builds on top of GStreamer and uses
libcamerasrc as source element.

Example usage:
  qemu-system-x86_64 \
    -device qemu-xhci \
    -videodev libcamera,id=cam0,\
    camera-name="\\\_SB_.PCI0.XHC_.RHUB.HS07-7:1.0-04f2:b681",\
    caps="video/x-raw^format=YUY2^width=960^height=540^framerate=15/1" \
    -device usb-video,videodev=cam0

Known limitations:
  - libcamersrc does not expose capabilities (supported
    pixelformat, etc.), which makes it impossible to query
    them in runtime, hence we have to select format, width, height
    and framerate via QEMU's cmdline.

Signed-off-by: David Milosevic <David.Milosevic@9elements.com>
---
 video/libcamera.c | 148 ++++++++++++++++++++++++++++++++++++++++++++++
 video/meson.build |   1 +
 2 files changed, 149 insertions(+)
 create mode 100644 video/libcamera.c

diff --git a/video/libcamera.c b/video/libcamera.c
new file mode 100644
index 0000000000..f28914ee20
--- /dev/null
+++ b/video/libcamera.c
@@ -0,0 +1,148 @@
+/*
+ * Copyright 2025 9elements GmbH
+ *
+ * Authors:
+ *   David Milosevic <david.milosevic@9elements.com>
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
+#include <gst/gst.h>
+#include <gst/app/gstappsink.h>
+
+#define TYPE_VIDEODEV_LIBCAMERA TYPE_VIDEODEV"-libcamera"
+
+#define VIDEO_LIBCAMERA_PIPELINE_TEMPLATE \
+    "libcamerasrc name=qemu_src camera-name=\"%s\" ! capsfilter caps=\"%s\" ! videoconvert name=qemu_vc ! capsfilter name=qemu_cf ! appsink name=qemu_sink"
+
+struct LibcameraVideodev {
+
+    GStreamerVideodev parent;
+};
+typedef struct LibcameraVideodev LibcameraVideodev;
+
+DECLARE_INSTANCE_CHECKER(LibcameraVideodev, LIBCAMERA_VIDEODEV, TYPE_VIDEODEV_LIBCAMERA)
+
+static char *video_libcamera_pipeline_string(const char *cam_name, const char *caps)
+{
+    char *pipeline_desc = NULL;
+    size_t pipeline_template_len, pipeline_len;
+
+    pipeline_template_len = strlen(VIDEO_LIBCAMERA_PIPELINE_TEMPLATE) - 4; // minus '%s' (x2)
+    pipeline_len = strlen(cam_name) + strlen(caps) + pipeline_template_len + 1; // plus '\0'
+
+    pipeline_desc = g_malloc(pipeline_len * sizeof(char));
+    if (!pipeline_desc) {
+        return NULL;
+    }
+
+    sprintf(pipeline_desc, VIDEO_LIBCAMERA_PIPELINE_TEMPLATE, cam_name, caps);
+    return pipeline_desc;
+}
+
+static int video_libcamera_open(Videodev *vd, QemuOpts *opts, Error **errp)
+{
+    LibcameraVideodev *lv = LIBCAMERA_VIDEODEV(vd);
+    GStreamerVideodev *gv = &lv->parent;
+    const char *cam_name = qemu_opt_get(opts, "camera-name");
+    char *caps = video_gstreamer_qemu_opt_get(opts, "caps");
+    char *pipeline_desc = NULL;
+    GError *error = NULL;
+    GstStateChangeReturn ret;
+
+    if (cam_name == NULL) {
+        vd_error_setg(vd, errp, QERR_MISSING_PARAMETER, "camera-name");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    if (caps == NULL) {
+        vd_error_setg(vd, errp, QERR_MISSING_PARAMETER, "caps");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    pipeline_desc = video_libcamera_pipeline_string(cam_name, caps);
+    g_free(caps);
+    if (!pipeline_desc) {
+        vd_error_setg(vd, errp, "memory allocation failure");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    if (!gst_is_initialized()) {
+        gst_init(NULL, NULL);
+    }
+
+    gv->pipeline = gst_parse_bin_from_description(pipeline_desc, false, &error);
+    g_free(pipeline_desc);
+    if (error) {
+        vd_error_setg(vd, errp, "unable to parse pipeline: %s", error->message);
+        return VIDEODEV_RC_ERROR;
+    }
+
+    gv->head = gst_bin_get_by_name(GST_BIN(gv->pipeline), "qemu_src");
+    if (unlikely(!gv->head)) {
+        vd_error_setg(vd, errp, "qemu_src not found");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    gv->tail = gst_bin_get_by_name(GST_BIN(gv->pipeline), "qemu_vc");
+    if (unlikely(!gv->tail)) {
+        vd_error_setg(vd, errp, "qemu_vc not found");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    gv->filter = gst_bin_get_by_name(GST_BIN(gv->pipeline), "qemu_cf");
+    if (unlikely(!gv->filter)) {
+        vd_error_setg(vd, errp, "qemu_cf not found");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    gv->sink = gst_bin_get_by_name(GST_BIN(gv->pipeline), "qemu_sink");
+    if (unlikely(!gv->sink)) {
+        vd_error_setg(vd, errp, "qemu_sink not found");
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
+static void video_libcamera_class_init(ObjectClass *oc, const void *data)
+{
+    VideodevClass *vc;
+    video_gstreamer_class_init(oc, data);
+
+    vc = VIDEODEV_CLASS(oc);
+
+    /* override GStreamer class methods */
+    vc->open          = video_libcamera_open;
+    vc->enum_controls = NULL;
+    vc->set_control   = NULL;
+}
+
+static const TypeInfo video_libcamera_type_info = {
+    .name = TYPE_VIDEODEV_LIBCAMERA,
+    .parent = TYPE_VIDEODEV_GSTREAMER,
+    .instance_size = sizeof(LibcameraVideodev),
+    .class_init = video_libcamera_class_init,
+};
+
+static void register_types(void)
+{
+    type_register_static(&video_libcamera_type_info);
+}
+
+type_init(register_types);
diff --git a/video/meson.build b/video/meson.build
index 33da556ea4..50eaf0c76e 100644
--- a/video/meson.build
+++ b/video/meson.build
@@ -11,6 +11,7 @@ video_modules = {}
 foreach m : [
   ['gstreamer', gstreamer, files('gstreamer.c')],
   ['gstreamer-app', gstreamer_app, files('gstreamer.c')],
+  ['libcamera', gstreamer, files('libcamera.c', 'gstreamer.c')],
   ['v4l2', v4l2, files('v4l2.c')],
 ]
   if m[dep].found()
-- 
2.47.0


