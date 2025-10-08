Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4B4CCA472
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 13:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6URp-0005B0-My; Wed, 08 Oct 2025 09:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6URo-0005Aq-FQ
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 09:43:16 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6URg-0007eJ-Gd
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 09:43:15 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-46e2c3b6d4cso60215245e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 06:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759930984; x=1760535784; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8WYmVZUPGCeWRRPW9UqLjJP3RgfLSdOOhZjuw1rwMow=;
 b=L56tJc3ILlyv6aiiX9vcsm4t9+36oBLMZz2cf8iFiVk6z/4qoLC+dgbeLkMb3fDMV3
 C1VqA7wdSDL9XkwIGi9NPStnYLtl7bs4RJjA3YzTQNdfR3A1j2MvJBO1/vQDzQ1cZaBL
 XlkwZctMhNVEPJQJbR19978veLHEGdKQVHQ2EZBDGcmWEErIQ5g7CuCd8TIZ9gzDwh97
 GL4XJ4w9SE3nx3TulB+hFTc+nfscbYbpH64ifXmsssKrRMneCea6yINWSwJ4mIrGcCRB
 xSZZmxbnR/rc90auHfWcharNLkJ4AP32+2RH2ytx6fiCpqalGgQAqWp890eKd/avPmIN
 tNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759930984; x=1760535784;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8WYmVZUPGCeWRRPW9UqLjJP3RgfLSdOOhZjuw1rwMow=;
 b=bZyeWwagovqo9o3RmBohavhGzK7h+iwNloVG01HVeR58nTpBfrKrq/oscZjBwwKuCf
 8M6A736YN9PtWEWimEPqM+aKAD1IXGz0cBkbUhADBkKj2BoGSrG0+igYsF5OMG5gcV1q
 Tmyor9sIv8xeIJirNBT4zmVyZLOgF7/apiu6hZBhm8Gq9J5egKhcCQYQ1ykTZTF08Egl
 4xqGoAH8CC9+kZjjo3H+/5csRyzrf7+G6QC5dGGrbUJqIWCqxCzMYbhTb28TjZuA7M7m
 VPuUYgk7YfQ5x+KgusEOms7mjRyAtySZk+Aba0G/G1W1uYj2ClkFxw3M+RF7+0a8ZKRD
 n+1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWdDvXAL4xn7xFQUmjAJMD+89J46w+cOwNLxaV3p3vLtTcxDH+W7fEOHzBrFce6FYpKrJQnU/ROj4Y@nongnu.org
X-Gm-Message-State: AOJu0YxJCmRqm05PK1ZIy1tSVPl0wzMAaqcGILOP0kYYyzeRYNE87os+
 SfjAwnUngc87EEhRRnVk9MkiSExRbbZOZ3VXJnhzXOqQ9Z6UEmY8BYx9gFlx7wSCn18=
X-Gm-Gg: ASbGncvVKG+at4/BQEcgYrqmJ3zE63pN+4fQ+R4SCu91SgrqnkZgGC1VJy15aAu4IV/
 R0AsK3z3NkRbtGqnb17ZjYHHdYYUQkCXNDH251yD90Nn0A2Ou5WybN+451cE2XhZqj95Yt98UBv
 Rr54S04wfPjc/+CKYmfwVmHuuLj4M5fSpBGlrwkWfKwi8FwrCOWPcnsXCMBDPZ3TCueZM0gozwe
 OvQ9fDYd75eCJP5QBW5jaomLTIwTpI2CV+QpS02Z8kMEZI5uQWYoxc/KHaySojkXnFyKtkEvZ4a
 L0O+BY7Isbt83YchCAG/ShhTJL7KyWC8b53BxcurtrQKit/ztttslUQXj9a0+EeQH67FU/9S98V
 pqZVOOR8dPeGCXK94kS4c/IYpqZaKilX9DfnVhDkFeBseXKf+VRTqxFjGUQKucbEsLg0MLpjmkz
 C3ZCrP12It4wikSLl+1w==
X-Google-Smtp-Source: AGHT+IH9HvqC0tp1npXHZh27KUDVlcevEktzs/zlQzxLQJY445D+vGc0ZqqN14xEz8q3QvGbiHbjjw==
X-Received: by 2002:a05:600c:4687:b0:45d:e5ff:e38c with SMTP id
 5b1f17b1804b1-46fa9b02000mr23578165e9.32.1759930984448; 
 Wed, 08 Oct 2025 06:43:04 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab656554sm14398735e9.11.2025.10.08.06.43.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 06:43:03 -0700 (PDT)
Message-ID: <8eb571a6-f48c-4083-85ef-3e92603c84d1@linaro.org>
Date: Wed, 8 Oct 2025 15:43:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/hppa: Fix booting Linux kernel with initrd
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250122180913.18667-1-deller@kernel.org>
 <20250122180913.18667-3-deller@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250122180913.18667-3-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Helge,

