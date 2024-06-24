Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8400C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLji6-00028H-5W; Mon, 24 Jun 2024 09:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLji4-00025b-I5
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:26:16 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLji2-0008Eu-Lu
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:26:16 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ec5fad1984so15779971fa.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719235573; x=1719840373; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cWSm7bv/+2MGZBoF+7pc3YJzYXMFe7xYS+tDO5J7j54=;
 b=kS3fBJsseYOwYLaKV1rwgcuZlopDu/H6tNQAlNEY8FJoeFADfqANi1wb7K0Wxkz5FG
 b5yKt6UJVLFwQCaqwasqjqaluEEtRVgF14CZY56YVIK5uraCmdE4MPe2k3Tl70iHuHPg
 0m9N3FZ8NCuv01A1gvrZ7yGAbGxgo42iG4OHpegWC5XMhs5ijgkqzIlHomYDmOmf14oc
 8PLtCuvKSDdN6bCt7VW4Odsm6+P8/FvYJ3BC9b8NCPIkAG10Yj3cKJIl441T9te7ElD6
 HZ3VFcNIy8cVRK/ldfXDThk7XurWKwfASyMaEVWkF447gx0ThsfslmTyjr9c9IoqX760
 UfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719235573; x=1719840373;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cWSm7bv/+2MGZBoF+7pc3YJzYXMFe7xYS+tDO5J7j54=;
 b=TwOu2uBq45LC0XKarNX2Xsxeyf+uVfcJRYMygXBuMhCVhGQ6awtZgGp5t23vUQfXMd
 WGwWJIVKLYwPhN1lXD/lSpBbfxOo4nX9Dg0ydyh7E14MZqbarLtl6wkm15twTNoc2QVr
 AYElirXq7fp/yWsnPU1jrLxb374OEBk8DNA2NMysMUD97mckZNMV42eHLj5jxBwg81i5
 c1brjBltEA+vxZYR9ZWh125iPcBiirSqsliVvqA9bg2+ssPo97yV9sFjfpdpBD3lHFn3
 VQVBcJsaJTGi7pQ1s5QSUGmDC9uIFmlw7x4nneJzBupjtIi/alS/DYw4Z2PM+OJXpYaF
 Mgyw==
X-Gm-Message-State: AOJu0Yw/IX/rO+nXbsQErMGCVAV3CqhtGK3VJkrQpdj2pJEnCDjbEAn/
 rGWHgRKMJWm3S0QTs3Njh1mI3guHwHf1cNYa9oUbT11b512ORKWGvQEroIOjxaB29JgK2/nu64u
 Ys7kHxJMfmY6mMHqMhvk+UvjEpD79peKPPuxWnA==
X-Google-Smtp-Source: AGHT+IHRbl4vGURD/GS3yqZH/JQ4FveTZ2cdNxMvK7LnbDDUchOdja61sr9+T3t9R9ILYe0JtZGs8BR+UxXEinrhhCs=
X-Received: by 2002:a2e:9e0d:0:b0:2ec:4fe0:c77 with SMTP id
 38308e7fff4ca-2ec5b357996mr36350261fa.36.1719235572624; Mon, 24 Jun 2024
 06:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240621143903.3598230-1-gustavo.romero@linaro.org>
 <20240621143903.3598230-2-gustavo.romero@linaro.org>
In-Reply-To: <20240621143903.3598230-2-gustavo.romero@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jun 2024 14:26:00 +0100
Message-ID: <CAFEAcA-W6KdKonrzf2UqAVODZLiUJdTzUiNLUeiq+Qe-W-KHQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] target/arm: Move initialization of debug ID
 registers
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, 
 richard.henderson@linaro.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

