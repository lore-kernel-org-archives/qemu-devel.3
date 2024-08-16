Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED120C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 15:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sezE9-0004Pu-DW; Fri, 16 Aug 2024 11:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sezE4-0004M5-Sa
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:50:53 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sezE2-0004X3-U1
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:50:52 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5b7b6a30454so2687676a12.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 08:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723823449; x=1724428249; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rO2VVv+jqWNvTEkWJWzvHa+RzRFCb0oR03+xq6f+JrI=;
 b=q+012dSgS89fRkpQ9UWILcxZcR0rsVjJnhL/7sUv/xOaclgbeRcRuPr4m8RbkNYsFi
 JVpmBEgIh+QN+V0EpbCzGXlp1J2713iQ0yJ2HakBiU/9fkr27A6qq33ErDZnWNJ2XEl1
 +8p9r78Cyu7BN9OmERVhzZ4E7++jZdaQ0MGMkDV9txyKT7HaiTddq+Kz9DCmfMx73aP6
 2ahNSyAajHs0r7nnjOXiUrNeRGSjexckULMsJGjPvn+DL2OM7umxlvMaIBaVkkKlaqTs
 SYYq10wbyb4oGwPOzFVgPjnIzAvdc4QwHbkXvjzVg4dlm7FM85MV3AHHvqlH3+7nBo3L
 T5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723823449; x=1724428249;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rO2VVv+jqWNvTEkWJWzvHa+RzRFCb0oR03+xq6f+JrI=;
 b=mUkdDMlPxctCjRNuaqySa84H4UOp3Q2qJG9+I4GOToG2e2VSJ0Qpsj/ZQTWUktWe23
 VYosbY38xcEEYYRWuFgby2i8eGMby74g/p/bQ1X89fHQz1TLIgHg2GehDW4hSH8TZjej
 /MQeiS//dAS0dcRGMu3MXhjQvG4I4H+c2HvKAozowW5MJ7CWaXaQrlwCZfvnqXGErbc3
 puwj3ej7W+kMVro9VeM1pUCusuOmSIQLMAsZMfU6z3f1aCgCHXpxAkdMNZyuAteNy2Bp
 JwxY55lXGiib5rdj1WibuCjk0KUzbTYiJSCvT1usr3BoT7+sMLgG1p/Vj/J5h93xHXea
 uQtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtajaBsvU0fH6BSGD82nnoeBs04wz5N4R45sdaK7JHX1eCvsaKVlnqG0uCO98QOB0Ia/y7voQ4iTsKrB/vk1GbVFVLXCA=
X-Gm-Message-State: AOJu0YyTnHAaCZZBSU7a7CDGhljhLBegqtk4CZzUhq/OKN2N8orJNL0+
 TJPiDdUqguIuxRibwB6LP2HvgYU8BZ7MniRWR5T9VIKB22e9P+yo1zjVspUQ7S5dkDSj7OWu65U
 XlD+L8K16qtRKELC2wNoLu84T7xTjYCCeJi435w==
X-Google-Smtp-Source: AGHT+IHIPeGhhc/g4WyYTayKU5+A3kVN8m/nYqxm2rrx+9FNvYIgajZruMHjcMqg+zqzrSYGZ76blvB442XFuKJRX5A=
X-Received: by 2002:a05:6402:524d:b0:58c:eee0:48f4 with SMTP id
 4fb4d7f45d1cf-5beca78d2d0mr2138274a12.31.1723823448850; Fri, 16 Aug 2024
 08:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-25-salil.mehta@huawei.com>
 <87v800wkb1.fsf@draig.linaro.org>
In-Reply-To: <87v800wkb1.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Aug 2024 16:50:37 +0100
Message-ID: <CAFEAcA9A9Oq0nURkiLNWZNC=P7KQGyr8TjjfOmEq+squwF+xog@mail.gmail.com>
Subject: Re: [PATCH RFC V3 24/29] target/arm: Add support of *unrealize*
 ARMCPU during vCPU Hot-unplug
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 mst@redhat.com, maz@kernel.org, jean-philippe@linaro.org, 
 jonathan.cameron@huawei.com, lpieralisi@kernel.org, 
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev, 
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org, 
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com, 
 gshan@redhat.com, rafael@kernel.org, borntraeger@linux.ibm.com, 
 npiggin@gmail.com, harshpb@linux.ibm.com, linux@armlinux.org.uk, 
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com, 
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com, 
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com, 
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com, 
 maobibo@loongson.cn, lixianglai@loongson.cn, shahuang@redhat.com, 
 zhao1.liu@intel.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 16 Aug 2024 at 16:37, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Salil Mehta <salil.mehta@huawei.com> writes:
>
> > vCPU Hot-unplug will result in QOM CPU object unrealization which will =
do away
> > with all the vCPU thread creations, allocations, registrations that hap=
pened
> > as part of the realization process. This change introduces the ARM CPU =
unrealize
> > function taking care of exactly that.
> >
> > Note, initialized KVM vCPUs are not destroyed in host KVM but their Qem=
u context
> > is parked at the QEMU KVM layer.
> >
> > Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> > Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > Reported-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > [VP: Identified CPU stall issue & suggested probable fix]
> > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > ---
> >  target/arm/cpu.c       | 101 +++++++++++++++++++++++++++++++++++++++++
> >  target/arm/cpu.h       |  14 ++++++
> >  target/arm/gdbstub.c   |   6 +++
> >  target/arm/helper.c    |  25 ++++++++++
> >  target/arm/internals.h |   3 ++
> >  target/arm/kvm.c       |   5 ++
> >  6 files changed, 154 insertions(+)
> >
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index c92162fa97..a3dc669309 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -157,6 +157,16 @@ void arm_register_pre_el_change_hook(ARMCPU *cpu, =
ARMELChangeHookFn *hook,
> >      QLIST_INSERT_HEAD(&cpu->pre_el_change_hooks, entry, node);
> >  }
> >
> > +void arm_unregister_pre_el_change_hooks(ARMCPU *cpu)
> > +{
> > +    ARMELChangeHook *entry, *next;
> > +
> > +    QLIST_FOREACH_SAFE(entry, &cpu->pre_el_change_hooks, node, next) {
> > +        QLIST_REMOVE(entry, node);
> > +        g_free(entry);
> > +    }
> > +}
> > +
> >  void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
> >                                   void *opaque)
> >  {
> > @@ -168,6 +178,16 @@ void arm_register_el_change_hook(ARMCPU *cpu, ARME=
LChangeHookFn *hook,
> >      QLIST_INSERT_HEAD(&cpu->el_change_hooks, entry, node);
> >  }
> >
> > +void arm_unregister_el_change_hooks(ARMCPU *cpu)
> > +{
> > +    ARMELChangeHook *entry, *next;
> > +
> > +    QLIST_FOREACH_SAFE(entry, &cpu->el_change_hooks, node, next) {
> > +        QLIST_REMOVE(entry, node);
> > +        g_free(entry);
> > +    }
> > +}
> > +
> >  static void cp_reg_reset(gpointer key, gpointer value, gpointer opaque=
)
> >  {
> >      /* Reset a single ARMCPRegInfo register */
> > @@ -2552,6 +2572,85 @@ static void arm_cpu_realizefn(DeviceState *dev, =
Error **errp)
> >      acc->parent_realize(dev, errp);
> >  }
> >
> > +static void arm_cpu_unrealizefn(DeviceState *dev)
> > +{
> > +    ARMCPUClass *acc =3D ARM_CPU_GET_CLASS(dev);
> > +    ARMCPU *cpu =3D ARM_CPU(dev);
> > +    CPUARMState *env =3D &cpu->env;
> > +    CPUState *cs =3D CPU(dev);
> > +    bool has_secure;
> > +
> > +    has_secure =3D cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECU=
RITY);
> > +
> > +    /* rock 'n' un-roll, whatever happened in the arm_cpu_realizefn cl=
eanly */
> > +    cpu_address_space_destroy(cs, ARMASIdx_NS);
>
> On current master this will fail:
>
> ../../target/arm/cpu.c: In function =E2=80=98arm_cpu_unrealizefn=E2=80=99=
:
> ../../target/arm/cpu.c:2626:5: error: implicit declaration of function =
=E2=80=98cpu_address_space_destroy=E2=80=99 [-Werror=3Dimplicit-function-de=
claration]
>  2626 |     cpu_address_space_destroy(cs, ARMASIdx_NS);
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~
> ../../target/arm/cpu.c:2626:5: error: nested extern declaration of =E2=80=
=98cpu_address_space_destroy=E2=80=99 [-Werror=3Dnested-externs]
> cc1: all warnings being treated as errors

We shouldn't need to explicitly call cpu_address_space_destroy()
from a target-specific unrealize anyway: we can do it all
from the base class (and I think this would fix some
leaks in current code for targets that hot-unplug, though
I should check that). Otherwise you need to duplicate all
the logic for figuring out which address spaces we created
in realize, which is fragile and not necessary when all we
want to do is "delete every address space the CPU object has"
and we want to do that for every target architecture always.

-- PMM

