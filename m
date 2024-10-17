Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F8ED2F7FA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 07:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1LCE-0004Np-G4; Thu, 17 Oct 2024 03:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1LCC-0004NE-PP
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 03:45:20 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1LCA-0003FZ-Es
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 03:45:20 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-431481433bdso6554545e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 00:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729151116; x=1729755916;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qphpJxHufUzK/7GodwFYxlaC6HLyfnmR0ImsDWYRXwY=;
 b=eNBbao/J+tLDihno/0DIH+xXk/47rnJ4jTcUyDUL5vsHSC0dJLMs80BLJ0TJCLYvp3
 91p5OlicFNV55mlEcU75mnZuAauSSYsNGlxrex+kYstdQH14CCcl/vibpiRNP9nZV4iI
 hKbyabM6RV3429y0/1GUX23U4KQ39vwDzizjk3VSkrlUMXP2EAPLfUaea/m9Alus6Hwr
 IzF/tz7BQXOAZ7VzxaXOsMSOJvt2OVVnbtXHRZsbKkYq1wVi1sV4tul0m2wPt3a3Pk8C
 bbSh2Hu3MFU3LkSws+nH/KP/VFbwACQnF/13VCKdve4nZ4Rb7MNFSLQ4N/tdsiQFRHGc
 UgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729151116; x=1729755916;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qphpJxHufUzK/7GodwFYxlaC6HLyfnmR0ImsDWYRXwY=;
 b=LUjwfSsIzCUawYxPW/f3qW2BI5yZ2Dmqr2ZmvBnKAV2xo5RYMOQm04fr3yt6FxSvs2
 5Lh1dB+sVUseMH2vQDTPBijDr0eCv9p/ckkwAkG1NqmC3WvLlwocaMzpjcHH3twXNsIG
 voIdqCc0MNJnxszPtQ2B5WYFvsFp9F6BtoF2GidAOF1rX56qr1L0/GCv13YbBfH4PblQ
 nBoQZF9xBIy+II6m/3j0KopU7K6PBbUZ1kNZFTPjuIq1NGu/4O/rQo2WRp9MZt9YSj4N
 zyrHwDLOHe0SAOSjqT5A596WqreygeEno24WBo0sHUEb3BSVB1geSF9EwYFkbwoQYolW
 nBIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAvmSVilwurGtSGw74MI37A57Ul0jOxC5K62pOxMXMDAYAPkM4AMZduSBvTwWTAPNa8Jh8hBYJjY79@nongnu.org
X-Gm-Message-State: AOJu0YxD/IPIwcPqLUTB/Ze8y+6yfd0APM7K66X9MI1wyDtStIef5lRH
 j9FmCq3BV7onWUAKrO2aZajgbzeyZGTzqgQ/UVhUFj87eskjMZbqRtgrAPUNMhc=
X-Google-Smtp-Source: AGHT+IEqoVSMfqpkocZDBu2Stauh7XLeQx4gMkQh9KpphoIort2jcLbNmuJo4wUBsBgmzfXnW2t4BA==
X-Received: by 2002:a05:600c:4f8e:b0:42f:8515:e490 with SMTP id
 5b1f17b1804b1-4311dea3cebmr209265805e9.5.1729151116057; 
 Thu, 17 Oct 2024 00:45:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa9090asm6384232f8f.57.2024.10.17.00.45.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 00:45:15 -0700 (PDT)
Message-ID: <bd7ed74e-0ed6-4868-a05d-71c0bcaf6278@rivosinc.com>
Date: Thu, 17 Oct 2024 09:45:14 +0200
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
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAKmqyKPUrCw8xrTW_g5Sh3JWOkgjrkjCUNO28AXhGfFUfx1Y1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x330.google.com
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



