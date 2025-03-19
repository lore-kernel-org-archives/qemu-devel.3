Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1D7C282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 01:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuiHg-0006lQ-O7; Tue, 18 Mar 2025 21:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tuiHP-0006kJ-9j
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 21:31:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tuiHJ-0006uF-Q8
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 21:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742347888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vFNC5DCk5BvDTzKW4gazY23seiRM0V7bofGKfYEmvBc=;
 b=JQWRh8fVvq81LQkG1vFErBK5TNyzq11EV1EK0/tWWvFQ2u5DmEWlGSTrxUi9VXiZRf2F9X
 7FAJkhrK0TcdeeOVXIPGry9EjuXrGkg86AYfOEGSscCftklI0EVKsimZgKRUAeMlgQtbWD
 S19iwYvV07/uARYUHBdvFAkDmSITuYg=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-H5MKtfqAMaGi32cTc-fthw-1; Tue, 18 Mar 2025 21:31:24 -0400
X-MC-Unique: H5MKtfqAMaGi32cTc-fthw-1
X-Mimecast-MFC-AGG-ID: H5MKtfqAMaGi32cTc-fthw_1742347884
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-85da19887ebso1297435939f.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 18:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742347884; x=1742952684;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vFNC5DCk5BvDTzKW4gazY23seiRM0V7bofGKfYEmvBc=;
 b=eLwDJB7LiHeOsdXP3TpXtS0FNuKSydOYyJVWiDRMhTBJbarQPg6fHe/HVbG2qQdhSd
 zfBwBQh4j33TiCT3D+y4qSTrQj020e0t1eLIqMIM/5CC2pRFngb+qaYkm2t+7Kn0p7H6
 kn7fWYWaebWXox7f2v8x/rmbeGL1TjckV/kQlPD8Qvn7CYax1n+mXbTw3MuO8LqHBPDv
 qyL5kuv3R+yej+m3PofrZUDyPSaZJA4shVFk+J9RnDFj5V4jBuLLMmg+YwJhsZ4Y7C+d
 yeIH4vVvmLFciUf9i1pHhkoQiclkxmZjUILBxC+kaZ92tQ141tw8/YivL/xcW43Ms4xx
 1YIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUuBA/cAvR6Grzk583SMZtRrwGQDdVNv1zKOCpfGV4zxocwYwtp/KjNCpSWlX7tcLUf6K+xeT4r/f9@nongnu.org
X-Gm-Message-State: AOJu0YylX4gGeGpNS798E8XbHJndqb/j7YGx4wHSszDHRiLUjvPpOZDI
 wIuR1cpCdkL8s1uGOjndVdyXgrA46GERcsrfVvS/UcxGCGugwQq8h4P/MtdfwO7q1llp2OLvUcP
 dL/QMtSS6tqdXk5Dtm+XyKOJrD9+PfaM/EmnvH7iMq35P0P1vRB8i
X-Gm-Gg: ASbGncuNdGYGYQeBKy3DGDXXlR24sKDP8Vi83WIEqxSCsxUpNWi37Vhy99NZLtnOlaf
 RMw24VlyIt6RyjZkTgWqSTEqAbpEiPoovynNGQlJFAF4vqO6xziuB3dW+5UCK0nfcoFLEhBVRAU
 E9H8dhyZyq2+fmXQI4ynk6lsVVNO9t1+jBqOoV+WELrJCpA+RsV+uBVzKDcsFDV7cCgsRRKVc07
 C5bcDfhdwzICWW1DSecWKPUsIuYoouA4h7/kli1ADfzImPhzsDp+darir66a1XICcqq9azHmmKH
 +JcQZ+8qMI/KahP5
X-Received: by 2002:a05:6602:6a46:b0:85b:3b30:9aa6 with SMTP id
 ca18e2360f4ac-85e1377d824mr117538039f.2.1742347883954; 
 Tue, 18 Mar 2025 18:31:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqR5NXzIUiJCqmeJfVnzBT7xKUP+DsmHVKhMP2bAkQXJn/szfPyQoXjCtWizQrg48srycaAQ==
X-Received: by 2002:a05:6602:6a46:b0:85b:3b30:9aa6 with SMTP id
 ca18e2360f4ac-85e1377d824mr117535639f.2.1742347883615; 
 Tue, 18 Mar 2025 18:31:23 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f263701f6dsm2996059173.26.2025.03.18.18.31.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 18:31:23 -0700 (PDT)
Message-ID: <28452954-7be2-4114-8d37-a208250b6f83@redhat.com>
Date: Tue, 18 Mar 2025 21:31:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 13/20] hw/arm/smmuv3-accel: Introduce helpers to
 batch and issue cache invalidations
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-14-shameerali.kolothum.thodi@huawei.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250311141045.66620-14-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Shameer,

Hi,


On 3/11/25 10:10 AM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> Inroduce an SMMUCommandBatch and some helpers to batch and issue the
   ^^^^^^^^ Introduce
> commands.  Currently separate out TLBI commands and device cache commands
> to avoid some errata on certain versions of SMMUs. Later it should check
> IIDR register to detect if underlying SMMU hw has such an erratum.
Where is all this info about 'certain versions of SMMUs' and
'check IIDR register' has something to do with 'underlying SMMU hw such an erratum',
-- which IIDR (& bits)? or are we talking about rsvd SMMU_IDR<> registers?


