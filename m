Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8669EC48292
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkFY-0002wH-0x; Sun, 04 Feb 2024 16:42:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFN-0002bt-W9
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:54 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFM-0003ZF-29
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:53 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d953fa3286so26175705ad.2
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082911; x=1707687711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1PZbgXf7h9mbijZSSPVJBmVbPzLYGP5B2/srtOcMXg4=;
 b=fK+KUwmmEcSf8ocga9VcPhl/uz47PhvIDlYX8cfeglHSBDevSDoT3yqyz9zl3Wp48e
 mWpXKn2CNFTXCITBSyIktJZeyNF7e2t9Z6f0I/oLoMHLswc6ixcJSAiOqLDdK5eRYVBk
 I6fZaCMWaoPWe6Xq5ORwbA7S8LsmFuWSDQ35LVZZcI1wY7eSQwCRuEZTJVLmEDKtgr1W
 QcdRnnN8N631yq4pHad9YQ0KlLjCbjNEJNLP0+dwIEDD9vfsJ9w4C0VcWfuIb8eOzSD2
 EXUIJimXAKjJ51HA/aMi2rKCB9Df2x+ykmNwqmeYIW+xkEnZw06q23jX5+/WrHzy9Kp7
 82ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082911; x=1707687711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1PZbgXf7h9mbijZSSPVJBmVbPzLYGP5B2/srtOcMXg4=;
 b=N7dtK+MtbnTMOhq/bjVX8BzD7a/VCDT6waOI2iMJy7OqvlXgWDiN0czUcx2C/BXqOW
 o3v5/nrlS+Gwp/oEZBLsXuOLlSFoXkV6Q6SruV26tOTMz0O3/iiK5VGOz9i9zZnZX2Rm
 tMKpLpcgEoKgAlVa2C0POPsQiYf3Mr8OZkniOvfXGcpLr3eJN1GQtBcmMvhDSu82AvLx
 Sk/hGx961NSoDQ9vc9Np4/zkMfzjbP1+b17ihPeUjXSF2OI98qlKYoUmUW5e8lOpJTWM
 L9y+DaaeiszpL16Wt4PfdQpBVFRQV1wuLDJiDCjF6Eozg9aqxByrfpANMQnJKKcSV3Du
 MFQw==
X-Gm-Message-State: AOJu0YzrWvcrcvpsFuiHBLIpLC/MsrHc/az3WzuEWdte14A++/TD8jN9
 F05F2G7upqOHfVO+SXRPnrMFuHIXGv/ALfjHyvbn9YGG2nUEWvSqgufTbnU26xXeM2WGK+a4Sq7
 bvEg=
X-Google-Smtp-Source: AGHT+IFGR0JkqjjCKFTCDvkF5rjZ/D/L18e11ZFko7+UZs1ftVDix1E6lVsUX8VI+hhg1fJgmaFxLQ==
X-Received: by 2002:a17:903:28e:b0:1d8:f016:cfae with SMTP id
 j14-20020a170903028e00b001d8f016cfaemr16394473plr.0.1707082910817; 
 Sun, 04 Feb 2024 13:41:50 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/39] tcg/i386: Improve TSTNE/TESTEQ vs powers of two
Date: Mon,  5 Feb 2024 07:40:39 +1000
Message-Id: <20240204214052.5639-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Use "test x,x" when the bit is one of the 4 sign bits.
Use "bt imm,x" otherwise.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target-con-set.h |  6 ++--
 tcg/i386/tcg-target-con-str.h |  1 +
 tcg/i386/tcg-target.c.inc     | 54 +++++++++++++++++++++++++++++++----
 3 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/tcg/i386/tcg-target-con-set.h b/tcg/i386/tcg-target-con-set.h
index 7d00a7dde8..e24241cfa2 100644
--- a/tcg/i386/tcg-target-con-set.h
+++ b/tcg/i386/tcg-target-con-set.h
@@ -20,7 +20,7 @@ C_O0_I2(L, L)
 C_O0_I2(qi, r)
 C_O0_I2(re, r)
 C_O0_I2(ri, r)
