Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C3DEF585F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 02:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrRZa-0006kP-HJ; Sat, 14 Feb 2026 21:09:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vrRZX-0006k2-39
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 21:09:19 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vrRZT-00026V-Sr
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 21:09:17 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4362507f0feso1349197f8f.0
 for <qemu-devel@nongnu.org>; Sat, 14 Feb 2026 18:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771121354; x=1771726154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RLK3ltO0ghQplH3eXTqbRyJGPzwuBHKYsMQRwYjy1V8=;
 b=mjjfMJtsML94g4UHyLHlVHgS95wWizEoGNCD3cAi0cPkKG0iYZOg46/2dXH45zs3w3
 /+NWrx2BVXKfQoVITseK/Il27sHv3aFpjmhwmDLdEnb+LYmP8mYEcIblqXJCjNirnNzr
 ZcHOnYlBQJZA7g/ze5T5EfzHGvliZ9gqrZYRwq4EXMiTyN0PoybPD6nB8VBeFPL+dlaF
 UxTESrp4YkgoZ9SSFmFk5epLljCZ8QFP/ZL0QptI7m2Fp/vqKd1vcu3gfx7L2C1q+Ijc
 zSGuqrKwrYIToXjsBnzaONjrO1Hfhboo7IzFuFW+QXyA5qLtVbRh49TsiJl7/g/491SI
 0mJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771121354; x=1771726154;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RLK3ltO0ghQplH3eXTqbRyJGPzwuBHKYsMQRwYjy1V8=;
 b=IBsOLfpNtxyTzwYE0SYc9AVFk9hUlYgfJIB6mzTS80QLo+cvdU6qMp04CnvC+VDm7A
 1cXAg68n+Vif49ORtIYiudrByFJusDc/ZHeY6ewazEd4jxDUc7s567e5aUTEVJuw+8H/
 E2WFr3tqhVIw+4kgH1IoDDGI67oITaWB4XymXsSOxYX5jF0AuUyvL8RzbId/LKdEM+qi
 ZNBO3NKru8vgQ/xis6L/R/iBSsVijrkRlVuW/h7S0Yk969Kn3ODpk+g3EykPr/wKErMW
 f0EhSZNxUzSmv+jM/l0mRvW/yzbAk+gQ9hW4iN004Ptja/71UqTHTaE+nUUoTMkI2jBx
 DESQ==
X-Gm-Message-State: AOJu0Ywiq/7ZHOlI/KZugGTHFTAzUlNG9/Ljd42cpHGSxeLYl782YvOB
 JN0GC4shDWhjOWfTRBckeB1Wpai+FD7v3h4r+lSjhuTXuJdFlc0ZrS9QXovckyNAeYE=
X-Gm-Gg: AZuq6aJfUQsT8hVm7DYSCtrqeM4WHdAvo7mCALojt/YLqJdZS9snfARJa59hnlQECmc
 OhSh6gKB8cP2Jd8evz7hdYf7ORTasn/unyhN5+U5Ln6cjt+CEGzFg8jQQiU7DJPSLbYmFSrWHig
 oaYUCqFnwpxvCJciTrXOkhZNwmHd9uEaXqKe5xQ6qRcHdYI5J/FknOA5itEiR9SFeCv6tQy+bv4
 73y4xlLrtKwvbHkRhsQsDW1Y3xGEvUAQq6yX4l/yI4T/PiHgdGwoGtd74vAKIdMb9H7USeQVnRd
 dibHlalT2qlt6Q953Ja6pfvT3a4raJdWV6PLd2z9N5dSIfv3abQMfwZPqnq5MLn7y54j6wYU7dc
 lk3DSb8i0yAupMEvDXSIebDZn7g8T5LJ9iDHDTIXnZionZQWMn5fGMx8+rxT2lh5EASqDrZbImW
 UxsX7m8CYlMHcYCkyHUWOS84ufalv+Jeuhz1bv8QnlGIUsSLaAPXHu9YyBnljz5vECZw==
