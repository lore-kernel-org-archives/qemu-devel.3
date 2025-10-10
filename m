Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A65CCD183
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 03:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v73NB-0007yO-5j; Thu, 09 Oct 2025 23:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v73N7-0007y5-KD
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 23:00:45 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v73Mt-0002HG-Hq
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 23:00:44 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-64e3e259f93so822826eaf.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 20:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1760065227; x=1760670027; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ip2B4Enn66V2uJQx4DLX+E6IX+haPOwbd+vtqDk2GOI=;
 b=iGlTBUZf3cdzKsbsIkLJ9fdlvpnn0WHB555fjEPmWqvWndD4ceRCMYWzmNB2lsGXZa
 Gj+6s0LOCJVud3Azr7PDCHtXA/6qX/HZU/iHkJ1na9HgzHP/BZIfzx73h2xtQQAxigPF
 Ivl3+b+h0CASxt6fijYvQ//Wlc8213m5bY1QGO+HqJUfkBGB24dK+QcEGT55fQalr9Vc
 qtd+XwcJAPsPcm23WxAsXvLMeN/gBK9d7hZiIoCXhSmYcLvgWd0nndHArwgJt6m/hkCb
 3DD4wGNGlUH1HrxoJFyZWgOCeskW8j0koLBTuNXzNRJUA+oGaBhq0GK4cawnuJkfQQCl
 qTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760065227; x=1760670027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ip2B4Enn66V2uJQx4DLX+E6IX+haPOwbd+vtqDk2GOI=;
 b=V7jxpxrpUhH69DYsuOtZ7Np3QvdVLsaxLZP7hOCAxndBlVfQSBoXicenAPHqynYJv8
 aJmsjGGw3SMWW41DxBDN672lNJNTZTXecOFcVW6f5zTz7C1k6P45+9AJsSzSt+omakPC
 Mcqp8ubmHo1G/hSXqR2IDrFj7ZqfKMT7HX1912YRPRHd05gfP4QfKf4MJnDUb5x5mk5Q
 jBtS3rpihWHp9CuJyCF9lPLCvXb9ednGVTjyj3tf95Hmn0QT453xkL9UP8LnQ77b9eRN
 AeNrs6DZY71Ry4qPp+EF93bPERSzTQVijrz4ZAOugUlWA+7ZM+gAMnTScoTtasV3TG9o
 bjVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwZHKc5ALmtNNL7EfICMaLaAPncl5O0SC1XxRD2XGI57IutJJGOJwiPx78MTAyoEdICLNbjPfgQp9V@nongnu.org
X-Gm-Message-State: AOJu0YzcUynDq7EuvBTQeLtnw/d3DgmKUsKUPJ0Kc8sQZvnBSo623C5/
 +RSqjt4zCzILeZKHQjrCx/RZneuDwStzLtO7NS+dkRc2gllUrz9LjMVlJZfgjpkKfHGRIJHpr8G
 2GctbSnrsJZ82bzHaBwf+f2Y2euVFIQ4NmQrVHKCiVw==
X-Gm-Gg: ASbGncvYLpJzGgzhk3C4sf94nQSyPGPIrmYMhezsbiZHbpO7sk+vIJEZm91Z4RUrUBk
 yS5+2B1FrO5BUjDL2Bfg+3birVeTuWW6snTT318IADhxcu1KvNR2i/W+ohyDEgKgsX44+U3n+0h
 dpbL7qbb6hP3g3ov7Lw0ymcszGe7icczMmJ5Bh9HRkHpzdRS/XTqF9NFBXXxqUKGvqYaJsaBecF
 uuWlx282BYlk6sUXdUKR5r+tEtg7T263mrqb2wMhjT4Wj9c5JBvGbCU/eRFSVprrDjZSo729X9H
 2peeoZznF5K5
X-Google-Smtp-Source: AGHT+IFnSoFLmcDx49t6kj2MNacrBvBkukqiaGKJbnPSdGEeBkq8Kg+8OUDlHvCApd4RV0RmipkatPS5bAajgO8xtB0=
X-Received: by 2002:a05:6871:80e:b0:346:9a15:6d69 with SMTP id
 586e51a60fabf-3c0f5c1e0a2mr5285114fac.6.1760065226987; Thu, 09 Oct 2025
 20:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-15-salil.mehta@opnsrc.net>
 <20251003165816.53821040@fedora>
 <7da6a9c470684754810414f0abd23a62@huawei.com> <20251007140613.5916df08@fedora>
In-Reply-To: <20251007140613.5916df08@fedora>
From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Fri, 10 Oct 2025 03:00:15 +0000
X-Gm-Features: AS18NWDZYnQ8BCEcJaVwvRwMUYRuou5CsXrssb5wCmIfzEE3R2K8I55PIwCJhZE
Message-ID: <CAJ7pxebaqZusZAF7y=881=3dA+YVNeYUZ8BCKb_tQPvn7BbNww@mail.gmail.com>
Subject: Re: [PATCH RFC V6 14/24] arm/acpi: Introduce dedicated CPU OSPM
 interface for ARM-like platforms
To: Igor Mammedov <imammedo@redhat.com>
Cc: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>,
 "maz@kernel.org" <maz@kernel.org>, 
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "armbru@redhat.com" <armbru@redhat.com>, 
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, 
 "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>, 
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, 
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, 
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, 
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>,
 "npiggin@gmail.com" <npiggin@gmail.com>, 
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, 
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>, 
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>, 
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>, 
 "gankulkarni@os.amperecomputing.com" <gankulkarni@os.amperecomputing.com>, 
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>, 
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>, 
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, 
 Linuxarm <linuxarm@huawei.com>, "jiakernel2@gmail.com" <jiakernel2@gmail.com>, 
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>, 
 "shahuang@redhat.com" <shahuang@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>
Content-Type: multipart/alternative; boundary="000000000000a2edba0640c51ea5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000a2edba0640c51ea5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Igor,

On Tue, Oct 7, 2025 at 12:06=E2=80=AFPM Igor Mammedov <imammedo@redhat.com>=
 wrote:

> On Tue, 7 Oct 2025 11:15:47 +0000
> Salil Mehta <salil.mehta@huawei.com> wrote:
>
> > Hi Igor,
> >
> > Thanks for the reviews and sorry for the late reply. Please find my
> replies inline.
> >
> >
> > > From: Igor Mammedov <imammedo@redhat.com>
> > > Sent: Friday, October 3, 2025 3:58 PM
> > >
> > > On Wed,  1 Oct 2025 01:01:17 +0000
> > > salil.mehta@opnsrc.net wrote:
> > >
> > > > From: Salil Mehta <salil.mehta@huawei.com>
> > > >
> > > > The existing ACPI CPU hotplug interface is built for x86 platforms
> > > > where CPUs can be inserted or removed and resources are allocated
> > > > dynamically. On ARM, CPUs are never hotpluggable: resources are
> > > > allocated at boot and QOM vCPU objects always exist. Instead, CPUs
> are
> > > > administratively managed by toggling ACPI _STA to enable or disable
> > > > them, which gives a hotplug-like effect but does not match the x86
> model.
> > > >
> > > > Reusing the x86 hotplug AML code would complicate maintenance since
> > > > much of its logic relies on toggling the _STA.Present bit to notify
> > > > OSPM about CPU insertion or removal. Such usage is not
> architecturally
> > > > valid on ARM, where CPUs cannot appear or disappear at runtime.
> Mixing
> > > > both models in one interface would increase complexity and make the
> > > > AML harder to extend. A separate path is therefore required. The ne=
w
> > > > design is heavily inspired by the CPU hotplug interface but avoids
> its
> > > unsuitable semantics.
> > >
> > > Let me ask how much existing CPUHP AML code will become, if you reuse
> it
> > > and add handling of 'enabled' bit there?
> > >
> > > Would it be the same 700LOC as in this patch, which is basically
> duplication of
> > > existing CPUHP ACPI interface?
> >
> >
> > It is by design as we have adopted non-hotplug approach now and closely
> aligned
> > ourselves with what PSCI standard perceives to be the definition of CPU
> hotplug on ARM
> > platforms - at least, as of today! And it is *NOT* what 'CPU hotplug'
> means on x86 platform.
>
> There is no argument that they are different but,
> Could you point to PSCI specific parts in this patch?
>

Yes, sure.

https://lore.kernel.org/qemu-devel/20251001010127.3092631-1-salil.mehta@opn=
src.net/T/#m926978ce8b91a1f2cca88b5b579a8aedd9e62d2c
https://lore.kernel.org/qemu-devel/20251001010127.3092631-1-salil.mehta@opn=
src.net/T/#mb96b36ebf68b0455b657ce495cac2aee9fbf0f67



>
> > In crux, this means,
> > 1. Dropping any hotplug/unplug infrastructure and its related
> paraphernalia from the
> >     ARM implementation till the time the meaning of physical CPU hotplu=
g
> is not clear as
> >     per the specification. We do not want to model in Qemu something
> which does not
> >     exist or defined, especially for the CPU hotplug case.
>
> there is 'opts' config struct that lets user to opt in/out from specific
> AML
> being generated. You could use that to disable some hotplug only bits of
> AML.
> Other bits that are more generic/reusable, just refactor/rename them to a
> more
> generic names.
>

Sure, but what you are suggesting is a code reuse strategy not a design
problem.
We can take this as a cleanup activity later on or even in parallel. I've
no reservations
about that. Why hold ARM patches hostage to these benign optimizations?

BTW, that 'opt' is one of the ugliest parts of this function. Why do other
architectures
have to worry about initializing legacy bits of x86 in the common code
before calling
AML function?


> > 2. This also means *NOT* enabling the  ACPI_CPU_HOTPLUG compilation
> switch to
> >      preserve the sanctity of the clean design.
>
> that's semantics, I'd suggest renaming that to ACPI_CPU.
>


It is not about this. To make it hotplug agnostic we would need to start
with new minimal
code and then add on top of it what is present in acpi/cpu.c incrementally.
This can be
done in parallel by

1. accepting the minimal new code. This will keep the ball rolling for ARM
2. adding the x86 stuff incrementally over that minimal new AML file (with
other name)
3. Testing a new file doesn't break x86 functionality
4. replacing the old file acpi/cpus.c with a new common file.


>
> > 3. Yes, there is a code duplicity for now but that=E2=80=99s a case of =
further
> optimization and
> >     cleanup not a design issue. Some of them are:
> >     (1)  ACPI device-check and eject-request  handling code can be
> extracted and
> >     made generic for all devices not just for CPUs.
>
> make it more generic in acpi/cpu.c, instead of copying.
> I don't have any objections to refactoring existing code if it makes sens=
e
> and
> we can share the code.
>

In principle I agree with your point about carving a common code that works
for all.
I'm only requesting how this could be done in a non-disrupting way by not
holding
the current patches of ARM for this change. This change will require time
and most
importantly testing across many architectures.


>
> >     (2)  Right now, acpi/cpu.c is assuming that resources and templates
> should be
> >      same for all the CPUs using CPUs AML described in it. There is no
> need for
> >      such a restriction. Every platform should be free to choose the wa=
y
> it wants to
> >      manage the resources and the interpretation of the fields inside i=
t.
>
> be more specific why you'd need different resources/MMIO layout for this
> series?
>

IIRC in RFC V5, you object to adding 'enabled' bit as it was breaking x86
ABI
because of some backward compatibility issue?


>
> The thing is if we copied every time when we needed something that's a bi=
t
> different,
> we would end up with unsupportable/bloated QEMU.
>

For sure. I totally agree with it but it was an informed decision here
internally to keep
the ACPI part separate for this series because of the past review comments
and the
difficulty in dealing with very minimalistic changes we proposed for ACPI
part.


>
> >     (3) Call backs used with GED  makes an assumption of HOTPLUG
> interface etc.
> >     (4) In fact, the prototype of the GED event handler makes a similar
> mistake of
> >      assuming that GED is only meant for devices supporting hotplug whe=
n
> this is not
> >      the case even as per the ACPI specification.
> please be more specific and point to problematic code.
>

void build_ged_aml(Aml *table, const char *name, HotplugHandler
*hotplug_dev,
                   uint32_t ged_irq, AmlRegionSpace rs, hwaddr ged_base)


GED is not just for hotplug handling.


>
> current acpi/cpu.c might be compiled under ACPI_CPU_HOTPLUG knob but it's
> not really
> limited to hotplug, the reason for being compiled as such is that hotplug
> was
> the sole reason for building CPUs AML at all.
>

Got it. so as you rightly suggested it needs refactoring. The only request
I'm making is
let us do it parallely and incrementally without holding ARM patches for
this change.


>
> What I see in the patch is simplifying current code somewhat by dropping
> some hotplug related bits and a bunch of renaming.
> Otherwise it's pretty much duplicating current acpi/cpu.c.
>
> Beside that simplification, I don't see any reason why duplicating such
> amount is good idea.
> Consider making exiting acpi/cpu.c more generic instead.
>

Intial idea was to make it generic enough for any device which uses
device-check
and eject-request  for adding/removing the device but we left it for later
discussions.


