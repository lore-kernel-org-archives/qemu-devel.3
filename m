Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E41CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 06:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6kWt-0006nW-Eg; Thu, 09 Oct 2025 02:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6kWq-0006ms-Qb
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 02:53:32 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6kWk-0005bf-2t
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 02:53:32 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-41174604d88so277481f8f.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 23:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759992802; x=1760597602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E6Q4EtsBNVZlQr7FFaPPDr1nc2rYfW1UAd90i7w7t1Q=;
 b=BJIYf67gPABXO7YFG032iTJrbFAUUjIn/BgtkOa5VWjTSc8g7hKsnJWp1tL8uPgTae
 +6SaR3+1lrpxTsMNIZezy8XHNZ7ZoHQumqpCnq/uZGoMTXUmcclb7kvrgCGdyoz7yJln
 165E73ni7kkl9ZwnYG9xDiwHrcOja34Xu5peGzE5MfLOlvqZqqGwo/UsoOGllYxXOCty
 6TpkQLaojXPhCDn5gjnMtu3M3+xDRWAuy/VSSv+gju1Q7y5pJWexrG7XhlUbEpwUZNvd
 osNk8swV7D3B4eOgg7jstpQ0nRa/Prq6llfcw/D2Lb70+bjgbzSxoKRjGYxHksp7Vat8
 c4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759992802; x=1760597602;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E6Q4EtsBNVZlQr7FFaPPDr1nc2rYfW1UAd90i7w7t1Q=;
 b=swonxVj9fN+GrOHgsOXREfZGLqK+7bBKgnqXEZnlPsOKd54kc+wlC42o+JOUJdAK0U
 vTEYH6P2xFQO73IjZrdANvHLHLjMMooA5HGN85Lnz33Mdki8DkP/jFimmJs3BRpBHNmO
 tex9RyJxHnicmJd2LkMCi5+EX6wT1quwVJ6qVixh9qTjXe/ATT0OEk5DiJyaidjhNJ68
 zvxHobep1SkiZirtqL6TEMXbWLqZ+TV1GScGB6d0pkQtV4y47HkOT7GVpRQsdGd1FVh6
 FrCMKzb86d7Aug3TCGLCkp7GD3obpWe3hHAUWK0EYCkYBzjuJjRG2WKtHiE8m0CM/P3J
 Fhow==
X-Gm-Message-State: AOJu0Yx65cJOQzqNnvvrB/BROuvPAZThZfufHm6W4nlplfY29Cd4kYTu
 qpPF1talCCs/AmF+4hSAU7u8Fn/TipXfmQre1CdSzjfPeUCq3zdlqV4C3i8aR0cwa+3E7ENQyYG
 JCHuACCi+KQ==
X-Gm-Gg: ASbGnctZf5w7rPs0dbHh0jlKycJQDXbLXDhf1uVZnUJ4LQnv8KVixdaILDZh4M/Mq3u
 2zYGytkeCTn5u2Mc0ATqS9+cEwf4y6cVByTDjNvlFcSORzVzbmruEr645+WMYL6+xFO5YanG3Zg
 k07D8BCPTQ5577tvh/8ymvqYlUxgCUgaSmraAlfYtmzwXzDb9ui49otiffCvoXEd+R8Cr+alpA5
 5/eqSigf7vC/KNfWhTiFgXrRLR8nJtayvM44V8/X6faWcvjLyYPjgJWjddcNTjOgDZRL/SrLX9A
 9sFn/LUQ/BJnjo2SYd4S/+6jVRMNO3hmOaoUHxoi0bbkLw57X2ZDc1AXKuefKbTAPc3Kv4Jbsix
 rF6LcPR6CUDACnZgmgnb4pYk/p7+PzSfBZVNlkY47hlcZj+e7p3SBqbrQ2pM4Ff1VKfYjmvomqM
 T5GwRrtQqo9RPSDXLaIw==
X-Google-Smtp-Source: AGHT+IFKnORvjaje2NDnm40KneHD8rqVW1F5kwfllOnnM9knvkCRB93F+HccAh32Sjp+CarhzFOocg==
X-Received: by 2002:a05:6000:2902:b0:3ec:de27:aaae with SMTP id
 ffacd0b85a97d-4266e7e0f57mr4230891f8f.38.1759992801970; 
 Wed, 08 Oct 2025 23:53:21 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9d62890sm67188125e9.14.2025.10.08.23.53.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 23:53:21 -0700 (PDT)
