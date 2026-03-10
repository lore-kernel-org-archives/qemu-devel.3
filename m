Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4003EB107C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzQW-0005fz-Qo; Tue, 10 Mar 2026 11:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzQI-0005S2-Nb
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:55:08 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzQF-0006jX-Dv
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:55:05 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-483487335c2so110020085e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 08:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773158102; x=1773762902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8ZSWTRc08ExH1rnCtqpock1Z5jkgGW0xJjAXZvGINU=;
 b=y981/YifxBO2tjJvl/V+bEDgISQJKBhHyo3N7BcRP1obkisxp8gHmlVaz+3Wyki4ND
 M2ye0RVWRaGbmuDCBXmiETDNbNgd0J0q+lHwcwdbLTqm8krj8lyunnubcEqqvz7eaJpW
 Cd7bWp1A9h92JUTZdxv+3rF4TBeoxSQpaotynGvb8Xx+pbVE8Bn7Bw/PQPS3TZr4mwLt
 yEo9N5D2EWM/qpTgkhwHetzjwW+Uw6LxXb8aKO7wjKRPaSqv+ITx53iTPrYRB0Bxk1sN
 OVkry/u8MeiPbQtn34Uur2ElQWT7oUq+j94JRcaipIzGP3mbJImFG1X8yS2oMJeyh+Dy
 PWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773158102; x=1773762902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y8ZSWTRc08ExH1rnCtqpock1Z5jkgGW0xJjAXZvGINU=;
 b=up6oCceBaajdf5G4JsU9O0r2Fw1X8PE2rAyfqfOLIItl3jyJ2wUS+o9SR+BAjHZQ/O
 3EDfdqBATVn8BOJkJWFw1bYptUFJY3mzQIKJdpIfcTYDzK6qBB0ZeCuBxLtkX2ZNHloN
 oStCGoMgxBc0p2BGCu/N450jcjshFEXs6N3od2ejb+Bwwt1l3BdP2yGNhmKGrfJ8N6HM
 fJsdww4qNkCgjjXZURYyGxN29i5ccAesjWbS3u3nmVUSZK5/DB5dMupsuGOxUevTh1RX
 0nTC+lIP/pnvQchKZ9Vnj2QH2Sf0Y/HuA94Sj6EEVMF8waDdfYn8mjkJxXzR8A8yaLFi
 9hgQ==
X-Gm-Message-State: AOJu0Yxjl032uO969ahQ35LAys8uuwvLowhWgpg77BabMSiL7hCOAY23
 O8XdZvd1U2V7zg3UVg6HUCQY4JI0zSDnWcUYgk5blUS7ZTYI3ZXZKIUT2SerlVQXjJFPoO4pce/
 tChMbl90=
X-Gm-Gg: ATEYQzzQKHYN4K5QXvyL95wkH/T0vcfiWzuty28vBi6kF9eEoyCR0PdoQ7DTx8xQtub
 z6637EaAbp3B4p283ROmT5BUwKc9rjYhNC9TZS99ukjdaeM+Fx7uV2ZdUc5NDFtDUYvQCLUybhf
 QAW09XUcxOMqub7FyDUiMWPbOB+5THHiDkPACXyvpaT2xwmtavnZXGq9LYBLVTGDbUYJ3s7yeuo
 sW/woE0ufCaj8xvnNIvVUj3icloQqVcg7iL24oXk6xyKGxGID40gj45GsRuS5FHuYSwB1LYI/xr
 ZxOxPnR3TVNrMdNAgxkh1qUNg1tEVQHr1B0Xi7JRsagyVh8uG2ukEthuYeuxD2NXuJEaUhJQizZ
 TgRYzhRxhh+IW0y55loJAlRe+lBcjS99efCQesA9ihlJuJ0VNv/J4OQmYTY88jpFyEtvMmuJfUF
 itLhJOoTmOpKF69QB6X2HyvN1btMup0s+WYoVprLCT1Y0yZzo9QiySU3Pyzpb3sBluA1QlNUEw
X-Received: by 2002:a05:600c:8209:b0:485:3a93:3aa3 with SMTP id
 5b1f17b1804b1-4853a933e17mr122630325e9.12.1773158101590; 
 Tue, 10 Mar 2026 08:55:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a9e6aesm83973185e9.11.2026.03.10.08.55.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 08:55:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-ppc@nongnu.org
Subject: [PATCH v2 13/13] gdbstub: Generate a single gdbstub-xml.c /
 gdb_static_features[]
Date: Tue, 10 Mar 2026 16:53:29 +0100
Message-ID: <20260310155329.48772-14-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310155329.48772-1-philmd@linaro.org>
References: <20260310155329.48772-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

gdb_static_features[] does not depend on target-specific code.
Instead of generating one file per target, generate a single file
with a single gdb_static_features[] array.

Co-developed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
---
 meson.build                               | 14 --------------
 stubs/gdbstub.c => gdbstub/gdb-xml-stub.c |  0
 gdbstub/meson.build                       | 23 +++++++++++++++++++++++
 stubs/meson.build                         |  2 --
 4 files changed, 23 insertions(+), 16 deletions(-)
 rename stubs/gdbstub.c => gdbstub/gdb-xml-stub.c (100%)

diff --git a/meson.build b/meson.build
index 503cde5ea90..538efb7092d 100644
--- a/meson.build
+++ b/meson.build
@@ -4248,7 +4248,6 @@ if have_rust
 endif
 
 
-feature_to_c = find_program('scripts/feature_to_c.py')
 rust_root_crate = find_program('scripts/rust/rust_root_crate.sh')
 
 if host_os == 'darwin'
@@ -4328,19 +4327,6 @@ foreach target : target_dirs
     endif
   endif
 
-  if 'TARGET_XML_FILES' in config_target
-    gdbstub_xml_files = []
-    foreach gdbstub_xml : config_target['TARGET_XML_FILES'].split()
-      gdbstub_xml_files += 'gdbstub/gdb-xml/' + gdbstub_xml
-    endforeach
-    gdbstub_xml = custom_target(target + '-gdbstub-xml.c',
-                                output: target + '-gdbstub-xml.c',
-                                input: files(gdbstub_xml_files),
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
index 15c666f5752..b61d2e915c1 100644
--- a/gdbstub/meson.build
+++ b/gdbstub/meson.build
@@ -4,6 +4,29 @@
 # types such as hwaddr.
 #
 
+gdbstub_xml_files = []
+foreach target : target_dirs
+  config_target = config_target_mak[target]
+  if 'TARGET_XML_FILES' in config_target
+    foreach gdbstub_xml : config_target['TARGET_XML_FILES'].split()
+      if not gdbstub_xml_files.contains('gdb-xml/' + gdbstub_xml)
+        gdbstub_xml_files += 'gdb-xml/' + gdbstub_xml
+      endif
+    endforeach
+  endif
+endforeach
+if gdbstub_xml_files.length() > 0
+  feature_to_c = find_program('../scripts/feature_to_c.py')
+  gdbstub_xml = custom_target('gdbstub-xml.c',
+                              output: 'gdbstub-xml.c',
+                              input: files(gdbstub_xml_files),
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
index fad796a49da..7189ff63ed5 100644
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
2.53.0


