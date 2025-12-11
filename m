Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12998D41D50
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 15:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTiNZ-0000Qj-GU; Thu, 11 Dec 2025 10:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTiNK-0000Pe-1M
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:14:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTiNC-00022b-K7
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765466069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PgOtxE9nqPCjCi27I0jXQn3we88rBCDFHkgrancRUJM=;
 b=QJ3e1t55dhEJTRJ9+mA/HuMmiEBwTgdhno4iKU8tFfR0Qwx7aOp5ZYy9LXPk++n/70akIp
 +q4U1pHuHk3Eiv5RsO0Glcm/5y3A0hWQzJpl4YN2pSFjU+LucK4NCBHnmJwHtBaFJsqSRo
 +rHVcHof2d+U4ZSHFn+0Vlq+ZPok3Yo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-uhSi9mx_MbGjLiMgE9U4Tg-1; Thu, 11 Dec 2025 10:14:28 -0500
X-MC-Unique: uhSi9mx_MbGjLiMgE9U4Tg-1
X-Mimecast-MFC-AGG-ID: uhSi9mx_MbGjLiMgE9U4Tg_1765466067
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477771366cbso1607695e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 07:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765466067; x=1766070867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=PgOtxE9nqPCjCi27I0jXQn3we88rBCDFHkgrancRUJM=;
 b=KKhAK92dXob+5jPm/8eb6utZy+r355VodTo4sRbhAnviDY2Xbp37LAoYqXWQchI7+O
 e9lO79cwbgdtsgAustSAexkZ7h0H+bK6DliGp4evWFKuyWQL/ktawDTS7jhQK+9Pi4/G
 82aWHT7cuEfY6uCUZJum7XH/SsbYoS1JudPsHtCI09IfLDgmrS5tPKliMmh7MZewB1WO
 zcoioT5jIdlhn4mrwOWV2WItr9bvk8f032XISCNiPwyHiGsUZi6OdkeJQ1SC+KDiLdG6
 SuDhJGPtmkqHOgjLNGpx5/7RXooP8V5s0RYGIGF0Toy1yEdQXbZI/PmIGrMorhSzZamH
 np4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765466067; x=1766070867;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PgOtxE9nqPCjCi27I0jXQn3we88rBCDFHkgrancRUJM=;
 b=t7SjqGtukmUDL8dmJZphU0wrWJtBCA1TlW/GtEPeZBnRyxHD2AQNzdoLuK5NCZLCfL
 mLyrWYeKCwL1NV9qLn110r81PRBfcBHh0d2Zb/Jr/vCsv6HMg4phxOTyUSnzU4TTzRLe
 sTinAJlmHO4bOv1KMvPbNHf2XNfGIyyFZpORjldek0jrpa3TasD5Tw6cWuz92vpJrxi1
 KkZ5K5aK+P9MLekjwELQOQP7pXgvDrEH/Y4j+hV+jTN4EJzZZOsgpT5LgGd+ksUEg1Rx
 vK7rMKixiduhDmN9JSsLFzseuRqCtvxP1q5TFgwsIYtNataMI8tYRDR/8tijYEycTrJQ
 Yvog==
X-Forwarded-Encrypted: i=1;
 AJvYcCU21pakZBFEp/HUlysC8ZS6Zuwoc7cCbBlS5Z3ImLlBc5Q8C3C/VFqTdw3prjzP2zt4jqQNqvxWDnzw@nongnu.org
X-Gm-Message-State: AOJu0Yz/GYROkM3SC0x19wtwoNDfggJlH1UHKOxIIZAjGZBbyaipNxvr
 utL/yO5y1+zkb27TRTyFPglqOtc0mJf9f7PxsvspLI+lcOv88O3G38YUg7N341CufNuGq/4uwZF
 3ZlJoccKj1arYyCXlKDC6T+od7JtCjWC5gyKexGJd/oVFmObrptA0258B
X-Gm-Gg: AY/fxX6Ou9mCTZfybOvKqiaZtmJkwLNJ11qXM9MSuk1H2JrpxKiaC7HLkOh1+YjFSVH
 hP1namnJRol3Ojj8+m4hutG9eWmrSfrvZsvUn78JIJo1yetnCs+XiHZyRbZ0x3NYiaQjhhxntx5
 9gxUBGzvq5PXqOdgcCPktDnw0l1cXYcOapw84IXJ03sfpaES/lejGT4ZF6Y6NmuAk3MqVVCBVpA
 GiTFplm/M0c4yzWBqp7Koc4/LVCqseq7yeu5ZhU2J0btFN8Z5g/1FeHtzeXlqUAkuRbVMv9Gi7J
 3Hh2Lwe5RgPwiN4VEZr7IWyn1eCNIVoRNGzuypOueN8T1h6U1llpSe2f/weMxBw4dwj3KkHhLUq
 n4oFlwSBFLZ9XZcuA+Ob3uyM0O/9LtxvBK0aXXONETGzAupy8