> > RFC V5 was an attempt to implement this feature using the hotplug
> infrastructure
> > and this RFC V6 is a deviation from previous approach towards
> non-hotplug. We do
> > not want a hotchpotch approach because that=E2=80=99s a recipe for futu=
re
> disaster.
> >
> >
> > Many Thanks!
> > Salil.
> >
> >
> > >
> > > >
> > > > This patch adds a dedicated CPU OSPM (Operating System Power
> > > > Management) interface. It provides a memory-mapped control region
> with
> > > > selector, flags, command, and data fields, and AML methods for
> > > > device-check, eject request, and _OST reporting. OSPM is notified
> > > > through GED events and can coordinate CPU events directly with QEMU=
.
> > > > Other ARM-like architectures may also use this interface.
> > > >
> > > > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > > > ---
> > > >  hw/acpi/Kconfig                        |   3 +
> > > >  hw/acpi/acpi-cpu-ospm-interface-stub.c |  41 ++
> > > >  hw/acpi/cpu_ospm_interface.c           | 747
> > > +++++++++++++++++++++++++
> > > >  hw/acpi/meson.build                    |   2 +
> > > >  hw/acpi/trace-events                   |  17 +
> > > >  hw/arm/Kconfig                         |   1 +
> > > >  include/hw/acpi/cpu_ospm_interface.h   |  78 +++
> > > >  7 files changed, 889 insertions(+)
> > > >  create mode 100644 hw/acpi/acpi-cpu-ospm-interface-stub.c
> > > >  create mode 100644 hw/acpi/cpu_ospm_interface.c  create mode 10064=
4
> > > > include/hw/acpi/cpu_ospm_interface.h
> > > >
> > > > diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig index
> > > > 1d4e9f0845..aa52f0468f 100644
> > > > --- a/hw/acpi/Kconfig
> > > > +++ b/hw/acpi/Kconfig
> > > > @@ -21,6 +21,9 @@ config ACPI_ICH9
> > > >  config ACPI_CPU_HOTPLUG
> > > >      bool
> > > >
> > > > +config ACPI_CPU_OSPM_INTERFACE
> > > > +    bool
> > > > +
> > > >  config ACPI_MEMORY_HOTPLUG
> > > >      bool
> > > >      select MEM_DEVICE
> > > > diff --git a/hw/acpi/acpi-cpu-ospm-interface-stub.c
> > > > b/hw/acpi/acpi-cpu-ospm-interface-stub.c
> > > > new file mode 100644
> > > > index 0000000000..f6f333f641
> > > > --- /dev/null
> > > > +++ b/hw/acpi/acpi-cpu-ospm-interface-stub.c
> > > > @@ -0,0 +1,41 @@
> > > > +/*
> > > > + * ACPI CPU OSPM Interface Handling.
> > > > + *
> > > > + * Copyright (c) 2025 Huawei Technologies R&D (UK) Ltd.
> > > > + *
> > > > + * Author: Salil Mehta <salil.mehta@huawei.com>
> > > > + *
> > > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > > + *
> > > > + * This program is free software; you can redistribute it and/or
> > > > +modify
> > > > + * it under the terms of the GNU General Public License as publish=
ed
> > > > +by
> > > > + * the Free Software Foundation; either version 2 of the License, =
or
> > > > + * (at your option) any later version.
> > > > + */
> > > > +
> > > > +#include "qemu/osdep.h"
> > > > +#include "hw/acpi/cpu_ospm_interface.h"
> > > > +
> > > > +void acpi_cpu_device_check_cb(AcpiCpuOspmState *cpu_st,
> DeviceState
> > > *dev,
> > > > +                              uint32_t event_st, Error **errp) { }
> > > > +
> > > > +void acpi_cpu_eject_request_cb(AcpiCpuOspmState *cpu_st,
> > > DeviceState *dev,
> > > > +                               uint32_t event_st, Error **errp) { =
}
> > > > +
> > > > +void acpi_cpu_eject_cb(AcpiCpuOspmState *cpu_st, DeviceState *dev,
> > > > +Error **errp) { }
> > > > +
> > > > +void acpi_cpu_ospm_state_interface_init(MemoryRegion *as, Object
> > > *owner,
> > > > +                                        AcpiCpuOspmState *state,
> > > > +                                        hwaddr base_addr) { }
> > > > +
> > > > +void acpi_cpus_ospm_status(AcpiCpuOspmState *cpu_st,
> > > ACPIOSTInfoList
> > > > +***list) { }
> > > > diff --git a/hw/acpi/cpu_ospm_interface.c
> > > > b/hw/acpi/cpu_ospm_interface.c new file mode 100644 index
> > > > 0000000000..61aab8a793
> > > > --- /dev/null
> > > > +++ b/hw/acpi/cpu_ospm_interface.c
> > > > @@ -0,0 +1,747 @@
> > > > +/*
> > > > + * ACPI CPU OSPM Interface Handling.
> > > > + *
> > > > + * Copyright (c) 2025 Huawei Technologies R&D (UK) Ltd.
> > > > + *
> > > > + * Author: Salil Mehta <salil.mehta@huawei.com>
> > > > + *
> > > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > > + *
> > > > + * This program is free software; you can redistribute it and/or
> > > > +modify
> > > > + * it under the terms of the GNU General Public License as publish=
ed
> > > > +by
> > > > + * the Free Software Foundation; either version 2 of the License, =
or
> > > > + * (at your option) any later version.
> > > > + */
> > > > +
> > > > +#include "qemu/osdep.h"
> > > > +#include "migration/vmstate.h"
> > > > +#include "hw/core/cpu.h"
> > > > +#include "qapi/error.h"
> > > > +#include "trace.h"
> > > > +#include "qapi/qapi-events-acpi.h"
> > > > +#include "hw/acpi/cpu_ospm_interface.h"
> > > > +
> > > > +/* CPU identifier and resource device */
> > > > +#define CPU_NAME_FMT      "C%.03X" /* CPU name format (e.g., C001)
> > > */
> > > > +#define CPU_RES_DEVICE    "CPUR" /* CPU resource device name */
> > > > +#define CPU_DEVICE        "CPUS" /* CPUs device name */
> > > > +#define CPU_LOCK          "CPLK" /* CPU lock object */
> > > > +/* ACPI method(_STA, _EJ0, etc.) handlers */
> > > > +#define CPU_STS_METHOD    "CSTA" /* CPU status method
> > > (_STA.Enabled) */
> > > > +#define CPU_SCAN_METHOD   "CSCN" /* CPU scan method for
> > > enumeration */
> > > > +#define CPU_NOTIFY_METHOD "CTFY" /* Notify method for CPU events
> > > */
> > > > +#define CPU_EJECT_METHOD  "CEJ0" /* CPU eject method (_EJ0) */
> > > > +#define CPU_OST_METHOD    "COST" /* OSPM status reporting (_OST) *=
/
> > > > +/* CPU MMIO region fields (in PRST region) */
> > > > +#define CPU_SELECTOR      "CSEL" /* CPU selector index (WO) */
> > > > +#define CPU_ENABLED_F     "CPEN" /* Flag: CPU enabled status(_STA)
> > > (RO) */
> > > > +#define CPU_DEVCHK_F      "CDCK" /* Flag: Device-check event (RW) =
*/
> > > > +#define CPU_EJECTRQ_F     "CEJR" /* Flag: Eject-request event (RW)=
*/
> > > > +#define CPU_EJECT_F       "CEJ0" /* Flag: Ejection trigger (WO) */
> > > > +#define CPU_COMMAND       "CCMD" /* Command register (RW) */
> > > > +#define CPU_DATA          "CDAT" /* Data register (RW) */
> > > > +
> > > > + /*
> > > > + * CPU OSPM Interface MMIO Layout (Total: 16 bytes)
> > > > + *
> > > > + *
> > > > +
> +--------+--------+--------+--------+--------+--------+--------+----
> > > > + ----+
> > > > + * |  0x00  |  0x01  |  0x02  |  0x03  |  0x04  |  0x05  |  0x06  =
|
> > > > + 0x07  |
> > > > + *
> +--------+--------+--------+--------+--------+--------+--------+--------+
> > > > + * |       Selector (DWord, write-only)         | Flags  |Command
> |Reserved|
> > > > + * |                                            | (RO/RW)|  (WO)
> |(2B pad)|
> > > > + * |        4 bytes (32 bits)                   | 1B     |   1B   =
|
> 2B     |
> > > > + *
> > > > +
> +-------------------------------------------------------------------
> > > > + ----+
> > > > + * |  0x08  |  0x09  |  0x0A  |  0x0B  |  0x0C  |  0x0D  |  0x0E  =
|
> > > > + 0x0F  |
> > > > + *
> +--------+--------+--------+--------+--------+--------+--------+--------+
> > > > + * |                        Data (QWord, read/write)
>        |
> > > > + * |               Used by CPU scan and _OST methods (64 bits)
>        |
> > > > + *
> > > > +
> +-------------------------------------------------------------------
> > > > + ----+
> > > > + *
> > > > + * Field Overview:
> > > > + *
> > > > + * - Selector: 4 bytes @0x00 (DWord, WO)
> > > > + *               - Selects target CPU index for the current
> operation.
> > > > + * - Flags:    1 byte  @0x04 (RO/RW)
> > > > + *               - Bit 0: ENABLED  =E2=80=93 CPU is powered on (RO=
)
> > > > + *               - Bit 1: DEVCHK   =E2=80=93 Device-check complete=
d (RW)
> > > > + *               - Bit 2: EJECTRQ  =E2=80=93 Guest requests CPU ej=
ect (RW)
> > > > + *               - Bit 3: EJECT    =E2=80=93 Trigger CPU ejection =
(WO)
> > > > + *               - Bits 4=E2=80=937: Reserved (write 0)
> > > > + * - Command:  1 byte  @0x05 (WO)
> > > > + *               - Specifies control operation (e.g., scan, _OST,
> eject).
> > > > + * - Reserved: 2 bytes @0x06=E2=80=930x07
> > > > + *               - Alignment padding; must be zero on write.
> > > > + * - Data:     8 bytes @0x08 (QWord, RW)
> > > > + *               - Input/output for command-specific data.
> > > > + *               - Used by CPU scan or _OST.
> > > > + */
> > > > +
> > > > +/*
> > > > + * Macros defining the CPU MMIO region layout. Change field sizes
> > > > +here to
> > > > + * alter the overall MMIO region size.
> > > > + */
> > > > +/* Sub-Field sizes (in bytes) */
> > > > +#define ACPI_CPU_MR_SELECTOR_SIZE  4 /* Write-only (DWord access)
> > > */
> > > > +#define ACPI_CPU_MR_FLAGS_SIZE     1 /* Read-write (Byte access) *=
/
> > > > +#define ACPI_CPU_MR_RES_FLAGS_SIZE 0 /* Reserved padding */
> > > > +#define ACPI_CPU_MR_CMD_SIZE       1 /* Write-only (Byte access) *=
/
> > > > +#define ACPI_CPU_MR_RES_CMD_SIZE   2 /* Reserved padding */
> > > > +#define ACPI_CPU_MR_CMD_DATA_SIZE  8 /* Read-write (QWord
> > > access) */
> > > > +
> > > > +#define ACPI_CPU_OSPM_IF_MAX_FIELD_SIZE \
> > > > +    MAX_CONST(ACPI_CPU_MR_CMD_DATA_SIZE, \
> > > > +    MAX_CONST(ACPI_CPU_MR_SELECTOR_SIZE, \
> > > > +    MAX_CONST(ACPI_CPU_MR_CMD_SIZE,
> > > ACPI_CPU_MR_FLAGS_SIZE)))
> > > > +
> > > > +/* Validate layout against exported total length */
> > > > +_Static_assert(ACPI_CPU_OSPM_IF_REG_LEN =3D=3D
> > > > +               (ACPI_CPU_MR_SELECTOR_SIZE +
> > > > +                ACPI_CPU_MR_FLAGS_SIZE +
> > > > +                ACPI_CPU_MR_RES_FLAGS_SIZE +
> > > > +                ACPI_CPU_MR_CMD_SIZE +
> > > > +                ACPI_CPU_MR_RES_CMD_SIZE +
> > > > +                ACPI_CPU_MR_CMD_DATA_SIZE),
> > > > +               "ACPI_CPU_OSPM_IF_REG_LEN mismatch with internal MM=
IO
> > > > +layout");
> > > > +
> > > > +/* Sub-Field sizes (in bits) */
> > > > +#define ACPI_CPU_MR_SELECTOR_SIZE_BITS \
> > > > +    (ACPI_CPU_MR_SELECTOR_SIZE * BITS_PER_BYTE)  /* Write-only
> > > (DWord
> > > > +Acc) */ #define ACPI_CPU_MR_FLAGS_SIZE_BITS \
> > > > +    (ACPI_CPU_MR_FLAGS_SIZE * BITS_PER_BYTE)     /* Read-write
> (Byte
> > > Acc) */
> > > > +#define ACPI_CPU_MR_RES_FLAGS_SIZE_BITS \
> > > > +    (ACPI_CPU_MR_RES_FLAGS_SIZE * BITS_PER_BYTE) /* Reserved
> > > padding
> > > > +*/ #define ACPI_CPU_MR_CMD_SIZE_BITS \
> > > > +    (ACPI_CPU_MR_CMD_SIZE * BITS_PER_BYTE)       /* Write-only
> (Byte
> > > Acc) */
> > > > +#define ACPI_CPU_MR_RES_CMD_SIZE_BITS \
> > > > +    (ACPI_CPU_MR_RES_CMD_SIZE * BITS_PER_BYTE)   /* Reserved
> > > padding */
> > > > +#define ACPI_CPU_MR_CMD_DATA_SIZE_BITS \
> > > > +    (ACPI_CPU_MR_CMD_DATA_SIZE * BITS_PER_BYTE)  /* Read-write
> > > (QWord
> > > > +Acc) */
> > > > +
> > > > +/* Field offsets (in bytes) */
> > > > +#define ACPI_CPU_MR_SELECTOR_OFFSET_WO  0 #define
> > > > +ACPI_CPU_MR_FLAGS_OFFSET_RW \
> > > > +    (ACPI_CPU_MR_SELECTOR_OFFSET_WO + \
> > > > +     ACPI_CPU_MR_SELECTOR_SIZE)
> > > > +#define ACPI_CPU_MR_CMD_OFFSET_WO \
> > > > +    (ACPI_CPU_MR_FLAGS_OFFSET_RW + \
> > > > +     ACPI_CPU_MR_FLAGS_SIZE + \
> > > > +     ACPI_CPU_MR_RES_FLAGS_SIZE)
> > > > +#define ACPI_CPU_MR_CMD_DATA_OFFSET_RW \
> > > > +    (ACPI_CPU_MR_CMD_OFFSET_WO + \
> > > > +     ACPI_CPU_MR_CMD_SIZE + \
> > > > +     ACPI_CPU_MR_RES_CMD_SIZE)
> > > > +
> > > > +/* ensure all offsets are at their natural size alignment
> boundaries */
> > > > +#define STATIC_ASSERT_FIELD_ALIGNMENT(offset, type, field_name)
> > > \
> > > > +    _Static_assert((offset) % sizeof(type) =3D=3D 0,
>           \
> > > > +                   field_name " is not aligned to its natural
> > > > +boundary")
> > > > +
> > > >
> > > +STATIC_ASSERT_FIELD_ALIGNMENT(ACPI_CPU_MR_SELECTOR_OFFSET_W
> > > O,
> > > > +                              uint32_t, "Selector");
> > > > +STATIC_ASSERT_FIELD_ALIGNMENT(ACPI_CPU_MR_FLAGS_OFFSET_RW,
> > > > +                              uint8_t, "Flags");
> > > > +STATIC_ASSERT_FIELD_ALIGNMENT(ACPI_CPU_MR_CMD_OFFSET_WO,
> > > > +                              uint8_t, "Command");
> > > >
> > > +STATIC_ASSERT_FIELD_ALIGNMENT(ACPI_CPU_MR_CMD_DATA_OFFSET_
> > > RW,
> > > > +                              uint64_t, "Command Data");
> > > > +
> > > > +/* Flag bit positions (used within 'flags' subfield) */ #define
> > > > +ACPI_CPU_FLAGS_USED_BITS 4 #define
> > > ACPI_CPU_MR_FLAGS_BIT_ENABLED
> > > > +BIT(0) #define ACPI_CPU_MR_FLAGS_BIT_DEVCHK  BIT(1) #define
> > > > +ACPI_CPU_MR_FLAGS_BIT_EJECTRQ BIT(2)
> > > > +#define ACPI_CPU_MR_FLAGS_BIT_EJECT
> > > BIT(ACPI_CPU_FLAGS_USED_BITS - 1)
> > > > +
> > > > +#define ACPI_CPU_MR_RES_FLAG_BITS (BITS_PER_BYTE -
> > > > +ACPI_CPU_FLAGS_USED_BITS)
> > > > +
> > > > +enum {
> > > > +    ACPI_GET_NEXT_CPU_WITH_EVENT_CMD =3D 0,
> > > > +    ACPI_OST_EVENT_CMD =3D 1,
> > > > +    ACPI_OST_STATUS_CMD =3D 2,
> > > > +    ACPI_CMD_MAX
> > > > +};
> > > > +
> > > > +#define AML_APPEND_MR_RESVD_FIELD(mr_field, size_bits)       \
> > > > +    do {                                                        \
> > > > +        if ((size_bits) !=3D 0) {                                 =
\
> > > > +            aml_append((mr_field), aml_reserved_field(size_bits));=
 \
> > > > +        }                                                       \
> > > > +    } while (0)
> > > > +
> > > > +#define AML_APPEND_MR_NAMED_FIELD(mr_field, name, size_bits)    \
> > > > +    do {                                                        \
> > > > +        if ((size_bits) !=3D 0) {                                 =
\
> > > > +            aml_append((mr_field), aml_named_field((name),
> (size_bits))); \
> > > > +        }                                                       \
> > > > +    } while (0)
> > > > +
> > > > +#define AML_CPU_RES_DEV(base, field) \
> > > > +        aml_name("%s.%s.%s", (base), CPU_RES_DEVICE, (field))
> > > > +
> > > > +static ACPIOSTInfo *
> > > > +acpi_cpu_ospm_ost_status(int idx, AcpiCpuOspmStateStatus *cdev) {
> > > > +    ACPIOSTInfo *info =3D g_new0(ACPIOSTInfo, 1);
> > > > +
> > > > +    info->source =3D cdev->ost_event;
> > > > +    info->status =3D cdev->ost_status;
> > > > +    if (cdev->cpu) {
> > > > +        DeviceState *dev =3D DEVICE(cdev->cpu);
> > > > +        if (dev->id) {
> > > > +            info->device =3D g_strdup(dev->id);
> > > > +        }
> > > > +    }
> > > > +    return info;
> > > > +}
> > > > +
> > > > +void acpi_cpus_ospm_status(AcpiCpuOspmState *cpu_st,
> > > ACPIOSTInfoList
> > > > +***list) {
> > > > +    ACPIOSTInfoList ***tail =3D list;
> > > > +    int i;
> > > > +
> > > > +    for (i =3D 0; i < cpu_st->dev_count; i++) {
> > > > +        QAPI_LIST_APPEND(*tail, acpi_cpu_ospm_ost_status(i, &cpu_s=
t-
> > > >devs[i]));
> > > > +    }
> > > > +}
> > > > +
> > > > +static uint64_t
> > > > +acpi_cpu_ospm_intf_mr_read(void *opaque, hwaddr addr, unsigned
> > > size)
> > > > +{
> > > > +    AcpiCpuOspmState *cpu_st =3D opaque;
> > > > +    AcpiCpuOspmStateStatus *cdev;
> > > > +    uint64_t val =3D 0;
> > > > +
> > > > +    if (cpu_st->selector >=3D cpu_st->dev_count) {
> > > > +        return val;
> > > > +    }
> > > > +    cdev =3D &cpu_st->devs[cpu_st->selector];
> > > > +    switch (addr) {
> > > > +    case ACPI_CPU_MR_FLAGS_OFFSET_RW:
> > > > +        val |=3D qdev_check_enabled(DEVICE(cdev->cpu)) ?
> > > > +                                  ACPI_CPU_MR_FLAGS_BIT_ENABLED : =
0;
> > > > +        val |=3D cdev->devchk_pending ? ACPI_CPU_MR_FLAGS_BIT_DEVC=
HK
> :
> > > 0;
> > > > +        val |=3D cdev->ejrqst_pending ? ACPI_CPU_MR_FLAGS_BIT_EJEC=
TRQ
> :
> > > 0;
> > > > +        trace_acpi_cpuos_if_read_flags(cpu_st->selector, val);
> > > > +        break;
> > > > +    case ACPI_CPU_MR_CMD_DATA_OFFSET_RW:
> > > > +        switch (cpu_st->command) {
> > > > +        case ACPI_GET_NEXT_CPU_WITH_EVENT_CMD:
> > > > +           val =3D cpu_st->selector;
> > > > +           break;
> > > > +        default:
> > > > +
>  trace_acpi_cpuos_if_read_invalid_cmd_data(cpu_st->selector,
> > > > +
>  cpu_st->command);
> > > > +           break;
> > > > +        }
> > > > +        trace_acpi_cpuos_if_read_cmd_data(cpu_st->selector, val);
> > > > +        break;
> > > > +    default:
> > > > +        break;
> > > > +    }
> > > > +    return val;
> > > > +}
> > > > +
> > > > +static void
> > > > +acpi_cpu_ospm_intf_mr_write(void *opaque, hwaddr addr, uint64_t
> > > data,
> > > > +                            unsigned int size) {
> > > > +    AcpiCpuOspmState *cpu_st =3D opaque;
> > > > +    AcpiCpuOspmStateStatus *cdev;
> > > > +    ACPIOSTInfo *info;
> > > > +
> > > > +    assert(cpu_st->dev_count);
> > > > +    if (addr) {
> > > > +        if (cpu_st->selector >=3D cpu_st->dev_count) {
> > > > +
> trace_acpi_cpuos_if_invalid_idx_selected(cpu_st->selector);
> > > > +            return;
> > > > +        }
> > > > +    }
> > > > +
> > > > +    switch (addr) {
> > > > +    case ACPI_CPU_MR_SELECTOR_OFFSET_WO: /* current CPU selector
> > > */
> > > > +        cpu_st->selector =3D data;
> > > > +        trace_acpi_cpuos_if_write_idx(cpu_st->selector);
> > > > +        break;
> > > > +    case ACPI_CPU_MR_FLAGS_OFFSET_RW: /* set is_* fields  */
> > > > +        cdev =3D &cpu_st->devs[cpu_st->selector];
> > > > +        if (data & ACPI_CPU_MR_FLAGS_BIT_DEVCHK) {
> > > > +            /* clear device-check pending event */
> > > > +            cdev->devchk_pending =3D false;
> > > > +            trace_acpi_cpuos_if_clear_devchk_evt(cpu_st->selector)=
;
> > > > +        } else if (data & ACPI_CPU_MR_FLAGS_BIT_EJECTRQ) {
> > > > +            /* clear eject-request pending event */
> > > > +            cdev->ejrqst_pending =3D false;
> > > > +            trace_acpi_cpuos_if_clear_ejrqst_evt(cpu_st->selector)=
;
> > > > +        } else if (data & ACPI_CPU_MR_FLAGS_BIT_EJECT) {
> > > > +            DeviceState *dev =3D NULL;
> > > > +            if (!cdev->cpu || cdev->cpu =3D=3D first_cpu) {
> > > > +
> trace_acpi_cpuos_if_ejecting_invalid_cpu(cpu_st->selector);
> > > > +                break;
> > > > +            }
> > > > +            /*
> > > > +             * OSPM has returned with eject. Hence, it is now safe
> to put the
> > > > +             * cpu device on powered-off state.
> > > > +             */
> > > > +            trace_acpi_cpuos_if_ejecting_cpu(cpu_st->selector);
> > > > +            dev =3D DEVICE(cdev->cpu);
> > > > +            qdev_sync_disable(dev, &error_fatal);
> > > > +        }
> > > > +        break;
> > > > +    case ACPI_CPU_MR_CMD_OFFSET_WO:
> > > > +        trace_acpi_cpuos_if_write_cmd(cpu_st->selector, data);
> > > > +        if (data < ACPI_CMD_MAX) {
> > > > +            cpu_st->command =3D data;
> > > > +            if (cpu_st->command =3D=3D
> > > ACPI_GET_NEXT_CPU_WITH_EVENT_CMD) {
> > > > +                uint32_t iter =3D cpu_st->selector;
> > > > +
> > > > +                do {
> > > > +                    cdev =3D &cpu_st->devs[iter];
> > > > +                    if (cdev->devchk_pending ||
> cdev->ejrqst_pending) {
> > > > +                        cpu_st->selector =3D iter;
> > > > +
> trace_acpi_cpuos_if_cpu_has_events(cpu_st->selector,
> > > > +                            cdev->devchk_pending,
> cdev->ejrqst_pending);
> > > > +                        break;
> > > > +                    }
> > > > +                    iter =3D iter + 1 < cpu_st->dev_count ? iter +=
 1
> : 0;
> > > > +                } while (iter !=3D cpu_st->selector);
> > > > +            }
> > > > +        }
> > > > +        break;
> > > > +    case ACPI_CPU_MR_CMD_DATA_OFFSET_RW:
> > > > +        switch (cpu_st->command) {
> > > > +        case ACPI_OST_EVENT_CMD: {
> > > > +           cdev =3D &cpu_st->devs[cpu_st->selector];
> > > > +           cdev->ost_event =3D data;
> > > > +           trace_acpi_cpuos_if_write_ost_ev(cpu_st->selector, cdev=
-
> > > >ost_event);
> > > > +           break;
> > > > +        }
> > > > +        case ACPI_OST_STATUS_CMD: {
> > > > +           cdev =3D &cpu_st->devs[cpu_st->selector];
> > > > +           cdev->ost_status =3D data;
> > > > +           info =3D acpi_cpu_ospm_ost_status(cpu_st->selector, cde=
v);
> > > > +           qapi_event_send_acpi_device_ost(info);
> > > > +           qapi_free_ACPIOSTInfo(info);
> > > > +           trace_acpi_cpuos_if_write_ost_status(cpu_st->selector,
> > > > +                                                cdev->ost_status);
> > > > +           break;
> > > > +        }
> > > > +        default:
> > > > +           trace_acpi_cpuos_if_write_invalid_cmd(cpu_st->selector,
> > > > +                                                 cpu_st->command);
> > > > +           break;
> > > > +        }
> > > > +        break;
> > > > +    default:
> > > > +        trace_acpi_cpuos_if_write_invalid_offset(cpu_st->selector,
> addr);
> > > > +        break;
> > > > +    }
> > > > +}
> > > > +
> > > > +static const MemoryRegionOps cpu_common_mr_ops =3D {
> > > > +    .read =3D acpi_cpu_ospm_intf_mr_read,
> > > > +    .write =3D acpi_cpu_ospm_intf_mr_write,
> > > > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > > > +    .valid =3D {
> > > > +        .min_access_size =3D 1,
> > > > +        .max_access_size =3D ACPI_CPU_OSPM_IF_MAX_FIELD_SIZE,
> > > > +    },
> > > > +    .impl =3D {
> > > > +        .min_access_size =3D 1,
> > > > +        .max_access_size =3D ACPI_CPU_OSPM_IF_MAX_FIELD_SIZE,
> > > > +        .unaligned =3D false,
> > > > +    },
> > > > +};
> > > > +
> > > > +void acpi_cpu_ospm_state_interface_init(MemoryRegion *as, Object
> > > *owner,
> > > > +                                        AcpiCpuOspmState *state,
> > > > +                                        hwaddr base_addr) {
> > > > +    MachineState *machine =3D MACHINE(qdev_get_machine());
> > > > +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> > > > +    const CPUArchIdList *id_list;
> > > > +    int i;
> > > > +
> > > > +    assert(mc->possible_cpu_arch_ids);
> > > > +    id_list =3D mc->possible_cpu_arch_ids(machine);
> > > > +    state->dev_count =3D id_list->len;
> > > > +    state->devs =3D g_new0(typeof(*state->devs), state->dev_count)=
;
> > > > +    for (i =3D 0; i < id_list->len; i++) {
> > > > +        state->devs[i].cpu =3D  CPU(id_list->cpus[i].cpu);
> > > > +        state->devs[i].arch_id =3D id_list->cpus[i].arch_id;
> > > > +    }
> > > > +    memory_region_init_io(&state->ctrl_reg, owner,
> > > &cpu_common_mr_ops, state,
> > > > +                          "ACPI CPU OSPM State Interface Memory
> Region",
> > > > +                          ACPI_CPU_OSPM_IF_REG_LEN);
> > > > +    memory_region_add_subregion(as, base_addr, &state->ctrl_reg); =
}
> > > > +
> > > > +static AcpiCpuOspmStateStatus *
> > > > +acpi_get_cpu_status(AcpiCpuOspmState *cpu_st, DeviceState *dev) {
> > > > +    CPUClass *k =3D CPU_GET_CLASS(dev);
> > > > +    uint64_t cpu_arch_id =3D k->get_arch_id(CPU(dev));
> > > > +    int i;
> > > > +
> > > > +    for (i =3D 0; i < cpu_st->dev_count; i++) {
> > > > +        if (cpu_arch_id =3D=3D cpu_st->devs[i].arch_id) {
> > > > +            return &cpu_st->devs[i];
> > > > +        }
> > > > +    }
> > > > +    return NULL;
> > > > +}
> > > > +
> > > > +void acpi_cpu_device_check_cb(AcpiCpuOspmState *cpu_st,
> DeviceState
> > > *dev,
> > > > +                              uint32_t event_st, Error **errp) {
> > > > +    AcpiCpuOspmStateStatus *cdev;
> > > > +    cdev =3D acpi_get_cpu_status(cpu_st, dev);
> > > > +    if (!cdev) {
> > > > +        return;
> > > > +    }
> > > > +    assert(cdev->cpu);
> > > > +
> > > > +    /*
> > > > +     * Tell OSPM via GED IRQ(GSI) that a powered-off cpu is being
> powered-
> > > on.
> > > > +     * Also, mark 'device-check' event pending for this cpu. This
> will
> > > > +     * eventually result in OSPM evaluating the ACPI _EVT method
> and scan
> > > of
> > > > +     * cpus
> > > > +     */
> > > > +    cdev->devchk_pending =3D true;
> > > > +    acpi_send_event(cpu_st->acpi_dev, event_st); }
> > > > +
> > > > +void acpi_cpu_eject_request_cb(AcpiCpuOspmState *cpu_st,
> > > DeviceState *dev,
> > > > +                              uint32_t event_st, Error **errp) {
> > > > +    AcpiCpuOspmStateStatus *cdev;
> > > > +    cdev =3D acpi_get_cpu_status(cpu_st, dev);
> > > > +    if (!cdev) {
> > > > +        return;
> > > > +    }
> > > > +    assert(cdev->cpu);
> > > > +
> > > > +    /*
> > > > +     * Tell OSPM via GED IRQ(GSI) that a cpu wants to power-off or
> go on
> > > standby
> > > > +     * Also,mark 'eject-request' event pending for this cpu.
> (graceful
> > > shutdown)
> > > > +     */
> > > > +    cdev->ejrqst_pending =3D true;
> > > > +    acpi_send_event(cpu_st->acpi_dev, event_st); }
> > > > +
> > > > +void
> > > > +acpi_cpu_eject_cb(AcpiCpuOspmState *cpu_st, DeviceState *dev, Erro=
r
> > > > +**errp) {
> > > > +    /* TODO: possible handling here */ }
> > > > +
> > > > +static const VMStateDescription vmstate_cpu_ospm_state_sts =3D {
> > > > +    .name =3D "CPU OSPM state status",
> > > > +    .version_id =3D 1,
> > > > +    .minimum_version_id =3D 1,
> > > > +    .fields =3D (const VMStateField[]) {
> > > > +        VMSTATE_BOOL(devchk_pending, AcpiCpuOspmStateStatus),
> > > > +        VMSTATE_BOOL(ejrqst_pending, AcpiCpuOspmStateStatus),
> > > > +        VMSTATE_UINT32(ost_event, AcpiCpuOspmStateStatus),
> > > > +        VMSTATE_UINT32(ost_status, AcpiCpuOspmStateStatus),
> > > > +        VMSTATE_END_OF_LIST()
> > > > +    }
> > > > +};
> > > > +
> > > > +const VMStateDescription vmstate_cpu_ospm_state =3D {
> > > > +    .name =3D "CPU OSPM state",
> > > > +    .version_id =3D 1,
> > > > +    .minimum_version_id =3D 1,
> > > > +    .fields =3D (const VMStateField[]) {
> > > > +        VMSTATE_UINT32(selector, AcpiCpuOspmState),
> > > > +        VMSTATE_UINT8(command, AcpiCpuOspmState),
> > > > +        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(devs,
> > > AcpiCpuOspmState,
> > > > +                                             dev_count,
> > > > +
>  vmstate_cpu_ospm_state_sts,
> > > > +
>  AcpiCpuOspmStateStatus),
> > > > +        VMSTATE_END_OF_LIST()
> > > > +    }
> > > > +};
> > > > +
> > > > +void acpi_build_cpus_aml(Aml *table, hwaddr base_addr, const char
> > > *root,
> > > > +                         const char *event_handler_method) {
> > > > +    MachineState *machine =3D MACHINE(qdev_get_machine());
> > > > +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> > > > +    const CPUArchIdList *arch_ids =3D
> mc->possible_cpu_arch_ids(machine);
> > > > +    Aml *sb_scope =3D aml_scope("_SB"); /* System Bus Scope */
> > > > +    Aml *ifctx, *field, *method, *cpu_res_dev, *cpus_dev;
> > > > +    Aml *zero =3D aml_int(0);
> > > > +    Aml *one =3D aml_int(1);
> > > > +
> > > > +    cpu_res_dev =3D aml_device("%s.%s", root, CPU_RES_DEVICE);
> > > > +    {
> > > > +        Aml *crs;
> > > > +
> > > > +        aml_append(cpu_res_dev,
> > > > +            aml_name_decl("_HID", aml_eisaid("PNP0A06")));
> > > > +        aml_append(cpu_res_dev,
> > > > +            aml_name_decl("_UID", aml_string("CPU OSPM Interface
> > > resources")));
> > > > +        aml_append(cpu_res_dev, aml_mutex(CPU_LOCK, 0));
> > > > +
> > > > +        crs =3D aml_resource_template();
> > > > +        aml_append(crs, aml_memory32_fixed(base_addr,
> > > ACPI_CPU_OSPM_IF_REG_LEN,
> > > > +                   AML_READ_WRITE));
> > > > +
> > > > +        aml_append(cpu_res_dev, aml_name_decl("_CRS", crs));
> > > > +
> > > > +        /* declare CPU OSPM Interface MMIO region related access
> fields */
> > > > +        aml_append(cpu_res_dev,
> > > > +                   aml_operation_region("PRST", AML_SYSTEM_MEMORY,
> > > > +                                        aml_int(base_addr),
> > > > +                                        ACPI_CPU_OSPM_IF_REG_LEN))=
;
> > > > +
> > > > +        /*
> > > > +         * define named fields within PRST region with 'Byte'
> access widths
> > > > +         * and reserve fields with other access width
> > > > +         */
> > > > +        field =3D aml_field("PRST", AML_BYTE_ACC, AML_NOLOCK,
> > > AML_PRESERVE);
> > > > +        /* reserve CPU 'selector' field (size in bits) */
> > > > +        AML_APPEND_MR_RESVD_FIELD(field,
> > > ACPI_CPU_MR_SELECTOR_SIZE_BITS);
> > > > +        /* Flag::Enabled Bit(RO) - Read '1' if enabled */
> > > > +        AML_APPEND_MR_NAMED_FIELD(field, CPU_ENABLED_F, 1);
> > > > +        /* Flag::Devchk Bit(RW) - Read '1', has a event. Write '1'=
,
> to clear */
> > > > +        AML_APPEND_MR_NAMED_FIELD(field, CPU_DEVCHK_F, 1);
> > > > +        /* Flag::Ejectrq Bit(RW) - Read 1, has event. Write 1 to
> clear */
> > > > +        AML_APPEND_MR_NAMED_FIELD(field, CPU_EJECTRQ_F, 1);
> > > > +        /* Flag::Eject Bit(WO) - OSPM evals _EJx, initiates CPU
> Eject in
> > > Qemu*/
> > > > +        AML_APPEND_MR_NAMED_FIELD(field, CPU_EJECT_F, 1);
> > > > +        /* Flag::Bit(ACPI_CPU_FLAGS_USED_BITS)-Bit(7) - Reserve
> left over
> > > bits*/
> > > > +        AML_APPEND_MR_RESVD_FIELD(field,
> > > ACPI_CPU_MR_RES_FLAG_BITS);
> > > > +        /* Reserved space: padding after flags */
> > > > +        AML_APPEND_MR_RESVD_FIELD(field,
> > > ACPI_CPU_MR_RES_FLAGS_SIZE_BITS);
> > > > +        /* Command field written by OSPM */
> > > > +        AML_APPEND_MR_NAMED_FIELD(field, CPU_COMMAND,
> > > > +                                  ACPI_CPU_MR_CMD_SIZE_BITS);
> > > > +        /* Reserved space: padding after command field */
> > > > +        AML_APPEND_MR_RESVD_FIELD(field,
> > > ACPI_CPU_MR_RES_CMD_SIZE_BITS);
> > > > +        /* Command data: 64-bit payload associated with command */
> > > > +        AML_APPEND_MR_RESVD_FIELD(field,
> > > ACPI_CPU_MR_CMD_DATA_SIZE_BITS);
> > > > +        aml_append(cpu_res_dev, field);
> > > > +
> > > > +        /*
> > > > +         * define named fields with 'Dword' access widths and
> reserve fields
> > > > +         * with other access width
> > > > +         */
> > > > +        field =3D aml_field("PRST", AML_DWORD_ACC, AML_NOLOCK,
> > > AML_PRESERVE);
> > > > +        /* CPU selector, write only */
> > > > +        AML_APPEND_MR_NAMED_FIELD(field, CPU_SELECTOR,
> > > > +                                  ACPI_CPU_MR_SELECTOR_SIZE_BITS);
> > > > +        aml_append(cpu_res_dev, field);
> > > > +
> > > > +        /*
> > > > +         * define named fields with 'Qword' access widths and
> reserve fields
> > > > +         * with other access width
> > > > +         */
> > > > +        field =3D aml_field("PRST", AML_QWORD_ACC, AML_NOLOCK,
> > > AML_PRESERVE);
> > > > +        /*
> > > > +         * Reserve space: selector, flags, reserved flags, command=
,
> reserved
> > > > +         * command for Qword alignment.
> > > > +         */
> > > > +        AML_APPEND_MR_RESVD_FIELD(field,
> > > ACPI_CPU_MR_SELECTOR_SIZE_BITS +
> > > > +
> ACPI_CPU_MR_FLAGS_SIZE_BITS +
> > > > +
> ACPI_CPU_MR_RES_FLAGS_SIZE_BITS +
> > > > +
> ACPI_CPU_MR_CMD_SIZE_BITS +
> > > > +
> ACPI_CPU_MR_RES_CMD_SIZE_BITS);
> > > > +        /* Command data accessible via Qword */
> > > > +        AML_APPEND_MR_NAMED_FIELD(field, CPU_DATA,
> > > > +                                  ACPI_CPU_MR_CMD_DATA_SIZE_BITS);
> > > > +        aml_append(cpu_res_dev, field);
> > > > +    }
> > > > +    aml_append(sb_scope, cpu_res_dev);
> > > > +
> > > > +    cpus_dev =3D aml_device("%s.%s", root, CPU_DEVICE);
> > > > +    {
> > > > +        Aml *ctrl_lock =3D AML_CPU_RES_DEV(root, CPU_LOCK);
> > > > +        Aml *cpu_selector =3D AML_CPU_RES_DEV(root, CPU_SELECTOR);
> > > > +        Aml *is_enabled =3D AML_CPU_RES_DEV(root, CPU_ENABLED_F);
> > > > +        Aml *dvchk_evt =3D AML_CPU_RES_DEV(root, CPU_DEVCHK_F);
> > > > +        Aml *ejrq_evt =3D AML_CPU_RES_DEV(root, CPU_EJECTRQ_F);
> > > > +        Aml *ej_evt =3D AML_CPU_RES_DEV(root, CPU_EJECT_F);
> > > > +        Aml *cpu_cmd =3D AML_CPU_RES_DEV(root, CPU_COMMAND);
> > > > +        Aml *cpu_data =3D AML_CPU_RES_DEV(root, CPU_DATA);
> > > > +        int i;
> > > > +
> > > > +        aml_append(cpus_dev, aml_name_decl("_HID",
> > > aml_string("ACPI0010")));
> > > > +        aml_append(cpus_dev, aml_name_decl("_CID",
> > > > + aml_eisaid("PNP0A05")));
> > > > +
> > > > +        method =3D aml_method(CPU_NOTIFY_METHOD, 2,
> > > AML_NOTSERIALIZED);
> > > > +        for (i =3D 0; i < arch_ids->len; i++) {
> > > > +            Aml *cpu =3D aml_name(CPU_NAME_FMT, i);
> > > > +            Aml *uid =3D aml_arg(0);
> > > > +            Aml *event =3D aml_arg(1);
> > > > +
> > > > +            ifctx =3D aml_if(aml_equal(uid, aml_int(i)));
> > > > +            {
> > > > +                aml_append(ifctx, aml_notify(cpu, event));
> > > > +            }
> > > > +            aml_append(method, ifctx);
> > > > +        }
> > > > +        aml_append(cpus_dev, method);
> > > > +
> > > > +        method =3D aml_method(CPU_STS_METHOD, 1, AML_SERIALIZED);
> > > > +        {
> > > > +            Aml *idx =3D aml_arg(0);
> > > > +            Aml *sta =3D aml_local(0);
> > > > +            Aml *else_ctx;
> > > > +
> > > > +            aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
> > > > +            aml_append(method, aml_store(idx, cpu_selector));
> > > > +            aml_append(method, aml_store(zero, sta));
> > > > +            ifctx =3D aml_if(aml_equal(is_enabled, one));
> > > > +            {
> > > > +                /* cpu is present and enabled */
> > > > +                aml_append(ifctx, aml_store(aml_int(0xF), sta));
> > > > +            }
> > > > +            aml_append(method, ifctx);
> > > > +            else_ctx =3D aml_else();
> > > > +            {
> > > > +                /* cpu is present but disabled */
> > > > +                aml_append(else_ctx, aml_store(aml_int(0xD), sta))=
;
> > > > +            }
> > > > +            aml_append(method, else_ctx);
> > > > +            aml_append(method, aml_release(ctrl_lock));
> > > > +            aml_append(method, aml_return(sta));
> > > > +        }
> > > > +        aml_append(cpus_dev, method);
> > > > +
> > > > +        method =3D aml_method(CPU_EJECT_METHOD, 1, AML_SERIALIZED)=
;
> > > > +        {
> > > > +            Aml *idx =3D aml_arg(0);
> > > > +
> > > > +            aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
> > > > +            aml_append(method, aml_store(idx, cpu_selector));
> > > > +            aml_append(method, aml_store(one, ej_evt));
> > > > +            aml_append(method, aml_release(ctrl_lock));
> > > > +        }
> > > > +        aml_append(cpus_dev, method);
> > > > +
> > > > +        method =3D aml_method(CPU_SCAN_METHOD, 0, AML_SERIALIZED);
> > > > +        {
> > > > +            Aml *has_event =3D aml_local(0); /* Local0: Loop contr=
ol
> flag */
> > > > +            Aml *uid =3D aml_local(1); /* Local1: Current CPU UID =
*/
> > > > +            /* Constants */
> > > > +            Aml *dev_chk =3D aml_int(1); /* Notify: device check t=
o
> enable */
> > > > +            Aml *eject_req =3D aml_int(3); /* Notify: eject for
> removal */
> > > > +            Aml *next_cpu_cmd =3D
> > > > + aml_int(ACPI_GET_NEXT_CPU_WITH_EVENT_CMD);
> > > > +
> > > > +            /* Acquire CPU lock */
> > > > +            aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
> > > > +
> > > > +            /* Initialize loop */
> > > > +            aml_append(method, aml_store(zero, uid));
> > > > +            aml_append(method, aml_store(one, has_event));
> > > > +
> > > > +            Aml *while_ctx =3D aml_while(aml_land(
> > > > +                aml_equal(has_event, one),
> > > > +                aml_lless(uid, aml_int(arch_ids->len))
> > > > +            ));
> > > > +            {
> > > > +                aml_append(while_ctx, aml_store(zero, has_event));
> > > > +                /*
> > > > +                 * Issue scan cmd: QEMU will return next CPU with
> event in
> > > > +                 * cpu_data
> > > > +                 */
> > > > +                aml_append(while_ctx, aml_store(uid, cpu_selector)=
);
> > > > +                aml_append(while_ctx, aml_store(next_cpu_cmd,
> > > > + cpu_cmd));
> > > > +
> > > > +                /* If scan wrapped around to an earlier UID, exit
> loop */
> > > > +                Aml *wrap_check =3D aml_if(aml_lless(cpu_data, uid=
));
> > > > +                aml_append(wrap_check, aml_break());
> > > > +                aml_append(while_ctx, wrap_check);
> > > > +
> > > > +                /* Set UID to scanned result */
> > > > +                aml_append(while_ctx, aml_store(cpu_data, uid));
> > > > +
> > > > +                /* send CPU device-check(resume) event to OSPM */
> > > > +                Aml *if_devchk =3D aml_if(aml_equal(dvchk_evt, one=
));
> > > > +                {
> > > > +                    aml_append(if_devchk,
> > > > +                        aml_call2(CPU_NOTIFY_METHOD, uid, dev_chk)=
);
> > > > +                    /* clear local device-check event sent flag */
> > > > +                    aml_append(if_devchk, aml_store(one,
> dvchk_evt));
> > > > +                    aml_append(if_devchk, aml_store(one,
> has_event));
> > > > +                }
> > > > +                aml_append(while_ctx, if_devchk);
> > > > +
> > > > +                /*
> > > > +                 * send CPU eject-request event to OSPM to
> gracefully handle
> > > > +                 * OSPM related tasks running on this CPU
> > > > +                 */
> > > > +                Aml *else_ctx =3D aml_else();
> > > > +                Aml *if_ejrq =3D aml_if(aml_equal(ejrq_evt, one));
> > > > +                {
> > > > +                    aml_append(if_ejrq,
> > > > +                        aml_call2(CPU_NOTIFY_METHOD, uid,
> eject_req));
> > > > +                    /* clear local eject-request event sent flag *=
/
> > > > +                    aml_append(if_ejrq, aml_store(one, ejrq_evt));
> > > > +                    aml_append(if_ejrq, aml_store(one, has_event))=
;
> > > > +                }
> > > > +                aml_append(else_ctx, if_ejrq);
> > > > +                aml_append(while_ctx, else_ctx);
> > > > +
> > > > +                /* Increment UID */
> > > > +                aml_append(while_ctx, aml_increment(uid));
> > > > +            }
> > > > +            aml_append(method, while_ctx);
> > > > +
> > > > +            /* Release cpu lock */
> > > > +            aml_append(method, aml_release(ctrl_lock));
> > > > +        }
> > > > +        aml_append(cpus_dev, method);
> > > > +
> > > > +        method =3D aml_method(CPU_OST_METHOD, 4, AML_SERIALIZED);
> > > > +        {
> > > > +            Aml *uid =3D aml_arg(0);
> > > > +            Aml *ev_cmd =3D aml_int(ACPI_OST_EVENT_CMD);
> > > > +            Aml *st_cmd =3D aml_int(ACPI_OST_STATUS_CMD);
> > > > +
> > > > +            aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
> > > > +            aml_append(method, aml_store(uid, cpu_selector));
> > > > +            aml_append(method, aml_store(ev_cmd, cpu_cmd));
> > > > +            aml_append(method, aml_store(aml_arg(1), cpu_data));
> > > > +            aml_append(method, aml_store(st_cmd, cpu_cmd));
> > > > +            aml_append(method, aml_store(aml_arg(2), cpu_data));
> > > > +            aml_append(method, aml_release(ctrl_lock));
> > > > +        }
> > > > +        aml_append(cpus_dev, method);
> > > > +
> > > > +        /* build Processor object for each processor */
> > > > +        for (i =3D 0; i < arch_ids->len; i++) {
> > > > +            Aml *dev;
> > > > +            Aml *uid =3D aml_int(i);
> > > > +
> > > > +            dev =3D aml_device(CPU_NAME_FMT, i);
> > > > +            aml_append(dev, aml_name_decl("_HID",
> > > aml_string("ACPI0007")));
> > > > +            aml_append(dev, aml_name_decl("_UID", uid));
> > > > +
> > > > +            method =3D aml_method("_STA", 0, AML_SERIALIZED);
> > > > +            aml_append(method,
> aml_return(aml_call1(CPU_STS_METHOD,
> > > uid)));
> > > > +            aml_append(dev, method);
> > > > +
> > > > +            if (CPU(arch_ids->cpus[i].cpu) !=3D first_cpu) {
> > > > +                method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED=
);
> > > > +                aml_append(method, aml_call1(CPU_EJECT_METHOD,
> uid));
> > > > +                aml_append(dev, method);
> > > > +            }
> > > > +
> > > > +            method =3D aml_method("_OST", 3, AML_SERIALIZED);
> > > > +            aml_append(method,
> > > > +                aml_call4(CPU_OST_METHOD, uid, aml_arg(0),
> > > > +                          aml_arg(1), aml_arg(2))
> > > > +            );
> > > > +            aml_append(dev, method);
> > > > +            aml_append(cpus_dev, dev);
> > > > +        }
> > > > +    }
> > > > +    aml_append(sb_scope, cpus_dev);
> > > > +    aml_append(table, sb_scope);
> > > > +
> > > > +    method =3D aml_method(event_handler_method, 0,
> > > AML_NOTSERIALIZED);
> > > > +    aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
> > > > +    aml_append(table, method);
> > > > +}
> > > > diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build index
> > > > 73f02b9691..6d83396ab4 100644
> > > > --- a/hw/acpi/meson.build
> > > > +++ b/hw/acpi/meson.build
> > > > @@ -8,6 +8,8 @@ acpi_ss.add(files(
> > > >  ))
> > > >  acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_true: files('cpu.c=
',
> > > > 'cpu_hotplug.c'))
> > > >  acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_false:
> > > > files('acpi-cpu-hotplug-stub.c'))
> > > > +acpi_ss.add(when: 'CONFIG_ACPI_CPU_OSPM_INTERFACE', if_true:
> > > > +files('cpu_ospm_interface.c'))
> > > > +acpi_ss.add(when: 'CONFIG_ACPI_CPU_OSPM_INTERFACE', if_false:
> > > > +files('acpi-cpu-ospm-interface-stub.c'))
> > > >  acpi_ss.add(when: 'CONFIG_ACPI_MEMORY_HOTPLUG', if_true:
> > > > files('memory_hotplug.c'))
> > > >  acpi_ss.add(when: 'CONFIG_ACPI_MEMORY_HOTPLUG', if_false:
> > > > files('acpi-mem-hotplug-stub.c'))
> > > >  acpi_ss.add(when: 'CONFIG_ACPI_NVDIMM', if_true: files('nvdimm.c')=
)
> > > > diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events index
> > > > edc93e703c..c0ecbdd48f 100644
> > > > --- a/hw/acpi/trace-events
> > > > +++ b/hw/acpi/trace-events
> > > > @@ -40,6 +40,23 @@ cpuhp_acpi_fw_remove_cpu(uint32_t idx)
> > > "0x%"PRIx32
> > > > cpuhp_acpi_write_ost_ev(uint32_t slot, uint32_t ev) "idx[0x%"PRIx32=
"]
> > > > OST EVENT: 0x%"PRIx32  cpuhp_acpi_write_ost_status(uint32_t slot,
> > > > uint32_t st) "idx[0x%"PRIx32"] OST STATUS: 0x%"PRIx32
> > > >
> > > > +#cpu_ospm_interface.c
> > > > +acpi_cpuos_if_invalid_idx_selected(uint32_t idx) "selector
> > > idx[0x%"PRIx32"]"
> > > > +acpi_cpuos_if_read_flags(uint32_t idx, uint8_t flags) "cpu
> > > > +idx[0x%"PRIx32"] flags: 0x%"PRIx8 acpi_cpuos_if_write_idx(uint32_t
> > > > +idx) "set active cpu idx: 0x%"PRIx32
> acpi_cpuos_if_write_cmd(uint32_t
> > > > +idx, uint8_t cmd) "cpu idx[0x%"PRIx32"] cmd: 0x%"PRIx8
> > > > +acpi_cpuos_if_write_invalid_cmd(uint32_t idx, uint8_t cmd) "cpu
> > > > +idx[0x%"PRIx32"] invalid cmd: 0x%"PRIx8
> > > > +acpi_cpuos_if_write_invalid_offset(uint32_t idx, uint64_t addr) "c=
pu
> > > > +idx[0x%"PRIx32"] invalid offset: 0x%"PRIx64
> > > acpi_cpuos_if_read_cmd_data(uint32_t idx, uint32_t data) "cpu
> > > idx[0x%"PRIx32"] data: 0x%"PRIx32
> > > acpi_cpuos_if_read_invalid_cmd_data(uint32_t idx, uint8_t cmd) "cpu
> > > idx[0x%"PRIx32"] invalid cmd: 0x%"PRIx8
> > > acpi_cpuos_if_cpu_has_events(uint32_t idx, bool devchk, bool ejrqst)
> "cpu
> > > idx[0x%"PRIx32"] device-check pending: %d, eject-request pending: %d"
> > > > +acpi_cpuos_if_clear_devchk_evt(uint32_t idx) "cpu idx[0x%"PRIx32"]=
"
> > > > +acpi_cpuos_if_clear_ejrqst_evt(uint32_t idx) "cpu idx[0x%"PRIx32"]=
"
> > > > +acpi_cpuos_if_ejecting_invalid_cpu(uint32_t idx) "invalid cpu
> > > idx[0x%"PRIx32"]"
> > > > +acpi_cpuos_if_ejecting_cpu(uint32_t idx) "cpu idx[0x%"PRIx32"]"
> > > > +acpi_cpuos_if_write_ost_ev(uint32_t idx, uint32_t ev) "cpu
> > > > +idx[0x%"PRIx32"] OST Event: 0x%"PRIx32
> > > > +acpi_cpuos_if_write_ost_status(uint32_t idx, uint32_t st) "cpu
> > > > +idx[0x%"PRIx32"] OST Status: 0x%"PRIx32
> > > > +
> > > >  # pcihp.c
> > > >  acpi_pci_eject_slot(unsigned bsel, unsigned slot) "bsel: %u slot:
> %u"
> > > >  acpi_pci_unplug(int bsel, int slot) "bsel: %d slot: %d"
> > > > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig index
> > > > 2aa4b5d778..c9991e00c7 100644
> > > > --- a/hw/arm/Kconfig
> > > > +++ b/hw/arm/Kconfig
> > > > @@ -39,6 +39,7 @@ config ARM_VIRT
> > > >      select VIRTIO_MEM_SUPPORTED
> > > >      select ACPI_CXL
> > > >      select ACPI_HMAT
> > > > +    select ACPI_CPU_OSPM_INTERFACE
> > > >
> > > >  config CUBIEBOARD
> > > >      bool
> > > > diff --git a/include/hw/acpi/cpu_ospm_interface.h
> > > > b/include/hw/acpi/cpu_ospm_interface.h
> > > > new file mode 100644
> > > > index 0000000000..5dda327a34
> > > > --- /dev/null
> > > > +++ b/include/hw/acpi/cpu_ospm_interface.h
> > > > @@ -0,0 +1,78 @@
> > > > +/*
> > > > + * ACPI CPU OSPM Interface Handling.
> > > > + *
> > > > + * Copyright (c) 2025 Huawei Technologies R&D (UK) Ltd.
> > > > + *
> > > > + * Author: Salil Mehta <salil.mehta@huawei.com>
> > > > + *
> > > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > > + *
> > > > + * This program is free software; you can redistribute it and/or
> > > > +modify
> > > > + * it under the terms of the GNU General Public License as publish=
ed
> > > > +by
> > > > + * the ree Software Foundation; either version 2 of the License, o=
r
> > > > + * (at your option) any later version.
> > > > + */
> > > > +#ifndef CPU_OSPM_INTERFACE_H
> > > > +#define CPU_OSPM_INTERFACE_H
> > > > +
> > > > +#include "qapi/qapi-types-acpi.h"
> > > > +#include "hw/qdev-core.h"
> > > > +#include "hw/acpi/acpi.h"
> > > > +#include "hw/acpi/aml-build.h"
> > > > +#include "hw/boards.h"
> > > > +
> > > > +/**
> > > > + * Total size (in bytes) of the ACPI CPU OSPM Interface MMIO regio=
n.
> > > > + *
> > > > + * This region contains control and status fields such as CPU
> > > > +selector,
> > > > + * flags, command register, and data register. It must exactly mat=
ch
> > > > +the
> > > > + * layout defined in the AML code and the memory region
> > > implementation.
> > > > + *
> > > > + * Any mismatch between this definition and the AML layout may
> result
> > > > +in
> > > > + * runtime errors or build-time assertion failures (e.g.,
> > > > +_Static_assert),
> > > > + * breaking correct device emulation and guest OS coordination.
> > > > + */
> > > > +#define ACPI_CPU_OSPM_IF_REG_LEN 16
> > > > +
> > > > +typedef struct  {
> > > > +    CPUState *cpu;
> > > > +    uint64_t arch_id;
> > > > +    bool devchk_pending; /* device-check pending */
> > > > +    bool ejrqst_pending; /* eject-request pending */
> > > > +    uint32_t ost_event;
> > > > +    uint32_t ost_status;
> > > > +} AcpiCpuOspmStateStatus;
> > > > +
> > > > +typedef struct AcpiCpuOspmState {
> > > > +    DeviceState *acpi_dev;
> > > > +    MemoryRegion ctrl_reg;
> > > > +    uint32_t selector;
> > > > +    uint8_t command;
> > > > +    uint32_t dev_count;
> > > > +    AcpiCpuOspmStateStatus *devs;
> > > > +} AcpiCpuOspmState;
> > > > +
> > > > +void acpi_cpu_device_check_cb(AcpiCpuOspmState *cpu_st,
> DeviceState
> > > *dev,
> > > > +                              uint32_t event_st, Error **errp);
> > > > +
> > > > +void acpi_cpu_eject_request_cb(AcpiCpuOspmState *cpu_st,
> > > DeviceState *dev,
> > > > +                               uint32_t event_st, Error **errp);
> > > > +
> > > > +void acpi_cpu_eject_cb(AcpiCpuOspmState *cpu_st, DeviceState *dev,
> > > > +                       Error **errp);
> > > > +
> > > > +void acpi_cpu_ospm_state_interface_init(MemoryRegion *as, Object
> > > *owner,
> > > > +                                        AcpiCpuOspmState *state,
> > > > +                                        hwaddr base_addr);
> > > > +
> > > > +void acpi_build_cpus_aml(Aml *table, hwaddr base_addr, const char
> > > *root,
> > > > +                         const char *event_handler_method);
> > > > +
> > > > +void acpi_cpus_ospm_status(AcpiCpuOspmState *cpu_st,
> > > > +                           ACPIOSTInfoList ***list);
> > > > +
> > > > +extern const VMStateDescription vmstate_cpu_ospm_state; #define
> > > > +VMSTATE_CPU_OSPM_STATE(cpuospm, state) \
> > > > +    VMSTATE_STRUCT(cpuospm, state, 1, \
> > > > +                   vmstate_cpu_ospm_state, AcpiCpuOspmState) #endi=
f
> > > > +/* CPU_OSPM_INTERFACE_H */
> > >
> >
>
>

