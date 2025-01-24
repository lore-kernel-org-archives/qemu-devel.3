Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A012DC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 03:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbAZR-00020H-Of; Thu, 23 Jan 2025 22:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tbAZQ-0001zq-B1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 22:41:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tbAZM-00053u-WB
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 22:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737690078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8GpJBYah3mCDW7pflVJO9e8M3eStnGWm+vLLR6TDLZE=;
 b=TBeIUVWGPUDBBh5IzMLqRp7HSRAGfbN19CwNw1UHpf2Bc3VGw79qtkOR16UZM7c0vYt3qB
 JFyLaTN51DjegdvM95pwmNtKSalq6E5o7NXC7hHIxLxHriVAZ+MHWMEXHFuqaEJ6p0xBap
 pePE7TNXqdhEu/sM8OzDjFkhWC5ZwFM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-SfudPlEDOUquB_pfv1hLEg-1; Thu, 23 Jan 2025 22:41:16 -0500
X-MC-Unique: SfudPlEDOUquB_pfv1hLEg-1
X-Mimecast-MFC-AGG-ID: SfudPlEDOUquB_pfv1hLEg
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2178115051dso31878625ad.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 19:41:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737690075; x=1738294875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8GpJBYah3mCDW7pflVJO9e8M3eStnGWm+vLLR6TDLZE=;
 b=ZNfWoYZT5Lci7fdDij+D8XlVJZDjOEJc29p1RIeO5JdAeg/DqEyS9UwSKAZ/zuchRZ
 VTeNQEED2UGGNTKTFwq72HwpB0HbmfLNx8u13wjuUE697Cmz6YawdCVeo4DcJgVL3bz9
 UGutvl58V5vxa0+tEh1MY+5O8mdm7mqkGkFRlpMI/g33uyG8tpNRzqqMVPp89ojx6pSS
 rr1a7KAgjYY0WLdbGk4WkLTS8qdL3t9qJrCo4RK1d5+rxjZzGKkppx4z1WSxBr0cV+r4
 BByzfkoCcFfOtXvBodK01z+iEFCpv7L5exbIkAhrzXihFMvBM5jTTKTOxVPn7ykhvAwK
 0emg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFO8HAJCJyKBP7lAlsR7RfHhqOL6nB6kwOnL3FQmU5pEhkaZ550ZpEJqmPZno+JmDtZB4CEFYXTUxX@nongnu.org
X-Gm-Message-State: AOJu0YzTKB5J/UdajEXOTv7aVOc/10a7ojQtCSTtlbH7pseJ5Y2TZY6k
 pCTkQOmLv7pbRT64riLYzTn4z9ylIaN71/BmPuWV7Z4YZ7qd7uuBMmhP8C65nk1NiBK0saMs3yX
 QqWgVFpjodITiPJ02XjKObojMOIifa9rnRdfGTBxRMOerbgZBtSHDiLD9SbaqoghW6wFJBYknwq
 gdt77EpM0m9r3EPJyb1Nn6Ojy5XG0=
X-Gm-Gg: ASbGnctARngJbvyGQdiPxjXFuHWmlPwWksYKo3R8anmnqdvg4NgLs/Oqsxx22LzRe/q
 KOznu7NafqS/R3l7KZDIV0kSBxD8EoYZAwkS4C9eOeoxS6X5gxp00
X-Received: by 2002:a05:6a00:a0c:b0:726:41e:b321 with SMTP id
 d2e1a72fcca58-72dafbdacadmr42539091b3a.21.1737690075525; 
 Thu, 23 Jan 2025 19:41:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/2c6IzbwYdqZRUK04vPVVZNIumoRO6UWZh4FZX1E9YFdN5X4kKmbsPv3s1XW0xJGXaMDoRnUplGr6OHsLwRE=
X-Received: by 2002:a05:6a00:a0c:b0:726:41e:b321 with SMTP id
 d2e1a72fcca58-72dafbdacadmr42539062b3a.21.1737690075090; Thu, 23 Jan 2025
 19:41:15 -0800 (PST)
MIME-Version: 1.0
References: <20250120173339.865681-1-eric.auger@redhat.com>
 <CACGkMEu4oMa8Sf9QXtszeoSMj_67Csr0s7kHdYfbNnJWibu2dA@mail.gmail.com>
 <5a55011a-af8f-483a-99fa-5cb2cdf3841f@redhat.com>
 <CACGkMEv6ec3JLZg6ZedSHdNS5_McX7_xoV4d2MG05x_Y5t=uEA@mail.gmail.com>
 <678babb6-f64a-4db5-ad60-494214a4e673@redhat.com>
 <CACGkMEvyYT7-PTOwO-Jg9a8AHA0AJHoV2BY2RBrJTGKEFYL6QA@mail.gmail.com>
 <25b5bb73-abd8-4008-905d-6c2e9e1330e2@redhat.com>
 <SJ0PR11MB6744EBC0BB7C8CD5F33D0A4E92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEtQT2yZf93+a3LxSCyfBEXbEDu5S2cFXuAhprDYd2-vhw@mail.gmail.com>
