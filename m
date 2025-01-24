Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6B6C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbFsT-0000lL-A6; Fri, 24 Jan 2025 04:21:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tbFsR-0000hY-54
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:21:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tbFsM-0000ys-No
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737710474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vR/bJ7/k6U4AM7e8DZBco+w8FC4eNah34CWSTPqGVjE=;
 b=hoGcNPdPlocmOynPyGgma3999/TUkBa68eqPq0tLGYiLvKzvRYJLVrBpyfwU1j0D26taBs
 +n3hi1CLkZZKXUcNpD8Tr0AT3OMUpr+RXQSWI9bNKRR7544BFizO9ZQuJoHWcN1ZpbdQ+a
 C8/EWiiFeyMr3JUkxzhSxR1WkuBw2Rk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-sNjMD7hENeOshPXjJTWlTw-1; Fri, 24 Jan 2025 04:21:11 -0500
X-MC-Unique: sNjMD7hENeOshPXjJTWlTw-1
X-Mimecast-MFC-AGG-ID: sNjMD7hENeOshPXjJTWlTw
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-21a7cbe3b56so29466925ad.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:21:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737710470; x=1738315270;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vR/bJ7/k6U4AM7e8DZBco+w8FC4eNah34CWSTPqGVjE=;
 b=UX6vaYL5YB+kAZsnD997VwOwOlStvE9Qh2Arbocj6vMEg0b6kq72L6hj2h40f/3HSu
 z/XLG9ZYTsOEpJJjTT9Nce4lTLqXOhWS4HRHPb6PEA2z7QHnwL/s5kaUfCGl1ItRtNfz
 gKwGf5l6lPu6JzNYcJybDGgsw6/ZgvNLNj3Z/QVtJj4OWcIGm4/00EX8p7UlHH45M1ZU
 zPsXfqFWoNixpjHg4RrEpY36kS2qD64JcIA9GzoiHikQ2U+f3JLpFEyb/yeEUj5n0xKA
 o/t9uTXHKMifNdw0Mi/AIqZxfl4d33QQ7oxA4lxsA9AlKT7dzpydLDjxUjek1Bm9F4g6
 WvbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXoWi0K1a+KYozuIQyVYAAwxEccKm074Qt0+AaDhIsWcZ/mTIwzlUYktv8oAjuvabebgtuKiT7g9jb@nongnu.org
X-Gm-Message-State: AOJu0YxUPVHbvpfoNmM/ZZzgr/tfcbXX+HdFsUzjjjhDk8UcXjM/wJbz
 XkF2tNHaynTHNCaDV/u8AQa/yReJJDZM9tlm08mvhW6Neoaid4DmMmuNp1rLgKlNkzEd8lyki3q
 6HjBD2A3TP4QL6wr7/y5DfHpqX3s8AKWE84A++NgZQLXcmUMZKU36Igcws5EyQYa9wXlbvhiV+I
 JqSTs8fzIFDBBeLscOUaol+OvSUbE=
X-Gm-Gg: ASbGncsQ/m9O++k05OcG1usg+R7R8nHuSd7laHM789WJ26AkXoH2s/YWeq4THXa6mjP
 7Z/7laE46cNg6Y18gnq8phnDuUlMBohMvpcc5mw3D9Hswlvcamg==
X-Received: by 2002:a05:6a20:7f95:b0:1e6:8f23:ba70 with SMTP id
 adf61e73a8af0-1eb215b280emr43978317637.41.1737710470445; 
 Fri, 24 Jan 2025 01:21:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgLbKHOuOScoBQxUDwLZGNQrlh13P3vWyqQePw1/791+YwnChjBSJPIEv3g/JKQ150ddrPjfCaC9P59vtBfyw=
X-Received: by 2002:a05:6a20:7f95:b0:1e6:8f23:ba70 with SMTP id
 adf61e73a8af0-1eb215b280emr43978268637.41.1737710469955; Fri, 24 Jan 2025
 01:21:09 -0800 (PST)
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
 <CACGkMEvOht6KaJ=x2LkD=C2o+4xgixdyXMqbfuXq7-KQPdkwgQ@mail.gmail.com>
 <SJ0PR11MB6744A84009D365C4CCA45D9292E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744A84009D365C4CCA45D9292E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 24 Jan 2025 17:20:58 +0800
X-Gm-Features: AWEUYZnEcBvYKMW9OtN0FlST1eH0HOmZG8vJ_ESejPknx-Yc8AVpS9d8fxaW0J4
Message-ID: <CACGkMEup5ENfD8OFEtJv7pXyBFhtW9ciUmz2Z=ejN_Pfbp_usA@mail.gmail.com>
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

