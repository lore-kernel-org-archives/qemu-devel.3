Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19069C48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkFh-00041V-W0; Sun, 04 Feb 2024 16:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFe-0003ev-MJ
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:42:10 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFc-0003cQ-QN
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:42:10 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d93ddd76adso27171915ad.2
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082927; x=1707687727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gLa7bF3d+J5rLIIpPnV3sWbEmYd7i3gQY65q07Ip5VY=;
 b=homsk3I/hZRNShqn/JxyG6c+iDbyV+69rltbvWXTFElTEbobYXW0Xqxa1RXQI7vJOb
 nup76YDL0QsLncK/83bCVsXYMJTTlG0Dls0fpIG5l1ieoIF7EeFugaHSMdH1fdRxKx+e
 3CCzaUihWmjjYLNUpfsJhSpA6Y+Nfw8T/6kqvC0f4BPk0qIM0tVuVkFBK6b0OPglr5sO
 2trwbKmPc+wkwhqT9PULTVllzTSB8zQppJh+UIzP1zhA8kN8g+NIZKXS8OZ0TNFf0CIA
 BWhGU3Lwh3sY+5DPNSKkQxbQ28JAI/cpkfRZC6qPQbHSIA0fxGwi2vf3QKtDLSYIIe9e
 9D0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082927; x=1707687727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gLa7bF3d+J5rLIIpPnV3sWbEmYd7i3gQY65q07Ip5VY=;
 b=bcwUw2t8ME4S6c9FhUUfEAKPrvApnnrnKNcwU/HKPlk1uKQ0cGbu85f7Y6zfDZFJOr
 RN34d5v2VUjStSIbhucxJg1FEr3Nf9QTTJDoHNPpHNSIARz4D3Zq1gfpCysLWFN04x2I
 McgvXnpqT2vnqAxdd5KC6Wwqt3Oj0azfNpOVlBB3faS2SdXyfEHSai3xQl+ueU6pCQ2g
 LUJPHX9vzFh/b918EEEWYmOel0YYRW4VFpvDzLdCsyLsWjGiz0owrTKYMPd0QfdetLx3
 kJO0/EhLwcAoqbvxI9aalKCgLJjx0eXHLKexsAKf48n1XvZVLaWO9Hk9Zwc2dPxcz4zK
 VSIw==
X-Gm-Message-State: AOJu0Yw2ubqdtK59awDMagZYxK5agTyPwkeGco6IgqnPMwIRVNRM9OoI
 MSD1ssWHgOo4cMZLSAatB4ydS7JRrCcklQZDeBAqQQLvB39oimhAJtY/7bAUd/WuQXMCu1toSvJ
 JgY8=
X-Google-Smtp-Source: AGHT+IHylKqO/mWMnmc/w1lL5yJtNd+mTkp5O3kgOzXzONtDqo90AC3FtDN2mV4dw3pqB5cWrfytLQ==
X-Received: by 2002:a17:902:6804:b0:1d8:b0d2:704 with SMTP id
 h4-20020a170902680400b001d8b0d20704mr13175366plk.62.1707082927540; 
 Sun, 04 Feb 2024 13:42:07 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:42:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 34/39] tcg/ppc: Add TCG_CT_CONST_CMP
Date: Mon,  5 Feb 2024 07:40:47 +1000
Message-Id: <20240204214052.5639-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
We can't yet remove the fallback to load constants into a
scratch because of tcg_out_cmp2, but that path should not
be as frequent.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target-con-set.h |  5 ++--
 tcg/ppc/tcg-target-con-str.h |  1 +
 tcg/ppc/tcg-target.c.inc     | 48 ++++++++++++++++++++++++++++++------
 3 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc/tcg-target-con-set.h
index cb47b29452..9f99bde505 100644
--- a/tcg/ppc/tcg-target-con-set.h
+++ b/tcg/ppc/tcg-target-con-set.h
@@ -11,7 +11,7 @@
  */
 C_O0_I1(r)
 C_O0_I2(r, r)
-C_O0_I2(r, ri)
+C_O0_I2(r, rC)
 C_O0_I2(v, r)
 C_O0_I3(r, r, r)
 C_O0_I3(o, m, r)
@@ -26,13 +26,14 @@ C_O1_I2(r, rI, ri)
 C_O1_I2(r, rI, rT)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, ri)
