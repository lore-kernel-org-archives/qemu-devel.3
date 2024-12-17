Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF49CE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 02:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNN68-00021W-W7; Mon, 16 Dec 2024 21:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tNN65-00021L-TD
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 21:14:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tNN62-0006c6-H5
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 21:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734401636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HNJaRZGWUI6ejL02MyLNfK8QQl59e5Fr5o9oJVbFLC0=;
 b=EJGmP6CmKfx8rGBPrWqX7/LZG496aw60q42BGmvZhs0dV4yLN3OPJNj+vxx+OrlcQ4sQUg
 zsAD6Uxjj+Lfu/ROy2vAaoCY84GcunQjAgheylUQsMwbTDAAEbcLI6VC6xDulaLrfBB4Fi
 l2xVPK8KJELccBF+2XTQBhpMvLC7+Zk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-6oLfz5S1Pq2iHrUuR_bO-Q-1; Mon, 16 Dec 2024 21:13:54 -0500
X-MC-Unique: 6oLfz5S1Pq2iHrUuR_bO-Q-1
X-Mimecast-MFC-AGG-ID: 6oLfz5S1Pq2iHrUuR_bO-Q
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ee5668e09bso4480951a91.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 18:13:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734401633; x=1735006433;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HNJaRZGWUI6ejL02MyLNfK8QQl59e5Fr5o9oJVbFLC0=;
 b=ToAkgX0wXakpxtTvD6NI6/Ae7lYjLYjOnGT3akoeA1DIWIme2HLIoxca2IzrL27zok
 MW67nGnKg6j4zHzRCtvi16PpXTmB13Pa8gnNadlimpU+AvZglloZOPL5wNxprpOZac9n
 C9VURqPYWhZoP9ZspRTjsbnhePuE2FWMPtf9n4oa5ngxkDMQdKy+ccKPtIGzhzKSfEyZ
 s2va5nTr4ymyxaJXuaDD/JPfjgMz9BkKP+IqINzLUNA0VE6ciifr3BFLfr/W6fFO57WV
 k17a6OSDwTUom5SoBaPlaMxqTrI/ktPEZxrFhkeSUQQBZ29vS102FDlyRPw50WzUXBJm
 u0Zg==
X-Gm-Message-State: AOJu0YxTPRg/t4r+4bNfCREriTy75UkloK1YcuQtoXao+mXII+Zbczzq
 DXcN3E51cB2JzN8pm/OLUh+EsS1tNQylr33cQPrjbQf+m4prnq+C0/MAzL9IZbiuJzWb150OKqq
 +ZDqD5NAsepGm1N6x8wkyvqE2puqRbGXufBMb5WYcU0BORATxvY8NwsIZ5oH+QO5qQ3X9PiYzmp
 fXXZssDszr2OSU88EGTyOGkU83as4=
X-Gm-Gg: ASbGncukjD0BBs28bCG5yfIuZj+lIMvYEKBOlnVJWis9vexqL2WTod+vQq56Iw7mALr
 tc/NbUhMqLxC6oxckxEKwgLvL3P1Bqu+nxxPJV20=
X-Received: by 2002:a17:90b:314d:b0:2ee:f80c:6884 with SMTP id
 98e67ed59e1d1-2f2901b44c3mr21813801a91.33.1734401633483; 
 Mon, 16 Dec 2024 18:13:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtqbmmSjVisTI/K/P4GN2VSEDjirNw18cpNTFsQKa1PtHtZKuAFT8wJb3gWVcQXVdMk6SOiVzxaIlHo2VCAv8=
X-Received: by 2002:a17:90b:314d:b0:2ee:f80c:6884 with SMTP id
 98e67ed59e1d1-2f2901b44c3mr21813755a91.33.1734401632963; Mon, 16 Dec 2024
 18:13:52 -0800 (PST)
MIME-Version: 1.0
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-13-zhenzhong.duan@intel.com>
 <CACGkMEscZB9f6toOcm_+3pQknDgnp3r6MvzbejB9BVEsKz7rjA@mail.gmail.com>
 <SJ0PR11MB67441D158F394CE1EA620CA9926B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEuXX6UE0=dNjeNJ5rHxkJADUrTG0tU1Cd1n0cvik5NnKg@mail.gmail.com>
 <SJ0PR11MB67447F79B1350833A5D878F8923B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB67447F79B1350833A5D878F8923B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Dec 2024 10:13:41 +0800
