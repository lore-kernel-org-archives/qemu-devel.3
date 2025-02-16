Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332ADC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnxI-0005zT-5d; Sun, 16 Feb 2025 18:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwq-0004Wp-Ey
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:17 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwh-0006Tc-Sj
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:16 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2fc0026eb79so7068676a91.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748064; x=1740352864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7XaNyUjpWtqwPBPZeQXhNxZWi96q8z6zdRnna8DyiQs=;
 b=kl2MpfIKp0Ezet4NlizInIT1xoI35AlVZTs3gtFtRrvSuLnlTZaEaAJaw2U/vMF1MF
 FFdGUA5z3F0z2sxfXe64cbxTRyCiPYB9x1oYFqSflUQxZDzferdSEHKMmv1inUjUM+Ys
 K+0t1cR1PQBU3MNmdAxJ18EqZzreMwnckJ7eoS+L8mYSlyR8Sy6xauZPlx7bFMgs4JMk
 RXlJpNpGpmlkc1Rbg7C7/2jm/a3ceikUJyOJ7YP0OJ4Iq2+Iapw/8MFhmK2Dgu0AqGWx
 u9LMnOQplKORJm17wKz4dXgpjXNfZeRK2TJy/wgwAHYqKn4oAPc/ThPAVT/PqoR2uD+/
 5cJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748064; x=1740352864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7XaNyUjpWtqwPBPZeQXhNxZWi96q8z6zdRnna8DyiQs=;
 b=g+0MKzmiGsd1mSsG96GbDVcrN+pvbQ4jG8cPoO+p0NjsWRvy9u624qz2crSfSm0CvD
 6GeFu33EjeELD+oO5NY+Ocfstt+mjBts8nGTkbQMXeZj9kInY8475EYfEuUWEDKzFtvT
 0NUZ3fKHMCVPil30Rgs2LIenh1/g9nyPGK3Jx3pYsrYt/YBz5EvBEFPB4C/0PJWI8zFj
 aoFG7LnddxKdbh+LfFwpgQfIjrI3PCN+471o4a2AuOOVatkTaQ9yQ/yP+ujIigwKS0jN
 k1jLXJ2KyI2fRX9ARmgwVbomOIqlV/+U3z6Oa+BV7pPi+B8xfp+e396kCwuHGnJcPmtk
 lWeg==
X-Gm-Message-State: AOJu0Yw2NvPcszUK7qe4Z7AN9NtXzCdR2zmHbtPv8G7V1u6sqk9l+ZCw
 8eQeP+6ykUVKxMlGl6jcqresIQeATyDKNKuu7vDcWDUKM+D/u9276Qo6cASj/2DmgCNvxqOel4O
 Z
X-Gm-Gg: ASbGncu4IXYZztsOx9njDVLS8QIHfyjSLEYnUwEsr2V1WvG+/QDxbmbpln3TXlq+g1u
 8xseBwmK6l5wz/zRmkxDZqEAU/WRvf0UZWyyUDrFEL306MP4ejtYKHg5AWkEP+GWzBwfk9OiSa6
 k8Sd2ZXRaRFLnBgX8cQ8GMAyW+UDKkPAFo2IE3e4CN8IakmFmzRKvT0LHe0m0JIx3MHlyJXa2Uf
 cSsrAtdAEDE50SsVY4fwn5/vcUemEoDjT+++QOxhknnTeYggHSZ4Vig7xnCSY0v2aPhkoG9Vm4H
 pV3uzF1j7W44KooYTaahFbm4ZCK69AzFQlbRhA65An6VKKw=
X-Google-Smtp-Source: AGHT+IF9q7eOuC+THtdjU8sHrXnMWv4am459rrtdL7Q20PDNJ+cxWSYkQYOalARRx3RCxeJq26ZtkA==
X-Received: by 2002:a17:90b:1652:b0:2f4:4003:f3d4 with SMTP id
 98e67ed59e1d1-2fc4116bc4amr10978912a91.30.1739748063729; 
 Sun, 16 Feb 2025 15:21:03 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.21.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:21:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 143/162] tcg/sparc64: Hoist tcg_cond_to_bcond lookup out of
 tcg_out_movcc
Date: Sun, 16 Feb 2025 15:09:52 -0800
Message-ID: <20250216231012.2808572-144-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Pass the sparc COND_* value not the tcg TCG_COND_* value.
This makes the usage within add2/sub2 clearer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target.c.inc | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 12f0dbd23d..350a7f6332 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -652,11 +652,10 @@ static void tcg_out_brcond_i32(TCGContext *s, TCGCond cond, TCGReg arg1,
     tcg_out_nop(s);
 }
 
