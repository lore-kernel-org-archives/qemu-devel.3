Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2871CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 14:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOSf-0007Nq-Lw; Mon, 27 Oct 2025 10:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDOSd-0007Nc-U6
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDOSP-0008FG-9s
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761576261;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fSnyMK2PnnR0lH6BZTdCQi2hL4wj4fDfNX0GX7+hhVw=;
 b=DGhU0yP66L7bLzrksODUgCVbyiuN/6R5jn7N7sk0pjD/VDtBl8N7SVzMf1+bwKxRB0x7ji
 3J/4jcAFt3GVscCPlW861Q8tNHMKJUUrG2BrpHpspr4MXJeBW8YCUS/uvumgyGiExIbIY5
 MwgJfmO0ou7rdqgXwXx7NjA4rVfGQ8o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-5UKamhUwN0eVP1ExJk5IhQ-1; Mon, 27 Oct 2025 10:44:19 -0400
X-MC-Unique: 5UKamhUwN0eVP1ExJk5IhQ-1
X-Mimecast-MFC-AGG-ID: 5UKamhUwN0eVP1ExJk5IhQ_1761576258
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-427013eb71dso4652594f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 07:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761576258; x=1762181058;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fSnyMK2PnnR0lH6BZTdCQi2hL4wj4fDfNX0GX7+hhVw=;
 b=EoJsSDpNoUKHDthvAxOFjxiNFpjV6/060+jCUUMUZ5BAUx1RZkqT5WzcSBKZX3G2Dl
 PLJNTXP6u+yGUE2JeW4ZY3IstR4ZCVyzMZ6Km9aTA+M3oOdD1gVa4bh3CxrcomPCE9ao
 Vyor+9KZsMULwURqhn9VN3jhl84tUtVyNxcjHxoghBNFCMmWXAzBoxE9Ql7JtAWEI/mz
 860xG5LdJ6gS7ivdAU1CcDgQ6gZEmVqRWznE62v6w56FhZg1zG5SLrFuYOEaNKVkj12W
 dCj1WZPaiIoJ00Z26OEAqyIpbthDuy6lnrwl2U3tVHwoXSlkKwgX9nvez5cxoyXKPZq6
 77Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZed7T3gczefDodUpuifktGEetZLd2jjtimNdK+1v7cVO1rGpyD0lG+MkJk0y/ZyeyjrlYgUvev8+t@nongnu.org
X-Gm-Message-State: AOJu0YydQ/lENEbXYDQzuWotFiBYpLxVvqWTOZWnK+aw21XcOp2OCXuc
 u6AprIJqFloXefQv7043pOaKmLnkwHWARfWe74AVIw9kOuNsbvuKajiDeSbZD+l4kAcu8Aa1rJ9
 Z+GHS1mpYOUAAG8zKT5gLaGK4cjGoTzZkDIb3yGx55A5wejscNlyZaSVf
X-Gm-Gg: ASbGncuZM/tOYJNxanSoO+J/97NeXyVMs7bARYZUgkqgd70hgGbI02Dx/arGEN14yIF
 OxIlWoRLMpivg8hJrb7s4hzBNuk/2g7xuIu2d70PP1S4piWKR8WPuvYvPxdk0ZEz/ZDijBo1U7u
 noXBZtc8o50CQBYHDbwU/bpNz7I8wbzMObT5IkD7Oya8Ne8Emi9cvSMaoXP7xnFdTljCsKNANHX
 +OIConhb0lr6oc45JoPSk6Qk0zCCdbnhEtA+79YD29xzrg+sis3ihLERq53NblYMEb2477W/RDm
 mAqAUUkBtSosLJuPrjQfJTY/bkccbB5uaZ/YPSofMHH1GiNJ+7ohNJOeFut4mBXxYVpdhHpMMR0
 HiOJ4VBMiSbo/pyywnbgCn/LSFoQU+F82f8rbGb6qlALJYg==
X-Received: by 2002:a05:6000:4809:b0:428:55c3:cea7 with SMTP id
 ffacd0b85a97d-42855c3d2demr16142173f8f.36.1761576257982; 
 Mon, 27 Oct 2025 07:44:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaj9MukrRhut2DRd7W9Jf4I5u1nOyNm8my6egdB8PcStJOnZkxyw4CR46IfJUk0u4ZAw8AgA==
X-Received: by 2002:a05:6000:4809:b0:428:55c3:cea7 with SMTP id
 ffacd0b85a97d-42855c3d2demr16142134f8f.36.1761576257531; 
 Mon, 27 Oct 2025 07:44:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df5c9sm14626724f8f.41.2025.10.27.07.44.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 07:44:17 -0700 (PDT)
