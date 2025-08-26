Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4984CA0FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwHp-0004PB-RV; Tue, 26 Aug 2025 12:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwHo-0004OR-De; Tue, 26 Aug 2025 12:12:40 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwHi-0007yd-Gu; Tue, 26 Aug 2025 12:12:38 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b4755f37c3eso5063076a12.3; 
 Tue, 26 Aug 2025 09:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224751; x=1756829551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y/Hd2M4tE3Hbkiac75/z8ogO/ymEtGCAa2RPV228M/k=;
 b=NiIGeXXIxIJt7qlqah15iVjna/aGWeX3e9G34raqpWKGHppupiYQrJBghHCBOdh/Fy
 l7ZLygEfuK900KRF2/wfjHpwmwQ+cBDpcy+8CH+trxxb0+8tnqskk6KplGJoMVUMueRN
 0GyTunX5ggjcogFanpNQsJJkPCw8LVhsNW/MSzhIobjkLnyglrZMwW7M9SBujFnhlCVn
 eY4YVo+A7+hUuIJN1mfMtAT52D2whPwwdx1uvB3LjXCx3rIeKDyMRZ8xX1vMKcvh82IU
 GkSuruB0yh3dvL3pVZLL0TqhWarmWeuAzRIvO7lfIrQ3dDtH/MmoOB6knSPF1KfIFJwq
 7hGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224751; x=1756829551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y/Hd2M4tE3Hbkiac75/z8ogO/ymEtGCAa2RPV228M/k=;
 b=AvypOKASWDvtUg9zTZB8TK6uhE8oTp5Y1rzkuh6X6tB2LObF5n2t/OqnUDB4JLI0mp
 AUNbGdOO2OEll8MBubJQQRkBvxeY3EJ59kbGke4aK+cm2TE3BlFw3yFyLo04bbcPetVW
 x2WVLOkenAFRU2fqN5F7/1P5bp96KDG4cgGIYorCp2ePvv+Hcmknj5m0trei/t+I2vnk
 koMFts/dyS4J3d4he5MQtWZ914+zH4xgyOUDO5WPZk7ekJwZ6EqwUoYpEjoDjN89rrc7
 elMp5gmU3YFI5DYr2P1J0Bn9FRk5R7ZcWQzB456THZBxxJcvExxV1fIB83XYKd/z6ssQ
 hutQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI39LNX3NLRZC+rRJ4WmpbMi54nbq0TLKddZVQp9NNJDbwei8xfDiLFRTvokejHtOliaF7gxsaUKTdPw==@nongnu.org,
 AJvYcCWU/R3eoHa6kk5VRBy3gyv6F2iwOZnm1YgC3uoGHqZGZ1j5AnkJP7ajr6JhiG2W9/D6U2YffFQVnA==@nongnu.org
X-Gm-Message-State: AOJu0YwtlUCFqoFOvZbInS1dY/B7DLinYbRdithD7dH5+HKhuOBC0Tj4
 htkFZLNsi4suNHvWHR2ARq9o0lFHdrDhknYL4XZ72sXIjpz5Rt3LMbmjWxQ4WA==
X-Gm-Gg: ASbGncs6t0mv7X+Od3663MRnc1P8aSjCHfTalYaytkIwij9K+En8xcOO42fQ0r9napf
 zyijT8E9o4SR+Lvb2d3rjmy/ZZi0V7xtcQgqoHUx3f9ozG0cYgBTP2s6ZSszaQdRgxXjiV4Jdvq
 qCVMyI2D9Xx3cG9Co8u3WeLZ3utpRrWtM9EbaRAkZxOMm6j+3iccyNpdAAda3faj3sW1ADhqlUf
 BGaaYLKny/sHqSJMl93lbI1cMKQld7bTT4ZAgezxliwlT76k2upCWe/rt6kUjA4v34PCB4S4ecQ
 9V/VQaG7rEArt0wTCyWogmGb18HmpfgpYM0f1y5ouI2nNWac5XwpjCq4WIRiiTF4KL2Ak2N/uwR
 OXgcHHImbLpGAzYIQ4MPcew==
X-Google-Smtp-Source: AGHT+IFIPuMmj0C9JKFEloEC9A22ne0BRSrs40BAJDwQNDURJV7Lb6s/zjwBjjc89tD13lHkWbc92A==
X-Received: by 2002:a17:90a:d610:b0:31f:762c:bc40 with SMTP id
 98e67ed59e1d1-32515e54409mr24293568a91.16.1756224751088; 
 Tue, 26 Aug 2025 09:12:31 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:12:30 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v2 14/35] tcg/wasm: Add load and store instructions
