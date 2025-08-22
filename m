Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B359CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 07:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upMdI-0007xT-GY; Fri, 22 Aug 2025 03:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1upMdF-0007w9-Sx
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 03:56:17 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1upMd8-0001zF-1B
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 03:56:17 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6188b7532f3so3202558a12.2
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 00:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755849363; x=1756454163; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Szwa3+x61AjR+V+P9JR802YOlHoy4d5KMmU1As6SE3w=;
 b=KTqgQen1ZVmjHbmz5lxwoilOPJpr1SnqPQLiO9kCx6rWDr2OFJz6rSrfXJPHge4Bl5
 zTI/+Y/plV+jZus+apKcdj3nXYn9DJOYJchHKqgk0ddBR0THAQxxouqY+hEYA52Q7W1G
 7H0zQAqeWRiCiOiqL6B17x0LMRo+wbzZMYYcadeQ97Idp4sMYNvHMHemIMGoh6aRt6ZI
 IGFz50qL56K7voBFyeXAnqqE4YCT/KocQMqmzoTmW3zqEBusM9VXbc2Hh+6zJJBZVtkZ
 qm6tcW2ZRfGBl06Qa+iEvD4RyWsDdLvJ+tC1gGc4BqwJRgepWCEoDnIfNOQiVzxlVPpX
 3MMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755849363; x=1756454163;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Szwa3+x61AjR+V+P9JR802YOlHoy4d5KMmU1As6SE3w=;
 b=Vl97Z38ofj5ZSbiDFbCZZ4Hn1mq8yUarskiYZAkC3CqaTQOnDXRc8QbVEGzmozOBYf
 5BK0ye0MlTiVLodTnpw18LAqjvs8D6oknHhU8aaubRhMdamW60/QjxT/HGp+YYFriBa+
 izSNLGijV1Y06TiAahi8R/FFg5kLy5QM2ckZ2QWHJaH2iYZR90u4+7vjKgXsf4fdjhyR
 MRXmN1fea6y8wjPWvReW6XXOJzUFPxK6zo286iYJxZIB3c4e6owU/tek8QXcrNextY4q
 C1EstLxOoe43Y2/eVor0EoSVltnbC24T1tgcFuq3AauPNgY9unp8ASM46XfmhMRrp8of
 F0Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh3fxw/F+T/aS6sBspaEibfXe2MunejPpk4W+8siXQrIO0ZG0or4Dkm6ildwaiVeUiQxOaU9EPasxk@nongnu.org
X-Gm-Message-State: AOJu0Yx0oVeyF47lazinA9V7HBVlYtFXQONPc2KVWKDDI52r4zOe8c2l
 RQHGbEpTQo7oiWPI/CQEaXGulQFnAywGzXK3QxaRIifnCADr7sV7mELKjtExpzSqf9KNdhuduEc
 w7ihvwZsbnA6AurTIPt7pj1MQmK5gQ9kvQF+6S6Dz2g==
X-Gm-Gg: ASbGnctAvkFef99paSXiU+SidU08U47ow61gimrvnFuI8aj+GQ34/v2NY09VGzqrl+y
 VVT8jDeJQhaXUYDDcsPVkfJhdDCwBOcxTij6AWSPRZFobzuNFscOkSDWeF4GW87oCDO/Lmmw3Nz
 L6BS+A1pRWxNJo3d9yG5wrSHgweafg1u+eDRHQ9fA6Qi/H/6+51dp9Cgbhvd4tTLzQiHrr9Xu9u
 ERMk3ar
X-Google-Smtp-Source: AGHT+IEGlXFB2VgzPVaxsYH+hNmAsUWM3LXReJXTH5m9LDwmYrw8I7I2udE/H9dX4DKeue/OTYF5bEV9W0xsKj9MdHU=
X-Received: by 2002:a05:6402:42ce:b0:618:35c5:64d9 with SMTP id
 4fb4d7f45d1cf-61c1b3b910amr1639914a12.1.1755849363521; Fri, 22 Aug 2025
 00:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250617163351.2640572-1-alex.bennee@linaro.org>
 <20250617163351.2640572-11-alex.bennee@linaro.org>
 <19837997-57c3-47b7-ab25-f8bad6bd3d4f@linaro.org>
In-Reply-To: <19837997-57c3-47b7-ab25-f8bad6bd3d4f@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 22 Aug 2025 10:55:37 +0300
X-Gm-Features: Ac12FXzysBykHD9AJKQFv_CgJk4g-Amfu2g5g4l_2aU9o7bjhIilWFp9_-DY6aE
Message-ID: <CAAjaMXbnNeMwt2qQNX+kMA=7=tCrcUjV2=18zpwERKP=bCZJ-g@mail.gmail.com>
Subject: Re: [RFC PATCH 10/11] kvm/arm: implement a basic hypercall handler
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org, 
 Mark Burton <mburton@qti.qualcomm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Alexander Graf <graf@amazon.com>, kvm@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52f.google.com
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

