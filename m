Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2436AC369B4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 11:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4ef3-0006TS-1S; Tue, 15 Apr 2025 07:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4eeo-0006Km-3u
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 07:40:55 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4eej-0001F3-Kj
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 07:40:49 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so47388965e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 04:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744717243; x=1745322043; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zjaojkGvC9yxwmVWToRlyYoPKTlrQiiUVCbY+47rixA=;
 b=tDxWesA40XpaJVK/Ow/ohk5wQmm04QgGjk9ZJ33lQxEg27Bwe/6CK6H/fB4Qn3CrTb
 HLDe7MtJTGv9TU4ESjRHuk7NfKQV8HT+a5mHxVHuti5MynyrfDNntU3J06n8+T9Y4FRB
 WFr3U4EXwGtV6MzzdDmgyVP5F259lo2mCZ8bTctZuXI1ivgymf+31JLEJJDkAaBHD4Be
 BrVCoZE13lOCaDDsuE0FUD3UEOyP7jclaI7HTFTGlzRG/Eg6HsLuxzF+9yNLBXOyvWny
 1XP/gHytv3w7V1Y+kI7Qco7BmxA9WwwBnT58bqN2atvf8MQDQKcaXNwGVdJIMpt/1kju
 8tJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744717243; x=1745322043;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zjaojkGvC9yxwmVWToRlyYoPKTlrQiiUVCbY+47rixA=;
 b=DBgXAHI18l/YLHX8COchxj9X67gejbUdtwmaTqoeAkQOHYZbywHC/msyneFUVCIRRv
 /UqkCUczaof/D9qIaekoongoxz79t6OqiOWPjcuoqRr6vkX1g+2chWSE3TNO4vm0sMoA
 cysu+im57OSiRe1z/B+pZ9CmCNu6T9PoHaG0CsCVdSOgtrk2Z+Y4lbw8SBQ9GBU1hG6+
 rM6AR1qr8Ay858UQB/NQ1Fyd2HOjtMfu80gRnL2AzKahOymfX27NM75b4LBM5eXOuNpM
 X8EM+VJzKXKme5b/ogYI+5O5+83Ub4/c8fHJFTiedEAtZDab2ffaU8N50d8SllkvBiU3
 oRxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBJt8N3tKIpZZxWzKnjA4VCrbTGmBgVlnrlvRRCu522XuTorvnnxSo7JeVVI2CIBbw8gr0kUn23fZS@nongnu.org
X-Gm-Message-State: AOJu0YzM360nevfmmZeIRB40+pR9iVEmnU1Tf3N3fT0kZ/pSr1sGkTUC
 YNJ094ZsreCulWsfLa8kY5jMxD3xMOQVrCR/P+lwMW8HjzEyYtaKxuAzt94GqCA=
X-Gm-Gg: ASbGncsgNDSEVUjYNU/t4I2O+ORMQC+QIMtYVNFas+RWgoNnyOUEg92J6In4XiTRMWT
 KwCJn6ffbL5oYA5RCS0C0G117Roj9+fpUHwEaXpakOaNZqLCsCu6IsdPw3Rl6h7tH5S7MLhEZ/j
 XMJ7+RvouGfjgetJ/q66CQNAdhe4DkJ679r+di3P88cEMKyhdTwYuLmQA6CmOVq9VAIwkgwwoM1
 BE51QiSDLsr2cyzDaukbUZKRrUDewlaOBAuBoqAPKnn6ufQdDKyGvX9Rs+0Hk0iYuQxt8AHwTE/
 DlsPD5jk085h3RR2myt4JJGfSpxH/1A0EIUy6P9vj71NblQ+GXmLM7a4O/nm/wcRg9hL3hziCUJ
 6Ch7d2pmf0OXMuQ==
X-Google-Smtp-Source: AGHT+IFJdETXZ7NGwE5rlOlEQG3xjEKxz8lg8GeNuu4UHoC6FPuS6Rq0ajw9Zhf9lWhL6BOpm3YJ6A==
X-Received: by 2002:a05:600c:4fc8:b0:43d:745a:5a50 with SMTP id
 5b1f17b1804b1-43f3a959ed2mr141295545e9.19.1744717243418; 
 Tue, 15 Apr 2025 04:40:43 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f205ecf30sm208279585e9.1.2025.04.15.04.40.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 04:40:42 -0700 (PDT)
Message-ID: <416e68f4-bf12-4218-ae2d-0246cc8ea8ec@linaro.org>
Date: Tue, 15 Apr 2025 13:40:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] hw/riscv: fix PLIC hart topology configuration
 string when not getting CPUState correctly
To: Chao Liu <lc00631@tecorigin.com>, alistair23@gmail.com, palmer@dabbelt.com
Cc: alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 zqz00548@tecorigin.com
References: <cover.1744709888.git.lc00631@tecorigin.com>
 <07a97219e3f7e342c668d6772acc4c0a8eb4d4f3.1744709888.git.lc00631@tecorigin.com>
 <20250415111459.1443-1-lc00631@tecorigin.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415111459.1443-1-lc00631@tecorigin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15/4/25 13:14, Chao Liu wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> Hi,
