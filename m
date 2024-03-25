Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C47C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 20:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ror6p-00046u-Sf; Mon, 25 Mar 2024 16:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1ror6n-00046Y-9U
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 16:39:53 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1ror6k-0004tY-PX
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 16:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711399188; x=1712003988; i=deller@gmx.de;
 bh=zrZhGEJCl4kVNU7RcviZxCAqDETWmHQL5aphl4h1RRY=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=iWl/51bxumq1OB97VOLFxtWBrehZzV3isvhA6qfYkZLQaREAq22YuWxkItvyBjEt
 MLibDkOz/DPSfl9Zqxn6HIOBIjaPOpkbvFnAnO7jY0HohcUqH4WIrfONoJU3d3ZoN
 HmFgTO7IEU1CPjxgh99hHq3mSY7Ngc3lPMcQzRU8GkZWaB0ATiC8RI//Hy885TBWF
 87Z7hA8UZtUJWg/txBCRGaAse5jRHCObdElwR8fNsR6zF99TO8jao2iDl7mRsCQaT
 WNF19OGKftvHiRCx0BIukOONkm72OMAwYjRo6ZQoTmdWMuGWqmuV2X7YgkxFlQk25
 XnhfUjunie5HPrBqzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.186.8]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MaJ7v-1sKOcj14Yn-00WGxY; Mon, 25
 Mar 2024 21:39:48 +0100
Message-ID: <bc223297-f4f6-47bf-b920-d0f6224cea42@gmx.de>
Date: Mon, 25 Mar 2024 21:39:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/hppa: Fix unit carry conditions
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240325190225.104465-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240325190225.104465-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JC98/EGwrxAStXbu+nOCr3FALNkTF/uM4cxo+YHtZOlchqwsAt7
 4/vBydvPhM8295GUGDkJUKYGsDwqLFNTIbwk+AjE9omy2IgNbTNOo8zXOmbfsiFUsao24GK
 f8OQbQslnRMqFdn6OgHZxmxs/Gxr875c09hVSWEKjyqd2sX3LPxiEvC7yTxXJU5cV9EbirO
 4ZLVdNuVE3N18uY2q5U8Q==
UI-OutboundReport: notjunk:1;M01:P0:cMnDoDbqT/8=;xD+VCOA4PKM9Veq1kVRknjC8hTj
 beY7XDZVP0Vc5hdJCcygg+ZIIwGsSUjgyOB/uWYzVn1rVaygn41ZozbqxH/5oF+gtLrbd5DLK
 P7zbHWtRTFwZr1hrIj5YgdTp1xmo0wPCauaf92hkjm0cWzxaP5+mMDGt7ZsCPRUE87xQ34Ro9
 0LDDBFBUtbS9URTbmDbAq3gqv52bYt1boCH/GQjiVLRiOidFy0LsQd2of+4mTmSvmq22VmFYr
 XLikP4RfkaYks2Fmth9iYF0mEUI96o0nYgJST/1CXVcQytvFZI+JnXzBt7S2T4wGCq6SDugVh
 D1Y9OtC7nshFVF4ULUn0S/lfAkEIj28ZvfKMtglnwnhv/kGDt92qvcl/GFt5tKT6N2Cqdbtxs
 +47R7cNhjZFB4I1MuZAQtD+RlpLe8HXkxxnOn8H/l/Qh6f52rsW73YBtYaGHSdAUiyLdjwoyj
 H1ndmaslOLvWG31sfkz1+04wLcWKtWOzy59oHGwrsbp8sejKsEEQdKRUYbB9e4u5z+RkQfA0k
 YDUk626sBZZjXkfNsNSvxPuqlnZOLuH2VgFfUPIs+ybHGa0C3fHjQhKyW47CKrSC5GHffVZEe
 PjxE0DmtTVWDxcZPPYMVUBjaLyaNF14z+Cw9QWeeGnJ+loYJQHY5lDT7THvBbHihzibiMQkeO
 A6v+nMEaupzXmBQTXLmI8tGCT5hOj/D6kIJjFMAbexcdMvZA+f7f30rCH1ZaFuWNYoXnTrGPB
 bPJzteR8/BZSnH9WqKDkIAQLIkORu00MKWm/kUVkghyWDCJfOmtQ2kcfUBOSTRigBjQidHHha
 qWczXsevHkh53Uf14TsmYlbGSHiEZL6/kY0AmV5TIJS/I=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/25/24 20:02, Richard Henderson wrote:
> Split do_unit_cond to do_unit_zero_cond to only handle conditions
> versus zero.  These are the only ones that are legal for UXOR.
> Simplify trans_uxor accordingly.
>
> Rename do_unit to do_unit_addsub, since xor has been split.
> Properly compute carry-out bits for add and subtract, mirroring
> the code in do_add and do_sub.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

