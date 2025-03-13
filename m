Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E18C28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZW7-0004f0-BF; Wed, 12 Mar 2025 23:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZW4-0004eK-7T
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:52 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVu-0007mh-3J
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:51 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-219f8263ae0so9605145ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837540; x=1742442340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HBRn320f0vqZtJU6nV6Y66O0sC8qfPrEa7TKcBvFURw=;
 b=WA4nmHfuo1uhHRE0vBecsJqVGjqRQOccWRQfnZLPwe/fkv/mzgM6xT1EqSFHgMUL2N
 JioKaq7MiHPpEmuN1ic2LLLkS+WcAfsuQ9Iftf1BKNVqvAABkIsxP2kg6Zgkr5zBk28v
 13h57+F5SKj3r7G8aLWSW4ZE/lVE1zM/laZtG1CuFKdwo9BatcSICYAAfD6Mzoq9LBZv
 BEtbP+FZkW9T052ehxeoSPZlR7S4g51mrMJUfg0zQ1UtYYHuyoHH3OYuE7+qAcWsmrgT
 HPH7EpOGhXdnBnQAaVTkbgbwlvwySDXBQ8IoUNG7j3Sa/orFEJyOF/kRWxpzNzZgD0GP
 iuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837540; x=1742442340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HBRn320f0vqZtJU6nV6Y66O0sC8qfPrEa7TKcBvFURw=;
 b=OzcgcY4nIK5Bdkebfzp1MYmzjTjFrZR2LkkvLNHsM8k6QGOA/DXPnConzr1+8Bsj7S
 ismTYBYGm0UZggBkgzdO9wqYx9YuGALjmgoM5RK6pITX/V6ZfC5WouUHHXt/i7rFCIMs
 KQt7pOGq47VCqeWwxLHQZ2ssVFsJ7HVjCA/fLF6zk/tbP5WltrHlxYalcNhlOWY6dSdO
 7SZZnvnvo++L6IH1xAJNWzUEcT2dcFi1y58AZes+k0Tt/azIKLYQSVNCoNSfO7qHwHcn
 S2o6ANM39PkEcxyoYeksgvH51d/PV+qZIvojqQaig5XzIVmY+mLEj70gntTBHLiawEyd
 Jwtg==
X-Gm-Message-State: AOJu0Yx8izrTe/LQ4SPDgNv5s1lfKZVruIwy0J3X7yjaZC7lyBWL6plX
 0yQVbkVCBHVRfhGNnIHfJOK7QcqaBu+BjXd/si5SaMKyhBdz0fTjv+w0KCdTlxAScWnmqorI3fB
 m
X-Gm-Gg: ASbGncu2N/n8fCE0gOCgETV0/UCpPoOAep7S4Oax8FKiHDE4ih/DzigH6daJCjJind5
 Gz8aC+FbhIiQq2Ucodl/7Gzyq/0EFeOFbp+hl+quZJDbdJXNEmrXAAXBq+07LUr3eJssggdTniw
 qIXgWFaVvhH5khK2h4MD7M/ekfVvKi/sy4JlS2hZdy1+A678igIynF4gedF2xAsZhB04D0ZD1p1
 UcqczBfutkR+Fg5DLYIcgqMnZZKVamZy4El8xG4I5WEpFtNKM1yPx6aP4hYyHLV8fFySQvJGQvX
 hBZV3AVicy4MLuWJ3WdFNUFSEFrNrN6rYXbfOs2mfG5S/krCiNl9270i9LuBLczMW1zYAFF+qai
 +
X-Google-Smtp-Source: AGHT+IGKln9yoGyodt3HmCRhtcaK5NUv/CYAHNrkFi8lHxE7RjRsF+/xZbrYCbc2OijI4MOYee4YqQ==
X-Received: by 2002:a05:6a00:8d2:b0:736:46b4:beef with SMTP id
 d2e1a72fcca58-736eb7b36d9mr15103299b3a.3.1741837540096; 
 Wed, 12 Mar 2025 20:45:40 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 17/37] meson: Introduce top-level libuser_ss and libsystem_ss
Date: Wed, 12 Mar 2025 20:44:57 -0700
Message-ID: <20250313034524.3069690-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

We already have two subdirectories for which we need
to build files twice, for user vs system modes.
Move this handling to the top level.

This cannot be combined with user_ss or system_ss,
because the formulation has not been extended to support
configuration symbols.

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
index 9d9c11731f..3869e5bfbc 100644
--- a/meson.build
+++ b/meson.build
@@ -3655,12 +3655,14 @@ io_ss = ss.source_set()
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
@@ -4038,6 +4040,26 @@ common_ss.add(qom, qemuutil)
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


