Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E4AE7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPf7-0001Iy-Ja; Thu, 02 Jan 2025 13:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPer-0007oA-1R
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:57 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPen-0006Ii-Sw
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:56 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2166651f752so183475625ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841453; x=1736446253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cxZvUAfQg2knNGhc6ZbXYqLogILLBNO801YZdlL620s=;
 b=Vb8I9u4JWyzYE6PoA/6S4jcFRdxBpcblUvgKiHQ3UIu1iRT9JEc9amL5va1N5Brfp1
 IViS/dhDg3/S19OyYOXTIgYUuv7Nm0wWr0VO13YQhCsGlv2dKiNh9T9ZPCrIfKCZJuE0
 yTBW4EAm8xkRpvK7kQuYK/lljWDcY/xp47PHC+xh80i87xx7jDKm54pFdgQOyEhbdRHr
 cag7m+fQpvfbpTgKikK3lV7BYRBtN00+9of8OJtdTkv0uA8xUbQSD/w7C6Fj8ezMGIpQ
 ehDHCeODWaSjUkSh1E/HiENT+jvQHIWLagrtlM/8w4ueFYBDPzMbAIIF4AdEu4beDh80
 LoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841453; x=1736446253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cxZvUAfQg2knNGhc6ZbXYqLogILLBNO801YZdlL620s=;
 b=LQ//HHo14FJMVSN8PmXdtuZXYjElQ1qtlMXnGgJxVP+FSPpSN/lQxhG2UYjN2w5mTY
 JWFZQzc9gp2hb9vM9Bjnp4oGJocYaaQAeNZPdU7DEfZNvtDjE39zPzYDMo5gEqPq0Vok
 3J8/qFsSk0R4+76zpu396KdXfbw8miJWpdSWI5DsRrAhkdd+JdeS1wwH5YgFWgvc9Xjg
 8ChhXF7NomHeNc59M9DcTYneQ2AeZ447z18+AAF8ictG60E2amVle/pQ8IGs0rikujv0
 b+X2AQidG/SmlVXFW4Ltyv8oOTBl1VOP/ceYG0S5IymuLQvPHIJndWqYefTLSKgf3Onj
 XakQ==
X-Gm-Message-State: AOJu0Yw4rdZqUrqAOXTIgXF9GXg/FVFZI2PGjxfwo1fQNH5aA7DhJ0nh
 +ftqenEz0m9iqvTZMQkbOXjPEV66qPDLJ+fizo67herXzYQbNR3ifd0f+pk+l5vgdmIG4tko92c
 5
X-Gm-Gg: ASbGncvq3e8QqmC9ECPZ6ps3WOsDc5s6hRjihbZYof5S15+BgSUz8pziWBtMtib0ylV
 Z4W4xbJb/EA+d/HFCgsdDag2ZLI2r7g6E+i0jLdgYFzvIiWHjrH9ZZL23rg5m8iFgiE6o24Sggp
 xMKdXsIiD8Deyn0wEc3VVVTNFTf8UQesZTZPl9IAtSP7ocWInDU8Tk6lv+w52O7/tshdWtDm9yb
 V+8x3IWOyVHgGx+3A6x5sBj/YD4ql+GynGKjdCkiCb5a25zyHUBnco/Wifflg==
X-Google-Smtp-Source: AGHT+IFHGNaaIl7zOyYZq7iQrhvWBBvOmO9agDi6Os1AuAXVWJXfK6cURttO8Vpx70zfaBPYucU8sQ==
X-Received: by 2002:a05:6a00:8087:b0:728:ea15:6d68 with SMTP id
 d2e1a72fcca58-72abde943fbmr64823530b3a.18.1735841452380; 
 Thu, 02 Jan 2025 10:10:52 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 73/73] tcg: Merge clz, ctz, ctpop operations
