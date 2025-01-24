Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C63BC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 03:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbAPj-0008TW-Bw; Thu, 23 Jan 2025 22:31:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tbAPe-0008Sw-IW
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 22:31:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tbAPc-0003Qq-2O
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 22:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737689473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J17h++/Fqn3buhimynx1h8Z8eMPFEHi3/WtoJOmOpm8=;
 b=MFUS+1Abp7dszKIImxJYnI1XakMA6fGHMxEhURt9gVFIFAyX9IzszFcC2k+WhXPQ8gAur7
 VMWRPP1P6rFMN3984IYCxXLWgg2ECdKDWI7Dk7ZXAnc9FVtFGAnu2ZgLZZDNfIVgmyNbhB
 SWHev/ttTfBrdIe9W5o+7b/lpLHbfT4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-xYTPEBDWPzW0JLvqjSYPTg-1; Thu, 23 Jan 2025 22:31:10 -0500
X-MC-Unique: xYTPEBDWPzW0JLvqjSYPTg-1
X-Mimecast-MFC-AGG-ID: xYTPEBDWPzW0JLvqjSYPTg
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef114d8346so3427722a91.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 19:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737689469; x=1738294269;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J17h++/Fqn3buhimynx1h8Z8eMPFEHi3/WtoJOmOpm8=;
 b=lfFbT2CfNtTry5FH6cNzHRvihdpKbG/7Zc7ouyjOdviGaGPYsh8XgmR4+uxtXGyokf
 TH8f78ankFrMe+1Yq1u3tr0Qcmmxsrw2c4GJdkwSrF/l+YkuZ3wlyRmLQUp4fj6ACDkE
 wxMv9g8Adzmr2TnP1g3G/86UZOn6Uf2tS+coJzTstPqMdDxu8lekWk/rlPLesKAKamb1
 Le8NRzgpvpJ9oNYUr11OHRw2wdOFVoYj48a9cTE1ck3XNYtHBDoKZxCnphacsJwtjl85
 AF+Hrlri9Y8D8VQdgcRZXIxvKppendRdSMewUaLyTaGSbpIgNTLPb+2fCZbQK2o1EkJ+
 Hl7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWugk58FRt2tp5U5Q09xqsMUJYt2OjPzMHd3ULiuypauzm+sc5fFfNew0KGra6hMCpjGeFq4IBLalsl@nongnu.org
X-Gm-Message-State: AOJu0Yzu4hrKiFK0XOGBA8fcwN+5Qy04jY2VkniJgSyhgec8aIrmxdUa
 AEMqz6AnEckhEOTMAlFYAviyohXVMddjVa3TNzXZXE8j5RIJWAtr/M9C2TnnKiPQYgzgs74R1ZT
 ykjdLGleSrNq5MTKI5gahFJYyqm8KD8vLGUoOvfoB3vbItlQU1bydbFkpnSLnII5KC9xQkGiZUJ
 rhdypbsqQBq7wbW4cciWDd5zKkQGk=
X-Gm-Gg: ASbGncvXYF+NK2+1dYgMTbBKrs9YyOV5/2EW7eUFM1cwBBUvkoKr2KBZcjpr0XqPioz
 9vNjIcovZgYMEC0iBUnMNpXcQdWMTjNT2+EmhFg7RU8oNMRymYv0f
X-Received: by 2002:a05:6a20:734a:b0:1e1:6ec8:fc63 with SMTP id
 adf61e73a8af0-1eb21481ce7mr40621657637.11.1737689469347; 
 Thu, 23 Jan 2025 19:31:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKcWCygRpuBfBOzaVBtIvHIOF2ee6ukNXAhNVzEhUNz6M+6WPFQWsae7s2kT6PxaKaT3fi0NWBCRaQxK577LU=
X-Received: by 2002:a05:6a20:734a:b0:1e1:6ec8:fc63 with SMTP id
 adf61e73a8af0-1eb21481ce7mr40621620637.11.1737689468914; Thu, 23 Jan 2025
 19:31:08 -0800 (PST)
