Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4F1606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SWrdztzZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xStRN-0006Xq-MA; Mon, 16 Nov 2026 04:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xStRK-0006XS-Fd
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 04:55:54 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xStRH-0001su-V8
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 04:55:53 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-67db1f6f50eso922807d50.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 01:55:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794822950; cv=none;
 d=google.com; s=arc-20260327;
 b=TCfrSixRekJ9BuTjD8FgaD1llcRjtl0sVUUMa87keRUhNDmTUqYxduQ/dMlOZKPD2h
 Rf+z80RQ1tm1szG9HwBxL6rw1pbLUWImpumx+UkLVHG/5irDj//jLmBUQxd1O0vA3sk8
 +NdfPX2cYpAIVrhEKLzTIbX63qqYUJEr0PzWAecWYO3x8MQMKR8CdnU3HuPPFGtUXRUy
 7GNwJvZtt/3FfElJNU5AS5ECdf0JZBFjyzkNtpV7/52zZsp8wlP5jwHBY747oDm2qFjw
 1K1u8+K5z9ynCmYr+N/dWXxHfOwa2tW9AXGNZeh18Pzhs1PxJy5IdOSBR/Mzq5bkzcu1
 kUIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dHpt5BEgS9XvCThL9tAUpr/conMjxdNUnVKFUIvkzm0=;
 fh=hsB5Cjbiv2lE513iZTHeCPbP4VsCh9HQj1vpKez3KkM=;
 b=pz8PzM61n7bhT6WRCtlXEU8R8ChjUImrnvso6hyM+AJhsQWfm510KOa9tp0q7plz1w
 RSSz2RJmmn+omDpfpu1GXcdG5nULHO2Y6/Be6LB3iCah4jOpK0vXX9PwuQl1U3mPKiQ2
 9gRSSWHwyNSyfwaIN5vKwbZPJ/ObxRNunIdDVZqQQhVmhG9tJJkYwfs9gX1Dea5IXCoq
 deQwmAwEOWjpL4Gt7cdfEMhnqtmPSXdCibuMrEnH29Jg1Tcm2K4Bv84XtQJ3Sw4OfJ46
 nDDg75+r0n3anjq1iiZgw98GtMLAO0QDwZA9zISGXPmegXjpnrTNhjj/QdGMrUMKj8P5
 lYXw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794822950; x=1795427750; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dHpt5BEgS9XvCThL9tAUpr/conMjxdNUnVKFUIvkzm0=;
 b=SWrdztzZFVcFiqrgCLr3ViMkrwifhX32Q4wCXCPAdCmYZb4PNm2DTby2tWNZiSt0hu
 pUo5OdTaLpUb5+ssVdxuZCIm3GuO710meb7mtreciMpOkNF1t7cMSGVUfSSbUNCHDwLV
 AhN4gEsnjQtZ5h2ZXrK4LR30v5/FFncWKvKKYYvLll6jQ1Ix2fRk5wzlzNNq7QZCxE88
 E32KCQTETSYwTg/Xbv9QXbKyC8vTwXM5nOQ9aFAjPYDJjAhK6lvV7j+DpSwDY1tzdtVh
 FMA5f/GUP05JJ1jBbhjgTQvAfqj/5eLhMm1Z46X9y3c/RLXc9NVDH87lzChdL3Yo0by0
 7IBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794822950; x=1795427750;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dHpt5BEgS9XvCThL9tAUpr/conMjxdNUnVKFUIvkzm0=;
 b=XXQsw9N0+4aZK7vxpzDWI65MzJqLBDcL2krIVEHsH7fYrAB8BLEH4UmB1q8qQ5ANVc
 9wyXFNtvO+CNXWwlhCaJE/ZyfRqAjLP8/9KjQShdpuEtP6EDLkRligQyI4sIfTyv6Tr+
 a2Ee5d2juPuuwkopgrWedJpxxKB7kFY3zUFZEa8wXkbGRA7vV1he8ltgvOl6/gk4GjJF
 d97lq7R6kWpD5kQqG0nIPQZY60nqnK7mttxLdQbrVJR9LMr5OYwAWFCON1JhL2k5fcdp
 ncH7KRgl71Sm0NFjU3GLXKjXADw8T0e4p3gdY8YJDv4/vPVWWuLchbhn/ccJ1FQoGm5z
 kRrQ==
X-Gm-Message-State: APuU4Z86BdpuC40GweFJXcg4fM1j26viOaF34AbkaWjKkc0eAMa91UUV
 D3x7tshrokkaK2by0HWGZXC8rL0AwGmH5KLBoMN33KcY6yPoVnkPxrr+WCx1EN3AnTjVX5+DuR/
 0aE0Cni4+REdqh5oH2CaTG5UMpLrT4FPwAWh79xLhEQ==
X-Gm-Gg: AZFdTZdmDUPUlPV9LfNYnYscvs35W+ZC6FxevTyrA6FEqttuCMNnz6VS2YWCdPHFrbI
 VaL6fX1m9MKjcKtsA4Ef2MgpFM+vwF3ZIRN2sytOU3qgza94Qy9CjtdTIViVmuQHm7PvhsApPjI
 SPR/M/VKzJuNdrV5yTo33wug5aPBRGTWLV66AQg8B1y1fDA7bctrluZ7O0B4W3lSo2gL5M1i8mQ
 6kPt+RVZeZW2oB66stgzJgzhH2q2wr6ZHSBtuFCFVhAHMxcCfU2Us2gmcYk0IcNwa0q9YSQCwiL
 YuxV+7ydLmQ0PYQ4nyTysVLv42opkIEXpePzqI8ARKkoViEiQxOi9VXV2zdQoWuIlbXVO/mnFY9
 /HEIJCfzGYl9jJBkXVz2O1ZO36ni9ZP0yMzdriGKJ4jXltOPrInXjgsig2WbHeeAzNSrn5w5FIX
 s1JGCSqBbbqw3HGNZD8Xdmevqi4Ofo1qfrqHLc4JsXAg==
