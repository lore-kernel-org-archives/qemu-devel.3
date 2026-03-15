Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC35AF3026E
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 20:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1ruN-0006Oj-N3; Sun, 15 Mar 2026 16:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w1ru6-0006Ll-M8
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 16:17:41 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w1ru1-0002MY-Ak
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 16:17:35 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 4C820C015F;
 Sun, 15 Mar 2026 23:17:10 +0300 (MSK)
Received: from localhost (unknown [2a02:6bf:8080:b49::1:d])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 9HRQD91AhmI0-RiAdBxZz; Sun, 15 Mar 2026 23:17:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1773605829;
 bh=o31vVvyYMo9/zoUyzVln6L7BlLpfRJY383WWkJGVbu4=;
 h=Cc:Message-Id:References:Date:In-Reply-To:Subject:To:From;
 b=EZGX5f725J08sFXn7037fO/4SJdaE/kzNtH4tVHgUJ7CpLJtusFvRpWybk7M4pdFv
 QSWcfuG6PcDOvpzLoy4ygCxeAR0bgmoOdl8xlqlD6kECjXpZxFhyOfu120ZyMOvVcf
 8TWKJfBP+8zh9iiQqwsgwGzA+fm7Rdi5Xx7fsGU8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Sergei Heifetz <heifetz@yandex-team.com>
Subject: [PATCH v3 11/11] meson.build: ignore audio drivers when configured
 with --disable-audio
Date: Mon, 16 Mar 2026 01:16:46 +0500
Message-Id: <20260315201646.96862-12-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315201646.96862-1-heifetz@yandex-team.com>
References: <20260315201646.96862-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 meson.build | 80 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 35 deletions(-)

diff --git a/meson.build b/meson.build
index d05533488f9..7f71dce3ae5 100644
--- a/meson.build
+++ b/meson.build
@@ -2280,46 +2280,55 @@ endif
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
@@ -4710,7 +4719,8 @@ if enable_modules
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


