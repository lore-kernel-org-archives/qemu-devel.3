Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53259F01828
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 11:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyTgs-0002YH-N7; Fri, 06 Mar 2026 06:49:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vyTgq-0002Xy-Vq
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 06:49:56 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vyTgn-0002dc-T1
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 06:49:55 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48069a48629so95878645e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 03:49:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772797792; cv=none;
 d=google.com; s=arc-20240605;
 b=K17R6xz8KBgqMejd6Ib8CRj0Ty/W7tMlb7VGdq3CChWPMTSYXSv5Uf0XG8oJjtxorO
 yipqnYiTUFOLNQTF97IEpBhsmaahatwJiulkSxjV8QKW98tw80K/tcGk6FspZ4Sgug/M
 U5XOPir8cinxs0CVW006cuP+rHimNOQMr4XI27ePZ1/Y/Vax9RjDgBXrmV2FMbyPQN+b
 MGlf2fzOl368bB8pCV7iPfjPNiIcd50rC5/FMllrttrog28vKnQQCueuZ3L2+z6siRih
 kHHljVmqCkFe7u2NwpGW5n5ScJ+bLjvsvcO1+Yh32Oc7nbKMzso3XHE+btXAYPl/4UdF
 9Q/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aEMUP9o7W63JZbWz7rK7k03pO+jBShh6IwlYY5T8OnQ=;
 fh=RRkaJ+KZEEvn/g9FYI0bJyvrK9Vw6krujPTAkOoUb+4=;
 b=GMVYJ66p2l/MLra3yt8FQjdz8X6EV46SGLESTlgyBhO5LYr3nMR8kr5H8K/9GpuvbX
 X+/DLm5Cyke+hhPQRSy1R98s2oTXit0wsSy2RspTgw8KxvpF27hc33xrX1azUS6Dej0H
 wj6Icb1z2CrbgfXDG95Gkq1Zyh4VB6qqz4shEI3gb/BV8zieazqwlbanPHx9rTAXQy+F
 B5YnSn0KSi+7hlSdpvo5UWsmVhczSBfmVIciu5zocwnLK4P5eRTZOQgwyShQJpBxwQl9
 yyRbBjk/c6hUTYHQdO1fruXriiqhymhNYdFPsO4NaJcXVxdZh2K7cnMBwHiSsogJMgvT
 AQhA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772797792; x=1773402592; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aEMUP9o7W63JZbWz7rK7k03pO+jBShh6IwlYY5T8OnQ=;
 b=seEL0qSTUrI4S5naRDCPn6Gr4xCmGdqw+4tvt6uJxVJxnyFTHu9fmfWbacMuDAzkaP
 LH0kub+cEFWadaUmhVbaIc8Fuby+qzZkwhUU18NrZtj9S4istDDMoTNFGr7ZcG9++9wj
 6iUBGovBlrc2SAe2mQKqt3SzjmSrgGTr6mTreZso1amH+wVUntQDmLboUKfvrkNplNQh
 ONBW6FCIT0rwM2hR8UtcbWwTMuFa1Xzhaz0ROU/bwlMgXTcn2iT43HGvs2uL0CskJ5ml
 Mcxo4NeFcEkAGHHcn3f89kTZVRqaahVByn8coPAnAInr+xQx74c+vUM7Uf/feKNhSKew
 MuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772797792; x=1773402592;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aEMUP9o7W63JZbWz7rK7k03pO+jBShh6IwlYY5T8OnQ=;
 b=omZcK33VPZFOgHGhg8XwIuMn5n26ZwhxAC+c6MAkU/8mZmVx+XE9Hb0pH2g0bslVYs
 5dLVcUbRdIAM/8FdxHYnOE7vOn7tO5UZzHPNmmRPOzzamWQfvQQKR60JurW0DE09HoCs
 ldVZwJTPaFHAORlxSOduUSErGCyp57j8V6/VF44LjGyfqa5u3+n3xEiz4xcWjjLq7waU
 7WWxWmG1/cQGVedECLo0mCPdG844UqReu+W+bX75vW37a5kuq5GIb63mRTGGg6JF2MVG
 oUCz3dQ/JYuMbr6iV/pXAaZeF+rnOHEEBrKvy0lqBrUKw1t6VUXemXUwRI78drf2uyrd
 Ot2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBJSJcQmQYhucvGCaIn6bx+PJpaxuh2K4DAJf6sccjAp5+bvF681vk5Y3mVjX80em75Y2tuHBV74Ka@nongnu.org
X-Gm-Message-State: AOJu0Yyt5hdZmVAdGzhx41VcVtRMvAmAmUe7qWgMhKuxtC5KXBPj1yJt
 TbvQpFv0mLJOAwgAhkweb7jlwBJL42YpaRlVSSPZvIqdU6gf0BjBDK4Q+tteAOXFfBnDWLv/L4b
 ybSlI+oxIQPSRwfEcozdfMl8BvE/umfhsulN3agYJBs8WKFoeIpW2MygIfw==
X-Gm-Gg: ATEYQzz3/NJwAVPoXBIrgZfKbcnVnBVew2iYUa3OacHgQ5HE9bBnhoFHp5vFZN5xgc0
 7a0wS3/MVwuT3JtNy4DpJt9jhKyNVVwsURi84ZqqkEw548alisn40R64Y03XJSQgmiy9uvbp4xI
 g5S64Tb1e882TorFlbmiCMuaan14v0VXzg4p4Nvuwoym2FDCpukAUcNmFH/DzJaEbCaZFu35kAh
 XfzZNSDAvGpZMdjViad4r4dU9y18lEcA9VQnkinNsPMClKcn7WaiW9bHM19krPsmFxqFiNiRgko
 RLg22PcEnM1tGwR7a0eZQnWaCKPc1TrhJBrw7O3ruOfQLVevsg==
