Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07471C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCa-0007RE-4q; Tue, 18 Aug 2026 13:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCX-0007QW-Pm
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:13 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCW-0004hw-3g
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:13 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-848643382fcso204044b3a.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072531; x=1787677331; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=09cHq0fLPk/RPP+6CKuCMV9YgsCAmSJq8LyqnZ9wybk=;
 b=gPt5pV4hn6G5QbYVhKZSfq1/6fw4fmlbAUjNHitZ2+HHeghmoiRmpRXzfuj+ObY42z
 6mdKCKKtJ2ScR/0yorFaAUvWt++wmWCAddx8qq252ba+hiAsNktFUIY8IIMQnWLSSzpd
 sTVTFV3Zjsz2pYFPIVTQAtrotAwPqaR9WI76XZRl5YyUhJdo0q5Sx4yTwbfT3Ya1qpZd
 nyr9p0v02rK+omthBdTz5qTZ4wUI5z/sDQm78JwzPJjbO4aI/E7ZN1XhY3I8WEK8UUCd
 Tj3vtp6IaECgBonOhnHQSIewRINufZoqZVX3fUMtNmjK7OffLIXmYju0OUfNB7KTQmgD
 bpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072531; x=1787677331;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=09cHq0fLPk/RPP+6CKuCMV9YgsCAmSJq8LyqnZ9wybk=;
 b=V3UnnsD7TSM/1oBTnE9ktPyFfBDcXrqAGismrugw+lNoQwnDF79EoHyAvX+5grizFb
 gs69B8UiEbwMYlqZvojrIMYnAQOSNxnLvaYb5Mo8JlVw1bpfJK9nzXyVwje6xizGGT2v
 5lW/gYs7PPGmdvfGKLCmrfGhIImf8BPKdzwb8Py2QO85X4DYuNKu5PD2q+JkFlBbqP9u
 vWWm3mruWBrQLaFTS0kqV4/UyAFqUWzxnukxGDvNhfM3b6OiA3TiYxYhnbl1kYGH6EDH
 2bDbpscERnWDdPbFjgbEtHaBiQVxijxsa+Q12t0moWZlcfM+V5ZSHprvdcRDIzaMN1hs
 Yd/A==
X-Gm-Message-State: AOJu0YzI37udSZqj2PC5w2nromV08NQz7zeIGi8yyiUp+IgDWry5tSMV
 0Kh8/ZDPqRQ1kUL5VJ5QXXngRDGgMQh9HY2xQFpOrIWiW+azTjblFBARFbR58KYkybIidWnID64
 TQBHqqaQ=
X-Gm-Gg: AR+sD13Nu38zjeuXMx0fabDgQ0nkFYu2l5P24FhdphkOa3hAeklhl159BKEHdawH0D3
 wCEwRX/8TjGNFQCotve1ofli+pJFkzZv/7nPYcOPgwL1PC6o7GggARsRYcMe1toVkaOacRDfYVT
 YXSTojrNlmbw1rQPzL4i7HKaQqLBMOWN6I6sQcjCiE9RfKyFDPN2B6wUQUWM4XCXvlM6kKl1MLl
 vp2B3ptww6Md87ybGv9/t7fOzg1kqvKE9yrHG6bC9eqKtITdUsG+yp0cc/WGcwP9fJvuwRpTC0g
 QncbcG0n4qAoFDnC7l3VAHxh45XG6fMkIHP/cB21GReowYJZvRvyi6jhM9waR/Ii99vdCveJVwD
 KmgqL3SPcBJoBdm2LHai9avPXyVrGpf2ZAzdcN8MrTQi/825EuEZru+N15V+PPnTRVpkAeWqw9s
 NUUYbU6tZtZRt2TryfodbVJ8xDekm2IBS4a6IWloQDE/GkoWCi/Nh+SKgKJqDeC0ftyqC55wM0r
 tk4cP6lXV+2x8FjO+OYxgbB+tptfdvQjys=
X-Received: by 2002:a05:6a00:4482:b0:848:5cf5:5040 with SMTP id
 d2e1a72fcca58-851b8810d0fmr14872652b3a.10.1787072530626; 
 Tue, 18 Aug 2026 10:02:10 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 10/38] target/arm: Use generic tcg_gen_revbit*
