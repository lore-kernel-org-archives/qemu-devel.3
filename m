Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A6BCAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 17:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1TAO-0000Y4-PQ; Wed, 24 Sep 2025 13:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1TAH-0000XI-Ck
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:20:25 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1TA5-00031m-KI
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:20:25 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3ee15505cdeso21608f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 10:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758734397; x=1759339197; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W0e64GO7SBJe09DXOCnTcc1eEsh8vSTBEq3BJd9NyoM=;
 b=JTvECHsRaBANXzqJmKd1yNEtbGlJt4AMqO56S5u20GYK0uyBYaHlP+4ayq/yB/WhNw
 NJKv2s+ahtbMBcMTgYGyc4JSno/MQkiNmGfK7v8bPCdJvc9u5jhofi/8TXjMZ7AWawF/
 wwLBVNFstj8tNkoxmiU/vz8gE3bbRR8H1rTy4gnpxu+6C7wUagqPjYB3YoF4efqgumFU
 Doaw8Twu76swSGhANXweIjDLW2fx9MVatiXDvM59wtniLQFas6/0LGlwhqcFBLu9OB7B
 5sDLB6+oCqpCoPY+X5eRqISQRbfG2v0k1tmmqRDYvDngKjL3D/+a5i+5M6oirzWe3sYP
 Grcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758734397; x=1759339197;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W0e64GO7SBJe09DXOCnTcc1eEsh8vSTBEq3BJd9NyoM=;
 b=u88Giv36F9pqdVkocZfF6Rpmx6iPC7OJ5EWUkqtyeKHucxlhEy74N91RdPUpv6kJBV
 21VBm7+xdZAiEcPeuMMN+Lz0jXQ/o1VEHArMjrZ1PAj2r+ny+n1neKD+iaGnSYCBFEfo
 YTEl21p/jfkKXZgjioQUTnNb3EZstkZ4w209p+BgPQ/Nm028CBV29r2Ixh9oHNiEDPBj
 OxPivg8kOWJSivEXGduZ4BF6tpbsmaw8nMAP+OJcqu9xsU/+nL9Rp7lBeq+BBppaKL74
 5qF5M79wDxg86YLjyQqq6EUtSSSgYkBMu/TQXGJCXBNtOt+YHboh91Judrmf+3ROyE60
 nmHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg9Hoj9Vd/+1LWPIoCZSXQia6xNStEyVWInIXFsAwTMI8gUk1uvlNJ17TonwdYF6nEka5cxJgJ+IAK@nongnu.org
X-Gm-Message-State: AOJu0YzvCkZ4JIeF0B1NEY0C9eMbeIIPE7FNG0U0iGB3nevbVOG3AkQP
 tYVfKGuvqiEI2tZzqabMS53Zn+eFi6lvw3vOi/5FOE9bM4O3xrtCKZnwzMGaSZ7fywE=
X-Gm-Gg: ASbGncthin8njV8ZPTi2Vnt+JoMRcKsQYQpD0aDGGtc2jqMh6mdhfMsBxwvHxeXoocT
 omNkOdTGahqWF/xPv03FiorI9IT31xm3O25uvL/eUJj1/aXs2afLKQpvFtShhwq7Uce8iBdIsg7
 91eZBRJVGQv6Dr/WpkbM7tE4DZH9VMp+c1/2+A7OGiHm7jJRZaxJVvHnf06B4YHOUhvmxu70rUI
 OxdByEbuGluajPKTfgPiW4b3QYarGfWYj96J1z8BalMnVd77/a10h+vHwcQ/KgXASapgIkLrxom
 drrht9vb9WtL5hp4udEIB6daVXlDr9qOG56LT5rlfPW4+7wi9s9p+IYWH0GiHEVfagXkPTCY2Dv
 b1lH3YpRRNP1mUiIqMcICn5F0qZdoZUl9NEpxVlYFw0l3TDzPqsOq5oj1AZomceL44w==
X-Google-Smtp-Source: AGHT+IHGISn+C+tDneB9eSI+HmhjaiQOEFKnN3XxqVtDRIyi1oA6lAHvO/kjqGh5ZtonevDj9HcGCQ==
X-Received: by 2002:adf:a30a:0:b0:404:c253:a38 with SMTP id
 ffacd0b85a97d-40e839f916bmr312397f8f.28.1758734397358; 
 Wed, 24 Sep 2025 10:19:57 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a9ac5basm49657325e9.7.2025.09.24.10.19.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 10:19:56 -0700 (PDT)
