Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B807DD41C36
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 13:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTgsR-00078D-Nf; Thu, 11 Dec 2025 08:38:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vTgsP-00077C-Ih
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 08:38:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vTgsM-0003YH-Sn
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 08:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765460313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GBh/8NIQqys6QJswMp8b1itNilxMD9uFW2if3/q3fDk=;
 b=PNESQphAi0B8PS3Opxvng98O4TWTkehwFqKmM46EOkvOPaCcQeacti/SVWHwF//rt/3jhD
 C/JRZ5CALOpE+B900312Ah8L0d2+TpFy+bP5VwYrKR6eeisg7cDOHkh67xQGxcdpnAsmyi
 yzQaQu59SXfFXFfjdhH6unYjrTSsurc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-xac3Z9pIMB-Crve4Z9xpbQ-1; Thu, 11 Dec 2025 08:38:29 -0500
X-MC-Unique: xac3Z9pIMB-Crve4Z9xpbQ-1
X-Mimecast-MFC-AGG-ID: xac3Z9pIMB-Crve4Z9xpbQ_1765460308
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779edba8f3so675655e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 05:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765460308; x=1766065108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GBh/8NIQqys6QJswMp8b1itNilxMD9uFW2if3/q3fDk=;
 b=Qt5gdaRN/nsEXZe870eZe/KH1JER88sxug+kq7jSi0zzbkh58BLms/rXBBPEjRrXHW
 y+yHUDy+lmEY6iyLFm6kMt6Pu/u7q9xO9wX8okJQipXJhJctv1Sz8zYtSt4g/X5L+GUN
 SeLrutL2fuWCgd7GJvMxrl/T+o/WX7mSYYC5cKvcwIcY/11lGwLISHt5YPXJDiPXEqex
 zpcmD5jxE+ylw2SeHf60aFA/yKVWNVUWvh/uLo1O+8FyJzcn8buVn6amcGINyt4L+PiN
 GidCyHUcZQ2x8gIROm/BNklbqliqOuJNUrc3I7CAXNPxLBcQ5Dh42MhRDnPZ7pzJxsQk
 KNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765460308; x=1766065108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GBh/8NIQqys6QJswMp8b1itNilxMD9uFW2if3/q3fDk=;
 b=UKVN7eWIJaNWuEKEo5/lbt+/x5vUVROIIpq92nAGwIelBwzPv/QhkogTBsSBhxT6eO
 1q80/45OYd4mRQuLdqreWpHLYWCwxDX8ko4Fkww6K5nZ4MjtAJynzMTacEMkTcaQ+0Qq
 9bLBQPUQ8+WwklvJ8oPEWnLzOnzS+ZxSiOpSdsN2LeSBj+YrxzyaDvsn1/6JX/PTQuZa
 hJhH2peSr+PNVJDEC3K6vGPPi45/tMJl+qYAcEoocQAITxJv13v7vcjawb8XNsJFsCw9
 RgNscIDvhAwW13ayOSr9c2RxNCTB+4fAdcCauRVgMgm87imXlB4oGbhWOILPF1k4gnVi
 70/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL5cgmmO0fGopXQqqBVEUIVmWxxN3W2lE4vohUb8BeWosWxh3dlvbPiSZvcB1YAeCkr7LlFtl9AzKC@nongnu.org
X-Gm-Message-State: AOJu0Yxci9PXgPWwa4s8Uo7Wstyi4+MmICizn5AMyZ6Tht9vgJXtldOf
 9zTbF3Yt1/jM/MyMI34KQtVJZGN3dtY3ZhB7fTgURFmgooYK27pHyHIx52KB+0zSSkPiGmOhFNq
 0wdCHcgAbbSb+6b2kwFEaPfMomOGcId2ulIq7n/Ql5dv1vSY/BHiMYAI+
X-Gm-Gg: AY/fxX4gg7Z9SeRUlLgUGjGlGnL3uKri4FfFyfs/cO1QR1sn5xHOQrzpA0JsWgLG2AT
 xEAoejtESn91b5hUdWv4ulUMkoAPelqSRUAw2ymqmGOeR48mGLcCkqcZ0rknQ5HcKyoH+mpv+dj
 xCQGCRMSBcluwUpIKDjZIzW9Bzu1W6yYzaqbDi/NLMaRaRkzwM6Dqxt8HPdE7SPVa8r1UaqVMcp
 JD/DRi5bz/wtL1tPwgtJzLn+8fsol+leSy2zeDxxUs/lwfextHWc0QuABCcqzAlSOImwOGR317W
 zcG4HvJBTQLdkgLGX79Y3fx4nn4PX6IJqSoYcbwYPeLLFH6h6ZJWmfPvhr7bxo8Aq8r7KA==
