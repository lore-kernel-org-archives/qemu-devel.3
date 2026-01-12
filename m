Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C9CC9EC96
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 14:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfIgj-0006zH-EC; Mon, 12 Jan 2026 09:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfIgX-0006mz-Vp
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:14:23 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfIgW-0003T6-21
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:14:21 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-79018a412edso65499077b3.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 06:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768227257; x=1768832057; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dSUYf1te18meE+WVrMTYCEid2uXFez4uGwlc1vMR9tk=;
 b=b+jRA8zMr/UkvG75VvyBW0TOGunkaEWt3KU2ndQJuonx0nGovkcbSvq5Vms5hNZaKj
 3CyaTBvIdCHEY/H4KUt+WzOu/DZrcmO56jjvacPeF0UNzUjtRGgZ7vdFfWFr1f/z2WUV
 1wJUt/U+E4xBmSeODwCwSaKw21ZwUdZYGYXP3s4HsLL9QAoD7W87xAw2tgBeWv9pewKz
 afWNoU7bZvy1J/UHLszWSAG4zckmbEcCBo4sqY9S7iau3r/G2yfmTyxTUPhB4brKU6vO
 zZ0n9+iB75hEC1H2e+xfUSPTHTWgVcAFyxBq4J0hiqZpC6VZAXp7QQRsk4E0ZCpZpN+J
 zOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768227257; x=1768832057;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dSUYf1te18meE+WVrMTYCEid2uXFez4uGwlc1vMR9tk=;
 b=TW59c8L0tiMiTBl5WMHQ5NJblJ5zD4X796/ZSM2yvsptjUeu2DILHJJgk9JcivLYZQ
 8fMO12OT2g2kJW24ADfQMPUF9ldkLlBOla9ZDTXIFNVDUCGDXSiBPbImF4IEPWjKGAMq
 V879i90TQHSYBdBYxKJ81gGFC23kaDRM9KyPf0ikJ2aTmY6G53oIZZohbNGPX8wEYUKf
 IUliGJ92tFwmboRQNnEgKOhpTgLbah9xdBwyixJ3zaCMjyqaGOz/ZOEphfqmzGWmWC/a
 Ub6WfolkE7GfutVYuQB4buXqvIx+s5vwo4K7wsgTEuFqwLLrfp/EI8Hld01zDha3nvnq
 Yzvw==
X-Gm-Message-State: AOJu0YwdSoN1rdHOo6SdZodHBF8DLANVxGlZ0dzWksuF2ExBTS6Ip81/
 RRu1Ytb4d3yBP6zZh+jlig0WLe4zq0MjzA2HXEfGfRabCHNvsIB0IolBGB7WzNeO4HZD9EBRUJM
 /jCA8Q3FfGVn3uvGEvHOYPDn9Mc2Tm4vJA2ZP8wOPHQ==
X-Gm-Gg: AY/fxX4LeGanbqoTivErA/eQZFKbKb5Kx+uemXnUVlSKglF0MPmRwA4mypM0CoRiAFH
 LN9TPL4w6+4DSR+m5VDKFOV4gqOFfDAOhdUWwK9qWmoTCF71qykijsA/PYEqr2XRCY8XwUOfetV
 UOwjxrCZ+6a9nTXL8N+uR/jQLvJLeWSuVYeGUqDP0FKNyKVkMYqKLBxPg1ko2shMV6GSDlXVt4/
 sA9tDFCsfOPafvkaY/40W3j4CM9GigbuahKG9Yoyk9FrGvIlHl9eIc4QTM+eFjoesFe0FEasC8h
 O7Aqo9uMNv/YimQefVw+Mqo=
X-Google-Smtp-Source: AGHT+IEU0IOJmBiWSb6kztPyVoipnjuYbS7GPYOWfbAe9O8+r68IYnAhgra3O5879zAQCSj+TB2za9m2v/Zy3mdKFhU=
X-Received: by 2002:a05:690e:11cb:b0:63f:b444:da92 with SMTP id
 956f58d0204a3-64716b1f9e3mr15604023d50.31.1768227257494; Mon, 12 Jan 2026
 06:14:17 -0800 (PST)
