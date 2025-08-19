Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF701CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoR0H-0006Fk-Dt; Tue, 19 Aug 2025 14:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR09-000618-It; Tue, 19 Aug 2025 14:24:06 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR06-0003tk-9D; Tue, 19 Aug 2025 14:24:05 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-32326e69f1dso5991102a91.3; 
 Tue, 19 Aug 2025 11:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627839; x=1756232639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gV7V9dWB/HkcHsbdYX7u5nmfU2D9G0qv0kcTVXJBfyE=;
 b=S2qfQAQtb9KR8YkQZamt290Stnrv7pvkLVlJTuGHv7OOcF7xxRL2gfaqyDrCWF5EN6
 RB9YcpoVZ/Y9v0wzhCOJQkTTyGYTJXfc6Pk0hfHtsSMoE4e8/eETnF9Tabhxc7SrBKq4
 0i8wUWhme+wPNStm01eFZk5rqs9g2BG3ucEdKnQmubeem3/OxiZ0w6DLnkJhcamDDV9C
 Bk5K9jOA04q7yP3ybX+Ji+IF75op894vGJLgWdBDfH7SsHGnUvH8WBnL+CtqnfpX3B1q
 +s+sRUGR6Qlw9rf+Ig4ghe/Lwr0ew8CMpFewp8BsG/rBHWX8cmIeCUBYAjpNNTsVaQHX
 ydCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627839; x=1756232639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gV7V9dWB/HkcHsbdYX7u5nmfU2D9G0qv0kcTVXJBfyE=;
 b=DTWOF4PgoFIbnSxoZvMTjKY+fijbFszZLAgrVbKTBApUiAFaaqH6rIcjF7MyGK+b/2
 CR9ZqBsmtVG7A97VSMb2bVskfbCzYJaeme/yxHjc/tUrgq5zxR2V162fgWGkQBtzpHyp
 fnj7nfyv6+nJ3p6ag5hwFrNG8a/sNO5bX3i0kBbg7gwQiq86srXzABdfN+pWOeASsBX4
 aebT9tfq+4TCZ3YUAE5oB5M64D56FsNPGw4+UVHPx1kTQfEnZQNPBpdCrmpKQ0attyi0
 Pn3nTRGa3g7/xwK5Gh+vq1czrUpdlMXcL9XO+yCszcm/sRpB1v/ft/ESfPPmHkJ6SJnR
 54VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+ywdz34iJKwn3WtPrQhltAccP0lUAj3gwLkHLQoj+LzgxDok5ZEwqmYfYDLudQ/+gkzOYJtc4Lw==@nongnu.org,
 AJvYcCXgydSInbLuKyxFyUGP0qh+qMUTqwOxMABwxvkGyHw+ByxjloFIVWGFl43uFdsws6c+2ss0uvkR8BEH7w==@nongnu.org
X-Gm-Message-State: AOJu0YwtHQL+oGZ/0iL06YH3KPi7tDHsDUfkbHx0KbagnUGLcctPdGRv
 XcP1jhdj63SNnJ/YfxqglU+dwDGgBmY7eJBouOj/vA0qoZC6z87aKisDNDqBPj61
X-Gm-Gg: ASbGncueYNP2D/mvMuRSqrRQAYHtpq/EWClQWFcbnJXm3Zg17XtGRRQMegBH8V/fLVy
 L7DPYKldr4n4C8OJZD4QOAFJs/6Tn3fTyGgba1Oho8JQJlr22k2sKWCkUUirwR6TXvQIMwu3lZ4
 OVFAV0LWC4IQwn1xCEeOA0pyJ2V/Im9JFxWFIV/KD3Kb9ajijDiHnHzbO376a1C4IUqMkkJtj7Q
 CVKGpFVVNTkD2dx5jOWdncznAbIFOmDc+7EGyTStpO7neLiVe8PtuWObLsIp8h5UuNQClpPRe97
 hNsS9tQKqYU2dZIl6HonqbijBN1Ncrzjf3dXN8KPJSMxROGSZ0CmipcVPAl9jskc53XV9jwQD2A
 3yJAQB0Ix8WAwe9bd5+TKAgZqPaXBNuF3qR/NRl1OFOM=
X-Google-Smtp-Source: AGHT+IFHVgk93sTkVZnRGsKD1u9m+QLZdANfoF1I5cm+bO+57vxHkLNidvt0MjpwxbR+xa8dexYrYQ==
X-Received: by 2002:a17:903:292:b0:242:c66f:9f75 with SMTP id
 d9443c01a7336-245e04fe6d0mr34958435ad.55.1755627839479; 
 Tue, 19 Aug 2025 11:23:59 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:23:58 -0700 (PDT)
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
Subject: [PATCH 15/35] tcg/wasm: Add load and store instructions
Date: Wed, 20 Aug 2025 03:21:44 +0900
Message-ID: <a3d07943f430773cb036e8bc8e8c0bccc951a8db.1755623521.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1034.google.com
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

