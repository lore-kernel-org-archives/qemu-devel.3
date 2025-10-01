Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94FDCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 17:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v40lH-0003bN-Lc; Wed, 01 Oct 2025 13:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v40lF-0003ak-IE
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:37:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v40l9-0007IV-S0
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759340212;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SczcoZ+B4fjrzbEuu24OKPudGjmNTcouKaDLvnATr+E=;
 b=T2vbsYsddVn4LGZVKtrlkCjGopw1ZevznLY8vcGwaPdHR+NxICWjOcDcEmMNvu3gJ5gIhY
 AdGMC0sRsRngETdaRXUPBU2IbpzmzMVvKxbxyeBXSpDyE8dodG/kEHxmQ6PKuxsDuLH5la
 KinBffvdl2EVpL8f8MP7JWPxaXQSQi8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-VwbOwlEoM1eNhrA0sygEJw-1; Wed, 01 Oct 2025 13:36:51 -0400
X-MC-Unique: VwbOwlEoM1eNhrA0sygEJw-1
X-Mimecast-MFC-AGG-ID: VwbOwlEoM1eNhrA0sygEJw_1759340210
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e3d43bbc7so167505e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 10:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759340210; x=1759945010;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SczcoZ+B4fjrzbEuu24OKPudGjmNTcouKaDLvnATr+E=;
 b=KEi9Bqwou2x4xoOSnV5vTxQB6AF/0Zo0sxq340WmqRSQb52iSBmKDQLU2Eu8mxhs7K
 /DgRRWth+p0rcGLCNHyKJCaiHXxwUjnmt5XyHwGzuvKhj67xSin8lWMjd+/2HuBe5RCe
 svXG1jB9iljD3Sn7QtdJQkJkPXgdo8ebcefvfaCuYy51hjGzuwx7erx6ooIpjoy3BcxX
 z2ODFbh6zbJy9Du8z8U24rP8vVoTpw9Y2wzByXGFL8Rh28gb/aYUCFT5zMG1SvgkTP/8
 6Ih30oVpkOPytIj6FmD3Tx/Sr/XTIoqS9BkPIeUaiUdBpumfn1S0XiiWQYksW9k3fjVz
 Cv1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUIx5EIivGmwX/inZkguyyvP5HKnM54Gxr9VzHkDMoUyltEgIMd6QD/jc2Pv8IHemAo20Ej1gapvd+@nongnu.org
X-Gm-Message-State: AOJu0YzBBleAbDR8CCByYdk0ayz2s7jnO90lQOTRSSY1OXN1P0ff0ZQJ
 /PNR6ivzsNK3yrP5nrXZzU9zmZqUhnx2c7DdVF526pUwwoaoHlhzcKmvPyFUAPCs2TvyPJzKKNx
 eSPKreL9ftPq8dmCvJSDGS3Lmdz7INNeEEsqh5w4+qlquh8qWx2roKPQJ
X-Gm-Gg: ASbGncsOGOglD0fF7X3m+IRRgP1Sg+Inrp0PIBrhsEgj1MQGQHV1BmLTuxPWLFf9tLs
 K2ZndnD9TA9jlM9lcjmTDZF1m7OuoDXdNyjjzU+RFdsjelhjBOo1pTa9k5RhpC9BMdBYpmQsWaU
 926wMzI9cuCm7NEXHLz0gQKojMuxAdAUmdcvMEfOrL29VTuaZdvle8nqhakP/uyOOlxcm451hvZ
 shf07wezC1b+s2F8M3AiIK3QYs+Q8y1HMuq0v4uqqGUSGnukRkM0KZRPkOnr6GKEI0dCsdrmVD/
 sP4xxUnmMLmevhwNjKRpeJqKsvgTjwj16rFDNJNhV0rxhzQxUbgFbsUUpbM4d1x8VOvyNNaQACu
 lYdNSwoRlQHA5c/qO
X-Received: by 2002:a05:600c:474b:b0:46e:32d4:46a1 with SMTP id
 5b1f17b1804b1-46e612be13bmr33378305e9.22.1759340209806; 
 Wed, 01 Oct 2025 10:36:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpk5EnNtkWNmMtaEMiiHy4RokR5z+G8SPBlYEhurelSWjVzav97Qvz7vHTmSW8Uk7JIv7t2g==
X-Received: by 2002:a05:600c:474b:b0:46e:32d4:46a1 with SMTP id
 5b1f17b1804b1-46e612be13bmr33378135e9.22.1759340209377; 
 Wed, 01 Oct 2025 10:36:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619c3ac3sm49635755e9.9.2025.10.01.10.36.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 10:36:48 -0700 (PDT)
Message-ID: <55de40c2-7d33-4806-8eb0-e4dde8d0c84f@redhat.com>
Date: Wed, 1 Oct 2025 19:36:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/27] hw/arm/smmuv3: Implement get_viommu_cap()
 callback
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 shameerkolothum@gmail.com
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-8-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250929133643.38961-8-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 9/29/25 3:36 PM, Shameer Kolothum wrote:
> For accelerated SMMUv3, we need nested parent domain creation. Add the
> callback support so that VFIO can create a nested parent.
>
> In the accelerated SMMUv3 case, the host SMMUv3 is configured in nested
> mode (S1 + S2), and the guest owns the Stage-1 page table. Therefore, we
> expose only Stage-1 to the guest to ensure it uses the correct page-table
> format.
>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Wonder if you shall keep both. I don't know the usage though but worth
to check.
> ---
>  hw/arm/smmuv3-accel.c | 13 +++++++++++++
>  hw/arm/virt.c         | 13 +++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 44410cfb2a..6b0e512d86 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -10,6 +10,7 @@
>  #include "qemu/error-report.h"
>  
>  #include "hw/arm/smmuv3.h"
> +#include "hw/iommu.h"
>  #include "hw/pci/pci_bridge.h"
>  #include "hw/pci-host/gpex.h"
>  #include "hw/vfio/pci.h"
> @@ -106,8 +107,20 @@ static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
>      }
>  }
>  
> +static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
> +{
> +    /*
> +     * We return VIOMMU_FLAG_WANT_NESTING_PARENT to inform VFIO core to create a
> +     * nesting parent which is required for accelerated SMMUv3 support.
> +     * The real HW nested support should be reported from host SMMUv3 and if
> +     * it doesn't, the nesting parent allocation will fail anyway in VFIO core.
> +     */
> +    return VIOMMU_FLAG_WANT_NESTING_PARENT;
> +}
> +
>  static const PCIIOMMUOps smmuv3_accel_ops = {
>      .get_address_space = smmuv3_accel_find_add_as,
> +    .get_viommu_flags = smmuv3_accel_get_viommu_flags,
>  };
>  
>  void smmuv3_accel_init(SMMUv3State *s)
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 02209fadcf..b533b0556e 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3073,6 +3073,19 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>                  return;
>              }
>  
> +            if (object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
This looks unrelated to the get_viommu_flags() addition and to me this
shall be put in a separate patch of squashed in the patch that exposes
the accel prop Thanks Eric
> +                char *stage;
> +
> +                stage = object_property_get_str(OBJECT(dev), "stage",
> +                                                &error_fatal);
> +                /* If no stage specified, SMMUv3 will default to stage 1 */
> +                if (*stage && strcmp("1", stage)) {
> +                    error_setg(errp, "Only stage1 is supported for SMMUV3 with "
> +                               "accel=on");
> +                    return;
> +                }
> +            }
> +
>              create_smmuv3_dev_dtb(vms, dev, bus);
>          }
>      }


