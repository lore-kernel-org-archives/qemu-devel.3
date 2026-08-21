Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E239C5DF8C
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxSMQ-0007W8-MG; Fri, 21 Aug 2026 12:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wxSMN-0007Vg-Ob; Fri, 21 Aug 2026 12:44:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wxSMK-0000sy-5J; Fri, 21 Aug 2026 12:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787330654; bh=JH3sm0gg58PT+PLfD7LyKWNFGXWho16jHhgPnCxvOwQ=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To;
 b=fFfdlE6zc4foMw25isYRMkhSfKUTgWe5Gs4buTgC6K14+Wz5ZMlBStNuuUyukHuCt
 X2hJa3YZoMpRdMoml0nW+vw89k8Bttr+VXaG28kkqEbYSbMZVRAal2/BDkXnVHJxjh
 GodFVmj2r6iRTdZW8qiP7ATPE7UYUU6yIzTz1Id3TCCVAPfwgJKPAAaB8DMZ99+Vcx
 CDJC5s0bnDBxdwemMPkKqMAephsFgdMYy76j2mdPpm/dCWiDZSWdHpe4PeHCzEgPEK
 ay1LCdzTHoPwVF+6DbxvM1quoeTvJvpfpPJ5GfhpH3iBzT9yresdxrIOi5JBFyJnyR
 JKrocAXTVeUcw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 50F841CD3AC;
 Fri, 21 Aug 2026 19:44:14 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C071D4113E8;
 Fri, 21 Aug 2026 19:44:43 +0300 (MSK)
Message-ID: <fd8ab02f-d134-4241-ae40-1ae32007a9e1@tls.msk.ru>
Date: Fri, 21 Aug 2026 19:44:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/43] target/arm: Fix SVE2 WHILEWR/WHILERW zero diff
 boundary case
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
 <20260821110101.3971391-14-peter.maydell@linaro.org>
