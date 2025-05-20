Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79F2C54754
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMVp-0006sp-Iv; Tue, 20 May 2025 08:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMV7-0004pM-6P; Tue, 20 May 2025 08:55:22 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMV0-0001KC-GE; Tue, 20 May 2025 08:55:20 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-309fac646adso6373973a91.1; 
 Tue, 20 May 2025 05:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745711; x=1748350511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D01VAfUBGZHAoC2ddrbmO4/0n/qVM5JIZp6Wbld3EfA=;
 b=MKJ4jX+lQEFuVPvv0Pfqfyu8vD1PlZDeY2orP83QMxUcAOLB/ILmtC/UCv5vsbE1p5
 jZvo9sRNolnsW8bQ2zK/gsPuw604qGTBba8NQX1DRBX8MaSFlFabD5j3KQdQM780aRqP
 jqT6s20CtkwytkxNerMskSz5GWXH7JFf2ZUl3IJ8J9nxIVH/M5N/ap8oGoLmYDFKXY9/
 fTEdqgir5bbn1nqdkwePbBYZgF/51iczX7MVdlw4yTKNFPuwRJvLzZ9JivaQxniEnGmN
 1fvBIKwe724UIitOuFj+z8K9b9lSeSbTIPmsbyTjB+1avbLUtJsNNgPgrFwAH5t56/ip
 KDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745711; x=1748350511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D01VAfUBGZHAoC2ddrbmO4/0n/qVM5JIZp6Wbld3EfA=;
 b=IoJfd3E2MgYa0df5WMFVrq2QhnuHWd4KIPcOCWrOGBINLQ505xlGokco8LpfWLtAF5
 VvJUT+8ixSsTAcpjYUKw0D5MnYjZyVxg5zr+otRBDWmqarnQuQNavCt+R97tU5l2Sjr9
 vNdkzYC7b9ALl1ZmLyeQM2dTW8vIMTde2+kBQi0NWJ3dx39e+cpnR0ZHPWczdTnjuNtP
 4llR6sG3/8LeYVgI74oukaZsm3Ua+gYdGsIBSHfExAJrUV/WAQ1SaFxtibLm630tkNJE
 Pmh/N+kFZt5BdQnfw5iI2Bi/VvAXgCDKoikisP8TeUxwgKl94441nOnYbpM1eefAWRue
 7ibw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7slssh2s+Psbea2BZL/gv3D6PduFCMBFMfmQxCdaFDIQl/COxy15tK795wnW0nA3L0SNfguJtxg==@nongnu.org,
 AJvYcCX9mNnoM41mtBaBwnqrhET5qPiv9F3OJC5jx2Htpf5ME12zSPsVgmv18p6V0ScIkyEDv+IvhdIgTtqR0Q==@nongnu.org
X-Gm-Message-State: AOJu0YxJ3ZcdAcF87PuuZl1FaL02FL1JNv2Tv5cUVK57W6Ysvs6NcTPu
 njVSKjRpcx5lL2SbbyWCDoQDZo5G2QZbkQDH8rJpJ9yMPtQD2EyH7pFZcftOuX5F
X-Gm-Gg: ASbGncuQQqwj7vdSofWr3NgADb3fNy5M8vSwRJMYkodr29Kifz8uZnEgC8rSDzxppTu
 kC/2knoJLelFs9qv/5jz/zDSy45ITyg2FsvyHBUwO+OjUjM6w6UEuCGzVD8x9VdF/u76LDD31aw
 t1SaX9Dbplb5gTfJfGUceeeWjHA7K20ZzZcB0z8ljJTcTEBfUujTzm3Jx68F4FAcRkY+xSMluel
 jT1hI/9CbMJHhD/i5Fh6S9NI/nS/Fo1SXYQdgSI2O+udkqU4sYIeiz2lNvR9Sg9XxHsxRotFcSP
 W6H1oHVWpQ5K5ZhaaxIZ2LNr3mAv6mC0ueWiAHx+lqxDYc+x+5k=
