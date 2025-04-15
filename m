Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A741C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mHW-0003f7-Bd; Tue, 15 Apr 2025 15:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m9Z-0005fF-FD
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:41:32 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m8U-00062I-Kw
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:40:47 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso5492913b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745971; x=1745350771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=srG3cMapP21ofIvyaKFsAIidgszpeCTgpMFAYeb7uag=;
 b=nWBZPL1NWbkRpp8NqqvvhAk9EznE0qto6Bnx87gKAm+MhqstDvkINgxQUIzaG2/IPz
 v7qN9SWE1E0G4mdZQNEYxrAjhuciRMrsCrWEAIsmxQdQd56RK0sp93p/VaBhmd9cHDv8
 Lvq6xmLbd/d+vr2gJ9MYMVE0kdTgbFgt9oVB6EHgLCm+B08UmHjmdK469WV1qyMlNaPd
 X1iQY7zM/WpoaNNhA6MNAdWDJpF9hTYJbFeqsR4UK5GWfShVyJZWkNqBMtVg36HREEP5
 rGLW6YUoWYz1LksMmR2lxl2GkKzZHhk7Q6pZXk+YZ2gnaoHBKBaqtWAx826vEVqhp8Y4
 wf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745971; x=1745350771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=srG3cMapP21ofIvyaKFsAIidgszpeCTgpMFAYeb7uag=;
 b=o0FiZ586038cnuQRY10RaSKQGCbOX7MrGqC+H9fD4ko7WLj9NatUTCCTZMvN3gJdje
 MRrq7AAxA2Z0HviEKfxn0cHjZjWmZ86rEZf8Hx7Q21bvGbYx3ZJteBxxxwYrxDcm9YVH
 UxSZ69E/jbNeicjnKoWWKG3p0WYOrLRNQmLGV0bwmLJlGDlA+hENXodsrLMAnES0rGiv
 AWBvA9IdcM5DcWN0bSvKHhvQdunGUQbXcJPpW7bpeNoTKvrEl+ZgUZJ+w8XRjq5wEtgN
 OvYbH7HApXycPdlqqj7uYfJq4ARwpsBQpIqFirJH5khMyh77VID//0YyidxPXsr4zNc8
 s8cQ==
X-Gm-Message-State: AOJu0Yy4cRMsh2ZZqbXVRr6cdByHR9olDj60lzlLWTOj/DdXeRw68Epw
 UuNPxLmzhOHvgbj8q2nZQVwgPpExhE5r2YYKYwf564ZSfBhSPNrPIBzOtQkruwgHYu01DWphf5T
 w
X-Gm-Gg: ASbGncuaPsHSo9a+viBzd9Mp4S/ZlYBdieXw5L9FMowvWnHtKTqjclYTl7wiGJXsi5B
 z+5TdVVPE8cjJ6WDYeIBDHBZ4/Ya5D97TV4qJY8tyZxXhjOE6FvKfmTRznErI4Ba0//LkpbwKj/
 2VJDVHBLn1NU8CqxYJ1RaU0PasVsZBl3ejZDA/2Xrz3FhGzozSR2nbeyAgQykt+qwZRPJbl4Wex
 Kg0MBHLo8ieio2gFSicmqoNxs1+uAvU5b2Nvs0+2sEkpBgoDBIhrHJjV7DbDHpEzehIsvYejm6K
 +n8/7lRTyRwtW/CmWSBtP/K0f8wKzhMNs5VVAw7FNYQ/uy+n69AMbx5Jyn1cam5hF0aQYJU8r/Q
 =
X-Google-Smtp-Source: AGHT+IGBEqL/C29Mj5O1uCA7JUZNWB7TmN8FwWQthyvH6dU/26FNY0o2SCxUJAq19WhQfnySOF4DnA==
X-Received: by 2002:a05:6a00:44c4:b0:732:535d:bb55 with SMTP id
 d2e1a72fcca58-73c1f8c3beamr1074602b3a.4.1744745970549; 
 Tue, 15 Apr 2025 12:39:30 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd233553fsm9228554b3a.172.2025.04.15.12.39.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:39:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 162/163] tcg: Convert qemu_st{2} to TCGOutOpLdSt{2}