On Fri, Aug 22, 2025 at 10:13=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 17/6/25 18:33, Alex Benn=C3=A9e wrote:
> > For now just deal with the basic version probe we see during startup.
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > ---
> >   target/arm/kvm.c        | 44 ++++++++++++++++++++++++++++++++++++++++=
+
> >   target/arm/trace-events |  1 +
> >   2 files changed, 45 insertions(+)
> >
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index 0a852af126..1280e2c1e8 100644
> > --- a/target/arm/kvm.c
> > +++ b/target/arm/kvm.c
> > @@ -1507,6 +1507,43 @@ static int kvm_arm_handle_sysreg_trap(ARMCPU *cp=
u,
> >       return -1;
> >   }
> >
> > +/*
> > + * The guest is making a hypercall or firmware call. We can handle a
> > + * limited number of them (e.g. PSCI) but we can't emulate a true
> > + * firmware. This is an abbreviated version of
> > + * kvm_smccc_call_handler() in the kernel and the TCG only arm_handle_=
psci_call().
> > + *
> > + * In the SplitAccel case we would be transitioning to execute EL2+
> > + * under TCG.
> > + */
> > +static int kvm_arm_handle_hypercall(ARMCPU *cpu,
> > +                                    int esr_ec)
> > +{
> > +    CPUARMState *env =3D &cpu->env;
> > +    int32_t ret =3D 0;
> > +
> > +    trace_kvm_hypercall(esr_ec, env->xregs[0]);
> > +
> > +    switch (env->xregs[0]) {
> > +    case QEMU_PSCI_0_2_FN_PSCI_VERSION:
> > +        ret =3D QEMU_PSCI_VERSION_1_1;
> > +        break;
> > +    case QEMU_PSCI_0_2_FN_MIGRATE_INFO_TYPE:
> > +        ret =3D QEMU_PSCI_0_2_RET_TOS_MIGRATION_NOT_REQUIRED; /* No tr=
usted OS */
> > +        break;
> > +    case QEMU_PSCI_1_0_FN_PSCI_FEATURES:
> > +        ret =3D QEMU_PSCI_RET_NOT_SUPPORTED;
> > +        break;
> > +    default:
> > +        qemu_log_mask(LOG_UNIMP, "%s: unhandled hypercall %"PRIx64"\n"=
,
> > +                      __func__, env->xregs[0]);
> > +        return -1;
> > +    }
> > +
> > +    env->xregs[0] =3D ret;
> > +    return 0;
> > +}
> > +
> >   /**
> >    * kvm_arm_handle_hard_trap:
> >    * @cpu: ARMCPU
> > @@ -1538,6 +1575,13 @@ static int kvm_arm_handle_hard_trap(ARMCPU *cpu,
> >       switch (esr_ec) {
> >       case EC_SYSTEMREGISTERTRAP:
> >           return kvm_arm_handle_sysreg_trap(cpu, esr_iss, elr);
> > +    case EC_AA32_SVC:
> > +    case EC_AA32_HVC:
> > +    case EC_AA32_SMC:
> > +    case EC_AA64_SVC:
> > +    case EC_AA64_HVC:
> > +    case EC_AA64_SMC:
>
> Should we increment $pc for SVC/SMC?
> The instruction operation pseudocode [*] is:
>
>    preferred_exception_return =3D ThisInstrAddr(64);
>

Here's what the trusted firmware handler does.

The exception return address is modified by the :

https://github.com/ARM-software/arm-trusted-firmware/blob/da6b3a181c03a492e=
e52182b0466d0b7cc4091dd/bl31/aarch64/runtime_exceptions.S#L456-L480

    > * returns:
    > *   -1: unhandled trap, UNDEF injection into lower EL
    > *    0: handled trap, return to the trapping instruction (repeating i=
t)
    > *    1: handled trap, return to the next instruction

An SMC-aware trap handler should do the same


> [*]
> https://developer.arm.com/documentation/ddi0602/2022-06/Shared-Pseudocode=
/AArch64-Exceptions?lang=3Den
>
> > +        return kvm_arm_handle_hypercall(cpu, esr_ec);
> >       default:
> >           qemu_log_mask(LOG_UNIMP, "%s: unhandled EC: %x/%x/%x/%d\n",
> >                   __func__, esr_ec, esr_iss, esr_iss2, esr_il);
> > diff --git a/target/arm/trace-events b/target/arm/trace-events
> > index 69bb4d370d..10cdba92a3 100644
> > --- a/target/arm/trace-events
> > +++ b/target/arm/trace-events
> > @@ -15,3 +15,4 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update=
_irq: timer %d irqstate %d"
> >   kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova =3D 0x=
%"PRIx64" is translated into 0x%"PRIx64
> >   kvm_sysreg_read(const char *name, uint64_t val) "%s =3D> 0x%" PRIx64
> >   kvm_sysreg_write(const char *name, uint64_t val) "%s <=3D  0x%" PRIx6=
4
> > +kvm_hypercall(int ec, uint64_t arg0) "%d: %"PRIx64
>
>

