Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9605E7716C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 03:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIgAG-0003aw-Kk; Tue, 03 Dec 2024 22:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tIgAF-0003an-Fi
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 22:34:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tIgAC-00006M-VK
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 22:34:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733283294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CXHsm/eWLw7FpT7IeeUFVOnKC3u6e2R1jOqv3AFhHx8=;
 b=GPbVwx3FUKlv/s3veBBJ1t3NCeb+X63CG8txUfJ3L/1QVdl+xhF9Y1AcRMFmRTrexEC9bX
 wnvFBb3h7iuP8ahmQjtrDB6V/q1BxL3TocwFSR3U7aUtyyRgIR7Mcu4MtdCmW6HVjU7MHe
 OIARdhTJyKVsOkdeyydxBRfk5S+CqJQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-oi_FAPoxNWmArGMXaGnh_g-1; Tue, 03 Dec 2024 22:34:52 -0500
X-MC-Unique: oi_FAPoxNWmArGMXaGnh_g-1
X-Mimecast-MFC-AGG-ID: oi_FAPoxNWmArGMXaGnh_g
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-7fbe1a5b5b3so6035182a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 19:34:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733283292; x=1733888092;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CXHsm/eWLw7FpT7IeeUFVOnKC3u6e2R1jOqv3AFhHx8=;
 b=XHe9ftTjGpZ5xJBFzWVer5DZsjRRMVVn4wnsrm7FIDx7XXYKpC2soeG6ZaabpLuF3q
 dhGtef6CiJpn42h1j6Rr5qax4rrlKlDrv2ik6weBWy1HRwN4QSK0Vz0g6AqKhK8knGr7
 wU0sIrDCo6PB+uL/hNHNrFtVjPKyuNHVRjPLE6hW2G84C6c5ZzfNszEE7q9bxzFDQjEu
 OySyHKBrTiQEBorQsaxhY4bBpGUaJvy3YoSAFrX7nZatyS3Ph9vReoAP9AkiZqKA5/us
 uUtx+KS6VMDUL7Bh0ysboT7JXN4sJLq2YS+gU43sPI4Wr0RoLr6vbIc6AUzXg8FvUjGr
 5Shw==
X-Gm-Message-State: AOJu0YyBOBZ9oURFD/K3NllPjBZkBN/LL8i+pYmHFZyCY5OSnz27Ieb1
 sXH8hGWBrgHGMn2IjyZeVvKd4UURFr9KpKcxmIrUTNvgQLySY4zcaGpx38/1JCq1hdT4MmNgVpP
 LG3RL3ldrM3kp8FkTyjVAOZpr5X2ijO3KKWjMuvE8vlqi2hSH3/IT8ZgKJ66jqiNroIEmEpOGPT
 OQtCkHJ1FLbOl7ibiUWU60mNKFx9Q=
X-Gm-Gg: ASbGncv+Z1Ui33CqqOzkb4kkyhb4jp7JyHEfrNp3U8gds8YRClq3WTTNw/wj6qGdxbS
 77VydHEKEpy6DzEzLHi8AnOHspQ1UAvfI
X-Received: by 2002:a05:6a21:3943:b0:1e1:62c4:8e9b with SMTP id
 adf61e73a8af0-1e1653d0861mr7504609637.25.1733283291960; 
 Tue, 03 Dec 2024 19:34:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/YO5oaTr4D09it1h0wARo3P5ztUXYnek/csEfrv6dFWk50tYw/IM+wHwTpnokxucXceOCaRUgrqE5LrnEG/E=
X-Received: by 2002:a05:6a21:3943:b0:1e1:62c4:8e9b with SMTP id
 adf61e73a8af0-1e1653d0861mr7504579637.25.1733283291544; Tue, 03 Dec 2024
 19:34:51 -0800 (PST)
MIME-Version: 1.0
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
 <20241111083457.2090664-19-zhenzhong.duan@intel.com>
