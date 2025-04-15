Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABC1C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mH3-0002lX-1h; Tue, 15 Apr 2025 15:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mDE-0004DB-SJ
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:44:54 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mCO-0000Es-80
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:44:52 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-523fa0df55dso6008e0c.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744746237; x=1745351037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3LmqZuFxtG12n8SC4iaqG3NkVLVYLVVy1QDpLVQlRQY=;
 b=D3EhPFozJGXLXgRp4R3bX3/WlSOeAGUgtAVVKTo3iYAi7w4EIPx/GrTL7VCtylQfUj
 JuWoBZ6CkU/fvWkdjRy5u9f+0tP0JVC4iKVOZ6jXPYLp0gWZEbTcrRrmtqHuXpKkgkdq
 YWPkXyoyUX/FM5LFCCJ/nnV5GEXCbxYrweDrlNyRcv4Hq1bVDibRQZyx0XWwaXpa8uPe
 lkAeS6/SgjIxiKw7pJ8gns6whoSAVEbbCWAPSDgEgdGxgEmRlo8NAHiINN5WjtZMLKFu
 H+MI0UbLgwYAlXzM6PKz1ZjOFZhGzpu8DAd9vpW03X/zAWJcK9x1Qu+i8NlPvm4Ygy7T
 Ovmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744746237; x=1745351037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3LmqZuFxtG12n8SC4iaqG3NkVLVYLVVy1QDpLVQlRQY=;
 b=F8euv8257ddJpWZsENJDNpqX6LuI6sjui95SM9/sUwCaogkge1p2IG0kPqLy9Z43tF
 t+cFlUmQahiwlRsPZs7BZIIQHPcZ28UHp/O8pXic57QgSf4YHZfD4xXXcj3fIms6sl+X
 WIMzHfI3mxMMVWl5rGlINXeeIrz6YJGHcNE0OkJ0RhrG4cb2NVGbgh2cUpduGpeKlg36
 efAsIQnUJk6ck36+4E7OyNo7SiaBnI/4RB1zCetgEegunPtX9W+77Ov7UC/dWSq1h0pj
 Du8tEFWxa097dtfWXCOPHCwm6DwiDHs8F8fsD07LyGERd4/nfBd15XCxPfntI8e2wnpu
 NIpQ==
X-Gm-Message-State: AOJu0YyoV7XuvQT/Zyop0zGTV9fOd+O4vb2p7cLVjjB2YPkLkEncWi8O
 +33ogOBFDw6EutyiDrwy7eFI+fa0OFrEdQlcm061TqAmDCR7Svjbz7wmOhZ5S2ckj/bMxOB/KDQ
 3
X-Gm-Gg: ASbGnctPFsruup0SpT5queN08xXTq1lWcjpQ8ALJjzK+1r0SUpoSLxUW3rm1RyDDDho
 cmxOlu7YkRf7pdw0ztUlYO5pgZUh1INJM85oC2D9wQUGTmAmOXseh7WtjZgvKo4/Axiy+kh+Wl3
 tSscp7Qx0suz+1+GvonjUzfF9/bn+lKArGfrLu8Ppj7s/MhLHPw3O2ZZat4ud4yTd8PDp6Cloh7
 yzD+9ZHN4WlAodphLlNQyX28dKZ5vPOmbFbs+rGBg5MF95B/lUILNyMoDuu7EEicxLzsE229w1k
 GDW/8v7BHbv0Vq8RCv7GJ1QvYBXxQNvsMF7dvlDUcC6gzvjgeRVB/vcGwi16d8005VsZrMLAc7L
 gMt3PQlDKJg==
X-Google-Smtp-Source: AGHT+IHy01Wv7uZCQ7meEHraB8hwjcpsGBOrO6qBAg2uaZgi8q4mAnWRZuw+X7My9bZUo+JAh8b6jQ==
X-Received: by 2002:a05:6a00:1897:b0:736:9f2e:1357 with SMTP id
 d2e1a72fcca58-73c1fb40a5fmr1104492b3a.12.1744745778901; 
 Tue, 15 Apr 2025 12:36:18 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 148/163] tcg/tci: Remove support for add2/sub2
