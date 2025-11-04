Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D09CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 14:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGI8X-0008Ic-Tj; Tue, 04 Nov 2025 09:35:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vGI8W-0008Hw-5b
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 09:35:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vGI8T-0002Te-OF
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 09:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762266947;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L2TwGClYH1z/88OuUCUvYGwOwfOueYyRNR6EbU4rtnk=;
 b=BwXAxql9mKR8ILErhAZhbVcC8zYusgtjoOoM8015VXDP1+o1TEh6XYXukL7Smqy+WOd9Fp
 BFFFZ/Duiq+V5+uSnKyslNC5MElciAKwNHuptpFGRxoQjY4imzdRJorhP3o4CBTdgBd628
 Jfm3uAiH4sS45PH7hJzta88WNLMRJHQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-Kr33DSLAO52MUHQKPqf69Q-1; Tue, 04 Nov 2025 09:35:46 -0500
X-MC-Unique: Kr33DSLAO52MUHQKPqf69Q-1
X-Mimecast-MFC-AGG-ID: Kr33DSLAO52MUHQKPqf69Q_1762266945
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e47d14dceso35014925e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 06:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762266945; x=1762871745;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L2TwGClYH1z/88OuUCUvYGwOwfOueYyRNR6EbU4rtnk=;
 b=ESNpBk0PVmpzob4K/i9o1wCuRX1/HgCJenZunaJhv1ylR7AAgZ9QQ4wUs7yGbbWPbe
 koPuB8eEtRC1JVX55GWb2NucJso+sjqS19a9E2i+vbaBpw8GkeW2eDHPlIHHuHhg8Wi4
 Kt+nJsCqiqLGYopSjpSOllkY9F2lqvl2rb0cIeYwSzZnJMKKtLg1RcyFyGmocus4H4so
 jKpSyLvqSk9QS9d0O3WKntFNyIEAGo8cl9oPm1sS65Bq7KNCOqunEExSXiyXnz9u+7F7
 /FqXqMya6Uz3oEuO0CkPcu90xIlBTQBLKzQAsIZeDMacQN/LBEV7XxQ0UTRJ3KtIvx0S
 9PZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmT+YCEGUEu5FS8UN/Kw25yvjPROioGO3XolbZziNpQ1x3rPTn7N84PNgf2GAbaULXDuQEMfZ8kUZS@nongnu.org
X-Gm-Message-State: AOJu0YwC1p5a5bjrDZ9dG+t4qHOQvW+IqJcX7gLpW+0AUbjj48PVty4W
 ht/xl0InqKXYecwqCZNK+mG0SHDbYV9svamUjVIacNzGDiR+k8q2WsunrBE4shzkM0b0eamL9LT
 FP8vpSEpF1PvdyOY9ZJU9BIcEzOiDB6WO98M9Z8Ab0fWjCVoePZPoRBAu
X-Gm-Gg: ASbGnctW3UJbMr6wF50nKqMka8Uv7wOJ8ecpUREFk0LZlqiFkN36MWCbQ3Av1wwrCf4
 aAEk06nneg0knGi+fF5EBHs8jvdpMBI/Ri/FVrMSqIw6XI5sXxAZnF/9NWMP7iU3jQbAPmqjCp5
 wIr3Gk/FwNKj3LyqrBqR+euzHT2L5ZR5MC2LLq9ji3ooiLjxiwljPa9nwJ6nyTx8JO84/bp3vvq
 u1CfE+C0uhDA48S+x6voNUEZ5mbVFGfrGCSgX1FLNLsgLujPfuZacejSoFCbsq8rRMgbckNB08Q
 FfAscIX72Rj2rvETNnxqjGfkHIUHXwOcWwNdh+5SztqStsXkGYtwbtt3E7yGXKqeEit2IrEeLWQ
 HlJXYJdurygZ5Eqe+ZeBj+3bH1WcFv4a+6UJ8g8LKLg+1RA==
X-Received: by 2002:a05:600c:828f:b0:475:df91:ddf2 with SMTP id
 5b1f17b1804b1-4773c7862cbmr107238665e9.17.1762266944749; 
 Tue, 04 Nov 2025 06:35:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0/036CHcIdYhlOpaPjZJOrbUzYILvDSG2nXp/dAat3Z6PP4YBEoQaNW84lHpINSYSZpRsnQ==
X-Received: by 2002:a05:600c:828f:b0:475:df91:ddf2 with SMTP id
 5b1f17b1804b1-4773c7862cbmr107238375e9.17.1762266944325; 
 Tue, 04 Nov 2025 06:35:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47755f92274sm39470015e9.9.2025.11.04.06.35.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 06:35:43 -0800 (PST)
