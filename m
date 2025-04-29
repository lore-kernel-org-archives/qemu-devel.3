Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFC8C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 17:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9oUl-0008EK-O6; Tue, 29 Apr 2025 13:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u9oUi-0008Do-KU; Tue, 29 Apr 2025 13:11:44 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u9oUf-0006bY-VC; Tue, 29 Apr 2025 13:11:44 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7E8A555D239;
 Tue, 29 Apr 2025 19:11:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id uWSJJS7hS5iB; Tue, 29 Apr 2025 19:11:35 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 19F0C55C592; Tue, 29 Apr 2025 19:11:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 17D17745682;
 Tue, 29 Apr 2025 19:11:35 +0200 (CEST)
Date: Tue, 29 Apr 2025 19:11:35 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH] target/ppc: Inline most of dcbz helper
In-Reply-To: <87bjsf3s40.fsf@draig.linaro.org>
Message-ID: <9438979e-b809-8209-bed0-7ac4b0c10912@eik.bme.hu>
References: <20240701005939.5A0AF4E6000@zero.eik.bme.hu>
 <d3c6c417-20d9-a215-2a5c-86fa084b00fa@eik.bme.hu>
 <173c9111-e065-0dd5-c276-6bbc0351f9cc@eik.bme.hu>
 <2b969dcd-4a82-9086-803d-c52ea274fefb@eik.bme.hu>
 <e4fc537a-a15e-77dd-1167-32b12ee7a22d@eik.bme.hu>
 <87bjsf3s40.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1258299402-1745946695=:85983"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--3866299591-1258299402-1745946695=:85983
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 29 Apr 2025, Alex Bennée wrote:
> BALATON Zoltan <balaton@eik.bme.hu> writes:
>> On Mon, 28 Apr 2025, BALATON Zoltan wrote:
>>> On Mon, 28 Apr 2025, BALATON Zoltan wrote:
>>>> On Thu, 24 Apr 2025, BALATON Zoltan wrote:
>>>>>> The test case I've used came out of a discussion about very slow
>>>>>> access to VRAM of a graphics card passed through with vfio the reason
>>>>>> for which is still not clear but it was already known that dcbz is
>>>>>> often used by MacOS and AmigaOS for clearing memory and to avoid
>>>>>> reading values about to be overwritten which is faster on real CPU but
>>>>>> was found to be slower on QEMU. The optimised copy routines were
>>>>>> posted here:
> <snip>
>>
>> I have tried profiling the dst in real card vfio vram with dcbz case
>> (with 100 iterations instead of 10000 in above tests) but I'm not sure
>> I understand the results. vperm and dcbz show up but not too high. Can
>> somebody explain what is happening here and where the overhead likely
>> comes from? Here is the profile result I got:
>>
>> Samples: 104K of event 'cycles:Pu', Event count (approx.): 122371086557
>>   Children      Self  Command          Shared Object            Symbol
>> -   99.44%     0.95%  qemu-system-ppc  qemu-system-ppc          [.] cpu_exec_loop
>>    - 98.49% cpu_exec_loop
>>       - 98.48% cpu_tb_exec
>>          - 90.95% 0x7f4e705d8f15
>>               helper_ldub_mmu
>>               do_ld_mmio_beN
>>             - cpu_io_recompile
>
> This looks like the dbz instructions are being used to clear device
> memory and tripping over the can_do_io check (normally the translator
> tries to ensure all device access is at the end of a block).

If you look at the benchmark results I posted earlier in this thread in 
https://lists.nongnu.org/archive/html/qemu-ppc/2025-04/msg00326.html
I also tried using dcba instead of dcbz in the CopyFromVRAM* functions but 
that only helped very little so not sure it's because of dcbz. Then I 
thought it might be VPERM but the NoAltivec variants are also only a 
little faster. It could be that using 64 bit access instead of 128 bit 
(the NoAltivec functions use FPU regs) makes it slower while avoiding 
VPERM makes it faster which cancel each other but the profile also shows 
VPERM not high and somebody else also tested this with -cpu g3 and only 
got 1% faster result so maybe it's also not primarily because of VPERM but 
there's a bigger overhead before these..

> You could try ending the block on dbz instructions and seeing if that
> helps. Normally I would expect the helper to be more efficient as it can
> probe the whole address range once and then use host insns to blat the
> memory.

Maybe I could try that if I can do that the same way as done in 
io_prepare.

>>                - 45.79% cpu_loop_exit_noexc
>>                   - cpu_loop_exit
>>                     __longjmp_chk
>>                     cpu_exec_setjmp
>>                   - cpu_exec_loop
>>                      - 45.78% cpu_tb_exec
>>                           42.35% 0x7f4e6f3f0000
>>                         - 0.72% 0x7f4e99f37037
>>                              helper_VPERM
>>                         - 0.68% 0x7f4e99f3716d
>>                              helper_VPERM
>>                - 45.16% rr_cpu_thread_fn
>
> Hmm you seem to be running in icount mode here for some reason.

No idea why. I had no such options and complied without --enable-debug and 
nothing special on QEMU command just defaults options. How can I check if 
icount is enabled? Can profiling with perf tool interfere? I thought that 
only reads CPU performance counters and does not attach to the process 
otherwise.

Regards,
BALATON Zoltan

>>                   - 45.16% tcg_cpu_exec
>>                      - 45.15% cpu_exec
>>                         - 45.15% cpu_exec_setjmp
>>                            - cpu_exec_loop
>>                               - 45.14% cpu_tb_exec
>>                                    42.08% 0x7f4e6f3f0000
>>                                  - 0.72% 0x7f4e99f37037
>>                                       helper_VPERM
>>                                  - 0.67% 0x7f4e99f3716d
>>                                       helper_VPERM
> <snip>
>
>
--3866299591-1258299402-1745946695=:85983--