Date: Wed, 27 Aug 2025 01:10:19 +0900
Message-ID: <a507277f4b40617655ba1c94963ef42c78ebbcca.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Since Wasm load and store instructions don't support negative offsets,
address calculations are performed separately before the memory access.

When Emscripten's -sMEMORY64=2 is enabled, the address size must be
32bits. So this commit updates the build tools to propagate this flag to the
C code via the WASM64_MEMORY64_2 macro. In this case, the emitted code casts
pointers to 32bit before memory oprations.

Additionally, the declaration of "--wasm64-32bit-address-limit" flag has
been moved from the configure script to meson.build. So the flag name is
updated to "--enable-wasm64-32bit-address-limit" to follow Meson's naming
conventions.

TCI instructions are also generated in the same way as the original TCI
backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 .gitlab-ci.d/buildtest.yml    |   2 +-
 configure                     |   8 +-
 meson.build                   |   4 +
 meson_options.txt             |   3 +
 scripts/meson-buildoptions.sh |   5 +
 tcg/wasm.c                    |  87 +++++++++++
 tcg/wasm/tcg-target-mo.h      |  20 +++
 tcg/wasm/tcg-target-opc.h.inc |   2 +
 tcg/wasm/tcg-target.c.inc     | 286 ++++++++++++++++++++++++++++++++++
 9 files changed, 411 insertions(+), 6 deletions(-)
 create mode 100644 tcg/wasm/tcg-target-mo.h

V2:
- This commit generates both Wasm and TCI instrucitons.
- Although checkpatch.pl reports an error "line over 90 characters" in
  scripts/meson-buildoptions.sh, the changes were automatically generated by
  meson-buildoptions.py and are preserved as-is.

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 77ae8f8281..a97bb89714 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -812,4 +812,4 @@ build-wasm64-32bit:
     job: wasm64-32bit-emsdk-cross-container
   variables:
     IMAGE: emsdk-wasm64-32bit-cross
-    CONFIGURE_ARGS: --static --cpu=wasm64 --wasm64-32bit-address-limit --disable-tools --enable-debug --enable-tcg-interpreter
+    CONFIGURE_ARGS: --static --cpu=wasm64 --enable-wasm64-32bit-address-limit --disable-tools --enable-debug --enable-tcg-interpreter
diff --git a/configure b/configure
index 8ac6cacc06..77365e2509 100755
--- a/configure
+++ b/configure
@@ -243,7 +243,9 @@ for opt do
   ;;
   --without-default-features) default_feature="no"
   ;;
-  --wasm64-32bit-address-limit) wasm64_memory64="2"
+  --enable-wasm64-32bit-address-limit) wasm64_memory64="2"
+  ;;
+  --disable-wasm64-32bit-address-limit) wasm64_memory64="1"
   ;;
   esac
 done
@@ -801,8 +803,6 @@ for opt do
   ;;
   --disable-rust) rust=disabled
   ;;
-  --wasm64-32bit-address-limit)
-  ;;
   # everything else has the same name in configure and meson
   --*) meson_option_parse "$opt" "$optarg"
   ;;
@@ -928,8 +928,6 @@ Advanced options (experts only):
   --disable-containers     don't use containers for cross-building
   --container-engine=TYPE  which container engine to use [$container_engine]
   --gdb=GDB-path           gdb to use for gdbstub tests [$gdb_bin]
-  --wasm64-32bit-address-limit Restrict wasm64 address space to 32-bit (default
-                               is to use the whole 64-bit range).
 EOF
   meson_options_help
 cat << EOF
diff --git a/meson.build b/meson.build
index 44bb7ed334..5b048ea70f 100644
--- a/meson.build
+++ b/meson.build
@@ -393,6 +393,10 @@ elif host_os == 'windows'
   if compiler.get_id() == 'clang' and compiler.get_linker_id() != 'ld.lld'
     error('On windows, you need to use lld with clang - use msys2 clang64/clangarm64 env')
   endif
+elif host_os == 'emscripten'
+  if cpu == 'wasm64' and get_option('wasm64_32bit_address_limit')
+    qemu_common_flags += '-DWASM64_MEMORY64_2'
+  endif
 endif
 
 # Choose instruction set (currently x86-only)
