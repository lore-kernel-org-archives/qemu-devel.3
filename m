Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40C3C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 20:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmJbV-0001JO-3O; Mon, 18 Mar 2024 16:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rmJbT-0001J2-J5
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 16:29:03 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rmJbR-00023y-7w
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 16:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1710793736; x=1711398536; i=deller@gmx.de;
 bh=WvsuPrZ0tqAwRzQ/KloEgNBdXl8EKEbqKyYrP8yNifA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=ZqTbiAqhdU0/afz+qagWt6LPQuA75c60pTUNKTuWFsvWcrtWFfLIhqNhsnmL+OyO
 WfOApqbDf8IZ1RPZN0q6lTVRuy078sxCAHhMZIHJFJ+//K9t7MdmyQg/VsWyzwtqi
 M/N8DX+PMiFFiGiSYcSm2+7g3Tqd3SxukRf4ZXlDUJN4mybPxi+fSnuHUiAVEGdax
 DqS/dXbQgEgjmyMl1tyFqiRPKbTdUgGghOjcrz/TMlT10tlwg/cnFhU49yz55WK/j
 4uQ5ws0lIyyKfaKvRdJbRY2DiYgbLVsRHbaHPG3ZACbrNuVA0eBrSQOprRfjz8Icp
 Kp+NNaqloE80sxNUbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.155.237]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mjj87-1r2meJ3EdP-00lE0r; Mon, 18
 Mar 2024 21:28:56 +0100
Message-ID: <d28de9c4-9bf3-4757-88d9-8f4bb6ef6cb6@gmx.de>
Date: Mon, 18 Mar 2024 21:28:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] target/hppa: fix shrp for wide mode
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240317221431.251515-1-svens@stackframe.org>
 <20240317221431.251515-3-svens@stackframe.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240317221431.251515-3-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qrTEr2QfXj+6//ANy4FvBTzaB14e2NJnCbHqISk2LV0ZtbQbTyH
 ztM51GZEr2oFBrHhon997VMLxkQboJQ1soa8pKIj+3LxuW2Z1DrxkB0U1V9IY7zedBNXSL+
 p3M4fOnrKkyc5JPXm3xKyKNVTmas5uXpFwL34AKBaMrlPed1UFgTiF8G9yd26U0yG5NP7ND
 qbY5EB4/XvLKEKXRMDAyw==
UI-OutboundReport: notjunk:1;M01:P0:nApgWvJNLFM=;3J6+TLJ2+5Zf/rjNWAB1uQkFQkG
 DIQ+sUOkJSV+eOqQezKfwssSXPdF/CQfeuo1spX4wEe3V5xFr+TWbs8GwwBrKxSCy9z55roze
 RQ1S38OR6CHKqC7QTGgpqnSfqCXvF3esOV1OVGqAivR3QAGWyHsJYx66Tn0rNhhAom6CECv5b
 yxK75dCtuvMeClOXWRtzBTYMa6P3tkOUQMfEw0+z8GrCnE7ILsTRolMzrVy238IK66+2LDtAs
 toQHat8blKpzOkRTzDMzjls50rnfxULC3jeOAzKBGbRuOzVVNMxsjXURdwO5ny6evtqycCIA2
 Ldcy3fIOnbWKBrukdSLU+Rh/jAY4ncI3TEFfIGUxfRKq/HhR4/MsEG2u8BSkVj27Hd3vzQLWB
 xM38Bc4JcRMp41z8wnV/eF6oC4Ez8/CyKPwEpf5RYnEWY+oFFgYOPWq/8VXnwGrBFplEnP6v7
 SwpmNHLViH4FDVsdEqq5nvTBgy1sFObZClUddVfkmvKlyiAWIFw3bzweY7CUfXA2mD3ovebwY
 Yx6uYi7mKkf1hEmNafxSiZR9UCoHfx1T1V9YkDDr6m6CoyosLKIyE5FN3LbXz5mw+phYa5H18
 STCnFWR/T0uZP3Rbucpk1YDD5a776E26sSCVpEBxUIhxOSL8DjtcACMzVIRhQ3duxUT5ldTg3
 4baICRbHCkQTTjU9/Oegl8cwzq3StUVVpa42w6uv605JVzXFj7aaK2vZCNKHTAtx+Vtzg/OfC
 OQiC5mqaEBBkeZ6dQpIO61NIL5JkTfJwPXxJarGEUXHhIiw/tDzZGdVaqgoeX+NohOuy+8VCS
 XuOoFROHTwzJBXNYXUmj9/PKsgxZh1vsn0ngnvav5Hyf0=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/17/24 23:14, Sven Schnelle wrote:
> Signed-off-by: Sven Schnelle <svens@stackframe.org>

Reviewed-by: Helge Deller <deller@gmx.de>

Helge

> ---
>   target/hppa/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 6a513d7d5c..8ba31567e8 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -3462,7 +3462,7 @@ static bool trans_shrp_sar(DisasContext *ctx, arg_=
shrp_sar *a)
>       /* Install the new nullification.  */
>       cond_free(&ctx->null_cond);
>       if (a->c) {
> -        ctx->null_cond =3D do_sed_cond(ctx, a->c, false, dest);
> +        ctx->null_cond =3D do_sed_cond(ctx, a->c, a->d, dest);
>       }
>       return nullify_end(ctx);
>   }
> @@ -3505,7 +3505,7 @@ static bool trans_shrp_imm(DisasContext *ctx, arg_=
shrp_imm *a)
>       /* Install the new nullification.  */
>       cond_free(&ctx->null_cond);
>       if (a->c) {
> -        ctx->null_cond =3D do_sed_cond(ctx, a->c, false, dest);
> +        ctx->null_cond =3D do_sed_cond(ctx, a->c, a->d, dest);
>       }
>       return nullify_end(ctx);
>   }


