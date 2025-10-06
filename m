Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB94CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 08:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5gYh-0008FX-Me; Mon, 06 Oct 2025 04:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v5gYd-0008FA-Db
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 04:26:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v5gYb-0001hV-Sf
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 04:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759739215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wujlEYf8iCcMxRtEeONRlM9Tga9yjEWpT/GH1s+cSv8=;
 b=eYA++QCyhVj6TDIAMDlvByo1Nikjyjge3XW5jLv4y/u2CHbQHo9G/SQQICbGlwrtrQEQun
 UfQRsAQNZi+yYuSRemjv50LTfp2/RvLyTC3H2L02EH4Fs7t4yhhLkMohByjTKtv4WYDFr7
 zz8PUhfELSH2NAWgL5cyZs9MGXmy1EA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-WIrL6j11MUyYnAFQ-XkRNw-1; Mon, 06 Oct 2025 04:26:54 -0400
X-MC-Unique: WIrL6j11MUyYnAFQ-XkRNw-1
X-Mimecast-MFC-AGG-ID: WIrL6j11MUyYnAFQ-XkRNw_1759739213
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4255d025f41so2760489f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 01:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759739213; x=1760344013;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wujlEYf8iCcMxRtEeONRlM9Tga9yjEWpT/GH1s+cSv8=;
 b=CvI1LhD78EGjrAqO2WVPPz+A9UFISOO5JbncvY0noapQYBk5nMDKlZ08u/82Mi7U8n
 UIBydFfooNRBq9BmHZ49hOKSPxoBW72bTnThkGuZWjv2vbYGAFTFz8npCfYsxy3M6avn
 zx4W2lh9tyXFuzpNe/H+uC1EMK9+dKSxxVV/5Xb35zuGKx6niOEGPfV98zc9s4oi8K8B
 0DAVLt6wfy91LXZZB/YcSkX1Qb9ka/dQoVpEcAabK8NoDDnnHQpf22wizMH65udFk2Wc
 s9nuQt3XIDo7ni2p+ZYsWPkf8KHvqRknIG+YnWJrSTHYZb3cpAU6YUbgF18jYxkofVm/
 GLqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0+h9Ga7jnl9cYXHuqAwO2c4PplWtAWWv+mrWBqp+svdUEGoC/ut/9mwbqgAmTsqhhwePQB5cpwJC0@nongnu.org
X-Gm-Message-State: AOJu0YzG6T4o8+B1mXsV9iFPS+Njtc3Y2L9a7VoOm0jXfDWOvC9qbmpt
 lwVFZ7ml1PkmLscmba1dAbrH+nJtgEmCzB6oLb45ONEDLMoasnjbAjZNlg3PSykySAqWgn6+zV+
 LNVWXEYMp1K1Bo1wxS6RGzS9pTpOU781IBHJKXTLZsOZNFszaAZeBzRwq
X-Gm-Gg: ASbGncuKN/efr9lsYo3BJ7/dceQ7WNwEIW7F4eiscMaZP6xTD5VrOpBis3miWm32QFu
 MX+v7n6N696ggxoXYUWO+KS/lcly79wcI7pSRIRfc8iyTbvA5L7t+gy8sJ0OqaOh3ZS0hrFKmoV
 43BoPphvoCWUXdURnF8uXAyNW8uJ6toCCTqBV+JhyCdSZ7eHW1jrwsAk0gb1NN/QkiIk7G76/4m
 osHPCi8JxRumDgWMak0oUAmsPxFKc6+1ciKSmWzg3FDeH0gfEpRYB0A0l5bS6TqAHu9YG7TrCB+
 JXg81lGyYa7ObY5/U2B/kG8WklXnIhwhIlSvNrc2Oq7Pa0nyVIeC5NGPFfwT+WQHg6zxkTJI6Uk
 PLh2INJeq
X-Received: by 2002:a05:6000:2306:b0:3ec:6259:5095 with SMTP id
 ffacd0b85a97d-425671362afmr6479310f8f.12.1759739212868; 
 Mon, 06 Oct 2025 01:26:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnUhdLPeGfTOnvTgcewoN9bIXUOYPPlThLJxpCFZxMjnAT+2bX7ZdgPasTgya9GDFuahOBpQ==
X-Received: by 2002:a05:6000:2306:b0:3ec:6259:5095 with SMTP id
 ffacd0b85a97d-425671362afmr6479298f8f.12.1759739212431; 
 Mon, 06 Oct 2025 01:26:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9703sm20044267f8f.30.2025.10.06.01.26.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 01:26:51 -0700 (PDT)
Message-ID: <4b738e3e-6788-4b28-8bc3-d656d3d4db58@redhat.com>
Date: Mon, 6 Oct 2025 10:26:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/7] vfio/region: Add a helper to get region index from
 memory region
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <20251003234138.85820-5-vivek.kasireddy@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251003234138.85820-5-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hello Vivek,

On 10/4/25 01:35, Vivek Kasireddy wrote:
> Having a way to figure out the region index (or bar) associated
> with a memory region is helpful in various scenarios. For example,
> this capability can be useful in retrieving the region info needed
> for mapping a part of a VFIO region or creating a dmabuf.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/vfio/region.c              | 14 ++++++++++++++
>   include/hw/vfio/vfio-device.h |  2 ++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index b165ab0b93..8837afc97f 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -398,3 +398,17 @@ void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled)
>       trace_vfio_region_mmaps_set_enabled(memory_region_name(region->mem),
>                                           enabled);
>   }
> +
> +int vfio_get_region_index_from_mr(MemoryRegion *mr)
> +{
> +    VFIORegion *region = mr->opaque;
> +
> +    if (mr->ops != &vfio_region_ops) {
> +        mr = mr->container;

May be start the routine with :

     while (mr->container) {
         mr = mr->container;
     }

> +        if (mr->ops != &vfio_region_ops) {
> +            return -1;

I think I would prefer returning a 'VFIORegion *' which should be
NULL in case of error. Looks cleaner.


> +        }
> +	region = mr->opaque;
> +    }
> +    return region->nr;
> +}
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 7e9aed6d3c..bdb106c937 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -277,6 +277,8 @@ bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_t
>   
>   int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
>                                   struct vfio_irq_info *info);
> +
> +int vfio_get_region_index_from_mr(MemoryRegion *mr);
Please add documentation.

Thanks,

C.


>   #endif
>   
>   /* Returns 0 on success, or a negative errno. */


