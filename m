Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAF3C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RBm-0006Vf-Sx; Fri, 25 Apr 2025 18:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RB2-0003jN-7S
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:45 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAz-0001tL-Rg
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:43 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso2343313b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618740; x=1746223540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9aUhJ3YDrv4+jRmCgF1xh3mT5PHgb9ONxHaIeLozt7M=;
 b=rF0B1QVWNB7bN214YTXyDvEmn5PTXycXe+qRYB1MhvP2Optt31seuMpMcknm2AO3Z4
 mCbkmfCXluhXnvsoFNPfWJp3XLPs3TAIGN7QkYJHuB424st7IySt1XHh1VSYH1hZaguc
 Q+e9/4HiZ/V9vNCb53UAQbuAtN+xnydRKhFF2NfKStZjx4S6rin1PH34SfI0LFTrtPrT
 uDFKC4lxXMjswRLROyECf+mGpE/JGtfRY82d2jobqN7Kg0LNpCIe44lPucr9RHUoLlFi
 W88MBSoOT/3P4XMuSPxBlYARfA64JWiouVwXpnX83uwJdosTObIvr7pc7WZS8cRwV1zZ
 ZpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618740; x=1746223540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9aUhJ3YDrv4+jRmCgF1xh3mT5PHgb9ONxHaIeLozt7M=;
 b=YQbpKrVKEnLCk51m/ErkozwnluVuFzelrouNUEuvGyQ+d/dpx+Ae+p2VYzDFSqlwdC
 NbrIAud9GSrwTUhz9hSVOl5Mdz+A6fWo9jyADRQQxL5SODT8z7mOnMbuu5npoiqVQpGJ
 8Xkpkea0EyN9P5uwKKEHDU2gEFbrnrDbruM3sScPOm9M69/ZhCnyajgD3tNSMTGk9drB
 mFyHWujWZqYZk4mNNpDj5+f/eFJoc/fcBLLwnsR+geAY87mOa8zD1q+IeqgMShWACHl1
 4kgUaez2g8d108ZGslNxbmGJNETUxhkVMnsZbR3fzuBXDHeaRxnzfIizm1223HD8iE6L
 ZRgg==
X-Gm-Message-State: AOJu0Yz0IXoGiekrgiA/HNgxOwZ9+ImgKeQUP2yJQpkPARBv3hbvil0h
 io+qTTSu932/+Vin2K0J8M3JH0x3Owa6vCZN2IIQbotOOlaJhvJYAISqFuq5kFbhcPiAsLeI0nz
 M
X-Gm-Gg: ASbGncs3SGu6ht/r39tjcvecoJfXPd/s/ofjVGOL2HAn7WXV50nVC9ns2M5UNwlBQDT
 qlRKfZbOeEkharndfCeqNJYZ6uYPoBH4bE9QjPgsSSUKCjL6gbe5lwd2Wf4tB4y5amI0DaTXNJ9
 M7AFwNNe+tChAPS+fRv6d7OgeARH8JCHdFcso2cdN7/t0Khi6ZbYGL0Y6I1mTVyqL2nTcAGEIv7
 qUiFV2sgWw7VLbuzAx3pkPXvlWBJ91Gzj+gGkWreRLlb4tYhw6pA+AZXJ9xWtZJRWwLmcYKSof+
 zvLCU7/G5TKBwBYqvWNU9Sdob0G7KzU49dlkd5eUmDkJPR2vVmXeb6pcE1CR9lYxaNU0qRZ29mU
 =
X-Google-Smtp-Source: AGHT+IGSX/Qo4WOF61FYBNZjZziqPgA1CB5fULJZhEdxUrpMQW8dWps7H61vvhDYbZuAbSBmJ1JIyA==
X-Received: by 2002:a05:6a00:a92:b0:73d:fdd9:a55 with SMTP id
 d2e1a72fcca58-73fd76b94ddmr5480485b3a.8.1745618740468; 
 Fri, 25 Apr 2025 15:05:40 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 143/159] tcg/sparc64: Hoist tcg_cond_to_bcond lookup out of
 tcg_out_movcc
Date: Fri, 25 Apr 2025 14:54:37 -0700
Message-ID: <20250425215454.886111-144-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target.c.inc | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 12f0dbd23d..3f97261626 100644
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
+            tcg_out_movcc(s, COND_CC, MOVCC_XCC, rh, ah, 0);
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