Message-ID: <CACGkMEv1uVaqu9c6e51qUQj17MGBj78CMOtBEFVYD=KHMMUA_A@mail.gmail.com>
Subject: Re: [PATCH v3 12/17] intel_iommu: Add support for PASID-based device
 IOTLB invalidation
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, 
 "peterx@redhat.com" <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, 
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, 
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Dec 16, 2024 at 4:22=E2=80=AFPM Duan, Zhenzhong
<zhenzhong.duan@intel.com> wrote:
>
>
>
> >-----Original Message-----
> >From: Jason Wang <jasowang@redhat.com>
> >Sent: Sunday, September 29, 2024 9:59 AM
> >Subject: Re: [PATCH v3 12/17] intel_iommu: Add support for PASID-based d=
evice
> >IOTLB invalidation
> >
> >On Fri, Sep 27, 2024 at 3:18=E2=80=AFPM Duan, Zhenzhong
> ><zhenzhong.duan@intel.com> wrote:
> >>
> >>
> >>
> >> >-----Original Message-----
> >> >From: Jason Wang <jasowang@redhat.com>
> >> >Subject: Re: [PATCH v3 12/17] intel_iommu: Add support for PASID-base=
d
> >> >device IOTLB invalidation
> >> >
> >> >On Wed, Sep 11, 2024 at 1:27=E2=80=AFPM Zhenzhong Duan
> >> ><zhenzhong.duan@intel.com> wrote:
> >> >>
> >> >> From: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@eviden.com>
> >> >>
> >> >> Signed-off-by: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@ev=
iden.com>
> >> >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >> >> ---
> >> >>  hw/i386/intel_iommu_internal.h | 11 ++++++++
> >> >>  hw/i386/intel_iommu.c          | 50
> >> >++++++++++++++++++++++++++++++++++
> >> >>  2 files changed, 61 insertions(+)
> >> >>
> >> >> diff --git a/hw/i386/intel_iommu_internal.h
> >> >b/hw/i386/intel_iommu_internal.h
> >> >> index 4f2c3a9350..52bdbf3bc5 100644
> >> >> --- a/hw/i386/intel_iommu_internal.h
> >> >> +++ b/hw/i386/intel_iommu_internal.h
> >> >> @@ -375,6 +375,7 @@ typedef union VTDInvDesc VTDInvDesc;
> >> >>  #define VTD_INV_DESC_WAIT               0x5 /* Invalidation Wait D=
escriptor
> >> >*/
> >> >>  #define VTD_INV_DESC_PIOTLB             0x6 /* PASID-IOTLB Invalid=
ate Desc
> >> >*/
> >> >>  #define VTD_INV_DESC_PC                 0x7 /* PASID-cache Invalid=
ate Desc */
> >> >> +#define VTD_INV_DESC_DEV_PIOTLB         0x8 /* PASID-based-DIOTLB
> >> >inv_desc*/
> >> >>  #define VTD_INV_DESC_NONE               0   /* Not an Invalidate D=
escriptor
> >> >*/
> >> >>
> >> >>  /* Masks for Invalidation Wait Descriptor*/
> >> >> @@ -413,6 +414,16 @@ typedef union VTDInvDesc VTDInvDesc;
> >> >>  #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI 0xffeULL
> >> >>  #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0fff8
> >> >>
> >> >> +/* Mask for PASID Device IOTLB Invalidate Descriptor */
> >> >> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_ADDR(val) ((val) & \
> >> >> +                                                   0xfffffffffffff=
000ULL)
> >> >> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_SIZE(val) ((val >> 11) & 0=
x1)
> >> >> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_GLOBAL(val) ((val) & 0x1)
> >> >> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_SID(val) (((val) >> 16) &
> >> >0xffffULL)
> >> >> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_PASID(val) ((val >> 32) &
> >> >0xfffffULL)
> >> >> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_HI 0x7feULL
> >> >> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_LO
> >> >0xfff000000000f000ULL
> >> >> +
> >> >>  /* Rsvd field masks for spte */
> >> >>  #define VTD_SPTE_SNP 0x800ULL
> >> >>
> >> >> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >> >> index d28c862598..4cf56924e1 100644
> >> >> --- a/hw/i386/intel_iommu.c
> >> >> +++ b/hw/i386/intel_iommu.c
> >> >> @@ -3017,6 +3017,49 @@ static void
> >> >do_invalidate_device_tlb(VTDAddressSpace *vtd_dev_as,
> >> >>      memory_region_notify_iommu(&vtd_dev_as->iommu, 0, event);
> >> >>  }
> >> >>
> >> >> +static bool vtd_process_device_piotlb_desc(IntelIOMMUState *s,
> >> >> +                                           VTDInvDesc *inv_desc)
> >> >> +{
> >> >> +    uint16_t sid;
> >> >> +    VTDAddressSpace *vtd_dev_as;
> >> >> +    bool size;
> >> >> +    bool global;
> >> >> +    hwaddr addr;
> >> >> +    uint32_t pasid;
> >> >> +
> >> >> +    if ((inv_desc->hi & VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_HI) |=
|
> >> >> +         (inv_desc->lo & VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_LO))=
 {
> >> >> +        error_report_once("%s: invalid pasid-based dev iotlb inv d=
esc:"
> >> >> +                          "hi=3D%"PRIx64 "(reserved nonzero)",
> >> >> +                          __func__, inv_desc->hi);
> >> >> +        return false;
> >> >> +    }
> >> >> +
> >> >> +    global =3D VTD_INV_DESC_PASID_DEVICE_IOTLB_GLOBAL(inv_desc->hi=
);
> >> >> +    size =3D VTD_INV_DESC_PASID_DEVICE_IOTLB_SIZE(inv_desc->hi);
> >> >> +    addr =3D VTD_INV_DESC_PASID_DEVICE_IOTLB_ADDR(inv_desc->hi);
> >> >> +    sid =3D VTD_INV_DESC_PASID_DEVICE_IOTLB_SID(inv_desc->lo);
> >> >> +    if (global) {
> >> >> +        QLIST_FOREACH(vtd_dev_as, &s->vtd_as_with_notifiers, next)=
 {
> >> >> +            if ((vtd_dev_as->pasid !=3D PCI_NO_PASID) &&
> >> >> +                (PCI_BUILD_BDF(pci_bus_num(vtd_dev_as->bus),
> >> >> +                                           vtd_dev_as->devfn) =3D=
=3D sid)) {
> >> >> +                do_invalidate_device_tlb(vtd_dev_as, size, addr);
> >> >> +            }
> >> >> +        }
> >> >> +    } else {
> >> >> +        pasid =3D VTD_INV_DESC_PASID_DEVICE_IOTLB_PASID(inv_desc->=
lo);
> >> >> +        vtd_dev_as =3D vtd_get_as_by_sid_and_pasid(s, sid, pasid);
> >> >> +        if (!vtd_dev_as) {
> >> >> +            return true;
> >> >> +        }
> >> >> +
> >> >> +        do_invalidate_device_tlb(vtd_dev_as, size, addr);
> >> >
> >> >Question:
> >> >
> >> >I wonder if current vhost (which has a device IOTLB abstraction via
> >> >virtio-pci) can work with this (PASID based IOTLB invalidation)
> >>
> >> Currently, it depends on if caching-mode is on. If it's off, vhost wor=
ks. E.g.:
> >>
> >> -device intel-iommu,caching-mode=3Doff,dma-drain=3Don,device-iotlb=3Do=
n,x-
> >scalable-mode=3Don
> >> -netdev tap,id=3Dtap0,vhost=3Don,script=3D/etc/qemu-ifup
> >> -device virtio-net-pci,netdev=3Dtap0,bus=3Droot0,iommu_platform=3Don,a=
ts=3Don
> >>
> >> It doesn't work currently when caching-mode is on.
> >> Reason is linux kernel has an optimization to send only piotlb invalid=
ation,
> >> no device-piotlb invalidation is sent. But I heard from Yi the optimiz=
ation
> >> will be dropped, then it will work too when caching-mode is on.
> >
> >Great, if possible please copy me when sending those fixes.
>
> FYI, I just found the optimization had already been dropped since April 2=
024 by commit https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3D304b3bde24b58515a75fd198beb52ca57df6275f
>
> After updating guest kernel to a new version containing above commit,
> vhost works irrespective the value of caching-mode.
>
> Thanks
> Zhenzhong

Great. Thanks for the updating.


