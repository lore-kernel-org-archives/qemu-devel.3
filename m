Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579CBC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 06:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvAch-0005dT-KR; Fri, 12 Apr 2024 02:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rvAcg-0005dH-8S
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 02:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rvAce-0007OR-Ir
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 02:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712904171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RPrYXunSz5ltbtfwGcsGhLyOtV47AulqpzxsK4Kg1bw=;
 b=QIN9TJRp8wDZAq998EpWKU5o5rDnF5ip0YZm8ajVpErLsj40YsVsjG5B3YJXWt3VKfpeu0
 ksE5/wos6F6Gj6Sj+6Be0WGS3sTucLe83OxwL+xjyXlb45QQcWgdt3jFCAMGZk67Zx9Fs0
 f0vYX+tPrMV2C4crSfqLPffT62fIN3s=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-9DCOQUM-MYqZMRRTPTfldg-1; Fri, 12 Apr 2024 02:42:50 -0400
X-MC-Unique: 9DCOQUM-MYqZMRRTPTfldg-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7e7b7d66c8fso570233241.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 23:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712904169; x=1713508969;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RPrYXunSz5ltbtfwGcsGhLyOtV47AulqpzxsK4Kg1bw=;
 b=tejLYqyAuQcBHTPUtNEOF0B3PyXLvzDv+lN317aSCldSJ4Ffr+2GE8veSEwO0AQrTv
 2KBk68UjYrbrkwJ0kANU5YVZ9sxbPxK1p0esDSKKorgpyES5omti+Q9lCib2Nfui8YT2
 ro92QrBZILtqecY1gJ+b7+/gwMnH0WqR72unU4Fdr3JjPW1Zqxhzcc2zWuHDyAPpuJac
 8f4CbHP1vZNcV4Pt/YXluOH4NE+zA/SjqaPs/aezIOpblqXZT+lUHe68eahIf745iOKj
 5CBXHKJNNts2FK6l//5FGMVxn3Rj0icY3wKB1kc4qW2AyGUPnB3ZMLPLNNcVCn+eRU2e
 uV8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkHM/Zs+8odb1eQDLWwhqa8IFcL2GuU6O60+QSSoq5vw9dlN+lCJPSv9NvM4N37uJbLQe3eoORfGBMjh7+OwYKqcN9GZE=
X-Gm-Message-State: AOJu0YyTL47uAJRk1iow/KTpaq9iACgUFauhSomTcNG87bYgSJ0udS13
 Cw0gJ5tEG4bemZVbXbeup8Xcm2xj6+98ChU8DQfSNxKgdbvPzuxI3JEBOktSP+PFBetTiAvBDVr
 24JbFEVAcBhYWSCioqJ3Rvr+yCqi4uuMm2s5dnQ7JFwj4cvDMaxhNQ1pDbAl7wOApHvREeWkos0
 LS2ZXJIwZX6aT6PyrBwUWL6iWkBFfj7YgtIzqDqg==
X-Received: by 2002:a05:6102:2c6:b0:47a:62c9:22e3 with SMTP id
 h6-20020a05610202c600b0047a62c922e3mr411919vsh.1.1712904168732; 
 Thu, 11 Apr 2024 23:42:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfhyGGp0sLZJC8Ii0VLB349aOMdRQfrAujvn+fRnimgOv3WVWatt23Hc3DW4VTeyAVYg3XWKAVpmGmsoKKPYk=
X-Received: by 2002:a05:6102:2c6:b0:47a:62c9:22e3 with SMTP id
 h6-20020a05610202c600b0047a62c922e3mr411916vsh.1.1712904168418; Thu, 11 Apr
 2024 23:42:48 -0700 (PDT)
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
 <BL1PR12MB5849380AAAE41CD6A2405D09E7042@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5849380AAAE41CD6A2405D09E7042@BL1PR12MB5849.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 12 Apr 2024 14:42:36 +0800
