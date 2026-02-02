Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB20E7DEE3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 14:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmv5v-0001Bb-OE; Mon, 02 Feb 2026 09:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vmv5u-0001AM-82
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:40:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vmv5r-0000mK-OM
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770043198;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I4OzIbWlsp5cpVNBuTmU9XHo7cdIckoBDTs7zm5um6M=;
 b=TB3g/Z9koXFD7RQXH2cBfOl2SRQFFCLmOKikFhuL7NCZDrFcFRmqG7o9k6xbHKuhKdlNkE
 C4i9klQ+B+GqgzpNc1hcXfyN5zsOQSZ5Lb0UJeW+LfdRZvocZtXYQZmoNop6yhdNy97yqq
 MfylLWWnN+gFNwG39+zjUCcZLxh80vk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-McnhyrXXOTig74MFogkr8g-1; Mon, 02 Feb 2026 09:39:57 -0500
X-MC-Unique: McnhyrXXOTig74MFogkr8g-1
X-Mimecast-MFC-AGG-ID: McnhyrXXOTig74MFogkr8g_1770043196
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-435db9425ebso4584732f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 06:39:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770043196; x=1770647996;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4OzIbWlsp5cpVNBuTmU9XHo7cdIckoBDTs7zm5um6M=;
 b=g5VTRxQ9vQkaDBf+l0ggyLRwvJ+5/71DmI48PLfMLstJSQULFPkLudPIuCXsXC+UF7
 EcTGgv/zcBzqXa5dbONCQsxVUdOCKn3kgRdscUcOGzgaFSWbIn5c+JEWfmsxp+wMtDuO
 CYNiQGnRJQar8zkyCeoavspQ6SYHKF0F00RnqWOWcJMKLhMIRvaTq75W8R2FBLbbsSpM
 hJi5891YgIElbThE7URVwTef67BsPJjD1/ELqLarqpAeOWw3mOYSlHiiUpEpgwG708oW
 1C+0V7DmraWK8riMWLxIvj+KdOc1dPSHjF5W7Bwc2lfs4w0ylB2PUO5i/7W9sXfGFABm
 B95w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7f+dCDTrsGmbIN+OsZyxvj1wA9yWo+XUiXoZthafWBS4TVHD+MrJz3PssKy+kS+GIOleMZ11qz64o@nongnu.org
X-Gm-Message-State: AOJu0YzoWmV61ST2lfwMxFa5TRotr8dfeKcMNKQRAGLwPrIkbAUMknTI
 1YGohxnfu8lD2y12lWV9+041PULqUGMBo0aEpCkopam0cklrDqlX7BWKq/AbPUgjxeeR1s/BmkA
 VNc00sTU2QH8FL7bNqu4R5zk3/14WcyPdN9tttNXzf8n7gGMr2NCSdkdc
X-Gm-Gg: AZuq6aJrGlR6kg7+E/Z+J9WIQK++qKC5Qc+Zd7Bykt6yxWHj5U6GVo/Q2/oQSyShe45
 3KEqtW3rVxdgK4ngCoS9fhuolHRadoNjIMDEZ/LDXdroSR19Xwr+qLa4Dv9R2V/rpZqq9B2uoDF
 E+uzWNfzfSNwGswfgbNs9jLPgr7wH0wm39IlJ1tAuP976cti+w9jCyNnaCzy8GqPbjcopyNGNYa
 QSK+dkYfJTuprwzh1Xz28QSOzwQxUSYMeGzH0KW0YQv7gLNsIx/YJXINw/Q9mLbbV9PceJ3xkN5
 ywxFbiKA8qtgyC6EEaL8qERPQo7hvyERQMOJWNUMO9mQ3EX4djqXiyjgZuDBf5yTeYMZeN3GC/a
 JwDY4l/LHvwERDDZH9LFm7FbXVQPgLMxcNUsTo30SGTRV5PTQ9Frl5axxwg==
X-Received: by 2002:a5d:584a:0:b0:435:a464:f467 with SMTP id
 ffacd0b85a97d-435f3abc7d7mr17933705f8f.50.1770043195626; 
 Mon, 02 Feb 2026 06:39:55 -0800 (PST)
X-Received: by 2002:a5d:584a:0:b0:435:a464:f467 with SMTP id
 ffacd0b85a97d-435f3abc7d7mr17933636f8f.50.1770043195118; 
 Mon, 02 Feb 2026 06:39:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e46cesm44330705f8f.7.2026.02.02.06.39.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 06:39:54 -0800 (PST)
Message-ID: <d9192ae6-a94f-479a-b19f-734cc52a6be0@redhat.com>
Date: Mon, 2 Feb 2026 15:39:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to specify OAS
 bits
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, clg@redhat.com, alex@shazbot.org,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, kjaju@nvidia.com
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-32-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260126104342.253965-32-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Shameer, Nicolin,
On 1/26/26 11:43 AM, Shameer Kolothum wrote:
> QEMU SMMUv3 currently sets the output address size (OAS) to 44 bits.
> With accelerator mode enabled, a device may use SVA, where CPU page tables
> are shared with the SMMU, requiring an OAS at least as large as the
> CPU’s output address size. A user option is added to configure this.
>
> However, the OAS value advertised by the virtual SMMU must remain
> compatible with the capabilities of the host SMMUv3. In accelerated
> mode, the host SMMU performs stage-2 translation and must be able to
> consume the intermediate physical addresses (IPA) produced by stage-1.
>
> The OAS exposed by the virtual SMMU defines the maximum IPA width that
> stage-1 translations may generate. For AArch64 implementations, the
> maximum usable IPA size on the host SMMU is determined by its own OAS.
> Check that the configured OAS does not exceed what the host SMMU
> can safely support.

