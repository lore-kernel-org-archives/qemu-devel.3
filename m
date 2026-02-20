Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F86C56201
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 14:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtRqa-0005Ff-J1; Fri, 20 Feb 2026 09:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtRqX-0005FA-5A
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 09:51:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtRqV-00073N-8y
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 09:51:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771599064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uPE7YVXm6kmKoX5gNXtVv79J5+rpVhQqdDj3rcJZruQ=;
 b=afNbrwB/uomY9rgf6Mg+28Zffa9nDdOpy5l1faRmyPOKFc3QR/bRXjCLVA3ENpF+ljneJq
 lN95CjHCMf5rS3ZO3WMDg9We53Zh2+W4OPQsmfuxm+BoOn/1+n3Htcm2rQCDKF5DAWMdF9
 9S/uoHCdQ9Ia2ViwW52Jrq/ojPoxWQ8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-L6SLFRmWPOay16_-c_Yybg-1; Fri, 20 Feb 2026 09:51:03 -0500
X-MC-Unique: L6SLFRmWPOay16_-c_Yybg-1
X-Mimecast-MFC-AGG-ID: L6SLFRmWPOay16_-c_Yybg_1771599062
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4358f90fe8dso1837986f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 06:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771599062; x=1772203862; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uPE7YVXm6kmKoX5gNXtVv79J5+rpVhQqdDj3rcJZruQ=;
 b=LY0Q1n9tM8rOxgpgIzd5EpTw2NdzhLZVrcYFNGkhZHFLjB8ggI2+Z09ubDqoVUP6CB
 5VCx4HSPomMXTeM6jnsp0HYWuuMc7vm5+Tz4o4aEjbCybVasOp6jhSzhRuElBY8wafOA
 k6xB6TG9rbXB04W2KYr6ebvTpx27IGnCJaQvSPP6rGXUoSe7ONFm4DfUWvmKRyYNW7yo
 2iHil9ZBKozya1STSp/VQzaMj3qr+qnhgx/5bMH6gDcQTivvNDQaqip9zpv45TML44cO
 ZJNutlu7IMShOQHe61lCJr2+9GBsjzUk9IfI8wkpZ09cNJqC2uX6FVd0/bQ/cnNeW52y
 yDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771599062; x=1772203862;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uPE7YVXm6kmKoX5gNXtVv79J5+rpVhQqdDj3rcJZruQ=;
 b=vH0pHgFfBBfqY/7rrAgoTIfBnhQPqJRq4Fjgv5almw977VFPtpJYhbxzB5HbkgiHZx
 bWoFrQs/DeL3D/S+66N+ZG3kfSZRcI5jG+/+MFnOlVSqu1Kf393/Gdg3tz5CXJ5sRfNC
 t0/mo9Z58qiAmJ5zBlQLd42JGXhffmD/kio8nVPjedBCp/B1LT5wEVt0HpOf25vCwx4a
 GzBLpJtdHbJeHqgS84iQQbGvkcmY3n5t3rTGL9FFv/jTPw2PC68YNT6SlAROzCqxXVL/
 38/aKFMffxfRZWf778OOvLZgSXCZ+u1f4vv8OasUnnvp5FCsOQmCKQf4oDhLNeS6tYS5
 1vyA==
X-Gm-Message-State: AOJu0YxY6tv2taY30U7VXlFOxGeMoo70vlBy5l7Q8FGdDEg5zEE8DLw3
 /e6Lz6pQ9IC7i4/nRRdlCNm1lB5UBvJtHd+33ySVaBq81Q9P/sVxmy7KRDkcQwZe6gwt/PcYxR9
 pwljSBPlCZIkVMHEAHvVGxmosb6s+ondKcULToaOijFlnX+qKb1lvbXg3
X-Gm-Gg: AZuq6aL4WLNnmlj47a4g7lEnFIsKuD7MzhPFtDAOvPzs8eE5emq+cZNTpTphBZ72J8D
 0SKuwlWeVpa6YbU9uWVj9nlzT0OOtZ5MpTrOobbr1iiInMRgMR/e8schjRaM88E6aTHHMcdgHB4
 lcC1F7OOOzURpzJC7hLxMlE1/eyRnxqhwr0SK7ajRLMa38lAV58eGYJnlhFY1pLvjB0Qyt1dHdF
 kkJ9s8KSFpKURAnRJgCd7qP45AA/oNjv2ts349V3ilJ3txZkekKh6p/wd5F9efR/XYzRIaC7ImA
 WkJnELy9qaFjlHb+p0bdtJLrLpEJWcixah+m7fy44JHyikT2PHhBysepE38OwrqGyx3DEyoyoaA
 F/BuPbBros2k8Sf7Qo+RZtnW5JYw/kg81EGXKomsCLTsYag==
X-Received: by 2002:a05:6000:40cc:b0:435:bcbd:cb29 with SMTP id
 ffacd0b85a97d-439625c9bbbmr11626355f8f.2.1771599061857; 
 Fri, 20 Feb 2026 06:51:01 -0800 (PST)
