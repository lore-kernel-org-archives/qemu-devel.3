Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2EEC3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs4b-0002p1-9m; Mon, 19 May 2025 00:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uGrmu-0004lI-3f
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:41 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uGrmq-00048w-3I
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:39 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-30ecc762cb7so811999a91.1
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1747627654; x=1748232454; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+3ZuYq+x9kFtr1OyrTJo9g69tzuSK4CN4Scb9G+xpT4=;
 b=ecWvLcz9yJU73dQUKak6cGbG9PzVHO7b/onV529vjqAGYTVrOTIEdi4P2tz994ppHy
 TkNb8YyFBkqkFy+ysxvp+vV2W0OmDmpVcaRTNj2wRglA30gP1y3sMJ/7qTjjwpr2Y9Q1
 NUBMvAG0o3y/AJF3rrUnjdxWXjUEwkMRYXGYm5bOuDfspXk2+UhVsZ2SR1GMGTLwGuHK
 nowTnATcVqMQSR26osWFC+4lw6kASmf9FcrS3vXMRByNmWuUk75/+aMmWUalcMfXmHUx
 hEFax46KSeg/PMfUhstOTwIYk53Uy1KnVA/oYjxWKPjYfU2mizSyX/bD/TkSGwj0RIFf
 +rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627654; x=1748232454;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+3ZuYq+x9kFtr1OyrTJo9g69tzuSK4CN4Scb9G+xpT4=;
 b=EYfXxSjEY2pwUDs0gO3sUuMj8ezFjaMXYUlU6PbyPFg8bgGwirDz3521pGy5WK96zW
 aqBxN4G8jaHaJoRlB17adri3KDl3DPyvtfR54ME7QYmhXhi6jdUWOYN96/lEh1NFwyGg
 WUbVfAZWljUn4VgBCaD8lNuC6RF1Xyai0Ho1F0rRkIYkfzw5v39owFInyRVYhH8rWtav
 w8J5HxnZLXuu0a7cgzpHnSWSqSEgUFgG+eyNUsz4tFZVrvTD7/q+Yamlaboh+Mm56MET
 jVwdhOpFw8Oqzee21csU+3M3B3ZS+IOQCujwDtEqK1vpO5+Xv40PaTZBOZVCZEG+jAZa
 iPEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGFi12rQvAZOGH9B3T3TNn8EOAl0ZNqmvI0Qzc5Lu0jcwJqfos8K+x4UyD9e8Z68JCGV5tjaDjBQyn@nongnu.org
X-Gm-Message-State: AOJu0YxXU/xs82CC73ajl2VUVd1dBy0l+BGOeDjZZTUcHiTdM8oEsbVR
 cIgGklkUz6DCkWisnh1ab+ONzD0XFAmNJVe4rgR4twmxQIP13gY+2BBsbVfQ6S8dNKs=
X-Gm-Gg: ASbGncvyUAhvytpqjWgULnGEJQSKTSZTpQdG0wLdODI994YCbAeGJdZFK/7VdM8iWUF
 BpZOSD3gZRjCy1LtgjhPUDP4/O+FmE/yGVwI5crKdi4y3B4zPUuP/91c+VMguPNtw0h0oP2IkYu
 Cs2kcgs4cfXGdq/7n3J+ADMy5mFNcJSwP0HnF3WNskLleP0WyAHv6yrZcDJO+Of5A1RNHuHScPv
 2uN6gwZX/jofjBwsHyTE0581i4eAMSd4UJfGYniPUaq3tzXym8V786iM6UpcG6B4SanYeZhnjsH
 wVD4jrI0t/FKc8UdZfeXhgEyJcpVowZlM6B9K/pTUvA5WpOJ3SuerUAMOLM=
X-Google-Smtp-Source: AGHT+IHUx0vbqdxGAcB2VDXygAGOHP7VwURn9nh/+eiscdMXWc1t6XJc3MYLezARPdRzs/vWsHAVKQ==
X-Received: by 2002:a17:90b:3bce:b0:2fe:b907:5e5a with SMTP id
 98e67ed59e1d1-30e4db3d8c5mr22296901a91.10.1747627654078; 
 Sun, 18 May 2025 21:07:34 -0700 (PDT)
Received: from sunil-laptop ([103.97.166.196])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30e7d591862sm5590679a91.47.2025.05.18.21.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:07:33 -0700 (PDT)
Date: Mon, 19 May 2025 09:37:23 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Li Chen <me@linux.beauty>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?Q?=22Philippe_Mathieu-Daud=C3=A9=22?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-riscv <qemu-riscv@nongnu.org>
Subject: Re: [PATCH V3 4/4] acpi/virt: suppress UART device & SPCR when guest
 has no serial hardware
