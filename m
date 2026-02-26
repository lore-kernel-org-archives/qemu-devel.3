Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577ACFD9E1E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 23:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvkKc-0000tc-Uy; Thu, 26 Feb 2026 17:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvkKb-0000tL-KI
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:59:41 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvkKZ-0003sA-TZ
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:59:41 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43988056dc3so1407245f8f.3
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 14:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772146778; x=1772751578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IHZXkaVgViOohCapk16z4GZOnLF3Wy2PgK3udt46ano=;
 b=OjsCmkSv/oH/tjTyiUrzJ/f2w4HiDeHocwYs8gJVMyHjHvuexDXnYx+bmmw3UYWDIV
 rJ80xGFZfobZE/yIpUuundFeciyjZoO7WTbalRhjAUTx1g3t/kxhk1Y9mh9ROBU8VWjP
 UuuhipRA3cfPvlQK+nCJ9ZNG4ECb5wCrv9OgOPyHkWHP4nJolczN3jByq1aaZPvvBMik
 jUcgoLljGB5RrxPrnfTeTqlJJR4gatQdvzVrmcZ1h2zUcbk8KwTYcCwpa9Yr4U9vjSqI
 lM0cu78CV3hwTSBDujElJsdjk7qp/SfeVZiw8BAM6rjdFHy4nN0lfqmpHP45bODvY3cl
 GTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772146778; x=1772751578;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IHZXkaVgViOohCapk16z4GZOnLF3Wy2PgK3udt46ano=;
 b=p10sr44BrGxNqjV7hBtdrPCf7i9cwHdEZSQBtorAOAEBjTmidpSWC8XP+X/kNhCY+L
 TBN4qewHi9hsl+liLa+kLEo7OnvR7aSPtho2q5F7jOjMqdbdcZbPZoRytb5nJC/JFMJ3
 jEPNrwP9i65TNHozYZXjLk+qB7t++kUUZIaqlPA+Ka8rNssQ1P4LY/nx0yOYwJwmxdHs
 RWHfL9jhzwfPAgdtHfFuNTj2uF81pCjyj1VSLV/uS71pSs/b93Acus/en9Nm14WkhtKD
 KxeSgxKFIaMtrSFnxD3NjPVLuvuV6aT+Vz+OyQvDNBjj7FcIB9tXtu3/MpzkHoMxhQYM
 IMTg==
X-Gm-Message-State: AOJu0YyUjFD3qunnrKiPs4Aq/XWn89wYMtI0k4FQFg6m74jxGR5fnKWD
 moU60wm1Qj3oPbWZLGB2W8Sb8uX3ZCwhZq//HKwgKQPB5mLQ5FgTAZyUs3Ow6qKV2/kmdihdutK
 tU/FsKu8=
X-Gm-Gg: ATEYQzx8D88Pt8YNgy6xxKWb585/XFLx8KOnnpeFNPw0mwo8gSeFYeeF6DjE9zSgM5K
 nfwNF0MTm6bv5Q/CfTdU3XvTEHWUG4iX94O04Bu7DdgqbU0u3+qkmXxVZpIR2HodL86inFbkJc8
 wug2lcNyDSY1J1AtLZWa3rR+/fiXboEpawZ5MpOfDVWfQFXomBXq/UoVdHWYXcLnhE5Zj8bXy1s
 kARIMQwDaW1DRKGHihK5xQWCCuIDBz9TTnyxLYMdUCHSDFsoEIm/WoJipGlxZMldJnQ7m7vtq1K
 vmOAnBlf6CjHePAu1MjhRGP5UQ0Ne3nFa+jjUeclO63+FL3qEq9v6AzmNKcWVzVbkw4bvH5Re1w
 Zgrset5Iv5jsfiSsqBRzQA+WUKKVNn+9V1Aediif+FxxXspNqxWDNDt81csUm8Xe+C24d0eteu7
 T33O5ZszKeCnnrixjQ9n6ob20okaIUdFNPpIjEi3Oxs+jbSX4wo2OXADDnrPOV+b4HePqoaXlTn
 eLhqB6Tuig=
X-Received: by 2002:a05:6000:250a:b0:439:5e4d:baa3 with SMTP id
 ffacd0b85a97d-4399de0b8b5mr925970f8f.11.1772146777800; 
 Thu, 26 Feb 2026 14:59:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c6100b8sm2856955f8f.2.2026.02.26.14.59.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Feb 2026 14:59:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] gdbstub: Generate a single gdbstub-xml.c /
 gdb_static_features[]
Date: Thu, 26 Feb 2026 23:59:36 +0100
Message-ID: <20260226225936.50725-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
with a single gdb_static_features[] array. Remove the stub.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v2: Check array length
---
 meson.build       | 27 +++++++++++++++++----------
 stubs/gdbstub.c   |  6 ------
 stubs/meson.build |  2 --
 3 files changed, 17 insertions(+), 18 deletions(-)
 delete mode 100644 stubs/gdbstub.c

diff --git a/meson.build b/meson.build
index 451cb28149f..5d7abc5db8b 100644
--- a/meson.build
+++ b/meson.build
@@ -3867,6 +3867,23 @@ subdir('linux-user')
 subdir('tests/qtest/libqos')
 subdir('tests/qtest/fuzz')
 
+feature_to_c = find_program('scripts/feature_to_c.py')
+gdbstub_xml = []
+foreach target : target_dirs
+  config_target = config_target_mak[target]
+  if 'TARGET_XML_FILES' in config_target
+    gdbstub_xml += config_target['TARGET_XML_FILES'].split()
+  endif
+endforeach
+if gdbstub_xml.length() > 0
+  gdbstub_xml = custom_target('gdbstub-xml.c',
+                              output: 'gdbstub-xml.c',
+                              input: files(gdbstub_xml),
+                              command: [feature_to_c, '@INPUT@'],
+                              capture: true)
+  common_ss.add(gdbstub_xml)
+endif
+
 ##############################################
 # Internal static_libraries and dependencies #
 ##############################################
@@ -4218,7 +4235,6 @@ if have_rust
 endif
 
 
-feature_to_c = find_program('scripts/feature_to_c.py')
 rust_root_crate = find_program('scripts/rust/rust_root_crate.sh')
 
 if host_os == 'darwin'
@@ -4298,15 +4314,6 @@ foreach target : target_dirs
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
diff --git a/stubs/gdbstub.c b/stubs/gdbstub.c
deleted file mode 100644
index 580e20702b2..00000000000
--- a/stubs/gdbstub.c
+++ /dev/null
@@ -1,6 +0,0 @@
-#include "qemu/osdep.h"
-#include "exec/gdbstub.h"       /* gdb_static_features */
-
-const GDBFeature gdb_static_features[] = {
-  { NULL }
-};
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


