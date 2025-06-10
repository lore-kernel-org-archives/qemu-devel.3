Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7037EC677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 20:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP5n8-00065V-1v; Tue, 10 Jun 2025 16:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uP5n1-0005rV-C1; Tue, 10 Jun 2025 16:41:48 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uP5mz-0003SG-6F; Tue, 10 Jun 2025 16:41:47 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-607ec30df2bso5231669a12.1; 
 Tue, 10 Jun 2025 13:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749588102; x=1750192902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dgmJXjtcgf2rDQe3ZcrY29ofFCyiwKawclslIYHzuxs=;
 b=GDAmFUhUoeMquD/hw0yGU3CfyyP0SNf89tZ96i374FvkeBsekTIFP8Xu5RiapdUi1W
 l2rqFHGE6PWkQUQCc2oySWPLAdkuiRYTzZUGocmTPt7YwCo+OzGZWKltTEnZrBriuKHo
 7yr/gDQ+gllxN6chzq6svWyZmGWuJg43yrwXdoZFKW8lDD9xjb5d3x2NR8ppDZdZ5nn+
 tcwmzBh00ue4l5ubmaP6DxU0XLdvSjWrBfr14T5nxu7XqF2xGBqjms+qNc3zVqdgdkZR
 rXCik2ksIptMJA97ayryk8EhYXV43bLkPUPV8Nq28ogMUAz6zbn+D19DHl3djdGpzlTv
 VmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749588102; x=1750192902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dgmJXjtcgf2rDQe3ZcrY29ofFCyiwKawclslIYHzuxs=;
 b=CqWpVeQ2qF9AnSQGOgHzNBQppdLFlFoIT1HmO7LiBzLaX2wWBhlCQ4OomWkTdauONi
 ylKFkCkfhUk762SjUn2hbeFpChcIUHbhAq2Wkzj9r5JLzl1ZFkkNmVKSlEtNtIgcF7Yd
 kZS834C0NPs95Oye5OxBGSgDY/j+qsmk7vGz5aEp3DBYB5LRSM4QkDh1tVyNtOf4j3ID
 V+Tx6AtDLniIrtUXLxBO+Fu4TRYSgGa5fmrIkZHOjBowec6veu13Lk8mkqohD+66iNc7
 DkZTDLrMshhOJIN66amM7GxclGCmFgkTo/pp+7MsKfpPGoFf+RBiIY3BiaYRYXrw9RUn
 RXpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU43+lE12ZlFhrw40G/UdYAxBBLGhoKdt+XEp6L4026LQwM2vIu67PULVslKB91UlSMMdtSWArTMg==@nongnu.org
X-Gm-Message-State: AOJu0YxFlqt73sucf8cY3mUiAyn5k6tWORc6JpE55BocvZWFwLRqTImT
 neVTLDxNamNQ2j+mCvC+AJwFGxjJ77pafMmeC4vOMgWDD8/5qD1tnh9NhsXqAg==
X-Gm-Gg: ASbGncvaFOUfn+gf4ZNKhHjkoSRxSw+7DHegHRpJHm4BW5cqqLDLR7z8OcKOG1CqIDn
 WrOzaelyb3Ybt9U2Kh1P5mLkTWOx9yKuVIeBI/03CwtTuzj19zxgbvqOY+carRNelDxvQiFglRr
 HQYzzYqi4F+R8dXBJxh0pnjBXAOQ6DZ1/MdFwa5/WcnrYu9B3PxJnSXjGwr5AS2VIR1R0fOrx/p
 fr6Xnj5h4ZXNFTVFZrAKk8+mTKJbOho24XpWm4LpulLHTIx66NnVFXCu18tNwS8i1tSgIIzLwXJ
 68YFV0clYuAfuYzXJ8b4JCAQvKvPSXmZt+FGzfRkXFg+eBHly1EB1AQUsgbQQNjtNO5Z3TwKjlH
 c2PDDDWX3n3WTNBLUEDb/HWkInuILrXSxJQVfvY2FvAlAeXWjOPZx1JYp8HW1rLFHfRvJHnfBNT
 wXfb6a5A==
X-Google-Smtp-Source: AGHT+IEF3v/0hIXq/nGE3i0DdYmDGtRy4dul89pgAbZgejfuucE50ut4FR20zRr0p/+AwWj15CgJug==
X-Received: by 2002:a05:6402:280c:b0:607:f5ce:4c01 with SMTP id
 4fb4d7f45d1cf-60846625a12mr630118a12.3.1749588102245; 
 Tue, 10 Jun 2025 13:41:42 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2cbf-5d00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2cbf:5d00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-607783de2bcsm6521847a12.68.2025.06.10.13.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 13:41:41 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 4/5] configure: Add dtc option
Date: Tue, 10 Jun 2025 22:41:30 +0200
Message-ID: <20250610204131.2862-5-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610204131.2862-1-shentey@gmail.com>
References: <20250610204131.2862-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
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

