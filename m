Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15055C4829D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 05:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra7yl-0007I1-3q; Wed, 14 Feb 2024 00:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra7yj-0007Hd-Fj
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 00:38:41 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra7yh-0004ea-DL
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 00:38:41 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-58e256505f7so2656497eaf.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 21:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707889118; x=1708493918;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XHeGaUU001nK+wN64KM5g7LzK1erIkCZ+zHg3K45j2I=;
 b=QwpLyiuyr+1HtuDlZ1HB9m2bGnGliQbSR6RZL6FKWJJDfjYr+KZ4eYskq95wSSrqml
 RJl+4BoAwCx+b8PYBZsX4FVGTTevHjY/3iEmNYIKS2NEkT9O+knppctzbN9QdFi6Lcvr
 82StpVkkvPUXh8hlkOyzf3KxJ/OoIyI1WaXvp/B4PlMg1tctcLfp3tuebS0Z1OTRjWvF
 2eChGBqzclcQcC07p5Fqe3+av4LjbCdAfmoTAi4AmYn+G/QAYenB5bR+0Fmp8nxMC50O
 0Anej2x1V9MthgDYqbqsemTx4S3S+JSPvtgb2AmKaf4RIa8DoJftk5w8/rDCXTbcRgub
 I/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707889118; x=1708493918;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XHeGaUU001nK+wN64KM5g7LzK1erIkCZ+zHg3K45j2I=;
 b=ohNIW6HblBLl1AC4NaEGoHwkRNQjDEL3OCITwwiqb6wxkzIdYvVyt6GBbDxBXjB8Ki
 OAJ0lu1sSWCkjX00gnEe3+DS+b+cno2f0rifYepbokeEGAXY5JZmzp4XRey+RzsvbANX
 hDm/j9ooAihR4ASYkx4W73m68u9s+L64d6UyYp6CutaETtz66nfDP+fjAESvPZoJ3vo+
 il6VZyC74pgrp9dFQLN2yjg7342U9r5gMGF0v33MecgmFSLqF+pDF/rghXYmgBwqxFMS
 vdAk0YJae6dB03YE3/RWlzwkvDE6gcKwc03hzne2vc7joMyAmOFcx6I+aBydt5+H80OQ
 i6ig==
X-Gm-Message-State: AOJu0YzjHUaOipqZTHVnhZK+q3eu+8gYwXYHwNfhc0gPVLsJTclmxXNN
 rYtVBY2id5Q29w+c678FKurv7eXLJ1g/WcOTwbngkvmOHDFIEL019z4c1uMhY+I=
X-Google-Smtp-Source: AGHT+IFM1cq9poa/zELiuPVkbXsGyfUgbx8HSEWP5fkC55Tniu/vhSYt5puKZQMZyI4kUVbdxhTrLQ==
X-Received: by 2002:a05:6358:3f96:b0:179:24b4:41ff with SMTP id
 f22-20020a0563583f9600b0017924b441ffmr1541576rwm.1.1707889118072; 
 Tue, 13 Feb 2024 21:38:38 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVPTixOape5HKX2PpY+0KRua9EYiPuKdIsluJ9gs3AQQ1rAqZgt1Gqa3SjJAWD/3Z78cqg3HeIVpFchCe/L8uf6nNkxg9+eKiUkM7Ckw8dv5x7nU8eeDadOt741ExlMB1jkI8wl+K7B7qU7bnlge+uOFQw5XsptVhy08UoSgNqN7NNpdU1zcv/xQ5bkXvwDtfsvL0OVem9TQyMv9zV5Q4nNlTBLKttXiDtqvQkk7soaJEQ49uMBlBDsfb91B0vB
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 e25-20020aa78c59000000b006e08a4b46b3sm8396552pfd.36.2024.02.13.21.38.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 21:38:37 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 14 Feb 2024 14:38:29 +0900
Subject: [PATCH v6] util: Move dbus_display1 to util
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-dbus-v6-1-411af2b9289e@daynix.com>
X-B4-Tracking: v=1; b=H4sIANRRzGUC/23POw7CMBBF0a0g1xh5xr+Ein0gCn8m4IIExRCBo
 uwdB1EAoXwjnyt5ZJn6RJltVyPraUg5dW0ZZr1i4eTaI/EUy2YoUAKC5tHfMq9MZQ0Fb72oWXl
 66alJ91dmfyj7lPK16x+v6gDz9ScwABdcqpqErl3QHnfRPdp034TuzObCgP8UFgWEZJwTCKAXS
 n4q81ayKK988BSttMotlPpU9q1UUaqJWoHwjVDNQul/ShdVASJViE7W3/+apukJ77CMXHEBAAA
 =
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Move dbus_display1 from ui to util as it's used not only by ui/dbus but
also dbus-display-test.

