Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E79C3ABAC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRut-00020g-2z; Sun, 04 May 2025 01:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRup-0001yj-Hj
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:27 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRum-0004GW-Tm
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:27 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso3518565b3a.2
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336563; x=1746941363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ACKFwyyWU6WsI3NK/C2B6+xTRZ3tXBLAzhxDpMaoiR4=;
 b=OK8jsZfmQkzmNheRCV0bTcXknadCkyoukw58o2QZjL76CH5o6nE4JyzRvAxapDsQX/
 nJYzYGPXZNMJ65h+d5zOSjGB7dshz3rYOPLsd2ZekfeFUVjJsBbkCIgl2FxbAoBogwN9
 Tc5NK4PFj+wUSVsa4BTaoj2s02h4fw+uxsu8s4lPSYkiOZ+e4JnBKXIm1jcuxvJTeMwQ
 TB7VdXnvmWV4e6WYkRxKbEL5lffl73ckmHlqX93FVpK6ALCH7bbuCHVUcyLqdEEOvvy/
 1aKuMry7rbVyWeLyyS/UxhvvaFaQT0h9SEY64MrJ2MhL5ZmdAOvIh3pSA2W6C7gRLGgr
 xEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336563; x=1746941363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ACKFwyyWU6WsI3NK/C2B6+xTRZ3tXBLAzhxDpMaoiR4=;
 b=dLAk8KKmIbJAdjh1H2zVzTqg7nieK//LAinLKu8kV3jBODub10gv5W2CnpOxptBhAC
 0/CCzbeggjPcDB8FmxQKNaDlAtKvd046n5fGabVnvp40FXoBaGtYbWlJGwijpxpSexbv
 e4qqDkEzQ/IZ6nGa/0asdaPkB5rkrJs5DAsPNP0/cXkFGFdYr4OtE/tkp539Up43fy9j
 VenaEMblTb4irkx6zPV6HnNplglbaFJIDyXlWNpvp6IxyGJ3gNKJDvxxwP2XX35RTJiL
 +UUMiWYCmLvB7hOC3RHmeXUmA5AwiTPwwQwciICakcq73Cz67JZ65yWqOY41IAs9I3kD
 yfKw==
X-Gm-Message-State: AOJu0YysSNGdczhH7oMgSBhLyCrFkPciiOk+KeX1KQaEukBQkO9qXuG5
 ajpOxwo3YbIqVLHrSyw2auAMlnzFwGbEppXW/NrYxIEgseVqJ5CTorOCij4z5aNwHpUPZUBTEcs
 7BVI=
X-Gm-Gg: ASbGnctjp1OonKCqeZDkrmKxNEXLGe+0eytDb3nDjhY9Nl8owGUKj2FRV0mJVMVHDtY
 lAaACjhU1Uxe/5De4A29be+RoCVJNl5C/yni6SRFRDpeXdot3xAHQKzxWM9yODa69VPWHSTP0bq
 RqsT437qssWfU9GOts2bnw90IxpFEA0AaBTLDw+fH4boWMwymkZSKKnbZqYfOxp9qWRtazGrGMX
 iiujdLMwk+PTyrAudZpUTn/c/Sz/wwVQYDtKxcfAmYzYg3eQ022WZejQAWEqEcOi15px2PHEtrr
 QACdk2zlkLBHxGhC+DDeDRZRhCIyw+GzeXFlsnbX
X-Google-Smtp-Source: AGHT+IGjACNX5uAUyFCHGk3bklz89ji8zZKeOyLS4Gcm5HJgZXwpRju3I7foEuYzZHYmB77R6TjtjQ==
X-Received: by 2002:a05:6a00:6ca1:b0:736:5753:12f7 with SMTP id
 d2e1a72fcca58-740589050bdmr13949906b3a.3.1746336563237; 
 Sat, 03 May 2025 22:29:23 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 03/40] meson: add common libs for target and target_system
Date: Sat,  3 May 2025 22:28:37 -0700
Message-ID: <20250504052914.3525365-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

Following what we did for hw/, we need target specific common libraries
for target. We need 2 different libraries:
- code common to a base architecture
- system code common to a base architecture

For user code, it can stay compiled per target for now.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 78 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 17 deletions(-)

diff --git a/meson.build b/meson.build
index 64778edeb2c..6f4129826af 100644
--- a/meson.build
+++ b/meson.build
@@ -3685,6 +3685,8 @@ target_arch = {}
 target_system_arch = {}
 target_user_arch = {}
 hw_common_arch = {}