X-Received: by 2002:a05:600c:4744:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-47a8374ceecmr61520745e9.3.1765460308224; 
 Thu, 11 Dec 2025 05:38:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvSC9KCUQJuMW49B/sGWIzCrcfwWyYnkKSlnd3tnVD2FqwiD7yI1ZElYhY0Z10NotATY80jA==
X-Received: by 2002:a05:600c:4744:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-47a8374ceecmr61520455e9.3.1765460307730; 
 Thu, 11 Dec 2025 05:38:27 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a89f2a2fesm35057315e9.4.2025.12.11.05.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 05:38:27 -0800 (PST)
Date: Thu, 11 Dec 2025 14:38:25 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Andrey Ryabinin <arbn@yandex-team.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] q35: Fix migration of SMRAM state
Message-ID: <20251211143825.1771439d@imammedo>
In-Reply-To: <3f126358-377f-4b4a-9fe5-dd361ba662ee@yandex-team.com>
References: <20251203180851.6390-1-arbn@yandex-team.com>
 <20251210144055.3351d435@imammedo>
 <3f126358-377f-4b4a-9fe5-dd361ba662ee@yandex-team.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 11 Dec 2025 16:51:44 +0900
Andrey Ryabinin <arbn@yandex-team.com> wrote:

> On 12/10/25 10:40 PM, Igor Mammedov wrote:
> > On Wed,  3 Dec 2025 19:08:51 +0100
> > Andrey Ryabinin <arbn@yandex-team.com> wrote:
> >  =20
> >> mch_update_smbase_smram() essentially uses wmask[MCH_HOST_BRIDGE_F_SMB=
ASE]
> >> to track SMBASE area state. Since 'wmask' state is not migrated is not
> >> migrated, the destination QEMU always sees
> >>  wmask[MCH_HOST_BRIDGE_F_SMBASE] =3D=3D 0xff
> >>
> >> As a result, when mch_update() calls mch_update_smbase_smram() on the
> >> destination, it resets ->config[MCH_HOST_BRIDGE_F_SMBASE] and disables
> >> the smbase-window memory region=E2=80=94even if it was enabled on the =
source. =20
> >=20
> > [...]
> >  =20
> >> +static void mch_smbase_smram_post_load(MCHPCIState *mch)
> >> +{
> >> +    PCIDevice *pd =3D PCI_DEVICE(mch);
> >> +    uint8_t *reg =3D pd->config + MCH_HOST_BRIDGE_F_SMBASE;
> >> +
> >> +    if (!mch->has_smram_at_smbase) {
> >> +        return;
> >> +    }
> >> +
> >> +    if (*reg =3D=3D MCH_HOST_BRIDGE_F_SMBASE_IN_RAM) {
> >> +        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =3D
> >> +            MCH_HOST_BRIDGE_F_SMBASE_LCK;
> >> +    } else if (*reg =3D=3D MCH_HOST_BRIDGE_F_SMBASE_LCK) {
> >> +        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =3D 0;
> >> +    }
> >> +} =20
> > You are correctly pointing to the issue about non-migratable wmask cont=
rolling
> > config[], it should be other way around.
> >=20
> > given reset already sets
> >   wmask[MCH_HOST_BRIDGE_F_SMBASE] && config[MCH_HOST_BRIDGE_F_SMBASE]
> > to default values, we don't need to do the same in mch_update_smbase_sm=
ram()
> > so we can just drop it.
> >=20
> > Also I wouldn't introduce a dedicated mch_smbase_smram_post_load() thou=
gh,
> > since mch_post_load() already calls mch_update_smbase_smram() indirectl=
y,
> > I'd rather fix the later.
> >=20
> > Would following work for you:
> >=20
> > diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> > index a708758d36..7a85a349bd 100644
> > --- a/hw/pci-host/q35.c
> > +++ b/hw/pci-host/q35.c
> > @@ -431,31 +431,25 @@ static void mch_update_smbase_smram(MCHPCIState *=
mch)
> >          return;
> >      }
> > =20
> > -    if (*reg =3D=3D MCH_HOST_BRIDGE_F_SMBASE_QUERY) {
> > -        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =3D
> > -            MCH_HOST_BRIDGE_F_SMBASE_LCK;
> > -        *reg =3D MCH_HOST_BRIDGE_F_SMBASE_IN_RAM;
> > -        return;
> > -    }
> > -
> >      /*
> > -     * default/reset state, discard written value
> > -     * which will disable SMRAM balackhole at SMBASE
> > +     * reg value can come either from register write/reset/migration
> > +     * source, update wmask to be in sync with it regardless of source
> >       */
> > -    if (pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =3D=3D 0xff) {
> > -        *reg =3D 0x00;
> > +    switch (*reg) {
> > +    case MCH_HOST_BRIDGE_F_SMBASE_QUERY:
> > +        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =3D MCH_HOST_BRIDGE_F_SMBA=
SE_LCK;
> > +        *reg =3D MCH_HOST_BRIDGE_F_SMBASE_IN_RAM;
> > +        return;
> > +    case MCH_HOST_BRIDGE_F_SMBASE_LCK:
> > +        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =3D 0;
> > +        break;
> > +    case MCH_HOST_BRIDGE_F_SMBASE_IN_RAM:
> > +        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =3D MCH_HOST_BRIDGE_F_SMBA=
SE_LCK;
> > +        break;
> >      }
> > =20
> >      memory_region_transaction_begin();
> > -    if (*reg & MCH_HOST_BRIDGE_F_SMBASE_LCK) {
> > -        /* disable all writes */
> > -        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] &=3D
> > -            ~MCH_HOST_BRIDGE_F_SMBASE_LCK;
> > -        *reg =3D MCH_HOST_BRIDGE_F_SMBASE_LCK;
> > -        lck =3D true;
> > -    } else {
> > -        lck =3D false;
> > -    }
> > +    lck =3D *reg & MCH_HOST_BRIDGE_F_SMBASE_LCK; =20
>=20
>=20
> This change makes strict adherence to the negotiation protocol unnecessar=
y. As a result:
>  - Writes performed before MCH_HOST_BRIDGE_F_SMBASE_QUERY are no longer i=
gnored.
>  - The guest can set MCH_HOST_BRIDGE_F_SMBASE_LCK immediately.
>  - The guest can now set MCH_HOST_BRIDGE_F_SMBASE_IN_RAM, which was previ=
ously impossible.
>=20
> Perhaps this is acceptable =E2=80=94 it may simply expose misbehaving gue=
st behavior, I=E2=80=99m not sure,
> I'm no expert here. But it does raise the question of why these restricti=
ons existed
> in the first place.