diff --git a/meson_options.txt b/meson_options.txt
index fff1521e58..82771340ba 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -386,3 +386,6 @@ option('rust', type: 'feature', value: 'disabled',
        description: 'Rust support')
 option('strict_rust_lints', type: 'boolean', value: false,
        description: 'Enable stricter set of Rust warnings')
+
+option('wasm64_32bit_address_limit', type: 'boolean', value: false,
+       description: 'Restrict wasm64 address space to 32-bit (default is to use the whole 64-bit range).')
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 0ebe6bc52a..64845aa0b9 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -56,6 +56,9 @@ meson_options_help() {
   printf "%s\n" '                           dtrace/ftrace/log/nop/simple/syslog/ust)'
   printf "%s\n" '  --enable-tsan            enable thread sanitizer'
   printf "%s\n" '  --enable-ubsan           enable undefined behaviour sanitizer'
+  printf "%s\n" '  --enable-wasm64-32bit-address-limit'
+  printf "%s\n" '                           Restrict wasm64 address space to 32-bit (default'
+  printf "%s\n" '                           is to use the whole 64-bit range).'
   printf "%s\n" '  --firmwarepath=VALUES    search PATH for firmware files [share/qemu-'
   printf "%s\n" '                           firmware]'
   printf "%s\n" '  --iasl=VALUE             Path to ACPI disassembler'
@@ -571,6 +574,8 @@ _meson_option_parse() {
     --disable-vte) printf "%s" -Dvte=disabled ;;
     --enable-vvfat) printf "%s" -Dvvfat=enabled ;;
     --disable-vvfat) printf "%s" -Dvvfat=disabled ;;
+    --enable-wasm64-32bit-address-limit) printf "%s" -Dwasm64_32bit_address_limit=true ;;
+    --disable-wasm64-32bit-address-limit) printf "%s" -Dwasm64_32bit_address_limit=false ;;
     --enable-werror) printf "%s" -Dwerror=true ;;
     --disable-werror) printf "%s" -Dwerror=false ;;
     --enable-whpx) printf "%s" -Dwhpx=enabled ;;
diff --git a/tcg/wasm.c b/tcg/wasm.c
index 183dad10a2..fa7413fc1d 100644
--- a/tcg/wasm.c
+++ b/tcg/wasm.c
@@ -20,6 +20,14 @@
 
 #include "qemu/osdep.h"
 #include "tcg/tcg.h"
+#include "tcg/tcg-ldst.h"
+
+static void tci_args_rl(uint32_t insn, const void *tb_ptr,
+                        TCGReg *r0, void **l1)
+{
+    *r0 = extract32(insn, 8, 4);
+    *l1 = sextract32(insn, 12, 20) + (void *)tb_ptr;
+}
 
 static void tci_args_rr(uint32_t insn, TCGReg *r0, TCGReg *r1)
 {
@@ -27,6 +35,12 @@ static void tci_args_rr(uint32_t insn, TCGReg *r0, TCGReg *r1)
     *r1 = extract32(insn, 12, 4);
 }
 
+static void tci_args_ri(uint32_t insn, TCGReg *r0, tcg_target_ulong *i1)
+{
+    *r0 = extract32(insn, 8, 4);
+    *i1 = sextract32(insn, 12, 20);
+}
+
 static void tci_args_rrr(uint32_t insn, TCGReg *r0, TCGReg *r1, TCGReg *r2)
 {
     *r0 = extract32(insn, 8, 4);
@@ -34,6 +48,13 @@ static void tci_args_rrr(uint32_t insn, TCGReg *r0, TCGReg *r1, TCGReg *r2)
     *r2 = extract32(insn, 16, 4);
 }
 
