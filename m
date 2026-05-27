Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CAFCD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 13:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSECq-0000yU-RJ; Wed, 27 May 2026 09:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSECp-0000yD-LJ
 for qemu-devel@nongnu.org; Wed, 27 May 2026 09:21:55 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSECn-0000ZN-Nu
 for qemu-devel@nongnu.org; Wed, 27 May 2026 09:21:55 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4903f7a90d1so47352495e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 06:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779888112; x=1780492912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbzzr0gERYizfHYbiBkh1MGR81fYEEnusIvBrkkcOnc=;
 b=e0czkzPJ5M//q/9u5wBi3WfeXZ3QR4r87UCzaZ/ZH8LxUdrEloGMT4KHuvFPCC9mca
 6qEpJ4VQwIpv3N4G8TSwCzg9H9+ITq1p+6WPAZjgMxt5MbHhjmhlPOHzQSPmsQxUyOeh
 iBHPFrzbD5JssCn5P+DiF6mFARzmsn0azXVFPBChRC83otdP1WLDHknUvDvTI6ad9egE
 TkzWCvXj7PnlWn0WCXfv+ovPCZEHd8Macr690iXVcjvIXG3Fvw3wuaQuy/Y4siyYAM7W
 NWmggQZmvA9z9GJpktzmh2FTRGeUZaeIIc+fBhBf104y4u5M3486JRDLvokVsTovn9tE
 Sp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779888112; x=1780492912;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jbzzr0gERYizfHYbiBkh1MGR81fYEEnusIvBrkkcOnc=;
 b=fO0yL2i53ndAU33xNEIARZyHObEM7sZBcRjzJG7dfZfqBV+X1+7ho+BVeomvgOMdhl
 XI41YhBjgj7wTeCylm5GNyNeBiipl/Oq847ROnZlFblrAVjBtoMj8q/iGIdIKtr/HYGk
 YX0xQuXevwjkUlVkBcdJexvz2XI4J2jZmpiNu8hPm8vb5IRwkbSVploe2+0v+zxWkPWi
 gL5DZqE5rAHDVoZ8MGEwPqICODlZ0AIWo7i2HB7R9QqNjgWqXfRtDxWYIXu7USRGKhH6
 /0KpIWgkpTFwxglbU32Uev3E7FFxEroCIpjl4Z4AQl0p6Bi5pjNuL5gDeCg0j9GkU1Qr
 fw8A==
X-Gm-Message-State: AOJu0Yx85AU63b9dt1Q12FNocrFun2rPaWr9dAC+VtS5OIS6vX+F2YVM
 CPRjc/bT2EhGxPIxF/oNl/1cSKkd16Hp0hRWd7Yr0okI6t4F42kDt+TXbvHqzibWDzs=
X-Gm-Gg: Acq92OG6uL/cC7UKZAN60uZfgsRBoK4XQGq82njXjM8yVUB+htAoRxbgZ6d1YKHArF5
 bq2etpbAwYDKcYKnJIYELmt9/GBrgwVoTIAYzNh28p0VH1lfBtgOquTh1/gZuHNbymZTouvRi9n
 M3pOOgGwhuZRFiIpDjuP2dOuzOu59oD1glumr6DtTd1j7ss7NMPC71abVstayCSNkBwrRJNawAZ
 H0q8lJmeGfzk9znBeWTyhJcmFFaq9BAfUXKdmJkT25eSTf1ZwTD5AO0bYNUYiiyNfW9j7RyaObS
 vza4C1AD8hIq24WAAfMEao8mlOMqZ1u/NgvB41cN/o30VKoZGdlAjYgCCuuRPvpxYY63UinCx5G
 +X8TAlz3+0jLh65IIFikTMxhImRkX9KnGsq1qheb7xSVK502R4E7cet+EiLuK87VBsXusc4SuBB
 Qdpdl2krXul9Ssey+S4GerpkjyzACanbw1HA==
X-Received: by 2002:a05:600c:4fc1:b0:490:7227:100 with SMTP id
 5b1f17b1804b1-49072aa14b3mr138575805e9.18.1779888111413; 
 Wed, 27 May 2026 06:21:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b2bbfsm6461998f8f.32.2026.05.27.06.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 06:21:50 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 888E25F7F0;
 Wed, 27 May 2026 14:21:49 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Torbj=C3=B6rn?= SVENSSON <torbjorn.svensson@foss.st.com>
Cc: <qemu-devel@nongnu.org>,  Peter Maydell <peter.maydell@linaro.org>,
 <qemu-arm@nongnu.org>
