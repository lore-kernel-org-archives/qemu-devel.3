Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368C8C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L1x-0005rp-9b; Fri, 25 Apr 2025 11:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L1t-0005ZX-K9
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:53 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L1n-000456-Ey
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:53 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so18057635e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595104; x=1746199904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0UwkXmOEC7pPGa0CzEAEdw9nAYyJsVi2zgERtjpyfxA=;
 b=zXi2ZttF6bUnvPI8F5ts1/t7zwLY2oeoC+ZXxG0rwUNndYfWsI1mBbnwR6OxtNXs+S
 FpxTmvYYldip17FGMzhdBBB3NfVS8Vy7TMDWDstgsF2fRqOp+/jvIkACe8GWt3le7WwP
 Gcz0Q5CvBJ3yseCb9yBNhCKsHiIXzTYV9JDszZ4aCiQqUMSg8EhKTbdmekrI7HkzxcVk
 6tGEMCUcaNUBTFL/ZbRCwLGQUqY/22AKM02wR6uM9WFFDVijdtFqMFkTSMjikOQOE73c
 fQQ4JVZfs564dHSqwGin/Q0edl4iwN71MxyYINz6mU41qzNjjwhlXwvoNhyjXfmAIB25
 9VFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595104; x=1746199904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0UwkXmOEC7pPGa0CzEAEdw9nAYyJsVi2zgERtjpyfxA=;
 b=kQKi64SI+ji39yzF3KU5igwDR6BbpRSleoHtnPNUsxJ7ohdm95yEYxAK6lVCMH45+K
 U+WTjyS8ogeNNpExZMQswb0kLZ+f8DCrr3jGZIVZUwzInNTymosW1znzYqhpY72HzPWL
 IK4mK//NLQULHwGMUK+O/vaZxGzMlgLjDTA7m0ND9iislSi7bk7omSmLeTuqYDi/7UNg
 Air33fGvcqMKp4i7vFeqO7p36x3NoE1pmDZ2M2Q09+MqROyw2UaLI9UsyUn770STx7kA
 ggEKcPygjcHyWxmC1XIw9CrjA/+qOXS7kAqszoBqeEiZo6ru/Q7UlOq7DdqlJeSHVUF5
 nEfA==
X-Gm-Message-State: AOJu0Yzxt1mumTYo575VqHTjtMZdGt60j8A+uTOicLHst3nTSAMS2ZLy
 0tk6zQChmGBbALWNxUqkwZi1orW3+lTOGo2oW+PiI1ND3+yh4SNaXbk4NKSgeZGR7mst4Vk0xRp
 3
X-Gm-Gg: ASbGncuAXRxr6N5hp1gNx4ui5GdmxNRbxjPOnXviWPosl92ub+6S/wgzL2gDvhn4oV2
 rcXs5jC8jlMjt7PILpJf5/W6WpC2ZGufmF6ToagVlyfM5e5N5+tIdY+oWSJQ09TZHjy8F80U2SB
 R5LEA6iiD86Y7xmv6NKio2WTlE+wE0TmFQd2OLhf9fWnU+m/n/+uL8azkU90B95hnKz1RQqREw0
 bRC4fy2OrtWR0wG9KtacyQwkUrJ8ZvpYD07NVc9uWl9aGhRAZkSXw6g5F8tSaqbQwk3oEHZmjCq
 z2AKQyZX3zKPP4MXKFlD3l1oc2ubWfELbZROAWTT9mLtEmYNz7nGjFtHkspki+y0qWtSOW8gWB2
 XVGRQsnJkNjH6hdw=
X-Google-Smtp-Source: AGHT+IED8RJQrmwVPMxSQtNSrkTwaKtbHayXl10LOhqP2JEuL21FscpS+KQx2me9EfF86/KDyZYoGw==
X-Received: by 2002:a05:600c:1c1a:b0:43c:fd72:f028 with SMTP id
 5b1f17b1804b1-440a66aca3fmr22470245e9.29.1745595104194; 
 Fri, 25 Apr 2025 08:31:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a536a1d1sm28571725e9.26.2025.04.25.08.31.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:31:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 36/58] pc-bios: Move device tree files in their own subdir
