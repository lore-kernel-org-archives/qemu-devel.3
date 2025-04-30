Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206D7C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 11:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA5UV-0005G1-Dh; Wed, 30 Apr 2025 07:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uA5UO-0005Fa-BK; Wed, 30 Apr 2025 07:20:33 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uA5UL-0000Uo-8L; Wed, 30 Apr 2025 07:20:32 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4D38755D245;
 Wed, 30 Apr 2025 13:20:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id KBe1XPR0ykqq; Wed, 30 Apr 2025 13:20:20 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E981D55C592; Wed, 30 Apr 2025 13:20:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E7532745682;
 Wed, 30 Apr 2025 13:20:20 +0200 (CEST)
Date: Wed, 30 Apr 2025 13:20:20 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org
Subject: Re: [RFC PATCH] target/ppc: Inline most of dcbz helper
In-Reply-To: <D9JJWC1IWEEB.1IA8DSZF98YT4@gmail.com>
Message-ID: <0386a2ee-e2c3-a1df-f867-c8fcaf9689a4@eik.bme.hu>
References: <20240701005939.5A0AF4E6000@zero.eik.bme.hu>
 <d3c6c417-20d9-a215-2a5c-86fa084b00fa@eik.bme.hu>
 <173c9111-e065-0dd5-c276-6bbc0351f9cc@eik.bme.hu>
 <2b969dcd-4a82-9086-803d-c52ea274fefb@eik.bme.hu>
 <e4fc537a-a15e-77dd-1167-32b12ee7a22d@eik.bme.hu>
 <ded56ee3-25bb-4ffd-98e4-2f47c500c88d@linaro.org>
 <164d86d5-f17a-1f89-d973-c3e56255195d@eik.bme.hu>
 <875xin3qeh.fsf@draig.linaro.org>
 <4f7cbb13-2c7c-1d3e-9d41-49ec16bee245@eik.bme.hu>
 <87zffy3l4g.fsf@draig.linaro.org>
 <aec151d9-fae2-4bbc-c690-2b68f5906664@eik.bme.hu>
 <D9JJWC1IWEEB.1IA8DSZF98YT4@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-428521133-1746012020=:25048"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-428521133-1746012020=:25048
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 30 Apr 2025, Nicholas Piggin wrote:
> On Wed Apr 30, 2025 at 7:09 AM AEST, BALATON Zoltan wrote:
>> On Tue, 29 Apr 2025, Alex Bennée wrote:
>>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>>> On Tue, 29 Apr 2025, Alex Bennée wrote:
>>>>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>>>>> On Mon, 28 Apr 2025, Richard Henderson wrote:
>>>>>>> On 4/28/25 06:26, BALATON Zoltan wrote:
>>>>>>>> I have tried profiling the dst in real card vfio vram with dcbz
>>>>>>>> case (with 100 iterations instead of 10000 in above tests) but I'm
>>>>>>>> not sure I understand the results. vperm and dcbz show up but not
>>>>>>>> too high. Can somebody explain what is happening here and where the
>>>>>>>> overhead likely comes from? Here is the profile result I got:
>>>>>>>> Samples: 104K of event 'cycles:Pu', Event count (approx.):
>>>>>>>> 122371086557
>>>>>>>>    Children      Self  Command          Shared Object            Symbol
>>>>>>>> -   99.44%     0.95%  qemu-system-ppc  qemu-system-ppc          [.]
>>>>>>>> cpu_exec_loop
>>>>>>>>     - 98.49% cpu_exec_loop
>>>>>>>>        - 98.48% cpu_tb_exec
>>>>>>>>           - 90.95% 0x7f4e705d8f15
>>>>>>>>                helper_ldub_mmu
>>>>>>>>                do_ld_mmio_beN
>>>>>>>>              - cpu_io_recompile
>>>>>>>>                 - 45.79% cpu_loop_exit_noexc
>>>>>>>
>>>>>>> I think the real problem is the number of loop exits due to i/o.  If
>>>>>>> I'm reading this rightly, 45% of execution is in cpu_io_recompile.
>>>>>>>
>>>>>>> I/O can only happen as the last insn of a translation block.
>>>>>>
>>>>>> I'm not sure I understand this. A comment above cpu_io_recompile says
>>>>>> "In deterministic execution mode, instructions doing device I/Os must
>>>>>> be at the end of the TB." Is that wrong? Otherwise shouldn't this only
>>>>>> apply if running with icount or something like that?
>>>>>
>>>>> That comment should be fixed. It used to only be the case for icount
>>>>> mode but there was another race bug that meant we need to honour device
>>>>> access as the last insn for both modes.
>>>>>
>>>>>>
>>>>>>> When we detect that it has happened in the middle of a translation
>>>>>>> block, we abort the block, compile a new one, and restart execution.
>>>>>>
>>>>>> Where does that happen? The calls of cpu_io_recompile in this case
>>>>>> seem to come from io_prepare which is called from do_ld16_mmio_beN if
>>>>>> (!cpu->neg.can_do_io) but I don't see how can_do_io is set.
>>>>>
>>>>> Inline by set_can_do_io()
>>>>
>>>> That one I've found but don't know where the cpu_loop_exit returns
>>>> from the end of cpu_io_recompile.
>>>
>>> cpu_loop_exit longjmp's back to the top of the execution loop.
>>>
>>>>
>>>>>>> Where this becomes a bottleneck is when this same translation block
>>>>>>> is in a loop.  Exactly this case of memset/memcpy of VRAM.  This
>>>>>>> could be addressed by invalidating the previous translation block
>>>>>>> and creating a new one which always ends with the i/o.
>>>>>>
>>>>>> And where to do that? cpu_io_recompile just exits the TB but what
>>>>>> generates the new TB? I need some more clues to understands how to do
>>>>>> this.
>>>>>
>>>>>  cpu->cflags_next_tb = curr_cflags(cpu) | CF_MEMI_ONLY | CF_NOIRQ | n;
>>>>>
>>>>> sets the cflags for the next cb, which typically will fail to find and
>>>>> then regenerate. Normally cflags_next_tb is empty.
>>>>
>>>> Shouldn't this only regenerate the next TB on the first loop iteration
>>>> and not afterwards?
>>>
>>> if we've been here before (needing n insn from the base addr) we will
>>> have a cached translation we can re-use. It doesn't stop the longer TB
>>> being called again as we re-enter a loop.
>>
>> So then maybe it should at least check if there's already a cached TB
>> where it can continue before calling cpu_io_recompile in io_prepare and
>> only recompile if needed?
>
> It basically does do that AFAIKS. cpu_io_recompile() name is misleading
> it does not cause a recompile, it just updates cflags and exits. Next
> entry will look up TB that has just 1 insn and enter that.

