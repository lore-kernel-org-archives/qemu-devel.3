Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BDDC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 12:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9NaC-0003kn-DJ; Mon, 28 Apr 2025 08:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9NaA-0003h3-Tm
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:27:34 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9Na8-0007Qx-Rd
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:27:34 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b0db0b6a677so4708649a12.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 05:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745843251; x=1746448051; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LHD5Hw3xe7D3CUfCU4oZp5+98TPBTV4XN9wlZ0CFwyY=;
 b=DgHApvB4bpUwcDSthzK9zSd/BfrEPMwzIO6Z4/X+Son6pOs3TQ+g7bc9hIvymYZhUP
 C1wbT2s8o1Mm3S4dp3x9I+6vkf+h2+XeuSaTJ9kAEdwBCrqYR02Yks/BO11IX9uUEdkS
 68rYyhOgPFrZO1dIJt99NOtYAwxOpkiwsq5TGOg9a/Wqd5NFbJApW5UF61DBHapw0jnO
 6dw+MnP+XYqUNqAB0nvWOjJKz9nGLHA1doDhZjVPyUBAt6KOPvGVpE0MEcdZ/a2FpgGY
 jlZ9+b8R7I6+D6mu9uDKYw9HJi/P5bQ1aVS1jGzG7P3NivhTMPmXcRFFy8Pb63aBxYAf
 G+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745843251; x=1746448051;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LHD5Hw3xe7D3CUfCU4oZp5+98TPBTV4XN9wlZ0CFwyY=;
 b=HsZYEuMuR6BKqjHuauNEr8wRZJg2x0wEUA0xmpn8WMo7BJkWPFTsnSBL3Yh44FEpWu
 QJknsZ0THOJCtECMU7e9F4UXDCNd9JjGtCU8UJ/2HUfLidOC2+Jsqod9j3NhWonkuMoh
 U6/llJKGUitqQS/YTFFdPAx7iGWNRicthOdYsUVwE4yEyzf7MraqJ31jaP9BIhXLW//J
 JTYD/b4gFYLr/miTJH5y4I8EUYA9+Ekkci0oyERYg3xn+F0HA9ekP6KbzUtQRiRAQHYb
 5JSOhlLUEqnB2O5iUUzmDBReDTzHJu1GHeCdwHThM15pb9h8uRJCctQKFQuZXPu7fHUa
 H5sA==
X-Gm-Message-State: AOJu0YxUR+OZLfVy4jTEyp2tw+iAIgMIWGiJ1nOJxG+3hzoy/y9ALLs0
 Pgf6yv+CZjoh6a4RRoy73VUhtXFj3AFtBKXpi7BNb2k+klwvpaT/W/j+QccodUU=
X-Gm-Gg: ASbGncu2c0XhcaC1BgJsQCcitNrAOLME4mZIGlf5fI4ScSR8stpajIFVRE3CSRGog0X
 FrA3/QE5PoPR7p13BZVkQkwvwzrHrSrPUsGiOzFrGNJHhwaqGFvhCzDt12hZt24gBKkYgKO5Fw7
 20I8tpmvoH5fMf16UACs++P53cQnSjW6fFqXmI3ucBL1gocuoYYXpJ/44ljETBSO7Lfyr7LIGQa
 qJhNfHyj2QEkWAbVBIzg6aBu5EcBYMl2rsOVcY2pP4NefmEQq7MPmMHRqA8jCH9DRZRCpsAaB2N
 OTW9520dpyRrUZAYcKWHZ0TTInZ09ZkW8ahSINRGus9SBLVbSJ0VrTQ=
X-Google-Smtp-Source: AGHT+IF0ce7SPg+TpOh+niFf/8FSQc0f+snrRT9SuLCyoj3Wvep0JX1GgAtr5XL2838C8jYvM9mGvw==
X-Received: by 2002:a05:6a21:10f:b0:1f5:79c4:5da6 with SMTP id
 adf61e73a8af0-2045b6984f2mr14792141637.5.1745843250999; 
 Mon, 28 Apr 2025 05:27:30 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15faded634sm7146869a12.73.2025.04.28.05.27.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 05:27:30 -0700 (PDT)
Message-ID: <8a2ea33b-e867-4a72-b36c-012c11e428ee@ventanamicro.com>
Date: Mon, 28 Apr 2025 09:27:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] target/riscv: widen scounteren to target_ulong
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20250425160203.2774835-1-dbarboza@ventanamicro.com>
 <20250425160203.2774835-9-dbarboza@ventanamicro.com>
 <20250427-e13fa003b1bfad48e17bcee9@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250427-e13fa003b1bfad48e17bcee9@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52c.google.com
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



