Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690F2CD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKctO-0005pB-N1; Wed, 06 May 2026 10:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcsl-0004hw-Ir
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:05:50 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcsi-0001hW-JG
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:05:46 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-44985f4ab0fso3093600f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076341; x=1778681141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wOtErwW0lTtn2AM7UlvNYjNCtCRetlbY5MBnk9eUwmo=;
 b=uRlVIgKYi9I1X+siHOakKvePrgNXGBL/ZqGgOhCKHOxOi6D4T2irRRMOstbrjUiSDB
 hKfyy6nKCZkHm3KvWI+7wekze03abkZKayAYf9Su5zGD+pn+Bqc8WjnfBwSuq8j2ZK1e
 81zmUWIs6bSIUaS7vKy2KnRE81lcpR4QKNgYLAo+Wm2ZCSO1s4YFJBv2ibGaL0jR0umA
 zgzlt7QqrN1IOc0/6Lp6goiBvXz6p5dzV8TtL4WM8nEtTUXLx55A9zpSO3jstNbOn4RD
 6tlH9SzRGuatOG/hCe4TRj8Xt8WqHJVZV/c54rd4BMmVxxegvj78XnnczjTNugvGdS6B
 N0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076341; x=1778681141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wOtErwW0lTtn2AM7UlvNYjNCtCRetlbY5MBnk9eUwmo=;
 b=evESlISqTIwIID8XRmlzEEYKhuXkdng886B+qEl/Bq9vUo1W+W4MzUq66fe7Wvxk4p
 gVOFdyJyYTOS6vK20BkRc+X72lHithS2/7n9JxzI2wZSOqsH/1mf+LVx81F/5xBGBFY9
 vN8HbFXxgZlQXhdedULkC/ATwa4oFg0kfePMhsj+GvTB1+4vjinwdAM1xpE+hURiTkS2
 0B9Guh+nC1hoXu67H7VxfVeQPB0ai+QZiOYlWn0xrBp9mkb0KFUQSYqndSHxCYqVr75F
 Y6DwwOBoqKYBODi3CD7p79WQJftrqlFGAgIEHxcuMERTnXqswJ9mcreOiYdwIOEG62gR
 fR4g==
X-Gm-Message-State: AOJu0YynF4MNDtBETFAio8jC75qCSadB/oks2as34V74mqIhNC3Nf+L1
 /ZkNpKPpF1mYpBUZbjuLY8FCFdfPcktkTPYi3h95rPXbB++p96SGJ31vav9jTfMqTSyzXzSpFbG
 UzTiBkkA=
X-Gm-Gg: AeBDiesEEFzI+hoCCunI4d2CHwJTc1CYJcgWP7hA59iFELTo1v/Vg8lDohzDurghBQz
 yIcfn2dxYbiUUxbDppyzcb398ONNiKQ1EjcOWmCcwLv9VUYIyGeASsQLHqlz0+Xi4VcowSsERU3
 JdPvTcj8ItVZ+GeBwlsOAuvml5T6a9Bp8WJjwm+JNSOwJ/7mTkvROV1xAGE7haPIFJzdhRclHoV
 o/EAS3QFOoJCrY9zi91RUaUH3iNuCdkkAsU0qTg5O7J5v6STxLoQ/EWQTsOR+M0F8mE55WgVYPY
 TWXR7lyqlF7OFzGwu/uMDH3XY8mMPzt3Tcm4BRexHt9ZysP4uZOLyEdNm62S+Xp16VIotfkw2pm
 n2ktfJByqCy9dhAZAnAOSlLRCmMfeDuDn2XDvEu2btmSxIoKxf+jA28piyE7RdCPgb0q03kRXz1
 xnRSK7VqiCXz8Hld5QKap5hAlA9JNG6pyZKtu789AQWKkS73zToq0C5xcDO2wQkznIQu/fzoYI7
 hzZBiqObD0=