MIME-Version: 1.0
References: <20251210-jmac-asid2-v6-0-d3b3acab98c7@linaro.org>
 <20251210-jmac-asid2-v6-1-d3b3acab98c7@linaro.org>
In-Reply-To: <20251210-jmac-asid2-v6-1-d3b3acab98c7@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jan 2026 14:14:05 +0000
X-Gm-Features: AZwV_Qi7ycSyKsF-53J25DICmIVwibV01QQKOXjFVYs-Lbe2S9nfBy-5hwiV1Ik
Message-ID: <CAFEAcA9Eseojv9gRRjp9euGAzxjtA+Mt=-1G2YnnB0DAmL9+zA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] target/arm: Enable ID_AA64MMFR4_EL1 register
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Wed, 10 Dec 2025 at 14:51, Jim MacArthur <jim.macarthur@linaro.org> wrot=
e:
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>  target/arm/cpu-sysregs.h.inc | 1 +
>  target/arm/helper.c          | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
> index 2bb2861c62..2ba49d8478 100644
> --- a/target/arm/cpu-sysregs.h.inc
> +++ b/target/arm/cpu-sysregs.h.inc
> @@ -14,6 +14,7 @@ DEF(ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
>  DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
>  DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
>  DEF(ID_AA64MMFR3_EL1, 3, 0, 0, 7, 3)
> +DEF(ID_AA64MMFR4_EL1, 3, 0, 0, 7, 4)
>  DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
>  DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
>  DEF(ID_DFR0_EL1, 3, 0, 0, 1, 2)
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 27ebc6f29b..c20334fa65 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6566,11 +6566,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                .access =3D PL1_R, .type =3D ARM_CP_CONST,
>                .accessfn =3D access_aa64_tid3,
>                .resetvalue =3D GET_IDREG(isar, ID_AA64MMFR3) },
> -            { .name =3D "ID_AA64MMFR4_EL1_RESERVED", .state =3D ARM_CP_S=
TATE_AA64,
> +            { .name =3D "ID_AA64MMFR4_EL1", .state =3D ARM_CP_STATE_AA64=
,
>                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 7, .opc2 =
=3D 4,
>                .access =3D PL1_R, .type =3D ARM_CP_CONST,
>                .accessfn =3D access_aa64_tid3,
> -              .resetvalue =3D 0 },
> +              .resetvalue =3D GET_IDREG(isar, ID_AA64MMFR4) },
>              { .name =3D "ID_AA64MMFR5_EL1_RESERVED", .state =3D ARM_CP_S=
TATE_AA64,
>                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 7, .opc2 =
=3D 5,
>                .access =3D PL1_R, .type =3D ARM_CP_CONST,

This needs a small extra bit:

--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6706,6 +6706,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .exported_bits =3D R_ID_AA64MMFR2_AT_MASK },
             { .name =3D "ID_AA64MMFR3_EL1",
               .exported_bits =3D 0 },
+            { .name =3D "ID_AA64MMFR4_EL1",
+              .exported_bits =3D 0 },
             { .name =3D "ID_AA64MMFR*_EL1_RESERVED",
               .is_glob =3D true },
             { .name =3D "ID_AA64DFR0_EL1",

This is where we tell the user-mode emulator what parts of the ID
register it should expose to the guest process. For ID_AA64MMFR4_EL1
that is nothing (i.e. read-as-zero) because no relevant fields
are listed here:
https://docs.kernel.org/arch/arm64/cpu-feature-registers.html

But we need an entry for it here, because changing the name from
"ID_AA64MMFR4_EL1_RESERVED" means it no longer matches the glob
pattern in the "ID_AA64MMFR*_EL1_RESERVED" catch-all entry
(which also says "make it read-as-zero").

This is a trivial fix so I'll just apply it when I take this
into target-arm.next rather than requiring you to do a respin.

thanks
-- PMM

