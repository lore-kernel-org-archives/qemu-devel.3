Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02820EC112C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 20:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vucVE-0003gs-Ag; Mon, 23 Feb 2026 15:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vucV1-0003GF-Ty
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:25:48 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vucUv-0002R9-Mr
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:25:47 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id E581982FC0;
 Mon, 23 Feb 2026 23:25:36 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:12d::1:2c])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id CPmvPN6Ap8c0-KKDYrATx; 
 Mon, 23 Feb 2026 23:25:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1771878336;
 bh=79h67q6LX1lQ96c0uP4Rm18o9dNvSF7B8/1ghQcCkZY=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=uPtu32VNDHcPg1HQXyFbwffZEB2Nk2D4e7xQtdurF6hN06CiN0uV48Pc8b1ur4xie
 IgduYQ8DfG/WSW/syBV0Y+c9GBIawcWddKt88HcpQ2H4YFBiSOnafwiRWxrHITraCR
 JU2/2norgVhv3Rci8NuhCCvAlSL95+enFsKwH1YE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v2 10/10] meson.build: ignore audio drivers when configured
 with --disable-audio
Date: Tue, 24 Feb 2026 01:25:12 +0500
Message-Id: <20260223202512.1308205-11-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223202512.1308205-1-heifetz@yandex-team.com>
References: <20260223202512.1308205-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

When QEMU is configured with `--disable-audio`, we do not need to add the
audio drivers list to config_host_data. We also do not need to print this
list.

Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
---
 meson.build | 80 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 35 deletions(-)

diff --git a/meson.build b/meson.build
index fdb2578447..ae71a0dd91 100644
--- a/meson.build
+++ b/meson.build
@@ -2272,46 +2272,55 @@ endif
 config_host_data = configuration_data()
 
 config_host_data.set('CONFIG_HAVE_RUST', have_rust)
-audio_drivers_selected = []
-if have_system
-  audio_drivers_available = {
-    'alsa': alsa.found(),
-    'coreaudio': coreaudio.found(),
-    'dsound': dsound.found(),
-    'jack': jack.found(),
-    'oss': oss.found(),
-    'pa': pulse.found(),
-    'pipewire': pipewire.found(),
-    'sdl': sdl.found(),
-    'sndio': sndio.found(),
-  }
-  foreach k, v: audio_drivers_available
-    config_host_data.set('CONFIG_AUDIO_' + k.to_upper(), v)
-  endforeach
+config_host_data.set('CONFIG_AUDIO', have_audio)
+if have_audio
+  audio_drivers_selected = []
+  if have_system
+    audio_drivers_available = {
+      'alsa': alsa.found(),
+      'coreaudio': coreaudio.found(),
+      'dsound': dsound.found(),
+      'jack': jack.found(),
+      'oss': oss.found(),
+      'pa': pulse.found(),
+      'pipewire': pipewire.found(),
+      'sdl': sdl.found(),
+      'sndio': sndio.found(),
+    }
+    foreach k, v: audio_drivers_available
+      config_host_data.set('CONFIG_AUDIO_' + k.to_upper(), v)
+    endforeach
 
-  # Default to native drivers first, OSS second, SDL third
-  audio_drivers_priority = \
-    [ 'pa', 'coreaudio', 'dsound', 'sndio', 'oss' ] + \
-    (host_os == 'linux' ? [] : [ 'sdl' ])
-  audio_drivers_default = []
-  foreach k: audio_drivers_priority
-    if audio_drivers_available[k]
-      audio_drivers_default += k
-    endif
-  endforeach
+    # Default to native drivers first, OSS second, SDL third
+    audio_drivers_priority = \
+      [ 'pa', 'coreaudio', 'dsound', 'sndio', 'oss' ] + \
+      (host_os == 'linux' ? [] : [ 'sdl' ])
+    audio_drivers_default = []
+    foreach k: audio_drivers_priority
+      if audio_drivers_available[k]
+        audio_drivers_default += k
+      endif
+    endforeach
 
+    foreach k: get_option('audio_drv_list')
+      if k == 'default'
+        audio_drivers_selected += audio_drivers_default
+      elif not audio_drivers_available[k]
+        error('Audio driver "@0@" not available.'.format(k))
+      else
+        audio_drivers_selected += k
+      endif
+    endforeach
+  endif
+  config_host_data.set('CONFIG_AUDIO_DRIVERS',
+                      '"' + '", "'.join(audio_drivers_selected) + '", ')
+else
   foreach k: get_option('audio_drv_list')
-    if k == 'default'
-      audio_drivers_selected += audio_drivers_default
-    elif not audio_drivers_available[k]
-      error('Audio driver "@0@" not available.'.format(k))
-    else
-      audio_drivers_selected += k
+    if k != 'default'
+      error('Audio drivers are not supported because audio is disabled.')
     endif
   endforeach
 endif
-config_host_data.set('CONFIG_AUDIO_DRIVERS',
-                     '"' + '", "'.join(audio_drivers_selected) + '", ')
 
 have_host_block_device = (host_os != 'darwin' or
     cc.has_header('IOKit/storage/IOMedia.h'))
@@ -4684,7 +4693,8 @@ if enable_modules
   summary_info += {'alternative module path': get_option('module_upgrades')}
 endif
 summary_info += {'fuzzing support':   get_option('fuzzing')}
-if have_system
+summary_info += {'Audio support':     have_audio}
+if have_audio
   summary_info += {'Audio drivers':     ' '.join(audio_drivers_selected)}
 endif
 summary_info += {'Trace backends':    ','.join(get_option('trace_backends'))}
-- 
2.34.1


