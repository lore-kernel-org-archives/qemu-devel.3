Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173BED3C54C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 07:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1h2B-0007J0-Ov; Fri, 18 Oct 2024 03:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1h29-0007Hr-MD
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 03:04:25 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1h27-0000d4-TO
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 03:04:25 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d49a7207cso1220499f8f.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 00:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729235062; x=1729839862;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fTUMTbd8vlTjCfY1mg31OjEcMp+/UHOeYnQ24prrp/c=;
 b=1tZC/mS7Xpr2U1HE0BoSy0xBmyAiF5/lXzMVLKRPNMujMJTtTxr5OTH8klsXp5ALW0
 +8vZtU/UNLVno7zj4EuiacoRrSgmq2Z4/g6iU70VbJjk/Qfmiaop5M88Bsx4uW6V4ep/
 hZR04RHN68zaIbGxeBLzxIvdkx7u9ebnRqlxBJPH12XIW96PGQCXEeJRlvqTERGuWAa1
 NG1b+GWArOjcjVgazVCSoyiZkz4oSozCDCJ/Y8AALVMqhMvm3LSh9pGvzUIHJKougfZ3
 koX5nTOdZyROhT9frYkZLXl/H7tINn9JT4ewBos/KXJbt+Wp/hauuk19iD+fJbwdki1P
 BHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729235062; x=1729839862;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fTUMTbd8vlTjCfY1mg31OjEcMp+/UHOeYnQ24prrp/c=;
 b=pNxz/Q6Tto7dYAPf3JuxhifPnXBuoDK2hEBPhwrRMxPOnD3BWm0LrlDwJbe1sIIML5
 evzCai5RmaqEBZjQRLnmzdJVwytC0kh8eayjoim5VOFZ+YXfyOf8uIWo3zR5CbSozwNT
 Gq6HnTAqDvfZF8TtQ0tLdfE/KTiFl3pK0iMgwvKYXmCcXpfkefz8RW/dfa6rDzLMEbfJ
 9NVATCZtWu4QO4Cb4znSNSRfGTTHVNr6lZ+kNBpT+KxCc/peQgO2euRvPoNFHbWAwGXp
 QhE2xiGhdggaMYVRz7rVeHfKe/bjCdf0wRzW/L4Cz8a5DwCiW5hNuN2YucuZqIeBhgfw
 KxIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjCZZMrdruesp8/SFOlXzihlR+lEt1RF30Ts3ga5e1RwX2lumEJAPdJOBPZ0PZEgvn6aYcoxPLBXZb@nongnu.org
X-Gm-Message-State: AOJu0YwDp5pTeGiMINWAAPQx+oZ00vQYTg22BOt0CUM+iEdz4y5pVB7S
 B6Sg7RcWRmV4gv6vBkvSOlo/GrxtZRLF5Yv4o4ZXOx1dgZTZ1dnh17W0Uz7Om/Q=
X-Google-Smtp-Source: AGHT+IE1iWiHboL/uSooklcKWFHLxOFfqDSKHXk14Lok53Xjs1iCarR/1PsoVXzVbZUI3xyKEHQbUw==
X-Received: by 2002:a05:6000:c81:b0:37d:52fc:edf1 with SMTP id
 ffacd0b85a97d-37eab6ec059mr836090f8f.58.1729235062029; 
 Fri, 18 Oct 2024 00:04:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf0861d2sm1097838f8f.56.2024.10.18.00.04.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2024 00:04:21 -0700 (PDT)
Message-ID: <1835dee0-b409-49fb-b804-d6f91d323bc5@rivosinc.com>
Date: Fri, 18 Oct 2024 09:04:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] target/riscv: Implement Ssdbltrp exception handling
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue
 <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
