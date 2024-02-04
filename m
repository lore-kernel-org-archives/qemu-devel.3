Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7258C4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkFc-0003JQ-4A; Sun, 04 Feb 2024 16:42:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFU-0002wD-KW
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:42:02 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFS-0003bB-TA
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:42:00 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-29080973530so3085173a91.1
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082917; x=1707687717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XTZQ8U70bvvwDjHMDYUT6Xyjxfqygw11gwaeaagFYFE=;
 b=eFNQBVmPbCmOcdijg7KEpSp9IJqNMazEjT1efysaGojWLB8nC4+waa99K29G+B/gj3
 YVwi+jM30idKpF/wIfs9NbIE471kuykmoEdviiNh2aJKdVjjWWlGlP+48ewpEk+qKCK0
 p6DA1Hjj8e67vsen2I5R9HXJpUSx+DgddwAs5rrpECNKEPU/btJNgdBrS0eC6nfuv/O5
 mtgQuPQe0ln8c8yFoL1lrgBTqNVPnvGsbjy0v3/Yz1CUjH0mUdC7veFx8pXU3xLbtmZV
 pI5og1wJnABCCrZ0KXcHFgAG3WwALCg8p9NrZ5bUuK7BFzUNJRJSghq9EF0RhPOqYU0J
 Aq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082917; x=1707687717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XTZQ8U70bvvwDjHMDYUT6Xyjxfqygw11gwaeaagFYFE=;
 b=Dni18bqNZnbj8V+TBAHz7p+tUq+gFvt3IkOdsgpNw1cu2o7xoQUFl42JAuY7vZxAok
 f51cMe3Q2M+uE2j5d12zbVRGa0z6t4t9sZdzdsmckdu6K3JW9JqsXnPMjFdLgVj4J5ll
 Khhde6DwyHtuStbB/M1iW1HqP13DZiGG82+aVVT+tlFkW1ETVfBjwk6rRlKMAs4d9GIT
 B+V42vgqphXfuAJm4cwWm249mKCQzCROHQrtMjMGy6S3k2aKIXFzD3pdVaZcsnfmLsBf
 Tx+F7XAg5Vgzcy9DE/s1+z3S+G36l7MTrenvwNi1XLFug8cZCr8qEXjQjs7H4SRa0HY5
 tTcg==
X-Gm-Message-State: AOJu0Yy85IFXb3B10SBW9ClWO5XyHs3i6s6OxjSzoBNI38bEJZcJSKfp
 QRGORi6frZWWaakc4+ckfFQ3DUz9YQWx4VpSTzzJGf2kt1D2ErQF3dbY9W3h5ovS7iTYSKftpsa
 t6bE=
X-Google-Smtp-Source: AGHT+IGoeKQ2w1xat8im/jgiLNwD2ziYNoiqdTmGEwqzrYjVEqvZloWEq91RpTR0GvWpIqA5cBeKgw==
X-Received: by 2002:a17:90a:b113:b0:295:b2e5:f907 with SMTP id
 z19-20020a17090ab11300b00295b2e5f907mr7658721pjq.4.1707082917363; 
 Sun, 04 Feb 2024 13:41:57 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/39] tcg/sparc64: Pass TCGCond to tcg_out_cmp
Date: Mon,  5 Feb 2024 07:40:42 +1000
Message-Id: <20240204214052.5639-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target.c.inc | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index e16b25e309..10fb8a1a0d 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -646,7 +646,8 @@ static void tcg_out_bpcc(TCGContext *s, int scond, int flags, TCGLabel *l)
     tcg_out_bpcc0(s, scond, flags, off19);
 }
 
-static void tcg_out_cmp(TCGContext *s, TCGReg c1, int32_t c2, int c2const)
+static void tcg_out_cmp(TCGContext *s, TCGCond cond,
+                        TCGReg c1, int32_t c2, int c2const)
 {
     tcg_out_arithc(s, TCG_REG_G0, c1, c2, c2const, ARITH_SUBCC);
 }