On 22/1/25 19:09, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Commit 20f7b890173b ("hw/hppa: Reset vCPUs calling resettable_reset()")
> broke booting the Linux kernel with initrd which may have been provided
> on the command line. The problem is, that the mentioned commit zeroes
> out initial registers which were preset with addresses for the Linux
> kernel and initrd.
> 
> Fix it by adding proper variables which are set shortly before starting
> the firmware.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Fixes: 20f7b890173b ("hw/hppa: Reset vCPUs calling resettable_reset()")
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/hppa/machine.c | 48 +++++++++++++++++++----------------------------
>   target/hppa/cpu.h |  4 ++++
>   2 files changed, 23 insertions(+), 29 deletions(-)
> 
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 4bcc66cd6f..0dd1908214 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -356,7 +356,6 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>       uint64_t kernel_entry = 0, kernel_low, kernel_high;
>       MemoryRegion *addr_space = get_system_memory();
>       MemoryRegion *rom_region;
> -    unsigned int smp_cpus = machine->smp.cpus;
>       SysBusDevice *s;
>   
>       /* SCSI disk setup. */
> @@ -482,8 +481,8 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>                         kernel_low, kernel_high, kernel_entry, size / KiB);
>   
>           if (kernel_cmdline) {
> -            cpu[0]->env.gr[24] = 0x4000;
> -            pstrcpy_targphys("cmdline", cpu[0]->env.gr[24],
> +            cpu[0]->env.cmdline_or_bootorder = 0x4000;
> +            pstrcpy_targphys("cmdline", cpu[0]->env.cmdline_or_bootorder,
>                                TARGET_PAGE_SIZE, kernel_cmdline);

I am a bit confused, here @cmdline_or_bootorder contains the physical
address of the kernel command line, ...

>           }
>   
> @@ -513,32 +512,22 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>               }
>   
>               load_image_targphys(initrd_filename, initrd_base, initrd_size);
> -            cpu[0]->env.gr[23] = initrd_base;
> -            cpu[0]->env.gr[22] = initrd_base + initrd_size;
> +            cpu[0]->env.initrd_base = initrd_base;
> +            cpu[0]->env.initrd_end  = initrd_base + initrd_size;
>           }
>       }
>   
>       if (!kernel_entry) {
>           /* When booting via firmware, tell firmware if we want interactive
> -         * mode (kernel_entry=1), and to boot from CD (gr[24]='d')
> -         * or hard disc * (gr[24]='c').
> +         * mode (kernel_entry=1), and to boot from CD (cmdline_or_bootorder='d')
> +         * or hard disc (cmdline_or_bootorder='c').
>            */
>           kernel_entry = machine->boot_config.has_menu ? machine->boot_config.menu : 0;
> -        cpu[0]->env.gr[24] = machine->boot_config.order[0];
> +        cpu[0]->env.cmdline_or_bootorder = machine->boot_config.order[0];

... but here a char ('c' or 'd'). Both seems different things.
Is that expected?

>       }
>   
> -    /* We jump to the firmware entry routine and pass the
> -     * various parameters in registers. After firmware initialization,
> -     * firmware will start the Linux kernel with ramdisk and cmdline.
> -     */
> -    cpu[0]->env.gr[26] = machine->ram_size;
> -    cpu[0]->env.gr[25] = kernel_entry;
> -
> -    /* tell firmware how many SMP CPUs to present in inventory table */
> -    cpu[0]->env.gr[21] = smp_cpus;
> -
> -    /* tell firmware fw_cfg port */
> -    cpu[0]->env.gr[19] = FW_CFG_IO_BASE;
> +    /* Keep initial kernel_entry for first boot */
> +    cpu[0]->env.kernel_entry = kernel_entry;
>   }
>   
>   /*
> @@ -675,18 +664,19 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
>           cpu[i]->env.gr[5] = CPU_HPA + i * 0x1000;
>       }
>   
> -    /* already initialized by machine_hppa_init()? */
> -    if (cpu[0]->env.gr[26] == ms->ram_size) {
> -        return;
> -    }
> -
>       cpu[0]->env.gr[26] = ms->ram_size;
> -    cpu[0]->env.gr[25] = 0; /* no firmware boot menu */
> -    cpu[0]->env.gr[24] = 'c';
> -    /* gr22/gr23 unused, no initrd while reboot. */
> +    cpu[0]->env.gr[25] = cpu[0]->env.kernel_entry;
> +    cpu[0]->env.gr[24] = cpu[0]->env.cmdline_or_bootorder;
> +    cpu[0]->env.gr[23] = cpu[0]->env.initrd_base;
> +    cpu[0]->env.gr[22] = cpu[0]->env.initrd_end;
>       cpu[0]->env.gr[21] = smp_cpus;
> -    /* tell firmware fw_cfg port */
>       cpu[0]->env.gr[19] = FW_CFG_IO_BASE;
> +
> +    /* reset static fields to avoid starting Linux kernel & initrd on reboot */
> +    cpu[0]->env.kernel_entry = 0;
> +    cpu[0]->env.initrd_base = 0;
> +    cpu[0]->env.initrd_end = 0;
> +    cpu[0]->env.cmdline_or_bootorder = 'c';
>   }
>   
>   static void hppa_nmi(NMIState *n, int cpu_index, Error **errp)
> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> index 083d4f5a56..beea42d105 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -268,6 +268,10 @@ typedef struct CPUArchState {
>       struct {} end_reset_fields;
>   
>       bool is_pa20;
> +
> +    target_ulong kernel_entry; /* Linux kernel was loaded here */
> +    target_ulong cmdline_or_bootorder;
> +    target_ulong initrd_base, initrd_end;
>   } CPUHPPAState;
>   
>   /**


