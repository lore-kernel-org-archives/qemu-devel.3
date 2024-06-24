Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E89C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 09:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLfrM-00005a-08; Mon, 24 Jun 2024 05:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sLfrK-00005I-Fx; Mon, 24 Jun 2024 05:19:34 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sLfrF-0005JN-3l; Mon, 24 Jun 2024 05:19:34 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E8B364E6004;
 Mon, 24 Jun 2024 11:19:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id u53lRidnyuLT; Mon, 24 Jun 2024 11:19:22 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EA4774E6001; Mon, 24 Jun 2024 11:19:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E838A7470B7;
 Mon, 24 Jun 2024 11:19:22 +0200 (CEST)
Date: Mon, 24 Jun 2024 11:19:22 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH] target/ppc/mem_helper.c: Remove a conditional from
 dcbz_common()
In-Reply-To: <ccb2fe51-4256-42a0-b9c8-1e4886c0472a@linaro.org>
Message-ID: <90370a73-8d47-ee91-b986-0a748ea01253@eik.bme.hu>
References: <20240622204833.5F7C74E6000@zero.eik.bme.hu>
 <6664471b-7223-4c6e-a106-ce272be72f28@linaro.org>
 <a0e7e8e3-97b1-34a3-b688-78bf77db5fd9@eik.bme.hu>
 <ccb2fe51-4256-42a0-b9c8-1e4886c0472a@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1921675513-1719220762=:66817"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

