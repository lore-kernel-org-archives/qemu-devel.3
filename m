Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FCAC54E4A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 13:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reEAg-00042A-F4; Sun, 25 Feb 2024 08:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1reEAc-00041f-7T
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 08:03:54 -0500
Received: from mailout06.t-online.de ([194.25.134.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1reEAa-0007MF-5H
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 08:03:53 -0500
Received: from fwd70.aul.t-online.de (fwd70.aul.t-online.de [10.223.144.96])
 by mailout06.t-online.de (Postfix) with SMTP id 4059918C2F;
 Sun, 25 Feb 2024 14:03:47 +0100 (CET)
Received: from [192.168.211.200] ([79.208.24.6]) by fwd70.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1reEAU-0IoCPp0; Sun, 25 Feb 2024 14:03:46 +0100
Message-ID: <9e82a04b-f2c1-4e34-b4b6-46a0581b572f@t-online.de>
Date: Sun, 25 Feb 2024 14:03:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 14/25] hw/i386/pc: Confine system flash handling to pc_sysfw
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240221211626.48190-1-philmd@linaro.org>
 <20240221211626.48190-15-philmd@linaro.org>
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <20240221211626.48190-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1708866226-33FFC937-3EF97DBF/0/0 CLEAN NORMAL
X-TOI-MSGID: 6c7a0ef1-7f6a-4a8b-8504-6b75a35d0277
Received-SPF: pass client-ip=194.25.134.19; envelope-from=vr_qemu@t-online.de;
 helo=mailout06.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 21.02.24 um 22:16 schrieb Philippe Mathieu-Daudé:
> From: Bernhard Beschow <shentey@gmail.com>
>
> Rather than distributing PC system flash handling across three files, let's
> confine it to one. Now, pc_system_firmware_init() creates, configures and cleans
> up the system flash which makes the code easier to understand. It also avoids
> the extra call to pc_system_flash_cleanup_unused() in the Xen case.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-ID: <20240208220349.4948-7-shentey@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/i386/pc.h | 2 --
>  hw/i386/pc.c         | 1 -
>  hw/i386/pc_piix.c    | 1 -
>  hw/i386/pc_sysfw.c   | 6 ++++--
>  4 files changed, 4 insertions(+), 6 deletions(-)

Hi Bernhard,

this patch breaks QEMU on my system.

./qemu-system-x86_64 -machine q35,pflash0=pflash0-storage -blockdev
driver=file,node-name=pflash0-storage,filename=/usr/share/qemu/ovmf-x86_64.bin,read-only=true
qemu-system-x86_64: Property 'pc-q35-9.0-machine.pflash0' not found

I had to revert cb05cc1602 ("hw/i386/pc_sysfw: Inline
pc_system_flash_create() and remove it") and 6f6ad2b245 ("hw/i386/pc:
Confine system flash handling to pc_sysfw") to make it work again.

With best regards,
Volker

> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 0a8a96600c..e8f4af5d5c 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -193,8 +193,6 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
>  #define TYPE_PORT92 "port92"
>  
>  /* pc_sysfw.c */
> -void pc_system_flash_create(PCMachineState *pcms);
> -void pc_system_flash_cleanup_unused(PCMachineState *pcms);
>  void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
>  bool pc_system_ovmf_table_find(const char *entry, uint8_t **data,
>                                 int *data_len);
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index e526498164..1ee41a5e56 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1733,7 +1733,6 @@ static void pc_machine_initfn(Object *obj)
>  #endif
>      pcms->default_bus_bypass_iommu = false;
>  
> -    pc_system_flash_create(pcms);
>      pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
>      object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
>                                OBJECT(pcms->pcspk), "audiodev");
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 34203927e1..ec7c07b362 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -231,7 +231,6 @@ static void pc_init1(MachineState *machine,
>          assert(machine->ram_size == x86ms->below_4g_mem_size +
>                                      x86ms->above_4g_mem_size);
>  
> -        pc_system_flash_cleanup_unused(pcms);
>          if (machine->kernel_filename != NULL) {
>              /* For xen HVM direct kernel boot, load linux here */
>              xen_load_linux(pcms);
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index c8d9e71b88..b4c3833352 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -91,7 +91,7 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
>      return PFLASH_CFI01(dev);
>  }
>  
> -void pc_system_flash_create(PCMachineState *pcms)
> +static void pc_system_flash_create(PCMachineState *pcms)
>  {
>      PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>  
> @@ -103,7 +103,7 @@ void pc_system_flash_create(PCMachineState *pcms)
>      }
>  }
>  
> -void pc_system_flash_cleanup_unused(PCMachineState *pcms)
> +static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
>  {
>      char *prop_name;
>      int i;
> @@ -212,6 +212,8 @@ void pc_system_firmware_init(PCMachineState *pcms,
>          return;
>      }
>  
> +    pc_system_flash_create(pcms);
> +
>      /* Map legacy -drive if=pflash to machine properties */
>      for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
>          pflash_cfi01_legacy_drive(pcms->flash[i],


