Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22D8D2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 10:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi8ZF-000602-IJ; Tue, 20 Jan 2026 05:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vi8Z8-0005u7-CP
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 05:02:30 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vi8Z6-0002o1-Ma
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 05:02:26 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b874c00a39fso911578566b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 02:02:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768903342; cv=none;
 d=google.com; s=arc-20240605;
 b=eEriTP2Po2NrzO2tnETSMhDkr/Tp5cHcw5BWraDkmGo1pf0TWBv9n00TIrcBbxk9xA
 dCfCd2mMxGS2XsNQKB0OfbySKFT3kmtV0aBrPg4DZoJMCp72vqK+UaNNffdZ5ncykcKr
 m3LFaAY+6cMGwcqqFYZX5gAR5rrp9f+iQHioc1I1P7i4E4ARg8LnYgb73Fn8Gsc3h9Mm
 HsZSQtAg7OSy0q5GasqEP/FfipcknY7oe3ce1kb3uQW0xWpbf0G5iWewG8jpdIUcXcHc
 Lk5UwT9YlagSg65XvwWd/GbCVRMeCcxLmByIoOnICQV6P3qHs8mbFQjlxW9eCxezMuQH
 2Mxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kC2m92qdH3N0jeY0deGlE2vuZ6060lZkkXzeNGrfHkU=;
 fh=XIoO0Ux/SZ8W8McSemELDCpGv0yDhpljSyd3z1XJOS8=;
 b=Ngw79fT9+6/kL3Yocy9LjfCXqUHAvbfrjKHnROIsR4Ox48/tMQvpG99Bh8rnAISR6m
 sl3nDCTOd2ljT8Kkck51PwDE+zEikXjyGtfTyUlR8orHiKv701AGrcVIFXXYfOWVxleY
 M6gy2v4xKAWciBnwzfo8Y4acHLGarkMZ/jxBArfs6SzdM1vXlSqsQO42v9SkYKC8HA1D
 Ze4O4Tp5VvwK8SASWIqr/124+/RHD9zHc7zEOa0GnHNbRrBKDBg3yYhC0ju++vG6xvfj
 8w2+LzQWVRxjwQsrJpzMhCNMq5yeRLJeAtzKtLrzJS/6rh3iWIPstE1tck2kgURusOXn
 /FWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768903342; x=1769508142; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kC2m92qdH3N0jeY0deGlE2vuZ6060lZkkXzeNGrfHkU=;
 b=VkO3mlT4FK0wgERRtjBDJt986exJLrNETdebTOQuocKwo+8YQF7QEI0ag00W6IMGO9
 3Ju4DJ1HGyf343lVnf1houYbTfY88toGQbHwYOJnP9oaLzKC3/5xVNe/Rs9MY3U294pS
 jU9l3ET9s1wCYVk51xOYYCQSH9weGzKu19lI0nYVd0HrBUHqSYQEVDlZvs8wC6u0CusR
 ty1Nml0dfVG87/797OE8edn2z1JFd6kNA58TkKJ1tmMXzRxn0s+ifs9EQbMH4WECiPlL
 dX7CloJtf3+JJZPqMorb6Dq5wfX3ZRDOQApPLuXjCY13GqKyANpcqbS/f4iVwdh4F1gs
 mFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768903342; x=1769508142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kC2m92qdH3N0jeY0deGlE2vuZ6060lZkkXzeNGrfHkU=;
 b=AyfajkILbQq6SXa0KJDztcZEz6y2sdJiXGI+qMFWH3SUWLslZhad8LE3zSzpuzZY4d
 8x4EPdoIIjmbKWzBxqiKvuQ1EVJWmhorTmJvFtuaGhMbqfXT3APLVcMb4KLVU+5TXBEq
 Km48TzwpnJRq6K4jkzKdKUQNA4Hl2fziT5UqwV6TuFizVQ9aNZ81t1CpdWi6gko7Vn8L
 FKUMQJf/ujAIQOjcb0HG1HUA3TiYNcxikVZ7Qh/PZFiXtYaYgbZ3/Ws7f7pUK+46p010
 oGslzT/DGxLoyEQ681QA4iHTKwySoDLbwkI1EjbRmVQ2HlfdvubnsFvlt0zE1jlCwVjo
 9I5Q==
