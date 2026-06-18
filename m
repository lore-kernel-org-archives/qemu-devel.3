Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FF7CD98F6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waE3i-0001Ek-5r; Thu, 18 Jun 2026 10:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waE3g-0001EX-T8
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:49:32 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waE3f-0002dP-AZ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:49:32 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-66077e90382so1071192d50.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 07:49:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781794170; cv=none;
 d=google.com; s=arc-20240605;
 b=OQ4aghQvGMo/q2im1tsey/3h546kmHWZCWcuo7bGOMvz5Mc10ttqS0oOOotmMnViLv
 kakMo+jMytLEK6+qW5i7fJQwbl2LIO2ebhDkEakXnhr9h55aqGjjNPL4tSUU7lSe5Jav
 DEbtrSofvxqarpY/f+PIsQ3bMro9kNYGMCuDvvvQYoCWCvKMk076hgz+l/VBOANnvsJv
 tTj+37Ses0tKyAVZdFS3IYy3i8Dawu1EdLCqWvqO9gIliLrXmhodyRXVZuRI1qa9WItX
 maHDaabxiIMjCrpwx4+x68nao18OK3hj+qzA/PFrHfTgdBBzBuY7gPwwm3UPWxDtEDDv
 bIcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3laHmjOQlANmr3X0E/kokaD/C6j0alh3CT6lAJ2DGqs=;
 fh=chhjV7bHuNR9/QsbsvDGFtnP52wjSmqnTdWu7XtddOM=;
 b=B9UNrkYC8DAnw6KM3jiYNqb1sM6zRhCN1e2MKPGb0P8+KZz3Me3uSB20Xkp3ZhTgBM
 vxBSaV08YIZAuinz+8J01VypTNfBo8LgwCnRlKPyib0lbnHTbVINuUvM80R9MVw7NOio
 Wq8hgAE9Pm5n3WIw9rnuzZKcra2+V3/P5tc9TGTfgiArKuzXOl43DydMUV/F8vTsKjum
 AOBvip2EPaq7156LghquAAAnoX2HG/RF2PAgKDDB6PDGRV9UHXZFmwl0w3X8RtGF/JCM
 Di/dJcB0G0Xos6Y3X80fR2zNEq9yKiGYoYixMbMjbOPMB/txMlJJ+gQbmK/FH4MflIgM
 GyDA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781794170; x=1782398970; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3laHmjOQlANmr3X0E/kokaD/C6j0alh3CT6lAJ2DGqs=;
 b=BwHH6b/cCDQ0XdxnVdmJu4fqKjtsetDOKxSCef4w9Rq9s6CPPuMauNDfPIaWb9e9z8
 RsxPdWWyMmdtVDdev8DsHkuGXywJ0iREGsddj4ImvymPkLw/EdNiQTJBN6cGjC4+/kBw
 TA68CEJ0wuJ9wvV1APtrJ9mu0Foj/RMV2PCZek4AXj1SPF7zkZmK6AbTPbWYeAQyhxsh
 NeiypQ+d/SXCXaC1Ls2z1LnnSL9cHeyfGBdqY6vMrfVeGlWkjUH1B9BL9fmNqoMdhIsr
 MQ5RGG6lr/hw08YHMe8laWW3CimvCKpAH+3AHENcICMUDOCOvSbMABU6vQw0gGemCUho
 efOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781794170; x=1782398970;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3laHmjOQlANmr3X0E/kokaD/C6j0alh3CT6lAJ2DGqs=;
 b=EfqxDnV+ozYUSOnwNUi3tdbj3j2nBYzhBqujUzSE+RCdnR+0/yCHlCOJrjiK+2Dg7G
 9Vu9Ii2s1DMrSNfPdwamvHfBXfRvEP1AcuKhrajRcvE8A0Uy3GAQz6glaEFXb2O8tDpa
 hNg2Flqiwa11Iwb/qMKPnRp+OLU6xJcJTz6HrYGeW1I3O2ZvIRS4m7N9nNXHu4vRfGCx
 tpSRzZnUkPZaC0FxGBl+8nUsohnpEJswVYMAqzCl88MIXExHjQcLdhhKt44ta2GKEU++
 QRYluFuvglRgJjmN8LM/pu8uEANf92MZd91aGOdkRk4LrJ8vtn5WWJqMog0aTONZYAjj
 +1nA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9szI8j0XQZMP4/XFaH1UNOU7IEAudpG75x8wxP9XwJfYTIIzuwq/oAn80GHpm53LxWDAEgJHp1g+TT@nongnu.org
