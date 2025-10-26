Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA7BCCD1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Oct 2025 00:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCokr-0000to-5n; Sat, 25 Oct 2025 20:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vCokp-0000tX-Jm
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 20:37:03 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vCokn-0000qZ-LW
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 20:37:03 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-27d3540a43fso35048885ad.3
 for <qemu-devel@nongnu.org>; Sat, 25 Oct 2025 17:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1761439017; x=1762043817; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y/zbNch+hHTr4ko2O/nzCx6Er5hyTQ8TC5nOt8MbHa0=;
 b=kqMgwSGB8TVI39w0N+SlKaxrwXYGT48bcVOytmoPKqQwzMuxwBafL9YfKY/zsyAYGA
 beki/eRzOTp8rRbiQSoOhcoeIpvTbuWVQjRFts8N6swtpEBPQZ3U39Ob5lVmjxrgE5Bb
 1mITB+VNDw+RThKnr7MCU1lDIQmwmHrEtoKLsjpf0df35rbjKEbPbQT7iCDbEedkUTru
 GAL9PTv2/hafJuKmDMRx2vBGMNoTCCW+1WQKxAB6Lj+nQ1gKqKSUDq23oWPUfEya4PS7
 G4sCK8rSmIgslbdSVWzUOX9Z5pUVUuw9awlZ/8aDmBY+vgjcvPGVXlIaSlvj2oShEfHF
 DyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761439017; x=1762043817;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y/zbNch+hHTr4ko2O/nzCx6Er5hyTQ8TC5nOt8MbHa0=;
 b=j83n6OXONnaN1Bx+8oZGgL9kaR/PaZ7BzcchtU3OYTrIpNW6DVevQla/IkbTdLvX0F
 HNUEFluEumRH6lJe1JQVh8sx2HkwtvEbX8XEeY3aeS/GRiGsmljUOf2EMMjdB8pwDt6h
 oKZaEPotH/otUUyJ9et1xiobjGVY9szTOs5+a719XeJCdHDR0zc53v+npfCAo+EOpDFT
 ByYp9PUEhgVkYzgn5MzQGZnp5pxMnwOVuIEtkfcTa07yNKw2MsW/BErQ7Yo9C0ODexix
 fH812TnmbmDDhQkrEkvfhMWKDTaVgRTQdw88ZMbOjgDrpu7yfX9+xNh5J1r4zJjnQeTJ
 EnxQ==
X-Gm-Message-State: AOJu0Yyin1nhDbq62snMOQOGUpNSEReZqqCSKrexgO3ErUsahoRom9uA
 VQqKZvBqBPDreQyVqiJ9vcYrSvYl8dWP2Dd5V7taaaIdnC/27bbk66uulaIlEM2S9tE=
X-Gm-Gg: ASbGnctPEWebDnSHFabAf21IMuFVSCmZnwoQBzdTgRZf95z/3Nc51Zl8CHYou4q4PLR
 q7d5MbVCOvDAcWitEQlLFYHyNNO04dyeFv0ZwIna9nGojXwEYBO8KFje/Z7v0RKSQNyQ260dQqP
 JXxqLgSJIarZyCod6e5FBZAzxQdjIZgLJ4jid+zvbvY8QNldIMjie02d6hADcDyemmGahtvKLOp
 pMYzLlPm7JGw9+3e6zbBJAO7kQO4q5flIegW7nyEDv7QyEGyyqo5xlqVBqvtw9AFbLL4lvBALzA
 xKBrEcaWtDnCDQ95nR2zseTF2Rtk9isGMaFjF0XbhEmttiHfNf2hQrB7zKkuh7cP7dtZwCsHle0
 YitKiMJYz+B7/hZgnBPbJXGdpRh0aJp2HLHGGy2FvFL9Ert/d+/gqoYCYqJJy+6+MJsLan82sth
 3ErODGFtgSeUuG
X-Google-Smtp-Source: AGHT+IGilCZdpWMe1PnDZBrkhmuVtYevTJmLppOP6O3jXiOOT+CnpFmuqReTkh3PZEHMFlqR2oSCMw==
X-Received: by 2002:a17:902:c942:b0:26a:8171:daf7 with SMTP id
 d9443c01a7336-290c9cbc096mr57387485ad.16.1761439017491; 
 Sat, 25 Oct 2025 17:36:57 -0700 (PDT)
