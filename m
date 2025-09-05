Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0A2CA1013
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 09:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuSvt-0001te-TM; Fri, 05 Sep 2025 05:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuSvs-0001sU-0P
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 05:40:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuSvj-000321-75
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 05:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757065223;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54mT/Q5vtaM1bWNgRvk/n22WQtgAGWNzrVXooY5qdps=;
 b=LazfMWx/vo4ydAoOxOa4Mc660uf3z8q7krBmsNZx9fVEAoyrV5iXgxpBi813ue+vCXaiac
 jskNE39wqGofPUsYIvGBUJ69zZ1lErsasUj32pZYKxYEXpk8EL5luXcbMDwYmv0fakEhcs
 w2nNYBdhnSAWTiTSBF7gBgPnJep82QE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-je3sAaUUPbaNZM74lTMXjg-1; Fri, 05 Sep 2025 05:40:21 -0400
X-MC-Unique: je3sAaUUPbaNZM74lTMXjg-1
X-Mimecast-MFC-AGG-ID: je3sAaUUPbaNZM74lTMXjg_1757065221
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3df9f185b82so916739f8f.1
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 02:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757065220; x=1757670020;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=54mT/Q5vtaM1bWNgRvk/n22WQtgAGWNzrVXooY5qdps=;
 b=WXzEG0CC5Tli5e/02oxMOtJ85+61OB4M7FBy/WF//kOuh2oGTcenfvBSUZqrgWUXa0
 C54Oix7CZYm/Ywt+Vmy8/xtACcebH7bsgvrnUQsGtwUxmIdCeQiVSkVl8VsAk909tUDi
 Yq3zP4W5k8gGPl6gWsc6qoHlJcnfa5YaIUU3BxtvkDS4wCnurdti10N3R+L8fTLiVYnc
 6gBXJvZwTdQiMyWKh0Fd87Y8ubN1WVXlBBis5cg9eTx9CPPCQWLxc5e5ozA4g2BKSVQf
 q80E3d2OC6cleGlTTwILgKDB8a2JpZej31FOdO16cJ/zMNZI5OabmPvvkqnKPLMuXd+z
 wU/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqdziHz0it9YAzj75T/iviO2z27f3yV8j2LK0nU8CKk5SCEeObZuwK4wXJpUHFbmmtjIxI2NhyZIsm@nongnu.org
X-Gm-Message-State: AOJu0YyygOyjHB7Eh6zmEsGkyFYXPRXXion+gmghlJiDNuiyYpPGSuWF
 /8EDSVmoKBFdMzDpINnNUq9sHR22Q5kySXz0k3LtInF4Y/I7SHfMofaIeZ2q1k817PD0Dev5B8Q
 fnZoXZjEldGReK6rM0DF6/FHdBBpl03CvKpIgtUPNJfaNwvSo+6v5mXWi
X-Gm-Gg: ASbGncsHMDQTGDJZbJk8rqTdskvuzq8cZpfhHdGUZfl0eb9Wz7UA1fAcjK+qC0z7Daq
 wGO1Wn1vRwuI1Joue0kRQCKb0jQWvGlyYkx0pjLEN+1Adsn3sCP31JNd12wV0xyBRsbBq6Zk9GY
 oRIgedVG8uGkqI3frKaIO0zsBZ2wrYR5y7+KgYvP55RlIWERwwO5uVaNLnCByNZnSuoHOOVAeeB
 Tqvn9VAeorctJUe7qfmH4ed02WI5pQjmqhLYqMYBGlJa8JR84pX+qoR9nn+IQHQvx2zfm3A+9jO
 gZCu9ylQmLGtxeQrVEVjx8WML1enMS4RJIaup/7OWkSFY1AXDBWB1mNDR33oq9yxo0ku2YN6gwc
 2R1IMkDIoQ/I=