In-Reply-To: <CACGkMEtQT2yZf93+a3LxSCyfBEXbEDu5S2cFXuAhprDYd2-vhw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 24 Jan 2025 11:41:03 +0800
X-Gm-Features: AWEUYZn_W45b6wfp335FRzrj-OS4oiRHiXhy6JpaH1p7CEVLhIrPtSg-a_UHiF4
Message-ID: <CACGkMEvOht6KaJ=x2LkD=C2o+4xgixdyXMqbfuXq7-KQPdkwgQ@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "mst@redhat.com" <mst@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>
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

On Fri, Jan 24, 2025 at 11:30=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Fri, Jan 24, 2025 at 10:44=E2=80=AFAM Duan, Zhenzhong
> <zhenzhong.duan@intel.com> wrote:
> >
> >
> >
> > >-----Original Message-----
> > >From: Eric Auger <eric.auger@redhat.com>
> > >Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOM=
MU gets
> > >disabled
> > >
> > >Hi Jason,
> > >
> > >
> > >On 1/23/25 2:34 AM, Jason Wang wrote:
> > >> On Wed, Jan 22, 2025 at 3:55=E2=80=AFPM Eric Auger <eric.auger@redha=
t.com> wrote:
> > >>> Hi Jason,
> > >>>
> > >>>
> > >>> On 1/22/25 8:17 AM, Jason Wang wrote:
> > >>>> On Wed, Jan 22, 2025 at 12:25=E2=80=AFAM Eric Auger <eric.auger@re=
dhat.com>
> > >wrote:
> > >>>>> Hi Jason,
> > >>>>>
> > >>>>> On 1/21/25 4:27 AM, Jason Wang wrote:
> > >>>>>> On Tue, Jan 21, 2025 at 1:33=E2=80=AFAM Eric Auger <eric.auger@r=
edhat.com>
> > >wrote:
> > >>>>>>> When a guest exposed with a vhost device and protected by an
> > >>>>>>> intel IOMMU gets rebooted, we sometimes observe a spurious warn=
ing:
> > >>>>>>>
> > >>>>>>> Fail to lookup the translated address ffffe000
> > >>>>>>>
> > >>>>>>> We observe that the IOMMU gets disabled through a write to the =
global
> > >>>>>>> command register (CMAR_GCMD.TE) before the vhost device gets
> > >stopped.
> > >>>>>>> When this warning happens it can be observed an inflight IOTLB
> > >>>>>>> miss occurs after the IOMMU disable and before the vhost stop. =
In
> > >>>>>>> that case a flat translation occurs and the check in
> > >>>>>>> vhost_memory_region_lookup() fails.
> > >>>>>>>
> > >>>>>>> Let's disable the IOTLB callbacks when all IOMMU MRs have been
> > >>>>>>> unregistered.
> > >>>>>>>
> > >>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > >>>>>>> ---
> > >>>>>>>  hw/virtio/vhost.c | 4 ++++
> > >>>>>>>  1 file changed, 4 insertions(+)
> > >>>>>>>
> > >>>>>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > >>>>>>> index 6aa72fd434..128c2ab094 100644
> > >>>>>>> --- a/hw/virtio/vhost.c
> > >>>>>>> +++ b/hw/virtio/vhost.c
> > >>>>>>> @@ -931,6 +931,10 @@ static void
> > >vhost_iommu_region_del(MemoryListener *listener,
> > >>>>>>>              break;
> > >>>>>>>          }
> > >>>>>>>      }
> > >>>>>>> +    if (QLIST_EMPTY(&dev->iommu_list) &&
> > >>>>>>> +        dev->vhost_ops->vhost_set_iotlb_callback) {
> > >>>>>>> +        dev->vhost_ops->vhost_set_iotlb_callback(dev, false);
> > >>>>>>> +    }
> > >>>>>> So the current code assumes:
> > >>>>>>
> > >>>>>> 1) IOMMU is enabled before vhost starts
> > >>>>>> 2) IOMMU is disabled after vhost stops
> > >>>>>>
> > >>>>>> This patch seems to fix 2) but not 1). Do we need to deal with t=
he
> > >>>>>> IOMMU enabled after vhost starts?
> > >>>>> sorry I initially misunderstood the above comment. Indeed in the =
reboot
> > >>>>> case assumption 2) happens to be wrong. However what I currently =
do is:
> > >>>>> stop listening to iotlb miss requests from the kernel because my
> > >>>>> understanding is those requests are just spurious ones, generate
> > >>>>> warnings and we do not care since we are rebooting the system.
> > >>>>>
> > >>>>> However I do not claim this could handle the case where the IOMMU=
 MR