References: <20240925115808.77874-1-cleger@rivosinc.com>
 <20240925115808.77874-4-cleger@rivosinc.com>
 <CAKmqyKNYJjudgxA6z4dF5AP31NFn3ZOePMadjiVumja29oti5w@mail.gmail.com>
 <109e3df4-416a-48a3-ae0b-b2a92f11c893@rivosinc.com>
 <CAKmqyKPUrCw8xrTW_g5Sh3JWOkgjrkjCUNO28AXhGfFUfx1Y1A@mail.gmail.com>
 <bd7ed74e-0ed6-4868-a05d-71c0bcaf6278@rivosinc.com>
 <CAKmqyKPGKuCQ4-+2YAbqC6GSxvug-tq9UufBAQ0y_pT9skj5pA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAKmqyKPGKuCQ4-+2YAbqC6GSxvug-tq9UufBAQ0y_pT9skj5pA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 18/10/2024 04:25, Alistair Francis wrote:
> On Thu, Oct 17, 2024 at 5:45 PM Clément Léger <cleger@rivosinc.com> wrote:
>>
>>
>>
>> On 17/10/2024 06:29, Alistair Francis wrote:
>>> On Mon, Oct 14, 2024 at 5:43 PM Clément Léger <cleger@rivosinc.com> wrote:
>>>>
>>>>
>>>>
>>>> On 11/10/2024 05:22, Alistair Francis wrote:
>>>>> On Wed, Sep 25, 2024 at 9:59 PM Clément Léger <cleger@rivosinc.com> wrote:
>>>>>>
>>>>>> When the Ssdbltrp ISA extension is enabled, if a trap happens in S-mode
>>>>>> while SSTATUS.SDT isn't cleared, generate a double trap exception to
>>>>>> M-mode.
>>>>>>
>>>>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>>>>> ---
>>>>>>  target/riscv/cpu.c        |  2 +-
>>>>>>  target/riscv/cpu_bits.h   |  1 +
>>>>>>  target/riscv/cpu_helper.c | 47 ++++++++++++++++++++++++++++++++++-----
>>>>>>  3 files changed, 43 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>>>>> index cf06cd741a..65347ccd5a 100644
>>>>>> --- a/target/riscv/cpu.c
>>>>>> +++ b/target/riscv/cpu.c
>>>>>> @@ -284,7 +284,7 @@ static const char * const riscv_excp_names[] = {
>>>>>>      "load_page_fault",
>>>>>>      "reserved",
>>>>>>      "store_page_fault",
>>>>>> -    "reserved",
>>>>>> +    "double_trap",
>>>>>>      "reserved",
>>>>>>      "reserved",
>>>>>>      "reserved",
>>>>>> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>>>>>> index 3a5588d4df..5557a86348 100644
>>>>>> --- a/target/riscv/cpu_bits.h
>>>>>> +++ b/target/riscv/cpu_bits.h
>>>>>> @@ -699,6 +699,7 @@ typedef enum RISCVException {
>>>>>>      RISCV_EXCP_INST_PAGE_FAULT = 0xc, /* since: priv-1.10.0 */
>>>>>>      RISCV_EXCP_LOAD_PAGE_FAULT = 0xd, /* since: priv-1.10.0 */
>>>>>>      RISCV_EXCP_STORE_PAGE_FAULT = 0xf, /* since: priv-1.10.0 */
>>>>>> +    RISCV_EXCP_DOUBLE_TRAP = 0x10,
>>>>>>      RISCV_EXCP_SW_CHECK = 0x12, /* since: priv-1.13.0 */
>>>>>>      RISCV_EXCP_HW_ERR = 0x13, /* since: priv-1.13.0 */
>>>>>>      RISCV_EXCP_INST_GUEST_PAGE_FAULT = 0x14,
>>>>>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>>>>>> index 395d8235ce..69da3c3384 100644
>>>>>> --- a/target/riscv/cpu_helper.c
>>>>>> +++ b/target/riscv/cpu_helper.c
>>>>>> @@ -575,7 +575,9 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
>>>>>>          mstatus_mask |= MSTATUS_FS;
>>>>>>      }
>>>>>>      bool current_virt = env->virt_enabled;
>>>>>> -
>>>>>> +    if (riscv_env_smode_dbltrp_enabled(env, current_virt)) {
>>>>>> +        mstatus_mask |= MSTATUS_SDT;
>>>>>> +    }
>>>>>>      g_assert(riscv_has_ext(env, RVH));
>>>>>>
>>>>>>      if (current_virt) {
>>>>>> @@ -1707,6 +1709,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>>>>>>      CPURISCVState *env = &cpu->env;
>>>>>>      bool virt = env->virt_enabled;
>>>>>>      bool write_gva = false;
>>>>>> +    bool vsmode_exc;
>>>>>>      uint64_t s;
>>>>>>      int mode;
>>>>>>
>>>>>> @@ -1721,6 +1724,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>>>>>>          !(env->mip & (1 << cause));
>>>>>>      bool vs_injected = env->hvip & (1 << cause) & env->hvien &&
>>>>>>          !(env->mip & (1 << cause));
>>>>>> +    bool smode_double_trap = false;
>>>>>> +    uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
>>>>>>      target_ulong tval = 0;
>>>>>>      target_ulong tinst = 0;
>>>>>>      target_ulong htval = 0;
>>>>>> @@ -1837,13 +1842,35 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>>>>>>                  !async &&
>>>>>>                  mode == PRV_M;
>>>>>>
>>>>>> +    vsmode_exc = env->virt_enabled && (((hdeleg >> cause) & 1) || vs_injected);
>>>>>> +    /*
>>>>>> +     * Check double trap condition only if already in S-mode and targeting
>>>>>> +     * S-mode
>>>>>> +     */
>>>>>> +    if (cpu->cfg.ext_ssdbltrp && env->priv == PRV_S && mode == PRV_S) {
>>>>>> +        bool dte = (env->menvcfg & MENVCFG_DTE) != 0;
>>>>>> +        bool sdt = (env->mstatus & MSTATUS_SDT) != 0;
>>>>>> +        /* In VS or HS */
>>>>>> +        if (riscv_has_ext(env, RVH)) {
>>>>>> +            if (vsmode_exc) {
>>>>>> +                /* VS -> VS */
>>>>>> +                /* Stay in VS mode, use henvcfg instead of menvcfg*/
>>>>>> +                dte = (env->henvcfg & HENVCFG_DTE) != 0;
>>>>>> +            } else if (env->virt_enabled) {
>>>>>> +                /* VS -> HS */
>>>>>> +                dte = false;
>>>>>
>>>>> I don't follow why this is false
>>>>
>>>> Hi Alistair,
>>>>
>>>> It's indeed probably lacking some comments here. The rationale is that
>>>> if you are trapping from VS to HS, then at some point, you returned to
>>>> VS using a sret/mret and thus cleared DTE, so rather than checking the
>>
>> s/DTE/SDT
>>
>>>
>>> Why not just clear it at sret/mret? Instead of having this assumption
>>
>> It has been cleared but since registers were swapped to enter virt mode,
>> hypervisor SDT value is stored in mstatus_hs rather than mstatus. So I
>> could have wrote it this way:
>>
>> +            } else if (env->virt_enabled) {
>> +                /* VS -> HS */
>> +                sdt = (env->mstatus_hs & MSTATUS_SDT);
>>
>> Since this is always 0 better assume it is 0 (but should be sdt = 0
>> instead of dte = 0). But if you prefer using mstatus_hs for clarity, I
>> can use that of course.
> 
> We should use the register directly. That way if it is accidently not
> cleared it's easier to catch and it makes the code easier to read

Yes indeed. I did that in the next version.

Thanks,

Clément

> 
> Alistair
> 
>>
>> Clément
>>
>>>
>>> Alistair
>>>
>>>> value of mstatus_hs, just assume it is false.
>>>>
>>>> Thanks,
>>>>
>>>> Clément
>>>>
>>>>>
>>>>> Alistair
>>>>
>>