--000000000000a2edba0640c51ea5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div>Hi Igor,</div><div><br></div><div>On Tue, Oct 7, 2025 at 12:=
06=E2=80=AFPM Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com">imam=
medo@redhat.com</a>&gt; wrote:</div><div class=3D"gmail_quote gmail_quote_c=
ontainer"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, 7 Oct 2=
025 11:15:47 +0000<br>
Salil Mehta &lt;<a href=3D"mailto:salil.mehta@huawei.com" target=3D"_blank"=
>salil.mehta@huawei.com</a>&gt; wrote:<br>
<br>
&gt; Hi Igor,<br>
&gt; <br>
&gt; Thanks for the reviews and sorry for the late reply. Please find my re=
plies inline.<br>
&gt; <br>
&gt; <br>
&gt; &gt; From: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com" ta=
rget=3D"_blank">imammedo@redhat.com</a>&gt;<br>
&gt; &gt; Sent: Friday, October 3, 2025 3:58 PM<br>
&gt; &gt; <br>
&gt; &gt; On Wed,=C2=A0 1 Oct 2025 01:01:17 +0000<br>
&gt; &gt; <a href=3D"mailto:salil.mehta@opnsrc.net" target=3D"_blank">salil=
.mehta@opnsrc.net</a> wrote:<br>
&gt; &gt;=C2=A0 =C2=A0<br>
&gt; &gt; &gt; From: Salil Mehta &lt;<a href=3D"mailto:salil.mehta@huawei.c=
om" target=3D"_blank">salil.mehta@huawei.com</a>&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The existing ACPI CPU hotplug interface is built for x86 pla=
tforms<br>
&gt; &gt; &gt; where CPUs can be inserted or removed and resources are allo=
cated<br>
&gt; &gt; &gt; dynamically. On ARM, CPUs are never hotpluggable: resources =
are<br>
&gt; &gt; &gt; allocated at boot and QOM vCPU objects always exist. Instead=
, CPUs are<br>
&gt; &gt; &gt; administratively managed by toggling ACPI _STA to enable or =
disable<br>
&gt; &gt; &gt; them, which gives a hotplug-like effect but does not match t=
he x86 model.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Reusing the x86 hotplug AML code would complicate maintenanc=
e since<br>
&gt; &gt; &gt; much of its logic relies on toggling the _STA.Present bit to=
 notify<br>
