Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759D3CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 18:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDRl6-0004Ou-ND; Mon, 27 Oct 2025 14:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDRku-0004L4-Vv
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDRkn-0003qk-IH
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761588928;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NlPU6INEkr+d8DWhH3VNveZdJMLbf5AEBQljCmivt7Y=;
 b=Kj2k8wl7UNXJ3mVPxz0wLxtYuD6k4OOvbszytHuCEuAbDqnOXXwQjFjSdwYkLaYnvzw1mZ
 M5XfkwwAxtXeTGxshiTHeNO8Ap0gLi2B/1jzzvw7KEEadiXZ6M5V1lCdAUWj9/QM3dvOV6
 WdhZlmf2oVXxPwfj0ok3elizazEojkE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-vfo5tqcDOsSaLLOYwKs16w-1; Mon, 27 Oct 2025 14:15:27 -0400
X-MC-Unique: vfo5tqcDOsSaLLOYwKs16w-1
X-Mimecast-MFC-AGG-ID: vfo5tqcDOsSaLLOYwKs16w_1761588926
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-40cfb98eddbso3345319f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 11:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761588926; x=1762193726;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NlPU6INEkr+d8DWhH3VNveZdJMLbf5AEBQljCmivt7Y=;
 b=MoAcxvDFQc8YYMoR5X/DgFCfb5IDhcdKMX6CwlKQU9GlOKy4SvruHITNphc3Ob6LtY
 eKDXrZONDArJrdkwuH4jm2OlLiixK3rB+VZ4pUNL0TGNpJ/1dnZbmBakVupcFrWtdpl5
 Qol7WJyp3nEtWTyPEjDLxw7FCgAUAApveKP+BU8J0nJWAxBiinxE0+NnuZUxWBFV7gq1
 jztRVQHYXhQczb0LJgbAVqHmRQBJr/ywV/9DXpUJmExYOdD54Jtmbl3UG6ZI/yyRYh8C
 b9MsRD+2sFrGnrh70uY6alVBPYYWy5KGG6J6GvkN0IHQLsG2quKtO7oEmMOds0Z1vBAy
 qdBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQhAoRLelfdGyNoNgvgGQhdbhOxouvxNL+jTl+vYpNYDRgEx/V8Uzqp4mqvXPRTTmHGJZJut+rrJUO@nongnu.org
X-Gm-Message-State: AOJu0Yzbx+pBDCVXrHjSJU8PPvB5+DnNyjWCs8WuvSyrzaGw+kWexCw0
 BzwL0p1RC3KUo6ryPZTYG3zouek3tayBSKdFUXAOpXE1xV3jDXwVvLM9ZpzMEJgobCAbmyw/Bj8
 hpWnfC/mh+qkQy5P15VzvLGuT5PV4l8Ezn1gZr9U10fAyPIHptotkSwgV
X-Gm-Gg: ASbGncvg7fLXRTAvwA+jw6YgWZwgeLGRajizfKITwHET3R7x7tVEdvlrn63MMRiIkHZ
 2AMxXhaJVf1KPkyjazWfzN1Sc1TB3vOnJcGnMWcV9XwKoLsFVPcgI6JTNwd+pJUga6tWkal2g/a
 cTVLV2yeg+W29fEnzu6aZE8xXpEU4QwK6LFE6DYe2C/h6Q9XQSyRtR9OjXuXwpBaUTUuUwoBJhh
 Ba6KPIUg4G+4jmXBWfQ1+pfu+u+F+35xb6YqWJdEGFghTSA4x9Raus4h/mUm70rfvUzX09tPEYI
 EmQyn3d/T43VCAWFxjSxxVufcXdFTnu+RJ0X4ed+XfVE60ldYpHUZcUfWJmTUEFlwvifsc11lud
 D8Z8RT6QKK3gwNsZ9NPc1ml8Ih9e6ga3GiZi++ySU9q2WCw==
X-Received: by 2002:a05:6000:4026:b0:429:8b01:c0a1 with SMTP id
 ffacd0b85a97d-429a83e5042mr356139f8f.28.1761588926138; 
 Mon, 27 Oct 2025 11:15:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsba+lI3QJ7uNt6CK7w6dX8AJirT51qqgUAN+AH0jdAWRSsJevtWPgbWHgci2Ivc+FZibmQQ==
X-Received: by 2002:a05:6000:4026:b0:429:8b01:c0a1 with SMTP id
 ffacd0b85a97d-429a83e5042mr356112f8f.28.1761588925718; 
 Mon, 27 Oct 2025 11:15:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cb55asm15551916f8f.17.2025.10.27.11.15.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 11:15:25 -0700 (PDT)
