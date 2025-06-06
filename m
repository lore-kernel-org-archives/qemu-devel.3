Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C3FC5B555
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 13:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNXLD-00086R-Mj; Fri, 06 Jun 2025 09:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNXLC-000862-NK
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:42:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNXLA-0005Cc-JM
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749217354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vKjYu0Ow/fwJ4nDbTb3n+H++RhD0vFazNcgpA/MfAbk=;
 b=BiK7ZPH0GF69JGQeL95c/8KE+DLup7M8nFA/NRO+ltFrhIPbfpKm6+gKEQ3Y/IIfZ0Je1o
 ZM+iEG7faqL3HMW6bAsfchtJ2WMhNleljDSJGKJbX4ME6mA6D+n5YVXayiB0aQ0OzFPMGH
 pCuWtB4k8vfp00Prg+N/tnfB08qACw8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-TwvXNH4gOcesknZ49OolAA-1; Fri, 06 Jun 2025 09:42:25 -0400
X-MC-Unique: TwvXNH4gOcesknZ49OolAA-1
X-Mimecast-MFC-AGG-ID: TwvXNH4gOcesknZ49OolAA_1749217341
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4eee2398bso1068442f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 06:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749217341; x=1749822141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vKjYu0Ow/fwJ4nDbTb3n+H++RhD0vFazNcgpA/MfAbk=;
 b=iIdvl3ddqMTSkBmqPRPtXbCp1e5dq7YWBZSrPuHct29D63Sg9dWuykgkfN9FdRb0+X
 SoSSFz1IJcGfMVkDyeW2XmUXM5XvoDMh1gqpp/VvE+jDg/wMO3Bd7lEyujBtjgefZEX9
 EVAPES/h5GmBhVgm3NvBoAL5slV9PdiqaoawUBM81cRw7pjga6moOOZj5FB2MewSM/G4
 SCPFu5m8qpHpafqCTjaPMvXW9P4ntS9iOifOP8SrJBHZ48TqOAU0ygDV8lPLQhXoyAQu
 609MoYRi/S6hvLwxCxKOao8hHX1EleUYXaILik5VtwD1STf2d/iAYKOk51TZpPGKbryo
 4azg==
X-Gm-Message-State: AOJu0YwI+FjoBe0PW4aGwKKix4pPuIoltFJ+Rzi9HuQ+JR5cZvBbRY9Q
 ZyIxV9UucYmwAHBuhp7PmZYPpa4H13GczByGbsQeNJ2Qin36wu53FsS7wPGq+dYFKJhrSfau09e
 y1yKC73mDMXtRn5mxJ2tV4sD1O3YabjgwzeD0VCCuAVyE3G76ZjSjP29E
X-Gm-Gg: ASbGncsxmMZpDG2obWmQ3/At14ORmexI54Xsy1Tca2VtXsPawDfTcA2vuMXh9ZKgtKe
 zLly6TeoZye1mzWad3dyBCbo5dF7brTuzu4e9plHR7yloxUyLLb9ugEqx0Lgf1dqSUypbL8HrKB
 GwDRFhYNzzAeHGjfZrl15TBx8I3jLF1SXkr+qb6X02+PGoS7nKcKZsKszAXynjwRtz9s0okCmUh
 0yN1tCl+yhJXdxiKvV4H5gmqH0R7ixUA1VloBivj1KS2yLvv/2xzBMtnGgP7/qZbrh+TIN1/iYG
 ECDYCGB9LxEZuA2FIouUZCZm6rjpSeV3L+pGuCsjdWQ=
X-Received: by 2002:a5d:5846:0:b0:3a4:e6c6:b8b1 with SMTP id
 ffacd0b85a97d-3a53189b3f0mr3036311f8f.17.1749217341392; 
 Fri, 06 Jun 2025 06:42:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf8crsLsZ9iU2C6A0/sXgnIMc7fS+knXLnGVZZi467rI2xUgCFgJVxKQn1OEYqPGIWinUkSA==
X-Received: by 2002:a5d:5846:0:b0:3a4:e6c6:b8b1 with SMTP id
 ffacd0b85a97d-3a53189b3f0mr3036288f8f.17.1749217341008; 
 Fri, 06 Jun 2025 06:42:21 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532435f94sm1928444f8f.60.2025.06.06.06.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 06:42:20 -0700 (PDT)
Date: Fri, 6 Jun 2025 15:42:19 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>, Hanna
 Reitz <hreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Ani
 Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas
 Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Yi Liu <yi.l.liu@intel.com>, <peterx@redhat.com>
Subject: Re: [PATCH 18/18] hw/i386/x86-iommu: Remove
 X86IOMMUState::pt_supported field
Message-ID: <20250606154219.37957b34@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250501210456.89071-19-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
 <20250501210456.89071-19-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu,  1 May 2025 23:04:56 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The X86IOMMUState::pt_supported boolean was only set in
