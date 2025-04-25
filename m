Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D5EC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 21:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R4F-0001DN-9p; Fri, 25 Apr 2025 17:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R48-0000tI-Ra
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:37 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R45-0000nx-Eu
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:36 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22c33e5013aso35735435ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618311; x=1746223111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Tfygo5FA+aJ1Z2AaVUAn3ry8TltDl91MJw1P65WsvY=;
 b=HJbuJhDUNESxjVTuSEESWtZ4IHkjcRPZTQj7bxWl4uwF827BupFi7BDW7ypXeZVeLj
 +Fo0umU4nz0L+siyzcLBFXZy000O557Otgeo0z5E8MQSzsIHlwOu2YsVspjJTAPMKb+a
 CByX0XXmY81GrQqGLuhXnzFzzF45rZ0psHg/S0dSN1VUA8bLC8iulQbNlKdZ7ANsRHvt
 aa0uTvND8Eh5D9kUWO7dxxlf1OkuacbD7EuElrEnenMGpdt3xVdOdrom55V1JJBVpPp3
 nzWrSCe5c7KUtg/0NiuhVp0dDNSIxNnd/FD0aHnR0e1lJd8MastpFfHD1EA1qpmU3rbf
 +HSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618311; x=1746223111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Tfygo5FA+aJ1Z2AaVUAn3ry8TltDl91MJw1P65WsvY=;
 b=PB4ydC/xH6w9xczLE3uoId3XvmlndimDBDeCbIRfA/tZIxroiiZCzZuyD2M3+y1Wr7
 hr250GfQmlphs9mBoZh/LIM9ObraKJx81G8ekDn1GtBwwV/J5LUpHX8vz0N26x08rfIJ
 Mzdjib/TYuLw3E0T5Pa4DywWKWUX/AvvUInxIWU+N8vuDw2cYXBPCY5qiGA82F21+Koe
 QO5c6zFgMqD0iXI8O81nTiWKVTTaUPNoKx0UN/DQgF+wHfc8ddyhs6s6dztoymSEHBWH
 BGSl4jOoVvJiOC6u6OvaOAxg770uaXxpkkmRlhmY1Ue6aU8lyT6Ou2f/p4yaVoyV+uch
 8mfA==
X-Gm-Message-State: AOJu0Yw5ZISZLsQYTw+8PPKZZD/8M69YbF+A/g2aPudHqlpxDjqi3Ygq
 J4X4R+9HOWr2foBrQWmGRNcJaEbtFMIBBMpK+1rw4ZAm0cSjC9FVT2zIOw1aWgjelK19ylwq9CZ
 0
X-Gm-Gg: ASbGncsIja2ti3mv1sL6bysH2eKhmDDe4o+tjwjNGN8veQy12xluu5q7ap5UZ5e8gVe
 gtgEyRU2JZ1B1kUtAGIh8etuzMfp696QYqzjvLCUy20Ybz85OMHy3oeWxqaEd4TwQNawMtkQDE/
 qtK7lFgIJP95n/2bmbhpSCpneTT76Afd/bBCyqc+CfNNoWtQTUAYviV8B00XQwT3gaRrs10Gjz+
 TMGQO+GeDCA5v23N7A0zQ4J2b/qOqrLjKAgpwEOce63h1c27qlZYJfnv8E9PkuaJC40nCUjMKOb
 it/5uuApVgyq91nFIG0yuERx29n4DPDBX5h7yc3vIInR3OxyF0bfMlxCdFqRCGnfQXGw2egB1MM
 =
X-Google-Smtp-Source: AGHT+IG6MNpaAx04ewk1JgKaqb9ib0r1+9UnCojqfQIA6/GhJ1PNhqMdM4oS4VZl0uz43P22UZetxw==
X-Received: by 2002:a17:902:f689:b0:224:abb:92c with SMTP id
 d9443c01a7336-22dc6a8a9ddmr14747645ad.50.1745618311596; 
 Fri, 25 Apr 2025 14:58:31 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d770d6sm37749595ad.17.2025.04.25.14.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:58:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 048/159] tcg: Merge INDEX_op_divu_{i32,i64}
