Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181DBCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFuP1-0001LF-VA; Mon, 03 Nov 2025 08:15:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFuP0-0001L2-Cz
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:15:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFuOm-00089D-MC
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762175696;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CaDHLIOrXtPtQ+fhq4CRo3T0/Rnmz6hpsJA3NyGec7k=;
 b=V/3nwr3/EkYUkObcBx5Aph09aKSkz7dc9YcEjG5DFaXfTktbgSxip6r7rUcF/PJbM+jsBc
 jDkdV5U1onehJMwJ0bv1lYGZq57bdU8MNIQ3kngXtb3dTMSOzBg/anPE4kgn22QWzySNDm
 /pUHWRXBBU820i9XUJMy0Io9BXATKZc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-PE-iY-fGPxyqIs71EmdFQg-1; Mon, 03 Nov 2025 08:14:55 -0500
X-MC-Unique: PE-iY-fGPxyqIs71EmdFQg-1
X-Mimecast-MFC-AGG-ID: PE-iY-fGPxyqIs71EmdFQg_1762175694
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477171bbf51so22804135e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 05:14:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762175694; x=1762780494;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CaDHLIOrXtPtQ+fhq4CRo3T0/Rnmz6hpsJA3NyGec7k=;
 b=dM0qOI17pVrha7r1zA7AiopvJ8SiQx1tQEWnTBV5AYQQ4+55YWRv2MJknNP2Z4h0Ip
 qZ84sLeEm04YDO34Kd7024m7V/RE7meGSNLCqKm1ajPCwctT4KT+YBoHjB4jGgfL2no/
 cbmSU9O3LJeWxRrufDuJgl2ho4Y+T4g1asDtjj0jZymNa42Dv8sUij60L8+FaQ9QiB5c
 uX6W4ZPTM6ROJs2u8uyKSziUWeyi28MXqyLfoyfEUe1dEADoSR7osHZCAxP+Qxb0rQQN
 J5AIvRyJss4UwEEjr5woR8rpvNzB7eQ5Vj39qLv2m2YdQYEC/BfQt/3BSRCIvCNLdExx
 88BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpwN/FMkcOAW58GdPL6hBbEHC0W3uzYqaRUODAM6tamP/2jsHnPvWHGXslxn3ulx9E07btuu3vAsXp@nongnu.org
X-Gm-Message-State: AOJu0YwTrGiuAOJMkkHBIX1ZrbmenMjmqFIQ7BQfc+kIbjdvE/XxWG86
 Fhq6y67rvKq3gSzklmx9Onmj7W1PxYnYyjp5rZNJZUOUlSpQoyDhdS2/ZzKogpSG357qa0ZAhaM
 OjgJIhCwhvmmPMwE8cH3Wtz+owf6D5ILkqxL6u0Syi0WwITI/eQQW8e7b
X-Gm-Gg: ASbGncufPaRnd+3GyLRUzh31d1YteUQ9YmaHjgW5OTJeEhCluJS2z37r7DwgmDNtoPT
 4CnR82d5BIjbFFM1LL/ei9rL65GrzpETbekx3DLpbdYlcT8XL3fSrHC50J6mXhpdLwJngk/cY0W
 YWI7/c6IzGFG/XJMqLbImdXEQejBAzsCCIE4ine90j6HUQcV7zggZrZ+QSZ4ahMsn5YCGtioGiy
 96WGSOvztympENvZEIDD7cvqm1y09ea/P5mlhs0FzK9e2xKq/8r74P6gcEVrzpy7MLnvdybojHr
 1jvBTEbCkAlS85oeEHnn7wORXYMADnwnbepOzwNzTKjFc8iVAfo5udLScPSgaQdf27XM7jF783F
 8Lohsw+l8VNBVkm0tBmgk7987rLGnyxsl38mZ5YfFH5RPig==
X-Received: by 2002:a05:600c:c16b:b0:477:f9c:67f5 with SMTP id
 5b1f17b1804b1-477376d769amr93689235e9.16.1762175694127; 
 Mon, 03 Nov 2025 05:14:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXsiDGZY9OIPISFyBzG7dzys7QvKpPW/xi4Me7yRxuuPM3ML6UN4GNCCpUYQhq4MHFRCodxw==
X-Received: by 2002:a05:600c:c16b:b0:477:f9c:67f5 with SMTP id
 5b1f17b1804b1-477376d769amr93688965e9.16.1762175693695; 
 Mon, 03 Nov 2025 05:14:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c383b45sm158194475e9.9.2025.11.03.05.14.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 05:14:53 -0800 (PST)
Message-ID: <ee36b44e-ba84-462b-be43-bb00b0b4158d@redhat.com>
Date: Mon, 3 Nov 2025 14:14:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 19/23] Workaround for ERRATA_772415_SPR17
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-20-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251024084349.102322-20-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 10/24/25 10:43 AM, Zhenzhong Duan wrote:
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
>  hw/vfio/iommufd.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index f9d0926274..f9da0e79cc 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -15,6 +15,7 @@
>  #include <linux/vfio.h>
>  #include <linux/iommufd.h>
>  
> +#include "hw/iommu.h"
>  #include "hw/vfio/vfio-device.h"
>  #include "qemu/error-report.h"
>  #include "trace.h"
> @@ -351,6 +352,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>      VFIOContainer *bcontainer = VFIO_IOMMU(container);
>      uint32_t type, flags = 0;
>      uint64_t hw_caps;
> +    VendorCaps caps;
>      VFIOIOASHwpt *hwpt;
>      uint32_t hwpt_id;
>      int ret;
> @@ -396,7 +398,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       * instead.
>       */
>      if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
> -                                         &type, NULL, 0, &hw_caps, errp)) {
> +                                         &type, &caps, sizeof(caps), &hw_caps,
> +                                         errp)) {
>          return false;
>      }
>  
> @@ -411,6 +414,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       */
>      if (vfio_device_get_viommu_flags_want_nesting(vbasedev)) {
>          flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
> +
> +        if (host_iommu_extract_quirks(type, &caps) &
Given that call site, I would rather implement a new PCIIOMMUOps, no?

Eric
> +            HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO) {
> +            bcontainer->bypass_ro = true;
> +        }
>      }
>  
>      if (cpr_is_incoming()) {


