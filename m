Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CD4C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 12:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzbQq-000781-3T; Wed, 24 Apr 2024 08:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzbQo-00077I-2l
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 08:08:58 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzbQl-0008P5-Tx
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 08:08:57 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-34782453ffdso7034492f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 05:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713960534; x=1714565334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TO77Tm9MKF3P3Fif+hCfnsL9weLWmVtjGBML7XF4nj8=;
 b=DDLIaneUfMV5U2DezSsvusW3imbfg7jzJZHTZaYylZcOh9nAbOxdP7QZFbtQ3QTstu
 BIqKiWIza2Jx5Ij37tt47gBZeNN0BSYUiURUpUe83zQdbyzGj5s47vo1IVdG/qu2cXBc
 3e7MdLk0GAr6A9Zw2w4LM+KCLwG8EkaJzQnV/TMY5sRYPFFWWMPCpD+tC923Qi6zZlUk
 lo3GGfsNC/siDmpRTjEFlgGpVq+obxIsrMCTXbjtaz58tAkqcugQLuKoFC5wVtEhL1/d
 SG6HbzZAICV65pW2xsBr5RaX5zbn5livUyzcRHH1V5UYg2bO7HioMyTa35WipUtUyd4s
 WQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713960534; x=1714565334;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TO77Tm9MKF3P3Fif+hCfnsL9weLWmVtjGBML7XF4nj8=;
 b=ZEl/P3HLupbhFpGrReedQoqWctx/q6HKU9xG95vXwR+p//EPXQVE57nhS48zHP2r1N
 xEqocG2GmVQr+JJAf7xqhOne263c+yfFHjP2qlm2X/XB82BJc1NgHkD/voDmjEE5IdhW
 +a0TN9VeY03G4re89AmJrmveezhay1iiyG+a6vJAndgR989h8OThkyEegr+dl/yxUueR
 k1/ujTSDXd3mZkG7qhS+ncwFzg7dio3fmVhthLvPs8EqUPaarHPxqDSQgv2lw24Zo5tL
 dEJUKAYzSStU4TuycLcdAoQXV09DyhUmE9OpTvl2fa8O347duHvtzHmA9PbOEA1W/uyP
 MggA==
X-Gm-Message-State: AOJu0YwWfksUpOgOdP30C/gRAgCF+Kb5yzbxRnYC0X3N9x+dJlYqmjDa
 yhLXnaHFvrbrOC+BByYRyFGG8eQStT4WMl47HwXy+wIID3RgP1CNrHXKE0IiIbs=
X-Google-Smtp-Source: AGHT+IHhTzdHrmaudyWBLO4QqfMlhgiKeDUGyISIvd+f4h25x3p7QeUbFxCXEVBcntwNqPx0/CTu+g==
X-Received: by 2002:a05:6000:12c3:b0:34a:d130:611b with SMTP id
 l3-20020a05600012c300b0034ad130611bmr1809127wrx.17.1713960533865; 
 Wed, 24 Apr 2024 05:08:53 -0700 (PDT)
Received: from [192.168.1.102] (mon75-h03-176-184-51-42.dsl.sta.abo.bbox.fr.
 [176.184.51.42]) by smtp.gmail.com with ESMTPSA id
 n17-20020adfe791000000b00349be95b5cesm16892492wrm.101.2024.04.24.05.08.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 05:08:53 -0700 (PDT)
Message-ID: <b621b69a-7e3e-45ee-8da9-e189b7d25c06@linaro.org>
Date: Wed, 24 Apr 2024 14:08:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 16/21] target/sparc: Replace qemu_printf() by
 monitor_printf() in monitor
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Chris Wulff <crwulff@gmail.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Max Filippov <jcmvbkbc@gmail.com>, "Dr . David Alan Gilbert"
 <dave@treblig.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240321154838.95771-1-philmd@linaro.org>
 <20240321154838.95771-17-philmd@linaro.org> <87edav433e.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87edav433e.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 24/4/24 09:44, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Replace qemu_printf() by monitor_printf() in monitor.c.
>> Rename dump_mmu() as sparc_dump_mmu().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Same "why?" and "suggest to mention passing current monitor" as for
> PATCH 05.
> 
> In addition:
> 
>> ---
>>   target/sparc/cpu.h         |   2 +-
>>   target/sparc/ldst_helper.c |  18 +++----
>>   target/sparc/mmu_helper.c  | 102 ++++++++++++++++++-------------------
>>   target/sparc/monitor.c     |   2 +-
>>   4 files changed, 62 insertions(+), 62 deletions(-)
>>
>> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
>> index f3cdd17c62..55589c8ae4 100644
>> --- a/target/sparc/cpu.h
>> +++ b/target/sparc/cpu.h
>> @@ -601,7 +601,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>>                           MMUAccessType access_type, int mmu_idx,
>>                           bool probe, uintptr_t retaddr);
>>   target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev);
>> -void dump_mmu(CPUSPARCState *env);
>> +void sparc_dump_mmu(Monitor *mon, CPUSPARCState *env);
>>   
>>   #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
>>   int sparc_cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
>> index 064390d1d4..44f8b2bb7a 100644
>> --- a/target/sparc/ldst_helper.c
>> +++ b/target/sparc/ldst_helper.c
>> @@ -195,7 +195,7 @@ static void demap_tlb(SparcTLBEntry *tlb, target_ulong demap_addr,
>>               replace_tlb_entry(&tlb[i], 0, 0, env1);
>>   #ifdef DEBUG_MMU
>>               DPRINTF_MMU("%s demap invalidated entry [%02u]\n", strmmu, i);
>> -            dump_mmu(env1);
>> +            sparc_dump_mmu(env1);
> 
> You add a parameter below.  I don't think this compiles :)

It does compile, because this is dead code (guarded
by undefined DEBUG_MMU). Good example that dead code
tends to bitrot, thanks for noticing.

> 
> Several more instances follow.
> 
>>   #endif
>>           }
>>       }
> 
> [...]
> 
> With that fixed
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 


