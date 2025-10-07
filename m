Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2736CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 13:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v67UT-0006w4-1P; Tue, 07 Oct 2025 09:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v67UQ-0006vm-CD
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 09:12:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v67UE-0002XR-Ry
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 09:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759842728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XlaXJ+9IXOJ/jK+m5vTCfGHWuwuUqatOTwrroHpPze0=;
 b=d7vAKpIDl5j7EjlrhCqF77hIExfGIWrKWyD3wHKmNzQCzNiwAM+1B59Bba+VTzSjIR+a5Z
 gqORxnQ7fq+qYMdWJKRhL28wxbbrLQdqjJn8iQKqT+IdJSrYvgg/cqqEHPtnUhOStMULCS
 zJQ41/tsNoizponYYJpffqMlTzQ+CkU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-4RmHtsiiO3GoOcVUjTXwMg-1; Tue, 07 Oct 2025 09:12:05 -0400
X-MC-Unique: 4RmHtsiiO3GoOcVUjTXwMg-1
X-Mimecast-MFC-AGG-ID: 4RmHtsiiO3GoOcVUjTXwMg_1759842724
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ed9557f976so4106445f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 06:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759842724; x=1760447524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XlaXJ+9IXOJ/jK+m5vTCfGHWuwuUqatOTwrroHpPze0=;
 b=ijtqsSzn2+bhCeN6jPvEymyZ2qpUbC+qz1Zw+LBwbSlLrOsaHHRGe//eRmxbu+JHdG
 pTRGPB8xXAgGveDoEvVvjw1TOKQWbVWo4h182cKKwINCVS1zGj2nAEUKfuT1nPq0XQBL
 dwINemORmHCT/fIisN6qebTwNDqqtUnX+M6KuEy53R6TlXuzJAdkgL5+jJFn3AASH2GS
 +pYtyq04TpAd4YdqCfj2zUDpBccBD66/u117eU7n06HCLER1KC8RPaVVo5sWurHephPr
 6BS4uWXkBGePsDLYYu/X/2CB2hYne2DKvJ68gmggWCAFjfUY1FoTQr8279IeEY524HEA
 5tZQ==
X-Gm-Message-State: AOJu0Yw1R0IYLukheePGvVcuHlalZ359hs0pUvr74S8yoQR85+rIn0Jf
 dXpn0+IwRANC0m7Aw3mKGBR63GmrlqEICAEUoR2bKwOZv0gU5OvfOLRMXpJr/VN1H66seltsv3p
 RGW4xCZo5tSlssrCN46nqwvIu29Xyg3LQqnHm+FdfYvh7wiq5h5RKQmvm
X-Gm-Gg: ASbGnctRXk5QqonlVKukHBts/lLAb8iywGBNcXbyKSGmhsU7qhmS+tbf3DWSe8uOWb1
 pS12lQ6yYR1uRcgXwkAeHeJbqMsOtn9HQyQeA9cMN+CRU9lG7iRYsz7ZYgSk7Bv9uHef5TLg+H5
 8Tk7VHVXEzQzV3MAmeT7GKhPGZDgKTynVQiBylQ2eYizW2SCMvsmtSS5H1vcEVMPSAFp/2vXI1g
 Kq3f3AwljfP07K4rhwMTp07sqUWyKedsFVpnkFp8M61oIurhTvlBqWAv0umU18btLLtg3gg6Kky
 /90403CGASJqxVttJOWl/jwkmVM49BpKOgvo
X-Received: by 2002:a5d:588d:0:b0:410:3a4f:1298 with SMTP id
 ffacd0b85a97d-4256714d018mr11824141f8f.15.1759842724382; 
 Tue, 07 Oct 2025 06:12:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT7tdOb3f7jG19ZBDrImwLtnWHUbAeRUbWk2BcC92rUoxdRTRiqP6oot8pZjHCQhcH7rexKA==
X-Received: by 2002:a5d:588d:0:b0:410:3a4f:1298 with SMTP id
 ffacd0b85a97d-4256714d018mr11824111f8f.15.1759842723902; 
 Tue, 07 Oct 2025 06:12:03 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6b40sm25522990f8f.2.2025.10.07.06.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 06:12:03 -0700 (PDT)
