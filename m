Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D0FC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 09:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rogwx-0004Vi-OM; Mon, 25 Mar 2024 05:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rogwv-0004VD-Jd
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:49:01 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rogwu-0008A8-0E
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711360138; x=1711964938; i=deller@gmx.de;
 bh=1g8OXDFY4cAtyjm25+osIojyUOIGPWg4U5AtB6/PdME=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=V/11Q1y6pzmdgEGYzUtvmubJttHC1e5wkTjbuKP8TTU9ypCeGK+Bk2FrC/iq97t3
 0iIYtczflw7nyRfL22jjjcd6y+O8NqgKEC7cUaDw9HwN79/5wcA2t6h6Fvcgm3UQv
 coA5xdyBIAsJXMawsSmicTxsliiUgOi3N2JXb/1LfVccCVOhTeTvPMo/U9fsgKjdn
 koEzIWZsOrLYtP5oh61p35AH/EYNLFHNGkAXdlNFY/Bq7wWT6CYNqr4mn7oLvcFa9
 SQx9UXshPXgP5q+0b4zRH7IuUkitPl78MCEvm3sftukm2jhl6SU4Q3rKTlZud59Se
 +SKlUIVbF8eH8LqzQg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.186.8]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQMuX-1sAMhc3f7J-00MM79; Mon, 25
 Mar 2024 10:48:57 +0100
Message-ID: <6ba279b9-51f1-4525-9227-b1601ba5eb7d@gmx.de>
Date: Mon, 25 Mar 2024 10:48:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/hppa: Optimize UADDCM with no condition
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240325030448.52110-1-richard.henderson@linaro.org>
 <20240325030448.52110-3-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240325030448.52110-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:znzsKz1CZGbgMniorpjUQhd/hg+8Huxef/Lq+YvQ0bhap9Z3JUo
 q84OrT5zooSc90pF/Bz/4IKZ2W2Jx/B+wB2AsFwKdLyf6ERiHv4s6DiqLuV4g8aoZguPDXk
 g+izSz10svF4sUE08cmOFJwevEXJ4oFJ0rdLAYQg5d25K5kSSuVwQougflTKXm0ULxC7qjH
 TgYQkH0PV0zlNV5pE6ysw==
UI-OutboundReport: notjunk:1;M01:P0:lHSP9kw05Gs=;TVuXIrFEzE2QOhIgPWXCiH44B77
 7MKSqNFBA85Dbf87lnV4b2rPoBjajBvjur220kp+qVLU7b4I/JOQ3J1zi0sxEEL4GOExZiVPO
 Ix3MlB25f+dEDre7R4gFQi6xW622y7q8AOP104pUq2zDjbZpyRYCkUQ6pNX8/JAmXR3PSxHoz
 d8ko+CNwgxMWM7FTJMRy4WHkx1XQMhW5jsXkTjXAuyDMsxPvQL4sTl+3W9oi0K0wA+brmIQxB
 UnfC/VIDcUkXFSpeR5VMru2wxXkWMeY55Sz1uGzfzZbHCSfPT3/esCGIpIxcvJkKRoEtQl0um
 IM0kUFgaybvExCToWhT7ky3fzrF0cyJvFNvSL+W+8ZoqgHzcm5q5t+ss7S3A8JdTedSAKPDjp
 1C8y3sFtD6Cvli6MbLnaDdrZFfPNhxGWJ7Caj8JOkZ+lJtFBlcmFwmd7Vf2r3DiEm1BNrxV4I
 CZg9ilYQiSON5l6R844j+ImgDP1lps1IuSylEGk48hGgN78b6qPbviHHMN0oqbygyq8d6WB9m
 DwuquQBU+wV6PCCShWQfh/0D+36ms6NGF/yh3G/3rF+iPoIFhA8uRF4JjeU0Pig5/I+arQ6In
 18G5Tlejomn+ZSEBrHgPh5KkLolgfSQ8Igd26aWamxqlGUey/k9Pte8HALW7XClkdYiWF+xAW
 lN7RsF21/hTc7XRYtlETUlES4mQY7S2yut5/ewefJmP7q8NGP4z4dAFgizSEK6TkNboe8F/s6
 toMg2U/Ciut4D46tfl2lHHYT6QPmTTrtQ0VYH9tAjFXP+YFVmYLFu7HTVWOEdDx4gqKZTuodi
 xxfa6pr2SNNIccXsj72iKIAyiP0Rrl9fyTEPO1zY+ruoE=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 3/25/24 04:04, Richard Henderson wrote:
> With r1 as zero is by far the only usage of UADDCM, as the easiest
> way to invert a register.  The compiler does occasionally use the
> addition step as well, and we can simplify that to avoid a temp
> and write directly into the destination.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>

Helge


> ---
>   target/hppa/translate.c | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index a3f425d861..3fc3e7754c 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -2763,9 +2763,29 @@ static bool do_uaddcm(DisasContext *ctx, arg_rrr_=
cf_d *a, bool is_tc)
>   {
>       TCGv_i64 tcg_r1, tcg_r2, tmp;
>
> -    if (a->cf) {
> -        nullify_over(ctx);
> +    if (a->cf =3D=3D 0) {
> +        tcg_r2 =3D load_gpr(ctx, a->r2);
> +        tmp =3D dest_gpr(ctx, a->t);
> +
> +        if (a->r1 =3D=3D 0) {
> +            /* UADDCM r0,src,dst is the common idiom for dst =3D ~src. =
*/
> +            tcg_gen_not_i64(tmp, tcg_r2);
> +        } else {
> +            /*
> +             * Recall that r1 - r2 =3D=3D r1 + ~r2 + 1.
> +             * Thus r1 + ~r2 =3D=3D r1 - r2 - 1,
> +             * which does not require an extra temporary.
> +             */
> +            tcg_r1 =3D load_gpr(ctx, a->r1);
> +            tcg_gen_sub_i64(tmp, tcg_r1, tcg_r2);
> +            tcg_gen_subi_i64(tmp, tmp, 1);
> +        }
> +        save_gpr(ctx, a->t, tmp);
> +        cond_free(&ctx->null_cond);
> +        return true;
>       }
> +
> +    nullify_over(ctx);
>       tcg_r1 =3D load_gpr(ctx, a->r1);
>       tcg_r2 =3D load_gpr(ctx, a->r2);
>       tmp =3D tcg_temp_new_i64();


