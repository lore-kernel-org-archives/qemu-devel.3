Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C08C48BF6
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 07:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgg0g-0006YD-L0; Sun, 03 Mar 2024 02:11:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rgg0d-0006W7-0J
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 02:11:43 -0500
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rgg0R-0002uT-36
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 02:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1709449887; x=1710054687; i=deller@gmx.de;
 bh=wQZk/9gmE8tNZ34ysJ6k53njHAewUxjBorKYM+UowKY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=km1d4yvzeYfLkDnoA777lDtBNwYfsU5WxCnxMPC7+ZvxK3ryg3boDZ2V7BQT+yos
 /MQ1AkbHYBhRPbPaBlqiZy10ZEfQeQdwdTEQrcpQRWmkh0iBbV05axZYuCQnpA3mK
 /TEF8QJj4U43Phvtb1M6acqwGlcgiuuXQEnu1nLQXOJl2779zvbwRb6BQ3hFp/EJw
 S1rmG+TZ6aiVlluaColg6uU7hDRXrsQTbMup6EwG1MXdnn8CaHvG+hnNysHi83FcZ
 wpKgSnlbdqOGE9oOeH1pZzSQrTCjYJrNGR+6+TxBkSiJBSmghISEXDkfc4kF95y4c
 seCYAVojIyqcA/1ZZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.157.166]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95e9-1qlOgr46CN-016AMC; Sun, 03
 Mar 2024 08:11:27 +0100
Message-ID: <7fbb3b2d-4a76-4899-8a7c-25a97c125bf4@gmx.de>
Date: Sun, 3 Mar 2024 08:11:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/hppa: Fix assemble_12a insns for wide mode
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: svens@stackframe.org
References: <20240303021925.116609-1-richard.henderson@linaro.org>
 <20240303021925.116609-4-richard.henderson@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240303021925.116609-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:etb51NtPGEk1DpP7pBvlsvexnlxMPgy84InHaP3r+R1mf28mGTg
 P0HT1EUqF1DA/Ew1n0YVfO4BF68W2tgjz6Y5WG0jFTS/D73kyf6aq9t4KJFF2pgbO406SOP
 mFO+vvsbz6gLXB0vVsvM5zKd7WT39YoXIWTaobMz7ZBOCkXag6Xq3CJxoWuUoyxT8A+M73N
 vQ67vB4q4MBIDkVK/RkLw==
UI-OutboundReport: notjunk:1;M01:P0:vIRMhwZ3CCo=;ivM8GYr0Zi3orls6zERGTHDKOKQ
 on0h3YnhhxNCnoejMIpBunmCZfKyZbyKaFiPL++3vxNNZNNH/SyF+xj9bw20yExAD266O7BwY
 2l3b7lfg8NZbnLZKv9nIQGP97HK8MGKMP6PAd0LfEeD9W3K1MJ8c6os+7yB+d+ckiuQvc5Z1r
 3R2mRe+1nh4G2ktoOV3q7GWpYrLSafgJ6TBJPyF1fX4H+K5uvl8rS6PoULWmfY5lTfUQAUb2I
 7+ffQ72ZPDzvjKohy5weki9yDdiwBhnFZvbjcMZ8QIGBqzIUCwIWkvLWQ7q8OsX59N5tKeOed
 oX0GWxXIuQ5JlPmRwE3E7EFXIVyFJc6VW9Cj6r1nLbL39nXrdqNWZSDkK/qWG31M1FuYQ1/Vm
 5ooDn9xiZA9qmjtchsMh+bc8dHV43FzwoBz6CtksBHF13ReEsnOey8yn6Pnl+k3eiaBFQwqfO
 WO3HbauI4QY1RMZRxL7n3wIgONXKC7quyLgMdvlL9cFBWjWvjmXsCH6JacDfFROzRfRBdno8q
 AW23mesden83/whs9qvjnGNIudbXH4TrgYtmL1fcnUv3tQKpPeXeZ61vxTlQ2BNcdRc3WTVTR
 oqIdiYKhwA+r04hsGgPRVITsgmIgDfHRaFUmwzC8Efvk/8gVHRWh31HPSB/RCj+L5FMmMlrtO
 etbzoWDuvVfozN+F3rT6P5EqKju1l5VqJ/G5S0F46ON7yf6PfLil22TQw3yUIGaZrQYrgDbY6
 wdDaCxlsma2CRiA0zwSw/Mv1jsu2SVFKzcwy1SutQIcgTx2b3azEVbFPkKJUbi5sMt+3JCWd+
 NqvcJJ6HFIzX+wpLjBTmjUF2rmXY8ZNlVXe4pifa3Pm/8=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 3/3/24 03:19, Richard Henderson wrote:
> Reported-by: Sven Schnelle <svens@stackframe.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Helge Deller <deller@gmx.de>

