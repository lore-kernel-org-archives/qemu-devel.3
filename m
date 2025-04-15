Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C58C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mG9-0008MU-K1; Tue, 15 Apr 2025 15:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m5o-0008W0-07
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:18 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m50-0004YQ-5n
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:09 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2279915e06eso64364125ad.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745776; x=1745350576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7XaNyUjpWtqwPBPZeQXhNxZWi96q8z6zdRnna8DyiQs=;
 b=sSjY5zLB4Fe0IB7jmOJrn0loXMgcinDJeZ5PXbTNNgeJ8GXaJEzpy8gI+nQK3NjM2b
 2iaYOpTVxyXm+ecobUweZFrWL8CLYpsUuBUeNnF/xtlsxbyLzX6k9m2vNTPJVsZLktGw
 fzO/U15s3+TZo8iMEYtPp8fGbzPo1ccTJOXY8DUrxiJ87ycfdH2/oYkhnW9aAygH+3fJ
 wviAPtUfcq1GuKq08RhrQLGdtRNFN4mTa45YIVKHhFuMev26M4xSMeUI3HXSUOlyN3B8
 lH2z/lsy153vRt9u5wffw23s0jMk9jg1rYzqzOhchpkOlkYmgwUDFddh3vcTKFA9wsnA
 h2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745776; x=1745350576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7XaNyUjpWtqwPBPZeQXhNxZWi96q8z6zdRnna8DyiQs=;
 b=RROb84Zm8hIgMcPanbrqOUTFvU3+VDxNWigFxp5coWZ3scWmgNRUzB8oAHBmnVnANX
 yxphDUU0O9JarRi9xw7OxNb5BTLnGZqfRbdNw6iSi2AT+eMORS/JS4sBZT8aqEAe4Gvq
 SXnzidaJROgYGRSXgJywR9Pz6D/UGx3e6mtwuKAAUplWYXuqOmC/lPn4iy3kf0+E5mcI
 AgMHgzzbq5A2Ny+xlleYSmdtdaMeT+Uk8sSq4vePYi7H1gEKBNfsl+m46f9Mc0s+5eby
 IuX+XHUQAARaRfnTqhr9c6nyH0THcvI8eQuhSJq9pTz+2fwSHrTzMIginju5l0x9Zz34
 nxZg==
X-Gm-Message-State: AOJu0YxpwnxUoENE7T3S+cdoAd+O5Sk5aO/yiSgeAykhl+iHQBJDBs0h
 O+zSpJrjmq8cSnppq1I1uuFTuNvwpe195IpFlUZdZhimvowpGU3mdXLTtlSsZHQOjgR76hw9Oq8
 h
X-Gm-Gg: ASbGncuOfVFr3NLXFdlg/IV7KLArkqOpk1SUHkGwIvNB5m1XNDCpul9QK51Y7g9fPcm
 RdCeors7g/aM3wUzx4yoRIDxKgiTNzD5lLZyVrR7J2GMTTxd9fxGrlFPTsDR5eCr/p7BzSKfGgs
 2GnY64pKDLzJNO2B0h02vZKvFPm7YGKeU8snbX18v9e+aFEmi9l4UZvTRSf3MNVgG738B5JfMvh
 Yg38TpO3sXqGdYgYi4ATf0S1GpMkNWSP2/QAZsLPBAMjPx26tO7cuO90jjsMs8dDvflOXd9i8th
 X0hYCX23slGPnDzbqhScwan9F98fqfbWQd08xsOkGfKDCUHqaYSXNPl2Q5PJ4u7CsBuEDxabp9g
 =
X-Google-Smtp-Source: AGHT+IFD+HyekRdyA2+R8hoWXjSHgtuwyibbCb9S3hnFS9xvvO2HWlgyTkdfQOIo91rakTVdD7x7SQ==
X-Received: by 2002:a17:903:2451:b0:224:912:153 with SMTP id
 d9443c01a7336-22c319fe278mr6026265ad.5.1744745776058; 
 Tue, 15 Apr 2025 12:36:16 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 144/163] tcg/sparc64: Hoist tcg_cond_to_bcond lookup out of
 tcg_out_movcc
Date: Tue, 15 Apr 2025 12:24:55 -0700
Message-ID: <20250415192515.232910-145-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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


