Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D305DC67861
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 03:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtJ5m-0002Dn-AM; Sat, 06 Apr 2024 23:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rtJ5l-0002Dd-JB
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 23:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rtJ5k-0000cQ-19
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 23:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712460070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6435RRoYgY8R7lSrI0z44+62BBFr+qSOVSb4wa/a6X0=;
 b=jC9dlH6W4xjj7O+wLlSu4iK9dqxzDtZubj1ai5xwcTVIy8xPhUC/6h8+LCZZQEd8s95fT3
 Ie3r+TRwkeC4iVkLryeXxcWalbYiIr+ZW5E5kEH5MGD0TnK5ro8K2dcmMRgXTbHVoYHK2B
 /oCl6/Jb3GmUfMqDmV0QEk5/Ot1E44k=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-nBVbU3hrODGdmhrHvGmp0g-1; Sat, 06 Apr 2024 23:21:09 -0400
X-MC-Unique: nBVbU3hrODGdmhrHvGmp0g-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-22ef443f520so716686fac.3
 for <qemu-devel@nongnu.org>; Sat, 06 Apr 2024 20:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712460068; x=1713064868;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6435RRoYgY8R7lSrI0z44+62BBFr+qSOVSb4wa/a6X0=;
 b=QFAIngnhdYTEAXXaEC2SCwyoZyqHj/aG69TvtW//A5yQn/qpPMF77nGId4+aSCpgbK
 sl70LPEtCkqVTmgrAQj68sAd3HVCa2kpBPsqV+NHwMrR0lx/Vh34B/u9XkzBw7G+PBTG
 nuUCUKaPmnb5Oj8P4vy5gmMXc0Hc0iXpV/vh6/1dFl8qR7i78IGq/HAF79kyUho485pW
 L9zjueJLycXF+NyInTrpbSeQSmGlDwt8KFkFuavL//TZcM9Pb4DqTeVfWR1dvhW5XSIm
 0MDxYHgn2wYtD9WHEk2jjHaBdT1TOscYUc/vqibiaLlnS80UeV214juw7YPEYv30ILb7
 qIcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+nySrQ5q+Z0hz0plN+kYLJsvdniPGcYxEd/7+A6hzFp4ngnXzTjsgi95bpPMIpUEuAeSoeKDHrNWETFsLbFLtZQSzDmk=
X-Gm-Message-State: AOJu0YzNlMr46e+2pLLCi07X7G/kLQ5SYOWOJTI2bvZr6GSyEXNCP3T8
 GpDqeyCIZ/nnbtNAnIEGs7tG+qF5BCo7KR2waP7I6mulRTq8IBPXC2NurjjDJTu3EQbHP8EpWK1
 bWfz8BmkqW2KfKPA3TWrPSKRyIApkUlWtKE4yQOiHVStOms7n+zCnP44DEhz6yLnCg3sulpR9WD
 +6k7SeVMTG5ACdSJIYxqkeP1g2+S8=
X-Received: by 2002:a05:6871:9ec1:b0:22e:8ba0:921f with SMTP id
 kr1-20020a0568719ec100b0022e8ba0921fmr4365240oac.52.1712460068514; 
 Sat, 06 Apr 2024 20:21:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCoIsFDcIN6OVXZPWDTK2Zab7L1YkUHcrRZ/IOoEf2Tz0F4ucRWwpv+D2FAoaYPuI6wPOua8wvus3mO5sGhCE=
