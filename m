Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FFFC54ED1
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs1B-0001UC-K9; Wed, 21 May 2025 18:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs19-0001Ti-6s
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:34:32 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs13-0004zp-Me
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:34:30 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-73bf5aa95e7so6604068b3a.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747866863; x=1748471663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iFTPMBgBeSb1Nb3otdhugWerdFL6Has6F3uTGj/LNK8=;
 b=LT5ZREmRjiGgW4lhkNVmUUWHG9WY+CcjSnhQgEyT4v1F77JxKjt6sUyfIXHjQA/jvS
 0FE4xBkQo/4rb/kSnkRdL5p9aNVziYoqTEweeQGzCBmhsQmNzshtVJpJoKFsgt5z2o9z
 HcrWWGZLkcj75JgI4VbFzVd2CbuKvxv4MngHqa6qMOi6uoGskiTipcB4Y7wU+s/AUQ0N
 2UkyOFgEkjshnndkrXyueBms70Rn9f/QrgOnWObizwZRwq5UJKFA5/ZiyILbusLAO9vB
 2bFdieMP4+yJMgWQg+gNuiCYVRuCjqzP+0lskD4MDrhDQaZN/OP01nGL1tY1xyh39eFW
 WMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747866863; x=1748471663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iFTPMBgBeSb1Nb3otdhugWerdFL6Has6F3uTGj/LNK8=;
 b=L90ox6elqPV9LaIb4c7S5EFO5BjGuDFzoor1xFWWoqYVniUP7zaSlvyvpRek4yssfX
 RabEmZX56kG8po+PtNSVSRIN5jflzJXD4ntpMiH4aYYFULhqqYrluCug6oNrX5DigrjY
 CJLk04bMzsWAfuFt507FdekHmxmPFH1uI1aPHeUCUkQA2XucOlrk8vb9KmzlRxlwMhtz
 Dnf+SGbgk19EYMz+2KjMFemBrebSFIcWttom2xDYO1N4v3oq5cQeH9jJzwytxEZdsXIA
 aZ6CSjWDLDg7SShfc1Xoa2SbRwsEXFM3OkqSQiG5Nc8N1drTRvKcAR8sB9MXj1IHZClg
 bfNQ==
X-Gm-Message-State: AOJu0YxsY4ak5jau2iwlQ0zH7my7kTqjX4pn/ORQZfM4EFsF5wyWrmi3
 lpQyeYu/dT8piq9KLSIqXnZj3LSyxQo6tYBiQg4/2MIc1VLQIftJTW+85okYbnJFvNVAaTNmRPJ
 6MdpD
X-Gm-Gg: ASbGncs+NL1SIhrxzdetimKdJJtPiwb+zx9W+CUoq5mQej4uHl4RTka0A9l1mH62yy8
 JOD6zsPIcOajzCJKAskBO9uYoJldvnrbZf//7mM8FqXAzU+g7stPIHibAqR06MX8ALnvsWUOxyK
 526uRjZrcr6Oo4Q950VPdVKaMNNPs9TrpW5tZGJGQYrEuTRcFEEPwbK8UopaZsBCAj1yfplyHzV
 vkYWGkAE2++hDyfpkMR62sdD+ujSfSGYO9IMv4pv2PhrImuai3AoONRQ+yM6xexOOH3W29e3XxO
 eRJtCh6y215IIdubuwm4wBQifqWG8QZi/6duyrYClbGYNq/tibs=
X-Google-Smtp-Source: AGHT+IFiGuN+jNpOhnPmSQ47Z4Q6SH4T9q4ux8WgqN+/wec40sTmRACeqXs6V8C94yZokdMyGqTL/A==
X-Received: by 2002:a05:6a21:3384:b0:1f5:769a:a4bf with SMTP id
 adf61e73a8af0-21621a23f5fmr37446219637.36.1747866862831; 
 Wed, 21 May 2025 15:34:22 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eaf5a31dsm10165224a12.2.2025.05.21.15.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 15:34:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 1/7] meson: build target libraries with common dependencies
Date: Wed, 21 May 2025 15:34:08 -0700
Message-ID: <20250521223414.248276-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250521223414.248276-1-pierrick.bouvier@linaro.org>
References: <20250521223414.248276-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

As mentioned in [1], dependencies
were missing when compiling per target libraries, thus breaking
compilation on certain host systems.

We now explicitly add common dependencies to those libraries, so it
solves the problem.

[1] https://lore.kernel.org/qemu-devel/20250513115637.184940-1-thuth@redhat.com/

Tested-by: Thomas Huth <thuth@redhat.com>
Fixes: 6f4e8a92bbd ("hw/arm: make most of the compilation units common")
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 75 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 35 deletions(-)

