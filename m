Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19DEE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 20:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMCQi-0006OU-00; Fri, 13 Dec 2024 15:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tMCQc-0006O9-Ma
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 15:38:26 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tMCQa-0004Nd-O4
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 15:38:26 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-725d9f57d90so1605300b3a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 12:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1734122301; x=1734727101; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1JjGb0mggJgm1DIVY3xrORZVD2wuCdXVN3H6PRG6xzU=;
 b=NpJmoOGkQdX+sI2bCyr1KR6Om9RxRMEfIikWZTR5QppVKLPCrV83fEs6QZ4IMTYKVK
 qKV8Z9MTvyTxRkrGLA0DCsOCr/9/ZCmHn1QaG0yiNDPOtXQNxgYgkTgjSZHOzYxYkSIu
 HYF6agToi/E0VE86jiiHf1fayry4ZCg9Mvp9XswRWIOK1wc9iBqH79enSYjifYTqf/+G
 4szaZMJAvYX9H4n+7cOfWVddcBmxAiwCwv16P0fYuqh0s/ZBGw+j7KOkjdTDPYv3ok9v
 vHyIYkGgfTMyHqPFoYmOL1WAuAQ0Y/LYcqU6k1Q1KRiYP6Mg3RdVas+mj+owhhd5uby/
 3D9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734122301; x=1734727101;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1JjGb0mggJgm1DIVY3xrORZVD2wuCdXVN3H6PRG6xzU=;
 b=qZS0GBp9tJcGNJUuy4F+SvEW6MG9lRu2dgfjD7Za1klPb4Vu8iT3MFVoly3O8XObWa
 Gsydq906pNX4iMJpp/1AvkGNug5sh9OWECZbnLrCsj7+N4XkFyNpCGkD8xJm+HojrDNI
 86C9B+A6x8pL5SHYC0OOt25yW2dzKhNcsO2PsDcCDTqDpk2bQ53PUDoyIPYBq3w1f/bM
 jYkgopeSjGGc2y85tFmh4aIUcaiqUf/lMHOiyI3ViBa/+xL9twzxJPUJlD2YMEr42/yr
 63gR6HBovjNaUnrAhL9yOqydi4ptSM3spE6k65dL8Kh0yPSKIIGlgqQRkqA6OMYFecJm
 T+qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpQKbPLPlVJk6+x1k2d5KGWT1ahxyIx76MWCANEbQxLdnthD8LwzUgiq5dQW+hDGH2+GSDtpxLeu+s@nongnu.org
X-Gm-Message-State: AOJu0YwwITeFlvV8SFTm9o0y/nR3VxSWOpC6vcmzgHrJseJ/4b12k+4D
 CNgTJ/+HbbHyqNK43M7iepzEpt4IoZYtBSQ1IoywfgCVHKFBq/MdOfeaoPopHlo=
X-Gm-Gg: ASbGnctYJGQYMsbtG6NPewsZ6ObAFXMmopFfXTqbEABDq7xR2JdMrDSwyM88xVUR43/
 /R/zXZkb6hQZuDg0PozPvqlSO2EIT4Zl0T4x+2y8X4ZlrcenIpQtxPIw7GZQ3ujYWBa/H+52QDo
 rt8jhiVAEYzqINfERM0Oov8WKklUSVdBEm0sJokF9WoTpRSozWF1nKQKXLblgK/gfM7dodCrDTK
 jjRRIy9i0Pk3I/Rr+iCEEixSJaZdLUfbNQ3WcwO3/rJ3z0j1Vj9GPZ841AvbCvNLksXA9VigkZ/
 BfxKOlLSlR9xSsFOWLDqTPWYwuysCjMu
X-Google-Smtp-Source: AGHT+IEZenXNbe8Yp7WLN0CAgoD3k8MKoye5E3zPSOnTirvw9K1meYaPJSbzpPk5H77VXno7kPIAXg==
X-Received: by 2002:a05:6a21:1796:b0:1e0:ca95:3cb3 with SMTP id
 adf61e73a8af0-1e1dfe96d96mr6748744637.37.1734122301541; 
 Fri, 13 Dec 2024 12:38:21 -0800 (PST)
