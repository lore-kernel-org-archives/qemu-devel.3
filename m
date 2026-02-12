Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D220EEE368C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 15:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqYMO-0003rw-13; Thu, 12 Feb 2026 10:12:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqYMI-0003pK-J0
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:11:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqYMF-0005DM-WC
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:11:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770909114;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kED5riT/5oS+OfxnKqCYvLTgxzkHr6ekjx7QdiJnrbk=;
 b=Nvtul7P7ANWM6V5jHcVRyw631dP6MhKCMz0AXVMyWxZ5TlD54TuqPC5ThiN0sUNSe2Zpy9
 8fcwuKsAcO6J91yOlbjG/lp+PtYGuQE0nGZ5pVQm0RyI/dvxEsqe208nRiRtdnhGoUfor/
 ZhP4aR1CAr5GxVPgtFNk/nf6t3FwMlc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-RIXXp23PMJ-T1-htJ6QSWw-1; Thu, 12 Feb 2026 10:11:52 -0500
X-MC-Unique: RIXXp23PMJ-T1-htJ6QSWw-1
X-Mimecast-MFC-AGG-ID: RIXXp23PMJ-T1-htJ6QSWw_1770909112
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48071615686so28547015e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 07:11:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770909111; x=1771513911;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kED5riT/5oS+OfxnKqCYvLTgxzkHr6ekjx7QdiJnrbk=;
 b=fHsBzq6+9cHONlsei2uhqAnc891pRgbRU9IC/hyoFCnCqIugcfLGTbLEwljahxJi+b
 UUhoJirlwM3wJl2NCrbeUEUTVcCTAMsa+FlcBZfBQra2OKTE6IgID34uGOBen6wSwn3o
 Llh53dAmidllV5X2Bblpc8G5+A2k1PvpNDa+EB6sfYuf1Wh/sdsXoMCbEAho0mIxz9gc
 He7KBumWBTC+utgcL4y9E7UzQJO9rnkBWFxh1tmSHuhoErjb2VIMSfGDK91D7GgUc3lX
 FM2c6moUE10rluk6S6qaSiC0l1K+COx1LIhTiW/si5hAMtviEqBxaxjj5VdBUYVQLu1T
 i9yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyRjiyZnfM6Vk8aghQC2RL3aczrrq0dss2i9nFQ+IiDS70HmZm07h53oKqxwAfu1SqUN7B92VbrrY7@nongnu.org
X-Gm-Message-State: AOJu0Yxj5cM9go23uC7Sm64hukNGlt7tTE41/xJY2IgUYhurt07yRwnL
 Xbz/C4keeMwjxY3ErWl6qF8Q8L1d7ODA2sV1a1XgLPv6SNV7t5l86pyCYoa0vOWMgZn+RbCnJjM
 JghCy1x9UCZ5bqI2vzMJgVI5sWzLxeoXcBe94bLk/sTBSk7Ih85Vae8fZ
X-Gm-Gg: AZuq6aJM+W/qCRxiol9+WaV61KaFBIGeVAS5DiBXBiHiBSRAQ8r288wMkGJLdm0RWY7
 +rniIivJHR7tsvPTXnXo7JLBzHJOzFb80AsIC9H5SZYymoUNfbND5bXk6oimby/MX374CIrbM1P
 ccYOIZgBHv9L/Z4KE6wqLHICAGK0f/VT+CXIIt0VBKUs57vDLbYMamf10ELe8F5WibiDVtMsBHc
 2Oh3jVjNbk1U5DSYFx+E8U6Skrch6zrJM0EoVKdfscTS3DtrreF5BxoVfUnKbbgTpCT2LZS4XPK
 qURgwQ0iGVQtFFe6Eg5lnj5IWTJsGMNV8e/liA/IhCSPKuX/F+RNoF5FIYmYJVRNZAhOChsXjnL
 rJWW1INQiSVa2t+j2CScMvOEcvtxBzcwagPl8+CRLpadELXhe97h+3uNsb3Esw30EL53Ffg==
X-Received: by 2002:a05:600d:486:10b0:483:6a8d:b2f9 with SMTP id
 5b1f17b1804b1-4836a8db4f0mr27682695e9.5.1770909111458; 
 Thu, 12 Feb 2026 07:11:51 -0800 (PST)
X-Received: by 2002:a05:600d:486:10b0:483:6a8d:b2f9 with SMTP id
 5b1f17b1804b1-4836a8db4f0mr27682155e9.5.1770909111054; 
 Thu, 12 Feb 2026 07:11:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d92267bsm170571175e9.0.2026.02.12.07.11.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 07:11:50 -0800 (PST)
Message-ID: <f07268f3-0e4b-480a-bc8a-cfa18cf753ed@redhat.com>
Date: Thu, 12 Feb 2026 16:11:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/24] hw/arm/tegra241-cmdqv: Implement CMDQV init and
 vIOMMU allocation
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-9-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260206144823.80655-9-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 2/6/26 3:48 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Add initial Tegra241 CMDQV support by wiring up initialization and
> IOMMUFD backed vIOMMU allocation. The CMDQV MMIO region and IRQ are
> registered, while register handling remains a stub and will be completed
> in subsequent patches.