Date: Tue, 15 Apr 2025 12:25:13 -0700
Message-ID: <20250415192515.232910-163-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
 tcg/tcg.c                        | 12 ++++-
 tcg/aarch64/tcg-target.c.inc     | 45 ++++++++-----------
 tcg/arm/tcg-target.c.inc         | 61 ++++++++++++++++---------
 tcg/i386/tcg-target.c.inc        | 71 ++++++++++++++++-------------
 tcg/loongarch64/tcg-target.c.inc | 47 +++++++++----------
 tcg/mips/tcg-target.c.inc        | 77 +++++++++++++++++---------------
 tcg/ppc/tcg-target.c.inc         | 47 +++++++++++--------
 tcg/riscv/tcg-target.c.inc       | 34 ++++++--------
 tcg/s390x/tcg-target.c.inc       | 42 +++++++++--------
 tcg/sparc64/tcg-target.c.inc     | 42 ++++++-----------
 tcg/tci/tcg-target.c.inc         | 51 +++++++++++----------
 11 files changed, 271 insertions(+), 258 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index ac955223a5..823bcc6cfc 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1224,6 +1224,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_qemu_ld, TCGOutOpQemuLdSt, outop_qemu_ld),
     OUTOP(INDEX_op_qemu_ld2, TCGOutOpQemuLdSt2, outop_qemu_ld2),
+    OUTOP(INDEX_op_qemu_st, TCGOutOpQemuLdSt, outop_qemu_st),
+    OUTOP(INDEX_op_qemu_st2, TCGOutOpQemuLdSt2, outop_qemu_st2),
     OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
     OUTOP(INDEX_op_remu, TCGOutOpBinary, outop_remu),
     OUTOP(INDEX_op_rotl, TCGOutOpBinary, outop_rotl),
@@ -5813,15 +5815,21 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
     case INDEX_op_qemu_ld:
+    case INDEX_op_qemu_st:
         {
-            const TCGOutOpQemuLdSt *out = &outop_qemu_ld;
+            const TCGOutOpQemuLdSt *out =
+                container_of(all_outop[op->opc], TCGOutOpQemuLdSt, base);
+
             out->out(s, type, new_args[0], new_args[1], new_args[2]);
         }
         break;
 
     case INDEX_op_qemu_ld2:
+    case INDEX_op_qemu_st2:
         {
-            const TCGOutOpQemuLdSt2 *out = &outop_qemu_ld2;
+            const TCGOutOpQemuLdSt2 *out =
+                container_of(all_outop[op->opc], TCGOutOpQemuLdSt2, base);
+
             out->out(s, type, new_args[0], new_args[1],
                      new_args[2], new_args[3]);
         }
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 21b6ce1229..be1ca74bc4 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1827,8 +1827,8 @@ static const TCGOutOpQemuLdSt outop_qemu_ld = {
     .out = tgen_qemu_ld,
 };
 
-static void tcg_out_qemu_st(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
-                            MemOpIdx oi, TCGType data_type)
+static void tgen_qemu_st(TCGContext *s, TCGType data_type, TCGReg data_reg,
+                         TCGReg addr_reg, MemOpIdx oi)
 {
     TCGLabelQemuLdst *ldst;
     HostAddress h;
@@ -1843,6 +1843,11 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
     }
 }
 
+static const TCGOutOpQemuLdSt outop_qemu_st = {
+    .base.static_constraint = C_O0_I2(rz, r),
+    .out = tgen_qemu_st,
+};
+
 static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
                                    TCGReg addr_reg, MemOpIdx oi, bool is_ld)
 {
@@ -1956,6 +1961,17 @@ static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
     .out = tgen_qemu_ld2,
 };
 
