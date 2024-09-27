Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B25CCEBF69
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 04:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su2HP-0003la-Kp; Fri, 27 Sep 2024 00:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su2HO-0003fm-6Z
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 00:08:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1su2HM-0006Gt-Ho
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 00:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727410107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MLfni3CLJOklyG1pO15JsPu/PMYFhLs8eL45Jq3qITA=;
 b=WlyjPE5wIVcGzA7DaiuH/nzjVPKa1E3LZBz2Fz/lLf0gieRDj6+v/3aGouMpSQFfl5yhVr
 PuowXwG7UGhmqLZvG5pDpVWZbWNR96feV2mvV9bQRSiDatREla6FVtOWFQJhgcHVRqWM1s
 HTUHvDhq/atbKE120L3buCQW9sW8dJU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-3zPe_-u8N5SgEQN6kKBZlQ-1; Fri, 27 Sep 2024 00:08:24 -0400
X-MC-Unique: 3zPe_-u8N5SgEQN6kKBZlQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2e0853aafceso2146466a91.1
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 21:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727410103; x=1728014903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MLfni3CLJOklyG1pO15JsPu/PMYFhLs8eL45Jq3qITA=;
 b=mDWuufvxyAU9ox9NLiaC+yd8yQMNR+RDu3oeVyhhpn6B5tqOuXwCpyMEbrzNmBqxOt
 mN4irX2mOlzuur4I8EkEjn8sgQrp7G+6AFrveigBLNyLMGvY1vQLRccmuA7PkcAPE1Xz
 aBgf2Oj6FouI41JOR5VYKQMhB0o0scPzhgsND8IvRONaONkTPMQAcneRKokRMyLdpSw2
 rJlLR/4w3KlJSGuUuhofbE1pi1CDSKJpaXXXxxCYW1hb/LBg4hOLpRqsdFcPvHn13NNY
 SlLvXGnJE3kGKxZW4RQ8siw4d+LVUuQpRlMn9xJgybi6dWmVrdTsvvk3wWmekHrR8Vb2
 +OqA==
X-Gm-Message-State: AOJu0YwqF3UOS4Sbp2xM4svtEbTcsL/g/TXQOdLzFLXEUR5Lb7R3g4Fv
 r0IEYTaCe/4PHwYTE50saZHrqwPRhso9nEfjzYQ2Q3iGo704H0kaNL+hnueDlUMKizbSPmln0Ld
 /o3JCEdEMkART3GBYZkMoDdipk3k6ypBV6i/sWAk6LFjGXBlT3gVF526SIn/w5rbNzSi4qqYVMl
 bbIm1Cx7N1sQaWhbJEf/mhze38G3o=
X-Received: by 2002:a17:90a:ad87:b0:2c8:6bfa:bbf1 with SMTP id
 98e67ed59e1d1-2e0b8d55554mr2492682a91.23.1727410103639; 
 Thu, 26 Sep 2024 21:08:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlo6ETK2Ecj6Be6hry6At158timW1IXMKPfnVoKW04LiaBes2eeQ4gUqEzyorbd6hxzzv+/8ICYgTk/Bng8aA=
X-Received: by 2002:a17:90a:ad87:b0:2c8:6bfa:bbf1 with SMTP id
 98e67ed59e1d1-2e0b8d55554mr2492655a91.23.1727410103142; Thu, 26 Sep 2024
 21:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-13-zhenzhong.duan@intel.com>
In-Reply-To: <20240911052255.1294071-13-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Sep 2024 12:08:10 +0800
Message-ID: <CACGkMEscZB9f6toOcm_+3pQknDgnp3r6MvzbejB9BVEsKz7rjA@mail.gmail.com>
Subject: Re: [PATCH v3 12/17] intel_iommu: Add support for PASID-based device
 IOTLB invalidation
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 eric.auger@redhat.com, mst@redhat.com, peterx@redhat.com, jgg@nvidia.com, 
 nicolinc@nvidia.com, joao.m.martins@oracle.com, 
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com, 
 chao.p.peng@intel.com, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 11, 2024 at 1:27=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> From: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@eviden.com>