X-Gm-Message-State: AOJu0YwEd2LAXFdB/gMi8Se97OET9T4gHjKBWjworiK50cqHf8vUqSQe
 2XnxvN21QhrVish6pH78rjM37puRiKFAVj09/hZ301PGU8OcPu5foYFWcFfqjN8w2kveVJ6Dk2U
 AoYfR9UjIXuDlFiIe9eg/up/sxzfh5wy0qbn98e7nDg==
X-Gm-Gg: AY/fxX4WJx8wTiQlWjiKo0zkEEfwBvk+yv3Qux+JByuIzi9ryIVCJTKtyPFhmKZNBn0
 CB5JUnFac30LrwRhNg0LSJDsJaB1GDmysNLcJRdYYwLez5oiTVZ72gn8J/4vtbT1OHtPid12Kjv
 COjuM3VKZ4uq5aDsm6pJg2gzrczyg5PwrpbOm4tXklm5GO6S3EeZ05KbxJ5DghAiC3RzhdjWdkY
 5TmbFoYpYaLv/NwCjq/Yx5LkooI5FTC/dHLMel+DEzt3HYZjVkDlTy6E4/lS+liOlUF6QM4og3L
 zfTJnTd6KBpeUDh07dOp3Wb6JYb+qhILepLwcOi1aW2sOdA=
X-Received: by 2002:a17:907:940b:b0:b87:105f:312b with SMTP id
 a640c23a62f3a-b8777bd32fbmr1661645166b.16.1768903341980; Tue, 20 Jan 2026
 02:02:21 -0800 (PST)
MIME-Version: 1.0
References: <20260115-sme2-hvf-v2-0-2eca481bd7ee@linaro.org>
 <20260115-sme2-hvf-v2-2-2eca481bd7ee@linaro.org>
 <2c3bb870-0321-4799-b7ca-65b2772ddf2c@linaro.org>
In-Reply-To: <2c3bb870-0321-4799-b7ca-65b2772ddf2c@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 20 Jan 2026 12:01:56 +0200
X-Gm-Features: AZwV_QiM_2z7ofaLNWomoS-ap-hzEu2OdpbWvVJ2PLRXWwlU-jeZQuIyRBGUnOw
Message-ID: <CAAjaMXabRsOX0OVXN202ev3A1sKqMmbDoeY6n7Z-EhmZWmL9Cg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hvf/arm: expose FEAT_SME2 to guest if available
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x634.google.com
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

On Tue, Jan 20, 2026 at 11:50=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 15/1/26 12:20, Manos Pitsidianakis wrote:
> > Starting from M4 cores and MacOS 15.2 SDK, HVF can virtualise FEAT_SME2=
.
> >
> > Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> >   target/arm/cpu.c     |  4 +++-
> >   target/arm/cpu64.c   | 13 ++++++++++++-
> >   target/arm/hvf/hvf.c | 25 +++++++++++++------------
> >   3 files changed, 28 insertions(+), 14 deletions(-)
> >
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index caf7980b1fc5244c5c2f130e79ba869456c20c88..7f4ebfdf61217db60754951=
19c1b642bc2abf295 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -1577,7 +1577,9 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error=
 **errp)
