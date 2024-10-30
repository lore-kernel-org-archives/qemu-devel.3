Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951FAD5CCBC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 15:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6AZm-0005Tl-SG; Wed, 30 Oct 2024 11:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1t6AZh-0005Sp-Mx
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:25:34 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1t6AZf-0002J5-Rx
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:25:33 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37d70df0b1aso5223857f8f.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 08:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1730301929; x=1730906729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:subject:autocrypt:from
 :content-language:references:cc:to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=WIsyejX7yKFTHz+LOKycu0zBu+Wym0DeOxYfl7qjQrI=;
 b=BiB0i+5NMAadMnlC8U6xCeTGmqzug2PzOH6WUhj4vFq9TIdIhjje02TkKNjzkMU/gC
 otUBRAT6Vm7fNRwZkBQ/5FkyjqPRoNEFz0nwm2Hyo/YwBaUyW4nHWv7Onfg9R9lP55dw
 7THWtDmmZcCbYCfSC9qR8P+4eONz2qZLuZO0XBu36yKntOma6Sn6bNG97I1RhMqrmDYT
 mwqViwRX2wAI+uZTp/YJfkhNWoWYgv0innJBVotY/o1W8OU5PjKGbucvV+skQF1YY85L
 ULAdegwprFHcQ2NsTij6RMRL5qtex2OuGNBtkz/idn76Dmhex2fqmZ1qF68qy6gxJ+L7
 WI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730301929; x=1730906729;
 h=content-transfer-encoding:in-reply-to:subject:autocrypt:from
 :content-language:references:cc:to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WIsyejX7yKFTHz+LOKycu0zBu+Wym0DeOxYfl7qjQrI=;
 b=mdnainE7NJbyb5oxHIXUX9u8Z0TcEG0mflMcDIVom5BPUm7NcvixjP7IAd1MjVE3vY
 F9MlngIx8rTeS+XYQuFBDcw3rAB7AqeCUWz0FvBvk0kJYZOWtVoyYRV9nTYExVofiQKW
 ogZPAzJEuNonpoOSpVj+uAy2cZpjttycSWnGNzpShpZDXLneTXDqN0kzrAAzzdr51oSs
 PWhgva32419S6/VrCgrUrIfuM4fpAcJRTPcBcsWwDx7dIkRyQZ4wasdSWTwDKMYbvh5+
 /b2pj5pq6ctIfgHQWpUM9JCTtavKi4R9EcMDYT/wjXQzO2PeGQLH7Nu6OTbsntXpsyLZ
 aBmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIXgrlRrmdMl5wWCPoaYvpCg0o48HVRDwca4H2ThWRDIQgwCt68oHeCtT/Dp2XF+tU/+aArGwV3aV+@nongnu.org
X-Gm-Message-State: AOJu0Yx1iX7azJU1sDucRRt+mUioKqVK+OU2KfJxVUvoQL7LcnGPKI2G
 aHRGF/kloQcplEp/IybhzAs6MDOuyz3yKVLXBkj4QKT3PJ4xwWJ2nSGQJeQJNT4=
X-Google-Smtp-Source: AGHT+IGvv/sfbd7b82GCTgYbeRsJu1VWswjn9AQB1PFY2N5JrAZ6hmAExCwXvcx7V2DDwS9ag8J9Zg==
X-Received: by 2002:adf:fb48:0:b0:37d:49cd:7b46 with SMTP id
 ffacd0b85a97d-38061158f51mr11183026f8f.27.1730301929213; 
 Wed, 30 Oct 2024 08:25:29 -0700 (PDT)
