Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C20C021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjntT-00034E-6j; Sun, 16 Feb 2025 18:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnt3-0001xb-7q
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:22 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnsy-0005zh-I8
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:20 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso95148035ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747834; x=1740352634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gRBrJuNxGT72R3GDEOrTvwBOdkJ33f0r4LUontC4w0I=;
 b=dxAhONaEWwOp/JiKuxR5OKXZZP9vAdFcwc7B7LhOxIRqkUb9rCvTe0+4quO4wO9fba
 OJ3rfjvipo4rUndPpw1vNxZ6+99RZTylcNFVyv1CCQ3mK2dUnw4Fp4iR4goBkhnDQGna
 iGkh70woYyBFgsl8Fplwkx4wcSgk+4B3WF6XnL6XuEpE+lA6ZLGTDJLV+vgh+xCYcVg+
 cNx0SgjPLFBdDRZVJEvq6CRjxUYhEWiVqv0QAXG7kpGJIXPiMDhZOtHP5zSexThAFkzX
 rw7xRn7lKNiGi9/5x6X3+SSB+Wr+Wn/9dgn2iNVuebttxvDW5ViU/H60TaXvye9YnuYw
 Q59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747834; x=1740352634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gRBrJuNxGT72R3GDEOrTvwBOdkJ33f0r4LUontC4w0I=;
 b=wwQ7Bm7XSwE1drWvzJfVp4fK0G8h2Y482zC2ZNYtt4J27D+ph/hB6bxOQxNPSUM1Zn
 8t4dJoC1sLPLEl8wqkG0Hrz/kfyFFJo4NusrX4M4xTBZhLEylb/n54XHnY8wfpO8womb
 k+eq3lxIleUKMe5iN/lEWbWkIqpEE3XcYqCVPpeK02MZCE4Ha24G3+09KivWsAx3p0PE
 PUJGWm8NKOjQoc14EA3ivsH2mkqgVL98Sbti/IzmsYoAlA8fBNqgZvUbvnBC+WGDA1Gc
 cZ0AfciTPzZjn2EwjSOiOpi3ZRj0BvWWZEMxirCCxkFsPIsvEbpLCU9wlXD2w/v+3WKp
 UK0A==
X-Gm-Message-State: AOJu0YxFjagtUgZU8lJ/WNfWaLNyNl1DS8CFH6Jy8aAmLqlGLM4Ql36M
 lnG9+kQI1flomGVR5UL64a+9hgNb9TOjmcqN7pVZ/Fzws9sy0pqmjxjZ0pzqBAdC1qLJYFPkTdt
 H
X-Gm-Gg: ASbGnctOjd1KSLqYF7RzpvJO+/YaFS03TnvtO69ENDWKkbvvlyxMOKVKNgQekbkhGQn
 cM7/N5XXwB/cHuB3fk7D9hWswd9eRIda+9+vufOfGrdY9lX0otedaG+X7aOyDfsbKnooUad5pJY
 VWXTHvS89zuuFK33Y4qPUc6HTdu//PPmHNYUZAXL1bfap03W3I9GJwbLRYiEkfHika+YcqESkjz
 GD8t7i3Ddognz+k5dSBjsdT0608AVxBkKM9eZx3yZ8zMzEY7yeU5g4Xy0lkpn8YPJeo6YBSZxRl
 GA0MOB3Xsd2vk1VaZhQGj3swBzRMiJFfnkp8hISOvXZZegM=
X-Google-Smtp-Source: AGHT+IHYni5HPlhywM4LUSBmGEGe6CSTihYVkzfiO86OeEzbnyVfDR5X+i699iSU4h/xFIEmKG4JDQ==
X-Received: by 2002:a17:902:d4d0:b0:21f:7082:1137 with SMTP id
 d9443c01a7336-22104057e78mr136954285ad.22.1739747834014; 
 Sun, 16 Feb 2025 15:17:14 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 081/162] tcg/ppc: Drop fallback constant loading in
 tcg_out_cmp
Date: Sun, 16 Feb 2025 15:08:50 -0800
Message-ID: <20250216231012.2808572-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Use U and C constraints for brcond2 and setcond2, so that
tcg_out_cmp2 automatically passes in-range constants
to tcg_out_cmp.

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


