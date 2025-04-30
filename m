Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926F7C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 15:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8tu-0002JR-Ln; Wed, 30 Apr 2025 10:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8tl-0002BK-P6
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:58:58 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8ti-0002eG-Sg
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:58:57 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b12b984e791so7043424a12.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746025133; x=1746629933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8aXdmB6f6CJf71wSR2HMNjOPhUhdvY7cV28foawZJTI=;
 b=SLk68ec1MROp2P66QANGDxnPQam0wPBuLB2wSMgcYQr2sKC6W6E9XkQ4CT+WXx/3ly
 aaqUTeJDeHlA6ReLIljUKPXvW9cqargmkn/MdiiPIrch5DIIROBSvW3u1Kvv+26meXDG
 8P8tm4jA626yodBPFqaO+E8SC8s5Z/JlJIc1BMn8a6E7i+B1jZV7mqIiA6uCdA95KEDa
 ThCk3jzMk4ywv0+ojFOr/gu0xtecuEuluH6lMHCfB7X4ifhtLudDJIrV/Lcypye3p5sL
 ctmtODg2yzXT4SN+WDSuN4hao/bXyh8NAYPPGegAVtQl/83+mmR2HE4tCQvdtWBOnZlm
 kIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746025133; x=1746629933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8aXdmB6f6CJf71wSR2HMNjOPhUhdvY7cV28foawZJTI=;
 b=fK8MhPf/5uOKtya7aY33dtxVt2YNp47SZLZCEao9e7ZF7pKcLY5TcgaybVtbZ/1agC
 irzL0BlIIEbF+5M6nIhop8+a7ce597c/7SBVcuMMXQK1c2W3DsgUX8IJzouXr1AgZiY2
 tsZ2satV5Remph9o0oH757AEzLOLG4hhSiM+LjddLgg3FU+Vhw9lHC0p16r+XvBZxMk1
 A5QRR10ROLJ0bHJxk/HTikQKJFwWqubSUc2/irvBrrTM14sNMjze1krz3dFNmAoCp74I
 i7bJMP+FT2roTINOLCz7jGpBflgiGOpKyUg6evZlTX1OTy+pkEUg5TlJOE4+65n4fyfV
 XNOA==
X-Gm-Message-State: AOJu0YzKdLGX1sTjlKWKZUET559yHnVSVrTu/s2IF+d/LgWTLOgc7lLc
 sGVkt/aqA+r5NjMDewu3AKoPvCtmbuWnIkTdMUmHL9xICrtM2OcZpLz/AEQuRB3eGWlrFDu0aW/
 L
X-Gm-Gg: ASbGnctdW2IeCSCHOcUU5cJVwB8RKLcEHZCOXvizDCrFK/4kjTTlYCCPSJbmtnon/vo
 hWcIw4UwJD5RcbcnXCRVPEJFOG/flfdJ1a2A7rgUO23cJIMqEOQXuTaRIUs77VeVY+wmKMl7iQo
 nIHCWYhd1VKYfDM09iikziC39Nz/ny8L59HmLt3O2uRNxR0LrkJha+M5JyidJTZ5iySPSlSJaF4
 zm8u5xdGISPybJKKol8T6nGkWLinyTBFtmQsTH1WDaKR278sNacqNhnVG8qG+JQmS4Nsr+m9M69
 pTZamfKhqj7VJUfZHu4BSRucZJfe/G9vlDNx0odL
X-Google-Smtp-Source: AGHT+IFpssHgsSSYtikIQu6tj8ir0gDcjk2YukXZRDxWJf/hcTFbtG7nZrI131KGmvNhHjq05d2fDQ==
X-Received: by 2002:a17:90b:5444:b0:2f2:a664:df1a with SMTP id
 98e67ed59e1d1-30a332d60b6mr5368225a91.2.1746025133341; 
 Wed, 30 Apr 2025 07:58:53 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34a5bd78sm1705652a91.42.2025.04.30.07.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:58:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, richard.henderson@linaro.org, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 03/12] meson: add common libs for target and target_system
Date: Wed, 30 Apr 2025 07:58:28 -0700
Message-ID: <20250430145838.1790471-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 78 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 17 deletions(-)

diff --git a/meson.build b/meson.build
index 68d36ac140f..7b2cf3cd7d1 100644
--- a/meson.build
+++ b/meson.build
@@ -3684,6 +3684,8 @@ target_arch = {}
 target_system_arch = {}
 target_user_arch = {}
 hw_common_arch = {}
+target_common_arch = {}
+target_common_system_arch = {}
 
 # NOTE: the trace/ subdirectory needs the qapi_trace_events variable
 # that is filled in by qapi/.
@@ -4087,29 +4089,59 @@ common_all = static_library('common',
 
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
 
@@ -4282,12 +4314,24 @@ foreach target : target_dirs
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


