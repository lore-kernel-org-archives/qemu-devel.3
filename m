Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219D9C54ED1
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs1N-0001WW-6u; Wed, 21 May 2025 18:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs1J-0001WF-Ga
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:34:42 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs18-00050L-TU
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:34:41 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-30e7bfef27dso4900081a91.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747866866; x=1748471666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDNP3RhUOghSEESTRNcI4qrBUgrMIzNRrDLa5dYfvc0=;
 b=W4otA+ypTiVpkBqMmMfI6ZvzTh68pinlCXVzKbb/CIW5q4FxowtiZ37pTlWUbmL7TN
 LK+Sw3dyjLM8eZMX9hAMt8jiowSEEJgaGoMhgtRd8GGq+3ku3EoGcVMdMJO+YV6ezE4c
 Xt9CCZTnDTcM/U5aOp/2kl5WoUcvIClVjYihWf/2Ho/amzNuIdVCJxZ0WYn26LlZcwSx
 AybFpjEfn7RR+klD/kQO/3gDXVzgn/o9YMK/InggXkdNYRksSDocT6YuijU2fH0zPE0y
 xSsG+tGqgUCwr+GXtQmOiFWARuuOlwp1/Dz7qmroLIuKyUHCu0UHIZF4dn6MLVv4JL5g
 BLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747866866; x=1748471666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LDNP3RhUOghSEESTRNcI4qrBUgrMIzNRrDLa5dYfvc0=;
 b=EZDOVJeicXeFOhyX4LqEvwIJooB5CzgE0semjhkwn8RRpSYAiGbOXdCZA8X9d0w4PM
 Qf810f/rL9a/RJXXRZ8U2afGxGGmGd6X77RZyrqwekfdfmXpILuvRaYfJPSuMkx1xPwB
 jpOPu2EFtVFpxFrnuqlA+DMc71x5OND6j4X7TRvtzh0dfrvLucbFlXNCX1FP7NkXUCqH
 Hmh1cdTQS0m/0D24/7tY1CaNVK/+f3LrKYXwwP+Sg6UJZMXfwcqj/TU4OCdh+N8N1WDP
 h3p7Sdp9PuXxZGnDLT2S+19ZVJv/th/W9fzEB3+iFaBvCiVNrwosK1c0UTXtlUmuMML8
 LT6g==
X-Gm-Message-State: AOJu0Yy5+I7Veh8t9dM09AFg+gg8nXe9aLqO4nCtoVpPXY96yfndM9Ky
 82UQhNYVBGzopw10uTTbfAS4V8aUgDohr+oNGqDLvZBdH6mF8xJCBvuNnA7lLhvzHbeXb5CZLSf
 OJ3BS
X-Gm-Gg: ASbGncuTNpsZHjHdo4JEWoz5gJJiCpvmfUueez0k5AasSND2/GB1c2l6T9pTpgq6eUh
 +EYr7+bHMtO0FSQgKg1i9HLJJClOHPm3URcbCtCH9d4Cjcrl7/qdwc5KrRauMFNGQWlMot+Uaip
 QdgPvkfoAJ9CMEkh7VclKF/sHt/vt2NL8gNJCfZ3Wx32ugIhxDaEO2VEZUekCO92tqWOW6ZWd4R
 7dnPCki/5X4D4ODEhn8w2XdZK9gtxh8i/IHRP5Kd+vTtQYVzrGpv3LYnKRFOq4EHob2RjVnVH1/
 FvjNg1CYM9ceM5mTDdqOs1eDtkEvki1O9F6fWOoUblfgBD66Qbo=
X-Google-Smtp-Source: AGHT+IENkWyZiEavDs+DckIevAsE9eF4W2maKEu0Excq3LQXzB02x2GgnqlvbXLmcKEQPQ8glNdidg==
X-Received: by 2002:a17:90b:5282:b0:2ff:5357:1c7e with SMTP id
 98e67ed59e1d1-30e831b492fmr32994892a91.20.1747866866271; 
 Wed, 21 May 2025 15:34:26 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eaf5a31dsm10165224a12.2.2025.05.21.15.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 15:34:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 5/7] meson: merge lib{system, user}_ss with {system,
 user}_ss
Date: Wed, 21 May 2025 15:34:12 -0700
Message-ID: <20250521223414.248276-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250521223414.248276-1-pierrick.bouvier@linaro.org>
References: <20250521223414.248276-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

Now that target configuration can be applied to lib{system, user}_ss,
there is no reason to keep that separate from the existing {system,
user}_ss.
The only difference is that we'll now compile those files with
-DCOMPILING_SYSTEM_VS_USER, which removes poison for
CONFIG_USER_ONLY and CONFIG_SOFTMMU, without any other side effect.

We extract existing system/user code common common libraries to
lib{system, user}.

