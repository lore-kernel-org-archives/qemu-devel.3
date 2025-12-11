Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BE0D41C36
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 13:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTgRG-0007Qb-4W; Thu, 11 Dec 2025 08:10:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vTgRD-0007QE-RR
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 08:10:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vTgRA-0005Dq-9r
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 08:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765458625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nxgZ5rHwXEKGnjUs10atvCH4X26HiDa9P76X5oSwGZw=;
 b=EBX4lIXKKzKKPq0OovHsy1V635o2jD1bhpdYKIU9JcIcK+2pezYVeVq246zaTKmkyed8F9
 uWR42LA1Er3+bF4/j9jel4FPzvIjyRtM/25KLTa+XSiAxPq7pE+MF64FdqYXZ1L3+afsss
 9fwqw3GuPYAwozgUw4BGm/hwzSKIqqQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-Z5enewnDMVCFjWdFkYhapQ-1; Thu, 11 Dec 2025 08:10:24 -0500
X-MC-Unique: Z5enewnDMVCFjWdFkYhapQ-1
X-Mimecast-MFC-AGG-ID: Z5enewnDMVCFjWdFkYhapQ_1765458623
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b487cda00so48444f8f.3
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 05:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765458623; x=1766063423; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nxgZ5rHwXEKGnjUs10atvCH4X26HiDa9P76X5oSwGZw=;
 b=gvsYOBUtNbe3TAWpQut58JzHCMTjwqwTUT9QGpYbYpNqiW5ZLc4oAe3PBpFi9s6zDI
 302h4aHSqmzE3rbyrKUixReyKg34wH4eQhbAehLgH+Oard2jY2pJXtu3feFJ5g++BRhp
 DjlkRYftOL2WiWe/X6r2rQFTFbR5Si1+YCq6bcxjX17IJkLTmlSzClDcrBwb9TkWAZ88
 4iG14ICQOxDJ78tJotF62TLkJ1YJ3k71/edmreWWGDFALgauQoZH3lzaytcXh9KoSSEa
 5TqMbaMOt3O85XPd0a9tUFKusfmOJi7m2837/R908SqdyKizZCUqMNQRag6KRzgUjgVI
 LsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765458623; x=1766063423;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nxgZ5rHwXEKGnjUs10atvCH4X26HiDa9P76X5oSwGZw=;
 b=FjYOyUU4a2Fmm614I05L7dFiEChjeeP+DRmIqAPjW8OQaBDf7ZqRZHnxzlfNe3exjx
 INjOCtcG0yEOSO0y1edUTCAFXbP5pJ11vpTH0T6Hbv+2jell5tqJNVcTipHOLBGKeEsR
 aBcy9oUonEiAntvIBQpS0FkFpTMxgapeAR0K+Rf1JFQJqpqMG59FicBplicRHN6umxvF
 +j5hZ6EnUmU2P2nqflMIcQA+cIh4BId/U0+T4jNIWxQ+V8sjf94MYMtsM9+7f/hGmcm2
 j3OuaBMTCPVFiO3rLiLwxlWc8XTBKpH8Fd68nJ6htHDA3mQaj2W3gR1G4JAS5GSlhcKy
 LlkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtAag5eP9x4Yu1DIk3KzRbKQMEa5Xr9eOPI9pL7DcsezLtUMFWZZB2JdqvqvLthnGjoUTlxsUkiwze@nongnu.org
X-Gm-Message-State: AOJu0Yw2f2Q0bhDAmoDNXYljV+4H9/rRO3TBAoDf8kcyRW6RzabdpEiG
 ey8Zvu5jhStw1Xdk/jaM5SEi4IHitapNn9WuKTY7oPjFTIVpndyWGpyDgv3v0kN5XgvwI+GHH30
 VuCxegxcvjIonhX3pMmauBs+uom+2emJMebe2ggZvv27KRNIBwdovMuKl
X-Gm-Gg: AY/fxX4epWsojwWcdnrRYkrtfjamvxR3C1vCKOWfdajnLvfMisPq/sl1zvn95BL/lEF
 Jexa93u8DMOfjk703LzLVu/Skk3t37qVduWg5U60CLxB1B/bVHx6ozFCQPupzkPUugYc0zf3Ii5
 yrbQesjx8EG7IA1u1Zp5Ro/aSJcRMC3/VR7TbCt+ShsBsSe12WiO92YqXbB9OAjyRDHZD4pEu8Y
 FD2jzDVfbg0ef4pvKRmvCZe2GseS6BA+dXU5GYM0J/ObPUjdx26LHi2Mtbe8ZYlze8z3BH7ehFw
 CjI/YiNZ9lP/eN1BIcDb9ul1yhYn/26948GK+F7tpBnI6M/7RkEl882p8OZNALXgYDFh8wC4DS2
 ZTfZzhiguUcDIvPDtKTDWq3UdP/NOMho=
