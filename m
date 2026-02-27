Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EBDFD5337
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 10:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvuoM-0004Sl-9E; Fri, 27 Feb 2026 05:11:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvuoK-0004Op-G3
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 05:11:04 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvuoI-0007QI-Pm
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 05:11:04 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-480706554beso22176775e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 02:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772187060; x=1772791860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xX2bZXSHTsWKoeoWUaoB4balrTpFbDM9rpvRx2uaGFU=;
 b=gdpTZcCbjgB8WWkgug8SZdBz0AsOFF19RymUxWZh7+Pj22lp+RVQtlst4O1k2eR8bi
 hGLUqPCLvApx4ZZIzvAq0REyUWBgYUJK5D2p54AVADwuhg8sn6pVav5D9saJTbrn0vso
 SyPQvhCbZO/ornzb7YPnIZgVyN/EKphqqjpZNpsSqRLn4Frv/iOes4RUdDrdMkNctDET
 wFloFw0vACNl8xTj0L/4m7Hdb7nTfMLxZ4xM2f6twkdxZGC9BR8rdpIhiJnX9WbfJiea
 oNgt8ju+BTvtKlh2RahLNmvIhIcWW7MPr2/a6ZAvd48/ZLw0t1dpecvqHY3jjoQ2zghU
 Pm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772187060; x=1772791860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xX2bZXSHTsWKoeoWUaoB4balrTpFbDM9rpvRx2uaGFU=;
 b=ccCyS/D0AO+M67igUsAol4iuy8od2BM94W0AX54v8EhT6MmHjsTi96ICXykeSxWbjX
 hoEJpGbXa53it9pjR7Mwghi8fnac3VhGCIQ2DmpSTHXr+gT8q0lQ79pEjeQI2/r849tK
 gB7M8Zrk/rYwUBI10/M9OxljyHVn6GYHqx/1cJY3TW8HSyw/wexVsZhSChPpMx1kXonF
 IAFLRiyyNEPhiAeIZDatoK3/s1DbuIxbQNREeVjnwjt6/jb+MFIw+dn3ALbpxQe72SpF
 D5ZMA4ABLkkYEQJ1YjFT6z2AIl3wPZzTp8jghwo75u1eWW8pcg1I12owfYgLdf0HvjGt
 L9Gg==
X-Gm-Message-State: AOJu0YyGSZ4sDLTaPHuYB3uvXsS7rSssKn4NdFcCTHBDz2inmj3oizRK
 ZzxYmUQNHIH/qTdlGWxMuglHrRui59Pd/gk+bSP9GBOAGYvT1Pu3Te/5Qzvsm9roYRMAe11qTAg
 b1mm9kTU=
X-Gm-Gg: ATEYQzzY31X02JcgTSk0A1E7JDWe6rNCyVDvflGTjT8/bggimdf53Y9eU0+7fduwvJh
 abfJOexGPkvsQOqtqU6rEgkE9c5/uXBZsrvAobbzYc/BeVzy7L75h5dIdmOEytFnvzn+p4Z3bKo
 3cRAVlf2SzAXGAihgdygOXR9d1k2ipb35ybbpuV7x+DOe7PSuvP+FRj10Olnllq9jVRmATBeYAf
 Sn4CjKPfBfQRS8D2uAr8W9wh3D75eWuruXDOIo2lmMKn5nnJuht3+x4R7ktj470Xf0alZaPYlUa
 LvGfM48DLVe2D+1I4PdiDwdO9N5jVOhfOs/NJM/qmbKGAkEycY3ZQGH4eIkzVOfh47vuO1LAWOC
 msucSJRxcJ6qG0K5ZQNhFhFI9/xeURLKyM5Z1JR+Ld+uE+IA3T1bUnEhBLWsgt6MEumsoiEOJi/
 NjatGw3KSIWHBKqYJw69798d3+6o5u5bJAHJ+iMdFtgia3MCTqQpLSnUulwmMO9ddBg++JYwVjX
 Ejlxf3g90M=