&gt; &gt; &gt; OSPM about CPU insertion or removal. Such usage is not archi=
tecturally<br>
&gt; &gt; &gt; valid on ARM, where CPUs cannot appear or disappear at runti=
me. Mixing<br>
&gt; &gt; &gt; both models in one interface would increase complexity and m=
ake the<br>
&gt; &gt; &gt; AML harder to extend. A separate path is therefore required.=
 The new<br>
&gt; &gt; &gt; design is heavily inspired by the CPU hotplug interface but =
avoids its=C2=A0 <br>
&gt; &gt; unsuitable semantics.<br>
&gt; &gt; <br>
&gt; &gt; Let me ask how much existing CPUHP AML code will become, if you r=
euse it<br>
&gt; &gt; and add handling of &#39;enabled&#39; bit there?<br>
&gt; &gt; <br>
&gt; &gt; Would it be the same 700LOC as in this patch, which is basically =
duplication of<br>
&gt; &gt; existing CPUHP ACPI interface?=C2=A0 <br>
&gt; <br>
&gt; <br>
&gt; It is by design as we have adopted non-hotplug approach now and closel=
y aligned<br>
&gt; ourselves with what PSCI standard perceives to be the definition of CP=
U hotplug on ARM<br>
&gt; platforms - at least, as of today! And it is *NOT* what &#39;CPU hotpl=
ug&#39; means on x86 platform. <br>
<br>
There is no argument that they are different but,<br>
Could you point to PSCI specific parts in this patch?<br></blockquote><div>=
<br></div><div>Yes, sure.</div><div><br></div><div><a href=3D"https://lore.=
kernel.org/qemu-devel/20251001010127.3092631-1-salil.mehta@opnsrc.net/T/#m9=
26978ce8b91a1f2cca88b5b579a8aedd9e62d2c">https://lore.kernel.org/qemu-devel=
/20251001010127.3092631-1-salil.mehta@opnsrc.net/T/#m926978ce8b91a1f2cca88b=
5b579a8aedd9e62d2c</a></div><div><a href=3D"https://lore.kernel.org/qemu-de=
vel/20251001010127.3092631-1-salil.mehta@opnsrc.net/T/#mb96b36ebf68b0455b65=
7ce495cac2aee9fbf0f67">https://lore.kernel.org/qemu-devel/20251001010127.30=
92631-1-salil.mehta@opnsrc.net/T/#mb96b36ebf68b0455b657ce495cac2aee9fbf0f67=
</a></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
<br>
&gt; In crux, this means,<br>
&gt; 1. Dropping any hotplug/unplug infrastructure and its related parapher=
nalia from the<br>
&gt;=C2=A0 =C2=A0 =C2=A0ARM implementation till the time the meaning of phy=
sical CPU hotplug is not clear as<br>
&gt;=C2=A0 =C2=A0 =C2=A0per the specification. We do not want to model in Q=
emu something which does not<br>
&gt;=C2=A0 =C2=A0 =C2=A0exist or defined, especially for the CPU hotplug ca=
se.<br>
<br>
there is &#39;opts&#39; config struct that lets user to opt in/out from spe=
cific AML<br>
being generated. You could use that to disable some hotplug only bits of AM=
L.<br>
Other bits that are more generic/reusable, just refactor/rename them to a m=
ore<br>
generic names.<br></blockquote><div><br></div><div>Sure, but what you are s=
uggesting is a code reuse strategy not a design problem.</div><div>We can t=
ake this as a cleanup activity later on or even in parallel. I&#39;ve no re=
servations</div><div>about that. Why hold ARM patches hostage to these beni=
gn optimizations?</div><div><br></div><div>BTW, that &#39;opt&#39; is one o=
f the ugliest parts of this function. Why do other architectures</div><div>=
have to worry about initializing legacy bits of x86 in the common code befo=
re calling</div><div>AML function?</div><div><br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
&gt; 2. This also means *NOT* enabling the=C2=A0 ACPI_CPU_HOTPLUG compilati=
on switch to <br>
&gt;=C2=A0 =C2=A0 =C2=A0 preserve the sanctity of the clean design.<br>
<br>
that&#39;s semantics, I&#39;d suggest renaming that to ACPI_CPU.<br></block=
quote><div><br></div><div><br></div><div>It is not about this. To make it h=
otplug agnostic we would need to start with new minimal</div><div>code and =
then add on top of it what is present in acpi/cpu.c incrementally. This can=
 be</div><div>done in parallel by</div><div><br></div><div>1. accepting the=
 minimal new code. This will keep the ball rolling for ARM</div><div>2. add=