Message-ID: <a3bed2c6-7597-4638-a4be-b4058ad7b7b3@linaro.org>
Date: Thu, 9 Oct 2025 08:53:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/avr: Mark I/O space mapped cpu regs as
 reentrancy-safe
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Darren Kenny <darren.kenny@oracle.com>, Michael Rolnik
 <mrolnik@gmail.com>, Alexander Bulekov <alxndr@bu.edu>
References: <20250924164329.51644-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250924164329.51644-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 24/9/25 18:43, Philippe Mathieu-Daudé wrote:
> The test_avr_mega2560.py functional test hangs displaying:
> 
>    qemu-system-avr: warning: Blocked re-entrant IO on MemoryRegion: avr-cpu-reg2 at addr: 0x5
> 
> Mark the I/O space mapped cpu regs as reentrancy-safe to avoid that.
> 
> Process 71455 stopped
> * thread #4, stop reason = breakpoint 1.1
>      frame #0: 0x1000a2d30 access_with_adjusted_size(addr=5, value=0x16ff9e4f0, size=1, access_size_min=<unavailable>, access_size_max=4, access_fn=(memory_region_read_accessor at memory.c:435), mr=0x12101bce0, attrs=MemTxAttrs @ x7) at memory.c:547:13
>     544 	    if (mr->dev && !mr->disable_reentrancy_guard &&
>     545 	        !mr->ram_device && !mr->ram && !mr->rom_device && !mr->readonly) {
>     546 	        if (mr->dev->mem_reentrancy_guard.engaged_in_io) {
> -> 547 	            warn_report_once("Blocked re-entrant IO on MemoryRegion: "
>     548 	                             "%s at addr: 0x%" HWADDR_PRIX,
>     549 	                             memory_region_name(mr), addr);
>     550 	            return MEMTX_ACCESS_ERROR;
> Target 0: (qemu-system-avr) stopped.
> (lldb) bt
> * thread #4, stop reason = breakpoint 1.1
>    * frame #0: 0x1000a2d30 access_with_adjusted_size(addr=5, value=0x16ff9e4f0, size=1, access_size_min=<unavailable>, access_size_max=4, access_fn=(memory_region_read_accessor at memory.c:435), mr=0x12101bce0, attrs=MemTxAttrs @ x7) at memory.c:547:13
>      frame #1: 0x1000a27a4 memory_region_dispatch_read [inlined] memory_region_dispatch_read1(mr=0x12101bce0, addr=5, pval=0x16ff9e4f0, size=1, attrs=MemTxAttrs @ x21) at memory.c:0
>      frame #2: 0x1000a2768 memory_region_dispatch_read(mr=0x12101bce0, addr=5, pval=<unavailable>, op=<unavailable>, attrs=<unavailable>) at memory.c:1484:9
>      frame #3: 0x1000af89c flatview_read_continue_step(attrs=MemTxAttrs @ x24, buf="", len=<unavailable>, mr_addr=5, l=0x16ff9e568, mr=0x12101bce0) at physmem.c:3061:18
>      frame #4: 0x1000afb4c flatview_read [inlined] flatview_read_continue(fv=0x0000600003993b40, addr=8388701, attrs=MemTxAttrs @ x21, ptr=0x16ff9e5c0, len=1, mr_addr=5, l=1, mr=<unavailable>) at physmem.c:3102:19
>      frame #5: 0x1000afb3c flatview_read(fv=0x0000600003993b40, addr=8388701, attrs=MemTxAttrs @ x21, buf=0x16ff9e5c0, len=1) at physmem.c:3132:12
>      frame #6: 0x1000b50bc subpage_read(opaque=<unavailable>, addr=<unavailable>, data=0x16ff9e630, len=1, attrs=<unavailable>) at physmem.c:2615:11
>      frame #7: 0x1000a9150 memory_region_read_with_attrs_accessor(mr=0x104096400, addr=93, value=0x16ff9e790, size=1, shift=0, mask=255, attrs=<unavailable>) at memory.c:461:9
>      frame #8: 0x1000a2c9c access_with_adjusted_size(addr=93, value=<unavailable>, size=<unavailable>, access_size_min=<unavailable>, access_size_max=<unavailable>, access_fn=<unavailable>, mr=<unavailable>, attrs=<unavailable>) at memory.c:566:18
>      frame #9: 0x1000a27a4 memory_region_dispatch_read [inlined] memory_region_dispatch_read1(mr=0x104096400, addr=93, pval=0x16ff9e790, size=1, attrs=MemTxAttrs @ x21) at memory.c:0
>      frame #10: 0x1000a2768 memory_region_dispatch_read(mr=0x104096400, addr=93, pval=<unavailable>, op=<unavailable>, attrs=<unavailable>) at memory.c:1484:9
>      frame #11: 0x100163034 do_ld_mmio_beN [inlined] int_ld_mmio_beN(cpu=<unavailable>, full=<unavailable>, ret_be=0, addr=93, size=1, mmu_idx=<unavailable>, type=<unavailable>, ra=<unavailable>, mr=<unavailable>, mr_offset=93) at cputlb.c:1963:13
>      frame #12: 0x100163004 do_ld_mmio_beN(cpu=0x121018ec0, full=0x121027400, ret_be=<unavailable>, addr=<unavailable>, size=<unavailable>, mmu_idx=1, type=MMU_DATA_LOAD, ra=12884916912) at cputlb.c:1997:12
>      frame #13: 0x1001536f0 helper_ldub_mmu [inlined] do_ld_1(cpu=<unavailable>, p=0x16ff9e800, mmu_idx=<unavailable>, type=MMU_DATA_LOAD, ra=12884916912) at cputlb.c:2262:16
>      frame #14: 0x1001536dc helper_ldub_mmu [inlined] do_ld1_mmu(cpu=<unavailable>, addr=<unavailable>, oi=<unavailable>, ra=<unavailable>, access_type=MMU_DATA_LOAD) at cputlb.c:2338:12
>      frame #15: 0x1001536dc helper_ldub_mmu(env=0x12101baf0, addr=<unavailable>, oi=<unavailable>, retaddr=12884916912) at ldst_common.c.inc:19:12
>      frame #16: 0x300003ae4
>      frame #17: 0x10013c6dc cpu_tb_exec(cpu=<unavailable>, itb=<unavailable>, tb_exit=<unavailable>) at cpu-exec.c:439:11
>      frame #18: 0x10013d418 cpu_exec_loop [inlined] cpu_loop_exec_tb(cpu=0x121018ec0, tb=<unavailable>, pc=<unavailable>, last_tb=<unavailable>, tb_exit=0x16ff9ee0c) at cpu-exec.c:878:10
>      frame #19: 0x10013d400 cpu_exec_loop(cpu=0x121018ec0, sc=0x16ff9eed0) at cpu-exec.c:991:13
>      frame #20: 0x10013cc00 cpu_exec_setjmp(cpu=0x121018ec0, sc=0x16ff9eed0) at cpu-exec.c:1011:12
>      frame #21: 0x10013cb24 cpu_exec(cpu=0x121018ec0) at cpu-exec.c:1037:11
>      frame #22: 0x100165830 tcg_cpu_exec(cpu=0x121018ec0) at tcg-accel-ops.c:98:11
>      frame #23: 0x10016607c mttcg_cpu_thread_routine [inlined] mttcg_cpu_exec(cpu=0x121018ec0) at tcg-accel-ops-mttcg.c:154:11
>      frame #24: 0x100166070 mttcg_cpu_thread_routine(arg=0x121018ec0) at tcg-accel-ops-mttcg.c:113:21
>      frame #25: 0x100334218 qemu_thread_start(args=<unavailable>) at qemu-thread-posix.c:393:9
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/avr/cpu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> index a6df71d0205..306c3590f23 100644
> --- a/target/avr/cpu.c
> +++ b/target/avr/cpu.c
> @@ -151,6 +151,7 @@ static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
>   
>       memory_region_init_io(&cpu->cpu_reg2, OBJECT(cpu), &avr_cpu_reg2, env,
>                             "avr-cpu-reg2", 8);
> +    cpu->cpu_reg2.disable_reentrancy_guard = true;

Same applies to cpu_reg1.

>       memory_region_add_subregion(get_system_memory(),
>                                   OFFSET_DATA + 0x58, &cpu->cpu_reg2);
>   }