Message-ID: <aCque4iAzEc8VWAx@sunil-laptop>
References: <87msberqzi.wl-me@linux.beauty>
 <87h61mrqko.wl-me@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h61mrqko.wl-me@linux.beauty>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pj1-x102c.google.com
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

On Thu, May 15, 2025 at 08:44:39PM +0800, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
> 
> The virt machines always instantiate a PL011/16550 at UART0 and
> describe it in ACPI (DSDT device node plus optional SPCR table).  When
> the command line contains “-serial none” there is no backend attached to
> that UART, yet the guest still discovers it via ACPI and may try to use
> it as a console, causing unexpected results.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> ---
> 
>  hw/arm/virt-acpi-build.c   | 15 +++++++++------
>  hw/riscv/virt-acpi-build.c |  6 ++++--
>  include/system/system.h    |  2 ++
>  system/vl.c                |  5 +++++
>  4 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index f25c3b26ce..8a1cde4b44 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -59,6 +59,7 @@
>  #include "hw/acpi/viot.h"
>  #include "hw/virtio/virtio-acpi.h"
>  #include "target/arm/multiprocessing.h"
> +#include "system/system.h"
>  
>  #define ARM_SPI_BASE 32
>  
> @@ -825,11 +826,13 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>       */
>      scope = aml_scope("\\_SB");
>      acpi_dsdt_add_cpus(scope, vms);
> -    acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0],
> -                       (irqmap[VIRT_UART0] + ARM_SPI_BASE), 0);
> -    if (vms->second_ns_uart_present) {
> -        acpi_dsdt_add_uart(scope, &memmap[VIRT_UART1],
> -                           (irqmap[VIRT_UART1] + ARM_SPI_BASE), 1);
> +    if (serial_exist()) {
> +        acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0],
> +                           (irqmap[VIRT_UART0] + ARM_SPI_BASE), 0);
> +        if (vms->second_ns_uart_present) {
> +            acpi_dsdt_add_uart(scope, &memmap[VIRT_UART1],
> +                               (irqmap[VIRT_UART1] + ARM_SPI_BASE), 1);
> +        }
>      }
>      if (vmc->acpi_expose_flash) {
>          acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
> @@ -941,7 +944,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  
>      acpi_add_table(table_offsets, tables_blob);
>  
> -    if (ms->enable_spcr) {
> +    if (ms->enable_spcr && serial_exist()) {
>          spcr_setup(tables_blob, tables->linker, vms);
>      }
>  
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 7f6d221c63..4e0f695a16 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -39,6 +39,7 @@
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "system/reset.h"
> +#include "system/system.h"
>  
>  #define ACPI_BUILD_TABLE_SIZE             0x20000
>  #define ACPI_BUILD_INTC_ID(socket, index) ((socket << 24) | (index))
> @@ -449,7 +450,8 @@ static void build_dsdt(GArray *table_data,
>                                   memmap[VIRT_APLIC_S].size, "RSCV0002");
>      }
>  
> -    acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ);
> +    if (serial_exist())
> +        acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ);
>  
>      if (socket_count == 1) {
>          virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
> @@ -681,7 +683,7 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
>  
>      acpi_add_table(table_offsets, tables_blob);
>  
> -    if (ms->enable_spcr) {
> +    if (ms->enable_spcr && serial_exist()) {
>          spcr_setup(tables_blob, tables->linker, s);
>      }
>  
> diff --git a/include/system/system.h b/include/system/system.h
> index a7effe7dfd..ca1af38432 100644
> --- a/include/system/system.h
> +++ b/include/system/system.h
> @@ -75,6 +75,8 @@ extern unsigned int nb_prom_envs;
>  /* Return the Chardev for serial port i, or NULL if none */
>  Chardev *serial_hd(int i);
>  
> +bool serial_exist(void);
> +
>  /* parallel ports */
>  
>  #define MAX_PARALLEL_PORTS 3
> diff --git a/system/vl.c b/system/vl.c
> index 520956f4a1..7e219df7bf 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -1484,6 +1484,11 @@ Chardev *serial_hd(int i)
>      return NULL;
>  }
>  
> +bool serial_exist(void)
> +{
> +    return serial_hd(0) ? true : false;
> +}
> +
LGTM.

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

