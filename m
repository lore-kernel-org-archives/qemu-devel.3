Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5378C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RDM-0000U5-Sq; Fri, 25 Apr 2025 18:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RB0-0003if-Rp
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:44 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAy-0001t6-JI
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:42 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso2343307b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618739; x=1746223539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=01E04bycLKSOerXCOc5R9f8v+nnTAdHoN10hyl5KiEE=;
 b=yWh9uRC4nNO+TQgip2EuCeAGBodFcvIjhA81JG6vtjCgzLaZ1PS7JnkpPNyCuUoFjI
 mbJlJHfPk1HVkFJ4hG9WNSjJmPdt8woyOJueISklnM/JQUa16a+GNGVI/yOXtk4KrAVj
 hCah17mYq1SC9c+ozYv2xzxlYirspnHU4qgH4v9QnYNtGPC9roYLRMaPuI+S7ALMmmZP
 WPYisq4kXYLK6fLbs3Jmv0E9YqC+U5qJ/T6E/L5lr3STcsk+yLPjt9a6ugXCH5tehZH+
 1CStZda0RrR6iDumFaI5Z+1aonIBpAX+tE6NaFTDAy3RUhvB+rxkQVz1RffdlzSMttl6
 mnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618739; x=1746223539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=01E04bycLKSOerXCOc5R9f8v+nnTAdHoN10hyl5KiEE=;
 b=Sb2TCuRorVDVd7c2vquHtIPgbuRZ4xRCJOhIyrmkWq7N3/FfcFUqc4nqQrTBAxuDhv
 /pAx/j3gJxXTJfWX8a54B9/XdZhCJKck8IXZTF68g/hK0+DDnbDbjTBjLi/UnsR17Qa0
 y6HIlalopxvXUr9bMfuuvRAxBfiTiM+csJ+i1d39N+G6KlweO4ZOAmtrE4+Do1bYr6JO
 co8ooDMYSrJfi0uqwouqGw3dK1fZLzUkVFNWhksfxGTZyqVMnf0hH0bC7MkZWrIlnyzO
 QVUgzEqwebsyL+tmuC9QbIuXr90SNettPxUrZA5WE3i4Q/y+XxG5XsTkQgC11c8rHFhw
 wuYQ==
X-Gm-Message-State: AOJu0Yza9uXfhOX81Yj1N3FfZTHm8cVizfyJf+fMmhS3EzqSwsAxmcGf
 A0excKsSAnpxIDx5K8RGMP1F/JeMWZFbiBRx7BPaY5Zv2OWoY7wUOz/Mmyi7LwrnjMrsGa+vT6C
 i
X-Gm-Gg: ASbGnctAh+Ivi5wvYy+4e7eEDHllxw+Ocn4b/2bOc8ncED+C1sqAc9qEKG/09dHEPBI
 mwlKHGFTwLZ9taSmlRr86/qDLUETOEFjKSG42Z4MB/hHN8lgBzplsF1DIsZGGtfz2+IPV7yOd4J
 ZH8XtXTjS/BGtHHL6W/3hAh7MDjSwWtgkDjpW05oQcEMz3CFVxF6GmqscJW4D3F2OBmx6nM0z9E
 t46sBmsP1/y207uWBZfN3Td/S0cLDL57AU3AvkcpTTcjHab9hBCPykWi0mSF6wpTUQY5cS0hB0K
 oldmGL+v0Ryi5iwu99BwhW3S3CHBiwzKgT3YARY0AziiOH2HxdEt1bj744bYT1WjW14OgAcMPV0
 =
X-Google-Smtp-Source: AGHT+IHzQ1KbbN/QGPnXKJbqcj6KKCCOG7UozEWoRWZNj2iHQC4iJ38B1Yp4ZUX+cRG+HaTVQeSEug==
X-Received: by 2002:a05:6a20:d04e:b0:1fe:8f7c:c8e with SMTP id
 adf61e73a8af0-2045b5ab4b4mr5275764637.15.1745618739099; 
 Fri, 25 Apr 2025 15:05:39 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 141/159] tcg/s390x: Implement add/sub carry opcodes
Date: Fri, 25 Apr 2025 14:54:35 -0700
Message-ID: <20250425215454.886111-142-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target-con-set.h |   4 +-
 tcg/s390x/tcg-target-has.h     |   8 +-
 tcg/s390x/tcg-target.c.inc     | 153 +++++++++++++++++++--------------
 3 files changed, 96 insertions(+), 69 deletions(-)