X-Received: by 2002:a05:600c:19c8:b0:46e:506b:20c5 with SMTP id
 5b1f17b1804b1-47a83810f1bmr64727435e9.26.1765458622623; 
 Thu, 11 Dec 2025 05:10:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnO4xQkRH8Oq6BtFsNihke7JXq5v93qZLrVAplcGFprC2BA7KhkQ2o9ofGGvV46tH/QDDh8Q==
X-Received: by 2002:a05:600c:19c8:b0:46e:506b:20c5 with SMTP id
 5b1f17b1804b1-47a83810f1bmr64726905e9.26.1765458622068; 
 Thu, 11 Dec 2025 05:10:22 -0800 (PST)
Received: from redhat.com (IGLD-80-230-32-59.inter.net.il. [80.230.32.59])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a89d04393sm36101945e9.0.2025.12.11.05.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 05:10:21 -0800 (PST)
Date: Thu, 11 Dec 2025 08:10:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Chen <me@linux.beauty>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-riscv <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v6] acpi/virt: suppress UART device & SPCR when guest has
 no serial hardware
Message-ID: <20251211080811-mutt-send-email-mst@kernel.org>
References: <20251211102025.873506-1-me@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251211102025.873506-1-me@linux.beauty>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Dec 11, 2025 at 06:20:25PM +0800, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
> 
> virt machines always instantiate a PL011/16550 UART at slot 0 and describe
> it in ACPI (DSDT and optional SPCR table). When the command line disables
> the serial backend (e.g. "-serial none"), the guest still sees the UART as
> a preferred console even though it is not usable.
> 
> Teach the virt ACPI code to omit the UART device and SPCR when there is no
> serial backend attached. This matches the hardware that the guest can
> actually use and avoids confusing firmware or OS code that relies on SPCR.
> 
> The bios-tables-test qtests rely on an ACPI UART node and SPCR entry for
> UEFI-based virt machines. To keep those tests working we create a UART
> with a "null" chardev backend instead. This preserves the ACPI tables
> while discarding the firmware's serial output so it does not corrupt the
> TAP stdout stream.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

This bothers me:
won't this mean number of serial devices changes silently?  So for
example, if you install a guest, see that 1st serial device is broken,
configure it with 2nd one as a work around, now with your change there
is no second one so guest will be broken?


I seems safer to have compat machinery around and avoid
changing this for old machine types.