X-Received: by 2002:a05:600c:1e88:b0:477:9cdb:e337 with SMTP id
 5b1f17b1804b1-47a8374cf08mr53560345e9.7.1765466066642; 
 Thu, 11 Dec 2025 07:14:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGksB8/PEJNh0N9xrtRNfYAwNYELy9HhUrwvAvpzlf9pwxJ2fSglCyQ4BAyDv082euBRFdshg==
X-Received: by 2002:a05:600c:1e88:b0:477:9cdb:e337 with SMTP id
 5b1f17b1804b1-47a8374cf08mr53560085e9.7.1765466066153; 
 Thu, 11 Dec 2025 07:14:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a89f1eb60sm15735305e9.20.2025.12.11.07.14.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 07:14:25 -0800 (PST)
Message-ID: <ab3b406b-749d-4259-82bb-f34b084a9769@redhat.com>
Date: Thu, 11 Dec 2025 16:14:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 27/33] hw/arm/smmuv3-accel: Add a property to specify
 RIL support
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, ddutile@redhat.com, berrange@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, kjaju@nvidia.com
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-28-skolothumtho@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251120132213.56581-28-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/20/25 14:22, Shameer Kolothum wrote:
> Currently QEMU SMMUv3 has RIL support by default. But if accelerated mode
> is enabled, RIL has to be compatible with host SMMUv3 support.
> 
> Add a property so that the user can specify this.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   hw/arm/smmuv3-accel.c   | 14 ++++++++++++--
>   hw/arm/smmuv3-accel.h   |  4 ++++
>   hw/arm/smmuv3.c         | 12 ++++++++++++
>   include/hw/arm/smmuv3.h |  1 +
>   4 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index aae7840c40..b6429c8b42 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -62,8 +62,8 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>           return false;
>       }
>   
> -    /* QEMU SMMUv3 supports Range Invalidation by default */
> -    if (FIELD_EX32(info->idr[3], IDR3, RIL) !=
> +    /* User can disable QEMU SMMUv3 Range Invalidation support */
> +    if (FIELD_EX32(info->idr[3], IDR3, RIL) >
>                   FIELD_EX32(s->idr[3], IDR3, RIL)) {
>           error_setg(errp, "Host SMMUv3 doesn't support Range Invalidation");
>           return false;
> @@ -639,6 +639,16 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
>       .get_msi_direct_gpa = smmuv3_accel_get_msi_gpa,
>   };
>   
> +void smmuv3_accel_idr_override(SMMUv3State *s)
> +{
> +    if (!s->accel) {
> +        return;
> +    }

Those :

    if (s->accel)

in the code reveal a modeling issue.

> +
> +    /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
> +    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
> +}
> +
>   /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
>   bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
>   {
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 7186817264..2f2904d86b 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -47,6 +47,7 @@ bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
>   bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp);
>   bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
>                                   Error **errp);
> +void smmuv3_accel_idr_override(SMMUv3State *s);
>   void smmuv3_accel_reset(SMMUv3State *s);
>   #else
>   static inline void smmuv3_accel_init(SMMUv3State *s)
> @@ -74,6 +75,9 @@ smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
>   {
>       return true;
>   }
> +static inline void smmuv3_accel_idr_override(SMMUv3State *s)
> +{
> +}
>   static inline void smmuv3_accel_reset(SMMUv3State *s)
>   {
>   }
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 8352dd5757..296afbe503 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -305,6 +305,7 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
>       s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
>       s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
>       s->aidr = 0x1;
> +    smmuv3_accel_idr_override(s);
>   }
>   
>   static void smmuv3_reset(SMMUv3State *s)
> @@ -1924,6 +1925,13 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>           return false;
>       }
>   #endif
> +    if (!s->accel) {
> +        if (!s->ril) {
> +            error_setg(errp, "ril can only be disabled if accel=on");
> +            return false;
> +        }
> +        return true;
> +    }
>       return true;
>   }
>   
> @@ -2047,6 +2055,8 @@ static const Property smmuv3_properties[] = {
>       DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
>       /* GPA of MSI doorbell, for SMMUv3 accel use. */
>       DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
> +    /* RIL can be turned off for accel cases */
> +    DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),

yep. Adding a QOM model would clarify a lot of things.

C.


>   };
>   
>   static void smmuv3_instance_init(Object *obj)
> @@ -2072,6 +2082,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>       object_class_property_set_description(klass, "accel",
>           "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
>           "configured in nested mode for vfio-pci dev assignment");
> +    object_class_property_set_description(klass, "ril",
> +        "Disable range invalidation support (for accel=on)");
>   }
>   
>   static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index 9c39acd5ca..533a2182e8 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -69,6 +69,7 @@ struct SMMUv3State {
>       struct SMMUv3AccelState *s_accel;
>       uint64_t msi_gpa;
>       Error *migration_blocker;
> +    bool ril;
>   };
>   
>   typedef enum {


