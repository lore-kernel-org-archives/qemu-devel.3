Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2907EC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 17:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ticm1-0007ft-Lu; Thu, 13 Feb 2025 12:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ticlq-0007dZ-4Z
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:13:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ticln-0008Lp-GI
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:13:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739466775;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxQypIxJ4HK/TSyQYMIsRDfvv4b0zIaiSvT1oa7a3ys=;
 b=AXbqA6zSLewRwmH2uLUfZ/hFAPVGGfYC735kgblbEnDsatAotOu12Z/uLTeps8KbD0PXcg
 lQnYngBha/nl43hA82sZfI7+whKcBMWm5eX4eApGJSDmQlPYCF5sD+dz5qIR+TSfwF4KyA
 3eyYhN0waKZtgm9aEBVuorgvOQkT28g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-WGSLDqT6PiOw2U7Wi1iwkQ-1; Thu, 13 Feb 2025 12:12:53 -0500
X-MC-Unique: WGSLDqT6PiOw2U7Wi1iwkQ-1
X-Mimecast-MFC-AGG-ID: WGSLDqT6PiOw2U7Wi1iwkQ_1739466773
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38dc6aad9f8so1148869f8f.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 09:12:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739466772; x=1740071572;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zxQypIxJ4HK/TSyQYMIsRDfvv4b0zIaiSvT1oa7a3ys=;
 b=CHE02nsbLUt9X5K5fOWwXv4tCJd7cOHRQpCbn1TAWxbmQVoKa/pt+LMlhfCPf1thOT
 bCZapHLkiacH6TNYcZWvYkX4LgA5oCKUE3GspXAkI2UIaXokkr4HRgkAp7ljtZdaNZ4T
 +/7djYMKz3Lqi3CQ+HetjfdZNVoi7+kMruUZOoVXVk+l/AwmYsX5OJ8ryaHfDdpgeUlT
 0+8eXUxCiV3/BJr6pKr/xzqvTKTpffPE6wQSthK7qljbY7+N7blrzeW3Oz1EsTjunTHB
 ETot6+467iUXMWOsLWA+uA2bymw9blVgeG1OPhuWQ+ae8l9ZuTlPod1lQo7nu5sfyMIJ
 CMPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW+ZTPseO1HumNs9tSDTjQGj5g9gadYlLsbsb0aRuOKLmkrkLVrVudZ84eANFgPXXw9+NhKOynOj4w@nongnu.org
X-Gm-Message-State: AOJu0YxgkjOq8qmnLwZXCVHLI5ChOxoqZAU0xGkuq8iYQFCix/CN6f7k
 u7+b8vbopGq7Q1s1dYRb5yRAFSp15NDTDXVR3luCulHIlUcFinAMt0eIOXYj6v/hMdBqtdhS6Fh
 tmjn9QpQDRkZ1gWzl13/MoMgQxWnT9P9O3Qf7lCaP1I+iy22fvT0o
X-Gm-Gg: ASbGnctDXc6X7xCS6uoCeta5gYIB9klGe4O1/Ksr2ruh1UDnJNl9s1wpAhXBqsApRo7
 llvxoHieMrrqZUFQfOFPowoyZwfAS8YeRWAcal3MVI16RTt2tklubpLjWjERF/yM9VEsMn5AMuc
 3xeXeuHgje/Z3T+z1Vt+Mdq8ZkJlDCk72pL+PpPzvxbeo4Lbe2Qtg9a+bxjOTsOIFTawuqIHgNU
 YgiFJEJwbzhkgVP7x1FBak20WJozoWZ/m1fWcBrKkdN7UsN0rGIKw7YdQAHDjVAFVoCUOx6iLWA
 5P44YxE+IUGRmfipe5VNUD3aaZqYkGhREspJt2tyOFS5RGs7p5wj
