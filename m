Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC41CFC500
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 07:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Fjh-0002UZ-0a; Mon, 14 Oct 2024 03:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t0Fjd-0002UC-PA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 03:43:21 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t0Fjb-0000Q5-9G
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 03:43:21 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5366fd6fdf1so4473167e87.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 00:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728891797; x=1729496597;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s3i3Xk7l0Jo7YGniRT7vjQA26Gcljvw+BcTLb1raQMo=;
 b=ZW7OXCyykJG9+LfL9WNXtR13+l8Zobc/HGw4zUdZrBSDdD5LugkEEHty+rbVBY/4gD
 YIa56LNz4hwOonQwqXlZHkP6BEwSNKAQNKy6f5VD2HkRrkcCvIRUFObjt0VPFMjAV1nI
 7aG0O3vZ5x7QjnoON1DFFR2C5zM8Ub2B4pCAtuTBrENhvdjIKwM/UX31g4ucX702Btpp
 2nBwhqNloCtMe3C9nhL8wkLOVHvY6wmA9iZOjA9Lwccl9r4VmTQMgROSYckRNR6veQNS
 fWRO+H4u/uew+PY1mPk35GrkLutCPTnXyIncX2Z84tEpWI02tvnKN8dzpcykae5FEIqC
 2tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728891797; x=1729496597;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s3i3Xk7l0Jo7YGniRT7vjQA26Gcljvw+BcTLb1raQMo=;
 b=jDB9WEMyxr/yNyxqsgP2O/L8qeuuEr1EWS0tuSbafA546n0uLhxjw3H3VH7AeKdDFu
 kTGAxCi9XLPrYQojpo/RrYTwjKf/RKe+NlGXFytWfkhB8xhsDanGm2Ge4YdRLYbQh+l8
 hPDjaku64308EVRvNXp/WYc1qd7GM8JSAp8InscB2YtL4GuDqdCljfsuJVdKZUPdKciS
 TgD3Y3xhEoAsKJhLTlNzGDGDBmRQbKFbqIcRyZGaCF7Oxkvegm+IWNBgWcyYH7erPxqs
 c0Fp4UZqmF5brLv/daLepadLWXu3DW5rUOu/Lff/X6jFIWCrSYRMThbrbqKzfCdKQTKr
 CTzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPqCsm3o0XvuK8J4KQcYL3KDIUGiEzUx2nXR1MLg3e99PQAt1ET7H8eAQD+1mZOJe/1Pl3WQbS1tEA@nongnu.org
X-Gm-Message-State: AOJu0YyzH+fypiwrdcrXazzS1TmDzVfOgVQeT1o3s2xHPQKLyTTJyl92
 X92hvFn2MzAN8yxcsk5B2Kzuvn/vUfmyRQCqav2kC4c7f+uUKlDHi50IVEKMdRY=
X-Google-Smtp-Source: AGHT+IGIQpBBQqH5AcDJePgrQteGEzkcdXHW4692kU7IyG+QQd2TgXTW3d3wBQ5ZVKyj1SHVe3FacQ==
X-Received: by 2002:a05:6512:3c95:b0:533:44e7:1b2a with SMTP id
 2adb3069b0e04-539da54792amr5038615e87.40.1728891796957; 
 Mon, 14 Oct 2024 00:43:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431183568dfsm112737435e9.36.2024.10.14.00.43.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 00:43:16 -0700 (PDT)
Message-ID: <109e3df4-416a-48a3-ae0b-b2a92f11c893@rivosinc.com>
Date: Mon, 14 Oct 2024 09:43:14 +0200
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
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAKmqyKNYJjudgxA6z4dF5AP31NFn3ZOePMadjiVumja29oti5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=cleger@rivosinc.com; helo=mail-lf1-x12a.google.com
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



