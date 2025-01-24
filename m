Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44021C02182
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 01:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb8oM-0004p7-IL; Thu, 23 Jan 2025 20:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tb8oJ-0004oa-Lv
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 20:48:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tb8oF-0002tQ-HS
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 20:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737683312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zYC6sxlsFcj1jEawCNGvobs5FPofsMPEiiVm0itlwrE=;
 b=K4mgsImJI9x9nxBTBLYIA8npEAwG2f0QbdVBUX+3Lm/u8aqlcyXGfOfD2V2C77f9tX/4Kq
 k7lzfLY50dWKgKUy5ww6IlKVnTgaIPLT2QJn8sLWDDBbv1tsanlUS3prGOUhTN+tEr9Bct
 j9jdEQRTgELZ34b62kbM1y+REeUJcIM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-SwD01RTJP2G2TFlaouEseQ-1; Thu, 23 Jan 2025 20:48:30 -0500
X-MC-Unique: SwD01RTJP2G2TFlaouEseQ-1
X-Mimecast-MFC-AGG-ID: SwD01RTJP2G2TFlaouEseQ
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ef9864e006so4550301a91.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 17:48:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737683309; x=1738288109;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zYC6sxlsFcj1jEawCNGvobs5FPofsMPEiiVm0itlwrE=;
 b=DlH6mgyBYsHzAmlgYTucB5AtbxJP7rbazV2mwvZ0dCVK88XgpDOGhPPg+DFQG+b+/2
 X0FIntXRHivo8zRijkfffBMm7uLERDQeUk3GEbo5PaupJ9APPBrxp3fpSCAB5dLMpfUG
 9ODUfTSuryuozoUkRAhfjX4loWnfvAO8g0E9eGtgowbeGi6jsh6/GrFD7oN1ca3nE/iT
 elrZJU3Ja5oOovadFlMusXUyr7rRK4IlvtUvYBkfTb/ylmmSavliEmrMivBLne4PlopK
 pc/6CMb8EDFVjkmZb7J3nWI5jORrbYLRkVuDIcr0dDPX9AD1kINDx4srhQ/0Yuq6x/HS
 0VsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI5w+85NeIQcMee8Fqfy2wO/de8MxGdTVMcKdgHkN6BbxicnKGybvOz9V2suRuIoiT+ntMAG5xQNnQ@nongnu.org
X-Gm-Message-State: AOJu0YwSrATaRZ2cWZ7wWR2fvvUEX1J61YJSIBx9M0eQ6jUA7t9sKha6
 M6T74ZSx4W/oaeE/gmTXmy2vJJtXgdeJDCZUJfZJyVTSxEFQgMOeyS0FBzBMMZDjZoC7xyBd8FI
 27MaoWYyo8Wi45QMYid9AsVNBp5ElxKTP35Ew23pupCAn7TiQzIrywTV7y1z5EBWDVIv6yA5PUT
 kWT/9KaGpKXGon33Rh8021vY0cEG0=
X-Gm-Gg: ASbGnctOueBIptlGHXBL5GKkeXNK139jCymLuywUW4p5NfmUj8TPlqGkcwlVz+3kRrz
 Zr2gUiDQi2INS/icIz7AGeqs2gHDAHdz+c+d8spzgQ6HgnWEYoQ==
X-Received: by 2002:a05:6a00:21c8:b0:725:9dc7:4f8b with SMTP id
 d2e1a72fcca58-72dafb6fcafmr36660306b3a.15.1737683309514; 
 Thu, 23 Jan 2025 17:48:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9O9+DItPo1GK52p5DQ5kisTLntO7tPgm0v+ddwvzhDvLJVlfNk8fIryfmnmZfQ2gOmf7IelPLtH345s/mbjU=
X-Received: by 2002:a05:6a00:21c8:b0:725:9dc7:4f8b with SMTP id
 d2e1a72fcca58-72dafb6fcafmr36660270b3a.15.1737683308947; Thu, 23 Jan 2025
 17:48:28 -0800 (PST)