On 17/10/2024 06:29, Alistair Francis wrote:
> On Mon, Oct 14, 2024 at 5:43 PM Clément Léger <cleger@rivosinc.com> wrote:
>>
>>
>>
>> On 11/10/2024 05:22, Alistair Francis wrote:
>>> On Wed, Sep 25, 2024 at 9:59 PM Clément Léger <cleger@rivosinc.com> wrote:
>>>>
>>>> When the Ssdbltrp ISA extension is enabled, if a trap happens in S-mode
>>>> while SSTATUS.SDT isn't cleared, generate a double trap exception to
>>>> M-mode.
>>>>
>>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>>> ---
>>>>  target/riscv/cpu.c        |  2 +-
>>>>  target/riscv/cpu_bits.h   |  1 +
>>>>  target/riscv/cpu_helper.c | 47 ++++++++++++++++++++++++++++++++++-----
>>>>  3 files changed, 43 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>>> index cf06cd741a..65347ccd5a 100644
>>>> --- a/target/riscv/cpu.c
>>>> +++ b/target/riscv/cpu.c
>>>> @@ -284,7 +284,7 @@ static const char * const riscv_excp_names[] = {
>>>>      "load_page_fault",
>>>>      "reserved",
>>>>      "store_page_fault",
>>>> -    "reserved",
>>>> +    "double_trap",
>>>>      "reserved",
>>>>      "reserved",
>>>>      "reserved",
>>>> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>>>> index 3a5588d4df..5557a86348 100644
>>>> --- a/target/riscv/cpu_bits.h
>>>> +++ b/target/riscv/cpu_bits.h
>>>> @@ -699,6 +699,7 @@ typedef enum RISCVException {
>>>>      RISCV_EXCP_INST_PAGE_FAULT = 0xc, /* since: priv-1.10.0 */
>>>>      RISCV_EXCP_LOAD_PAGE_FAULT = 0xd, /* since: priv-1.10.0 */
>>>>      RISCV_EXCP_STORE_PAGE_FAULT = 0xf, /* since: priv-1.10.0 */
>>>> +    RISCV_EXCP_DOUBLE_TRAP = 0x10,
>>>>      RISCV_EXCP_SW_CHECK = 0x12, /* since: priv-1.13.0 */
>>>>      RISCV_EXCP_HW_ERR = 0x13, /* since: priv-1.13.0 */
>>>>      RISCV_EXCP_INST_GUEST_PAGE_FAULT = 0x14,
>>>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>>>> index 395d8235ce..69da3c3384 100644
>>>> --- a/target/riscv/cpu_helper.c
>>>> +++ b/target/riscv/cpu_helper.c
>>>> @@ -575,7 +575,9 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
>>>>          mstatus_mask |= MSTATUS_FS;
>>>>      }
>>>>      bool current_virt = env->virt_enabled;
>>>> -
>>>> +    if (riscv_env_smode_dbltrp_enabled(env, current_virt)) {
>>>> +        mstatus_mask |= MSTATUS_SDT;
>>>> +    }
>>>>      g_assert(riscv_has_ext(env, RVH));
>>>>
>>>>      if (current_virt) {
>>>> @@ -1707,6 +1709,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>>>>      CPURISCVState *env = &cpu->env;
>>>>      bool virt = env->virt_enabled;
>>>>      bool write_gva = false;
>>>> +    bool vsmode_exc;
>>>>      uint64_t s;
>>>>      int mode;
>>>>
>>>> @@ -1721,6 +1724,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>>>>          !(env->mip & (1 << cause));
>>>>      bool vs_injected = env->hvip & (1 << cause) & env->hvien &&
>>>>          !(env->mip & (1 << cause));
>>>> +    bool smode_double_trap = false;
>>>> +    uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
>>>>      target_ulong tval = 0;
>>>>      target_ulong tinst = 0;
>>>>      target_ulong htval = 0;
>>>> @@ -1837,13 +1842,35 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>>>>                  !async &&
>>>>                  mode == PRV_M;
>>>>
>>>> +    vsmode_exc = env->virt_enabled && (((hdeleg >> cause) & 1) || vs_injected);
>>>> +    /*
>>>> +     * Check double trap condition only if already in S-mode and targeting
>>>> +     * S-mode
>>>> +     */
>>>> +    if (cpu->cfg.ext_ssdbltrp && env->priv == PRV_S && mode == PRV_S) {
>>>> +        bool dte = (env->menvcfg & MENVCFG_DTE) != 0;
>>>> +        bool sdt = (env->mstatus & MSTATUS_SDT) != 0;
>>>> +        /* In VS or HS */
>>>> +        if (riscv_has_ext(env, RVH)) {
>>>> +            if (vsmode_exc) {
>>>> +                /* VS -> VS */
>>>> +                /* Stay in VS mode, use henvcfg instead of menvcfg*/
>>>> +                dte = (env->henvcfg & HENVCFG_DTE) != 0;
>>>> +            } else if (env->virt_enabled) {
>>>> +                /* VS -> HS */
>>>> +                dte = false;
>>>
>>> I don't follow why this is false
>>
>> Hi Alistair,
>>
>> It's indeed probably lacking some comments here. The rationale is that
>> if you are trapping from VS to HS, then at some point, you returned to
>> VS using a sret/mret and thus cleared DTE, so rather than checking the

s/DTE/SDT

> 
> Why not just clear it at sret/mret? Instead of having this assumption

It has been cleared but since registers were swapped to enter virt mode,
hypervisor SDT value is stored in mstatus_hs rather than mstatus. So I
could have wrote it this way:

+            } else if (env->virt_enabled) {
+                /* VS -> HS */
+                sdt = (env->mstatus_hs & MSTATUS_SDT);

Since this is always 0 better assume it is 0 (but should be sdt = 0
instead of dte = 0). But if you prefer using mstatus_hs for clarity, I
can use that of course.

Clément

> 
> Alistair
> 
>> value of mstatus_hs, just assume it is false.
>>
>> Thanks,
>>
>> Clément
>>
>>>
>>> Alistair
>>