Date: Fri, 25 Apr 2025 14:53:02 -0700
Message-ID: <20250425215454.886111-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    |  3 +--
 tcg/optimize.c           |  9 +++++----
 tcg/tcg-op.c             | 16 ++++++++--------
 tcg/tcg.c                |  6 ++----
 tcg/tci.c                |  5 ++---
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 6d4edd0b16..243f002a61 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -43,6 +43,7 @@ DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(divs, 1, 2, 0, TCG_OPF_INT)
+DEF(divu, 1, 2, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
 DEF(mulsh, 1, 2, 0, TCG_OPF_INT)
@@ -69,7 +70,6 @@ DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* arith */
-DEF(divu_i32, 1, 2, 0, 0)
 DEF(rem_i32, 1, 2, 0, 0)
 DEF(remu_i32, 1, 2, 0, 0)
 DEF(div2_i32, 2, 3, 0, 0)
@@ -116,7 +116,6 @@ DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* arith */
-DEF(divu_i64, 1, 2, 0, 0)
 DEF(rem_i64, 1, 2, 0, 0)
 DEF(remu_i64, 1, 2, 0, 0)
 DEF(div2_i64, 2, 3, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index af9054be37..c11cce782a 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -563,9 +563,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
         }
         return (int64_t)x / ((int64_t)y ? : 1);
 
-    case INDEX_op_divu_i32:
-        return (uint32_t)x / ((uint32_t)y ? : 1);
-    case INDEX_op_divu_i64:
+    case INDEX_op_divu:
+        if (type == TCG_TYPE_I32) {
+            return (uint32_t)x / ((uint32_t)y ? : 1);
+        }
         return (uint64_t)x / ((uint64_t)y ? : 1);
 
     case INDEX_op_rem_i32:
@@ -2908,7 +2909,7 @@ void tcg_optimize(TCGContext *s)
             done = fold_deposit(&ctx, op);
             break;
         case INDEX_op_divs:
-        CASE_OP_32_64(divu):
+        case INDEX_op_divu:
             done = fold_divide(&ctx, op);
             break;
         case INDEX_op_dup_vec:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 19be461214..f326c452a4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -635,8 +635,8 @@ void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_divu_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_divu_i32, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_divu, ret, arg1, arg2);
     } else if (TCG_TARGET_HAS_div2_i32) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 zero = tcg_constant_i32(0);
@@ -651,9 +651,9 @@ void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_rem_i32) {
         tcg_gen_op3_i32(INDEX_op_remu_i32, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu_i32, TCG_TYPE_I32, 0)) {
+    } else if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_divu_i32, t0, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_divu, t0, arg1, arg2);
         tcg_gen_mul_i32(t0, t0, arg2);
         tcg_gen_sub_i32(ret, arg1, t0);
         tcg_temp_free_i32(t0);
@@ -2003,8 +2003,8 @@ void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (tcg_op_supported(INDEX_op_divu_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_divu_i64, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_divu, ret, arg1, arg2);
     } else if (TCG_TARGET_HAS_div2_i64) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 zero = tcg_constant_i64(0);
@@ -2019,9 +2019,9 @@ void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_HAS_rem_i64) {
         tcg_gen_op3_i64(INDEX_op_remu_i64, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu_i64, TCG_TYPE_I64, 0)) {
+    } else if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_divu_i64, t0, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_divu, t0, arg1, arg2);
         tcg_gen_mul_i64(t0, t0, arg2);
         tcg_gen_sub_i64(ret, arg1, t0);
         tcg_temp_free_i64(t0);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a0e58c07d7..9aa6d40905 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1021,8 +1021,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
-    OUTOP(INDEX_op_divu_i32, TCGOutOpBinary, outop_divu),
-    OUTOP(INDEX_op_divu_i64, TCGOutOpBinary, outop_divu),
+    OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
@@ -5415,8 +5414,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_divs:
-    case INDEX_op_divu_i32:
-    case INDEX_op_divu_i64:
+    case INDEX_op_divu:
     case INDEX_op_eqv:
     case INDEX_op_mul:
     case INDEX_op_mulsh:
diff --git a/tcg/tci.c b/tcg/tci.c
index 0691824f97..bf97849bfe 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -724,7 +724,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (int64_t)regs[r1] / (int64_t)regs[r2];
             break;
-        case INDEX_op_divu_i64:
+        case INDEX_op_divu:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (uint64_t)regs[r1] / (uint64_t)regs[r2];
             break;
@@ -1072,6 +1072,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_divs:
+    case INDEX_op_divu:
     case INDEX_op_eqv:
     case INDEX_op_mul:
     case INDEX_op_nand:
@@ -1082,8 +1083,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_xor:
     case INDEX_op_rem_i32:
     case INDEX_op_rem_i64:
-    case INDEX_op_divu_i32:
-    case INDEX_op_divu_i64:
     case INDEX_op_remu_i32:
     case INDEX_op_remu_i64:
     case INDEX_op_shl_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index a833b3b7b2..41985be012 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -282,7 +282,7 @@ Arithmetic
      - | *t0* = *t1* / *t2* (signed)
        | Undefined behavior if division by zero or overflow.
 
-   * - divu_i32/i64 *t0*, *t1*, *t2*
+   * - divu *t0*, *t1*, *t2*
 
      - | *t0* = *t1* / *t2* (unsigned)
        | Undefined behavior if division by zero.
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 18a10156a6..dfa8aecc7a 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -663,7 +663,7 @@ static void tgen_divu(TCGContext *s, TCGType type,
 {
     TCGOpcode opc = (type == TCG_TYPE_I32
                      ? INDEX_op_tci_divu32
-                     : INDEX_op_divu_i64);
+                     : INDEX_op_divu);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
 }
 
-- 
2.43.0


