Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48486D7495D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 08:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWVsJ-0003Aj-2t; Fri, 19 Dec 2025 03:30:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vWVsF-00038j-PJ
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 03:30:07 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vWVsE-0002G0-3u
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 03:30:07 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2a137692691so17523515ad.0
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 00:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766133004; x=1766737804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:subject:references:cc:to
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yoLJXVcx5GkTwYq8VbHVtXNivhEcqi5wmCmX7/7K6J4=;
 b=SyYmEW9YMbF8S4u4q4aYok6GA1DbHVxTrP4wGkdLT9KgvVU6YZIfT48rRw9GKcrQSr
 qlTyPHZLRtdmi7A4R4cjiwFAmWWYuqA4z9vAeoSnUNvab2cpPWdLzUfOVu6vqoCCM5LC
 VL2KGPuxgvlQOgFT/cjOxzJTEOCDI/wi9TWAxokZr9C9v6exDrdD4DD/uquN1FXIGLs2
 sdgGY+zDGPKvNnvMqmXcVsCFM/K/+/wXtIeLmaH/4JBPf8CFSaXFF5qV3zEHX22FlXJw
 0Gai8jEjSSSNz/GKZFQvUdm9fuVe4JEj91O488DJJasVUkVvIcMxA05pfyEPn0G1y00C
 yCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766133004; x=1766737804;
 h=content-transfer-encoding:in-reply-to:from:subject:references:cc:to
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yoLJXVcx5GkTwYq8VbHVtXNivhEcqi5wmCmX7/7K6J4=;
 b=j8KyFU+lxci8HSk5fqSRQTEsnU+qKqLRMN2uKGCzDqvx68e/52VRAvbcwGvlXiTxO9
 GffbBlv+FcLDKwtYkLgmNMDQ89CeeQZzy2ZP7gBsH1tWux+Z9LadGcPzSHP1DEw8cY+A
 8QJyf+aeMmQWguqWTqBKHBeUmF7gbRRG/pnf8wtGCeH0IOUk8a+VaI/uFTqf9Y94tJSv
 XGmRmK0dPpLnvMOgRNypY4t1t5sEla5AQvAofW/RcsFVeQUSoeGXmtA1sDHIDgInXbCw
 LB7lEZIYOkw5Yyt762trdwWJiuAhHbDh046iydj9UsRtABIIO2TUDcaRFQSAVOxQKua3
 ICFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFZggnxyEfUwkJekyyJryYc91wy8mzmR69jgBit6nj4ceyU1o/1yPEZ/ctMDFXdfykmZM8l5wVviGW@nongnu.org
X-Gm-Message-State: AOJu0YyED8QuFU7gwEsADs+N1cOcuq48SbpZZf01wl+tgxfDubo8ucF5
 YdI44D0TXreIOm9AkfxFFZUYIZWWpS58ZWydXtl68EQhHwCE8Mgc5Mf85VYqxYwA
X-Gm-Gg: AY/fxX5Rjr7SPKxjfwOn+afb5WTd65C8WlQIAO2t56rMQ2HSozpP10kZJqho5ZZhaYt
 jA9VprUTvmdjgkHZC5DgNAyiLwNewPpqFMLKSp71LEcxMsSUf2neNRIrPB2Pmy5fF7rfDRQAHlc
 g6sGwdTtMe35HTqwant3k9ibsNfHqicU+T9mAe8c2yiBjbcbo7TQfNoSEiU/7zoHiZPCNKefgCe
 N6R/enU035v3lKrkVoqMGJ6tIhrQKeoHYw1NBG64J7EDYwHrPP7o5Rt8iocDEqkaiAPIlYB+4z/
 CveslMmexeoQi8jFH9qt3kmBEoyTW0ilYJYzjP+xsnv/z8+tj6mlrGdOEddaSe18hkBU1mHTWT2
 cBAJoXj3NExQEfyidzywggA0Fz8OuDeDvyNSIQfzmCRmrHkRFr2pIeYHKs5FBx5URmzpqQsqC2E
 R/7P9UWy8rzt++HXEwdYQRaMRixe0VwkA=
X-Google-Smtp-Source: AGHT+IGZRGHevRth+N54zI4LQ5R01EEEw6AA0ZgugPeaf3epZNg3gHyu/WJsqcdw1VIJNbkVwQsNrg==
X-Received: by 2002:a17:902:da81:b0:29e:e642:95d6 with SMTP id
 d9443c01a7336-2a2f2a423afmr22966665ad.59.1766133004035; 
 Fri, 19 Dec 2025 00:30:04 -0800 (PST)
Received: from [127.0.0.1] ([218.81.29.112]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c87845sm15666695ad.39.2025.12.19.00.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Dec 2025 00:30:03 -0800 (PST)
Message-ID: <5ed187df-61ae-4a59-98b2-cb2cc32b084a@gmail.com>
Date: Fri, 19 Dec 2025 16:29:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: tphan@ventanamicro.com
Cc: alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 palmer@dabbelt.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 sunilvl@ventanamicro.com, zhiwei_liu@linux.alibaba.com
References: <20251203002259.2856-1-tphan@ventanamicro.com>
Subject: Re: [PATCH] hw/riscv/virt-acpi-build.c: Add TPM2 device node and ACPI
 table support
From: Chao Liu <chao.liu.zevorn@gmail.com>
In-Reply-To: <20251203002259.2856-1-tphan@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pl1-x644.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue,  2 Dec 2025 16:22:59 -0800, Tuan Phan wrote:
> This patch enables TPM2 support in the RISC-V virt machine ACPI builder.
>
> Signed-off-by: Tuan Phan <tphan@ventanamicro.com>
> ---
>  hw/riscv/virt-acpi-build.c | 56 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index f1406cb68339..b5bf812a9d36 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -32,6 +32,7 @@
>  #include "hw/intc/riscv_aclint.h"
>  #include "hw/nvram/fw_cfg_acpi.h"
>  #include "hw/pci-host/gpex.h"
> +#include "hw/platform-bus.h"
>  #include "hw/riscv/virt.h"
>  #include "hw/riscv/numa.h"
>  #include "hw/virtio/virtio-acpi.h"
> @@ -39,6 +40,7 @@
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "system/reset.h"
> +#include "system/tpm.h"
>
>  #define ACPI_BUILD_TABLE_SIZE             0x20000
>  #define ACPI_BUILD_INTC_ID(socket, index) ((socket << 24) | (index))
> @@ -224,6 +226,41 @@ static void acpi_dsdt_add_iommu_sys(Aml *scope, const
MemMapEntry *iommu_memmap,
>      aml_append(scope, dev);
>  }
>
> +#ifdef CONFIG_TPM
> +static void acpi_dsdt_add_tpm(Aml *scope, RISCVVirtState *s)
> +{
> +    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(s->platform_bus_dev);
> +    hwaddr pbus_base = s->memmap[VIRT_PLATFORM_BUS].base;
> +    SysBusDevice *sbdev = SYS_BUS_DEVICE(tpm_find());
> +    MemoryRegion *sbdev_mr;
> +    hwaddr tpm_base;
> +
> +    if (!sbdev) {
> +        return;
> +    }
> +
> +    tpm_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> +    assert(tpm_base != -1);
> +
I suggest reporting an error message when the tpm_base check fails.

    if (tpm_base == -1) {
        error_report("Failed to get TPM MMIO address");
        exit(1);
    }

Thanks,
Chao