X-Received: by 2002:a05:6000:1fa7:b0:388:c61d:4415 with SMTP id
 ffacd0b85a97d-38f24f7236bmr4417932f8f.18.1739466772426; 
 Thu, 13 Feb 2025 09:12:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMQfLvg86eVfWFFok8uvvu4KHFRh14/qfBp3koegDBkKbsD7RJO45pZXitfe+2glNFilN48g==
X-Received: by 2002:a05:6000:1fa7:b0:388:c61d:4415 with SMTP id
 ffacd0b85a97d-38f24f7236bmr4417879f8f.18.1739466771964; 
 Thu, 13 Feb 2025 09:12:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f8115sm2394404f8f.92.2025.02.13.09.12.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 09:12:51 -0800 (PST)
Message-ID: <191589e7-69ff-41db-94cd-988c83f623e4@redhat.com>
Date: Thu, 13 Feb 2025 18:12:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hw/arm/virt: Support larger highmem MMIO regions
Content-Language: en-US
To: "Matthew R. Ochs" <mochs@nvidia.com>, qemu-devel@nongnu.org,
 shameerali.kolothum.thodi@huawei.com, nathanc@nvidia.com
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, ddutile@redhat.com,
 nicolinc@nvidia.com, ankita@nvidia.com, philmd@linaro.org, gshan@redhat.com
References: <20250212145457.1899954-1-mochs@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250212145457.1899954-1-mochs@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 2/12/25 3:54 PM, Matthew R. Ochs wrote:
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
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> v4: - Added default size to highmem-mmio-size description
> v3: - Updated highmem-mmio-size description
> v2: - Add unit suffix to example in commit message
>     - Use existing "high memory region" terminology
>     - Resolve minor braces nit
>
>  docs/system/arm/virt.rst |  4 ++++
>  hw/arm/virt.c            | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> index e67e7f0f7c50..6ff1de1ecbba 100644
> --- a/docs/system/arm/virt.rst
> +++ b/docs/system/arm/virt.rst
> @@ -138,6 +138,10 @@ highmem-mmio
>    Set ``on``/``off`` to enable/disable the high memory region for PCI MMIO.
>    The default is ``on``.
>  
> +highmem-mmio-size
> +  Set the high memory region size for PCI MMIO. Must be a power-of-2 and
> +  greater than or equal to the default size (512G).
> +
>  gic-version
>    Specify the version of the Generic Interrupt Controller (GIC) to provide.
>    Valid values are:
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 49eb0355ef0c..d8d62df43f04 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2773,6 +2773,36 @@ static void virt_set_highmem_mmio(Object *obj, bool value, Error **errp)
>      vms->highmem_mmio = value;
>  }
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
> +    extended_memmap[VIRT_HIGH_PCIE_MMIO].size = size;
> +}
>  
>  static bool virt_get_its(Object *obj, Error **errp)
>  {
> @@ -3446,6 +3476,14 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>                                            "Set on/off to enable/disable high "
>                                            "memory region for PCI MMIO");
>  
> +    object_class_property_add(oc, "highmem-mmio-size", "size",
> +                                   virt_get_highmem_mmio_size,
> +                                   virt_set_highmem_mmio_size,
> +                                   NULL, NULL);
> +    object_class_property_set_description(oc, "highmem-mmio-size",
> +                                          "Set the high memory region size "
> +                                          "for PCI MMIO");
> +
>      object_class_property_add_str(oc, "gic-version", virt_get_gic_version,
>                                    virt_set_gic_version);
>      object_class_property_set_description(oc, "gic-version",
Reviewed-by: Eric Auger <eric.auger@redhat.com>

The only nitpick I have is that if you read

static MemMapEntry extended_memmap[] = {
    /* Additional 64 MB redist region (can contain up to 512
redistributors) */
    [VIRT_HIGH_GIC_REDIST2] =   { 0x0, 64 * MiB },
    [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
    /* Second PCIe window */
    [VIRT_HIGH_PCIE_MMIO] =     { 0x0, 512 * GiB },
};
and the above comment, it is not obvious that the HIGH_PCI_MMIO can be
extended by an option. A distracted reader may not get it.

But I don't know if it is worth respinning.

Eric