Received: from [192.168.0.124] ([212.69.42.53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b91f43sm15724218f8f.92.2024.10.30.08.25.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 08:25:28 -0700 (PDT)
Message-ID: <96e7601d-14aa-4741-8f6a-ae4a1c397a44@embecosm.com>
Date: Wed, 30 Oct 2024 15:25:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>
References: <20241029194348.59574-1-paolo.savini@embecosm.com>
 <20241029194348.59574-3-paolo.savini@embecosm.com>
 <7a046c99-c4e7-4395-8dc9-9139e9bfba06@linaro.org>
Content-Language: en-US
From: Paolo Savini <paolo.savini@embecosm.com>
Autocrypt: addr=paolo.savini@embecosm.com; keydata=
 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
Subject: Re: [RFC v4 2/2] target/riscv: rvv: improve performance of RISC-V
 vector loads and stores on large amounts of data.
In-Reply-To: <7a046c99-c4e7-4395-8dc9-9139e9bfba06@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wr1-x430.google.com
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

Thanks for the review Richard.

On 10/30/24 11:40, Richard Henderson wrote:
> On 10/29/24 19:43, Paolo Savini wrote:
>> This patch optimizes the emulation of unit-stride load/store RVV 
>> instructions
>> when the data being loaded/stored per iteration amounts to 16 bytes 
>> or more.
>> The optimization consists of calling __builtin_memcpy on chunks of 
>> data of 16
>> bytes between the memory address of the simulated vector register and 
>> the
>> destination memory address and vice versa.
>> This is done only if we have direct access to the RAM of the host 
>> machine,
>> if the host is little endiand and if it supports atomic 128 bit memory
>> operations.
>>
>> Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
>> ---
>>   target/riscv/vector_helper.c    | 17 ++++++++++++++++-
>>   target/riscv/vector_internals.h | 12 ++++++++++++
>>   2 files changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
>> index 75c24653f0..e1c100e907 100644
>> --- a/target/riscv/vector_helper.c
>> +++ b/target/riscv/vector_helper.c
>> @@ -488,7 +488,22 @@ vext_group_ldst_host(CPURISCVState *env, void 
>> *vd, uint32_t byte_end,
>>       }
>>         fn = fns[is_load][group_size];
>> -    fn(vd, byte_offset, host + byte_offset);
>> +
>> +    /* __builtin_memcpy uses host 16 bytes vector loads and stores 
>> if supported.
>> +     * We need to make sure that these instructions have guarantees 
>> of atomicity.
>> +     * E.g. x86 processors provide strong guarantees of atomicity 
>> for 16-byte
>> +     * memory operations if the memory operands are 16-byte aligned */
>> +    if (!HOST_BIG_ENDIAN && (byte_offset + 16 < byte_end) &&
>> +            ((byte_offset % 16) == 0) && HOST_128_ATOMIC_MEM_OP) {
>> +      group_size = MO_128;
>> +      if (is_load) {
>> +        __builtin_memcpy((uint8_t *)(vd + byte_offset), (uint8_t 
>> *)(host + byte_offset), 16);
>> +      } else {
>> +        __builtin_memcpy((uint8_t *)(host + byte_offset), (uint8_t 
>> *)(vd + byte_offset), 16);
>> +      }
>
> I said this last time and I'll say it again:
>
>     __builtin_memcpy DOES NOT equal VMOVDQA
I am aware of this. I took __builtin_memcpy as a generic enough way to 
emulate loads and stores that should allow several hosts to generate the 
widest load/store instructions they can and on x86 I see this generates 
instructions vmovdpu/movdqu that are not always guaranteed to be atomic. 
x86 though guarantees them to be atomic if the memory address is aligned 
to 16 bytes. Hence the check on the alignment. My x86 knowledge is 
admittedly limited though so the check on alignment might be redundant?
>
> Your comment there about 'if supported' does not really apply.

This refers to the fact that in order to decide whether to use 
__builtin_memcpy which could generate 16 byte mem ops we use cpuinfo to 
test for applicable host features (so for x86 whether the host supports 
AVX or atomic vmovdqa/vmovdqu). The intent here is to only use 
__builtin_memcpy when we know that 16 byte mem ops, if generated, will 
have a guarantee of atomicity.

Before I submit a new version of the patch, does this comment describe 
the situation more clearly?

     /* __builtin_memcpy could generate host 16 bytes memory operations that
      * would accelerate the emulation of RVV loads and stores of more 
than 16 bytes.
      * We need to make sure that these instructions have guarantees of 
atomicity.
      * E.g. x86 processors provide strong guarantees of atomicity for 
16-byte
      * memory operations if the memory operands are 16-byte aligned */

Worst case scenario the memcpy will generate normal 8 byte mem ops.

>
> (1) You'd need a compile-time test not the runtime test that is 
> HOST_128_ATOMIC_MEM_OP to ensure that the compiler knows that AVX 
> vector support is present.
(lack of QEMU knowledge here) I assumed it was safe enough to use QEMU's 
cpuinfo in the way it is initialized for x86 as an example in 
util/cpuinfo-i386.c:cpuinfo_init() and by building this for Aarch64 I 
see that these conditions work as intended (by not using memcpy, because 
we haven't added atomicity checks for Aarch64 yet).
>
> (2) Even then, you're not giving the compiler any reason to use 
> VMOVDQA over VMOVDQU or ANY OTHER vector load/store.  So you're not 
> really doing what you say you're doing.

I hope that the new version of the comment addresses this.

If I misinterpreted the point of your feedback and you are saying that 
it would be better to have guarantee to have specific host atomic vector 
loads/stores rather then using memcpy, there's the option of using 
compiler builtins to generate some specific host instructions and so 
enhance performance for some hosts but that didn't seem like a neat 
solution. Any thoughts?

>
>
> Frankly, I think this entire patch set is premature.
> We need to get Max Chou's patch set landed first.

Understood. I'm trying anyway to get to the bottom of this as it can 
prove useful for other optimizations.

Thanks again for the review work.

Paolo