X-Received: by 2002:a05:6000:200e:b0:43d:781d:37b9 with SMTP id
 ffacd0b85a97d-4515dc80a95mr6161729f8f.42.1778076340998; 
 Wed, 06 May 2026 07:05:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b03df9sm12424062f8f.24.2026.05.06.07.05.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:05:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 078/110] meson.build: define stubs library per target base
 architecture
Date: Wed,  6 May 2026 15:54:50 +0200
Message-ID: <20260506135524.20617-79-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

QEMU stubs (from stubs folder) have a unique feature: they emulate weak
symbols. Weak symbols are not supported on Windows with gcc. This is
achieved by defining a static library, so the linker can pick a file
only when one of its symbol is needed.

The problem is that common stubs are embedded in qemuutil, which is
defined and created before any target code. Thus, to benefit from the
same feature for target code, we need to create stub static libraries
for each target architecture.

To keep things simple, we declare one library per target base
architecture. This implies that stubs are compiled only once, and we
choose them to be system common files. This is not a big issue, since
stubs definition have no specific behaviour, out of returning a default
value, or stopping execution, which makes this safe to link them in user
binaries also.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260424230103.1579600-2-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 987f33bacee..5fbdc75a0fc 100644
--- a/meson.build
+++ b/meson.build
@@ -3738,6 +3738,7 @@ target_user_arch = {}
 hw_common_arch = {}
 target_common_arch = {}
 target_common_system_arch = {}
+target_stubs_arch = {}
 
 # NOTE: the trace/ subdirectory needs the qapi_trace_events variable
 # that is filled in by qapi/.
@@ -4143,6 +4144,7 @@ common_all = static_library('common',
 # construct common libraries per base architecture
 target_common_arch_libs = {}
 target_common_system_arch_libs = {}
+target_stubs_arch_libs = {}
 foreach target_base_arch, config_base_arch : config_base_arch_mak
   target_inc = [include_directories('target' / target_base_arch)]
   inc = [common_user_inc + target_inc]
@@ -4202,6 +4204,15 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
       dependencies: src.all_dependencies() + common_deps + system_deps)
     target_common_system_arch_libs += {target_base_arch: lib}
   endif
+
+  if target_base_arch in target_stubs_arch
+    src = target_stubs_arch[target_base_arch]
+    lib = static_library('stubs_' + target_base_arch,
+                         sources: src.all_sources() + genh,
+                         include_directories: inc,
+                         c_args: target_system_c_args)
+    target_stubs_arch_libs += {target_base_arch: lib}
+  endif
 endforeach
 
 if have_rust
@@ -4363,6 +4374,11 @@ foreach target : target_dirs
     objects += lib.extract_objects(src.sources())
     arch_deps += src.dependencies()
   endif
+  lib_target_stubs = []
+  if target_base_arch in target_stubs_arch_libs
+    lib_target_stubs = [target_stubs_arch_libs[target_base_arch]]
+  endif
+  target_stubs = declare_dependency(link_with: lib_target_stubs)
 
   target_specific = specific_ss.apply(config_target, strict: false)
   arch_srcs += target_specific.sources()
@@ -4408,14 +4424,14 @@ foreach target : target_dirs
       'name': 'qemu-system-' + target_name,
       'win_subsystem': 'console',
       'sources': [main_rs, files('system/main.c')],
-      'dependencies': [sdl]
+      'dependencies': [sdl, target_stubs],
     }]
     if host_os == 'windows' and (sdl.found() or gtk.found())
       execs += [{
         'name': 'qemu-system-' + target_name + 'w',
         'win_subsystem': 'windows',
         'sources': [main_rs, files('system/main.c')],
-        'dependencies': [sdl]
+        'dependencies': [sdl, target_stubs],
       }]
     endif
     if get_option('fuzzing')
@@ -4432,7 +4448,7 @@ foreach target : target_dirs
       'name': 'qemu-' + target_name,
       'win_subsystem': 'console',
       'sources': [],
-      'dependencies': []
+      'dependencies': [target_stubs]
     }]
   endif
   foreach exe: execs
-- 
2.53.0


