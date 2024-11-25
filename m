Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BC1D58D41
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 13:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFYkj-00080X-Cg; Mon, 25 Nov 2024 08:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFYkh-00080K-JN; Mon, 25 Nov 2024 08:03:43 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFYkf-0002Ne-78; Mon, 25 Nov 2024 08:03:42 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7e6d04f74faso3010763a12.1; 
 Mon, 25 Nov 2024 05:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732539819; x=1733144619; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0t5ZYhSsVTmh6oCEPLwfuhbeFDt36YI2arCPlIIOHbE=;
 b=L0wjLyyMRWqapCah6zwGpg2Xk2FXEEJGP2n8lHPtW1tjzMjDH1W2DPONT6yTy4yfk6
 nbvlyuQ+L4EuzuPXHdhCKh7TR39mxcM4K2oETrmLzz7hnGXuX7FXCwt5vp+npco1QPfi
 qeujPDeORVjzyKUpEW1MMZnXhgV9la953tyiQmDfB6AyZT576IBFansBm/vZj+dDZj/S
 vaIATUIW0t8cqjTIA8/GrrVPV3j28p0dNZv7tq5uCGN+nqfuiaadibOnhFJftVIm6ZHM
 l+4rEXnLoufvVNJ9FFva+2IZQD2X2WuT8rByAJTUZLOxQIDyaBq7nNoTGtIrC180Af6O
 emVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732539819; x=1733144619;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0t5ZYhSsVTmh6oCEPLwfuhbeFDt36YI2arCPlIIOHbE=;
 b=vPbL5rDGyFaN6ThrBD2rqPylSrok1DQmxoW3tf/alnNZqn+sogsC09vRWfVoMEejgR
 k2SMUhxFjAmBbT9cP5a9rZk0EgRyywFcQotHgwlA5zkgPmov9Z5xkuDUR9gr/Cvus4fw
 8lQf3GS2V4KOJCxxniK5YLr3Mg7TNMYcLByZaAziPodCQAtotmX4XLAYJxUZIG0s/BJV
 jRjHhDdBdw8DkpCCyHtqp7bas5QbFdVw232Rw3HP355QDfIejZYyhRRqyQpjoUMuRVNb
 7M5gok0EqqNyYe97WxHS3CkDcNZh5KKpbCtIH3TAdGvtiE08mgJVeU0dR5TZlbW2ukAF
 31Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6k/widznyRTDIn3Op34WxZCTbrvN95XWFomE2PoUFdFPgXEinvrx7rxsuo4TWpNaZp8GYzGPHDWJU@nongnu.org,
 AJvYcCWtHAh8f1v+nycX1t3MOnJys0scNUIYVI7hHJEYLV+FbdMPshwdDc6u31Mu9b+Lb0bsrHBfd84VWd0=@nongnu.org
X-Gm-Message-State: AOJu0YzwGz/sGX14RKr/tNhJqqZJX+MyEsjnVPJyRNRl3BrSaDGR3sp0
 qlKU4VDan6C9wkU0ECZIKo+52ztOO4wFuhZ4dTm2j86AyjM6W4o8atbUZQ==
X-Gm-Gg: ASbGnct4jn+uERFOp4Qa9UMn0hbynZvKmKqw9919xUV5e4fNMj7oIm+2WwUHgebw8fJ
 ign6OzImFHPiYfMXtcFF3/VuIuoryHh2Uyb9YirLyHOanRY3FAaVG8V2oC6HX4Vkfmxlhtkwynk
 nc0gqMpSmYAntZO5wb/4WauFHfyeW4kHgd8dt+hMApGSwvswPXxWF3fHg+Q53A+LqcnO1eiBWuJ
 RXACrM/IZmEpcfSQV58clbvODYhMQz+iRLBIZrj7fhqh2T3IIAqm0pC5mmaIGqeD/U69Do=
X-Google-Smtp-Source: AGHT+IHGC83FaEa3F+pH9OX57BfXgOZHlMSTuRPfWv0hPalwj+Yhvc/H5GOxVG2aQN2E6maTrv5bDA==
X-Received: by 2002:a17:902:fc86:b0:212:3f13:d4bc with SMTP id
 d9443c01a7336-21284112f8bmr248425935ad.27.1732539818965; 
 Mon, 25 Nov 2024 05:03:38 -0800 (PST)
Received: from localhost (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724de531247sm6514919b3a.104.2024.11.25.05.03.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 05:03:38 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 Nov 2024 23:03:34 +1000
Message-Id: <D5VA3V07UFIY.BX05Q673TWAV@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2] hw/ppc/pegasos2: Fix IRQ routing from pci.0
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.18.2
References: <20241102121711.26F054E6013@zero.eik.bme.hu>
 <88eff33f-d9b8-01c7-db0e-5ac38d722f8b@eik.bme.hu>