ing the x86 stuff incrementally over that minimal new AML file (with other =
name)</div><div>3. Testing a new file doesn&#39;t=C2=A0break x86 functional=
ity</div><div>4. replacing the old file acpi/cpus.c with a new=C2=A0common =
file.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
&gt; 3. Yes, there is a code duplicity for now but that=E2=80=99s a case of=
 further optimization and<br>
&gt;=C2=A0 =C2=A0 =C2=A0cleanup not a design issue. Some of them are:<br>
&gt;=C2=A0 =C2=A0 =C2=A0(1)=C2=A0 ACPI device-check and eject-request=C2=A0=
 handling code can be extracted and<br>
&gt;=C2=A0 =C2=A0 =C2=A0made generic for all devices not just for CPUs.<br>
<br>
make it more generic in acpi/cpu.c, instead of copying.<br>
I don&#39;t have any objections to refactoring existing code if it makes se=
nse and<br>
we can share the code.<br></blockquote><div><br></div><div>In principle I a=
gree with your point about carving a common code that works for all.</div><=
div>I&#39;m only requesting how this could be done in a non-disrupting way =
by not holding</div><div>the current patches of ARM for this change. This c=
hange will require time and most</div><div>importantly=C2=A0testing across =
many architectures.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0(2)=C2=A0 Right now, acpi/cpu.c is assuming that re=
sources and templates should be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 same for all the CPUs using CPUs AML described in =
it. There is no need for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 such a restriction. Every platform should be free =
to choose the way it wants to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 manage the resources and the interpretation of the=
 fields inside it.<br>
<br>
be more specific why you&#39;d need different resources/MMIO layout for thi=
s series?<br></blockquote><div><br></div><div>IIRC in RFC V5, you object to=
 adding &#39;enabled&#39; bit as it was breaking x86 ABI</div><div>because =
of some backward compatibility issue?</div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
<br>
The thing is if we copied every time when we needed something that&#39;s a =
bit different,<br>
we would end up with unsupportable/bloated QEMU.<br></blockquote><div><br><=
/div><div>For sure. I totally agree with it but it was an informed decision=
 here internally to keep</div><div>the ACPI part separate for this series b=
ecause of the past review comments and the</div><div>difficulty in dealing =
with very minimalistic=C2=A0changes we proposed for ACPI part.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0(3) Call backs used with GED=C2=A0 makes an assumpt=
ion of HOTPLUG interface etc.<br>
&gt;=C2=A0 =C2=A0 =C2=A0(4) In fact, the prototype of the GED event handler=
 makes a similar mistake of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 assuming that GED is only meant for devices suppor=
ting hotplug when this is not<br>
&gt;=C2=A0 =C2=A0 =C2=A0 the case even as per the ACPI specification.<br>
please be more specific and point to problematic code.<br></blockquote><div=
><br></div><div><div>void build_ged_aml(Aml *table, const char *name, Hotpl=
ugHandler *hotplug_dev,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t ged_irq, AmlRegionSpace rs, hwaddr ged=
_base)</div></div><div><br></div><div><br></div><div>GED is not just for ho=
tplug handling.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
current acpi/cpu.c might be compiled under ACPI_CPU_HOTPLUG knob but it&#39=
;s not really<br>
limited to hotplug, the reason for being compiled as such is that hotplug w=
as<br>
the sole reason for building CPUs AML at all.<br></blockquote><div><br></di=
v><div>Got it. so as you rightly suggested it needs refactoring. The only r=
equest I&#39;m making is</div><div>let us do it parallely and incrementally=
 without holding ARM patches for this change.</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
<br>
What I see in the patch is simplifying current code somewhat by dropping<br=
>
some hotplug related bits and a bunch of renaming.<br>
Otherwise it&#39;s pretty much duplicating current acpi/cpu.c.<br>
<br>
Beside that simplification, I don&#39;t see any reason why duplicating such=
 amount is good idea.<br>
Consider making exiting acpi/cpu.c more generic instead.<br></blockquote><d=
iv><br></div><div>Intial idea was to make it generic enough for any device =
which uses device-check</div><div>and eject-request=C2=A0 for adding/removi=
ng the device but we left it for later discussions.=C2=A0</div><div><br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; RFC V5 was an attempt to implement this feature using the hotplug infr=
astructure<br>
&gt; and this RFC V6 is a deviation from previous approach towards non-hotp=
lug. We do<br>
&gt; not want a hotchpotch approach because that=E2=80=99s a recipe for fut=
ure disaster.<br>
&gt; <br>
&gt; <br>
&gt; Many Thanks!<br>
&gt; Salil.<br>
&gt; <br>
&gt; <br>
&gt; &gt;=C2=A0 =C2=A0<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; This patch adds a dedicated CPU OSPM (Operating System Power=
<br>
&gt; &gt; &gt; Management) interface. It provides a memory-mapped control r=
egion with<br>
&gt; &gt; &gt; selector, flags, command, and data fields, and AML methods f=
or<br>
&gt; &gt; &gt; device-check, eject request, and _OST reporting. OSPM is not=
ified<br>
&gt; &gt; &gt; through GED events and can coordinate CPU events directly wi=
th QEMU.<br>
&gt; &gt; &gt; Other ARM-like architectures may also use this interface.<br=
>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Salil Mehta &lt;<a href=3D"mailto:salil.mehta=
@huawei.com" target=3D"_blank">salil.mehta@huawei.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 hw/acpi/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
&gt; &gt; &gt;=C2=A0 hw/acpi/acpi-cpu-ospm-interface-stub.c |=C2=A0 41 ++<b=
r>
&gt; &gt; &gt;=C2=A0 hw/acpi/cpu_ospm_interface.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 747=C2=A0 <br>
&gt; &gt; +++++++++++++++++++++++++=C2=A0 <br>
&gt; &gt; &gt;=C2=A0 hw/acpi/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
&gt; &gt; &gt;=C2=A0 hw/acpi/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 17 +<br>
&gt; &gt; &gt;=C2=A0 hw/arm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt; &gt; &gt;=C2=A0 include/hw/acpi/cpu_ospm_interface.h=C2=A0 =C2=A0|=C2=
=A0 78 +++<br>
&gt; &gt; &gt;=C2=A0 7 files changed, 889 insertions(+)<br>
&gt; &gt; &gt;=C2=A0 create mode 100644 hw/acpi/acpi-cpu-ospm-interface-stu=
b.c<br>
&gt; &gt; &gt;=C2=A0 create mode 100644 hw/acpi/cpu_ospm_interface.c=C2=A0 =
create mode 100644<br>
&gt; &gt; &gt; include/hw/acpi/cpu_ospm_interface.h<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig index<br>
&gt; &gt; &gt; 1d4e9f0845..aa52f0468f 100644<br>
&gt; &gt; &gt; --- a/hw/acpi/Kconfig<br>
&gt; &gt; &gt; +++ b/hw/acpi/Kconfig<br>
&gt; &gt; &gt; @@ -21,6 +21,9 @@ config ACPI_ICH9<br>
&gt; &gt; &gt;=C2=A0 config ACPI_CPU_HOTPLUG<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 bool<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +config ACPI_CPU_OSPM_INTERFACE<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 bool<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 config ACPI_MEMORY_HOTPLUG<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 bool<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 select MEM_DEVICE<br>
&gt; &gt; &gt; diff --git a/hw/acpi/acpi-cpu-ospm-interface-stub.c<br>
&gt; &gt; &gt; b/hw/acpi/acpi-cpu-ospm-interface-stub.c<br>
&gt; &gt; &gt; new file mode 100644<br>
&gt; &gt; &gt; index 0000000000..f6f333f641<br>
&gt; &gt; &gt; --- /dev/null<br>
&gt; &gt; &gt; +++ b/hw/acpi/acpi-cpu-ospm-interface-stub.c<br>
&gt; &gt; &gt; @@ -0,0 +1,41 @@<br>
&gt; &gt; &gt; +/*<br>
&gt; &gt; &gt; + * ACPI CPU OSPM Interface Handling.<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * Copyright (c) 2025 Huawei Technologies R&amp;D (UK) Ltd.=
<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * Author: Salil Mehta &lt;<a href=3D"mailto:salil.mehta@hu=
awei.com" target=3D"_blank">salil.mehta@huawei.com</a>&gt;<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * This program is free software; you can redistribute it a=
nd/or<br>
&gt; &gt; &gt; +modify<br>
&gt; &gt; &gt; + * it under the terms of the GNU General Public License as =
published<br>
&gt; &gt; &gt; +by<br>
&gt; &gt; &gt; + * the Free Software Foundation; either version 2 of the Li=
cense, or<br>
&gt; &gt; &gt; + * (at your option) any later version.<br>
&gt; &gt; &gt; + */<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; &gt; &gt; +#include &quot;hw/acpi/cpu_ospm_interface.h&quot;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +void acpi_cpu_device_check_cb(AcpiCpuOspmState *cpu_st, Dev=
iceState=C2=A0 <br>
&gt; &gt; *dev,=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t event_st, Error **er=
rp) { }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +void acpi_cpu_eject_request_cb(AcpiCpuOspmState *cpu_st,=C2=
=A0 <br>
&gt; &gt; DeviceState *dev,=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t event_st, Erro=
r **errp) { }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +void acpi_cpu_eject_cb(AcpiCpuOspmState *cpu_st, DeviceStat=
e *dev,<br>
&gt; &gt; &gt; +Error **errp) { }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +void acpi_cpu_ospm_state_interface_init(MemoryRegion *as, O=
bject=C2=A0 <br>
&gt; &gt; *owner,=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 AcpiCpuOspmState *state,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 hwaddr base_addr) { }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +void acpi_cpus_ospm_status(AcpiCpuOspmState *cpu_st,=C2=A0 =
<br>
&gt; &gt; ACPIOSTInfoList=C2=A0 <br>
&gt; &gt; &gt; +***list) { }<br>
&gt; &gt; &gt; diff --git a/hw/acpi/cpu_ospm_interface.c<br>
&gt; &gt; &gt; b/hw/acpi/cpu_ospm_interface.c new file mode 100644 index<br=
>
&gt; &gt; &gt; 0000000000..61aab8a793<br>
&gt; &gt; &gt; --- /dev/null<br>
&gt; &gt; &gt; +++ b/hw/acpi/cpu_ospm_interface.c<br>
&gt; &gt; &gt; @@ -0,0 +1,747 @@<br>
&gt; &gt; &gt; +/*<br>
&gt; &gt; &gt; + * ACPI CPU OSPM Interface Handling.<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * Copyright (c) 2025 Huawei Technologies R&amp;D (UK) Ltd.=
<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * Author: Salil Mehta &lt;<a href=3D"mailto:salil.mehta@hu=
awei.com" target=3D"_blank">salil.mehta@huawei.com</a>&gt;<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * This program is free software; you can redistribute it a=
nd/or<br>
&gt; &gt; &gt; +modify<br>
&gt; &gt; &gt; + * it under the terms of the GNU General Public License as =
published<br>
&gt; &gt; &gt; +by<br>
&gt; &gt; &gt; + * the Free Software Foundation; either version 2 of the Li=
cense, or<br>
&gt; &gt; &gt; + * (at your option) any later version.<br>
&gt; &gt; &gt; + */<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; &gt; &gt; +#include &quot;migration/vmstate.h&quot;<br>
&gt; &gt; &gt; +#include &quot;hw/core/cpu.h&quot;<br>
&gt; &gt; &gt; +#include &quot;qapi/error.h&quot;<br>
&gt; &gt; &gt; +#include &quot;trace.h&quot;<br>
&gt; &gt; &gt; +#include &quot;qapi/qapi-events-acpi.h&quot;<br>
&gt; &gt; &gt; +#include &quot;hw/acpi/cpu_ospm_interface.h&quot;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +/* CPU identifier and resource device */<br>
&gt; &gt; &gt; +#define CPU_NAME_FMT=C2=A0 =C2=A0 =C2=A0 &quot;C%.03X&quot;=
 /* CPU name format (e.g., C001)=C2=A0 <br>
&gt; &gt; */=C2=A0 <br>
&gt; &gt; &gt; +#define CPU_RES_DEVICE=C2=A0 =C2=A0 &quot;CPUR&quot; /* CPU=
 resource device name */<br>
&gt; &gt; &gt; +#define CPU_DEVICE=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;CPUS&qu=
ot; /* CPUs device name */<br>
&gt; &gt; &gt; +#define CPU_LOCK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;CP=
LK&quot; /* CPU lock object */<br>
&gt; &gt; &gt; +/* ACPI method(_STA, _EJ0, etc.) handlers */<br>
&gt; &gt; &gt; +#define CPU_STS_METHOD=C2=A0 =C2=A0 &quot;CSTA&quot; /* CPU=
 status method=C2=A0 <br>
&gt; &gt; (_STA.Enabled) */=C2=A0 <br>
&gt; &gt; &gt; +#define CPU_SCAN_METHOD=C2=A0 =C2=A0&quot;CSCN&quot; /* CPU=
 scan method for=C2=A0 <br>
&gt; &gt; enumeration */=C2=A0 <br>
&gt; &gt; &gt; +#define CPU_NOTIFY_METHOD &quot;CTFY&quot; /* Notify method=
 for CPU events=C2=A0 <br>