diff --git a/meson.build b/meson.build
index 49c8b0e5f6a..d803ec47221 100644
--- a/meson.build
+++ b/meson.build
@@ -3259,6 +3259,7 @@ config_devices_mak_list = []
 config_devices_h = {}
 config_target_h = {}
 config_target_mak = {}
+config_base_arch_mak = {}
 
 disassemblers = {
   'alpha' : ['CONFIG_ALPHA_DIS'],
@@ -3451,6 +3452,11 @@ foreach target : target_dirs
     config_all_devices += config_devices
   endif
   config_target_mak += {target: config_target}
+
+  # build a merged config for all targets with the same TARGET_BASE_ARCH
+  target_base_arch = config_target['TARGET_BASE_ARCH']
+  config_base_arch = config_base_arch_mak.get(target_base_arch, {}) + config_target
+  config_base_arch_mak += {target_base_arch: config_base_arch}
 endforeach
 target_dirs = actual_target_dirs
 
@@ -4131,57 +4137,56 @@ common_all = static_library('common',
 hw_common_arch_libs = {}
 target_common_arch_libs = {}
 target_common_system_arch_libs = {}
-foreach target : target_dirs
+foreach target_base_arch, config_base_arch : config_base_arch_mak
   config_target = config_target_mak[target]
-  target_base_arch = config_target['TARGET_BASE_ARCH']
   target_inc = [include_directories('target' / target_base_arch)]
   inc = [common_user_inc + target_inc]
 
+  target_common = common_ss.apply(config_target, strict: false)
+  common_deps = []
+  foreach dep: target_common.dependencies()
+    common_deps += dep.partial_dependency(compile_args: true, includes: true)
+  endforeach
+
   # prevent common code to access cpu compile time definition,
   # but still allow access to cpu.h
   target_c_args = ['-DCPU_DEFS_H']
   target_system_c_args = target_c_args + ['-DCOMPILING_SYSTEM_VS_USER', '-DCONFIG_SOFTMMU']
 
   if target_base_arch in hw_common_arch
-    if target_base_arch not in hw_common_arch_libs
-      src = hw_common_arch[target_base_arch]
-      lib = static_library(
-        'hw_' + target_base_arch,
-        build_by_default: false,
-        sources: src.all_sources() + genh,
-        include_directories: inc,
-        c_args: target_system_c_args,
-        dependencies: src.all_dependencies())
-      hw_common_arch_libs += {target_base_arch: lib}
-    endif
+    src = hw_common_arch[target_base_arch]
+    lib = static_library(
+      'hw_' + target_base_arch,
+      build_by_default: false,
+      sources: src.all_sources() + genh,
+      include_directories: inc,
+      c_args: target_system_c_args,
+      dependencies: src.all_dependencies() + common_deps)
+    hw_common_arch_libs += {target_base_arch: lib}
   endif
 
   if target_base_arch in target_common_arch
-    if target_base_arch not in target_common_arch_libs
-      src = target_common_arch[target_base_arch]
-      lib = static_library(
-        'target_' + target_base_arch,
-        build_by_default: false,
-        sources: src.all_sources() + genh,
-        include_directories: inc,
-        c_args: target_c_args,
-        dependencies: src.all_dependencies())
-      target_common_arch_libs += {target_base_arch: lib}
-    endif
+    src = target_common_arch[target_base_arch]
+    lib = static_library(
+      'target_' + target_base_arch,
+      build_by_default: false,
+      sources: src.all_sources() + genh,
+      include_directories: inc,
+      c_args: target_c_args,
+      dependencies: src.all_dependencies() + common_deps)
+    target_common_arch_libs += {target_base_arch: lib}
   endif
 
   if target_base_arch in target_common_system_arch
-    if target_base_arch not in target_common_system_arch_libs
-      src = target_common_system_arch[target_base_arch]
-      lib = static_library(
-        'target_system_' + target_base_arch,
-        build_by_default: false,
-        sources: src.all_sources() + genh,
-        include_directories: inc,
-        c_args: target_system_c_args,
-        dependencies: src.all_dependencies())
-      target_common_system_arch_libs += {target_base_arch: lib}
-    endif
+    src = target_common_system_arch[target_base_arch]
+    lib = static_library(
+      'target_system_' + target_base_arch,
+      build_by_default: false,
+      sources: src.all_sources() + genh,
+      include_directories: inc,
+      c_args: target_system_c_args,
+      dependencies: src.all_dependencies() + common_deps)
+    target_common_system_arch_libs += {target_base_arch: lib}
   endif
 endforeach
 
-- 
2.47.2