Received: from [192.168.68.110] ([189.38.141.22])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498cf3bbcsm34821945ad.15.2025.10.25.17.36.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Oct 2025 17:36:57 -0700 (PDT)
Message-ID: <c01b9130-e706-4f56-b67a-653130f7ee01@ventanamicro.com>
Date: Sat, 25 Oct 2025 21:36:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 47/56] target/riscv/kvm: add scounteren CSR
To: Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell
 <peter.maydell@linaro.org>, alistair23@gmail.com
Cc: qemu-devel@nongnu.org, Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
 <20250519040555.3797167-48-alistair.francis@wdc.com>
 <CAFEAcA_6zma2=nsBWB7ebb35Jt1cNAChiMG0xnkT3WPEY8csiw@mail.gmail.com>
 <f9c1c814-c083-4c9b-831c-4cd5ce162002@ventanamicro.com>
 <7fe9bec3-43f5-4d28-9efa-5d499335baf8@tls.msk.ru>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <7fe9bec3-43f5-4d28-9efa-5d499335baf8@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
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



On 10/25/25 1:45 PM, Michael Tokarev wrote:
> On 10/24/25 19:17, Daniel Henrique Barboza wrote:
>>
>>
>> On 10/24/25 10:43 AM, Peter Maydell wrote:
>>> On Mon, 19 May 2025 at 05:25, <alistair23@gmail.com> wrote:
>>>>
>>>> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>>>
>>>> Add support for the scounteren KVM CSR. Note that env->scounteren is a
>>>> 32 bit and all KVM CSRs are target_ulong, so scounteren will be capped
>>>> to 32 bits read/writes.
>>>>
>>>> Reported-by: Andrew Jones <ajones@ventanamicro.com>
>>>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>>> Message-ID: <20250429124421.223883-10-dbarboza@ventanamicro.com>
>>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>>> ---
>>>>   target/riscv/kvm/kvm-cpu.c | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>>>> index ca171d5457..82f9728636 100644
>>>> --- a/target/riscv/kvm/kvm-cpu.c
>>>> +++ b/target/riscv/kvm/kvm-cpu.c
>>>> @@ -251,6 +251,7 @@ static KVMCPUConfig kvm_csr_cfgs[] = {
>>>>       KVM_CSR_CFG("stval",      stval,      RISCV_CSR_REG(stval)),
>>>>       KVM_CSR_CFG("sip",        mip,        RISCV_CSR_REG(sip)),
>>>>       KVM_CSR_CFG("satp",       satp,       RISCV_CSR_REG(satp)),
>>>> +    KVM_CSR_CFG("scounteren", scounteren, RISCV_CSR_REG(scounteren)),
>>>>       KVM_CSR_CFG("senvcfg",    senvcfg,    RISCV_CSR_REG(senvcfg)),
>>>>   };
>>>>
>>>> @@ -701,6 +702,7 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
>>>>       env->stval = 0;
>>>>       env->mip = 0;
>>>>       env->satp = 0;
>>>> +    env->scounteren = 0;
>>>>       env->senvcfg = 0;
>>>>   }
>>>
>>> Hi -- this came up in a conversation on IRC. Does this new
>>> CPU state field need migration support adding in machine.c ?
>>
>>
>> Hmm, I believe it already has, doesn't it?
>>
>> target/riscv/machine.c:
>>
>>
>> const VMStateDescription vmstate_riscv_cpu = {
>>      .name = "cpu",
>>      .version_id = 10,
>>      .minimum_version_id = 10,
>>      .post_load = riscv_cpu_post_load,
>>      .fields = (const VMStateField[]) {
>>          VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
>> (...)
>>         VMSTATE_UINT32(env.scounteren, RISCVCPU),  <-------
>>
>>
>> Or are you referring to something else like post_load callbacks and so on? Thanks,
> 
> In this case, can or should this change be picked up for
> qemu-stable (in this case, 10.0.x)?
> 
> Not that it's hugely important, but some subsequent patches
> in this area would apply cleanly if I'll pick this one and
> also senvcfg one (86b8c3821496).

Go ahead, but to pick those you'll need to also pick these:

[PULL 44/56] target/riscv/kvm: do not read unavailable CSRs

[PULL 46/56] target/riscv/kvm: read/write KVM regs via env size

Otherwise you might introduce bugs. Thanks,


Daniel


> 
> Thanks,
> 
> /mjt


