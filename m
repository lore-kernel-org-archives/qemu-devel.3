Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60461CA0ED3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 14:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slqmh-0005Ff-FY; Wed, 04 Sep 2024 10:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <whendrik@google.com>)
 id 1slqme-0005Ep-NB
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:14:56 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <whendrik@google.com>)
 id 1slqmc-0004qX-S7
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:14:56 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4567deb9f9dso232571cf.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 07:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1725459292; x=1726064092; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKnIcS+IRtAo+3bnUr1JiwvGweSl0v2Q2/wnp8l8V14=;
 b=arSxg9Nzujp46gmV+l/KndFBd31X3zM5sazmnNkDIvigevpolzhLVtQfjfmKF6f/jp
 Wqfmg/rd11rauX2y3hu4jrVXYn7sAj7xrw1rF81BcpTHLP3DnK8zq8i13bMcAuh0C+yH
 3Zk+uw5ylktoZ8ur/FAZh7Z+le2Z5EOmk8e9UER2JHAm0VsmJRlGu2ciz1Yt+7CjnCAs
 +lcYQM2vm6d3TntQBpR/JYxXnYUpK72+45FaeFG4cK7+wSCbKmSys00Sa/aXn2/WHmiN
 CNFLOKPlpcpoCe3HVBHJW4EbM5/IVWYduUP3ZH0c9NJy7TL5kcYORMLjwLtJ/n0NMhjv
 WY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725459292; x=1726064092;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NKnIcS+IRtAo+3bnUr1JiwvGweSl0v2Q2/wnp8l8V14=;
 b=k11tGuhi/UqIHF2RD4CvFQKHGDcm+ncHOFj+TzM8BYiP3iRr6uDYns5ZtNo7AkaTB6
 z4tfph+RoYK/xvzq04wibrjCEzDLTab93xVIJU6ZSRlK4zaWDd82I0vgNNCJv5lQKNtB
 fCE8ZpI/kbdchM32l/O3kRv6Y1//nxTza+/p0baDVp6Me3e/JjPuwTmtvKQijaq3a037
 vFCPTmB3aowxIQVqxHVq50bQtW0CO57UpGPaVGONA37RYA9yth+e1YPBuOlIndNM1kQg
 3HmZ2tFTztIDKbsGLsgILVhOBiG0xWWWbLb4s8kTjYRsx7M9bDx2CuSy82iuQ7GvaTcK
 pY0g==
X-Gm-Message-State: AOJu0YwifCFzatvhUVi90gJSuf6ryQyXZFQsZRaKWeEbDEUPzRDl/fdJ
 e43xO1xptw8MnyhB+5uRrJblx3kYKbwmzHnQHas2wVY9U5tD10wTeiJnLTOF39OvV7jb3ZmxB1+
 x/fL/gw4IQb1fqQHOUpTdwKcgWk+TuWuDiRyr
X-Google-Smtp-Source: AGHT+IGy8G9yDeMs/+deVNmYRmenUj7Bgc6p/9DJnTp6fc7jaCwyI1CBuS36Ut/X6XQ+f6pBLte6e8FSu0ucS2pKH7I=
X-Received: by 2002:a05:622a:90:b0:447:e3e3:77c1 with SMTP id
 d75a77b69052e-457f7b1b7fdmr2757391cf.29.1725459292193; Wed, 04 Sep 2024
 07:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240719162929.1197154-1-whendrik@google.com>
 <20240719162929.1197154-2-whendrik@google.com>
 <20240726112423.00005e5f@Huawei.com>
In-Reply-To: <20240726112423.00005e5f@Huawei.com>
From: =?UTF-8?Q?Hendrik_W=C3=BCthrich?= <whendrik@google.com>
Date: Wed, 4 Sep 2024 16:14:40 +0200
Message-ID: <CAEX-0Ws10ti8mdjjr=-a+UWvoGgGxo+xT472-swRhs7Xi6GjyQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] Add Intel RDT device to config.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com, 
 peternewman@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=whendrik@google.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Fri, Jul 26, 2024 at 12:24=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 19 Jul 2024 16:29:21 +0000
> Hendrik Wuethrich <whendrik@google.com> wrote:
>
> > From: =E2=80=AAHendrik W=C3=BCthrich <whendrik@google.com>
> >
> > Change config to show RDT, add minimal code to the rdt.c module to make
> > sure things still compile.
> >
> > Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
>
> Hi Hendrik
>
> Great to see emulation of this. Will be handy for testing
> kernel changes etc.

Hi Jonathan, thank you very much for the review, and very sorry
for the late reply.