+static void tgen_qemu_st2(TCGContext *s, TCGType type, TCGReg datalo,
+                          TCGReg datahi, TCGReg addr_reg, MemOpIdx oi)
+{
+    tcg_out_qemu_ldst_i128(s, datalo, datahi, addr_reg, oi, false);
+}
+
+static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
+    .base.static_constraint = C_O0_I3(rz, rz, r),
+    .out = tgen_qemu_st2,
+};
+
 static const tcg_insn_unit *tb_ret_addr;
 
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
@@ -2885,25 +2901,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    /* Hoist the loads of the most common arguments.  */
-    TCGArg a0 = args[0];
-    TCGArg a1 = args[1];
-    TCGArg a2 = args[2];
-
-    switch (opc) {
-    case INDEX_op_qemu_st:
-        tcg_out_qemu_st(s, a0, a1, a2, ext);
-        break;
-    case INDEX_op_qemu_st2:
-        tcg_out_qemu_ldst_i128(s, a0, a1, a2, args[3], false);
-        break;
-
-    case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
-    case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
-    case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    default:
-        g_assert_not_reached();
-    }
+    g_assert_not_reached();
 }
 
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
@@ -3350,11 +3348,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_st:
-        return C_O0_I2(rz, r);
-    case INDEX_op_qemu_st2:
-        return C_O0_I3(rz, rz, r);
-
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
     case INDEX_op_mul_vec:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 681ecc3d7a..014a441420 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1711,8 +1711,8 @@ static void tcg_out_qemu_st_direct(TCGContext *s, MemOp opc, TCGReg datalo,
     }
 }
 
-static void tcg_out_qemu_st(TCGContext *s, TCGReg datalo, TCGReg datahi,
-                            TCGReg addr, MemOpIdx oi, TCGType data_type)
+static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data,
+                         TCGReg addr, MemOpIdx oi)
 {
     MemOp opc = get_memop(oi);
     TCGLabelQemuLdst *ldst;
@@ -1720,7 +1720,37 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg datalo, TCGReg datahi,
 
     ldst = prepare_host_addr(s, &h, addr, oi, false);
     if (ldst) {
-        ldst->type = data_type;
+        ldst->type = type;
+        ldst->datalo_reg = data;
+        ldst->datahi_reg = -1;
+
+        h.cond = COND_EQ;
+        tcg_out_qemu_st_direct(s, opc, data, -1, h);
+
+        /* The conditional call is last, as we're going to return here. */
+        ldst->label_ptr[0] = s->code_ptr;
+        tcg_out_bl_imm(s, COND_NE, 0);
+        ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
+    } else {
+        tcg_out_qemu_st_direct(s, opc, data, -1, h);
+    }
+}
+
+static const TCGOutOpQemuLdSt outop_qemu_st = {
+    .base.static_constraint = C_O0_I2(q, q),
+    .out = tgen_qemu_st,
+};
+
+static void tgen_qemu_st2(TCGContext *s, TCGType type, TCGReg datalo,
+                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
+{
+    MemOp opc = get_memop(oi);
+    TCGLabelQemuLdst *ldst;
+    HostAddress h;
+
+    ldst = prepare_host_addr(s, &h, addr, oi, false);
+    if (ldst) {
+        ldst->type = type;
         ldst->datalo_reg = datalo;
         ldst->datahi_reg = datahi;
 
@@ -1736,6 +1766,11 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg datalo, TCGReg datahi,
     }
 }
 
+static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
+    .base.static_constraint = C_O0_I3(Q, p, q),
+    .out = tgen_qemu_st2,
+};
+
 static void tcg_out_epilogue(TCGContext *s);
 
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg)
@@ -2609,31 +2644,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    switch (opc) {
-    case INDEX_op_qemu_st:
-        tcg_out_qemu_st(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
-        break;
-    case INDEX_op_qemu_st2:
-        tcg_out_qemu_st(s, args[0], args[1], args[2], args[3], TCG_TYPE_I64);
-        break;
-
-    case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
-    case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
-    case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    default:
-        g_assert_not_reached();
-    }
+    g_assert_not_reached();
 }
 
 static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_st:
