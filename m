Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96DEC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAklB-0002w4-9d; Sun, 27 Sep 2026 05:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkP-0002U2-OM
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:39 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkN-0007RZ-Ox
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:37 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-39b910bdf2eso1023984a91.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499634; x=1791104434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FqfAA0UcHBRYeT6qkWosMqGVjWoQbjRoht/rc7A5geQ=;
 b=Ze7ijz69fCur7iu5p0gXD7Nk+GjBSOJdNYE0vt1vhRH58hRUzaU0ZrDEjWCwMhTZQQ
 VxL0OG4kS/kA/k262+sXZlt5JliROaxz8E+wGk8RXAJEFYhArdWAR17m+S8imu1BIVI4
 B53aTaqWc5s9RfL+ub56/pY6CUcY7YvJhBh4XZ4Em17aQUth1jngJq1203Nl9eGoar6W
 8hMFrDTyXBmdAeItNFglcHkqYrsGedw5jKcuzWyfzMkzUgNlJyAhkGBS8VnHllix0kXR
 ZhsWV5gXhGL6LB1Sa2G4L+NJwjwgfL1w+bJd6SdsY3h/PvR2/eJEn+TibQrXWIJ2meH+
 HFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499634; x=1791104434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FqfAA0UcHBRYeT6qkWosMqGVjWoQbjRoht/rc7A5geQ=;
 b=wW3xK2t+XNmXfSekPoTIbYfqYILCKkedHWzw79Dh+e3WOEsvKd4JZ0r/sVieZQrA3B
 D+BmPFEwy4jruFJ+Q2KYnWx79Cwie9xFNCfTpZYB6dvjlaY2GCN3LEeIoSRCQGE/p2Yc
 dQ+XL5vQB0BiuFgUMpfyT4BLGhvr2Qn+Kor67JgPpqcM7t8CCGm48kXwshpkp6kzR2sL
 Eam2Eaj8Le5FPIs7lnqS+rV7LNJnGjdKBV9N6GsCSr9dgzHkpetsP88Y2i3fzrB6Kqx8
 lyA1CHHC2wWgU2C59NMzTLdBrgvR0p9tts0/cjOix+uY7Hh35iQ8nRgpd/yHtbMTSmW7
 W0FQ==
X-Gm-Message-State: AFq9FYLqBpZ/gPF6bwSSAPQtd4QcsaO8OKGRtrg4bUdGmzD9jgdZTyEo
 CLJ0nEoiNt6/Y6v1R8LmIH2bboGMqJDIfQOT6KUlhDImQ/NHTJ66fzmP7HIVIiebx45V8l23FfU
 vQllh
X-Gm-Gg: AYBFou1vfmEGrQO2rvzpizfMef8WAx6NCGZPRRbPAi2K/YhNyXXXVwwny6Jbbme/ZDU
 6O4z82Ra/ZkmqyjvDRRaa+W3QP7erqxh2Vac755lsI6LsWgAjUjM6Og+GzWP+Q/QmkfXW/oR07T
 GuDYMVMkYnTRvffLEjrnizG1ZfQGyQy+gqq6juWqopC4NIR/HuKQ6CmQb/l8op/AsYZ9EGflm4G
 4va6BxNE0PtVPYIR+iW/qDjM6D6gZkLUPMGN8cYmzl/jXw3KhyvPW+7M+durrfmRkyZBVemMphU
 tNu+qb7PF1cZ8bSp8eZPD7e7IAtMA7lskbQ3wo+8J+dUwu25L0htSQJN90I4pKZMDWFjF0YhM1g
 cc2Lrf1e2GJ1VCoga3H6uEJdNmDhRJklOMalKoIPkRgWQ1hVVriUb0q7O8/+sBO3XIGBn8vMWLr
 +p1HzyRQyvHMgIn6BpS/wQiSN/tNy0R2hra4L4/Z6jiAded9hmVLqwY65sy4zuZz4YH5twY2VWF
 wCD9RJOVIlFL3PQ2cGxES5+X94zQQ==
X-Received: by 2002:a17:90b:384f:b0:3a0:d7e4:c4bd with SMTP id
 98e67ed59e1d1-3a0d7e4c5f3mr3584926a91.60.1790499633713; 
 Sun, 27 Sep 2026 02:00:33 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 022/101] tcg: Generic expansion of tcg_gen_shr_*
Date: Sun, 27 Sep 2026 01:58:52 -0700
Message-ID: <20260927090011.10724-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 773f1e16c41..5d72c92534d 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -313,7 +312,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 3e6dd1eaf93..573a4963b4f 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -10,6 +10,7 @@ DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
+DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8d5befb75a6..dc1734b7584 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -414,6 +414,11 @@ void tcg_gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
 }
 
+void tcg_gen_shr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    tcg_gen_op_ttt(INDEX_op_shr, type, dst, src1, src2);
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -515,11 +520,6 @@ void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_shr, ret, arg1, arg2);
-}
-
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1493,11 +1493,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_shr, ret, arg1, arg2);
-}
-
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_sar, ret, arg1, arg2);
-- 
2.53.0