Received: from ?IPV6:2804:7f0:bcc0:51cf:9cf:d2f2:d49e:7bd9?
 ([2804:7f0:bcc0:51cf:9cf:d2f2:d49e:7bd9])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918ac53cdsm210960b3a.23.2024.12.13.12.38.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 12:38:21 -0800 (PST)
Message-ID: <b6ed5e56-b50c-4287-9d8d-466f6f6b13ff@ventanamicro.com>
Date: Fri, 13 Dec 2024 17:38:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 51/71] hw/riscv: Constify all Property
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:OpenTitan" <qemu-riscv@nongnu.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-56-richard.henderson@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241213190750.2513964-56-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42c.google.com
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



On 12/13/24 4:07 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   hw/riscv/opentitan.c       | 2 +-
>   hw/riscv/riscv-iommu-pci.c | 2 +-
>   hw/riscv/riscv-iommu.c     | 2 +-
>   hw/riscv/riscv_hart.c      | 2 +-
>   hw/riscv/sifive_u.c        | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> index e2830e9dc2..8ce85ea9f7 100644
> --- a/hw/riscv/opentitan.c
> +++ b/hw/riscv/opentitan.c
> @@ -306,7 +306,7 @@ static void lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
>           memmap[IBEX_DEV_IBEX_CFG].base, memmap[IBEX_DEV_IBEX_CFG].size);
>   }
>   
> -static Property lowrisc_ibex_soc_props[] = {
> +static const Property lowrisc_ibex_soc_props[] = {
>       DEFINE_PROP_UINT32("resetvec", LowRISCIbexSoCState, resetvec, 0x20000400),
>       DEFINE_PROP_END_OF_LIST()
>   };
> diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
> index a42242532d..a695314bbe 100644
> --- a/hw/riscv/riscv-iommu-pci.c
> +++ b/hw/riscv/riscv-iommu-pci.c
> @@ -157,7 +157,7 @@ static void riscv_iommu_pci_init(Object *obj)
>       iommu->icvec_avail_vectors = RISCV_IOMMU_PCI_ICVEC_VECTORS;
>   }
>   
> -static Property riscv_iommu_pci_properties[] = {
> +static const Property riscv_iommu_pci_properties[] = {
>       DEFINE_PROP_UINT16("vendor-id", RISCVIOMMUStatePci, vendor_id,
>                          PCI_VENDOR_ID_REDHAT),
>       DEFINE_PROP_UINT16("device-id", RISCVIOMMUStatePci, device_id,
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index bbc95425b3..07fed36986 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2235,7 +2235,7 @@ static void riscv_iommu_unrealize(DeviceState *dev)
>       g_hash_table_unref(s->ctx_cache);
>   }
>   
> -static Property riscv_iommu_properties[] = {
> +static const Property riscv_iommu_properties[] = {
>       DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
>           RISCV_IOMMU_SPEC_DOT_VER),
>       DEFINE_PROP_UINT32("bus", RISCVIOMMUState, bus, 0x0),
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index 613ea2aaa0..0df454772f 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -27,7 +27,7 @@
>   #include "hw/qdev-properties.h"
>   #include "hw/riscv/riscv_hart.h"
>   
> -static Property riscv_harts_props[] = {
> +static const Property riscv_harts_props[] = {
>       DEFINE_PROP_UINT32("num-harts", RISCVHartArrayState, num_harts, 1),
>       DEFINE_PROP_UINT32("hartid-base", RISCVHartArrayState, hartid_base, 0),
>       DEFINE_PROP_STRING("cpu-type", RISCVHartArrayState, cpu_type),
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index c5e74126b1..124ffd4842 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -936,7 +936,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>                          qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_QSPI2_IRQ));
>   }
>   
> -static Property sifive_u_soc_props[] = {
> +static const Property sifive_u_soc_props[] = {
>       DEFINE_PROP_UINT32("serial", SiFiveUSoCState, serial, OTP_SERIAL),
>       DEFINE_PROP_STRING("cpu-type", SiFiveUSoCState, cpu_type),
>       DEFINE_PROP_END_OF_LIST()