> Not convinced it's worth a separate patch just to add stubs.
> Why not at least bring some real code in with this?
>
> > ---
> >  hw/i386/Kconfig       |  4 ++++
> >  hw/i386/meson.build   |  1 +
> >  hw/i386/rdt.c         | 49 +++++++++++++++++++++++++++++++++++++++++++
> >  include/hw/i386/rdt.h | 12 +++++++++++
> >  4 files changed, 66 insertions(+)
> >  create mode 100644 hw/i386/rdt.c
> >  create mode 100644 include/hw/i386/rdt.h
> >
> > diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> > index f4a33b6c08..4dd05ed6f2 100644
> > --- a/hw/i386/Kconfig
> > +++ b/hw/i386/Kconfig
> > @@ -10,6 +10,9 @@ config SGX
> >      bool
> >      depends on KVM
> >
> > +config RDT
> > +    bool
> > +
> >  config PC
> >      bool
> >      imply APPLESMC
> > @@ -26,6 +29,7 @@ config PC
> >      imply QXL
> >      imply SEV
> >      imply SGX
> > +    imply RDT
> >      imply TEST_DEVICES
> >      imply TPM_CRB
> >      imply TPM_TIS_ISA
> > diff --git a/hw/i386/meson.build b/hw/i386/meson.build
> > index 03aad10df7..fdbf5962b5 100644
> > --- a/hw/i386/meson.build
> > +++ b/hw/i386/meson.build
> > @@ -21,6 +21,7 @@ i386_ss.add(when: 'CONFIG_VMPORT', if_true: files('vm=
port.c'))
> >  i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))
> >  i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
> >                                  if_false: files('sgx-stub.c'))
> > +i386_ss.add(when: 'CONFIG_RDT', if_true: files('rdt.c'))
> >
> >  i386_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-common.c'))
> >  i386_ss.add(when: 'CONFIG_PC', if_true: files(
> > diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
> > new file mode 100644
> > index 0000000000..0a5e95606b
> > --- /dev/null
> > +++ b/hw/i386/rdt.c
>
> License etc missing.
>
> > @@ -0,0 +1,49 @@
> > +#include "qemu/osdep.h"
> > +#include "hw/i386/rdt.h"
> > +#include <stdint.h>
> > +#include "hw/qdev-properties.h"
> > +#include "qemu/typedefs.h"
> > +#include "qom/object.h"
> > +#include "target/i386/cpu.h"
> > +#include "hw/isa/isa.h"
>
> Ordering seems a bit random.  I don't really mind what order
> they are in but it is easier to pick an option so it
> becomes obvious where to put things later.
>
> Also better to bring these in when they are needed so it
> is obvious why they are here.
>
>
> > +
> > +#define TYPE_RDT "rdt"
> > +
> > +OBJECT_DECLARE_TYPE(RDTState, RDTStateClass, RDT);
> > +
> > +struct RDTState {
> > +    ISADevice parent;
> > +};
> > +
> > +struct RDTStateClass { };
> I'd do
> ...Class {
> };
>
> As will reduce noise in later patches assuming this will have
> content.
>
>
> > +
> > +OBJECT_DEFINE_TYPE(RDTState, rdt, RDT, ISA_DEVICE);
> > +
> > +static Property rdt_properties[] =3D {
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void rdt_init(Object *obj)
>
> Not used?
>
> > +{
> > +}
> > +
> > +static void rdt_realize(DeviceState *dev, Error **errp)
> > +{
> > +}
> > +
> > +static void rdt_finalize(Object *obj)
> > +{
> > +}
>
> Not used?

Realize will be removed in V2 until needed. init and
finalize are necessary to build the device, as far as I
can tell.
>
> > +
> > +static void rdt_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->hotpluggable =3D false;
> > +    dc->desc =3D "RDT";
> > +    dc->user_creatable =3D true;
> > +    dc->realize =3D rdt_realize;
> > +
> > +    device_class_set_props(dc, rdt_properties);
> > +}
> > +
> > diff --git a/include/hw/i386/rdt.h b/include/hw/i386/rdt.h
> > new file mode 100644
> > index 0000000000..45e34d3103
> > --- /dev/null
> > +++ b/include/hw/i386/rdt.h
> > @@ -0,0 +1,12 @@
> > +#ifndef HW_RDT_H
> > +#define HW_RDT_H
> > +
> > +#include <stdbool.h>
> > +#include <stdint.h>
>
> Not used so don't include them until needed.
>
> > +
> > +typedef struct RDTState RDTState;
> > +typedef struct RDTStateInstance RDTStateInstance;
> > +typedef struct RDTMonitor RDTMonitor;
> > +typedef struct RDTAllocation RDTAllocation;
> > +
> > +#endif
>

