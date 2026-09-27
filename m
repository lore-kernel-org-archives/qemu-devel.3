Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D054DC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAklF-00037o-2K; Sun, 27 Sep 2026 05:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkp-0002Zk-AG
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:01:05 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkl-0007Ta-2J
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:01:01 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so1441050a91.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499644; x=1791104444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ro5g/Hc0T4aS4YYRwWRPL6usFUYMajhcQc1Yh1nhXeg=;
 b=aIouXy1AaZzGwNhZVQFWUB2Mx8EDfk6uCszifnchYEYEzMRpDoiW0jq77uLY/i6An3
 U3RqHwNOL26bVsKNDcp3/Ceo1kRbyYDVsAvvHdSMPiNtzokcA7Ss7dNwYBWuLBNzHXcl
 bHJyr6JRyz9i0aXCjTCNzjDd5mcpaCH5ZJrZ+haSnM95RrC2i8drfVOHS+fFm2001EcD
 DOUqvBXKISvQoLLJ4DF44/jBa6J6AMqlaLTtcvam9TjXGMCcrQUrFAFncJFIh8JaRGMZ
 +d2qLfa+giOwYCLeiHUitE+o3cbBh4DAa/3L8P1Zqd6OI4Fc5100rT5ab2nQbhKd/PTd
 eweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499644; x=1791104444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ro5g/Hc0T4aS4YYRwWRPL6usFUYMajhcQc1Yh1nhXeg=;
 b=mBKCBdVkurOgVE8oNAZFWSa307SEt35xnOKrEkoyhz0rV0WNkuilLq4lXnwuYY4tVc
 ukwevBfa4MCcwvdSx3W9u77NQ2TyypwnKmzl0xHVNq/u8CRtiRtYAMXxDoJxHyb6fQf/
 x8MIKPsaaTQA5EfFJYldxcAN8hNAnRJXP70gTsZLF+AE8k12RKz3Qmnlyl7o0xNfzctH
 G/k6JVq1+/11WkhTWRr+yHjj4nbxyV7em4GpMY2+teqRGO5Oq+L2raASxBT+mx1oEBLZ
 ql+w65T/gM6iy4WGv75EDlSQ/6cG08a+xidijPjz7Q2MbNTm7U3GOT7QZZjyQbuJEEAN
 g9lQ==
X-Gm-Message-State: AFq9FYKJ8Fg18b/fy2FNkL3VbnWC1Ewiq99SgLksF4R9jKXBzNLn+W2n
 AhYfDFJGIvj8Dn89Y2zyNPKFUU2LzhGpsph0r3qJai6LPoPurNGLxwXboa0b6Eq6NiB/kze9K9u
 t9HsN
X-Gm-Gg: AYBFou2JOI8Y1CU4f51NlZNWmQxjcuwLR7QzVbuWyI3e5ieo20wzFTwW8E5CW4hGkip
 ekdPYmMDwdKL61UIulGQ9/xHLD1mkvwCEn/7sJIEHwPo5DBu9YyL3NOhzh2cpqQXd9zHPU5fdYi
 X6EB5xKpVZ2JzgRvGMcgIyI+B55HSHxXZoVRBUkKB31aIDpPQreMMAhBiDqIx9UExY04usqqSTM
 KSte8DOCLG5l3XISb21Y5E0A7GAzR5B0qpYPAPeg4f171n116CQ/iHZjNokgz51POzq30NaMXGI
 zaA8au5l7WyvBSq7p5S8MfsUKRrJPuuyg6G9p8aVQM4Sjo5xueyQJZswi5MCrXcIVRbD2Ata0En
 U2M86LSqTVW77dAJzhm7aHGNGH13kBTLABkxzCgvdwbv9GzrknNQ1MXET5jkXRB5YlqdHQpDcSZ
 lFYDjKZwfD5Z2aE1eGPkpckEy8AToXaPEnQDqO2apQMsfqvTGEXjqIBO7pd+oh+VZGuWBKv61CQ
 ikKjXE+qiU/yzcCJToe7WkhjsOP1lykVfHSL5cQ
X-Received: by 2002:a17:90b:4d85:b0:39e:53a:c8d4 with SMTP id
 98e67ed59e1d1-3a098ae21c7mr9507218a91.12.1790499644074; 
 Sun, 27 Sep 2026 02:00:44 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 032/101] tcg: Generic expansion of tcg_gen_not_*
Date: Sun, 27 Sep 2026 01:59:02 -0700
Message-ID: <20260927090011.10724-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
 include/tcg/tcg-op-common.h  |  3 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 28 ++++++++++------------------
 3 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 773dd8db719..aa4fe339d8e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -203,8 +203,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
-
 /* 64 bit ops */
 
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
@@ -258,7 +256,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index abea00e7e0e..8c9d3d99c48 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -11,6 +11,7 @@ DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
+DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
 DEF3(sar, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index dacdcc68c52..d1cf0a436ea 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -444,6 +444,16 @@ void tcg_gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
     tcg_gen_op_tt(INDEX_op_neg, type, dst, src);
 }
 
+void tcg_gen_not(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (tcg_op_supported(INDEX_op_not, type, 0)) {
+        tcg_gen_op_tt(INDEX_op_not, type, dst, src);
+    } else {
+        /* Do not recurse with gen_xori. */
+        tcg_gen_xor(type, dst, src, tcg_constant_internal(type, -1));
+    }
+}
+
 void tcg_gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
@@ -543,15 +553,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_not, ret, arg);
-    } else {
-        tcg_gen_xori_i32(ret, arg, -1);
-    }
-}
-
 void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
@@ -1803,15 +1804,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_not, ret, arg);
-    } else {
-        tcg_gen_xori_i64(ret, arg, -1);
-    }
-}
-
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I64, 0)) {
-- 
2.53.0