Date: Thu,  2 Jan 2025 10:06:53 -0800
Message-ID: <20250102180654.1420056-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
 include/tcg/tcg-opc.h            | 11 ++---
 tcg/riscv/tcg-target-con-set.h   |  2 +-
 tcg/riscv/tcg-target-con-str.h   |  1 -
 tcg/tci/tcg-target-has.h         |  6 +--
 tcg/optimize.c                   | 38 ++++++----------
 tcg/tcg-op.c                     | 12 ++---
 tcg/tcg.c                        | 20 +++------
 tcg/tci.c                        | 47 +++++---------------
 tcg/aarch64/tcg-target.c.inc     | 12 ++---
 tcg/arm/tcg-target.c.inc         |  8 ++--
 tcg/i386/tcg-target.c.inc        | 15 +++----
 tcg/loongarch64/tcg-target.c.inc | 28 ++++++------
 tcg/mips/tcg-target.c.inc        | 14 +++---
 tcg/ppc/tcg-target.c.inc         | 51 +++++++++++-----------
 tcg/riscv/tcg-target.c.inc       | 75 ++++++++++++--------------------
 tcg/s390x/tcg-target.c.inc       | 14 +++---
 tcg/tci/tcg-target.c.inc         | 15 +++----
 17 files changed, 143 insertions(+), 226 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 33c630e223..1e2efc369b 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -77,6 +77,9 @@ DEF(extract2, 1, 2, 1, TCG_OPF_INT)
 DEF(bswap16, 1, 1, 1, TCG_OPF_INT)
 DEF(bswap32, 1, 1, 1, TCG_OPF_INT)
 DEF(bswap64, 1, 1, 1, TCG_OPF_INT)
+DEF(clz, 1, 2, 0, TCG_OPF_INT)
+DEF(ctz, 1, 2, 0, TCG_OPF_INT)
+DEF(ctpop, 1, 1, 0, TCG_OPF_INT)
 
 DEF(brcond, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH | TCG_OPF_INT)
 DEF(setcond, 1, 2, 1, TCG_OPF_INT)
@@ -86,20 +89,12 @@ DEF(movcond, 1, 4, 1, TCG_OPF_INT)
 DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(setcond2_i32, 1, 4, 1, 0)
 
-DEF(clz_i32, 1, 2, 0, 0)
-DEF(ctz_i32, 1, 2, 0, 0)
-DEF(ctpop_i32, 1, 1, 0, 0)
-
 /* size changing ops */
 DEF(ext_i32_i64, 1, 1, 0, 0)
 DEF(extu_i32_i64, 1, 1, 0, 0)
 DEF(extrl_i64_i32, 1, 1, 0, 0)
 DEF(extrh_i64_i32, 1, 1, 0, 0)
 
-DEF(clz_i64, 1, 2, 0, 0)
-DEF(ctz_i64, 1, 2, 0, 0)
-DEF(ctpop_i64, 1, 1, 0, 0)
-
 /* host load/store */
 DEF(ld, 1, 1, 2, TCG_OPF_INT)
 DEF(st, 0, 2, 2, TCG_OPF_INT)
diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index 3c4ef44eb0..32a435092a 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -13,9 +13,9 @@ C_O0_I1(r)
 C_O0_I2(rZ, r)
 C_O0_I2(rZ, rZ)
 C_O1_I1(r, r)
+C_O1_I2(r, r, r)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rI)
-C_O1_I2(r, r, rJ)
 C_O1_I2(r, rZ, rN)
 C_O1_I2(r, rZ, rZ)
 C_N1_I2(r, r, rM)
diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-str.h
index 089efe96ca..33577da7bf 100644
--- a/tcg/riscv/tcg-target-con-str.h
+++ b/tcg/riscv/tcg-target-con-str.h
@@ -16,7 +16,6 @@ REGS('v', ALL_VECTOR_REGS)
  * CONST(letter, TCG_CT_CONST_* bit set)
  */
 CONST('I', TCG_CT_CONST_S12)
-CONST('J', TCG_CT_CONST_J12)
 CONST('K', TCG_CT_CONST_S5)
 CONST('L', TCG_CT_CONST_CMP_VI)
 CONST('N', TCG_CT_CONST_N12)
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 49ef7d62e9..95ec77d9c1 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -10,9 +10,9 @@
 /* optional integer instructions */
 #define TCG_TARGET_HAS_add2(T)          (T == TCG_TYPE_REG)
 #define TCG_TARGET_HAS_bswap(T)         1
-#define TCG_TARGET_HAS_clz(T)           1
-#define TCG_TARGET_HAS_ctpop(T)         1
-#define TCG_TARGET_HAS_ctz(T)           1
+#define TCG_TARGET_HAS_clz(T)           (T == TCG_TYPE_REG)
+#define TCG_TARGET_HAS_ctpop(T)         (T == TCG_TYPE_REG)
+#define TCG_TARGET_HAS_ctz(T)           (T == TCG_TYPE_REG)
 #define TCG_TARGET_HAS_div(T)           (T == TCG_TYPE_REG)
 #define TCG_TARGET_HAS_muls2(T)         (T == TCG_TYPE_REG)
 #define TCG_TARGET_HAS_mulu2(T)         (T == TCG_TYPE_REG)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 0b7a4b1aad..1b9e54d996 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -30,15 +30,6 @@
 #include "tcg-internal.h"
 #include "tcg-has.h"
 