-        return C_O0_I2(q, q);
-    case INDEX_op_qemu_st2:
-        return C_O0_I3(Q, p, q);
-
     case INDEX_op_st_vec:
         return C_O0_I2(w, r);
     case INDEX_op_ld_vec:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 7ec06f57ee..7b78ab67f4 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2576,8 +2576,38 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
     }
 }
 
-static void tcg_out_qemu_st(TCGContext *s, TCGReg datalo, TCGReg datahi,
-                            TCGReg addr, MemOpIdx oi, TCGType data_type)
+static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data,
+                         TCGReg addr, MemOpIdx oi)
+{
+    TCGLabelQemuLdst *ldst;
+    HostAddress h;
+
+    ldst = prepare_host_addr(s, &h, addr, oi, false);
+    tcg_out_qemu_st_direct(s, data, -1, h, get_memop(oi));
+
+    if (ldst) {
+        ldst->type = type;
+        ldst->datalo_reg = data;
+        ldst->datahi_reg = -1;
+        ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
+    }
+}
+
+static TCGConstraintSetIndex cset_qemu_st(TCGType type, unsigned flags)
+{
+    return flags == MO_8 ? C_O0_I2(s, L) : C_O0_I2(L, L);
+}
+
+static const TCGOutOpQemuLdSt outop_qemu_st = {
+    .base.static_constraint =
+        TCG_TARGET_REG_BITS == 32 ? C_Dynamic : C_O0_I2(L, L),
+    .base.dynamic_constraint =
+        TCG_TARGET_REG_BITS == 32 ? cset_qemu_st : NULL,
+    .out = tgen_qemu_st,
+};
+
+static void tgen_qemu_st2(TCGContext *s, TCGType type, TCGReg datalo,
+                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
 {
     TCGLabelQemuLdst *ldst;
     HostAddress h;
@@ -2586,13 +2616,18 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg datalo, TCGReg datahi,
     tcg_out_qemu_st_direct(s, datalo, datahi, h, get_memop(oi));
 
     if (ldst) {
-        ldst->type = data_type;
+        ldst->type = type;
         ldst->datalo_reg = datalo;
         ldst->datahi_reg = datahi;
         ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
     }
 }
 
+static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
+    .base.static_constraint = C_O0_I3(L, L, L),
+    .out = tgen_qemu_st2,
+};
+
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
 {
     /* Reuse the zeroing that exists for goto_ptr.  */
@@ -3571,27 +3606,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    TCGArg a0, a1, a2;
-
-    /* Hoist the loads of the most common arguments.  */
-    a0 = args[0];
-    a1 = args[1];
-    a2 = args[2];
-
-    switch (opc) {
-    case INDEX_op_qemu_st:
-        tcg_out_qemu_st(s, a0, -1, a1, a2, type);
-        break;
-    case INDEX_op_qemu_st2:
-        tcg_out_qemu_st(s, a0, a1, a2, args[3], type);
-        break;
-
-    case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
-    case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
-    case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    default:
-        g_assert_not_reached();
-    }
+    g_assert_not_reached();
 }
 
 static int const umin_insn[4] = {
@@ -4139,14 +4154,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_st:
-        return (TCG_TARGET_REG_BITS == 32 && flags == MO_8
-                ? C_O0_I2(s, L)
-                : C_O0_I2(L, L));
-
-    case INDEX_op_qemu_st2:
-        return C_O0_I3(L, L, L);
-
     case INDEX_op_ld_vec:
     case INDEX_op_dupm_vec:
         return C_O1_I1(x, r);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index a1147a1cdc..49522dcd72 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1200,8 +1200,8 @@ static void tcg_out_qemu_st_indexed(TCGContext *s, MemOp opc,
     }
 }
 
-static void tcg_out_qemu_st(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
-                            MemOpIdx oi, TCGType data_type)
+static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data_reg,
+                         TCGReg addr_reg, MemOpIdx oi)
 {
     TCGLabelQemuLdst *ldst;
     HostAddress h;
@@ -1210,12 +1210,17 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
     tcg_out_qemu_st_indexed(s, get_memop(oi), data_reg, h);
 
     if (ldst) {
-        ldst->type = data_type;
+        ldst->type = type;
         ldst->datalo_reg = data_reg;
         ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
     }
 }
 
