Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E59EDE99D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 15:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so2ra-0003ng-1e; Tue, 10 Sep 2024 11:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1so2rY-0003g9-Eh
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 11:33:04 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1so2rV-0007fD-B6
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 11:33:04 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c26815e174so6104729a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 08:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725982379; x=1726587179; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=673+7126m/PgbKBQHUor/H7+hwjYoEYu+WIMR/3/Ws8=;
 b=MGR9nvrIFVEtmEc+MA0651R9/prt7q1VEmlsLNFbSuBRQaASpJ+lS/EYkM8hW27F9u
 f9UACaj9uIISJaHcGh1Es24Fo6bXjsGIdk9CYryDvtjzUoZT89k7wV6dzQp1jSGDxn/C
 gQbwjyoAMnxNGgqLWbiA/tZ1u4fsVxL1PlkL4UDRNZueF4QaOY6DfG5+dX4LpvWTgqJo
 FrSzQ17wpgvJSxAyFcn+6JRoMA4j3WQw72pSPIPgjW5zXTi5zJDN0O9OkwixnIp5Eozu
 Q74i9Tc90hzxfGifzoFxUa/l4vZe6eP4AobyHldcCc/FAD2CU/ldXL8DCuACK2Bq3Rtu
 FpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725982379; x=1726587179;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=673+7126m/PgbKBQHUor/H7+hwjYoEYu+WIMR/3/Ws8=;
 b=rS9pPiu/LoUvKMRxpeQR8DO1bNErUeitOVGIbOG8B34ikyFaF3GpiYJypwyV1ouazM
 prJPRfgYN3V66FDWG8v5ihzskxWMyXysZO4OsnKZLY8KyqbpFGxYCmW+5mjb9Cwpk0zn
 QLXjelfiuV1xYkJbXKdMiPGsuZ4p2KnmwsqWrZ+Szu5PdQAZcb47RM2Q5hYPxznyuYQd
 tI/aD8LBb1xjb+2BsPYfXc0z3KEd+vcz3aAgM39WbvlS6TA+7wSyxjbkyN6owz9L8C7L
 dvAnWM4CS4xc0i+MeZIhoY2E/oGaChm3+tw2nn/UsGBf0/ewPLqGU8bozIkz5vS3qLqR
 3tzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfuCzGwO4A68HERvPqLIrSa2YKGEQJK6FtTojm9yyvBdPBwHp5GN625kHW6aq/NOoXdizU6flnbdHX@nongnu.org
X-Gm-Message-State: AOJu0YyMhwZ3A3aTCCaoH0e2AOmye3N5FDvO5zhG7P9PhVVIxcoqJxyD
 Kd8QRXSQeb5/owGUSu7Ktxpjb55w/J1VOcryuwVDh90YmgXDrT83GdWAONMiaRxMrLo+RxnIumJ
 eS6Gj8KauWBb+E/iP1V0M8pbkCnmZvy8Mcs/tGA==
X-Google-Smtp-Source: AGHT+IHM9Y82FUV6Qkb5GXSnrEbcTNb9FR+tIdnMPKDHRIq1BmAr/Za8Vkbqkb9S+xPVCK1J2/TTPDEI1cJG1nI25zM=
X-Received: by 2002:a05:6402:5cd:b0:5c3:cc7d:c29d with SMTP id
 4fb4d7f45d1cf-5c3e95354abmr7938111a12.6.1725982379388; Tue, 10 Sep 2024
 08:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240816103723.2325982-1-cohuck@redhat.com>
 <Zr8uNB8gaJTroMBU@redhat.com> <Ztn21z0ZR3_MiVQJ@redhat.com>
 <CAFEAcA9ToJuZwGkJr2gCRf63uJom0b0QpdVv-OrAVVUGwB_2wQ@mail.gmail.com>
 <20240910113131-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240910113131-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2024 16:32:47 +0100
