Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D9DECD6D0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 17:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqEKz-0002yB-4m; Wed, 11 Feb 2026 12:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqEKw-0002xa-JL
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 12:49:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqEKu-0005yp-SE
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 12:49:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770832150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1yCZLR1DLzEMSeGP2YkgCMXudyI6gzjodSS/USsCDZI=;
 b=NVgiMXhr48Gva3n/td5o/LXIzJPUA0FoPjYbzdBzq3bM+pXfo0oMnQnLduMAj/3iDL8onm
 atN2yDDGgue1R/7w9RtgvoB5zmnJPRw7dsHUH+er9kpF6HVAi9sxkE+NdOLaToNWqWMilY
 e9v5g7XbcSEkDPLPZPkvjy82YaceT5g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-Gok3r_aLMXitOnuyGyUlNQ-1; Wed, 11 Feb 2026 12:49:08 -0500
X-MC-Unique: Gok3r_aLMXitOnuyGyUlNQ-1
X-Mimecast-MFC-AGG-ID: Gok3r_aLMXitOnuyGyUlNQ_1770832147
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43623cfb160so4074897f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 09:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770832147; x=1771436947; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=1yCZLR1DLzEMSeGP2YkgCMXudyI6gzjodSS/USsCDZI=;
 b=VU+a7wca23UNjHG3B2M6olo6viLZ3FiAlQBkhbQM2r7ROvdiBvF+w0m9+e3qMyYeUa
 bLsc30oD3VSKrt3g9UGCnEnUC863MgL2XqPZ1qlrVk5KXgV9MJZqM6HfHIyW6Cah7Wqq
 jnPdQYd3+EkCkWCbjd6fc/8JJBeLSVhq86rUi5J33fvyVKAdytOLl/auYTxsHCncivKf
 94okrNKhyzMz6spdcm5qVF8ym2iuOTtT7q8g3oTGkAQ8qt/U2ynVdEfHzTfIBJeKWoLy
 TxQnWEXsZpwKzE2mpFH8o5GJDPJnAcuBQxesI9jS+RNzsZOUBVl2xPdjLvbCUfTUfNKr
 csjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770832147; x=1771436947;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1yCZLR1DLzEMSeGP2YkgCMXudyI6gzjodSS/USsCDZI=;
 b=EyBy3I8HM0LZa6Ub8sVfjJ/06JCRALZZagQHLZ6x4JxYXKNrbX1EKQN519tduM7xtO
 Y9SQI0VlNfcLPk4nBu+L0e8bvV/wOaKAEbxMJkQIJOdTfduoO2wU4rQEazsamcTLAOeI
 a2OaF1/yvI95cNhCH3yxrFj3d7RJk+ETfgTSXZGYdKwB8X09T2xplZGSOf4JUnHTFBS2
 YBgWEw0Ycq6rKPvrOF2YICKIpqVZgUkj9iat/eqnnLHS0tIcr8R9rw5Sbr6qxdHtWfSC
 vhjX+0Cr8UkIOvef66RHOPzktpolOTG/nxCC/OxJBcPnUZK7SLXktsMbpb7HGGe+KDTI
 szEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoeMZXP8Kj/WaSeNgQHrDHSs3BaoAQ5Jxl3CDQSGluhGB84ko927cq0Lg06R6jMn7k1wPQkON3rvOk@nongnu.org
X-Gm-Message-State: AOJu0YyvDIKXamGsP/BYHYMMtUb6shWEMO427EgWc/D4wgaVKJkR+mKB
 ee3rz7kFil5W2qaWV4+2Cs52FaHW0k00WngY6oCgmvRwiM4TUEY/iimr9hED6NeZNiWVawQH53G
 0ohHkLFTZMzVBBrOsTGTMyDWvN1fv56/Y3TD4OlB4JsOTJdLLLB/qJTDc
X-Gm-Gg: AZuq6aIiM3gB3+VUbhTcQQCvUvCa15XX+yQSn6oPxA+kofyx1y2338Xy+qFg4jk/cM2
 y2fTC/++GCUl1W/xxQOV7wq9LMaYsRCW9zXXyEeOfmV7K8QilIsLqpVFltSV0zEZWw39LTOMIJj
 dyggdWwZbphRWE4GfRhUlDPXYkfTX+ZXXOY0ZZvG6gw7LnaDQ+aOD7iwONVvFR0AJIhheOe9QPo
 h7PSbCfWtYBnyaSDZb0T27gOTZXw7jLgxAfm7cv3MqHhB5xsXlaLgJkA3I48dZ0nSWkpV99biQz
 XBrzzNPPNCjMgFK0TqbgGZi/fqFcfLuuvtxNNmzC7FNkd2IsW+CPN8YNDlie5KGqfuXmo2fvNdf
 wc7qBQatElDFvaDrWdx5Eh0bJsxIyhyDfhpnNLoKX3qXdPqqSH6txS+BLShZn
