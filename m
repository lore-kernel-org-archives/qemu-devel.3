Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53A6C02181
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 01:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tam78-0004pP-8L; Wed, 22 Jan 2025 20:34:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tam76-0004p0-F6
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 20:34:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tam70-0007ml-V8
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 20:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737596063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zfI0gqpNkhbosZYoGKaxTfcmmQoGniZdWssGZqV6iSg=;
 b=KrgCZZKhyzVMWggvLbxABhW+j+8d6wb8VDIMWKRtAJ/i8hnjsXWgACF2mjEWdftAHNg/2/
 ECZdYDq1/cta9dNtuQG5enlIxCk3XrB9giTdmMwJj9jgWme8r78XQq5K+38ppFw53ef1yj
 6JHKzl3W6ZGn4cQB3uVCNHUCDCQm3Ko=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-ZRKYPWuEN1i-xg2KqNqRpA-1; Wed, 22 Jan 2025 20:34:20 -0500
X-MC-Unique: ZRKYPWuEN1i-xg2KqNqRpA-1
X-Mimecast-MFC-AGG-ID: ZRKYPWuEN1i-xg2KqNqRpA
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2164fad3792so5630855ad.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 17:34:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737596059; x=1738200859;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zfI0gqpNkhbosZYoGKaxTfcmmQoGniZdWssGZqV6iSg=;
 b=UXAYR8KwzSd5wMuZ2bzuZ174zlzhTV1zRGANj7YCK08VlIVedP7/0p/lgrNCWg1yOb
 S+Gee5PH3GLYzFaAn6TN6YdgawfGc6Cr2NKtIAdLUrVHka8WiXGAozrirJrRglMJjoxF
 P5R9eS9QA7ySep3R/A+6OgsxShNYMOSbEJFCQylEnfys92+BEhiV4RxnJcYrX8vWVxts
 tM+vmynEqpcqKL+uEbQkK/FXhZJhdlvDqmZrCBZNTbmAwaGiCHvKNKQEuGh4PxU9Q6HI
 9GlGOhPZevv6PlEH0pXyDfJRzC49pv6THItcW2SGEEOmgfLbSnyUspYYEuJGDp2ZkyJn
 FZWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG3x8fUP4b1oyT7x7Smj+LuVfxpPVn5BUs729UC6kyXzOL6sylTWb+lk17c5cM2Ma47NIwY37XZMnx@nongnu.org
X-Gm-Message-State: AOJu0YxBc/hbprj15vo0wMZcglo1SlJnJCsrUByQQRLHIsO9Z7C/MAn+
 scUxLR16uRtlBVSFwSS3ZPTzLhf+KpUzUsGoki+9mjtMsbxCFdgbPL5HvkjTpYtxMb5PXe7b8vG
 xK54+4/eDPuF1wFJsq4BFqMLVcXXVOGqAJpdzlEvpYwPt6WQ+vA1MZrpRAeUujChde3t9QGtXGT
 ZVndgm7IquYdzDmQqDtW0qD2IRN+I=
X-Gm-Gg: ASbGncueD2JQKYBnRHyjGVIt66Hh9oV6Oge2KZNk1W9sEFY2J95de+ISsdmsPM72wy6
 rBnuzgovkgIGRb6mLK7TrCN/y8+/ZEEVsPXlfC4I5e0NcJ5qKqw==
X-Received: by 2002:a05:6a20:9143:b0:1dc:bdb1:349e with SMTP id
 adf61e73a8af0-1eb214a08c1mr36270261637.17.1737596059666; 
 Wed, 22 Jan 2025 17:34:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkAL2AnWbU9lCfySHDAhjE3Yxiwgl7x8CgdBbNRC/3E3NKJWhuzvBPZsLh8PzFOvULrqp7ZR9JZtmCO51+Kes=
X-Received: by 2002:a05:6a20:9143:b0:1dc:bdb1:349e with SMTP id
 adf61e73a8af0-1eb214a08c1mr36270223637.17.1737596059137; Wed, 22 Jan 2025
 17:34:19 -0800 (PST)
MIME-Version: 1.0
References: <20250120173339.865681-1-eric.auger@redhat.com>
 <CACGkMEu4oMa8Sf9QXtszeoSMj_67Csr0s7kHdYfbNnJWibu2dA@mail.gmail.com>
 <5a55011a-af8f-483a-99fa-5cb2cdf3841f@redhat.com>
 <CACGkMEv6ec3JLZg6ZedSHdNS5_McX7_xoV4d2MG05x_Y5t=uEA@mail.gmail.com>
 <678babb6-f64a-4db5-ad60-494214a4e673@redhat.com>
In-Reply-To: <678babb6-f64a-4db5-ad60-494214a4e673@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Jan 2025 09:34:08 +0800
X-Gm-Features: AbW1kvZAagMx2Pa2eRV4BNnt2LSd_Z_Q-EQ2J5oyZdrNFg6SZUrRAGIEJqRp6W0
Message-ID: <CACGkMEvyYT7-PTOwO-Jg9a8AHA0AJHoV2BY2RBrJTGKEFYL6QA@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
To: eric.auger@redhat.com
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, mst@redhat.com, 
 sgarzare@redhat.com, lvivier@redhat.com, zhenzhong.duan@intel.com, 
 Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 22, 2025 at 3:55=E2=80=AFPM Eric Auger <eric.auger@redhat.com> =
