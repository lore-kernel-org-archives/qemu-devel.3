Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF65ACCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 17:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCLkc-0008FT-PB; Fri, 24 Oct 2025 13:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vCLkZ-0008F5-SO
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 13:38:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vCLkW-0002T3-5m
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 13:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761327520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=99DqisHHiWuDqbo1PH+vuQKG9hkb9XpjpghmHElLyZg=;
 b=eC5NL5pDkKrIeOAM7NpNRKLD4UTyBdeCb+Vl9PCJt/nYA4Li74ZnMlCjMG0WE0PbAVX6MW
 LnKZ8x4Qa+CxzPTE+RTgQIiVs777VuYiCS06LPPuTjg80ZbR0sHqDAt4JGPCJG3/2chE2p
 A4qXxh9t+D2eDGKplMCA7St9LLXNjYM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-N5TmYn4NM3O0sWAKf1IDsw-1; Fri, 24 Oct 2025 13:38:39 -0400
X-MC-Unique: N5TmYn4NM3O0sWAKf1IDsw-1
X-Mimecast-MFC-AGG-ID: N5TmYn4NM3O0sWAKf1IDsw_1761327518
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b48635cf06fso401217566b.1
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 10:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761327518; x=1761932318;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=99DqisHHiWuDqbo1PH+vuQKG9hkb9XpjpghmHElLyZg=;
 b=tIQxlFdD7R3zy300mf6TNdcIs7DiTm5zbO818fPO6QQ1JJ441scpn/Q7gV6Egq6paK
 l9ZVwHtvlcczcnedR6xt4zTUnqeLW+rmAn+PNouMKRtMSzf/5tsJEnWyylKsFdBOjSgE
 ojdnjj8SN1CIwTu5E1DOmY7rZ1nXb1zYerLt4rqmUYkw1Wgf/8l62bMEOjoXhUzh0EUM
 Q1iSS+22ysTOn2EhneNI+dYdZ1bGnWxgAqeXeKlCyEeNt1HUC8gUTHx9YZO4xGJ/NlPn
 c8PrnooR/9HPa+eiFfb4PtSIVXNe+n3hzv1h9OQ8KTsK0NrwmgocYFaUzKoW+n+eA/bT
 HrtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWyU08FExiGYNwwL5Hn4SFHGFdY/Ba11z88+xqmmQEunISjiOwspCSYgEnsFpW6gKIUwFJ1dqA+NlG@nongnu.org
X-Gm-Message-State: AOJu0YxJvcprFxERdgIjMDZCzRArgI/QNMpY9aDHKlCj4JgnQq5afRUW
 icrsPWIHJc4Au9d3kMbdpJH5DZNqeZCQLHLdanwPwkDLUx5Ukj/pYl4Weo9lYKCis88+2Ohte8x
 1CL9nBokX4CyuLNHZPsEuI7QpqWPDSlutd4Y0p5pOFqkDydRiNVGdEbtX4L9jHrfO
X-Gm-Gg: ASbGncta6auy+lFEz2O5TxSe6nHTBpVT8JpnV9MMlslVmI2IPiQIlUorqItc0i5FngT
 vgu+PFNqz0gEwfIJogd6jEphLoscfxnRs/dsX/8QyvZ4P+1HLPzP8BJWrIk+47YAH9C9Sw5dWir
 SzrfyT56L1kkQjTjZD3U7y6vPKbkauoPAvUKo2TV5GCSP/Kip0ujE6y5JW3NN+fLNX2tOOa4v1E
 EHMwcxHlEDxLktzcc6NNJHoujSMrylWBdZCfnLH3i7V8RRYTjvB5dzxXemGMB5duhbS5ZOEKM9V
 we29PnTYKXtvOiDpw9UzOz/GJ9At14nqbBv9S/C0bky/ZNoWg3a2MOF7pYIx1H4PA0IPnHMe
X-Received: by 2002:a17:907:1b15:b0:b6d:505e:3da1 with SMTP id
 a640c23a62f3a-b6d505e7df8mr736220066b.7.1761327517637; 
 Fri, 24 Oct 2025 10:38:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU6bNjzjHr6b01pIttDrKqBI56hD9ZfjNCZXavh1gb7fv9Lb1uQkSY8GeZvzhZ5KHuSGpEEg==
X-Received: by 2002:a17:907:1b15:b0:b6d:505e:3da1 with SMTP id
 a640c23a62f3a-b6d505e7df8mr736213566b.7.1761327516403; 
 Fri, 24 Oct 2025 10:38:36 -0700 (PDT)
Received: from [10.54.0.145] ([147.135.244.229])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d517827a1sm564146166b.40.2025.10.24.10.38.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 10:38:35 -0700 (PDT)
Message-ID: <ad429497-65cb-4eeb-80a4-250c93b0df14@redhat.com>
Date: Fri, 24 Oct 2025 19:38:26 +0200
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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