Message-ID: <CACGkMEuA=Tt+rLOo=KFqxvPCDP9Ts0fFxMB=+uvu6OrVec-UFg@mail.gmail.com>
Subject: Re: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 12, 2024 at 1:59=E2=80=AFPM Chen, Jiqian <Jiqian.Chen@amd.com> =
wrote:
>
> On 2024/4/7 11:20, Jason Wang wrote:
> > On Tue, Apr 2, 2024 at 11:03=E2=80=AFAM Chen, Jiqian <Jiqian.Chen@amd.c=
om> wrote:
> >>
> >> On 2024/3/29 18:44, Michael S. Tsirkin wrote:
> >>> On Fri, Mar 29, 2024 at 03:20:59PM +0800, Jason Wang wrote:
> >>>> On Fri, Mar 29, 2024 at 3:07=E2=80=AFPM Chen, Jiqian <Jiqian.Chen@am=
d.com> wrote:
> >>>>>
> >>>>> On 2024/3/28 20:36, Michael S. Tsirkin wrote:
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>>  static void virtio_pci_bus_reset_hold(Object *obj)
> >>>>>>>>>  {
> >>>>>>>>>      PCIDevice *dev =3D PCI_DEVICE(obj);
> >>>>>>>>>      DeviceState *qdev =3D DEVICE(obj);
> >>>>>>>>>
> >>>>>>>>> +    if (virtio_pci_no_soft_reset(dev)) {
> >>>>>>>>> +        return;
> >>>>>>>>> +    }
> >>>>>>>>> +
> >>>>>>>>>      virtio_pci_reset(qdev);
> >>>>>>>>>
> >>>>>>>>>      if (pci_is_express(dev)) {
> >>>>>>>>> @@ -2484,6 +2511,8 @@ static Property virtio_pci_properties[] =
=3D {
> >>>>>>>>>                      VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
> >>>>>>>>>      DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
> >>>>>>>>>                      VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
> >>>>>>>>> +    DEFINE_PROP_BIT("x-pcie-pm-no-soft-reset", VirtIOPCIProxy,=
 flags,
> >>>>>>>>> +                    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, fals=
e),
> >>>>
> >>>> Why does it come with an x prefix?
> >>>>
> >>>>>>>>>      DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
> >>>>>>>>>                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
> >>>>>>>>>      DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
> >>>>>>>>
> >>>>>>>> I am a bit confused about this part.
> >>>>>>>> Do you want to make this software controllable?
> >>>>>>> Yes, because even the real hardware, this bit is not always set.
> >>>>
> >>>> We are talking about emulated devices here.
> >>>>
> >>>>>>
> >>>>>> So which virtio devices should and which should not set this bit?
> >>>>> This depends on the scenario the virtio-device is used, if we want =
to trigger an internal soft reset for the virtio-device during S3, this bit=
 shouldn't be set.
> >>>>
> >>>> If the device doesn't need reset, why bother the driver for this?
> >>>>
> >>>> Btw, no_soft_reset is insufficient for some cases, there's a proposa=
l
> >>>> for the virtio-spec. I think we need to wait until it is done.
> >>>
> >>> That seems orthogonal or did I miss something?
> >> Yes, I looked the detail of the proposal, I also think they are unrela=
ted.
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
> If I understand the proposal correctly.
> Only need to check the SUSPEND bit when virtio_pci_bus_reset_hold is call=
ed.
> It seems the proposal won't block this patch to upstream.
> In next version, I will add comments to note the SUSPEND bit that need to=
 be considered once it is accepted.
>
> >
> >> I will set the default value of No_Soft_Reset bit to true in next vers=
ion according to your opinion.
> >> About the compatibility of old machine types, which types should I con=
sider? Does the same as x-pcie-pm-init(hw_compat_2_8)?
> >> Forgive me for not knowing much about compatibility.
> >
> > "x" means no compatibility at all, please drop the "x" prefix. And it
> Thanks to explain.
> So it seems the prefix "x" of "x-pcie-pm-init" is also wrong? Because it =
considered the hw_compat_2_8. Also "x-pcie-flr-init".

Probably but too late to fix.

> Back to No_Soft_Reset, do you know which old machines should I consider t=
o compatible with?

Replied in another mail.

Thanks

>
> > looks more safe to start as "false" by default.
> >
> > Thanks
> >
> >>>
> >>>>> In my use case on my environment, I don't want to reset virtio-gpu =
during S3,
> >>>>> because once the display resources are destroyed, there are not eno=
ugh information to re-create them, so this bit should be set.
> >>>>> Making this bit software controllable is convenient for users to ta=
ke their own choices.
> >>>>
> >>>> Thanks
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>> Or should this be set to true by default and then
> >>>>>>>> changed to false for old machine types?
> >>>>>>> How can I do so?
> >>>>>>> Do you mean set this to true by default, and if old machine types=
 don't need this bit, they can pass false config to qemu when running qemu?
> >>>>>>
> >>>>>> No, you would use compat machinery. See how is x-pcie-flr-init han=
dled.
> >>>>>>
> >>>>>>
> >>>>>
> >>>>> --
> >>>>> Best regards,
> >>>>> Jiqian Chen.
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