X-Received: by 2002:a05:600c:5303:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-4852695aa55mr28908905e9.22.1772797791980; Fri, 06 Mar 2026
 03:49:51 -0800 (PST)
MIME-Version: 1.0
References: <20260303-sme2-hvf-v6-0-b473702d8287@linaro.org>
 <20260303-sme2-hvf-v6-1-b473702d8287@linaro.org>
 <CAFEAcA8zTkc4pyHQKoDkTMhGPLQmxBaJS3bZiGRrPgux3rDLzw@mail.gmail.com>
 <CAAjaMXbXdrW9N1xLMPxL9OmjLqti6A3rqAmYipu6OkdBY8JPNQ@mail.gmail.com>
 <CAFEAcA_MuZH8d=Z=NfrNQ78k+Kv9mSx+=DLLt8AxZeEjccN8yw@mail.gmail.com>
 <CAAjaMXbq9A1NCO4jnF4aSL0XM2pzHsPsPyWfmqSCg_+2ZQpEHA@mail.gmail.com>
 <35FDE44D-63E2-426E-912C-6EB6CDA52116@unpredictable.fr>
 <CAFEAcA-Zgq43KW9EC-pteOqxHcZg==GE=1TAURZP-DGRh3OoHQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-Zgq43KW9EC-pteOqxHcZg==GE=1TAURZP-DGRh3OoHQ@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 6 Mar 2026 13:49:26 +0200
X-Gm-Features: AaiRm50yoEkke4iSBaCmNRxYQSDppG8hP_7kkEgEuftC2-TKNrR_0Q3toKUV4bE
Message-ID: <CAAjaMXa3h1abx=-ijZqf13ku-T=9+eV+XK9g85kGwxeRB-on1g@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] hvf/arm: handle FEAT_SME2 migration
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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

On Fri, Mar 6, 2026 at 1:14=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Fri, 6 Mar 2026 at 10:19, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
> > > On 6. Mar 2026, at 11:05, Manos Pitsidianakis <manos.pitsidianakis@li=
naro.org> wrote:
> > >
> > > On Fri, Mar 6, 2026 at 11:48=E2=80=AFAM Peter Maydell <peter.maydell@=
linaro.org> wrote:
> > >> While you're retesting, could you also look at / test patches
> > >> 17 and 18 in Mohamed's series
> > >> https://lore.kernel.org/qemu-devel/20260306083113.74177-18-mohamed@u=
npredictable.fr/T/#m2d1e3dfbfa5aecd41af6c0aa9e3b574a72c6f04d
> > >>
> > >> ?
> > >>
> > >> They look to me like bugfixes that we should be squashing/including
> > >> in the "enable SME2 for hvf" handling.
> > >
> > > Had a quick look, 17 seems to be nested-virt specific so not a bugfix
> > > if nested-virt was not already supported in the first place, right?
> >
> > Hello,
> >
> > This part isn=E2=80=99t:
> >
> > @@ -1370,16 +1373,22 @@ int hvf_arch_init_vcpu(CPUState *cpu)
> > arm_cpu->cpreg_indexes[sregs_cnt++] =3D kvm_id;
> > }
> > }
> > - if (__builtin_available(macOS 15.2, *)) {
> > - for (i =3D 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
> > - hv_sys_reg_t hvf_id =3D hvf_sreg_list_sme2[i].sreg;
> > - uint64_t kvm_id =3D HVF_TO_KVMID(hvf_id);
> > - uint32_t key =3D kvm_to_cpreg_id(kvm_id);
> > - const ARMCPRegInfo *ri =3D get_arm_cp_reginfo(arm_cpu->cp_regs, key);
> > -
> > - if (ri) {
> > - assert(!(ri->type & ARM_CP_NO_RAW));
> > - arm_cpu->cpreg_indexes[sregs_cnt++] =3D kvm_id;
> > + if (hvf_arm_sme2_supported()) {
> > + /*
> > + * Clang doesn't allow us to combine the two checks together.
> > + * -Wunsupported-availability-guard
> > + */
> > + if (__builtin_available(macOS 15.2, *)) {
> > + for (i =3D 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
> > + hv_sys_reg_t hvf_id =3D hvf_sreg_list_sme2[i].sreg;
> > + uint64_t kvm_id =3D HVF_TO_KVMID(hvf_id);
> > + uint32_t key =3D kvm_to_cpreg_id(kvm_id);
> > + const ARMCPRegInfo *ri =3D get_arm_cp_reginfo(arm_cpu->cp_regs, key);
> > +
> > + if (ri) {
> > + assert(!(ri->type & ARM_CP_NO_RAW));
> > + arm_cpu->cpreg_indexes[sregs_cnt++] =3D kvm_id;
> > + }
> > }
>
> Yes; the patch is doing two things and really ought to be two patches,
> so we can put the bit that we need for "make SME2 hvf work correctly"
> before the "enable SME2 HVF" patch, and the bit that is nested-virt
> specific in the nested-virt patches.
>

Patch v18 needs an adjustment, because clang prints warnings about the
`static const struct sme_isar_regs` array.


../target/arm/hvf/hvf.c:1098:11: warning:
'HV_FEATURE_REG_ID_AA64SMFR0_EL1' is only available on macOS 15.2 or
newer [-Wunguarded-availability-new]

Peter,

Maybe I should send a new revision since you haven't merged these
patches anyway?

> thanks
> -- PMM

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

