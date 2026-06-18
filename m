Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F53CD98F6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waDnq-0005NB-Uq; Thu, 18 Jun 2026 10:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1waDnp-0005MU-Ou
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:33:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1waDnn-0006Pk-VF
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781793186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJrHSixspHjfMRFrkJOSeFkO4cK0hPkIV3hmNy4buJ4=;
 b=L7mx2tXQUsjSG+/nayasgm/L0M7XzJslektu06tu/09e8j98J2LnBsXpIYKgc5FDY5OL3w
 eSohfR0ownzVzI3HYXlvPi/BXCWaiwDNnltK0GGjyCFQxI3XNBZtfdXmjOEq/3fZ1DXkcG
 HNQWj4JGXvWlMjUoP8VUEpaf7tY7g2c=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-vtE2CiJ4MqOeuFgoWb483g-1; Thu, 18 Jun 2026 10:33:04 -0400
X-MC-Unique: vtE2CiJ4MqOeuFgoWb483g-1
X-Mimecast-MFC-AGG-ID: vtE2CiJ4MqOeuFgoWb483g_1781793184
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4893fc86bebso2121672b6e.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 07:33:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781793184; cv=none;
 d=google.com; s=arc-20240605;
 b=HjOtVDIcESG4XLo+EuNMVTenVbYOeax6FpIUU50BXHzKiMY4cyC9a7n/HqPEe7vbwF
 1w1/sJxill9izQ7fpt6aII0rTfY/tRwAr6MbmiIEJfo0cxNg+hJZBKQkXA7/8SJPAWBZ
 TIiEPsVBd4Fb6baTGlr1kF0kwPCf5otEEi00kaVqgV8+g1mWVsZMw00wdMlMkvNBmvnb
 0N+0Wx+Ad13UWSr+oTIjMlXRBN2no63RXgS7E9dx2b6UJYTF4rFjG4elVwKWA0nfIhHM
 jSE2HGXXeltlpNTG6ZUSnhIWi5i0e623SqCZwpdoxjJAPbTBroSCInuak9tmNCALPhzC
 lYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cJrHSixspHjfMRFrkJOSeFkO4cK0hPkIV3hmNy4buJ4=;
 fh=ovYVIiHIxHaznPtutltgX1n6Q2Lk7lpA1x0bVw9IfQs=;
 b=NMl2/fxuAltXNrPP6W53YuC0yiHMO/l/uy2xIQ75IKJX3SYL7WyY4kStjz8lZrN41S
 jyfuO5gfZOnl/FMo41P+1kUUyju6dxjUKL1ueNI3Xc1EEWTJwOCrdAC1aWBsz7+QxmQi
 tbW7FPmwXXpo8vy1yyOn+5G6p+zgUvPfckwm1ElGrOHAqSmkmBvAscppouX/aXNyKBL7
 otBGi5jnQTovn3upEIHHHfn4158JVVXHgH8annU/iu7EcMllVXEINnxj7TrnarR09PjQ
 NWy9pO2jxKWsKbIN5pvUZ5hnWMUWDMZp93wvLi6WAWJBHDwQQvNO5TkhlZwRhmMsBvKA
 bPzg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781793184; x=1782397984; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJrHSixspHjfMRFrkJOSeFkO4cK0hPkIV3hmNy4buJ4=;
 b=UDJYBfJqhpxNxVAQqqJRJl3csxJED403YtAhr10x5CdIn67pSA4cSBg2HqrCpwtE+6
 RSN7WZPZ3e14+EQBOCGSD3/FgwWsF07iv0Fe6NPWFTnGv5P2DP3cfBtQL/yEOnNWCgzi
 8LswenpxYQjYznbkHvMEYNSQoYUkO9cVor7RLYLbSgPV44Rr1wrKzPLS/QR1rGSyR6Cs
 xCXY8n6fpIWt5UAIIjy8SJRdWHTCUkotsY+w6Kg4svyWS8o7pYXiTW6uv613DSC2CUVb
 ZIySwmbFVCcXxJu3x4LcrJF2hivLV3vNDE1rXdNTxYwfHPsHRsTyMuNBWQfRuvLmDK8t
 URtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781793184; x=1782397984;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cJrHSixspHjfMRFrkJOSeFkO4cK0hPkIV3hmNy4buJ4=;
 b=J9KI/+izXIVSig91dbLkkXwDMuCEA6EfeL9S7XJu/LVd/NjrrhEoxBygMofvKC811s
 Snwu9RRKCnPv1deFTOHMgIrolm58LCF1pahBQAxioobAvK3gXmSsr0t8xPqlIuCEKJwv
 wQHLQcEtJ0x7LI1Y2QgktkPTv5/f0R/ECxG73H2RmGlyCQBNQKVqv5+Pihi4R9tO0ONe
 QEw+gfew+uOeez62Nn4W7CS1riepVbTKifMt0B0TBSWUNu81LOofbpnP4KhRiheH5Eli
 UKfJ32H/KSXx94emHTPVifGPYIlqJm0bAVHSSVFxWHQx6ElvP47xTrHClhACFmqv+sRW
 5v2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hzt5WsEcFKBtpNdQTHyWXaVoYuMU4AEfi0rLfw0iOEI4HjtGAGMdiSlZBqgn1wpZYA8vBSf8vu5Wd@nongnu.org
