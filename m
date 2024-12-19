Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0EAE77188
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 00:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO4kI-00075y-Fk; Wed, 18 Dec 2024 19:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tO4kH-00075h-IA
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 19:50:29 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tO4kF-0002vD-Oj
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 19:50:29 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7f71f2b1370so92474a12.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 16:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734569426; x=1735174226; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkJya71wtN7yKIm4zE/6//N5nBw5L1+wqJ27hcwaq5M=;
 b=JXIHYeZCj/EZmoj5P/xn+K2NWcG9QQEp97kcjwRje1TGHTFO5T4UI7b4lK6LDGYazK
 9ir1aZdU2uhLkdpXqJJGuexqKc/RNzmNnJavX3StpVpglHodzaC/cLa7w2L/tLCTt4Be
 WNzfZo4JH6zSdB8W5nuBMi9eLJG++7BKdb0/7Ul9LxdbX9rWK6UMriiOW5fJohE6w6k9
 o0GBWPOgUnVeSkBKAfnuCsrhBXSopYNxJBERtIlLATyvDWyMZg70Dd1dEZAnp7KipuwH
 oeCcdWIMBjEm0iT9cqg0X5Q8yI1JFJxJdhDzZV27hcVi1YCvuFyclD50cEkv60mg7ML/
 IAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734569426; x=1735174226;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rkJya71wtN7yKIm4zE/6//N5nBw5L1+wqJ27hcwaq5M=;
 b=BWj+aR5lfp5pOttKHavo5HR4qBqhbfPJMzU13tBn1K8LAXhl9hkLhssiCH3sopZLhi
 CxedjoyvPVmO2wuZQdvxICAa2cuHBKb0EmUQOmnnW1T2rzy5op6MzvUvUsXyqDU/DTz5
 uShYtvDwSVM6Wll0LPl99gh7VAK/XxahNcr+fcH9asqwETI+f+YG6QyY6G7Bs9O1fwDi
 8d7XejgKjjD2/+UFSSLpyZbrguDEgvNRLV1lSrTqxaDRSQ7IxFaVENXf9FSjb7Edgc+c
 /WOvNK0mUSG593qvIAWp85b8eBvc4DS+ZEoI+p5AZAkURYCR8QaPj2nxQH3bkSefN/2W
 zFjw==
X-Gm-Message-State: AOJu0YyMMyUh/MrLs/ETtA1XWsQ1FdjBtTC8FIGqmBDbLbcJg65r5dFf
 J4Dg1VObDCDSUUcqvdEdKWhzvYmLdFZeQJArV+9CZ0Go4ytHkxoe
X-Gm-Gg: ASbGnctr8rJ5noAGrBiAyNDi6o/pk14i0cgVw5qQRVmT2cgdRI7sOK3jeQF5mX4ruiZ
 +gQPKVV92gpp1t3vXaYZIqZaPF8iUuBCA3kQjnQeBCSCl81FfN3mymakzarDSduIznRUN0FhQew
 hy8Y7PAdzpXR3nkFsmvcho27gTUkaHb6jNX/O0uQBOX1aS/7jpf7MsQfALJulM1DOITXJe5XF4a
 CcIg4I50MeW0jTGFVzfH5reErSA8nkbKLRBZcF6c4gh+EERWhCmZU9LMJwquB72JnC3ia+mROc=
X-Google-Smtp-Source: AGHT+IGIvKmBz7wgljwTQL2oQFNQVDPIQHGLbxWnxRc+mc5RVO61mHNgCdbtTanbMigFGHBsIJ46IA==
X-Received: by 2002:a17:90b:2803:b0:2ea:4c4f:bd20 with SMTP id
 98e67ed59e1d1-2f2e93ad642mr6109877a91.32.1734569425878; 
 Wed, 18 Dec 2024 16:50:25 -0800 (PST)
Received: from localhost (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ed62cde6sm2267605a91.13.2024.12.18.16.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 16:50:25 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Dec 2024 10:50:20 +1000
Message-Id: <D6F9JJ5CT2YO.D1DXT3XHPQWS@gmail.com>
Cc: <qemu-devel@nongnu.org>, "Akihiko Odaki" <akihiko.odaki@daynix.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 1/2] hw/usb/hcd-xhci-pci: Make PCI device more
 configurable
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Phil Dennis-Jordan" <phil@philjordan.eu>
X-Mailer: aerc 0.18.2
References: <20241212085207.1439501-1-npiggin@gmail.com>
 <20241212085207.1439501-2-npiggin@gmail.com>
 <CAAibmn3NsDewTEFdWoR=VpTRSb5C67bFMYXnf74zBQOwWCLi1Q@mail.gmail.com>
 <D6EFJHL1PDCX.2TZC2E8DZLNU3@gmail.com>
 <CAAibmn3STc4hWJPfDtdp2rDscx_8cO=cO4JA=qhneif03Jf9QA@mail.gmail.com>
In-Reply-To: <CAAibmn3STc4hWJPfDtdp2rDscx_8cO=cO4JA=qhneif03Jf9QA@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52d.google.com
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

On Thu Dec 19, 2024 at 7:06 AM AEST, Phil Dennis-Jordan wrote:
> On Wed, 18 Dec 2024 at 02:19, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> > On Thu Dec 12, 2024 at 8:41 PM AEST, Phil Dennis-Jordan wrote:

[...]

