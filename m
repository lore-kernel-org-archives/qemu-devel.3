Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E460C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXXD-0002uV-W2; Mon, 12 May 2025 14:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWh-0002EB-VJ
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:20 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWf-0008R4-6H
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:19 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22d95f0dda4so55838925ad.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073114; x=1747677914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6FGLSZTqO/KSoe45Th2y1VHmRd/kN2aH8D38tKOyoXc=;
 b=InRn58Ct73V8ZtvhBfV4+Q/WPe2hW1G9KRTxm4lAznSHPgRQs67noP0hYe5v5znOvF
 +C3xj1cDnAYOzc+ci3A8VeM1MrD+pgGbKjQkyITI32ZvpQUMufGyfWkqok3N9iooP9BL
 L37N9+h5DIpdVZhfzcgtjeNMDeln3Kkg1UvuE9qBpLZIRcpX/crMmXwVZhVX7n6+NLEl
 Tx0+a0mE9fgbvHSY8/jW1jsE8O/b1stZYYBwL1fynwYbo12XKsOlqSNpLByOxxdinP/f
 4YukqXVdc/ZxdWyqwV91b7W06lA3xzaKoLyGxqdWktjaf7ejvMh3bL1fHzrqEG+Uzg2z
 aa9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073114; x=1747677914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6FGLSZTqO/KSoe45Th2y1VHmRd/kN2aH8D38tKOyoXc=;
 b=pX4zNJv6dG/FSuK2+F/+5PxgOR/da181q4o4NqH/ryY/JU7pGAwqBx24AXp9tvvS9G
 iC7qwpU3w9Ij37mbflEMaki4sUzb9+i/vH701DfZ8tOK8akXgXWqdVtug+TiGmg2RNnh
 iPSL6/wdoOioUb9kk5MsqGSSj/HLOZCD9PSjcoIh4hXJakajYprJDynxreNPcLP+e2JU
 9X6H/mKnu90kocZ4zD1XuDWqvQMcFH7zoGQbCMrrWDSazD503rjJHTvmQVSD8nnKruEt
 +UOi7cXzueReoWvL3wC41EmhmfV0H7h8EOiFzWpYdT+j+y3nyuzmpQMiMM7ec/4BVhcq
 raHg==
X-Gm-Message-State: AOJu0YyNwEwafco2Lxvjc96jZyqjZqamDAX1yZgjcuFKj8ciidn5fMDz
 GJBpKA8+Z9UnWL5LShl1V06/6ankzXhL5ZeL5MZPDmlbyBx12txCBcMqHAwqznNdYT/4hpkvQ9I
 O
X-Gm-Gg: ASbGncuO45Ipg+SbP+9Jqj+hLVUwF1m+8m2ByV2EDfmTHLnH52xIsKUO/+hHkxW1iYy
 AKH9n1aK1g08HA+v9fvg3gKjsaGDPzd3Y1grEQOK0Fgj4YolltYyt1+B++zzEwprn/vQxCVx9qS
 aSHUnpAy4NVH4wguLsSvbpE/F4aVnjBqaWe/DysPpu5npKL1Vc6qy+yVqLVWxA0350PksccF24L
 Gwf5ueCkceJQqqb8a0gUjDBY1egHf407UYUBMAXdyVnppL2F0cj70THgEZYR0VqG7ZeW95kpBwN
 crYMyBoiWI8mPgJQqt/0MJloIdm8PUq2Y8Zuz+EGyBUe4yMGViiROljjNorsLA==
X-Google-Smtp-Source: AGHT+IFmXHZOtSdCdLVo7meuSiXO0630xCPLqApSephMacKWL+WSH3IS2ya1Tkuv7qwGub+XyjrxZg==
X-Received: by 2002:a17:903:98c:b0:22f:9f6a:7cf with SMTP id
 d9443c01a7336-22fc91a8c92mr188920805ad.52.1747073114488; 
 Mon, 12 May 2025 11:05:14 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 03/48] meson: add common libs for target and target_system
Date: Mon, 12 May 2025 11:04:17 -0700
Message-ID: <20250512180502.2395029-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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
index bbcba3a84a1..bdcde9746c1 100644
--- a/meson.build
+++ b/meson.build
@@ -3706,6 +3706,8 @@ target_arch = {}
 target_system_arch = {}
 target_user_arch = {}
 hw_common_arch = {}
+target_common_arch = {}
+target_common_system_arch = {}
 
 # NOTE: the trace/ subdirectory needs the qapi_trace_events variable
 # that is filled in by qapi/.
@@ -4111,29 +4113,59 @@ common_all = static_library('common',
 
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
 
@@ -4306,12 +4338,24 @@ foreach target : target_dirs
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


