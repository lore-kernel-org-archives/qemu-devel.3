Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FFEC369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl0d-0003rx-4i; Sun, 04 May 2025 21:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0b-0003qc-2e
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:41 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0R-0002Tn-Da
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:40 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736aaeed234so3388618b3a.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409950; x=1747014750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1mHjwLOmCSZb7+SiNUT87VRUe5PiKHdCHDdwE+42+GQ=;
 b=ZfjFAylNT0MBmi7Jbm20QGSGsUSipgPxEeYEWEUTT/DHhwNwoRpZ5+zwsqKHm+TDjY
 ovMglyqC86Th/t80lBnlrx5Q6OYg9KZ1MCK7zYNmoJjDrQ0WCzpgGTuKvg3kjs7O7sJn
 NpMbBIbZ+GdWZIn37/GpZiJOyLxEEiJ/azq25gTuc3JpbXGOGsQaQKQj/Vz5T+RGreeB
 qCsgLYxtVVEgB6XIr5qJJxHiXoCzPWelxPw17OFcUwMv9LU3Bj8fXpw7dq4iR3y8Co1q
 iXUztg6SQi4p6J6zWAktU9vpjbx/RG7q4Pp4XRSfFlJsWRuidXyr99jpNVdc7fXRhoGO
 d61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409950; x=1747014750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1mHjwLOmCSZb7+SiNUT87VRUe5PiKHdCHDdwE+42+GQ=;
 b=neDYIeCxukOW239yP8BQpgnTYtaDwOpDDxRFs7FL7q1WCfn47cXcpPDnYe3bWB3l3+
 beK4+fgdeiE65nECp2AfHlKDPPG102Ix2jFA/i84jSz4lM7Imytecn5b97NJrR5FWYQt
 ce5s1DvIsPPpet4HK8WuKxFgXbXyivztQNY09dtbOiiEQXVJD7QzDUYSnmtLb31F1AYG
 +Z7jFN3mglsED6+i3LF9dhf1t6yzU7pKBfCBkSMqNfJsWyx5Nu2Yi9ykpZVpYFWsSHIM
 cVejs6t/HYlVeuwAV/VwkLG265Frps7XslsdJnaDtdsfwnQNQ9BE46I1nUBtOwTk+GVY
 IM/w==
X-Gm-Message-State: AOJu0YzPCA0SoHnssIIoZhgI6/FomHRt4MfWPsezK84GpUaVGlisQfYy
 a8RcLPTHt572JiFTAZOWuzLMbOkRmYRdT+XE0MT6STXg0noxLw7ld5vmEXf2EEwGWZvF128Z1Rh
 N3OU=
X-Gm-Gg: ASbGncvCRN+Hc5gt/OoHsnV3IV/4Z4u8fr3omS6CAKh/kL6zR3+xIS3xy1S4InqaZeT
 okgFYu+7og1V8hzpPn0VSGEomta2kUyFa4jvTN2M5Es01z1hJ2v/xRzUv0vvBBCe9PHUmr5RAiX
 wwtnsyzTVMCCWQJHBwyfgu2UMVPTVWZb6u70AxQemjjhBwRtTHSwZdMWgDZNG+G/HGRum3WrkCo
 9fwqteI50S0WAC2QJ16TFEmK8jq2o4D125jUrQurHNPA7g9M50qjynnFTcY8IfRj/3ztGN7iIx9
 YQ+xEday368F+v0ES2jAXXed3bzA0Yc5pkh2VNKO
X-Google-Smtp-Source: AGHT+IEnw8VfECoK5fXq9FFAAhr8guvZNgIjGdAHEKIO0OBZTov/PyOJGomE9HYGIk9r8C+GFvgmiQ==
X-Received: by 2002:a05:6a21:1743:b0:1f5:80a3:b003 with SMTP id
 adf61e73a8af0-20e97ea68fbmr8446109637.37.1746409950025; 
 Sun, 04 May 2025 18:52:30 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 03/48] meson: add common libs for target and target_system
Date: Sun,  4 May 2025 18:51:38 -0700
Message-ID: <20250505015223.3895275-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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
index abdb2cc33ea..b2c79a7a928 100644
--- a/meson.build
+++ b/meson.build
@@ -3678,6 +3678,8 @@ target_arch = {}
 target_system_arch = {}
 target_user_arch = {}
 hw_common_arch = {}
+target_common_arch = {}
+target_common_system_arch = {}
 
 # NOTE: the trace/ subdirectory needs the qapi_trace_events variable
 # that is filled in by qapi/.
@@ -4081,29 +4083,59 @@ common_all = static_library('common',
 
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
 
@@ -4276,12 +4308,24 @@ foreach target : target_dirs
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