-C_O0_I2(r, re)
+C_O0_I2(r, reT)
 C_O0_I2(s, L)
 C_O0_I2(x, r)
 C_O0_I3(L, L, L)
@@ -34,7 +34,7 @@ C_O1_I1(r, r)
 C_O1_I1(x, r)
 C_O1_I1(x, x)
 C_O1_I2(q, 0, qi)
-C_O1_I2(q, r, re)
+C_O1_I2(q, r, reT)
 C_O1_I2(r, 0, ci)
 C_O1_I2(r, 0, r)
 C_O1_I2(r, 0, re)
@@ -50,7 +50,7 @@ C_N1_I2(r, r, r)
 C_N1_I2(r, r, rW)
 C_O1_I3(x, 0, x, x)
 C_O1_I3(x, x, x, x)
-C_O1_I4(r, r, re, r, 0)
+C_O1_I4(r, r, reT, r, 0)
 C_O1_I4(r, r, r, ri, ri)
 C_O2_I1(r, r, L)
 C_O2_I2(a, d, a, r)
diff --git a/tcg/i386/tcg-target-con-str.h b/tcg/i386/tcg-target-con-str.h
index 95a30e58cd..cc22db227b 100644
--- a/tcg/i386/tcg-target-con-str.h
+++ b/tcg/i386/tcg-target-con-str.h
@@ -28,5 +28,6 @@ REGS('s', ALL_BYTEL_REGS & ~SOFTMMU_RESERVE_REGS)    /* qemu_st8_i32 data */
  */
 CONST('e', TCG_CT_CONST_S32)
 CONST('I', TCG_CT_CONST_I32)
+CONST('T', TCG_CT_CONST_TST)
 CONST('W', TCG_CT_CONST_WSZ)
 CONST('Z', TCG_CT_CONST_U32)
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index f2414177bd..0b8c60d021 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -132,6 +132,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_U32 0x200
 #define TCG_CT_CONST_I32 0x400
 #define TCG_CT_CONST_WSZ 0x800
