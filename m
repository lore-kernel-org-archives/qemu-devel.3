Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4480EC021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnuQ-0004Rt-2j; Sun, 16 Feb 2025 18:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntK-0002re-1e
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:38 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntG-00063j-Fp
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:36 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-220f4dd756eso39372535ad.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747853; x=1740352653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tVFMB/4goCUjfEUwL3Yfn3+4nZ6fGLubQq1aU1yBUYo=;
 b=pp3l7LOHSfNZgg9Q8PPn1ybB4j+8i9wiq6xxpAHO7zILXv/NkiAlKMscFmWnV4Xrtb
 ftAWT7kHy5GB+xoopJuU5cvecPk3ENfG3bFvlI0FdX+brl8K0uFyCMIXNNAKXSqDuOnc
 0AcqZpKpCZppLZ1fWO0SXAL45QF4WBTpxmpPQ/pgBEO0LOxobOK5SG1kTn6HBcQawhqD
 iZSs+KBRZFtNy5cIzqvsXprg7ZAp/HTgZopqKXGrAD92Eb9CecG/nvV2a8vrlksqpskk
 EOKfunOTYpBM1hicLCDyLQH4x/XrdqJVK1xBRRwF6blPtmSh/1bYVpsXGpdZxZfH1GpI
 b4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747853; x=1740352653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tVFMB/4goCUjfEUwL3Yfn3+4nZ6fGLubQq1aU1yBUYo=;
 b=qcgw+SopNWiXvVi+78Z8oUpRTs5W3/H15EtbquYUPpbiDUNamYnzUNeBzKUM3GaC7/
 hLDM/ceXpiFrAz6ntfECiazmhudzGIJk1HRs8BBcu/AvtSBQCv2CDad/ZroSYvnfrHzN
 wMWRyDfCDfz6CHyiZj+NDPoq/ySenaPsZqr54hSWHOlhDKFDkngJtGl8Ky/nzJdHQ1yb
 hYJTNy1a64/8QJBrKtrFDJVDlX4Fe16FAbpL4XOlPFkGxX07nsS2x/LgncRuIpm3lbBN
 Vgm110M74F1+1ALH4SzQW/avXPNSsZo13V5Rr6EqDuYgceiPv0/QgXWhEvd/TBZ3tD/L
 6cKQ==
X-Gm-Message-State: AOJu0Yw6SOht4zR8QYtKeEpBIf0zel1plen6rilYQy/CSwnXkV1fUx4N
 0cMvP4Ybf6fzz8uLbXOP1brW5W8TNe5pnKn+qwcdtfxoIgtPh37baixTm5W0kpeSnHI0ABRPe/1
 e
X-Gm-Gg: ASbGncsnAbqkXM7eF1/7JYZqRADjpAciCz4sQef43wKJlHP0IVWjDoqLZ7fmFgpUd9O
 alaBadVXRJpP0Tp3Hqry/mUi1J7D/RkSF0xwHbsoR99kPCW4yF44TuLyDfjG+09tLXmxWgTouWs
 F4sEmPuulNWBQvFU9YMgbUPl9ewS0rdZiiyBuiiAb50XaHfoVHhsYD9ZFPT0ybO5rwTy5hTCV7k
 0CdB9+va9fPXTBfbsvq9issKFYtMi/ShtS8de5DjcWGw8ifSLa2qlBa0EoOhBeAva/7m6MmZkgu
 5Aj3LdoaOP7wR+9vyGbOI+155B/Ine+c/ILXE1o9C8792Ds=
X-Google-Smtp-Source: AGHT+IEjgu1xwZI+qfYG2aIsh/jeHP5EGEYCXs1GqIRJuAslNDcx05Wc35/YKTjhdvBOsh/28efhcg==
X-Received: by 2002:a17:902:cccc:b0:220:e04e:7213 with SMTP id
 d9443c01a7336-22104042474mr123049365ad.25.1739747852695; 
 Sun, 16 Feb 2025 15:17:32 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 104/162] tcg: Merge INDEX_op_extract2_{i32,i64}