X-Received: by 2002:a05:600c:1d1d:b0:483:703e:4ad9 with SMTP id
 5b1f17b1804b1-483c9bbbe2emr31717265e9.19.1772187060545; 
 Fri, 27 Feb 2026 02:11:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b5b6sm5460570f8f.18.2026.02.27.02.10.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Feb 2026 02:10:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 2/2] gdbstub: Generate a single gdbstub-xml.c /
 gdb_static_features[]
Date: Fri, 27 Feb 2026 11:10:39 +0100
Message-ID: <20260227101040.70763-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227101040.70763-1-philmd@linaro.org>
References: <20260227101040.70763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

gdb_static_features[] only contains strings, nothing target-specific.
Instead of generating one file per target, generate a single file
with a single gdb_static_features[] array.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build                               | 10 ----------
 stubs/gdbstub.c => gdbstub/gdb-xml-stub.c |  0
 gdbstub/meson.build                       | 19 +++++++++++++++++++
 stubs/meson.build                         |  2 --
 4 files changed, 19 insertions(+), 12 deletions(-)
 rename stubs/gdbstub.c => gdbstub/gdb-xml-stub.c (100%)

diff --git a/meson.build b/meson.build
index 60415df69a1..875a0bb1999 100644
--- a/meson.build
+++ b/meson.build
@@ -4221,7 +4221,6 @@ if have_rust
 endif
 
 
-feature_to_c = find_program('scripts/feature_to_c.py')
 rust_root_crate = find_program('scripts/rust/rust_root_crate.sh')
 
 if host_os == 'darwin'
@@ -4301,15 +4300,6 @@ foreach target : target_dirs
     endif
   endif
 
-  if 'TARGET_XML_FILES' in config_target
-    gdbstub_xml = custom_target(target + '-gdbstub-xml.c',
-                                output: target + '-gdbstub-xml.c',
-                                input: files(config_target['TARGET_XML_FILES'].split()),
-                                command: [feature_to_c, '@INPUT@'],
-                                capture: true)
-    arch_srcs += gdbstub_xml
-  endif
-
   if target in config_target_info
     arch_srcs += config_target_info[target]
   else
diff --git a/stubs/gdbstub.c b/gdbstub/gdb-xml-stub.c
similarity index 100%
rename from stubs/gdbstub.c
rename to gdbstub/gdb-xml-stub.c
diff --git a/gdbstub/meson.build b/gdbstub/meson.build
index 15c666f5752..06fa4d1b6f0 100644
--- a/gdbstub/meson.build
+++ b/gdbstub/meson.build
@@ -4,6 +4,25 @@
 # types such as hwaddr.
 #
 
+gdbstub_xml = []
+foreach target : target_dirs
+  config_target = config_target_mak[target]
+  if 'TARGET_XML_FILES' in config_target
+    gdbstub_xml += config_target['TARGET_XML_FILES'].split()
+  endif
+endforeach
+if gdbstub_xml.length() > 0
+  feature_to_c = find_program('../scripts/feature_to_c.py')
+  gdbstub_xml = custom_target('gdbstub-xml.c',
+                              output: 'gdbstub-xml.c',
+                              input: files(gdbstub_xml),
+                              command: [feature_to_c, '@INPUT@'],
+                              capture: true)
+else
+  gdbstub_xml = files('gdb-xml-stub.c')
+endif
+common_ss.add(gdbstub_xml)
+
 # We build two versions of gdbstub, one for each mode
 user_ss.add(files(
   'gdbstub.c',
diff --git a/stubs/meson.build b/stubs/meson.build
index 8a07059500d..1e0f6f47377 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -89,8 +89,6 @@ if have_system
 endif
 
 if have_system or have_user
-  stub_ss.add(files('gdbstub.c'))
-
   # Also included in have_system for --disable-tcg builds
   stub_ss.add(files('replay.c'))
 
-- 
2.52.0


