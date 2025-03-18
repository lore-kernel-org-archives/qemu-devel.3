Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE1AC35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueZd-0003d6-3o; Tue, 18 Mar 2025 17:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY3-0001Jn-PC
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:32 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY0-0000mz-Js
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:31 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22401f4d35aso116911585ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333547; x=1742938347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jrgt/XCMOgJKy403kS5/j6/fnymT1kJMQRDGV0b46U=;
 b=wTyaD2XFOMb3hiJ0XA4QcttjQogVcmZGxstSVc9Ps5eUC4nmRgwmdUl5C3vA7EhooP
 C2eaE1zWMdqNpME4u1JJeKs1RXIMpIXKzK6xQ+E0OAw9dYrtOT9J3qUQKI9s1egIm13l
 iSNAkYQuf5vS6AhT6n9dQM8Uql3DykPHPN4INjLZzcta5L4Hdobk70fkDOBFhIb0RE9w
 jD74LofdyDNNOOLPyc1nXiITGLXePCgCtEwR9O4BGHYVNnX2iQFgKZ8SsmN2kSvpVS+i
 fU7CvYH7UBvT7qVHiEvZNBy8ZsVoMqYcUVp5O6eFe9VWZUD1GJzZ45bqJrIoz2YXDmNz
 1SuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333547; x=1742938347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7jrgt/XCMOgJKy403kS5/j6/fnymT1kJMQRDGV0b46U=;
 b=SmEPO2aqqTqlP376hp1Q6vH4MzDT6ZNoqpO9U4BTmhsM9n4OZ/aqKvwNxpX7HsF7vK
 zaShCvPXyrwbAmmhKZGFMfDMidhOCT6xew/Ij/HNKLcQvu5W/kEcZP3XTNfCmamCKzg1
 3dIQLImI/sRjtk0BwyBb3WbpNEOG0aMAwc1PSa5ktYTTG12I0tUUAe8kxXgZFwLsoFMh
 iUZz1lSvD06/LobeEjcEuX3MNN6xIhDX3FB9Fq9XM5GOgVGI+0dDVmFweFOUP6CqrxkE
 SvsJF3j8woK3Ilgxabpntf0Nbmxvv2tGVT2zx25UX8HPjoXqsimFQbFP6BaOWAjehFRt
 6c4w==
X-Gm-Message-State: AOJu0YzOYp4PY1uPrgoB8SAC8OVq27U8lXnBZl1IEGsC/vEaZSmtNJKk
 K+SFg9QsbCotfC3YKCI7uRbSBmGo2X4umMcvpzQAZZBGb0aiRIYGPy78Kubx7OTD3t11uc/BhX5
 k
X-Gm-Gg: ASbGncuNVU6pLaAydBxp4Ck4Qn9ypBwZyWUWnIssa8sP6hJ/WuPUI5TsjZWT/+1dT8W
 BanSt14wgAS0Shq2Zxi4g3h4L5NVUmRVQL9OzBN4bhKJmIHWqIQWN4bzJP14wnCZBPFnTkNeBRH
 FpNConxfW8VjzRt/jTM/OpXICXltoGJZEG/vlhKppIG0zaC08jb0Arhdam9mjexf9KK7dpI+10i
 mE2KLiq94slmF+n/xHvw4pH7voweAJkGVWUPe74rjZ0FfV6m5c+KLXXshS7ZZ/J5/eLJbEyARkV
 xe8rUQ9290b9hpK9D3B7xiWLK1hZ2Xl0UxjIhpiZkpWIQlDVZFKRPZCUVyr3EI04+O4vfE09tsa
 s
X-Google-Smtp-Source: AGHT+IHl/pBFPgJf6mYRTHGi/fnDcd19LWwmdOT8agijoHfQRgSHdqSLZY3mik4aOxH2tL6+ZXPkZQ==
X-Received: by 2002:a05:6a21:62c6:b0:1f5:75a9:5257 with SMTP id
 adf61e73a8af0-1fbeb4a330amr354168637.13.1742333547296; 
 Tue, 18 Mar 2025 14:32:27 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 23/42] meson: Introduce top-level libuser_ss and
 libsystem_ss
Date: Tue, 18 Mar 2025 14:31:48 -0700
Message-ID: <20250318213209.2579218-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

We already have two subdirectories for which we need
to build files twice, for user vs system modes.
Move this handling to the top level.

This cannot be combined with user_ss or system_ss,
because the formulation has not been extended to support
configuration symbols.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub/meson.build | 32 ++++++++------------------------
 meson.build         | 22 ++++++++++++++++++++++
 tcg/meson.build     | 23 ++---------------------
 3 files changed, 32 insertions(+), 45 deletions(-)

diff --git a/gdbstub/meson.build b/gdbstub/meson.build
index dff741ddd4..0e8099ae9c 100644
--- a/gdbstub/meson.build
+++ b/gdbstub/meson.build
@@ -4,32 +4,16 @@
 # types such as hwaddr.
 #
 