And can't these helpers be used for emulated smmuv3 as well as accelerated?

Thanks,
- Don
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   hw/arm/smmuv3-accel.c    | 69 ++++++++++++++++++++++++++++++++++++++++
>   hw/arm/smmuv3-internal.h | 29 +++++++++++++++++
>   2 files changed, 98 insertions(+)
> 
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 76134d106a..09be838d22 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -160,6 +160,75 @@ void smmuv3_accel_install_nested_ste(SMMUDevice *sdev, int sid)
>                                             nested_data.ste[0]);
>   }
>   
> +/* Update batch->ncmds to the number of execute cmds */
> +int smmuv3_accel_issue_cmd_batch(SMMUState *bs, SMMUCommandBatch *batch)
> +{
> +    SMMUv3AccelState *s_accel = ARM_SMMUV3_ACCEL(bs);
> +    uint32_t total = batch->ncmds;
> +    IOMMUFDViommu *viommu_core;
> +    int ret;
> +
> +    if (!bs->accel) {
> +        return 0;
> +    }
> +
> +    if (!s_accel->viommu) {
> +        return 0;
> +    }
> +    viommu_core = &s_accel->viommu->core;
> +    ret = iommufd_backend_invalidate_cache(viommu_core->iommufd,
> +                                           viommu_core->viommu_id,
> +                                           IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3,
> +                                           sizeof(Cmd), &batch->ncmds,
> +                                           batch->cmds);
> +    if (total != batch->ncmds) {
> +        error_report("%s failed: ret=%d, total=%d, done=%d",
> +                      __func__, ret, total, batch->ncmds);
> +        return ret;
> +    }
> +
> +    batch->ncmds = 0;
> +    batch->dev_cache = false;
> +    return ret;
> +}
> +
> +int smmuv3_accel_batch_cmds(SMMUState *bs, SMMUDevice *sdev,
> +                            SMMUCommandBatch *batch, Cmd *cmd,
> +                            uint32_t *cons, bool dev_cache)
> +{
> +    int ret;
> +
> +    if (!bs->accel) {
> +        return 0;
> +    }
> +
> +    if (sdev) {
> +        SMMUv3AccelDevice *accel_dev;
> +        accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
> +        if (!accel_dev->s1_hwpt) {
> +            return 0;
> +        }
> +    }
> +
> +    /*
> +     * Currently separate out dev_cache and hwpt for safety, which might
> +     * not be necessary if underlying HW SMMU does not have the errata.
> +     *
> +     * TODO check IIDR register values read from hw_info.
> +     */
> +    if (batch->ncmds && (dev_cache != batch->dev_cache)) {
> +        ret = smmuv3_accel_issue_cmd_batch(bs, batch);
> +        if (ret) {
> +            *cons = batch->cons[batch->ncmds];
> +            return ret;
> +        }
> +    }
> +    batch->dev_cache = dev_cache;
> +    batch->cmds[batch->ncmds] = *cmd;
> +    batch->cons[batch->ncmds++] = *cons;
> +    return 0;
> +}
> +
>   static bool
>   smmuv3_accel_dev_attach_viommu(SMMUv3AccelDevice *accel_dev,
>                                  HostIOMMUDeviceIOMMUFD *idev, Error **errp)
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 46c8bcae14..4602ae6728 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -549,13 +549,42 @@ typedef struct CD {
>       uint32_t word[16];
>   } CD;
>   
> +/**
> + * SMMUCommandBatch - batch of invalidation commands for smmuv3-accel
> + * @cmds: Pointer to list of commands
> + * @cons: Pointer to list of CONS corresponding to the commands
> + * @ncmds: Total ncmds in the batch
> + * @dev_cache: Issue to a device cache
> + */
> +typedef struct SMMUCommandBatch {
> +    Cmd *cmds;
> +    uint32_t *cons;
> +    uint32_t ncmds;
> +    bool dev_cache;
> +} SMMUCommandBatch;
> +
>   int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>                     SMMUEventInfo *event);
>   void smmuv3_flush_config(SMMUDevice *sdev);
>   
>   #if defined(CONFIG_ARM_SMMUV3_ACCEL) && defined(CONFIG_IOMMUFD)
> +int smmuv3_accel_issue_cmd_batch(SMMUState *bs, SMMUCommandBatch *batch);
> +int smmuv3_accel_batch_cmds(SMMUState *bs, SMMUDevice *sdev,
> +                            SMMUCommandBatch *batch, Cmd *cmd,
> +                            uint32_t *cons, bool dev_cache);
>   void smmuv3_accel_install_nested_ste(SMMUDevice *sdev, int sid);
>   #else
> +static inline int smmuv3_accel_issue_cmd_batch(SMMUState *bs,
> +                                               SMMUCommandBatch *batch)
> +{
> +    return 0;
> +}
> +static inline int smmuv3_accel_batch_cmds(SMMUState *bs, SMMUDevice *sdev,
> +                                          SMMUCommandBatch *batch, Cmd *cmd,
> +                                          uint32_t *cons, bool dev_cache)
> +{
> +    return 0;
> +}
>   static inline void smmuv3_accel_install_nested_ste(SMMUDevice *sdev, int sid)
>   {
>   }


