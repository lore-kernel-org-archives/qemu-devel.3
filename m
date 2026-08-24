Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FC8C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 22:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyctv-0003QJ-Gv; Mon, 24 Aug 2026 18:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1wyctt-0003QB-Rt
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 18:12:17 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1wycts-00088U-7y
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 18:12:17 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cb2513ec378so296354a12.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1787609508; x=1788214308; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YfPAJrzh23k5bf6NYHNz6je6+xhKQtygq0qvA9+KJck=;
 b=DVq6FEF81+1sYAh0vlmoYOCxcNVwXkgdlGrexjLGcz/8xFwCLCE1qZtNsHspQtUye4
 l4PvKx2JKi6xODAv6b9bpjUZf1LAKdtoXrNkJ5deUcEhNXrMwfT3AfDuO0aVKlEJDe7F
 6P1KkZCaH0Rzd1MoLuEeYKJHUBcmRdPlz026eCsNNQUO8bLhv9rLX5if1TXoCBQ0Mogd
 3zpuDMtiQlOELwJgsErsSMN+xf0zFIQ6ftsXgeBiS7nlG9PirKfPEoTrjYj0K4VXiuTk
 imzERjpArrbxLdeFOFEaTHVPGHLXJdBZx471ccD0Z4+1Y647RYo/J4WqdAxlXmfzSwxv
 MIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787609508; x=1788214308;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YfPAJrzh23k5bf6NYHNz6je6+xhKQtygq0qvA9+KJck=;
 b=S8nwwbUMnEHx/eaHY9fVRBGaQx/AZQQYvE6f3J+RmmidXbbV6y5t51qdmYEIbcAdgn
 vncj6LQ25cF+6McnwaMLbincFt6ooI2XBI5RQK2teh6v5RsvgeyvkPUSNOVxavDihtEq
 vSzpVz0bkyNCyIdXs6rVfpTbgH9vW3dzLhg8fl3KD3FhgsNIq5vrb6gCS4U+M1DKsC5A
 GMZ980eyJmBXp9cxmd1UGINV1183l3dpNakEeTaZaJklc7OafXmxjEz3n0NRfVmAjL34
 4GP22g2/RYNqX/YZFzxKPP7XcDu0FNild9RRH7zSRYIiVZ9//w+Oayr6F+hEt12ZJKGK
 8Hwg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqY7YecwAWM2uNbRlZKd1kvhY8Vy2PYkTxKSZsUuQbzyg0FTOaWCDPKGUGyHBsWkSs5mzlt1TI1IP7w@nongnu.org
X-Gm-Message-State: AFuF++n1uaShvyQf6yJt80w0YXnlrmoTYW3bzOqUhkjFO25zVWdqMOD3
 rIq/+h6zP+EkeVkJrTBFgIm9Og4ATGdVQ12uhPuTmGz3pmyYj14uKm/WjaL793ix7i4=
X-Gm-Gg: AR+sD12tWiqZbKtXLTXkLuU3KD/jlvu6tlfdnpKxv7vey6fyQwjv0/O8NyfcEg8HxuH
 epvxK2zIb3VcCCxCKJGfuq/TrMpzNU1qLKKIySgxk/9O66suvWKwok5e4vG8vHAwMYYzPiXoFjw
 uFR+0UjNDTLZr3lHbndAypE+BVWtPcDRyQ1/Fcfs3FwzpbFAclN8LFjI4WGoVPdWKXTo/gGEnzr
 jGq50Wig1ssASmZkuv6tP5VK2bNZu46Dsa5TNebMevclm6WCGaXA5CmBmye66Onzo4M/j7/OUEF
 kKx89BJftk7eEPX/dnAivGVJ+Z7iCI2KURoKn6SPEnRztWcV4S8ve2Vz9Uq57PZN0d3IsyiRdpr
 fQPoi351CKJhDEI0DmfVpJKKAY4+mnDYo3jGVaY7bYdo8qhi4gOh0slNXNz/0GgXvLn71xw2aaS
 /GqI4gJohuO093T128bmNaY//Nd1aDoWKwXOHXuYXjutPLTyIVEa61JbcXHsoPAmgmA5GyEOB2g
 wilZvleKqRY6mLc
