Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCB2C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 04:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhhJU-0002n6-NM; Fri, 01 Aug 2025 00:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhhJQ-0002gb-Ho
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 00:24:09 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhhJO-0004Eu-Vk
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 00:24:08 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-23636167afeso3549375ad.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 21:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754022245; x=1754627045; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QrcjdRn4FoXk91gllSNnJ6FARMuaVOS6lz2+WKkXkSo=;
 b=TgUViCAXdcq+Mg6Ey2xOinuKS0Q4lzzXJToYx90YQ5h/+nycqR0ofiFwIbjS8ZO6+9
 PuTccV4Rnwz1F2lyDYF5YTVreOOltufZs4dLkih8FTYbslkb47yxwsVAZ4BE3+XmfM7M
 gany4grbOdUQTzfPZcyL61O3sasFajki413F1pXd3k3Ha3WOFEhj5JmbvZddPRLq8sCx
 XuW6ssUhGgpGimu3gX7P1zYz+NOWxFG8/GpEbJGtyOo+epTF+6/08ShQx1SnbA3rw6BA
 uD03JgKo/sebJMB4tZEaxiUuOPIJq1SfozNxVsuObYPpel06J0XaMlwZFM9rlI2hF8Qo
 6XoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754022245; x=1754627045;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QrcjdRn4FoXk91gllSNnJ6FARMuaVOS6lz2+WKkXkSo=;
 b=OlJ/Q1RPrbNoYXMiuNFFPZdUSrYFgL/Ja7ASKK7odXshvcXVpwWFbjSNRU88Y8lgmu
 XHLZSpVeiVikjVPRvF0/ual0/Z+sPJbXUDXSJikqRlZ6eDekgOTAi0BInOEs1hTEKz5v
 J40RREGvEFWJyVjgH/kHvgIv0nuoFkVdCKTtKIatGMpOVkJMPuStEkE/tq8H1x/JUgSP
 98Z7lVr8e1t01sMIWi7LSt8hnBWoXoU4RDIpz/I0JuECuqUHLSgpHmm0McrXeK75NpSY
 c9xhieNEnbwTDjQ/4/V784Z3HlZ5kakMH8M4N3w38VfPokeS7c3AHhlLiPHUUe9p/VGB
 gofw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/xFp62ea9K6dbfKyS1HS6NffHo+mgUmyOn+Gl+1xJJl6GOdnto+etqHGxA75MjY4fy+IjS3MeVS13@nongnu.org
X-Gm-Message-State: AOJu0Yw+gexk2zE3io1nVRqIe8lE1PJwUXxuyWNUA64UTwe57q8ZMP8f
 TmbYb3TTjJdl2fFGjYDeOroRYwDiAyNi+izYhP/rgviUDbnvLQsViYjotlA7Cnp6/v8=
X-Gm-Gg: ASbGnctlY3f+yl7ZGdga9Upqzy1LbqXqj9AG44JAOMG102f1VSZOWhorI4BOoihX83z
 JLOS9VrxV9cX+J3h38fiAbKGiOM+JuO3hcvbzO/Mu5neV3HZgJpw2lRWNh1S8T/H+BAq9uQRu8f
 zb8VE7f+UbuHj6I25d6gk7uFyimrId09k7GB8YKoSAUjUNJnHx0y22h4gsUaEzdPienxoKV9kXS
 N/hxwjFzcwf0eCthRsBGLi/uMm1G5xYe1U0unPXSLm9O0x48qsFWqYah1w28sLs4S0CaVR5F8EP
 mPg96nByIsISWCSccnPmCu4rGh+qrAlQRsCEwD1yeUyEuWXaRfMbnZyiByuSxdTfWKOegzUkWim
 b9mY4KoZ4wrK1vc2QawAyA8EisXqS0TOR+1BVYwJrtP+fU5Ui9HM=
X-Google-Smtp-Source: AGHT+IG7OP2f/nirxrxZChsgzNbFhBkC+fOSlnVpCGK1uQLwW9CU/TKTdAJa+tmw2+GaCoF6SlqXZw==
X-Received: by 2002:a17:903:1b67:b0:23f:8bcc:e4e9 with SMTP id
 d9443c01a7336-24096b103b9mr144220575ad.23.1754022245143; 
 Thu, 31 Jul 2025 21:24:05 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8ab38b4sm31085455ad.181.2025.07.31.21.24.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 21:24:04 -0700 (PDT)
Message-ID: <f198153f-088c-4196-9ee2-ed1e8e4fc92f@linaro.org>
Date: Fri, 1 Aug 2025 14:24:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 47/82] target/arm: Expand pstate to 64 bits
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thiago Jung Bauermann <thiago.bauermann@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-48-richard.henderson@linaro.org>
 <b2e40787-6043-4d4c-9cbb-731d0e92e25c@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <b2e40787-6043-4d4c-9cbb-731d0e92e25c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/1/25 05:13, Pierrick Bouvier wrote:
> On 7/27/25 1:02 AM, Richard Henderson wrote:
>> The ARM now defines 36 bits in SPSR_ELx in aarch64 mode, so
>> it's time to bite the bullet and extend PSTATE to match.
>>
>> Most changes are straightforward, adjusting printf formats,
>> changing local variable types.  More complex is migration,
>> where to maintain backward compatibility a new pstate64
>> record is introduced, and only when one of the extensions
>> that sets bits 32-35 are active.
>>
>> The fate of gdbstub is left undecided for the moment.
...
>> diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
>> index 64ee9b3b56..3cef47281a 100644
>> --- a/target/arm/gdbstub64.c
>> +++ b/target/arm/gdbstub64.c
>> @@ -47,6 +47,7 @@ int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, 
>> int n)
>>       case 32:
>>           return gdb_get_reg64(mem_buf, env->pc);
>>       case 33:
>> +        /* pstate is now a 64-bit value; can we simply adjust the xml? */
>>           return gdb_get_reg32(mem_buf, pstate_read(env));
>>       }
> 
> If I'm correct, we currently don't expose PSTATE through gdbstub, but only CPSR. This was 
> a bit confusing for me, considering that CPSR is not even supposed to exist in Aarch64.

Correct.  An old error, for sure.


> Maybe it's a good opportunity to expose PSTATE instead, which could have a 64 bits size. 
> This way, we don't break any workflow.

Hmm, perhaps adding a "org.gnu.gdb.aarch64.pstate" xml with just one 64-bit value is the 
best solution.  Thiago?


r~