wrote:
>
> Hi Jason,
>
>
> On 1/22/25 8:17 AM, Jason Wang wrote:
> > On Wed, Jan 22, 2025 at 12:25=E2=80=AFAM Eric Auger <eric.auger@redhat.=
com> wrote:
> >>
> >> Hi Jason,
> >>
> >> On 1/21/25 4:27 AM, Jason Wang wrote:
> >>> On Tue, Jan 21, 2025 at 1:33=E2=80=AFAM Eric Auger <eric.auger@redhat=
.com> wrote:
> >>>> When a guest exposed with a vhost device and protected by an
> >>>> intel IOMMU gets rebooted, we sometimes observe a spurious warning:
> >>>>
> >>>> Fail to lookup the translated address ffffe000
> >>>>
> >>>> We observe that the IOMMU gets disabled through a write to the globa=
l
> >>>> command register (CMAR_GCMD.TE) before the vhost device gets stopped=
.
> >>>> When this warning happens it can be observed an inflight IOTLB
> >>>> miss occurs after the IOMMU disable and before the vhost stop. In
> >>>> that case a flat translation occurs and the check in
> >>>> vhost_memory_region_lookup() fails.
> >>>>
> >>>> Let's disable the IOTLB callbacks when all IOMMU MRs have been
> >>>> unregistered.
> >>>>
> >>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>>> ---
> >>>>  hw/virtio/vhost.c | 4 ++++
> >>>>  1 file changed, 4 insertions(+)
> >>>>
> >>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >>>> index 6aa72fd434..128c2ab094 100644
> >>>> --- a/hw/virtio/vhost.c
> >>>> +++ b/hw/virtio/vhost.c
> >>>> @@ -931,6 +931,10 @@ static void vhost_iommu_region_del(MemoryListen=
er *listener,
> >>>>              break;
> >>>>          }
> >>>>      }
> >>>> +    if (QLIST_EMPTY(&dev->iommu_list) &&
> >>>> +        dev->vhost_ops->vhost_set_iotlb_callback) {
> >>>> +        dev->vhost_ops->vhost_set_iotlb_callback(dev, false);
> >>>> +    }
> >>> So the current code assumes:
> >>>
> >>> 1) IOMMU is enabled before vhost starts
> >>> 2) IOMMU is disabled after vhost stops
> >>>
> >>> This patch seems to fix 2) but not 1). Do we need to deal with the
> >>> IOMMU enabled after vhost starts?
> >> sorry I initially misunderstood the above comment. Indeed in the reboo=
t
> >> case assumption 2) happens to be wrong. However what I currently do is=
:
> >> stop listening to iotlb miss requests from the kernel because my
> >> understanding is those requests are just spurious ones, generate
> >> warnings and we do not care since we are rebooting the system.
> >>
> >> However I do not claim this could handle the case where the IOMMU MR
> >> would be turned off and then turned on. I think in that case we should
> >> also flush the kernel IOTLB and this is not taken care of in this patc=
h.
> >> Is it a relevant use case?
> > Not sure.
> >
> >> wrt removing assumption 1) and allow IOMMU enabled after vhost start. =
Is
> >> that a valid use case as the virtio driver is using the dma api?
> > It should not be but we can't assume the behaviour of the guest. It
> > could be buggy or even malicious.
>
> agreed
> >
> > Btw, we had the following codes while handling te:
> >
> > /* Handle Translation Enable/Disable */
> > static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
> > {
> >     if (s->dmar_enabled =3D=3D en) {
> >         return;
> >     }
> >
> >     trace_vtd_dmar_enable(en);
> >
> > ...
> >
> >     vtd_reset_caches(s);
> >     vtd_address_space_refresh_all(s);
> > }
> >
> > vtd_address_space_refresh_all() will basically disable the iommu
> > memory region. It looks not sufficient to trigger the region_del
> > callback, maybe we should delete the region or introduce listener
> > callback?
>
> This is exactly the code path which is entered in my use case.
>
> vtd_address_space_refresh_all(s) induces the vhost_iommu_region_del. But =
given the current implement of this latter the IOTLB callback is not unset =
and the kernel IOTLB is not refreshed. Also as I pointed out the  hdev->mem=
->regions are not updated? shouldn't they. Can you explain what they corres=
pond to?

Adding Peter for more ideas.

I think it's better to find a way to trigger the listener here, probably:

1) add/delete the memory regions instead of enable/disable

or

2) introduce new listener ops that can be triggered when a region is
enabled or disabled

Thanks

>
> Thanks
>
> Eric
>
> >
> > Thanks
> >
> >> Eric
> >>
> >>
> >>> Thanks
> >>>
> >>>>  }
> >>>>
> >>>>  void vhost_toggle_device_iotlb(VirtIODevice *vdev)
> >>>> --
> >>>> 2.47.1
> >>>>
>


