Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14D7C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 21:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twT1e-0001y6-VJ; Sun, 23 Mar 2025 17:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twT1a-0001xv-L0
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 17:38:30 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twT1W-0007pr-Ub
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 17:38:30 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so25105855e9.3
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 14:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742765904; x=1743370704; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EgDJtWw5jsUJD1vXHCI3P3kZIutNzdlM8ZLVFfCduxs=;
 b=uoyoyzPPxJ8c3wODzOLAi0LKOWu8uNK1t4PgZgpXOkEdkv2tSZHQzA07dTRqSCDNTS
 dnisGMD7d9DrHMr2GC6IBDdI0693W2uzWgrE+Cppr9ks+1BtYxYqgXGXohVRLbYZohae
 QfDSDnqEYeal4tszCH484TYFqUX6HjLJCd1fcRbGfi/peu80jbm3PKa1uJnHe5+7kvHx
 Aym83KMPcq6j+g3hrcumo9keutWvc5s26tLiCE9aynAni5bqyK7X8BwalGmmnAg6gbW5
 kpq/B8nHsetNnKI6LZUsLmlGb7PU+hWxYlrwokw8yrR+/IyfqNFHK0vujTeKUrF75PRD
 nEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742765904; x=1743370704;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EgDJtWw5jsUJD1vXHCI3P3kZIutNzdlM8ZLVFfCduxs=;
 b=DIeO2DGqQ29PZmh+A6CMpcfksAPc3SCo488yQg/5AlHX/YKckRFrBiHH3QHIQTq0eY
 80NUVy8TcyeV1XRTGzgDAnV5oOQyFJMTdT0XFPCHvvvNekpYy4nl51YpzKLMxzPQchGb
 qgWvN4XRoqTbnePufAsrTG6BSjBzGEJdUnOW5wwQPFEEsLgf+1XpzR6bPhjwDwGeeFBC
 1YStMS5oWNTQKyYXR/xBIAiOUR8GMNB50bltGjOb5LyD30Fu+XG0niLsBTikmdiP5KEo
 gypsrPZR889Dr1pkpAy97fj+JAJfKQKp2mjUx+RUHsE6yB7n02VZnVW/xamMLNdiGCvr
 6Brw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa54NkmCZ3c52/kl5j6152G5csKAg8rwhejmJQ8thWjemWCgyNVRdz98OHpKlWuUYZH5apwOClHA95@nongnu.org
X-Gm-Message-State: AOJu0YwhnM24vfC/jN4u4O3hoWu57dJ/WkcZe4XcYkqY/TTorcaChJY5
 BGMlH6oVBPo9Z+93bPbfoy74VaeKGrJOxN5MndgGmg1dObauJYVcE4Ih3ajD6Y4=
X-Gm-Gg: ASbGncvgZP2896k+D/q8eWiMiraw2RKz120O8bVsbq2fgcv1242YUB1wPVmgPwnS65+
 ONDwHzZu9bWoSpXDG05QfphsgYr2CuE/b4dcloGV0XTre6JIAbxBMxc8KGFo5GTFoj3huLbxogg
 qwipfS3hP9wZx8e6X3kKDRoZklyHLxbrrexDWRJORFtDc5wi0nVFqFdmwpaCqd7GUuHeZNW8gwA
 xWMtoFz0ssrX8IwjTof45KCxZyK2pm+m+2km2Rmp7Nu5lGp54Tuw+ZBAjZgD3YBDKvvNG9PQdM4
 kjmRKz+6nFZkYF24bnXjdqz5YWOa26inTyFtragyn+VxGEeXZ2LvijRJI86ohFtmFVWVji5y+L2
 F1aEAexJn7gALuFQBJQ==
X-Google-Smtp-Source: AGHT+IH5ccxWCqXebtKra13wC7kToog74g7yae1SEJAJYsS1pbLGABFbT74Lf7MizlRnAe4tQXMzhQ==
X-Received: by 2002:a05:600c:1e8f:b0:43c:fbba:41ba with SMTP id
 5b1f17b1804b1-43d50a3c949mr82777695e9.28.1742765904648; 
 Sun, 23 Mar 2025 14:38:24 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43fdaca8sm151765975e9.28.2025.03.23.14.38.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 14:38:24 -0700 (PDT)
Message-ID: <e2cbce38-831a-473c-ab26-a68ba5667bf8@linaro.org>
Date: Sun, 23 Mar 2025 22:38:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] target/avr: Handle offset_io in avr_cpu_realizefn
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, pierrick.bouvier@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-14-richard.henderson@linaro.org>
 <ee521295-63c5-43ed-add3-cde4f0014524@linaro.org>
Content-Language: en-US
In-Reply-To: <ee521295-63c5-43ed-add3-cde4f0014524@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 23/3/25 22:35, Philippe Mathieu-Daudé wrote:
> On 23/3/25 18:37, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/avr/cpu.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
>> index e4011004b4..538fcbc215 100644
>> --- a/target/avr/cpu.c
>> +++ b/target/avr/cpu.c
>> @@ -161,12 +161,14 @@ static void avr_cpu_realizefn(DeviceState *dev, 
>> Error **errp)
>>       memory_region_init_io(&cpu->cpu_reg1, OBJECT(cpu), 
>> &avr_cpu_reg1, env,
>>                             "avr-cpu-reg1", 32);
>>       memory_region_add_subregion(get_system_memory(),
>> -                                OFFSET_DATA, &cpu->cpu_reg1);
>> +                                OFFSET_DATA + cpu->offset_io,
>> +                                &cpu->cpu_reg1);
>>       memory_region_init_io(&cpu->cpu_reg2, OBJECT(cpu), 
>> &avr_cpu_reg2, env,
>>                             "avr-cpu-reg2", 8);
>>       memory_region_add_subregion(get_system_memory(),
>> -                                OFFSET_DATA + 0x58, &cpu->cpu_reg2);
>> +                                OFFSET_DATA + cpu->offset_io + 0x58,
>> +                                &cpu->cpu_reg2);
> 
> Always zero, but I agree it is clearer.

I figured out the use after reading the following patch ;)

> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>>   }


