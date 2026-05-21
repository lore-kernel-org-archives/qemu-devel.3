Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A678ECD5BB4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 15:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ5P1-0003gX-IZ; Thu, 21 May 2026 11:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ5Or-0003Y1-JX
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:33:32 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ5Om-00017N-6d
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:33:27 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-38e7c3a2deaso58803481fa.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 08:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779377601; x=1779982401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KimNAMyXmZNNTWWv9jeYJPSLYiMDb4bG0OyNT/B+qNg=;
 b=DjWiZwo6vHuuFpCbA2AFvqjtLi/Dcn8X/BUHaQcHDpK78gsc/uQVAIcGrb/y08weQM
 9x1g6IgHTOlLwHMHy8CgwWvSfLqvdJU0Tmbg2/5vRNFc3VQujtfV/WiWUTmTulaLXuo3
 9E1PMVNAugwYu+lKfxTZcTCjtWApjwtMeqB8Mcz9wvwoNUfjnZuWUqsaTvmlPV4cYQ29
 dHuQp0ytqwLB9ReV8sl+MbiHd97gWCCHy1zVBGiGW1c5HG7pW5cYGpuqicp3ekkS7CoG
 3C0lBb9zeN8FCJuZ14qK+ikPVBsi/b4wGNfObEmx9Go5w07kS4nrUars92uQvL24eK8v
 aZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779377601; x=1779982401;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KimNAMyXmZNNTWWv9jeYJPSLYiMDb4bG0OyNT/B+qNg=;
 b=osPt7i4OWEn9P0VVwOMtd8lAoh8e2rcbj0IZtHXMAW/PPdwE494bgqaNIkSg+Jt5CS
 7OV+bHX4a1U+VOd0CljXNVaGTlmURVZiQfndAHXcUl78sN16LjHyhmDkq579Cm+rRzbM
 UmJd2BosSK2qMDHzuKVAcrm+OtPEf6+PMxwNSOVvukD1Juey5IY4clNQCSI77aKqNqob
 oqUskb6zzGz3Jznjw7pU9r11xNGgNDdOPfuxfK9XMomka3bT0RRpGPTLgWsdXFtuvV0g
 t2Jbe1h/ny67NIZQNtMWo5OmyarYLC0+4x+0pYH+V2i5MmLOdoJndpQxOAybmqtkfWZm
 SyXg==
X-Gm-Message-State: AOJu0Yx4HxfKtQ3xkp7mcIs6ukdMWmCUBv4g6w7Rsys4FJ8y7hhyIAAU
 pduWsZlZ1TzSA19JxwDghdpYI9bHExXiNHPxQjDadISUazWEKshEY7wJ63JaB91JuINLv8u0sph
 7m8WbKGE=
X-Gm-Gg: Acq92OFvozCfo7+u8Dr/Uq9r/EGtLgCzXmtHqyUF+W+o/2akCnQr2wnIQvknjSrFbtE
 MBYlakeadHZcB99okPOpqdlfdkcaTtwIo05GfjfpqUmB2naUSfA+iDy/V8FkmFIEOKKcnxcru14
 uvPE7Krjlzvu884EVGEe981Oc1mIA0Mf/QAT8oBidU+qDj5h0UHIJLVVgpCafnvOe63VfuccHZh
 TxJcqnvxJSTtQ31wHrJr8J+h9oH+w/cnzKr9Vo1QtOdr7eU/rAnDY7dZ2y5NpjxF2rVsVK5l0r2
 bPNPH7qT7l317N5U7Ky0Xrr1vDVLIu46hXWkPawhrd0+5AOdxQiMr7uvaCLDq3+QaiaDFv9VT9X
 JheSMwGHsQUCBMqmwhCkltphvxBz1pr6bFLspUpuaHu4/YhW4gcgeRXvPo2RDfUu0Puo68ozv1p
 8asmMMtRPFhffuzbR+M66sgMY=
X-Received: by 2002:a05:600c:8585:b0:490:3890:605b with SMTP id
 5b1f17b1804b1-49038906125mr35734655e9.31.1779376943042; 
 Thu, 21 May 2026 08:22:23 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035c47b31sm18444115e9.14.2026.05.21.08.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 08:22:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 61EFC5F886;
 Thu, 21 May 2026 16:22:21 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH v6 01/64] target/arm: Implement ID_AA64ISAR3
