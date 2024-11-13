Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673F1D462DA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 16:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBGYA-0008Jn-Jg; Wed, 13 Nov 2024 11:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tBGY8-0008HV-Vl
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 11:49:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tBGY7-0000aw-F6
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 11:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731516537;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q5lxgJju3VDJD2N/GXeMJZtK5/RQQ64Bmm3cQ/TKIEo=;
 b=f/jtP7BwhsnIVu4rVrSadLIPKCAHZT1mZ27d1FeEdNXoKMLHBHPgapyXIjQmIR4v2AbGM2
 +SNf14DPaDb7j6CIojTRsLjclsxYe+x2mGHy5J0bEz7KXvyUVvPsiONJqtgPHFcX31zNf8
 LzrD7BhnFQcie0wGWF/O5q0mV85mPAo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-lazXbQoIOFiQiUbgCZERJg-1; Wed, 13 Nov 2024 11:48:56 -0500
X-MC-Unique: lazXbQoIOFiQiUbgCZERJg-1
X-Mimecast-MFC-AGG-ID: lazXbQoIOFiQiUbgCZERJg
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d35062e1fcso110467286d6.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 08:48:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731516536; x=1732121336;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q5lxgJju3VDJD2N/GXeMJZtK5/RQQ64Bmm3cQ/TKIEo=;
 b=TxG3FvxyEVHy4YXQ1Rs9MhL2ix6SRMIKFr/fSCH4Z0cMzGsKSAvBKprZ52Lx9fI8ev
 UK9h6u2lO4CFUJ+qSIIT+dXFTvBa/rYjFzM/ulXGxYWs0uSXzhAlbYqbTjUJXfJ16O0N
 e5K10eU+jUoOl4nX1QXQjOeyHW00ruea19wvZzk4xiRBWJkD1S+fUxmfrRy4hhzeXx66
 9N05AzlsGIMdvqHkteGQjnPFr2y4DLJJ5opyQwN25Lmw1my6rHOmRXPX7tK4h+1CZw6v
 Sa+TwfySEQS6Pf/1+auLFmx6igf9gOeGFkPXuSeboT8VLMjP5SXnqcTyGSQLnju9N86f
 cRyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdOnCRmOjiJRk/MekW6QnDvsG3TDYw6Roh+OyUkRwRnE2zTUH/W3lm1bND6KxF9PYzw9SfOG+t8zu1@nongnu.org
X-Gm-Message-State: AOJu0YzMINur8T2uCU8pS/WmiYk4cCkgYq6g2DNIBKB+s8McUPAy6ApI
 Ycd1jsiuYWnEAotVY5TFlRCxX1NIiVIutdGHsQl52MWB52lvf9SsMGFalxSEjiVQYU9EjnvlzQ1
 Pb9QG+6fS5MbrPseT4QHiabtXctqXM7yTVMLfv/zeFx2MvnY8bvDw
X-Received: by 2002:a05:6214:3987:b0:6ce:34d5:8882 with SMTP id
 6a1803df08f44-6d39e19e2a1mr284192036d6.39.1731516535722; 
 Wed, 13 Nov 2024 08:48:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjEnEsAPyBHLpbwzxknztfmiiU2Cgdkdnx7qjiRQQ561YfYORBB2F5b6kpXWAAeQPVOkB9Eg==
X-Received: by 2002:a05:6214:3987:b0:6ce:34d5:8882 with SMTP id
 6a1803df08f44-6d39e19e2a1mr284191736d6.39.1731516535422; 
 Wed, 13 Nov 2024 08:48:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d3961df2c5sm86079806d6.4.2024.11.13.08.48.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 08:48:54 -0800 (PST)
Message-ID: <f739eaee-4890-45ab-9f8c-f406bdb085cc@redhat.com>
Date: Wed, 13 Nov 2024 17:48:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] hw/arm/virt: Add an SMMU_IO_LEN macro
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-2-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20241108125242.60136-2-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
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

Hi,

On 11/8/24 13:52, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> A following patch will add a new MMIO region for nested SMMU instances.
Nit: Add a new ... is generally preferred I think
>
> This macro will be repeatedly used to set offsets and MMIO sizes in both
> virt and virt-acpi-build.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/virt.c         | 2 +-
>  include/hw/arm/virt.h | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 719e83e6a1..780bcff77c 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -174,7 +174,7 @@ static const MemMapEntry base_memmap[] = {
>      [VIRT_FW_CFG] =             { 0x09020000, 0x00000018 },
>      [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
>      [VIRT_UART1] =              { 0x09040000, 0x00001000 },
> -    [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
> +    [VIRT_SMMU] =               { 0x09050000, SMMU_IO_LEN },
>      [VIRT_PCDIMM_ACPI] =        { 0x09070000, MEMORY_HOTPLUG_IO_LEN },
>      [VIRT_ACPI_GED] =           { 0x09080000, ACPI_GED_EVT_SEL_LEN },
>      [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index ab961bb6a9..46f48fe561 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -47,6 +47,9 @@
>  /* See Linux kernel arch/arm64/include/asm/pvclock-abi.h */
>  #define PVTIME_SIZE_PER_CPU 64
>  
> +/* MMIO region size for SMMUv3 */
> +#define SMMU_IO_LEN 0x20000
> +
>  enum {
>      VIRT_FLASH,
>      VIRT_MEM,