Subject: Re: [PATCH 1/3] target/arm/tcg: define cortex-m85 cpu
In-Reply-To: <20260518-pr-pacbti-v1-1-8932a885b03d@foss.st.com>
 (=?utf-8?Q?=22Torbj=C3=B6rn?=
 SVENSSON"'s message of "Mon, 18 May 2026 18:13:59 +0200")
References: <20260518-pr-pacbti-v1-0-8932a885b03d@foss.st.com>
 <20260518-pr-pacbti-v1-1-8932a885b03d@foss.st.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Wed, 27 May 2026 14:21:49 +0100
Message-ID: <87h5ntxa1e.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Torbj=C3=B6rn SVENSSON <torbjorn.svensson@foss.st.com> writes:

Can you mention the TRM in the commit:

  https://developer.arm.com/documentation/101924/0100/

> Signed-off-by: Torbj=C3=B6rn SVENSSON <torbjorn.svensson@foss.st.com>
> ---
>  target/arm/tcg/cpu-v7m.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
> index dc249ce1f1..5cfda232cd 100644
> --- a/target/arm/tcg/cpu-v7m.c
> +++ b/target/arm/tcg/cpu-v7m.c
> @@ -237,6 +237,44 @@ static void cortex_m55_initfn(Object *obj)
>      cpu->ctr =3D 0x8303c003;
>  }
>=20=20
> +static void cortex_m85_initfn(Object *obj)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(obj);
> +    ARMISARegisters *isar =3D &cpu->isar;
> +
> +    set_feature(&cpu->env, ARM_FEATURE_V8);
> +    set_feature(&cpu->env, ARM_FEATURE_V8_1M);
> +    set_feature(&cpu->env, ARM_FEATURE_M);
> +    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
> +    set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
> +    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
> +    cpu->midr =3D 0x411fd230; /* r1p0 */
> +    cpu->revidr =3D 0;
> +    cpu->pmsav7_dregion =3D 16;
> +    cpu->sau_sregion =3D 8;
> +    /* These are the MVFR* values for the FPU + full MVE configuration */
> +    cpu->isar.mvfr0 =3D 0x10110221;
> +    cpu->isar.mvfr1 =3D 0x12100211;
> +    cpu->isar.mvfr2 =3D 0x00000040;
> +    SET_IDREG(isar, ID_PFR0, 0x20000030);
> +    SET_IDREG(isar, ID_PFR1, 0x00000230);
> +    SET_IDREG(isar, ID_DFR0, 0x10200000);
> +    SET_IDREG(isar, ID_AFR0, 0x00000000);
> +    SET_IDREG(isar, ID_MMFR0, 0x00111040);
> +    SET_IDREG(isar, ID_MMFR1, 0x00000000);
> +    SET_IDREG(isar, ID_MMFR2, 0x01000000);
> +    SET_IDREG(isar, ID_MMFR3, 0x00000011);
> +    SET_IDREG(isar, ID_ISAR0, 0x01103110);
> +    SET_IDREG(isar, ID_ISAR1, 0x02212000);
> +    SET_IDREG(isar, ID_ISAR2, 0x20232232);
> +    SET_IDREG(isar, ID_ISAR3, 0x01111131);
> +    SET_IDREG(isar, ID_ISAR4, 0x01310132);
> +    SET_IDREG(isar, ID_ISAR5, 0x00000000);

The TRM specifies this as 0x00100000 and you set this to in 3/3 to:

  SET_IDREG(isar, ID_ISAR5, 0x00200000); /* PACBTI=3Dimplementation defined=
 */

which isn't one of the available config options. We'd rather not present
a CPU that can't exist.

With that said for A-profile we do offer the control knob of
pauth-impdef (which is the default for -cpu max). We could add similar
logic to aarch64_cpu_pauth_finalize to cpu32 to allow the user to
actively tune their emulation speed.

> +    SET_IDREG(isar, ID_ISAR6, 0x00000000);
> +    SET_IDREG(isar, CLIDR, 0x00000000); /* caches not implemented */
> +    cpu->ctr =3D 0x8303c003;
> +}
> +
>  static const TCGCPUOps arm_v7m_tcg_ops =3D {
>      /* ARM processors have a weak memory model */
>      .guest_default_memory_order =3D 0,
> @@ -290,6 +328,8 @@ static const ARMCPUInfo arm_v7m_cpus[] =3D {
>                               .class_init =3D arm_v7m_class_init },
>      { .name =3D "cortex-m55",  .initfn =3D cortex_m55_initfn,
>                               .class_init =3D arm_v7m_class_init },
> +    { .name =3D "cortex-m85",  .initfn =3D cortex_m85_initfn,
> +                             .class_init =3D arm_v7m_class_init },
>  };
>=20=20
>  static void arm_v7m_cpu_register_types(void)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