Message-ID: <CAFEAcA9M-MUqTxjXOUVyOcYjGi+8LusoYh19Au4nhuE+ty2u=A@mail.gmail.com>
Subject: Re: [PATCH for-9.2] hw: add compat machines for 9.2
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>, 
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 10 Sept 2024 at 16:31, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Sep 05, 2024 at 08:05:14PM +0100, Peter Maydell wrote:
> > On Thu, 5 Sept 2024 at 19:22, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > >
> > > On Fri, Aug 16, 2024 at 11:47:16AM +0100, Daniel P. Berrang=C3=A9 wro=
te:
> > > > On Fri, Aug 16, 2024 at 12:37:23PM +0200, Cornelia Huck wrote:
> > > > > Add 9.2 machine types for arm/i440fx/m68k/q35/s390x/spapr.
> > > > >
> > > > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > > > > ---
> > > > >  hw/arm/virt.c              |  9 ++++++++-
> > > > >  hw/core/machine.c          |  3 +++
> > > > >  hw/i386/pc.c               |  3 +++
> > > > >  hw/i386/pc_piix.c          | 15 ++++++++++++---
> > > > >  hw/i386/pc_q35.c           | 13 +++++++++++--
> > > > >  hw/m68k/virt.c             |  9 ++++++++-
> > > > >  hw/ppc/spapr.c             | 15 +++++++++++++--
> > > > >  hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
> > > > >  include/hw/boards.h        |  3 +++
> > > > >  include/hw/i386/pc.h       |  3 +++
> > > > >  10 files changed, 77 insertions(+), 10 deletions(-)
> > > >
> > > > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > >
> > > >
> > > > > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > > > > index d9e69243b4a7..746bfe05d386 100644
> > > > > --- a/hw/i386/pc_piix.c
> > > > > +++ b/hw/i386/pc_piix.c
> > > > > @@ -479,13 +479,24 @@ static void pc_i440fx_machine_options(Machi=
neClass *m)
> > > > >                                       "Use a different south brid=
ge than PIIX3");
> > > > >  }
> > > > >
> > > > > -static void pc_i440fx_machine_9_1_options(MachineClass *m)
> > > > > +static void pc_i440fx_machine_9_2_options(MachineClass *m)
> > > > >  {
> > > > >      pc_i440fx_machine_options(m);
> > > > >      m->alias =3D "pc";
> > > > >      m->is_default =3D true;
> > > > >  }
> > > > >
> > > > > +DEFINE_I440FX_MACHINE(9, 2);
> > > > > +
> > > > > +static void pc_i440fx_machine_9_1_options(MachineClass *m)
> > > > > +{
> > > > > +    pc_i440fx_machine_9_2_options(m);
> > > > > +    m->alias =3D NULL;
> > > > > +    m->is_default =3D false;
> > > > > +    compat_props_add(m->compat_props, hw_compat_9_1, hw_compat_9=
_1_len);
> > > > > +    compat_props_add(m->compat_props, pc_compat_9_1, pc_compat_9=
_1_len);
> > > > > +}
> > > > > +
> > > > >  DEFINE_I440FX_MACHINE(9, 1);
> > > > >
> > > > >  static void pc_i440fx_machine_9_0_options(MachineClass *m)
> > > > > @@ -493,8 +504,6 @@ static void pc_i440fx_machine_9_0_options(Mac=
hineClass *m)
> > > > >      PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> > > > >
> > > > >      pc_i440fx_machine_9_1_options(m);
> > > > > -    m->alias =3D NULL;
> > > > > -    m->is_default =3D false;
> > > > >      m->smbios_memory_device_size =3D 16 * GiB;
> > > >
> > > > Feels like we should be adding an "_AS_LATEST" macro
> > > > variant for piix/q35 too, so it matches the pattern
> > > > in other targets for handling alias & is_default.
> > > >
> > > > Not a thing your patch needs todo though.
> > >
> > > I've just a patch that does that now. If it looks good & you want to =
include
> > > it as a pre-requisite for your patch here feel free to grab, otherwis=
e I can
> > > rebase it after your patch merges.
> >
> > I have this patch in my target-arm pullreq that's currently posted
> > and pending merge, by the way.
> >
> > -- PMM
>
> Ok feel free to tack on
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Too late, this is already in git as commit fb6051e7bb2bd.

-- PMM

