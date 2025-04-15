Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B9AC369C1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4m8k-0004IS-EG; Tue, 15 Apr 2025 15:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lzG-0008Ix-Nr
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:27 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4ly6-0000lK-HL
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:26 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-227d6b530d8so59152165ad.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745342; x=1745350142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJs5InOBa0W/UPNlQRdJNbuDcBJlPUgv3ONVSiJnEp8=;
 b=xQWajVgbvjINDMH2K/vj/xI4Gf6U3ag/6YUk3txro1OvrJz5WtbTji7gTUN5tBzRzH
 0z46yE/pTu9WOelMV2lDJjWNIqs0jfbT3n3mrdNOG+jKMoy6Gg/I7izxWKsIRg5nrRO0
 DP1iIeiixK7ChXQ0skNfg7xKB6nJwB+g5wYAQSCaRwWsWHfNWOFDPROvKIZDPwvYD7vZ
 +4oUuElYE4+bcc3TBAOpQ6Alj/CVNHAszEXjMEJqPa3M7aiQ6H7WvdnSg1Q4MdOBjR6X
 4w6T/eU2vqvnCUS5CVVCasN7YvknwfSVmXBC4xzD8/h0I844g7lBknWuNHa9AFYImmMU
 EHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745342; x=1745350142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IJs5InOBa0W/UPNlQRdJNbuDcBJlPUgv3ONVSiJnEp8=;
 b=Y+sHgAdpsfS3ph3enkA8arubPkLCiFQ04M06Yi5bkAnJcq2TPQOJT43lbFVtLTMo/e
 UWpqlVdvnt0jLNU5MpGV454CdpwpQNtLgDuU28c31ZkmG6BQ2w6XOnVzvstNG4t5nPGn
 xVc/4SQMqupmZLhu1gPUZYJJyEkIJuSMKFow5eVecQCAwhxKdG4IpdZpqIIfXGB2eeRR
 osjsSuXQuqJ6kenB2Jrgl/eT4A7qqIYXe9YEV11+CvHTVrYRnf9vuOJKc+olpdTDQc4O
 yLwg/+wp4ZpLNf+z8Ik/T299P04LP3jUDZEwuOCIICDcx9Kj8Lg66NNKtjazfTinqDkm
 P32A==
X-Gm-Message-State: AOJu0YzYugNpqBD83ivJUiu1ykYvCYP+xMIAOP7EShU3CxTa/HVhh34M
 teRZTmmvvAVUbv8K0vZH2Vvx98JmpwX+wZ+yk1FDB1zgrTQYz7hJLKyfTrp9XKl1M/dsl8WH6ny
 W
X-Gm-Gg: ASbGncuTgyRVyziUu1uiz1KwWCgboZcczGaHDmFK5U+6aUSmEWO/t8zL9ilMCuW9s9I
 j/rxVsescqt1YBYjikUcCqRbheHN5v3QlMci1vS6LTvKKJxmLKm7AjzF2y8kFWp6hBqi3vU9z85
 gZ8/dWKmA7mHoL3f3phPRpVcyzncOPN8AnegBB5VCXOGjFLzI1uKc/x1qv1fpnyh46myg7YHxXf
 AuJlCmFAULA6Hbf6nUoz3Hu3Kgg1kn0sjhaXCEXxHeAZjYboSdayWI5wvWQE1Lmnv5TwKIRZX6K
 tCPQeXQUsv/veD0bptQiF47r87p3MwBhGRxFThU9wRlmlstV9R0ECq+aPwiZzRBVDi8hsk0SNI4
 =
X-Google-Smtp-Source: AGHT+IEv342PjBwqlcxp6tWZFxHuXWT1RoI4FIrzSs+/yKxuYS74D6faP1JTjnzQ8HTrSTwE78E/Eg==
X-Received: by 2002:a17:90b:2647:b0:2ee:bc7b:9237 with SMTP id
 98e67ed59e1d1-3085ef3d000mr504467a91.27.1744745342105; 
 Tue, 15 Apr 2025 12:29:02 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm13534812a91.4.2025.04.15.12.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:29:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 052/163] tcg: Merge INDEX_op_remu_{i32,i64}
Date: Tue, 15 Apr 2025 12:23:23 -0700
Message-ID: <20250415192515.232910-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
 include/tcg/tcg-opc.h    | 5 +----
 tcg/optimize.c           | 9 +++++----
 tcg/tcg-op.c             | 8 ++++----
 tcg/tcg.c                | 6 ++----
 tcg/tci.c                | 4 ++--
 docs/devel/tcg-ops.rst   | 2 +-
 tcg/tci/tcg-target.c.inc | 2 +-
 7 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 040f4da835..ebb23347e9 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -57,6 +57,7 @@ DEF(not, 1, 1, 0, TCG_OPF_INT)
 DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
 DEF(rems, 1, 2, 0, TCG_OPF_INT)