The next patch will make dtc mandatory for boards with a bundled DTB, causing
these boards to be omitted when dtc is missing. Allow packagers to force the
build of those boards by providing an option.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 meson.build                   | 12 ++++++++++++
 Kconfig.host                  |  3 +++
 meson_options.txt             |  3 +++
 pc-bios/dtb/meson.build       |  1 -
 scripts/meson-buildoptions.sh |  3 +++
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 34729c2a3d..8a03fbaed8 100644
--- a/meson.build
+++ b/meson.build
@@ -2119,6 +2119,15 @@ if fdt_opt == 'internal'
   fdt = libfdt_proj.get_variable('libfdt_dep')
 endif
 
+dtc = not_found
+dtc_opt = get_option('dtc')
+if dtc_opt == 'enabled' or (dtc_opt == 'auto' and have_system)
+  dtc = find_program('dtc', required: dtc_opt == 'enabled')
+  if not dtc.found() and dtc_opt == 'enabled'
+    error('dtc not found')
+  endif
+endif
+
 rdma = not_found
 if not get_option('rdma').auto() or have_system
   rdma_libs = [cc.find_library('rdmacm', has_headers: ['rdma/rdma_cma.h'],
@@ -2477,6 +2486,7 @@ config_host_data.set('CONFIG_FREEBSD', host_os == 'freebsd')
 config_host_data.set('CONFIG_CAPSTONE', capstone.found())
 config_host_data.set('CONFIG_COCOA', cocoa.found())
 config_host_data.set('CONFIG_DARWIN', host_os == 'darwin')
+config_host_data.set('CONFIG_DTC', dtc.found())
 config_host_data.set('CONFIG_FDT', fdt.found())
 config_host_data.set('CONFIG_FUZZ', get_option('fuzzing'))
 config_host_data.set('CONFIG_GCOV', get_option('b_coverage'))
@@ -3314,6 +3324,7 @@ host_kconfig = \
   (libcbor.found() ? ['CONFIG_LIBCBOR=y'] : []) + \
   (gnutls.found() ? ['CONFIG_GNUTLS=y'] : []) + \
   (x11.found() ? ['CONFIG_X11=y'] : []) + \
+  (dtc.found() ? ['CONFIG_DTC=y'] : []) + \
   (fdt.found() ? ['CONFIG_FDT=y'] : []) + \
   (have_vhost_user ? ['CONFIG_VHOST_USER=y'] : []) + \
   (have_vhost_vdpa ? ['CONFIG_VHOST_VDPA=y'] : []) + \
@@ -4703,6 +4714,7 @@ summary_info += {'sphinx-build':      sphinx_build}
 if config_host.has_key('GDB')
   summary_info += {'gdb':             config_host['GDB']}
 endif
+summary_info += {'dtc':               dtc}
 summary_info += {'iasl':              iasl}
 summary_info += {'genisoimage':       config_host['GENISOIMAGE']}
 if host_os == 'windows' and have_ga
diff --git a/Kconfig.host b/Kconfig.host
index 933425c74b..82fc8848dd 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -29,6 +29,9 @@ config IVSHMEM
 config TPM
     bool
 
+config DTC
+    bool
+
 config FDT
     bool
 
diff --git a/meson_options.txt b/meson_options.txt
index a442be2995..d0e56564fb 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -316,6 +316,9 @@ option('vduse_blk_export', type: 'feature', value: 'auto',
 
 option('capstone', type: 'feature', value: 'auto',
        description: 'Whether and how to find the capstone library')
+option('dtc', type: 'combo', value: 'auto',
+       choices: ['disabled', 'enabled', 'auto'],
+       description: 'Whether to find the device tree compiler')
 option('fdt', type: 'combo', value: 'auto',
        choices: ['disabled', 'enabled', 'auto', 'system', 'internal'],
        description: 'Whether and how to find the libfdt library')
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
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 73e0770f42..e8c452ffb0 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -116,6 +116,7 @@ meson_options_help() {
   printf "%s\n" '  dmg             dmg image format support'
   printf "%s\n" '  docs            Documentations build support'
   printf "%s\n" '  dsound          DirectSound sound support'
+  printf "%s\n" '  dtc             Whether to find the device tree compiler'
   printf "%s\n" '  fuse            FUSE block device export'
   printf "%s\n" '  fuse-lseek      SEEK_HOLE/SEEK_DATA support for FUSE exports'
   printf "%s\n" '  gcrypt          libgcrypt cryptography support'
@@ -310,6 +311,8 @@ _meson_option_parse() {
     --disable-docs) printf "%s" -Ddocs=disabled ;;
     --enable-dsound) printf "%s" -Ddsound=enabled ;;
     --disable-dsound) printf "%s" -Ddsound=disabled ;;
+    --enable-dtc) printf "%s" -Ddtc=enabled ;;
+    --disable-dtc) printf "%s" -Ddtc=disabled ;;
     --enable-fdt) printf "%s" -Dfdt=enabled ;;
     --disable-fdt) printf "%s" -Dfdt=disabled ;;
     --enable-fdt=*) quote_sh "-Dfdt=$2" ;;
-- 
2.49.0


