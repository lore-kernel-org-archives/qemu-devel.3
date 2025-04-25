Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FAAC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R8x-0007EG-Jm; Fri, 25 Apr 2025 18:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7Z-0004re-Ew
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:09 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7T-0001Jg-BV
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:08 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b0b2d1f2845so2029075a12.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618521; x=1746223321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IvtPrV+CidtBjJQ2rZmHCtyf+43GCBYiLIHyO7tNVKY=;
 b=P0OLBj7Gke4UW4OhEF6EBNfaDLUoEnf0BHy/s2Xjd+BlprC1E7YBY00ESuHK4Lhu1V
 y/AQsdVgvUwK7YlbqYfKcIPB6SXCg7qmdB6mB9AHkM3IQcA+/0Jg1uO8S1/NZO2Ji33O
 9+Ep2NmQAHlkFw+cUehg1weRSkz1Tj+bOvLqmZmL2mOP3zqCnJs9svX/zUbf1EIRn0xa
 Ugzs4PIT6o/hJQgF8qFO1Wv5PoghJ8w14b3xJzqIRKRkBjC4MeUa8JwJEvb9iOmy+Lek
 hWUxY9urtOXE+6sw4Zm5H4hDR4FVMILmo6iXtj+jaNWas/95OI3xqS3LJJD7RQBAMhWW
 lP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618521; x=1746223321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IvtPrV+CidtBjJQ2rZmHCtyf+43GCBYiLIHyO7tNVKY=;
 b=Q0msU28zTRT/ok66PVxDta/YccuQB4FjWUMZRIKvdkq1+uHZBTR1Hy+P63xpNVw5QI
 6Sq5j1f93LWNklYpCc0hehabXj3g//jrPKpfylK2bXiuCiTpHAx2N5EPBqrmw/XX84lJ
 WRuoMGifuVcv+R3/F89H1o4Sk0Arnh1Wd3uhVFEJ5Mi1XHlmYI249NRKOxsHJ0PSg4/L
 3h8zUMw7QzA1/xVMMcZck2D1Te1DROq4hQCRCT/jFaBtewNAph2U/MPZg7f2iqUpFc2n
 4u9NWgIMOzwZ7Bc8UW+4d568lrAh9Erke7bOLu3/l1eBvom93IOrg2SGM5xR1NWcMvE6
 7Rig==
X-Gm-Message-State: AOJu0YxpKu+7kYNzRbomeusWkf3oVGKciwweZder4fMP0iLjXqndGevb
 BTjC8G7DJG6MWreR30sH1MMIKWFL1A7OjCBr6uo96O+ixJByEfRMOTvDGcT/f5qcFEJzGG2SRZr
 9
X-Gm-Gg: ASbGncsoMVdGOmrglCLT8SRFyWeU2s4hUGZrs4KnMNEqcaqvhKgL48Zy3JyEQKwIfeu
 YO2qijI9KAI0e7dD/DJOqvOYpLbA77ih12aP/KP83vAPtce10xIi7F1RPz9wf4pp82FrOBeo09G
 sskfdWikAAR5VILnf27WqfmUmptN55AOj5rnNO2tOktrYDa2/1fZgJOmZ5Z1nDNLkprAxlXyIdM
 7LMYldamiTO94Z/n+ojQaBLVo6Qn2HfBnGn9dt2+/re+eLnDUhIP/VL+HLhzgOjWzJqMHDHOKLU
 uwp6lA7V7yvMa61ktdMfR0OEe25iFITbqsAC/8oXLU+hVV7WEgJ6URsMw8ZkSAvLMSk6j9+NYEE
 =
X-Google-Smtp-Source: AGHT+IGVo6tGfgi/YmPPAtGJ7KGQzuSb3X1f3QmKlg+k7emHQEXKKvSR4Tu8jI3guaBdL3qXuB2PNg==
X-Received: by 2002:a17:90b:520f:b0:2f9:c139:b61f with SMTP id
 98e67ed59e1d1-309f8d9b077mr6181892a91.14.1745618521530; 
 Fri, 25 Apr 2025 15:02:01 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 086/159] tcg/ppc: Drop fallback constant loading in tcg_out_cmp
Date: Fri, 25 Apr 2025 14:53:40 -0700
Message-ID: <20250425215454.886111-87-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Use U and C constraints for brcond2 and setcond2, so that tcg_out_cmp2
automatically passes in-range constants to tcg_out_cmp.

Tested-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target-con-set.h |  4 +--
 tcg/ppc/tcg-target.c.inc     | 49 ++++++++++++------------------------
 2 files changed, 18 insertions(+), 35 deletions(-)

diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc/tcg-target-con-set.h
index 77a1038d51..14cd217287 100644
--- a/tcg/ppc/tcg-target-con-set.h
+++ b/tcg/ppc/tcg-target-con-set.h
@@ -15,7 +15,7 @@ C_O0_I2(r, rC)
 C_O0_I2(v, r)
 C_O0_I3(r, r, r)
 C_O0_I3(o, m, r)
-C_O0_I4(r, r, ri, ri)
+C_O0_I4(r, r, rU, rC)
 C_O0_I4(r, r, r, r)
 C_O1_I1(r, r)
 C_O1_I1(v, r)
@@ -34,7 +34,7 @@ C_O1_I2(v, v, v)
 C_O1_I3(v, v, v, v)
 C_O1_I4(v, v, v, vZM, v)
 C_O1_I4(r, r, rC, rZ, rZ)
-C_O1_I4(r, r, r, ri, ri)
+C_O1_I4(r, r, r, rU, rC)
 C_O2_I1(r, r, r)
 C_N1O1_I1(o, m, r)
 C_O2_I2(r, r, r, r)
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 339b3a0904..1782d05290 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1777,9 +1777,8 @@ static void tcg_out_test(TCGContext *s, TCGReg dest, TCGReg arg1, TCGArg arg2,
 }
 
 static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg2,
-                        int const_arg2, int cr, TCGType type)
+                        bool const_arg2, int cr, TCGType type)
 {
-    int imm;
     uint32_t op;
 
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
@@ -1796,18 +1795,15 @@ static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg2,
     case TCG_COND_EQ:
     case TCG_COND_NE:
         if (const_arg2) {
-            if ((int16_t) arg2 == arg2) {
+            if ((int16_t)arg2 == arg2) {
                 op = CMPI;
-                imm = 1;
-                break;
-            } else if ((uint16_t) arg2 == arg2) {
-                op = CMPLI;
-                imm = 1;
                 break;
             }
+            tcg_debug_assert((uint16_t)arg2 == arg2);
+            op = CMPLI;
+            break;
         }
         op = CMPL;
-        imm = 0;
         break;
 
     case TCG_COND_TSTEQ:
@@ -1821,14 +1817,11 @@ static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg2,
     case TCG_COND_LE:
     case TCG_COND_GT:
         if (const_arg2) {
-            if ((int16_t) arg2 == arg2) {
-                op = CMPI;
-                imm = 1;
-                break;
-            }
+            tcg_debug_assert((int16_t)arg2 == arg2);
+            op = CMPI;
+            break;
         }
         op = CMP;
-        imm = 0;
         break;
 
     case TCG_COND_LTU:
@@ -1836,30 +1829,20 @@ static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg2,
     case TCG_COND_LEU:
     case TCG_COND_GTU:
         if (const_arg2) {
-            if ((uint16_t) arg2 == arg2) {
-                op = CMPLI;
-                imm = 1;
-                break;
-            }
+            tcg_debug_assert((uint16_t)arg2 == arg2);
+            op = CMPLI;
+            break;
         }
         op = CMPL;
-        imm = 0;
         break;
 
     default:
         g_assert_not_reached();
     }
     op |= BF(cr) | ((type == TCG_TYPE_I64) << 21);
-
-    if (imm) {
-        tcg_out32(s, op | RA(arg1) | (arg2 & 0xffff));
-    } else {
-        if (const_arg2) {
-            tcg_out_movi(s, type, TCG_REG_R0, arg2);
-            arg2 = TCG_REG_R0;
-        }
-        tcg_out32(s, op | RA(arg1) | RB(arg2));
-    }
+    op |= RA(arg1);
+    op |= const_arg2 ? arg2 & 0xffff : RB(arg2);
+    tcg_out32(s, op);
 }
 
 static void tcg_out_setcond_eq0(TCGContext *s, TCGType type,
@@ -4297,9 +4280,9 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_deposit_i64:
         return C_O1_I2(r, 0, rZ);
     case INDEX_op_brcond2_i32:
-        return C_O0_I4(r, r, ri, ri);
+        return C_O0_I4(r, r, rU, rC);
     case INDEX_op_setcond2_i32:
-        return C_O1_I4(r, r, r, ri, ri);
+        return C_O1_I4(r, r, r, rU, rC);
     case INDEX_op_add2_i64:
     case INDEX_op_add2_i32:
         return C_O2_I4(r, r, r, r, rI, rZM);
-- 
2.43.0


