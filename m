Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A58FCCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 14:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOdr-0003X3-S7; Mon, 27 Oct 2025 10:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDOdp-0003WZ-4N
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:56:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDOdd-0001jZ-9Y
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761576950;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tVerbbE405LAzakn5L8OBSutixPaXaTVwINnDEUYcJg=;
 b=JNddsd86fIaddI2WXOfEr5PuXTKMoFXt83vSkZZK9PwN4GaPlp7j1d84au86XMl2moSwB3
 9Z0gFk7yTpKjAVkZgJzzFoE9F1HZJmehSoUSlHfaumvExgKGbhsn6QdktM3C4+Jz/qlcLI
 KAl7iODX2e9T0Z5ECc1ySjAt9d8qw0Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-l6lN_b2XN-KhdIVEhBLl3A-1; Mon, 27 Oct 2025 10:55:48 -0400
X-MC-Unique: l6lN_b2XN-KhdIVEhBLl3A-1
X-Mimecast-MFC-AGG-ID: l6lN_b2XN-KhdIVEhBLl3A_1761576948
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4710d174c31so47483625e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 07:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761576948; x=1762181748;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tVerbbE405LAzakn5L8OBSutixPaXaTVwINnDEUYcJg=;
 b=BV8RaLJyTki2OHddolSFzvqlhIbIUiLpV2WYRiLopxiXAn7DgGzFPAYQdDBUDiuSXn
 xIbiafVFNSjpjJxoaY7haINGmWlKPRLht6Qbwht/gbr9YXbAiNaNYN7AYuaTByGUqdPB
 il3Cl3e8t3+ASLdtjRaU/wj/EEuFlv3Xa/JULFOJJv1kLSAyf6BjOpUf5ddXxIytUEaB
 +ACN1/4Qt/ZtffssDfKa4iZdNJUqyQCszta9/gl40YW54vMj4i0hzxdhBL4T/ySyLCrk
 a+P3lawWW2Cr2qCsK1f8wE6631grjlDxKsmcatHQkZ2oAxm6c1VgRO4ZJ7s9rGznMhCr
 o0KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZW97UZOGiMke1BRcvjstBiz6u3aUG0w7/I+Zb86WqzYHcRPpBHjPR6M6eJUtBg86xj1kDK2ExDzho@nongnu.org
X-Gm-Message-State: AOJu0Ywkurug3A94h8Ln9DImlQ9qVK27/4/n8IM2pZMTd7HTt82M4Qym
 AAS2xVcGxdQBiY0xCnLXdjDkUzWrtpgo4tROY+QM/OnMNGlnNLG2yqewoGTjsUa5+bJMK3GBZVe
 bhPQwPQpdKANVgMJfqx6xAq5yIomNAHqZDrTwBRgln/UEhV+PV1Xc8qW4
X-Gm-Gg: ASbGncvXq88PQyU3LEBAfVXb9Q7yQdEBfAJvPaSzQes9jk+PhiJas1a9OTT0zEA9afY
 UiaQt+SYM4Qb28mNX1TMhdCbk9dstqXyaRFX4uSyjs9Wg6NNYyOy7sAociMnfqAge0YZUOmKk55
 eifMRrOv57JWDmJNrao+33sHg8shZM5ITPN805eEb3CHIuKNrj0U/HhzzNw9piXh/mTsEfEmc24
 fc0v3QNHUIdhr6p8ptCLU4iYxBFe9ceF+Ov10CFg/KYWho8DbSIs7bvQvXes5TnLYyCxWfa5yKr
 aiVTDkwqE34EdL5y+CDAxQL6ek91APpscXB+NW2CmzQK1ZgM/Iuxjgsk6XTOHL50Zvo5KUjQhpR
 RIB0g4jNvZR+zfkUbldg+LrYf5UxUxYS0QEkgeEb5Mxw8Iw==
X-Received: by 2002:a05:600c:34d0:b0:46d:cfc9:1d0f with SMTP id
 5b1f17b1804b1-471179067e6mr294702665e9.19.1761576947630; 
 Mon, 27 Oct 2025 07:55:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU4iMIlsaSciaaD6WumXf+u5DtARF5+VSJ/d4+EZnKRY1Z+2xpbIi7iDXkryKQYbN0qTTLCQ==
X-Received: by 2002:a05:600c:34d0:b0:46d:cfc9:1d0f with SMTP id
 5b1f17b1804b1-471179067e6mr294702305e9.19.1761576947171; 
 Mon, 27 Oct 2025 07:55:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cb7e8sm15061460f8f.19.2025.10.27.07.55.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 07:55:46 -0700 (PDT)
