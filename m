Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E0FC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 20:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tspbB-00071q-Pi; Thu, 13 Mar 2025 16:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspb6-00070q-Jc
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:56:09 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspb4-0005dw-4V
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:56:08 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-224191d92e4so30770945ad.3
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 13:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741899364; x=1742504164; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uVII2DExTsUP45WiRTifB8uTc2S6i/JghMsBQA1p8go=;
 b=S1UZservdRgfYJ6CA+cg5uI23VRiirnYG7DS6gmfgcV1LEhJMfLpRneRxc+zkBDlKL
 IZTGOhfADY+TOOKKZjzbF1dKqZrzVLndGwnui+UpEP9tdzM+OIUIN1WWErRKYM1ttyhJ
 hI5HxMMW33XcaFYtJ1PB6AwxNhQFQ0dtyvFxuWzosS+l9FrgFDBIFyNhhf9rxx0VegiG
 aPDY7U0hsbe7VCjyBH/1D9tLodCF9UXGK6bZAdOwiPRkIVghyKOviWrUlaqw5f2TD7x1
 ZSEdW8SH9zONz9JAWsVeCuoJcluVBqKnKfqHPQRwYO7tWB8EeJbioRwIof+oAmTGME8D
 itcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741899364; x=1742504164;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uVII2DExTsUP45WiRTifB8uTc2S6i/JghMsBQA1p8go=;
 b=PSUQZ9/r77yaUlSHRt5cBRslWk1IrH3ujlZTv8+Oc+5u9JaDUftPkaR139hNnc/ipC
 rqGWkkUcGQV9Y7yaXnruQ+V1wb5gCl+Fxh+n2K5UvWT4Hpq5GXcSbuErV+h6bJGwk29t
 Si0dCox51rjdgIkMX0rVrtP0jacSFpNmsATgJo7+XLiR/HCsH0qj83zdQMriy5mkeheD
 nbed4DxjkO41JHmpv8y3NlFXf8wnr6Sro0D96XRQWVaHKb0LGnzK60keTCITCFF25ipw
 NTUtaHrkOXe6s/zH8Dg8BDCvERj6sSFDoL4Ow8RNakC4kQeOMMY7peCpmSCiFoM1/qOS
 WboQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW63Er/JX3t+/GCvwUklEkyRZiLUMOFO9qdfDfCOMHJiwYKnmGPTau2QoXRajbugf2Cmz8tHxZfrre5@nongnu.org
X-Gm-Message-State: AOJu0YxhkiENDSGpFY/2j0zqV4YdFtbQJb2TwESLlOTPZo/5Byh5gRsg
 b68Udnz4tqQDmQyzaWvTP1RgwGW20/jUspk09cFi4P6Frxe2iLKAs+fajMumU3c=
X-Gm-Gg: ASbGncsWxQ6QrzzNcgFouTMqD6affukNApz8yqdJz+RpddNDr1c04y3INK9kNSxbifR
 UAilNgakhVb8jbvGeotFOKYJLNuLTZY1bc+HX5kOom3S5pER9PG3+Nu5fGMWin3ZhPdHRNXHkcp
 nMfbyadodDX1d18Am3knQxYxxos4B+bEGQccy66bdarqg1N3+c7BiFHzM14qdaW1Bt+gVhilS4C
 Zl0ePaBANIK9MNCFrJ2UtMvdhJdJ07v9/P6eFMXbaspv4iFwiyHH/WVjbRLlaWvZpHzH3lQaWgg
 wvZ3h8lJpCVV4zWrsiN6EyWHlpBqkTVAbddca86R++POwy0gJjwF+nlMgA==
X-Google-Smtp-Source: AGHT+IF2xRtouHIy7OVyPPksZ9rfGci4sOc6A3jPXQm2DjdYz5VIMeA0fPbFYArE34B+xAYTxNhRZQ==
X-Received: by 2002:a05:6a00:1910:b0:736:3c2f:acdd with SMTP id
 d2e1a72fcca58-7371f0f96eemr978138b3a.14.1741899364666; 
 Thu, 13 Mar 2025 13:56:04 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-737115293f6sm1855595b3a.14.2025.03.13.13.56.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 13:56:04 -0700 (PDT)
Message-ID: <fa9b6aca-6dce-4ba2-84b4-c09ba8daddd1@linaro.org>
Date: Thu, 13 Mar 2025 13:56:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/37] include/system: Move exec/ramblock.h to
 system/ramblock.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-25-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/12/25 20:45, Richard Henderson wrote:
> Convert the existing includes with sed.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/system/ram_addr.h           | 2 +-
>   include/{exec => system}/ramblock.h | 9 ++++-----
>   hw/display/virtio-gpu-udmabuf.c     | 2 +-
>   hw/hyperv/hv-balloon.c              | 2 +-
>   hw/virtio/vhost-user.c              | 2 +-
>   migration/dirtyrate.c               | 2 +-
>   migration/file.c                    | 2 +-
>   migration/multifd-nocomp.c          | 2 +-
>   migration/multifd-qatzip.c          | 2 +-
>   migration/multifd-qpl.c             | 2 +-
>   migration/multifd-uadk.c            | 2 +-
>   migration/multifd-zero-page.c       | 2 +-
>   migration/multifd-zlib.c            | 2 +-
>   migration/multifd-zstd.c            | 2 +-
>   migration/multifd.c                 | 2 +-
>   migration/postcopy-ram.c            | 2 +-
>   tests/qtest/fuzz/generic_fuzz.c     | 2 +-
>   MAINTAINERS                         | 2 +-
>   18 files changed, 21 insertions(+), 22 deletions(-)
>   rename include/{exec => system}/ramblock.h (96%)
> 
> diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
> index 65f8f37b2a..eceb8fbe4b 100644
> --- a/include/system/ram_addr.h
> +++ b/include/system/ram_addr.h
> @@ -24,7 +24,7 @@
>   #include "system/tcg.h"
>   #include "exec/cputlb.h"
>   #include "exec/ramlist.h"
> -#include "exec/ramblock.h"
> +#include "system/ramblock.h"
>   #include "exec/exec-all.h"
>   #include "qemu/rcu.h"
>   
> diff --git a/include/exec/ramblock.h b/include/system/ramblock.h
> similarity index 96%
> rename from include/exec/ramblock.h
> rename to include/system/ramblock.h
> index 64484cd821..d8a116ba99 100644
> --- a/include/exec/ramblock.h
> +++ b/include/system/ramblock.h
> @@ -16,11 +16,10 @@
>    * The functions declared here will be removed soon.
>    */
>   
> -#ifndef QEMU_EXEC_RAMBLOCK_H
> -#define QEMU_EXEC_RAMBLOCK_H
> +#ifndef SYSTEM_RAMBLOCK_H
> +#define SYSTEM_RAMBLOCK_H
>   
> -#ifndef CONFIG_USER_ONLY
> -#include "cpu-common.h"
> +#include "exec/cpu-common.h"
>   #include "qemu/rcu.h"
>   #include "exec/ramlist.h"
>   
> @@ -91,5 +90,5 @@ struct RAMBlock {
>        */
>       ram_addr_t postcopy_length;
>   };
> -#endif
> +
>   #endif
> diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
> index 85ca23cb32..0510577475 100644
> --- a/hw/display/virtio-gpu-udmabuf.c
> +++ b/hw/display/virtio-gpu-udmabuf.c
> @@ -19,7 +19,7 @@
>   #include "hw/virtio/virtio-gpu.h"
>   #include "hw/virtio/virtio-gpu-pixman.h"
>   #include "trace.h"
> -#include "exec/ramblock.h"
> +#include "system/ramblock.h"
>   #include "system/hostmem.h"
>   #include <sys/ioctl.h>
>   #include <linux/memfd.h>
> diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
> index 0b1da723c8..acabff2c4a 100644
> --- a/hw/hyperv/hv-balloon.c
> +++ b/hw/hyperv/hv-balloon.c
> @@ -12,7 +12,7 @@
>   
>   #include "system/address-spaces.h"
>   #include "exec/cpu-common.h"
> -#include "exec/ramblock.h"
> +#include "system/ramblock.h"
>   #include "hw/boards.h"
>   #include "hw/hyperv/dynmem-proto.h"
>   #include "hw/hyperv/hv-balloon.h"
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 267b612587..48561d3c74 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -28,7 +28,7 @@
>   #include "system/cryptodev.h"
>   #include "migration/postcopy-ram.h"
>   #include "trace.h"
> -#include "exec/ramblock.h"
> +#include "system/ramblock.h"
>   
>   #include <sys/ioctl.h>
>   #include <sys/socket.h>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 09caf92f87..986624c79a 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -14,7 +14,7 @@
>   #include "qemu/error-report.h"
>   #include "hw/core/cpu.h"
>   #include "qapi/error.h"
> -#include "exec/ramblock.h"
> +#include "system/ramblock.h"
>   #include "exec/target_page.h"
>   #include "qemu/rcu_queue.h"
>   #include "qemu/main-loop.h"
> diff --git a/migration/file.c b/migration/file.c
> index 7f11e26f5c..bb8031e3c7 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -6,7 +6,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "exec/ramblock.h"
> +#include "system/ramblock.h"
>   #include "qemu/cutils.h"
>   #include "qemu/error-report.h"
>   #include "qapi/error.h"
> diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
> index ffe75256c9..94f248e8a2 100644
> --- a/migration/multifd-nocomp.c
> +++ b/migration/multifd-nocomp.c
> @@ -11,7 +11,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "exec/ramblock.h"
> +#include "system/ramblock.h"
>   #include "exec/target_page.h"
>   #include "file.h"
>   #include "migration-stats.h"
> diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
> index 6a0e989fae..7419e5dc0d 100644
> --- a/migration/multifd-qatzip.c
> +++ b/migration/multifd-qatzip.c
> @@ -13,7 +13,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "exec/ramblock.h"
> +#include "system/ramblock.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "qapi/qapi-types-migration.h"
> diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
> index 88e2344af2..52902eb00c 100644
> --- a/migration/multifd-qpl.c
> +++ b/migration/multifd-qpl.c
> @@ -14,7 +14,7 @@
>   #include "qemu/module.h"
>   #include "qapi/error.h"
>   #include "qapi/qapi-types-migration.h"
> -#include "exec/ramblock.h"
> +#include "system/ramblock.h"
>   #include "multifd.h"
>   #include "qpl/qpl.h"
>   
> diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
> index 6895c1f65a..fd7cd9b5e8 100644
> --- a/migration/multifd-uadk.c
> +++ b/migration/multifd-uadk.c
> @@ -13,7 +13,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/module.h"
>   #include "qapi/error.h"
> -#include "exec/ramblock.h"
> +#include "system/ramblock.h"
>   #include "migration.h"
>   #include "multifd.h"
>   #include "options.h"
> diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
> index f1e988a959..dbc1184921 100644
> --- a/migration/multifd-zero-page.c
> +++ b/migration/multifd-zero-page.c
> @@ -12,7 +12,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/cutils.h"
> -#include "exec/ramblock.h"
> +#include "system/ramblock.h"
>   #include "migration.h"
>   #include "migration-stats.h"
>   #include "multifd.h"
> diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
> index 8cf8a26bb4..8820b2a787 100644
> --- a/migration/multifd-zlib.c
> +++ b/migration/multifd-zlib.c
> @@ -13,7 +13,7 @@
>   #include "qemu/osdep.h"
>   #include <zlib.h>
>   #include "qemu/rcu.h"
> -#include "exec/ramblock.h"
> +#include "system/ramblock.h"
>   #include "exec/target_page.h"
>   #include "qapi/error.h"
>   #include "migration.h"
> diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
> index abed140855..3c2dcf76b0 100644
> --- a/migration/multifd-zstd.c
> +++ b/migration/multifd-zstd.c
> @@ -13,7 +13,7 @@
>   #include "qemu/osdep.h"
>   #include <zstd.h>
>   #include "qemu/rcu.h"
> -#include "exec/ramblock.h"
> +#include "system/ramblock.h"
>   #include "exec/target_page.h"
>   #include "qapi/error.h"
>   #include "migration.h"
> diff --git a/migration/multifd.c b/migration/multifd.c
> index dfb5189f0e..86c83e43c0 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -16,7 +16,7 @@
>   #include "qemu/rcu.h"
>   #include "exec/target_page.h"
>   #include "system/system.h"
> -#include "exec/ramblock.h"
> +#include "system/ramblock.h"
>   #include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "file.h"
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 5d3edfcfec..995614b38c 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -31,7 +31,7 @@
>   #include "qemu/error-report.h"
>   #include "trace.h"
>   #include "hw/boards.h"
> -#include "exec/ramblock.h"
> +#include "system/ramblock.h"
>   #include "socket.h"
>   #include "yank_functions.h"
>   #include "tls.h"
> diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
> index 239be9372d..507de74806 100644
> --- a/tests/qtest/fuzz/generic_fuzz.c
> +++ b/tests/qtest/fuzz/generic_fuzz.c
> @@ -21,7 +21,7 @@
>   #include "fuzz.h"
>   #include "string.h"
>   #include "system/memory.h"
> -#include "exec/ramblock.h"
> +#include "system/ramblock.h"
>   #include "hw/qdev-core.h"
>   #include "hw/pci/pci.h"
>   #include "hw/pci/pci_device.h"
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2cc0b54ec4..212435e302 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3111,7 +3111,7 @@ F: include/system/ioport.h
>   F: include/exec/memop.h
>   F: include/system/memory.h
>   F: include/system/ram_addr.h
> -F: include/exec/ramblock.h
> +F: include/system/ramblock.h
>   F: include/system/memory_mapping.h
>   F: system/dma-helpers.c
>   F: system/ioport.c

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


