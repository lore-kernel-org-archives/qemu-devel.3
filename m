Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA3CCA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 10:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl4Iu-0003Uh-Hi; Mon, 02 Sep 2024 06:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sl4It-0003U8-5a
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 06:28:59 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sl4Ir-0008MX-8T
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 06:28:58 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c255e3c327so1147596a12.1
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 03:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725272936; x=1725877736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VuLWGPc+fBuQ9iaV3/2pEGUNCaaM8aCitYg18xppFvg=;
 b=Id2EFmkptuAPJyALEzlb2KZ9EQXMVGD8uAOz+n/dY8RTFbuvCvlOWNRQZFEZ6LYC5b
 ybEnTLaxEBeOFZ7mZ0f4BijsB2z3pCHDk/axpsgSOH0RHGKxLjwzHIOMx2rdyQfqV0Hy
 ZpvZ6y8sA+DwKeu6JTGyKMciWQ0Vk7DNkm965HoBtYpzEO0ugaZYnPkXfhuFygXaVleX
 Gp9RKOnmoXR/fk0d7Ad0LodGCtSCtTY6M+wtOUu5K/Nhs9jX5/kfPf/VhrreAN4Ko+0r
 T1G0R6d/nzYmn3WR/CUod0cHYQtPJXJ0/kFywl7GSIoWPBCTPpGrWDcq9PwODuFPbJRA
 OjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725272936; x=1725877736;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VuLWGPc+fBuQ9iaV3/2pEGUNCaaM8aCitYg18xppFvg=;
 b=UMEWkiQsF63K4noSP6xg+CAB3v9MDZT/B1ZzI+ZoEw1cD3RewaDBwc9LPpelP+6aT5
 ddkCJnRCh9FT//jw3taWVb13YnXrWCw1dJUpNxXWGpqVaHLyrzSDmZUzTUUZ0krovNHn
 joawDTRI2OSk+ikMV/OjdlawMb7S2y5IFrU3fiDHeBGfm552YeVoODnUzwTX6iaT09mK
 a8bGcDGdqql/0S9kRZ0lJJeWD+bUUbp9G42NOukjCr3ntm0+Ld3ZAWiiJOZmG+4X4MZM
 K+hKF2A2SJ9I5DL4MTVlQJXujXXCZHW5ypEa10JX0144mulwP8HhABbyXZtl/syPFpYv
 jfBg==
X-Gm-Message-State: AOJu0YyP7ziMP7Y78/2dIIegB5jDJkM0siFZrvYqLl11pZAI3SP/1o6a
 yOi9zo4Ry8vvk8cEcePiMdr74P/vcXH0W4Huv37iAMnmjoHpvYlynUmwDhLAi0g=
X-Google-Smtp-Source: AGHT+IGzcWPpsq8hX6MN6jafLFNXronzC1AHXiYCVsF5efnWz/3V6RmIvPJv/lNoFScXmIZZPXFRYA==
X-Received: by 2002:a05:6402:2812:b0:5bf:2577:32b8 with SMTP id
 4fb4d7f45d1cf-5c25c3ad602mr2608981a12.9.1725272935037; 
 Mon, 02 Sep 2024 03:28:55 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c243fd65f4sm2925323a12.29.2024.09.02.03.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 03:28:54 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 74B2E5F835;
 Mon,  2 Sep 2024 11:28:53 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alireza Sanaee via <qemu-arm@nongnu.org>
Cc: <qemu-devel@nongnu.org>,  Alireza Sanaee <alireza.sanaee@huawei.com>,
 <linuxarm@huawei.com>,  <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>,  <shameerali.kolothum.thodi@huawei.com>,
 <Jonathan.Cameron@Huawei.com>,  <jiangkunkun@huawei.com>
Subject: Re: [PATCH v2] target/arm/tcg: refine cache descriptions with a
 wrapper