On Fri, Jan 24, 2025 at 12:01=E2=80=AFPM Duan, Zhenzhong
<zhenzhong.duan@intel.com> wrote:
>
>
>
> >-----Original Message-----
> >From: Jason Wang <jasowang@redhat.com>
> >Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU=
 gets
> >disabled
> >
> >On Fri, Jan 24, 2025 at 11:30=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> >>
> >> On Fri, Jan 24, 2025 at 10:44=E2=80=AFAM Duan, Zhenzhong
> >> <zhenzhong.duan@intel.com> wrote:
> >> >
> >> >
> >> >
> >> > >-----Original Message-----
> >> > >From: Eric Auger <eric.auger@redhat.com>
> >> > >Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when =
IOMMU
> >gets
> >> > >disabled
> >> > >
> >> > >Hi Jason,
> >> > >
> >> > >
> >> > >On 1/23/25 2:34 AM, Jason Wang wrote:
> >> > >> On Wed, Jan 22, 2025 at 3:55=E2=80=AFPM Eric Auger <eric.auger@re=
dhat.com>
> >wrote:
> >> > >>> Hi Jason,
> >> > >>>
> >> > >>>
> >> > >>> On 1/22/25 8:17 AM, Jason Wang wrote:
> >> > >>>> On Wed, Jan 22, 2025 at 12:25=E2=80=AFAM Eric Auger <eric.auger=
@redhat.com>
> >> > >wrote:
> >> > >>>>> Hi Jason,
> >> > >>>>>
> >> > >>>>> On 1/21/25 4:27 AM, Jason Wang wrote:
> >> > >>>>>> On Tue, Jan 21, 2025 at 1:33=E2=80=AFAM Eric Auger <eric.auge=
r@redhat.com>
> >> > >wrote:
> >> > >>>>>>> When a guest exposed with a vhost device and protected by an
> >> > >>>>>>> intel IOMMU gets rebooted, we sometimes observe a spurious
> >warning:
> >> > >>>>>>>
> >> > >>>>>>> Fail to lookup the translated address ffffe000
> >> > >>>>>>>
> >> > >>>>>>> We observe that the IOMMU gets disabled through a write to t=
he
> >global
> >> > >>>>>>> command register (CMAR_GCMD.TE) before the vhost device gets
> >> > >stopped.
> >> > >>>>>>> When this warning happens it can be observed an inflight IOT=
LB
> >> > >>>>>>> miss occurs after the IOMMU disable and before the vhost sto=
p. In
> >> > >>>>>>> that case a flat translation occurs and the check in
> >> > >>>>>>> vhost_memory_region_lookup() fails.
> >> > >>>>>>>
> >> > >>>>>>> Let's disable the IOTLB callbacks when all IOMMU MRs have be=
en
> >> > >>>>>>> unregistered.
> >> > >>>>>>>
> >> > >>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> > >>>>>>> ---
> >> > >>>>>>>  hw/virtio/vhost.c | 4 ++++
> >> > >>>>>>>  1 file changed, 4 insertions(+)
> >> > >>>>>>>
> >> > >>>>>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >> > >>>>>>> index 6aa72fd434..128c2ab094 100644
> >> > >>>>>>> --- a/hw/virtio/vhost.c
> >> > >>>>>>> +++ b/hw/virtio/vhost.c
> >> > >>>>>>> @@ -931,6 +931,10 @@ static void
> >> > >vhost_iommu_region_del(MemoryListener *listener,
> >> > >>>>>>>              break;
> >> > >>>>>>>          }
> >> > >>>>>>>      }
> >> > >>>>>>> +    if (QLIST_EMPTY(&dev->iommu_list) &&
> >> > >>>>>>> +        dev->vhost_ops->vhost_set_iotlb_callback) {
> >> > >>>>>>> +        dev->vhost_ops->vhost_set_iotlb_callback(dev, false=
);
> >> > >>>>>>> +    }
> >> > >>>>>> So the current code assumes:
> >> > >>>>>>
> >> > >>>>>> 1) IOMMU is enabled before vhost starts
> >> > >>>>>> 2) IOMMU is disabled after vhost stops
> >> > >>>>>>
> >> > >>>>>> This patch seems to fix 2) but not 1). Do we need to deal wit=
h the
> >> > >>>>>> IOMMU enabled after vhost starts?
> >> > >>>>> sorry I initially misunderstood the above comment. Indeed in t=
he
> >reboot
> >> > >>>>> case assumption 2) happens to be wrong. However what I current=
ly do
> >is:
> >> > >>>>> stop listening to iotlb miss requests from the kernel because =
my
> >> > >>>>> understanding is those requests are just spurious ones, genera=
te
> >> > >>>>> warnings and we do not care since we are rebooting the system.
> >> > >>>>>
> >> > >>>>> However I do not claim this could handle the case where the IO=
MMU
> >MR
> >> > >>>>> would be turned off and then turned on. I think in that case w=
e should
> >> > >>>>> also flush the kernel IOTLB and this is not taken care of in t=
his patch.
> >> > >>>>> Is it a relevant use case?
> >> > >>>> Not sure.
> >> > >>>>
> >> > >>>>> wrt removing assumption 1) and allow IOMMU enabled after vhost
> >start. Is
> >> > >>>>> that a valid use case as the virtio driver is using the dma ap=
i?
> >> > >>>> It should not be but we can't assume the behaviour of the guest=
. It
> >> > >>>> could be buggy or even malicious.
> >> > >>> agreed
> >> > >>>> Btw, we had the following codes while handling te:
> >> > >>>>
> >> > >>>> /* Handle Translation Enable/Disable */
> >> > >>>> static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
> >> > >>>> {
> >> > >>>>     if (s->dmar_enabled =3D=3D en) {
> >> > >>>>         return;
> >> > >>>>     }
> >> > >>>>
> >> > >>>>     trace_vtd_dmar_enable(en);
> >> > >>>>
> >> > >>>> ...
> >> > >>>>
> >> > >>>>     vtd_reset_caches(s);
> >> > >>>>     vtd_address_space_refresh_all(s);
> >> > >>>> }
> >> > >>>>
> >> > >>>> vtd_address_space_refresh_all() will basically disable the iomm=
u
> >> > >>>> memory region. It looks not sufficient to trigger the region_de=
l
> >> > >>>> callback, maybe we should delete the region or introduce listen=
er
> >> > >>>> callback?
> >> > >>> This is exactly the code path which is entered in my use case.
> >> > >>>
> >> > >>> vtd_address_space_refresh_all(s) induces the vhost_iommu_region_=
del.
> >But
> >> > >given the current implement of this latter the IOTLB callback is no=
t unset and
> >the
> >> > >kernel IOTLB is not refreshed. Also as I pointed out the  hdev->mem=
->regions
> >are
> >> > >not updated? shouldn't they. Can you explain what they correspond t=
o?
> >> > >> Adding Peter for more ideas.
> >> > >>
> >> > >> I think it's better to find a way to trigger the listener here, p=
robably:
> >> > >>
> >> > >> 1) add/delete the memory regions instead of enable/disable
> >> > >sorry I don't understand what you mean. The vhost_iommu_region_del =
call
> >> > >stack is provided below [1]. Write to the intel iommu GCMD TE bit
> >> > >induces a call to vhost_iommu_region_del. This happens before the
> >> > >vhost_dev_stop whose call stack is provided below [2] and originate=
s
> >> > >from a bus reset.
> >> > >
> >> > >We may have inflight IOTLB miss requests happening between both.
> >> > >
> >> > >If this happens, vhost_device_iotlb_miss() fails because the IOVA i=
s not
> >> > >translated anymore by the IOMMU and the iotlb.translated_addr retur=
ned
> >> > >by address_space_get_iotlb_entry() is not within the registered
> >> > >vhost_memory_regions looked up in vhost_memory_region_lookup(), hen=
ce
> >> > >the "Fail to lookup the translated address" message.
> >> > >
> >> > >It sounds wrong that vhost keeps on using IOVAs that are not transl=
ated
> >> > >anymore. It looks we have a reset ordering issue and this patch is =
just
> >> > >removing the sympton and not the cause.
> >> > >
> >> > >At the moment I don't really get what is initiating the intel iommu=
 TE
> >> > >bit write. This is a guest action but is it initiated from a misord=
ered
> >> > >qemu event?
> >> >
> >> > During reboot, native_machine_shutdown() calls
> >x86_platform.iommu_shutdown()
> >> > to disable iommu before reset. So Peter's patch will not address you=
r issue.
> >> >
> >> > Before iommu shutdown, device_shutdown() is called to shutdown all d=
evices.
> >> > Not clear why vhost is still active.
> >>
> >> It might be because neither virtio bus nor virtio-net provides a
> >> shutdown method.
>
> Oh, I see.
>
> >>
> >> There used to be requests to provide those to unbreak the kexec.
> >
> >More could be seen at https://issues.redhat.com/browse/RHEL-331
> >
> >This looks exactly the same issue.
>
> Have not access=F0=9F=98=8A

It should work now.

Thanks

>
> >
> >Thanks
> >
> >>
> >> A quick try might be to provide a .driver.shutdown to
> >> virtio_net_driver structure and reset the device there as a start.
>
> Make sense.
>
> Thanks
> Zhenzhong


