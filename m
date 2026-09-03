Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A27C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28i5-0002TY-Po; Thu, 03 Sep 2026 10:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x28i3-0002T7-0f
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:46:35 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x28hP-0004sS-BY
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:46:34 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49cdc81f40eso17871735e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788446753; x=1789051553; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=z4mcTa20Q6K/eSAXdcv86SfpDZEirfKuPAnuP96c43s=;
 b=c/AMuRyC9lQsm03yObIgK1NgVstB5KSI80+otqOtScfSpbqKYie3jEWqEyDozb1bvO
 lCk+Xi/qGs6UYAwopT+V9xC/Pgp660rwyCrVFjiK6R0uwDvnddi+fWSyeAfgIuMmfLb1
 jMr33pfAndLeESy+viFOmJgBPZA24Uvf5wxDFzRk4pKHWYsUZD+FfSX/VnliFc9PexFM
 /nMtNe7NARwf5P5Vog9sraJMeITWDSUqk2a6r375TJJOwcvww8gO9CXnFZPeVvVAajJA
 cbybtX0WmGKsRr5nuHAUsnKgncLAyolPRoAds9wnm4+X954Nmmd0jCDx1vKoMp7WGUqz
 mrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446753; x=1789051553;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z4mcTa20Q6K/eSAXdcv86SfpDZEirfKuPAnuP96c43s=;
 b=r8xs+bwV30mlKs2gpMizgYHO9VmxqlKMryccmd/JXCNsc7WMVZe88urwSC6EF62PrW
 /0zv1tXLmttKOfGr+XZYSEtAF1PXSjIzztO7WRt9U3C3rGSr4TTfdAqurnYP15jXiEqa
 Dpdz9HWtaOcKJYJ7WiAquwqRerwbPuG2YH4PLSwUqzn6fkyL4gAyPdmZ+h8Fv3egYFc6
 gJbreXkxuSLDOCF/AMvwYKUKfCuf4UDyUAeUHQs2sa72oa+EHIEkBOUgNqSE7kxuhDGZ
 gWF6XefZ0fKIGMISN3wxeG97b9IalsfGXtAh/lzmQ4pDv7uxMBXnjJnVFc5Tcui+2erv
 5klA==
X-Gm-Message-State: AFuF++k5x8LD1BbTfaBViszDnqaYS+p/vdSGeq4s/SDv7U31Da8v6DYI
 gYkzsOR9qzCnUbw4hmMSkM0IgFDGG/IlnTyG4NHRJuL0iD4cLHT+tyzr2zS/ApSoL04=
X-Gm-Gg: AYBFou13l3/Rgj6bGVVxDvXoIcGamb26Mwkf+2dGiJcuF35geakkj0JKTVZ0AkkzQDn
 pNyRAsJQHQ5c6frt0tgvSotEGOgUoieRpLC+dbfu0cJhRKrXHGOy/719giCvVE0GfmDYPtnZZOM
 j862OHI984bHZXoiUxFM2Mag/XJXG4RNK8xtImTF53ZeVzFzOGmSKhkaNjw7evZEkGY/R5KRXYa
 mFQ/OuwzChQJ5NXLFSRKiYTo7IYSL9Jwc1Ko+1JR/G+teyHDVnxX0tPWfN0nie0xhbJRVUph3vD
 bkMIE2YFFtZP5TRzv+dN3UqwTfUbKCL8n4G3w04Z+knh3JMtjKvygppsuVHurbl0a16my/StWFz
 vZN3TvoLl5SLpNA7jSBQm5hR3y2zDSdYIHtYDh8VNzc3+5CPxu+wl9N6ydyoYyRnK1SH/4ppGPc
 GFMO+mQtkxbnGhbGeSFACF9zsa+DM9yx6jXsUR55riYKEJKjMS92LddKzI0pQw
X-Received: by 2002:a05:600c:83c8:b0:49c:d52e:d0ea with SMTP id
 5b1f17b1804b1-49ce581779dmr243106045e9.4.1788446753379; 
 Thu, 03 Sep 2026 07:45:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5f914bsm92364115e9.3.2026.09.03.07.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:45:51 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B664D5F8FD;
 Thu, 03 Sep 2026 15:45:50 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH 01/33] target/arm: Add Phytium FTC310 and FTC664 CPU models
