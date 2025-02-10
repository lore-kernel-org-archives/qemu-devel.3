Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3BFC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thUqD-0004Fw-4b; Mon, 10 Feb 2025 09:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thUq9-0004Fa-W8
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:32:51 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thUq8-0008S8-2L
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:32:49 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-30797730cbdso43729221fa.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 06:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739197964; x=1739802764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4mibrs0nPa4b5qhMCk9/SHcgnt6VVF5S6N00pbymtkI=;
 b=W24BqTQLUW5wxO7vVvHGUOYl3muXRdpJKlDvGUF/BvSbr/9iq5RlBz/ulqH5ECykTy
 OlgdYLvetegivx9EvyVm+t6vCK5Jxvl0ZpUa1AruDg1gC25zyJlAqz4JceduNZYpGVPM
 k4LV30sshioOYwQJBc98G3GfZlSlNlYzYcujD8lGECCFbLTDszRK7/dSgsLt/0QcgEtl
 DZQRpYpvSV7l4gBktlgTdiFVOeGvPPtPgbfheG12XyAYcGAGet+b2p/xkcXjU2/ZnyZn
 H2a6yZNPMVkJB2jwURf9DoC/ltZ+bLZJlZAfzgV/IIyN2xifJGxNw6TKkCtm7sYZSd63
 nTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739197964; x=1739802764;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4mibrs0nPa4b5qhMCk9/SHcgnt6VVF5S6N00pbymtkI=;
 b=tyVukk7M5GtmPWQza8g+DTqepAJm43BoPGlh5H5KWJC9ZmRj37up3euC26OrVQrq7g
 G9Cgki0Jq7SZSq/YrwvRpREX8YtkJFFZhmrstr7MCFtXe3Dg2pufZRJEk8nobzkn8ajg
 XNTt/ftvD0b+S2VL+yX97YP4FcZmEyipZFo+gfQBqtAtGc+VaK2Lsuw1/Z8m4TwQJsD5
 FDc30jeSEdIknm3TB7qAclPkZ70f08V6bi3Q9Cp8XAO175LxXxf37s1sdSCxetpOKzUr
 WQbMLY8xngYFn/3vWLbOCEoJxgeMKZF+LXIx+c70qSvumqGGeVx5IiqSlHGYhb/RQYJq
 C/1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaw21IbkuF/cHDcOtIJPaKvVhj5k7iOoTreXJsPvLM5pNeFXiQXRoTqHRqxkv1dTFQiKlWqW4BouZE@nongnu.org
X-Gm-Message-State: AOJu0YzXxMuT5F8aHEX7UZPXSxvnA7POVF/FrOYXMah+nle+gM9c5mbB
 H7bLffqmqwaoVg8yIqpgmd+aMSJBohtOcs7jJ1r9hSzQni1iRu0rYwiP/kBvLOE=
X-Gm-Gg: ASbGncuZGAnZZj8Z+DOD1o/T5SmMkaWc+LCYaYrardCkQDgL1KSansAd6b3RF8Gxj1Y
 hujz+W8F5mZajyBhQ5odKch8Uj4VjINNooB6JwYQChdTlZv6gIUBZgO0nopbXHE0MTdVSeV8cZD
 XPygb7gUaRhOp/elHt9Bfo7qFMXd40oY51nXO0UJyCNLB3eCxHjKMB9FUXCV5lLqbbpM8IBqau4
 3de3LGh9IbsSLoLArYWIUcGdJZhl8+ZTRAWDj4Q4CE2lkSPWSRB5NYRrm2zHw262HMN5b7lurqm
 MzJsSec+3ndLhG3WeI2TKucPodudeQF+8yfV8jyd3rzKAkzmIUjyHRNWhFo=
X-Google-Smtp-Source: AGHT+IF3nZ4Jv488Rc1DXZQR7QkkeS/T/PNOQKX8hX+uvxFoLfDpCXS4sNqUdk35b9sMz+W9GObBfA==
X-Received: by 2002:a2e:ab0f:0:b0:302:17e7:e16d with SMTP id
 38308e7fff4ca-307e57bbcfbmr49965241fa.3.1739197964389; 
 Mon, 10 Feb 2025 06:32:44 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-308f6a95bc3sm789631fa.110.2025.02.10.06.32.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 06:32:42 -0800 (PST)
Message-ID: <281482d8-f6db-440f-a892-ad1600e7dc56@linaro.org>
Date: Mon, 10 Feb 2025 15:32:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] vfio: Introduce vfio_get_vfio_device()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20250130134346.1754143-1-clg@redhat.com>
 <20250130134346.1754143-5-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250130134346.1754143-5-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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
> This helper will be useful in the listener handlers to extract the
> VFIO device from a memory region using memory_region_owner(). At the
> moment, we only care for PCI passthrough devices. If the need arises,
> we will add more.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/hw/vfio/vfio-common.h |  1 +
>   hw/vfio/helpers.c             | 10 ++++++++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 0c60be5b15c70168f4f94ad7054d9bd750a162d3..ac35136a11051b079cd9d04e6becd344a0e0f7e7 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -252,6 +252,7 @@ bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
>   bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>                           AddressSpace *as, Error **errp);
>   void vfio_detach_device(VFIODevice *vbasedev);
> +VFIODevice *vfio_get_vfio_device(Object *obj);
>   
>   int vfio_kvm_device_add_fd(int fd, Error **errp);
>   int vfio_kvm_device_del_fd(int fd, Error **errp);
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index 913796f437f84eece8711cb4b4b654a44040d17c..4b255d4f3a9e81f55df00c68fc71da769fd5bd04 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -23,6 +23,7 @@
>   #include <sys/ioctl.h>
>   
>   #include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/pci.h"
>   #include "hw/hw.h"
>   #include "trace.h"
>   #include "qapi/error.h"
> @@ -728,3 +729,12 @@ bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
>   
>       return HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp);
>   }
> +
> +VFIODevice *vfio_get_vfio_device(Object *obj)

Can't we take a VFIOPCIDevice argument?

> +{
> +    if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
> +        return &VFIO_PCI(obj)->vbasedev;
> +    } else {
> +        return NULL;
> +    }
> +}