To not break existing meson files, we alias libsystem_ss to system_ss
and libuser_ss to user_ss, so we can do the cleanup in next commit.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/meson.build b/meson.build
index 22eb2f04e09..23815c916cb 100644
--- a/meson.build
+++ b/meson.build
@@ -3712,14 +3712,14 @@ io_ss = ss.source_set()
 qmp_ss = ss.source_set()
 qom_ss = ss.source_set()
 system_ss = ss.source_set()
-libsystem_ss = ss.source_set()
+libsystem_ss = system_ss
 specific_fuzz_ss = ss.source_set()
 specific_ss = ss.source_set()
 rust_devices_ss = ss.source_set()
 stub_ss = ss.source_set()
 trace_ss = ss.source_set()
 user_ss = ss.source_set()
-libuser_ss = ss.source_set()
+libuser_ss = user_ss
 util_ss = ss.source_set()
 
 # accel modules
@@ -4098,21 +4098,19 @@ common_ss.add(hwcore)
 system_ss.add(authz, blockdev, chardev, crypto, io, qmp)
 common_ss.add(qom, qemuutil)
 
-common_ss.add_all(when: 'CONFIG_SYSTEM_ONLY', if_true: [system_ss])
-common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)
-
 libuser = static_library('user',
-                         libuser_ss.all_sources() + genh,
+                         user_ss.all_sources() + genh,
                          c_args: ['-DCONFIG_USER_ONLY',
                                   '-DCOMPILING_SYSTEM_VS_USER'],
-                         dependencies: libuser_ss.all_dependencies(),
+                         include_directories: common_user_inc,
+                         dependencies: user_ss.all_dependencies(),
                          build_by_default: false)
 
 libsystem = static_library('system',
-                           libsystem_ss.all_sources() + genh,
+                           system_ss.all_sources() + genh,
                            c_args: ['-DCONFIG_SOFTMMU',
                                     '-DCOMPILING_SYSTEM_VS_USER'],
-                           dependencies: libsystem_ss.all_dependencies(),
+                           dependencies: system_ss.all_dependencies(),
                            build_by_default: false)
 
 # Note that this library is never used directly (only through extract_objects)
@@ -4121,7 +4119,6 @@ libsystem = static_library('system',
 common_all = static_library('common',
                             build_by_default: false,
                             sources: common_ss.all_sources() + genh,
-                            include_directories: common_user_inc,
                             implicit_include_directories: false,
                             dependencies: common_ss.all_dependencies())
 
@@ -4135,10 +4132,20 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
   inc = [common_user_inc + target_inc]
 
   target_common = common_ss.apply(config_target, strict: false)
+  target_system = system_ss.apply(config_target, strict: false)
+  target_user = user_ss.apply(config_target, strict: false)
   common_deps = []
+  system_deps = []
+  user_deps = []
   foreach dep: target_common.dependencies()
     common_deps += dep.partial_dependency(compile_args: true, includes: true)
   endforeach
+  foreach dep: target_system.dependencies()
+    system_deps += dep.partial_dependency(compile_args: true, includes: true)
+  endforeach
+  foreach dep: target_user.dependencies()
+    user_deps += dep.partial_dependency(compile_args: true, includes: true)
+  endforeach
 
   # prevent common code to access cpu compile time definition,
   # but still allow access to cpu.h
@@ -4153,7 +4160,7 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
       sources: src.all_sources() + genh,
       include_directories: inc,
       c_args: target_system_c_args,
-      dependencies: src.all_dependencies() + common_deps)
+      dependencies: src.all_dependencies() + common_deps + system_deps)
     hw_common_arch_libs += {target_base_arch: lib}
   endif
 
@@ -4165,7 +4172,8 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
       sources: src.all_sources() + genh,
       include_directories: inc,
       c_args: target_c_args,
-      dependencies: src.all_dependencies() + common_deps)
+      dependencies: src.all_dependencies() + common_deps +
+                    system_deps + user_deps)
     target_common_arch_libs += {target_base_arch: lib}
   endif
 
@@ -4177,7 +4185,7 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
       sources: src.all_sources() + genh,
       include_directories: inc,
       c_args: target_system_c_args,
-      dependencies: src.all_dependencies() + common_deps)
+      dependencies: src.all_dependencies() + common_deps + system_deps)
     target_common_system_arch_libs += {target_base_arch: lib}
   endif
 endforeach
@@ -4358,12 +4366,12 @@ foreach target : target_dirs
     arch_deps += src.dependencies()
   endif
   if target_type == 'system'
-    src = libsystem_ss.apply(config_target, strict: false)
+    src = system_ss.apply(config_target, strict: false)
     objects += libsystem.extract_objects(src.sources())
     arch_deps += src.dependencies()
   endif
   if target_type == 'user'
-    src = libuser_ss.apply(config_target, strict: false)
+    src = user_ss.apply(config_target, strict: false)
     objects += libuser.extract_objects(src.sources())
     arch_deps += src.dependencies()
   endif
-- 
2.47.2