diff --git a/tcg/s390x/tcg-target-con-set.h b/tcg/s390x/tcg-target-con-set.h
index f5d3878070..f67fd7898e 100644
--- a/tcg/s390x/tcg-target-con-set.h
+++ b/tcg/s390x/tcg-target-con-set.h
@@ -22,6 +22,7 @@ C_O1_I1(r, r)
 C_O1_I1(v, r)
 C_O1_I1(v, v)
 C_O1_I1(v, vr)
+C_O1_I2(r, 0, r)
 C_O1_I2(r, 0, ri)
 C_O1_I2(r, 0, rI)
 C_O1_I2(r, 0, rJ)
@@ -32,6 +33,7 @@ C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rJ)
 C_O1_I2(r, r, rK)
 C_O1_I2(r, r, rNKR)
+C_O1_I2(r, r, rUV)
 C_O1_I2(r, rZ, r)
 C_O1_I2(v, v, r)
 C_O1_I2(v, v, v)
@@ -43,5 +45,3 @@ C_O2_I1(o, m, r)
 C_O2_I2(o, m, 0, r)
 C_O2_I2(o, m, r, r)
 C_O2_I3(o, m, 0, 1, r)
-C_N1_O1_I4(r, r, 0, 1, ri, r)
-C_N1_O1_I4(r, r, 0, 1, rUV, r)
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 4a2b71995d..17e61130cd 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -29,13 +29,13 @@ extern uint64_t s390_facilities[3];
     ((s390_facilities[FACILITY_##X / 64] >> (63 - FACILITY_##X % 64)) & 1)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32       1
-#define TCG_TARGET_HAS_sub2_i32       1
+#define TCG_TARGET_HAS_add2_i32       0
+#define TCG_TARGET_HAS_sub2_i32       0
 #define TCG_TARGET_HAS_extr_i64_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
 
-#define TCG_TARGET_HAS_add2_i64       1
-#define TCG_TARGET_HAS_sub2_i64       1
+#define TCG_TARGET_HAS_add2_i64       0
+#define TCG_TARGET_HAS_sub2_i64       0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128 1
 
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 9b28083945..67179de848 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -173,6 +173,8 @@ typedef enum S390Opcode {
     RRE_SLBGR   = 0xb989,
     RRE_XGR     = 0xb982,
 
+    RRFa_ALRK   = 0xb9fa,
+    RRFa_ALGRK  = 0xb9ea,
     RRFa_MGRK   = 0xb9ec,
     RRFa_MSRKC  = 0xb9fd,
     RRFa_MSGRKC = 0xb9ed,
@@ -2259,21 +2261,60 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_addco_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type != TCG_TYPE_I32) {
+        tcg_out_insn(s, RRFa, ALGRK, a0, a1, a2);
+    } else if (a0 == a1) {
+        tcg_out_insn(s, RR, ALR, a0, a2);
+    } else {
+        tcg_out_insn(s, RRFa, ALRK, a0, a1, a2);
+    }
+}
+
+static void tgen_addco_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_mov(s, type, a0, a1);
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RIL, ALFI, a0, a2);
+    } else if (a2 >= 0) {
+        tcg_out_insn(s, RIL, ALGFI, a0, a2);
+    } else {
+        tcg_out_insn(s, RIL, SLGFI, a0, -a2);
+    }
+}
+
 static const TCGOutOpBinary outop_addco = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, rUV),