+DEF(remu, 1, 2, 0, TCG_OPF_INT)
 DEF(sub, 1, 2, 0, TCG_OPF_INT)
 DEF(xor, 1, 2, 0, TCG_OPF_INT)
 
@@ -72,8 +73,6 @@ DEF(ld_i32, 1, 1, 1, 0)
 DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
-/* arith */
-DEF(remu_i32, 1, 2, 0, 0)
 /* shifts/rotates */
 DEF(shl_i32, 1, 2, 0, 0)
 DEF(shr_i32, 1, 2, 0, 0)
@@ -115,8 +114,6 @@ DEF(st8_i64, 0, 2, 1, 0)
 DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
-/* arith */
-DEF(remu_i64, 1, 2, 0, 0)
 /* shifts/rotates */
 DEF(shl_i64, 1, 2, 0, 0)
 DEF(shr_i64, 1, 2, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 55663ff4c3..6f0887f808 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -563,9 +563,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
         }
         return (int64_t)x % ((int64_t)y ? : 1);
 
-    case INDEX_op_remu_i32:
-        return (uint32_t)x % ((uint32_t)y ? : 1);
-    case INDEX_op_remu_i64:
+    case INDEX_op_remu:
+        if (type == TCG_TYPE_I32) {
+            return (uint32_t)x % ((uint32_t)y ? : 1);
+        }
         return (uint64_t)x % ((uint64_t)y ? : 1);
 
     default:
@@ -3012,7 +3013,7 @@ void tcg_optimize(TCGContext *s)
             done = fold_qemu_st(&ctx, op);
             break;
         case INDEX_op_rems:
-        CASE_OP_32_64(remu):
+        case INDEX_op_remu:
             done = fold_remainder(&ctx, op);
             break;
         CASE_OP_32_64(rotl):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4ff6c9f0ab..0f1e83a49f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -649,8 +649,8 @@ void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_remu_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_remu_i32, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_remu, ret, arg1, arg2);
     } else if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_op3_i32(INDEX_op_divu, t0, arg1, arg2);
@@ -2017,8 +2017,8 @@ void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (tcg_op_supported(INDEX_op_remu_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_remu_i64, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_remu, ret, arg1, arg2);
     } else if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         tcg_gen_op3_i64(INDEX_op_divu, t0, arg1, arg2);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 7c4c698d65..94644a1781 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1041,8 +1041,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
-    OUTOP(INDEX_op_remu_i32, TCGOutOpBinary, outop_remu),
-    OUTOP(INDEX_op_remu_i64, TCGOutOpBinary, outop_remu),
+    OUTOP(INDEX_op_remu, TCGOutOpBinary, outop_remu),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 };
@@ -5420,8 +5419,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_rems:
-    case INDEX_op_remu_i32:
-    case INDEX_op_remu_i64:
+    case INDEX_op_remu:
     case INDEX_op_xor:
         {
             const TCGOutOpBinary *out =
diff --git a/tcg/tci.c b/tcg/tci.c
index bd5817a382..5d2cba4941 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -732,7 +732,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (int64_t)regs[r1] % (int64_t)regs[r2];
             break;
-        case INDEX_op_remu_i64:
+        case INDEX_op_remu:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (uint64_t)regs[r1] % (uint64_t)regs[r2];
             break;
@@ -1080,9 +1080,9 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_rems:
+    case INDEX_op_remu:
     case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_remu_i64:
     case INDEX_op_shl_i32:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 1f4160a585..bceecb0596 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -292,7 +292,7 @@ Arithmetic
      - | *t0* = *t1* % *t2* (signed)
        | Undefined behavior if division by zero or overflow.
 
-   * - remu_i32/i64 *t0*, *t1*, *t2*
+   * - remu *t0*, *t1*, *t2*
 
      - | *t0* = *t1* % *t2* (unsigned)
        | Undefined behavior if division by zero.
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 421a2a8ac7..eb30fd04ba 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -769,7 +769,7 @@ static void tgen_remu(TCGContext *s, TCGType type,
 {
     TCGOpcode opc = (type == TCG_TYPE_I32
                      ? INDEX_op_tci_remu32
-                     : INDEX_op_remu_i64);
+                     : INDEX_op_remu);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
 }
 
-- 
2.43.0


