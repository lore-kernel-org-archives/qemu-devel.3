Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE04BCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 10:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4GBa-0006Ro-2L; Thu, 02 Oct 2025 06:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v4GBY-0006Ql-2p
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 06:05:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v4GBI-0008Cu-5a
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 06:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759399492;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RKiYuSV/95hQkf3qst5VRJsfohuT/o16gSdFeG3UEac=;
 b=JI2xR/KaDcd/SiR8hMrpkc6Ua3pefLxEKT+jrIe5zt7Fi9crf5mHshHGhMmGwzZsRncip6
 gVEerEHFwzxp6xLC7tH8Y9/er8EG03Fzd7wy6xzRUJ8jctLkotnCDsFowDCGKAd0/BNse1
 m7gWCvv/HGnYG0D4llwlZA8f3MNOpe8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-QQ4YVWcGNea2NVYpmB9Ugw-1; Thu, 02 Oct 2025 06:04:51 -0400
X-MC-Unique: QQ4YVWcGNea2NVYpmB9Ugw-1
X-Mimecast-MFC-AGG-ID: QQ4YVWcGNea2NVYpmB9Ugw_1759399490
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e407c600eso4206575e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 03:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759399490; x=1760004290;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RKiYuSV/95hQkf3qst5VRJsfohuT/o16gSdFeG3UEac=;
 b=wslrLqnYBqKuvSReqyytguUD+B63ReXh6thpAqOkgruZA6BmAaNeCZ+DVi3HOh2xJI
 NliBzz0XXeetwEG8O/JOTfo3xSv+hFlGOmaolwbP1IjF70ykk+nI6prWI4Ksu58l5YPy
 DMqq6rped0xsc9j54i/lH16FUTS7HCQV3BuNKgn4mKr9UbRKjVHrFnZZPRla9B7az+9j
 Q0LXafiebowVVvwEP1KxOLLiCEwFnJAtXl0ey1Jp7AWuM629GEXXH/FjGQ6Upm+9Ynst
 S62lSxnZRR/Cjxh28ZfBNZphj3BgCb/HX+xIpF8Ra7+k2BclMyQGrad4G5oB8UyTrho5
 7paQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEZ3Ke7YoblfYMHHGqThFZOIBDeM6xKHSSmOym4D8KQoXe9VhgjKIpvaUsJMOXPQ3hNqz1f3Z+x5Cr@nongnu.org
X-Gm-Message-State: AOJu0YxSaLrU7EAW4xevoedS3Ud/+cHl1tDKMRxtFuls+ITYCspkfcIm
 bWaaK7ITjaz5So+SgYN7NsUSwGCJZ6rUrXzitBAKjJkaNou2clOO/ad/SpgKYnTcY7Z60x83s5j
 T5REji4AV48mipv8UE/X1Bq1X/T9ajP0PuwEzmQeea8bSkNQfAGw7u8I8
X-Gm-Gg: ASbGncu5dN3hJZZCHzRfdM2kzPOwr6RFSJELu5TWYFaXmtT4UZpz4B1fZD70uFeZi3B
 LgW3TtVMfIPVXIkNGj2X8GYc8kMfx5IK7W8OztXS0KhiYP5/0Gawf0ZnUnCx3lM7FLRmAQUy3lv
 2jNk5TmN6d3VQnStO/BeY9kw2Td6UOtNflEHtMeI2KY8ecilBE421pUfw+hTyfi8zLkL+ny2GIR
 pzQvN/udVz/pcNTL5zKyCIos8KBduSKYYDg4PdaOJIs34t5Nmv/ZOo2tjbE2hBMKQYaI3QO3xXH
 HfE2E1U7p+//Av8dslfQ1sP0K1PeLgokis3ZLMewGs+OX3znn9ac0Bz28Ugpb2GQbyOi6YHkNzC
 OaD1/lb/p4Luz5teq
X-Received: by 2002:a05:600c:1d1a:b0:46d:45e:3514 with SMTP id
 5b1f17b1804b1-46e612bede2mr60953355e9.17.1759399489598; 
 Thu, 02 Oct 2025 03:04:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI8ZicA1fOGUXmQtRnUohkoR25R2DyorrnkK8TYd0vMUmSV8HSgSxAXaRt15BJVNM3BwU4MA==
X-Received: by 2002:a05:600c:1d1a:b0:46d:45e:3514 with SMTP id
 5b1f17b1804b1-46e612bede2mr60952875e9.17.1759399489083; 
 Thu, 02 Oct 2025 03:04:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619b86e1sm73599785e9.5.2025.10.02.03.04.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 03:04:48 -0700 (PDT)