+    .out_rrr = tgen_addco_rrr,
+    .out_rri = tgen_addco_rri,
+};
+
+static void tgen_addcio(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RRE, ALCR, a0, a2);
+    } else {
+        tcg_out_insn(s, RRE, ALCGR, a0, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_O1_I2(r, 0, r),
+    .out_rrr = tgen_addcio,
 };
 
 static const TCGOutOpAddSubCarry outop_addci = {
-    .base.static_constraint = C_NotImplemented,
-};
-
-static const TCGOutOpBinary outop_addcio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, 0, r),
+    .out_rrr = tgen_addcio,
 };
 
 static void tcg_out_set_carry(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out_insn(s, RR, SLR, TCG_REG_R0, TCG_REG_R0); /* cc = 2 */
 }
 
 static void tgen_and(TCGContext *s, TCGType type,
@@ -2794,21 +2835,57 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static void tgen_subbo_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type != TCG_TYPE_I32) {
+        tcg_out_insn(s, RRFa, SLGRK, a0, a1, a2);
+    } else if (a0 == a1) {
+        tcg_out_insn(s, RR, SLR, a0, a2);
+    } else {
+        tcg_out_insn(s, RRFa, SLRK, a0, a1, a2);
+    }
+}
+
+static void tgen_subbo_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_mov(s, type, a0, a1);
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RIL, SLFI, a0, a2);
+    } else if (a2 >= 0) {
+        tcg_out_insn(s, RIL, SLGFI, a0, a2);
+    } else {
+        tcg_out_insn(s, RIL, ALGFI, a0, -a2);
+    }
+}
+
 static const TCGOutOpAddSubCarry outop_subbo = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, rUV),
+    .out_rrr = tgen_subbo_rrr,
+    .out_rri = tgen_subbo_rri,
 };
 
-static const TCGOutOpAddSubCarry outop_subbi = {
-    .base.static_constraint = C_NotImplemented,
-};
+static void tgen_subbio(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RRE, SLBR, a0, a2);
+    } else {
+        tcg_out_insn(s, RRE, SLBGR, a0, a2);
+    }
+}
 
 static const TCGOutOpAddSubCarry outop_subbio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, 0, r),
+    .out_rrr = tgen_subbio,
 };
 
+#define outop_subbi  outop_subbio
+
 static void tcg_out_set_borrow(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out_insn(s, RR, CLR, TCG_REG_R0, TCG_REG_R0); /* cc = 0 */
 }
 
 static void tgen_xor(TCGContext *s, TCGType type,
@@ -2967,23 +3044,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_add2_i32:
-        if (const_args[4]) {
-            tcg_out_insn(s, RIL, ALFI, args[0], args[4]);
-        } else {
-            tcg_out_insn(s, RR, ALR, args[0], args[4]);
-        }
-        tcg_out_insn(s, RRE, ALCR, args[1], args[5]);
-        break;
-    case INDEX_op_sub2_i32:
-        if (const_args[4]) {
-            tcg_out_insn(s, RIL, SLFI, args[0], args[4]);
-        } else {
-            tcg_out_insn(s, RR, SLR, args[0], args[4]);
-        }
-        tcg_out_insn(s, RRE, SLBR, args[1], args[5]);
-        break;
-
     case INDEX_op_br:
         tgen_branch(s, S390_CC_ALWAYS, arg_label(args[0]));
         break;
@@ -3027,31 +3087,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I64, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_add2_i64:
-        if (const_args[4]) {
-            if ((int64_t)args[4] >= 0) {
-                tcg_out_insn(s, RIL, ALGFI, args[0], args[4]);
-            } else {
-                tcg_out_insn(s, RIL, SLGFI, args[0], -args[4]);
-            }
-        } else {
-            tcg_out_insn(s, RRE, ALGR, args[0], args[4]);
-        }
-        tcg_out_insn(s, RRE, ALCGR, args[1], args[5]);
-        break;
-    case INDEX_op_sub2_i64:
-        if (const_args[4]) {
-            if ((int64_t)args[4] >= 0) {
-                tcg_out_insn(s, RIL, SLGFI, args[0], args[4]);
-            } else {
-                tcg_out_insn(s, RIL, ALGFI, args[0], -args[4]);
-            }
-        } else {
-            tcg_out_insn(s, RRE, SLGR, args[0], args[4]);
-        }
-        tcg_out_insn(s, RRE, SLBGR, args[1], args[5]);
-        break;
-
     case INDEX_op_mb:
         /* The host memory model is quite strong, we simply need to
            serialize the instruction stream.  */
@@ -3546,14 +3581,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i128:
         return C_O0_I3(o, m, r);
 
-    case INDEX_op_add2_i32:
-    case INDEX_op_sub2_i32:
-        return C_N1_O1_I4(r, r, 0, 1, ri, r);
-
-    case INDEX_op_add2_i64:
-    case INDEX_op_sub2_i64:
-        return C_N1_O1_I4(r, r, 0, 1, rUV, r);
-
     case INDEX_op_st_vec:
         return C_O0_I2(v, r);
     case INDEX_op_ld_vec:
-- 
2.43.0


