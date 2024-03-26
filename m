Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EB9CD11DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 09:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp3U2-0004tb-2T; Tue, 26 Mar 2024 05:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rp3U0-0004sy-UW
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 05:52:40 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rp3Ty-0006GN-8G
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 05:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711446754; x=1712051554; i=deller@gmx.de;
 bh=b94KEHukYll9rxsjxxPqJC/xAaFx6anFIL4zxVDQLMw=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=Ffe5MXaH0Z35S/LlLdrY6SgefMwjvTmzg2MqjKTC6Yky/nzVx2J6qfpZw9h/GB1V
 OMOCykQ9xNeCox2Riyh/9Tplf5vVBMAq6ZcenAlOnqLO1MLQqz+3hn0Z4oKzuK7OO
 UHH+X7HKcsAwU5Xdr5w++hAEhcX5/paSDNzA6ed1DxLBgkhDSISjWhqNVOsfX6Uj6
 FZmqxuq7Iew9Xkv52tRI4U+cI3Z3eSIMlz6t1NafiUGUz1hZw8T8NB2J8PpO7bt4y
 h5Xae6GNmCMd0T6eVJvjsuX3nGZM9T3pff/0Y/spVhsKk2daiWIsDtNdaU5nE/H76
 v5mPPs5yO7aR8P6EJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.180.193]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhuK-1s1ieu1Nn0-00DlRv; Tue, 26
 Mar 2024 10:52:34 +0100
Message-ID: <978754b4-2253-4a10-a3c5-cbb7ac0e9eda@gmx.de>
Date: Tue, 26 Mar 2024 10:52:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/hppa: Fix overflow computation for shladd
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240326064405.320551-1-richard.henderson@linaro.org>
 <20240326064405.320551-4-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240326064405.320551-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OrviTvLnNDgzr3mz7AHxB9iM6+be4QdagcPryDxRb4tF+C9Xg16
 9WdZCCgpY/dfTcA1hraeyp/GS8iVbMyLaMR7R9Hg8z+KtDk57gNjOU9tg0HyP7a0mF/k7OL
 UtoZEfac49GPZX//D97yAEnoMS46bGiuKnyBgtrjkIIHHwIUnDZ8s1MllHmtqn0IuEmln6j
 yhotoFBbrxJeHTGaSBtwQ==
UI-OutboundReport: notjunk:1;M01:P0:MKM2U/jsOQA=;WTLIU47H3eQaJUY3bwubxEhD3Yu
 gTIxsaJswXQWNqNFZDd5PccorvteSj5TsjIcqZeWiOqbcjWzH0xNOs0yz21FfiyJFFuwT2vN6
 0QmQCFxl+dNaftuw4h/X7KM5+TcH47SBmONI/TbjK+ZloDvotZhQswJwGJTnFFl509H/p9CXG
 p+UBe1C7zTpRpse9bf2q7LUa6nS+xDTKnRlJ3z3pV46l+FJgrvb/oXvxDi/+48U68P0Rlfq4S
 qkchTkqi/nrDMRwOAFCty/WwuklO/cHvhoX/A6NpPOF0IJowch9IZ3mjiT/HoesA7eL2naR5b
 gT1up4oy9Zi/R4j8InOHGYRNuf0ZbL7nBhSF4G8kspjlX5/tMKHhfv9o6e9XMvY03Wle636Jh
 +4nM21Nn5XdFQ+VHrpylOhdFbLVikFNlVKLjMxsZNW7c6rU/AAhzXA1JdJdFGD+7KNVIK5SHu
 j442dZX26DpfJJs6TwTbJs5PcUnJVv/xiXf0BcKjyNhfgqBRvMrW3viFTRN8m4YhbpZJZrnaU
 rC1JwYvQb1YYsDkD72UevYRL47yL6TnvF9KsSgphZOPgAUevLoihSyyKVMp64dRtP2rSSEcQS
 Ef8GC6c0H/d2XI+M5RU9nAagOv5NGmYVEqKZIz1InpYBFbuv33jOu8cbTEI+v1m4O0stFG6Jh
 tbBSPiTJwYrmFuYkukGq//vlXGbO6PHcGn76iU45Y8jLX2TJ7fkW1rUAo6ZQZChcrntklAvCU
 3wzJId1NvM3I9KuUtdQ491N3/47XTIePq7++6wyemglp77QfFXL10JOrGDF+o5aIF55vRKavC
 uKsGfTQwTchhsPUVd+Yrev8HUkDwCHh+WS9ujRAreQtoY=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On 3/26/24 07:44, Richard Henderson wrote:
> Overflow indicator should include the effect of the shift step.
> We had previously left ??? comments about the issue.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


Tested-by: Helge Deller <deller@gmx.de>

Helge

> ---
>   target/hppa/translate.c | 85 ++++++++++++++++++++++++++++++++---------
>   1 file changed, 66 insertions(+), 19 deletions(-)
>
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 9d31ef5764..0976372d16 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -994,7 +994,8 @@ static TCGv_i64 get_psw_carry(DisasContext *ctx, boo=
l d)
>
>   /* Compute signed overflow for addition.  */
>   static TCGv_i64 do_add_sv(DisasContext *ctx, TCGv_i64 res,
> -                          TCGv_i64 in1, TCGv_i64 in2)
> +                          TCGv_i64 in1, TCGv_i64 in2,
> +                          TCGv_i64 orig_in1, int shift, bool d)
>   {
>       TCGv_i64 sv =3D tcg_temp_new_i64();
>       TCGv_i64 tmp =3D tcg_temp_new_i64();
> @@ -1003,9 +1004,50 @@ static TCGv_i64 do_add_sv(DisasContext *ctx, TCGv=
_i64 res,
>       tcg_gen_xor_i64(tmp, in1, in2);
>       tcg_gen_andc_i64(sv, sv, tmp);
>
> +    switch (shift) {
> +    case 0:
> +        break;
> +    case 1:
> +        /* Shift left by one and compare the sign. */
> +        tcg_gen_add_i64(tmp, orig_in1, orig_in1);
> +        tcg_gen_xor_i64(tmp, tmp, orig_in1);
> +        /* Incorporate into the overflow. */
> +        tcg_gen_or_i64(sv, sv, tmp);
> +        break;
> +    default:
> +        {
> +            int sign_bit =3D d ? 63 : 31;
> +            uint64_t mask =3D MAKE_64BIT_MASK(sign_bit - shift, shift);
> +
> +            /* Compare the sign against all lower bits. */
> +            tcg_gen_sextract_i64(tmp, orig_in1, sign_bit, 1);
> +            tcg_gen_xor_i64(tmp, tmp, orig_in1);
> +            /*
> +             * If one of the bits shifting into or through the sign
> +             * differs, then we have overflow.
> +             */
> +            tcg_gen_movcond_i64(TCG_COND_TSTNE, sv,
> +                                tmp, tcg_constant_i64(mask),
> +                                tcg_constant_i64(-1), sv);
> +        }
> +    }
>       return sv;
>   }
>
> +/* Compute unsigned overflow for addition.  */
> +static TCGv_i64 do_add_uv(DisasContext *ctx, TCGv_i64 cb, TCGv_i64 cb_m=
sb,
> +                          TCGv_i64 in1, int shift, bool d)
> +{
> +    if (shift =3D=3D 0) {
> +        return get_carry(ctx, d, cb, cb_msb);
> +    } else {
> +        TCGv_i64 tmp =3D tcg_temp_new_i64();
> +        tcg_gen_extract_i64(tmp, in1, (d ? 63 : 31) - shift, shift);
> +        tcg_gen_or_i64(tmp, tmp, get_carry(ctx, d, cb, cb_msb));
> +        return tmp;
> +    }
> +}
> +
>   /* Compute signed overflow for subtraction.  */
>   static TCGv_i64 do_sub_sv(DisasContext *ctx, TCGv_i64 res,
>                             TCGv_i64 in1, TCGv_i64 in2)
> @@ -1020,19 +1062,19 @@ static TCGv_i64 do_sub_sv(DisasContext *ctx, TCG=
v_i64 res,
>       return sv;
>   }
>
> -static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
> +static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 orig_in1,
>                      TCGv_i64 in2, unsigned shift, bool is_l,
>                      bool is_tsv, bool is_tc, bool is_c, unsigned cf, bo=
ol d)
>   {
> -    TCGv_i64 dest, cb, cb_msb, cb_cond, sv, tmp;
> +    TCGv_i64 dest, cb, cb_msb, in1, uv, sv, tmp;
>       unsigned c =3D cf >> 1;
>       DisasCond cond;
>
>       dest =3D tcg_temp_new_i64();
>       cb =3D NULL;
>       cb_msb =3D NULL;
> -    cb_cond =3D NULL;
>
> +    in1 =3D orig_in1;
>       if (shift) {
>           tmp =3D tcg_temp_new_i64();
>           tcg_gen_shli_i64(tmp, in1, shift);
> @@ -1050,9 +1092,6 @@ static void do_add(DisasContext *ctx, unsigned rt,=
 TCGv_i64 in1,
>           }
>           tcg_gen_xor_i64(cb, in1, in2);
>           tcg_gen_xor_i64(cb, cb, dest);
> -        if (cond_need_cb(c)) {
> -            cb_cond =3D get_carry(ctx, d, cb, cb_msb);
> -        }
>       } else {
>           tcg_gen_add_i64(dest, in1, in2);
>           if (is_c) {
> @@ -1063,18 +1102,23 @@ static void do_add(DisasContext *ctx, unsigned r=
t, TCGv_i64 in1,
>       /* Compute signed overflow if required.  */
>       sv =3D NULL;
>       if (is_tsv || cond_need_sv(c)) {
> -        sv =3D do_add_sv(ctx, dest, in1, in2);
> +        sv =3D do_add_sv(ctx, dest, in1, in2, orig_in1, shift, d);
>           if (is_tsv) {
>               if (!d) {
>                   tcg_gen_ext32s_i64(sv, sv);
>               }
> -            /* ??? Need to include overflow from shift.  */
>               gen_helper_tsv(tcg_env, sv);
>           }
>       }
>
> +    /* Compute unsigned overflow if required.  */
> +    uv =3D NULL;
> +    if (cond_need_cb(c)) {
> +        uv =3D do_add_uv(ctx, cb, cb_msb, orig_in1, shift, d);
> +    }
> +
>       /* Emit any conditional trap before any writeback.  */
> -    cond =3D do_cond(ctx, cf, d, dest, cb_cond, sv);
> +    cond =3D do_cond(ctx, cf, d, dest, uv, sv);
>       if (is_tc) {
>           tmp =3D tcg_temp_new_i64();
>           tcg_gen_setcond_i64(cond.c, tmp, cond.a0, cond.a1);
> @@ -2843,7 +2887,6 @@ static bool trans_dcor_i(DisasContext *ctx, arg_rr=
_cf_d *a)
>   static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
>   {
>       TCGv_i64 dest, add1, add2, addc, in1, in2;
> -    TCGv_i64 cout;
>
>       nullify_over(ctx);
>
> @@ -2880,19 +2923,23 @@ static bool trans_ds(DisasContext *ctx, arg_rrr_=
cf *a)
>       tcg_gen_xor_i64(cpu_psw_cb, add1, add2);
>       tcg_gen_xor_i64(cpu_psw_cb, cpu_psw_cb, dest);
>
> -    /* Write back PSW[V] for the division step.  */
> -    cout =3D get_psw_carry(ctx, false);
> -    tcg_gen_neg_i64(cpu_psw_v, cout);
> +    /*
> +     * Write back PSW[V] for the division step.
> +     * Shift cb{8} from where it lives in bit 32 to bit 31,
> +     * so that it overlaps r2{32} in bit 31.
> +     */
> +    tcg_gen_shri_i64(cpu_psw_v, cpu_psw_cb, 1);
>       tcg_gen_xor_i64(cpu_psw_v, cpu_psw_v, in2);
>
>       /* Install the new nullification.  */
>       if (a->cf) {
> -        TCGv_i64 sv =3D NULL;
> +        TCGv_i64 sv =3D NULL, uv =3D NULL;
>           if (cond_need_sv(a->cf >> 1)) {
> -            /* ??? The lshift is supposed to contribute to overflow.  *=
/
> -            sv =3D do_add_sv(ctx, dest, add1, add2);
> +            sv =3D do_add_sv(ctx, dest, add1, add2, in1, 1, false);
> +        } else if (cond_need_cb(a->cf >> 1)) {
> +            uv =3D do_add_uv(ctx, cpu_psw_cb, NULL, in1, 1, false);
>           }
> -        ctx->null_cond =3D do_cond(ctx, a->cf, false, dest, cout, sv);
> +        ctx->null_cond =3D do_cond(ctx, a->cf, false, dest, uv, sv);
>       }
>
>       return nullify_end(ctx);
> @@ -3419,7 +3466,7 @@ static bool do_addb(DisasContext *ctx, unsigned r,=
 TCGv_i64 in1,
>           tcg_gen_add_i64(dest, in1, in2);
>       }
>       if (cond_need_sv(c)) {
> -        sv =3D do_add_sv(ctx, dest, in1, in2);
> +        sv =3D do_add_sv(ctx, dest, in1, in2, in1, 0, d);
>       }
>
>       cond =3D do_cond(ctx, c * 2 + f, d, dest, cb_cond, sv);