dbus_display1 is now added to util_ss accordingly. It ensures that the
source will be linked with audio/dbus, and also avoids recompilation
when linking with dbus-display-test.

dbus-display.h is also added to genh to ensure it is generated before
compiling ui/dbus, audio/dbus, and dbus-display-test.

Both changes combined, it is no longer necessary for ui/dbus,
audio/dbus, and dbus-display-test to explicitly state the dependency on
dbus_display1.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
I found it was failing to build dbus modules when --enable-dbus so here
are fixes.
---
Changes in v6:
- Dropped patch "audio: Do not include ui/dbus.h" (Marc-André Lureau).
- Rebased.
- Link to v5: https://lore.kernel.org/r/20231217-dbus-v5-0-8122e822a392@daynix.com

Changes in v5:
- Fixed docs/interop/dbus-display.rst.
- Link to v4: https://lore.kernel.org/r/20231217-dbus-v4-0-4fd5410bf04f@daynix.com

Changes in v4:
- Moved dbus_display1 to util.
- Link to v3: https://lore.kernel.org/r/20231216-dbus-v3-0-b4bcbed7374a@daynix.com

Changes in v3:
- Merged dbus_display1_lib into libqemuutil.
- Added patch "audio: Do not include ui/dbus.h".
- Link to v2: https://lore.kernel.org/r/20231215-dbus-v2-0-1e2e6aa02115@daynix.com

Changes in v2:
- Updated MAINTAINERS.
- Link to v1: https://lore.kernel.org/r/20231215-dbus-v1-0-349e059ac5b2@daynix.com
---
 MAINTAINERS                     |  2 +-
 docs/interop/dbus-display.rst   |  6 +++---
 ui/dbus.h                       |  2 +-
 audio/dbusaudio.c               |  2 +-
 tests/qtest/dbus-display-test.c |  2 +-
 tests/qtest/meson.build         |  2 +-
 ui/meson.build                  | 20 +-------------------
 {ui => util}/dbus-display1.xml  |  0
 util/meson.build                | 21 +++++++++++++++++++++
 9 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f80db6a96a3f..0a81159e33d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3413,7 +3413,7 @@ S: Maintained
 F: backends/dbus-vmstate.c
 F: ui/dbus*
 F: audio/dbus*
-F: util/dbus.c
+F: util/dbus*
 F: include/ui/dbus*
 F: include/qemu/dbus.h
 F: docs/interop/dbus*
diff --git a/docs/interop/dbus-display.rst b/docs/interop/dbus-display.rst
index 8c6e8e0f5a82..efec89723a34 100644
--- a/docs/interop/dbus-display.rst
+++ b/docs/interop/dbus-display.rst
@@ -18,14 +18,14 @@ QEMU also implements the standard interfaces, such as
 
 .. only:: sphinx4
 
-   .. dbus-doc:: ui/dbus-display1.xml
+   .. dbus-doc:: util/dbus-display1.xml
 
 .. only:: not sphinx4
 
    .. warning::
       Sphinx 4 is required to build D-Bus documentation.
 
-      This is the content of ``ui/dbus-display1.xml``:
+      This is the content of ``util/dbus-display1.xml``:
 
-   .. literalinclude:: ../../ui/dbus-display1.xml
+   .. literalinclude:: ../../util/dbus-display1.xml
       :language: xml
diff --git a/ui/dbus.h b/ui/dbus.h
index 1e8c24a48e32..a847bee98876 100644
--- a/ui/dbus.h
+++ b/ui/dbus.h
@@ -31,7 +31,7 @@
 #include "ui/console.h"
 #include "ui/clipboard.h"
 
