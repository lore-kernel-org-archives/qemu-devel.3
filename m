Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAC8C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 10:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq8YX-00029g-Jo; Thu, 06 Mar 2025 05:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tq8YE-00026q-Tm
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 05:34:02 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tq8Y7-0008W2-IF
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 05:34:02 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-390e3b3d3bcso501395f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 02:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741257231; x=1741862031; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VtE1iEOZkI1sAQooTHAixfRIlazc17GL3n7kh/f7qXc=;
 b=YTeEE2WJrLPnQHihwxjuEob1F5g0UshkdSyAwCVQLuNKIF3Gm+NLXms3khmgrnLhEG
 mDd6YhzuLsvkkQHyPazciPVRwG+7XuO0apSIQR9NZDSjRZWMBqXGKRJIaoIbnDrJLbVy
 XrHOvtFQ6sdMLIIAW2gQYRt8Nd/8sbrIw0x6ssWD9XcyCQm1hmvxCm/TNYAIYVH5uLAX
 04kaHIhPupz+Vu+19FQA71bONSabnrPC2C3l7LkWYaSxwuDIJBYavI2liuDYblqBV7ct
 8S4++6FOHEC4eGII4Qrdk2HERu6uTbeSlMW/tDbW1Eep+L7LEIBVv8vMIdpkKg66Y5WO
 uxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741257231; x=1741862031;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VtE1iEOZkI1sAQooTHAixfRIlazc17GL3n7kh/f7qXc=;
 b=Ls4MoXCnAmJfA02Exv7emW8Kpg9CcXtzaBfj1JB7kVJ3K8/aQmLDEpUkvTZzlaQBQp
 nCuNlNoSD5HFV5oJUech3TpBNO6NsUWjoMyT7XcBT9RllG8KJwK4KdN/KPKzAOuALJsL
 CY9niBR4NOsFDGFTJnVkjHlsXpn4L/SBXoOCQURb8UMvdLhIP1Au45luUoHMf4VKFScu
 Ur/E5SZ0TlTvLhqoda2vA3lZJOexD5XPtTfzF0FuxTPwo34DG3owov1Xhzf02ocEO1kM
 yQebDSHf1kw8vUwiKnHPkUPbxP/dcMO4PhNhbkzfW/AL3UwoUHAmr5LzDivfsIkdCs9w
 tTtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuuPhO7pr8jjQOZ6E1QvvsIAMg2YW+qqeV71+4J4T7qOzwGgj1R1xogeBQAVxPHptbhIbbNuzvCX/C@nongnu.org
X-Gm-Message-State: AOJu0YzTZhYSyC6+msdje+eIA2mTotWZTUZAxoVlfNC954T8dTEnbDAv
 kgFKLlbGg/kRN79lS9Sw1PTBjSWwzAyJGVavfTiXeYhw8sjL/i0mohyLenb6kNM=
X-Gm-Gg: ASbGncsvRzFpZFt1bAPlVzQNOcdJmsQ3BaE/bxGHLXmwHtlFuIz2toIUbKt2Wzthz/k
 6l8R+wOW9meiOzyJ3XHmol9mQXCQitHnacZxc5gmXSbWoWz240LLZ2IBCX8iITAHK2Vp0YYyh4+
 9foURVkHTuqOVTwB/KNKsfbQcUWjOYkKV2j5TpYpLD1MU9pYbOQSrMlv0u1WkVIVmdZu57zz8bB
 PF8Wb93e2LOs6nz+QgKluvr1EOnNF0eD3/FG0RWNhVWIJPhvdsl2oZ0mC9OQ66fB/A235nY5+I5
 +0TPICVR2FCY4sHP+QJccVnNOHLgfGLallmlRhQ5Pa4jVprU3Y+m2mfFdbN8zDiK04a+PNa2ARJ
 VW66S+zJGPUk3
X-Google-Smtp-Source: AGHT+IF33iHksvt9MLx03vTbDPs6T06jc9D40ihJRPIU11hf2kIKzE50Nl/EBe5l3Ji0pVCbC9i4BQ==
X-Received: by 2002:a05:6000:2108:b0:391:2c0c:1247 with SMTP id
 ffacd0b85a97d-3912c0c1ca4mr952583f8f.1.1741257230864; 
 Thu, 06 Mar 2025 02:33:50 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2f10sm1614500f8f.65.2025.03.06.02.33.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 02:33:50 -0800 (PST)
Message-ID: <2390cf9e-c9df-4d19-946b-68c51763ce16@linaro.org>
Date: Thu, 6 Mar 2025 11:33:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] vfio: Check compatibility of CPU and IOMMU address
 space width
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250130134346.1754143-1-clg@redhat.com>
 <20250130134346.1754143-9-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250130134346.1754143-9-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 30/1/25 14:43, Cédric Le Goater wrote:
> Print a warning if IOMMU address space width is smaller than the
> physical address width. In this case, PCI peer-to-peer transactions on
> BARs are not supported and failures of device MMIO regions are to be
> expected.
> 
> This can occur with the 39-bit IOMMU address space width as found on
> consumer grade processors or when using a vIOMMU device with default
> settings.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/common.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 5c9d8657d746ce30af5ae8f9122101e086a61ef5..e5ef93c589b2bed68f790608868ec3c7779d4cb8 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -44,6 +44,8 @@
>   #include "migration/qemu-file.h"
>   #include "system/tpm.h"
>   
> +#include "hw/core/cpu.h"
> +
>   VFIODeviceList vfio_device_list =
>       QLIST_HEAD_INITIALIZER(vfio_device_list);
>   static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
> @@ -1546,12 +1548,28 @@ retry:
>       return info;
>   }
>   
> +static bool vfio_device_check_address_space(VFIODevice *vbasedev, Error **errp)
> +{
> +    uint32_t cpu_aw_bits = cpu_get_phys_bits(first_cpu);

This 'first_cpu' use is annoying. I understand the device is created
from the CLI, and passing the host physical bits limit as a device
property is not practical. We'll deal with that later...

> +    uint32_t iommu_aw_bits = vfio_device_get_aw_bits(vbasedev);
> +
> +    if (cpu_aw_bits && cpu_aw_bits > iommu_aw_bits) {
> +        error_setg(errp, "Host physical address space (%u) is larger than "
> +                   "the host IOMMU address space (%u).", cpu_aw_bits,
> +                   iommu_aw_bits);
> +        vfio_device_error_append(vbasedev, errp);
> +        return false;
> +    }
> +    return true;
> +}
> +
>   bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>                           AddressSpace *as, Error **errp)
>   {
>       const VFIOIOMMUClass *ops =
>           VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
>       HostIOMMUDevice *hiod = NULL;
> +    Error *local_err = NULL;
>   
>       if (vbasedev->iommufd) {
>           ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
> @@ -1571,6 +1589,9 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>           return false;
>       }
>   
> +    if (!vfio_device_check_address_space(vbasedev, &local_err)) {
> +        warn_report_err(local_err);
> +    }
>       return true;
>   }
>   