Message-ID: <25894b56-0b00-4807-8c74-60ddcea89cac@linaro.org>
Date: Wed, 24 Sep 2025 19:19:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Qemu-devel] [PULL 07/12] ppc: Get out of emulation on SMT "OR"
 ops
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: benh@kernel.crashing.org, qemu-ppc@nongnu.org
Cc: agraf@suse.de, David Gibson <david@gibson.dropbear.id.au>,
 pbonzini@redhat.com, peter.maydell@linaro.org, bharata.rao@gmail.com,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
References: <1464655277-14748-1-git-send-email-david@gibson.dropbear.id.au>
 <1464655277-14748-8-git-send-email-david@gibson.dropbear.id.au>
 <92e74dad-2027-49ab-8af5-5181b829d68d@linaro.org>
In-Reply-To: <92e74dad-2027-49ab-8af5-5181b829d68d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 27/8/25 16:07, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> (old patch merged as commit b68e60e6f0d2865e961a800fb8db96a7fc6494c4)
> 
> On 31/5/16 02:41, David Gibson wrote:
>> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>
>> Otherwise tight loops at smt_low for example, which OPAL does,
>> eat so much CPU that we can't boot a kernel anymore. With that,
>> I can boot 8 CPUs just fine with powernv.
>>
>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>   target-ppc/translate.c | 21 ++++++++++++++++++---
>>   1 file changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/target-ppc/translate.c b/target-ppc/translate.c
>> index 51f6eb1..fe10bf8 100644
>> --- a/target-ppc/translate.c
>> +++ b/target-ppc/translate.c
>> @@ -1392,6 +1392,19 @@ GEN_LOGICAL2(nand, tcg_gen_nand_tl, 0x0E, 
>> PPC_INTEGER);
>>   /* nor & nor. */
>>   GEN_LOGICAL2(nor, tcg_gen_nor_tl, 0x03, PPC_INTEGER);
>> +#if defined(TARGET_PPC64)
>> +static void gen_pause(DisasContext *ctx)
>> +{
>> +    TCGv_i32 t0 = tcg_const_i32(0);
>> +    tcg_gen_st_i32(t0, cpu_env,
>> +                   -offsetof(PowerPCCPU, env) + offsetof(CPUState, 
>> halted));
> 
> This sets CPUState::halted = 0, as unhalted state (a.k.a. "running"),
> is that expected? I'd expect "Pause" to halt the vCPU to avoid spinning
> (as mentioned below).
> 
>> +    tcg_temp_free_i32(t0);
>> +
>> +    /* Stop translation, this gives other CPUs a chance to run */
>> +    gen_exception_err(ctx, EXCP_HLT, 1);
>> +}
>> +#endif /* defined(TARGET_PPC64) */
>> +
>>   /* or & or. */
>>   static void gen_or(DisasContext *ctx)
>>   {
>> @@ -1447,7 +1460,7 @@ static void gen_or(DisasContext *ctx)
>>               }
>>               break;
>>           case 7:
>> -            if (ctx->hv) {
>> +            if (ctx->hv && !ctx->pr) {
>>                   /* Set process priority to very high */
>>                   prio = 7;
>>               }
>> @@ -1464,6 +1477,10 @@ static void gen_or(DisasContext *ctx)
>>               tcg_gen_ori_tl(t0, t0, ((uint64_t)prio) << 50);
>>               gen_store_spr(SPR_PPR, t0);
>>               tcg_temp_free(t0);
>> +            /* Pause us out of TCG otherwise spin loops with smt_low
>> +             * eat too much CPU and the kernel hangs
>> +             */
>> +            gen_pause(ctx);
>>           }
>>   #endif
>>       }
>> @@ -1489,8 +1506,6 @@ static void gen_ori(DisasContext *ctx)
>>       target_ulong uimm = UIMM(ctx->opcode);
>>       if (rS(ctx->opcode) == rA(ctx->opcode) && uimm == 0) {
>> -        /* NOP */
>> -        /* XXX: should handle special NOPs for POWER series */
>>           return;
>>       }
>>       tcg_gen_ori_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx- 
>> >opcode)], uimm);
> Note there is a similar code in gen_wait() doing the same (but 
> correctlyIMO):
> 
>   3366  /*
>   3367   * wait without WC field or with WC=0 waits for an exception / 
> interrupt
>   3368   * to occur.
>   3369   */
>   3370  if (wc == 0) {
>   3371      TCGv_i32 t0 = tcg_constant_i32(1);
>   3372      tcg_gen_st_i32(t0, tcg_env,
>   3373                     -offsetof(PowerPCCPU, env) + 
> offsetof(CPUState, halted));
>   3374      /* Stop translation, as the CPU is supposed to sleep from 
> now */
>   3375      gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
>   3376  }
> 

I'll post a patch as RFC to see...