X-Google-Smtp-Source: AGHT+IGOMOt/FkM/rdBI6wkt/aJrDNn9TYfU+or40zKKV8LX/mutFAggKceozq56SFUpc/Yq4TPZPg==
X-Received: by 2002:a17:90b:3d86:b0:2fa:17e4:b1cf with SMTP id
 98e67ed59e1d1-30e7dc1e956mr27665623a91.2.1747745711292; 
 Tue, 20 May 2025 05:55:11 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:55:10 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 31/33] tcg/wasm32: Enable TLB lookup
Date: Tue, 20 May 2025 21:51:33 +0900
Message-ID: <746962847ecb7947fa9315342d9ea953ad849607.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1032.google.com
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

This commit enables qemu_ld and qemu_st to perform TLB lookups, following
the approach used in other backends such as RISC-V. Unlike other backends,
the Wasm backend cannot use ldst labels, as jumping to specific code
addresses (e.g. raddr) is not possible in Wasm. Instead, each TLB lookup is
followed by a if branch: if the lookup succeeds, the memory is accessed
directly; otherwise, a fallback helper function is invoked. Support for
MO_BSWAP is not yet implemented, so has_memory_bswap is set to false.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32/tcg-target.c.inc | 223 +++++++++++++++++++++++++++++++++++-
 1 file changed, 221 insertions(+), 2 deletions(-)

diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index f0c51a5d3d..a2815db6b5 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -3,8 +3,12 @@
  * Tiny Code Generator for QEMU
  *
  * Copyright (c) 2009, 2011 Stefan Weil
+ * Copyright (c) 2018 SiFive, Inc
+ * Copyright (c) 2008-2009 Arnaud Patard <arnaud.patard@rtp-net.org>
+ * Copyright (c) 2009 Aurelien Jarno <aurelien@aurel32.net>
+ * Copyright (c) 2008 Fabrice Bellard
  *
- * Based on tci/tcg-target.c.inc
+ * Based on tci/tcg-target.c.inc and riscv/tcg-target.c.inc
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -364,6 +368,10 @@ static void tcg_wasm_out_op_i64_eqz(TCGContext *s)
 {
     tcg_wasm_out8(s, 0x50);
 }
+static void tcg_wasm_out_op_i64_eq(TCGContext *s)
+{
+    tcg_wasm_out8(s, 0x51);
+}
 static void tcg_wasm_out_op_br(TCGContext *s, int i)
 {
     tcg_wasm_out8(s, 0x0c);
@@ -436,6 +444,10 @@ static void tcg_wasm_out_op_local_set(TCGContext *s, uint8_t i)
 {
     tcg_wasm_out_op_var(s, 0x21, i);
 }
+static void tcg_wasm_out_op_local_tee(TCGContext *s, uint8_t i)
+{
+    tcg_wasm_out_op_var(s, 0x22, i);
+}
 
 #define tcg_wasm_out_i64_calc(op)                                       \
     static void tcg_wasm_out_i64_calc_##op(                             \
@@ -1993,12 +2005,161 @@ static void *qemu_ld_helper_ptr(uint32_t oi)
     }
 }
 
