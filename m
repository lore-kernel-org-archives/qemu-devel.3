Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606FAC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZG5G-00029i-5f; Tue, 08 Jul 2025 17:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uZFEj-0006wF-Fv; Tue, 08 Jul 2025 16:48:23 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uZFEg-000310-RI; Tue, 08 Jul 2025 16:48:20 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-60c6fea6742so10035118a12.1; 
 Tue, 08 Jul 2025 13:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752007696; x=1752612496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fv+8CY+MCTDQ/NbLZtbDnoZ1UE4SMU4iQlFO6R+qUPU=;
 b=kUKj9maoHpme1fubfxIJCHXESFkTS7MKJXz+R77ysFnLUszixL0NcdfwB8pFVCOVPf
 oXaRjpIaay8oMlwuOVQyn753hGa+6KVe8CoubuuUZ4a1wniH589nEFljAgH/exW9q7rb
 SuWdP5m5KLglx6ipI5HlCvN9NqOwvgNp36Qz6TmvVSt7hsGyvsqbBeKRJOunNoQeI6b9
 HJ5ZcfeXI8wNj7TVoRMPdCPORTVC/HSyuUIOIFk2KGXjkNhqGXeDP8U/jtKu30tJJR7z
 hBVE1ZCYWOeg1Y4uUa5EVEZV95zUJQDLgCJ9F8gbOPpjVtvP034Vi6AX7o8p3vhoPGW8
 xfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752007696; x=1752612496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fv+8CY+MCTDQ/NbLZtbDnoZ1UE4SMU4iQlFO6R+qUPU=;
 b=TQFa/cfVkCh6uS2Wl+pSbShpaj0d7DnbuD6LE12qt1WkplmjfpWeKrOSA+qSm7Wg27
 ThWwaj4ESUuCAR1EsVRtqgpS2INQFNtsRC/Et4Jh9vjJBA4YD9/fdiowNUW91/6yc9C3
 YrUg+4mgz1C5rX9I+lmemq1XkPAloVHdngkqnC6iIq2yMn/rj8zI9xu6SwlXlGFY2BIx
 GNerthPrAtrNOjeWZx70Z//8pADE7h/1O/hcF/WQ5TFHTUHCX00znTAjbOhS/xZmGr+G
 VOnhXklGv1UkjcjW/pgHNEZ1Rt0A9uCloCCpUI5XKGfC72Zh8VHJYbKL8kD9MeB+N5tZ
 63dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc5knQ+YL8mqY2WxwXJQgG2icV13xBRwDjzLn9L2pwsfxClk5/8oE1lQ1OU3kr2jNQJ87+306zCA==@nongnu.org,
 AJvYcCXzHuyJ7zC2LyofQCc4FMeVhe0pNj68jlm0QGjkmPF4EF+Wnakz+sT2udD0cL9acjv3FYsZQC5JcPs=@nongnu.org
X-Gm-Message-State: AOJu0YwC63zRsleDOv4b12FGMeKNzOvHNIsHCaoSD/iuLT+r77hqzEG9
 4F6eVR81iaXH2Hnk1JiqMX6iaiKGAf1MThBLAQQGMVsqmlFHLV+CH+FOWoEhLw==
X-Gm-Gg: ASbGnctaXgrqM8nqk7PWg8uhKUG9WgF636xWqsmhs2jnZ73m2AtNvLt0BlXvxY08N86
 M7+ZT90Gbws26UPtWM/PW7TkVGjUWLQmgXRUUc5u1DUisJt83qsbFDMfU0oDEjFU1brFB/bT8/J
 q6idfWg1+3rpkLT+YmWi679D6701VkWiiOXvvfehVco5R8X4kg0RVsHWcVVKuOP+IuB5WDf3oIz
 YcxWVbCVU8jo17tuFHgxtNH0tnhqKzC04CtpalqGdD65DvHSrg0fY0FB2dJ29r/06Lx8OfPmRRv
 ByyHFBI2Nw+AQMTfEN8cAwvPxCGD9CldDw3GKbA7n0FrPa5Uus3hDaK3oNhcRKgv6moGC2qEGR4
 tKYP/enAmsu/hniVk9bux/tXgw0tYnCcthPg88dOx1XkJjwIhVjP1EIwz4Dp5dDIJH01rH3C4KJ
 6E8dcV7g==
X-Google-Smtp-Source: AGHT+IFXbxv/riLDdg+2n1gpUm29OyvURlBBjnl725JQhG3NmLdvwF9b2AxKniifhxiLPCaxcm/IqQ==
X-Received: by 2002:a05:6402:28aa:b0:607:2d3b:4827 with SMTP id
 4fb4d7f45d1cf-610472e6805mr4237257a12.30.1752007695909; 
 Tue, 08 Jul 2025 13:48:15 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-18f0-be00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:18f0:be00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60fca66410bsm7647461a12.1.2025.07.08.13.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 13:48:15 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/3] configure: Ensure existance of dtc when libfdt is used
Date: Tue,  8 Jul 2025 22:48:05 +0200
Message-ID: <20250708204806.1898-3-shentey@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708204806.1898-1-shentey@gmail.com>
References: <20250708204806.1898-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The next patch relies on dtc for boards with a bundled DTB. These boards
depend on libfdt already. Make sure that there is a dtc iff libfdt is used
such that the DTBs can be generated.

Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 meson.build                                   | 16 +++--
 pc-bios/dtb/meson.build                       |  1 -
 subprojects/dtc.wrap                          |  1 +
 .../packagefiles/dtc-meson-override.patch     | 62 +++++++++++++++++++
 4 files changed, 75 insertions(+), 5 deletions(-)
 create mode 100644 subprojects/packagefiles/dtc-meson-override.patch