+static const TCGOutOpQemuLdSt outop_qemu_st = {
+    .base.static_constraint = C_O0_I2(rz, r),
+    .out = tgen_qemu_st,
+};
+
 static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg data_lo, TCGReg data_hi,
                                    TCGReg addr_reg, MemOpIdx oi, bool is_ld)
 {
@@ -1274,6 +1279,17 @@ static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
     .out = tgen_qemu_ld2,
 };
 
+static void tgen_qemu_st2(TCGContext *s, TCGType type, TCGReg datalo,
+                          TCGReg datahi, TCGReg addr_reg, MemOpIdx oi)
+{
+    tcg_out_qemu_ldst_i128(s, datalo, datahi, addr_reg, oi, false);
+}
+
+static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
+    .base.static_constraint = C_O0_I3(r, r, r),
+    .out = tgen_qemu_st2,
+};
+
 /*
  * Entry-points
  */
@@ -2018,25 +2034,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    TCGArg a0 = args[0];
-    TCGArg a1 = args[1];
-    TCGArg a2 = args[2];
-    TCGArg a3 = args[3];
-
-    switch (opc) {
-    case INDEX_op_qemu_st:
-        tcg_out_qemu_st(s, a0, a1, a2, type);
-        break;
-    case INDEX_op_qemu_st2:
-        tcg_out_qemu_ldst_i128(s, a0, a1, a2, a3, false);
-        break;
-
-    case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
-    case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
-    case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    default:
-        g_assert_not_reached();
-    }
+    g_assert_not_reached();
 }
 
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
@@ -2539,11 +2537,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_st:
-        return C_O0_I2(rz, r);
-    case INDEX_op_qemu_st2:
-        return C_O0_I3(r, r, r);
-
     case INDEX_op_ld_vec:
     case INDEX_op_dupm_vec:
     case INDEX_op_dup_vec:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 14bffcd404..1f12500344 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1510,8 +1510,8 @@ static void tcg_out_qemu_st_unalign(TCGContext *s, TCGReg lo, TCGReg hi,
     }
 }
 
