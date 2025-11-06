Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00235CCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 13:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH0Sq-00080Z-Px; Thu, 06 Nov 2025 08:55:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vH0Sp-00080K-W2
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 08:55:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vH0Sn-0003QK-F9
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 08:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762437342;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=01SU0RhLQwEiOS6q37xq1Pr1Ihj1YfZqxXq3UNB5G8c=;
 b=feIKLN8iGrTR9ADGg60BmY+qvuAQm5tDWl1ecnCZdrDhc/z6guM29hkCCe6GPq2aZmQrCT
 uvBEp9ljPyLPe3H86Z6QY0UWNlMPkYVHhC6kLsAEkwBFlzA4lRP6c2mTJ5Yor/yZe0blE2
 U9LUTYsuak4DPup/jJTNtdnP2dRW/3I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-uizQwJfRM1qG0uZBZrF7Hw-1; Thu, 06 Nov 2025 08:55:41 -0500
X-MC-Unique: uizQwJfRM1qG0uZBZrF7Hw-1
X-Mimecast-MFC-AGG-ID: uizQwJfRM1qG0uZBZrF7Hw_1762437340
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47106720618so7794155e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 05:55:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762437338; x=1763042138;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=01SU0RhLQwEiOS6q37xq1Pr1Ihj1YfZqxXq3UNB5G8c=;
 b=mv82hduQajfnPtiSOtGGjSbJNXD6fhh0bfHsA4zuybFcyuE+LIuDYVt42HQr5Uigcr
 pZBqBGpvxfXUHKfSLQohVVZ/Iqq5v7eILiX4gQA7Juc5+liHuNg6tAVgof6crfpec3tJ
 eUoB3OVc4ivdSCNlR1sFLxJRAphfhZI249cUdsNj7W/7cnJT6MBmvxCvCuBPbJ96B6wN
 SaS5eACOYzizM0C7Kidm/hZLfUVZJZFmGqqSJovhqbAcgUr48EJOd5DB02FmN2HJdh/b
 u/kfe/E5ZMvY+E80N+XqIDnEA8bPW0EtJByIwiLHRmZliDU/SXZWV/t+7HpcZCvOYIfA
 XaNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp5N02I8eW/g1AtUchNZitP0AQjxZfB81fsLOaPLF+SQ+9oDrVCiAvNH+QHysXb9Wu0/I+JE8ZHzg/@nongnu.org
X-Gm-Message-State: AOJu0YzmMPgCy+unYfOmmAttlPW8QYYugNW3+8Hzpwo9vhYUsxLsIDsB
 HR2RGUpm1zqib4uQFwFy+PDvOkmYE3N+FXizp/rYOoi1gXMTRwl9MAZjn0BP3QAs80gQtytSTLF
 M/z4MBdNV6XpgUyFp9s97GYkTc/nQcogKxmV0F9AmLrjF2bQlRmqBsL9d
X-Gm-Gg: ASbGncuZhVvhrX6JjNe6iVRRyz9wsFK3ap67DpLwVcajm5El+fdHe6+Zfdj4mPeku2C
 cgTUlm/vzxm9XgjdFaeN3kF6qNIMfqGCu9Cal8s5F4fD1qp1hz0g013JFE2SJAZvMoZPnosU5D1
 Ge6sI2FVvNw0HAUiFLpZ39QVfIaeokHb9n6nGgRIZ/40Nu9z0oBwUkoXTeAtxlOjudPVPY30Yr9
 A4I4nXmNBBJNyreQNG24apiFb0PGkYLpv/j+YydJ2qf32p7eHSpZt4X8r1Ty93xQMNquI/uHAtf
 3Ij/tbZYJCOFdXRr4vyqNiaj9TPsDgKhADNbVvMFwrVZi/sz13wKXLWZZjTuFtk0H6glifKsxKt
 G5DOq1Kilztpket2bVwRv1EDVaAjfOllwRi4r8bZhbCn1Xw==
X-Received: by 2002:a05:600c:8b28:b0:477:a58:2d6b with SMTP id
 5b1f17b1804b1-4775cdbd460mr64072065e9.7.1762437338470; 
 Thu, 06 Nov 2025 05:55:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdNPZTotSJSiw+kGW8TF0ZOD5Tpcy0czenZ2FsDU3Dbh/lVCzKKQCjmXjTppZUlocNKhTnbQ==
X-Received: by 2002:a05:600c:8b28:b0:477:a58:2d6b with SMTP id
 5b1f17b1804b1-4775cdbd460mr64071765e9.7.1762437338035; 
 Thu, 06 Nov 2025 05:55:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429eb410ffcsm5203681f8f.15.2025.11.06.05.55.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 05:55:37 -0800 (PST)
