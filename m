Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DEFC3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVn2-0004Qj-RL; Thu, 15 May 2025 06:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVn1-0004QM-3a
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:11 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmy-00089E-Os
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:10 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so8369085e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304767; x=1747909567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+fk+E1hNI4ene4uIKK/hnLRnqA1uMFK4Q9d7SpDJgfs=;
 b=QT/4dH0CRGnOn4Q/ecROuTXpvzynOWf3ZOX2+2VcvU3XVEwbEq3N4wuzHD0FxK33j3
 zIIrI4908idSjkWCmxPzBECyOl9afRuG1/usXFZpTy/kRztyK2BGPg0UKSNHFYppqeu+
 pj+TEez1XcDLuSP4RzrWq1CFjJKMo6PEK1ngXNbBGPV7h8V5Hb6J9uxKsk8zqQk2fGWr
 9uVgeyaeUiX/Vmz6kw7i8t8UbD5RWMSrgdxi5iDOqCGgZ19tXzxxCTvZ2yFmORlLLijJ
 twvArvSbkNmvW1uODP0ZMgLSIVD42lxYIxcnREz5rdetLj9qdgy4tvOJqD/34hRkDMHb
 hisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304767; x=1747909567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+fk+E1hNI4ene4uIKK/hnLRnqA1uMFK4Q9d7SpDJgfs=;
 b=jlDt5r2HauqByIKyL8VaiNQ2Gvm8QTN81+TQhdz9Tft6kSh1L64tHBw+46Iongyida
 SjNUbu3gisIbZy0jGvNB7B8AXhLkUC9buKzBAF20W1PVNMSikrI5C2t3SHlzPwv3Ns7I
 nBa8bauFLpYPZZMoq/d+Qq1tHFG1SWsz+IISu6BfkhdDJ9FfWL2ijiieBkFyf7ltIxxV
 u3fG3Ft97OhFzgoY9LPf/PCqjirtzcTbYsOck3W16n3XmszS5BAl+hv8wk0/D2Aa6klk
 /gacRxgJHnDrvbNJozCAfMSeny956ySLt3EVYnx0Maa6QGO4585q/N05NzaN3KHvITc2
 7g7Q==
X-Gm-Message-State: AOJu0YzeZpqz3P9kLrbji0ZoUD7r8x55ZPhi6htz/3KpLD7KMMqcdHVb
 hFQaLpXdOVZfSuVjyOMyRoIu3He9Yn/e2lL2QdO8UuWad38nh7l8lqv24zkiBAv8h2z9mFmFG05
 KKKI=
X-Gm-Gg: ASbGncuky1d3y77bCo8YUAkFc9kGVpHD3gcnRQGTM77l0qm6VTnY0QwAbLo9jPVjVd+
 kzSpZ5EhPEBgPmnWMIONaVNRhNtlWB4A8mpN9LfR6U/5sm7/wVbllPKayZjcyKAQKVjoCasUdw+
 2Mt5EhT6+eKGufb3uIB6rsML0vclcwbeVgwINrdpi9MVZaQx79vQpm/Boxf4ttqSARYoZp4i2of
 THTtLDWTEACBTRuKOklFyvu0frQEPLCNWgCf3TrFn2w5y28NvxEq8POoCZFQMm9+qPXpmnmUGmQ
 syy1AQVeTaj5n4p35u0woY+M6637ulZnD3cws4Y5L+mjmi6fHHQG0V3W5g==
X-Google-Smtp-Source: AGHT+IEsuMGWFeteTRMxWin+qCIrvuJsFDXBDxpvDyQlCn7UxaW4XolV1XVv+46ItEB9YipHHaYL8w==
X-Received: by 2002:a05:600c:4e09:b0:43d:1b74:e89a with SMTP id
 5b1f17b1804b1-442f96e8949mr19588185e9.9.1747304767095; 
 Thu, 15 May 2025 03:26:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/58] meson: add common libs for target and target_system
Date: Thu, 15 May 2025 11:25:01 +0100
Message-ID: <20250515102546.2149601-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Following what we did for hw/, we need target specific common libraries
for target. We need 2 different libraries:
- code common to a base architecture
- system code common to a base architecture

For user code, it can stay compiled per target for now.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-4-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 meson.build | 78 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 17 deletions(-)

diff --git a/meson.build b/meson.build
index 7f91500bb73..ad2053f968b 100644
--- a/meson.build
+++ b/meson.build
@@ -3709,6 +3709,8 @@ target_arch = {}
 target_system_arch = {}
 target_user_arch = {}
 hw_common_arch = {}
+target_common_arch = {}
+target_common_system_arch = {}
 
 # NOTE: the trace/ subdirectory needs the qapi_trace_events variable
 # that is filled in by qapi/.
@@ -4107,29 +4109,59 @@ common_all = static_library('common',
 
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
 
@@ -4300,12 +4332,24 @@ foreach target : target_dirs
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
2.43.0