-static void tcg_out_qemu_st(TCGContext *s, TCGReg datalo, TCGReg datahi,
-                            TCGReg addr, MemOpIdx oi, TCGType data_type)
+static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data,
+                         TCGReg addr, MemOpIdx oi)
 {
     MemOp opc = get_memop(oi);
     TCGLabelQemuLdst *ldst;
@@ -1519,6 +1519,35 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg datalo, TCGReg datahi,
 
     ldst = prepare_host_addr(s, &h, addr, oi, false);
 
+    if (use_mips32r6_instructions || h.aa.align >= (opc & MO_SIZE)) {
+        tcg_out_qemu_st_direct(s, data, 0, h.base, opc);
+    } else {
+        tcg_out_qemu_st_unalign(s, data, 0, h.base, opc);
+    }
+
+    if (ldst) {
+        ldst->type = type;
+        ldst->datalo_reg = data;
+        ldst->datahi_reg = 0;
+        ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
+    }
+}
+
+static const TCGOutOpQemuLdSt outop_qemu_st = {
+    .base.static_constraint = C_O0_I2(rz, r),
+    .out = tgen_qemu_st,
+};
+
+static void tgen_qemu_st2(TCGContext *s, TCGType type, TCGReg datalo,
+                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
+{
+    MemOp opc = get_memop(oi);
+    TCGLabelQemuLdst *ldst;
+    HostAddress h;
+
+    tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
+    ldst = prepare_host_addr(s, &h, addr, oi, false);
+
     if (use_mips32r6_instructions || h.aa.align >= (opc & MO_SIZE)) {
         tcg_out_qemu_st_direct(s, datalo, datahi, h.base, opc);
     } else {
@@ -1526,13 +1555,21 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg datalo, TCGReg datahi,
     }
 
     if (ldst) {
-        ldst->type = data_type;
+        ldst->type = type;
         ldst->datalo_reg = datalo;
         ldst->datahi_reg = datahi;
         ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
     }
 }
 
+static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
+    /* Ensure that the mips32 code is compiled but discarded for mips64. */
+    .base.static_constraint =
+        TCG_TARGET_REG_BITS == 32 ? C_O0_I3(rz, rz, r) : C_NotImplemented,
+    .out =
+        TCG_TARGET_REG_BITS == 32 ? tgen_qemu_st2 : NULL,
+};
+
 static void tcg_out_mb(TCGContext *s, unsigned a0)
 {
     static const MIPSInsn sync[] = {
@@ -2411,43 +2448,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    TCGArg a0, a1, a2;
-
-    a0 = args[0];
-    a1 = args[1];
-    a2 = args[2];
-
-    switch (opc) {
-    case INDEX_op_qemu_st:
-        tcg_out_qemu_st(s, a0, 0, a1, a2, type);
-        break;
-    case INDEX_op_qemu_st2:
-        tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
-        tcg_out_qemu_st(s, a0, a1, a2, args[3], type);
-        break;
-
-    case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
-    case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
-    case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    default:
-        g_assert_not_reached();
-    }
+    g_assert_not_reached();
 }
 
 static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
-    switch (op) {
-    case INDEX_op_qemu_st:
-        return C_O0_I2(rz, r);
-    case INDEX_op_qemu_ld2:
-        return TCG_TARGET_REG_BITS == 64 ? C_NotImplemented : C_O2_I1(r, r, r);
-    case INDEX_op_qemu_st2:
-        return TCG_TARGET_REG_BITS == 64 ? C_NotImplemented : C_O0_I3(rz, rz, r);
-
-    default:
-        return C_NotImplemented;
-    }
+    return C_NotImplemented;
 }
 
 static const int tcg_target_callee_save_regs[] = {
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index e4e6b7b2d9..824cced94a 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2722,6 +2722,33 @@ static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
     .out = tgen_qemu_ld2,
 };
 
+static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data,
+                         TCGReg addr, MemOpIdx oi)
+{
+    tcg_out_qemu_st(s, data, -1, addr, oi, type);
+}
+
+static const TCGOutOpQemuLdSt outop_qemu_st = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out = tgen_qemu_st,
+};
+
+static void tgen_qemu_st2(TCGContext *s, TCGType type, TCGReg datalo,
+                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
+{
+    if (TCG_TARGET_REG_BITS == 32) {
+        tcg_out_qemu_st(s, datalo, datahi, addr, oi, type);
+    } else {
+        tcg_out_qemu_ldst_i128(s, datalo, datahi, addr, oi, false);
+    }
+}
+
+static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
+    .base.static_constraint =
+        TCG_TARGET_REG_BITS == 64 ? C_O0_I3(o, m, r) : C_O0_I3(r, r, r),
+    .out = tgen_qemu_st2,
+};
+
 static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
 {
     int i;
@@ -3805,25 +3832,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    switch (opc) {
-    case INDEX_op_qemu_st:
-        tcg_out_qemu_st(s, args[0], -1, args[1], args[2], type);
-        break;
-    case INDEX_op_qemu_st2:
-        if (TCG_TARGET_REG_BITS == 32) {
-            tcg_out_qemu_st(s, args[0], args[1], args[2],
-                            args[3], TCG_TYPE_I64);
-            break;
-        }
-        tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
-        break;
-
-    case INDEX_op_call:      /* Always emitted via tcg_out_call.  */
-    case INDEX_op_exit_tb:   /* Always emitted via tcg_out_exit_tb.  */
-    case INDEX_op_goto_tb:   /* Always emitted via tcg_out_goto_tb.  */
-    default:
-        g_assert_not_reached();
-    }
+    g_assert_not_reached();
 }
 
 int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 94e6f04fa6..eca1283742 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1882,8 +1882,8 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg val,
     }
 }
 
