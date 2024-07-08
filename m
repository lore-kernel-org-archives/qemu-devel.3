Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC6AC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 15:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQqGX-0003FT-95; Mon, 08 Jul 2024 11:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sQqGV-0003Ad-CG
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:26:55 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sQqGO-0007BS-KF
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:26:54 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-585e774fd3dso5332193a12.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 08:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720452404; x=1721057204; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZkC2y6M8pI7idOeViCjT4FahQm568LGM8eyZteXdTU0=;
 b=NtUBN32nONgQaRqEuqw7jrX2rj47WtZ720yTKsQrHyhHadDGgcn/QzV2pfTqUpc+sa
 8SeSWk3dznECnNY8Oa8MMqS5Mhz/SQj3xrwTM+gWWnZO0xVls5nczLwY7MwDi7/lIX+B
 IWI7I0jp55Dz/SUifdK7rcb/DQtMaGVQzx3ogO4m5YXiS0ilmUlZ9T99R6ABbXsJNRRk
 OdlM9FFdBWzVpAwnv3qS00nfecM9tpQegZfq2HCQOezPLGjtjMyXSip0I+N69P0SiiXc
 WB3JRkZOUgLGp+/ogzM1CY+o+uA4Ed5ILGKqj9eZsu8y8E43Jz7/jbq3n/o9hfQkte31
 YBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720452404; x=1721057204;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZkC2y6M8pI7idOeViCjT4FahQm568LGM8eyZteXdTU0=;
 b=oMKYdAMNq3oN62zu6quPih6+ATH+G+mHOlHXRPTrS/nmtLyJ2AjdiXPkbbxsC/kt2O
 MxqRwjyXEaR1Ruq36tmVC4bgDw1LjuEBMeQR/mHfilwRtDeUDi7W8pz7x6cX5uPqM5jA
 Tqom6aB51EQKDpp0QRpr84Qm3koCP7YUk27CVPjpgajcl7+dXWeePXNOwKs44Xmydt4r
 vEFqhPMDTqjYU7MxNWo9xU9A/UHkVKxZdZ2fDL3Rv9BfT/vDP57k8CvQK5S4c0lPUPpx
 B1h1T404+rbgkamvcOD1Z1Gf1tOrnNt8humwrpgV63uoIx2+fGWR66vvRUDtLL1Zrrhi
 Wp6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeEJa8KXf7EecDbilolkrM57MT/Xk5/iO1kywMCKqo4TQULvRe9v4nb9OZtLIM20Sf1Ur+UtwFPflGJBGEHdf0AsvoRV8=
X-Gm-Message-State: AOJu0YyqMlmPFkwPf5wQCrecx/n8i5WQXgQTVWTvaSSUa1Er7/rw2IZW
 LA9CuFeBCIA2eu6nP/glIl8/zrZlby+DEN52tKQ6Ow8J4weo0uY+pf5BcIpYZfCHxWkp5u+HXWe
 kBmtj3Z4cr416Jc0h0pbyJgaZTKTFzFJF0SL+fg==
X-Google-Smtp-Source: AGHT+IHT8O+lo9/GRDNeAWrH3yN3TJ922duHRJ/l5zq3Me5pjti1yXw3W823hbr1Mxne93DQdjfzjecfBX5/I4VXtJQ=
X-Received: by 2002:a05:6402:354f:b0:57d:5286:b513 with SMTP id
 4fb4d7f45d1cf-58e5926674dmr9108540a12.9.1720452404412; Mon, 08 Jul 2024
 08:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240704205854.18537-1-shentey@gmail.com>
 <20240704205854.18537-2-shentey@gmail.com>
 <5f8089ed-fb3f-d92c-0287-e055e8448677@eik.bme.hu>
In-Reply-To: <5f8089ed-fb3f-d92c-0287-e055e8448677@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jul 2024 16:26:32 +0100
Message-ID: <CAFEAcA8Yq+kt6-R7SZiDp3WQ_z4_4Sp8DT_YN71CwA+5Wz=Kmg@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/isa/vt82c686: Turn "intr" irq into a named gpio
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Huacai Chen <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, 5 Jul 2024 at 01:32, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Thu, 4 Jul 2024, Bernhard Beschow wrote:
> > Makes the code more comprehensible, matches the datasheet and the piix4 device
> > model.
> >
> > Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> > ---
> > hw/isa/vt82c686.c   | 2 +-
> > hw/mips/fuloong2e.c | 2 +-
> > hw/ppc/amigaone.c   | 4 ++--
> > hw/ppc/pegasos2.c   | 4 ++--
> > 4 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> > index 8582ac0322..505b44c4e6 100644
> > --- a/hw/isa/vt82c686.c
> > +++ b/hw/isa/vt82c686.c
> > @@ -719,7 +719,7 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
> >     ISABus *isa_bus;
> >     int i;
> >
> > -    qdev_init_gpio_out(dev, &s->cpu_intr, 1);
> > +    qdev_init_gpio_out_named(dev, &s->cpu_intr, "intr", 1);
> >     qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);
> >     isa_irq = qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
> >     isa_bus = isa_bus_new(dev, pci_address_space(d), pci_address_space_io(d),
> > diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
> > index a45aac368c..6e4303ba47 100644
> > --- a/hw/mips/fuloong2e.c
> > +++ b/hw/mips/fuloong2e.c
> > @@ -299,7 +299,7 @@ static void mips_fuloong2e_init(MachineState *machine)
> >                               object_resolve_path_component(OBJECT(pci_dev),
> >                                                             "rtc"),
> >                               "date");
> > -    qdev_connect_gpio_out(DEVICE(pci_dev), 0, env->irq[5]);
> > +    qdev_connect_gpio_out_named(DEVICE(pci_dev), "intr", 0, env->irq[5]);
>
> I was wondering why we still have 0 when we have a name so checked the doc
> commant in include/hw/qdev-core.h and found that the docs in
> qdev_connect_gpio_out_named is mostly just a copy&paste of the
> qdev_connect_gpio_out and it also talks about output GPIO array but then
> says input GPIOs in that array. I've stopped reading at that point as this
> text makes little sense. Somebody who knows how this actually works might
> want to update that doc comment.

Yeah, there's some copy-n-paste errors there. I'll send a patch.

The answer to "why is there both a name and a number 0" is
that named GPIOs (both input and output) are always created as
arrays of GPIOs, not single GPIOs. So you can create a named GPIO
output array like this:
   qdev_init_gpio_out_named(dev, s->fiq, "fiq", BCM2836_NCORES);
and then connect to fiq 0, fiq 1, fiq 2, and so on.
A single named output GPIO is a special case of the array-output
with only one element, so when you connect it up you still have
to say "I want element 0 of this length-1 array".

(The unnamed (anonymous) GPIOs are implemented under the hood
as "a named GPIO array where the name of the GPIO array is NULL".
So their semantics and also the documentation for the functions
is very similar to that for named GPIO arrays. But there are
also some places where I made cut-n-paste errors...)

thanks
-- PMM