@@ -654,7 +655,7 @@ static void tcg_out_cmp(TCGContext *s, TCGReg c1, int32_t c2, int c2const)
 static void tcg_out_brcond_i32(TCGContext *s, TCGCond cond, TCGReg arg1,
                                int32_t arg2, int const_arg2, TCGLabel *l)
 {
-    tcg_out_cmp(s, arg1, arg2, const_arg2);
+    tcg_out_cmp(s, cond, arg1, arg2, const_arg2);
     tcg_out_bpcc(s, tcg_cond_to_bcond[cond], BPCC_ICC | BPCC_PT, l);
     tcg_out_nop(s);
 }
@@ -671,7 +672,7 @@ static void tcg_out_movcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
                                 TCGReg c1, int32_t c2, int c2const,
                                 int32_t v1, int v1const)
 {
-    tcg_out_cmp(s, c1, c2, c2const);
+    tcg_out_cmp(s, cond, c1, c2, c2const);
     tcg_out_movcc(s, cond, MOVCC_ICC, ret, v1, v1const);
 }
 
@@ -691,7 +692,7 @@ static void tcg_out_brcond_i64(TCGContext *s, TCGCond cond, TCGReg arg1,
         tcg_out32(s, INSN_OP(0) | INSN_OP2(3) | BPR_PT | INSN_RS1(arg1)
                   | INSN_COND(rcond) | off16);
     } else {
-        tcg_out_cmp(s, arg1, arg2, const_arg2);
+        tcg_out_cmp(s, cond, arg1, arg2, const_arg2);
         tcg_out_bpcc(s, tcg_cond_to_bcond[cond], BPCC_XCC | BPCC_PT, l);
     }
     tcg_out_nop(s);
@@ -715,7 +716,7 @@ static void tcg_out_movcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
     if (c2 == 0 && rcond && (!v1const || check_fit_i32(v1, 10))) {
         tcg_out_movr(s, rcond, ret, c1, v1, v1const);
     } else {
-        tcg_out_cmp(s, c1, c2, c2const);
+        tcg_out_cmp(s, cond, c1, c2, c2const);
         tcg_out_movcc(s, cond, MOVCC_XCC, ret, v1, v1const);
     }
 }
@@ -759,13 +760,13 @@ static void tcg_out_setcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
         /* FALLTHRU */
 
     default:
-        tcg_out_cmp(s, c1, c2, c2const);
+        tcg_out_cmp(s, cond, c1, c2, c2const);
         tcg_out_movi_s13(s, ret, 0);
         tcg_out_movcc(s, cond, MOVCC_ICC, ret, neg ? -1 : 1, 1);
         return;
     }
 
-    tcg_out_cmp(s, c1, c2, c2const);
+    tcg_out_cmp(s, cond, c1, c2, c2const);
     if (cond == TCG_COND_LTU) {
         if (neg) {
             /* 0 - 0 - C = -C = (C ? -1 : 0) */
@@ -799,7 +800,7 @@ static void tcg_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
             c2 = c1, c2const = 0, c1 = TCG_REG_G0;
             /* FALLTHRU */
         case TCG_COND_LTU:
-            tcg_out_cmp(s, c1, c2, c2const);
+            tcg_out_cmp(s, cond, c1, c2, c2const);
             tcg_out_arith(s, ret, TCG_REG_G0, TCG_REG_G0, ARITH_ADDXC);
             return;
         default:
@@ -814,7 +815,7 @@ static void tcg_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
         tcg_out_movi_s13(s, ret, 0);
         tcg_out_movr(s, rcond, ret, c1, neg ? -1 : 1, 1);
     } else {
-        tcg_out_cmp(s, c1, c2, c2const);
+        tcg_out_cmp(s, cond, c1, c2, c2const);
         tcg_out_movi_s13(s, ret, 0);
         tcg_out_movcc(s, cond, MOVCC_XCC, ret, neg ? -1 : 1, 1);
     }
@@ -1102,7 +1103,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out_movi_s32(s, TCG_REG_T3, compare_mask);
         tcg_out_arith(s, TCG_REG_T3, addr_reg, TCG_REG_T3, ARITH_AND);
     }
-    tcg_out_cmp(s, TCG_REG_T2, TCG_REG_T3, 0);
+    tcg_out_cmp(s, TCG_COND_NE, TCG_REG_T2, TCG_REG_T3, 0);
 
     ldst = new_ldst_label(s);
     ldst->is_ld = is_ld;
-- 
2.34.1