X-Received: by 2002:a05:6a00:7183:b0:848:4d4f:d481 with SMTP id
 d2e1a72fcca58-851f9fa9f18mr16205259b3a.2.1787609508252; 
 Mon, 24 Aug 2026 15:11:48 -0700 (PDT)
Received: from [172.16.1.33] ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8520eed2293sm2262821b3a.2.2026.08.24.15.11.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 15:11:47 -0700 (PDT)
Message-ID: <6dd03d71-b0e5-4039-bce9-37c1cff4b108@oss.tenstorrent.com>
Date: Tue, 25 Aug 2026 08:11:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/riscv/boot: Make RISCVBootInfo const where possible
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>, Niek Linnenbank
 <nieklinnenbank@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260824055642.41098-1-joel@jms.id.au>
 <20260824055642.41098-2-joel@jms.id.au>
Content-Language: en-US
From: Portia Stephens <portias@oss.tenstorrent.com>
In-Reply-To: <20260824055642.41098-2-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=portias@tenstorrent.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


On 24/8/2026 3:56 PM, Joel Stanley wrote:
> As with riscv_load_firmware, take a const pointer in functions that
> reads the structure without writing.
>
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   include/hw/riscv/boot.h | 6 +++---
>   hw/riscv/boot.c         | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)


Reviewed-by: Portia Stephens <portias@oss.tenstorrent.com>


>
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index 4e7bd9a225ef..d23f45d78077 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -50,10 +50,10 @@ void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts);
>   void riscv_boot_info_init_discontig_mem(RISCVBootInfo *info,
>                                           RISCVHartArrayState *harts,
>                                           hwaddr low_start, hwaddr low_size);
> -vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
> +vaddr riscv_calc_kernel_start_addr(const RISCVBootInfo *info,
>                                      hwaddr firmware_end_addr);
>   hwaddr riscv_find_and_load_firmware(MachineState *machine,
> -                                    RISCVBootInfo *info,
> +                                    const RISCVBootInfo *info,
>                                       const char *default_machine_firmware,
>                                       hwaddr *firmware_load_addr,
>                                       symbol_fn_t sym_cb);
> @@ -71,7 +71,7 @@ void riscv_load_kernel(MachineState *machine,
>                          bool load_initrd,
>                          symbol_fn_t sym_cb);
>   uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
> -                                MachineState *ms, RISCVBootInfo *info);
> +                                MachineState *ms, const RISCVBootInfo *info);
>   void riscv_load_fdt(hwaddr fdt_addr, void *fdt);
>   void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts,
>                                  hwaddr saddr,
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 5e2dfa091a13..4ac0b8ef6581 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -91,7 +91,7 @@ void riscv_boot_info_init_discontig_mem(RISCVBootInfo *info,
>       info->ram_low_size = low_size;
>   }
>   
> -vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
> +vaddr riscv_calc_kernel_start_addr(const RISCVBootInfo *info,
>                                      hwaddr firmware_end_addr) {
>       if (info->is_32bit) {
>           return QEMU_ALIGN_UP(firmware_end_addr, 4 * MiB);
> @@ -151,7 +151,7 @@ char *riscv_find_firmware(const char *firmware_filename,
>   }
>   
>   hwaddr riscv_find_and_load_firmware(MachineState *machine,
> -                                    RISCVBootInfo *info,
> +                                    const RISCVBootInfo *info,
>                                       const char *default_machine_firmware,
>                                       hwaddr *firmware_load_addr,
>                                       symbol_fn_t sym_cb)
> @@ -348,7 +348,7 @@ out:
>    * The FDT is fdt_packed() during the calculation.
>    */
>   uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
> -                                MachineState *ms, RISCVBootInfo *info)
> +                                MachineState *ms, const RISCVBootInfo *info)
>   {
>       int ret = fdt_pack(ms->fdt);
>       hwaddr dram_end, temp;

