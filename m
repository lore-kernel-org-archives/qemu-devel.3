Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B20CC02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 05:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfXeT-0007oG-WF; Wed, 05 Feb 2025 00:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tfXeO-0007n2-Lz
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 00:08:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tfXeN-00075v-6L
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 00:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738732114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lYWuJH78uIjdeN05kZXHZ/y58aB8vgywJCx5R5RlS1U=;
 b=g1sDEAh6DfHEtW3l/HmKgf7nDoXcknoOHo4/n6s+BoiaXC6NcYCglnDOLVPb5b+V4jb1F6
 FutllxNoBZ6E3lftpy4QP3KSSiHl+aCy/4xG7VHRb3/JRcnF9RWmd+qzGv/4KX4QlMzgJp
 3p1Zj2/YZpzIfDKHQmzhPhOmkb0Vwi0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-J-RsyJaoOJ-s9XqUZge-sg-1; Wed, 05 Feb 2025 00:08:28 -0500
X-MC-Unique: J-RsyJaoOJ-s9XqUZge-sg-1
X-Mimecast-MFC-AGG-ID: J-RsyJaoOJ-s9XqUZge-sg
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ee86953aeaso11891910a91.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 21:08:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738732108; x=1739336908;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lYWuJH78uIjdeN05kZXHZ/y58aB8vgywJCx5R5RlS1U=;
 b=D6965WfBtnUiJnivG+3jhwcmzQQfhMabGy3DJEmMSdLf9ZwbW0EzHunbAKaXdQ9TrA
 fRrTLnaRaBqHLiWcCbz/zlfb21eJnGvqUVoEZZ6f3U157AzvrYLHxM018PrtU54dra/t
 Ajr7BqYjM+jOLIstfNcUCYj4lgkF3AhSKNt9o1ELtsingYearK3vI4S7Yytabx3XU9xS
 4Zc9WKt3mP3++Zu/GRWvhTNw2L1xWWG+WhETHC0frFmLxdhPODaPp75TaUsRppiU9NMo
 kE+BOOjZ/myIRrlWuN+3ThMuEmH4b/yoLcbvxnxTNXC7mf0I5L1fpWcFbc/qGSyvgOSF
 E33Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeP3HKI9QCXo/QEZfjDZYQIR6aqaX0LB9mhxeXkeFrDd2HoKnmutADmgVcez/LFBBraNB3WLBhg3J7@nongnu.org
X-Gm-Message-State: AOJu0YwC5FNUFg+F43mZTXtBAbM4dNtIJJhwUgP2ZN/XB95qsxb2lZvp
 heA8xManILVvd0dWvoIrY0Awv2/vSHTkrQ4gTpYBty0MPkB5nGCL6yuBrgECxg+eIyjdOSI1gID
 LpepfRlVly71PRtsxs8CcSeuGdBOEPDWoSFDUmmYl9Z3ynt0fM0q9
X-Gm-Gg: ASbGncuh74DevMBzRfaqpP3LswSoZwWoOV7aH/+MGIsZn2SdYLCAvcHN7KMPbz9Ell/
 /ajo4sVIJQdlezQcHovIjwbxVbCVGkGJ0ODPW3HC09cvodcw117AC0ZSAj8yZsVBVz1oUPYapJE
 +VY8RHr5HZrtEgl/fMUuANNpNVX4sl68CHmFr9dgNiEVWTk3WjqL35LQYcB0h0VZbXb9ZoUeOaD
 FfSQauqLQYFkvZWk5kJAkBdxSD8SfBunLfZaz0z59C0kbbnpwybHxXsMbaDCIjfpGlWbHAqNgU6
 mBqdfA==
X-Received: by 2002:a05:6a00:28cc:b0:725:f1b1:cbc5 with SMTP id
 d2e1a72fcca58-730350f96demr2999425b3a.3.1738732107811; 
 Tue, 04 Feb 2025 21:08:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHL4EVXfQs7ldqqSvTneYj0zFp+EBcIFaaBzFXtFT/lffzlrSaryfHflYyNRu2CO1DCfJ5XYw==
X-Received: by 2002:a05:6a00:28cc:b0:725:f1b1:cbc5 with SMTP id
 d2e1a72fcca58-730350f96demr2999400b3a.3.1738732107463; 
 Tue, 04 Feb 2025 21:08:27 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.64])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe631c1f3sm11533598b3a.35.2025.02.04.21.08.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 21:08:26 -0800 (PST)