On Fri, 21 Jun 2024 at 15:39, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>
> Move the initialization of the debug ID registers to aa32_max_features,
> which is used to set the 32-bit ID registers. This ensures that the
> debug ID registers are consistently set for the max CPU in a single
> place.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  target/arm/cpu.h       |  2 ++
>  target/arm/tcg/cpu32.c | 30 +++++++++++++++++++++++++++---
>  target/arm/tcg/cpu64.c |  2 +-
>  3 files changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 3841359d0f..d8eb986a04 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2299,6 +2299,8 @@ FIELD(DBGDEVID, DOUBLELOCK, 20, 4)
>  FIELD(DBGDEVID, AUXREGS, 24, 4)
>  FIELD(DBGDEVID, CIDMASK, 28, 4)
>
> +FIELD(DBGDEVID1, PCSROFFSET, 0, 4)
> +
>  FIELD(MVFR0, SIMDREG, 0, 4)
>  FIELD(MVFR0, FPSP, 4, 4)
>  FIELD(MVFR0, FPDP, 8, 4)
> diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
> index bdd82d912a..b155a0136f 100644
> --- a/target/arm/tcg/cpu32.c
> +++ b/target/arm/tcg/cpu32.c
> @@ -87,6 +87,33 @@ void aa32_max_features(ARMCPU *cpu)
>      t = FIELD_DP32(t, ID_DFR0, PERFMON, 6);       /* FEAT_PMUv3p5 */
>      cpu->isar.id_dfr0 = t;
>
> +    /* Debug ID registers. */
> +
> +    /* Bit[15] is RES1, Bit[13] and Bits[11:0] are RES0. */
> +    t = 0x00008000;
> +    t = FIELD_DP32(t, DBGDIDR, SE_IMP, 1);
> +    t = FIELD_DP32(t, DBGDIDR, NSUHD_IMP, 1);
> +    t = FIELD_DP32(t, DBGDIDR, VERSION, 6);       /* Armv8 debug */
> +    t = FIELD_DP32(t, DBGDIDR, CTX_CMPS, 1);
> +    t = FIELD_DP32(t, DBGDIDR, BRPS, 5);
> +    t = FIELD_DP32(t, DBGDIDR, WRPS, 3);
> +    cpu->isar.dbgdidr = t;
> +
> +    t = FIELD_DP32(t, DBGDEVID, PCSAMPLE, 3);

Looks like we should have an initial "t = something" ("t = 0")
before this line? Otherwise we start the DBGDEVID value
with the value of DBGDIDR.

> +    t = FIELD_DP32(t, DBGDEVID, WPADDRMASK, 1);
> +    t = FIELD_DP32(t, DBGDEVID, BPADDRMASK, 15);
> +    t = FIELD_DP32(t, DBGDEVID, VECTORCATCH, 0);
> +    t = FIELD_DP32(t, DBGDEVID, VIRTEXTNS, 1);
> +    t = FIELD_DP32(t, DBGDEVID, DOUBLELOCK, 1);
> +    t = FIELD_DP32(t, DBGDEVID, AUXREGS, 0);
> +    t = FIELD_DP32(t, DBGDEVID, CIDMASK, 0);
> +    cpu->isar.dbgdevid = t;
> +
> +    /* Bits[31:4] are RES0. */
> +    t = 0;
> +    t = FIELD_DP32(t, DBGDEVID1, PCSROFFSET, 2);
> +    cpu->isar.dbgdevid1 = t;
> +
>      t = cpu->isar.id_dfr1;
>      t = FIELD_DP32(t, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
>      cpu->isar.id_dfr1 = t;
> @@ -955,9 +982,6 @@ static void arm_max_initfn(Object *obj)
>      cpu->isar.id_isar4 = 0x00011142;
>      cpu->isar.id_isar5 = 0x00011121;
>      cpu->isar.id_isar6 = 0;
> -    cpu->isar.dbgdidr = 0x3516d000;
> -    cpu->isar.dbgdevid = 0x00110f13;
> -    cpu->isar.dbgdevid1 = 0x2;
>      cpu->isar.reset_pmcr_el0 = 0x41013000;
>      cpu->clidr = 0x0a200023;
>      cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 0899251eef..71e1bfcd4e 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -1167,7 +1167,7 @@ void aarch64_max_tcg_initfn(Object *obj)
>
>      t = cpu->isar.id_aa64isar2;
>      t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* FEAT_MOPS */
> -    t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);      /* FEAT_HBC */
> +    t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
>      t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
>      cpu->isar.id_aa64isar2 = t;

This indent fixup is unrelated so should really be its own patch.

thanks
-- PMM