-static void tcg_out_qemu_st(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
-                            MemOpIdx oi, TCGType data_type)
+static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data_reg,
+                         TCGReg addr_reg, MemOpIdx oi)
 {
     TCGLabelQemuLdst *ldst;
     TCGReg base;
@@ -1892,12 +1892,21 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
     tcg_out_qemu_st_direct(s, data_reg, base, get_memop(oi));
 
     if (ldst) {
-        ldst->type = data_type;
+        ldst->type = type;
         ldst->datalo_reg = data_reg;
         ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
     }
 }
 
+static const TCGOutOpQemuLdSt outop_qemu_st = {
+    .base.static_constraint = C_O0_I2(rz, r),
+    .out = tgen_qemu_st,
+};
+
+static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static const tcg_insn_unit *tb_ret_addr;
 
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
@@ -2637,21 +2646,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    TCGArg a0 = args[0];
-    TCGArg a1 = args[1];
-    TCGArg a2 = args[2];
-
-    switch (opc) {
-    case INDEX_op_qemu_st:
-        tcg_out_qemu_st(s, a0, a1, a2, type);
-        break;
-
-    case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
-    case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
-    case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    default:
-        g_assert_not_reached();
-    }
+    g_assert_not_reached();
 }
 
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
@@ -2875,9 +2870,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_st:
-        return C_O0_I2(rz, r);
-
     case INDEX_op_st_vec:
         return C_O0_I2(v, r);
     case INDEX_op_dup_vec:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 72dd161007..123e74290a 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2102,8 +2102,8 @@ static const TCGOutOpQemuLdSt outop_qemu_ld = {
     .out = tgen_qemu_ld,
 };
 
-static void tcg_out_qemu_st(TCGContext* s, TCGReg data_reg, TCGReg addr_reg,
-                            MemOpIdx oi, TCGType data_type)
+static void tgen_qemu_st(TCGContext* s, TCGType type, TCGReg data_reg,
+                         TCGReg addr_reg, MemOpIdx oi)
 {
     TCGLabelQemuLdst *ldst;
     HostAddress h;
@@ -2112,12 +2112,17 @@ static void tcg_out_qemu_st(TCGContext* s, TCGReg data_reg, TCGReg addr_reg,
     tcg_out_qemu_st_direct(s, get_memop(oi), data_reg, h);
 
     if (ldst) {
-        ldst->type = data_type;
+        ldst->type = type;
         ldst->datalo_reg = data_reg;
         ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
     }
 }
 
+static const TCGOutOpQemuLdSt outop_qemu_st = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out = tgen_qemu_st,
+};
+
 static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
                                    TCGReg addr_reg, MemOpIdx oi, bool is_ld)
 {
@@ -2203,6 +2208,17 @@ static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
     .out = tgen_qemu_ld2,
 };
 
+static void tgen_qemu_st2(TCGContext *s, TCGType type, TCGReg datalo,
+                          TCGReg datahi, TCGReg addr_reg, MemOpIdx oi)
+{
+    tcg_out_qemu_ldst_i128(s, datalo, datahi, addr_reg, oi, false);
+}
+
+static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
+    .base.static_constraint = C_O0_I3(o, m, r),
+    .out = tgen_qemu_st2,
+};
+
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
 {
     /* Reuse the zeroing that exists for goto_ptr.  */
@@ -3148,20 +3164,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    switch (opc) {
-    case INDEX_op_qemu_st:
-        tcg_out_qemu_st(s, args[0], args[1], args[2], type);
-        break;
-    case INDEX_op_qemu_st2:
-        tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
-        break;
-
-    case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
-    case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
-    case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    default:
-        g_assert_not_reached();
-    }
+    g_assert_not_reached();
 }
 
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
@@ -3604,11 +3607,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_st:
-        return C_O0_I2(r, r);
-    case INDEX_op_qemu_st2:
-        return C_O0_I3(o, m, r);
-
     case INDEX_op_st_vec:
         return C_O0_I2(v, r);
     case INDEX_op_ld_vec:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index d9a4b4ea36..49a4f4f281 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1234,8 +1234,8 @@ static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
     .base.static_constraint = C_NotImplemented,
 };
 