X-Received: by 2002:a05:6000:40cc:b0:435:bcbd:cb29 with SMTP id
 ffacd0b85a97d-439625c9bbbmr11626297f8f.2.1771599061272; 
 Fri, 20 Feb 2026 06:51:01 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5d156sm61280027f8f.5.2026.02.20.06.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 06:51:00 -0800 (PST)
Date: Fri, 20 Feb 2026 09:50:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Chen <me@linux.beauty>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v7 1/1] acpi/virt: suppress SPCR when UART0 has no serial
 backend
Message-ID: <20260220094834-mutt-send-email-mst@kernel.org>
References: <20260219130403.810220-1-me@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260219130403.810220-1-me@linux.beauty>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 19, 2026 at 09:04:02PM +0800, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
> 
> virt machines always instantiate a PL011/16550 UART at slot 0 and describe
> it in ACPI (DSDT and optional SPCR table). When the command line disables
> the serial backend (e.g. "-serial none"), SPCR still points at UART0 and
> the guest may pick it as the preferred console even though it is not
> usable.
> 
> Only generate SPCR when UART0 has a chardev backend attached. Keep the
> UART device description in DSDT unchanged so the guest-visible UART
> topology does not change.
> 
> The bios-tables-test qtests use "-serial null" to keep SPCR enabled while
> discarding firmware serial output, avoiding TAP stdout corruption.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> ---

So -serial null gives a device -serial none hides it from guest.
Sensible. And yet, out of abundance of caution, maybe keep
the legacy behaviour for existing machine types. No?


> v6 -> v7:
>   Do not gate DSDT UART devices on serial_hd(0); only gate SPCR.
>   Drop the serial_exists() helper added by v6.
>   Keep bios-tables-test using "-serial null" (comment wording update).
> 
> v5 -> v6:
>   Fix TAP parsing errors by using "-serial null" in bios-tables-test.
> 
> v4 -> v5:
>   Also suppress UART device & SPCR when guest has no serial hardware on
>   loongarch.
>   Rename serial_exist to serial_exists.
>   Fix style issues.
> 
>  hw/arm/virt-acpi-build.c       | 3 ++-
>  hw/loongarch/virt-acpi-build.c | 2 +-
>  hw/riscv/virt-acpi-build.c     | 3 ++-
>  tests/qtest/bios-tables-test.c | 7 +++++--
>  4 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index c145678185..1411f98ea1 100644
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
> @@ -1291,7 +1292,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  
>      acpi_add_table(table_offsets, tables_blob);
>  
> -    if (ms->acpi_spcr_enabled) {
> +    if (ms->acpi_spcr_enabled && serial_hd(0)) {
>          spcr_setup(tables_blob, tables->linker, vms);
>      }
>  
> diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
> index 54ac94e17d..dc8bbb9fdc 100644
> --- a/hw/loongarch/virt-acpi-build.c
> +++ b/hw/loongarch/virt-acpi-build.c
> @@ -546,7 +546,7 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>      build_srat(tables_blob, tables->linker, machine);
>      acpi_add_table(table_offsets, tables_blob);
>  
> -    if (machine->acpi_spcr_enabled)
> +    if (machine->acpi_spcr_enabled && serial_hd(0))
>          spcr_setup(tables_blob, tables->linker, machine);
>  
>      if (machine->numa_state->num_nodes) {
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index f1406cb683..29080d1125 100644
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
> @@ -890,7 +891,7 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
>  
>      acpi_add_table(table_offsets, tables_blob);
>  
> -    if (ms->acpi_spcr_enabled) {
> +    if (ms->acpi_spcr_enabled && serial_hd(0)) {
>          spcr_setup(tables_blob, tables->linker, s);
>      }
>  
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index e489d94331..37f2b72d83 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -825,10 +825,13 @@ static char *test_acpi_create_args(test_data *data, const char *params)
>          /*
>           * TODO: convert '-drive if=pflash' to new syntax (see e33763be7cd3)
>           * when arm/virt boad starts to support it.
> +         * NOTE: Explicitly add "-serial null" to keep SPCR enabled while
> +         *       discarding firmware serial output (avoid corrupting TAP
> +         *       stdout).
>           */
>          if (data->cd) {
>              args = g_strdup_printf("-machine %s%s %s -accel tcg "
> -                "-nodefaults -nographic "
> +                "-nodefaults -serial null -nographic "
>                  "-drive if=pflash,format=raw,file=%s,readonly=on "
>                  "-drive if=pflash,format=raw,file=%s,snapshot=on -cdrom %s %s",
>                  data->machine, data->machine_param ?: "",
> @@ -836,7 +839,7 @@ static char *test_acpi_create_args(test_data *data, const char *params)
>                  data->uefi_fl1, data->uefi_fl2, data->cd, params ? params : "");
>          } else {
>              args = g_strdup_printf("-machine %s%s %s -accel tcg "
> -                "-nodefaults -nographic "
> +                "-nodefaults -serial null -nographic "
>                  "-drive if=pflash,format=raw,file=%s,readonly=on "
>                  "-drive if=pflash,format=raw,file=%s,snapshot=on %s",
>                  data->machine, data->machine_param ?: "",
> -- 
> 2.52.0