This commit implements load and store operations using Wasm's memory
instructions. Since Wasm load and store instructions don't support negative
offsets, address calculations are performed separately before the memory
access.

When Emscripten's -sMEMORY64=2 is enabled, the address size must be
32bits. So this commit updates the build tools to propagate this flag to the
C code via the WASM64_MEMORY64_2 macro. In this case, the emitted code casts
pointers to 32bit before memory oprations.

Additionally, the declaration of "--wasm64-32bit-address-limit" flag has
been moved from the configure script to meson.build. So the flag name is
updated to "--enable-wasm64-32bit-address-limit" to follow Meson's naming
conventions.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 .gitlab-ci.d/buildtest.yml    |  2 +-
 configure                     |  8 ++-
 meson.build                   |  4 ++
 meson_options.txt             |  3 ++
 scripts/meson-buildoptions.sh |  5 ++
 tcg/wasm/tcg-target.c.inc     | 95 +++++++++++++++++++++++++++++++++++
 6 files changed, 111 insertions(+), 6 deletions(-)

V1:
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
index 0587577da9..da0b97027f 100755
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
index 263a72df61..5fee61a256 100644
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
index dd33530750..0d05109b84 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -388,3 +388,6 @@ option('rust', type: 'feature', value: 'disabled',
        description: 'Rust support')
 option('strict_rust_lints', type: 'boolean', value: false,
        description: 'Enable stricter set of Rust warnings')
+
+option('wasm64_32bit_address_limit', type: 'boolean', value: false,
+       description: 'Restrict wasm64 address space to 32-bit (default is to use the whole 64-bit range).')
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index d559e260ed..18faf9ca30 100644
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
@@ -576,6 +579,8 @@ _meson_option_parse() {
     --disable-vte) printf "%s" -Dvte=disabled ;;
     --enable-vvfat) printf "%s" -Dvvfat=enabled ;;
     --disable-vvfat) printf "%s" -Dvvfat=disabled ;;