Date: Tue, 7 Oct 2025 15:11:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Alexander Gryanko <xpahos@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH] hw/arm: add pvpanic mmio device for arm
Message-ID: <20251007151157.5a601c3e@fedora>
In-Reply-To: <CC5A0011-CD14-40F9-8023-8BF5F989BCCF@gmail.com>
References: <CC5A0011-CD14-40F9-8023-8BF5F989BCCF@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, 4 Oct 2025 23:19:09 +0300
Alexander Gryanko <xpahos@gmail.com> wrote:

> Currently, pvpanic is available in three device types: ISA,
> MMIO, and PCI. For early stages of system initialisation
> before PCI enumeration, only ISA and MMIO are suitable.
> ISA is specific to the x86 platform; only MMIO devices
> can be used for ARM. It is not possible to specify a
> device as on the x86 platform (-device pvpanic); the

perhaps ARM folsk know better, don't we have some
user create-able sysbus devices? Can it be implemented
as such, so we would avoid creating built-in device?

> only possible way is to add an MMIO device to the dtb,
> which can be implemented by manually adding new functions
> to the QEMU code, as was done in the VMApple implementation.
> 
> Signed-off-by: Alexander Gryanko <xpahos@gmail.com>
> ---
> hw/arm/virt.c         | 25 +++++++++++++++++++++++++
> include/hw/arm/virt.h |  1 +
> 2 files changed, 26 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 02209fadcf..1059584b67 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -39,6 +39,7 @@
> #include "hw/arm/virt.h"
> #include "hw/block/flash.h"
> #include "hw/display/ramfb.h"
> +#include "hw/misc/pvpanic.h"
> #include "net/net.h"
> #include "system/device_tree.h"
> #include "system/numa.h"
> @@ -182,6 +183,7 @@ static const MemMapEntry base_memmap[] = {
>     [VIRT_UART0] =              { 0x09000000, 0x00001000 },
>     [VIRT_RTC] =                { 0x09010000, 0x00001000 },
>     [VIRT_FW_CFG] =             { 0x09020000, 0x00000018 },
> +    [VIRT_PVPANIC] =            { 0x09021000, 0x00000002 },
>     [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
>     [VIRT_UART1] =              { 0x09040000, 0x00001000 },
>     [VIRT_SMMU] =               { 0x09050000, SMMU_IO_LEN },
> @@ -276,6 +278,27 @@ static bool ns_el2_virt_timer_present(void)
>         arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu);
> }
> 
> +static void create_pvpanic(VirtMachineState *vms)
> +{
> +    char *nodename;
> +    MachineState *ms = MACHINE(vms);
> +    DeviceState *dev = qdev_new(TYPE_PVPANIC_MMIO_DEVICE);
> +    SysBusDevice *s = SYS_BUS_DEVICE(dev);
> +
> +    hwaddr base = vms->memmap[VIRT_PVPANIC].base;
> +    hwaddr size = vms->memmap[VIRT_PVPANIC].size;
> +
> +    sysbus_realize_and_unref(s, &error_fatal);
> +    sysbus_mmio_map(s, 0, base);
> +
> +    nodename = g_strdup_printf("/pvpanic@%" PRIx64, base);
> +    qemu_fdt_add_subnode(ms->fdt, nodename);
> +    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
> +                            "qemu,pvpanic-mmio");
> +    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
> +                                 2, base, 2, size);
> +}
> +
> static void create_fdt(VirtMachineState *vms)
> {
>     MachineState *ms = MACHINE(vms);
> @@ -2498,6 +2521,8 @@ static void machvirt_init(MachineState *machine)
>     create_pcie(vms);
>     create_cxl_host_reg_region(vms);
> 
> +    create_pvpanic(vms);

given that virt is versioned machine type,
we probably need a compat knob to disable it's creation on old machine types

> +
>     if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
>         vms->acpi_dev = create_acpi_ged(vms);
>     } else {
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index ea2cff05b0..39bf07c9c1 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -81,6 +81,7 @@ enum {
>     VIRT_NVDIMM_ACPI,
>     VIRT_PVTIME,
>     VIRT_ACPI_PCIHP,
> +    VIRT_PVPANIC,
>     VIRT_LOWMEMMAP_LAST,
> };
> 
> 
> ---
> base-commit: bd6aa0d1e59d71218c3eee055bc8d222c6e1a628
> change-id: 20251004-arm-pvpanic-84a7d7b67d8d
> 
> Best regards,


