Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA22FC369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JLa-0000Hj-I8; Tue, 22 Apr 2025 15:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLU-0008QE-3W
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:52 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLS-0006aZ-0G
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:51 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22401f4d35aso62147115ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350308; x=1745955108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RK0p9wQfVgEVzHTMYQneP9tRo6BI56q+RabGlzQyjiM=;
 b=NjUhODq0wFg0Brnr5ilmupwcCAzGvoO5A5a2jmJbo84VxA777dRT+WWxTjujnQ9m6H
 yPG9cPSJmfISvG4rzUnaZz5OBBA5IAjWroWy+PSsjCTvs9oRTeMVuZduB/tSkiq+zfbo
 p+5HTrcy3Xgr3EOstxDJRaECPEU8CV5jYSpvPqXTDoplzE6Z5BRkz3wobMrB/pENDHME
 eE7qmtyqlFZaJOcYRDnHh6sc3+qk3oaY7fG8+1YZLB+SDUAizsdoC9anPdE+2XO7vA45
 fJmpBvPibc5DRJofn3V3kFiJp24i9IIFh3bkOGKdQLl3MszpNhJCLqsW1bdvbw9DcVgV
 pI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350308; x=1745955108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RK0p9wQfVgEVzHTMYQneP9tRo6BI56q+RabGlzQyjiM=;
 b=GrIfiECI5OFggbjNa5SxP/mM4eGUfZgingkWD/DB7DgGnSUGagaGyLVFwSUR1W0HhX
 tBCXXn6CKsMRHgKskOq3scfZMiFxt0z1sGZ7BTOM8bgGcSFHGwVqKuhm02Ayq49ByjhG
 XtQm+gYXDHtmxDpnBJyzAhseITl0Tap+RXCZwtySgm7+2qc7MiH5FxeahfGGjnBmedFR
 N9PUEDgAfjQVh4fOeo+KFMi/+JmJNzKcw/ScTwaC/wVvXWaUW15UrvLNJsb8GE5lB3m1
 2alayH6fqER9TtrhoRZ6g6aQjTDCyoZWqe6DEN2snDkrIyULIyQdTfoGbGuCI9cwDbS+
 jFBA==
X-Gm-Message-State: AOJu0YzwIzE+nnQH6FLxAU4NpySj3tnIT3j8LBPgYnXLfhKHg7Ealput
 PJKiBUAyZ2EWQ6hirQb7ejBf3rLxtwg9NbmHBCq6P6z9vSfYS1prxqUzEWLUbvJo4qzRqA6IVEz
 d
X-Gm-Gg: ASbGnctjGkH8f3v3IpwFnp19gTH+xK65xeMmLCClWVr3qmvxgrAKyzyKi3maxcKUzmi
 ksoBCFHSGBBes3wMHQqF+gdkeslYsqxRO3B9o1hl879Df0CxWtAK85pjIe7eggbPreZ5xlGKU01
 ps0f9zKFzV1TulWOL9hZMxDEk/LCakPzyVN7LUobSACt3BBBOqrfooe11PoOJe5EL9+rG2PZbw8
 0nrHjRl7mrwff1JRFhOUpNEkyyp5zvHjnN76lsPdhswb6SuTBr/UPFszwhtZIdnvyvL0ZiTPEe7
 s7KRpdN++G1g0Idqlt3LSIbbV/vU8FFy3fIJbsx1mq/Bv0OQrNV2beFgaGxeTOA0aU0jSgE/uzc
 =
X-Google-Smtp-Source: AGHT+IGexOeAtuv+pWgvR5o9iU8zWslkGHMpbsYRBy3/u1CVMsZb/6FctPrNlkJhYDWZN4iTvniG0g==
X-Received: by 2002:a17:903:250:b0:224:1ec0:8a0c with SMTP id
 d9443c01a7336-22c535acd5cmr253967455ad.29.1745350308249; 
 Tue, 22 Apr 2025 12:31:48 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:31:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 041/147] meson: Introduce top-level libuser_ss and libsystem_ss
Date: Tue, 22 Apr 2025 12:26:30 -0700
Message-ID: <20250422192819.302784-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
index 41f68d3806..7e22afe135 100644
--- a/meson.build
+++ b/meson.build
@@ -3662,12 +3662,14 @@ io_ss = ss.source_set()
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
@@ -4045,6 +4047,26 @@ common_ss.add(qom, qemuutil)
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