> >            * assumes it, so if the user asked for sve=3Doff then turn o=
ff SME also.
> >            * (KVM doesn't currently support SME at all.)
> >            */
> > -        if (cpu_isar_feature(aa64_sme, cpu) && !cpu_isar_feature(aa64_=
sve, cpu)) {
> > +        if (!hvf_enabled()
>
> In my experience "if(!accel)" is bug prone, maybe change to explicit "if
> (tcg_enabled() || kvm_enabled()"?

Shouldn't we list all accelerators instead of just tcg/kvm then?

And why is if(!accel) bug prone?

>
> > +            && cpu_isar_feature(aa64_sme, cpu)
> > +            && !cpu_isar_feature(aa64_sve, cpu)) {
> >               object_property_set_bool(OBJECT(cpu), "sme", false, &erro=
r_abort);
> >           }
> >
> > diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> > index bf303813701972648fa6751ffe352ba074ca6442..8dd9eb46c783a799a53891a=
6ddad40b930e95eb4 100644
> > --- a/target/arm/cpu64.c
> > +++ b/target/arm/cpu64.c
> > @@ -329,9 +329,20 @@ void arm_cpu_sme_finalize(ARMCPU *cpu, Error **err=
p)
> >   {
> >       uint32_t vq_map =3D cpu->sme_vq.map;
> >       uint32_t vq_init =3D cpu->sme_vq.init;
> > -    uint32_t vq_supported =3D cpu->sme_vq.supported;
> > +    uint32_t vq_supported;
> >       uint32_t vq;
> >
> > +    if (hvf_enabled()) {
> > +        if (hvf_arm_sme2_supported()) {
> > +            vq_supported =3D hvf_arm_sme2_get_svl();
> > +        } else {
> > +            assert(!cpu_isar_feature(aa64_sme, cpu));
> > +            vq_supported =3D 0;
> > +        }
> > +    } else {
> > +        vq_supported =3D cpu->sme_vq.supported;
> > +    }
> > +
> >       if (vq_map =3D=3D 0) {
> >           if (!cpu_isar_feature(aa64_sme, cpu)) {
> >               SET_IDREG(&cpu->isar, ID_AA64SMFR0, 0);
> > diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> > index 6c5061742862635ae394f764188114f939259703..01bbb90b962156885021da7=
5a0d62ae3c39ff5b0 100644
> > --- a/target/arm/hvf/hvf.c
> > +++ b/target/arm/hvf/hvf.c
> > @@ -1043,18 +1043,18 @@ static bool hvf_arm_get_host_cpu_features(ARMHo=
stCPUFeatures *ahcf)
> >
> >       clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar);
> >
> > -    /*
> > -     * Disable SME, which is not properly handled by QEMU hvf yet.
> > -     * To allow this through we would need to:
> > -     * - make sure that the SME state is correctly handled in the
> > -     *   get_registers/put_registers functions
> > -     * - get the SME-specific CPU properties to work with accelerators
> > -     *   other than TCG
> > -     * - fix any assumptions we made that SME implies SVE (since
> > -     *   on the M4 there is SME but not SVE)
> > -     */
> > -    SET_IDREG(&host_isar, ID_AA64PFR1,
> > -              GET_IDREG(&host_isar, ID_AA64PFR1) & ~R_ID_AA64PFR1_SME_=
MASK);
> > +    if (hvf_arm_sme2_supported()) {
> > +        t =3D GET_IDREG(&host_isar, ID_AA64PFR1);
> > +        t =3D FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* FEAT_SME2 *=
/
> > +        SET_IDREG(&host_isar, ID_AA64PFR1, t);
> > +
> > +        t =3D GET_IDREG(&host_isar, ID_AA64SMFR0);
> > +        t =3D FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 1);   /* FEAT_SME2 *=
/
> > +        SET_IDREG(&host_isar, ID_AA64SMFR0, t);
> > +    } else {
> > +        SET_IDREG(&host_isar, ID_AA64PFR1,
> > +                GET_IDREG(&host_isar, ID_AA64PFR1) & ~R_ID_AA64PFR1_SM=
E_MASK);
> > +    }
> >
> >       ahcf->isar =3D host_isar;
> >
> > @@ -1252,6 +1252,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
> >                                 arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_I=
DX]);
> >       assert_hvf_ok(ret);
> >
> > +    aarch64_add_sme_properties(OBJECT(cpu));
>
> Out of scope, those aarch64_add_FEAT_properties() should really take a
> ARMCPU *cpu argument IMHO.

You're just looking for new things to fix :D

>
> >       return 0;
> >   }
> >
> >
>

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