On 11/10/2024 05:22, Alistair Francis wrote:
> On Wed, Sep 25, 2024 at 9:59 PM Clément Léger <cleger@rivosinc.com> wrote:
>>
>> When the Ssdbltrp ISA extension is enabled, if a trap happens in S-mode
>> while SSTATUS.SDT isn't cleared, generate a double trap exception to
>> M-mode.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  target/riscv/cpu.c        |  2 +-
>>  target/riscv/cpu_bits.h   |  1 +
>>  target/riscv/cpu_helper.c | 47 ++++++++++++++++++++++++++++++++++-----
>>  3 files changed, 43 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index cf06cd741a..65347ccd5a 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -284,7 +284,7 @@ static const char * const riscv_excp_names[] = {
>>      "load_page_fault",
>>      "reserved",
>>      "store_page_fault",
>> -    "reserved",
>> +    "double_trap",
>>      "reserved",
>>      "reserved",
>>      "reserved",
>> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>> index 3a5588d4df..5557a86348 100644
>> --- a/target/riscv/cpu_bits.h
>> +++ b/target/riscv/cpu_bits.h
>> @@ -699,6 +699,7 @@ typedef enum RISCVException {
>>      RISCV_EXCP_INST_PAGE_FAULT = 0xc, /* since: priv-1.10.0 */
>>      RISCV_EXCP_LOAD_PAGE_FAULT = 0xd, /* since: priv-1.10.0 */
>>      RISCV_EXCP_STORE_PAGE_FAULT = 0xf, /* since: priv-1.10.0 */
>> +    RISCV_EXCP_DOUBLE_TRAP = 0x10,
>>      RISCV_EXCP_SW_CHECK = 0x12, /* since: priv-1.13.0 */
>>      RISCV_EXCP_HW_ERR = 0x13, /* since: priv-1.13.0 */
>>      RISCV_EXCP_INST_GUEST_PAGE_FAULT = 0x14,
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index 395d8235ce..69da3c3384 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -575,7 +575,9 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
>>          mstatus_mask |= MSTATUS_FS;
>>      }
>>      bool current_virt = env->virt_enabled;
>> -
>> +    if (riscv_env_smode_dbltrp_enabled(env, current_virt)) {
>> +        mstatus_mask |= MSTATUS_SDT;
>> +    }
>>      g_assert(riscv_has_ext(env, RVH));
>>
>>      if (current_virt) {
>> @@ -1707,6 +1709,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>>      CPURISCVState *env = &cpu->env;
>>      bool virt = env->virt_enabled;
>>      bool write_gva = false;
>> +    bool vsmode_exc;
>>      uint64_t s;
>>      int mode;
>>
>> @@ -1721,6 +1724,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>>          !(env->mip & (1 << cause));
>>      bool vs_injected = env->hvip & (1 << cause) & env->hvien &&
>>          !(env->mip & (1 << cause));
>> +    bool smode_double_trap = false;
>> +    uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
>>      target_ulong tval = 0;
>>      target_ulong tinst = 0;
>>      target_ulong htval = 0;
>> @@ -1837,13 +1842,35 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>>                  !async &&
>>                  mode == PRV_M;
>>
>> +    vsmode_exc = env->virt_enabled && (((hdeleg >> cause) & 1) || vs_injected);
>> +    /*
>> +     * Check double trap condition only if already in S-mode and targeting
>> +     * S-mode
>> +     */
>> +    if (cpu->cfg.ext_ssdbltrp && env->priv == PRV_S && mode == PRV_S) {
>> +        bool dte = (env->menvcfg & MENVCFG_DTE) != 0;
>> +        bool sdt = (env->mstatus & MSTATUS_SDT) != 0;
>> +        /* In VS or HS */
>> +        if (riscv_has_ext(env, RVH)) {
>> +            if (vsmode_exc) {
>> +                /* VS -> VS */
>> +                /* Stay in VS mode, use henvcfg instead of menvcfg*/
>> +                dte = (env->henvcfg & HENVCFG_DTE) != 0;
>> +            } else if (env->virt_enabled) {
>> +                /* VS -> HS */
>> +                dte = false;
> 
> I don't follow why this is false

Hi Alistair,

It's indeed probably lacking some comments here. The rationale is that
if you are trapping from VS to HS, then at some point, you returned to
VS using a sret/mret and thus cleared DTE, so rather than checking the
value of mstatus_hs, just assume it is false.

Thanks,

Clément

> 
> Alistair


