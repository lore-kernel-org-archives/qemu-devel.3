Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4919DCAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 14:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwiLJ-0003or-Tx; Thu, 11 Sep 2025 10:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uwiLH-0003o0-8Z
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 10:32:07 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uwiLF-0002Kf-3D
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 10:32:06 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-7227bc08c97so13016427b3.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 07:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757601123; x=1758205923; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3avX0MJx7z7ou5iJA8DuZIGcQo8FIUExV5H2IAivXQM=;
 b=yPDh6ShsGO4UdkVpGSvccunYtdauqdYYDUcbb5hvWwwbL4z6l9msN+GFk+5xfhCyMf
 u3niURFOcNSX6YoIO28xJTYBH/HQ95WXVio4hBsz0USJGN75LpA9TC347HTidM/I7tPC
 k2FAqW47KRz3PHmtxOPt3xTxiGq5WAx2M3x8tktMMXTAnbmMpX0I16hHxE6oLxTf6mqy
 VBIn0lAu++PL5ux5QVOS98ZYochWzXLP5gwrrhjST3rmo9ASUogU5Rj173aMdvEedNSc
 DXM0pvi9GQd49UZMi0AOoeEQd/JB/JV3PYOWymHl9ggl2RoYyv7zxZptJ0loV232fPfW
 PxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757601123; x=1758205923;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3avX0MJx7z7ou5iJA8DuZIGcQo8FIUExV5H2IAivXQM=;
 b=HNfQ6QLUzdTUvNNY+baoVY0siJdh00Lbkz4C8w2brmRClSYYRYc67zh+tN/MQLn1+L
 PRtMOxXnkUeD0gKk2yqm/CSkakGWn9KZHg8ek9c9R/eIKg7H57hIkTzbCvjxs8QHH4e7
 FC17VsevITmS+KT55L1LzfeVG03vRHpimlxAGH7au/tTr7BkjcPgcdXSU0KwAPKwPHo+
 JyYpLP9Z0Tr8YSzKxw8DnzkO/OKrbsWnCtc287Pb2dKhioyvI1XsCVpBY+aKz1Ea1cLC
 ICHe1T6vh/jXncTtFl1x8DnSbydED7KiksX73rsvjD40BUNCdTkNRMgsmWnCPoMr8DuA
 yL1A==
X-Gm-Message-State: AOJu0YytFN8EXv1NT24ozWlfiMb8HUkQb6mD+hQB3fWUKTnS066Ybxj5
 67ae+iAWOGY0DkoMO2HrpS01UVl5K3CGUtmPtGmRjEHPgcc21IeaBhK7SNX7AFsSHCKgQjej8lq
 fjJXQkcMeD4PIcNYdq+4NggBmNPf1QAg6jWQzs6rHCA==
X-Gm-Gg: ASbGncsgpANxpehpqkcQXwQGt2weNQKs1LPSIYO78yE0fHvFD0v1BX5AzuAykRdqqRh
 p7a4pszYVw/gZ7WH6v3tPQJBNnrNmxHeqyuIu7negnYzwPtcW94MGkoS8FbHUoAxAMwGJ7wO62n
 qMgF7e3WkwbDc7qzA/Uf4+/TzyUwHOR/NRVvWZA4UQP6O0GaJigpvEuIQFaKgpSK/4ccxqe3bgo
 yC8KNZn
X-Google-Smtp-Source: AGHT+IEQyUF2uAO/Dr3GK+/8Yh1FkCBEqxkbFKdhvIn9JJK1BNBdmp5GTS8xK/Ajst3mT6d6OfL+Zito7A1qMjyCNDs=
X-Received: by 2002:a05:690c:8d17:b0:71e:7a40:7efb with SMTP id
 00721157ae682-72eeb9d1c8cmr29254277b3.11.1757601123187; Thu, 11 Sep 2025
 07:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250822151614.187856-1-luc.michel@amd.com>
 <20250822151614.187856-40-luc.michel@amd.com>
In-Reply-To: <20250822151614.187856-40-luc.michel@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Sep 2025 15:31:51 +0100
X-Gm-Features: Ac12FXwU5pA47bV4PZ29Vo3Sh2Y6L9SKmyzInNKFfKlbGlg_Wess6EL5BefVsm8
Message-ID: <CAFEAcA-wnyWketgmq-gQYfgxMkDq16VDNZQCvM3uA1OE__=PAA@mail.gmail.com>
Subject: Re: [PATCH v4 39/47] target/arm/tcg/cpu64: add the cortex-a78ae CPU
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>, 
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Fri, 22 Aug 2025 at 16:17, Luc Michel <luc.michel@amd.com> wrote:
>
> Add support for the ARM Cortex-A78AE CPU.
>
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
>  target/arm/tcg/cpu64.c | 79 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 35cddbafa4c..b56677c1a5d 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -404,10 +404,84 @@ static void aarch64_a76_initfn(Object *obj)
>
>      /* From D5.1 AArch64 PMU register summary */
>      cpu->isar.reset_pmcr_el0 = 0x410b3000;
>  }
>
> +static void aarch64_a78ae_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    ARMISARegisters *isar = &cpu->isar;
> +
> +    cpu->dtb_compatible = "arm,cortex-a78ae";
> +    set_feature(&cpu->env, ARM_FEATURE_V8);
> +    set_feature(&cpu->env, ARM_FEATURE_NEON);
> +    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
> +    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);

