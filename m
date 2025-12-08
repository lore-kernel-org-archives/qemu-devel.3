Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA97D3B7EA
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 17:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSev8-000348-Vf; Mon, 08 Dec 2025 12:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vSev4-000336-Fu
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 12:21:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vSev2-0003mZ-Cn
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 12:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765214463;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sjzHxxxnRSZ81YfwV7siPTJDYcVrZgUTvmtP5vI/n38=;
 b=XdHwQzQLT+cZ2bR6QwN0dB5LM+YKm3oDUbmZH7qYBBSbwndEZgDjZG21+ekwxBOZHWUnJH
 5Z4L8om3weIkOpsqtlzZD2mtfj1+9FUK+/vVHH6P8Ntit3U6yyR+CX2BCTG6A/P4pm/etl
 5XF3JLtI59LTKL8pMi7h+uSxjkdUF/E=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-H_2Zf59ZNxaeKJeafdujaw-1; Mon, 08 Dec 2025 12:21:02 -0500
X-MC-Unique: H_2Zf59ZNxaeKJeafdujaw-1
X-Mimecast-MFC-AGG-ID: H_2Zf59ZNxaeKJeafdujaw_1765214461
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4ed782d4c7dso78355141cf.2
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 09:21:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765214461; x=1765819261;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sjzHxxxnRSZ81YfwV7siPTJDYcVrZgUTvmtP5vI/n38=;
 b=CFn0RUCnCbGVRWgoedt1br/Ch+OgJRRfRSwHGwWw1NzC+zXV0piCZguf14q6NwXX5Y
 rFRM+SM8I7YA568XBCob0BohH/1yreR/G7q/QUMwTSLBIoSyiAvQLK7uiT4X2F7s3Bmy
 sItXeOoKYmedkk3uTOlm0R88JPuImImFulIUZWEA23/j3oZE2cVC9wbJQxJrvQ6G1nG/
 wQ6Ym6NcmgM1DB2u/urHgrC6WGN0cn8wRbtYCkfC1md8fRAPR1B9vHOJ2gVjCmlrSPIW
 hDgIfTL8kM/q9QndRhXMKs0jvw5OcVN6h4ARxUUpZF0JWZaEl8i7eMGI38VrsMLIXkjj
 tsRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxTp9/0IV2fCnkloOUJWf1K/i/3zb5cIdmgs3Qdtm1LdCV2u0qpxu99Lr6ZKY2Y6vjIOFD7xDCE8CP@nongnu.org
X-Gm-Message-State: AOJu0YxKP/RrWxCjJVSacHBy+vtdI5ZYr5CaKj9WDFdP4P8mPUPD5ln3
 5V48c2UJfyxWr7pjOBawhhPT+0ZKzMxxP5kiHtkxs3WnUs6l1K4e1fSyZZoNMPXiXCsvxQUlFVN
 Qq0tRdqfggtVqrEA2af54h4Mj8JSdto3GBIy3zCUJwNIIjkEN7XrO2yyo
X-Gm-Gg: ASbGncveeGFCaRY2x28bPuWflpXpJhuqg5gQqqKqmnUglbqIr3kw2RJyeqQfWnvNsqf
 yjtTAv+WObryl0LYNwqApyC5VuXrpYgiMa82PuRr7wBKYxA0rxNOAzka2qNH3ThSNQKv54PfX+Q
 /yjH9W5gkVnWV6L3pwf7QaZMQpmfQyoCYEcJaXDyXwEHdk21uxetrWCOcrHT7IvufYVifVF9bGk
 lHLTEvLDaN180Q0Dps64FxeOFcMS6HvC6vbIlJ3BpVHYHt3AJU0QuyfdervnK66ahhnfvZKpdl7
 g0VtPH78jyDPoErt8gVaQbBiSbxQOjQpiP68at+aFHfDLzuhaHTlBO20BDLu2/og2fw1Gw8U+PJ
 JFLm5ACJR6uN2ciyvOrFHKm9WgcfETstRYynz4MAPrySGJJGHHfQlE2s9Gw==
X-Received: by 2002:a05:622a:248e:b0:4ee:bff:7fbf with SMTP id
 d75a77b69052e-4f03fd4e99bmr145202341cf.4.1765214461264; 
 Mon, 08 Dec 2025 09:21:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHC/M32qKG/+HveL3Xnq+CKcGLBrkjWgMxhJtjPxIspGhfFaREMF11/oOVEAkTyq3i2oM7ZZg==
X-Received: by 2002:a05:622a:248e:b0:4ee:bff:7fbf with SMTP id
 d75a77b69052e-4f03fd4e99bmr145201701cf.4.1765214460730; 
 Mon, 08 Dec 2025 09:21:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88827f4f4b1sm113128316d6.22.2025.12.08.09.20.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 09:21:00 -0800 (PST)
