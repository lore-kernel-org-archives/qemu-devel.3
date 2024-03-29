Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFCFCD11DD
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 10:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq9d9-0007vG-OU; Fri, 29 Mar 2024 06:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rq9d7-0007uh-Mk
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:38:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rq9d5-0008Dh-Q6
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711708714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OQlEwUNCH7AUCz+RmqMsCPan3tAhOz8EyXg7soUMEKA=;
 b=Gg9wjIayffq8H7sEZAy+V9Et8FGbB3uFYYLII6IsV9hgAFBZprDB8VOkh4/ZDqVElAFVg5
 Aw7iGi+horXEKv8kt3nPEWpXHMj8G5lrWoqcUGHsY+A8hTBkna4OYJB5D+unSyal12uDWV
 pIp7IFWlT/cfRHEbEqxAbzFYieb96WE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-I0jl85ysP9qRffM7RGG1xA-1; Fri, 29 Mar 2024 06:38:32 -0400
X-MC-Unique: I0jl85ysP9qRffM7RGG1xA-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6ea884cceeeso1895447b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 03:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711708711; x=1712313511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQlEwUNCH7AUCz+RmqMsCPan3tAhOz8EyXg7soUMEKA=;
 b=HpiQU7h2T3dKr1PLM3CZQCC78VE0Qc4Nl7J2xR3bRH5iosmbYYKpOO/pXuZP+A2bmh
 uE748MH9qZgtQdXycNZQiS6T8Am1xB1hEvQVH9XtD0Sz9LLe5Mc5PCdmKmv/4yJm1GiV
 UXKIEN8Pc8+3S5SD/U5+Qwg9smW8Wi1dweDGDbwgB/lOU2NqYvlzGORt9oX/pqCnpsOa
 ryZeY+3pSnfNyjfnJCSMWjdqqvJMTRjvcgamWkfWN5QVePIdy0XUVI1Qf3TIy9nS1hhL
 LdA2fq0JyzOSY5dvuRYWJTI7nhqm/lFLhFtnbKXLx0oVM6BuNONumQdxYyX45mF3wvie
 vKcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/yMo47Pg14SBrRlG3qkSX/yi+yKcgaIWlRpwAecmQTS6ZchuqkqZWb9sjCjzdJxqimLR4jgcXQFeMarna7BDEgT6x9YM=
X-Gm-Message-State: AOJu0Yyzec1nQr0B4+z5pk4RujtwBeDwPu9yFCiJjKeTTOwqHlznfDfd
 KNFtNin+DOM/OPNuCgGENqFZaKO7IgadM7JidYBQSJbeQADbSPaIgS6q2O20sIKMUXlXGtsXxDv
 6XuhFANSWUu+QZoifCQWvFjwcHitMOSu1CEtQHMM2p2809NwRrewbOTvMdsehazlofYqb3YCtyH
 QWE/FDCylnIUAoNf3Z6tpSDX5TH/E=
X-Received: by 2002:a05:6a20:4393:b0:1a3:579f:2c5c with SMTP id
 i19-20020a056a20439300b001a3579f2c5cmr1872019pzl.53.1711708710467; 
 Fri, 29 Mar 2024 03:38:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHm+CKraobkYyrUDpjhoWb9VgSGEw+dsBViYeRSz1CNZt9lbFPlZYBhQo2azvoCZaoPczKILFHEZPQp3buGNc=
X-Received: by 2002:a05:6a20:4393:b0:1a3:579f:2c5c with SMTP id
 i19-20020a056a20439300b001a3579f2c5cmr1872004pzl.53.1711708710058; Fri, 29
 Mar 2024 03:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240328103903.408290-1-Jiqian.Chen@amd.com>
 <20240328103903.408290-3-Jiqian.Chen@amd.com>
 <20240328065606-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849ACCD6602EAB88BE2FED9E73B2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <20240328083503-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849C37A0B0E1AF02644C203E73A2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEt=V4V4JgT08o5_f7tj-eNZDi2GB4=H_Qp7xALrRxBWhQ@mail.gmail.com>
 <BL1PR12MB5849A4AECE81D37684B88129E73A2@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5849A4AECE81D37684B88129E73A2@BL1PR12MB5849.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 29 Mar 2024 18:38:18 +0800