From cpu.h:

    /*
     * ARM_FEATURE_BACKCOMPAT_CNTFRQ makes the CPU default cntfrq be 62.5MHz
     * if the board doesn't set a value, instead of 1GHz. It is for backwards
     * compatibility and used only with CPU definitions that were already
     * in QEMU before we changed the default. It should not be set on any
     * CPU types added in future.
     */

This is a new CPU type, so don't set this.

> +    set_feature(&cpu->env, ARM_FEATURE_AARCH64);
> +    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);

The TRM says this CPU doesn't have a CBAR register, so
don't set this.

> +    set_feature(&cpu->env, ARM_FEATURE_EL2);
> +    set_feature(&cpu->env, ARM_FEATURE_EL3);
> +    set_feature(&cpu->env, ARM_FEATURE_PMU);
> +
> +    /* Ordered by B2.4 AArch64 registers by functional group */

There is no B2.4 in the Cortex-A78AE TRM. Please don't
just cut-and-paste things from other CPU definitions.
Similarly for other comments here referencing TRM sections.

In this case what you want is section 3.2.4.

> +    SET_IDREG(isar, CLIDR, 0x82000023);
> +    cpu->ctr = 0x9444c004;
> +    cpu->dcz_blocksize = 4;
> +    SET_IDREG(isar, ID_AA64DFR0, 0x0000000110305408ull);
> +    SET_IDREG(isar, ID_AA64ISAR0, 0x0010100010211120ull);
> +    SET_IDREG(isar, ID_AA64ISAR1, 0x0000000001200031ull);
> +    SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000101125ull);
> +    SET_IDREG(isar, ID_AA64MMFR1, 0x0000000010212122ull);
> +    SET_IDREG(isar, ID_AA64MMFR2, 0x0000000100001011ull);
> +    SET_IDREG(isar, ID_AA64PFR0, 0x1100000010111112ull); /* GIC filled in later */
> +    SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000010ull);
> +    SET_IDREG(isar, ID_AFR0, 0x00000000);
> +    SET_IDREG(isar, ID_DFR0, 0x04010088);
> +    SET_IDREG(isar, ID_ISAR0, 0x02101110);
> +    SET_IDREG(isar, ID_ISAR1, 0x13112111);
> +    SET_IDREG(isar, ID_ISAR2, 0x21232042);
> +    SET_IDREG(isar, ID_ISAR3, 0x01112131);
> +    SET_IDREG(isar, ID_ISAR4, 0x00010142);
> +    SET_IDREG(isar, ID_ISAR5, 0x01011121);
> +    SET_IDREG(isar, ID_ISAR6, 0x00000010);
> +    SET_IDREG(isar, ID_MMFR0, 0x10201105);
> +    SET_IDREG(isar, ID_MMFR1, 0x40000000);
> +    SET_IDREG(isar, ID_MMFR2, 0x01260000);
> +    SET_IDREG(isar, ID_MMFR3, 0x02122211);
> +    SET_IDREG(isar, ID_MMFR4, 0x00021110);
> +    SET_IDREG(isar, ID_PFR0, 0x10010131);
> +    SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
> +    SET_IDREG(isar, ID_PFR2, 0x00000011);
> +    cpu->midr = 0x410fd421;          /* r0p1 */

r0p3 is the latest...

> +    cpu->revidr = 0;
> +
> +    /* From B2.18 CCSIDR_EL1 */
> +    /* 64KB L1 dcache */
> +    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
> +    /* 64KB L1 icache */
> +    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2);
> +    /* 512KB L2 cache */
> +    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 512 * KiB, 7);
> +
> +    /* From B2.93 SCTLR_EL3 */
> +    cpu->reset_sctlr = 0x30c50838;
> +
> +    /* From B4.23 ICH_VTR_EL2 */
> +    cpu->gic_num_lrs = 4;
> +    cpu->gic_vpribits = 5;
> +    cpu->gic_vprebits = 5;
> +    cpu->gic_pribits = 5;
> +
> +    /* From B5.1 AdvSIMD AArch64 register summary */
> +    cpu->isar.mvfr0 = 0x10110222;
> +    cpu->isar.mvfr1 = 0x13211111;
> +    cpu->isar.mvfr2 = 0x00000043;
> +
> +    /* From D5.1 AArch64 PMU register summary */
> +    cpu->isar.reset_pmcr_el0 = 0x41223000;
> +}

The register values look OK; checked against the TRM.

thanks
-- PMM