Message-ID: <be5c998c-ce55-4b42-8efb-87a619d76c28@redhat.com>
Date: Mon, 8 Dec 2025 18:20:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 31/33] Extend get_cap() callback to support PASID
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 kjaju@nvidia.com
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-32-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251120132213.56581-32-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 11/20/25 2:22 PM, Shameer Kolothum wrote:
> Modify get_cap() callback so that it can return cap via an output
> uint64_t param. And add support for generic iommu hw capability
> info and max_pasid_log2(pasid width).
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  backends/iommufd.c                 | 23 ++++++++++++++++++-----
>  hw/i386/intel_iommu.c              |  8 +++++---
>  hw/vfio/container-legacy.c         |  8 ++++++--
>  include/system/host_iommu_device.h | 18 ++++++++++++------
>  4 files changed, 41 insertions(+), 16 deletions(-)
>
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 6381f9664b..718d63f5cf 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -523,19 +523,32 @@ bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>      return idevc->detach_hwpt(idev, errp);
>  }
>  
> -static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
> +static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap_id,
> +                                uint64_t *out_cap, Error **errp)
>  {
>      HostIOMMUDeviceCaps *caps = &hiod->caps;
>  
> -    switch (cap) {
> +    g_assert(out_cap);
> +
> +    switch (cap_id) {
>      case HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE:
> -        return caps->type;
> +        *out_cap = caps->type;
> +        break;
>      case HOST_IOMMU_DEVICE_CAP_AW_BITS:
> -        return vfio_device_get_aw_bits(hiod->agent);
> +        *out_cap = vfio_device_get_aw_bits(hiod->agent);
> +        break;
> +    case HOST_IOMMU_DEVICE_CAP_GENERIC_HW:
> +        *out_cap = caps->hw_caps;
> +        break;
> +    case HOST_IOMMU_DEVICE_CAP_MAX_PASID_LOG2:
> +        *out_cap = caps->max_pasid_log2;
> +        break;
>      default:
> -        error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
> +        *out_cap = 0;
not sure it is needed.

besides

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> +        error_setg(errp, "%s: unsupported capability %x", hiod->name, cap_id);
>          return -EINVAL;
>      }
> +    return 0;
>  }
>  
>  static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 78b142ccea..d5c131a814 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4605,6 +4605,7 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>                             Error **errp)
>  {
>      HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
> +    uint64_t out_cap;
>      int ret;
>  
>      if (!hiodc->get_cap) {
> @@ -4613,12 +4614,13 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>      }
>  
>      /* Common checks */
> -    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_AW_BITS, errp);
> +    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_AW_BITS, &out_cap, errp);
>      if (ret < 0) {
>          return false;
>      }
> -    if (s->aw_bits > ret) {
> -        error_setg(errp, "aw-bits %d > host aw-bits %d", s->aw_bits, ret);
> +    if (s->aw_bits > out_cap) {
> +        error_setg(errp, "aw-bits %d > host aw-bits 0x%" PRIx64, s->aw_bits,
> +                   out_cap);
>          return false;
>      }
>  
> diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
> index 32c260b345..1acf063762 100644
> --- a/hw/vfio/container-legacy.c
> +++ b/hw/vfio/container-legacy.c
> @@ -1203,15 +1203,19 @@ static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>  }
>  
>  static int hiod_legacy_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
> -                                    Error **errp)
> +                                    uint64_t *out_cap, Error **errp)
>  {
> +    g_assert(out_cap);
> +
>      switch (cap) {
>      case HOST_IOMMU_DEVICE_CAP_AW_BITS:
> -        return vfio_device_get_aw_bits(hiod->agent);
> +        *out_cap = vfio_device_get_aw_bits(hiod->agent);
> +        break;
>      default:
>          error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
>          return -EINVAL;
>      }
> +    return 0;
>  }
>  
>  static GList *
> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
> index bfb2b60478..4e891e5225 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
> @@ -88,19 +88,21 @@ struct HostIOMMUDeviceClass {
>       * @get_cap: check if a host IOMMU device capability is supported.
>       *
>       * Optional callback, if not implemented, hint not supporting query
> -     * of @cap.
> +     * of @cap_id.
>       *
>       * @hiod: pointer to a host IOMMU device instance.
>       *
> -     * @cap: capability to check.
> +     * @cap_id: capability to check.
> +     *
> +     * @out_cap: 0 if a @cap_id is unsupported or else the capability
> +     * value for @cap_id.
>       *
>       * @errp: pass an Error out when fails to query capability.
>       *
> -     * Returns: <0 on failure, 0 if a @cap is unsupported, or else
> -     * 1 or some positive value for some special @cap,
> -     * i.e., HOST_IOMMU_DEVICE_CAP_AW_BITS.
> +     * Returns: <0 if @cap_id is not supported, 0 on success.
>       */
> -    int (*get_cap)(HostIOMMUDevice *hiod, int cap, Error **errp);
> +    int (*get_cap)(HostIOMMUDevice *hiod, int cap_id, uint64_t *out_cap,
> +                   Error **errp);
>      /**
>       * @get_iova_ranges: Return the list of usable iova_ranges along with
>       * @hiod Host IOMMU device
> @@ -123,6 +125,10 @@ struct HostIOMMUDeviceClass {
>   */
>  #define HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE        0
>  #define HOST_IOMMU_DEVICE_CAP_AW_BITS           1
> +/* Generic IOMMU HW capability info */
> +#define HOST_IOMMU_DEVICE_CAP_GENERIC_HW        2
> +/* PASID width */
> +#define HOST_IOMMU_DEVICE_CAP_MAX_PASID_LOG2    3
>  
>  #define HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX       64
>  #endif