--3866299591-1921675513-1719220762=:66817
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 23 Jun 2024, Richard Henderson wrote:
> On 6/23/24 15:24, BALATON Zoltan wrote:
>> On Sun, 23 Jun 2024, Richard Henderson wrote:
>>> On 6/22/24 13:48, BALATON Zoltan wrote:
>>>> Instead of passing a bool and select a value within dcbz_common() let
>>>> the callers pass in the right value to avoid this conditional
>>>> statement. On PPC dcbz is often used to zero memory and some code uses
>>>> it a lot. This change improves the run time of a test case that copies
>>>> memory with a dcbz call in every iteration from 6.23 to 5.83 seconds.
>>>> 
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>> This is just a small optimisation removing some of the overhead but
>>>> dcbz still seems to be the biggest issue with this test. Removing the
>>>> dcbz call it runs in 2 seconds. In a profile I see:
>>>>    Children      Self  Command   Shared Object            Symbol
>>>> -   55.01%    11.44%  qemu-ppc  qemu-ppc                 [.] 
>>>> dcbz_common.constprop.0
>>>>                 - 43.57% dcbz_common.constprop.0
>>>>                    - probe_access
>>>>                       - page_get_flags
>>>>                            interval_tree_iter_first
>>>>                 - 11.44% helper_raise_exception_err
>>>>                      cpu_loop_exit_restore
>>>>                      cpu_loop
>>>>                      cpu_exec
>>>>                      cpu_exec_setjmp.isra.0
>>>>                      cpu_exec_loop.constprop.0
>>>>                      cpu_tb_exec
>>>>                      0x7f262403636e
>>>>                      helper_raise_exception_err
>>>>                      cpu_loop_exit_restore
>>>>                      cpu_loop
>>>>                      cpu_exec
>>>>                      cpu_exec_setjmp.isra.0
>>>>                      cpu_exec_loop.constprop.0
>>>>                      cpu_tb_exec
>>>>                    - 0x7f26240386a4
>>>>                         11.20% helper_dcbz
>>>> +   43.81%    12.28%  qemu-ppc  qemu-ppc                 [.] probe_access
>>>> +   39.31%     0.00%  qemu-ppc  [JIT] tid 9969           [.] 
>>>> 0x00007f2624000000
>>>> +   32.45%     4.51%  qemu-ppc  qemu-ppc                 [.] 
>>>> page_get_flags
>>>> +   25.50%     2.10%  qemu-ppc  qemu-ppc                 [.] 
>>>> interval_tree_iter_first
>>>> +   24.67%    24.67%  qemu-ppc  qemu-ppc                 [.] 
>>>> interval_tree_subtree_search
>>>> +   16.75%     1.19%  qemu-ppc  qemu-ppc                 [.] helper_dcbz
>>>> +    4.78%     4.78%  qemu-ppc  [JIT] tid 9969           [.] 
>>>> 0x00007f26240386be
>>>> +    3.46%     3.46%  qemu-ppc  libc-2.32.so             [.] 
>>>> __memset_avx2_unaligned_erms
>>>> Any idea how this could be optimised further? (This is running with
>>>> qemu-ppc user mode emulation but I think with system it might be even
>>>> worse.) Could an inline implementation with TCG vector ops work to
>>>> avoid the helper and let it compile to efficient host code? Even if
>>>> that could work I don't know how to do that so I'd need some further
>>>> advice on this.
>>>> 
>>>>   target/ppc/mem_helper.c | 7 +++----
>>>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>>> 
>>>> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
>>>> index f88155ad45..361fd72226 100644
>>>> --- a/target/ppc/mem_helper.c
>>>> +++ b/target/ppc/mem_helper.c
>>>> @@ -271,12 +271,11 @@ void helper_stsw(CPUPPCState *env, target_ulong 
>>>> addr, uint32_t nb,
>>>>   }
>>>>     static void dcbz_common(CPUPPCState *env, target_ulong addr,
>>>> -                        uint32_t opcode, bool epid, uintptr_t retaddr)
>>>> +                        uint32_t opcode, int mmu_idx, uintptr_t retaddr)
>>>>   {
>>>>       target_ulong mask, dcbz_size = env->dcache_line_size;
>>>>       uint32_t i;
>>>>       void *haddr;
>>>> -    int mmu_idx = epid ? PPC_TLB_EPID_STORE : ppc_env_mmu_index(env, 
>>>> false);
>>>>     #if defined(TARGET_PPC64)
>>>>       /* Check for dcbz vs dcbzl on 970 */
>>>> @@ -309,12 +308,12 @@ static void dcbz_common(CPUPPCState *env, 
>>>> target_ulong addr,
>>>>     void helper_dcbz(CPUPPCState *env, target_ulong addr, uint32_t 
>>>> opcode)
>>>>   {
>>>> -    dcbz_common(env, addr, opcode, false, GETPC());
>>>> +    dcbz_common(env, addr, opcode, ppc_env_mmu_index(env, false), 
>>>> GETPC());
>>> 
>>> This is already computed in the translator: DisasContext.mem_idx.
>>> If you pass the mmu_idx as an argument, you can unify these two helpers.
>> 
>> I've tried that. It works but slower: I get 5.9 seconds vs 5.83 with this 
>> patch so I think I'd stay with this one. Maybe it's because making the 
>> helper take 4 parameters instead of 3? I can submit the patch for reference 
>> if it would be useful but I'd keep this one for merging for now.
>
> Interesting.  Can you share your test case?
>
> The other thing I see is that we can split out the 970 test to a separate 
> helper.  We can test for POWERPC_EXCP_970 and !(opcode & 0x00200000) during 
> translation.  I think the current placement, where dcbzep tests that as well, 
> is wrong, since dcbze is an E500 insn.
> Anyway, that would eliminate opcode as an argument bringing you back to 3.

It'd eliminate opcode but I think I'd need to pass cache line size instead 
somehow so it might still need 4 parameters. I'll give that a try and see 
if it's better or not. But the biggest overhead is still the call to 
probe_write. Is there a way to eliminate that and maybe do the zeroing 
with vector or 128 bir ops in compiled code and not in the helper? (I've 
tried removing the test and memset but the slow path is really slow, takes 
more than 9 seconds so it's still faster to test when memset can be used.)

Regards,
BALATON Zoltan
--3866299591-1921675513-1719220762=:66817--