-static void tcg_out_qemu_st(TCGContext *s, TCGReg data, TCGReg addr,
-                            MemOpIdx oi, TCGType data_type)
+static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data,
+                         TCGReg addr, MemOpIdx oi)
 {
     static const int st_opc[(MO_SIZE | MO_BSWAP) + 1] = {
         [MO_UB]   = STB,
@@ -1258,12 +1258,21 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg data, TCGReg addr,
                     st_opc[get_memop(oi) & (MO_BSWAP | MO_SIZE)]);
 
     if (ldst) {
-        ldst->type = data_type;
+        ldst->type = type;
         ldst->datalo_reg = data;
         ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
     }
 }
 
+static const TCGOutOpQemuLdSt outop_qemu_st = {
+    .base.static_constraint = C_O0_I2(rz, r),
+    .out = tgen_qemu_st,
+};
+
+static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
 {
     if (check_fit_ptr(a0, 13)) {
@@ -2064,36 +2073,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    TCGArg a0, a1, a2;
-
-    /* Hoist the loads of the most common arguments.  */
-    a0 = args[0];
-    a1 = args[1];
-    a2 = args[2];
-
-    switch (opc) {
-    case INDEX_op_qemu_st:
-        tcg_out_qemu_st(s, a0, a1, a2, type);
-        break;
-
-    case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
-    case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
-    case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    default:
-        g_assert_not_reached();
-    }
+    g_assert_not_reached();
 }
 
 static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
-    switch (op) {
-    case INDEX_op_qemu_st:
-        return C_O0_I2(rz, r);
-
-    default:
-        return C_NotImplemented;
-    }
+    return C_NotImplemented;
 }
 
 static void tcg_target_init(TCGContext *s)
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index f69e35e6ce..50e205211d 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -39,15 +39,7 @@
 static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
-    switch (op) {
-    case INDEX_op_qemu_st:
-        return C_O0_I2(r, r);
-    case INDEX_op_qemu_st2:
-        return TCG_TARGET_REG_BITS == 64 ? C_NotImplemented : C_O0_I3(r, r, r);
-
-    default:
-        return C_NotImplemented;
-    }
+    return C_NotImplemented;
 }
 
 static const int tcg_target_reg_alloc_order[] = {
@@ -1218,25 +1210,36 @@ static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
         TCG_TARGET_REG_BITS == 64 ? NULL : tgen_qemu_ld2,
 };
 
+static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data,
+                         TCGReg addr, MemOpIdx oi)
+{
+    tcg_out_op_rrm(s, INDEX_op_qemu_st, data, addr, oi);
+}
+
+static const TCGOutOpQemuLdSt outop_qemu_st = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out = tgen_qemu_st,
+};
+
+static void tgen_qemu_st2(TCGContext *s, TCGType type, TCGReg datalo,
+                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
+{
+    tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, oi);
+    tcg_out_op_rrrr(s, INDEX_op_qemu_st2, datalo, datahi, addr, TCG_REG_TMP);
+}
+
+static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
+    .base.static_constraint =
+        TCG_TARGET_REG_BITS == 64 ? C_NotImplemented : C_O0_I3(r, r, r),
+    .out =
+        TCG_TARGET_REG_BITS == 64 ? NULL : tgen_qemu_st2,
+};
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    switch (opc) {
-    case INDEX_op_qemu_st:
-        tcg_out_op_rrm(s, opc, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_qemu_st2:
-        tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, args[3]);
-        tcg_out_op_rrrr(s, opc, args[0], args[1], args[2], TCG_REG_TMP);
-        break;
-
-    case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
-    case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
-    case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    default:
-        g_assert_not_reached();
-    }
+    g_assert_not_reached();
 }
 
 static void tcg_out_st(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
-- 
2.43.0


