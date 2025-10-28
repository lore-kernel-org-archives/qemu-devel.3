Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3F0CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeF1-0005sR-KB; Tue, 28 Oct 2025 03:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vDeEu-0005sC-JR
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:35:33 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vDeEr-0005IB-R5
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:35:32 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4ed0c162789so3780111cf.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761636926; x=1762241726; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5IEXDvYexfcgTROxVKwQBAdAkcITu8SYQfb0MLZP/WQ=;
 b=Ov0Xg+F6eXDAfbT+gpOAfKxKl7mV5CkinXaFCbaw+1AStRLT4l7j255H4jhpGRFaVB
 y8WKi2A0sBX/506v3oNphSWUL2m+qIZZ/mmyjzZqdPuJeNnuZVdw9G60wPfouCzCt7ex
 unSbZvXKb1Hkxqmp6BoIr4iqL+L3KuIhQKgJ8vM/sS6mz118vL8gsCDKZ9HyCpivXNhF
 qu28TB5VBrxcjkTAEjhaAStBFIZvm9fPFziGILGuxm9xadBg44/am8D2BlZEB+EE6iCm
 WZBfNN/j8XAzQbeA7/V+I2wWHVj9iesqI3ldfT9roIywRh6vNoGKUZ5hllPZ90gYf0XC
 TeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761636926; x=1762241726;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5IEXDvYexfcgTROxVKwQBAdAkcITu8SYQfb0MLZP/WQ=;
 b=ZZuSBLtf2811sl4KcXTDCEMaUiP7zN3h2BW3LcfTtWoaEsl0M9dG0p27IM/N007DJN
 ibPyll3Y3BU9G/PKGQN3O/vhHn7zo+7q+Os56i2kJizV3BbkbyyTBJb27pHC7G2zAEb6
 CEX7F/XGxP93jyIj9cZxCZZXPtg5OQ+l1rvuK1IqdbvgDEDGKuEr1UxftWicirvGIWjG
 bzE+9I9YRnh1DQWq5/+1HDS3xx/C44M40iAyZA7Sow8t2BeMbeLpLvE+qo48698RKDKk
 BJuqnQh9Lh23oZ+PI2kL8IIiKEj9/YGFZnFWl6cOpnTnV4g/nR1lRZUNALOFx3OABAvp
 JqrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgcg1sKd/u8J0RVpFPOdUp845HBrR8iIbz23eLdbkWQvZ/iJ4KAxOyqXeB+q9cX13b5B62HAr2BLPw@nongnu.org
X-Gm-Message-State: AOJu0YwdunXKPd9o4ZN8RgINNYK0YPaWXQYpNBGqjqlbikf+zjiDbKZS
 sILCuHWhdWS8pq1+qI9NXMdnmH/Qv21AxtExAmd/yNH7L0IBAXvaJb+RjKchZKWUqyrWVYQHVZ8
 P8NdQWbMK+W+0PppEAFuop/xLUspnCUo=
X-Gm-Gg: ASbGncv550t94vX4ETUTX0rz+EznPQ/QCQJmdXRsid/OdmVc44yrE2v9ybttsABJgHf
 jUFI3Xl1PHDZy3HW+XT/twf2k2bK+fXhqClx1sSBFbX4mBmNw5I5h3vwdGIfzSLRTQBpBRZgqO2
 HMlYJU6Z+dmq1OKVcaB1Ojvo6qfRiQpBsggxxaysuwYJhmlVToE/1+4QmEQkHjq7jHrCGLYJovA
 Bt7IaNnAcNR21XoTE9uqjh5giOK4N8MbJe4n7NTWzdjGNgYYHv+aZ2uIz02K7XWyJIXM33vSPIl
 qsoC70oGs6m9zK7+uh3GGDUzbq8=
