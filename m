Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00058C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 13:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugkcw-0007hV-KY; Tue, 29 Jul 2025 09:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugkct-0007AG-O6
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 09:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugkcq-0006GW-DF
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 09:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753796651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JcCNJ2GkM+w2OKEXL+93GJyOk7rUrV/wnAuK9b1otCg=;
 b=f/qtdo4n2xpiXBxM0WpjQrtiyAtY/LxsNTtYiOR/+jxLVZqUkgbmMEZKzquve8vWkV1wDZ
 aRBn0ZUVWGop9PUNEDS5XmrQlonKGj6fPFE+3XVpGjcQrBZTqtTMHieL9+j/oojEDKNQl1
 8ubWvcFN5S1h9gX8D2IKta7sQtYFtV0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-rzj9bJFtON2GfcAghXea5g-1; Tue, 29 Jul 2025 09:44:09 -0400
X-MC-Unique: rzj9bJFtON2GfcAghXea5g-1
X-Mimecast-MFC-AGG-ID: rzj9bJFtON2GfcAghXea5g_1753796649
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a58939191eso2018997f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 06:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753796649; x=1754401449;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JcCNJ2GkM+w2OKEXL+93GJyOk7rUrV/wnAuK9b1otCg=;
 b=LxU2ULddfJGKR4xyvpju+MG32CpG4q65uo6Z+h91ZPYiFcJdCoEd6+nEXBuXvub7qb
 T84AEEOg8dJPRQ2ax2ae1UieGEaUYV3v+7cNqAU8xqYplf8jsEzkmwSuueP+cp4I0Cyi
 NUnSWa+8qc4SxJ+TO/ecZqQ8nXwAxiyt+/+Sj0dAqP8wJy0unt657yl22tyfkvoK3wa4
 hd3XiGr/3HRU/bqNSmnCvTXyIuOdUn5ES0NTBlAyLEx1j5AyGy+vhG8yRDTTlaXA+5XY
 wydFv/BVJ8T5A80pZruLcEFcZ6SNsOVLlVNQxMnQIUbE3buNzuhswGKjmISLrc+EQEP5
 cAQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdSXR4LKpxugXyHy90qM1jCFJbsxhNLgE2CSpLw70TAxki/SV71d9B1RsX0Zhbu6793vcMkaUjhxDJ@nongnu.org
X-Gm-Message-State: AOJu0Yz+Mibi0Y+9llmX/w0FUhh8aRV0D2kfenvHXk1b2BxcgkeOxYZW
 Nw0y3y22ZRW8rPeby7DXQ6hASzbkM8UyQ1cMvprG/RPmMkyTlSgQc627aKawlFNRW6t9FBuuxZw
 4nGnszS3VVzToooe5f7AsVe+RC6nNJDP5MD4GYW4KvK8qtsVPFyFuZ5x2
X-Gm-Gg: ASbGncvrGRlVgjgeUEg8XhefMQSHZ957LqELcq19fIGFTFrgwVviJsymEicEZYX8VMf
 I1S1UXRDaGa+Fn527p+3RF/NLqVR4RBNtJo+IARCwptQh7ReAoTXnY4Lu/MookLVe+PouUuv+J1
 VOli1dG1+9F3xx6DhMschGJg+jJSLCPENeABAe+N+ychwo4AlU/6DF5s1DC7VYOwxiQd2lP/Twh
 33eG5bJry05WTBxlfYS6Z5B3yOvBP+bko9ZW8FNlcmnJRw0G6E1F45G03A09JC3+FHhy2KyI5NM
 6B903FgEsDskUhIn3E8XJ+2wmhJJQiKseJz+2N8lhSizw1h4GtVT/S+eO+8K5e4Nrq0puBPDBRh
 A2g==
X-Received: by 2002:a05:6000:4410:b0:3b7:7870:125a with SMTP id
 ffacd0b85a97d-3b778701569mr6967927f8f.43.1753796648644; 
 Tue, 29 Jul 2025 06:44:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeR+kdoFywAEKOnhJP7MUp0wgKZlWyH6UOZRO9t+Lt6m2MouNVNb/6lcCK7ytMZCeCYcJn7w==
X-Received: by 2002:a05:6000:4410:b0:3b7:7870:125a with SMTP id
 ffacd0b85a97d-3b778701569mr6967900f8f.43.1753796648191; 
 Tue, 29 Jul 2025 06:44:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b78b26a4dcsm5051163f8f.32.2025.07.29.06.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 06:44:07 -0700 (PDT)
Message-ID: <74895627-74a8-4cb4-a460-491ac5dd1c2b@redhat.com>
Date: Tue, 29 Jul 2025 15:44:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/20] vfio/iommufd: Force creating nested parent domain
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
 <20250729092043.785836-5-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250729092043.785836-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/29/25 11:20, Zhenzhong Duan wrote:
> Call pci_device_get_viommu_cap() to get if vIOMMU supports VIOMMU_CAP_HW_NESTED,
> if yes, create nested parent domain which could be reused by vIOMMU to create
> nested domain.
> 
> It is safe because hw_caps & VIOMMU_CAP_HW_NESTED cannot be set yet because
> s->flts is forbidden until we support passthrough device with x-flts=on.
> 
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/vfio/iommufd.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 48c590b6a9..61a548f13f 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -20,6 +20,7 @@
>   #include "trace.h"
>   #include "qapi/error.h"
>   #include "system/iommufd.h"
> +#include "hw/iommu.h"
>   #include "hw/qdev-core.h"
>   #include "hw/vfio/vfio-cpr.h"
>   #include "system/reset.h"
> @@ -379,6 +380,19 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>           flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>       }
>   
> +    /*
> +     * If vIOMMU supports stage-1 translation, force to create nested parent
> +     * domain which could be reused by vIOMMU to create nested domain.
> +     */
> +    if (vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
> +        VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> +
> +        hw_caps = pci_device_get_viommu_cap(&vdev->pdev);
> +        if (hw_caps & VIOMMU_CAP_HW_NESTED) {
> +            flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
> +        }
> +    }
>

Could you please add a wrapper for the above ? Something like :

static bool vfio_device_viommu_get_nested(VFIODevice *vbasedev)
{
     if (vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
         VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);

	return !!(pci_device_get_viommu_cap(&vdev->pdev) & VIOMMU_CAP_HW_NESTED);
     }
     return false;
}
	
May be this routine belongs to hw/vfio/device.c.


Thanks,

C.




>       if (cpr_is_incoming()) {
>           hwpt_id = vbasedev->cpr.hwpt_id;
>           goto skip_alloc;