X-Received: by 2002:a05:6871:9ec1:b0:22e:8ba0:921f with SMTP id
 kr1-20020a0568719ec100b0022e8ba0921fmr4365237oac.52.1712460068232; Sat, 06
 Apr 2024 20:21:08 -0700 (PDT)
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
In-Reply-To: <BL1PR12MB5849AA89DC28465714590B56E73E2@BL1PR12MB5849.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 7 Apr 2024 11:20:57 +0800
Message-ID: <CACGkMEu6uEF+4P3_3Q5tw4TNZ9dj3GwJh+h_BtWDfq3WeUhKJQ@mail.gmail.com>
Subject: Re: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Apr 2, 2024 at 11:03=E2=80=AFAM Chen, Jiqian <Jiqian.Chen@amd.com> =
wrote:
>
> On 2024/3/29 18:44, Michael S. Tsirkin wrote:
> > On Fri, Mar 29, 2024 at 03:20:59PM +0800, Jason Wang wrote:
> >> On Fri, Mar 29, 2024 at 3:07=E2=80=AFPM Chen, Jiqian <Jiqian.Chen@amd.=
com> wrote:
> >>>
> >>> On 2024/3/28 20:36, Michael S. Tsirkin wrote:
> >>>>>>> +}
> >>>>>>> +
> >>>>>>>  static void virtio_pci_bus_reset_hold(Object *obj)
> >>>>>>>  {
> >>>>>>>      PCIDevice *dev =3D PCI_DEVICE(obj);
> >>>>>>>      DeviceState *qdev =3D DEVICE(obj);
> >>>>>>>
> >>>>>>> +    if (virtio_pci_no_soft_reset(dev)) {
> >>>>>>> +        return;
> >>>>>>> +    }
> >>>>>>> +
> >>>>>>>      virtio_pci_reset(qdev);
> >>>>>>>
> >>>>>>>      if (pci_is_express(dev)) {
> >>>>>>> @@ -2484,6 +2511,8 @@ static Property virtio_pci_properties[] =3D=
 {
> >>>>>>>                      VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
> >>>>>>>      DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
> >>>>>>>                      VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
> >>>>>>> +    DEFINE_PROP_BIT("x-pcie-pm-no-soft-reset", VirtIOPCIProxy, f=
lags,
> >>>>>>> +                    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, false)=
,
> >>
> >> Why does it come with an x prefix?
> >>
> >>>>>>>      DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
> >>>>>>>                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
> >>>>>>>      DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
> >>>>>>
> >>>>>> I am a bit confused about this part.
> >>>>>> Do you want to make this software controllable?
> >>>>> Yes, because even the real hardware, this bit is not always set.
> >>
> >> We are talking about emulated devices here.
> >>
> >>>>
> >>>> So which virtio devices should and which should not set this bit?
> >>> This depends on the scenario the virtio-device is used, if we want to=
 trigger an internal soft reset for the virtio-device during S3, this bit s=
houldn't be set.
> >>
> >> If the device doesn't need reset, why bother the driver for this?
> >>
> >> Btw, no_soft_reset is insufficient for some cases, there's a proposal
> >> for the virtio-spec. I think we need to wait until it is done.
> >
> > That seems orthogonal or did I miss something?
> Yes, I looked the detail of the proposal, I also think they are unrelated=
.

The point is the proposal said

"""
Without a mechanism to
suspend/resume virtio devices when the driver is suspended/resumed in
the early phase of suspend/late phase of resume, there is a window where
interrupts can be lost.
"""

It looks safe to enable it with the suspend bit. Or if you think it's
wrong, please comment on the virtio spec patch.

> I will set the default value of No_Soft_Reset bit to true in next version=
 according to your opinion.
> About the compatibility of old machine types, which types should I consid=
er? Does the same as x-pcie-pm-init(hw_compat_2_8)?
> Forgive me for not knowing much about compatibility.

"x" means no compatibility at all, please drop the "x" prefix. And it
looks more safe to start as "false" by default.

Thanks

> >
> >>> In my use case on my environment, I don't want to reset virtio-gpu du=
ring S3,
> >>> because once the display resources are destroyed, there are not enoug=
h information to re-create them, so this bit should be set.
> >>> Making this bit software controllable is convenient for users to take=
 their own choices.
> >>
> >> Thanks
> >>
> >>>
> >>>>
> >>>>>> Or should this be set to true by default and then
> >>>>>> changed to false for old machine types?
> >>>>> How can I do so?
> >>>>> Do you mean set this to true by default, and if old machine types d=
on't need this bit, they can pass false config to qemu when running qemu?
> >>>>
> >>>> No, you would use compat machinery. See how is x-pcie-flr-init handl=
ed.
> >>>>
> >>>>
> >>>
> >>> --
> >>> Best regards,
> >>> Jiqian Chen.
> >
>
> --
> Best regards,
> Jiqian Chen.