+C_O1_I2(r, r, rC)
 C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rT)
 C_O1_I2(r, r, rU)
 C_O1_I2(r, r, rZW)
 C_O1_I2(v, v, v)
 C_O1_I3(v, v, v, v)
-C_O1_I4(r, r, ri, rZ, rZ)
+C_O1_I4(r, r, rC, rZ, rZ)
 C_O1_I4(r, r, r, ri, ri)
 C_O2_I1(r, r, r)
 C_N1O1_I1(o, m, r)
diff --git a/tcg/ppc/tcg-target-con-str.h b/tcg/ppc/tcg-target-con-str.h
index 20846901de..16b687216e 100644
--- a/tcg/ppc/tcg-target-con-str.h
+++ b/tcg/ppc/tcg-target-con-str.h
@@ -16,6 +16,7 @@ REGS('v', ALL_VECTOR_REGS)
  * Define constraint letters for constants:
  * CONST(letter, TCG_CT_CONST_* bit set)
  */
+CONST('C', TCG_CT_CONST_CMP)
 CONST('I', TCG_CT_CONST_S16)
 CONST('M', TCG_CT_CONST_MONE)
 CONST('T', TCG_CT_CONST_S32)
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 26e0bc31d7..535ef2cbe7 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -92,11 +92,13 @@
 #define SZR  (TCG_TARGET_REG_BITS / 8)
 
 #define TCG_CT_CONST_S16  0x100
+#define TCG_CT_CONST_U16  0x200
 #define TCG_CT_CONST_S32  0x400
 #define TCG_CT_CONST_U32  0x800
 #define TCG_CT_CONST_ZERO 0x1000
 #define TCG_CT_CONST_MONE 0x2000
 #define TCG_CT_CONST_WSZ  0x4000
+#define TCG_CT_CONST_CMP  0x8000
 
 #define ALL_GENERAL_REGS  0xffffffffu
 #define ALL_VECTOR_REGS   0xffffffff00000000ull
@@ -296,9 +298,35 @@ static bool tcg_target_const_match(int64_t sval, int ct,
         sval = (int32_t)sval;
     }
 
+    if (ct & TCG_CT_CONST_CMP) {
+        switch (cond) {
+        case TCG_COND_EQ:
+        case TCG_COND_NE:
+            ct |= TCG_CT_CONST_S16 | TCG_CT_CONST_U16;
+            break;
+        case TCG_COND_LT:
+        case TCG_COND_GE:
+        case TCG_COND_LE:
+        case TCG_COND_GT:
+            ct |= TCG_CT_CONST_S16;
+            break;
+        case TCG_COND_LTU:
+        case TCG_COND_GEU:
+        case TCG_COND_LEU:
+        case TCG_COND_GTU:
+            ct |= TCG_CT_CONST_U16;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
     if ((ct & TCG_CT_CONST_S16) && sval == (int16_t)sval) {
         return 1;
     }
+    if ((ct & TCG_CT_CONST_U16) && uval == (uint16_t)uval) {
+        return 1;
+    }
     if ((ct & TCG_CT_CONST_S32) && sval == (int32_t)sval) {
         return 1;
     }
@@ -1682,7 +1710,10 @@ static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg2,
 
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
 
-    /* Simplify the comparisons below wrt CMPI.  */
+    /*
+     * Simplify the comparisons below wrt CMPI.
+     * All of the tests are 16-bit, so a 32-bit sign extend always works.
+     */
     if (type == TCG_TYPE_I32) {
         arg2 = (int32_t)arg2;
     }
@@ -3991,8 +4022,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sar_i32:
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
-    case INDEX_op_setcond_i32:
-    case INDEX_op_negsetcond_i32:
     case INDEX_op_and_i64:
     case INDEX_op_andc_i64:
     case INDEX_op_shl_i64:
@@ -4000,8 +4029,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sar_i64:
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i64:
-    case INDEX_op_setcond_i64:
-    case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, ri);
 
     case INDEX_op_mul_i32:
@@ -4045,11 +4072,16 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return C_O0_I2(r, ri);
-
+        return C_O0_I2(r, rC);
+    case INDEX_op_setcond_i32:
+    case INDEX_op_setcond_i64:
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
+        return C_O1_I2(r, r, rC);
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
-        return C_O1_I4(r, r, ri, rZ, rZ);
+        return C_O1_I4(r, r, rC, rZ, rZ);
+
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
         return C_O1_I2(r, 0, rZ);
-- 
2.34.1