Message-ID: <CACGkMEvNjeYSRQRdcSz4=Cg-DvqNWhD6w9H75PFiqdcQPH+Xww@mail.gmail.com>
Subject: Re: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Mar 29, 2024 at 4:00=E2=80=AFPM Chen, Jiqian <Jiqian.Chen@amd.com> =
wrote:
>
> On 2024/3/29 15:20, Jason Wang wrote:
> > On Fri, Mar 29, 2024 at 3:07=E2=80=AFPM Chen, Jiqian <Jiqian.Chen@amd.c=
om> wrote:
> >>
> >> On 2024/3/28 20:36, Michael S. Tsirkin wrote:
> >>>>>> +}
> >>>>>> +
> >>>>>>  static void virtio_pci_bus_reset_hold(Object *obj)
> >>>>>>  {
> >>>>>>      PCIDevice *dev =3D PCI_DEVICE(obj);
> >>>>>>      DeviceState *qdev =3D DEVICE(obj);
> >>>>>>
> >>>>>> +    if (virtio_pci_no_soft_reset(dev)) {
> >>>>>> +        return;
> >>>>>> +    }
> >>>>>> +
> >>>>>>      virtio_pci_reset(qdev);
> >>>>>>
> >>>>>>      if (pci_is_express(dev)) {
> >>>>>> @@ -2484,6 +2511,8 @@ static Property virtio_pci_properties[] =3D =
{
> >>>>>>                      VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
> >>>>>>      DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
> >>>>>>                      VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
> >>>>>> +    DEFINE_PROP_BIT("x-pcie-pm-no-soft-reset", VirtIOPCIProxy, fl=
ags,
> >>>>>> +                    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, false),
> >
> > Why does it come with an x prefix?
> Sorry, it's my misunderstanding of this prefix, if No_Soft_Reset doesn't =
need this prefix, I will delete it in next version.
> Does x prefix means compat machinery? Or other meanings?
>
> >
> >>>>>>      DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
> >>>>>>                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
> >>>>>>      DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
> >>>>>
> >>>>> I am a bit confused about this part.
> >>>>> Do you want to make this software controllable?
> >>>> Yes, because even the real hardware, this bit is not always set.
> >
> > We are talking about emulated devices here.
> Yes, I just gave an example. It actually this bit is not always set. What=
's your opinion about when to set this bit or which virtio-device should se=
t this bit?

If the implementation of Qemu is correct, we should set it unless we
need compatibility.

>
> >
> >>>
> >>> So which virtio devices should and which should not set this bit?
> >> This depends on the scenario the virtio-device is used, if we want to =
trigger an internal soft reset for the virtio-device during S3, this bit sh=
ouldn't be set.
> >
> > If the device doesn't need reset, why bother the driver for this?
> I don't know what you mean.
> If the device doesn't need reset, we can config true to set this bit, the=
n on the driver side, driver finds this bit is set, then driver will not tr=
igger a soft reset.

I mean if the device can suspend without reset, we don't need to
bother the driver to save and load states.

>
> >
> > Btw, no_soft_reset is insufficient for some cases,
> May I know which cases?
>
> > there's a proposal for the virtio-spec. I think we need to wait until i=
t is done.
> Can you share the proposal?

See this

https://lore.kernel.org/all/20240227015345.3614965-1-stevensd@chromium.org/=
T/

Thanks

>
> >
> >> In my use case on my environment, I don't want to reset virtio-gpu dur=
ing S3,
> >> because once the display resources are destroyed, there are not enough=
 information to re-create them, so this bit should be set.
> >> Making this bit software controllable is convenient for users to take =
their own choices.
> >
> > Thanks
> >
> >>
> >>>
> >>>>> Or should this be set to true by default and then
> >>>>> changed to false for old machine types?
> >>>> How can I do so?
> >>>> Do you mean set this to true by default, and if old machine types do=
n't need this bit, they can pass false config to qemu when running qemu?
> >>>
> >>> No, you would use compat machinery. See how is x-pcie-flr-init handle=
d.
> >>>
> >>>
> >>
> >> --
> >> Best regards,
> >> Jiqian Chen.
> >
>
> --
> Best regards,
> Jiqian Chen.


