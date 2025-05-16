Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD18C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 05:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFnbT-0006Ie-2Y; Fri, 16 May 2025 01:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFnbR-0006HW-Ao
 for qemu-devel@nongnu.org; Fri, 16 May 2025 01:27:25 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFnbP-0001NL-Et
 for qemu-devel@nongnu.org; Fri, 16 May 2025 01:27:25 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-231d4679580so4642245ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 22:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747373242; x=1747978042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXBESZVUZ0qJuwgxJHdI3VR+MEIbN3bpMpEGJ/yalXg=;
 b=OV6+ghR4XJLqcSAEn7IvPpjnpDkZpDcHFvAsHDGDBFFxsAQvIPbFr2y0zKMczmaBQw
 rEeBHKBBGqMCToQAUqf+JFlXNBORK9XnVmUafS1t3TDJcIDPJkO9zzGlg+a8F4LgQIQt
 wU8fkwDiYr/XPPXw6y4izJnu/OHaJJwYAVNUw2zGlAKu7cJBqnD8zaFbGsa9Rt1WxRzv
 Rhtq+DD2XVey5X/gkBOIjICTPNbFzjeLNm4tvx6L/JktivAFdiZl9V9aA9qg4im6v0dN
 9nJfE96rjr3A2qLCxXTfK0mUqhvykIdLJJy9cD4GZk6I9ZdpZHwC6ndmjb9uWsCbe56w
 tJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747373242; x=1747978042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXBESZVUZ0qJuwgxJHdI3VR+MEIbN3bpMpEGJ/yalXg=;
 b=UCR1ji1u2fiMEMkhQXGCqCufZOzVNeo6djnDbKQ5BMecyoKEHYQtxA/Fqo35lUAVcy
 pVGKpZ13XTnX4vcwXwKkLUPtfAVqKa8Sxnf6C+qp2obwS2r/B3AbNVhcGBQKidXe23EP
 wkytwVs509JW2tSQ6BOxLFf9+loLT3FNq8lyoJ/saTHmi/Ifcx22p+ggf1WIQHMpJnJD
 iw3bHElqszqWhCnS+3lbGbP8YnkzLNQTztK4GZpHuw407Am/zVWiWTDn30RpMfEd7dh3
 EHNP9ltKgJeCK/qJaR2nYraVXwu/twWNVskUJLkku/2hnwcwm3FW4nw9v2EDMt/qygS6
 vjBA==
X-Gm-Message-State: AOJu0YxgIiLPNynWTP957UbPYTGfAfZyvZEnJDuvi2REo8tPol4HZ9hP
 OTAdfbai2i2ZMXEP9CnApX2i26oI0pVI2QPkMYjkRiGDj6DXnQ8f4wsokgp+ePGs3ocAVd+u89/
 2HS1S
X-Gm-Gg: ASbGncsO8iMQGYSeDHZYNAQJS5xHvTc6D1x8F8DXSZBQS7icVzRm7ILOakkz0Z0yfaK
 eZdBq3EloAfwSO/B4qLIdpyeBLF8W/pWdmK3N4FTn2WpNuQ05+RZmQWgZuA03jis4hCHSgiFFNb
 ewcDyatTCNxF8rzdEkhwLLaOdr/Hvst/6v6+aUSqhmVq/cjuNbYZVGyHC1BTqonliy9YS7jeLEA
 GrlDi86/XKm/e2G+JRvrK2KWvG4hGS9FsU3hDKBnSUPT0mF6dapA2NPYMGs++2Oma5PXYhhJ0N5
 z8nh7z3kOxQOSSXZfncD8csxF1EyBDvZsEhatDA+rWIevFOCGP8=
X-Google-Smtp-Source: AGHT+IFWSzTIxUMXClaMsNx/3QmdW+19V3MhDwNmcN8ovzqJIbpz6ChBlTE76+P2d53FezPhRuoIUQ==
X-Received: by 2002:a17:902:c948:b0:22f:c91f:d05f with SMTP id
 d9443c01a7336-231d45c99c7mr26113395ad.46.1747373241875; 
 Thu, 15 May 2025 22:27:21 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ebabfesm6539135ad.174.2025.05.15.22.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 22:27:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 thuth@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 5/6] meson: merge lib{system, user}_ss with {system, user}_ss.
Date: Thu, 15 May 2025 22:27:07 -0700
Message-ID: <20250516052708.930928-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
References: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We extract existing system/user code common common libraries to
lib{system, user}.

To not break existing meson files, we alias libsystem_ss to system_ss
and libuser_ss to user_ss, so we can do the cleanup in next commit.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/meson.build b/meson.build
index fadee0f29fa..98b97fd7ba3 100644
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
@@ -4154,7 +4161,7 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
         sources: src.all_sources() + genh,
         include_directories: inc,
         c_args: target_system_c_args,
-        dependencies: src.all_dependencies() + common_deps)
+        dependencies: src.all_dependencies() + common_deps + system_deps)
       hw_common_arch_libs += {target_base_arch: lib}
     endif
   endif
@@ -4168,7 +4175,8 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
         sources: src.all_sources() + genh,
         include_directories: inc,
         c_args: target_c_args,
-        dependencies: src.all_dependencies() + common_deps)
+        dependencies: src.all_dependencies() + common_deps +
+                      system_deps + user_deps)
       target_common_arch_libs += {target_base_arch: lib}
     endif
   endif
@@ -4182,7 +4190,7 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
         sources: src.all_sources() + genh,
         include_directories: inc,
         c_args: target_system_c_args,
-        dependencies: src.all_dependencies() + common_deps)
+        dependencies: src.all_dependencies() + common_deps + system_deps)
       target_common_system_arch_libs += {target_base_arch: lib}
     endif
   endif
@@ -4358,12 +4366,12 @@ foreach target : target_dirs
   objects = [common_all.extract_objects(target_common.sources())]
   arch_deps += target_common.dependencies()
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


