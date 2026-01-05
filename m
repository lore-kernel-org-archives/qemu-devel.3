Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71DCC79FAF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 18:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcpcP-00067i-JS; Mon, 05 Jan 2026 13:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vcpbq-0005eB-Fq
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:47:19 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vcpbo-0000SD-PV
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:47:18 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-477632d9326so1508785e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 10:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767638835; x=1768243635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SpDhy8RTo0H6hUNpedWzmERUj4zB9i/oq7zkILxNnFM=;
 b=fNgzzwcpF52Y4HMIOmaaTFPjOSNpq2b4+FKqXkVHURBXsDtwfc2BVgDEb2EvtFDrSJ
 CO6UV5c5WH42GH2fSfGq7r3WaE6NQYh6jTOXlLBCd8eA8LvkBjBA28IkHxJmSVhHvDk/
 yumwS66BXHRq8U3l4UcB+XCucOZ9RLXM1Q7mhf9j/zl4F7+benxc5TPebEbODonYMNSK
 liWvgR8eu46xvOAk4cnRdxy8Efzh9Xe5FCm0MUO8mn2eh+0iqt5W8wQpyRg5+IqgTZO6
 Ei1FmcLkxWnCqdeg0GNDQ3SN4nWutK1di00YwfkVbhh2x9ycWSnl+77mirElGutaDrt1
 RByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767638835; x=1768243635;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SpDhy8RTo0H6hUNpedWzmERUj4zB9i/oq7zkILxNnFM=;
 b=tJx9xBxSJOuxGFKBXSkvqfxxKxd8cDyw4ECd0LVVBpM6Kn4W6fA+1KL8dtHlQveNpa
 DBlPVPMiIKK+bI0FgLkIe5PL2n1x0faj+5chM/Gkk8BjBCv3IG41qHQW/DhQtY1s7u6n
 muXnkkcRDzMJjepXrdDd3RWg91srj+PqRJL2N9vqj6Q+Oe3XmNq5Nvg/CA0IHbKxf0LD
 eNYI8w6Jx35KeEssaYCBBsPD2DAhfSaF21h2lAsp0OX4W/mB4nffy0Tz+Mej5V/ogtoz
 3ql7dUCG0uRCPtV7ED02T+JghLgPEZsqgopcPyPBb+Yjmg66NzJxytXY0+OKq7sd/Ob/
 Uf5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG2ZKwbsy/N8umdXb476eroPETLgnqZ4GRrK85l2xIpoXsxrUrNgp8PK57J8TlyhCgC1OkWBZ53uiy@nongnu.org
X-Gm-Message-State: AOJu0YxdJ2s0c7MLzCdk2k3jUBzXcAtG3SERVfzLZuutG09s4r5M0NDh
 TLhwCip3k7g1OW5uNte5h/YdCdgV803iWZOQxpaDTk//BIk34uRLJGcUeyitW2wF0CI=
X-Gm-Gg: AY/fxX4LP9xOjwtKXKhFRya+hojOJ3ZB4BNNZY6IwxiyA4+ZEyVPkZA99wxyAh+RXf2
 nyKPCZuzQOdVUpGgI5kSjRc8l8Be1v2GMaWWq0Mal5LCpjZWSyTgr/QHQHzTWqEVpI/b9HwgPfW
 7JEbwSSmiwIj8AuDMolImzx1AoRN6ekGWDPw2zFyjdPJ+0OVLie9YkJsl17npHvdy4VqEbeTkHq
 Swzh5ju9T7pNxl8EmJt28ez4jr0FYHy1FD67TodTZrAfxsM4XAsfRx5p3MJgCd0WMxpSyB+cSN8
 JfadtS9Dz0+GhXDtvWxG3bxfUtGYNwUfe6Yemkqve5kV76pD3rC/r+vshdthlWSN7eKBerUsg8l
 Y9e9xYLuYwO6Ic+nm+hN4D6jD1hPuGmer6r3+KzpbQUXRpt4bVmtPLlZLfE6/ojH3jSyzi5CxFm
 fQAFNiYICMJyEP6zGnFpTT84pUY2qMpal3WcXtVUSqBWE3HLNQgWJ0okz0LDTeUzb5TgEZ
X-Google-Smtp-Source: AGHT+IHN9H9YrstvfBR/GcW4iAzN+UoMyvGONDjc7kReQ+iw1wi67fBpPStECW5snD5k+kjyA13r/w==
X-Received: by 2002:a05:600c:c494:b0:47d:4047:f377 with SMTP id
 5b1f17b1804b1-47d7f0a36b6mr3740885e9.36.1767638834943; 
 Mon, 05 Jan 2026 10:47:14 -0800 (PST)
Received: from [10.247.174.66] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f390a69sm2996425e9.0.2026.01.05.10.47.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 10:47:14 -0800 (PST)
Message-ID: <1752b84f-291b-4f56-9a97-e61163564963@linaro.org>
Date: Mon, 5 Jan 2026 19:47:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/openrisc: Inline translator_ldl()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Jia Liu <proljc@gmail.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stafford Horne <shorne@gmail.com>
References: <20251224161804.90064-1-philmd@linaro.org>
 <20251224161804.90064-4-philmd@linaro.org>
 <bc66522e-0c13-4c03-a7ec-86ef64a49eb4@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <bc66522e-0c13-4c03-a7ec-86ef64a49eb4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 5/1/26 01:11, Richard Henderson wrote:
> On 12/25/25 03:18, Philippe Mathieu-Daudé wrote:
>> translator_ldl() is defined in "exec/translator.h" as:
>>
>>    198 static inline uint32_t
>>    199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
>>    200 {
>>    201     return translator_ldl_end(env, db, pc, MO_TE);
>>    202 }
>>
>> Directly use the inlined form, expanding MO_TE -> MO_BE
>> since we only build the OpenRISC targets as big-endian.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/openrisc/translate.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
>> index 6fa4d6cfa70..a6d550bbc2e 100644
>> --- a/target/openrisc/translate.c
>> +++ b/target/openrisc/translate.c
>> @@ -1558,7 +1558,8 @@ static void 
>> openrisc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
>>   static void openrisc_tr_translate_insn(DisasContextBase *dcbase, 
>> CPUState *cs)
>>   {
>>       DisasContext *dc = container_of(dcbase, DisasContext, base);
>> -    uint32_t insn = translator_ldl(cpu_env(cs), &dc->base, dc- 
>> >base.pc_next);
>> +    uint32_t insn = translator_ldl_end(cpu_env(cs), &dc->base,
>> +                                       dc->base.pc_next, MO_BE);
>>       if (!decode(dc, insn)) {
>>           gen_illegal_exception(dc);
> 
> Use mo_endian().  With that,

Oops!

> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!