main point of this is discovery of the feature and enabling/locking backhol=
e.
and only the last (#3 in original commit says anything wrt further writes).

so yes, above change will open up ability to write MCH_HOST_BRIDGE_F_SMBASE=
_IN_RAM
with out the same outcome as MCH_HOST_BRIDGE_F_SMBASE_QUERY, which ain't br=
eaking
anything. But it's pointless as it doesn't really tell guest if the feature=
 is available.
There must be asymmetric write 0xff with following read 0x1 read to occur, =
otherwise
nothing is guarantied.

the same applies to MCH_HOST_BRIDGE_F_SMBASE_LCK write, without negotiation.
One might get backhole enabled or not, it shouldn't affect existing code th=
at
is written according to described protocol.
Drawback of it would be possibility to guest write new code that could use
backhole effect to check if it's enabled, but then it won't work on older
QEMU and onus is on them to make it follow protocol as described.

I think it should be ok to relax existing restrictions a bit as long as
detection/locking flow works the same as was initially described.

And while I'm not opposed to a dedicated post_load routine, it is ok too.
But considering that we do use mch_update() on migration and write path
anyway and not only for smbase lock, I'm in favor of fixing up
mch_update_smbase_smram() for consistency.

>=20
> Also, if we are lifting these restrictions, tests/qtest/q35-test.c will n=
eed to be updated.
thanks,
I'll fix it up and post a proper patch.

>=20
> >      memory_region_set_enabled(&mch->smbase_blackhole, lck);
> >      memory_region_set_enabled(&mch->smbase_window, lck);
> >      memory_region_transaction_commit();
> >  =20
> >>  static int mch_post_load(void *opaque, int version_id)
> >>  {
> >>      MCHPCIState *mch =3D opaque;
> >> +
> >> +    mch_smbase_smram_post_load(mch);
> >>      mch_update(mch);
> >>      return 0;
> >>  } =20
> >  =20
>=20