In-Reply-To: <20240830184713.224-1-alireza.sanaee@huawei.com> (Alireza Sanaee
 via's message of "Fri, 30 Aug 2024 19:47:13 +0100")
References: <20240830184713.224-1-alireza.sanaee@huawei.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 02 Sep 2024 11:28:53 +0100
Message-ID: <87r0a2cpsq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Alireza Sanaee via <qemu-arm@nongnu.org> writes:

> This patch allows for easier manipulation of the cache description
> register, CCSIDR. Which is helpful for testing as well. Currently
> numbers get hard-coded and might be prone to errors.
>
> Therefore, this patch adds wrappers for different types of CPUs
> available in tcg to decribe caches. Two functions `make_ccsidr32` and
> `make_ccsidr64` describing descriptions. The 32 bit version receives
> extra parameters that became unknown later in 64 bit.
>
> For CCSIDR register, 32 bit version follows specification [1].
> Conversely, 64 bit version follows specification [2].
>
> [1] B4.1.19, ARM Architecture Reference Manual ARMv7-A and ARMv7-R
> edition, https://developer.arm.com/documentation/ddi0406
> [2] D23.2.29, ARM Architecture Reference Manual for A-profile Architectur=
e,
> https://developer.arm.com/documentation/ddi0487/latest/
>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  target/arm/cpu-features.h | 53 ++++++++++++++++++++++++
>  target/arm/cpu64.c        | 19 ++++++---
>  target/arm/tcg/cpu64.c    | 86 ++++++++++++++++++---------------------
>  3 files changed, 105 insertions(+), 53 deletions(-)
>
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index c59ca104fe..00a0f0d963 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -1022,6 +1022,59 @@ static inline bool isar_feature_any_evt(const ARMI=
SARegisters *id)
>      return isar_feature_aa64_evt(id) || isar_feature_aa32_evt(id);
>  }
>=20=20
> +static inline uint64_t make_ccsidr32(unsigned assoc, unsigned linesize,
> +                                     unsigned cachesize, uint8_t flags)
> +{

isn't this returning a 32 bit value?

> +    unsigned lg_linesize =3D ctz32(linesize);
> +    unsigned sets;
> +
> +    /*
> +     * The 32-bit CCSIDR_EL1 format is:
> +     *   [27:13] number of sets - 1
> +     *   [12:3]  associativity - 1
> +     *   [2:0]   log2(linesize) - 4
> +     *           so 0 =3D=3D 16 bytes, 1 =3D=3D 32 bytes, 2 =3D=3D 64 by=
tes, etc
> +     */
> +    assert(assoc !=3D 0);
> +    assert(is_power_of_2(linesize));
> +    assert(lg_linesize >=3D 4 && lg_linesize <=3D 7 + 4);
> +
> +    /* sets * associativity * linesize =3D=3D cachesize. */
> +    sets =3D cachesize / (assoc * linesize);
> +    assert(cachesize % (assoc * linesize) =3D=3D 0);
> +
> +    return ((uint64_t)(flags) << 28)
> +        | ((sets - 1) << 13)
> +        | ((assoc - 1) << 3)
> +        | (lg_linesize - 4);

This is a nice improvement but using deposit() will ensure you don't
accidentally overflow fields with the shift/or combos. So something
like:

  uint32_t ccsidr32 =3D 0;
  ..
  ccsidr32 =3D deposit32(ccsidr32, 28,  4, flags);
  ccsidr32 =3D deposit32(ccsidr32, 13, 14, sets - 1);
  ccsidr32 =3D deposit32(ccsidr32,  3, 10, assoc - 1);
  ccsidr32 =3D deposit32(ccsidr32,  0,  3, lg_linesize - 1);

And leave the compiler to simplify everything (not that it matters that
much for an init function).

Actually I note CCSIDR already has some field definitions so it would
be:

  ccsidr32 =3D FIELD_DP32(ccsidr32, CCSIDR_EL1, LINESIZE, lg_linesize -1);

etc. Although I notice it two sets of defines to account for FEAT_CCIDX

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

