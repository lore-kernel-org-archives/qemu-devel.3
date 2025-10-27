Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471C5CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 17:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDR1b-0001g4-VT; Mon, 27 Oct 2025 13:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDR1a-0001fe-5K
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 13:28:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDR1Q-0005pP-7P
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 13:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761586119;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nLIboskL/rQ/k7TUMmbaT8PpA+hD/Sk2wIipoyR6JjE=;
 b=U/gmkKM0Hjvod2WE9y9Z3myXmXed9364rcc7kU1SpiRpkQrP4n3rXOIAAoTyinFMi1JJLr
 st8bw6BR6Crvd7IGnYOa8vdzCCAl3aMnhOFbqaZxdnyJRJrpatp86NLGUsJ/vGAD+xY+gQ
 fR3N3oDHJxn3ZuDDOQVh5qmzvLINt3Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-8-E8pKyTO5O7meDuGAQcFg-1; Mon, 27 Oct 2025 13:28:37 -0400
X-MC-Unique: 8-E8pKyTO5O7meDuGAQcFg-1
X-Mimecast-MFC-AGG-ID: 8-E8pKyTO5O7meDuGAQcFg_1761586116
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4256fae4b46so3823911f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 10:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761586116; x=1762190916;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nLIboskL/rQ/k7TUMmbaT8PpA+hD/Sk2wIipoyR6JjE=;
 b=UnWh4LvqovStFeB4DnF8F+Xaxp+C69begTSy65mWC4ooBxrpmow68aLFDqT1zUZXJx
 yJsK/zNljmeq19chQFFW/HKDEt/lt76tobmsBDQI5v1+6k8V7lsO/bSYw+Z8AWrCQ3kH
 kMyzN/0lTlduJHK7aDHsTwt9qU/73W6U6a2aVrYGj+B6rnwLUACmxXvINQiA3GpNffgV
 u6t8lR5zMwPH3PZ4quzjHGOqNPk2ShCGKBzuXrFNIKMPx8/ce86z7mSZt4m9ZfLO0LVQ
 LWq2EN5v1jleFdXifQX14bJykSW0K5Vqcj+t7aJeMAzp9ZpJwl9PHxSyAp548N+bIu7h
 ZSZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJJdOdgXiXysYOt7k8ph5i6PD8B/f58z6D0ivR1pPyiok3elPimqT3LvX8Kl+eNKLUP+BQjQkPompx@nongnu.org
X-Gm-Message-State: AOJu0YwOA20aw2zyQT3ThfVA89jyproekiij4bHgoVKmorIKgO2bgkmG
 ke2pLFgAHRl6q+6NeT6j+HbTl4Jc0r1cC3JAQvB11wPKoYO9GmDo1yW7/AdYY53/dp0Y4AYOBxe
 CcwmBmc8/17vIjnhuHswA42bOuYvrNTqO0t9zlbz0bJysjG/r79UcTbi0
X-Gm-Gg: ASbGnctpfvEFHA1yCIsCq1lQHUfJ+LFB3EFSX6nHvRY3dWpCM+H6c9okS9xpico2C13
 mTKr5O4TKiP7sL+tR23CSCStC9wUAElRwwbzhXx9R/upLWkHnbW2fuZtXQhOZqCz0SuVGk72Xfw
 ty3dGe51r5LRk8B0A9OY/vzLvlxQK1iBhKcW6Sf2wFLkHc+RP3H+PeKChy4SRF3FPPjYWj6QTqy
 XPVk5BEgfcz9y1MmALqQTXMT+02Ot/+UA+6efKa1/HyE0tgwe42IhnKq3DjUh1MFGpNg427wQgM
 mJOezzOoJEVpyjP1F1ZPTt6KXHh0UHDMWgsbE8OKlaIZq0XsAuMMsJG7sNjGi9+KBFBaxlrWjBQ
 734PxMizTHjY6Xoksr7zNog3tu6jlMoLngp1OnnsqKG1eeQ==
X-Received: by 2002:a05:6000:2381:b0:3eb:5245:7c1f with SMTP id
 ffacd0b85a97d-429a7e35cddmr401032f8f.2.1761586116438; 
 Mon, 27 Oct 2025 10:28:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEECNBbkkanBJOCmuNxECWe+RldEe86PX/D9bIC19yYKIgd0pa9jybRTI0BhR2KBrdbIOQcEQ==
X-Received: by 2002:a05:6000:2381:b0:3eb:5245:7c1f with SMTP id
 ffacd0b85a97d-429a7e35cddmr401017f8f.2.1761586116023; 
 Mon, 27 Oct 2025 10:28:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7ce1sm15144251f8f.0.2025.10.27.10.28.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 10:28:35 -0700 (PDT)
Message-ID: <c2c6a1ec-1590-4eaf-b59a-a2dc3b5ed260@redhat.com>
Date: Mon, 27 Oct 2025 18:28:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 25/27] backends/iommufd: Add a callback helper to
 retrieve PASID support
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
 <20250929133643.38961-26-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250929133643.38961-26-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
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
> Subsequent patch will make use of this to add a PASID CAP for assigned devices.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  backends/iommufd.c                 |  9 +++++++++
>  include/system/host_iommu_device.h | 12 ++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 023e67bc46..0ff46a5747 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -523,6 +523,14 @@ bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>      return idevc->detach_hwpt(idev, errp);
>  }
>  
> +static uint8_t hiod_iommufd_get_pasid(HostIOMMUDevice *hiod, uint64_t *hw_caps)
I would call it hiod_iommufd_get_max_pasid_log2 instead.
> +{
> +    HostIOMMUDeviceCaps *caps = &hiod->caps;
> +
> +    *hw_caps = caps->hw_caps;
> +    return caps->max_pasid_log2;
> +}
> +
>  static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>  {
>      HostIOMMUDeviceCaps *caps = &hiod->caps;
> @@ -543,6 +551,7 @@ static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
>      HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
>  
>      hioc->get_cap = hiod_iommufd_get_cap;
> +    hioc->get_pasid = hiod_iommufd_get_pasid;
same for the cb name
>  };
>  
>  static const TypeInfo types[] = {
> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
> index c6a2a3899a..3773c54977 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
> @@ -115,6 +115,18 @@ struct HostIOMMUDeviceClass {
>       * @hiod: handle to the host IOMMU device
>       */
>      uint64_t (*get_page_size_mask)(HostIOMMUDevice *hiod);
> +    /**
> +     * @get_pasid: Get PASID support information along this
> +     *             @hiod Host IOMMU device
> +     * Optional callback. If not implemented, PASID not supported
> +     *
> +     * @hiod: handle to the host IOMMU device
> +     *
> +     * @out_hw_caps: Output the generic iommu capability info which includes
> +     *               device PASID CAP info

I would precise this corresponds to kernel bitmap of enum iommufd_hw_capabilities

> +     * Returns the width of PASIDs. Zero means no PASID support
> +     */
> +     uint8_t (*get_pasid)(HostIOMMUDevice *hiod, uint64_t *out_hw_caps);
ditto. But actually even get_pasid_max_pasid_log2 is not very well
suited as it returns both iommu_hw_capabilities and max_pasid_log2.
and this can now be easily mixed up with the other get_cap() callback.

Why can't we use hiod_iommufd_get_cap() cb instead that would return an
uint64_t instead. we could easily add new cap value for max_pasid_log2
and output_hw_capabilities.

Or do I miss something?

Thanks

Eric

>  };
>  
>  /*


