Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7BECF65DB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 12:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkLFk-0007lN-G7; Mon, 26 Jan 2026 06:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vkLFi-0007ky-Vw
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 06:59:31 -0500
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vkLFh-0003NZ-7M
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 06:59:30 -0500
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-8c52e25e644so474658285a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 03:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1769428767; x=1770033567; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xgmEAmE6/Ad5Dj9XGSiR7Q4IXQ6Hi/VQOrGmTuJkqVM=;
 b=COgO59o+kRmUAPZnhOTYRgE88TFSXfBda0YQvS7CDrmnoO1II3UFoo9P/2xqN2Oy+o
 EmBFx+x9ckZWPAVhalfpe+Z+otJci47mgwStfqXsq1AEO3Y775VYFr4yuN+BGKW/Ehqu
 QRWaJs2TrA+aS0utHIJF5orjyp1vC94bEjat4jDDJnKVZItA4++ttOKAGarP29rLfEof
 IIfV7VGs1oTQcmW/myChH9hQFAyY/MIhO1/+4OtNlF/VQ8BSjuta6qXD7oXRo4s8wq5x
 Q9JUAuOoq/yZB+vcqfJcBpKL9ZheMQzGrCJxAVEkSAoHaHAo8QPg0D7BG1K+3t185L/E
 7I8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769428767; x=1770033567;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xgmEAmE6/Ad5Dj9XGSiR7Q4IXQ6Hi/VQOrGmTuJkqVM=;
 b=HVhuCU3pwBkLwjCdI0dt10r417s0agLlhjvxVdThb/hhuvdza7CGUzyjVlwRlE0z1N
 xLRdtSVMEw9n+5Ib5XIgjOYcD/BIa0r9tTxRfx7BSc09HAXXJpyGjLkClYwwf4M3Lq2Z
 xgNPRV7Vc9zvel2oC1DIm/iodsahQ0C25lE3X2/wLHxOe8pnBt9lJqKL60yCit5LmxYO
 gK1kWhpTzOhGprvSVqvBtTvYqQqg01KTJpRsxgsw4uQzqTU5J9OVckGMVAcCbDuJkb9N
 Ml2Z3nMagTWiQjc6Z3jfUCko7wW9Rzxr6q22NkIwRYJvcfCHIY0z7pcCbAZcEkl7yCfn
 w82g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmYnNWqw7m9bgFK889eUSmP94A1EwynM1EfWZnce0kZiqRXHS2QHgWy0f1oR46dplS7v21d/dG8byw@nongnu.org
X-Gm-Message-State: AOJu0YwamOCN4ql/jQW6Rwp8Mx/SAQYjwN0ytIhD/WYdeP8Gz/YhxXkB
 ySAIKRi+tny8AxkTI2hINsgubdaQt3pwz8nSq7qmT7veeO7JRrd+4Hhtl555/X4shbA=
X-Gm-Gg: AZuq6aLidk9SqfFW+LJhYUBofMoHbMra/hLgly+rTUWEpaSQ0UKHRYAe/WRbTZW3H5x
 adxQA1x30exLxbJLvsnvAWHxDLVH5fYhUmYEi5pPnanDEUGXOii/CnEBSA9OJ1L8NJMXDrGydnp
 07sQq4l1kSCL4P643kfympbWHRJddxaghZ+pJ+Rtoay9CkBArlBJHjeNZd9z73QdgthUW6dsiaW
 hb+Rn+JrB1iX49SwE7BfdMvJucrJiTucPjwJJV2mDyYegy5DhDH207K3FQohdupHITL8URXTf3L
 NUk05XrrirLFPcrd8iCIkU8iZ07pNPj47fnUUeRjk+Sc5UEmtfBGZr/S71ENphm1RAeWCosfpiR
 ckCTSRJTLKTNseI58M/fBu26GsGlmL/a76UXFkjlYIgnUGAbZqTnGf2ohokUBN6WBQA6w3fKi2Q
 nuyrOU5aIpjX3KRFW+fXowsyq1zc/QVH+BjRSuUMXuxTkIM7ZF/Q==
X-Received: by 2002:a05:620a:c45:b0:8b2:f26e:3220 with SMTP id
 af79cd13be357-8c6f95817d4mr503152185a.8.1769428767298; 
 Mon, 26 Jan 2026 03:59:27 -0800 (PST)
