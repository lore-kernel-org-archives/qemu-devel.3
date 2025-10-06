Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7681ECCA476
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 04:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5cb1-0002s6-03; Mon, 06 Oct 2025 00:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5cay-0002rK-T1
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 00:13:09 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5caw-0004xN-Tx
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 00:13:08 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e29d65728so24981775e9.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 21:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759723985; x=1760328785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MZbLHfe+g9Rf8IQGycX1MZlJJnT7Yhz3mrmYoTSYdGc=;
 b=buhVga9ioPHX3lm+Lt/lyfems1F7zvMEXI9Qpr6BekG/z6IelmJKbG4BL/8j3rF/vs
 cG7N5aB5If7Wc0Q+KpSPSW4oUh7qHAJEAxxD2f6DLDpyXDjfmIm0bIY91ASH+fOqUQbB
 S2VTi10lAI1t4JzB437/pQcAYcmoOXUv3t38jvGyqU4A51f+7/Wm/DkTljZf21ywpJD0
 i3T3Bk9lHjXqu7POeCudn7Zm8z7vbiH6kJDfW4jXnawfmmsk3I5yRKpX1zW614fH6NwE
 elHplHix8i1Sj+1rXexU2UmHD5JNq0b7XrAG3fh890c7CK/CHtIimqLIUW9F11JR8NwV
 Ww6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759723985; x=1760328785;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MZbLHfe+g9Rf8IQGycX1MZlJJnT7Yhz3mrmYoTSYdGc=;
 b=QsdzR6e7LeK4Ntl2VOHfnhU54k6LJ85luKXkBK8xqTk/VA5KWcZ7cSbbHmceun6RLq
 JIZZdGpNeZ10Ki6gmUBHIPcH2BZ8SJaBS5Ie5QTSovtEndZNLVSCRSj7U11oaq9CwA37
 lHxkdguu63dj5Xl+Uf9Vo5t2jStPPuy55he3vy33YtFxXrdwUfevlx3jlgb0VVryhGNO
 o+EUn0fLu40lbo+pehYV9GHdWmE+tb0cm0xvbyY+VtsxaoxjRDL5A3MB4KDDB5FBnpff
 5rLVy3K5hw8vItauTS9AzS+2Vp1IF4SgneMyfUBnikRtoX8LG9pj8n09cocIPatE6u4h
 8fFA==
X-Gm-Message-State: AOJu0YzxJVRgOsCAYMPd5cvtQT7eL3YmFgn88NZNY9xlpQavS7GBFFiY
 cbU5O1mviKKRSW3C3wbqknfTA56zD9U3Wi7iynoDg7DWSnhkwdN2Wydlxsv0rnAsOdJkmgGRAUA
 fEq2sutAl9g==
X-Gm-Gg: ASbGnctQCaEB4AzyniiRu7K1G/O21WQWbX4/8QPJ7Uc/ZvzXUZi9QB7U9sNHP8uPpGb
 XdpwqMOXjiS2iejxy7oNPjRCV+Tg1cYlP5FYWLf3RNxpSKmisOfJzu1TLZ29rrEmAGVghcgQmjj
 eBOBpBlKzyeHHhf5R3PbfPHAfPq8Jjx/mLane2AMHDYTG+ThzyFtQsafj0jdKbn0ftxMZicj2DX
 d9VqWElGGWBZZrzx/F41oMvzQE2X3w5DEkIcK8WJHXKiXlbXQHHJ8f7inrF1Owd3Lis6L6FB0Sh
 V/+263yiC/SYDBWEbjMU85V0E3g8vFNXNE2ih9WdA+xEi69dH0io6tyC3XE7Qw4zcC5oS9MCoHC
 CFEPDjUWoL/6GRqZToU9ni3rvm+EprR71jMscSUfsCZ396eEiTrTnvx4/y+P0+ndpUzxaGNXU9r
 OaU6KU0ZHs66Hb5tfRGw==
X-Google-Smtp-Source: AGHT+IF4zknuQSSFn5tLX7TdDOIDyUOnouFNe9R7R5LRSxNbmOQvpIzRmDMp/1iA7Igf/q5RUs39vA==
X-Received: by 2002:a05:600d:4173:b0:46e:4586:57e4 with SMTP id
 5b1f17b1804b1-46e71164167mr82064265e9.24.1759723984783; 
 Sun, 05 Oct 2025 21:13:04 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6b23d4c5sm179840485e9.17.2025.10.05.21.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Oct 2025 21:13:03 -0700 (PDT)
Message-ID: <f9498de0-7371-4fbb-acb4-1dd5c691da48@linaro.org>
Date: Mon, 6 Oct 2025 06:13:01 +0200
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
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

ping

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
>       memory_region_add_subregion(get_system_memory(),
>                                   OFFSET_DATA + 0x58, &cpu->cpu_reg2);
>   }