In-Reply-To: <20260520182213.872945-2-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 20 May 2026 11:21:10 -0700")
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-2-richard.henderson@linaro.org>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Thu, 21 May 2026 16:22:21 +0100
Message-ID: <874ik0okia.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22c.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h    | 9 +++++++++
>  target/arm/helper.c          | 8 ++++++--
>  target/arm/cpu-sysregs.h.inc | 1 +
>  3 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index 4e44245a8b..50776347a5 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -244,6 +244,15 @@ FIELD(ID_AA64ISAR2, CSSC, 52, 4)
>  FIELD(ID_AA64ISAR2, LUT, 56, 4)
>  FIELD(ID_AA64ISAR2, ATS1A, 60, 4)
>=20=20
> +FIELD(ID_AA64ISAR3, CPA, 0, 4)
> +FIELD(ID_AA64ISAR3, FAMINMAX, 4, 4)
> +FIELD(ID_AA64ISAR3, TLBIW, 8, 4)
> +FIELD(ID_AA64ISAR3, PACM, 12, 4)
> +FIELD(ID_AA64ISAR3, LSFE, 16, 4)
> +FIELD(ID_AA64ISAR3, OCCMO, 20, 4)
> +FIELD(ID_AA64ISAR3, LSUI, 24, 4)
> +FIELD(ID_AA64ISAR3, FPRCVT, 28, 4)
> +
>  FIELD(ID_AA64PFR0, EL0, 0, 4)
>  FIELD(ID_AA64PFR0, EL1, 4, 4)
>  FIELD(ID_AA64PFR0, EL2, 8, 4)
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 8240f1b384..6ad01b345f 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6519,11 +6519,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                .access =3D PL1_R, .type =3D ARM_CP_CONST,
>                .accessfn =3D access_tid3,
>                .resetvalue =3D GET_IDREG(isar, ID_AA64ISAR2)},
> -            { .name =3D "ID_AA64ISAR3_EL1_RESERVED", .state =3D ARM_CP_S=
TATE_AA64,
> +            { .name =3D "ID_AA64ISAR3_EL1", .state =3D ARM_CP_STATE_AA64,
>                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 6, .opc2 =
=3D 3,
>                .access =3D PL1_R, .type =3D ARM_CP_CONST,
>                .accessfn =3D access_tid3,
> -              .resetvalue =3D 0 },
> +              .resetvalue =3D GET_IDREG(isar, ID_AA64ISAR3) },
>              { .name =3D "ID_AA64ISAR4_EL1_RESERVED", .state =3D ARM_CP_S=
TATE_AA64,
>                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 6, .opc2 =
=3D 4,
>                .access =3D PL1_R, .type =3D ARM_CP_CONST,
> @@ -6752,6 +6752,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                                 R_ID_AA64ISAR2_BC_MASK |
>                                 R_ID_AA64ISAR2_RPRFM_MASK |
>                                 R_ID_AA64ISAR2_CSSC_MASK },
> +            { .name =3D "ID_AA64ISAR3_EL1",
> +              .exported_bits =3D R_ID_AA64ISAR3_FAMINMAX_MASK |
> +                               R_ID_AA64ISAR3_LSFE_MASK |
> +                               R_ID_AA64ISAR3_FPRCVT_MASK },

With this definition should we also add it to arm_clear_aarch64_idregs()
which clears the other ISARs with aarch64=3Doff?

>              { .name =3D "ID_AA64ISAR*_EL1_RESERVED",
>                .is_glob =3D true },
>          };
> diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
> index 3d1ed40f04..b99579f773 100644
> --- a/target/arm/cpu-sysregs.h.inc
> +++ b/target/arm/cpu-sysregs.h.inc
> @@ -10,6 +10,7 @@ DEF(ID_AA64AFR1_EL1, 3, 0, 0, 5, 5)
>  DEF(ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
>  DEF(ID_AA64ISAR1_EL1, 3, 0, 0, 6, 1)
>  DEF(ID_AA64ISAR2_EL1, 3, 0, 0, 6, 2)
> +DEF(ID_AA64ISAR3_EL1, 3, 0, 0, 6, 3)
>  DEF(ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
>  DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
>  DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