Date: Fri, 25 Apr 2025 17:28:20 +0200
Message-ID: <20250425152843.69638-37-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

We have several device tree files already and may have more in the
future so add a new dtb subdirectory and move device tree files there
so they are not mixed with ROM binaries.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <57f179bd3904c1f2ca062ca4d4ff9592bb4f4daa.1745402140.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                                |   2 +-
 system/datadir.c                           |   4 +++-
 pc-bios/{ => dtb}/bamboo.dtb               | Bin
 pc-bios/{ => dtb}/bamboo.dts               |   0
 pc-bios/{ => dtb}/canyonlands.dtb          | Bin
 pc-bios/{ => dtb}/canyonlands.dts          |   0
 pc-bios/dtb/meson.build                    |  23 +++++++++++++++++++++
 pc-bios/{ => dtb}/petalogix-ml605.dtb      | Bin
 pc-bios/{ => dtb}/petalogix-ml605.dts      |   0
 pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb | Bin
 pc-bios/{ => dtb}/petalogix-s3adsp1800.dts |   0
 pc-bios/meson.build                        |  23 +--------------------
 qemu.nsi                                   |   2 +-
 13 files changed, 29 insertions(+), 25 deletions(-)
 rename pc-bios/{ => dtb}/bamboo.dtb (100%)
 rename pc-bios/{ => dtb}/bamboo.dts (100%)
 rename pc-bios/{ => dtb}/canyonlands.dtb (100%)
 rename pc-bios/{ => dtb}/canyonlands.dts (100%)
 create mode 100644 pc-bios/dtb/meson.build
 rename pc-bios/{ => dtb}/petalogix-ml605.dtb (100%)
 rename pc-bios/{ => dtb}/petalogix-ml605.dts (100%)
 rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb (100%)
 rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dts (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 661a47db5ac..d82d962f1a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1581,7 +1581,7 @@ F: hw/pci-host/ppc440_pcix.c
 F: hw/display/sm501*
 F: hw/ide/sii3112.c
 F: hw/rtc/m41t80.c
-F: pc-bios/canyonlands.dt[sb]
+F: pc-bios/dtb/canyonlands.dt[sb]
 F: pc-bios/u-boot-sam460ex-20100605.bin
 F: roms/u-boot-sam460ex
 F: docs/system/ppc/amigang.rst
diff --git a/system/datadir.c b/system/datadir.c
index e450b84ce91..f96f8fc2646 100644
--- a/system/datadir.c
+++ b/system/datadir.c
@@ -44,9 +44,11 @@ char *qemu_find_file(QemuFileType type, const char *name)
 
     switch (type) {
     case QEMU_FILE_TYPE_BIOS:
-    case QEMU_FILE_TYPE_DTB:
         subdir = "";
         break;
+    case QEMU_FILE_TYPE_DTB:
+        subdir = "dtb/";
+        break;
     case QEMU_FILE_TYPE_KEYMAP:
         subdir = "keymaps/";
         break;
diff --git a/pc-bios/bamboo.dtb b/pc-bios/dtb/bamboo.dtb
similarity index 100%
rename from pc-bios/bamboo.dtb
rename to pc-bios/dtb/bamboo.dtb
diff --git a/pc-bios/bamboo.dts b/pc-bios/dtb/bamboo.dts
similarity index 100%
rename from pc-bios/bamboo.dts
rename to pc-bios/dtb/bamboo.dts
diff --git a/pc-bios/canyonlands.dtb b/pc-bios/dtb/canyonlands.dtb
similarity index 100%
rename from pc-bios/canyonlands.dtb
rename to pc-bios/dtb/canyonlands.dtb
diff --git a/pc-bios/canyonlands.dts b/pc-bios/dtb/canyonlands.dts
similarity index 100%
rename from pc-bios/canyonlands.dts
rename to pc-bios/dtb/canyonlands.dts
diff --git a/pc-bios/dtb/meson.build b/pc-bios/dtb/meson.build
new file mode 100644
index 00000000000..7a71835bca7
--- /dev/null
+++ b/pc-bios/dtb/meson.build
@@ -0,0 +1,23 @@
+dtbs = [
+  'bamboo.dtb',
+  'canyonlands.dtb',
+  'petalogix-ml605.dtb',
+  'petalogix-s3adsp1800.dtb',
+]
+
+dtc = find_program('dtc', required: false)
+if dtc.found()
+  foreach out : dtbs
+    f = fs.replace_suffix(out, '.dts')
+    custom_target(f,
+        build_by_default: have_system,
+        input: files(f),
+        output: out,
+        install: get_option('install_blobs'),
+        install_dir: qemu_datadir / 'dtb',
+        command: [ dtc, '-q', '-I', 'dts', '-O', 'dtb',
+                        '-o', '@OUTPUT@', '@INPUT0@' ])
+  endforeach
+else
+    install_data(dtbs, install_dir: qemu_datadir / 'dtb')
+endif
diff --git a/pc-bios/petalogix-ml605.dtb b/pc-bios/dtb/petalogix-ml605.dtb
similarity index 100%
rename from pc-bios/petalogix-ml605.dtb
rename to pc-bios/dtb/petalogix-ml605.dtb
diff --git a/pc-bios/petalogix-ml605.dts b/pc-bios/dtb/petalogix-ml605.dts
similarity index 100%
rename from pc-bios/petalogix-ml605.dts
rename to pc-bios/dtb/petalogix-ml605.dts
diff --git a/pc-bios/petalogix-s3adsp1800.dtb b/pc-bios/dtb/petalogix-s3adsp1800.dtb
similarity index 100%
rename from pc-bios/petalogix-s3adsp1800.dtb
rename to pc-bios/dtb/petalogix-s3adsp1800.dtb
diff --git a/pc-bios/petalogix-s3adsp1800.dts b/pc-bios/dtb/petalogix-s3adsp1800.dts
similarity index 100%
rename from pc-bios/petalogix-s3adsp1800.dts
rename to pc-bios/dtb/petalogix-s3adsp1800.dts
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 34d6616c32b..34d8cc4f338 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -86,31 +86,10 @@ blobs = [
   'vof-nvram.bin',
 ]
 
-dtc = find_program('dtc', required: false)
-foreach f : [
-  'bamboo.dts',
-  'canyonlands.dts',
-  'petalogix-s3adsp1800.dts',
-  'petalogix-ml605.dts',
-]
-  out = fs.replace_suffix(f, '.dtb')
-  if dtc.found()
-    custom_target(f,
-        build_by_default: have_system,
-        input: files(f),
-        output: out,
-        install: get_option('install_blobs'),
-        install_dir: qemu_datadir,
-        command: [ dtc, '-q', '-I', 'dts', '-O', 'dtb',
-                        '-o', '@OUTPUT@', '@INPUT0@' ])
-  else
-    blobs += out
-  endif
-endforeach
-
 if get_option('install_blobs')
   install_data(blobs, install_dir: qemu_datadir)
 endif
 
 subdir('descriptors')
+subdir('dtb')
 subdir('keymaps')
diff --git a/qemu.nsi b/qemu.nsi
index b186f223e14..d419986ca06 100644
--- a/qemu.nsi
+++ b/qemu.nsi
@@ -204,7 +204,6 @@ Section "Uninstall"
     Delete "$INSTDIR\*.bmp"
     Delete "$INSTDIR\*.bin"
     Delete "$INSTDIR\*.dll"
-    Delete "$INSTDIR\*.dtb"
     Delete "$INSTDIR\*.fd"
     Delete "$INSTDIR\*.img"
     Delete "$INSTDIR\*.lid"
@@ -215,6 +214,7 @@ Section "Uninstall"
     Delete "$INSTDIR\qemu-io.exe"
     Delete "$INSTDIR\qemu.exe"
     Delete "$INSTDIR\qemu-system-*.exe"
+    RMDir /r "$INSTDIR\dtb"
     RMDir /r "$INSTDIR\doc"
     RMDir /r "$INSTDIR\share"
     ; Remove generated files
-- 
2.47.1