>
> Signed-off-by: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@eviden.c=
om>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h | 11 ++++++++
>  hw/i386/intel_iommu.c          | 50 ++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_interna=
l.h
> index 4f2c3a9350..52bdbf3bc5 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -375,6 +375,7 @@ typedef union VTDInvDesc VTDInvDesc;
>  #define VTD_INV_DESC_WAIT               0x5 /* Invalidation Wait Descrip=
tor */
>  #define VTD_INV_DESC_PIOTLB             0x6 /* PASID-IOTLB Invalidate De=
sc */
>  #define VTD_INV_DESC_PC                 0x7 /* PASID-cache Invalidate De=
sc */
> +#define VTD_INV_DESC_DEV_PIOTLB         0x8 /* PASID-based-DIOTLB inv_de=
sc*/
>  #define VTD_INV_DESC_NONE               0   /* Not an Invalidate Descrip=
tor */
>
>  /* Masks for Invalidation Wait Descriptor*/
> @@ -413,6 +414,16 @@ typedef union VTDInvDesc VTDInvDesc;
>  #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI 0xffeULL
>  #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0fff8
>
> +/* Mask for PASID Device IOTLB Invalidate Descriptor */
> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_ADDR(val) ((val) & \
> +                                                   0xfffffffffffff000ULL=
)
> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_SIZE(val) ((val >> 11) & 0x1)
> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_GLOBAL(val) ((val) & 0x1)
> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_SID(val) (((val) >> 16) & 0xffff=
ULL)
> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_PASID(val) ((val >> 32) & 0xffff=
fULL)
> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_HI 0x7feULL
> +#define VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_LO 0xfff000000000f000ULL
> +
>  /* Rsvd field masks for spte */
>  #define VTD_SPTE_SNP 0x800ULL
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index d28c862598..4cf56924e1 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3017,6 +3017,49 @@ static void do_invalidate_device_tlb(VTDAddressSpa=
ce *vtd_dev_as,
>      memory_region_notify_iommu(&vtd_dev_as->iommu, 0, event);
>  }
>
> +static bool vtd_process_device_piotlb_desc(IntelIOMMUState *s,
> +                                           VTDInvDesc *inv_desc)
> +{
> +    uint16_t sid;
> +    VTDAddressSpace *vtd_dev_as;
> +    bool size;
> +    bool global;
> +    hwaddr addr;
> +    uint32_t pasid;
> +
> +    if ((inv_desc->hi & VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_HI) ||
> +         (inv_desc->lo & VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_LO)) {
> +        error_report_once("%s: invalid pasid-based dev iotlb inv desc:"
> +                          "hi=3D%"PRIx64 "(reserved nonzero)",
> +                          __func__, inv_desc->hi);
> +        return false;
> +    }
> +
> +    global =3D VTD_INV_DESC_PASID_DEVICE_IOTLB_GLOBAL(inv_desc->hi);
> +    size =3D VTD_INV_DESC_PASID_DEVICE_IOTLB_SIZE(inv_desc->hi);
> +    addr =3D VTD_INV_DESC_PASID_DEVICE_IOTLB_ADDR(inv_desc->hi);
> +    sid =3D VTD_INV_DESC_PASID_DEVICE_IOTLB_SID(inv_desc->lo);
> +    if (global) {
> +        QLIST_FOREACH(vtd_dev_as, &s->vtd_as_with_notifiers, next) {
> +            if ((vtd_dev_as->pasid !=3D PCI_NO_PASID) &&
> +                (PCI_BUILD_BDF(pci_bus_num(vtd_dev_as->bus),
> +                                           vtd_dev_as->devfn) =3D=3D sid=
)) {
> +                do_invalidate_device_tlb(vtd_dev_as, size, addr);
> +            }
> +        }
> +    } else {
> +        pasid =3D VTD_INV_DESC_PASID_DEVICE_IOTLB_PASID(inv_desc->lo);
> +        vtd_dev_as =3D vtd_get_as_by_sid_and_pasid(s, sid, pasid);
> +        if (!vtd_dev_as) {
> +            return true;
> +        }
> +
> +        do_invalidate_device_tlb(vtd_dev_as, size, addr);

Question:

I wonder if current vhost (which has a device IOTLB abstraction via
virtio-pci) can work with this (PASID based IOTLB invalidation)

THanks


> +    }
> +
> +    return true;
> +}
> +
>  static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
>                                            VTDInvDesc *inv_desc)
>  {
> @@ -3111,6 +3154,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *=
s)
>          }
>          break;
>
> +    case VTD_INV_DESC_DEV_PIOTLB:
> +        trace_vtd_inv_desc("device-piotlb", inv_desc.hi, inv_desc.lo);
> +        if (!vtd_process_device_piotlb_desc(s, &inv_desc)) {
> +            return false;
> +        }
> +        break;
> +
>      case VTD_INV_DESC_DEVICE:
>          trace_vtd_inv_desc("device", inv_desc.hi, inv_desc.lo);
>          if (!vtd_process_device_iotlb_desc(s, &inv_desc)) {
> --
> 2.34.1
>