&gt; &gt; */=C2=A0 <br>
&gt; &gt; &gt; +#define CPU_EJECT_METHOD=C2=A0 &quot;CEJ0&quot; /* CPU ejec=
t method (_EJ0) */<br>
&gt; &gt; &gt; +#define CPU_OST_METHOD=C2=A0 =C2=A0 &quot;COST&quot; /* OSP=
M status reporting (_OST) */<br>
&gt; &gt; &gt; +/* CPU MMIO region fields (in PRST region) */<br>
&gt; &gt; &gt; +#define CPU_SELECTOR=C2=A0 =C2=A0 =C2=A0 &quot;CSEL&quot; /=
* CPU selector index (WO) */<br>
&gt; &gt; &gt; +#define CPU_ENABLED_F=C2=A0 =C2=A0 =C2=A0&quot;CPEN&quot; /=
* Flag: CPU enabled status(_STA)=C2=A0 <br>
&gt; &gt; (RO) */=C2=A0 <br>
&gt; &gt; &gt; +#define CPU_DEVCHK_F=C2=A0 =C2=A0 =C2=A0 &quot;CDCK&quot; /=
* Flag: Device-check event (RW) */<br>
&gt; &gt; &gt; +#define CPU_EJECTRQ_F=C2=A0 =C2=A0 =C2=A0&quot;CEJR&quot; /=
* Flag: Eject-request event (RW)*/<br>
&gt; &gt; &gt; +#define CPU_EJECT_F=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;CEJ0&qu=
ot; /* Flag: Ejection trigger (WO) */<br>
&gt; &gt; &gt; +#define CPU_COMMAND=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;CCMD&qu=
ot; /* Command register (RW) */<br>
&gt; &gt; &gt; +#define CPU_DATA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;CD=
AT&quot; /* Data register (RW) */<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; + /*<br>
&gt; &gt; &gt; + * CPU OSPM Interface MMIO Layout (Total: 16 bytes)<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + +--------+--------+--------+--------+--------+--------+---=
-----+----<br>
&gt; &gt; &gt; + ----+<br>
&gt; &gt; &gt; + * |=C2=A0 0x00=C2=A0 |=C2=A0 0x01=C2=A0 |=C2=A0 0x02=C2=A0=
 |=C2=A0 0x03=C2=A0 |=C2=A0 0x04=C2=A0 |=C2=A0 0x05=C2=A0 |=C2=A0 0x06=C2=
=A0 |<br>
&gt; &gt; &gt; + 0x07=C2=A0 |<br>
&gt; &gt; &gt; + * +--------+--------+--------+--------+--------+--------+-=
-------+--------+<br>
&gt; &gt; &gt; + * |=C2=A0 =C2=A0 =C2=A0 =C2=A0Selector (DWord, write-only)=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| Flags=C2=A0 |Command |Reserved|<br>
&gt; &gt; &gt; + * |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | (RO/RW)|=C2=A0 (WO)=C2=A0 |(2B pad)|<br>
&gt; &gt; &gt; + * |=C2=A0 =C2=A0 =C2=A0 =C2=A0 4 bytes (32 bits)=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1B=C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A01B=C2=A0 =C2=A0| 2B=C2=A0 =C2=A0 =C2=A0|<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + +---------------------------------------------------------=
----------<br>
&gt; &gt; &gt; + ----+<br>
&gt; &gt; &gt; + * |=C2=A0 0x08=C2=A0 |=C2=A0 0x09=C2=A0 |=C2=A0 0x0A=C2=A0=
 |=C2=A0 0x0B=C2=A0 |=C2=A0 0x0C=C2=A0 |=C2=A0 0x0D=C2=A0 |=C2=A0 0x0E=C2=
=A0 |<br>
&gt; &gt; &gt; + 0x0F=C2=A0 |<br>
&gt; &gt; &gt; + * +--------+--------+--------+--------+--------+--------+-=
-------+--------+<br>
&gt; &gt; &gt; + * |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Data (QWord, read/write)=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt; &gt; &gt; + * |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
Used by CPU scan and _OST methods (64 bits)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + +---------------------------------------------------------=
----------<br>
&gt; &gt; &gt; + ----+<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * Field Overview:<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * - Selector: 4 bytes @0x00 (DWord, WO)<br>
&gt; &gt; &gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- =
Selects target CPU index for the current operation.<br>
&gt; &gt; &gt; + * - Flags:=C2=A0 =C2=A0 1 byte=C2=A0 @0x04 (RO/RW)<br>
&gt; &gt; &gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- =
Bit 0: ENABLED=C2=A0 =E2=80=93 CPU is powered on (RO)<br>
&gt; &gt; &gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- =
Bit 1: DEVCHK=C2=A0 =C2=A0=E2=80=93 Device-check completed (RW)<br>
&gt; &gt; &gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- =
Bit 2: EJECTRQ=C2=A0 =E2=80=93 Guest requests CPU eject (RW)<br>
&gt; &gt; &gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- =
Bit 3: EJECT=C2=A0 =C2=A0 =E2=80=93 Trigger CPU ejection (WO)<br>
&gt; &gt; &gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- =
Bits 4=E2=80=937: Reserved (write 0)<br>
&gt; &gt; &gt; + * - Command:=C2=A0 1 byte=C2=A0 @0x05 (WO)<br>
&gt; &gt; &gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- =
Specifies control operation (e.g., scan, _OST, eject).<br>
&gt; &gt; &gt; + * - Reserved: 2 bytes @0x06=E2=80=930x07<br>
&gt; &gt; &gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- =
Alignment padding; must be zero on write.<br>
&gt; &gt; &gt; + * - Data:=C2=A0 =C2=A0 =C2=A08 bytes @0x08 (QWord, RW)<br>
&gt; &gt; &gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- =
Input/output for command-specific data.<br>
&gt; &gt; &gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- =
Used by CPU scan or _OST.<br>
&gt; &gt; &gt; + */<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +/*<br>
&gt; &gt; &gt; + * Macros defining the CPU MMIO region layout. Change field=
 sizes<br>
&gt; &gt; &gt; +here to<br>
&gt; &gt; &gt; + * alter the overall MMIO region size.<br>
&gt; &gt; &gt; + */<br>
&gt; &gt; &gt; +/* Sub-Field sizes (in bytes) */<br>
&gt; &gt; &gt; +#define ACPI_CPU_MR_SELECTOR_SIZE=C2=A0 4 /* Write-only (DW=
ord access)=C2=A0 <br>
&gt; &gt; */=C2=A0 <br>
&gt; &gt; &gt; +#define ACPI_CPU_MR_FLAGS_SIZE=C2=A0 =C2=A0 =C2=A01 /* Read=
-write (Byte access) */<br>
&gt; &gt; &gt; +#define ACPI_CPU_MR_RES_FLAGS_SIZE 0 /* Reserved padding */=
<br>
&gt; &gt; &gt; +#define ACPI_CPU_MR_CMD_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A01 /*=
 Write-only (Byte access) */<br>
&gt; &gt; &gt; +#define ACPI_CPU_MR_RES_CMD_SIZE=C2=A0 =C2=A02 /* Reserved =
padding */<br>
&gt; &gt; &gt; +#define ACPI_CPU_MR_CMD_DATA_SIZE=C2=A0 8 /* Read-write (QW=
ord=C2=A0 <br>
&gt; &gt; access) */=C2=A0 <br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +#define ACPI_CPU_OSPM_IF_MAX_FIELD_SIZE \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 MAX_CONST(ACPI_CPU_MR_CMD_DATA_SIZE, \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 MAX_CONST(ACPI_CPU_MR_SELECTOR_SIZE, \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 MAX_CONST(ACPI_CPU_MR_CMD_SIZE,=C2=A0 <br>
&gt; &gt; ACPI_CPU_MR_FLAGS_SIZE)))=C2=A0 <br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +/* Validate layout against exported total length */<br>
&gt; &gt; &gt; +_Static_assert(ACPI_CPU_OSPM_IF_REG_LEN =3D=3D<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(ACP=
I_CPU_MR_SELECTOR_SIZE +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ACP=
I_CPU_MR_FLAGS_SIZE +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ACP=
I_CPU_MR_RES_FLAGS_SIZE +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ACP=
I_CPU_MR_CMD_SIZE +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ACP=
I_CPU_MR_RES_CMD_SIZE +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ACP=
I_CPU_MR_CMD_DATA_SIZE),<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quo=
t;ACPI_CPU_OSPM_IF_REG_LEN mismatch with internal MMIO<br>
&gt; &gt; &gt; +layout&quot;);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +/* Sub-Field sizes (in bits) */<br>
&gt; &gt; &gt; +#define ACPI_CPU_MR_SELECTOR_SIZE_BITS \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 (ACPI_CPU_MR_SELECTOR_SIZE * BITS_PER_BYTE)=
=C2=A0 /* Write-only=C2=A0 <br>
&gt; &gt; (DWord=C2=A0 <br>
&gt; &gt; &gt; +Acc) */ #define ACPI_CPU_MR_FLAGS_SIZE_BITS \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 (ACPI_CPU_MR_FLAGS_SIZE * BITS_PER_BYTE)=C2=
=A0 =C2=A0 =C2=A0/* Read-write (Byte=C2=A0 <br>
&gt; &gt; Acc) */=C2=A0 <br>
&gt; &gt; &gt; +#define ACPI_CPU_MR_RES_FLAGS_SIZE_BITS \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 (ACPI_CPU_MR_RES_FLAGS_SIZE * BITS_PER_BYTE) =
/* Reserved=C2=A0 <br>
&gt; &gt; padding=C2=A0 <br>
&gt; &gt; &gt; +*/ #define ACPI_CPU_MR_CMD_SIZE_BITS \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 (ACPI_CPU_MR_CMD_SIZE * BITS_PER_BYTE)=C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* Write-only (Byte=C2=A0 <br>
&gt; &gt; Acc) */=C2=A0 <br>
&gt; &gt; &gt; +#define ACPI_CPU_MR_RES_CMD_SIZE_BITS \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 (ACPI_CPU_MR_RES_CMD_SIZE * BITS_PER_BYTE)=C2=
=A0 =C2=A0/* Reserved=C2=A0 <br>
&gt; &gt; padding */=C2=A0 <br>
&gt; &gt; &gt; +#define ACPI_CPU_MR_CMD_DATA_SIZE_BITS \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 (ACPI_CPU_MR_CMD_DATA_SIZE * BITS_PER_BYTE)=
=C2=A0 /* Read-write=C2=A0 <br>
&gt; &gt; (QWord=C2=A0 <br>
&gt; &gt; &gt; +Acc) */<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +/* Field offsets (in bytes) */<br>
&gt; &gt; &gt; +#define ACPI_CPU_MR_SELECTOR_OFFSET_WO=C2=A0 0 #define<br>
&gt; &gt; &gt; +ACPI_CPU_MR_FLAGS_OFFSET_RW \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 (ACPI_CPU_MR_SELECTOR_OFFSET_WO + \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0ACPI_CPU_MR_SELECTOR_SIZE)<br>
&gt; &gt; &gt; +#define ACPI_CPU_MR_CMD_OFFSET_WO \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 (ACPI_CPU_MR_FLAGS_OFFSET_RW + \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0ACPI_CPU_MR_FLAGS_SIZE + \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0ACPI_CPU_MR_RES_FLAGS_SIZE)<br>
&gt; &gt; &gt; +#define ACPI_CPU_MR_CMD_DATA_OFFSET_RW \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 (ACPI_CPU_MR_CMD_OFFSET_WO + \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0ACPI_CPU_MR_CMD_SIZE + \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0ACPI_CPU_MR_RES_CMD_SIZE)<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +/* ensure all offsets are at their natural size alignment b=
oundaries */<br>
&gt; &gt; &gt; +#define STATIC_ASSERT_FIELD_ALIGNMENT(offset, type, field_n=
ame)=C2=A0 <br>
&gt; &gt; \=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 _Static_assert((offset) % sizeof(type) =3D=3D=
 0,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0field_name &quot; is not aligned to its natural<br>
&gt; &gt; &gt; +boundary&quot;)<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 <br>
&gt; &gt; +STATIC_ASSERT_FIELD_ALIGNMENT(ACPI_CPU_MR_SELECTOR_OFFSET_W<br>
&gt; &gt; O,=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t, &quot;Selector&quot=
;);<br>
&gt; &gt; &gt; +STATIC_ASSERT_FIELD_ALIGNMENT(ACPI_CPU_MR_FLAGS_OFFSET_RW,<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t, &quot;Flags&quot;);<=
br>
&gt; &gt; &gt; +STATIC_ASSERT_FIELD_ALIGNMENT(ACPI_CPU_MR_CMD_OFFSET_WO,<br=
>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t, &quot;Command&quot;)=
;<br>
&gt; &gt; &gt;=C2=A0 <br>
&gt; &gt; +STATIC_ASSERT_FIELD_ALIGNMENT(ACPI_CPU_MR_CMD_DATA_OFFSET_<br>
&gt; &gt; RW,=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t, &quot;Command Data&=
quot;);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +/* Flag bit positions (used within &#39;flags&#39; subfield=
) */ #define<br>
&gt; &gt; &gt; +ACPI_CPU_FLAGS_USED_BITS 4 #define=C2=A0 <br>
&gt; &gt; ACPI_CPU_MR_FLAGS_BIT_ENABLED=C2=A0 <br>
&gt; &gt; &gt; +BIT(0) #define ACPI_CPU_MR_FLAGS_BIT_DEVCHK=C2=A0 BIT(1) #d=
efine<br>
&gt; &gt; &gt; +ACPI_CPU_MR_FLAGS_BIT_EJECTRQ BIT(2)<br>
&gt; &gt; &gt; +#define ACPI_CPU_MR_FLAGS_BIT_EJECT=C2=A0 <br>
&gt; &gt; BIT(ACPI_CPU_FLAGS_USED_BITS - 1)=C2=A0 <br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +#define ACPI_CPU_MR_RES_FLAG_BITS (BITS_PER_BYTE -<br>
&gt; &gt; &gt; +ACPI_CPU_FLAGS_USED_BITS)<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +enum {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 ACPI_GET_NEXT_CPU_WITH_EVENT_CMD =3D 0,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 ACPI_OST_EVENT_CMD =3D 1,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 ACPI_OST_STATUS_CMD =3D 2,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 ACPI_CMD_MAX<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +#define AML_APPEND_MR_RESVD_FIELD(mr_field, size_bits)=C2=
=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 do {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((size_bits) !=3D 0) {=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append((mr_fi=
eld), aml_reserved_field(size_bits)); \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 } while (0)<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +#define AML_APPEND_MR_NAMED_FIELD(mr_field, name, size_bits=
)=C2=A0 =C2=A0 \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 do {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((size_bits) !=3D 0) {=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append((mr_fi=
eld), aml_named_field((name), (size_bits))); \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 } while (0)<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +#define AML_CPU_RES_DEV(base, field) \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_name(&quot;%s.%s.%s&quot;, =
(base), CPU_RES_DEVICE, (field))<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static ACPIOSTInfo *<br>
&gt; &gt; &gt; +acpi_cpu_ospm_ost_status(int idx, AcpiCpuOspmStateStatus *c=
dev) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 ACPIOSTInfo *info =3D g_new0(ACPIOSTInfo, 1);=
<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 info-&gt;source =3D cdev-&gt;ost_event;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 info-&gt;status =3D cdev-&gt;ost_status;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (cdev-&gt;cpu) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 DeviceState *dev =3D DEVICE(cde=
v-&gt;cpu);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev-&gt;id) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;device =
=3D g_strdup(dev-&gt;id);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 return info;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +void acpi_cpus_ospm_status(AcpiCpuOspmState *cpu_st,=C2=A0 =
<br>
&gt; &gt; ACPIOSTInfoList=C2=A0 <br>
&gt; &gt; &gt; +***list) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 ACPIOSTInfoList ***tail =3D list;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 int i;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; cpu_st-&gt;dev_count; i+=
+) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(*tail, acpi_cp=
u_ospm_ost_status(i, &amp;cpu_st-<br>
&gt; &gt; &gt;devs[i]));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static uint64_t<br>
&gt; &gt; &gt; +acpi_cpu_ospm_intf_mr_read(void *opaque, hwaddr addr, unsig=
ned=C2=A0 <br>
&gt; &gt; size)=C2=A0 <br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 AcpiCpuOspmState *cpu_st =3D opaque;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 AcpiCpuOspmStateStatus *cdev;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint64_t val =3D 0;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (cpu_st-&gt;selector &gt;=3D cpu_st-&gt;de=
v_count) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return val;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 cdev =3D &amp;cpu_st-&gt;devs[cpu_st-&gt;sele=
ctor];<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 switch (addr) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 case ACPI_CPU_MR_FLAGS_OFFSET_RW:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val |=3D qdev_check_enabled(DEV=
ICE(cdev-&gt;cpu)) ?<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ACPI_CPU_MR_FLA=
GS_BIT_ENABLED : 0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val |=3D cdev-&gt;devchk_pendin=
g ? ACPI_CPU_MR_FLAGS_BIT_DEVCHK :=C2=A0 <br>
&gt; &gt; 0;=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 val |=3D cdev-&gt;ejrqst_pendin=
g ? ACPI_CPU_MR_FLAGS_BIT_EJECTRQ :=C2=A0 <br>
&gt; &gt; 0;=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_acpi_cpuos_if_read_flags(=
cpu_st-&gt;selector, val);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 case ACPI_CPU_MR_CMD_DATA_OFFSET_RW:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (cpu_st-&gt;command) {<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case ACPI_GET_NEXT_CPU_WITH_EVE=
NT_CMD:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D cpu_st-&gt=
;selector;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_acpi_cpuos_i=
f_read_invalid_cmd_data(cpu_st-&gt;selector,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_st-&gt;command);=
<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_acpi_cpuos_if_read_cmd_da=
ta(cpu_st-&gt;selector, val);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 default:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 return val;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static void<br>
&gt; &gt; &gt; +acpi_cpu_ospm_intf_mr_write(void *opaque, hwaddr addr, uint=
64_t=C2=A0 <br>
&gt; &gt; data,=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int size) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 AcpiCpuOspmState *cpu_st =3D opaque;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 AcpiCpuOspmStateStatus *cdev;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 ACPIOSTInfo *info;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 assert(cpu_st-&gt;dev_count);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (addr) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu_st-&gt;selector &gt;=3D=
 cpu_st-&gt;dev_count) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_acpi_cpuos_=