+static void tci_args_rrs(uint32_t insn, TCGReg *r0, TCGReg *r1, int32_t *i2)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *i2 = sextract32(insn, 16, 16);
+}
+
 static void tci_args_rrbb(uint32_t insn, TCGReg *r0, TCGReg *r1,
                           uint8_t *i2, uint8_t *i3)
 {
@@ -161,9 +182,12 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
         uint32_t insn;
         TCGOpcode opc;
         TCGReg r0, r1, r2, r3, r4;
+        tcg_target_ulong t1;
         uint8_t pos, len;
         TCGCond condition;
         uint32_t tmp32;
+        int32_t ofs;
+        void *ptr;
 
         insn = *tb_ptr++;
         opc = extract32(insn, 0, 8);
@@ -236,6 +260,69 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
             tmp32 = tci_compare32(regs[r1], regs[r2], condition);
             regs[r0] = regs[tmp32 ? r3 : r4];
             break;
+        case INDEX_op_tci_movi:
+            tci_args_ri(insn, &r0, &t1);
+            regs[r0] = t1;
+            break;
+        case INDEX_op_tci_movl:
+            tci_args_rl(insn, tb_ptr, &r0, &ptr);
+            regs[r0] = *(tcg_target_ulong *)ptr;
+            break;
+        case INDEX_op_ld:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            regs[r0] = *(tcg_target_ulong *)ptr;
+            break;
+        case INDEX_op_ld8u:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            regs[r0] = *(uint8_t *)ptr;
+            break;
+        case INDEX_op_ld8s:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            regs[r0] = *(int8_t *)ptr;
+            break;
+        case INDEX_op_ld16u:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            regs[r0] = *(uint16_t *)ptr;
+            break;
+        case INDEX_op_ld16s:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            regs[r0] = *(int16_t *)ptr;
+            break;
+        case INDEX_op_st:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            *(tcg_target_ulong *)ptr = regs[r0];
+            break;
+        case INDEX_op_st8:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            *(uint8_t *)ptr = regs[r0];
+            break;
+        case INDEX_op_st16:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            *(uint16_t *)ptr = regs[r0];
+            break;
+        case INDEX_op_ld32u:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            regs[r0] = *(uint32_t *)ptr;
+            break;
+        case INDEX_op_ld32s:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            regs[r0] = *(int32_t *)ptr;
+            break;
+        case INDEX_op_st32:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            *(uint32_t *)ptr = regs[r0];
+            break;
         default:
             g_assert_not_reached();
         }
diff --git a/tcg/wasm/tcg-target-mo.h b/tcg/wasm/tcg-target-mo.h
new file mode 100644
index 0000000000..525f702293
--- /dev/null
+++ b/tcg/wasm/tcg-target-mo.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific memory model
+ *
+ * Based on tci/tcg-target-mo.h
+ *
+ * Copyright (c) 2009, 2011 Stefan Weil
+ */
+
+#ifndef TCG_TARGET_MO_H
+#define TCG_TARGET_MO_H
+
+/*
+ * We could notice __i386__ or __s390x__ and reduce the barriers depending
+ * on the host.  But if you want performance, you use the normal backend.
+ * We prefer consistency across hosts on this.
+ */
+#define TCG_TARGET_DEFAULT_MO  0
+
+#endif
diff --git a/tcg/wasm/tcg-target-opc.h.inc b/tcg/wasm/tcg-target-opc.h.inc
index 57274d4569..122b45749a 100644
--- a/tcg/wasm/tcg-target-opc.h.inc
+++ b/tcg/wasm/tcg-target-opc.h.inc
@@ -4,5 +4,7 @@
  *
  * These opcodes for use between the tci generator and interpreter.
  */
