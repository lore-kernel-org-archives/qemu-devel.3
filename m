Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6460C4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkFn-0004Uz-T7; Sun, 04 Feb 2024 16:42:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFl-0004Ie-3c
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:42:17 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFi-0003d5-Tf
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:42:16 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d93f2c3701so18201365ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082933; x=1707687733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tzAVTurY/MAys+s1+i1OQQjHsG3DvtN9WipSnI15uxA=;
 b=mnEW53uYd3yhr8mwY1Wqnd97orS0RDqJ+UX5kxutz1QcDtMszaeM2UFJZmuGqRgR+g
 4Q3uTMqhjcgCn/eLp8Ucr++l5+oNY/OVo2+JGBG91/ZXy0GOfU6/DYzKcSWajXwsM54w
 5bv02OSBGOgmK6LpUSrbjntE2GsnQGST7fofwxO05tBpLThIttbC/pGp6Vz52dWDv443
 fA3BrsltyD2Xcn7uKkvHk6pMD5HKoCwaimyBMlf7B/Ep3vy/y1AsCXKQ9GbJdIRYuzxC
 YCntpE1RpTCQdI0flhyOtDOwjWcU8dTK8rCDYHDoTGIkHweQ47VJAbIUyNHnJJIgdpb6
 SN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082933; x=1707687733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tzAVTurY/MAys+s1+i1OQQjHsG3DvtN9WipSnI15uxA=;
 b=cSw73UoqIuH27AQnFXtlVR11fDzYtZh966b1grnr0cyFIoIAgm5IfiOYoW24JjfMHe
 75Z8aREjDGqDzLzY8lLYWV70UCLWbj3wE40sD+y6Xmhn6BAWbdcb9XEBpYpBId96ZULH
 Q8aQRkTrPl1yIUKER0AlSyKQwnuZwdEl+jkYRXMowbb5N2AnQ5hBVC44+cEEGcdypVdB
 xw7uB/4nAOu9mxUpv3Q8lvtSuxQMiw/8B/dm/8+rcm1AnwhhnKMJWqAhz1JTvbXePKfo
 3p23fHyjY9mDbCKxJ4fP16XUI24x6dFXescLOI+rAbFLSSYWskdGp6w+KKO3h52HmZUN
 T98w==
X-Gm-Message-State: AOJu0YwZDd4N1rXZ9aj9DZURZjg7mUTOIYd6+TcVYXKIhjv8v79frJf1
 OmJ+mkszHRuBuB5D9bFYGSmyv5uq3C/AlQSl1V4LuYzCjJGaYDogOI+kUq8BjxQaDYEtah4AKCz
 BvgM=
X-Google-Smtp-Source: AGHT+IFPg7Fdam8miXa6Sj4j74ucf8nYvwnygCEQseF0SX4E39m6WRq9EgMMNGqERIBzV/Z0UJ9l5g==
X-Received: by 2002:a17:902:708c:b0:1d9:63d1:e619 with SMTP id
 z12-20020a170902708c00b001d963d1e619mr7538410plk.29.1707082933639; 
 Sun, 04 Feb 2024 13:42:13 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:42:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 37/39] tcg/s390x: Add TCG_CT_CONST_CMP
Date: Mon,  5 Feb 2024 07:40:50 +1000
Message-Id: <20240204214052.5639-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Better constraint for tcg_out_cmp, based on the comparison.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target-con-set.h |  6 +--
 tcg/s390x/tcg-target-con-str.h |  1 +
 tcg/s390x/tcg-target.c.inc     | 72 +++++++++++++++++++++++++---------
 3 files changed, 58 insertions(+), 21 deletions(-)

diff --git a/tcg/s390x/tcg-target-con-set.h b/tcg/s390x/tcg-target-con-set.h
index 665851d84a..f75955eaa8 100644
--- a/tcg/s390x/tcg-target-con-set.h
+++ b/tcg/s390x/tcg-target-con-set.h
@@ -15,7 +15,7 @@
 C_O0_I1(r)
 C_O0_I2(r, r)
 C_O0_I2(r, ri)
-C_O0_I2(r, rJU)
+C_O0_I2(r, rC)
 C_O0_I2(v, r)
 C_O0_I3(o, m, r)
 C_O1_I1(r, r)
@@ -27,7 +27,7 @@ C_O1_I2(r, 0, rI)
 C_O1_I2(r, 0, rJ)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, ri)
-C_O1_I2(r, r, rJU)
+C_O1_I2(r, r, rC)
 C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rJ)
 C_O1_I2(r, r, rK)
@@ -39,7 +39,7 @@ C_O1_I2(v, v, r)
 C_O1_I2(v, v, v)
 C_O1_I3(v, v, v, v)
 C_O1_I4(r, r, ri, rI, r)
-C_O1_I4(r, r, rJU, rI, r)
+C_O1_I4(r, r, rC, rI, r)
 C_O2_I1(o, m, r)
 C_O2_I2(o, m, 0, r)
 C_O2_I2(o, m, r, r)