-#define CASE_OP_32_64(x)                        \
-        glue(glue(case INDEX_op_, x), _i32):    \
-        glue(glue(case INDEX_op_, x), _i64)
-
-#define CASE_OP_32_64_VEC(x)                    \
-        glue(glue(case INDEX_op_, x), _i32):    \
-        glue(glue(case INDEX_op_, x), _i64):    \
-        glue(glue(case INDEX_op_, x), _vec)
-
 typedef struct MemCopyInfo {
     IntervalTreeNode itree;
     QSIMPLEQ_ENTRY (MemCopyInfo) next;
@@ -486,23 +477,20 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type, uint64_t x, ui
     case INDEX_op_nor_vec:
         return ~(x | y);
 
-    case INDEX_op_clz_i32:
-        return (uint32_t)x ? clz32(x) : y;
-
-    case INDEX_op_clz_i64:
+    case INDEX_op_clz:
+        if (type == TCG_TYPE_I32) {
+            return (uint32_t)x ? clz32(x) : y;
+        }
         return x ? clz64(x) : y;
 
-    case INDEX_op_ctz_i32:
-        return (uint32_t)x ? ctz32(x) : y;
-
-    case INDEX_op_ctz_i64:
+    case INDEX_op_ctz:
+        if (type == TCG_TYPE_I32) {
+            return (uint32_t)x ? ctz32(x) : y;
+        }
         return x ? ctz64(x) : y;
 
-    case INDEX_op_ctpop_i32:
-        return ctpop32(x);
-
-    case INDEX_op_ctpop_i64:
-        return ctpop64(x);
+    case INDEX_op_ctpop:
+        return type == TCG_TYPE_I32 ? ctpop32(x) : ctpop64(x);
 
     case INDEX_op_bswap16:
         x = bswap16(x);
@@ -2737,11 +2725,11 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_bswap64:
             done = fold_bswap(&ctx, op);
             break;
-        CASE_OP_32_64(clz):
-        CASE_OP_32_64(ctz):
+        case INDEX_op_clz:
+        case INDEX_op_ctz:
             done = fold_count_zeros(&ctx, op);
             break;
-        CASE_OP_32_64(ctpop):
+        case INDEX_op_ctpop:
             done = fold_ctpop(&ctx, op);
             break;
         case INDEX_op_deposit:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4f1b7605aa..69f7a2ae1a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -717,7 +717,7 @@ void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_clz(TCG_TYPE_I32)) {
-        tcg_gen_op3_i32(INDEX_op_clz_i32, ret, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_clz, ret, arg1, arg2);
     } else if (TCG_TARGET_REG_BITS == 64 &&
                TCG_TARGET_HAS_clz(TCG_TYPE_I64)) {
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
@@ -743,7 +743,7 @@ void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_ctz(TCG_TYPE_I32)) {
-        tcg_gen_op3_i32(INDEX_op_ctz_i32, ret, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_ctz, ret, arg1, arg2);
     } else if (TCG_TARGET_HAS_ctz(TCG_TYPE_I64)) {
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
         TCGv_i64 t2 = tcg_temp_ebb_new_i64();
@@ -812,7 +812,7 @@ void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
 void tcg_gen_ctpop_i32(TCGv_i32 ret, TCGv_i32 arg1)
 {
     if (TCG_TARGET_HAS_ctpop(TCG_TYPE_I32)) {
-        tcg_gen_op2_i32(INDEX_op_ctpop_i32, ret, arg1);
+        tcg_gen_op2_i32(INDEX_op_ctpop, ret, arg1);
     } else if (TCG_TARGET_HAS_ctpop(TCG_TYPE_I64)) {
         TCGv_i64 t = tcg_temp_ebb_new_i64();
         tcg_gen_extu_i32_i64(t, arg1);
@@ -2350,7 +2350,7 @@ void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64 &&
         TCG_TARGET_HAS_clz(TCG_TYPE_I64)) {
-        tcg_gen_op3_i64(INDEX_op_clz_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_clz, ret, arg1, arg2);
     } else {
         gen_helper_clz_i64(ret, arg1, arg2);
     }
@@ -2376,7 +2376,7 @@ void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
         if (TCG_TARGET_HAS_ctz(TCG_TYPE_I64)) {
-            tcg_gen_op3_i64(INDEX_op_ctz_i64, ret, arg1, arg2);
+            tcg_gen_op3_i64(INDEX_op_ctz, ret, arg1, arg2);
             return;
         }
         if (TCG_TARGET_HAS_ctpop(TCG_TYPE_I64)) {
@@ -2452,7 +2452,7 @@ void tcg_gen_ctpop_i64(TCGv_i64 ret, TCGv_i64 arg1)
 {
     if (TCG_TARGET_REG_BITS == 64) {
         if (TCG_TARGET_HAS_ctpop(TCG_TYPE_I64)) {
-            tcg_gen_op2_i64(INDEX_op_ctpop_i64, ret, arg1);
+            tcg_gen_op2_i64(INDEX_op_ctpop, ret, arg1);
             return;
         }
     } else {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index f0f733f189..98374ef69d 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2218,6 +2218,12 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_bswap32:
     case INDEX_op_bswap64:
         return has_type && TCG_TARGET_HAS_bswap(type);
+    case INDEX_op_clz:
+        return has_type && TCG_TARGET_HAS_clz(type);
+    case INDEX_op_ctpop:
+        return has_type && TCG_TARGET_HAS_ctpop(type);
+    case INDEX_op_ctz:
+        return has_type && TCG_TARGET_HAS_ctz(type);
     case INDEX_op_div:
     case INDEX_op_divu:
         return has_type && TCG_TARGET_HAS_div(type);
@@ -2255,26 +2261,12 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_sub2:
         return has_type && TCG_TARGET_HAS_sub2(type);
 
-    case INDEX_op_clz_i32:
-        return TCG_TARGET_HAS_clz(TCG_TYPE_I32);
-    case INDEX_op_ctz_i32:
-        return TCG_TARGET_HAS_ctz(TCG_TYPE_I32);
-    case INDEX_op_ctpop_i32:
-        return TCG_TARGET_HAS_ctpop(TCG_TYPE_I32);
-
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
         return TCG_TARGET_REG_BITS == 64;
 
-    case INDEX_op_clz_i64:
-        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_clz(TCG_TYPE_I64);
-    case INDEX_op_ctz_i64:
-        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_ctz(TCG_TYPE_I64);
-    case INDEX_op_ctpop_i64:
-        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_ctpop(TCG_TYPE_I64);
-
     case INDEX_op_mov_vec:
     case INDEX_op_dup_vec:
     case INDEX_op_dupm_vec:
diff --git a/tcg/tci.c b/tcg/tci.c
index ba47497f4e..68b7ba27de 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -39,6 +39,9 @@
 #define extract_tr   glue(extract, TCG_TARGET_REG_BITS)
 #define sextract_tr  glue(sextract, TCG_TARGET_REG_BITS)
 #define deposit_tr   glue(deposit, TCG_TARGET_REG_BITS)
+#define clz_tr       glue(clz, TCG_TARGET_REG_BITS)
+#define ctz_tr       glue(ctz, TCG_TARGET_REG_BITS)
+#define ctpop_tr     glue(ctpop, TCG_TARGET_REG_BITS)
 
 __thread uintptr_t tci_tb_ptr;
 
@@ -627,26 +630,18 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
                 regs[r0] = ror64(regs[r1], regs[r2] & 63);
             }
             break;
-
-            /* Arithmetic operations (32 bit). */
-
-        case INDEX_op_clz_i32:
+        case INDEX_op_clz:
             tci_args_rrr(insn, &r0, &r1, &r2);
-            tmp32 = regs[r1];
-            regs[r0] = tmp32 ? clz32(tmp32) : regs[r2];
+            regs[r0] = regs[r1] ? clz_tr(regs[r1]) : regs[r2];
             break;
-        case INDEX_op_ctz_i32:
+        case INDEX_op_ctz:
             tci_args_rrr(insn, &r0, &r1, &r2);
-            tmp32 = regs[r1];
-            regs[r0] = tmp32 ? ctz32(tmp32) : regs[r2];
+            regs[r0] = regs[r1] ? ctz_tr(regs[r1]) : regs[r2];
             break;
-        case INDEX_op_ctpop_i32:
+        case INDEX_op_ctpop:
             tci_args_rr(insn, &r0, &r1);
-            regs[r0] = ctpop32(regs[r1]);
+            regs[r0] = ctpop_tr(regs[r1]);
             break;
-
-            /* Shift/rotate operations (32 bit). */
-
         case INDEX_op_deposit:
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
             regs[r0] = deposit_tr(regs[r1], pos, len, regs[r2]);
@@ -744,21 +739,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             *(uint64_t *)ptr = regs[r0];
             break;
 
-            /* Arithmetic operations (64 bit). */
-
-        case INDEX_op_clz_i64:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = regs[r1] ? clz64(regs[r1]) : regs[r2];
-            break;
-        case INDEX_op_ctz_i64:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = regs[r1] ? ctz64(regs[r1]) : regs[r2];
-            break;
-        case INDEX_op_ctpop_i64:
-            tci_args_rr(insn, &r0, &r1);
-            regs[r0] = ctpop64(regs[r1]);
-            break;
-
             /* Shift/rotate operations (64 bit). */
 
         case INDEX_op_ext_i32_i64:
@@ -1028,8 +1008,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_bswap32:
     case INDEX_op_bswap64:
     case INDEX_op_neg:
-    case INDEX_op_ctpop_i32:
-    case INDEX_op_ctpop_i64:
+    case INDEX_op_ctpop:
         tci_args_rr(insn, &r0, &r1);
         info->fprintf_func(info->stream, "%-12s  %s, %s",
                            op_name, str_r(r0), str_r(r1));
@@ -1055,10 +1034,8 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_sar:
     case INDEX_op_rotl:
     case INDEX_op_rotr:
-    case INDEX_op_clz_i32:
-    case INDEX_op_clz_i64:
-    case INDEX_op_ctz_i32:
-    case INDEX_op_ctz_i64:
+    case INDEX_op_clz:
+    case INDEX_op_ctz:
         tci_args_rrr(insn, &r0, &r1, &r2);
         info->fprintf_func(info->stream, "%-12s  %s, %s, %s",
                            op_name, str_r(r0), str_r(r1), str_r(r2));
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 5c8d490fa4..f37a0535c3 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2330,12 +2330,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_shr(s, TCG_TYPE_I64, a0, a1, 32);
         break;
 
-    case INDEX_op_clz_i64:
-    case INDEX_op_clz_i32:
+    case INDEX_op_clz:
         tcg_out_cltz(s, ext, a0, a1, a2, c2, false);
         break;
-    case INDEX_op_ctz_i64:
-    case INDEX_op_ctz_i32:
+    case INDEX_op_ctz:
         tcg_out_cltz(s, ext, a0, a1, a2, c2, true);
         break;
 
@@ -2955,10 +2953,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_rotr:
         return C_O1_I2(r, r, ri);
 
-    case INDEX_op_clz_i32:
-    case INDEX_op_ctz_i32:
-    case INDEX_op_clz_i64:
-    case INDEX_op_ctz_i64:
+    case INDEX_op_clz:
+    case INDEX_op_ctz:
         return C_O1_I2(r, r, rAL);
 
     case INDEX_op_brcond:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 55fc420b7c..cf30667306 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2032,12 +2032,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_ctz_i32:
+    case INDEX_op_ctz:
         tcg_out_dat_reg(s, COND_AL, INSN_RBIT, TCG_REG_TMP, 0, args[1], 0);
         a1 = TCG_REG_TMP;
         goto do_clz;
 
-    case INDEX_op_clz_i32:
+    case INDEX_op_clz:
         a1 = args[1];
     do_clz:
         a0 = args[0];
@@ -2201,8 +2201,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
 
     case INDEX_op_and:
     case INDEX_op_andc:
-    case INDEX_op_clz_i32:
-    case INDEX_op_ctz_i32:
+    case INDEX_op_clz:
+    case INDEX_op_ctz:
         return C_O1_I2(r, r, rIK);
 
     case INDEX_op_mul:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 5285d2eddd..5230c388b5 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2849,13 +2849,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(ctz):
+    case INDEX_op_ctz:
         tcg_out_ctz(s, rexw, args[0], args[1], args[2], const_args[2]);
         break;
-    OP_32_64(clz):
+    case INDEX_op_clz:
         tcg_out_clz(s, rexw, args[0], args[1], args[2], const_args[2]);
         break;
-    OP_32_64(ctpop):
+    case INDEX_op_ctpop:
         tcg_out_modrm(s, OPC_POPCNT + rexw, a0, a1);
         break;
 
@@ -3718,8 +3718,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extract:
     case INDEX_op_sextract:
-    case INDEX_op_ctpop_i32:
-    case INDEX_op_ctpop_i64:
+    case INDEX_op_ctpop:
         return C_O1_I1(r, r);
 
     case INDEX_op_extract2:
@@ -3747,12 +3746,10 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_sub2:
         return C_N1_O1_I4(r, r, 0, 1, re, re);
 
-    case INDEX_op_ctz_i32:
-    case INDEX_op_ctz_i64:
+    case INDEX_op_ctz:
         return have_bmi1 ? C_N1_I2(r, r, rW) : C_N1_I2(r, r, r);
 
-    case INDEX_op_clz_i32:
-    case INDEX_op_clz_i64:
+    case INDEX_op_clz:
         return have_lzcnt ? C_N1_I2(r, r, rW) : C_N1_I2(r, r, r);
 
     case INDEX_op_qemu_ld_a32_i32:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 119823067a..f114e337b5 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1423,18 +1423,20 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_revb_d(s, a0, a1);
         break;
 
-    case INDEX_op_clz_i32:
-        tcg_out_clzctz(s, OPC_CLZ_W, a0, a1, a2, c2, true);
-        break;
-    case INDEX_op_clz_i64:
-        tcg_out_clzctz(s, OPC_CLZ_D, a0, a1, a2, c2, false);
+    case INDEX_op_clz:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_clzctz(s, OPC_CLZ_W, a0, a1, a2, c2, true);
+        } else {
+            tcg_out_clzctz(s, OPC_CLZ_D, a0, a1, a2, c2, false);
+        }
         break;
 
-    case INDEX_op_ctz_i32:
-        tcg_out_clzctz(s, OPC_CTZ_W, a0, a1, a2, c2, true);
-        break;
-    case INDEX_op_ctz_i64:
-        tcg_out_clzctz(s, OPC_CTZ_D, a0, a1, a2, c2, false);
+    case INDEX_op_ctz:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_clzctz(s, OPC_CTZ_W, a0, a1, a2, c2, true);
+        } else {
+            tcg_out_clzctz(s, OPC_CTZ_D, a0, a1, a2, c2, false);
+        }
         break;
 
     case INDEX_op_shl:
@@ -2268,10 +2270,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
         /* LoongArch reg-imm bitops have their imms ZERO-extended */
         return C_O1_I2(r, r, rU);
 
-    case INDEX_op_clz_i32:
-    case INDEX_op_clz_i64:
-    case INDEX_op_ctz_i32:
-    case INDEX_op_ctz_i64:
+    case INDEX_op_clz:
+    case INDEX_op_ctz:
         return C_O1_I2(r, r, rW);
 
     case INDEX_op_deposit:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 2f2e37d7a4..438207b38d 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2001,11 +2001,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_clz_i32:
-        tcg_out_clz(s, OPC_CLZ, OPC_CLZ_R6, 32, a0, a1, a2);
-        break;
-    case INDEX_op_clz_i64:
-        tcg_out_clz(s, OPC_DCLZ, OPC_DCLZ_R6, 64, a0, a1, a2);
+    case INDEX_op_clz:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_clz(s, OPC_CLZ, OPC_CLZ_R6, 32, a0, a1, a2);
+        } else {
+            tcg_out_clz(s, OPC_DCLZ, OPC_DCLZ_R6, 64, a0, a1, a2);
+        }
         break;
 
     case INDEX_op_deposit:
@@ -2183,8 +2184,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_rotr:
     case INDEX_op_rotl:
         return C_O1_I2(r, r, ri);
-    case INDEX_op_clz_i32:
-    case INDEX_op_clz_i64:
+    case INDEX_op_clz:
         return C_O1_I2(r, r, rWZ);
 
     case INDEX_op_deposit:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 339badea42..611e8e5f59 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3098,28 +3098,30 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out32(s, NOR | SAB(args[1], args[0], args[2]));
         break;
 
-    case INDEX_op_clz_i32:
-        tcg_out_cntxz(s, TCG_TYPE_I32, CNTLZW, args[0], args[1],
-                      args[2], const_args[2]);
+    case INDEX_op_clz:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_cntxz(s, TCG_TYPE_I32, CNTLZW, args[0], args[1],
+                          args[2], const_args[2]);
+        } else {
+            tcg_out_cntxz(s, TCG_TYPE_I64, CNTLZD, args[0], args[1],
+                          args[2], const_args[2]);
+        }
         break;
