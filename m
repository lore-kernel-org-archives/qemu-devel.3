Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD776C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubivN-0001tu-2L; Tue, 15 Jul 2025 12:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubidV-0003tq-2a
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubidT-0002xe-E4
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752597366;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ShMPyh1RRebJ1+FKIOsSra0OAkW1VG4bG3dUi1mKyhk=;
 b=GPB2i9ucWTEhG5ohjnQFsT23JATJb+A3eb1lLCq9G2jdjg+C5a8lEsPi4b7sedJu6Mslrw
 RxRiQbvDzfU3QNFWQNLLd5ggf3j2+aDnmoy/pT/MBIHR1gNm+cml1x4lmOdfyjDqvv03Ri
 RIU2eMbWe+IbGGNYjeC77ObhKOPs+qA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-WfyVwYZnPx-KySdAaXYwzQ-1; Tue, 15 Jul 2025 12:36:04 -0400
X-MC-Unique: WfyVwYZnPx-KySdAaXYwzQ-1
X-Mimecast-MFC-AGG-ID: WfyVwYZnPx-KySdAaXYwzQ_1752597363
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a50816cc58so1986969f8f.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 09:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752597363; x=1753202163;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ShMPyh1RRebJ1+FKIOsSra0OAkW1VG4bG3dUi1mKyhk=;
 b=RSpJmvrCCOAVeaXFK2WYAp8s3pdL/6ZfQlaAnJMjaZGRjAkXXaxzkor/qw0mpe2OeW
 mnrpefcwdcLcjbFeg/6+J0GWkf2fk5CZUJxBEiK+KwLyVauVMTQ0MHBZiRADLBadImEZ
 bOopSbmM+xeJcnOPy1hu580He+mm9gBpOmDW2XvG3ypA+V27yFF+WBuIaTlcP21YuJZy
 pAvPkJQ4M3AfSDrz90/+9VkfGu2L1asaBM3ExNak8MwvCJpFX3kOq74NXoB75rStgHCV
 E4CY8EXPUPYrR18I89roPIS7drSjjX8h9g/Xs91kRgQex0s5bCAAtf6IId9S+Y6VREHJ
 s/HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVHMqziTpZycjcJk7t+TmR+r3b+skdO6NIM6hwIyolzH3YORJ+vx9nIkb/7vBz7jUIG8/ZAQMZ3+cS@nongnu.org
X-Gm-Message-State: AOJu0YxAW/mZj+maFp6uPSwxZRaOLgIvgWAs5djumOrmCvm7VXLCgrC5
 jWk8+MOIiJbWyL4Ll4pGcTmG3StrVPnnnGjqpbdjhL6SWmpx+UonuS0RoO+2T+yuC2BvYnR3sFn
 RRs5xmV9ME/6ayVXI1DbihFLjlRW/oEWGYSqnLReXphlgM2d3Q4k4dDT+
X-Gm-Gg: ASbGncu4di7lJkAXgdAqf2Lm1s5+ONTATyUpYa9wPfbMRYvNAvGmf7mdJri1hLfGcXZ
 O301fC1DttGtATeec24A1IHzFSBwvAK2toG/LPWKJ5UOyQ5Aeg1q6xHbPBndXyObzoGbkd07v3Q
 9MSA1DxX78qKP09/VEyLbIIBRNoiXVgyJMiNagQBJjs2UAhadW17M/HfbyR9X44tMt+gnaSBEf8
 yG+6YEIDxSvl/KyUVeNRQESfJhSBV8oF+2cqch8ySeOMMIr/mlF0H3QoLUFkPXP2RDpkSzajKXv
 bUbBe5y5Hc2fXB8MN2tSwS6FeHI7FuqrC8DIwvj6JTLq+AbQj9n6UEIqDQGsfhmmE6CHHyVkdx1
 mBJ6lhh6xjxM=
X-Received: by 2002:a05:6000:643:b0:3a5:25e0:1851 with SMTP id
 ffacd0b85a97d-3b5f1875e37mr15895602f8f.7.1752597363444; 
 Tue, 15 Jul 2025 09:36:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGby+GBrc1XY2Ds/yqVXjHtSwQ1ptYpfJbd+cSzzRZ8SDHOH3ZlrYqi8oTbQY58aylgykD9Uw==
X-Received: by 2002:a05:6000:643:b0:3a5:25e0:1851 with SMTP id
 ffacd0b85a97d-3b5f1875e37mr15895573f8f.7.1752597363035; 
 Tue, 15 Jul 2025 09:36:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc9268sm15431871f8f.41.2025.07.15.09.36.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 09:36:01 -0700 (PDT)
Message-ID: <e543cd27-f70e-416f-b59d-bb681a207ab6@redhat.com>
Date: Tue, 15 Jul 2025 18:36:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/20] vfio/iommufd: Force creating nested parent domain
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-5-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250708110601.633308-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/8/25 1:05 PM, Zhenzhong Duan wrote:
> Call pci_device_get_viommu_cap() to get if vIOMMU supports VIOMMU_CAP_STAGE1,
> if yes, create nested parent domain which could be reused by vIOMMU to create
> nested domain.
>
> It is safe because hw_caps & VIOMMU_CAP_STAGE1 cannot be set yet because
> s->flts is forbidden until we support passthrough device with x-flts=on.
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

>
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/iommufd.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 48c590b6a9..c172c177fc 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -20,6 +20,7 @@
>  #include "trace.h"
>  #include "qapi/error.h"
>  #include "system/iommufd.h"
> +#include "hw/iommu.h"
>  #include "hw/qdev-core.h"
>  #include "hw/vfio/vfio-cpr.h"
>  #include "system/reset.h"
> @@ -379,6 +380,19 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>          flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>      }
>  
> +    /*
> +     * If vIOMMU supports stage-1 translation, force to create nested parent
> +     * domain which could be reused by vIOMMU to create nested domain.
> +     */
> +    if (vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
> +        VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> +
> +        hw_caps = pci_device_get_viommu_cap(&vdev->pdev);
> +        if (hw_caps & VIOMMU_CAP_STAGE1) {
> +            flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
> +        }
> +    }
> +
>      if (cpr_is_incoming()) {
>          hwpt_id = vbasedev->cpr.hwpt_id;
>          goto skip_alloc;