X-Received: by 2002:a05:6000:4022:b0:437:675d:7620 with SMTP id
 ffacd0b85a97d-4378ac82043mr437730f8f.35.1770832147301; 
 Wed, 11 Feb 2026 09:49:07 -0800 (PST)
X-Received: by 2002:a05:6000:4022:b0:437:675d:7620 with SMTP id
 ffacd0b85a97d-4378ac82043mr437687f8f.35.1770832146840; 
 Wed, 11 Feb 2026 09:49:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783dfc54csm5988604f8f.25.2026.02.11.09.49.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 09:49:06 -0800 (PST)
Message-ID: <98b36726-71d1-4129-99cf-b16bea1575f1@redhat.com>
Date: Wed, 11 Feb 2026 18:49:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/vfio: sort and validate sparse mmap regions by
 offset
To: ankita@nvidia.com, vsethi@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com, alex@shazbot.org
Cc: aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
 targupta@nvidia.com, zhiw@nvidia.com, mochs@nvidia.com, kjaju@nvidia.com,
 qemu-devel@nongnu.org
References: <20260211030615.3202-1-ankita@nvidia.com>
 <20260211030615.3202-2-ankita@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260211030615.3202-2-ankita@nvidia.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/11/26 04:06, ankita@nvidia.com wrote:
> From: Ankit Agrawal <ankita@nvidia.com>
> 
> Sort sparse mmap regions by offset during region setup to ensure
> predictable mapping order, avoid overlaps and a proper handling
> of the gaps between sub-regions.
> 
> Add validation to detect overlapping sparse regions early during
> setup before any mapping operations begin.
> 
> The sorting is performed on the subregions ranges during
> vfio_setup_region_sparse_mmaps(). This also ensures that subsequent
> mapping code can rely on subregions being in ascending offset order.
> 
> This is preparatory work for alignment adjustments needed to support
> hugepfnmap on systems where device memory (e.g., Grace-based systems)
> may have non-power-of-2 sizes.
> 
> cc: Alex Williamson <alex@shazbot.org>
> Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>   hw/vfio/region.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index ab39d77574..177494c379 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -149,6 +149,19 @@ static const MemoryRegionOps vfio_region_ops = {
>       },
>   };
>   
> +static int vfio_mmap_compare_offset(const void *a, const void *b)
> +{
> +    const VFIOMmap *mmap_a = a;
> +    const VFIOMmap *mmap_b = b;
> +
> +    if (mmap_a->offset < mmap_b->offset) {
> +        return -1;
> +    } else if (mmap_a->offset > mmap_b->offset) {
> +        return 1;
> +    }
> +    return 0;
> +}
> +
>   static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
>                                             struct vfio_region_info *info)
>   {
> @@ -182,6 +195,34 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
>       region->nr_mmaps = j;
>       region->mmaps = g_realloc(region->mmaps, j * sizeof(VFIOMmap));
>   
> +    /*
> +     * Sort sparse mmaps by offset to ensure proper handling of gaps
> +     * and predictable mapping order in vfio_region_mmap().
> +     */
> +    if (region->nr_mmaps > 1) {
> +        qsort(region->mmaps, region->nr_mmaps, sizeof(VFIOMmap),> +              vfio_mmap_compare_offset);
> +
> +        /*
> +         * Validate that sparse regions dont overlap after sorting.
> +         */
> +        for (i = 1; i < region->nr_mmaps; i++) {
> +            off_t prev_end = region->mmaps[i - 1].offset +
> +                             region->mmaps[i - 1].size;
> +            if (prev_end > region->mmaps[i].offset) {
> +                error_report("%s: overlapping sparse mmap regions detected "
> +                             "in region %d: [0x%lx-0x%lx] overlaps with [0x%lx-0x%lx]",

please use PRIx64

An extra 'Error **' parameter to vfio_region_setup() could also be
considered to propagate the error to vfio_pci_realize(). It shouldn't
be too complex to add.

Thanks,

C.


> +                             __func__, region->nr, region->mmaps[i - 1].offset,
> +                             prev_end - 1, region->mmaps[i].offset,
> +                             region->mmaps[i].offset + region->mmaps[i].size - 1);
> +                g_free(region->mmaps);
> +                region->mmaps = NULL;
> +                region->nr_mmaps = 0;
> +                return -EINVAL;
> +            }
> +        }
> +    }
> +
>       return 0;
>   }
>   
> @@ -213,11 +254,13 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>   
>               ret = vfio_setup_region_sparse_mmaps(region, info);
>   
> -            if (ret) {
> +            if (ret == -ENODEV) {
>                   region->nr_mmaps = 1;
>                   region->mmaps = g_new0(VFIOMmap, region->nr_mmaps);
>                   region->mmaps[0].offset = 0;
>                   region->mmaps[0].size = region->size;
> +            } else if (ret) {
> +                return ret;
>               }
>           }
>       }