After reading it I came to the same conclusion but then I don't understand 
what causes the problem. Is it just that it will exit the loop for every 
IO to look up the recompiled TB? It looks like it tries to chain TBs, why 
does that not work here?

>> I was thinking maybe we need a flag or counter
>> to see if cpu_io_recompile is called more than once and after a limit
>> invalidate the TB and create two new ones the first ending at the I/O and
>> then what cpu_io_recompile does now which as I understood was what Richard
>> suggested but I don't know how to do that.
>
> memset/cpy routines had kind of the same problem with real hardware.
> They wanted to use vector instructions for best performance, but when
> those are used on MMIO they would trap and be very slow.

Why do those trap on MMIO on real machine? These routines were tested on 
real machines and the reasoning to use the widest possible access was that 
PCI transfer has overhead and that is minimised by transferring more bits 
in one op. I think they also verifed that it works at least for the 32 bit 
CPUs up to G4 that were used on real AmigaNG machines. There are some 
benchmark results here: 
https://hdrlab.org.nz/benchmark/gfxbench2d/OS/AmigaOS?start=60 which is 
also where the benchmark I used comes from so this should be similar. I 
think the MemCopy on that page has plain unoptimised copy as Copy to/from 
VRAM and optimised routines similar to this benchmark as Read/Write Pixel 
Array, but it's not easy to search. Some of the machines like Pegasos II 
and AmigaOne XE were made with both G3 or G4 CPUs so if I find a result 
from those with same graphics card that could show if AltiVec is faster 
(although the G4s were also higher clock so not directly comparable). Some 
results there are also from QEMU, mostly those that are with SiliconMotion 
502 but that does not have this problem only vfio-pci pass through. So 
maybe it's something with how vfio-pci maps PCI memory BARs?

> Problem is we don't know ahead of time if some routine will access
> MMIO or not. You could recompile it with fewer instructions but then
> it will be slow when used for regular memory.
>
> Heuristics are tough because you could have e.g., one initial big
> memset to clear a MMIO region that iterates many times over inner
> loop of dcbz instructions, but then is never used again for MMIO but
> important for regular page clearing. Making something that dynamically
> decays or periodically would recompile to non-IO case perhaps, but
> then complexity goes up.
>
> I would prefer not like to do that just for a microbenchmark, but if
> you think it is reasonable overall win for average workloads of your
> users then perhaps.

I'm still trying to understand what to optimise. So far it looks like that 
dcbz has the least impact, then vperm a bit bigger but still only about a 
few percent and the biggest impact is still not known for sure but we see 
faster access on real machines that run on slower PCIe (only 4x at best) 
while CPU benchmarks don't show slower performance on QEMU only accessing 
passed through card's VRAM is slower than expected. But if there's a trap 
involved I've found before that exceptions are slower with QEMU but I did 
not see evidence of that in the profile.

Regards,
BALATON Zoltan
--3866299591-428521133-1746012020=:25048--

