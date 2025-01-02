Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689D7E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPeu-000884-7g; Thu, 02 Jan 2025 13:11:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeo-0007bX-V0
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:55 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPel-0006IB-8Z
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:54 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso154757725ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841450; x=1736446250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fAaXJuliG4AX1JfPizZhxdX1L9P0mdLOxcA7EdEklLU=;
 b=oSFYqxtvPgcH+Pzz+KQCpuTRCa99zB5wKRu3wE0DScrIbER5rIlbKxRURgQCJIaj5Z
 lYI7ReGi44s6ebKFDwsFVqq7fl/WhZLe8ehGsy0wse4p1ukf1Dy6wwTfptiDMr4hB4V6
 WBkD6HvjC/lt8Mk2Fnh3Lyb8IioGZexaz24uSL5kGA9qtU8jv2RhlMdXuxxFpbhYDgWA
 QmOCNLjTHfWT44bpfpU7oydEWwvP3eHJa9Y7Nlb5h18Bw+MeIR93VFmhG73O+Wvcijc/
 I2Uoj+q/SEnOdGTOie8MLSvV9tuEZ7Y79ft4/BnicYRwMqCQIQq1qLZjpbxWK0ezDy30
 RZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841450; x=1736446250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fAaXJuliG4AX1JfPizZhxdX1L9P0mdLOxcA7EdEklLU=;
 b=Koi4UTFj6mF5eTZkbP17YGo8Hs6OwO9JI7fCP4p2VpXQPGVPtpmjz/VDoAtYGE1+So
 sZ11oOTVXzvg5UVr6dnHax5zBfTynMRApwxN1hnLeL1NpZHIgTVcSODrFMhvDZBhkTLd
 9kSBxn2qVa6aXFOMEK1bjxPJzqEMEt9I97geHNcwo7tvCARGwjaTNOagkNLPoUiBfy89
 zu/FHiTMCUm7137tK5ghWPV3mNfCsXIelQbX/y72tHHekzEfdPJ87JQFxqhK0Qe8wBXG
 BB6YeTJwZ9XOdYKrl90DtNqS/ky5b0wZ1EsktNoLpkbN3E0idqx/9K8WUdJg8Nd5nN0U
 u8nw==
X-Gm-Message-State: AOJu0Yy0RoVw47cdVBH1W+zbV/zqN3IimVDEd4MEIKjKfd0Wk1GqlI72
 zhnN6iRy/EAr/+A3nIePu7mb9coRLahN1bnsVjaCnE1eDMPv3Z8jvqU5qdnx9eJTYJRrO4KFq2E
 K
X-Gm-Gg: ASbGncuwJ/RcncMJkq7YjMfJuP9scONCMMApCqYOUHKDmdnLLxj9yazBeuSbuC5+52Z
 XgfMatQ3PIpSzStMpKoZN4GxU1dkOvw7xLNGTM0Rfx6UfKyfjlN8fXeI0SdK44yvhXQLHpL1MHp
 3/z5uXKir0ihh5BzhfP3ppqmPUkAd0IsMTwbmjWxiKReJoyfk6AJk8v6BjI16Is4+1ZMRFXB1xQ
 rfu6l8s9W3s4WVzKUWtrkEaFTShwQ77nlqyj9xkVHKgS+RCUI6BDqySJFmScg==
X-Google-Smtp-Source: AGHT+IGu4QnN9f/gsKku3F0CsJ6dORcclU4cisWzA6UZHKbB3LgWBeB1BMJt/IMhXe9so2VAm3pR2w==
X-Received: by 2002:a05:6a00:8087:b0:725:d1d5:6d80 with SMTP id
 d2e1a72fcca58-72abde65a85mr61592488b3a.7.1735841449962; 
 Thu, 02 Jan 2025 10:10:49 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 70/73] tcg: Merge extract2 operations
