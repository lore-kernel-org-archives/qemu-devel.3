Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0550C27C4F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 03:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLaIU-0005HE-5M; Sun, 23 Jun 2024 23:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLaIS-0005Ge-Ky
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 23:23:12 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLaIQ-0008Ud-LF
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 23:23:12 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fa2782a8ccso4892605ad.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 20:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719199389; x=1719804189; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nuaq6tDlRdNBp0IfWKYsdP6oTVJHTIOYNZFstCRJQWE=;
 b=hvJp5VNRVG8KuecMxzBtjCBU0r0KrQqAFLGSwf4QQXP6OrzzYZ6vCD2yIHNNC21rio
 Bau/fZO2L750fAjpKVOU8TYHb4IOky+EEf3tGcNoXddm8kmXuUeG1ABJfj95wsNqxbNH
 qcDUTIhe9PPuj0fZ8EZNZQY1kGtfEwHfd3N7ib70faMWYziER0mgaaoMV9z3XB2N+KVi
 oB8Cs2Vo+UolA2QtZkd6VDY/H395CKjauPuQkTUrUlWlerNNhPKqdp6WmrehOlAmXKCW
 y5rzOlmtcOvP6MVMhtFzsP3rEQ7yZyZzd6SrYImOk0YxuUhbptMI2NsurbLTfnr7QeXr
 UMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719199389; x=1719804189;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nuaq6tDlRdNBp0IfWKYsdP6oTVJHTIOYNZFstCRJQWE=;
 b=NO5fu0u9XZ09630IVHsGJ1tw0GL+77uP/U8dSLf3EOl8cCUCwpU+oLaL0W3MZUUK6T
 Z6Y1NmX/2gZLC7GBO1MCo4CXq5VeqZNHLPS5riiKKJ71ZEWLidW1jo7TX0P4qu+/E3KH
 iBEOD4euauV4R2GOzOIFRWMLthKaScZCrTmpbaUb9yRw9inXekEcyRv6Hy3Q0SRl5kOU
 zOjMfftyW5Nb6Dp+63mLKxRU5M1fcmFTNXbIuuoTWl94/onJYiSqII9fNULxsGHLzMji
 Mp3hice7GGmtFQ1APJjFxhAaAnGpGhG5BdEYjqUKSmZMbswHqA6M9DFiZPCSJb50ld3E
 2bYw==
X-Gm-Message-State: AOJu0Yzoral/Apy2MaipUpChH6bfaFR9UXj5ddPoSQcxvIzQo1r/U0y6
 qeVgs8jtIIHv0nIxVTCwb7SS8HGQGMR6E1KiQxDzg0IllDhHEoZtqgtipCGAUng=
X-Google-Smtp-Source: AGHT+IFX9oERW/4OWC0kbdbQ1BBv4EW5IhCCUFDhjhlwxr8T+XpbFCk3GyY90XcqpbcPS+T3ZFRCUA==
X-Received: by 2002:a17:902:e852:b0:1f9:c508:a765 with SMTP id
 d9443c01a7336-1fa23f15beamr42423645ad.44.1719199388854; 
 Sun, 23 Jun 2024 20:23:08 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9f6e36df3sm47117215ad.17.2024.06.23.20.23.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 20:23:08 -0700 (PDT)
Message-ID: <ccb2fe51-4256-42a0-b9c8-1e4886c0472a@linaro.org>
Date: Sun, 23 Jun 2024 20:23:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc/mem_helper.c: Remove a conditional from
 dcbz_common()
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20240622204833.5F7C74E6000@zero.eik.bme.hu>
 <6664471b-7223-4c6e-a106-ce272be72f28@linaro.org>
 <a0e7e8e3-97b1-34a3-b688-78bf77db5fd9@eik.bme.hu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <a0e7e8e3-97b1-34a3-b688-78bf77db5fd9@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 6/23/24 15:24, BALATON Zoltan wrote:
> On Sun, 23 Jun 2024, Richard Henderson wrote:
>> On 6/22/24 13:48, BALATON Zoltan wrote:
>>> Instead of passing a bool and select a value within dcbz_common() let
>>> the callers pass in the right value to avoid this conditional
>>> statement. On PPC dcbz is often used to zero memory and some code uses
>>> it a lot. This change improves the run time of a test case that copies
>>> memory with a dcbz call in every iteration from 6.23 to 5.83 seconds.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>> This is just a small optimisation removing some of the overhead but
>>> dcbz still seems to be the biggest issue with this test. Removing the
>>> dcbz call it runs in 2 seconds. In a profile I see:
>>>    Children      Self  Command   Shared Object            Symbol
>>> -   55.01%    11.44%  qemu-ppc  qemu-ppc                 [.] dcbz_common.constprop.0
>>>                 - 43.57% dcbz_common.constprop.0
>>>                    - probe_access
>>>                       - page_get_flags
>>>                            interval_tree_iter_first
>>>                 - 11.44% helper_raise_exception_err
>>>                      cpu_loop_exit_restore
>>>                      cpu_loop
>>>                      cpu_exec
>>>                      cpu_exec_setjmp.isra.0
>>>                      cpu_exec_loop.constprop.0
>>>                      cpu_tb_exec
>>>                      0x7f262403636e
>>>                      helper_raise_exception_err
>>>                      cpu_loop_exit_restore
>>>                      cpu_loop
>>>                      cpu_exec
>>>                      cpu_exec_setjmp.isra.0
>>>                      cpu_exec_loop.constprop.0
>>>                      cpu_tb_exec
>>>                    - 0x7f26240386a4
>>>                         11.20% helper_dcbz
>>> +   43.81%    12.28%  qemu-ppc  qemu-ppc                 [.] probe_access
>>> +   39.31%     0.00%  qemu-ppc  [JIT] tid 9969           [.] 0x00007f2624000000
>>> +   32.45%     4.51%  qemu-ppc  qemu-ppc                 [.] page_get_flags
>>> +   25.50%     2.10%  qemu-ppc  qemu-ppc                 [.] interval_tree_iter_first
>>> +   24.67%    24.67%  qemu-ppc  qemu-ppc                 [.] interval_tree_subtree_search
>>> +   16.75%     1.19%  qemu-ppc  qemu-ppc                 [.] helper_dcbz
>>> +    4.78%     4.78%  qemu-ppc  [JIT] tid 9969           [.] 0x00007f26240386be
>>> +    3.46%     3.46%  qemu-ppc  libc-2.32.so             [.] __memset_avx2_unaligned_erms
>>> Any idea how this could be optimised further? (This is running with
>>> qemu-ppc user mode emulation but I think with system it might be even
>>> worse.) Could an inline implementation with TCG vector ops work to
>>> avoid the helper and let it compile to efficient host code? Even if
>>> that could work I don't know how to do that so I'd need some further
>>> advice on this.
>>>
>>>   target/ppc/mem_helper.c | 7 +++----
>>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
>>> index f88155ad45..361fd72226 100644
>>> --- a/target/ppc/mem_helper.c
>>> +++ b/target/ppc/mem_helper.c
>>> @@ -271,12 +271,11 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
>>>   }
>>>     static void dcbz_common(CPUPPCState *env, target_ulong addr,
>>> -                        uint32_t opcode, bool epid, uintptr_t retaddr)
>>> +                        uint32_t opcode, int mmu_idx, uintptr_t retaddr)
>>>   {
>>>       target_ulong mask, dcbz_size = env->dcache_line_size;
>>>       uint32_t i;
>>>       void *haddr;
>>> -    int mmu_idx = epid ? PPC_TLB_EPID_STORE : ppc_env_mmu_index(env, false);
>>>     #if defined(TARGET_PPC64)
>>>       /* Check for dcbz vs dcbzl on 970 */
>>> @@ -309,12 +308,12 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
>>>     void helper_dcbz(CPUPPCState *env, target_ulong addr, uint32_t opcode)
>>>   {
>>> -    dcbz_common(env, addr, opcode, false, GETPC());
>>> +    dcbz_common(env, addr, opcode, ppc_env_mmu_index(env, false), GETPC());
>>
>> This is already computed in the translator: DisasContext.mem_idx.
>> If you pass the mmu_idx as an argument, you can unify these two helpers.
> 
> I've tried that. It works but slower: I get 5.9 seconds vs 5.83 with this patch so I think 
> I'd stay with this one. Maybe it's because making the helper take 4 parameters instead of 
> 3? I can submit the patch for reference if it would be useful but I'd keep this one for 
> merging for now.

Interesting.  Can you share your test case?

The other thing I see is that we can split out the 970 test to a separate helper.  We can 
test for POWERPC_EXCP_970 and !(opcode & 0x00200000) during translation.  I think the 
current placement, where dcbzep tests that as well, is wrong, since dcbze is an E500 insn.
Anyway, that would eliminate opcode as an argument bringing you back to 3.


r~

