Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6A2CD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPyc5-00006m-7a; Thu, 21 May 2026 04:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPyc3-00005f-DS
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:18:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPyc1-00047z-7r
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779351516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HNeJVZ1Rc6A7hrZJ52mZsN822mJ/FP2TSqTjK4PmuOs=;
 b=EwPgHL1MN7Cl64Y9DQT/cLazDCF9hnNs0geZd+nb3JPNMRLkClCn2ao7oFI9nZSgYOYjt+
 o9vO1gRdmgD4E/rcIuKuud3TX9TzJemm48l4z689KFXoulWhaf8YKzCh0nTI0FtLMnf35m
 hD+gTaPOGvSIIY6i5/oBoZrWdyovohY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-shIqCSlbOb6Z-Lfxre3Ezg-1; Thu, 21 May 2026 04:18:35 -0400
X-MC-Unique: shIqCSlbOb6Z-Lfxre3Ezg-1
X-Mimecast-MFC-AGG-ID: shIqCSlbOb6Z-Lfxre3Ezg_1779351514
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48feb029961so33054085e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 01:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779351514; x=1779956314; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HNeJVZ1Rc6A7hrZJ52mZsN822mJ/FP2TSqTjK4PmuOs=;
 b=PCrkEidttLBFW5ydcA9e/lNWeVS1UwOn8jaT7AmjpRXGc0asNsM9JmO11rwi9Kt1yb
 uynHESXvozKf6ZsACaJkP9xm+8eWFBVmUfiUZme+wcnNUVTp/ydxfD9i2a1BGBhS2sOO
 Y62P75JME/I4/OA9iFrK4z7Q0HYsj64L4bpH1Da113+kf7BKlK0hjAzIrSfx2qY17kVH
 Zb/r6E5gU/O7HkqIDjwGdH5gLOpouLg1jOUlPUhg8HIrGcorjxmjb+IWjL1EWVPd5c7B
 U0oXMWZgzAtIfDbDYPn4i1fJ6tywpn/7iP0vBAPzrlko1mfuU6oCiibBHzvrW4JrDzq3
 k7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779351514; x=1779956314;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HNeJVZ1Rc6A7hrZJ52mZsN822mJ/FP2TSqTjK4PmuOs=;
 b=YH+ezBwYaZkiRtFLP0VF4Tzpt05ALtUqRy3mlrFRh492ZlsNrtB1RcI1OfJRBKZ0qp
 fbBeSOOyX63tUC8a7icIg9re+tiFz8M7XAiJSsPXZOsBFZK/fh7orhn1Ko2AdNBurZ8f
 XAGhq5i1ScNQ0of1lN9VJ0z1rVsDO5ta+raQlk0Is0b1m6A5k/3OQ3MR8Q3K1NJ2b2mY
 QMKdLnd3wT46DJwnB3pv0WCe1aQ0ije9wjTK/2fJyFgTC+KBZFbFVnUbuCium92kwoZ7
 4Py6GOctJivg/KD4RasUgs7M7zos/FCbtDJi+uQxkPaHO7fPAaasATD7U1cVPYXUi/Ad
 khhw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ioY0BY9QXKJDms1Qnmx5MidoYWxrRIdVV/yRvdZStywRgGdnfWlNLE/5ez6wbk05Lm8K2vS6vEjFa@nongnu.org
X-Gm-Message-State: AOJu0YwHE3+tG+TZjif4PuwLBMuxTu0s+OqOK49w22Yn//3JIqOzPJdf
 cAC06vnZcKv0FSV2tKE4h1jOd6+hXDNraYOHVhEu9Dszw/2R+XByVapsSe4oRoJ1GLt2XF45T2v
 QYYpPV/kh5M4ohiSoF2iSArckb5HOq8+RIZYdzWqLQxTqNhzZklh1vOaR
X-Gm-Gg: Acq92OGB8+DQKZFawx4ZFFbYKXN3UaoAwFnFa4AwCiCB210m1l7tH0YAfjm1zck/Rbk
 m3usdiqgAEuJBbIAfXYmpag+aSsbTRFsiYzoPNm33pU2Y6Kg63k8aseDvLMRUTHVRsPsrvGq7IR
 7msG+DJJ16HnLnpiGEdIE0m3XhMJmCgykPNDqrqjdbxeLZBDrzrr5gYb5TXHAXr9MeuVOLNxui5
 DF9M7ctLC+KLE15rGHcgaPbI9V2RATibVrYfZcy3ljoaOfR+qxbBse14K0EHx8bgcBvpMI/xMO2
 MrY2IP58tkEJU1EhWN20tXXBVanjIfINAFsd4T3rmGq3mV342aJrrU5qaFIrc+SChun2nS+hWdU
 IRr6vJeG3PjC7Qq4tFzpmIiqYHjL+CDgadVjQnxjhTocw5tESNA9kQAhVvGrO
X-Received: by 2002:a05:600c:8596:b0:48a:5339:ef0e with SMTP id
 5b1f17b1804b1-4903604ccb3mr20228245e9.3.1779351513653; 
 Thu, 21 May 2026 01:18:33 -0700 (PDT)
X-Received: by 2002:a05:600c:8596:b0:48a:5339:ef0e with SMTP id
 5b1f17b1804b1-4903604ccb3mr20227625e9.3.1779351513136; 
 Thu, 21 May 2026 01:18:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035eec6casm10704715e9.33.2026.05.21.01.18.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 01:18:32 -0700 (PDT)