Received: from [192.168.68.103] ([152.234.122.35])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6e37124d6sm1051972385a.0.2026.01.26.03.59.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 03:59:26 -0800 (PST)
Message-ID: <f72674c2-9828-4ee7-84d8-2eaac776de68@ventanamicro.com>
Date: Mon, 26 Jan 2026 08:59:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/virt-acpi-build.c: Add TPM2 device node and ACPI
 table support
To: Tuan Phan <tuan.phan@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260120194033.4049570-1-tuan.phan@oss.qualcomm.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260120194033.4049570-1-tuan.phan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x72e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 1/20/2026 4:40 PM, Tuan Phan wrote:
> This patch enables TPM2 support in the RISC-V virt machine ACPI builder.
> 
> Signed-off-by: Tuan Phan <tuan.phan@oss.qualcomm.com>
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/virt-acpi-build.c | 59 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 59 insertions(+)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index f1406cb683..b300492b2f 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -32,6 +32,7 @@
>   #include "hw/intc/riscv_aclint.h"
>   #include "hw/nvram/fw_cfg_acpi.h"
>   #include "hw/pci-host/gpex.h"
> +#include "hw/core/platform-bus.h"
>   #include "hw/riscv/virt.h"
>   #include "hw/riscv/numa.h"
>   #include "hw/virtio/virtio-acpi.h"
> @@ -39,6 +40,7 @@
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "system/reset.h"
> +#include "system/tpm.h"
>   
>   #define ACPI_BUILD_TABLE_SIZE             0x20000
>   #define ACPI_BUILD_INTC_ID(socket, index) ((socket << 24) | (index))
> @@ -224,6 +226,44 @@ static void acpi_dsdt_add_iommu_sys(Aml *scope, const MemMapEntry *iommu_memmap,
>       aml_append(scope, dev);
>   }
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
> +    if (tpm_base == -1) {
> +        error_report("Failed to get TPM MMIO address");
> +        exit(1);
> +    }
> +
> +    tpm_base += pbus_base;
> +
> +    sbdev_mr = sysbus_mmio_get_region(sbdev, 0);
> +
> +    Aml *dev = aml_device("TPM0");
> +    aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
> +    aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Device")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +
> +    Aml *crs = aml_resource_template();
> +    aml_append(crs,
> +               aml_memory32_fixed(tpm_base,
> +                                  (uint32_t)memory_region_size(sbdev_mr),
> +                                  AML_READ_WRITE));
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +    aml_append(scope, dev);
> +}
> +#endif
> +
>   /*
>    * Serial Port Console Redirection Table (SPCR)
>    * Rev: 1.10
> @@ -479,6 +519,10 @@ static void build_dsdt(GArray *table_data,
>           acpi_dsdt_add_iommu_sys(scope, &memmap[VIRT_IOMMU_SYS], IOMMU_SYS_IRQ);
>       }
>   
> +#ifdef CONFIG_TPM
> +    acpi_dsdt_add_tpm(scope, s);
> +#endif
> +
>       if (socket_count == 1) {
>           virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
>                                memmap[VIRT_VIRTIO].size,
> @@ -914,6 +958,16 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
>           }
>       }
>   
> +#ifdef CONFIG_TPM
> +    /* TPM info */
> +    if (tpm_get_version(tpm_find()) == TPM_VERSION_2_0) {
> +        acpi_add_table(table_offsets, tables_blob);
> +        build_tpm2(tables_blob, tables->linker,
> +                   tables->tcpalog, s->oem_id,
> +                   s->oem_table_id);
> +    }
> +#endif
> +
>       /* XSDT is pointed to by RSDP */
>       xsdt = tables_blob->len;
>       build_xsdt(tables_blob, tables->linker, table_offsets, s->oem_id,
> @@ -1025,6 +1079,11 @@ void virt_acpi_setup(RISCVVirtState *s)
>                                                build_state, tables.rsdp,
>                                                ACPI_BUILD_RSDP_FILE);
>   
> +#ifdef CONFIG_TPM
> +    fw_cfg_add_file(s->fw_cfg, ACPI_BUILD_TPMLOG_FILE, tables.tcpalog->data,
> +                    acpi_data_len(tables.tcpalog));
> +#endif
> +
>       qemu_register_reset(virt_acpi_build_reset, build_state);
>       virt_acpi_build_reset(build_state);
>       vmstate_register(NULL, 0, &vmstate_virt_acpi_build, build_state);