Date: Tue, 15 Apr 2025 12:24:59 -0700
Message-ID: <20250415192515.232910-149-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-vk1-xa2a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci/tcg-target-has.h |  8 ++---
 tcg/tci.c                | 66 +++-------------------------------------
 tcg/tci/tcg-target.c.inc | 28 -----------------
 3 files changed, 9 insertions(+), 93 deletions(-)

diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 6063f32f7b..310d45ba62 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -8,13 +8,13 @@
 #define TCG_TARGET_HAS_H
 
 #define TCG_TARGET_HAS_qemu_st8_i32     0
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_add2_i32         0
+#define TCG_TARGET_HAS_sub2_i32         0
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
+#define TCG_TARGET_HAS_add2_i64         0
+#define TCG_TARGET_HAS_sub2_i64         0
 #endif /* TCG_TARGET_REG_BITS == 64 */
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/tci.c b/tcg/tci.c
index d65ff2b8f1..a18478a07a 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -179,17 +179,6 @@ static void tci_args_rrrrrc(uint32_t insn, TCGReg *r0, TCGReg *r1,
     *c5 = extract32(insn, 28, 4);
 }
 
-static void tci_args_rrrrrr(uint32_t insn, TCGReg *r0, TCGReg *r1,
-                            TCGReg *r2, TCGReg *r3, TCGReg *r4, TCGReg *r5)
-{
-    *r0 = extract32(insn, 8, 4);
-    *r1 = extract32(insn, 12, 4);
-    *r2 = extract32(insn, 16, 4);
-    *r3 = extract32(insn, 20, 4);
-    *r4 = extract32(insn, 24, 4);
-    *r5 = extract32(insn, 28, 4);
-}
-
 static bool tci_compare32(uint32_t u0, uint32_t u1, TCGCond condition)
 {
     bool result = false;
@@ -370,13 +359,12 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
     for (;;) {
         uint32_t insn;
         TCGOpcode opc;
-        TCGReg r0, r1, r2, r3, r4, r5;
+        TCGReg r0, r1, r2, r3, r4;
         tcg_target_ulong t1;
         TCGCond condition;
         uint8_t pos, len;
         uint32_t tmp32;
         uint64_t tmp64, taddr;
-        uint64_t T1, T2;
         MemOpIdx oi;
         int32_t ofs;
         void *ptr;
@@ -445,9 +433,9 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 #if TCG_TARGET_REG_BITS == 32
         case INDEX_op_setcond2_i32:
             tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &condition);
-            T1 = tci_uint64(regs[r2], regs[r1]);
-            T2 = tci_uint64(regs[r4], regs[r3]);
-            regs[r0] = tci_compare64(T1, T2, condition);
+            regs[r0] = tci_compare64(tci_uint64(regs[r2], regs[r1]),
+                                     tci_uint64(regs[r4], regs[r3]),
+                                     condition);
             break;
 #elif TCG_TARGET_REG_BITS == 64
         case INDEX_op_setcond:
@@ -717,22 +705,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
                 tb_ptr = ptr;
             }
             break;
-#if TCG_TARGET_REG_BITS == 32 || TCG_TARGET_HAS_add2_i32
-        case INDEX_op_add2_i32:
-            tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
-            T1 = tci_uint64(regs[r3], regs[r2]);
-            T2 = tci_uint64(regs[r5], regs[r4]);
-            tci_write_reg64(regs, r1, r0, T1 + T2);
-            break;
-#endif
-#if TCG_TARGET_REG_BITS == 32 || TCG_TARGET_HAS_sub2_i32
-        case INDEX_op_sub2_i32:
-            tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
-            T1 = tci_uint64(regs[r3], regs[r2]);
-            T2 = tci_uint64(regs[r5], regs[r4]);
-            tci_write_reg64(regs, r1, r0, T1 - T2);
-            break;
-#endif
         case INDEX_op_bswap16:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = bswap16(regs[r1]);