-    case INDEX_op_ctz_i32:
-        tcg_out_cntxz(s, TCG_TYPE_I32, CNTTZW, args[0], args[1],
-                      args[2], const_args[2]);
+    case INDEX_op_ctz:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_cntxz(s, TCG_TYPE_I32, CNTTZW, args[0], args[1],
+                          args[2], const_args[2]);
+        } else {
+            tcg_out_cntxz(s, TCG_TYPE_I64, CNTTZD, args[0], args[1],
+                          args[2], const_args[2]);
+        }
         break;
-    case INDEX_op_ctpop_i32:
-        tcg_out32(s, CNTPOPW | SAB(args[1], args[0], 0));
-        break;
-
-    case INDEX_op_clz_i64:
-        tcg_out_cntxz(s, TCG_TYPE_I64, CNTLZD, args[0], args[1],
-                      args[2], const_args[2]);
-        break;
-    case INDEX_op_ctz_i64:
-        tcg_out_cntxz(s, TCG_TYPE_I64, CNTTZD, args[0], args[1],
-                      args[2], const_args[2]);
-        break;
-    case INDEX_op_ctpop_i64:
-        tcg_out32(s, CNTPOPD | SAB(args[1], args[0], 0));
+    case INDEX_op_ctpop:
+        if (type == TCG_TYPE_I32) {
+            tcg_out32(s, CNTPOPW | SAB(args[1], args[0], 0));
+        } else {
+            tcg_out32(s, CNTPOPD | SAB(args[1], args[0], 0));
+        }
         break;
 
     case INDEX_op_mul:
@@ -4083,12 +4085,11 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
         return C_O0_I1(r);
 
     case INDEX_op_ld:
-    case INDEX_op_ctpop_i32:
+    case INDEX_op_ctpop:
     case INDEX_op_neg:
     case INDEX_op_not:
     case INDEX_op_extract:
     case INDEX_op_sextract:
-    case INDEX_op_ctpop_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
@@ -4140,10 +4141,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_mulsh:
         return C_O1_I2(r, r, r);
 
-    case INDEX_op_clz_i32:
-    case INDEX_op_ctz_i32:
-    case INDEX_op_clz_i64:
-    case INDEX_op_ctz_i64:
+    case INDEX_op_clz:
+    case INDEX_op_ctz:
         return C_O1_I2(r, r, rZW);
 
     case INDEX_op_brcond:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 28c1afca65..12c3cffcc0 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -116,9 +116,8 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_S12     0x200
 #define TCG_CT_CONST_N12     0x400
 #define TCG_CT_CONST_M12     0x800
-#define TCG_CT_CONST_J12    0x1000
-#define TCG_CT_CONST_S5     0x2000
-#define TCG_CT_CONST_CMP_VI 0x4000
+#define TCG_CT_CONST_S5     0x1000
+#define TCG_CT_CONST_CMP_VI 0x2000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
@@ -419,13 +418,6 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_M12) && val >= -0x7ff && val <= 0x7ff) {
         return 1;
     }
