Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC6BC0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thUty-0005iQ-Gs; Mon, 10 Feb 2025 09:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thUtx-0005hy-5e
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:36:45 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thUts-0000kR-Vv
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:36:44 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so51956165e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 06:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739198198; x=1739802998; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QX10BBocv63GY5fZdLKdqbQRgRXLNJQWeXy5ivOBNJQ=;
 b=oAWpOPkOPyEnIxkP0gxefTJJQxsoS7AgSILG+zajOOFLZw9cepd/WWrcQ7s26FeROb
 uSU1o0HsxiCFW7Tubn98YrYVI+doMFZtI5gMyClYcirG0TiYcQ7PSaHc+ZvnbqsptljE
 HffP51wOo6fS0UPrtWm7LOCXBmmQ7j6cKX/Sx9oDZ+drlNfwtTR1z4a1tYCdOn57We/p
 JrEqN4bVz20yWB+Kna8Ozr9hcYLoefCAe77mLyb2CyC/Wo+xRFu21/AFqNC4IcUIiIRR
 H3VOrr2pIYs0d/yTcztJCjzTyvqmUItSDZLzRCm2W+iU1KfcGN8eMhZi8t97qKLfGseq
 AKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739198198; x=1739802998;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QX10BBocv63GY5fZdLKdqbQRgRXLNJQWeXy5ivOBNJQ=;
 b=nyYGljrnuk55vijLjCpvZ8YfU4Ec4M1ypYmHHKuG0CO3nx5H5bxvsD4U/1lQ+9JJnk
 G2rAX1MlvNb9H/5OOsO/dg9HLn01V8qMfSqp+FamI49R+x3Th6hKEh2qNMt+gEBrtLmH
 1a+MZXeVuhYCWCPndwDj0gAULjrP5OcU05a/jAQ9y/s+HBWWyOIxSshi91L+3DFZAj0z
 XXffUfuYe6T0jJQxMd4isQConBqaLNFq/MK/JrE9qTWBs41aHaWxxH4tvDfss/5nx0Sr
 PAuDAFNQ+lRZ+RQwwgGJn4KFgi303PjuABzOveQEv55kR+ADl1ZK/skPqh6qICauF0Ba
 QLEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3W6EBml2CxXQe+Duk6+D1PrKUTqis7kS2Qa6CX9CjTsyVBCIngbt877E08I+pdLnE7WpiNukNiE0A@nongnu.org
X-Gm-Message-State: AOJu0Ywz0Ihyf2SomwcgjVZLVbS0t8om88T4rrDX4RepvU9U3arSLBKd
 sLC0iEVtHLraaoSol16sxd0jdNXVdHLujp3x8Y7U3kwrzMK4lWhbAeuX+JS53JhpjiAuLE2ztGb
 L5ps=
X-Gm-Gg: ASbGncukh0IIeBwGWubdoGwLm3YKddCXdcJG3IWql1sertmjYGdjBcKm2XFiq/OiZaC
 2Mit8y7Efya8NdOHxJU8ulTmg8lnn6WRRV723ttRkGkLcwGZhE7LmCnyg3e0JqQ36bnQqmZuBGR
 Ny0NBiKHmCRs2W/vQmft0Ma6lnmgVVOKI1od82Cq02G8JBFWmp3TIn42d3mg63OREVYkBT7dUj1
 mvP4R1xkhjTHrBKzfiBvwoAEH+4kGTU0HcMm8mhsFeXDa2NYO4ICckUHvitb1tgH2GaXa5PBiws
 czdAAYIynNNyAV88Psfz6MUEUO+C2iICLn8BLESi8zHKbzDxlCAR3MLH2ec=
X-Google-Smtp-Source: AGHT+IGzbzj7OYUsjw0VA1DOVilDTxCVj/FFGLTKw38jNxb6R74a3q2+fYMXl6O3//BAohNkGEcJFw==
X-Received: by 2002:a5d:5244:0:b0:38d:c105:e22f with SMTP id
 ffacd0b85a97d-38dc9346a1cmr8878121f8f.52.1739198198525; 
 Mon, 10 Feb 2025 06:36:38 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd5b03955sm6534442f8f.49.2025.02.10.06.36.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 06:36:38 -0800 (PST)
Message-ID: <84bfb439-e3eb-469c-afb4-4c942c70ec68@linaro.org>
Date: Mon, 10 Feb 2025 15:36:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] vfio: Improve error reporting when MMIO region
 mapping fails
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20250130134346.1754143-1-clg@redhat.com>
 <20250130134346.1754143-6-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250130134346.1754143-6-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
> When the IOMMU address space width is smaller than the physical
> address width, a MMIO region of a device can fail to map because the
> region is outside the supported IOVA ranges of the VM. In this case,
> PCI peer-to-peer transactions on BARs are not supported.
> 
> This can occur with the 39-bit IOMMU address space width, as can be
> the case on some consumer processors or when using a vIOMMU device
> with default settings. The current error message is unclear, also
> change the error report to a warning because it is a non fatal
> condition for the VM.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/common.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 62af1216fc5a9089fc718c2afe3a405d9381db32..5c9d8657d746ce30af5ae8f9122101e086a61ef5 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -555,6 +555,18 @@ static bool vfio_get_section_iova_range(VFIOContainerBase *bcontainer,
>       return true;
>   }
>   
> +static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
> +{
> +    /*
> +     * MMIO region mapping failures are not fatal but in this case PCI
> +     * peer-to-peer transactions are broken.
> +     */
> +    if (vbasedev && vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
> +        error_append_hint(errp, "%s: PCI peer-to-peer transactions "
> +                          "on BARs are not supported.\n", vbasedev->name);
> +    }
> +}
> +
>   static void vfio_listener_region_add(MemoryListener *listener,
>                                        MemoryRegionSection *section)
>   {
> @@ -670,7 +682,10 @@ static void vfio_listener_region_add(MemoryListener *listener,
>                      strerror(-ret));
>           if (memory_region_is_ram_device(section->mr)) {
>               /* Allow unexpected mappings not to be fatal for RAM devices */
> -            error_report_err(err);
> +            VFIODevice *vbasedev =
> +                vfio_get_vfio_device(memory_region_owner(section->mr));
> +            vfio_device_error_append(vbasedev, &err);

Having vfio_get_vfio_device() returning NULL and
vfio_device_error_append() also checking for NULL is odd.

Maybe just inline everything here?

> +            warn_report_once_err(err);
>               return;
>           }
>           goto fail;