X-Google-Smtp-Source: AGHT+IH3A/e7zqX0c+0suLfjnP0sTsVUzYL2UDQm09Zv+s0v+2Kwsi6OUoNf/uxTK+l6VDJgGwMu65UwWyZeMwI0nrg=
X-Received: by 2002:a05:622a:130e:b0:4ec:f151:6559 with SMTP id
 d75a77b69052e-4ed074b6299mr37464201cf.27.1761636925929; Tue, 28 Oct 2025
 00:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20251027165304.98296-1-philmd@linaro.org>
 <20251027165304.98296-2-philmd@linaro.org>
 <CAFEAcA-=cT_2JX+-D0_nHMrr_fgpRtXA2WqvY66unNAUhwkVkQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-=cT_2JX+-D0_nHMrr_fgpRtXA2WqvY66unNAUhwkVkQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Oct 2025 11:35:14 +0400
X-Gm-Features: AWmQ_bm8gFUqsnospo-ujqxGgmgusZ3NKTbROf4AEt0Ry9DbcCPetkQBvpATpLc
Message-ID: <CAJ+F1CLRGqjegi9zSy75TvxNrnbURUUAY3Y9aWcv=AWFDW3HPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] hw/pci/pci_host: Add 'config-reg-check-high-bit'
 property
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82a.google.com
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

Hi

On Mon, Oct 27, 2025 at 9:31=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Mon, 27 Oct 2025 at 16:54, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org> wrote:
> >
> > In order to have more PCI host bridges to re-use the
> > generic pci_host_data_le_ops MemoryRegionOps, add the
> > 'config-reg-check-high-bit' property (%true by default).
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> > diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
> > index b5c624e12e8..d6db365e327 100644
> > --- a/hw/pci/pci_host.c
> > +++ b/hw/pci/pci_host.c
> > @@ -184,8 +184,10 @@ static void pci_host_data_write(void *opaque, hwad=
dr addr,
> >  {
> >      PCIHostState *s =3D opaque;
> >
> > -    if (s->config_reg & (1u << 31))
> > -        pci_data_write(s->bus, s->config_reg | (addr & 3), val, len);
> > +    if (s->config_reg_check_high_bit && !(s->config_reg & (1U << 31)))=
 {
> > +        return;
> > +    }
> > +    pci_data_write(s->bus, s->config_reg | (addr & 3), val, len);
> >  }
> >
> >  static uint64_t pci_host_data_read(void *opaque,
> > @@ -193,7 +195,7 @@ static uint64_t pci_host_data_read(void *opaque,
> >  {
> >      PCIHostState *s =3D opaque;
> >
> > -    if (!(s->config_reg & (1U << 31))) {
> > +    if (s->config_reg_check_high_bit && !(s->config_reg & (1U << 31)))=
 {
> >          return 0xffffffff;
> >      }
> >      return pci_data_read(s->bus, s->config_reg | (addr & 3), len);
> > @@ -235,6 +237,8 @@ const VMStateDescription vmstate_pcihost =3D {
> >  };
> >
> >  static const Property pci_host_properties_common[] =3D {
> > +    DEFINE_PROP_BOOL("config-reg-check-high-bit", PCIHostState,
> > +                     config_reg_check_high_bit, true),
>
> I think it might be useful to name and document this
> property at a slightly higher level of abstraction.
>
> Specifically, this code is handling the behaviour of
> the CONFIG_ADDRESS register which is part of the PCI
> Configuration Access Method (CAM). For x86 the top bit of
> CONFIG_ADDRESS is an Enable bit, which must be set to
> cause accesses to CONFIG_DATA to actually do something.
> For PCI controllers like Dino there is no Enable bit
> defined in CONFIG_ADDRESS[*] and CONFIG_DATA accesses always
> take effect.
>
> [*] http://ftp.parisc-linux.org/docs/chips/dino_ers.pdf page 49
>
> So perhaps we could call this "config-address-reg-has-enable-bit" ?
>
> A documentation comment about its purpose and noting that
> the expectation is that this is set by the subclass,
> not by end-users, might also be helpful.

If this shouldn't be tweaked by users and is specific to a device
kind, could it be a bool on the PCIHostBridgeClass ?

--=20
Marc-Andr=C3=A9 Lureau