Message-ID: <1be3383e-843f-49b8-a246-59375c42aaae@redhat.com>
Date: Thu, 6 Nov 2025 14:55:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 31/32] vfio: Synthesize vPASID capability to VM
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 kjaju@nvidia.com
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-32-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251031105005.24618-32-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Hi Shameer,
On 10/31/25 11:50 AM, Shameer Kolothum wrote:
> From: Yi Liu <yi.l.liu@intel.com>
>
> If user wants to expose PASID capability in vIOMMU, then VFIO would also
need to report?
> report the PASID cap for this device if the underlying hardware supports
> it as well.
>
> As a start, this chooses to put the vPASID cap in the last 8 bytes of the
> vconfig space. This is a choice in the good hope of no conflict with any
> existing cap or hidden registers. For the devices that has hidden registers,
> user should figure out a proper offset for the vPASID cap. This may require
> an option for user to config it. Here we leave it as a future extension.
> There are more discussions on the mechanism of finding the proper offset.
>
> https://lore.kernel.org/kvm/BN9PR11MB5276318969A212AD0649C7BE8CBE2@BN9PR11MB5276.namprd11.prod.outlook.com/
>
> Since we add a check to ensure the vIOMMU supports PASID, only devices
> under those vIOMMUs can synthesize the vPASID capability. This gives
> users control over which devices expose vPASID.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/vfio/pci.c      | 37 +++++++++++++++++++++++++++++++++++++
>  include/hw/iommu.h |  1 +
>  2 files changed, 38 insertions(+)
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 06b06afc2b..2054eac897 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -24,6 +24,7 @@
>  #include <sys/ioctl.h>
>  
>  #include "hw/hw.h"
> +#include "hw/iommu.h"
>  #include "hw/pci/msi.h"
>  #include "hw/pci/msix.h"
>  #include "hw/pci/pci_bridge.h"
> @@ -2500,7 +2501,12 @@ static int vfio_setup_rebar_ecap(VFIOPCIDevice *vdev, uint16_t pos)
>  
>  static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>  {
> +    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
> +    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>      PCIDevice *pdev = PCI_DEVICE(vdev);
> +    uint64_t max_pasid_log2 = 0;
> +    bool pasid_cap_added = false;
> +    uint64_t hw_caps;
>      uint32_t header;
>      uint16_t cap_id, next, size;
>      uint8_t cap_ver;
> @@ -2578,12 +2584,43 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>                  pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>              }
>              break;
> +        case PCI_EXT_CAP_ID_PASID:
> +             pasid_cap_added = true;
> +             /* fallthrough */
>          default:
>              pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>          }
>  
>      }
>  
> +#ifdef CONFIG_IOMMUFD
> +    /*
> +     * Although we check for PCI_EXT_CAP_ID_PASID above, the Linux VFIO
> +     * framework currently hides this capability. Try to retrieve it
> +     * through alternative kernel interfaces (e.g. IOMMUFD APIs).
I don't catch this sentence . When are you supposed to read above
PCI_EXT_CAP_ID_PASID cap id then?
> +     */
> +    if (!pasid_cap_added && hiodc->get_cap) {
> +        hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_GENERIC_HW, &hw_caps, NULL);
> +        hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_MAX_PASID_LOG2,
> +                       &max_pasid_log2, NULL);
> +    }
> +
> +    /*
> +     * If supported, adds the PASID capability in the end of the PCIe config
> +     * space. TODO: Add option for enabling pasid at a safe offset.
> +     */
> +    if (max_pasid_log2 && (pci_device_get_viommu_flags(pdev) &
> +                           VIOMMU_FLAG_PASID_SUPPORTED)) {
> +        bool exec_perm = (hw_caps & IOMMU_HW_CAP_PCI_PASID_EXEC) ? true : false;
can't you direct set exec_perm = (hw_caps & IOMMU_HW_CAP_PCI_PASID_EXEC);
> +        bool priv_mod = (hw_caps & IOMMU_HW_CAP_PCI_PASID_PRIV) ? true : false;
> +
> +        pcie_pasid_init(pdev, PCIE_CONFIG_SPACE_SIZE - PCI_EXT_CAP_PASID_SIZEOF,
> +                        max_pasid_log2, exec_perm, priv_mod);
> +        /* PASID capability is fully emulated by QEMU */
> +        memset(vdev->emulated_config_bits + pdev->exp.pasid_cap, 0xff, 8);
> +    }
> +#endif
> +
>      /* Cleanup chain head ID if necessary */
>      if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) == 0xFFFF) {
>          pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
> diff --git a/include/hw/iommu.h b/include/hw/iommu.h
> index 9b8bb94fc2..9635770bee 100644
> --- a/include/hw/iommu.h
> +++ b/include/hw/iommu.h
> @@ -20,6 +20,7 @@
>  enum viommu_flags {
>      /* vIOMMU needs nesting parent HWPT to create nested HWPT */
>      VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
> +    VIOMMU_FLAG_PASID_SUPPORTED = BIT_ULL(1),
>  };
>  
>  #endif /* HW_IOMMU_H */
Thanks

Eric


