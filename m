Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE798CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 17:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCLjQ-0007l5-2O; Fri, 24 Oct 2025 13:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vCLjO-0007ko-FG
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 13:37:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vCLjM-0002PM-4M
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 13:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761327455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=99DqisHHiWuDqbo1PH+vuQKG9hkb9XpjpghmHElLyZg=;
 b=MoiZXBV3fzRL0vd0QHbG+mnx0fGzCz710nIVQp4viJG4MFuqQKHCyrx6i5WkJ6dHFS3A/S
 ASADLIz1zJWMEt0sBZ5tf/FhXgsI9Zy2/r0z2oNiais5bR4QW/PO6R5RU5HWTppxpwp0Tx
 T9EKqf363Z3FAD5Ap6Gwz4Dw/4ybBe4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-p1jyOmMJP2O6IxP10ldgVg-1; Fri, 24 Oct 2025 13:37:33 -0400
X-MC-Unique: p1jyOmMJP2O6IxP10ldgVg-1
X-Mimecast-MFC-AGG-ID: p1jyOmMJP2O6IxP10ldgVg_1761327452
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47106720618so15820545e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 10:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761327452; x=1761932252;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=99DqisHHiWuDqbo1PH+vuQKG9hkb9XpjpghmHElLyZg=;
 b=O6zxjWw4b1eSQQJ6VJs2U7aaKPuVxwtSZjlLINkGPuF5pUgYQV3Cc4NCtvo1Ax4vo+
 uEckPxJr1vlM6KawcDITcgK86x/622zsnbm0XECJKOQ+l+yptdYBH5fEVsDE2Y+6jqQs
 JJNRLx91fM62mS+oXbbfPHIUiDk+12u641a+d9P7iR5EJ2GiG0CWM/KtEgpD7z6FgJJZ
 NALmh/ghwDCTk55t/f6zJZx/okmFDlZ650cI0jMG0SfhE573qWwNR2SQ62VcRBgOOPfI
 RK7auxTjV6OPZ1KLlIqotghA+9vfccXETX00ZnKE7yMD8c+AcyTCs38EwTRdDizpe2wW
 l0lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW/wGvTQT5gTJWOFmUi47rIE5eqj2ywTLvOxqgC9nOUVhq3xh+8vHSwi7+9UZ1bAWawXivJPu0WAPw@nongnu.org
X-Gm-Message-State: AOJu0YxctaP7SMOJyPoIAwU9Fsb/nN6hEL80YsCcqlADliLDYlbsR6CC
 EW7b4j3Cvidsx/rB9oiUDQ4yB91DjiwZC72zyZQaO55ARc4Kwwij4s7iHPVswm1cAT8azHDGlKD
 klOn6Dhr35HzTekLgfJUp6cY7zpnMkL8nanQFTmZLAZ4oQxptYy2p8cxX
X-Gm-Gg: ASbGncuoWC0DTZTxCdtkrp9bOUW0UK7uZ0jBZa/eQ91a2FAUi7i9YNb3MP92G5J3QxY
 TZKWWU2NyqWAVrY/wiGaIlCmBDXrfc1BBz/V36RuaaqWth7//cARTfV51GESx0G1F0eSPENuDUo
 qEjO5PvMfooGMlKMrKfmcLouUD8sE+rC9vVDYEyZQGrwft+vSPZ7AC4k98ra4Htt0aTaNHoolcE
 cHOE0iMs5JuUnH/E9PFNok7k2URmnmiM64EcwryavvQjmkTuzpnS/dBHbkwyLgKfOKH2fRl97C1
 OmjP+PkpwxrA+Pp6lreZOqoTGnM7lgwIKHc3fWaCA8lxclXiDYxOb229N+4YDDdxajnQrlqE
X-Received: by 2002:a05:600c:45d4:b0:471:56:6f79 with SMTP id
 5b1f17b1804b1-475d30d90admr28971995e9.41.1761327452203; 
 Fri, 24 Oct 2025 10:37:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETV6v0K4rF/WEXFsftyF1P3i4kO0IjoYRlppo6wEY6jOJC2wIdaDvhX/umx4PIpfUVbYRSaw==
X-Received: by 2002:a05:600c:45d4:b0:471:56:6f79 with SMTP id
 5b1f17b1804b1-475d30d90admr28971825e9.41.1761327451691; 
 Fri, 24 Oct 2025 10:37:31 -0700 (PDT)
Received: from [10.54.0.145] ([147.135.244.229])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475caf15416sm102380545e9.10.2025.10.24.10.36.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 10:36:29 -0700 (PDT)
Message-ID: <3e4f5b3d-1ba2-4a1b-92e6-3b9ef9067ffe@redhat.com>
Date: Fri, 24 Oct 2025 19:36:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 19/23] Workaround for ERRATA_772415_SPR17
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-20-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251024084349.102322-20-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/24/25 10:43, Zhenzhong Duan wrote:
> On a system influenced by ERRATA_772415, IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17
> is repored by IOMMU_DEVICE_GET_HW_INFO. Due to this errata, even the readonly
> range mapped on second stage page table could still be written.
> 
> Reference from 4th Gen Intel Xeon Processor Scalable Family Specification
> Update, Errata Details, SPR17.
> https://edc.intel.com/content/www/us/en/design/products-and-solutions/processors-and-chipsets/eagle-stream/sapphire-rapids-specification-update/
> 
> Also copied the SPR17 details from above link:
> "Problem: When remapping hardware is configured by system software in
> scalable mode as Nested (PGTT=011b) and with PWSNP field Set in the
> PASID-table-entry, it may Set Accessed bit and Dirty bit (and Extended
> Access bit if enabled) in first-stage page-table entries even when
> second-stage mappings indicate that corresponding first-stage page-table
> is Read-Only.
> 
> Implication: Due to this erratum, pages mapped as Read-only in second-stage
> page-tables may be modified by remapping hardware Access/Dirty bit updates.
> 
> Workaround: None identified. System software enabling nested translations
> for a VM should ensure that there are no read-only pages in the
> corresponding second-stage mappings."
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/iommufd.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index f9d0926274..f9da0e79cc 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -15,6 +15,7 @@
>   #include <linux/vfio.h>
>   #include <linux/iommufd.h>
>   
> +#include "hw/iommu.h"

Changes look ok apart from this include.


Thanks,

C.



>   #include "hw/vfio/vfio-device.h"
>   #include "qemu/error-report.h"
>   #include "trace.h"
> @@ -351,6 +352,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       VFIOContainer *bcontainer = VFIO_IOMMU(container);
>       uint32_t type, flags = 0;
>       uint64_t hw_caps;
> +    VendorCaps caps;
>       VFIOIOASHwpt *hwpt;
>       uint32_t hwpt_id;
>       int ret;
> @@ -396,7 +398,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>        * instead.
>        */
>       if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
> -                                         &type, NULL, 0, &hw_caps, errp)) {
> +                                         &type, &caps, sizeof(caps), &hw_caps,
> +                                         errp)) {
>           return false;
>       }
>   
> @@ -411,6 +414,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>        */
>       if (vfio_device_get_viommu_flags_want_nesting(vbasedev)) {
>           flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
> +
> +        if (host_iommu_extract_quirks(type, &caps) &
> +            HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO) {
> +            bcontainer->bypass_ro = true;
> +        }
>       }
>   
>       if (cpr_is_incoming()) {