Message-ID: <dd41dfd5-6fc7-4fff-b995-db0114a6f4f2@redhat.com>
Date: Mon, 27 Oct 2025 15:55:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/27] hw/arm/smmuv3-accel: Add property to specify OAS
 bits
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
 <20250929133643.38961-24-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250929133643.38961-24-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 9/29/25 3:36 PM, Shameer Kolothum wrote:
> QEMU SMMUv3 currently sets the output address size (OAS) to 44 bits. With
> accelerator mode enabled, a guest device may use SVA where CPU page tables
> are shared with SMMUv3, requiring OAS at least equal to the CPU OAS. Add
physical CPU OAS.
> a user option to set this.
>
> Note: Linux kernel docs currently state the OAS field in the IDR register
> is not meaningful for users. But looks like we need this information.
My concern is how will the above layers (libvirt) know how to set those
low level props?
At least in 14/27, during the compatibility check, you shall print the
host values to help the user determine the relevant option values
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c    | 15 +++++++++++++++
>  hw/arm/smmuv3-internal.h |  3 ++-
>  hw/arm/smmuv3.c          | 15 ++++++++++++++-
>  include/hw/arm/smmuv3.h  |  1 +
>  4 files changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index eee54316bf..ba37d690ad 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -86,6 +86,17 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>          return false;
>      }
>  
> +    /*
> +     * ToDo: OAS is not something Linux kernel doc says meaningful for user.
> +     * But looks like OAS needs to be compatibe for accelerator support. Please
compatible
> +     * check.
> +     */
> +    val = FIELD_EX32(info->idr[5], IDR5, OAS);
> +    if (val < FIELD_EX32(s->idr[5], IDR5, OAS)) {
> +        error_setg(errp, "Host SUMMUv3 OAS not compatible");
print the host value too
> +        return false;
> +    }
> +
>      val = FIELD_EX32(info->idr[5], IDR5, GRAN4K);
>      if (val != FIELD_EX32(s->idr[5], IDR5, GRAN4K)) {
>          error_setg(errp, "Host SMMUv3 doesn't support 64K translation granule");
> @@ -648,6 +659,10 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>      if (s->ats) {
>          s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 1); /* ATS */
>      }
> +    /* QEMU SMMUv3 has oas set 44. Update IDR5 if user has it set to 48 bits*/
> +    if (s->oas == 48) {
> +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
> +    }
>  }
>  
>  /*
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index b0dfa9465c..910a34e05b 100644
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
> index 77d46a9cd6..7c391ab711 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -294,7 +294,8 @@ static void smmuv3_init_regs(SMMUv3State *s)
>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
>  
> -    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS); /* 44 bits */
> +    /* OAS: 44 bits */
> +    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_44);
>      /* 4K, 16K and 64K granule support */
>      s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
>      s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
> @@ -1943,6 +1944,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>      }
>  #endif
>      if (s->accel) {
> +        if (s->oas != 44 && s->oas != 48) {
> +            error_setg(errp, "oas can only be set to 44 or 48 bits");
s/oas/OAS
> +            return false;
> +        }
>          return true;
>      }
>      if (!s->ril) {
> @@ -1953,6 +1958,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>          error_setg(errp, "ats can only be enabled if accel=on");
>          return false;
>      }
> +    if (s->oas != 44) {
> +        error_setg(errp, "oas can only be set to 44 bits if accel=off");
ditto
> +        return false;
> +    }
>      return true;
>  }
>  
> @@ -2078,6 +2087,7 @@ static const Property smmuv3_properties[] = {
>      /* RIL can be turned off for accel cases */
>      DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
>      DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
> +    DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
>  };
>  
>  static void smmuv3_instance_init(Object *obj)
> @@ -2110,6 +2120,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>      object_class_property_set_description(klass, "ats",
>          "Enable/disable ATS support. Please ensure host platform has ATS "
>          "support before enabling this");
> +    object_class_property_set_description(klass, "oas",
> +        "Specify Output Address Size. Supported values are 44 or 48 bits "
> +        "Defaults to 44 bits");
>  }
>  
>  static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index 6f07baa144..d3788b2d85 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -70,6 +70,7 @@ struct SMMUv3State {
>      Error  *migration_blocker;
>      bool ril;
>      bool ats;
> +    uint8_t oas;
>  };
>  
>  typedef enum {
Thanks

Eric