+    --enable-wasm64-32bit-address-limit) printf "%s" -Dwasm64_32bit_address_limit=true ;;
+    --disable-wasm64-32bit-address-limit) printf "%s" -Dwasm64_32bit_address_limit=false ;;
     --enable-werror) printf "%s" -Dwerror=true ;;
     --disable-werror) printf "%s" -Dwerror=false ;;
     --enable-whpx) printf "%s" -Dwhpx=enabled ;;
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 6220b43f98..c7da6ae055 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -123,6 +123,20 @@ typedef enum {
     OPC_GLOBAL_GET = 0x23,
     OPC_GLOBAL_SET = 0x24,
 
+    OPC_I32_LOAD = 0x28,
+    OPC_I64_LOAD = 0x29,
+    OPC_I64_LOAD8_S = 0x30,
+    OPC_I64_LOAD8_U = 0x31,
+    OPC_I64_LOAD16_S = 0x32,
+    OPC_I64_LOAD16_U = 0x33,
+    OPC_I64_LOAD32_S = 0x34,
+    OPC_I64_LOAD32_U = 0x35,
+    OPC_I32_STORE = 0x36,
+    OPC_I64_STORE = 0x37,
+    OPC_I64_STORE8 = 0x3c,
+    OPC_I64_STORE16 = 0x3d,
+    OPC_I64_STORE32 = 0x3e,
+
     OPC_I32_CONST = 0x41,
     OPC_I64_CONST = 0x42,
 
@@ -148,6 +162,7 @@ typedef enum {
     OPC_I64_GE_S = 0x59,
     OPC_I64_GE_U = 0x5a,
 
+    OPC_I32_ADD = 0x6a,
     OPC_I32_SHL = 0x74,
     OPC_I32_SHR_S = 0x75,
     OPC_I32_SHR_U = 0x76,
@@ -283,6 +298,24 @@ static void tcg_wasm_out_op_not(TCGContext *s)
     tcg_wasm_out_op(s, OPC_I64_XOR);
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
 static void tcg_wasm_out_o1_i2(
     TCGContext *s, WasmInsn opc, TCGReg ret, TCGReg arg1, TCGReg arg2)
 {
@@ -313,6 +346,54 @@ static void tcg_wasm_out_o1_i2_type(
     }
 }
 
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
 static const struct {
     WasmInsn i32;
     WasmInsn i64;
@@ -677,11 +758,14 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
                        intptr_t offset)
 {
     TCGOpcode op = INDEX_op_ld;
+    WasmInsn wasm_opc = OPC_I64_LOAD;
 
     if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I32) {
         op = INDEX_op_ld32u;
+        wasm_opc = OPC_I64_LOAD32_U;
     }
     tcg_out_ldst(s, op, val, base, offset);
+    tcg_wasm_out_ld(s, wasm_opc, val, base, offset);
 }
 
 static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
@@ -1450,6 +1534,7 @@ static void tgen_ld8u(TCGContext *s, TCGType type, TCGReg dest,
                       TCGReg base, ptrdiff_t offset)
 {
     tcg_out_ldst(s, INDEX_op_ld8u, dest, base, offset);
+    tcg_wasm_out_ld(s, OPC_I64_LOAD8_U, dest, base, offset);
 }
 
 static const TCGOutOpLoad outop_ld8u = {
@@ -1461,6 +1546,7 @@ static void tgen_ld8s(TCGContext *s, TCGType type, TCGReg dest,
                       TCGReg base, ptrdiff_t offset)
 {
     tcg_out_ldst(s, INDEX_op_ld8s, dest, base, offset);
+    tcg_wasm_out_ld(s, OPC_I64_LOAD8_S, dest, base, offset);
 }
 
 static const TCGOutOpLoad outop_ld8s = {
@@ -1472,6 +1558,7 @@ static void tgen_ld16u(TCGContext *s, TCGType type, TCGReg dest,
                        TCGReg base, ptrdiff_t offset)
 {
     tcg_out_ldst(s, INDEX_op_ld16u, dest, base, offset);
+    tcg_wasm_out_ld(s, OPC_I64_LOAD16_U, dest, base, offset);
 }
 
 static const TCGOutOpLoad outop_ld16u = {
@@ -1483,6 +1570,7 @@ static void tgen_ld16s(TCGContext *s, TCGType type, TCGReg dest,
                        TCGReg base, ptrdiff_t offset)
 {
     tcg_out_ldst(s, INDEX_op_ld16s, dest, base, offset);
+    tcg_wasm_out_ld(s, OPC_I64_LOAD16_S, dest, base, offset);
 }
 
 static const TCGOutOpLoad outop_ld16s = {
@@ -1495,6 +1583,7 @@ static void tgen_ld32u(TCGContext *s, TCGType type, TCGReg dest,
                        TCGReg base, ptrdiff_t offset)
 {
     tcg_out_ldst(s, INDEX_op_ld32u, dest, base, offset);
+    tcg_wasm_out_ld(s, OPC_I64_LOAD32_U, dest, base, offset);
 }
 
 static const TCGOutOpLoad outop_ld32u = {
@@ -1506,6 +1595,7 @@ static void tgen_ld32s(TCGContext *s, TCGType type, TCGReg dest,
                        TCGReg base, ptrdiff_t offset)
 {
     tcg_out_ldst(s, INDEX_op_ld32s, dest, base, offset);
+    tcg_wasm_out_ld(s, OPC_I64_LOAD32_S, dest, base, offset);
 }
 
 static const TCGOutOpLoad outop_ld32s = {
@@ -1518,6 +1608,7 @@ static void tgen_st8(TCGContext *s, TCGType type, TCGReg data,
                      TCGReg base, ptrdiff_t offset)
 {
     tcg_out_ldst(s, INDEX_op_st8, data, base, offset);
+    tcg_wasm_out_st(s, OPC_I64_STORE8, data, base, offset);
 }
 
 static const TCGOutOpStore outop_st8 = {
@@ -1529,6 +1620,7 @@ static void tgen_st16(TCGContext *s, TCGType type, TCGReg data,
                       TCGReg base, ptrdiff_t offset)
 {
     tcg_out_ldst(s, INDEX_op_st16, data, base, offset);
+    tcg_wasm_out_st(s, OPC_I64_STORE16, data, base, offset);
 }
 
 static const TCGOutOpStore outop_st16 = {
@@ -1575,11 +1667,14 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
                        intptr_t offset)
 {
     TCGOpcode op = INDEX_op_st;
+    WasmInsn wasm_opc = OPC_I64_STORE;
 
     if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I32) {
         op = INDEX_op_st32;
+        wasm_opc = OPC_I64_STORE32;
     }
     tcg_out_ldst(s, op, val, base, offset);
+    tcg_wasm_out_st(s, wasm_opc, val, base, offset);
 }
 
 static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
-- 
2.43.0