X-Received: by 2002:a05:6000:402b:b0:436:1951:21f2 with SMTP id
 ffacd0b85a97d-43796ab181fmr13650918f8f.12.1771121354054; 
 Sat, 14 Feb 2026 18:09:14 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ad0166sm16425286f8f.35.2026.02.14.18.09.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Feb 2026 18:09:13 -0800 (PST)
Message-ID: <56a0f465-2055-4c82-b0c0-963b376609e9@linaro.org>
Date: Sun, 15 Feb 2026 03:09:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] hw/ppc: Set graphic display dimensions generically
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260214021240.58657-1-philmd@linaro.org>
 <20260214021240.58657-8-philmd@linaro.org>
 <252b2fa2-9251-3949-625b-7071c525c8e2@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <252b2fa2-9251-3949-625b-7071c525c8e2@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Hi Zoltan,

On 14/2/26 12:46, BALATON Zoltan wrote:
> On Sat, 14 Feb 2026, Philippe Mathieu-Daudé wrote:
>> If a dimension is not set, have the machine init code set
>> the default value by calling the ppc_graphic_dimensions()
>> helper, common to all PowerPC machines. Declare local
>> variables to avoid using the global ones.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> include/hw/ppc/ppc.h    |  2 ++
>> hw/ppc/mac_newworld.c   | 10 ++++++----
>> hw/ppc/mac_oldworld.c   | 10 ++++++----
>> hw/ppc/ppc.c            |  8 ++++++++
>> hw/ppc/prep.c           |  4 ++++
>> hw/ppc/spapr.c          |  4 ++++
>> system/globals-target.c |  6 ------
>> 7 files changed, 30 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
>> index cb51d704c6d..14cc09ab22b 100644
>> --- a/include/hw/ppc/ppc.h
>> +++ b/include/hw/ppc/ppc.h
>> @@ -102,6 +102,8 @@ enum {
>>     ARCH_MAC99_U3,
>> };
>>
>> +void ppc_graphic_dimensions(int *width, int *height, int *depth);
>> +
>> #define FW_CFG_PPC_WIDTH        (FW_CFG_ARCH_LOCAL + 0x00)
>> #define FW_CFG_PPC_HEIGHT       (FW_CFG_ARCH_LOCAL + 0x01)
>> #define FW_CFG_PPC_DEPTH        (FW_CFG_ARCH_LOCAL + 0x02)
>> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
>> index 7275563a155..daf0029c01a 100644
>> --- a/hw/ppc/mac_newworld.c
>> +++ b/hw/ppc/mac_newworld.c
>> @@ -156,6 +156,7 @@ static void ppc_core99_init(MachineState *machine)
>>     DeviceState *uninorth_internal_dev = NULL, *uninorth_agp_dev = NULL;
>>     hwaddr nvram_addr = 0xFFF04000;
>>     uint64_t tbfreq = kvm_enabled() ? kvmppc_get_tbfreq() : TBFREQ;
>> +    int graphic_width, graphic_height, graphic_depth;
>>
>>     /* init CPUs */
>>     for (i = 0; i < machine->smp.cpus; i++) {
>> @@ -432,10 +433,6 @@ static void ppc_core99_init(MachineState *machine)
>>
>>     pci_vga_init(pci_bus);
>>
>> -    if (graphic_depth != 15 && graphic_depth != 32 && graphic_depth ! 
>> = 8) {
>> -        graphic_depth = 15;
>> -    }
>> -
>>     pci_init_nic_devices(pci_bus, mc->default_nic);
>>
>>     /* The NewWorld NVRAM is not located in the MacIO device */
>> @@ -480,6 +477,11 @@ static void ppc_core99_init(MachineState *machine)
>>     fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
>>     fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, ppc_boot_device);
>>
>> +    ppc_graphic_dimensions(&graphic_width, &graphic_height, 
>> &graphic_depth);
>> +    if (graphic_depth != 15 && graphic_depth != 32 && graphic_depth ! 
>> = 8) {
>> +        graphic_depth = 15;
>> +    }
>> +
>>     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, graphic_width);
>>     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, graphic_height);
>>     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, graphic_depth);
>> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
>> index e679d338985..ea1f778877c 100644
>> --- a/hw/ppc/mac_oldworld.c
>> +++ b/hw/ppc/mac_oldworld.c
>> @@ -108,6 +108,7 @@ static void ppc_heathrow_init(MachineState *machine)
>>     DriveInfo *dinfo, *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>>     void *fw_cfg;
>>     uint64_t tbfreq = kvm_enabled() ? kvmppc_get_tbfreq() : TBFREQ;
>> +    int graphic_width, graphic_height, graphic_depth;
>>
>>     /* init CPUs */
>>     for (i = 0; i < machine->smp.cpus; i++) {
>> @@ -288,10 +289,6 @@ static void ppc_heathrow_init(MachineState *machine)
>>         pci_create_simple(pci_bus, -1, "pci-ohci");
>>     }
>>
>> -    if (graphic_depth != 15 && graphic_depth != 32 && graphic_depth ! 
>> = 8) {
>> -        graphic_depth = 15;
>> -    }
>> -
>>     /* No PCI init: the BIOS will do it */
>>
>>     dev = qdev_new(TYPE_FW_CFG_MEM);
>> @@ -321,6 +318,11 @@ static void ppc_heathrow_init(MachineState *machine)
>>     fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
>>     fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, ppc_boot_device);
>>
>> +    ppc_graphic_dimensions(&graphic_width, &graphic_height, 
>> &graphic_depth);
>> +    if (graphic_depth != 15 && graphic_depth != 32 && graphic_depth ! 
>> = 8) {
>> +        graphic_depth = 15;
>> +    }
>> +
>>     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, graphic_width);
>>     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, graphic_height);
>>     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, graphic_depth);
>> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
>> index a512d4fa647..d7b4466d701 100644
>> --- a/hw/ppc/ppc.c
>> +++ b/hw/ppc/ppc.c
>> @@ -29,6 +29,7 @@
>> #include "qemu/timer.h"
>> #include "exec/cpu-interrupt.h"
>> #include "system/cpus.h"
>> +#include "system/system.h"
>> #include "qemu/log.h"
>> #include "qemu/main-loop.h"
>> #include "qemu/error-report.h"
>> @@ -1557,3 +1558,10 @@ void ppc_irq_reset(PowerPCCPU *cpu)
>>         kvmppc_set_interrupt(cpu, PPC_INTERRUPT_EXT, 0);
>>     }
>> }
>> +
>> +void ppc_graphic_dimensions(int *width, int *height, int *depth)
>> +{
>> +    *width = graphic_width ?: 800;
>> +    *height = graphic_height ?: 600;
>> +    *depth = graphic_depth ?: 32;
>> +}
> 
> I think there's no reason to have this common to all ppc machines. If we 
> change this we could also make it per machine like for other targets. 
> There's nothing common in these machines that dictate these defaults. It 
> seems it used to be an arbitrary default in QEMU that some machines 
> later deviated from. So might as well just keep it as global for now 
> after you removed the SPARC and M68K special cases. If the ppc machines 
> are the last users of these global defaults you can just move them to 
> hw/ppc/ppc.{h,c} for now and let ppc people clean this up eventually.

What you are asking is to use 800x600x32 as the default for all
non-SPARC / non-M68K targets, so PPC don't have to change? But then
SPARC and M68k won't be able to use the '-g' CLI (which Paolo asked
me not to remove, thus this series). What is worrying you exactly?
Can you provide a patch showing how you'd prefer it to be done?

Thanks,

Phil.

