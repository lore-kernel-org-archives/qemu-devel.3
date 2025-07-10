Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F9CC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 14:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZs0E-0001oj-FL; Thu, 10 Jul 2025 10:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZrop-0001cZ-4x
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZrok-0001li-Jr
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752156004;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dJjCigvybdlnEXFGMz7Rl4+7KN0wofLnw82pLSmmup0=;
 b=DOCgwvT7hdz3IVtSgc812RjDU4fiGxO3utT6jegcWFrk1Ai9fGm5R9+jBngTfxE1G0d3ZM
 r5hHj3GUre+xJJAQGo5dVWBFieFIePj1RsWwMA3LEBZ+R0eCG7CMtGt6MYTFNw2JuR/eLn
 HlYbhCulSPY54wneF6hP8woBLLnbOwo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-QTIrJ_xCPXm1R9Q9z2vlKQ-1; Thu, 10 Jul 2025 10:00:02 -0400
X-MC-Unique: QTIrJ_xCPXm1R9Q9z2vlKQ-1
X-Mimecast-MFC-AGG-ID: QTIrJ_xCPXm1R9Q9z2vlKQ_1752156002
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-453691d0a1dso7029755e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 07:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752156001; x=1752760801;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dJjCigvybdlnEXFGMz7Rl4+7KN0wofLnw82pLSmmup0=;
 b=U/yMzm5DX+mGTQGe3fZAAWUNJikvPHTVN1rEFPNPS55Gl6BlI0/Yb6ohhdGQicHuQX
 Ez03+aMIU1UWoIxzQW9diLnvHESyLVOb0wzhhgrwYsYbeIDufP1D8vTmLEVAwKvV8jxF
 jmGQ3NeScOevE4KVoBTvnZj+soG+2cjxfl58n+IhsB4DSzAJJJLMyetm8zl98nFjxt2O
 UGf3YV9m4qQzHZ1AFrNk5D5LP7bS8pDybl/rfP1hIt0WLd7MaI6s1rUYe44Cz95I8Ch8
 ICogRF/Cxhv/W8ROwnzR0dKgWkhsH96sRF/uh0fjf4RI4PQ5yieEWKvqz/519wkkNOhL
 uIEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvMsv+DhS4DUDi1YwI132HvQQJtcwCRWBRFUeZmy3P5EfVz0FzqHkWmZ7pgEvSsLkkpaTcCNdFQvfR@nongnu.org
X-Gm-Message-State: AOJu0YzWv7Qcf07Jv4tRmDb+cQ2Ja1aONbZ+/4jfkZ2TlOz+9mGeze4I
 i2cJNRara6Z9FSj+VjrKztdK/NDNoU3faivD1DUc8ZBXjhUxuVViTgl+NisVIxs5Ye3QHAYUFEY
 FXrftDjwAEZefDo6n3LRUGjr7IgMRgCIit9cXXBKounky4i66aSnzfse5
X-Gm-Gg: ASbGncsmQ6Ivwo8sDwwdeW2hJjs/87+nfLH87GOkw6wa3ygCZH+Ct+k1PpoNRNg7W+o
 D8vyjKW6dCl2IptLVBXbji7SpRFh1Xeu0ap5qetZIEKxU5caKZ1x2V1m4dXipScWK65+kkL1Uhg
 cQbNFrmG6leTfqBWsCZooj6xM3Q69pWonzsiHZd16u+n/jvHfYRZNpOgz7lYejLnwrnbccKddbm
 2MvWrq40AdkObmq0G2Hmw70yU6WbWGCEQZ/y3zFncVnqQ9IyCoKAtDJaG1/sZeseqe3tLPJwgyQ
 Tmxmtc2B47XH08hBRfLfH0u5uwFYw4eTT2gbZcbtGE2UK9VpfPsxBT/1Av39PQ8F7YAkOA==
X-Received: by 2002:a05:600c:5296:b0:441:b19c:96fe with SMTP id
 5b1f17b1804b1-454dd2024c7mr34396755e9.10.1752156001529; 
 Thu, 10 Jul 2025 07:00:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm6FJrN/XV0uH6Miy8mhfVKCYdwhMYe+goTFW+Md2g6U7wm4W5fSiqezOPS50N/lxRz0UROA==
X-Received: by 2002:a05:600c:5296:b0:441:b19c:96fe with SMTP id
 5b1f17b1804b1-454dd2024c7mr34396325e9.10.1752156001066; 
 Thu, 10 Jul 2025 07:00:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd537932sm20756575e9.20.2025.07.10.06.59.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 07:00:00 -0700 (PDT)
Message-ID: <61464e90-9be3-4be5-a0af-ab15b92776e5@redhat.com>
Date: Thu, 10 Jul 2025 15:59:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/12] hw/arm/virt-acpi-build: Don't create ITS id
 mappings by default
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, imammedo@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 gustavo.romero@linaro.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 linuxarm@huawei.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
 <20250708154055.101012-2-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250708154055.101012-2-shameerali.kolothum.thodi@huawei.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Peter,

On 7/8/25 5:40 PM, Shameer Kolothum wrote:
> Commit d6afe18b7242 ("hw/arm/virt-acpi-build: Fix ACPI IORT and MADT tables
> when its=off") moved ITS group node generation under the its=on condition.
> However, it still creates rc_its_idmaps unconditionally, which results in
> duplicate ID mappings in the IORT table.
>
> Fixes:d6afe18b7242 ("hw/arm/virt-acpi-build: Fix ACPI IORT and MADT tables when its=off")

At least please could you take this fix?

Thanks

Eric
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Donald Dutile <ddutile@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/virt-acpi-build.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index cd90c47976..724fad5ffa 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -329,12 +329,6 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          /* Sort the smmu idmap by input_base */
>          g_array_sort(rc_smmu_idmaps, iort_idmap_compare);
>  
> -        /*
> -         * Knowing the ID ranges from the RC to the SMMU, it's possible to
> -         * determine the ID ranges from RC that are directed to the ITS.
> -         */
> -        create_rc_its_idmaps(rc_its_idmaps, rc_smmu_idmaps);
> -
>          nb_nodes = 2; /* RC and SMMUv3 */
>          rc_mapping_count = rc_smmu_idmaps->len;
>  