MIME-Version: 1.0
References: <20250120173339.865681-1-eric.auger@redhat.com>
 <CACGkMEu4oMa8Sf9QXtszeoSMj_67Csr0s7kHdYfbNnJWibu2dA@mail.gmail.com>
 <5a55011a-af8f-483a-99fa-5cb2cdf3841f@redhat.com>
 <CACGkMEv6ec3JLZg6ZedSHdNS5_McX7_xoV4d2MG05x_Y5t=uEA@mail.gmail.com>
 <678babb6-f64a-4db5-ad60-494214a4e673@redhat.com>
 <CACGkMEvyYT7-PTOwO-Jg9a8AHA0AJHoV2BY2RBrJTGKEFYL6QA@mail.gmail.com>
 <25b5bb73-abd8-4008-905d-6c2e9e1330e2@redhat.com>
In-Reply-To: <25b5bb73-abd8-4008-905d-6c2e9e1330e2@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 24 Jan 2025 09:48:04 +0800
X-Gm-Features: AWEUYZn59YwCS6hQDdl4P6q4u-xr4-rBJzS9PK7iVpxTr4WD6zdMlUdfzbgoPx0
Message-ID: <CACGkMEu=Cwa2wQEZQyE6FZ26KVZD4uMbFvg0uLOb3=23e1MZSw@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
To: eric.auger@redhat.com
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, mst@redhat.com, 
 sgarzare@redhat.com, lvivier@redhat.com, zhenzhong.duan@intel.com, 
 Peter Xu <peterx@redhat.com>, 
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>, "Liu,
 Yi L" <yi.l.liu@intel.com>
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

On Thu, Jan 23, 2025 at 4:31=E2=80=AFPM Eric Auger <eric.auger@redhat.com> =
wrote:
>
> Hi Jason,
>
>
> On 1/23/25 2:34 AM, Jason Wang wrote:
> > On Wed, Jan 22, 2025 at 3:55=E2=80=AFPM Eric Auger <eric.auger@redhat.c=
om> wrote:
> >> Hi Jason,
> >>
> >>
> >> On 1/22/25 8:17 AM, Jason Wang wrote:
> >>> On Wed, Jan 22, 2025 at 12:25=E2=80=AFAM Eric Auger <eric.auger@redha=
t.com> wrote:
> >>>> Hi Jason,
> >>>>
> >>>> On 1/21/25 4:27 AM, Jason Wang wrote:
> >>>>> On Tue, Jan 21, 2025 at 1:33=E2=80=AFAM Eric Auger <eric.auger@redh=
at.com> wrote:
> >>>>>> When a guest exposed with a vhost device and protected by an
> >>>>>> intel IOMMU gets rebooted, we sometimes observe a spurious warning=
:
> >>>>>>
> >>>>>> Fail to lookup the translated address ffffe000
> >>>>>>
> >>>>>> We observe that the IOMMU gets disabled through a write to the glo=
bal
> >>>>>> command register (CMAR_GCMD.TE) before the vhost device gets stopp=
ed.
> >>>>>> When this warning happens it can be observed an inflight IOTLB
> >>>>>> miss occurs after the IOMMU disable and before the vhost stop. In
> >>>>>> that case a flat translation occurs and the check in
> >>>>>> vhost_memory_region_lookup() fails.
> >>>>>>
> >>>>>> Let's disable the IOTLB callbacks when all IOMMU MRs have been
> >>>>>> unregistered.
> >>>>>>
> >>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>>>>> ---
> >>>>>>  hw/virtio/vhost.c | 4 ++++
> >>>>>>  1 file changed, 4 insertions(+)
> >>>>>>
> >>>>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >>>>>> index 6aa72fd434..128c2ab094 100644
> >>>>>> --- a/hw/virtio/vhost.c
> >>>>>> +++ b/hw/virtio/vhost.c
> >>>>>> @@ -931,6 +931,10 @@ static void vhost_iommu_region_del(MemoryList=
ener *listener,
> >>>>>>              break;
> >>>>>>          }
> >>>>>>      }
> >>>>>> +    if (QLIST_EMPTY(&dev->iommu_list) &&
> >>>>>> +        dev->vhost_ops->vhost_set_iotlb_callback) {
> >>>>>> +        dev->vhost_ops->vhost_set_iotlb_callback(dev, false);
> >>>>>> +    }
> >>>>> So the current code assumes:
> >>>>>
> >>>>> 1) IOMMU is enabled before vhost starts
> >>>>> 2) IOMMU is disabled after vhost stops
> >>>>>
> >>>>> This patch seems to fix 2) but not 1). Do we need to deal with the
> >>>>> IOMMU enabled after vhost starts?
> >>>> sorry I initially misunderstood the above comment. Indeed in the reb=
oot
> >>>> case assumption 2) happens to be wrong. However what I currently do =
is:
> >>>> stop listening to iotlb miss requests from the kernel because my
> >>>> understanding is those requests are just spurious ones, generate
> >>>> warnings and we do not care since we are rebooting the system.
> >>>>
> >>>> However I do not claim this could handle the case where the IOMMU MR
> >>>> would be turned off and then turned on. I think in that case we shou=
ld
> >>>> also flush the kernel IOTLB and this is not taken care of in this pa=
tch.
> >>>> Is it a relevant use case?
> >>> Not sure.
> >>>
> >>>> wrt removing assumption 1) and allow IOMMU enabled after vhost start=
. Is
> >>>> that a valid use case as the virtio driver is using the dma api?
> >>> It should not be but we can't assume the behaviour of the guest. It
> >>> could be buggy or even malicious.
> >> agreed
> >>> Btw, we had the following codes while handling te:
> >>>
> >>> /* Handle Translation Enable/Disable */
> >>> static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
> >>> {
> >>>     if (s->dmar_enabled =3D=3D en) {
> >>>         return;
> >>>     }
> >>>
> >>>     trace_vtd_dmar_enable(en);
> >>>
> >>> ...
> >>>
> >>>     vtd_reset_caches(s);
> >>>     vtd_address_space_refresh_all(s);
> >>> }
> >>>
> >>> vtd_address_space_refresh_all() will basically disable the iommu
> >>> memory region. It looks not sufficient to trigger the region_del
> >>> callback, maybe we should delete the region or introduce listener
> >>> callback?
> >> This is exactly the code path which is entered in my use case.
> >>
> >> vtd_address_space_refresh_all(s) induces the vhost_iommu_region_del. B=
ut given the current implement of this latter the IOTLB callback is not uns=
et and the kernel IOTLB is not refreshed. Also as I pointed out the  hdev->=
mem->regions are not updated? shouldn't they. Can you explain what they cor=
respond to?
> > Adding Peter for more ideas.
> >
> > I think it's better to find a way to trigger the listener here, probabl=
y:
> >
> > 1) add/delete the memory regions instead of enable/disable
> sorry I don't understand what you mean. The vhost_iommu_region_del call
> stack is provided below [1]. Write to the intel iommu GCMD TE bit
> induces a call to vhost_iommu_region_del. This happens before the
> vhost_dev_stop whose call stack is provided below [2] and originates
> from a bus reset.