+#define TCG_CT_CONST_TST 0x1000
 
 /* Registers used with L constraint, which are the first argument
    registers on x86_64, and two random call clobbered registers on
@@ -202,7 +203,8 @@ static bool tcg_target_const_match(int64_t val, int ct,
         return 1;
     }
     if (type == TCG_TYPE_I32) {
-        if (ct & (TCG_CT_CONST_S32 | TCG_CT_CONST_U32 | TCG_CT_CONST_I32)) {
+        if (ct & (TCG_CT_CONST_S32 | TCG_CT_CONST_U32 |
+                  TCG_CT_CONST_I32 | TCG_CT_CONST_TST)) {
             return 1;
         }
     } else {
@@ -215,6 +217,17 @@ static bool tcg_target_const_match(int64_t val, int ct,
         if ((ct & TCG_CT_CONST_I32) && ~val == (int32_t)~val) {
             return 1;
         }
+        /*
+         * This will be used in combination with TCG_CT_CONST_S32,
+         * so "normal" TESTQ is already matched.  Also accept:
+         *    TESTQ -> TESTL   (uint32_t)
+         *    TESTQ -> BT      (is_power_of_2)
+         */
+        if ((ct & TCG_CT_CONST_TST)
+            && is_tst_cond(cond)
+            && (val == (uint32_t)val || is_power_of_2(val))) {
+            return 1;
+        }
     }
     if ((ct & TCG_CT_CONST_WSZ) && val == (type == TCG_TYPE_I32 ? 32 : 64)) {
         return 1;
@@ -396,6 +409,7 @@ static bool tcg_target_const_match(int64_t val, int ct,
 #define OPC_SHLX        (0xf7 | P_EXT38 | P_DATA16)
 #define OPC_SHRX        (0xf7 | P_EXT38 | P_SIMDF2)
 #define OPC_SHRD_Ib     (0xac | P_EXT)
+#define OPC_TESTB	(0x84)
 #define OPC_TESTL	(0x85)
 #define OPC_TZCNT       (0xbc | P_EXT | P_SIMDF3)
 #define OPC_UD2         (0x0b | P_EXT)
@@ -442,6 +456,12 @@ static bool tcg_target_const_match(int64_t val, int ct,
 #define OPC_GRP3_Ev     (0xf7)
 #define OPC_GRP5        (0xff)
 #define OPC_GRP14       (0x73 | P_EXT | P_DATA16)
+#define OPC_GRPBT       (0xba | P_EXT)
+
+#define OPC_GRPBT_BT    4
+#define OPC_GRPBT_BTS   5
+#define OPC_GRPBT_BTR   6
+#define OPC_GRPBT_BTC   7
 
 /* Group 1 opcode extensions for 0x80-0x83.
    These are also used as modifiers for OPC_ARITH.  */
@@ -1454,7 +1474,7 @@ static void tcg_out_jxx(TCGContext *s, int opc, TCGLabel *l, bool small)
 static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
                        TCGArg arg2, int const_arg2, int rexw)
 {
-    int jz;
+    int jz, js;
 
     if (!is_tst_cond(cond)) {
         if (!const_arg2) {
@@ -1469,6 +1489,7 @@ static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
     }
 
     jz = tcg_cond_to_jcc[cond];
+    js = (cond == TCG_COND_TSTNE ? JCC_JS : JCC_JNS);
 
     if (!const_arg2) {
         tcg_out_modrm(s, OPC_TESTL + rexw, arg1, arg2);
@@ -1476,17 +1497,40 @@ static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
     }
 
     if (arg2 <= 0xff && (TCG_TARGET_REG_BITS == 64 || arg1 < 4)) {
+        if (arg2 == 0x80) {
+            tcg_out_modrm(s, OPC_TESTB | P_REXB_R, arg1, arg1);
+            return js;
+        }
         tcg_out_modrm(s, OPC_GRP3_Eb | P_REXB_RM, EXT3_TESTi, arg1);
         tcg_out8(s, arg2);
         return jz;
     }
 
     if ((arg2 & ~0xff00) == 0 && arg1 < 4) {
+        if (arg2 == 0x8000) {
+            tcg_out_modrm(s, OPC_TESTB, arg1 + 4, arg1 + 4);
+            return js;
+        }
         tcg_out_modrm(s, OPC_GRP3_Eb, EXT3_TESTi, arg1 + 4);
         tcg_out8(s, arg2 >> 8);
         return jz;
     }
 
+    if (is_power_of_2(rexw ? arg2 : (uint32_t)arg2)) {
+        int jc = (cond == TCG_COND_TSTNE ? JCC_JB : JCC_JAE);
+        int sh = ctz64(arg2);
+
+        rexw = (sh & 32 ? P_REXW : 0);
+        if ((sh & 31) == 31) {
+            tcg_out_modrm(s, OPC_TESTL | rexw, arg1, arg1);
+            return js;
+        } else {
+            tcg_out_modrm(s, OPC_GRPBT | rexw, OPC_GRPBT_BT, arg1);
+            tcg_out8(s, sh);
+            return jc;
+        }
+    }
+
     if (rexw) {
         if (arg2 == (uint32_t)arg2) {
             rexw = 0;
@@ -3399,7 +3443,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return C_O0_I2(r, re);
+        return C_O0_I2(r, reT);
 
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
@@ -3447,11 +3491,11 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_setcond_i64:
     case INDEX_op_negsetcond_i32:
     case INDEX_op_negsetcond_i64:
-        return C_O1_I2(q, r, re);
+        return C_O1_I2(q, r, reT);
 
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
-        return C_O1_I4(r, r, re, r, 0);
+        return C_O1_I4(r, r, reT, r, 0);
 
     case INDEX_op_div2_i32:
     case INDEX_op_div2_i64:
-- 
2.34.1


