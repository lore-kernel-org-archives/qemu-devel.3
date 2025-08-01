Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E8FC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 14:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhqgv-0004le-88; Fri, 01 Aug 2025 10:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhqWR-0002LJ-D4
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:14:11 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhqWO-0000T5-R8
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:14:11 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45892deb1dcso4292365e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754057646; x=1754662446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D8dpATFFfosJyK/OsBtmby1KIdAynCWW1Pbc+yBUzoU=;
 b=MEevFzrEnlfKCaszxMWVPIzqGS6F9CrVJBLLxEUKEPjp9oe1yOvFcqvEJhHOIr0xAA
 9dUdUrP5aUnBAA9Tp0GzU3h2nlRlTVpsMn9JQh/vcMJJQRNke4LuDnJ+oJjUcW7APmOB
 nzrrMR5zIscJCPBwjIj9dV9XUIwzztAzaxoBi6VFlgmNlhF1SPNLO0q5JHuUTHkcdj7Z
 0aojxM1hvGUtl1egvXhSQVzOGVEHU7Unh4C+cd5nI1egzz+n4SunR9FFfDka2OTShe+k
 EKqUVRKZZ+guJ6vJX7lxHp5VoI2bFqEk0pDb8andaXSVBZJGqREOnVPqhrvL2eJo9o93
 BB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754057646; x=1754662446;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D8dpATFFfosJyK/OsBtmby1KIdAynCWW1Pbc+yBUzoU=;
 b=uL5Emux+mMeiLZbhCdnjsYyRVJuE00CrSuEu1p3M+SEfKSaFyZAJ7rGtKB0zlXiaxs
 jDr3XvBdl9iPbFoYKU2XQcDHTJ7yOD0gC5iNs5a02nB6caSlrTwUgYNr/g6UzzdI79/g
 GGQ4invu0/b+FZ22Jd4hUmVAlcRsDatAHbFFnLhi4MMLjsTYprXgqRafqmGcrKFAV1s6
 pv6kkfYVmbO/MbSO42VspHGlsE4gYgT1Kh84TKHueTo/n93Wa1MX5p1eP8L61bbzZJ1/
 xOGQs27zErvHBdFWYCqGG8ucTO+Yf7U4me7Fpz5Dvo5GUevgKcCMLdJp/3By6/ZjEP7X
 oowQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrcO70pWRUVFqF96OzwsL8oEzDdbjo0GUNp0DZq8DoF3oODhJhNLuP9iyY8Pj9s1R9/4Yd5oJxZcsQ@nongnu.org
X-Gm-Message-State: AOJu0Yw7HzFo0ku5wGAUgpz6QX/7OeEnWxZMlz39C/e6m25CUIbuKeqP
 z+F13hki9eGoeUksp662p8ryeAhca6WMHMGRcRREiuR6HopU21E9aeSSzt5mB9nyWwFJEYo4OQ+
 dgTJf
X-Gm-Gg: ASbGnctvz6kAEnVSJjbkS3oLPk1UCKmkrL/XkX9COvxO1vQ+eA76EVnco1r5K8ViaZx
 bLsey/jjha2lK3SjuYh5qI4k2lSDM+mHy+YWriLTaxedIWe+T+x8wQHt8zxriOEpjQjJ8LpnhN0
 qhyDSwzkugGZwX6N/++LscxR1giYXffi55Rt8wlznI50RPud9n+B1YIDcdZL1Ty8Yn4fxzho8y5
 2d82yEFr+SGQtEODFO9UxGtdwvkiJoU/GnxFhWaaBlGb9c0AoXtz7c7uekvvODvbzJM+yEm9FED
 /bmTM+aMdBb+JIrd6sVYR4k6S/WFFV8dKaB2TU9NM1+AihbEE/ttQEo6LETZFeJt7QFSfhCOA72
 F29SCsgi4e/dfLlMeE/mzfnsCWbjh21XcHmqvNrLv0Vc1ZHxtlQ0ZWSOUUHGWbb23lLY93aNJyl
 z2
X-Google-Smtp-Source: AGHT+IGQbwOC3AThYPPVNiqRLPvhdXrcTk1iKLCT4A2YUTA2P9MX2o7zJmgtf4hib+Jni6Bi+V4Dcw==
X-Received: by 2002:a05:600c:1d1e:b0:456:19be:5e8 with SMTP id
 5b1f17b1804b1-45892bc7b07mr95424735e9.20.1754057646414; 
 Fri, 01 Aug 2025 07:14:06 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589edfd983sm66782595e9.13.2025.08.01.07.14.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 07:14:05 -0700 (PDT)
Message-ID: <83d920b8-1838-43c7-a86f-5f4e5e5980b3@linaro.org>
Date: Fri, 1 Aug 2025 16:14:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfio: Introduce helper vfio_pci_from_vfio_device()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com
References: <20250801023533.1458644-1-zhenzhong.duan@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250801023533.1458644-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 1/8/25 04:35, Zhenzhong Duan wrote:
> Introduce helper vfio_pci_from_vfio_device() to transform from VFIODevice
> to VFIOPCIDevice, also to hide low level VFIO_DEVICE_TYPE_PCI type check.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
> v3: add one line comment to the helper
> v2: move helper to hw/vfio/pci.[hc]
>      rename with vfio_pci_ prefix
> 
>   hw/vfio/pci.h       | 1 +
>   hw/vfio/container.c | 4 ++--
>   hw/vfio/device.c    | 2 +-
>   hw/vfio/iommufd.c   | 4 ++--
>   hw/vfio/listener.c  | 4 ++--
>   hw/vfio/pci.c       | 9 +++++++++
>   6 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 81465a8214..53842cb149 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -219,6 +219,7 @@ void vfio_pci_write_config(PCIDevice *pdev,
>   uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
>   void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned size);
>   

[*]

> +VFIOPCIDevice *vfio_pci_from_vfio_device(VFIODevice *vbasedev);
>   void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev);
>   bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev);
>   bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp);

Quoting https://lore.kernel.org/qemu-devel/87bjpl25e6.fsf@draig.linaro.org/:

   Generally APIs to the rest of QEMU should be documented in the
   headers. Comments on individual functions or internal details are
   fine to live in the C files.

> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 4fa692c1a3..85761544ba 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2824,6 +2824,15 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
>       return ret;
>   }
>   
> +/* Transform from VFIODevice to VFIOPCIDevice. Return NULL if fails. */

So this comment preferably goes in [*]. Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +VFIOPCIDevice *vfio_pci_from_vfio_device(VFIODevice *vbasedev)
> +{
> +    if (vbasedev && vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
> +        return container_of(vbasedev, VFIOPCIDevice, vbasedev);
> +    }
> +    return NULL;
> +}