Message-ID: <49215c9d-feb1-4f72-bfe0-799572ecfac2@redhat.com>
Date: Tue, 4 Nov 2025 15:35:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 28/32] hw/arm/smmuv3-accel: Add property to specify OAS
 bits
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 kjaju@nvidia.com
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-29-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251031105005.24618-29-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/31/25 11:50 AM, Shameer Kolothum wrote:
> QEMU SMMUv3 currently sets the output address size (OAS) to 44 bits. With
> accelerator mode enabled, a guest device may use SVA where CPU page tables
> are shared with SMMUv3, requiring OAS at least equal to the CPU OAS. Add
> a user option to set this.
>
> Note: Linux kernel docs currently state the OAS field in the IDR register
> is not meaningful for users. But looks like we need this information.
I would explain why this is actually needed instead of quoting the linux
kernel docs. I guess in practice the vSMMU can't advertise an OAS
greater than the one support by the host SMMU otherwise the guest might
fail to use the range exposed by the vSMMU.
>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c    | 22 ++++++++++++++++++++++
>  hw/arm/smmuv3-internal.h |  3 ++-
>  hw/arm/smmuv3.c          | 16 +++++++++++++++-
>  include/hw/arm/smmuv3.h  |  1 +
>  4 files changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 5b0ef3804a..c46510150e 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -28,6 +28,12 @@ MemoryRegion root;
>  MemoryRegion sysmem;
>  static AddressSpace *shared_as_sysmem;
>  
> +static int smmuv3_oas_bits(uint32_t oas)
> +{
> +    static const int map[] = { 32, 36, 40, 42, 44, 48, 52, 56 };
> +    return (oas < ARRAY_SIZE(map)) ? map[oas] : -EINVAL;
> +}
> +
>  static bool
>  smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>                                   struct iommu_hw_info_arm_smmuv3 *info,
> @@ -70,6 +76,18 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>          return false;
>      }
>  
> +    /*
> +     * TODO: OAS is not something Linux kernel doc says meaningful for user.
> +     * But looks like OAS needs to be compatible for accelerator support. Please
> +     * check.
would remove that comment. Either it is requested or not.
> +     */
> +    if (FIELD_EX32(info->idr[5], IDR5, OAS) <
> +                FIELD_EX32(s->idr[5], IDR5, OAS)) {
> +        error_setg(errp, "Host SMMUv3 OAS(%d) bits not compatible",
> +                   smmuv3_oas_bits(FIELD_EX32(info->idr[5], IDR5, OAS)));
let's be more explicit then and say

Host SMMUv3 OAS (%d bits) is less that OAS bits advertised by SMMU (%d)



> +        return false;
> +    }
> +
>      /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
>      if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
>                  FIELD_EX32(s->idr[5], IDR5, GRAN4K)) {
> @@ -649,6 +667,10 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>      if (s->ats) {
>          s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 1); /* ATS */
>      }
> +    /* QEMU SMMUv3 has OAS set 44. Update IDR5 if user has it set to 48 bits*/
vSMMUv3 advertises by default a 44 bit wide OAS
> +    if (s->oas == 48) {
> +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
> +    }
>  }
>  
>  /* Based on SMUUv3 GBPA configuration, attach a corresponding HWPT */
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 5fd88b4257..cfc5897569 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -111,7 +111,8 @@ REG32(IDR5,                0x14)
>       FIELD(IDR5, VAX,        10, 2);
>       FIELD(IDR5, STALL_MAX,  16, 16);
>  
> -#define SMMU_IDR5_OAS 4
> +#define SMMU_IDR5_OAS_44 4
> +#define SMMU_IDR5_OAS_48 5
>  
>  REG32(IIDR,                0x18)
>  REG32(AIDR,                0x1c)
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index d95279a733..c4d28a3786 100644
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
> @@ -1961,6 +1962,15 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>              error_setg(errp, "ats can only be enabled if accel=on");
>              return false;
>          }
> +        if (s->oas != 44) {
> +            error_setg(errp, "OAS can only be set to 44 bits if accel=off");
> +            return false;
> +        }
> +        return false;
> +    }
> +
> +    if (s->oas != 44 && s->oas != 48) {
> +        error_setg(errp, "OAS can only be set to 44 or 48 bits");
>          return false;
>      }
>      return true;
> @@ -2087,6 +2097,7 @@ static const Property smmuv3_properties[] = {
>      /* RIL can be turned off for accel cases */
>      DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
>      DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
> +    DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
>  };
>  
>  static void smmuv3_instance_init(Object *obj)
> @@ -2119,6 +2130,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>      object_class_property_set_description(klass, "ats",
>          "Enable/disable ATS support (for accel=on). Please ensure host "
>          "platform has ATS support before enabling this");
> +    object_class_property_set_description(klass, "oas",
> +        "Specify Output Address Size (for accel =on). Supported values "
> +        "are 44 or 48 bits. Defaults to 44 bits");
>  }
>  
>  static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index 5fd5ec7b49..e4226b66f3 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -70,6 +70,7 @@ struct SMMUv3State {
>      Error *migration_blocker;
>      bool ril;
>      bool ats;
> +    uint8_t oas;
>  };
>  
>  typedef enum {