>>
>> On 15/4/25 12:05, Chao Liu wrote:
>> > riscv_plic_hart_config_string() when getting CPUState via 
>> qemu_get_cpu()
>> > should be consistent with keeping sifive_plic_realize() by
>> > hartid_base + cpu_index.
>> > > For non-numa or single-cluster machines, hartid_base should be 0.
>> > > Also, to ensure that CPUState->cpu_index is set correctly, we need to
>> > update it with the value of mhartid during riscv_hart_realize().
>> > > Signed-off-by: Chao Liu <lc00631@tecorigin.com>
>> > Reviewed-by: zhaoqingze <zqz00548@tecorigin.com>
>> > ---
>> >   hw/riscv/boot.c            | 4 ++--
>> >   hw/riscv/microchip_pfsoc.c | 2 +-
>> >   hw/riscv/riscv_hart.c      | 1 +
>> >   hw/riscv/sifive_u.c        | 5 +++--
>> >   hw/riscv/virt.c            | 2 +-
>> >   include/hw/riscv/boot.h    | 2 +-
>> >   6 files changed, 9 insertions(+), 7 deletions(-)
>> > > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
>> > index 765b9e2b1a..d4c06e7530 100644
>> > --- a/hw/riscv/boot.c
>> > +++ b/hw/riscv/boot.c
>> > @@ -44,13 +44,13 @@ bool riscv_is_32bit(RISCVHartArrayState *harts)
>> >    * Return the per-socket PLIC hart topology configuration string
>> >    * (caller must free with g_free())
>> >    */
>> > -char *riscv_plic_hart_config_string(int hart_count)
>> > +char *riscv_plic_hart_config_string(int hart_base, int hart_count)
>> >   {
>> >       g_autofree const char **vals = g_new(const char *, hart_count 
>> + 1);
>> >       int i;
>> > >       for (i = 0; i < hart_count; i++) {
>> > -        CPUState *cs = qemu_get_cpu(i);
>> > +        CPUState *cs = qemu_get_cpu(hart_base + i);
>> >           CPURISCVState *env = &RISCV_CPU(cs)->env;
>> > >           if (kvm_enabled()) {
>> > diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
>> > index 9c846f9b5b..5269336346 100644
>> > --- a/hw/riscv/microchip_pfsoc.c
>> > +++ b/hw/riscv/microchip_pfsoc.c
>> > @@ -275,7 +275,7 @@ static void 
>> microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>> >                                   l2lim_mem);
>> > >       /* create PLIC hart topology configuration string */
>> > -    plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
>> > +    plic_hart_config = riscv_plic_hart_config_string(0, ms->smp.cpus);
>> > >       /* PLIC */
>> >       s->plic = sifive_plic_create(memmap[MICROCHIP_PFSOC_PLIC].base,
>> > diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
>> > index a55d156668..522e795033 100644
>> > --- a/hw/riscv/riscv_hart.c
>> > +++ b/hw/riscv/riscv_hart.c
>> > @@ -138,6 +138,7 @@ static bool 
>> riscv_hart_realize(RISCVHartArrayState *s, int idx,
>> >       }
>> > >       s->harts[idx].env.mhartid = s->hartid_base + idx;
>> > +    CPU(&s->harts[idx])->cpu_index = s->harts[idx].env.mhartid;
>>
>> Why do we need this particular change? CPUState::cpu_index isn't related
>> to RISC-V HART index, it is meant for the accelerators (KVM, TCG, ...),
>> and shouldn't be used by hw/ code.
>>
>> Otherwise the rest LGTM.
>>
>> Regards,
>>
>> Phil.
> 
> Thanks for the reply, here is an update to cpu_index, mainly for 
> consistency
> with the following:
> 
> static void sifive_plic_realize(DeviceState *dev, Error **errp)
> {
>     ...
> 
>     for (i = 0; i < s->num_harts; i++) {
>         /* this get cpu with hartid_base + i */        RISCVCPU *cpu = 
> RISCV_CPU(qemu_get_cpu(s->hartid_base + i));

OK I see. Pre-existing design issue, qemu_get_cpu() shouldn't exist.
Not your fault. Normally indexed cores belong to some array / cluster.

I'd assume PLIC to be wired to a fixed set of CPUs, not to some
unrelated random index. I'd expect the PLIC model to take either
an CPUCluster as link property, or a set of HART link properties,
then iterates over these internal references. Not to fish it out
elsewhere.

Again, pre-existing and not related to what you try to achieve.


Please add a /* Set CPU index for i.e. sifive_plic_realize() */
before the assignment in riscv_hart_realize(). With that:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Regards,

Phil.

>         if (riscv_cpu_claim_interrupts(cpu, MIP_SEIP) < 0) {
>             error_setg(errp, "SEIP already claimed");
>             return;
>         }
>     }
> 
>     msi_nonbroken = true;
> }
> 
> But when adding the cpu to the global chain table, the cpu_index starts 
> at 0.
> 
> Maybe there is a better way to handle this here?
> 
> For example:
> 
> 1. When updating the cpu_index in the upper level, we can set a base id, 
> and by
> setting this base id, we can update the cpu_index indirectly.
> 
> or
> 
> 2. Modify sifive_plic_realize() to iterate over cpu's to avoid getting them
> by id.
> 
> I haven't thought of a better way to handle this at the moment,
> so we can discuss it further
> 
> -- 
> Regards,
> Chao