> ---
> v4->v5:
> - Also suppress UART device & SPCR when guest has no serial hardware on loongarch
> - rename serial_exist to serial_exists
> - fix style issue
> v5->v6: 
> - Fix: tap parsingg error caused by changing serial to none; now set to null.
> 
>  hw/arm/virt-acpi-build.c       | 15 +++++++++------
>  hw/loongarch/virt-acpi-build.c |  8 +++++---
>  hw/riscv/virt-acpi-build.c     |  8 ++++++--
>  include/system/system.h        |  2 ++
>  system/vl.c                    |  5 +++++
>  tests/qtest/bios-tables-test.c |  6 ++++--
>  6 files changed, 31 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 200e2a1da7..16d3b63030 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -64,6 +64,7 @@
>  #include "hw/virtio/virtio-acpi.h"
>  #include "target/arm/cpu.h"
>  #include "target/arm/multiprocessing.h"
> +#include "system/system.h"
>  
>  #define ARM_SPI_BASE 32
>  
> @@ -1031,11 +1032,13 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>       */
>      scope = aml_scope("\\_SB");
>      acpi_dsdt_add_cpus(scope, vms);
> -    acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0],
> -                       (irqmap[VIRT_UART0] + ARM_SPI_BASE), 0);
> -    if (vms->second_ns_uart_present) {
> -        acpi_dsdt_add_uart(scope, &memmap[VIRT_UART1],
> -                           (irqmap[VIRT_UART1] + ARM_SPI_BASE), 1);
> +    if (serial_exists()) {
> +        acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0],
> +                           (irqmap[VIRT_UART0] + ARM_SPI_BASE), 0);
> +        if (vms->second_ns_uart_present) {
> +            acpi_dsdt_add_uart(scope, &memmap[VIRT_UART1],
> +                               (irqmap[VIRT_UART1] + ARM_SPI_BASE), 1);
> +        }
>      }
>      if (vmc->acpi_expose_flash) {
>          acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
> @@ -1184,7 +1187,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  
>      acpi_add_table(table_offsets, tables_blob);
>  
> -    if (ms->acpi_spcr_enabled) {
> +    if (ms->acpi_spcr_enabled && serial_exists()) {
>          spcr_setup(tables_blob, tables->linker, vms);
>      }
>  
> diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
> index 3694c9827f..6eab907087 100644
> --- a/hw/loongarch/virt-acpi-build.c
> +++ b/hw/loongarch/virt-acpi-build.c
> @@ -484,8 +484,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>  
>      acpi_table_begin(&table, table_data);
>      dsdt = init_aml_allocator();
> -    for (i = 0; i < VIRT_UART_COUNT; i++) {
> -        build_uart_device_aml(dsdt, i);
> +    if (serial_exists()) {
> +        for (i = 0; i < VIRT_UART_COUNT; i++) {
> +            build_uart_device_aml(dsdt, i);
> +        }
>      }
>      build_pci_device_aml(dsdt, lvms);
>      build_la_ged_aml(dsdt, machine);
> @@ -557,7 +559,7 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>      build_srat(tables_blob, tables->linker, machine);
>      acpi_add_table(table_offsets, tables_blob);
>  
> -    if (machine->acpi_spcr_enabled)
> +    if (machine->acpi_spcr_enabled && serial_exists())
>          spcr_setup(tables_blob, tables->linker, machine);
>  
>      if (machine->numa_state->num_nodes) {
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index f1406cb683..e895bc4ddb 100644
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
> @@ -474,7 +475,10 @@ static void build_dsdt(GArray *table_data,
>                                   memmap[VIRT_APLIC_S].size, "RSCV0002");
>      }
>  
> -    acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ);
> +    if (serial_exists()) {
> +        acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ);
> +    }
> +
>      if (virt_is_iommu_sys_enabled(s)) {
>          acpi_dsdt_add_iommu_sys(scope, &memmap[VIRT_IOMMU_SYS], IOMMU_SYS_IRQ);
>      }
> @@ -890,7 +894,7 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
>  
>      acpi_add_table(table_offsets, tables_blob);
>  
> -    if (ms->acpi_spcr_enabled) {
> +    if (ms->acpi_spcr_enabled && serial_exists()) {
>          spcr_setup(tables_blob, tables->linker, s);
>      }
>  
> diff --git a/include/system/system.h b/include/system/system.h
> index 03a2d0e900..4a03f17e91 100644
> --- a/include/system/system.h
> +++ b/include/system/system.h
> @@ -74,6 +74,8 @@ extern unsigned int nb_prom_envs;
>  /* Return the Chardev for serial port i, or NULL if none */
>  Chardev *serial_hd(int i);
>  
> +bool serial_exists(void);
> +
>  /* parallel ports */
>  
>  #define MAX_PARALLEL_PORTS 3
> diff --git a/system/vl.c b/system/vl.c
> index 5091fe52d9..3a2988cb47 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -1487,6 +1487,11 @@ Chardev *serial_hd(int i)
>      return NULL;
>  }
>  
> +bool serial_exists(void)
> +{
> +    return serial_hd(0) ? true : false;
> +}
> +
>  static bool parallel_parse(const char *devname, Error **errp)
>  {
>      static int index = 0;
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 6b892ef23e..6b0e4be752 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -824,10 +824,12 @@ static char *test_acpi_create_args(test_data *data, const char *params)
>          /*
>           * TODO: convert '-drive if=pflash' to new syntax (see e33763be7cd3)
>           * when arm/virt boad starts to support it.
> +         * NOTE: Explicitly add "-serial null" to enable uart in DSDT
> +         *       without mixing guest output into TAP stdout.
>           */
>          if (data->cd) {
>              args = g_strdup_printf("-machine %s%s %s -accel tcg "
> -                "-nodefaults -nographic "
> +                "-nodefaults -serial null -nographic "
>                  "-drive if=pflash,format=raw,file=%s,readonly=on "
>                  "-drive if=pflash,format=raw,file=%s,snapshot=on -cdrom %s %s",
>                  data->machine, data->machine_param ?: "",
> @@ -835,7 +837,7 @@ static char *test_acpi_create_args(test_data *data, const char *params)
>                  data->uefi_fl1, data->uefi_fl2, data->cd, params ? params : "");
>          } else {
>              args = g_strdup_printf("-machine %s%s %s -accel tcg "
> -                "-nodefaults -nographic "
> +                "-nodefaults -serial null -nographic "
>                  "-drive if=pflash,format=raw,file=%s,readonly=on "
>                  "-drive if=pflash,format=raw,file=%s,snapshot=on %s",
>                  data->machine, data->machine_param ?: "",
> -- 
> 2.51.0