Message-ID: <e4eef901-174a-4dad-bd0a-860d705673e1@redhat.com>
Date: Mon, 27 Oct 2025 19:15:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/27] hw.arm/smmuv3: Add support for PASID enable
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
 <20250929133643.38961-28-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250929133643.38961-28-skolothumtho@nvidia.com>
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

Hi Shameer,

On 9/29/25 3:36 PM, Shameer Kolothum wrote:
> QEMU SMMUv3 currently forces SSID (Substream ID) to zero. One key use case
> for accelerated mode is Shared Virtual Addressing (SVA), which requires
> SSID support so the guest can maintain multiple context descriptors per
> substream ID.
>
> Provide an option for user to enable PASID support. A SSIDSIZE of 16
> is currently used as default.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c    | 24 +++++++++++++++++++++++-
>  hw/arm/smmuv3-internal.h |  1 +
>  hw/arm/smmuv3.c          |  8 +++++++-
>  include/hw/arm/smmuv3.h  |  1 +
>  4 files changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 283d36e6cd..0de9598dcb 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -79,6 +79,13 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>          return false;
>      }
>  
> +    /* If user enables PASID support(pasid=on), QEMU sets SSIDSIZE to 16 */
> +    val = FIELD_EX32(info->idr[1], IDR1, SSIDSIZE);
> +    if (val < FIELD_EX32(s->idr[1], IDR1, SSIDSIZE)) {
> +        error_setg(errp, "Host SUMMUv3 SSIDSIZE not compatible");
> +        return false;
> +    }
> +
>      /* User can override QEMU SMMUv3 Range Invalidation support */
>      val = FIELD_EX32(info->idr[3], IDR3, RIL);
>      if (val != FIELD_EX32(s->idr[3], IDR3, RIL)) {
> @@ -635,7 +642,14 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
>       * The real HW nested support should be reported from host SMMUv3 and if
>       * it doesn't, the nesting parent allocation will fail anyway in VFIO core.
>       */
> -    return VIOMMU_FLAG_WANT_NESTING_PARENT;
> +    uint64_t flags = VIOMMU_FLAG_WANT_NESTING_PARENT;
> +    SMMUState *bs = opaque;
> +    SMMUv3State *s = ARM_SMMUV3(bs);
> +
> +    if (s->pasid) {
> +        flags |= VIOMMU_FLAG_PASID_SUPPORTED;
> +    }
> +    return flags;
>  }
>  
>  static const PCIIOMMUOps smmuv3_accel_ops = {
> @@ -664,6 +678,14 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>      if (s->oas == 48) {
>          s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
>      }
> +
> +    /*
> +     * By default QEMU SMMUv3 has no PASID(SSID) support. Update IDR1 if user
> +     * has enabled it.
> +     */
> +    if (s->pasid) {
> +        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE, SMMU_IDR1_SSIDSIZE);
> +    }
>  }
>  
>  /*
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 910a34e05b..38e9da245b 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -81,6 +81,7 @@ REG32(IDR1,                0x4)
>      FIELD(IDR1, ECMDQ,        31, 1)
>  
>  #define SMMU_IDR1_SIDSIZE 16
> +#define SMMU_IDR1_SSIDSIZE 16
>  #define SMMU_CMDQS   19
>  #define SMMU_EVENTQS 19
>  
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 7c391ab711..f7a1635ec7 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -604,7 +604,8 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>          }
>      }
>  
> -    if (STE_S1CDMAX(ste) != 0) {
> +    /* If pasid enabled, we report SSIDSIZE = 16 */
why do we chose 16 and not a bigger value to avoid incompatibility?
worth a comment
> +    if (!FIELD_EX32(s->idr[1], IDR1, SSIDSIZE) && STE_S1CDMAX(ste) != 0) {
>          qemu_log_mask(LOG_UNIMP,
>                        "SMMUv3 does not support multiple context descriptors yet\n");
>          goto bad_ste;
> @@ -1962,6 +1963,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>          error_setg(errp, "oas can only be set to 44 bits if accel=off");
>          return false;
>      }
> +    if (s->pasid) {
> +        error_setg(errp, "pasid can only be enabled if accel=on");
> +        return false;
> +    }
>      return true;
>  }
Just skimming though the SMMU spec, I don't see any handling for
STE.S1DSS anywhere
Also I would expect some C_BAD_SUBSTREAMID likely to be emitted?

Thanks

Eric
>  
> @@ -2088,6 +2093,7 @@ static const Property smmuv3_properties[] = {
>      DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
>      DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
>      DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
> +    DEFINE_PROP_BOOL("pasid", SMMUv3State, pasid, false),
>  };
>  
>  static void smmuv3_instance_init(Object *obj)
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index d3788b2d85..3781b79fc8 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -71,6 +71,7 @@ struct SMMUv3State {
>      bool ril;
>      bool ats;
>      uint8_t oas;
> +    bool pasid;
>  };
>  
>  typedef enum {