+DEF(tci_movi, 1, 0, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_movl, 1, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_setcond32, 1, 2, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_movcond32, 1, 2, 1, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index dd75deecd3..6bab20a6a9 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -143,6 +143,18 @@ typedef enum {
     OPC_GLOBAL_GET = 0x23,
     OPC_GLOBAL_SET = 0x24,
 
+    OPC_I64_LOAD = 0x29,
+    OPC_I64_LOAD8_S = 0x30,
+    OPC_I64_LOAD8_U = 0x31,
+    OPC_I64_LOAD16_S = 0x32,
+    OPC_I64_LOAD16_U = 0x33,
+    OPC_I64_LOAD32_S = 0x34,
+    OPC_I64_LOAD32_U = 0x35,
+    OPC_I64_STORE = 0x37,
+    OPC_I64_STORE8 = 0x3c,
+    OPC_I64_STORE16 = 0x3d,
+    OPC_I64_STORE32 = 0x3e,
+
     OPC_I32_CONST = 0x41,
     OPC_I64_CONST = 0x42,
 
@@ -168,6 +180,7 @@ typedef enum {
     OPC_I64_GE_S = 0x59,
     OPC_I64_GE_U = 0x5a,
 
+    OPC_I32_ADD = 0x6a,
     OPC_I32_SHR_S = 0x75,
     OPC_I32_SHR_U = 0x76,
 
@@ -421,6 +434,84 @@ static void tcg_wasm_out_sextract(TCGContext *s, TCGReg dest, TCGReg arg1,
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(dest));
 }
 
+/*
+ * The size of the offset field of Wasm's load/store instruction defers
+ * depending on the "-sMEMORY64" flag value: 64bit when "-sMEMORY64=1"
+ * and 32bit when "-sMEMORY64=2".
+ */
+#if defined(WASM64_MEMORY64_2)
+typedef uint32_t wasm_ldst_offset_t;
+#else
+typedef uint64_t wasm_ldst_offset_t;
+#endif
+static void tcg_wasm_out_op_ldst(
+    TCGContext *s, WasmInsn instr, uint32_t a, wasm_ldst_offset_t o)
+{
+    tcg_wasm_out_op(s, instr);
+    tcg_wasm_out_leb128(s, a);
+    tcg_wasm_out_leb128(s, (wasm_ldst_offset_t)o);
+}
+
+/*
+ * tcg_wasm_out_norm_ptr emits instructions to adjust the 64bit pointer value
+ * at the top of the stack to satisfy Wasm's memory addressing requirements.
+ */
+static intptr_t tcg_wasm_out_norm_ptr(TCGContext *s, intptr_t offset)
+{
+#if defined(WASM64_MEMORY64_2)
+    /*
+     * If Emscripten's "-sMEMORY64=2" is enabled,
+     * the address size is limited to 32bit.
+     */
+    tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+#endif
+    /*
+     * Wasm's load/store instructions don't support negative value in
+     * the offset field. So this function calculates the target address
+     * using the base and the offset and makes the offset field 0.
+     */
+    if (offset < 0) {
+#if defined(WASM64_MEMORY64_2)
+        tcg_wasm_out_op_const(s, OPC_I32_CONST, offset);
+        tcg_wasm_out_op(s, OPC_I32_ADD);
+#else
+        tcg_wasm_out_op_const(s, OPC_I64_CONST, offset);
+        tcg_wasm_out_op(s, OPC_I64_ADD);
+#endif
+        offset = 0;
+    }
+    return offset;
+}
+
+static void tcg_wasm_out_ld(
+    TCGContext *s, WasmInsn opc, TCGReg val, TCGReg base, intptr_t offset)
+{
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(base));
+    offset = tcg_wasm_out_norm_ptr(s, offset);
+    tcg_wasm_out_op_ldst(s, opc, 0, offset);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(val));
+}
+
+static void tcg_wasm_out_st(
+    TCGContext *s, WasmInsn opc, TCGReg val, TCGReg base, intptr_t offset)
+{
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(base));
+    offset = tcg_wasm_out_norm_ptr(s, offset);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(val));
+    tcg_wasm_out_op_ldst(s, opc, 0, offset);
+}
+
+static void tcg_out_op_ri(TCGContext *s, TCGOpcode op, TCGReg r0, int32_t i1)
+{
+    tcg_insn_unit_tci insn = 0;
+
+    tcg_debug_assert(i1 == sextract32(i1, 0, 20));
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 20, i1);
+    tcg_out32(s, insn);
+}
+
 static void tcg_out_op_rr(TCGContext *s, TCGOpcode op, TCGReg r0, TCGReg r1)
 {
     tcg_insn_unit_tci insn = 0;
@@ -443,6 +534,19 @@ static void tcg_out_op_rrr(TCGContext *s, TCGOpcode op,
     tcg_out32(s, insn);
 }
 
+static void tcg_out_op_rrs(TCGContext *s, TCGOpcode op,
+                           TCGReg r0, TCGReg r1, intptr_t i2)
+{
+    tcg_insn_unit_tci insn = 0;
+
+    tcg_debug_assert(i2 == sextract32(i2, 0, 16));
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 16, i2);
+    tcg_out32(s, insn);
+}
+
 static void tcg_out_op_rrbb(TCGContext *s, TCGOpcode op, TCGReg r0,
                             TCGReg r1, uint8_t b2, uint8_t b3)
 {
@@ -669,6 +773,188 @@ static const TCGOutOpMovcond outop_movcond = {
     .out = tgen_movcond,
 };
 
+static void tcg_tci_out_movi(TCGContext *s, TCGType type,
+                             TCGReg ret, tcg_target_long arg)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        arg = (int32_t)arg;
+        /* fall through */
+    case TCG_TYPE_I64:
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (arg == sextract32(arg, 0, 20)) {
+        tcg_out_op_ri(s, INDEX_op_tci_movi, ret, arg);
+    } else {
+        tcg_insn_unit_tci insn = 0;
+
+        new_pool_label(s, arg, 20, s->code_ptr, 0);
+        insn = deposit32(insn, 0, 8, INDEX_op_tci_movl);
+        insn = deposit32(insn, 8, 4, ret);
+        tcg_out32(s, insn);
+    }
+}
+
+static void stack_bounds_check(TCGReg base, intptr_t offset)
+{
+    if (base == TCG_REG_CALL_STACK) {
+        tcg_debug_assert(offset >= 0);
+        tcg_debug_assert(offset < (TCG_STATIC_CALL_ARGS_SIZE +
+                                   TCG_STATIC_FRAME_SIZE));
+    }
+}
+
+static void tcg_out_ldst(TCGContext *s, TCGOpcode op, TCGReg val,
+                         TCGReg base, intptr_t offset)
+{
+    stack_bounds_check(base, offset);
+    if (offset != sextract32(offset, 0, 16)) {
+        tcg_tci_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP, offset);
+        tcg_out_op_rrr(s, INDEX_op_add, TCG_REG_TMP, TCG_REG_TMP, base);
+        base = TCG_REG_TMP;
+        offset = 0;
+    }
+    tcg_out_op_rrs(s, op, val, base, offset);
+}
+
+static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
+                       intptr_t offset)
+{
+    TCGOpcode op = INDEX_op_ld;
+    WasmInsn wasm_opc = OPC_I64_LOAD;
+
+    if (type == TCG_TYPE_I32) {
+        op = INDEX_op_ld32u;
+        wasm_opc = OPC_I64_LOAD32_U;
+    }
+    tcg_out_ldst(s, op, val, base, offset);
+    tcg_wasm_out_ld(s, wasm_opc, val, base, offset);
+}
+
+static void tgen_ld8u(TCGContext *s, TCGType type, TCGReg dest,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_ld8u, dest, base, offset);
+    tcg_wasm_out_ld(s, OPC_I64_LOAD8_U, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld8u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8u,
+};
+
+static void tgen_ld8s(TCGContext *s, TCGType type, TCGReg dest,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_ld8s, dest, base, offset);
+    tcg_wasm_out_ld(s, OPC_I64_LOAD8_S, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld8s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8s,
+};
+
+static void tgen_ld16u(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_ld16u, dest, base, offset);
+    tcg_wasm_out_ld(s, OPC_I64_LOAD16_U, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld16u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16u,
+};
+
+static void tgen_ld16s(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_ld16s, dest, base, offset);
+    tcg_wasm_out_ld(s, OPC_I64_LOAD16_S, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld16s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16s,
+};
+
+static void tgen_ld32u(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_ld32u, dest, base, offset);
+    tcg_wasm_out_ld(s, OPC_I64_LOAD32_U, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld32u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld32u,
+};
+
+static void tgen_ld32s(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_ld32s, dest, base, offset);
+    tcg_wasm_out_ld(s, OPC_I64_LOAD32_S, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld32s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld32s,
+};
+
+static void tgen_st8(TCGContext *s, TCGType type, TCGReg data,
+                     TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_st8, data, base, offset);
+    tcg_wasm_out_st(s, OPC_I64_STORE8, data, base, offset);
+}
+
+static const TCGOutOpStore outop_st8 = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out_r = tgen_st8,
+};
+
+static void tgen_st16(TCGContext *s, TCGType type, TCGReg data,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_st16, data, base, offset);
+    tcg_wasm_out_st(s, OPC_I64_STORE16, data, base, offset);
+}
+
+static const TCGOutOpStore outop_st16 = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out_r = tgen_st16,
+};
+
+static void tcg_out_st(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
+                       intptr_t offset)
+{
+    TCGOpcode op = INDEX_op_st;
+    WasmInsn wasm_opc = OPC_I64_STORE;
+
+    if (type == TCG_TYPE_I32) {
+        op = INDEX_op_st32;
+        wasm_opc = OPC_I64_STORE32;
+    }
+    tcg_out_ldst(s, op, val, base, offset);
+    tcg_wasm_out_st(s, wasm_opc, val, base, offset);
+}
+
+static const TCGOutOpStore outop_st = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out_r = tcg_out_st,
+};
+
+static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
+                               TCGReg base, intptr_t ofs)
+{
+    return false;
+}
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
-- 
2.43.0