Right, I see.

>
> We may have inflight IOTLB miss requests happening between both.
>
> If this happens, vhost_device_iotlb_miss() fails because the IOVA is not
> translated anymore by the IOMMU and the iotlb.translated_addr returned
> by address_space_get_iotlb_entry() is not within the registered
> vhost_memory_regions looked up in vhost_memory_region_lookup(), hence
> the "Fail to lookup the translated address" message.
>
> It sounds wrong that vhost keeps on using IOVAs that are not translated
> anymore. It looks we have a reset ordering issue and this patch is just
> removing the sympton and not the cause.

Exactly.

>
> At the moment I don't really get what is initiating the intel iommu TE
> bit write. This is a guest action but is it initiated from a misordered
> qemu event?

It could also be a guest bug which reset the vIOMMU before the device.
Do we have a calltrace in the guest?

Adding more vtd maintiners for more thoughts.

Thanks

>
> It could also relate to
> [PATCH 0/4] intel_iommu: Reset vIOMMU after all the rest of devices
> https://lore.kernel.org/all/?q=3Ds%3Aintel_iommu%3A+Reset+vIOMMU+after+al=
l+the+rest+of+devices
>
> Thanks
>
> Eric
>
>
>
>
> [1]
> #0  vhost_iommu_region_del (listener=3D0x55555708a388,
> section=3D0x7ffff62bf030) at ../hw/virtio/vhost.c:927
> #1  0x0000555555c851b4 in address_space_update_topology_pass
> (as=3D0x55555822e4f0, old_view=3D0x7fffe8e81850, new_view=3D0x55555723dfa=
0,
> adding=3Dfalse) at ../system/memory.c:977
> #2  0x0000555555c857a0 in address_space_set_flatview (as=3D0x55555822e4f0=
)
> at ../system/memory.c:1079
> #3  0x0000555555c85986 in memory_region_transaction_commit () at
> ../system/memory.c:1132
> #4  0x0000555555c89f25 in memory_region_set_enabled (mr=3D0x555557dc0d30,
> enabled=3Dfalse) at ../system/memory.c:2686
> #5  0x0000555555b5edb1 in vtd_switch_address_space (as=3D0x555557dc0c60)
> at ../hw/i386/intel_iommu.c:1735
> #6  0x0000555555b5ee6f in vtd_switch_address_space_all
> (s=3D0x555557db1500) at ../hw/i386/intel_iommu.c:1779
> #7  0x0000555555b64533 in vtd_address_space_refresh_all
> (s=3D0x555557db1500) at ../hw/i386/intel_iommu.c:4006
> #8  0x0000555555b60770 in vtd_handle_gcmd_te (s=3D0x555557db1500,
> en=3Dfalse) at ../hw/i386/intel_iommu.c:2419
> #9  0x0000555555b60885 in vtd_handle_gcmd_write (s=3D0x555557db1500) at
> ../hw/i386/intel_iommu.c:2449
> #10 0x0000555555b61db2 in vtd_mem_write (opaque=3D0x555557db1500, addr=3D=
24,
> val=3D100663296, size=3D4) at ../hw/i386/intel_iommu.c:2991
> #11 0x0000555555c833e0 in memory_region_write_accessor
> (mr=3D0x555557db1840, addr=3D24, value=3D0x7ffff62bf3d8, size=3D4, shift=
=3D0,
> mask=3D4294967295, attrs=3D...) at ../system/memory.c:497
> #12 0x0000555555c83711 in access_with_adjusted_size
>     (addr=3D24, value=3D0x7ffff62bf3d8, size=3D4, access_size_min=3D4,
> access_size_max=3D8, access_fn=3D0x555555c832ea
> <memory_region_write_accessor>, mr=3D0x555557db1840, attrs=3D...)
>     at ../system/memory.c:573
> #13 0x0000555555c8698b in memory_region_dispatch_write
> (mr=3D0x555557db1840, addr=3D24, data=3D100663296, op=3DMO_32, attrs=3D..=
.) at
> ../system/memory.c:1521
> #14 0x0000555555c95619 in flatview_write_continue_step (attrs=3D...,
> buf=3D0x7ffff7fbb028 "", len=3D4, mr_addr=3D24, l=3D0x7ffff62bf4c0,
> mr=3D0x555557db1840) at ../system/physmem.c:2803
> #15 0x0000555555c956eb in flatview_write_continue (fv=3D0x7fffe852d370,
> addr=3D4275634200, attrs=3D..., ptr=3D0x7ffff7fbb028, len=3D4, mr_addr=3D=
24, l=3D4,
> mr=3D0x555557db1840) at ../system/physmem.c:2833
> #16 0x0000555555c957f9 in flatview_write (fv=3D0x7fffe852d370,
> addr=3D4275634200, attrs=3D..., buf=3D0x7ffff7fbb028, len=3D4) at
> ../system/physmem.c:2864
> #17 0x0000555555c95c39 in address_space_write (as=3D0x555556ff1720
> <address_space_memory>, addr=3D4275634200, attrs=3D..., buf=3D0x7ffff7fbb=
028,
> len=3D4) at ../system/physmem.c:2984
> #18 0x0000555555c95cb1 in address_space_rw (as=3D0x555556ff1720
> <address_space_memory>, addr=3D4275634200, attrs=3D..., buf=3D0x7ffff7fbb=
028,
> len=3D4, is_write=3Dtrue) at ../system/physmem.c:2994
> #19 0x0000555555ceeb56 in kvm_cpu_exec (cpu=3D0x55555727e950) at
> ../accel/kvm/kvm-all.c:3188
> #20 0x0000555555cf1ea6 in kvm_vcpu_thread_fn (arg=3D0x55555727e950) at
> ../accel/kvm/kvm-accel-ops.c:50
> #21 0x0000555555f6de20 in qemu_thread_start (args=3D0x555557288960) at
> ../util/qemu-thread-posix.c:541
> #22 0x00007ffff7289e92 in start_thread () at /lib64/libc.so.6
>
> [2]
> #0  vhost_dev_stop (hdev=3D0x55555708a2c0, vdev=3D0x555558234cb0,
> vrings=3Dfalse) at ../hw/virtio/vhost.c:2222
> #1  0x0000555555990266 in vhost_net_stop_one (net=3D0x55555708a2c0,
> dev=3D0x555558234cb0) at ../hw/net/vhost_net.c:350
> #2  0x00005555559906ea in vhost_net_stop (dev=3D0x555558234cb0,
> ncs=3D0x55555826f968, data_queue_pairs=3D1, cvq=3D0) at ../hw/net/vhost_n=
et.c:462
> #3  0x0000555555c1ad0a in virtio_net_vhost_status (n=3D0x555558234cb0,
> status=3D0 '\000') at ../hw/net/virtio-net.c:318
> #4  0x0000555555c1afaf in virtio_net_set_status (vdev=3D0x555558234cb0,
> status=3D0 '\000') at ../hw/net/virtio-net.c:393
> #5  0x0000555555c591bd in virtio_set_status (vdev=3D0x555558234cb0, val=
=3D0
> '\000') at ../hw/virtio/virtio.c:2242
> #6  0x0000555555c595eb in virtio_reset (opaque=3D0x555558234cb0) at
> ../hw/virtio/virtio.c:2325
> #7  0x0000555555a0d1e1 in virtio_bus_reset (bus=3D0x555558234c30) at
> ../hw/virtio/virtio-bus.c:109
> #8  0x0000555555a13d51 in virtio_pci_reset (qdev=3D0x55555822c830) at
> ../hw/virtio/virtio-pci.c:2282
> #9  0x0000555555a14016 in virtio_pci_bus_reset_hold (obj=3D0x55555822c830=
,
> type=3DRESET_TYPE_COLD) at ../hw/virtio/virtio-pci.c:2322
> #10 0x0000555555d08831 in resettable_phase_hold (obj=3D0x55555822c830,
> opaque=3D0x0, type=3DRESET_TYPE_COLD) at ../hw/core/resettable.c:180
> #11 0x0000555555d00fc5 in bus_reset_child_foreach (obj=3D0x555557ffa3c0,
> cb=3D0x555555d086d5 <resettable_phase_hold>, opaque=3D0x0,
> type=3DRESET_TYPE_COLD) at ../hw/core/bus.c:97
> #12 0x0000555555d084d8 in resettable_child_foreach (rc=3D0x555557146f20,
> obj=3D0x555557ffa3c0, cb=3D0x555555d086d5 <resettable_phase_hold>,
> opaque=3D0x0, type=3DRESET_TYPE_COLD) at ../hw/core/resettable.c:92
> #13 0x0000555555d08792 in resettable_phase_hold (obj=3D0x555557ffa3c0,
> opaque=3D0x0, type=3DRESET_TYPE_COLD) at ../hw/core/resettable.c:169
> #14 0x0000555555d0543b in device_reset_child_foreach
> (obj=3D0x555557ff98e0, cb=3D0x555555d086d5 <resettable_phase_hold>,
> opaque=3D0x0, type=3DRESET_TYPE_COLD) at ../hw/core/qdev.c:275
> #15 0x0000555555d084d8 in resettable_child_foreach (rc=3D0x55555715a090,
> obj=3D0x555557ff98e0, cb=3D0x555555d086d5 <resettable_phase_hold>,
> opaque=3D0x0, type=3DRESET_TYPE_COLD) at ../hw/core/resettable.c:92
> #16 0x0000555555d08792 in resettable_phase_hold (obj=3D0x555557ff98e0,
> opaque=3D0x0, type=3DRESET_TYPE_COLD) at ../hw/core/resettable.c:169
> #17 0x0000555555d00fc5 in bus_reset_child_foreach (obj=3D0x555557445120,
> cb=3D0x555555d086d5 <resettable_phase_hold>, opaque=3D0x0,
> type=3DRESET_TYPE_COLD) at ../hw/core/bus.c:97
> #18 0x0000555555d084d8 in resettable_child_foreach (rc=3D0x555557146f20,
> obj=3D0x555557445120, cb=3D0x555555d086d5 <resettable_phase_hold>,
> opaque=3D0x0, type=3DRESET_TYPE_COLD) at ../hw/core/resettable.c:92
> #19 0x0000555555d08792 in resettable_phase_hold (obj=3D0x555557445120,
> opaque=3D0x0, type=3DRESET_TYPE_COLD) at ../hw/core/resettable.c:169
> #20 0x0000555555d0543b in device_reset_child_foreach
> (obj=3D0x5555572d0a00, cb=3D0x555555d086d5 <resettable_phase_hold>,
> opaque=3D0x0, type=3DRESET_TYPE_COLD) at ../hw/core/qdev.c:275
> #21 0x0000555555d084d8 in resettable_child_foreach (rc=3D0x5555570cf410,
> obj=3D0x5555572d0a00, cb=3D0x555555d086d5 <resettable_phase_hold>,
> opaque=3D0x0, type=3DRESET_TYPE_COLD) at ../hw/core/resettable.c:92
> #22 0x0000555555d08792 in resettable_phase_hold (obj=3D0x5555572d0a00,
> opaque=3D0x0, type=3DRESET_TYPE_COLD) at ../hw/core/resettable.c:169
> #23 0x0000555555d00fc5 in bus_reset_child_foreach (obj=3D0x55555723d270,
> cb=3D0x555555d086d5 <resettable_phase_hold>, opaque=3D0x0,
> type=3DRESET_TYPE_COLD) at ../hw/core/bus.c:97
> #24 0x0000555555d084d8 in resettable_child_foreach (rc=3D0x5555571bfde0,
> obj=3D0x55555723d270, cb=3D0x555555d086d5 <resettable_phase_hold>,
> opaque=3D0x0, type=3DRESET_TYPE_COLD) at ../hw/core/resettable.c:92
> #25 0x0000555555d08792 in resettable_phase_hold (obj=3D0x55555723d270,
> opaque=3D0x0, type=3DRESET_TYPE_COLD) at ../hw/core/resettable.c:169
> #26 0x0000555555d06d6d in resettable_container_child_foreach
> (obj=3D0x55555724a8a0, cb=3D0x555555d086d5 <resettable_phase_hold>,
> opaque=3D0x0, type=3DRESET_TYPE_COLD) at ../hw/core/resetcontainer.c:54
> #27 0x0000555555d084d8 in resettable_child_foreach (rc=3D0x5555572180f0,
> obj=3D0x55555724a8a0, cb=3D0x555555d086d5 <resettable_phase_hold>,
> opaque=3D0x0, type=3DRESET_TYPE_COLD) at ../hw/core/resettable.c:92
> #28 0x0000555555d08792 in resettable_phase_hold (obj=3D0x55555724a8a0,
> opaque=3D0x0, type=3DRESET_TYPE_COLD) at ../hw/core/resettable.c:169
> #29 0x0000555555d0838d in resettable_assert_reset (obj=3D0x55555724a8a0,
> type=3DRESET_TYPE_COLD) at ../hw/core/resettable.c:58
> #30 0x0000555555d082e5 in resettable_reset (obj=3D0x55555724a8a0,
> type=3DRESET_TYPE_COLD) at ../hw/core/resettable.c:45
> #31 0x00005555558db5c8 in qemu_devices_reset
> (reason=3DSHUTDOWN_CAUSE_GUEST_RESET) at ../hw/core/reset.c:179
> #32 0x0000555555b6f5b2 in pc_machine_reset (machine=3D0x555557234490,
> reason=3DSHUTDOWN_CAUSE_GUEST_RESET) at ../hw/i386/pc.c:1877
> #33 0x0000555555a5a0a2 in qemu_system_reset
> (reason=3DSHUTDOWN_CAUSE_GUEST_RESET) at ../system/runstate.c:516
> #34 0x0000555555a5a891 in main_loop_should_exit (status=3D0x7fffffffd574)
> at ../system/runstate.c:792
> #35 0x0000555555a5a992 in qemu_main_loop () at ../system/runstate.c:825
> #36 0x0000555555e9cced in qemu_default_main () at ../system/main.c:37
> #37 0x0000555555e9cd2a in main (argc=3D58, argv=3D0x7fffffffd6d8) at
> ../system/main.c:48
>
>
> >
> > or
> >
> > 2) introduce new listener ops that can be triggered when a region is
> > enabled or disabled
> >
> > Thanks
> >
> >> Thanks
> >>
> >> Eric
> >>
> >>> Thanks
> >>>
> >>>> Eric
> >>>>
> >>>>
> >>>>> Thanks
> >>>>>
> >>>>>>  }
> >>>>>>
> >>>>>>  void vhost_toggle_device_iotlb(VirtIODevice *vdev)
> >>>>>> --
> >>>>>> 2.47.1
> >>>>>>
>