> ---
>   target/hppa/insns.decode | 27 ++++++++++++++++-----------
>   target/hppa/translate.c  | 17 +++++++++++++++++
>   2 files changed, 33 insertions(+), 11 deletions(-)
>
> diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
> index 9c6f92444c..5412ff9836 100644
> --- a/target/hppa/insns.decode
> +++ b/target/hppa/insns.decode
> @@ -26,7 +26,7 @@
>
>   %assemble_11a   4:12 0:1             !function=3Dexpand_11a
>   %assemble_12    0:s1 2:1 3:10        !function=3Dexpand_shl2
> -%assemble_12a   0:s1 3:11            !function=3Dexpand_shl2
> +%assemble_12a   3:13 0:1             !function=3Dexpand_12a
>   %assemble_16    0:16                 !function=3Dexpand_16
>   %assemble_17    0:s1 16:5 2:1 3:10   !function=3Dexpand_shl2
>   %assemble_22    0:s1 16:10 2:1 3:10  !function=3Dexpand_shl2
> @@ -314,8 +314,9 @@ fstd            001011 ..... ..... .. . 1 -- 100 0 .=
 .....      @fldstdi
>   @ldstim14m      ...... b:5 t:5 ................          \
>                   &ldst sp=3D%assemble_sp disp=3D%assemble_16  \
>                   x=3D0 scale=3D0 m=3D%neg_to_m
> -@ldstim12m      ...... b:5 t:5 sp:2 ..............      \
> -                &ldst disp=3D%assemble_12a x=3D0 scale=3D0 m=3D%pos_to_=
m
> +@ldstim12m      ...... b:5 t:5 ................          \
> +                &ldst sp=3D%assemble_sp disp=3D%assemble_12a \
> +                x=3D0 scale=3D0 m=3D%pos_to_m
>
>   # LDB, LDH, LDW, LDWM
>   ld              010000 ..... ..... .. ..............    @ldstim14  siz=
e=3D0
> @@ -331,15 +332,19 @@ st              011010 ..... ..... .. ............=
..    @ldstim14  size=3D2
>   st              011011 ..... ..... .. ..............    @ldstim14m siz=
e=3D2
>   st              011111 ..... ..... .. ...........10.    @ldstim12m siz=
e=3D2
>
> -fldw            010110 b:5 ..... sp:2 ..............    \
> -                &ldst disp=3D%assemble_12a t=3D%rm64 m=3D%a_to_m x=3D0 =
scale=3D0 size=3D2
> -fldw            010111 b:5 ..... sp:2 ...........0..    \
> -                &ldst disp=3D%assemble_12a t=3D%rm64 m=3D0 x=3D0 scale=
=3D0 size=3D2
> +fldw            010110 b:5 ..... ................        \
> +                &ldst disp=3D%assemble_12a sp=3D%assemble_sp \
> +                t=3D%rm64 m=3D%a_to_m x=3D0 scale=3D0 size=3D2
> +fldw            010111 b:5 ..... .............0..        \
> +                &ldst disp=3D%assemble_12a sp=3D%assemble_sp \
> +                t=3D%rm64 m=3D0 x=3D0 scale=3D0 size=3D2
>
> -fstw            011110 b:5 ..... sp:2 ..............    \
> -                &ldst disp=3D%assemble_12a t=3D%rm64 m=3D%a_to_m x=3D0 =
scale=3D0 size=3D2
> -fstw            011111 b:5 ..... sp:2 ...........0..    \
> -                &ldst disp=3D%assemble_12a t=3D%rm64 m=3D0 x=3D0 scale=
=3D0 size=3D2
> +fstw            011110 b:5 ..... ................        \
> +                &ldst disp=3D%assemble_12a sp=3D%assemble_sp \
> +                t=3D%rm64 m=3D%a_to_m x=3D0 scale=3D0 size=3D2
> +fstw            011111 b:5 ..... .............0..        \
> +                &ldst disp=3D%assemble_12a sp=3D%assemble_sp \
> +                t=3D%rm64 m=3D0 x=3D0 scale=3D0 size=3D2
>
>   ld              010100 ..... ..... .. ............0.    @ldstim11
>   fldd            010100 ..... ..... .. ............1.    @ldstim11
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 6dcc74e681..1ef266c403 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -155,6 +155,23 @@ static int expand_11a(DisasContext *ctx, int val)
>       return i;
>   }
>
> +/* Expander for assemble_16a(s,im11a,i). */
> +static int expand_12a(DisasContext *ctx, int val)
> +{
> +    /*
> +     * @val is bit 0 and bits [3:15].
> +     * Swizzle thing around depending on PSW.W.
> +     */
> +    int im11a =3D extract32(val, 1, 11);
> +    int sp =3D extract32(val, 12, 2);
> +    int i =3D (-(val & 1) << 13) | (im11a << 2);
> +
> +    if (ctx->tb_flags & PSW_W) {
> +        i ^=3D sp << 13;
> +    }
> +    return i;
> +}
> +
>   /* Expander for assemble_16(s,im14). */
>   static int expand_16(DisasContext *ctx, int val)
>   {