X-Gm-Message-State: AOJu0Yyn0HdJBJNnVprMILQCBixdEDbmvTWdTYVWjZx59HiwQgnywMts
 JwzSkTqtYL3j1vv1MmfJ+EvfIeeiP248kixcuYNoyASzTMqpCoRR51BBbM3FAF5io65EEzr2iWt
 gHWPUlkPpcP1PQkv2bkr2a20bFGZN7PxuMtSf7EVQ9ow0LzbgafrYMvBjmlu/jMLB89MzDVOEGh
 BkN6e8qaUypWueh5Q2q65VOEPxpkMFiaU=
X-Gm-Gg: Acq92OHjpWlxxTRUSCxM6edLgy20rwtzq0RJslDy2Gb/E0IneuJEIwhD7938BYA02KB
 zNLfUJ8mq2+OpQVFfLoZMyjx7Om1PjHg51QHwVVVuGV7lviYLHY0dLS60uLPjs/rRHF8st7x6dr
 XMPPh6tkZEAa4b1oLa9iaHDPHIUw1eWM0Cht3AfhZ1K5fWm2/zo6Zulxw7cuXKpF/Rg9CQwzyAo
 vp3ZSz18sMYCbc3PqwW2aCn2H4=
X-Received: by 2002:a05:6808:1205:b0:488:f11e:65a6 with SMTP id
 5614622812f47-48942a35d57mr7205087b6e.43.1781793183831; 
 Thu, 18 Jun 2026 07:33:03 -0700 (PDT)
X-Received: by 2002:a05:6808:1205:b0:488:f11e:65a6 with SMTP id
 5614622812f47-48942a35d57mr7205053b6e.43.1781793183360; Thu, 18 Jun 2026
 07:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260618125442.641532-1-mbawa@redhat.com>
 <20260618125442.641532-2-mbawa@redhat.com>
 <CAFEAcA9BtQ3DyuoqYEKcNYK-dncxmxXiS1zm51-6OuY5A8m=zA@mail.gmail.com>