Message-ID: <b6105534-4a17-4700-bb0b-e961babd10bb@redhat.com>
Date: Mon, 27 Oct 2025 15:44:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/27] hw/arm/smmuv3-accel: Add a property to specify
 RIL support
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
 <20250929133643.38961-22-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250929133643.38961-22-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
> Currently QEMU SMMUv3 has RIL support by default. But if accelerated mode
> is enabled, RIL has to be compatible with host SMMUv3 support.

We may have extended this prop to emulation code too.

While checking I noticed AIDR is set to 3.1 in vIOMMU. Not related to
this patch but should we test the host IOMMU has a compatible
architecture too?
>
> Add a property so that the user can specify this.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c   | 16 ++++++++++++++--
>  hw/arm/smmuv3-accel.h   |  4 ++++
>  hw/arm/smmuv3.c         | 13 +++++++++++++
>  include/hw/arm/smmuv3.h |  1 +
>  4 files changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 8396053a6c..e8607b253e 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -79,10 +79,10 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>          return false;
>      }
>  
> -    /* QEMU SMMUv3 supports Range Invalidation by default */
> +    /* User can override QEMU SMMUv3 Range Invalidation support */
>      val = FIELD_EX32(info->idr[3], IDR3, RIL);
>      if (val != FIELD_EX32(s->idr[3], IDR3, RIL)) {
> -        error_setg(errp, "Host SUMMUv3 deosn't support Range Invalidation");
> +        error_setg(errp, "Host SUMMUv3 differs in Range Invalidation support");
>          return false;
>      }
>  
> @@ -634,6 +634,18 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
>      .get_msi_address_space = smmuv3_accel_find_msi_as,
>  };
>  
> +void smmuv3_accel_idr_override(SMMUv3State *s)
> +{
> +    if (!s->accel) {
> +        return;
> +    }
> +
> +    /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
> +    if (!s->ril) {
> +        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 0);
> +    }
> +}
> +
>  /*
>   * If the guest reboots and devices are configured for S1+S2, Stage1 must
>   * be switched to bypass. Otherwise, QEMU/UEFI may fail when accessing a
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 75f858e34a..357d8352c5 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -49,6 +49,7 @@ bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
>  bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
>                                  Error **errp);
>  void smmuv3_accel_attach_bypass_hwpt(SMMUv3State *s);
> +void smmuv3_accel_idr_override(SMMUv3State *s);
>  #else
>  static inline void smmuv3_accel_init(SMMUv3State *s)
>  {
> @@ -74,6 +75,9 @@ smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
>  static inline void smmuv3_accel_attach_bypass_hwpt(SMMUv3State *s)
>  {
>  }
> +static inline void smmuv3_accel_idr_override(SMMUv3State *s)
> +{
> +}
>  #endif
>  
>  #endif /* HW_ARM_SMMUV3_ACCEL_H */
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index a0f704fc35..0f3a61646a 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -300,6 +300,8 @@ static void smmuv3_init_regs(SMMUv3State *s)
>      s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
>      s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
>  
> +    smmuv3_accel_idr_override(s);
> +
>      s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
>      s->cmdq.prod = 0;
>      s->cmdq.cons = 0;
> @@ -1925,6 +1927,13 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>          return false;
>      }
>  #endif
> +    if (s->accel) {
> +        return true;
> +    }
> +    if (!s->ril) {
> +        error_setg(errp, "ril can only be disabled if accel=on");
> +        return false;
> +    }
>      return true;
>  }
>  
> @@ -2047,6 +2056,8 @@ static const Property smmuv3_properties[] = {
>       */
>      DEFINE_PROP_STRING("stage", SMMUv3State, stage),
>      DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
> +    /* RIL can be turned off for accel cases */
> +    DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
>  };
>  
>  static void smmuv3_instance_init(Object *obj)
> @@ -2074,6 +2085,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>                                            "Enable SMMUv3 accelerator support."
>                                            "Allows host SMMUv3 to be configured "
>                                            "in nested mode for vfio-pci dev assignment");
> +    object_class_property_set_description(klass, "ril",
> +        "Enable/disable range invalidation support");
if we decide to enable the prop only along with accel, might be worth to
document it here.
>  }
>  
>  static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index 874cbaaf32..c555ea684e 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -68,6 +68,7 @@ struct SMMUv3State {
>      bool accel;
>      struct SMMUv3AccelState  *s_accel;
>      Error  *migration_blocker;
> +    bool ril;
>  };
>  
>  typedef enum {
Thanks

Eric