-    /*
-     * Inverse of sign extended from 12 bits: ~[-0x800, 0x7ff].
-     * Used to map ANDN back to ANDI, etc.
-     */
-    if ((ct & TCG_CT_CONST_J12) && ~val >= -0x800 && ~val <= 0x7ff) {
-        return 1;
-    }
     /*
      * Sign extended from 5 bits: [-0x10, 0x0f].
      * Used for vector-immediate.
@@ -2075,25 +2067,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     case INDEX_op_andc:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_ANDI, a0, a1, ~a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_ANDN, a0, a1, a2);
-        }
+        tcg_out_opc_reg(s, OPC_ANDN, a0, a1, a2);
         break;
     case INDEX_op_orc:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_ORI, a0, a1, ~a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_ORN, a0, a1, a2);
-        }
+        tcg_out_opc_reg(s, OPC_ORN, a0, a1, a2);
         break;
     case INDEX_op_eqv:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_XORI, a0, a1, ~a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_XNOR, a0, a1, a2);
-        }
+        tcg_out_opc_reg(s, OPC_XNOR, a0, a1, a2);
         break;
 
     case INDEX_op_not:
@@ -2235,24 +2215,28 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_ctpop_i32:
-        tcg_out_opc_imm(s, OPC_CPOPW, a0, a1, 0);
-        break;
-    case INDEX_op_ctpop_i64:
-        tcg_out_opc_imm(s, OPC_CPOP, a0, a1, 0);
+    case INDEX_op_ctpop:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_opc_imm(s, OPC_CPOPW, a0, a1, 0);
+        } else {
+            tcg_out_opc_imm(s, OPC_CPOP, a0, a1, 0);
+        }
         break;
 
-    case INDEX_op_clz_i32:
-        tcg_out_cltz(s, TCG_TYPE_I32, OPC_CLZW, a0, a1, a2, c2);
+    case INDEX_op_clz:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_cltz(s, TCG_TYPE_I32, OPC_CLZW, a0, a1, a2, c2);
+        } else {
+            tcg_out_cltz(s, TCG_TYPE_I64, OPC_CLZ, a0, a1, a2, c2);
+        }
         break;
-    case INDEX_op_clz_i64:
-        tcg_out_cltz(s, TCG_TYPE_I64, OPC_CLZ, a0, a1, a2, c2);
-        break;
-    case INDEX_op_ctz_i32:
-        tcg_out_cltz(s, TCG_TYPE_I32, OPC_CTZW, a0, a1, a2, c2);
-        break;
-    case INDEX_op_ctz_i64:
-        tcg_out_cltz(s, TCG_TYPE_I64, OPC_CTZ, a0, a1, a2, c2);
+
+    case INDEX_op_ctz:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_cltz(s, TCG_TYPE_I32, OPC_CTZW, a0, a1, a2, c2);
+        } else {
+            tcg_out_cltz(s, TCG_TYPE_I64, OPC_CTZ, a0, a1, a2, c2);
+        }
         break;
 
     case INDEX_op_add2:
@@ -2593,8 +2577,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_bswap16:
     case INDEX_op_bswap32:
     case INDEX_op_bswap64:
-    case INDEX_op_ctpop_i32:
-    case INDEX_op_ctpop_i64:
+    case INDEX_op_ctpop:
         return C_O1_I1(r, r);
 
     case INDEX_op_st:
@@ -2611,7 +2594,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_andc:
     case INDEX_op_orc:
     case INDEX_op_eqv:
-        return C_O1_I2(r, r, rJ);
+        return C_O1_I2(r, r, r);
 
     case INDEX_op_sub:
         return C_O1_I2(r, rZ, rN);
@@ -2632,10 +2615,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_rotr:
         return C_O1_I2(r, r, ri);
 
-    case INDEX_op_clz_i32:
-    case INDEX_op_clz_i64:
-    case INDEX_op_ctz_i32:
-    case INDEX_op_ctz_i64:
+    case INDEX_op_clz:
+    case INDEX_op_ctz:
         return C_N1_I2(r, r, rM);
 
     case INDEX_op_brcond:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index d6e6418403..c35676434b 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2668,15 +2668,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tgen_sextract(s, args[0], args[1], args[2], args[3]);
         break;
 
-    case INDEX_op_clz_i64:
+    case INDEX_op_clz:
         tgen_clz(s, args[0], args[1], args[2], const_args[2]);
         break;
 
-    case INDEX_op_ctpop_i32:
-        tgen_ctpop(s, TCG_TYPE_I32, args[0], args[1]);
-        break;
-    case INDEX_op_ctpop_i64:
-        tgen_ctpop(s, TCG_TYPE_I64, args[0], args[1]);
+    case INDEX_op_ctpop:
+        tgen_ctpop(s, type, args[0], args[1]);
         break;
 
     case INDEX_op_mb:
@@ -3160,7 +3157,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_negsetcond:
         return C_O1_I2(r, r, rC);
 
-    case INDEX_op_clz_i64:
+    case INDEX_op_clz:
         return C_O1_I2(r, r, rI);
 
     case INDEX_op_and:
@@ -3210,8 +3207,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_extract:
     case INDEX_op_sextract:
-    case INDEX_op_ctpop_i32:
-    case INDEX_op_ctpop_i64:
+    case INDEX_op_ctpop:
         return C_O1_I1(r, r);
 
     case INDEX_op_qemu_ld_a32_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index e996b5e23c..9e56ca4c8c 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -54,8 +54,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_bswap64:
     case INDEX_op_extract:
     case INDEX_op_sextract:
-    case INDEX_op_ctpop_i32:
-    case INDEX_op_ctpop_i64:
+    case INDEX_op_ctpop:
         return C_O1_I1(r, r);
 
     case INDEX_op_st:
@@ -83,10 +82,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_rotr:
     case INDEX_op_setcond:
     case INDEX_op_deposit:
-    case INDEX_op_clz_i32:
-    case INDEX_op_clz_i64:
-    case INDEX_op_ctz_i32:
-    case INDEX_op_ctz_i64:
+    case INDEX_op_clz:
+    case INDEX_op_ctz:
         return C_O1_I2(r, r, r);
 
     case INDEX_op_brcond:
@@ -722,8 +719,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_shl:
     case INDEX_op_rotl:
     case INDEX_op_rotr:
-    CASE_32_64(clz)      /* Optional (TCG_TARGET_HAS_clz_*). */
-    CASE_32_64(ctz)      /* Optional (TCG_TARGET_HAS_ctz_*). */
+    case INDEX_op_clz:
+    case INDEX_op_ctz:
         tcg_out_op_rrr(s, opc, args[0], args[1], args[2]);
         break;
 
@@ -758,7 +755,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 
     case INDEX_op_neg:
     case INDEX_op_not:
-    CASE_32_64(ctpop)    /* Optional (TCG_TARGET_HAS_ctpop_*). */
+    case INDEX_op_ctpop:
     case INDEX_op_bswap64:
         tcg_out_op_rr(s, opc, args[0], args[1]);
         break;
-- 
2.43.0


