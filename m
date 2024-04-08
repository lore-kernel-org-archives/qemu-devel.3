Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC77CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 04:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rth43-0001x8-VB; Mon, 08 Apr 2024 00:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rth42-0001wn-1F
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 00:57:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rth40-0003TS-DJ
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 00:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712552218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TPTvO4uSD2ITcQFpdFsmvHxne5VOVMcChyx9bckwzsU=;
 b=erwtQCYjo8D1ve2Q+zp2o7tXfWhiLOJ1wdC95vBrlWr7kTZ09MLHWGujO+RKWC5JkzDhUZ
 n+t8XSZ/w/eg6R0fU4Cs15S/zbeizX8pazt+VFkJCR6HToR0bWW/QFNkwB6vrjUKCRvMJY
 ubOaSgZ3KRWJaW4ilsmg41kOo+/lstM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-dQDbZZYOMjq6g_7ts5-s6w-1; Mon, 08 Apr 2024 00:56:56 -0400
X-MC-Unique: dQDbZZYOMjq6g_7ts5-s6w-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5e4df21f22dso2791115a12.0
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 21:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712552215; x=1713157015;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TPTvO4uSD2ITcQFpdFsmvHxne5VOVMcChyx9bckwzsU=;
 b=NH5Cr+pDKALEADk7vPBZY8P2xdAHPkkIAAROUK/hay5/zyo+r/y71PJFlYIkLcRzwi
 Oj9wnQ0SgH35yfHOWWdgQvXFPo4A5m3ncc7pCYIP/wwEIigdDtmuOeohm1kEveqrIHmb
 rGU0yf/aUmjclzUW8URUK/rdHGu3RlLRj1iqngJtcn5t2KhdzF40M+RYYnwqGZGqf+PE
 xUDIUzYGwuAaPolKJ20qa10UyQ1Gx92wDFOPcCx44Bt/MKQZMuA3zP94603KBaulP3YE
 1XE/4TzyEmuVNVTgXRl1N983WDC//XNA6eQs3W+MyPlqbvp/wE/Y0kHKpqwNXdu3K4xK
 Bxmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsxilGVb/4EybXyGrccJJPMr4kzrVYzHSki3XhpRxaIqbVx3Wu8i7HSo1re9Yg/Kctjs8uPg5zNNvW8+6YA6NO2vQkZKM=
X-Gm-Message-State: AOJu0Yy1C2fpqqyJ1/Yt45Ew/bPzbimyCf4OIrsqTU9CeYwjT5mWmvRe
 Jy1/XtycfAllZaQXSkDYYpFWBbJQEevllPsJvc69uTje6aXJdRxPI9Ew1xSviIXfpM017DS4Eel
 ig4HHEUnex7Y5tgjEolWuZ+Snk2wpj1jPVzYMFY50hS6JcwwtWTQodrGMf25Rx1q90Z4wuX9pOD
 gBsnEssImp52zitCJL8Y9nbTJpBpCH61Cgxh8=
X-Received: by 2002:a17:90a:1109:b0:2a3:846:6a45 with SMTP id
 d9-20020a17090a110900b002a308466a45mr11161308pja.5.1712552215615; 
 Sun, 07 Apr 2024 21:56:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPa1OGHhqSI0CZWqXyPWNrFdrC3/b8+Hym5e/49PDqAuS2Ji+jl9Damfv2qAaPZEKYvmEDZPebGaxT+HwKA8w=
X-Received: by 2002:a17:90a:1109:b0:2a3:846:6a45 with SMTP id
 d9-20020a17090a110900b002a308466a45mr11161298pja.5.1712552215306; Sun, 07 Apr
 2024 21:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240328103903.408290-1-Jiqian.Chen@amd.com>
 <20240328103903.408290-3-Jiqian.Chen@amd.com>
 <20240328065606-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849ACCD6602EAB88BE2FED9E73B2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <20240328083503-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849C37A0B0E1AF02644C203E73A2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEt=V4V4JgT08o5_f7tj-eNZDi2GB4=H_Qp7xALrRxBWhQ@mail.gmail.com>
 <20240329064431-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849AA89DC28465714590B56E73E2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEu6uEF+4P3_3Q5tw4TNZ9dj3GwJh+h_BtWDfq3WeUhKJQ@mail.gmail.com>
 <20240407074848-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240407074848-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Apr 2024 12:56:44 +0800
Message-ID: <CACGkMEuzcVRfLY+axEP3QXb9TwYq_c=jLZRB5++EwyGWLv0YcQ@mail.gmail.com>
Subject: Re: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Chen, Jiqian" <Jiqian.Chen@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