X-Gm-Message-State: AOJu0YzhW7dt7qM+el5E8YJnzpT0f3vkFqVDpI8suJ024YWPo8a7Giap
 5HtaZPHv7h7urZRopcj4ISf1JBFiNfVmhHu0aC24qbc0ego+5mlMkdP39qIPPGj8FEiflL54ixd
 kDkM2K6+Dqi9+J5PWr/1WlrIV2x5bO2fsz7sNb9ynDQ==
X-Gm-Gg: AfdE7clDdJEaAjQH4x2M+F18H43BMHtAF5qos3rep5oWaJNETLAw3eoK/fYtVI66VDj
 nyF2JYdL6tT7O6D6zE8duhLRxW/I6X9xs3D00RTmSuD5P6kDAzc77CvcBqNYaPSOxB9N7LMqMPu
 +roq6hxWRWGuXCcDVEIIyGYBO0pM5Ea0vsHnCtMrmVpCLiAuUEH3dUo/RkDg9V7Pu4fwJfYzfow
 e9ZqBw4SsNlwHG0eE9NSnzQu781rm9edsR07nyZ7ol6cONDNiTsV9iyQD//kv3PCj18O9i/kx+Y
 G5dku1wzBiq7zk7IBpnA4/SBVVGu2DVjZ4o3O3ozZpsjgkCKpEF3X4Lc
X-Received: by 2002:a05:690e:4004:b0:662:e27b:5f9a with SMTP id
 956f58d0204a3-662ee0a3628mr2717933d50.8.1781794169893; Thu, 18 Jun 2026
 07:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260618125442.641532-1-mbawa@redhat.com>
 <20260618125442.641532-2-mbawa@redhat.com>
 <CAFEAcA9BtQ3DyuoqYEKcNYK-dncxmxXiS1zm51-6OuY5A8m=zA@mail.gmail.com>
 <CAJg9KkxppD2yJaEpbBETpyYMtXcoi6s4VMDt0Mevb_r0uD7geA@mail.gmail.com>
In-Reply-To: <CAJg9KkxppD2yJaEpbBETpyYMtXcoi6s4VMDt0Mevb_r0uD7geA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2026 15:49:18 +0100
X-Gm-Features: AVVi8CcZAxl9viffbt4riISlJ6Jq--_Fq6KHIFe6fzmnktDwRxIGyj0bm2mpYgQ
Message-ID: <CAFEAcA9ede95qznf0FMY=wg1Fy9Qf0ZRF4CQ4irCLqpYb0HZrA@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/tpm: gate PPI support on tpm-tis-device behind a
 device property