@@ -786,24 +758,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ? ctz64(regs[r1]) : regs[r2];
             break;
-#if TCG_TARGET_HAS_add2_i64
-        case INDEX_op_add2_i64:
-            tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
-            T1 = regs[r2] + regs[r4];
-            T2 = regs[r3] + regs[r5] + (T1 < regs[r2]);
-            regs[r0] = T1;
-            regs[r1] = T2;
-            break;
-#endif
-#if TCG_TARGET_HAS_add2_i64
-        case INDEX_op_sub2_i64:
-            tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
-            T1 = regs[r2] - regs[r4];
-            T2 = regs[r3] - regs[r5] - (regs[r2] < regs[r4]);
-            regs[r0] = T1;
-            regs[r1] = T2;
-            break;
-#endif
 
             /* Shift/rotate operations (64 bit). */
 
@@ -952,7 +906,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     const char *op_name;
     uint32_t insn;
     TCGOpcode op;
-    TCGReg r0, r1, r2, r3, r4, r5;
+    TCGReg r0, r1, r2, r3, r4;
     tcg_target_ulong i1;
     int32_t s2;
     TCGCond c;
@@ -1125,16 +1079,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            str_r(r2), str_r(r3));
         break;
 
-    case INDEX_op_add2_i32:
-    case INDEX_op_add2_i64:
-    case INDEX_op_sub2_i32:
-    case INDEX_op_sub2_i64:
-        tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
-        info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s, %s, %s",
-                           op_name, str_r(r0), str_r(r1), str_r(r2),
-                           str_r(r3), str_r(r4), str_r(r5));
-        break;
-
     case INDEX_op_qemu_ld_i64:
     case INDEX_op_qemu_st_i64:
         if (TCG_TARGET_REG_BITS == 32) {
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 947aa1aada..35c0c91f3e 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -66,12 +66,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_add2_i32:
-    case INDEX_op_add2_i64:
-    case INDEX_op_sub2_i32:
-    case INDEX_op_sub2_i64:
-        return C_O2_I4(r, r, r, r, r, r);
-
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, r);
     case INDEX_op_qemu_ld_i64:
@@ -346,22 +340,6 @@ static void tcg_out_op_rrrrrc(TCGContext *s, TCGOpcode op,
     tcg_out32(s, insn);
 }
 
-static void tcg_out_op_rrrrrr(TCGContext *s, TCGOpcode op,
-                              TCGReg r0, TCGReg r1, TCGReg r2,
-                              TCGReg r3, TCGReg r4, TCGReg r5)
-{
-    tcg_insn_unit insn = 0;
-
-    insn = deposit32(insn, 0, 8, op);
-    insn = deposit32(insn, 8, 4, r0);
-    insn = deposit32(insn, 12, 4, r1);
-    insn = deposit32(insn, 16, 4, r2);
-    insn = deposit32(insn, 20, 4, r3);
-    insn = deposit32(insn, 24, 4, r4);
-    insn = deposit32(insn, 28, 4, r5);
-    tcg_out32(s, insn);
-}
-
 static void tcg_out_ldst(TCGContext *s, TCGOpcode op, TCGReg val,
                          TCGReg base, intptr_t offset)
 {
@@ -1182,12 +1160,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, opc, args[0], args[1], args[2]);
         break;
 
-    CASE_32_64(add2)
-    CASE_32_64(sub2)
-        tcg_out_op_rrrrrr(s, opc, args[0], args[1], args[2],
-                          args[3], args[4], args[5]);
-        break;
-
     case INDEX_op_qemu_ld_i64:
     case INDEX_op_qemu_st_i64:
         if (TCG_TARGET_REG_BITS == 32) {
-- 
2.43.0