if_invalid_idx_selected(cpu_st-&gt;selector);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 switch (addr) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 case ACPI_CPU_MR_SELECTOR_OFFSET_WO: /* curre=
nt CPU selector=C2=A0 <br>
&gt; &gt; */=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_st-&gt;selector =3D data;<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_acpi_cpuos_if_write_idx(c=
pu_st-&gt;selector);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 case ACPI_CPU_MR_FLAGS_OFFSET_RW: /* set is_*=
 fields=C2=A0 */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cdev =3D &amp;cpu_st-&gt;devs[c=
pu_st-&gt;selector];<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (data &amp; ACPI_CPU_MR_FLAG=
S_BIT_DEVCHK) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* clear device-c=
heck pending event */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cdev-&gt;devchk_p=
ending =3D false;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_acpi_cpuos_=
if_clear_devchk_evt(cpu_st-&gt;selector);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (data &amp; ACPI_CPU_=
MR_FLAGS_BIT_EJECTRQ) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* clear eject-re=
quest pending event */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cdev-&gt;ejrqst_p=
ending =3D false;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_acpi_cpuos_=
if_clear_ejrqst_evt(cpu_st-&gt;selector);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (data &amp; ACPI_CPU_=
MR_FLAGS_BIT_EJECT) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DeviceState *dev =
=3D NULL;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cdev-&gt;cpu=
 || cdev-&gt;cpu =3D=3D first_cpu) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tra=
ce_acpi_cpuos_if_ejecting_invalid_cpu(cpu_st-&gt;selector);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bre=
ak;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* OSPM has =
returned with eject. Hence, it is now safe to put the<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* cpu devic=
e on powered-off state.<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_acpi_cpuos_=
if_ejecting_cpu(cpu_st-&gt;selector);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev =3D DEVICE(cd=
ev-&gt;cpu);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_sync_disable=
(dev, &amp;error_fatal);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 case ACPI_CPU_MR_CMD_OFFSET_WO:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_acpi_cpuos_if_write_cmd(c=
pu_st-&gt;selector, data);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (data &lt; ACPI_CMD_MAX) {<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_st-&gt;comman=
d =3D data;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu_st-&gt;co=
mmand =3D=3D=C2=A0 <br>
&gt; &gt; ACPI_GET_NEXT_CPU_WITH_EVENT_CMD) {=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uin=
t32_t iter =3D cpu_st-&gt;selector;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do =
{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cdev =3D &amp;cpu_st-&gt;devs[iter];<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (cdev-&gt;devchk_pending || cdev-&gt;ejrqst_pending) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 cpu_st-&gt;selector =3D iter;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 trace_acpi_cpuos_if_cpu_has_events(cpu_st-&gt;sele=
ctor,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cdev-&gt;devchk_pending, cdev-&gt;ej=
rqst_pending);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 iter =3D iter + 1 &lt; cpu_st-&gt;dev_count ? iter + 1 : 0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } w=
hile (iter !=3D cpu_st-&gt;selector);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 case ACPI_CPU_MR_CMD_DATA_OFFSET_RW:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (cpu_st-&gt;command) {<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case ACPI_OST_EVENT_CMD: {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cdev =3D &amp;cpu_=
st-&gt;devs[cpu_st-&gt;selector];<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cdev-&gt;ost_event=
 =3D data;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_acpi_cpuos_i=
f_write_ost_ev(cpu_st-&gt;selector, cdev-<br>
&gt; &gt; &gt;ost_event);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case ACPI_OST_STATUS_CMD: {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cdev =3D &amp;cpu_=
st-&gt;devs[cpu_st-&gt;selector];<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cdev-&gt;ost_statu=
s =3D data;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info =3D acpi_cpu_=
ospm_ost_status(cpu_st-&gt;selector, cdev);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qapi_event_send_ac=
pi_device_ost(info);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qapi_free_ACPIOSTI=
nfo(info);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_acpi_cpuos_i=
f_write_ost_status(cpu_st-&gt;selector,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cdev-&gt;ost_status);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_acpi_cpuos_i=
f_write_invalid_cmd(cpu_st-&gt;selector,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_st-&gt;command);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 default:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_acpi_cpuos_if_write_inval=
id_offset(cpu_st-&gt;selector, addr);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static const MemoryRegionOps cpu_common_mr_ops =3D {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 .read =3D acpi_cpu_ospm_intf_mr_read,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 .write =3D acpi_cpu_ospm_intf_mr_write,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 1,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D ACPI_CPU_O=
SPM_IF_MAX_FIELD_SIZE,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 },<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 .impl =3D {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 1,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D ACPI_CPU_O=
SPM_IF_MAX_FIELD_SIZE,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .unaligned =3D false,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 },<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +void acpi_cpu_ospm_state_interface_init(MemoryRegion *as, O=
bject=C2=A0 <br>
&gt; &gt; *owner,=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 AcpiCpuOspmState *state,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 hwaddr base_addr) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 MachineState *machine =3D MACHINE(qdev_get_ma=
chine());<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_GET_CLASS(machin=
e);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 const CPUArchIdList *id_list;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 int i;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 assert(mc-&gt;possible_cpu_arch_ids);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 id_list =3D mc-&gt;possible_cpu_arch_ids(mach=
ine);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 state-&gt;dev_count =3D id_list-&gt;len;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 state-&gt;devs =3D g_new0(typeof(*state-&gt;d=
evs), state-&gt;dev_count);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; id_list-&gt;len; i++) {<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 state-&gt;devs[i].cpu =3D=C2=A0=
 CPU(id_list-&gt;cpus[i].cpu);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 state-&gt;devs[i].arch_id =3D i=
d_list-&gt;cpus[i].arch_id;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;state-&gt;ctrl_reg=
, owner,=C2=A0 <br>
&gt; &gt; &amp;cpu_common_mr_ops, state,=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ACPI CPU OSPM State Interface Memory =
Region&quot;,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ACPI_CPU_OSPM_IF_REG_LEN);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 memory_region_add_subregion(as, base_addr, &a=
mp;state-&gt;ctrl_reg); }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static AcpiCpuOspmStateStatus *<br>
&gt; &gt; &gt; +acpi_get_cpu_status(AcpiCpuOspmState *cpu_st, DeviceState *=
dev) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 CPUClass *k =3D CPU_GET_CLASS(dev);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint64_t cpu_arch_id =3D k-&gt;get_arch_id(CP=
U(dev));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 int i;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; cpu_st-&gt;dev_count; i+=
+) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu_arch_id =3D=3D cpu_st-&=
gt;devs[i].arch_id) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &amp;cpu_s=
t-&gt;devs[i];<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 return NULL;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +void acpi_cpu_device_check_cb(AcpiCpuOspmState *cpu_st, Dev=
iceState=C2=A0 <br>
&gt; &gt; *dev,=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t event_st, Error **er=
rp) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 AcpiCpuOspmStateStatus *cdev;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 cdev =3D acpi_get_cpu_status(cpu_st, dev);<br=
>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (!cdev) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 assert(cdev-&gt;cpu);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* Tell OSPM via GED IRQ(GSI) that a pow=
ered-off cpu is being powered-=C2=A0 <br>
&gt; &gt; on.=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* Also, mark &#39;device-check&#39; eve=
nt pending for this cpu. This will<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* eventually result in OSPM evaluating =
the ACPI _EVT method and scan=C2=A0 <br>
&gt; &gt; of=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* cpus<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 cdev-&gt;devchk_pending =3D true;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 acpi_send_event(cpu_st-&gt;acpi_dev, event_st=
); }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +void acpi_cpu_eject_request_cb(AcpiCpuOspmState *cpu_st,=C2=
=A0 <br>
&gt; &gt; DeviceState *dev,=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t event_st, Error **er=
rp) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 AcpiCpuOspmStateStatus *cdev;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 cdev =3D acpi_get_cpu_status(cpu_st, dev);<br=
>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (!cdev) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 assert(cdev-&gt;cpu);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* Tell OSPM via GED IRQ(GSI) that a cpu=
 wants to power-off or go on=C2=A0 <br>
&gt; &gt; standby=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* Also,mark &#39;eject-request&#39; eve=
nt pending for this cpu. (graceful=C2=A0 <br>
&gt; &gt; shutdown)=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 cdev-&gt;ejrqst_pending =3D true;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 acpi_send_event(cpu_st-&gt;acpi_dev, event_st=
); }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +void<br>
&gt; &gt; &gt; +acpi_cpu_eject_cb(AcpiCpuOspmState *cpu_st, DeviceState *de=
v, Error<br>
&gt; &gt; &gt; +**errp) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /* TODO: possible handling here */ }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static const VMStateDescription vmstate_cpu_ospm_state_sts =
=3D {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 .name =3D &quot;CPU OSPM state status&quot;,<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 .version_id =3D 1,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 .fields =3D (const VMStateField[]) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BOOL(devchk_pending, Ac=
piCpuOspmStateStatus),<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BOOL(ejrqst_pending, Ac=
piCpuOspmStateStatus),<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(ost_event, AcpiC=
puOspmStateStatus),<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(ost_status, Acpi=
CpuOspmStateStatus),<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +const VMStateDescription vmstate_cpu_ospm_state =3D {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 .name =3D &quot;CPU OSPM state&quot;,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 .version_id =3D 1,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 .fields =3D (const VMStateField[]) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(selector, AcpiCp=
uOspmState),<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8(command, AcpiCpuO=
spmState),<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_STRUCT_VARRAY_POINTER_U=
INT32(devs,=C2=A0 <br>
&gt; &gt; AcpiCpuOspmState,=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_count,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0vmstate_cpu_ospm_state_sts,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0AcpiCpuOspmStateStatus),<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +void acpi_build_cpus_aml(Aml *table, hwaddr base_addr, cons=
t char=C2=A0 <br>
&gt; &gt; *root,=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *event_handler_method) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 MachineState *machine =3D MACHINE(qdev_get_ma=
chine());<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_GET_CLASS(machin=
e);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 const CPUArchIdList *arch_ids =3D mc-&gt;poss=
ible_cpu_arch_ids(machine);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 Aml *sb_scope =3D aml_scope(&quot;_SB&quot;);=
 /* System Bus Scope */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 Aml *ifctx, *field, *method, *cpu_res_dev, *c=
pus_dev;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 Aml *zero =3D aml_int(0);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 Aml *one =3D aml_int(1);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 cpu_res_dev =3D aml_device(&quot;%s.%s&quot;,=
 root, CPU_RES_DEVICE);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *crs;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(cpu_res_dev,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_name_decl(&qu=
ot;_HID&quot;, aml_eisaid(&quot;PNP0A06&quot;)));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(cpu_res_dev,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_name_decl(&qu=
ot;_UID&quot;, aml_string(&quot;CPU OSPM Interface=C2=A0 <br>
&gt; &gt; resources&quot;)));=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(cpu_res_dev, aml_mut=
ex(CPU_LOCK, 0));<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 crs =3D aml_resource_template()=
;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(crs, aml_memory32_fi=
xed(base_addr,=C2=A0 <br>
&gt; &gt; ACPI_CPU_OSPM_IF_REG_LEN,=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0AML_READ_WRITE));<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(cpu_res_dev, aml_nam=
e_decl(&quot;_CRS&quot;, crs));<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* declare CPU OSPM Interface M=
MIO region related access fields */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(cpu_res_dev,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0aml_operation_region(&quot;PRST&quot;, AML_SYSTEM_MEMORY,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 aml_int(base_addr),<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ACPI_CPU_OSPM_IF_REG_LEN));<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* define named fields wit=
hin PRST region with &#39;Byte&#39; access widths<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* and reserve fields with=
 other access width<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 field =3D aml_field(&quot;PRST&=
quot;, AML_BYTE_ACC, AML_NOLOCK,=C2=A0 <br>
&gt; &gt; AML_PRESERVE);=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* reserve CPU &#39;selector&#3=
9; field (size in bits) */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AML_APPEND_MR_RESVD_FIELD(field=
,=C2=A0 <br>
&gt; &gt; ACPI_CPU_MR_SELECTOR_SIZE_BITS);=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Flag::Enabled Bit(RO) - Read=
 &#39;1&#39; if enabled */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AML_APPEND_MR_NAMED_FIELD(field=
, CPU_ENABLED_F, 1);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Flag::Devchk Bit(RW) - Read =
&#39;1&#39;, has a event. Write &#39;1&#39;, to clear */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AML_APPEND_MR_NAMED_FIELD(field=
, CPU_DEVCHK_F, 1);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Flag::Ejectrq Bit(RW) - Read=
 1, has event. Write 1 to clear */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AML_APPEND_MR_NAMED_FIELD(field=
, CPU_EJECTRQ_F, 1);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Flag::Eject Bit(WO) - OSPM e=
vals _EJx, initiates CPU Eject in=C2=A0 <br>
&gt; &gt; Qemu*/=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AML_APPEND_MR_NAMED_FIELD(field=
, CPU_EJECT_F, 1);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Flag::Bit(ACPI_CPU_FLAGS_USE=
D_BITS)-Bit(7) - Reserve left over=C2=A0 <br>
&gt; &gt; bits*/=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AML_APPEND_MR_RESVD_FIELD(field=
,=C2=A0 <br>
&gt; &gt; ACPI_CPU_MR_RES_FLAG_BITS);=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Reserved space: padding afte=
r flags */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AML_APPEND_MR_RESVD_FIELD(field=
,=C2=A0 <br>
&gt; &gt; ACPI_CPU_MR_RES_FLAGS_SIZE_BITS);=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Command field written by OSP=
M */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AML_APPEND_MR_NAMED_FIELD(field=
, CPU_COMMAND,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ACPI_CPU_MR_CMD=
_SIZE_BITS);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Reserved space: padding afte=
r command field */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AML_APPEND_MR_RESVD_FIELD(field=
,=C2=A0 <br>
&gt; &gt; ACPI_CPU_MR_RES_CMD_SIZE_BITS);=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Command data: 64-bit payload=
 associated with command */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AML_APPEND_MR_RESVD_FIELD(field=
,=C2=A0 <br>
&gt; &gt; ACPI_CPU_MR_CMD_DATA_SIZE_BITS);=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(cpu_res_dev, field);=
<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* define named fields wit=
h &#39;Dword&#39; access widths and reserve fields<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* with other access width=
<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 field =3D aml_field(&quot;PRST&=
quot;, AML_DWORD_ACC, AML_NOLOCK,=C2=A0 <br>
&gt; &gt; AML_PRESERVE);=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* CPU selector, write only */<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AML_APPEND_MR_NAMED_FIELD(field=
, CPU_SELECTOR,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ACPI_CPU_MR_SEL=
ECTOR_SIZE_BITS);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(cpu_res_dev, field);=
<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* define named fields wit=
h &#39;Qword&#39; access widths and reserve fields<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* with other access width=
<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 field =3D aml_field(&quot;PRST&=
quot;, AML_QWORD_ACC, AML_NOLOCK,=C2=A0 <br>
&gt; &gt; AML_PRESERVE);=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Reserve space: selector=
, flags, reserved flags, command, reserved<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* command for Qword align=
ment.<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AML_APPEND_MR_RESVD_FIELD(field=
,=C2=A0 <br>
&gt; &gt; ACPI_CPU_MR_SELECTOR_SIZE_BITS +=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ACPI_CPU_MR_FLAGS_SIZE_BITS +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ACPI_CPU_MR_RES_FLAGS_SIZE_BITS +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ACPI_CPU_MR_CMD_SIZE_BITS +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ACPI_CPU_MR_RES_CMD_SIZE_BITS);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Command data accessible via =
Qword */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AML_APPEND_MR_NAMED_FIELD(field=
, CPU_DATA,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ACPI_CPU_MR_CMD=
_DATA_SIZE_BITS);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(cpu_res_dev, field);=
<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 aml_append(sb_scope, cpu_res_dev);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 cpus_dev =3D aml_device(&quot;%s.%s&quot;, ro=
ot, CPU_DEVICE);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *ctrl_lock =3D AML_CPU_RES_=
DEV(root, CPU_LOCK);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *cpu_selector =3D AML_CPU_R=
ES_DEV(root, CPU_SELECTOR);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *is_enabled =3D AML_CPU_RES=
_DEV(root, CPU_ENABLED_F);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *dvchk_evt =3D AML_CPU_RES_=
DEV(root, CPU_DEVCHK_F);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *ejrq_evt =3D AML_CPU_RES_D=
EV(root, CPU_EJECTRQ_F);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *ej_evt =3D AML_CPU_RES_DEV=
(root, CPU_EJECT_F);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *cpu_cmd =3D AML_CPU_RES_DE=
V(root, CPU_COMMAND);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *cpu_data =3D AML_CPU_RES_D=
EV(root, CPU_DATA);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(cpus_dev, aml_name_d=
ecl(&quot;_HID&quot;,=C2=A0 <br>
&gt; &gt; aml_string(&quot;ACPI0010&quot;)));=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(cpus_dev, aml_name_d=
ecl(&quot;_CID&quot;,<br>
&gt; &gt; &gt; + aml_eisaid(&quot;PNP0A05&quot;)));<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 method =3D aml_method(CPU_NOTIF=
Y_METHOD, 2,=C2=A0 <br>
&gt; &gt; AML_NOTSERIALIZED);=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; arch_ids-&=
gt;len; i++) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *cpu =3D aml_=
name(CPU_NAME_FMT, i);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *uid =3D aml_=
arg(0);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *event =3D am=
l_arg(1);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ifctx =3D aml_if(=
aml_equal(uid, aml_int(i)));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml=
_append(ifctx, aml_notify(cpu, event));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, ifctx);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(cpus_dev, method);<b=
r>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 method =3D aml_method(CPU_STS_M=
ETHOD, 1, AML_SERIALIZED);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *idx =3D aml_=
arg(0);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *sta =3D aml_=
local(0);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *else_ctx;<br=
>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, aml_acquire(ctrl_lock, 0xFFFF));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, aml_store(idx, cpu_selector));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, aml_store(zero, sta));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ifctx =3D aml_if(=
aml_equal(is_enabled, one));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* =
cpu is present and enabled */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml=
_append(ifctx, aml_store(aml_int(0xF), sta));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, ifctx);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else_ctx =3D aml_=
else();<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* =
cpu is present but disabled */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml=
_append(else_ctx, aml_store(aml_int(0xD), sta));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, else_ctx);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, aml_release(ctrl_lock));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, aml_return(sta));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(cpus_dev, method);<b=
r>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 method =3D aml_method(CPU_EJECT=
_METHOD, 1, AML_SERIALIZED);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *idx =3D aml_=
arg(0);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, aml_acquire(ctrl_lock, 0xFFFF));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, aml_store(idx, cpu_selector));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, aml_store(one, ej_evt));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, aml_release(ctrl_lock));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(cpus_dev, method);<b=
r>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 method =3D aml_method(CPU_SCAN_=
METHOD, 0, AML_SERIALIZED);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *has_event =
=3D aml_local(0); /* Local0: Loop control flag */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *uid =3D aml_=
local(1); /* Local1: Current CPU UID */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Constants */<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *dev_chk =3D =
aml_int(1); /* Notify: device check to enable */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *eject_req =
=3D aml_int(3); /* Notify: eject for removal */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *next_cpu_cmd=
 =3D<br>