> > >>>>> would be turned off and then turned on. I think in that case we s=
hould
> > >>>>> also flush the kernel IOTLB and this is not taken care of in this=
 patch.
> > >>>>> Is it a relevant use case?
> > >>>> Not sure.
> > >>>>
> > >>>>> wrt removing assumption 1) and allow IOMMU enabled after vhost st=
art. Is
> > >>>>> that a valid use case as the virtio driver is using the dma api?
> > >>>> It should not be but we can't assume the behaviour of the guest. I=
t
> > >>>> could be buggy or even malicious.
> > >>> agreed
> > >>>> Btw, we had the following codes while handling te:
> > >>>>
> > >>>> /* Handle Translation Enable/Disable */
> > >>>> static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
> > >>>> {
> > >>>>     if (s->dmar_enabled =3D=3D en) {
> > >>>>         return;
> > >>>>     }
> > >>>>
> > >>>>     trace_vtd_dmar_enable(en);
> > >>>>
> > >>>> ...
> > >>>>
> > >>>>     vtd_reset_caches(s);
> > >>>>     vtd_address_space_refresh_all(s);
> > >>>> }
> > >>>>
> > >>>> vtd_address_space_refresh_all() will basically disable the iommu
> > >>>> memory region. It looks not sufficient to trigger the region_del
> > >>>> callback, maybe we should delete the region or introduce listener
> > >>>> callback?
> > >>> This is exactly the code path which is entered in my use case.
> > >>>
> > >>> vtd_address_space_refresh_all(s) induces the vhost_iommu_region_del=
. But
> > >given the current implement of this latter the IOTLB callback is not u=
nset and the
> > >kernel IOTLB is not refreshed. Also as I pointed out the  hdev->mem->r=
egions are
> > >not updated? shouldn't they. Can you explain what they correspond to?
> > >> Adding Peter for more ideas.
> > >>
> > >> I think it's better to find a way to trigger the listener here, prob=
ably:
> > >>
> > >> 1) add/delete the memory regions instead of enable/disable
> > >sorry I don't understand what you mean. The vhost_iommu_region_del cal=
l
> > >stack is provided below [1]. Write to the intel iommu GCMD TE bit
> > >induces a call to vhost_iommu_region_del. This happens before the
> > >vhost_dev_stop whose call stack is provided below [2] and originates
> > >from a bus reset.
> > >
> > >We may have inflight IOTLB miss requests happening between both.
> > >
> > >If this happens, vhost_device_iotlb_miss() fails because the IOVA is n=
ot
> > >translated anymore by the IOMMU and the iotlb.translated_addr returned
> > >by address_space_get_iotlb_entry() is not within the registered
> > >vhost_memory_regions looked up in vhost_memory_region_lookup(), hence
> > >the "Fail to lookup the translated address" message.
> > >
> > >It sounds wrong that vhost keeps on using IOVAs that are not translate=
d
> > >anymore. It looks we have a reset ordering issue and this patch is jus=
t
> > >removing the sympton and not the cause.
> > >
> > >At the moment I don't really get what is initiating the intel iommu TE
> > >bit write. This is a guest action but is it initiated from a misordere=
d
> > >qemu event?
> >
> > During reboot, native_machine_shutdown() calls x86_platform.iommu_shutd=
own()
> > to disable iommu before reset. So Peter's patch will not address your i=
ssue.
> >
> > Before iommu shutdown, device_shutdown() is called to shutdown all devi=
ces.
> > Not clear why vhost is still active.
>
> It might be because neither virtio bus nor virtio-net provides a
> shutdown method.
>
> There used to be requests to provide those to unbreak the kexec.

More could be seen at https://issues.redhat.com/browse/RHEL-331

This looks exactly the same issue.

Thanks

>
> A quick try might be to provide a .driver.shutdown to
> virtio_net_driver structure and reset the device there as a start.
>
> Thanks
>
> >
> > Thanks
> > Zhenzhong
> >
> > >
> > >It could also relate to
> > >[PATCH 0/4] intel_iommu: Reset vIOMMU after all the rest of devices
> > >https://lore.kernel.org/all/?q=3Ds%3Aintel_iommu%3A+Reset+vIOMMU+after=
+all+
> > >the+rest+of+devices
> >