Message-ID: <04b9198a-9b50-4ad5-8495-8ed4c44aa9eb@redhat.com>
Date: Wed, 5 Feb 2025 15:08:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/arm/virt: Support larger highmem MMIO regions
To: "Matthew R. Ochs" <mochs@nvidia.com>, qemu-devel@nongnu.org,
 shameerali.kolothum.thodi@huawei.com, nathanc@nvidia.com
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, ddutile@redhat.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, ankita@nvidia.com
References: <20250205041918.2340237-1-mochs@nvidia.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250205041918.2340237-1-mochs@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/5/25 2:19 PM, Matthew R. Ochs wrote:
> The MMIO region size required to support virtualized environments with
> large PCI BAR regions can exceed the hardcoded limit configured in QEMU.
> For example, a VM with multiple NVIDIA Grace-Hopper GPUs passed through
> requires more MMIO memory than the amount provided by VIRT_HIGH_PCIE_MMIO
> (currently 512GB). Instead of updating VIRT_HIGH_PCIE_MMIO, introduce a
> new parameter, highmem-mmio-size, that specifies the MMIO size required
> to support the VM configuration.
> 
> Example usage with 1TB MMIO region size:
> 	-machine virt,gic-version=3,highmem-mmio-size=1T
> 
> Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
> ---
> v2: - Add unit suffix to example in commit message
>      - Use existing "high memory region" terminology
>      - Resolve minor braces nit
> 
>   docs/system/arm/virt.rst |  4 ++++
>   hw/arm/virt.c            | 38 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 42 insertions(+)
> 

With the following nitpick addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> index e67e7f0f7c50..f96cf4da2a78 100644
> --- a/docs/system/arm/virt.rst
> +++ b/docs/system/arm/virt.rst
> @@ -138,6 +138,10 @@ highmem-mmio
>     Set ``on``/``off`` to enable/disable the high memory region for PCI MMIO.
>     The default is ``on``.
>   
> +highmem-mmio-size
> +  Set the high memory region size for PCI MMIO. Must be a power-of-2 and
> +  greater than the default size.
> +

The description doesn't match with the code changes because it's acceptable
when the specified size is equal to the default one. I think the description
needs to be improved for this.

>   gic-version
>     Specify the version of the Generic Interrupt Controller (GIC) to provide.
>     Valid values are:
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 49eb0355ef0c..d8d62df43f04 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2773,6 +2773,36 @@ static void virt_set_highmem_mmio(Object *obj, bool value, Error **errp)
>       vms->highmem_mmio = value;
>   }
>   
> +static void virt_get_highmem_mmio_size(Object *obj, Visitor *v, const char *name,
> +                          void *opaque, Error **errp)
> +{
> +    uint64_t size = extended_memmap[VIRT_HIGH_PCIE_MMIO].size;
> +
> +    visit_type_size(v, name, &size, errp);
> +}
> +
> +static void virt_set_highmem_mmio_size(Object *obj, Visitor *v, const char *name,
> +                          void *opaque, Error **errp)
> +{
> +    uint64_t size;
> +
> +    if (!visit_type_size(v, name, &size, errp)) {
> +        return;
> +    }
> +
> +    if (!is_power_of_2(size)) {
> +        error_setg(errp, "highmem_mmio_size is not a power-of-2");
> +        return;
> +    }
> +
> +    if (size < extended_memmap[VIRT_HIGH_PCIE_MMIO].size) {
> +        error_setg(errp, "highmem_mmio_size is less than the default (%lu)",
> +                   extended_memmap[VIRT_HIGH_PCIE_MMIO].size);
> +        return;
> +    }
> +

It's acceptable when the specified size is equal to the default one, slightly
conflicting with the description in docs/system/arm/virt.rst


> +    extended_memmap[VIRT_HIGH_PCIE_MMIO].size = size;
> +}
>   
>   static bool virt_get_its(Object *obj, Error **errp)
>   {
> @@ -3446,6 +3476,14 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>                                             "Set on/off to enable/disable high "
>                                             "memory region for PCI MMIO");
>   
> +    object_class_property_add(oc, "highmem-mmio-size", "size",
> +                                   virt_get_highmem_mmio_size,
> +                                   virt_set_highmem_mmio_size,
> +                                   NULL, NULL);
> +    object_class_property_set_description(oc, "highmem-mmio-size",
> +                                          "Set the high memory region size "
> +                                          "for PCI MMIO");
> +
>       object_class_property_add_str(oc, "gic-version", virt_get_gic_version,
>                                     virt_set_gic_version);
>       object_class_property_set_description(oc, "gic-version",

Thanks,
Gavin