> the hw_compat_2_9[] array, via the 'pt=3Doff' property. We
> removed all machines using that array, lets remove that
> property and all the code around it, always setting the
> VTD_ECAP_PT capability.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/i386/x86-iommu.h |  1 -
>  hw/i386/amd_iommu.c         | 12 ++----------
>  hw/i386/intel_iommu.c       | 13 ++-----------
>  hw/i386/x86-iommu.c         |  1 -
>  4 files changed, 4 insertions(+), 23 deletions(-)
>=20
> diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
> index bfd21649d08..d6e52b1eb6b 100644
> --- a/include/hw/i386/x86-iommu.h
> +++ b/include/hw/i386/x86-iommu.h
> @@ -63,7 +63,6 @@ struct X86IOMMUState {
>      SysBusDevice busdev;
>      OnOffAuto intr_supported;   /* Whether vIOMMU supports IR */
>      bool dt_supported;          /* Whether vIOMMU supports DT */
> -    bool pt_supported;          /* Whether vIOMMU supports pass-through =
*/
>      QLIST_HEAD(, IEC_Notifier) iec_notifiers; /* IEC notify list */
>  };
> =20
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 2cf7e24a21d..516e231bf13 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1426,7 +1426,6 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *b=
us, void *opaque, int devfn)
>      AMDVIState *s =3D opaque;
>      AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
>      int bus_num =3D pci_bus_num(bus);
> -    X86IOMMUState *x86_iommu =3D X86_IOMMU_DEVICE(s);
> =20
>      iommu_as =3D s->address_spaces[bus_num];
> =20
> @@ -1486,15 +1485,8 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *=
bus, void *opaque, int devfn)
>                                              AMDVI_INT_ADDR_FIRST,
>                                              &amdvi_dev_as->iommu_ir, 1);
> =20
> -        if (!x86_iommu->pt_supported) {
> -            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
> -            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu=
),
> -                                      true);
> -        } else {
> -            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu=
),
> -                                      false);
> -            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, true);
> -        }
> +        memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
> +        memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu), t=
rue);

given default is 'true', this hunk seems to be backwards,
shouldn't it be 'else' branch code


>      }
>      return &iommu_as[devfn]->as;
>  }
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index c980cecb4ee..cc08dc41441 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1066,6 +1066,7 @@ static inline bool vtd_ce_type_check(X86IOMMUState =
*x86_iommu,
>  {
>      switch (vtd_ce_get_type(ce)) {
>      case VTD_CONTEXT_TT_MULTI_LEVEL:
> +    case VTD_CONTEXT_TT_PASS_THROUGH:
>          /* Always supported */
>          break;
>      case VTD_CONTEXT_TT_DEV_IOTLB:
> @@ -1074,12 +1075,6 @@ static inline bool vtd_ce_type_check(X86IOMMUState=
 *x86_iommu,
>              return false;
>          }
>          break;
> -    case VTD_CONTEXT_TT_PASS_THROUGH:
> -        if (!x86_iommu->pt_supported) {
> -            error_report_once("%s: PT specified but not supported", __fu=
nc__);
> -            return false;
> -        }
> -        break;
>      default:
>          /* Unknown type */
>          error_report_once("%s: unknown ce type: %"PRIu32, __func__,
> @@ -4520,7 +4515,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
>  {
>      X86IOMMUState *x86_iommu =3D X86_IOMMU_DEVICE(s);
> =20
> -    s->cap =3D VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
> +    s->cap =3D VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND | VTD_ECAP_PT |
>               VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS |
>               VTD_CAP_MGAW(s->aw_bits);
>      if (s->dma_drain) {
> @@ -4548,10 +4543,6 @@ static void vtd_cap_init(IntelIOMMUState *s)
>          s->ecap |=3D VTD_ECAP_DT;
>      }
> =20
> -    if (x86_iommu->pt_supported) {
> -        s->ecap |=3D VTD_ECAP_PT;
> -    }
> -
>      if (s->caching_mode) {
>          s->cap |=3D VTD_CAP_CM;
>      }
> diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
> index d34a6849f4a..ca7cd953e98 100644
> --- a/hw/i386/x86-iommu.c
> +++ b/hw/i386/x86-iommu.c
> @@ -129,7 +129,6 @@ static const Property x86_iommu_properties[] =3D {
>      DEFINE_PROP_ON_OFF_AUTO("intremap", X86IOMMUState,
>                              intr_supported, ON_OFF_AUTO_AUTO),
>      DEFINE_PROP_BOOL("device-iotlb", X86IOMMUState, dt_supported, false),
> -    DEFINE_PROP_BOOL("pt", X86IOMMUState, pt_supported, true),
>  };
> =20
>  static void x86_iommu_class_init(ObjectClass *klass, const void *data)