this patch does not break test #55 (uaddcm) any longer, and with the other
two patches test #58 (uaddcm & dcor) is OK as well.

So, for the whole series:
Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>

Thanks!
Helge



> ---
>
> v2: Cut and paste error between 64- and 32-bit paths.
>      Shift 32-bit carry down 1 bit like 64-bit carry;
>      tradeoff is shift vs needing a 64-bit constant for the mask.
>      Don't use of TCG_COND_TST{NE,EQ}, as this will limit backports
>      of the actual bug fix.  We can convert the port to test conditions
>      en masse during the next devel cycle.
>
> ---
>   target/hppa/translate.c | 218 +++++++++++++++++++++-------------------
>   1 file changed, 113 insertions(+), 105 deletions(-)
>
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 3fc3e7754c..99c5c4cbca 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -936,98 +936,44 @@ static DisasCond do_sed_cond(DisasContext *ctx, un=
signed orig, bool d,
>       return do_log_cond(ctx, c * 2 + f, d, res);
>   }
>
> -/* Similar, but for unit conditions.  */
> -
> -static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_i64 res,
> -                              TCGv_i64 in1, TCGv_i64 in2)
> +/* Similar, but for unit zero conditions.  */
> +static DisasCond do_unit_zero_cond(unsigned cf, bool d, TCGv_i64 res)
>   {
> -    DisasCond cond;
> -    TCGv_i64 tmp, cb =3D NULL;
> +    TCGv_i64 tmp;
>       uint64_t d_repl =3D d ? 0x0000000100000001ull : 1;
> -
> -    if (cf & 8) {
> -        /* Since we want to test lots of carry-out bits all at once, do=
 not
> -         * do our normal thing and compute carry-in of bit B+1 since th=
at
> -         * leaves us with carry bits spread across two words.
> -         */
> -        cb =3D tcg_temp_new_i64();
> -        tmp =3D tcg_temp_new_i64();
> -        tcg_gen_or_i64(cb, in1, in2);
> -        tcg_gen_and_i64(tmp, in1, in2);
> -        tcg_gen_andc_i64(cb, cb, res);
> -        tcg_gen_or_i64(cb, cb, tmp);
> -    }
> +    uint64_t ones =3D 0, sgns =3D 0;
>
>       switch (cf >> 1) {
> -    case 0: /* never / TR */
> -        cond =3D cond_make_f();
> -        break;
> -
>       case 1: /* SBW / NBW */
>           if (d) {
> -            tmp =3D tcg_temp_new_i64();
> -            tcg_gen_subi_i64(tmp, res, d_repl * 0x00000001u);
> -            tcg_gen_andc_i64(tmp, tmp, res);
> -            tcg_gen_andi_i64(tmp, tmp, d_repl * 0x80000000u);
> -            cond =3D cond_make_0(TCG_COND_NE, tmp);
> -        } else {
> -            /* undefined */
> -            cond =3D cond_make_f();
> +            ones =3D d_repl;
> +            sgns =3D d_repl << 31;
>           }
>           break;
> -
>       case 2: /* SBZ / NBZ */
> -        /* See hasless(v,1) from
> -         * https://graphics.stanford.edu/~seander/bithacks.html#ZeroInW=
ord
> -         */
> -        tmp =3D tcg_temp_new_i64();
> -        tcg_gen_subi_i64(tmp, res, d_repl * 0x01010101u);
> -        tcg_gen_andc_i64(tmp, tmp, res);
> -        tcg_gen_andi_i64(tmp, tmp, d_repl * 0x80808080u);
> -        cond =3D cond_make_0(TCG_COND_NE, tmp);
> +        ones =3D d_repl * 0x01010101u;
> +        sgns =3D ones << 7;
>           break;
> -
>       case 3: /* SHZ / NHZ */
> -        tmp =3D tcg_temp_new_i64();
> -        tcg_gen_subi_i64(tmp, res, d_repl * 0x00010001u);
> -        tcg_gen_andc_i64(tmp, tmp, res);
> -        tcg_gen_andi_i64(tmp, tmp, d_repl * 0x80008000u);
> -        cond =3D cond_make_0(TCG_COND_NE, tmp);
> +        ones =3D d_repl * 0x00010001u;
> +        sgns =3D ones << 15;
>           break;
> -
> -    case 4: /* SDC / NDC */
> -        tcg_gen_andi_i64(cb, cb, d_repl * 0x88888888u);
> -        cond =3D cond_make_0(TCG_COND_NE, cb);
> -        break;
> -
> -    case 5: /* SWC / NWC */
> -        if (d) {
> -            tcg_gen_andi_i64(cb, cb, d_repl * 0x80000000u);
> -            cond =3D cond_make_0(TCG_COND_NE, cb);
> -        } else {
> -            /* undefined */
> -            cond =3D cond_make_f();
> -        }
> -        break;
> -
> -    case 6: /* SBC / NBC */
> -        tcg_gen_andi_i64(cb, cb, d_repl * 0x80808080u);
> -        cond =3D cond_make_0(TCG_COND_NE, cb);
> -        break;
> -
> -    case 7: /* SHC / NHC */
> -        tcg_gen_andi_i64(cb, cb, d_repl * 0x80008000u);
> -        cond =3D cond_make_0(TCG_COND_NE, cb);
> -        break;
> -
> -    default:
> -        g_assert_not_reached();
>       }
> -    if (cf & 1) {
> -        cond.c =3D tcg_invert_cond(cond.c);
> +    if (ones =3D=3D 0) {
> +        /* Undefined, or 0/1 (never/always). */
> +        return cf & 1 ? cond_make_t() : cond_make_f();
>       }
>
> -    return cond;
> +    /*
> +     * See hasless(v,1) from
> +     * https://graphics.stanford.edu/~seander/bithacks.html#ZeroInWord
> +     */
> +    tmp =3D tcg_temp_new_i64();
> +    tcg_gen_subi_i64(tmp, res, ones);
> +    tcg_gen_andc_i64(tmp, tmp, res);
> +    tcg_gen_andi_i64(tmp, tmp, sgns);
> +
> +    return cond_make_0_tmp(cf & 1 ? TCG_COND_EQ : TCG_COND_NE, tmp);
>   }
>
>   static TCGv_i64 get_carry(DisasContext *ctx, bool d,
> @@ -1330,34 +1276,86 @@ static bool do_log_reg(DisasContext *ctx, arg_rr=
r_cf_d *a,
>       return nullify_end(ctx);
>   }
>
> -static void do_unit(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
> -                    TCGv_i64 in2, unsigned cf, bool d, bool is_tc,
> -                    void (*fn)(TCGv_i64, TCGv_i64, TCGv_i64))
> +static void do_unit_addsub(DisasContext *ctx, unsigned rt, TCGv_i64 in1=
,
> +                           TCGv_i64 in2, unsigned cf, bool d,
> +                           bool is_tc, bool is_add)
>   {
> -    TCGv_i64 dest;
> +    TCGv_i64 dest =3D tcg_temp_new_i64();
> +    uint64_t test_cb =3D 0;
>       DisasCond cond;
>
> -    if (cf =3D=3D 0) {
> -        dest =3D dest_gpr(ctx, rt);
> -        fn(dest, in1, in2);
> -        save_gpr(ctx, rt, dest);
> -        cond_free(&ctx->null_cond);
> -    } else {
> -        dest =3D tcg_temp_new_i64();
> -        fn(dest, in1, in2);
> -
> -        cond =3D do_unit_cond(cf, d, dest, in1, in2);
> -
> -        if (is_tc) {
> -            TCGv_i64 tmp =3D tcg_temp_new_i64();
> -            tcg_gen_setcond_i64(cond.c, tmp, cond.a0, cond.a1);
> -            gen_helper_tcond(tcg_env, tmp);
> +    /* Select which carry-out bits to test. */
> +    switch (cf >> 1) {
> +    case 4: /* NDC / SDC -- 4-bit carries */
> +        test_cb =3D dup_const(MO_8, 0x88);
> +        break;
> +    case 5: /* NWC / SWC -- 32-bit carries */
> +        if (d) {
> +            test_cb =3D dup_const(MO_32, INT32_MIN);
> +        } else {
> +            cf &=3D 1; /* undefined -- map to never/always */
>           }
> -        save_gpr(ctx, rt, dest);
> -
> -        cond_free(&ctx->null_cond);
> -        ctx->null_cond =3D cond;
> +        break;
> +    case 6: /* NBC / SBC -- 8-bit carries */
> +        test_cb =3D dup_const(MO_8, INT8_MIN);
> +        break;
> +    case 7: /* NHC / SHC -- 16-bit carries */
> +        test_cb =3D dup_const(MO_16, INT16_MIN);
> +        break;
>       }
> +    if (!d) {
> +        test_cb =3D (uint32_t)test_cb;
> +    }
> +
> +    if (!test_cb) {
> +        /* No need to compute carries if we don't need to test them. */
> +        if (is_add) {
> +            tcg_gen_add_i64(dest, in1, in2);
> +        } else {
> +            tcg_gen_sub_i64(dest, in1, in2);
> +        }
> +        cond =3D do_unit_zero_cond(cf, d, dest);
> +    } else {
> +        TCGv_i64 cb =3D tcg_temp_new_i64();
> +
> +        if (d) {
> +            TCGv_i64 cb_msb =3D tcg_temp_new_i64();
> +            if (is_add) {
> +                tcg_gen_add2_i64(dest, cb_msb, in1, ctx->zero, in2, ctx=
->zero);
> +                tcg_gen_xor_i64(cb, in1, in2);
> +            } else {
> +                /* See do_sub, !is_b. */
> +                TCGv_i64 one =3D tcg_constant_i64(1);
> +                tcg_gen_sub2_i64(dest, cb_msb, in1, one, in2, ctx->zero=
);
> +                tcg_gen_eqv_i64(cb, in1, in2);
> +            }
> +            tcg_gen_xor_i64(cb, cb, dest);
> +            tcg_gen_extract2_i64(cb, cb, cb_msb, 1);
> +        } else {
> +            if (is_add) {
> +                tcg_gen_add_i64(dest, in1, in2);
> +                tcg_gen_xor_i64(cb, in1, in2);
> +            } else {
> +                tcg_gen_sub_i64(dest, in1, in2);
> +                tcg_gen_eqv_i64(cb, in1, in2);
> +            }
> +            tcg_gen_xor_i64(cb, cb, dest);
> +            tcg_gen_shri_i64(cb, cb, 1);
> +        }
> +
> +        tcg_gen_andi_i64(cb, cb, test_cb);
> +        cond =3D cond_make_0_tmp(cf & 1 ? TCG_COND_EQ : TCG_COND_NE, cb=
);
> +    }
> +
> +    if (is_tc) {
> +        TCGv_i64 tmp =3D tcg_temp_new_i64();
> +        tcg_gen_setcond_i64(cond.c, tmp, cond.a0, cond.a1);
> +        gen_helper_tcond(tcg_env, tmp);
> +    }
> +    save_gpr(ctx, rt, dest);
> +
> +    cond_free(&ctx->null_cond);
> +    ctx->null_cond =3D cond;
>   }
>
>   #ifndef CONFIG_USER_ONLY
> @@ -2748,14 +2746,24 @@ static bool trans_cmpclr(DisasContext *ctx, arg_=
rrr_cf_d *a)
>
>   static bool trans_uxor(DisasContext *ctx, arg_rrr_cf_d *a)
>   {
> -    TCGv_i64 tcg_r1, tcg_r2;
> +    TCGv_i64 tcg_r1, tcg_r2, dest;
>
>       if (a->cf) {
>           nullify_over(ctx);
>       }
> +
>       tcg_r1 =3D load_gpr(ctx, a->r1);
>       tcg_r2 =3D load_gpr(ctx, a->r2);
> -    do_unit(ctx, a->t, tcg_r1, tcg_r2, a->cf, a->d, false, tcg_gen_xor_=
i64);
> +    dest =3D dest_gpr(ctx, a->t);
> +
> +    tcg_gen_xor_i64(dest, tcg_r1, tcg_r2);
> +    save_gpr(ctx, a->t, dest);
> +
> +    cond_free(&ctx->null_cond);
> +    if (a->cf) {
> +        ctx->null_cond =3D do_unit_zero_cond(a->cf, a->d, dest);
> +    }
> +
>       return nullify_end(ctx);
>   }
>
> @@ -2790,7 +2798,7 @@ static bool do_uaddcm(DisasContext *ctx, arg_rrr_c=
f_d *a, bool is_tc)
>       tcg_r2 =3D load_gpr(ctx, a->r2);
>       tmp =3D tcg_temp_new_i64();
>       tcg_gen_not_i64(tmp, tcg_r2);
> -    do_unit(ctx, a->t, tcg_r1, tmp, a->cf, a->d, is_tc, tcg_gen_add_i64=
);
> +    do_unit_addsub(ctx, a->t, tcg_r1, tmp, a->cf, a->d, is_tc, true);
>       return nullify_end(ctx);
>   }
>
> @@ -2817,8 +2825,8 @@ static bool do_dcor(DisasContext *ctx, arg_rr_cf_d=
 *a, bool is_i)
>       }
>       tcg_gen_andi_i64(tmp, tmp, (uint64_t)0x1111111111111111ull);
>       tcg_gen_muli_i64(tmp, tmp, 6);
> -    do_unit(ctx, a->t, load_gpr(ctx, a->r), tmp, a->cf, a->d, false,
> -            is_i ? tcg_gen_add_i64 : tcg_gen_sub_i64);
> +    do_unit_addsub(ctx, a->t, load_gpr(ctx, a->r), tmp,
> +                   a->cf, a->d, false, is_i);
>       return nullify_end(ctx);
>   }
>