MIME-Version: 1.0
References: <20250120173339.865681-1-eric.auger@redhat.com>
 <CACGkMEu4oMa8Sf9QXtszeoSMj_67Csr0s7kHdYfbNnJWibu2dA@mail.gmail.com>
 <5a55011a-af8f-483a-99fa-5cb2cdf3841f@redhat.com>
 <CACGkMEv6ec3JLZg6ZedSHdNS5_McX7_xoV4d2MG05x_Y5t=uEA@mail.gmail.com>
 <678babb6-f64a-4db5-ad60-494214a4e673@redhat.com>
 <CACGkMEvyYT7-PTOwO-Jg9a8AHA0AJHoV2BY2RBrJTGKEFYL6QA@mail.gmail.com>
 <25b5bb73-abd8-4008-905d-6c2e9e1330e2@redhat.com>
 <SJ0PR11MB6744EBC0BB7C8CD5F33D0A4E92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744EBC0BB7C8CD5F33D0A4E92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 24 Jan 2025 11:30:56 +0800
X-Gm-Features: AWEUYZkk-Jls46t6NJsMnG5G5VWHVjQoTC0F1d7ZM1TEv--S8iKp-5tmyQx_qyY
Message-ID: <CACGkMEtQT2yZf93+a3LxSCyfBEXbEDu5S2cFXuAhprDYd2-vhw@mail.gmail.com>
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

On Fri, Jan 24, 2025 at 10:44=E2=80=AFAM Duan, Zhenzhong
<zhenzhong.duan@intel.com> wrote:
>
>
>
> >-----Original Message-----
> >From: Eric Auger <eric.auger@redhat.com>
> >Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU=
 gets
> >disabled
> >
> >Hi Jason,
> >
> >
> >On 1/23/25 2:34 AM, Jason Wang wrote:
> >> On Wed, Jan 22, 2025 at 3:55=E2=80=AFPM Eric Auger <eric.auger@redhat.=
com> wrote:
> >>> Hi Jason,
> >>>
> >>>
> >>> On 1/22/25 8:17 AM, Jason Wang wrote:
> >>>> On Wed, Jan 22, 2025 at 12:25=E2=80=AFAM Eric Auger <eric.auger@redh=
at.com>
> >wrote:
> >>>>> Hi Jason,
> >>>>>
> >>>>> On 1/21/25 4:27 AM, Jason Wang wrote:
> >>>>>> On Tue, Jan 21, 2025 at 1:33=E2=80=AFAM Eric Auger <eric.auger@red=
hat.com>
> >wrote:
> >>>>>>> When a guest exposed with a vhost device and protected by an
> >>>>>>> intel IOMMU gets rebooted, we sometimes observe a spurious warnin=
g:
> >>>>>>>
> >>>>>>> Fail to lookup the translated address ffffe000
> >>>>>>>
> >>>>>>> We observe that the IOMMU gets disabled through a write to the gl=
obal
> >>>>>>> command register (CMAR_GCMD.TE) before the vhost device gets
> >stopped.
> >>>>>>> When this warning happens it can be observed an inflight IOTLB
> >>>>>>> miss occurs after the IOMMU disable and before the vhost stop. In
> >>>>>>> that case a flat translation occurs and the check in
> >>>>>>> vhost_memory_region_lookup() fails.
> >>>>>>>
> >>>>>>> Let's disable the IOTLB callbacks when all IOMMU MRs have been
> >>>>>>> unregistered.
> >>>>>>>
> >>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>>>>>> ---
> >>>>>>>  hw/virtio/vhost.c | 4 ++++
> >>>>>>>  1 file changed, 4 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >>>>>>> index 6aa72fd434..128c2ab094 100644
> >>>>>>> --- a/hw/virtio/vhost.c
> >>>>>>> +++ b/hw/virtio/vhost.c
> >>>>>>> @@ -931,6 +931,10 @@ static void
> >vhost_iommu_region_del(MemoryListener *listener,
> >>>>>>>              break;
> >>>>>>>          }
> >>>>>>>      }
> >>>>>>> +    if (QLIST_EMPTY(&dev->iommu_list) &&
> >>>>>>> +        dev->vhost_ops->vhost_set_iotlb_callback) {
> >>>>>>> +        dev->vhost_ops->vhost_set_iotlb_callback(dev, false);
> >>>>>>> +    }
> >>>>>> So the current code assumes:
> >>>>>>
> >>>>>> 1) IOMMU is enabled before vhost starts
> >>>>>> 2) IOMMU is disabled after vhost stops
> >>>>>>
> >>>>>> This patch seems to fix 2) but not 1). Do we need to deal with the
> >>>>>> IOMMU enabled after vhost starts?
> >>>>> sorry I initially misunderstood the above comment. Indeed in the re=
boot
> >>>>> case assumption 2) happens to be wrong. However what I currently do=
 is:
> >>>>> stop listening to iotlb miss requests from the kernel because my
> >>>>> understanding is those requests are just spurious ones, generate
> >>>>> warnings and we do not care since we are rebooting the system.
> >>>>>
> >>>>> However I do not claim this could handle the case where the IOMMU M=
R
> >>>>> would be turned off and then turned on. I think in that case we sho=
uld
> >>>>> also flush the kernel IOTLB and this is not taken care of in this p=
atch.
> >>>>> Is it a relevant use case?
> >>>> Not sure.
> >>>>
> >>>>> wrt removing assumption 1) and allow IOMMU enabled after vhost star=
t. Is
> >>>>> that a valid use case as the virtio driver is using the dma api?
> >>>> It should not be but we can't assume the behaviour of the guest. It
> >>>> could be buggy or even malicious.
> >>> agreed
> >>>> Btw, we had the following codes while handling te:
> >>>>
> >>>> /* Handle Translation Enable/Disable */
> >>>> static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
> >>>> {
> >>>>     if (s->dmar_enabled =3D=3D en) {
> >>>>         return;
> >>>>     }
> >>>>
> >>>>     trace_vtd_dmar_enable(en);
> >>>>
> >>>> ...
> >>>>
> >>>>     vtd_reset_caches(s);
> >>>>     vtd_address_space_refresh_all(s);
> >>>> }
> >>>>
> >>>> vtd_address_space_refresh_all() will basically disable the iommu
> >>>> memory region. It looks not sufficient to trigger the region_del
> >>>> callback, maybe we should delete the region or introduce listener
> >>>> callback?
> >>> This is exactly the code path which is entered in my use case.
> >>>
> >>> vtd_address_space_refresh_all(s) induces the vhost_iommu_region_del. =
But
> >given the current implement of this latter the IOTLB callback is not uns=
et and the
> >kernel IOTLB is not refreshed. Also as I pointed out the  hdev->mem->reg=
ions are
> >not updated? shouldn't they. Can you explain what they correspond to?
> >> Adding Peter for more ideas.
> >>
> >> I think it's better to find a way to trigger the listener here, probab=
ly:
> >>
> >> 1) add/delete the memory regions instead of enable/disable
> >sorry I don't understand what you mean. The vhost_iommu_region_del call
> >stack is provided below [1]. Write to the intel iommu GCMD TE bit
> >induces a call to vhost_iommu_region_del. This happens before the
> >vhost_dev_stop whose call stack is provided below [2] and originates
> >from a bus reset.
> >
> >We may have inflight IOTLB miss requests happening between both.
> >
> >If this happens, vhost_device_iotlb_miss() fails because the IOVA is not
> >translated anymore by the IOMMU and the iotlb.translated_addr returned
> >by address_space_get_iotlb_entry() is not within the registered
> >vhost_memory_regions looked up in vhost_memory_region_lookup(), hence
> >the "Fail to lookup the translated address" message.
> >
> >It sounds wrong that vhost keeps on using IOVAs that are not translated
> >anymore. It looks we have a reset ordering issue and this patch is just
> >removing the sympton and not the cause.
> >
> >At the moment I don't really get what is initiating the intel iommu TE
> >bit write. This is a guest action but is it initiated from a misordered
> >qemu event?
>
> During reboot, native_machine_shutdown() calls x86_platform.iommu_shutdow=
n()
> to disable iommu before reset. So Peter's patch will not address your iss=
ue.
>
> Before iommu shutdown, device_shutdown() is called to shutdown all device=
s.
> Not clear why vhost is still active.

It might be because neither virtio bus nor virtio-net provides a
shutdown method.

There used to be requests to provide those to unbreak the kexec.

A quick try might be to provide a .driver.shutdown to
virtio_net_driver structure and reset the device there as a start.

Thanks

>
> Thanks
> Zhenzhong
>
> >
> >It could also relate to
> >[PATCH 0/4] intel_iommu: Reset vIOMMU after all the rest of devices
> >https://lore.kernel.org/all/?q=3Ds%3Aintel_iommu%3A+Reset+vIOMMU+after+a=
ll+
> >the+rest+of+devices
>