In-Reply-To: <20241111083457.2090664-19-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Dec 2024 11:34:39 +0800
Message-ID: <CACGkMEtwV51X9ovWB3JHtyW4gpLT8zD8bieKFA2X=BVNZF8ymA@mail.gmail.com>
Subject: Re: [PATCH v5 18/20] intel_iommu: Introduce a property x-flts for
 scalable modern mode
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 eric.auger@redhat.com, mst@redhat.com, peterx@redhat.com, jgg@nvidia.com, 
 nicolinc@nvidia.com, joao.m.martins@oracle.com, 
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com, 
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Mon, Nov 11, 2024 at 4:39=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> Intel VT-d 3.0 introduces scalable mode, and it has a bunch of capabiliti=
es
> related to scalable mode translation, thus there are multiple combination=
s.
>
> This vIOMMU implementation wants to simplify it with a new property "x-fl=
ts".
> When enabled in scalable mode, first stage translation also known as scal=
able
> modern mode is supported. When enabled in legacy mode, throw out error.
>
> With scalable modern mode exposed to user, also accurate the pasid entry
> check in vtd_pe_type_check().
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |  2 ++
>  hw/i386/intel_iommu.c          | 28 +++++++++++++++++++---------
>  2 files changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_interna=
l.h
> index 2c977aa7da..e8b211e8b0 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -195,6 +195,7 @@
>  #define VTD_ECAP_PASID              (1ULL << 40)
>  #define VTD_ECAP_SMTS               (1ULL << 43)
>  #define VTD_ECAP_SLTS               (1ULL << 46)
> +#define VTD_ECAP_FLTS               (1ULL << 47)
>
>  /* CAP_REG */
>  /* (offset >> 4) << 24 */
> @@ -211,6 +212,7 @@
>  #define VTD_CAP_SLLPS               ((1ULL << 34) | (1ULL << 35))
>  #define VTD_CAP_DRAIN_WRITE         (1ULL << 54)
>  #define VTD_CAP_DRAIN_READ          (1ULL << 55)
> +#define VTD_CAP_FS1GP               (1ULL << 56)
>  #define VTD_CAP_DRAIN               (VTD_CAP_DRAIN_READ | VTD_CAP_DRAIN_=
WRITE)
>  #define VTD_CAP_CM                  (1ULL << 7)
>  #define VTD_PASID_ID_SHIFT          20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index b921793c3a..a7a81aebee 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -803,16 +803,18 @@ static inline bool vtd_is_fl_level_supported(IntelI=
OMMUState *s, uint32_t level)
>  }
>
>  /* Return true if check passed, otherwise false */
> -static inline bool vtd_pe_type_check(X86IOMMUState *x86_iommu,
> -                                     VTDPASIDEntry *pe)
> +static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *=
pe)
>  {
>      switch (VTD_PE_GET_TYPE(pe)) {
> -    case VTD_SM_PASID_ENTRY_SLT:
> -        return true;
> -    case VTD_SM_PASID_ENTRY_PT:
> -        return x86_iommu->pt_supported;
>      case VTD_SM_PASID_ENTRY_FLT:
> +        return !!(s->ecap & VTD_ECAP_FLTS);
> +    case VTD_SM_PASID_ENTRY_SLT:
> +        return !!(s->ecap & VTD_ECAP_SLTS);
>      case VTD_SM_PASID_ENTRY_NESTED:
> +        /* Not support NESTED page table type yet */
> +        return false;
> +    case VTD_SM_PASID_ENTRY_PT:
> +        return !!(s->ecap & VTD_ECAP_PT);
>      default:
>          /* Unknown type */
>          return false;
> @@ -861,7 +863,6 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUS=
tate *s,
>      uint8_t pgtt;
>      uint32_t index;
>      dma_addr_t entry_size;
> -    X86IOMMUState *x86_iommu =3D X86_IOMMU_DEVICE(s);
>
>      index =3D VTD_PASID_TABLE_INDEX(pasid);
>      entry_size =3D VTD_PASID_ENTRY_SIZE;
> @@ -875,7 +876,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUS=
tate *s,
>      }
>
>      /* Do translation type check */
> -    if (!vtd_pe_type_check(x86_iommu, pe)) {
> +    if (!vtd_pe_type_check(s, pe)) {
>          return -VTD_FR_PASID_TABLE_ENTRY_INV;
>      }
>
> @@ -3827,6 +3828,7 @@ static Property vtd_properties[] =3D {
>                        VTD_HOST_ADDRESS_WIDTH),
>      DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALS=
E),
>      DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, =
FALSE),
> +    DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, scalable_modern, FALSE),
>      DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, fa=
lse),
>      DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
>      DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
> @@ -4558,7 +4560,10 @@ static void vtd_cap_init(IntelIOMMUState *s)
>      }
>
>      /* TODO: read cap/ecap from host to decide which cap to be exposed. =
*/
> -    if (s->scalable_mode) {
> +    if (s->scalable_modern) {
> +        s->ecap |=3D VTD_ECAP_SMTS | VTD_ECAP_FLTS;
> +        s->cap |=3D VTD_CAP_FS1GP;
> +    } else if (s->scalable_mode) {
>          s->ecap |=3D VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
>      }
>
> @@ -4737,6 +4742,11 @@ static bool vtd_decide_config(IntelIOMMUState *s, =
Error **errp)
>          }
>      }
>
> +    if (!s->scalable_mode && s->scalable_modern) {
> +        error_setg(errp, "Legacy mode: not support x-flts=3Don");

This seems to be wired, should we say "scalable mode is needed for
scalable modern mode"?

> +        return false;
> +    }
> +
>      if (!s->scalable_modern && s->aw_bits !=3D VTD_HOST_AW_39BIT &&
>          s->aw_bits !=3D VTD_HOST_AW_48BIT) {
>          error_setg(errp, "%s mode: supported values for aw-bits are: %d,=
 %d",
> --
> 2.34.1
>

Thanks


