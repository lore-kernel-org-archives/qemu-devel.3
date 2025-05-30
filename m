Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F902C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtvL-0008D7-CT; Fri, 30 May 2025 03:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvJ-0008Cl-T2
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvH-0006na-NY
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3+XE4e8aMSeFFSFNL/218gsKkgHYSEQyHzUsqXaoYHs=;
 b=Pv7UT9F9AwCZCPsjdzICFUz05Yqy7FqnRG9Khm55pOlzRbARto4N3doPvsZ0SzXrE8erwG
 4QllJr0w5f6dYRAbT3kCBxBrvDibliksU+2vI8VnRZDehbh6SiMNOIa+vP0eh7GwnCL/ZK
 LA+xH4G+j0yqCOkXDqbS5ogtLG4/pfM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-SWjkpCdhPv2s1yPVQBCbNA-1; Fri, 30 May 2025 03:12:56 -0400
X-MC-Unique: SWjkpCdhPv2s1yPVQBCbNA-1
X-Mimecast-MFC-AGG-ID: SWjkpCdhPv2s1yPVQBCbNA_1748589176
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-604630fc735so1237771a12.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589174; x=1749193974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3+XE4e8aMSeFFSFNL/218gsKkgHYSEQyHzUsqXaoYHs=;
 b=LZdwF85N+Dkt/NNmbGHYSwvLhBPEgqXgYT5sOZIvzoVhiSJf0g3HgxppoPGDN035oP
 YFibAIDQp5o1WA8wGM0lQ+cIaiyS4hi+vpIRq1WV8ZhV49b2dvFMmrtlheHR4u4yN8ki
 qMsCbbOLX96wovBXqwMJO7Vj8dLUXkONQGAdkS7/JIsK13TD9wMUktYf6WNgPlpcWWHI
 WA64kAKfE9emMzB3H/lMsxlYl9IMvfLNbwfErlnFqbo7Ngqss0p/MPmEmukwpayr3K02
 0qhyNDj1c6zxnpRgsg4/umKEk64RP7fW0JKDoM18lZlDTOQ676DRGCPgKUFgyt7lemkn
 4gAQ==
X-Gm-Message-State: AOJu0YwE2X86QC5vO3ldt8xEsu6RWxzt5RtvqiMUDD/CCg8PjiAlyajg
 DHkj9GyEvl124Z1aN6alysiKJAkLgoA19eN3qqW301RFJIZFxPrsXM9vLF0j/QfHTS+qCAvhUtM
 0cnTWkdordiBK0F4arqOjN71If821h6Cig8WPkNlcvSPM8b2xAuATTupHtNttKNMzw5SOzLIMZD
 3uFlBDpLIczsO4HN2C7bzu5XVs6fe3s+ULs9+kmiHG
X-Gm-Gg: ASbGncun+z0ds4oUMYUuRHHyzzCEDUL4xWYF9iaHZNvuhWYYpuLDs1XANDtaahOeF40
 If4KRM3D3hsr3SMgkeikUSB/n/7dzypBChBpTibWAAxPXr31pqylJUEbscwd4CB8Nxogbw9PquD
 2ZXy0hP3XCgpeb069jtaZHpI5XJDbIOfW2W9fGaPUx1DFjGXE5hdklsER3KKtNtdqDGy1udC9k1
 Ntr7jTSHKQi9i7tPYtUThP8+7IjBcvufBpMONy2eXLyBBvSFZ3uQPnU+I/wa0bgsdRLXGqcPOIq
 A+WCfCBOgd7yWQ==
X-Received: by 2002:a05:6402:35c6:b0:5f8:357e:bb1 with SMTP id
 4fb4d7f45d1cf-6056e1597eamr1732657a12.22.1748589173889; 
 Fri, 30 May 2025 00:12:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBpa2ccG9zAuGIgx8wSbSDXRptQwtMp3U5IZCNMrpJEqezwrRYDrVCTs7ljl7Hm09h9cI+Lg==
X-Received: by 2002:a05:6402:35c6:b0:5f8:357e:bb1 with SMTP id
 4fb4d7f45d1cf-6056e1597eamr1732633a12.22.1748589173465; 
 Fri, 30 May 2025 00:12:53 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60567169e04sm1185863a12.79.2025.05.30.00.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:12:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/77] meson: build target libraries with common dependencies
Date: Fri, 30 May 2025 09:11:31 +0200
Message-ID: <20250530071250.2050910-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As mentioned in [1], dependencies
were missing when compiling per target libraries, thus breaking
compilation on certain host systems.

We now explicitly add common dependencies to those libraries, so it
solves the problem.

[1] https://lore.kernel.org/qemu-devel/20250513115637.184940-1-thuth@redhat.com/

Tested-by: Thomas Huth <thuth@redhat.com>
Fixes: 6f4e8a92bbd ("hw/arm: make most of the compilation units common")
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250521223414.248276-2-pierrick.bouvier@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 75 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 35 deletions(-)

diff --git a/meson.build b/meson.build
index ad2053f968b..cbb22f60d1f 100644
--- a/meson.build
+++ b/meson.build
@@ -3242,6 +3242,7 @@ config_devices_mak_list = []
 config_devices_h = {}
 config_target_h = {}
 config_target_mak = {}
+config_base_arch_mak = {}
 
 disassemblers = {
   'alpha' : ['CONFIG_ALPHA_DIS'],
@@ -3433,6 +3434,11 @@ foreach target : target_dirs
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
 
@@ -4111,57 +4117,56 @@ common_all = static_library('common',
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
2.49.0