Date: Tue, 18 Aug 2026 10:01:27 -0700
Message-ID: <20260818170155.1907006-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64-defs.h | 1 -
 target/arm/tcg/helper-defs.h     | 1 -
 target/arm/tcg/helper-a64.c      | 5 -----
 target/arm/tcg/op_helper.c       | 5 -----
 target/arm/tcg/translate-a64.c   | 4 ++--
 target/arm/tcg/translate.c       | 2 +-
 6 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index 0e56e00f45..12f58c6a44 100644
--- a/target/arm/tcg/helper-a64-defs.h
+++ b/target/arm/tcg/helper-a64-defs.h
@@ -18,7 +18,6 @@
  */
 DEF_HELPER_FLAGS_2(udiv64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(sdiv64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
-DEF_HELPER_FLAGS_1(rbit64, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_2(msr_i_spsel, void, env, i32)
 DEF_HELPER_2(msr_i_daifset, void, env, i32)
 DEF_HELPER_2(msr_i_daifclear, void, env, i32)
diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 0077aeb4e2..42376af2c6 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -10,7 +10,6 @@ DEF_HELPER_3(add_usaturate, i32, env, i32, i32)
 DEF_HELPER_3(sub_usaturate, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(sdiv, TCG_CALL_NO_RWG, s32, env, s32, s32)
 DEF_HELPER_FLAGS_3(udiv, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_1(rbit, TCG_CALL_NO_RWG_SE, i32, i32)
 
 #define PAS_OP(pfx)  \
     DEF_HELPER_3(pfx ## add8, i32, i32, i32, ptr) \
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 05ab9ab6d3..9d805231a0 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -69,11 +69,6 @@ int64_t HELPER(sdiv64)(int64_t num, int64_t den)
     return num / den;
 }
 
-uint64_t HELPER(rbit64)(uint64_t x)
-{
-    return revbit64(x);
-}
-
 void HELPER(msr_i_spsel)(CPUARMState *env, uint32_t imm)
 {
     update_spsel(env, imm);
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index c4433be2ed..857e897a48 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -172,11 +172,6 @@ uint32_t HELPER(udiv)(CPUARMState *env, uint32_t num, uint32_t den)
     return num / den;
 }
 
-uint32_t HELPER(rbit)(uint32_t x)
-{
-    return revbit32(x);
-}
-
 uint32_t HELPER(add_setq)(CPUARMState *env, uint32_t a, uint32_t b)
 {
     uint32_t res = a + b;
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1780490065..4f9a93950b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8963,7 +8963,7 @@ static void gen_wrap2_i32(TCGv_i64 d, TCGv_i64 n, NeonGenOneOpFn fn)
 
 static void gen_rbit32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
 {
-    gen_wrap2_i32(tcg_rd, tcg_rn, gen_helper_rbit);
+    tcg_gen_revbit32_i64(tcg_rd, tcg_rn, TCG_BSWAP_OZ);
 }
 
 static void gen_rev16_xx(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn, TCGv_i64 mask)
@@ -8998,7 +8998,7 @@ static void gen_rev32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
     tcg_gen_rotri_i64(tcg_rd, tcg_rd, 32);
 }
 
-TRANS(RBIT, gen_rr, a->rd, a->rn, a->sf ? gen_helper_rbit64 : gen_rbit32)
+TRANS(RBIT, gen_rr, a->rd, a->rn, a->sf ? tcg_gen_revbit64_i64 : gen_rbit32)
 TRANS(REV16, gen_rr, a->rd, a->rn, a->sf ? gen_rev16_64 : gen_rev16_32)
 TRANS(REV32, gen_rr, a->rd, a->rn, a->sf ? gen_rev32 : gen_rev_32)
 TRANS(REV64, gen_rr, a->rd, a->rn, tcg_gen_bswap64_i64)
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 055f3c5b40..1770428d3c 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -4835,7 +4835,7 @@ static bool trans_RBIT(DisasContext *s, arg_rr *a)
     if (!ENABLE_ARCH_6T2) {
         return false;
     }
-    return op_rr(s, a, gen_helper_rbit);
+    return op_rr(s, a, tcg_gen_revbit32_i32);
 }
 
 /*
-- 
2.43.0