On Sun, Apr 7, 2024 at 7:50=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Sun, Apr 07, 2024 at 11:20:57AM +0800, Jason Wang wrote:
> > On Tue, Apr 2, 2024 at 11:03=E2=80=AFAM Chen, Jiqian <Jiqian.Chen@amd.c=
om> wrote:
> > >
> > > On 2024/3/29 18:44, Michael S. Tsirkin wrote:
> > > > On Fri, Mar 29, 2024 at 03:20:59PM +0800, Jason Wang wrote:
> > > >> On Fri, Mar 29, 2024 at 3:07=E2=80=AFPM Chen, Jiqian <Jiqian.Chen@=
amd.com> wrote:
> > > >>>
> > > >>> On 2024/3/28 20:36, Michael S. Tsirkin wrote:
> > > >>>>>>> +}
> > > >>>>>>> +
> > > >>>>>>>  static void virtio_pci_bus_reset_hold(Object *obj)
> > > >>>>>>>  {
> > > >>>>>>>      PCIDevice *dev =3D PCI_DEVICE(obj);
> > > >>>>>>>      DeviceState *qdev =3D DEVICE(obj);
> > > >>>>>>>
> > > >>>>>>> +    if (virtio_pci_no_soft_reset(dev)) {
> > > >>>>>>> +        return;
> > > >>>>>>> +    }
> > > >>>>>>> +
> > > >>>>>>>      virtio_pci_reset(qdev);
> > > >>>>>>>
> > > >>>>>>>      if (pci_is_express(dev)) {
> > > >>>>>>> @@ -2484,6 +2511,8 @@ static Property virtio_pci_properties[]=
 =3D {
> > > >>>>>>>                      VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
> > > >>>>>>>      DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
> > > >>>>>>>                      VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
> > > >>>>>>> +    DEFINE_PROP_BIT("x-pcie-pm-no-soft-reset", VirtIOPCIProx=
y, flags,
> > > >>>>>>> +                    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, fa=
lse),
> > > >>
> > > >> Why does it come with an x prefix?
> > > >>
> > > >>>>>>>      DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags=
,
> > > >>>>>>>                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
> > > >>>>>>>      DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
> > > >>>>>>
> > > >>>>>> I am a bit confused about this part.
> > > >>>>>> Do you want to make this software controllable?
> > > >>>>> Yes, because even the real hardware, this bit is not always set=
.
> > > >>
> > > >> We are talking about emulated devices here.
> > > >>
> > > >>>>
> > > >>>> So which virtio devices should and which should not set this bit=
?
> > > >>> This depends on the scenario the virtio-device is used, if we wan=
t to trigger an internal soft reset for the virtio-device during S3, this b=
it shouldn't be set.
> > > >>
> > > >> If the device doesn't need reset, why bother the driver for this?
> > > >>
> > > >> Btw, no_soft_reset is insufficient for some cases, there's a propo=
sal
> > > >> for the virtio-spec. I think we need to wait until it is done.
> > > >
> > > > That seems orthogonal or did I miss something?
> > > Yes, I looked the detail of the proposal, I also think they are unrel=
ated.
> >
> > The point is the proposal said
> >
> > """
> > Without a mechanism to
> > suspend/resume virtio devices when the driver is suspended/resumed in
> > the early phase of suspend/late phase of resume, there is a window wher=
e
> > interrupts can be lost.
> > """
> >
> > It looks safe to enable it with the suspend bit. Or if you think it's
> > wrong, please comment on the virtio spec patch.
> >
> > > I will set the default value of No_Soft_Reset bit to true in next ver=
sion according to your opinion.
> > > About the compatibility of old machine types, which types should I co=
nsider? Does the same as x-pcie-pm-init(hw_compat_2_8)?
> > > Forgive me for not knowing much about compatibility.
> >
> > "x" means no compatibility at all, please drop the "x" prefix. And it
> > looks more safe to start as "false" by default.
> >
> > Thanks
>
>
> Not sure I agree. External flags are for when users want to tweak them.
> When would users want it to be off?

If I understand the suspending status proposal correctly, there are at
least 1 device that is not safe. And this series does not mention
which device it has tested.

It means if we enable it unconditionally, guests may break.

Thanks

> What is done here is I feel sane, just add machine compat machinery
> to change to off for old machine types.
>
>
> > > >
> > > >>> In my use case on my environment, I don't want to reset virtio-gp=
u during S3,
> > > >>> because once the display resources are destroyed, there are not e=
nough information to re-create them, so this bit should be set.
> > > >>> Making this bit software controllable is convenient for users to =
take their own choices.
> > > >>
> > > >> Thanks
> > > >>
> > > >>>
> > > >>>>
> > > >>>>>> Or should this be set to true by default and then
> > > >>>>>> changed to false for old machine types?
> > > >>>>> How can I do so?
> > > >>>>> Do you mean set this to true by default, and if old machine typ=
es don't need this bit, they can pass false config to qemu when running qem=
u?
> > > >>>>
> > > >>>> No, you would use compat machinery. See how is x-pcie-flr-init h=
andled.
> > > >>>>
> > > >>>>
> > > >>>
> > > >>> --
> > > >>> Best regards,
> > > >>> Jiqian Chen.
> > > >
> > >
> > > --
> > > Best regards,
> > > Jiqian Chen.
>