-static void tcg_out_movcc(TCGContext *s, TCGCond cond, int cc, TCGReg ret,
+static void tcg_out_movcc(TCGContext *s, int scond, int cc, TCGReg ret,
                           int32_t v1, int v1const)
 {
-    tcg_out32(s, ARITH_MOVCC | cc | INSN_RD(ret)
-              | INSN_RS1(tcg_cond_to_bcond[cond])
+    tcg_out32(s, ARITH_MOVCC | cc | INSN_RD(ret) | INSN_RS1(scond)
               | (v1const ? INSN_IMM11(v1) : INSN_RS2(v1)));
 }
 
@@ -665,7 +664,7 @@ static void tcg_out_movcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
                                 int32_t v1, int v1const)
 {
     tcg_out_cmp(s, cond, c1, c2, c2const);
-    tcg_out_movcc(s, cond, MOVCC_ICC, ret, v1, v1const);
+    tcg_out_movcc(s, tcg_cond_to_bcond[cond], MOVCC_ICC, ret, v1, v1const);
 }
 
 static void tcg_out_brcond_i64(TCGContext *s, TCGCond cond, TCGReg arg1,
@@ -709,7 +708,7 @@ static void tcg_out_movcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
         tcg_out_movr(s, rcond, ret, c1, v1, v1const);
     } else {
         tcg_out_cmp(s, cond, c1, c2, c2const);
-        tcg_out_movcc(s, cond, MOVCC_XCC, ret, v1, v1const);
+        tcg_out_movcc(s, tcg_cond_to_bcond[cond], MOVCC_XCC, ret, v1, v1const);
     }
 }
 
@@ -763,7 +762,8 @@ static void tcg_out_setcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
     default:
         tcg_out_cmp(s, cond, c1, c2, c2const);
         tcg_out_movi_s13(s, ret, 0);
-        tcg_out_movcc(s, cond, MOVCC_ICC, ret, neg ? -1 : 1, 1);
+        tcg_out_movcc(s, tcg_cond_to_bcond[cond],
+                      MOVCC_ICC, ret, neg ? -1 : 1, 1);
         return;
     }
 
@@ -818,7 +818,8 @@ static void tcg_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
     } else {
         tcg_out_cmp(s, cond, c1, c2, c2const);
         tcg_out_movi_s13(s, ret, 0);
-        tcg_out_movcc(s, cond, MOVCC_XCC, ret, neg ? -1 : 1, 1);
+        tcg_out_movcc(s, tcg_cond_to_bcond[cond],
+                      MOVCC_XCC, ret, neg ? -1 : 1, 1);
     }
 }
 
@@ -956,10 +957,10 @@ static void tcg_out_addsub2_i64(TCGContext *s, TCGReg rl, TCGReg rh,
 	if (rh == ah) {
             tcg_out_arithi(s, TCG_REG_T2, ah, 1,
 			   is_sub ? ARITH_SUB : ARITH_ADD);
-            tcg_out_movcc(s, TCG_COND_LTU, MOVCC_XCC, rh, TCG_REG_T2, 0);
+            tcg_out_movcc(s, COND_CS, MOVCC_XCC, rh, TCG_REG_T2, 0);
 	} else {
             tcg_out_arithi(s, rh, ah, 1, is_sub ? ARITH_SUB : ARITH_ADD);
-	    tcg_out_movcc(s, TCG_COND_GEU, MOVCC_XCC, rh, ah, 0);
+	    tcg_out_movcc(s, COND_CC, MOVCC_XCC, rh, ah, 0);
 	}
     } else {
         /*
@@ -974,7 +975,7 @@ static void tcg_out_addsub2_i64(TCGContext *s, TCGReg rl, TCGReg rh,
                            is_sub ? ARITH_SUB : ARITH_ADD);
         }
         /* ... smoosh T2 back to original BH if carry is clear ... */
-        tcg_out_movcc(s, TCG_COND_GEU, MOVCC_XCC, TCG_REG_T2, bh, bhconst);
+        tcg_out_movcc(s, COND_CC, MOVCC_XCC, TCG_REG_T2, bh, bhconst);
 	/* ... and finally perform the arithmetic with the new operand.  */
         tcg_out_arith(s, rh, ah, TCG_REG_T2, is_sub ? ARITH_SUB : ARITH_ADD);
     }
-- 
2.43.0