+target_common_arch = {}
+target_common_system_arch = {}
 
 # NOTE: the trace/ subdirectory needs the qapi_trace_events variable
 # that is filled in by qapi/.
@@ -4088,29 +4090,59 @@ common_all = static_library('common',
 
 # construct common libraries per base architecture
 hw_common_arch_libs = {}
+target_common_arch_libs = {}
+target_common_system_arch_libs = {}
 foreach target : target_dirs
   config_target = config_target_mak[target]
   target_base_arch = config_target['TARGET_BASE_ARCH']
+  target_inc = [include_directories('target' / target_base_arch)]
+  inc = [common_user_inc + target_inc]
 
-  # check if already generated
-  if target_base_arch in hw_common_arch_libs
-    continue
-  endif
+  # prevent common code to access cpu compile time definition,
+  # but still allow access to cpu.h
+  target_c_args = ['-DCPU_DEFS_H']
+  target_system_c_args = target_c_args + ['-DCOMPILING_SYSTEM_VS_USER', '-DCONFIG_SOFTMMU']
 
   if target_base_arch in hw_common_arch
-    target_inc = [include_directories('target' / target_base_arch)]
-    src = hw_common_arch[target_base_arch]
-    lib = static_library(
-      'hw_' + target_base_arch,
-      build_by_default: false,
-      sources: src.all_sources() + genh,
-      include_directories: common_user_inc + target_inc,
-      implicit_include_directories: false,
-      # prevent common code to access cpu compile time
-      # definition, but still allow access to cpu.h
-      c_args: ['-DCPU_DEFS_H', '-DCOMPILING_SYSTEM_VS_USER', '-DCONFIG_SOFTMMU'],
-      dependencies: src.all_dependencies())
-    hw_common_arch_libs += {target_base_arch: lib}
+    if target_base_arch not in hw_common_arch_libs
+      src = hw_common_arch[target_base_arch]
+      lib = static_library(
+        'hw_' + target_base_arch,
+        build_by_default: false,
+        sources: src.all_sources() + genh,
+        include_directories: inc,
+        c_args: target_system_c_args,
+        dependencies: src.all_dependencies())
+      hw_common_arch_libs += {target_base_arch: lib}
+    endif
+  endif
+
+  if target_base_arch in target_common_arch
+    if target_base_arch not in target_common_arch_libs
+      src = target_common_arch[target_base_arch]
+      lib = static_library(
+        'target_' + target_base_arch,
+        build_by_default: false,
+        sources: src.all_sources() + genh,
+        include_directories: inc,
+        c_args: target_c_args,
+        dependencies: src.all_dependencies())
+      target_common_arch_libs += {target_base_arch: lib}
+    endif
+  endif
+
+  if target_base_arch in target_common_system_arch
+    if target_base_arch not in target_common_system_arch_libs
+      src = target_common_system_arch[target_base_arch]
+      lib = static_library(
+        'target_system_' + target_base_arch,
+        build_by_default: false,
+        sources: src.all_sources() + genh,
+        include_directories: inc,
+        c_args: target_system_c_args,
+        dependencies: src.all_dependencies())
+      target_common_system_arch_libs += {target_base_arch: lib}
+    endif
   endif
 endforeach
 
@@ -4283,12 +4315,24 @@ foreach target : target_dirs
   target_common = common_ss.apply(config_target, strict: false)
   objects = [common_all.extract_objects(target_common.sources())]
   arch_deps += target_common.dependencies()
+  if target_base_arch in target_common_arch_libs
+    src = target_common_arch[target_base_arch].apply(config_target, strict: false)
+    lib = target_common_arch_libs[target_base_arch]
+    objects += lib.extract_objects(src.sources())
+    arch_deps += src.dependencies()
+  endif
   if target_type == 'system' and target_base_arch in hw_common_arch_libs
     src = hw_common_arch[target_base_arch].apply(config_target, strict: false)
     lib = hw_common_arch_libs[target_base_arch]
     objects += lib.extract_objects(src.sources())
     arch_deps += src.dependencies()
   endif
+  if target_type == 'system' and target_base_arch in target_common_system_arch_libs
+    src = target_common_system_arch[target_base_arch].apply(config_target, strict: false)
+    lib = target_common_system_arch_libs[target_base_arch]
+    objects += lib.extract_objects(src.sources())
+    arch_deps += src.dependencies()
+  endif
 
   target_specific = specific_ss.apply(config_target, strict: false)
   arch_srcs += target_specific.sources()
-- 
2.47.2


