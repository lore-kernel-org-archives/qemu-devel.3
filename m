Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6351CE7A81
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 19:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smHnQ-0004df-Pd; Thu, 05 Sep 2024 15:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smHnP-0004cf-G0
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:05:31 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smHnN-0007ez-Jd
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:05:31 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2f64cc05564so13606371fa.2
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 12:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725563127; x=1726167927; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/MP4tMhhHd/mwpBAPnELAzIOaMl8ctE+gXPc38noHU=;
 b=hy9kLAf82OaeRa65lP3X3F3et3OpzzH8uxO1/20urHaFnInn3sV035J2qYiIggKnb/
 Cwatb9CrxnmloHqqv1zc9Fqe5bHGGQlEszGC/R7wf3qABkI7pPIdrqyLBiGstosAwoIl
 shP58fWUq+KuYD6ldPa7kHt8L2z3Jv5U9/mc8anWWUrsugVzKq+vzGj8kIxvmxzKIUWf
 MWS5KDA51qjIX6Jh0lZbyZCCUAso/aBXjCmMI7imJc5A7DsJXW6nUqHkG/CXX4nbCZOp
 Iv2Ph5rP39F0JYYDbrqJycmj8FmjZCoYV3JCfUF7fP5Hjpnri5tn6pqNsXfDDRkfOrr4
 yyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725563127; x=1726167927;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d/MP4tMhhHd/mwpBAPnELAzIOaMl8ctE+gXPc38noHU=;
 b=WVGhfRgq9cmvlIxlEMN3yJboLc0TMVRaoWUGzmxjbpOnPVt2t7PkwL4CHmV3qLyKjw
 x1TeS4BVZgEMSxa8mhKZwDiKZTRgpxQtfvcNpib6xbLjlOLSw8rGr6kxe1EVSgZD0N1a
 qWj/+p+lDrph/ULoAyo8QfROx8Oi/yxK/XDiJ20fwgRHWury9jcL3UDihzWsGXizleYm
 lKxqZOGf+5NtcvUyaWRXlml4vPR4LJ2qJAjFJhlFMvakgafwcA/cQYB/PrZNVG+ztBq1
 5FN7USwEvsfnWcLKnfoQ7xMqxv1raYZ7IlsG4W/MioWw++up+0tjqVJGjJJ5fHKNQ8gM
 2NTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXka81jsddvkAGC0pIyNdvbC5hL5Nzh1G4DQ+PfbGuVqb79xKiouCHoZq9oInIu/FgcVKYLA8XZxxhr@nongnu.org
X-Gm-Message-State: AOJu0YyW/IHmzK51q+z1XLRb8ap7a8EjmcLMl9UlIia8rmkEmXvqBEcM
 c1i26Z7nUxOQRjdxzTEwO06R6aBmOvdBye93fap+9Jtt1i1fQv5vKCvJIOj7T032lx8bB1trI2V
 te4YOsEVHc8QTSRxIdOnBmlAgLY95rYwGtxr0wg==
X-Google-Smtp-Source: AGHT+IFRWfWBKIV44993VzDwOsdKXkassBAsGDZNJOIiWYd4seejaYuPFNiTT7voCESgxTn/VPY2GBZPE+91gsj3pLA=
X-Received: by 2002:a2e:be84:0:b0:2f4:fd6a:be38 with SMTP id
 38308e7fff4ca-2f751eaef73mr856431fa.2.1725563127070; Thu, 05 Sep 2024
 12:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240816103723.2325982-1-cohuck@redhat.com>
 <Zr8uNB8gaJTroMBU@redhat.com> <Ztn21z0ZR3_MiVQJ@redhat.com>
In-Reply-To: <Ztn21z0ZR3_MiVQJ@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Sep 2024 20:05:14 +0100
Message-ID: <CAFEAcA9ToJuZwGkJr2gCRf63uJom0b0QpdVv-OrAVVUGwB_2wQ@mail.gmail.com>
Subject: Re: [PATCH for-9.2] hw: add compat machines for 9.2
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 5 Sept 2024 at 19:22, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Fri, Aug 16, 2024 at 11:47:16AM +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Fri, Aug 16, 2024 at 12:37:23PM +0200, Cornelia Huck wrote:
> > > Add 9.2 machine types for arm/i440fx/m68k/q35/s390x/spapr.
> > >
> > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > > ---
> > >  hw/arm/virt.c              |  9 ++++++++-
> > >  hw/core/machine.c          |  3 +++
> > >  hw/i386/pc.c               |  3 +++
> > >  hw/i386/pc_piix.c          | 15 ++++++++++++---
> > >  hw/i386/pc_q35.c           | 13 +++++++++++--
> > >  hw/m68k/virt.c             |  9 ++++++++-
> > >  hw/ppc/spapr.c             | 15 +++++++++++++--
> > >  hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
> > >  include/hw/boards.h        |  3 +++
> > >  include/hw/i386/pc.h       |  3 +++
> > >  10 files changed, 77 insertions(+), 10 deletions(-)
> >
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >
> >
> > > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > > index d9e69243b4a7..746bfe05d386 100644
> > > --- a/hw/i386/pc_piix.c
> > > +++ b/hw/i386/pc_piix.c
> > > @@ -479,13 +479,24 @@ static void pc_i440fx_machine_options(MachineCl=
ass *m)
> > >                                       "Use a different south bridge t=
han PIIX3");
> > >  }
> > >
> > > -static void pc_i440fx_machine_9_1_options(MachineClass *m)
> > > +static void pc_i440fx_machine_9_2_options(MachineClass *m)
> > >  {
> > >      pc_i440fx_machine_options(m);
> > >      m->alias =3D "pc";
> > >      m->is_default =3D true;
> > >  }
> > >
> > > +DEFINE_I440FX_MACHINE(9, 2);
> > > +
> > > +static void pc_i440fx_machine_9_1_options(MachineClass *m)
> > > +{
> > > +    pc_i440fx_machine_9_2_options(m);
> > > +    m->alias =3D NULL;
> > > +    m->is_default =3D false;
> > > +    compat_props_add(m->compat_props, hw_compat_9_1, hw_compat_9_1_l=
en);
> > > +    compat_props_add(m->compat_props, pc_compat_9_1, pc_compat_9_1_l=
en);
> > > +}
> > > +
> > >  DEFINE_I440FX_MACHINE(9, 1);
> > >
> > >  static void pc_i440fx_machine_9_0_options(MachineClass *m)
> > > @@ -493,8 +504,6 @@ static void pc_i440fx_machine_9_0_options(Machine=
Class *m)
> > >      PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> > >
> > >      pc_i440fx_machine_9_1_options(m);
> > > -    m->alias =3D NULL;
> > > -    m->is_default =3D false;
> > >      m->smbios_memory_device_size =3D 16 * GiB;
> >
> > Feels like we should be adding an "_AS_LATEST" macro
> > variant for piix/q35 too, so it matches the pattern
> > in other targets for handling alias & is_default.
> >
> > Not a thing your patch needs todo though.
>
> I've just a patch that does that now. If it looks good & you want to incl=
ude
> it as a pre-requisite for your patch here feel free to grab, otherwise I =
can
> rebase it after your patch merges.

I have this patch in my target-arm pullreq that's currently posted
and pending merge, by the way.

-- PMM