Date: Thu,  2 Jan 2025 10:06:50 -0800
Message-ID: <20250102180654.1420056-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
 include/tcg/tcg-opc.h        |  5 +----
 tcg/optimize.c               | 10 +++++-----
 tcg/tcg-op.c                 |  4 ++--
 tcg/tcg.c                    |  6 ++----
 target/i386/tcg/emit.c.inc   | 12 +-----------
 tcg/aarch64/tcg-target.c.inc |  6 ++----
 tcg/arm/tcg-target.c.inc     |  4 ++--
 tcg/i386/tcg-target.c.inc    |  5 ++---
 8 files changed, 17 insertions(+), 35 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index d390d639ee..c9069525a1 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -72,6 +72,7 @@ DEF(rotr, 1, 2, 0, TCG_OPF_INT)
 DEF(extract, 1, 1, 2, TCG_OPF_INT)
 DEF(sextract, 1, 1, 2, TCG_OPF_INT)
 DEF(deposit, 1, 2, 2, TCG_OPF_INT)
+DEF(extract2, 1, 2, 1, TCG_OPF_INT)
 
 DEF(brcond, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH | TCG_OPF_INT)
 DEF(setcond, 1, 2, 1, TCG_OPF_INT)
@@ -81,8 +82,6 @@ DEF(movcond, 1, 4, 1, TCG_OPF_INT)
 /* load/store */
 DEF(ld_i32, 1, 1, 2, 0)
 DEF(st_i32, 0, 2, 2, 0)
-/* shifts/rotates */
-DEF(extract2_i32, 1, 2, 1, 0)
 
 DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(setcond2_i32, 1, 4, 1, 0)
@@ -96,8 +95,6 @@ DEF(ctpop_i32, 1, 1, 0, 0)
 /* load/store */
 DEF(ld_i64, 1, 1, 2, 0)
 DEF(st_i64, 0, 2, 2, 0)