In-Reply-To: <88eff33f-d9b8-01c7-db0e-5ac38d722f8b@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sat Nov 16, 2024 at 2:01 AM AEST, BALATON Zoltan wrote:
> On Sat, 2 Nov 2024, BALATON Zoltan wrote:
> > The MV64361 has two PCI buses one of which is used for AGP on
> > PegasosII. So far we only emulated the PCI bus on pci.1 but some
> > graphics cards are only recognised by some guests when connected to
> > pci.0 corresponding to the AGP port. So far the interrupts were not
> > routed from pci.0 so this patch fixes that allowing the use of both
> > PCI buses. On real board only INTA and INTB are connected for AGP but
> > to avoid surprises we connect all 4 PCI interrupt lines so pci.0 can
> > be used for all PCI cards as well.
>
> Ping? As this is a bug fix it's still not too late to merge I think.

I missed it, sorry.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Regards,
> BALATON Zoltan
>
> > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > ---
> > hw/pci-host/mv64361.c |  1 +
> > hw/ppc/pegasos2.c     | 30 +++++++++++++++++++++++++++++-
> > 2 files changed, 30 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
> > index 1036d8600d..421c287eb0 100644
> > --- a/hw/pci-host/mv64361.c
> > +++ b/hw/pci-host/mv64361.c
> > @@ -95,6 +95,7 @@ static void mv64361_pcihost_realize(DeviceState *dev,=
 Error **errp)
> >                                    &s->mem, &s->io, 0, 4, TYPE_PCI_BUS)=
;
> >     g_free(name);
> >     pci_create_simple(h->bus, 0, TYPE_MV64361_PCI_BRIDGE);
> > +    qdev_init_gpio_out(dev, s->irq, ARRAY_SIZE(s->irq));
> > }
> >
> > static Property mv64361_pcihost_props[] =3D {
> > diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> > index 8ff4a00c34..16abeaac82 100644
> > --- a/hw/ppc/pegasos2.c
> > +++ b/hw/ppc/pegasos2.c
> > @@ -14,6 +14,7 @@
> > #include "hw/sysbus.h"
> > #include "hw/pci/pci_host.h"
> > #include "hw/irq.h"
> > +#include "hw/or-irq.h"
> > #include "hw/pci-host/mv64361.h"
> > #include "hw/isa/vt82c686.h"
> > #include "hw/ide/pci.h"
> > @@ -73,8 +74,11 @@ OBJECT_DECLARE_TYPE(Pegasos2MachineState, MachineCla=
ss, PEGASOS2_MACHINE)
> >
> > struct Pegasos2MachineState {
> >     MachineState parent_obj;
> > +
> >     PowerPCCPU *cpu;
> >     DeviceState *mv;
> > +    IRQState pci_irqs[PCI_NUM_PINS];
> > +    OrIRQState orirq[PCI_NUM_PINS];
> >     qemu_irq mv_pirq[PCI_NUM_PINS];
> >     qemu_irq via_pirq[PCI_NUM_PINS];
> >     Vof *vof;
> > @@ -177,7 +181,6 @@ static void pegasos2_init(MachineState *machine)
> >         pm->mv_pirq[i] =3D qdev_get_gpio_in_named(pm->mv, "gpp", 12 + i=
);
> >     }
> >     pci_bus =3D mv64361_get_pci_bus(pm->mv, 1);
> > -    pci_bus_irqs(pci_bus, pegasos2_pci_irq, pm, PCI_NUM_PINS);
> >
> >     /* VIA VT8231 South Bridge (multifunction PCI device) */
> >     via =3D OBJECT(pci_new_multifunction(PCI_DEVFN(12, 0), TYPE_VT8231_=
ISA));
> > @@ -209,6 +212,31 @@ static void pegasos2_init(MachineState *machine)
> >     /* other PC hardware */
> >     pci_vga_init(pci_bus);
> >
> > +    /* PCI interrupt routing: lines from pci.0 and pci.1 are ORed */
> > +    for (int h =3D 0; h < 2; h++) {
> > +        DeviceState *pd;
> > +        g_autofree const char *pn =3D g_strdup_printf("pcihost%d", h);
> > +
> > +        pd =3D DEVICE(object_resolve_path_component(OBJECT(pm->mv), pn=
));
> > +        assert(pd);
> > +        for (i =3D 0; i < PCI_NUM_PINS; i++) {
> > +            OrIRQState *ori =3D &pm->orirq[i];
> > +
> > +            if (h =3D=3D 0) {
> > +                g_autofree const char *n =3D g_strdup_printf("pci-orir=
q[%d]", i);
> > +
> > +                object_initialize_child_with_props(OBJECT(pm), n,
> > +                                                   ori, sizeof(*ori),
> > +                                                   TYPE_OR_IRQ, &error=
_fatal,
> > +                                                   "num-lines", "2", N=
ULL);
> > +                qdev_realize(DEVICE(ori), NULL, &error_fatal);
> > +                qemu_init_irq(&pm->pci_irqs[i], pegasos2_pci_irq, pm, =
i);
> > +                qdev_connect_gpio_out(DEVICE(ori), 0, &pm->pci_irqs[i]=
);
> > +            }
> > +            qdev_connect_gpio_out(pd, i, qdev_get_gpio_in(DEVICE(ori),=
 h));
> > +        }
> > +    }
> > +
> >     if (machine->kernel_filename) {
> >         sz =3D load_elf(machine->kernel_filename, NULL, NULL, NULL,
> >                       &pm->kernel_entry, &pm->kernel_addr, NULL, NULL, =
1,
> >