+static void tcg_wasm_out_i32_load_s(TCGContext *s, int off)
+{
+    if (off < 0) {
+        tcg_wasm_out_op_i32_const(s, off);
+        tcg_wasm_out_op_i32_add(s);
+        off = 0;
+    }
+    tcg_wasm_out_op_i32_load(s, 0, off);
+}
+
+static void tcg_wasm_out_i64_load_s(TCGContext *s, int off)
+{
+    if (off < 0) {
+        tcg_wasm_out_op_i32_const(s, off);
+        tcg_wasm_out_op_i32_add(s);
+        off = 0;
+    }
+    tcg_wasm_out_op_i64_load(s, 0, off);
+}
+
+#define MIN_TLB_MASK_TABLE_OFS INT_MIN
+
+static uint8_t prepare_host_addr_wasm(TCGContext *s, uint8_t *hit_var,
+                                      TCGReg addr_reg, MemOpIdx oi,
+                                      bool is_ld)
+{
+    MemOp opc = get_memop(oi);
+    TCGAtomAlign aa;
+    unsigned a_mask;
+    unsigned s_bits = opc & MO_SIZE;
+    unsigned s_mask = (1u << s_bits) - 1;
+    int mem_index = get_mmuidx(oi);
+    int fast_ofs = tlb_mask_table_ofs(s, mem_index);
+    int mask_ofs = fast_ofs + offsetof(CPUTLBDescFast, mask);
+    int table_ofs = fast_ofs + offsetof(CPUTLBDescFast, table);
+    int add_off = offsetof(CPUTLBEntry, addend);
+    tcg_target_long compare_mask;
+
+    if (!tcg_use_softmmu) {
+        g_assert_not_reached();
+    }
+
+    *hit_var = TMP64_LOCAL_0_IDX;
+    tcg_wasm_out_op_i64_const(s, 0);
+    tcg_wasm_out_op_local_set(s, *hit_var);
+
+    aa = atom_and_align_for_opc(s, opc, MO_ATOM_IFALIGN, false);
+    a_mask = (1u << aa.align) - 1;
+
+    /* Get the CPUTLBEntry offset */
+    tcg_wasm_out_op_global_get_r(s, addr_reg);
+    tcg_wasm_out_op_i64_const(s, s->page_bits - CPU_TLB_ENTRY_BITS);
+    tcg_wasm_out_op_i64_shr_u(s);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_global_get_r_i32(s, TCG_AREG0);
+    tcg_wasm_out_i32_load_s(s, mask_ofs);
+    tcg_wasm_out_op_i32_and(s);
+
+    /* Get the pointer to the target CPUTLBEntry */
+    tcg_wasm_out_op_global_get_r_i32(s, TCG_AREG0);
+    tcg_wasm_out_i32_load_s(s, table_ofs);
+    tcg_wasm_out_op_i32_add(s);
+    tcg_wasm_out_op_local_tee(s, TMP32_LOCAL_0_IDX);
+
+    /* Load the tlb copmarator */
+    tcg_wasm_out_i64_load_s(
+        s, is_ld ? offsetof(CPUTLBEntry, addr_read)
+        : offsetof(CPUTLBEntry, addr_write));
+
+    /*
+     * For aligned accesses, we check the first byte and include the
+     * alignment bits within the address.  For unaligned access, we
+     * check that we don't cross pages using the address of the last
+     * byte of the access.
+     */
+    tcg_wasm_out_op_global_get_r(s, addr_reg);
+    if (a_mask < s_mask) {
+        tcg_wasm_out_op_i64_const(s, s_mask - a_mask);
+        tcg_wasm_out_op_i64_add(s);
+    }
+    compare_mask = (uint64_t)s->page_mask | a_mask;
+    tcg_wasm_out_op_i64_const(s, compare_mask);
+    tcg_wasm_out_op_i64_and(s);
+
+    /* Compare masked address with the TLB entry. */
+    tcg_wasm_out_op_i64_eq(s);
+    tcg_wasm_out_op_if_noret(s);
+
+    /* TLB Hit - translate address using addend.  */
+    tcg_wasm_out_op_local_get(s, TMP32_LOCAL_0_IDX);
+    tcg_wasm_out_i32_load_s(s, add_off);
+    tcg_wasm_out_op_global_get_r(s, addr_reg);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_i32_add(s);
+    tcg_wasm_out_op_local_set(s, TMP32_LOCAL_1_IDX);
+    tcg_wasm_out_op_i64_const(s, 1);
+    tcg_wasm_out_op_local_set(s, *hit_var);
+
+    tcg_wasm_out_op_end(s);
+
+    return TMP32_LOCAL_1_IDX;
+}
+
+static void tcg_wasm_out_qemu_ld_direct(
+    TCGContext *s, TCGReg r, uint8_t base, MemOp opc)
+{
+    switch (opc & (MO_SSIZE)) {
+    case MO_UB:
+        tcg_wasm_out_op_local_get(s, base);
+        tcg_wasm_out_op_i64_load8_u(s, 0, 0);
+        tcg_wasm_out_op_global_set_r(s, r);
+        break;
+    case MO_SB:
+        tcg_wasm_out_op_local_get(s, base);
+        tcg_wasm_out_op_i64_load8_s(s, 0, 0);
+        tcg_wasm_out_op_global_set_r(s, r);
+        break;
+    case MO_UW:
+        tcg_wasm_out_op_local_get(s, base);
+        tcg_wasm_out_op_i64_load16_u(s, 0, 0);
+        tcg_wasm_out_op_global_set_r(s, r);
+        break;
+    case MO_SW:
+        tcg_wasm_out_op_local_get(s, base);
+        tcg_wasm_out_op_i64_load16_s(s, 0, 0);
+        tcg_wasm_out_op_global_set_r(s, r);
+        break;
+    case MO_UL:
+        tcg_wasm_out_op_local_get(s, base);
+        tcg_wasm_out_op_i64_load32_u(s, 0, 0);
+        tcg_wasm_out_op_global_set_r(s, r);
+        break;
+    case MO_SL:
+        tcg_wasm_out_op_local_get(s, base);
+        tcg_wasm_out_op_i64_load32_s(s, 0, 0);
+        tcg_wasm_out_op_global_set_r(s, r);
+        break;
+    case MO_UQ:
+        tcg_wasm_out_op_local_get(s, base);
+        tcg_wasm_out_op_i64_load(s, 0, 0);
+        tcg_wasm_out_op_global_set_r(s, r);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void tcg_wasm_out_qemu_ld(TCGContext *s, TCGReg data_reg,
                                  TCGReg addr_reg, MemOpIdx oi)
 {
     int helper_idx;
     int func_idx;
     bool addr64 = s->addr_type == TCG_TYPE_I64;
+    MemOp mop = get_memop(oi);
+    uint8_t base_var, hit_var;
 
     helper_idx = (uint32_t)qemu_ld_helper_ptr(oi);
     func_idx = get_helper_idx(s, helper_idx);
@@ -2012,6 +2173,14 @@ static void tcg_wasm_out_qemu_ld(TCGContext *s, TCGReg data_reg,
         addr_reg = TCG_REG_TMP;
     }
 
+    base_var = prepare_host_addr_wasm(s, &hit_var, addr_reg, oi, true);
+    tcg_wasm_out_op_local_get(s, hit_var);
+    tcg_wasm_out_op_i64_const(s, 1);
+    tcg_wasm_out_op_i64_eq(s);
+    tcg_wasm_out_op_if_noret(s);
+    tcg_wasm_out_qemu_ld_direct(s, data_reg, base_var, mop); /* fast path */
+    tcg_wasm_out_op_end(s);
+
     /*
      * update the block index so that the possible rewinding will
      * skip this block
@@ -2020,6 +2189,10 @@ static void tcg_wasm_out_qemu_ld(TCGContext *s, TCGReg data_reg,
     tcg_wasm_out_op_global_set(s, BLOCK_PTR_IDX);
     tcg_wasm_out_new_block(s);
 
+    tcg_wasm_out_op_local_get(s, hit_var);
+    tcg_wasm_out_op_i64_eqz(s);
+    tcg_wasm_out_op_if_noret(s);
+
     /* call helper */
     tcg_wasm_out_op_global_get_r(s, TCG_AREG0);
     tcg_wasm_out_op_i32_wrap_i64(s);
@@ -2030,6 +2203,8 @@ static void tcg_wasm_out_qemu_ld(TCGContext *s, TCGReg data_reg,
     tcg_wasm_out_op_call(s, func_idx);
     tcg_wasm_out_op_global_set_r(s, data_reg);
     tcg_wasm_out_handle_unwinding(s);
+
+    tcg_wasm_out_op_end(s);
 }
 
 static void *qemu_st_helper_ptr(uint32_t oi)
@@ -2049,6 +2224,35 @@ static void *qemu_st_helper_ptr(uint32_t oi)
     }
 }
 
+static void tcg_wasm_out_qemu_st_direct(
+    TCGContext *s, TCGReg lo, uint8_t base, MemOp opc)
+{
+    switch (opc & (MO_SSIZE)) {
+    case MO_8:
+        tcg_wasm_out_op_local_get(s, base);
+        tcg_wasm_out_op_global_get_r(s, lo);
+        tcg_wasm_out_op_i64_store8(s, 0, 0);
+        break;
+    case MO_16:
+        tcg_wasm_out_op_local_get(s, base);
+        tcg_wasm_out_op_global_get_r(s, lo);
+        tcg_wasm_out_op_i64_store16(s, 0, 0);
+        break;
+    case MO_32:
+        tcg_wasm_out_op_local_get(s, base);
+        tcg_wasm_out_op_global_get_r(s, lo);
+        tcg_wasm_out_op_i64_store32(s, 0, 0);
+        break;
+    case MO_64:
+        tcg_wasm_out_op_local_get(s, base);
+        tcg_wasm_out_op_global_get_r(s, lo);
+        tcg_wasm_out_op_i64_store(s, 0, 0);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void tcg_wasm_out_qemu_st(TCGContext *s, TCGReg data_reg,
                                  TCGReg addr_reg, MemOpIdx oi)
 {
@@ -2056,6 +2260,7 @@ static void tcg_wasm_out_qemu_st(TCGContext *s, TCGReg data_reg,
     int func_idx;
     bool addr64 = s->addr_type == TCG_TYPE_I64;
     MemOp mop = get_memop(oi);
+    uint8_t base_var, hit_var;
 
     helper_idx = (uint32_t)qemu_st_helper_ptr(oi);
     func_idx = get_helper_idx(s, helper_idx);
@@ -2069,6 +2274,14 @@ static void tcg_wasm_out_qemu_st(TCGContext *s, TCGReg data_reg,
         addr_reg = TCG_REG_TMP;
     }
 
+    base_var = prepare_host_addr_wasm(s, &hit_var, addr_reg, oi, false);
+    tcg_wasm_out_op_local_get(s, hit_var);
+    tcg_wasm_out_op_i64_const(s, 1);
+    tcg_wasm_out_op_i64_eq(s);
+    tcg_wasm_out_op_if_noret(s);
+    tcg_wasm_out_qemu_st_direct(s, data_reg, base_var, mop); /* fast path */
+    tcg_wasm_out_op_end(s);
+
     /*
      * update the block index so that the possible rewinding will
      * skip this block
@@ -2077,6 +2290,10 @@ static void tcg_wasm_out_qemu_st(TCGContext *s, TCGReg data_reg,
     tcg_wasm_out_op_global_set(s, BLOCK_PTR_IDX);
     tcg_wasm_out_new_block(s);
 
+    tcg_wasm_out_op_local_get(s, hit_var);
+    tcg_wasm_out_op_i64_eqz(s);
+    tcg_wasm_out_op_if_noret(s);
+
     /* call helper */
     tcg_wasm_out_op_global_get_r(s, TCG_AREG0);
     tcg_wasm_out_op_i32_wrap_i64(s);
@@ -2095,6 +2312,8 @@ static void tcg_wasm_out_qemu_st(TCGContext *s, TCGReg data_reg,
 
     tcg_wasm_out_op_call(s, func_idx);
     tcg_wasm_out_handle_unwinding(s);
+
+    tcg_wasm_out_op_end(s);
 }
 
 static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
@@ -3752,7 +3971,7 @@ static int tcg_out_tb_end(TCGContext *s)
 
 bool tcg_target_has_memory_bswap(MemOp memop)
 {
-    return true;
+    return false;
 }
 
 static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
-- 
2.43.0