-# We need to build the core gdb code via a library to be able to tweak
-# cflags so:
-
-gdb_user_ss = ss.source_set()
-gdb_system_ss = ss.source_set()
-
 # We build two versions of gdbstub, one for each mode
-gdb_user_ss.add(files('gdbstub.c', 'user.c'))
-gdb_system_ss.add(files('gdbstub.c', 'system.c'))
+libuser_ss.add(files(
+  'gdbstub.c',
+  'user.c'
+))
 
-gdb_user_ss = gdb_user_ss.apply({})
-gdb_system_ss = gdb_system_ss.apply({})
-
-libgdb_user = static_library('gdb_user',
-                             gdb_user_ss.sources() + genh,
-                             c_args: '-DCONFIG_USER_ONLY',
-                             build_by_default: false)
-
-libgdb_system = static_library('gdb_system',
-                                gdb_system_ss.sources() + genh,
-                                build_by_default: false)
-
-gdb_user = declare_dependency(objects: libgdb_user.extract_all_objects(recursive: false))
-user_ss.add(gdb_user)
-gdb_system = declare_dependency(objects: libgdb_system.extract_all_objects(recursive: false))
-system_ss.add(gdb_system)
+libsystem_ss.add(files(
+  'gdbstub.c',
+  'system.c'
+))
 
 common_ss.add(files('syscalls.c'))
 
diff --git a/meson.build b/meson.build
index 7f75256acf..329e7f056a 100644
--- a/meson.build
+++ b/meson.build
@@ -3666,12 +3666,14 @@ io_ss = ss.source_set()
 qmp_ss = ss.source_set()
 qom_ss = ss.source_set()
 system_ss = ss.source_set()
+libsystem_ss = ss.source_set()
 specific_fuzz_ss = ss.source_set()
 specific_ss = ss.source_set()
 rust_devices_ss = ss.source_set()
 stub_ss = ss.source_set()
 trace_ss = ss.source_set()
 user_ss = ss.source_set()
+libuser_ss = ss.source_set()
 util_ss = ss.source_set()
 
 # accel modules
@@ -4049,6 +4051,26 @@ common_ss.add(qom, qemuutil)
 common_ss.add_all(when: 'CONFIG_SYSTEM_ONLY', if_true: [system_ss])
 common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)
 
+libuser_ss = libuser_ss.apply({})
+libuser = static_library('user',
+                         libuser_ss.sources() + genh,
+                         c_args: '-DCONFIG_USER_ONLY',
+                         dependencies: libuser_ss.dependencies(),
+                         build_by_default: false)
+libuser = declare_dependency(objects: libuser.extract_all_objects(recursive: false),
+                             dependencies: libuser_ss.dependencies())
+common_ss.add(when: 'CONFIG_USER_ONLY', if_true: libuser)
+
+libsystem_ss = libsystem_ss.apply({})
+libsystem = static_library('system',
+                           libsystem_ss.sources() + genh,
+                           c_args: '-DCONFIG_SOFTMMU',
+                           dependencies: libsystem_ss.dependencies(),
+                           build_by_default: false)
+libsystem = declare_dependency(objects: libsystem.extract_all_objects(recursive: false),
+                               dependencies: libsystem_ss.dependencies())
+common_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: libsystem)
+
 # Note that this library is never used directly (only through extract_objects)
 # and is not built by default; therefore, source files not used by the build
 # configuration will be in build.ninja, but are never built by default.
diff --git a/tcg/meson.build b/tcg/meson.build
index 69ebb4908a..7df378d773 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -27,24 +27,5 @@ if host_os == 'linux'
   tcg_ss.add(files('perf.c'))
 endif
 
-tcg_ss = tcg_ss.apply({})
-
-libtcg_user = static_library('tcg_user',
-                             tcg_ss.sources() + genh,
-                             dependencies: tcg_ss.dependencies(),
-                             c_args: '-DCONFIG_USER_ONLY',
-                             build_by_default: false)
-
-tcg_user = declare_dependency(objects: libtcg_user.extract_all_objects(recursive: false),
-                              dependencies: tcg_ss.dependencies())
-user_ss.add(tcg_user)
-
-libtcg_system = static_library('tcg_system',
-                                tcg_ss.sources() + genh,
-                                dependencies: tcg_ss.dependencies(),
-                                c_args: '-DCONFIG_SOFTMMU',
-                                build_by_default: false)
-
-tcg_system = declare_dependency(objects: libtcg_system.extract_all_objects(recursive: false),
-                                dependencies: tcg_ss.dependencies())
-system_ss.add(tcg_system)
+libuser_ss.add_all(tcg_ss)
+libsystem_ss.add_all(tcg_ss)
-- 
2.43.0