On 4/27/25 2:59 AM, Andrew Jones wrote:
> On Fri, Apr 25, 2025 at 01:02:02PM -0300, Daniel Henrique Barboza wrote:
>> We want to support scounteren as a KVM CSR. The KVM UAPI defines every
>> CSR size as target_ulong, and our env->scounteren is fixed at 32 bits.
>>
>> The other existing cases where the property size does not match the KVM
>> reg size happens with uint64_t properties, like 'mstatus'. When running
>> a 32 bit CPU we'll write a 32 bit 'sstatus' KVM reg into the 64 bit
>> 'mstatus' field. As long as we're consistent, i.e. we're always
>> reading/writing the same words, this is ok.
>>
>> For scounteren, a KVM guest running in a 64 bit CPU will end up writing
>> a 64 bit reg in a 32 bit field. This will have all sort of funny side
>> effects in the KVM guest that we would rather avoid.
>>
>> Increase scounteren to target_ulong to allow KVM to read/write the
>> scounteren CSR without any surprises.
>>
>> Aside from bumping the version of the RISCVCPU vmstate no other
>> behavioral changes are expected.
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/cpu.h     | 9 ++++++++-
>>   target/riscv/machine.c | 6 +++---
>>   2 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index f5a60d0c52..66d4ddfcb4 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -400,7 +400,14 @@ struct CPUArchState {
>>        */
>>       bool two_stage_indirect_lookup;
>>   
>> -    uint32_t scounteren;
>> +    /*
>> +     * scounteren is supposed to be an uint32_t, as the spec
>> +     * says. We're using a target_ulong instead because the
>> +     * scounteren KVM CSR is defined as target_ulong in
>> +     * kvm_riscv_csr, and we want to avoid having to deal
>> +     * with an ulong reg being read/written in an uint32_t.
>> +     */
>> +    target_ulong scounteren;
> 
> I'm having second thoughts about this. It seems like it should be
> avoidable with the use of an intermediary buffer (which we already
> have -- the uint64_t reg) and with tracking the size of the env state
> by capturing the size with the new macro used to build the array.
> Then,

I think I just understood what you mean. You suggested a more generic
approach instead of handling just the scounteren case.

To handle this in a more generic way we can store the size of the env
var using that macro magic you suggested in v1, and then we can handle
all cases where we have a 32 bit env in QEMU exactly like we would handle
scounteren.

I'll do a new version with this change in the patch that introduces
scounteren. Thanks,


Daniel

> 
> for reading:
>   1. read the kvm reg into a buffer of the size kvm says it is
>   2. only write the bytes we can store from the buffer into the env state,
>      using the size field to know how many that is
> 
> for writing:
>   1. put the env state into a buffer of the size kvm says the register is,
>      ensuring any upper unused bytes of the buffer are zero
>   2. write the buffer to kvm
> 
> Thanks,
> drew
> 
>>       uint32_t mcounteren;
>>   
>>       uint32_t scountinhibit;
>> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
>> index df2d5bad8d..f3477e153b 100644
>> --- a/target/riscv/machine.c
>> +++ b/target/riscv/machine.c
>> @@ -401,8 +401,8 @@ static const VMStateDescription vmstate_ssp = {
>>   
>>   const VMStateDescription vmstate_riscv_cpu = {
>>       .name = "cpu",
>> -    .version_id = 10,
>> -    .minimum_version_id = 10,
>> +    .version_id = 11,
>> +    .minimum_version_id = 11,
>>       .post_load = riscv_cpu_post_load,
>>       .fields = (const VMStateField[]) {
>>           VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
>> @@ -445,7 +445,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>>           VMSTATE_UINTTL(env.mtval, RISCVCPU),
>>           VMSTATE_UINTTL(env.miselect, RISCVCPU),
>>           VMSTATE_UINTTL(env.siselect, RISCVCPU),
>> -        VMSTATE_UINT32(env.scounteren, RISCVCPU),
>> +        VMSTATE_UINTTL(env.scounteren, RISCVCPU),
>>           VMSTATE_UINT32(env.mcounteren, RISCVCPU),
>>           VMSTATE_UINT32(env.scountinhibit, RISCVCPU),
>>           VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),
>> -- 
>> 2.49.0
>>