X-Received: by 2002:a5d:5c84:0:b0:3df:d8ea:1f87 with SMTP id
 ffacd0b85a97d-3dfd8ea27a5mr6435860f8f.58.1757065220532; 
 Fri, 05 Sep 2025 02:40:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcXln/tANMdrKOsTvR0gTUUmtklS5+a+7IMIE4YSHWUS8SAGX5Y7mQISEWmsN2cudUtxFzNw==
X-Received: by 2002:a5d:5c84:0:b0:3df:d8ea:1f87 with SMTP id
 ffacd0b85a97d-3dfd8ea27a5mr6435820f8f.58.1757065219886; 
 Fri, 05 Sep 2025 02:40:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e23d29bb9esm4295644f8f.4.2025.09.05.02.40.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 02:40:18 -0700 (PDT)
Message-ID: <41ceadf1-07de-4c8a-8935-d709ac7cf6bc@redhat.com>
Date: Fri, 5 Sep 2025 11:40:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 09/15] hw/arm/smmuv3-accel: Support nested STE
 install/uninstall support
Content-Language: en-US
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org, skolothumtho@nvidia.com
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, shameerkolothum@gmail.com
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-10-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250714155941.22176-10-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/14/25 5:59 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Allocates a s1 HWPT for the Guest s1 stage and attaches that
> to the dev. This will be invoked when Guest issues
dev: I think you shall be more precise because there are so many now ;-)
> SMMU_CMD_CFGI_STE/STE_RANGE.
>
> While at it, we are also exporting both smmu_find_ste() and
> smmuv3_flush_config() from smmuv3.c for use here.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmuv3-accel.c    | 130 +++++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3-accel.h    |  17 +++++
>  hw/arm/smmuv3-internal.h |   4 ++
>  hw/arm/smmuv3.c          |   8 ++-
>  hw/arm/trace-events      |   1 +
>  5 files changed, 157 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index fe90d48675..74bf20cfaf 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -18,9 +18,139 @@
>  
>  #include "smmuv3-accel.h"
>  
> +#include "smmuv3-internal.h"
> +
>  #define SMMU_STE_VALID      (1ULL << 0)
>  #define SMMU_STE_CFG_BYPASS (1ULL << 3)
>  
> +static void
> +smmuv3_accel_dev_uninstall_nested_ste(SMMUv3AccelDevice *accel_dev, bool abort)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
> +    SMMUS1Hwpt *s1_hwpt = accel_dev->s1_hwpt;
> +    uint32_t hwpt_id;
> +
> +    if (!s1_hwpt || !accel_dev->viommu) {
> +        return;
> +    }
> +
> +    if (abort) {
> +        hwpt_id = accel_dev->viommu->abort_hwpt_id;
> +    } else {
> +        hwpt_id = accel_dev->viommu->bypass_hwpt_id;
> +    }
> +
> +    host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, &error_abort);
> +    iommufd_backend_free_id(s1_hwpt->iommufd, s1_hwpt->hwpt_id);
> +    accel_dev->s1_hwpt = NULL;
> +    g_free(s1_hwpt);
> +}
> +
> +static int
> +smmuv3_accel_dev_install_nested_ste(SMMUv3AccelDevice *accel_dev,
> +                                    uint32_t data_type, uint32_t data_len,
> +                                    void *data)
> +{
> +    SMMUViommu *viommu = accel_dev->viommu;
> +    SMMUS1Hwpt *s1_hwpt = accel_dev->s1_hwpt;
> +    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
> +    uint32_t flags = 0;
> +
> +    if (!idev || !viommu) {
> +        return -ENOENT;
> +    }
> +
> +    if (s1_hwpt) {
> +        smmuv3_accel_dev_uninstall_nested_ste(accel_dev, true);
> +    }
> +
> +    s1_hwpt = g_new0(SMMUS1Hwpt, 1);
> +    s1_hwpt->iommufd = idev->iommufd;
> +    iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> +                               viommu->core.viommu_id, flags, data_type,
> +                               data_len, data, &s1_hwpt->hwpt_id, &error_abort);
> +    host_iommu_device_iommufd_attach_hwpt(idev, s1_hwpt->hwpt_id, &error_abort);
We don't want error_abort here in the prospect to support hotplug. Also
I think you should properly cascade any error through Error handles, at
least on the install path
> +    accel_dev->s1_hwpt = s1_hwpt;
> +    return 0;
> +}
> +
> +void smmuv3_accel_install_nested_ste(SMMUState *bs, SMMUDevice *sdev, int sid)
return bool and pass Error handle
> +{
> +    SMMUv3AccelDevice *accel_dev;
> +    SMMUEventInfo event = {.type = SMMU_EVT_NONE, .sid = sid,
> +                           .inval_ste_allowed = true};
> +    struct iommu_hwpt_arm_smmuv3 nested_data = {};
> +    uint32_t config;
> +    STE ste;
> +    int ret;
> +
> +    if (!bs->accel) {
> +        return;
> +    }
> +
> +    accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
> +    if (!accel_dev->viommu) {
> +        return;
> +    }
> +
> +    ret = smmu_find_ste(sdev->smmu, sid, &ste, &event);
> +    if (ret) {
> +        error_report("failed to find STE for sid 0x%x", sid);
> +        return;
> +    }
> +
> +    config = STE_CONFIG(&ste);
> +    if (!STE_VALID(&ste) || !STE_CFG_S1_ENABLED(config)) {
> +        smmuv3_accel_dev_uninstall_nested_ste(accel_dev, STE_CFG_ABORT(config));
> +        smmuv3_flush_config(sdev);
> +        return;
> +    }
> +
> +    nested_data.ste[0] = (uint64_t)ste.word[0] | (uint64_t)ste.word[1] << 32;
> +    nested_data.ste[1] = (uint64_t)ste.word[2] | (uint64_t)ste.word[3] << 32;
> +    /* V | CONFIG | S1FMT | S1CTXPTR | S1CDMAX */
use bitmasks here and below?
> +    nested_data.ste[0] &= 0xf80fffffffffffffULL;
> +    /* S1DSS | S1CIR | S1COR | S1CSH | S1STALLD | EATS */
> +    nested_data.ste[1] &= 0x380000ffULL;
> +    ret = smmuv3_accel_dev_install_nested_ste(accel_dev,
> +                                              IOMMU_HWPT_DATA_ARM_SMMUV3,
> +                                              sizeof(nested_data),
> +                                              &nested_data);
> +    if (ret) {
> +        error_report("Unable to install nested STE=%16LX:%16LX, sid=0x%x,"
> +                      "ret=%d", nested_data.ste[1], nested_data.ste[0],
> +                      sid, ret);
error_setg everywhere
> +    }
> +
> +    trace_smmuv3_accel_install_nested_ste(sid, nested_data.ste[1],
> +                                          nested_data.ste[0]);
> +}
> +
> +static void
> +smmuv3_accel_ste_range(gpointer key, gpointer value, gpointer user_data)
> +{
> +    SMMUDevice *sdev = (SMMUDevice *)key;
> +    uint32_t sid = smmu_get_sid(sdev);
> +    SMMUSIDRange *sid_range = (SMMUSIDRange *)user_data;
> +
> +    if (sid >= sid_range->start && sid <= sid_range->end) {
> +        SMMUv3State *s = sdev->smmu;
> +        SMMUState *bs = &s->smmu_state;
> +
> +        smmuv3_accel_install_nested_ste(bs, sdev, sid);
> +    }
> +}
> +
> +void
> +smmuv3_accel_install_nested_ste_range(SMMUState *bs, SMMUSIDRange *range)
> +{
> +    if (!bs->accel) {
> +        return;
> +    }
> +
> +    g_hash_table_foreach(bs->configs, smmuv3_accel_ste_range, range);
> +}
> +
>  static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
>                                                  PCIBus *bus, int devfn)
>  {
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 55a6a353fc..06e81b630d 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -29,10 +29,16 @@ typedef struct SMMUViommu {
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
>      AddressSpace as_sysmem;
>      HostIOMMUDeviceIOMMUFD *idev;
> +    SMMUS1Hwpt  *s1_hwpt;
>      SMMUViommu *viommu;
>      QLIST_ENTRY(SMMUv3AccelDevice) next;
>  } SMMUv3AccelDevice;
> @@ -45,10 +51,21 @@ typedef struct SMMUv3AccelState {
>  
>  #if defined(CONFIG_ARM_SMMUV3) && defined(CONFIG_IOMMUFD)
>  void smmuv3_accel_init(SMMUv3State *s);
> +void smmuv3_accel_install_nested_ste(SMMUState *bs, SMMUDevice *sdev, int sid);
> +void smmuv3_accel_install_nested_ste_range(SMMUState *bs,
> +                                           SMMUSIDRange *range);
to me should return an int or bool and convey Error handle
>  #else
>  static inline void smmuv3_accel_init(SMMUv3State *d)
>  {
>  }
> +static inline void
> +smmuv3_accel_install_nested_ste(SMMUState *bs, SMMUDevice *sdev, int sid)
> +{
> +}
> +static inline void
> +smmuv3_accel_install_nested_ste_range(SMMUState *bs, SMMUSIDRange *range)
> +{
> +}
>  #endif
>  
>  #endif /* HW_ARM_SMMUV3_ACCEL_H */
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index b6b7399347..738061c6ad 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -547,6 +547,10 @@ typedef struct CD {
>      uint32_t word[16];
>  } CD;
>  
> +int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
> +                  SMMUEventInfo *event);
> +void smmuv3_flush_config(SMMUDevice *sdev);
> +
>  /* STE fields */
>  
>  #define STE_VALID(x)   extract32((x)->word[0], 0, 1)
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 2f5a8157dd..c94bfe6564 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -630,8 +630,8 @@ bad_ste:
>   * Supports linear and 2-level stream table
>   * Return 0 on success, -EINVAL otherwise
>   */
> -static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
> -                         SMMUEventInfo *event)
> +int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
> +                  SMMUEventInfo *event)
>  {
>      dma_addr_t addr, strtab_base;
>      uint32_t log2size;
> @@ -900,7 +900,7 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
>      return cfg;
>  }
>  
> -static void smmuv3_flush_config(SMMUDevice *sdev)
> +void smmuv3_flush_config(SMMUDevice *sdev)
>  {
>      SMMUv3State *s = sdev->smmu;
>      SMMUState *bc = &s->smmu_state;
> @@ -1342,6 +1342,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>  
>              trace_smmuv3_cmdq_cfgi_ste(sid);
>              smmuv3_flush_config(sdev);
> +            smmuv3_accel_install_nested_ste(bs, sdev, sid);
>  
>              break;
>          }
> @@ -1361,6 +1362,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>              sid_range.end = sid_range.start + mask;
>  
>              trace_smmuv3_cmdq_cfgi_ste_range(sid_range.start, sid_range.end);
> +            smmuv3_accel_install_nested_ste_range(bs, &sid_range);
>              smmu_configs_inv_sid_range(bs, sid_range);
>              break;
>          }
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index c4537ca1d6..7d232ca17c 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -69,6 +69,7 @@ smmu_reset_exit(void) ""
>  #smmuv3-accel.c
>  smmuv3_accel_set_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x)"
>  smmuv3_accel_unset_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x"
> +smmuv3_accel_install_nested_ste(uint32_t sid, uint64_t ste_1, uint64_t ste_0) "sid=%d ste=%"PRIx64":%"PRIx64
>  
>  # strongarm.c
>  strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
Thanks

Eric