Message-ID: <4a2e8fe9-b20a-421d-adaf-8d8cbb270c44@redhat.com>
Date: Thu, 21 May 2026 10:18:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/32] hw/arm/tegra241-cmdqv: Implement CMDQV init
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, zhenzhong.duan@intel.com, kjaju@nvidia.com,
 phrdina@redhat.com
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-12-skolothumtho@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260519103727.899332-12-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Shameer,

On 5/19/26 12:36, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> Tegra241 CMDQV extends SMMUv3 with support for virtual command queues
> (VCMDQs) exposed via a CMDQV MMIO region. The CMDQV MMIO space is split
> into 64KB pages:
> 
> 0x00000  (CMDQ-V Config page)
> 0x10000  (CMDQ-V CMDQ Page0)
> 0x20000  (CMDQ-V CMDQ Page1)
> 0x30000  (Virtual Interface Page0)
> 0x40000  (Virtual Interface Page1)
> 
> This patch wires up the Tegra241 CMDQV init callback and allocates
> vendor-specific CMDQV state. The state pointer is stored in
> SMMUv3AccelState for use by subsequent CMDQV operations.
> 
> The CMDQV MMIO region and a dedicated IRQ line are registered with the
> SMMUv3 device. The MMIO read/write handlers are currently stubs and will
> be implemented in later patches.
> 
> The CMDQV interrupt is edge-triggered and indicates VCMDQ or VINTF
> error conditions. This patch only registers the IRQ line. Interrupt
> generation and propagation to the guest will be added in a subsequent
> patch.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   hw/arm/smmuv3-accel.h   |  1 +
>   hw/arm/tegra241-cmdqv.h | 18 ++++++++++++++++++
>   hw/arm/tegra241-cmdqv.c | 38 ++++++++++++++++++++++++++++++++++++--
>   3 files changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index f82a7112d8..49c10535cf 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -62,6 +62,7 @@ typedef struct SMMUv3AccelState {
>       bool auto_mode;
>       bool auto_finalised;
>       const SMMUv3AccelCmdqvOps *cmdqv_ops;
> +    void *cmdqv;  /* vendor specific CMDQV state */
>   } SMMUv3AccelState;
>   
>   typedef struct SMMUS1Hwpt {
> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> index 38c8b27b4d..030f5758d5 100644
> --- a/hw/arm/tegra241-cmdqv.h
> +++ b/hw/arm/tegra241-cmdqv.h
> @@ -14,6 +14,24 @@
>   #define CMDQV_NUM_CMDQ_LOG2       1
>   #define CMDQV_NUM_SID_PER_VI_LOG2 4
>   
> +/*
> + * Tegra241 CMDQV MMIO layout (64KB pages)
> + *
> + * 0x00000  (CMDQ-V Config page)
> + * 0x10000  (CMDQ-V CMDQ Page0)
> + * 0x20000  (CMDQ-V CMDQ Page1)
> + * 0x30000  (Virtual Interface Page0)
> + * 0x40000  (Virtual Interface Page1)
> + */
> +#define TEGRA241_CMDQV_IO_LEN 0x50000
> +
> +typedef struct Tegra241CMDQV {
> +    struct iommu_viommu_tegra241_cmdqv cmdqv_data;

This won't build on Windows.

C.


> +    SMMUv3AccelState *s_accel;
> +    MemoryRegion mmio_cmdqv;
> +    qemu_irq irq;
> +} Tegra241CMDQV;
> +
>   const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
>   
>   #endif /* HW_ARM_TEGRA241_CMDQV_H */
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index 3a19a1af56..298671e0ce 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -13,6 +13,16 @@
>   #include "smmuv3-accel.h"
>   #include "tegra241-cmdqv.h"
>   
> +static uint64_t tegra241_cmdqv_read_mmio(void *opaque, hwaddr offset, unsigned size)
> +{
> +    return 0;
> +}
> +
> +static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset, uint64_t value,
> +                                 unsigned size)
> +{
> +}
> +
>   static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
>   {
>   }
> @@ -29,10 +39,34 @@ static void tegra241_cmdqv_reset(SMMUv3State *s)
>   {
>   }
>   
> +static const MemoryRegionOps mmio_cmdqv_ops = {
> +    .read = tegra241_cmdqv_read_mmio,
> +    .write = tegra241_cmdqv_write_mmio,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,
> +    },
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,
> +    },
> +};
> +
>   static bool tegra241_cmdqv_init(SMMUv3State *s, Error **errp)
>   {
> -    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
> -    return false;
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(OBJECT(s));
> +    SMMUv3AccelState *accel = s->s_accel;
> +    Tegra241CMDQV *cmdqv;
> +
> +    cmdqv = g_new0(Tegra241CMDQV, 1);
> +    memory_region_init_io(&cmdqv->mmio_cmdqv, OBJECT(s), &mmio_cmdqv_ops, cmdqv,
> +                          "tegra241-cmdqv", TEGRA241_CMDQV_IO_LEN);
> +    sysbus_init_mmio(sbd, &cmdqv->mmio_cmdqv);
> +    sysbus_init_irq(sbd, &cmdqv->irq);
> +    cmdqv->s_accel = accel;
> +    accel->cmdqv = cmdqv;
> +    return true;
>   }
>   
>   static bool tegra241_cmdqv_probe(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,