Content-Language: en-US, ru-RU
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Stable <qemu-stable@nongnu.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20260821110101.3971391-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 8/21/26 14:00, Peter Maydell wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> The trans_WHILE_ptr function incorrectly handles the case where the
> address difference divided by ESIZE results in zero. This happens when
> the address difference is less than ESIZE but greater than zero.
> 
> Fix by dropping direct comparisons of op0 vs op1, and instead
> testing the scaled diff vs 0.  Merge with the bounding to the
> maximum vector length via wrapping arithmetic.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 14f6dad168e ("target/arm: Implement SVE2 WHILERW, WHILEWR")
> Reported-by: YanjunYang <yang.yanjun1@sanechips.com.cn>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Message-id: 20260811191540.79882-3-richard.henderson@linaro.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-sve.c | 38 +++++++++++++++++++++-------------
>   1 file changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
> index fc4cc8c479f..0becef16a94 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -3697,7 +3697,7 @@ TRANS_FEAT(WHILE_gt_cnt4, aa64_sme2_or_sve2p1, do_WHILE,
>   
>   static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
>   {
> -    TCGv_i64 op0, op1, diff, t1, tmax;
> +    TCGv_i64 op0, op1, diff, t1;
>       TCGv_i32 t2;
>       TCGv_ptr ptr;
>       unsigned vsz = vec_full_reg_size(s);
> @@ -3713,7 +3713,6 @@ static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
>       op0 = read_cpu_reg(s, a->rn, 1);
>       op1 = read_cpu_reg(s, a->rm, 1);
>   
> -    tmax = tcg_constant_i64(vsz >> a->esz);
>       diff = tcg_temp_new_i64();
>   
>       if (a->rw) {
> @@ -3723,25 +3722,36 @@ static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
>           tcg_gen_sub_i64(diff, op0, op1);
>           tcg_gen_sub_i64(t1, op1, op0);
>           tcg_gen_movcond_i64(TCG_COND_GEU, diff, op0, op1, diff, t1);
> -        /* Divide, rounding down, by ESIZE.  */
> -        tcg_gen_shri_i64(diff, diff, a->esz);
> -        /* If op1 == op0, diff == 0, and the condition is always true. */
> -        tcg_gen_movcond_i64(TCG_COND_EQ, diff, op0, op1, tmax, diff);
>       } else {
>           /* WHILEWR */
> -        tcg_gen_sub_i64(diff, op1, op0);
> -        /* Divide, rounding down, by ESIZE.  */
> -        tcg_gen_shri_i64(diff, diff, a->esz);
> -        /* If op0 >= op1, diff <= 0, the condition is always true. */
> -        tcg_gen_movcond_i64(TCG_COND_GEU, diff, op0, op1, tmax, diff);
> +        /* Saturating subtraction maps diff <= 0 to diff == 0. */
> +        tcg_gen_ussub_i64(diff, op1, op0);
>       }
>   
> -    /* Bound to the maximum.  */
> -    tcg_gen_umin_i64(diff, diff, tmax);
> +    /* Divide, rounding down, by ESIZE.  */
> +    tcg_gen_shri_i64(diff, diff, a->esz);

While picking this one up for 10.0.x stable series, I come across an
interesting case.  This very code were changed in v10.0.0-1961-gf96fd13c6ea0
("target/arm: Move scale by esz into helper_sve_while*"), and is now being
dropped entirely.

The back-port of this patch to 10.0.x is below, and is also available at
https://gitlab.com/mjt0k/qemu/-/commit/f25f16d5c5d364306ee88438704a9054855c12b0
(staging-10.0 branch).  It should be okay, but I appreciate an additional
look there, just in case :)

(Yes, I picked up the testcase too, and it passes).

Thanks,

/mjt

commit f25f16d5c5d364306ee88438704a9054855c12b0
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Tue Aug 11 12:15:39 2026 -0700

     target/arm: Fix SVE2 WHILEWR/WHILERW zero diff boundary case

     The trans_WHILE_ptr function incorrectly handles the case where the
     address difference divided by ESIZE results in zero. This happens when
     the address difference is less than ESIZE but greater than zero.

     Fix by dropping direct comparisons of op0 vs op1, and instead
     testing the scaled diff vs 0.  Merge with the bounding to the
     maximum vector length via wrapping arithmetic.

     Cc: qemu-stable@nongnu.org
     Fixes: 14f6dad168e ("target/arm: Implement SVE2 WHILERW, WHILEWR")
     Reported-by: YanjunYang <yang.yanjun1@sanechips.com.cn>
     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
     Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
     Message-id: 20260811191540.79882-3-richard.henderson@linaro.org
     Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
     (cherry picked from commit bab972a2b0e34b889fbe8deb1e41cbea47e797f2)
     (Mjt: back-port to 10.0.x across missing v10.0.0-1961-gf96fd13c6ea0
      "target/arm: Move scale by esz into helper_sve_while*")
     Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 1d5b06e3917..e7d1f8d5b12 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3218,7 +3218,7 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a)

  static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
  {
-    TCGv_i64 op0, op1, diff, t1, tmax;
+    TCGv_i64 op0, op1, diff, t1;
      TCGv_i32 t2;
      TCGv_ptr ptr;
      unsigned vsz = vec_full_reg_size(s);
@@ -3234,7 +3234,6 @@ static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
      op0 = read_cpu_reg(s, a->rn, 1);
      op1 = read_cpu_reg(s, a->rm, 1);

-    tmax = tcg_constant_i64(vsz);
      diff = tcg_temp_new_i64();

      if (a->rw) {
@@ -3244,25 +3243,36 @@ static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
          tcg_gen_sub_i64(diff, op0, op1);
          tcg_gen_sub_i64(t1, op1, op0);
          tcg_gen_movcond_i64(TCG_COND_GEU, diff, op0, op1, diff, t1);
-        /* Round down to a multiple of ESIZE.  */
-        tcg_gen_andi_i64(diff, diff, -1 << a->esz);
-        /* If op1 == op0, diff == 0, and the condition is always true. */
-        tcg_gen_movcond_i64(TCG_COND_EQ, diff, op0, op1, tmax, diff);
      } else {
          /* WHILEWR */
-        tcg_gen_sub_i64(diff, op1, op0);
-        /* Round down to a multiple of ESIZE.  */
-        tcg_gen_andi_i64(diff, diff, -1 << a->esz);
-        /* If op0 >= op1, diff <= 0, the condition is always true. */
-        tcg_gen_movcond_i64(TCG_COND_GEU, diff, op0, op1, tmax, diff);
+        /* Saturating subtraction maps diff <= 0 to diff == 0. */
+        tcg_gen_ussub_i64(diff, op1, op0);
      }

-    /* Bound to the maximum.  */
-    tcg_gen_umin_i64(diff, diff, tmax);
+    /* Divide, rounding down, by ESIZE.  */
+    tcg_gen_shri_i64(diff, diff, a->esz);

-    /* Since we're bounded, pass as a 32-bit type.  */
+    /*
+     * If diff == 0, the condition is always true.  Also, bound to max.
+     * Simplify
+     *    diff = diff ? diff : max;
+     *    diff = umin(diff, max);
+     * via
+     *    diff -= 1;
+     *    diff = umin(diff, max - 1);
+     *    diff += 1;
+     * via 0 - 1 == UINT64_MAX.
+     */
+    tcg_gen_addi_i64(diff, diff, -1);
+    tcg_gen_umin_i64(diff, diff, tcg_constant_i64((vsz >> a->esz) - 1));
+
+    /*
+     * Since we're bounded, pass as a 32-bit type.
+     * Sink the diff += 1 from above into the 32-bit type.
+     */
      t2 = tcg_temp_new_i32();
      tcg_gen_extrl_i64_i32(t2, diff);
+    tcg_gen_addi_i32(t2, t2, 1);

      desc = FIELD_DP32(desc, PREDDESC, OPRSZ, vsz / 8);
      desc = FIELD_DP32(desc, PREDDESC, ESZ, a->esz);