diff --git a/tcg/s390x/tcg-target-con-str.h b/tcg/s390x/tcg-target-con-str.h
index 9d2cb775dc..745f6c0df5 100644
--- a/tcg/s390x/tcg-target-con-str.h
+++ b/tcg/s390x/tcg-target-con-str.h
@@ -16,6 +16,7 @@ REGS('o', 0xaaaa) /* odd numbered general regs */
  * Define constraint letters for constants:
  * CONST(letter, TCG_CT_CONST_* bit set)
  */
+CONST('C', TCG_CT_CONST_CMP)
 CONST('I', TCG_CT_CONST_S16)
 CONST('J', TCG_CT_CONST_S32)
 CONST('K', TCG_CT_CONST_P32)
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index b2815ec648..7f97080f52 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -35,6 +35,7 @@
 #define TCG_CT_CONST_P32        (1 << 12)
 #define TCG_CT_CONST_INV        (1 << 13)
 #define TCG_CT_CONST_INVRISBG   (1 << 14)
+#define TCG_CT_CONST_CMP        (1 << 15)
 
 #define ALL_GENERAL_REGS     MAKE_64BIT_MASK(0, 16)
 #define ALL_VECTOR_REGS      MAKE_64BIT_MASK(32, 32)
@@ -548,6 +549,29 @@ static bool tcg_target_const_match(int64_t val, int ct,
         val = (int32_t)val;
     }
 
+    if (ct & TCG_CT_CONST_CMP) {
+        switch (cond) {
+        case TCG_COND_EQ:
+        case TCG_COND_NE:
+            ct |= TCG_CT_CONST_S32 | TCG_CT_CONST_U32;  /* CGFI or CLGFI */
+            break;
+        case TCG_COND_LT:
+        case TCG_COND_GE:
+        case TCG_COND_LE:
+        case TCG_COND_GT:
+            ct |= TCG_CT_CONST_S32;  /* CGFI */
+            break;
+        case TCG_COND_LTU:
+        case TCG_COND_GEU:
+        case TCG_COND_LEU:
+        case TCG_COND_GTU:
+            ct |= TCG_CT_CONST_U32;  /* CLGFI */
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
     if ((ct & TCG_CT_CONST_S32) && val == (int32_t)val) {
         return true;
     }
@@ -1229,22 +1253,34 @@ static int tgen_cmp2(TCGContext *s, TCGType type, TCGCond c, TCGReg r1,
             goto exit;
         }
 
-        /*
-         * Constraints are for a signed 33-bit operand, which is a
-         * convenient superset of this signed/unsigned test.
-         */
-        if (c2 == (is_unsigned ? (TCGArg)(uint32_t)c2 : (TCGArg)(int32_t)c2)) {
-            op = (is_unsigned ? RIL_CLGFI : RIL_CGFI);
-            tcg_out_insn_RIL(s, op, r1, c2);
-            goto exit;
+        /* Should match TCG_CT_CONST_CMP. */
+        switch (c) {
+        case TCG_COND_LT:
+        case TCG_COND_GE:
+        case TCG_COND_LE:
+        case TCG_COND_GT:
+            tcg_debug_assert(c2 == (int32_t)c2);
+            op = RIL_CGFI;
+            break;
+        case TCG_COND_EQ:
+        case TCG_COND_NE:
+            if (c2 == (int32_t)c2) {
+                op = RIL_CGFI;
+                break;
+            }
+            /* fall through */
+        case TCG_COND_LTU:
+        case TCG_COND_GEU:
+        case TCG_COND_LEU:
+        case TCG_COND_GTU:
+            tcg_debug_assert(c2 == (uint32_t)c2);
+            op = RIL_CLGFI;
+            break;
+        default:
+            g_assert_not_reached();
         }
-
-        /* Load everything else into a register. */
-        tcg_out_movi(s, TCG_TYPE_I64, TCG_TMP0, c2);
-        c2 = TCG_TMP0;
-    }
-
-    if (type == TCG_TYPE_I32) {
+        tcg_out_insn_RIL(s, op, r1, c2);
+    } else if (type == TCG_TYPE_I32) {
         op = (is_unsigned ? RR_CLR : RR_CR);
         tcg_out_insn_RR(s, op, r1, c2);
     } else {
@@ -3137,7 +3173,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I2(r, r, ri);
     case INDEX_op_setcond_i64:
     case INDEX_op_negsetcond_i64:
-        return C_O1_I2(r, r, rJU);
+        return C_O1_I2(r, r, rC);
 
     case INDEX_op_clz_i64:
         return C_O1_I2(r, r, rI);
@@ -3187,7 +3223,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_brcond_i32:
         return C_O0_I2(r, ri);
     case INDEX_op_brcond_i64:
-        return C_O0_I2(r, rJU);
+        return C_O0_I2(r, rC);
 
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
@@ -3240,7 +3276,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_movcond_i32:
         return C_O1_I4(r, r, ri, rI, r);
     case INDEX_op_movcond_i64:
-        return C_O1_I4(r, r, rJU, rI, r);
+        return C_O1_I4(r, r, rC, rI, r);
 
     case INDEX_op_div2_i32:
     case INDEX_op_div2_i64:
-- 
2.34.1