After discussion with Kubevirt guys, the management of current RIL,
ssidsize, ats and oas options look touchy because it is tricky for them
to introspect the host values.

In cold plug case at least it looks feasible to use IOMMU_GET_HW_INFO()
to retrieve host info:

RIL is in IDR3
ssidsize in IDR1
OAS in IDR5
ATS may be more touchy but maybe this can be introspected too?

I would advocate to turn those options into _AUTO options to give a
chance to the user to ask for host derived values.

Currently in include/hw/qdev-properties.h we have
DEFINE_PROP_ON_OFF_AUTO for a bool and
DEFINE_PROP_ON_OFF_AUTO_BIT64 for a 64b

RIL can match bool.
Others may need a new DEFINE_PROP_ON_OFF_AUTO_* one.

Note such kind of auto property was introduced for virtio-iommu
(DEFINE_PROP_GRANULE_MODE)

What do you think? Most probably this has been dicussed in the past but
I do not necessarily remember the outputs.

Thanks

Eric



>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c          | 22 ++++++++++++++++++++++
>  hw/arm/smmuv3.c                | 16 +++++++++++++++-
>  include/hw/arm/smmuv3-common.h |  5 ++++-
>  include/hw/arm/smmuv3.h        |  1 +
>  4 files changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index a97abc1f79..ea420afeb7 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -27,6 +27,14 @@
>  static MemoryRegion root, sysmem;
>  static AddressSpace *shared_as_sysmem;
>  
> +static int smmuv3_oas_bits(uint32_t oas)
> +{
> +    static const int map[] = { 32, 36, 40, 42, 44, 48, 52, 56 };
> +
> +    g_assert(oas < ARRAY_SIZE(map));
> +    return map[oas];
> +}
> +
>  static bool
>  smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>                                   struct iommu_hw_info_arm_smmuv3 *info,
> @@ -74,6 +82,15 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>          error_setg(errp, "Host SMMUv3 doesn't support Range Invalidation");
>          return false;
>      }
> +    /* Check OAS value opted is compatible with Host SMMUv3 IPA */
> +    if (FIELD_EX32(info->idr[5], IDR5, OAS) <
> +                FIELD_EX32(s->idr[5], IDR5, OAS)) {
> +        error_setg(errp, "Host SMMUv3 supports only %d-bit IPA, but the vSMMU "
> +                   "OAS implies %d-bit IPA",
> +                   smmuv3_oas_bits(FIELD_EX32(info->idr[5], IDR5, OAS)),
> +                   smmuv3_oas_bits(FIELD_EX32(s->idr[5], IDR5, OAS)));
> +        return false;
> +    }
>  
>      /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
>      if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
> @@ -657,6 +674,11 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>  
>      /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
>      s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
> +
> +    /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
> +    if (s->oas == SMMU_OAS_48BIT) {
> +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
> +    }
>  }
>  
>  /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index ca086ba00a..cb02184d2d 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -299,7 +299,8 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
>  
> -    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS); /* 44 bits */
> +    /* OAS: 44 bits */
> +    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_44);
>      /* 4K, 16K and 64K granule support */
>      s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
>      s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
> @@ -1949,6 +1950,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>              error_setg(errp, "ats can only be enabled if accel=on");
>              return false;
>          }
> +        if (s->oas != SMMU_OAS_44BIT) {
> +            error_setg(errp, "OAS must be 44 bits when accel=off");
> +            return false;
> +        }
>          return true;
>      }
>  
> @@ -1959,6 +1964,11 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>          return false;
>      }
>  
> +    if (s->oas != SMMU_OAS_44BIT && s->oas != SMMU_OAS_48BIT) {
> +        error_setg(errp, "OAS can only be set to 44 or 48 bits");
> +        return false;
> +    }
> +
>      return true;
>  }
>  
> @@ -2085,6 +2095,7 @@ static const Property smmuv3_properties[] = {
>      /* RIL can be turned off for accel cases */
>      DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
>      DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
> +    DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
>  };
>  
>  static void smmuv3_instance_init(Object *obj)
> @@ -2115,6 +2126,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>      object_class_property_set_description(klass, "ats",
>          "Enable/disable ATS support (for accel=on). Please ensure host "
>          "platform has ATS support before enabling this");
> +    object_class_property_set_description(klass, "oas",
> +        "Specify Output Address Size (for accel=on). Supported values "
> +        "are 44 or 48 bits. Defaults to 44 bits");
>  }
>  
>  static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
> diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
> index 415b7ccde5..abe3565357 100644
> --- a/include/hw/arm/smmuv3-common.h
> +++ b/include/hw/arm/smmuv3-common.h
> @@ -342,7 +342,10 @@ REG32(IDR5,                0x14)
>       FIELD(IDR5, VAX,        10, 2);
>       FIELD(IDR5, STALL_MAX,  16, 16);
>  
> -#define SMMU_IDR5_OAS 4
> +#define SMMU_OAS_44BIT 44
> +#define SMMU_OAS_48BIT 48
> +#define SMMU_IDR5_OAS_44 4
> +#define SMMU_IDR5_OAS_48 5
>  
>  REG32(IIDR,                0x18)
>  REG32(AIDR,                0x1c)
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index 242d6429ed..d488a39cd0 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -71,6 +71,7 @@ struct SMMUv3State {
>      Error *migration_blocker;
>      bool ril;
>      bool ats;
> +    uint8_t oas;
>  };
>  
>  typedef enum {


