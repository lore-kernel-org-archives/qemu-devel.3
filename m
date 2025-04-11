Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309C0C369A8
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3C1y-0001LH-Up; Fri, 11 Apr 2025 06:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3C1m-0001KM-OB
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:54:30 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3C1l-0001QW-2w
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:54:30 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39c0dfad22aso949517f8f.2
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 03:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744368867; x=1744973667; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R4xKw0valGiaUcQFk11Quo1HH2cbB7HnEB7/lEN/1bY=;
 b=TlZxpfJYj8frD7vkQgRr5UWbxKH542re+Dy/RiKAksNyeE+XPf+YeJDUoap79F3O3/
 fDdfvLy2QktDc+iAYjq5aewOcxmNZiKmNq7BQ5tpjKP2fX4WQSBy/V7mEWieaaZvwHqv
 b7S/BDJkCyY1pUPu1h0Ofq7qWPfX7VrsZR/elRYAu/g8LU4aISXhBJg65nsSow6jYwKq
 SEFcEYTIjGxm683zYvvcoY8WVl7D7U/XSl5C5wOC11dEHVBNf3vM/NPyr1LMovBRKVR6
 9hvl/ZxhLkmKT7wXnZcjWAQ84Y+CYK8mrigYXQa2OXwPaquiNuLccXH6eIMAG0QEr+sp
 5qoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744368867; x=1744973667;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R4xKw0valGiaUcQFk11Quo1HH2cbB7HnEB7/lEN/1bY=;
 b=EasnHYRtB0z80p9rdE7MP4HNXYIlANbAmdGuLOQsDUkDVthSYTOYzBIRcUm3Ubp6Xz
 C3K6U1fWysA/P8tykDUfT7SQtiSik4vJOqAFW0u3/h2+RAOSwA8+PWoLeS0Nje9vVaB7
 LPZtlHvxdsMpvFKxdcuJ/fcqnsqYG/H9FOfApitxM/YeDQ74Rs7lY+sBunXW9uz8f553
 4792A5NAl3VwIsUS23QXCl5kV8YnHDEE4cblahmuxb4oWZjDJIkff5RwvaimkVkIOEoU
 0EPsWHeLq3wU9I6G2dG2zSUaK36pXRwemL/M4nhuPVT7TBxGDW15hznmHhuXCIfby27K
 XYng==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2cIoVHuLD15usB7pC7HHk8kz98nY0Y6KvpWE68ofvMPWz+4gzTWqC/xJyd8ZWRv55/cnULU+loIAy@nongnu.org
X-Gm-Message-State: AOJu0YyQ3y3vQ9W1ae9ZqfP1XC3Mtl9hP8DrT2wy70ZeqcV8j2/+rDXG
 RioUrUPXBhj0wOCyziTUeohBcCSHGiFWFWYr2Z0gv76WvnKJcp9EHVfsZZTqPaM=
X-Gm-Gg: ASbGnctDNo94+MQNTqZ91PoMQ4PhaWN3sHrM+kB1Xrx07o0AqbDHMQRkZm7LxtzJyjb
 LOq6p0+Mism5W5fLVR79R6wTrB6+trjpFDM0q4DMtc8dSH5YpIKER31BlWRqFbgtvIdSMRlLC/N
 Nxp5b9lLEhaHt5H83K3uEK8WYoserjyiA9h4mBScE0y7zQTnQLEpFG/6JUrLAcxxoiYtl4O3VVm
 g8Xh07BSrZzcSAb+iQn7DvDn9Df/NM77gsL1kk+zYTil7633TCigRi4SS4EicTshJV5mFC1tXMH
 K6dbnDExLLrtJQzsmCb5uqSOFo3V0hzTFneMbPOlIc17eB3cOGnQRBAfUqQVGT7sxFbi5SzjQQJ
 O1fAXTCAPwUe1N6NSfy8=
X-Google-Smtp-Source: AGHT+IGRN+UX2PG+iaNlwcN59DMW3J+GGjxws3OKidiab30cARP6MAENV80bEV3S4AkuZArrQDijBg==
X-Received: by 2002:a05:6000:4387:b0:397:8ef9:9963 with SMTP id
 ffacd0b85a97d-39eaaed5841mr1667263f8f.55.1744368867336; 
 Fri, 11 Apr 2025 03:54:27 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f20626c19sm85359915e9.15.2025.04.11.03.54.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 03:54:26 -0700 (PDT)
Message-ID: <a9fbd9ed-f107-4bde-adfd-26b51bac0442@linaro.org>
Date: Fri, 11 Apr 2025 12:54:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] vfio: Move realize() after attach_device()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, chao.p.peng@intel.com,
 Donald Dutile <ddutile@redhat.com>
References: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
 <20250411101707.3460429-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250411101707.3460429-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Hi,

On 11/4/25 12:17, Zhenzhong Duan wrote:
> Previously device attaching depends on realize() getting host iommu
> capabilities to check dirty tracking support.
> 
> Now we save a caps copy in VFIODevice and check that copy for dirty
> tracking support, there is no dependency any more, move realize()
> call after attach_device() call in vfio_device_attach().
> 
> Drop vfio_device_hiod_realize() which looks redundant now.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Suggested-by: Donald Dutile <ddutile@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-device.h |  1 -
>   hw/vfio/container.c           |  4 ----
>   hw/vfio/device.c              | 28 +++++++++++-----------------
>   hw/vfio/iommufd.c             |  4 ----
>   4 files changed, 11 insertions(+), 26 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 09a7af891a..14559733c6 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -124,7 +124,6 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
>   
>   void vfio_device_reset_handler(void *opaque);
>   bool vfio_device_is_mdev(VFIODevice *vbasedev);
> -bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);

Pre-existing, but can we add documentation about what vfio_device_attach
does, in particular in which state is the device once attached (or if
attachment failed)?

>   bool vfio_device_attach(char *name, VFIODevice *vbasedev,
>                           AddressSpace *as, Error **errp);
>   void vfio_device_detach(VFIODevice *vbasedev);