diff --git a/meson.build b/meson.build
index b5f74aa37a..2963789033 100644
--- a/meson.build
+++ b/meson.build
@@ -2089,13 +2089,15 @@ if numa.found() and not cc.links('''
 endif
 
 fdt = not_found
+dtc = not_found
 fdt_opt = get_option('fdt')
 if fdt_opt == 'enabled' and get_option('wrap_mode') == 'nodownload'
   fdt_opt = 'system'
 endif
 if fdt_opt in ['enabled', 'system'] or (fdt_opt == 'auto' and have_system)
   fdt = cc.find_library('fdt', required: fdt_opt == 'system')
-  if fdt.found() and cc.links('''
+  dtc = find_program('dtc', required: fdt_opt == 'system')
+  if dtc.found() and fdt.found() and cc.links('''
      #include <libfdt.h>
      #include <libfdt_env.h>
      int main(void) { fdt_find_max_phandle(NULL, NULL); return 0; }''',
@@ -2104,16 +2106,22 @@ if fdt_opt in ['enabled', 'system'] or (fdt_opt == 'auto' and have_system)
   elif fdt_opt != 'system'
     fdt_opt = get_option('wrap_mode') == 'nodownload' ? 'disabled' : 'internal'
     fdt = not_found
+    dtc = not_found
   else
-    error('system libfdt is too old (1.5.1 or newer required)')
+    if dtc.found()
+      error('system libfdt is too old (1.5.1 or newer required)')
+    else
+      error('device tree compiler not found')
+    endif
   endif
 endif
 if fdt_opt == 'internal'
   assert(not fdt.found())
   libfdt_proj = subproject('dtc', required: true,
-                           default_options: ['tools=false',  'yaml=disabled',
+                           default_options: ['tools=true',  'yaml=disabled',
                                              'python=disabled', 'default_library=static'])
-  fdt = libfdt_proj.get_variable('libfdt_dep')
+  fdt = dependency('libfdt', required: true)
+  dtc = find_program('dtc', required: true)
 endif
 
 rdma = not_found
diff --git a/pc-bios/dtb/meson.build b/pc-bios/dtb/meson.build
index 993032949f..9fcdbeff14 100644
--- a/pc-bios/dtb/meson.build
+++ b/pc-bios/dtb/meson.build
@@ -5,7 +5,6 @@ dtbs = [
   'petalogix-s3adsp1800.dtb',
 ]
 
-dtc = find_program('dtc', required: false)
 if dtc.found()
   foreach out : dtbs
     f = fs.replace_suffix(out, '.dts')
diff --git a/subprojects/dtc.wrap b/subprojects/dtc.wrap
index d1bc9174e9..347ca61ea6 100644
--- a/subprojects/dtc.wrap
+++ b/subprojects/dtc.wrap
@@ -2,3 +2,4 @@
 url = https://gitlab.com/qemu-project/dtc.git
 revision = b6910bec11614980a21e46fbccc35934b671bd81
 depth = 1
+diff_files = dtc-meson-override.patch
diff --git a/subprojects/packagefiles/dtc-meson-override.patch b/subprojects/packagefiles/dtc-meson-override.patch
new file mode 100644
index 0000000000..9dd8cf85a7
--- /dev/null
+++ b/subprojects/packagefiles/dtc-meson-override.patch
@@ -0,0 +1,62 @@
+diff --git a/libfdt/meson.build b/libfdt/meson.build
+index 0307ffb..6581965 100644
+--- a/libfdt/meson.build
++++ b/libfdt/meson.build
+@@ -30,6 +30,7 @@ libfdt_dep = declare_dependency(
+   include_directories: libfdt_inc,
+   link_with: libfdt,
+ )
++meson.override_dependency('libfdt', libfdt_dep)
+ 
+ install_headers(
+   files(
+diff --git a/meson.build b/meson.build
+index b23ea1b..7def0a6 100644
+--- a/meson.build
++++ b/meson.build
+@@ -54,6 +54,7 @@ version_gen_h = vcs_tag(
+ 
+ subdir('libfdt')
+ 
++dtc_tools = []
+ if get_option('tools')
+   flex = find_program('flex', required: true)
+   bison = find_program('bison', required: true)
+@@ -77,7 +78,7 @@ if get_option('tools')
+   )
+ 
+   if cc.check_header('fnmatch.h')
+-    executable(
++    dtc_tools += executable(
+       'convert-dtsv0',
+       [
+         lgen.process('convert-dtsv0-lexer.l'),
+@@ -88,7 +89,7 @@ if get_option('tools')
+     )
+   endif
+ 
+-  executable(
++  dtc_tools += executable(
+     'dtc',
+     [
+       lgen.process('dtc-lexer.l'),
+@@ -108,7 +109,7 @@ if get_option('tools')
+   )
+ 
+   foreach e: ['fdtdump', 'fdtget', 'fdtput', 'fdtoverlay']
+-    executable(e, files(e + '.c'), dependencies: util_dep, install: true)
++    dtc_tools += executable(e, files(e + '.c'), dependencies: util_dep, install: true)
+   endforeach
+ 
+   install_data(
+@@ -118,6 +119,10 @@ if get_option('tools')
+   )
+ endif
+ 
++foreach e: dtc_tools
++  meson.override_find_program(e.name(), e)
++endforeach
++
+ if not meson.is_cross_build()
+   if py.found() and swig.found()
+     subdir('pylibfdt')
-- 
2.50.0


