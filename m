Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4701FC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 13:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEqnl-0002Jk-73; Wed, 05 Jun 2024 09:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEqnk-0002Gh-BV
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 09:35:40 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEqni-0003N1-CQ
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 09:35:40 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57a6fcb823fso3347457a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 06:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717594537; x=1718199337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FwE6PA3YucFEKlF5XYjDfDwwa1ZnwXRI6rnHV+Zj+ic=;
 b=Rgku2IpcdVyIjJprwOElWtYcktspT9Pn616Lssk9wFp1hPVUtWJpgGpJdiwNsv4uA+
 /EYcbeNBzv5oVPAQ/YtKyAGAxSRL3eitqabt0ujMRZ4YYWD1XJNLttIJ4S/D7zPkx+S1
 XL8FLhzOOPdFdJr1VxAQdKFqRwqUOUO/YpzhST0jq1Hxg/7jCPILeaiJaV9FIfAAjiLq
 stp4EofTP8uT58H1++Yw5dx2vaJjv4vax2VKOSxcQCl8qpaxMCXYW8DiueLHR3o8TKiO
 Ywp3PjHXrmmQyWdZeiKCWG927jwFShxD5YOarTzMqBOZ4mYbKAbptAfg85RTeYyXEgl8
 a5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717594537; x=1718199337;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FwE6PA3YucFEKlF5XYjDfDwwa1ZnwXRI6rnHV+Zj+ic=;
 b=QAkf1n/KptSK3Jfus5z4Kw6lKw4I4q7vKndVaH/5mqta9MUIG7VKL9+6ub+2Vh57e1
 ltYZxWCyO/21mKLr/KdmR4qbUZPMrjOUvMje72ibdr8HPcmaevm57u9ixnkQ5Z6Y+eEa
 OPJH9IGavetMv5XxmBfOk+6W7677tULOqKwi/8AuAk2jNfO5D7Gnfnr5vUk83ZXtJbUw
 ee5J3YrVPeeV6SOoxRABriZIeo+hvDTg1YkOUlxxppUpISYrxGmPH8dVXJwsscjtyn/O
 yklCQ6GZYuPJJll5KLqbzgYWNLzHQWaCCGwvbgPU58x2I6/grK8luKar0bwLhUaDnsif
 jBBQ==
X-Gm-Message-State: AOJu0Yz0thOzmRCoptheyfaZbZIByA2WWiSakD6xkxpuLT5IrVV9ODJz
 4cMW7EDv27kYj5cFFtjf42+hB4j1aLO/eUthD172E+RR5dueefVMPpVnjsTNN1M=
X-Google-Smtp-Source: AGHT+IGRYnIQkdeS2elJGqSKHzq8vAImXSCKZZG4iqcEpfc1iakQCXvkbYRxoJHjb4rfwPXphLD+eQ==
X-Received: by 2002:a50:8d4e:0:b0:57a:76c1:b14e with SMTP id
 4fb4d7f45d1cf-57a8b51f11amr1799819a12.0.1717594536672; 
 Wed, 05 Jun 2024 06:35:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a8b21ae1csm1731593a12.62.2024.06.05.06.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 06:35:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 81DF45F7AE;
 Wed,  5 Jun 2024 14:35:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] subprojects: add a wrapper for libvirglrenderer
Date: Wed,  5 Jun 2024 14:35:27 +0100
Message-Id: <20240605133527.529950-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

As the latest features for virtio-gpu need a pretty recent version of
libvirglrenderer. When it is not available on the system we can use a
meson wrapper and provide it when --download is specified in
configure.

We have to take some additional care as currently QEMU will hang
libvirglrenderer fails to exec the render server. As the error isn't
back propagated we make sure we at least test we have a path to an
executable before tweaking the environment.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 meson.build                    |  7 ++++++-
 hw/display/virtio-gpu-virgl.c  | 24 ++++++++++++++++++++++++
 subprojects/virglrenderer.wrap |  6 ++++++
 3 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 subprojects/virglrenderer.wrap

diff --git a/meson.build b/meson.build
index 1d7346b703..e4e270df78 100644
--- a/meson.build
+++ b/meson.build
@@ -1203,7 +1203,8 @@ have_vhost_user_gpu = have_tools and host_os == 'linux' and pixman.found()
 if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
   virgl = dependency('virglrenderer',
                      method: 'pkg-config',
-                     required: get_option('virglrenderer'))
+                     required: get_option('virglrenderer'),
+                     default_options: ['default_library=static', 'render-server=true', 'venus=true'])
 endif
 rutabaga = not_found
 if not get_option('rutabaga_gfx').auto() or have_system or have_vhost_user_gpu
@@ -2314,6 +2315,10 @@ if virgl.version().version_compare('>=1.0.0')
   config_host_data.set('HAVE_VIRGL_RESOURCE_BLOB', 1)
   config_host_data.set('HAVE_VIRGL_VENUS', 1)
 endif
+if virgl.type_name().contains('internal')
+  config_host_data.set('HAVE_BUNDLED_VIRGL_SERVER', 1)
+endif
+
 config_host_data.set('CONFIG_VIRTFS', have_virtfs)
 config_host_data.set('CONFIG_VTE', vte.found())
 config_host_data.set('CONFIG_XKBCOMMON', xkbcommon.found())
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index c9d20a8a60..53d6742e79 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
+#include "qemu/cutils.h"
 #include "trace.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-gpu.h"
@@ -1122,6 +1123,26 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)
     virgl_renderer_reset();
 }
 
+/*
+ * If we fail to spawn the render server things tend to hang so it is
+ * important to do our due diligence before then. If QEMU has bundled
+ * the virgl server we want to ensure we can run it from the build
+ * directory and if installed.
+ *
+ * The principle way we can override the libvirglrenders behaviour is
+ * by setting environment variables.
+ */
+static void virgl_set_render_env(void)
+{
+#ifdef HAVE_BUNDLED_VIRGL_SERVER
+    g_autofree char *file = get_relocated_path(CONFIG_QEMU_HELPERDIR "/virgl_render_server");
+    if (g_file_test(file, G_FILE_TEST_EXISTS | G_FILE_TEST_IS_EXECUTABLE)) {
+        g_setenv("RENDER_SERVER_EXEC_PATH", file, false);
+    }
+#endif
+}
+
+
 int virtio_gpu_virgl_init(VirtIOGPU *g)
 {
     int ret;
@@ -1145,6 +1166,9 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     }
 #endif
 
+    /* Ensure we can find the render server */
+    virgl_set_render_env();
+
     ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
     if (ret != 0) {
         error_report("virgl could not be initialized: %d", ret);
diff --git a/subprojects/virglrenderer.wrap b/subprojects/virglrenderer.wrap
new file mode 100644
index 0000000000..3656a478c4
--- /dev/null
+++ b/subprojects/virglrenderer.wrap
@@ -0,0 +1,6 @@
+[wrap-git]
+url = https://gitlab.freedesktop.org/virgl/virglrenderer.git
+revision = virglrenderer-1.0.1
+
+[provide]
+virglrenderer = libvirglrenderer_dep
-- 
2.39.2