Message-ID: <a0a149c6-e05a-40b1-87dc-c4a9470a85ed@redhat.com>
Date: Thu, 2 Oct 2025 12:04:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/27] hw/arm/smmuv3-accel: Support nested STE
 install/uninstall support
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
 <20250929133643.38961-10-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250929133643.38961-10-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Allocates a s1 HWPT for the Guest s1 stage and attaches that to the
> pass-through vfio device. This will be invoked when Guest issues
> SMMU_CMD_CFGI_STE/STE_RANGE.
ON set both alloc + attachment are done. On unset you shall explain the
gym related to config/abort hwpt. Those are S1 hwpt, right? I think this
shall be reflected in the name to make it clearer? In the previous patch
I didn't really understand that.
> While at it, we are also exporting both smmu_find_ste() and
> smmuv3_flush_config() from smmuv3.c for use here.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c    | 164 +++++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3-accel.h    |  22 ++++++
>  hw/arm/smmuv3-internal.h |   3 +
>  hw/arm/smmuv3.c          |  18 ++++-
>  hw/arm/trace-events      |   1 +
>  5 files changed, 205 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 81fa738f6f..5c3825cecd 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -17,10 +17,174 @@
>  #include "hw/vfio/pci.h"
>  
>  #include "smmuv3-accel.h"
> +#include "smmuv3-internal.h"
>  
>  #define SMMU_STE_VALID      (1ULL << 0)
>  #define SMMU_STE_CFG_BYPASS (1ULL << 3)
>  
> +#define STE0_V       MAKE_64BIT_MASK(0, 1)
> +#define STE0_CONFIG  MAKE_64BIT_MASK(1, 3)
> +#define STE0_S1FMT   MAKE_64BIT_MASK(4, 2)
> +#define STE0_CTXPTR  MAKE_64BIT_MASK(6, 50)
> +#define STE0_S1CDMAX MAKE_64BIT_MASK(59, 5)
> +#define STE0_MASK    (STE0_S1CDMAX | STE0_CTXPTR | STE0_S1FMT | STE0_CONFIG | \
> +                      STE0_V)
> +
> +#define STE1_S1DSS    MAKE_64BIT_MASK(0, 2)
> +#define STE1_S1CIR    MAKE_64BIT_MASK(2, 2)
> +#define STE1_S1COR    MAKE_64BIT_MASK(4, 2)
> +#define STE1_S1CSH    MAKE_64BIT_MASK(6, 2)
> +#define STE1_S1STALLD MAKE_64BIT_MASK(27, 1)
> +#define STE1_ETS      MAKE_64BIT_MASK(28, 2)
this is EATS
> +#define STE1_MASK     (STE1_ETS | STE1_S1STALLD | STE1_S1CSH | STE1_S1COR | \
> +                       STE1_S1CIR | STE1_S1DSS)
I would move all that stuff in smmuv3-internal.h too
> +
> +static bool
> +smmuv3_accel_dev_uninstall_nested_ste(SMMUv3AccelDevice *accel_dev, bool abort,
> +                                      Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
> +    SMMUS1Hwpt *s1_hwpt = accel_dev->s1_hwpt;
> +    uint32_t hwpt_id;
> +
> +    if (!s1_hwpt || !accel_dev->viommu) {
> +        return true;
> +    }
> +
> +    if (abort) {
> +        hwpt_id = accel_dev->viommu->abort_hwpt_id;
> +    } else {
> +        hwpt_id = accel_dev->viommu->bypass_hwpt_id;
> +    }
> +
> +    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
> +        return false;
> +    }
I think you shall add a trace point for uninstall and precise which hwpt
we use (abort or bypass). This might be useful for debug.
> +
> +    iommufd_backend_free_id(s1_hwpt->iommufd, s1_hwpt->hwpt_id);
> +    accel_dev->s1_hwpt = NULL;
> +    g_free(s1_hwpt);
> +    return true;
> +}
> +
> +static bool
> +smmuv3_accel_dev_install_nested_ste(SMMUv3AccelDevice *accel_dev,
> +                                    uint32_t data_type, uint32_t data_len,
> +                                    void *data, Error **errp)
> +{
> +    SMMUViommu *viommu = accel_dev->viommu;
> +    SMMUS1Hwpt *s1_hwpt = accel_dev->s1_hwpt;
> +    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
> +    uint32_t flags = 0;
> +
> +    if (!idev || !viommu) {
> +        error_setg(errp, "Device 0x%x has no associated IOMMU dev or vIOMMU",
> +                   smmu_get_sid(&accel_dev->sdev));
> +        return false;
> +    }
> +
> +    if (s1_hwpt) {
> +        if (!smmuv3_accel_dev_uninstall_nested_ste(accel_dev, true, errp)) {
> +            return false;
> +        }
> +    }
> +
> +    s1_hwpt = g_new0(SMMUS1Hwpt, 1);
> +    s1_hwpt->iommufd = idev->iommufd;
> +    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> +                                    viommu->core.viommu_id, flags, data_type,
> +                                    data_len, data, &s1_hwpt->hwpt_id, errp)) {
> +        return false;
> +    }
> +
> +    if (!host_iommu_device_iommufd_attach_hwpt(idev, s1_hwpt->hwpt_id, errp)) {
> +        iommufd_backend_free_id(idev->iommufd, s1_hwpt->hwpt_id);
> +        return false;
> +    }
> +    accel_dev->s1_hwpt = s1_hwpt;
> +    return true;
> +}
> +
> +bool
> +smmuv3_accel_install_nested_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
> +                                Error **errp)
> +{
> +    SMMUv3AccelDevice *accel_dev;
> +    SMMUEventInfo event = {.type = SMMU_EVT_NONE, .sid = sid,
> +                           .inval_ste_allowed = true};
> +    struct iommu_hwpt_arm_smmuv3 nested_data = {};
> +    uint64_t ste_0, ste_1;
> +    uint32_t config;
> +    STE ste;
> +    int ret;
> +
> +    if (!s->accel) {
> +        return true;
> +    }
> +
> +    accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
> +    if (!accel_dev->viommu) {
> +        return true;
> +    }
> +
> +    ret = smmu_find_ste(sdev->smmu, sid, &ste, &event);
> +    if (ret) {
> +        error_setg(errp, "Failed to find STE for Device 0x%x", sid);
> +        return true;
> +    }
> +
> +    config = STE_CONFIG(&ste);
> +    if (!STE_VALID(&ste) || !STE_CFG_S1_ENABLED(config)) {
> +        if (!smmuv3_accel_dev_uninstall_nested_ste(accel_dev,
> +                                                   STE_CFG_ABORT(config),
> +                                                   errp)) {
> +            return false;
> +        }
> +        smmuv3_flush_config(sdev);
> +        return true;
> +    }
> +
> +    ste_0 = (uint64_t)ste.word[0] | (uint64_t)ste.word[1] << 32;
> +    ste_1 = (uint64_t)ste.word[2] | (uint64_t)ste.word[3] << 32;
> +    nested_data.ste[0] = cpu_to_le64(ste_0 & STE0_MASK);
> +    nested_data.ste[1] = cpu_to_le64(ste_1 & STE1_MASK);
> +
> +    if (!smmuv3_accel_dev_install_nested_ste(accel_dev,
> +                                             IOMMU_HWPT_DATA_ARM_SMMUV3,
> +                                             sizeof(nested_data),
> +                                             &nested_data, errp)) {
> +        error_setg(errp, "Unable to install nested STE=%16LX:%16LX, sid=0x%x,"
don't you need to use PRIx64 instead?
also I suggest to put the SID first.
> +                   "ret=%d", nested_data.ste[1], nested_data.ste[0], sid, ret);
> +        return false;
> +    }
> +    trace_smmuv3_accel_install_nested_ste(sid, nested_data.ste[1],
> +                                          nested_data.ste[0]);
> +    return true;
> +}
> +
> +bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
> +                                           Error **errp)
> +{
> +    SMMUv3AccelState *s_accel = s->s_accel;
> +    SMMUv3AccelDevice *accel_dev;
> +
> +    if (!s_accel || !s_accel->viommu) {
> +        return true;
> +    }
> +
> +    QLIST_FOREACH(accel_dev, &s_accel->viommu->device_list, next) {
> +        uint32_t sid = smmu_get_sid(&accel_dev->sdev);
> +
> +        if (sid >= range->start && sid <= range->end) {
> +            if (!smmuv3_accel_install_nested_ste(s, &accel_dev->sdev,
> +                                                 sid, errp)) {
> +                return false;
> +            }
> +        }
> +    }
> +    return true;
> +}
> +
>  static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
>                                                 PCIBus *bus, int devfn)
>  {
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 3c8506d1e6..f631443b09 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -22,9 +22,15 @@ typedef struct SMMUViommu {
>      QLIST_HEAD(, SMMUv3AccelDevice) device_list;
>  } SMMUViommu;
>  
> +typedef struct SMMUS1Hwpt {
> +    IOMMUFDBackend *iommufd;
> +    uint32_t hwpt_id;
> +} SMMUS1Hwpt;
> +
>  typedef struct SMMUv3AccelDevice {
>      SMMUDevice  sdev;
>      HostIOMMUDeviceIOMMUFD *idev;
> +    SMMUS1Hwpt *s1_hwpt;
>      SMMUViommu *viommu;
>      QLIST_ENTRY(SMMUv3AccelDevice) next;
>  } SMMUv3AccelDevice;
> @@ -35,10 +41,26 @@ typedef struct SMMUv3AccelState {
>  
>  #ifdef CONFIG_ARM_SMMUV3_ACCEL
>  void smmuv3_accel_init(SMMUv3State *s);
> +bool smmuv3_accel_install_nested_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
> +                                     Error **errp);
> +bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
> +                                           Error **errp);
>  #else
>  static inline void smmuv3_accel_init(SMMUv3State *s)
>  {
>  }
> +static inline bool
> +smmuv3_accel_install_nested_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
> +                                Error **errp)
> +{
> +    return true;
> +}
> +static inline bool
> +smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
> +                                      Error **errp)
> +{
> +    return true;
> +}
>  #endif
>  
>  #endif /* HW_ARM_SMMUV3_ACCEL_H */
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index b6b7399347..b0dfa9465c 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -547,6 +547,9 @@ typedef struct CD {
>      uint32_t word[16];
>  } CD;
>  
> +int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event);
> +void smmuv3_flush_config(SMMUDevice *sdev);
> +
>  /* STE fields */
>  
>  #define STE_VALID(x)   extract32((x)->word[0], 0, 1)
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index ef991cb7d8..1fd8aaa0c7 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -630,8 +630,7 @@ bad_ste:
>   * Supports linear and 2-level stream table
>   * Return 0 on success, -EINVAL otherwise
>   */
> -static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
> -                         SMMUEventInfo *event)
> +int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
>  {
>      dma_addr_t addr, strtab_base;
>      uint32_t log2size;
> @@ -900,7 +899,7 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
>      return cfg;
>  }
>  
> -static void smmuv3_flush_config(SMMUDevice *sdev)
> +void smmuv3_flush_config(SMMUDevice *sdev)
>  {
>      SMMUv3State *s = sdev->smmu;
>      SMMUState *bc = &s->smmu_state;
> @@ -1330,6 +1329,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>          {
>              uint32_t sid = CMD_SID(&cmd);
>              SMMUDevice *sdev = smmu_find_sdev(bs, sid);
> +            Error *local_err = NULL;
>  
>              if (CMD_SSEC(&cmd)) {
>                  cmd_error = SMMU_CERROR_ILL;
> @@ -1341,6 +1341,11 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>              }
>  
>              trace_smmuv3_cmdq_cfgi_ste(sid);
> +            if (!smmuv3_accel_install_nested_ste(s, sdev, sid, &local_err)) {
> +                error_report_err(local_err);
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
>              smmuv3_flush_config(sdev);
>  
>              break;
> @@ -1350,6 +1355,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>              uint32_t sid = CMD_SID(&cmd), mask;
>              uint8_t range = CMD_STE_RANGE(&cmd);
>              SMMUSIDRange sid_range;
> +            Error *local_err = NULL;
>  
>              if (CMD_SSEC(&cmd)) {
>                  cmd_error = SMMU_CERROR_ILL;
> @@ -1361,6 +1367,12 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>              sid_range.end = sid_range.start + mask;
>  
>              trace_smmuv3_cmdq_cfgi_ste_range(sid_range.start, sid_range.end);
> +            if (!smmuv3_accel_install_nested_ste_range(s, &sid_range,
> +                                                       &local_err)) {
> +                error_report_err(local_err);
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
>              smmu_configs_inv_sid_range(bs, sid_range);
>              break;
>          }
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 86370d448a..3b1e9bf083 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -69,6 +69,7 @@ smmu_reset_exit(void) ""
>  #smmuv3-accel.c
>  smmuv3_accel_set_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x)"
>  smmuv3_accel_unset_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x)"
> +smmuv3_accel_install_nested_ste(uint32_t sid, uint64_t ste_1, uint64_t ste_0) "sid=%d ste=%"PRIx64":%"PRIx64
>  
>  # strongarm.c
>  strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
Thanks

Eric