-/* shifts/rotates */
-DEF(extract2_i64, 1, 2, 1, 0)
 
 /* size changing ops */
 DEF(ext_i32_i64, 1, 1, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 25ab293a73..82606a00f5 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1831,12 +1831,12 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
         uint64_t v2 = arg_info(op->args[2])->val;
         int shr = op->args[3];
 
-        if (op->opc == INDEX_op_extract2_i64) {
-            v1 >>= shr;
-            v2 <<= 64 - shr;
-        } else {
+        if (op->type == TCG_TYPE_I32) {
             v1 = (uint32_t)v1 >> shr;
             v2 = (uint64_t)((int32_t)v2 << (32 - shr));
+        } else {
+            v1 >>= shr;
+            v2 <<= 64 - shr;
         }
         return tcg_opt_gen_movi(ctx, op, op->args[0], v1 | v2);
     }
@@ -2766,7 +2766,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_extract:
             done = fold_extract(&ctx, op);
             break;
-        CASE_OP_32_64(extract2):
+        case INDEX_op_extract2:
             done = fold_extract2(&ctx, op);
             break;
         case INDEX_op_ext_i32_i64:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 65a6031eaf..f3f758b15b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1070,7 +1070,7 @@ void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
     } else if (al == ah) {
         tcg_gen_rotri_i32(ret, al, ofs);
     } else if (TCG_TARGET_HAS_extract2(TCG_TYPE_I32)) {
-        tcg_gen_op4i_i32(INDEX_op_extract2_i32, ret, al, ah, ofs);
+        tcg_gen_op4i_i32(INDEX_op_extract2, ret, al, ah, ofs);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_shri_i32(t0, al, ofs);
@@ -2802,7 +2802,7 @@ void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
     } else if (al == ah) {
         tcg_gen_rotri_i64(ret, al, ofs);
     } else if (TCG_TARGET_HAS_extract2(TCG_TYPE_I64)) {
-        tcg_gen_op4i_i64(INDEX_op_extract2_i64, ret, al, ah, ofs);
+        tcg_gen_op4i_i64(INDEX_op_extract2, ret, al, ah, ofs);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         tcg_gen_shri_i64(t0, al, ofs);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 77f28147a1..e8377a9bbe 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2224,6 +2224,8 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
         return has_type && TCG_TARGET_HAS_div2(type);
     case INDEX_op_eqv:
         return has_type && TCG_TARGET_HAS_eqv(type);
+    case INDEX_op_extract2:
+        return has_type && TCG_TARGET_HAS_extract2(type);
     case INDEX_op_muls2:
         return has_type && TCG_TARGET_HAS_muls2(type);
     case INDEX_op_mulsh:
@@ -2251,8 +2253,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_sub2:
         return has_type && TCG_TARGET_HAS_sub2(type);
 
-    case INDEX_op_extract2_i32:
-        return TCG_TARGET_HAS_extract2(TCG_TYPE_I32);
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
         return TCG_TARGET_HAS_bswap(TCG_TYPE_I32);
@@ -2271,8 +2271,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_extrh_i64_i32:
         return TCG_TARGET_REG_BITS == 64;
 
-    case INDEX_op_extract2_i64:
-        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_extract2(TCG_TYPE_I64);
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 00f7a6123a..c8fb3c36d9 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -19,16 +19,6 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-/*
- * Sometimes, knowing what the backend has can produce better code.
- * The exact opcode to check depends on 32- vs. 64-bit.
- */
-#ifdef TARGET_X86_64
-#define INDEX_op_extract2_tl            INDEX_op_extract2_i64
-#else
-#define INDEX_op_extract2_tl            INDEX_op_extract2_i32
-#endif
-
 #define MMX_OFFSET(reg)                        \
   ({ assert((reg) >= 0 && (reg) <= 7);         \
      offsetof(CPUX86State, fpregs[reg].mmx); })
@@ -2993,7 +2983,7 @@ static void gen_PMOVMSKB(DisasContext *s, X86DecodedInsn *decode)
     tcg_gen_ld8u_tl(s->T0, tcg_env, offsetof(CPUX86State, xmm_t0.ZMM_B(vec_len - 1)));
     while (vec_len > 8) {
         vec_len -= 8;
-        if (tcg_op_supported(INDEX_op_extract2_tl, TCG_TYPE_TL)) {
+        if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_TL)) {
             /*
              * Load the next byte of the result into the high byte of T.
              * TCG does a similar expansion of deposit to shl+extract2; by
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 57f4e05b5c..d982ac38a1 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2426,8 +2426,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_sbfm(s, ext, a0, a1, a2, a2 + args[3] - 1);
         break;
 
-    case INDEX_op_extract2_i64:
-    case INDEX_op_extract2_i32:
+    case INDEX_op_extract2:
         tcg_out_extr(s, ext, a0, REG0(2), REG0(1), args[3]);
         break;
 
@@ -2998,8 +2997,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_deposit:
         return C_O1_I2(r, 0, rZ);
 
-    case INDEX_op_extract2_i32:
-    case INDEX_op_extract2_i64:
+    case INDEX_op_extract2:
         return C_O1_I2(r, rZ, rZ);
 
     case INDEX_op_add2:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 1bf020ed67..ef33cf0ac7 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2133,7 +2133,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_sextract:
         tcg_out_sextract(s, COND_AL, args[0], args[1], args[2], args[3]);
         break;
-    case INDEX_op_extract2_i32:
+    case INDEX_op_extract2:
         /* ??? These optimization vs zero should be generic.  */
         /* ??? But we can't substitute 2 for 1 in the opcode stream yet.  */
         if (const_args[1]) {
@@ -2229,7 +2229,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
         return C_O0_I2(r, rIN);
     case INDEX_op_deposit:
         return C_O1_I2(r, 0, rZ);
-    case INDEX_op_extract2_i32:
+    case INDEX_op_extract2:
         return C_O1_I2(r, rZ, rZ);
     case INDEX_op_movcond:
         return C_O1_I4(r, r, rIN, rIK, 0);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 917775b7f6..61acf23708 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3093,7 +3093,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(extract2):
+    case INDEX_op_extract2:
         /* Note that SHRD outputs to the r/m operand.  */
         tcg_out_modrm(s, OPC_SHRD_Ib + rexw, a2, a0);
         tcg_out8(s, args[3]);
@@ -3726,8 +3726,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ctpop_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_extract2_i32:
-    case INDEX_op_extract2_i64:
+    case INDEX_op_extract2:
         return C_O1_I2(r, 0, r);
 
     case INDEX_op_deposit:
-- 
2.43.0


