Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85A5CCFA19
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 08:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGvdI-0001pJ-F2; Thu, 06 Nov 2025 03:46:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vGvdF-0001o9-Mx
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 03:46:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vGvdD-0001A9-Ty
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 03:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762418771;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L1Hvu5InP1NiVOb7qGH8XRbwDQN1L1qk73OrVYDw2B8=;
 b=HwOZ2l0ehjXivEis0eamBTVGvVHBl0FKxkSlalsgvLbwP5PlYB+P0iX4UGOpN1t2FaUpkq
 xPduLZSnCsHGu4J9T6dZ0XhwmH3enO+uUnYC+9xgwTlKHGEzlkUR17h7FGLF79De0SWAeo
 J2jl1aUaAuxQG140+QY4zjDn3WGafpY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-DY6_XcMpPuaJj3M__y8sCQ-1; Thu, 06 Nov 2025 03:45:59 -0500
X-MC-Unique: DY6_XcMpPuaJj3M__y8sCQ-1
X-Mimecast-MFC-AGG-ID: DY6_XcMpPuaJj3M__y8sCQ_1762418758
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e47d14dceso3028145e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 00:45:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762418758; x=1763023558;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L1Hvu5InP1NiVOb7qGH8XRbwDQN1L1qk73OrVYDw2B8=;
 b=K02NGtxSG1CMgMWnaRDKyrOdYFbl7dNB7ujEgBNdRLrAb6cuAZyfUu/PaFw7nz65zI
 Tja/oqLeC95kmBpP6iYZ1G2jNcVxYEFvX7k8j+aQyo0EC+yPidJghWngI+OIkpr66mqQ
 BO7f66LNUPO+LUqOLhAnE5hUE52mf0HCLU9aFd6Xq4LRkONotT+rJE3AnVxaG6JEbwFT
 oQ6Muc0G+qMOnWDLiB9d4agRg795Q0Xec8BEw4KXEgEcAMreCsfy6X43/nK/73iIYk+2
 rh2v+06xBuZURG25BSsgPcMZ17v5AWUpdpvy+dqXOAEwwr2IS1MNS8nIb3h6nJathTTe
 bPFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNaX0jiGieSVkxtX0bIsa3gjCBncEu/ycWpuqqJv8vXkOGnOI0mbj2oqUST2Qe/OH3G431VPIkQvxF@nongnu.org
X-Gm-Message-State: AOJu0YxS6MDy6Lq2NbchUYbD75X2mvpRPew28k8o8epeODtG1mcVsHOR
 SZ7XgH2BaL/9wPBVZcTyk+34jR1bCJo5YtwkOTKLETPfso5uf+H1dierLXK6pbuncv7zuH24abc
 Q2Ct9fSlA29hHKc5zl89cK8fhFePvlHdH+60aymuPEtd/nqoHGZO42grW
X-Gm-Gg: ASbGncsFH+fAzfBawHgyOu9ePOTr4XMCr8FH50beIhjsf+gTSSHo50fWsgdzG0zyM+G
 HxlkpDbkPCpHWQP2XEX3sVEMWeFAjU9B9vUK8iPjJorknlCmu6B/VyeEw0wkDpVYp9Xas0EjmS/
 4W5iTEleuG9e1t3TS1BeLN2hvXZKp5AaNuIhaRFIhXyr/mA/+Ua5Pw+WIctKxJqP3H/YsjAFDLy
 nIMw0JLZGrbrlOp6nfjIzLvFanqwy5ZawVM8P+TlO3oyyLbFUWTX5aFDTqgErA9fCJjUQovVeBr
 +CErFFBA54P/0ymQqiN61Dv8J6izsJ/2svIERup/f3e1XZl5tzA1M9/5LVhyCJ9/JyxHLMwVqKg
 W9pnVyfSyaW0bA5arw2MsGBHvU0EWgA2jtRvn+kbDa/KWEA==