X-Received: by 2002:a53:c38b:0:b0:67a:5ed4:9507 with SMTP id
 956f58d0204a3-67d8983bdccmr4413025d50.93.1794822950418; Mon, 16 Nov 2026
 01:55:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <CAFEAcA8G-aoxoeEOy2SyUcYyrfxMazHZvB+hfZZYOrbMcmhxkw@mail.gmail.com>
 <f749e844-5f7b-4e5e-9251-40251c531b82@oss.qualcomm.com>
In-Reply-To: <f749e844-5f7b-4e5e-9251-40251c531b82@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Nov 2026 09:55:38 +0000
X-Gm-Features: AclHuK8QfXXByg-QA1hveAvS9ro5qva5lGXNSxQUl26FQ_6ZWcyBkUJTnfucGS0
Message-ID: <CAFEAcA-ihP0DrO404vZDYVbnPjbZg2UMAanYJPMqmtR039oG-w@mail.gmail.com>
Subject: Re: [PATCH 00/19] target/mips: Mixed bag of fixes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>, 
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Milica Lazarevic <Milica.Lazarevic@syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026 at 08:37, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
> On 13/11/26 17:34, Peter Maydell wrote:
> > If you have a little time for MIPS could I get you to have a look at
> > Coverity issue 1689817 ? It's not urgent, but Coverity complains about
> > what it thinks is some dead code in the dextr_s_h helper:

> > I don't know what this instruction is supposed to be doing, but
> > it would be helpful if somebody who does could have a look and
> > rewrite the code to either do the right thing if the current
> > code is wrong, or else to rephrase it so it is clearer about
> > what it's doing if it's getting the right result in a weird way.
>
> Although MD00375 (MIPS64 DSP) and MD00765 (microMIPS64 DSP) manuals
> list the DEXTP* or DEXTR* instructions encoding tables, they do not
> contains these instruction descriptions. We can infer from the MIPS32
> EXTR_S.H semantics which saturates to [-0x8000, 0x7FFF], sign-extend
> to 64 bits and apply to the 128-bit HI:LO.


> But this is a good opportunity to rewrite in a more readable style
> (I'm not a fan of complex condition checks in particular when 'else if'
> is involved, I rather use local self-descriptive booleans); the same
> fix becomes:
>
> -- >8 --
> diff --git a/target/mips/tcg/dsp_helper.c b/target/mips/tcg/dsp_helper.c
> index 73934cab7786..82a9a29c0213 100644
> --- a/target/mips/tcg/dsp_helper.c
> +++ b/target/mips/tcg/dsp_helper.c
> @@ -3379,28 +3379,25 @@ target_ulong HELPER(extr_s_h)(target_ulong ac,
> target_ulong shift,
>   target_ulong HELPER(dextr_s_h)(target_ulong ac, target_ulong shift,
>                                 CPUMIPSState *env)
>   {
> -    int64_t temp[2];
> -    uint32_t temp127;
> +    uint64_t temp[2];
> +    int64_t lo;
> +    bool negative, fits_s64, fits_s16;
>
>       shift =3D shift & 0x1F;
>
> -    mipsdsp_rashift_acc((uint64_t *)temp, ac, shift, env);
> +    mipsdsp_rashift_acc(temp, ac, shift, env);
>
> -    temp127 =3D (temp[1] >> 63) & 0x01;
> +    lo =3D temp[0];
> +    negative =3D temp[1] >> 63;
> +    fits_s64 =3D temp[1] =3D=3D (uint64_t)(lo >> 63);
> +    fits_s16 =3D lo =3D=3D (int16_t)lo;
>
> -    if ((temp127 =3D=3D 0) && (temp[1] > 0 || temp[0] > 32767)) {
> -        temp[0] &=3D 0xFFFF0000;
> -        temp[0] |=3D 0x00007FFF;
> -        set_DSPControl_overflow_flag(1, 23, env);
> -    } else if ((temp127 =3D=3D 1) &&
> -            (temp[1] < 0xFFFFFFFFFFFFFFFFll
> -             || temp[0] < 0xFFFFFFFFFFFF1000ll)) {
> -        temp[0] &=3D 0xFFFF0000;
> -        temp[0] |=3D 0x00008000;
> -        set_DSPControl_overflow_flag(1, 23, env);
> +    if (fits_s64 && fits_s16) {
> +        return lo;
>       }
> -
> -    return (int64_t)(int16_t)(temp[0] & MIPSDSP_LO);
> +    set_DSPControl_overflow_flag(1, 23, env);
> +    return negative ? INT16_MIN : INT16_MAX;
>   }
>
> ---
>
> Is it reviewable-enough to be a single fix patch or do you rather
> that split in 1 fix and 1 refactor?

I think that's OK as a single patch if you explain in the
commit message which cases the old code was getting wrong
and what the intent of the code is.

-- PMM