> > > > @@ -143,22 +177,37 @@ static void usb_xhci_pci_realize(struct PCIDe=
vice
> > > > *dev, Error **errp)
> > > >          /* With msi=3Dauto, we fall back to MSI off silently */
> > > >          error_free(err);
> > > >      }
> > > > +
> > > >      pci_register_bar(dev, 0,
> > > >                       PCI_BASE_ADDRESS_SPACE_MEMORY |
> > > >                       PCI_BASE_ADDRESS_MEM_TYPE_64,
> > > >                       &s->xhci.mem);
> > > >
> > > >      if (pci_bus_is_express(pci_get_bus(dev))) {
> > > > -        ret =3D pcie_endpoint_cap_init(dev, 0xa0);
> > > > +        ret =3D pcie_endpoint_cap_init(dev, s->pcie_cap_off);
> > > >          assert(ret > 0);
> > > >      }
> > > >
> > > >      if (s->msix !=3D ON_OFF_AUTO_OFF) {
> > > > -        /* TODO check for errors, and should fail when msix=3Don *=
/
> > > > -        msix_init(dev, s->xhci.numintrs,
> > > > -                  &s->xhci.mem, 0, OFF_MSIX_TABLE,
> > > > -                  &s->xhci.mem, 0, OFF_MSIX_PBA,
> > > > -                  0x90, NULL);
> > > > +        MemoryRegion *msix_bar =3D &s->xhci.mem;
> > > > +        if (s->msix_bar_nr !=3D 0) {
> > > > +            memory_region_init(&dev->msix_exclusive_bar, OBJECT(de=
v),
> > > > +                               "xhci-msix", s->msix_bar_size);
> > > > +            msix_bar =3D &dev->msix_exclusive_bar;
> > > > +        }
> > > > +
> > > > +        ret =3D msix_init(dev, s->xhci.numintrs,
> > > > +                        msix_bar, s->msix_bar_nr, s->msix_table_of=
f,
> > > > +                        msix_bar, s->msix_bar_nr, s->msix_pba_off,
> > > > +                        s->msix_cap_off, errp);
> > > > +        if (ret) {
> > > > +            return;
> > > > +        }
> > > >
> > >
> > > Surely we should only propagate the error and fail realize() iff s->m=
six
> > is
> > > ON_OFF_AUTO_ON?
> > >
> > > For ON_OFF_AUTO_AUTO, msix_init returning failure isn't a critical er=
ror.
> >
> > Yep you're right... you had been testing with msix disabled. I wonder i=
f
> > there is a good way to force fail this in qtests?
> >
>
> I'm really the wrong person to ask about qtest, I'm only just beginning t=
o
> get to grips with it.

I'm not an expert in it, for the most part it can set up a machine as
usual, but the test case itself pokes at the machine directly by
talking to an interface on the host that can run memory access, qmp
commands, etc.

Can just make things easier and faster to set up and orchestrate than
doing it from within the target machine code.

> It seems the only real reason msix_init fails other
> than misconfiguration of the device/BAR is when msi_nonbroken =3D false.
>
> At least on x86(-64), msi_nonbroken=3Dtrue is unconditionally set in
> apic_realize(). (I think real hardware would not support MSI(-X) on the
> i440FX chipset - I was fairly certain it was the PCI root/southbridge
> catching the writes to the reserved memory region, and I didn't think the
> PIIX did this; but at least in QEMU it doesn't seem to be implemented in =
a
> chipset-dependent way.) I'm not sure it's possible to run QEMU without an
> APIC?
>
> On aarch64, the GICv3 needs to explicitly enable support (via the ITS), s=
o
> perhaps it's possible to set up an aarch64 qtest with ITS disabled? It
> looks like the 'virt' machine type only supports the ITS from version 6.2=
,
> so older versions will disable it.
>
> Sorry, clutching at straws here.

No that's okay, thanks for the input. Finding a platform with
broken msi could be an interesting test. I'll check it out.

> > > > +
> > > > +        pci_register_bar(dev, s->msix_bar_nr,
> > > > +                         PCI_BASE_ADDRESS_SPACE_MEMORY |
> > > > +                         PCI_BASE_ADDRESS_MEM_TYPE_64,
> > > > +                         msix_bar);
> > > >
> > >
> > > Is it safe to call pci_register_bar() again for the msix_bar_nr =3D 0=
 case?
> > > Even if it is safe, is it sensible? If we're calling it twice for the
> > same
> > > BAR, and the arguments of either of the calls changes in future, the
> > other
> > > needs to change too. Doesn't seem ideal.
> >
> > Good catch. It looks like it "works" so long as the bar wasn't mapped,
> > but I'm sure bad practice... Interesting there is no assertion in
> > there though. I'll fix it though.
> >
>
> I notice there's a msix_init_exclusive_bar()=E2=80=A6 I wonder if it'd be=
 simpler
> to use that and modify it so it allows you to choose a size and layout fo=
r
> the BAR, rather than adding all that extra code to deal with the extra BA=
R
> in the XHCI?
> (It already calls pci_register_bar() and msix_init() internally, but seem=
s
> to set the BAR's size to 4096 and places the PBA at halfway through the
> BAR. Perhaps rename it to something like
> msix_init_exclusive_bar_with_layout and pass the bar_size and
> bar_pba_offset in as parameters; then make msix_init_exclusive_bar() a
> wrapper for that function with the existing defaults for those variables?=
)
>
> Just kicking around some ideas here, I have no idea if that actually ends
> up making things simpler=E2=80=A6

Yeah, I ended up beginning with that, but ended up running into some of
these issues and ended up being more code due to duplicating the non
exclusive case.

I'll stick with open-coding it for now, but it almost seems like there
could be an API call that could encompass exclusive and non-exclusive
cases in one. Would probably be good to have more than one caller before
trying to refactor it though.

Thanks,
Nick