Date: Sun, 16 Feb 2025 15:09:13 -0800
Message-ID: <20250216231012.2808572-105-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h      |  5 +----
 tcg/optimize.c             | 10 +++++-----
 tcg/tcg-op.c               | 16 ++++++++--------
 tcg/tcg.c                  |  6 ++----
 docs/devel/tcg-ops.rst     |  4 ++--
 target/i386/tcg/emit.c.inc | 12 +-----------
 6 files changed, 19 insertions(+), 34 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index c6848b3c63..1f995c54be 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -56,6 +56,7 @@ DEF(divu, 1, 2, 0, TCG_OPF_INT)
 DEF(divu2, 2, 3, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(extract, 1, 1, 2, TCG_OPF_INT)
+DEF(extract2, 1, 2, 1, TCG_OPF_INT)
 DEF(movcond, 1, 4, 1, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
 DEF(muls2, 2, 2, 0, TCG_OPF_INT)
@@ -90,8 +91,6 @@ DEF(ld_i32, 1, 1, 1, 0)
 DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
-/* shifts/rotates */
-DEF(extract2_i32, 1, 2, 1, 0)
 
 DEF(add2_i32, 2, 4, 0, 0)
 DEF(sub2_i32, 2, 4, 0, 0)
@@ -110,8 +109,6 @@ DEF(st8_i64, 0, 2, 1, 0)
 DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
-/* shifts/rotates */
-DEF(extract2_i64, 1, 2, 1, 0)
 
 /* size changing ops */
 DEF(ext_i32_i64, 1, 1, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index f1adea829b..9595b32d54 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1861,12 +1861,12 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
         uint64_t v2 = arg_info(op->args[2])->val;
         int shr = op->args[3];
 
-        if (op->opc == INDEX_op_extract2_i64) {
-            v1 >>= shr;
-            v2 <<= 64 - shr;
-        } else {
+        if (ctx->type == TCG_TYPE_I32) {
             v1 = (uint32_t)v1 >> shr;
             v2 = (uint64_t)((int32_t)v2 << (32 - shr));
+        } else {
+            v1 >>= shr;
+            v2 <<= 64 - shr;
         }
         return tcg_opt_gen_movi(ctx, op, op->args[0], v1 | v2);
     }
@@ -2866,7 +2866,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_extract:
             done = fold_extract(&ctx, op);
             break;
-        CASE_OP_32_64(extract2):
+        case INDEX_op_extract2:
             done = fold_extract2(&ctx, op);
             break;
         case INDEX_op_ext_i32_i64:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 5f95350d5d..edbb214f7c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -921,7 +921,7 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
 
     t1 = tcg_temp_ebb_new_i32();
 
-    if (tcg_op_supported(INDEX_op_extract2_i32, TCG_TYPE_I32, 0)) {
+    if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I32, 0)) {
         if (ofs + len == 32) {
             tcg_gen_shli_i32(t1, arg1, len);
             tcg_gen_extract2_i32(ret, t1, arg2, len);
@@ -1077,8 +1077,8 @@ void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
         tcg_gen_mov_i32(ret, ah);
     } else if (al == ah) {
         tcg_gen_rotri_i32(ret, al, ofs);
-    } else if (tcg_op_supported(INDEX_op_extract2_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op4i_i32(INDEX_op_extract2_i32, ret, al, ah, ofs);
+    } else if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I32, 0)) {
+        tcg_gen_op4i_i32(INDEX_op_extract2, ret, al, ah, ofs);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_shri_i32(t0, al, ofs);
@@ -1799,7 +1799,7 @@ static inline void tcg_gen_shifti_i64(TCGv_i64 ret, TCGv_i64 arg1,
             tcg_gen_movi_i32(TCGV_LOW(ret), 0);
         }
     } else if (right) {
-        if (tcg_op_supported(INDEX_op_extract2_i32, TCG_TYPE_I32, 0)) {
+        if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I32, 0)) {
             tcg_gen_extract2_i32(TCGV_LOW(ret),
                                  TCGV_LOW(arg1), TCGV_HIGH(arg1), c);
         } else {
@@ -1813,7 +1813,7 @@ static inline void tcg_gen_shifti_i64(TCGv_i64 ret, TCGv_i64 arg1,
             tcg_gen_shri_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
         }
     } else {
-        if (tcg_op_supported(INDEX_op_extract2_i32, TCG_TYPE_I32, 0)) {
+        if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I32, 0)) {
             tcg_gen_extract2_i32(TCGV_HIGH(ret),
                                  TCGV_LOW(arg1), TCGV_HIGH(arg1), 32 - c);
         } else {
@@ -2553,7 +2553,7 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
 
     t1 = tcg_temp_ebb_new_i64();
 
-    if (tcg_op_supported(INDEX_op_extract2_i64, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I64, 0)) {
         if (ofs + len == 64) {
             tcg_gen_shli_i64(t1, arg1, len);
             tcg_gen_extract2_i64(ret, t1, arg2, len);
@@ -2781,8 +2781,8 @@ void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
         tcg_gen_mov_i64(ret, ah);
     } else if (al == ah) {
         tcg_gen_rotri_i64(ret, al, ofs);
-    } else if (tcg_op_supported(INDEX_op_extract2_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op4i_i64(INDEX_op_extract2_i64, ret, al, ah, ofs);
+    } else if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I64, 0)) {
+        tcg_gen_op4i_i64(INDEX_op_extract2, ret, al, ah, ofs);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         tcg_gen_shri_i64(t0, al, ofs);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index c96df10fe0..c54fe90309 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1146,8 +1146,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_divu2, TCGOutOpDivRem, outop_divu2),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_extract, TCGOutOpExtract, outop_extract),
-    OUTOP(INDEX_op_extract2_i32, TCGOutOpExtract2, outop_extract2),
-    OUTOP(INDEX_op_extract2_i64, TCGOutOpExtract2, outop_extract2),
+    OUTOP(INDEX_op_extract2, TCGOutOpExtract2, outop_extract2),
     OUTOP(INDEX_op_movcond, TCGOutOpMovcond, outop_movcond),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_muls2, TCGOutOpMul2, outop_muls2),
@@ -5585,8 +5584,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_extract2_i32:
-    case INDEX_op_extract2_i64:
+    case INDEX_op_extract2:
         {
             const TCGOutOpExtract2 *out = &outop_extract2;
 
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index aea8a897bd..9392d88069 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -476,9 +476,9 @@ Misc
        |
        | (using an arithmetic right shift) on TCG_TYPE_I32.
 
-   * - extract2_i32/i64 *dest*, *t1*, *t2*, *pos*
+   * - extract2 *dest*, *t1*, *t2*, *pos*
 
-     - | For N = {32,64}, extract an N-bit quantity from the concatenation
+     - | For TCG_TYPE_I{N}, extract an N-bit quantity from the concatenation
          of *t2*:*t1*, beginning at *pos*. The tcg_gen_extract2_{i32,i64} expander
          accepts 0 <= *pos* <= N as inputs. The backend code generator will
          not see either 0 or N as inputs for these opcodes.
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 0fa1664a24..a3cba8d791 100644
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
@@ -2997,7 +2987,7 @@ static void gen_PMOVMSKB(DisasContext *s, X86DecodedInsn *decode)
     tcg_gen_ld8u_tl(s->T0, tcg_env, offsetof(CPUX86State, xmm_t0.ZMM_B(vec_len - 1)));
     while (vec_len > 8) {
         vec_len -= 8;
-        if (tcg_op_supported(INDEX_op_extract2_tl, TCG_TYPE_TL, 0)) {
+        if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_TL, 0)) {
             /*
              * Load the next byte of the result into the high byte of T.
              * TCG does a similar expansion of deposit to shl+extract2; by
-- 
2.43.0