Explain what the MMIO region is made of (see below). Also describe what
the interrupt is used for. what kind of interrupt is it? Also a work
about the state (data)?
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.c | 55 ++++++++++++++++++++++++++++++++++++++---
>  hw/arm/tegra241-cmdqv.h | 19 ++++++++++++++
>  2 files changed, 70 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index 6f30ca035b..596b1c5595 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -13,6 +13,16 @@
>  #include "smmuv3-accel.h"
>  #include "tegra241-cmdqv.h"
>  
> +static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    return 0;
> +}
> +
> +static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
> +                                 unsigned size)
> +{
> +}
> +
>  static void tegra241_cmdqv_free_veventq(SMMUv3State *s)
>  {
>  }
> @@ -25,24 +35,61 @@ static bool tegra241_cmdqv_alloc_veventq(SMMUv3State *s, Error **errp)
>  
>  static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
>  {
> +    SMMUv3AccelState *accel = s->s_accel;
> +    IOMMUFDViommu *viommu = accel->viommu;
> +
> +    if (!viommu) {
> +        return;
> +    }
> +    iommufd_backend_free_id(viommu->iommufd, viommu->viommu_id);
>  }
>  
>  static bool
>  tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>                              uint32_t *out_viommu_id, Error **errp)
>  {
> -    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
> -    return false;
> +    Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
> +
> +    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
> +                                      IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
> +                                      idev->hwpt_id, &cmdqv->cmdqv_data,
> +                                      sizeof(cmdqv->cmdqv_data), out_viommu_id,
> +                                      errp)) {
> +        error_append_hint(errp, "Tegra241 CMDQV support unavailable");
> +        return false;
> +    }
> +    return true;
>  }
>  
>  static void tegra241_cmdqv_reset(SMMUv3State *s)
>  {
>  }
>  
> +static const MemoryRegionOps mmio_cmdqv_ops = {
> +    .read = tegra241_cmdqv_read,
> +    .write = tegra241_cmdqv_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
>  static bool tegra241_cmdqv_init(SMMUv3State *s, Error **errp)
>  {
> -    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
> -    return false;
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(OBJECT(s));
> +    SMMUv3AccelState *accel = s->s_accel;
> +    Tegra241CMDQV *cmdqv;
> +
> +    if (!accel) {
> +        error_setg(errp, "Tegra241 CMDQV requires SMMUv3 acceleration");
> +        return false;
> +    }
> +
> +    cmdqv = g_new0(Tegra241CMDQV, 1);
> +    memory_region_init_io(&cmdqv->mmio_cmdqv, OBJECT(s), &mmio_cmdqv_ops, cmdqv,
> +                          "tegra241-cmdqv", TEGRA241_CMDQV_IO_LEN);
> +    sysbus_init_mmio(sbd, &cmdqv->mmio_cmdqv);
> +    sysbus_init_irq(sbd, &cmdqv->irq);
> +    cmdqv->s_accel = accel;
> +    accel->cmdqv = cmdqv;
> +    return true;
>  }
>  
>  static const SMMUv3AccelCmdqvOps tegra241_cmdqv_ops_impl = {
> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> index 81c9deb384..6ea0087f61 100644
> --- a/hw/arm/tegra241-cmdqv.h
> +++ b/hw/arm/tegra241-cmdqv.h
> @@ -10,8 +10,27 @@
>  #ifndef HW_TEGRA241_CMDQV_H
>  #define HW_TEGRA241_CMDQV_H
>  
> +#include "smmuv3-accel.h"
>  #include CONFIG_DEVICES
>  
> +/*
> + * Tegra241 CMDQV MMIO layout (64KB pages):
> + *
> + * 0x00000: Global CMDQV registers
I would use the spec terminology, something like

TEGRA241_CMDQV_CFG TEGRA241_CMDQV_VCMDQ0
TEGRA241_CMDQV_VCMDQ1 TEGRA241_CMDQV_VINTF0
TEGRA241_CMDQV_VINTF1 Eric



> + * 0x10000: Global VCMDQ registers, page 0
> + * 0x20000: Global VCMDQ registers, page 1
> + * 0x30000: VINTF0 logical VCMDQ registers, page 0
> + * 0x40000: VINTF0 logical VCMDQ registers, page 1
> + */
> +#define TEGRA241_CMDQV_IO_LEN 0x50000
> +
> +typedef struct Tegra241CMDQV {
> +    struct iommu_viommu_tegra241_cmdqv cmdqv_data;
> +    SMMUv3AccelState *s_accel;
> +    MemoryRegion mmio_cmdqv;
> +    qemu_irq irq;
> +} Tegra241CMDQV;
> +
>  #ifdef CONFIG_TEGRA241_CMDQV
>  const SMMUv3AccelCmdqvOps *tegra241_cmdqv_ops(void);
>  #else