In-Reply-To: <CAFEAcA9BtQ3DyuoqYEKcNYK-dncxmxXiS1zm51-6OuY5A8m=zA@mail.gmail.com>
From: Mohammadfaiz Bawa <mbawa@redhat.com>
Date: Thu, 18 Jun 2026 20:02:45 +0530
X-Gm-Features: AVVi8CcU4hijSek8mmWfdE52udmYfpJSTbTz2n_1LLuvAO2eSii4kzY1v02nP18
Message-ID: <CAJg9KkxppD2yJaEpbBETpyYMtXcoi6s4VMDt0Mevb_r0uD7geA@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/tpm: gate PPI support on tpm-tis-device behind a
 device property
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jun 18, 2026 at 6:39=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Thu, 18 Jun 2026 at 13:55, Mohammadfaiz Bawa <mbawa@redhat.com> wrote:
> >
> > Add a "ppi" boolean property (default: true) to tpm-tis-device.
> > When ppi=3Doff the RAMBlock is never registered and the migration
> > stream omits "tpm-ppi", restoring backward compatibility.
> >
> > When disabled, realizefn initializes the region with zero size so
> > the platform bus skips it and ACPI PPI tables are omitted.
> >
> > Fixes: 46cd2c1050f0 ("hw/tpm: add PPI support to tpm-tis-device for ARM=
64 virt")
> > Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> > ---
> >  hw/tpm/tpm_tis.h        |  1 +
> >  hw/tpm/tpm_tis_sysbus.c | 16 +++++++++++-----
> >  2 files changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
> > index 1531620bf9..6ac9804050 100644
> > --- a/hw/tpm/tpm_tis.h
> > +++ b/hw/tpm/tpm_tis.h
> > @@ -76,6 +76,7 @@ typedef struct TPMState {
> >      size_t be_buffer_size;
> >
> >      TPMPPI ppi;
> > +    bool ppi_enabled;
> >  } TPMState;
> >
> >  extern const VMStateDescription vmstate_locty;
> > diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> > index 16bb17874b..54691ac272 100644
> > --- a/hw/tpm/tpm_tis_sysbus.c
> > +++ b/hw/tpm/tpm_tis_sysbus.c
> > @@ -94,6 +94,7 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
> >  static const Property tpm_tis_sysbus_properties[] =3D {
> >      DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_I=
RQ),
> >      DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
> > +    DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, true),
> >  };
> >
> >  static void tpm_tis_sysbus_initfn(Object *obj)
> > @@ -122,14 +123,19 @@ static void tpm_tis_sysbus_realizefn(DeviceState =
*dev, Error **errp)
> >          return;
> >      }
> >
> > -    s->ppi.buf =3D qemu_memalign(host_page_size,
> > -                               ROUND_UP(TPM_PPI_ADDR_SIZE, host_page_s=
ize));
> >      memory_region_init_io(&s->mmio, OBJECT(dev), &tpm_tis_memory_ops,
> >                            s, "tpm-tis-mmio",
> >                            TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY_S=
HIFT);
> > -    memory_region_init_ram_device_ptr(&s->ppi.ram, OBJECT(dev), "tpm-p=
pi",
> > -                                      TPM_PPI_ADDR_SIZE, s->ppi.buf);
> > -    vmstate_register_ram(&s->ppi.ram, dev);
> > +
> > +    if (s->ppi_enabled) {
> > +        s->ppi.buf =3D qemu_memalign(host_page_size,
> > +                                   ROUND_UP(TPM_PPI_ADDR_SIZE, host_pa=
ge_size));
> > +        memory_region_init_ram_device_ptr(&s->ppi.ram, OBJECT(dev), "t=
pm-ppi",
> > +                                          TPM_PPI_ADDR_SIZE, s->ppi.bu=
f);
> > +        vmstate_register_ram(&s->ppi.ram, dev);
> > +    } else {
> > +        memory_region_init(&s->ppi.ram, OBJECT(dev), "tpm-ppi", 0);
> > +    }
>
> Is it valid to create a 0-size memory region? I think the more
> usual approach here would be to not expose the 2nd MMIO region
> if the device was configured with PPI disabled.
>
> This device also very weirdly calls sysbus_init_mmio() in
> its initfn, before it has actually set up the MR, which it
> is doing here in realize. I think that also needs to be fixed
> (especially since the property will only be available in
> realize). It happens to work since all sysbus_init_mmio()
> is doing is putting the pointer into its data structure, but
> it doesn't make much logical sense to do it that way around.
>
> thanks
> -- PMM
>
Agreed. I initially considered not exposing the 2nd MMIO region
at all when PPI is disabled, but I followed the existing
pattern in initfn. You're right that it's cleaner to just not register it.

I'll move both sysbus_init_mmio() calls to realizefn so the MR are
properly initialized before being registered, and only expose the PPI
region when ppi=3Don.

Is it fine to include this refactoring (moving sysbus_init_mmio() to realiz=
efn)
in this same series, or would it be preferable as a separate patch?

Will send a v2.

Thanks,
Faiz