X-Received: by 2002:a05:600c:45c7:b0:477:19c2:9765 with SMTP id
 5b1f17b1804b1-4775cdad684mr58104245e9.4.1762418758251; 
 Thu, 06 Nov 2025 00:45:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRsJ/vUrRvb6R51p9yDw2mUterNInMI9xJbtNzCEsIig1yamvxe62pvURMCrgSultJhDo8vA==
X-Received: by 2002:a05:600c:45c7:b0:477:19c2:9765 with SMTP id
 5b1f17b1804b1-4775cdad684mr58103995e9.4.1762418757802; 
 Thu, 06 Nov 2025 00:45:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429ef2d58c2sm1723932f8f.16.2025.11.06.00.45.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 00:45:57 -0800 (PST)
Message-ID: <518b7ace-f71c-43d4-bd85-7dc485c19649@redhat.com>
Date: Thu, 6 Nov 2025 09:45:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 30/32] Extend get_cap() callback to support PASID
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
 <20251031105005.24618-31-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251031105005.24618-31-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Modify get_cap() callback so that it can return cap via an output
> uint64_t param. And add support for generic iommu hw capability
> info and max_pasid_log2(pasid width).
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  backends/iommufd.c                 | 18 +++++++++++++++---
>  hw/i386/intel_iommu.c              |  5 +++--
>  hw/vfio/container-legacy.c         |  8 ++++++--
>  include/system/host_iommu_device.h | 14 ++++++++++----
>  4 files changed, 34 insertions(+), 11 deletions(-)
>
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 6381f9664b..392f9cf2a8 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -523,19 +523,31 @@ bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>      return idevc->detach_hwpt(idev, errp);
>  }
>  
> -static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
> +static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap,
s/cap/capid? to avoid confusion with actual cap value?
> +                                uint64_t *out_cap, Error **errp)
>  {
>      HostIOMMUDeviceCaps *caps = &hiod->caps;
>  
> +    g_assert(out_cap);
> +
>      switch (cap) {
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
>          error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
>          return -EINVAL;
>      }
> +    return 0;
>  }
>  
>  static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 6a168d5107..91d0d643ea 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4444,6 +4444,7 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>                             Error **errp)
>  {
>      HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
> +    uint64_t out_cap;
>      int ret;
>  
>      if (!hiodc->get_cap) {
> @@ -4452,11 +4453,11 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>      }
>  
>      /* Common checks */
> -    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_AW_BITS, errp);
> +    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_AW_BITS, &out_cap, errp);
>      if (ret < 0) {
>          return false;
>      }
> -    if (s->aw_bits > ret) {
> +    if (s->aw_bits > out_cap) {
>          error_setg(errp, "aw-bits %d > host aw-bits %d", s->aw_bits, ret);
you also need to replace ret and out_cap here and also use 0x%PRIx64
>          return false;
>      }
> diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
> index a3615d7b5d..ac8370bd4b 100644
> --- a/hw/vfio/container-legacy.c
> +++ b/hw/vfio/container-legacy.c
> @@ -1197,15 +1197,19 @@ static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
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
> index bfb2b60478..f89dbafd9e 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
> @@ -94,13 +94,15 @@ struct HostIOMMUDeviceClass {
>       *
>       * @cap: capability to check.
>       *
> +     * @out_cap: 0 if a @cap is unsupported or else 1 or some positive
> +     * value for some special @cap, i.e., HOST_IOMMU_DEVICE_CAP_AW_BITS.
this does not match what is done in the impl. In case @cap is not
supported you do not zero it.
> +     *
>       * @errp: pass an Error out when fails to query capability.
>       *
> -     * Returns: <0 on failure, 0 if a @cap is unsupported, or else
> -     * 1 or some positive value for some special @cap,
I would rather say the capability value
> -     * i.e., HOST_IOMMU_DEVICE_CAP_AW_BITS.
> +     * Returns: <0 on failure, 0 on success.
<0 if cap is not supported
>       */
> -    int (*get_cap)(HostIOMMUDevice *hiod, int cap, Error **errp);
> +    int (*get_cap)(HostIOMMUDevice *hiod, int cap, uint64_t *out_cap,
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
Eric