&gt; &gt; &gt; + aml_int(ACPI_GET_NEXT_CPU_WITH_EVENT_CMD);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Acquire CPU lo=
ck */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, aml_acquire(ctrl_lock, 0xFFFF));<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Initialize loo=
p */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, aml_store(zero, uid));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, aml_store(one, has_event));<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *while_ctx =
=3D aml_while(aml_land(<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml=
_equal(has_event, one),<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml=
_lless(uid, aml_int(arch_ids-&gt;len))<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml=
_append(while_ctx, aml_store(zero, has_event));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* Issue scan cmd: QEMU will return next CPU with event in<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* cpu_data<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml=
_append(while_ctx, aml_store(uid, cpu_selector));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml=
_append(while_ctx, aml_store(next_cpu_cmd,<br>
&gt; &gt; &gt; + cpu_cmd));<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* =
If scan wrapped around to an earlier UID, exit loop */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml=
 *wrap_check =3D aml_if(aml_lless(cpu_data, uid));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml=
_append(wrap_check, aml_break());<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml=
_append(while_ctx, wrap_check);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* =
Set UID to scanned result */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml=
_append(while_ctx, aml_store(cpu_data, uid));<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* =
send CPU device-check(resume) event to OSPM */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml=
 *if_devchk =3D aml_if(aml_equal(dvchk_evt, one));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 aml_append(if_devchk,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 aml_call2(CPU_NOTIFY_METHOD, uid, dev_chk));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* clear local device-check event sent flag */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 aml_append(if_devchk, aml_store(one, dvchk_evt));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 aml_append(if_devchk, aml_store(one, has_event));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml=
_append(while_ctx, if_devchk);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* send CPU eject-request event to OSPM to gracefully handle<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* OSPM related tasks running on this CPU<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml=
 *else_ctx =3D aml_else();<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml=
 *if_ejrq =3D aml_if(aml_equal(ejrq_evt, one));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 aml_append(if_ejrq,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 aml_call2(CPU_NOTIFY_METHOD, uid, eject_req));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* clear local eject-request event sent flag */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 aml_append(if_ejrq, aml_store(one, ejrq_evt));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 aml_append(if_ejrq, aml_store(one, has_event));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml=
_append(else_ctx, if_ejrq);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml=
_append(while_ctx, else_ctx);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* =
Increment UID */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml=
_append(while_ctx, aml_increment(uid));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, while_ctx);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Release cpu lo=
ck */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, aml_release(ctrl_lock));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(cpus_dev, method);<b=
r>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 method =3D aml_method(CPU_OST_M=
ETHOD, 4, AML_SERIALIZED);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *uid =3D aml_=
arg(0);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *ev_cmd =3D a=
ml_int(ACPI_OST_EVENT_CMD);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *st_cmd =3D a=
ml_int(ACPI_OST_STATUS_CMD);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, aml_acquire(ctrl_lock, 0xFFFF));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, aml_store(uid, cpu_selector));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, aml_store(ev_cmd, cpu_cmd));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, aml_store(aml_arg(1), cpu_data));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, aml_store(st_cmd, cpu_cmd));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, aml_store(aml_arg(2), cpu_data));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, aml_release(ctrl_lock));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(cpus_dev, method);<b=
r>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* build Processor object for e=
ach processor */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; arch_ids-&=
gt;len; i++) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *dev;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Aml *uid =3D aml_=
int(i);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev =3D aml_devic=
e(CPU_NAME_FMT, i);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(dev, a=
ml_name_decl(&quot;_HID&quot;,=C2=A0 <br>
&gt; &gt; aml_string(&quot;ACPI0007&quot;)));=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(dev, a=
ml_name_decl(&quot;_UID&quot;, uid));<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 method =3D aml_me=
thod(&quot;_STA&quot;, 0, AML_SERIALIZED);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
, aml_return(aml_call1(CPU_STS_METHOD,=C2=A0 <br>
&gt; &gt; uid)));=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(dev, m=
ethod);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (CPU(arch_ids-=
&gt;cpus[i].cpu) !=3D first_cpu) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 met=
hod =3D aml_method(&quot;_EJ0&quot;, 1, AML_NOTSERIALIZED);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml=
_append(method, aml_call1(CPU_EJECT_METHOD, uid));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml=
_append(dev, method);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 method =3D aml_me=
thod(&quot;_OST&quot;, 3, AML_SERIALIZED);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(method=
,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml=
_call4(CPU_OST_METHOD, uid, aml_arg(0),<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_arg(1), aml_arg(2))<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 );<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(dev, m=
ethod);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aml_append(cpus_d=
ev, dev);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 aml_append(sb_scope, cpus_dev);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 aml_append(table, sb_scope);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 method =3D aml_method(event_handler_method, 0=
,=C2=A0 <br>
&gt; &gt; AML_NOTSERIALIZED);=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 aml_append(method, aml_call0(&quot;\\_SB.CPUS=
.&quot; CPU_SCAN_METHOD));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 aml_append(table, method);<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build index=
<br>
&gt; &gt; &gt; 73f02b9691..6d83396ab4 100644<br>
&gt; &gt; &gt; --- a/hw/acpi/meson.build<br>
&gt; &gt; &gt; +++ b/hw/acpi/meson.build<br>
&gt; &gt; &gt; @@ -8,6 +8,8 @@ acpi_ss.add(files(<br>
&gt; &gt; &gt;=C2=A0 ))<br>
&gt; &gt; &gt;=C2=A0 acpi_ss.add(when: &#39;CONFIG_ACPI_CPU_HOTPLUG&#39;, i=
f_true: files(&#39;cpu.c&#39;,<br>
&gt; &gt; &gt; &#39;cpu_hotplug.c&#39;))<br>
&gt; &gt; &gt;=C2=A0 acpi_ss.add(when: &#39;CONFIG_ACPI_CPU_HOTPLUG&#39;, i=
f_false:<br>
&gt; &gt; &gt; files(&#39;acpi-cpu-hotplug-stub.c&#39;))<br>
&gt; &gt; &gt; +acpi_ss.add(when: &#39;CONFIG_ACPI_CPU_OSPM_INTERFACE&#39;,=
 if_true:<br>
&gt; &gt; &gt; +files(&#39;cpu_ospm_interface.c&#39;))<br>
&gt; &gt; &gt; +acpi_ss.add(when: &#39;CONFIG_ACPI_CPU_OSPM_INTERFACE&#39;,=
 if_false:<br>
&gt; &gt; &gt; +files(&#39;acpi-cpu-ospm-interface-stub.c&#39;))<br>
&gt; &gt; &gt;=C2=A0 acpi_ss.add(when: &#39;CONFIG_ACPI_MEMORY_HOTPLUG&#39;=
, if_true:<br>
&gt; &gt; &gt; files(&#39;memory_hotplug.c&#39;))<br>
&gt; &gt; &gt;=C2=A0 acpi_ss.add(when: &#39;CONFIG_ACPI_MEMORY_HOTPLUG&#39;=
, if_false:<br>
&gt; &gt; &gt; files(&#39;acpi-mem-hotplug-stub.c&#39;))<br>
&gt; &gt; &gt;=C2=A0 acpi_ss.add(when: &#39;CONFIG_ACPI_NVDIMM&#39;, if_tru=
e: files(&#39;nvdimm.c&#39;))<br>
&gt; &gt; &gt; diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events ind=
ex<br>
&gt; &gt; &gt; edc93e703c..c0ecbdd48f 100644<br>
&gt; &gt; &gt; --- a/hw/acpi/trace-events<br>
&gt; &gt; &gt; +++ b/hw/acpi/trace-events<br>
&gt; &gt; &gt; @@ -40,6 +40,23 @@ cpuhp_acpi_fw_remove_cpu(uint32_t idx)=C2=
=A0 <br>
&gt; &gt; &quot;0x%&quot;PRIx32=C2=A0 <br>
&gt; &gt; &gt; cpuhp_acpi_write_ost_ev(uint32_t slot, uint32_t ev) &quot;id=
x[0x%&quot;PRIx32&quot;]<br>
&gt; &gt; &gt; OST EVENT: 0x%&quot;PRIx32=C2=A0 cpuhp_acpi_write_ost_status=
(uint32_t slot,<br>
&gt; &gt; &gt; uint32_t st) &quot;idx[0x%&quot;PRIx32&quot;] OST STATUS: 0x=
%&quot;PRIx32<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +#cpu_ospm_interface.c<br>
&gt; &gt; &gt; +acpi_cpuos_if_invalid_idx_selected(uint32_t idx) &quot;sele=
ctor=C2=A0 <br>
&gt; &gt; idx[0x%&quot;PRIx32&quot;]&quot;=C2=A0 <br>
&gt; &gt; &gt; +acpi_cpuos_if_read_flags(uint32_t idx, uint8_t flags) &quot=
;cpu<br>
&gt; &gt; &gt; +idx[0x%&quot;PRIx32&quot;] flags: 0x%&quot;PRIx8 acpi_cpuos=
_if_write_idx(uint32_t<br>
&gt; &gt; &gt; +idx) &quot;set active cpu idx: 0x%&quot;PRIx32 acpi_cpuos_i=
f_write_cmd(uint32_t<br>
&gt; &gt; &gt; +idx, uint8_t cmd) &quot;cpu idx[0x%&quot;PRIx32&quot;] cmd:=
 0x%&quot;PRIx8<br>
&gt; &gt; &gt; +acpi_cpuos_if_write_invalid_cmd(uint32_t idx, uint8_t cmd) =
&quot;cpu<br>
&gt; &gt; &gt; +idx[0x%&quot;PRIx32&quot;] invalid cmd: 0x%&quot;PRIx8<br>
&gt; &gt; &gt; +acpi_cpuos_if_write_invalid_offset(uint32_t idx, uint64_t a=
ddr) &quot;cpu<br>
&gt; &gt; &gt; +idx[0x%&quot;PRIx32&quot;] invalid offset: 0x%&quot;PRIx64=
=C2=A0 <br>
&gt; &gt; acpi_cpuos_if_read_cmd_data(uint32_t idx, uint32_t data) &quot;cp=
u<br>
&gt; &gt; idx[0x%&quot;PRIx32&quot;] data: 0x%&quot;PRIx32<br>
&gt; &gt; acpi_cpuos_if_read_invalid_cmd_data(uint32_t idx, uint8_t cmd) &q=
uot;cpu<br>
&gt; &gt; idx[0x%&quot;PRIx32&quot;] invalid cmd: 0x%&quot;PRIx8<br>
&gt; &gt; acpi_cpuos_if_cpu_has_events(uint32_t idx, bool devchk, bool ejrq=
st) &quot;cpu<br>
&gt; &gt; idx[0x%&quot;PRIx32&quot;] device-check pending: %d, eject-reques=
t pending: %d&quot;=C2=A0 <br>
&gt; &gt; &gt; +acpi_cpuos_if_clear_devchk_evt(uint32_t idx) &quot;cpu idx[=
0x%&quot;PRIx32&quot;]&quot;<br>
&gt; &gt; &gt; +acpi_cpuos_if_clear_ejrqst_evt(uint32_t idx) &quot;cpu idx[=
0x%&quot;PRIx32&quot;]&quot;<br>
&gt; &gt; &gt; +acpi_cpuos_if_ejecting_invalid_cpu(uint32_t idx) &quot;inva=
lid cpu=C2=A0 <br>
&gt; &gt; idx[0x%&quot;PRIx32&quot;]&quot;=C2=A0 <br>
&gt; &gt; &gt; +acpi_cpuos_if_ejecting_cpu(uint32_t idx) &quot;cpu idx[0x%&=
quot;PRIx32&quot;]&quot;<br>
&gt; &gt; &gt; +acpi_cpuos_if_write_ost_ev(uint32_t idx, uint32_t ev) &quot=
;cpu<br>
&gt; &gt; &gt; +idx[0x%&quot;PRIx32&quot;] OST Event: 0x%&quot;PRIx32<br>
&gt; &gt; &gt; +acpi_cpuos_if_write_ost_status(uint32_t idx, uint32_t st) &=
quot;cpu<br>
&gt; &gt; &gt; +idx[0x%&quot;PRIx32&quot;] OST Status: 0x%&quot;PRIx32<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 # pcihp.c<br>
&gt; &gt; &gt;=C2=A0 acpi_pci_eject_slot(unsigned bsel, unsigned slot) &quo=
t;bsel: %u slot: %u&quot;<br>
&gt; &gt; &gt;=C2=A0 acpi_pci_unplug(int bsel, int slot) &quot;bsel: %d slo=
t: %d&quot;<br>
&gt; &gt; &gt; diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig index<br>
&gt; &gt; &gt; 2aa4b5d778..c9991e00c7 100644<br>
&gt; &gt; &gt; --- a/hw/arm/Kconfig<br>
&gt; &gt; &gt; +++ b/hw/arm/Kconfig<br>
&gt; &gt; &gt; @@ -39,6 +39,7 @@ config ARM_VIRT<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 select VIRTIO_MEM_SUPPORTED<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 select ACPI_CXL<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 select ACPI_HMAT<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 select ACPI_CPU_OSPM_INTERFACE<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 config CUBIEBOARD<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 bool<br>
&gt; &gt; &gt; diff --git a/include/hw/acpi/cpu_ospm_interface.h<br>
&gt; &gt; &gt; b/include/hw/acpi/cpu_ospm_interface.h<br>
&gt; &gt; &gt; new file mode 100644<br>
&gt; &gt; &gt; index 0000000000..5dda327a34<br>
&gt; &gt; &gt; --- /dev/null<br>
&gt; &gt; &gt; +++ b/include/hw/acpi/cpu_ospm_interface.h<br>
&gt; &gt; &gt; @@ -0,0 +1,78 @@<br>
&gt; &gt; &gt; +/*<br>
&gt; &gt; &gt; + * ACPI CPU OSPM Interface Handling.<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * Copyright (c) 2025 Huawei Technologies R&amp;D (UK) Ltd.=
<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * Author: Salil Mehta &lt;<a href=3D"mailto:salil.mehta@hu=
awei.com" target=3D"_blank">salil.mehta@huawei.com</a>&gt;<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * This program is free software; you can redistribute it a=
nd/or<br>
&gt; &gt; &gt; +modify<br>
&gt; &gt; &gt; + * it under the terms of the GNU General Public License as =
published<br>
&gt; &gt; &gt; +by<br>
&gt; &gt; &gt; + * the ree Software Foundation; either version 2 of the Lic=
ense, or<br>
&gt; &gt; &gt; + * (at your option) any later version.<br>
&gt; &gt; &gt; + */<br>
&gt; &gt; &gt; +#ifndef CPU_OSPM_INTERFACE_H<br>
&gt; &gt; &gt; +#define CPU_OSPM_INTERFACE_H<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +#include &quot;qapi/qapi-types-acpi.h&quot;<br>
&gt; &gt; &gt; +#include &quot;hw/qdev-core.h&quot;<br>
&gt; &gt; &gt; +#include &quot;hw/acpi/acpi.h&quot;<br>
&gt; &gt; &gt; +#include &quot;hw/acpi/aml-build.h&quot;<br>
&gt; &gt; &gt; +#include &quot;hw/boards.h&quot;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +/**<br>
&gt; &gt; &gt; + * Total size (in bytes) of the ACPI CPU OSPM Interface MMI=
O region.<br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * This region contains control and status fields such as C=
PU<br>
&gt; &gt; &gt; +selector,<br>
&gt; &gt; &gt; + * flags, command register, and data register. It must exac=
tly match<br>
&gt; &gt; &gt; +the<br>
&gt; &gt; &gt; + * layout defined in the AML code and the memory region=C2=
=A0 <br>
&gt; &gt; implementation.=C2=A0 <br>
&gt; &gt; &gt; + *<br>
&gt; &gt; &gt; + * Any mismatch between this definition and the AML layout =
may result<br>
&gt; &gt; &gt; +in<br>
&gt; &gt; &gt; + * runtime errors or build-time assertion failures (e.g.,<b=
r>
&gt; &gt; &gt; +_Static_assert),<br>
&gt; &gt; &gt; + * breaking correct device emulation and guest OS coordinat=
ion.<br>
&gt; &gt; &gt; + */<br>
&gt; &gt; &gt; +#define ACPI_CPU_OSPM_IF_REG_LEN 16<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +typedef struct=C2=A0 {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 CPUState *cpu;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint64_t arch_id;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 bool devchk_pending; /* device-check pending =
*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 bool ejrqst_pending; /* eject-request pending=
 */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint32_t ost_event;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint32_t ost_status;<br>
&gt; &gt; &gt; +} AcpiCpuOspmStateStatus;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +typedef struct AcpiCpuOspmState {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 DeviceState *acpi_dev;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 MemoryRegion ctrl_reg;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint32_t selector;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint8_t command;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint32_t dev_count;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 AcpiCpuOspmStateStatus *devs;<br>
&gt; &gt; &gt; +} AcpiCpuOspmState;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +void acpi_cpu_device_check_cb(AcpiCpuOspmState *cpu_st, Dev=
iceState=C2=A0 <br>
&gt; &gt; *dev,=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t event_st, Error **er=
rp);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +void acpi_cpu_eject_request_cb(AcpiCpuOspmState *cpu_st,=C2=
=A0 <br>
&gt; &gt; DeviceState *dev,=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t event_st, Erro=
r **errp);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +void acpi_cpu_eject_cb(AcpiCpuOspmState *cpu_st, DeviceStat=
e *dev,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Error **errp);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +void acpi_cpu_ospm_state_interface_init(MemoryRegion *as, O=
bject=C2=A0 <br>
&gt; &gt; *owner,=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 AcpiCpuOspmState *state,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 hwaddr base_addr);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +void acpi_build_cpus_aml(Aml *table, hwaddr base_addr, cons=
t char=C2=A0 <br>
&gt; &gt; *root,=C2=A0 <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *event_handler_method);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +void acpi_cpus_ospm_status(AcpiCpuOspmState *cpu_st,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ACPIOSTInfoList ***list);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +extern const VMStateDescription vmstate_cpu_ospm_state; #de=
fine<br>
&gt; &gt; &gt; +VMSTATE_CPU_OSPM_STATE(cpuospm, state) \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 VMSTATE_STRUCT(cpuospm, state, 1, \<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0vmstate_cpu_ospm_state, AcpiCpuOspmState) #endif<br>
&gt; &gt; &gt; +/* CPU_OSPM_INTERFACE_H */=C2=A0 <br>
&gt; &gt;=C2=A0 =C2=A0<br>
&gt; <br>
<br>
</blockquote></div></div></div></div></div></div>

--000000000000a2edba0640c51ea5--