To: Mohammadfaiz Bawa <mbawa@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Thu, 18 Jun 2026 at 15:33, Mohammadfaiz Bawa <mbawa@redhat.com> wrote:
>
> On Thu, Jun 18, 2026 at 6:39=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > On Thu, 18 Jun 2026 at 13:55, Mohammadfaiz Bawa <mbawa@redhat.com> wrot=
e:
> > >
> > > Add a "ppi" boolean property (default: true) to tpm-tis-device.
> > > When ppi=3Doff the RAMBlock is never registered and the migration
> > > stream omits "tpm-ppi", restoring backward compatibility.
> > >
> > > When disabled, realizefn initializes the region with zero size so
> > > the platform bus skips it and ACPI PPI tables are omitted.
> > >
> > > Fixes: 46cd2c1050f0 ("hw/tpm: add PPI support to tpm-tis-device for A=
RM64 virt")
> > > Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> > > ---
> > >  hw/tpm/tpm_tis.h        |  1 +
> > >  hw/tpm/tpm_tis_sysbus.c | 16 +++++++++++-----
> > >  2 files changed, 12 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
> > > index 1531620bf9..6ac9804050 100644
> > > --- a/hw/tpm/tpm_tis.h
> > > +++ b/hw/tpm/tpm_tis.h
> > > @@ -76,6 +76,7 @@ typedef struct TPMState {
> > >      size_t be_buffer_size;
> > >
> > >      TPMPPI ppi;
> > > +    bool ppi_enabled;
> > >  } TPMState;
> > >
> > >  extern const VMStateDescription vmstate_locty;
> > > diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> > > index 16bb17874b..54691ac272 100644
> > > --- a/hw/tpm/tpm_tis_sysbus.c
> > > +++ b/hw/tpm/tpm_tis_sysbus.c
> > > @@ -94,6 +94,7 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
> > >  static const Property tpm_tis_sysbus_properties[] =3D {
> > >      DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS=
_IRQ),
> > >      DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
> > > +    DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, true)=
,
> > >  };
> > >
> > >  static void tpm_tis_sysbus_initfn(Object *obj)
> > > @@ -122,14 +123,19 @@ static void tpm_tis_sysbus_realizefn(DeviceStat=
e *dev, Error **errp)
> > >          return;
> > >      }
> > >
> > > -    s->ppi.buf =3D qemu_memalign(host_page_size,
> > > -                               ROUND_UP(TPM_PPI_ADDR_SIZE, host_page=
_size));
> > >      memory_region_init_io(&s->mmio, OBJECT(dev), &tpm_tis_memory_ops=
,
> > >                            s, "tpm-tis-mmio",
> > >                            TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY=
_SHIFT);
> > > -    memory_region_init_ram_device_ptr(&s->ppi.ram, OBJECT(dev), "tpm=
-ppi",
> > > -                                      TPM_PPI_ADDR_SIZE, s->ppi.buf)=
;
> > > -    vmstate_register_ram(&s->ppi.ram, dev);
> > > +
> > > +    if (s->ppi_enabled) {
> > > +        s->ppi.buf =3D qemu_memalign(host_page_size,
> > > +                                   ROUND_UP(TPM_PPI_ADDR_SIZE, host_=
page_size));
> > > +        memory_region_init_ram_device_ptr(&s->ppi.ram, OBJECT(dev), =
"tpm-ppi",
> > > +                                          TPM_PPI_ADDR_SIZE, s->ppi.=
buf);
> > > +        vmstate_register_ram(&s->ppi.ram, dev);
> > > +    } else {
> > > +        memory_region_init(&s->ppi.ram, OBJECT(dev), "tpm-ppi", 0);
> > > +    }
> >
> > Is it valid to create a 0-size memory region? I think the more
> > usual approach here would be to not expose the 2nd MMIO region
> > if the device was configured with PPI disabled.
> >
> > This device also very weirdly calls sysbus_init_mmio() in
> > its initfn, before it has actually set up the MR, which it
> > is doing here in realize. I think that also needs to be fixed
> > (especially since the property will only be available in
> > realize). It happens to work since all sysbus_init_mmio()
> > is doing is putting the pointer into its data structure, but
> > it doesn't make much logical sense to do it that way around.

> Agreed. I initially considered not exposing the 2nd MMIO region
> at all when PPI is disabled, but I followed the existing
> pattern in initfn. You're right that it's cleaner to just not register it=
.
>
> I'll move both sysbus_init_mmio() calls to realizefn so the MR are
> properly initialized before being registered, and only expose the PPI
> region when ppi=3Don.
>
> Is it fine to include this refactoring (moving sysbus_init_mmio() to real=
izefn)
> in this same series, or would it be preferable as a separate patch?

Either is OK, I think -- it's only moving two lines of code.

-- PMM