In-Reply-To: <20260903112532.3276678-2-bin.meng@processmission.com> (Bin
 Meng's message of "Thu, 3 Sep 2026 19:24:41 +0800")
References: <20260903112532.3276678-1-bin.meng@processmission.com>
 <20260903112532.3276678-2-bin.meng@processmission.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Thu, 03 Sep 2026 15:45:50 +0100
Message-ID: <87se3qpf4x.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Bin Meng <bin.meng@processmission.com> writes:

> The Phytium E2000Q combines two FTC310 cores and two FTC664 cores.
> Its EL3 firmware accesses implementation-defined system registers
> while setting up the cores. Using generic Cortex-A72 CPUs leaves
> these registers undefined and traps firmware before it can reach
> U-Boot.
>
> Add FTC310 and FTC664 CPU types using Cortex-A72 as their common
> execution base. Provide conservative RAZ/WI and NOP stubs for the
> firmware-visible E2000 controls that have no modeled behavior.
>
> Set each CPU DT compatible string, MIDR, instruction feature fields,
> AArch32 floating-point feature fields, and CTR_EL0.L1Ip field to
> values observed on an E2000Q board. The FTC310 reports a VIPT
> instruction cache, while the FTC664 reports a PIPT instruction cache.
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
>
>  target/arm/tcg/cpu64.c | 81
>  ++++++++++++++++++++++++++++++++++++++++++

I wonder if cpu64 is the best place to model this? The alternative is to
treat it like other SoCs (e.g. the Pi's BCM SoCs). Was the reason it
ended up here because you needed access to aarch64_a72_initfn? Could you
not instantiate:

    soc_base->cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a72");
=20=20=20=20
and then at realize:

    object_initialize_child(OBJECT(dev), "cpu[*]", &s->cpu[n].core,
                                soc_base->cpu_type);

or does that not allow for tweaking the CP regs?


>  1 file changed, 81 insertions(+)
>
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index affd87a3ae..0fd2f79bbc 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -336,6 +336,85 @@ static void aarch64_a72_initfn(Object *obj)
>      define_cortex_a72_a57_a53_cp_reginfo(cpu);
>  }
>=20=20
> +static const ARMCPRegInfo phytium_e2000_cp_reginfo[] =3D {
> +    /*
> +     * The E2000 EL3 firmware touches implementation-defined CPU registe=
rs
> +     * during the PBF/BL1 cache and core setup. QEMU does not model these
> +     * controls, so expose conservative RAZ/WI stubs for the boot firmwa=
re.
> +     *
> +     * PBF reads these identification and cluster controls after writing
> +     * them. Returning zero preserves the reset state without claiming t=
hat
> +     * QEMU implements the associated cache or coherency controls.
> +     */
> +    { .name =3D "E2000_CPUID_CTL1", .state =3D ARM_CP_STATE_AA64,
> +      .opc0 =3D 3, .opc1 =3D 1, .crn =3D 15, .crm =3D 1, .opc2 =3D 0,
> +      .access =3D PL1_RW, .type =3D ARM_CP_CONST | ARM_CP_NO_RAW,
> +      .resetvalue =3D 0 },
> +    { .name =3D "E2000_CLUSTER_CTL", .state =3D ARM_CP_STATE_AA64,
> +      .opc0 =3D 3, .opc1 =3D 1, .crn =3D 11, .crm =3D 8, .opc2 =3D 6,
> +      .access =3D PL1_RW, .type =3D ARM_CP_CONST | ARM_CP_NO_RAW,
> +      .resetvalue =3D 0 },
> +    /*
> +     * The remaining controls are only programmed as part of firmware se=
tup.
> +     * Accept the writes without retaining state because no modeled CPU
> +     * behavior depends on their values.
> +     */
> +    { .name =3D "E2000_EL1_CTL", .state =3D ARM_CP_STATE_AA64,
> +      .opc0 =3D 3, .opc1 =3D 2, .crn =3D 15, .crm =3D 15, .opc2 =3D 0,
> +      .access =3D PL1_RW, .type =3D ARM_CP_NOP | ARM_CP_NO_RAW },
> +    { .name =3D "E2000_EL2_CTL", .state =3D ARM_CP_STATE_AA64,
> +      .opc0 =3D 3, .opc1 =3D 4, .crn =3D 15, .crm =3D 15, .opc2 =3D 0,
> +      .access =3D PL2_RW, .type =3D ARM_CP_NOP | ARM_CP_NO_RAW },
> +    { .name =3D "E2000_EL2_CTL2", .state =3D ARM_CP_STATE_AA64,
> +      .opc0 =3D 3, .opc1 =3D 4, .crn =3D 15, .crm =3D 2, .opc2 =3D 4,
> +      .access =3D PL2_RW, .type =3D ARM_CP_NOP | ARM_CP_NO_RAW },
> +    { .name =3D "E2000_EL3_CTL", .state =3D ARM_CP_STATE_AA64,
> +      .opc0 =3D 3, .opc1 =3D 6, .crn =3D 15, .crm =3D 15, .opc2 =3D 0,
> +      .access =3D PL3_RW, .type =3D ARM_CP_NOP | ARM_CP_NO_RAW },
> +};
> +
> +/*
> + * Use the Cortex-A72 execution model as the common E2000 TCG base, then
> + * replace the architected identity fields that differ between the two
> + * physical core types.
> + */
> +static void aarch64_phytium_e2000_base_initfn(Object *obj)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(obj);
> +
> +    aarch64_a72_initfn(obj);
> +    define_arm_cp_regs(cpu, phytium_e2000_cp_reginfo);
> +}
> +
> +static void aarch64_phytium_ftc310_initfn(Object *obj)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(obj);
> +    ARMISARegisters *isar =3D &cpu->isar;
> +
> +    aarch64_phytium_e2000_base_initfn(obj);
> +
> +    /* FTC310 cores identify with the FTC303 part number */
> +    cpu->dtb_compatible =3D "phytium,ftc310";
> +    cpu->midr =3D 0x700f3034;
> +    SET_IDREG(isar, ID_AA64ISAR0, 0x00011100012120);
> +    cpu->isar.mvfr0 =3D 0x10110222;
> +    cpu->ctr =3D FIELD_DP64(cpu->ctr, CTR_EL0, L1IP, 2); /* VIPT */
> +}
> +
> +static void aarch64_phytium_ftc664_initfn(Object *obj)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(obj);
> +    ARMISARegisters *isar =3D &cpu->isar;
> +
> +    aarch64_phytium_e2000_base_initfn(obj);
> +
> +    cpu->dtb_compatible =3D "phytium,ftc664";
> +    cpu->midr =3D 0x701f6643;
> +    SET_IDREG(isar, ID_AA64ISAR0, 0x00000100012120);
> +    cpu->isar.mvfr0 =3D 0x10111222;
> +    cpu->ctr =3D FIELD_DP64(cpu->ctr, CTR_EL0, L1IP, 3); /* PIPT */
> +}
> +
>  static void aarch64_a76_initfn(Object *obj)
>  {
>      ARMCPU *cpu =3D ARM_CPU(obj);
> @@ -1533,6 +1612,8 @@ static const ARMCPUInfo aarch64_cpus[] =3D {
>      { .name =3D "cortex-a55",         .initfn =3D aarch64_a55_initfn },
>      { .name =3D "cortex-a72",         .initfn =3D aarch64_a72_initfn },
>      { .name =3D "cortex-a76",         .initfn =3D aarch64_a76_initfn },
> +    { .name =3D "phytium-ftc310",     .initfn =3D aarch64_phytium_ftc310=
_initfn },
> +    { .name =3D "phytium-ftc664",     .initfn =3D aarch64_phytium_ftc664=
_initfn },
>      /*
>       * The Cortex-A78AE differs slightly from the plain Cortex-A78. We d=
on't
>       * currently model the latter.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