-#include "ui/dbus-display1.h"
+#include "util/dbus-display1.h"
 
 typedef struct DBusClipboardRequest {
     GDBusMethodInvocation *invocation;
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index 60fcf643ecf8..2aacdac6715b 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -34,7 +34,7 @@
 #endif
 
 #include "ui/dbus.h"
-#include "ui/dbus-display1.h"
+#include "util/dbus-display1.h"
 
 #define AUDIO_CAP "dbus"
 #include "audio.h"
diff --git a/tests/qtest/dbus-display-test.c b/tests/qtest/dbus-display-test.c
index 21edaa1e321f..d4871e2fd80f 100644
--- a/tests/qtest/dbus-display-test.c
+++ b/tests/qtest/dbus-display-test.c
@@ -5,7 +5,7 @@
 #include <gio/gio.h>
 #include <gio/gunixfdlist.h>
 #include "libqtest.h"
-#include "ui/dbus-display1.h"
+#include "util/dbus-display1.h"
 
 static GDBusConnection*
 test_dbus_p2p_from_fd(int fd)
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 39557d5ecbb0..627ff8fbe1c7 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -344,7 +344,7 @@ if vnc.found()
 endif
 
 if dbus_display
-  qtests += {'dbus-display-test': [dbus_display1, gio]}
+  qtests += {'dbus-display-test': [gio]}
 endif
 
 qtest_executables = {}
diff --git a/ui/meson.build b/ui/meson.build
index 376e0d771ba9..74e2a79b8c1e 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -74,25 +74,7 @@ endif
 
 if dbus_display
   dbus_ss = ss.source_set()
-  env = environment()
-  env.set('HOST_OS', host_os)
-  xml = custom_target('dbus-display preprocess',
-                      input: 'dbus-display1.xml',
-                      output: 'dbus-display1.xml',
-                      env: env,
-                      command: [xml_pp, '@INPUT@', '@OUTPUT@'])
-  dbus_display1 = custom_target('dbus-display gdbus-codegen',
-                                output: ['dbus-display1.h', 'dbus-display1.c'],
-                                input: xml,
-                                command: [gdbus_codegen, '@INPUT@',
-                                          '--glib-min-required', '2.64',
-                                          '--output-directory', meson.current_build_dir(),
-                                          '--interface-prefix', 'org.qemu.',
-                                          '--c-namespace', 'QemuDBus',
-                                          '--generate-c-code', '@BASENAME@'])
-  dbus_display1_lib = static_library('dbus-display1', dbus_display1, dependencies: gio)
-  dbus_display1_dep = declare_dependency(link_with: dbus_display1_lib, include_directories: include_directories('.'))
-  dbus_ss.add(when: [gio, dbus_display1_dep],
+  dbus_ss.add(when: [gio],
               if_true: [files(
                 'dbus-chardev.c',
                 'dbus-clipboard.c',
diff --git a/ui/dbus-display1.xml b/util/dbus-display1.xml
similarity index 100%
rename from ui/dbus-display1.xml
rename to util/dbus-display1.xml
diff --git a/util/meson.build b/util/meson.build
index 0ef9886be048..d23c8382fa37 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -128,3 +128,24 @@ elif cpu == 'loongarch64'
 elif cpu in ['ppc', 'ppc64']
   util_ss.add(files('cpuinfo-ppc.c'))
 endif
+
+if dbus_display
+  env = environment()
+  env.set('HOST_OS', host_os)
+  xml = custom_target('dbus-display preprocess',
+                      input: 'dbus-display1.xml',
+                      output: 'dbus-display1.xml',
+                      env: env,
+                      command: [xml_pp, '@INPUT@', '@OUTPUT@'])
+  dbus_display1 = custom_target('dbus-display gdbus-codegen',
+                                output: ['dbus-display1.h', 'dbus-display1.c'],
+                                input: xml,
+                                command: [gdbus_codegen, '@INPUT@',
+                                          '--glib-min-required', '2.64',
+                                          '--output-directory', meson.current_build_dir(),
+                                          '--interface-prefix', 'org.qemu.',
+                                          '--c-namespace', 'QemuDBus',
+                                          '--generate-c-code', '@BASENAME@'])
+  util_ss.add(dbus_display1)
+  genh += dbus_display1[0]
+endif

---
base-commit: 5005aed8a7e728d028efb40e243ecfc2b4f3df3a
change-id: 20231215-dbus-86876ecb7b09

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


