Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C60C48BF6
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 06:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgfhv-0008E5-3I; Sun, 03 Mar 2024 01:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rgfhk-0008Cr-JC
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 01:52:12 -0500
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rgfhi-0005eF-No
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 01:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1709448727; x=1710053527; i=deller@gmx.de;
 bh=ELreuQvFiullE7etmPzNrQcTKx8KpiktqaIEAtJOVmA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=UOstU44TJ3b2SaYcX/BZMI6R0Uqw6ECz/zHVSebQF0eIkSoFavwYT/ql90JoTvL0
 VxO1wIZ0VL32tGUgdqh39tPsXWXYdKo4eLVqlM3sQHEMfW5d/KJOzvjbDf4TwmYvY
 krgXUObb5hpY8nmma8/W7nW4b2c11tV3RnAFvt2ltZQbTZSoE8hTcUyBfj1fVwBuT
 Db/xbMdfKWovKqm7Bs6V+uqPMHg34Zs48/BhYGaAinNkOyA9SceKD1FNafL5q4YlF
 J7Aj56RjVjWRIKRQV06xIeOvsbygXr/MgvpySi8qXNEBbhkMHyVYD9wVo8nTcRE3w
 egt0CaWOaiwVZ8cR9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.157.166]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhlKs-1rBziJ07pQ-00djme; Sun, 03
 Mar 2024 07:52:07 +0100
Message-ID: <d71b8c47-336d-466d-bfbb-c04f955b20e7@gmx.de>
Date: Sun, 3 Mar 2024 07:52:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/hppa: Fix assemble_11a insns for wide mode
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: svens@stackframe.org
References: <20240303021925.116609-1-richard.henderson@linaro.org>
 <20240303021925.116609-3-richard.henderson@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240303021925.116609-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H7wmmdbniTQXWnNPLD4CWiIC1qCCEB8YW6VqOJGklmzfyHB3aMV
 otBzs3uizsULn7iEuVxS2azzJweodRLD1uzmvaib8RI1ceYfLdd820tDm6Jh5NmTlFAFrZg
 NxW723nVwhr740b1hTtYv0mLhS7GIg0TaUvjsuj8dDzV/InyjsV0EwBd2eZohoa5k36cz4G
 BkFs/QePleyMOq5Fi++sQ==
UI-OutboundReport: notjunk:1;M01:P0:5QGKZQi234Y=;DA1P0Tt+BD7mErGJf/FfyNXG0VW
 OTuNB/20qZcQXgJHPidMeEKWHP1m3ZrXrvAnZNk8uVlCBt9UoBXq1Er7U9sX8sTyDA/dcxsIR
 WYMYUiahtyDiXcVwfYL+fzCUntzoNiuPjL+5swpJNmehMX9YgzjCVyX4eGdICoeTxnrxtP5aH
 tXtCoKx2WbHH86T2ndsVStXMESIgmI+ZPDCzGXv0nqK9HAdHgAykWfbJlap8gz55DT25Myqn5
 rpq1wBPvLf4qSqbVKJBbW03AmRDyNPpupRd6O1+QCAe4X1ih1HjGqTqdnkAXEU65CDH6WwZM7
 srDFAliFL4pnMmc8Io5BxWMmKZyYZjxojeZS31hADk92WEaKR8Csfy9C0pOUO/NAwM99BRnGL
 98trxKXm7/7G72rQ6SkOPum0xoTZdhedLoztDJYDBOGaAeehltbLFmJ15u8x+Bwz7IY8dDtHO
 24VaI3Ojih3uq6FWWlNTcQIAVCJ+IRV5C/ExB7G5iDxh15WAN0++8GK2XOqtR9nRIxnFLXnu9
 I39e0/V/PemxJMt/KtCnetf4goM2YoKCvlPoirBCnkhyjfP9ANPEdU2k51pxyvARslot9Dv2H
 bh3+5hzg8n5Hp4FRvFblJuHCV+DdDK90MI5vWn8TJHMD/CXAimP/XQIyo4xrP6yPES+YH6quQ
 hc5nzqT6WZoo/N74PN7Wd49ZLHZrsia6vI32bS18Sq87kO5Bw9NNl9VTepJtAcJQEzC5P3NIk
 GXfuKZDnOMnKDBuMACE9mGMhaM1EyQIiBdpGq+838+MtCrapo+BJYB25l59w75Ks0rfMJtLOJ
 QgnfCCVLeD5bQvoDF/Bqw9zcHNABi6bsMiHm1DG52bT6E=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> ---
>   target/hppa/insns.decode |  7 ++++---
>   target/hppa/translate.c  | 23 +++++++++++++++++------
>   2 files changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
> index 0d9f8159ec..9c6f92444c 100644
> --- a/target/hppa/insns.decode
> +++ b/target/hppa/insns.decode
> @@ -24,7 +24,7 @@
>   %assemble_sr3   13:1 14:2
>   %assemble_sr3x  13:1 14:2 !function=3Dexpand_sr3x
>
> -%assemble_11a   0:s1 4:10            !function=3Dexpand_shl3
> +%assemble_11a   4:12 0:1             !function=3Dexpand_11a
>   %assemble_12    0:s1 2:1 3:10        !function=3Dexpand_shl2
>   %assemble_12a   0:s1 3:11            !function=3Dexpand_shl2
>   %assemble_16    0:16                 !function=3Dexpand_16
> @@ -305,8 +305,9 @@ fstd            001011 ..... ..... .. . 1 -- 100 0 .=
 .....      @fldstdi
>   # Offset Mem
>   ####
>
> -@ldstim11       ...... b:5 t:5 sp:2 ..............      \
> -                &ldst disp=3D%assemble_11a m=3D%ma2_to_m x=3D0 scale=3D=
0 size=3D3
> +@ldstim11       ...... b:5 t:5 ................          \
> +                &ldst sp=3D%assemble_sp disp=3D%assemble_11a \
> +                m=3D%ma2_to_m x=3D0 scale=3D0 size=3D3
>   @ldstim14       ...... b:5 t:5 ................          \
>                   &ldst sp=3D%assemble_sp disp=3D%assemble_16  \
>                   x=3D0 scale=3D0 m=3D0
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 585d836959..6dcc74e681 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -121,12 +121,6 @@ static int expand_shl2(DisasContext *ctx, int val)
>       return val << 2;
>   }
>
> -/* Used for fp memory ops.  */
> -static int expand_shl3(DisasContext *ctx, int val)
> -{
> -    return val << 3;
> -}
> -
>   /* Used for assemble_21.  */
>   static int expand_shl11(DisasContext *ctx, int val)
>   {
> @@ -144,6 +138,23 @@ static int assemble_6(DisasContext *ctx, int val)
>       return (val ^ 31) + 1;
>   }
>
> +/* Expander for assemble_16a(s,cat(im10a,0),i). */

Typo above, should be assemble_11a().

Otherwise:
Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>

> +static int expand_11a(DisasContext *ctx, int val)
> +{
> +    /*
> +     * @val is bit 0 and bits [4:15].
> +     * Swizzle thing around depending on PSW.W.
> +     */
> +    int im10a =3D extract32(val, 1, 10);
> +    int sp =3D extract32(val, 11, 2);
> +    int i =3D (-(val & 1) << 13) | (im10a << 3);
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


