Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99D3C87FCB
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 11:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukiDb-0005NF-7Q; Sat, 09 Aug 2025 07:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukiDZ-0005Li-Ed
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 07:58:33 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukiDX-0008Nj-Jm
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 07:58:33 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45994a72356so22703755e9.0
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 04:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754740709; x=1755345509; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CuVeWiDXup3Fxz11lR8lgrgzHwCPEXpLHAd+940VFDc=;
 b=D4DVz5HwB8DwNpu023lL98qhM+Rzk+tCy3dOX1P6mal2zaYTsj99abItsE+kmFMqsL
 4RwrnxIU6fkADimAmpkY7d885PgvglDU+Xc1wLb/eka9ox2AWEAZMd1HPWuTin670OEw
 ZsYKWqREJ3WPMNw8AgwshqNMyR0XhhXhdqp6ViXcfh8mggZgzSLCqwvgEpayYiuQfFPl
 +cwfgewx43gm6xoXlok5UzuBPSuvweYlgPYEm0Cjgwb2eP1QDhHj2yDlpn/uU5rTF77p
 DDdGXTV4pEghy/KRxEARZB7Du3+GVmF96GTNfxf243YJ8CxKa+ut2UqnavybBbrtg1k4
 VGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754740709; x=1755345509;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CuVeWiDXup3Fxz11lR8lgrgzHwCPEXpLHAd+940VFDc=;
 b=fyOd3nwYMf+Z1qGF+2JH0z1fRX/6J6/YTO+32PGLlq1pSdzLtkScA17wyMKAPR0FQI
 qF6v+dYyz6KV1WABjoJm4eP9hxQrhQkjJRTCUEaYNz1u0NrpOXOOtRxRA8tNCwz/2O7l
 oDi5mGeMMX5trfNWtOyPEL8NOcpVrs3ffPX3R2rdOb/nyHB3py+kzqpK+MAf0TTP7HI/
 n601T/KjlLCKdy074RaaflfxCJS5DjMb8IYM1kcyyWZesw2OFbr77ysRNGEPj4K3sMk9
 DDM8PhY97EUg8B+tdVz7LZjo3BHaaluL06rEXpyH0OU0tSnk9bUDrnupdkG+oWOnQpaf
 4vJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0Qz+EpEWihhM2wAa638t25pF959lITh5aG76fwr76jDhTATWKIfyvxDcQf3Aq2sGRbAHV+2HwZU83@nongnu.org
X-Gm-Message-State: AOJu0Yxibc415ZBsFPf6wDotzA0WW8B48nJFO9a4h3I/2gskN2jkKX/k
 Lmf6vt8xvgywvxvONw7tBHfq0CZFtdAx9pByxt5BYSHIK5xqnnVUwdSB1Wkli180Ujw=
X-Gm-Gg: ASbGncvQtCxnIH+H+7K0Kj5h/rb1QfrwtIQrwdbdm2PIh9Tuq3AznAwwHhM/M96IxNW
 1IWxPAw/mlgbwGzdO7ZdZNoeibla289ypVHCDrRqZ+rf3vF44eFQXn3lmWOSHfUB9sxxypWjg22
 yQvaHH3bjJPl6Aaml7NLU9GC80yXP0KQGNTpImbL0lYxo11JHmP5fnq3TsMeZ1AUFsWaCAIjMqy
 3VLIy+OKlubFW14Oewa9AY9MQG8W/CWlDrUYFTHbeuRVpsTILGL8Su0/QdWV6L7HUk1ANL/S1Sy
 4xlSt37gSvPFBlfOCbkZPoxrkQO6h+oQ6mh3tOJB8H/kFL4iQ/DlZv4JebzrS91LYjs6QoCeVcK
 CdhT/c4ZWpZcG33f185hmPCtaY8bXdNFDYbPLwg1JsaBaa5dRPw43sI/Wen6V1xWvoA==
X-Google-Smtp-Source: AGHT+IEVmK+enMCd1CVLC4fTfNQraFKiWHh0FSFWhxfCwNkZSZpY58pN7yTnAOJz7ZBdwAaYjn1mzQ==
X-Received: by 2002:a05:600c:a31a:b0:456:1d06:f37d with SMTP id
 5b1f17b1804b1-459ee0db219mr79392515e9.16.1754740709352; 
 Sat, 09 Aug 2025 04:58:29 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459de0d4cf1sm236447195e9.13.2025.08.09.04.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Aug 2025 04:58:28 -0700 (PDT)
Message-ID: <0f865d71-1910-40fd-aa8a-aa72801dabde@linaro.org>
Date: Sat, 9 Aug 2025 13:58:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] contrib/plugins/uftrace: implement tracing
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, rowan Hart <rowanbhart@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20250808204156.659715-1-pierrick.bouvier@linaro.org>
 <20250808204156.659715-5-pierrick.bouvier@linaro.org>
 <ef71cc03-53a3-4a9f-8052-eabf528227e4@linaro.org>
 <a0ae6c62-24d3-4772-aa4d-126fdf88df72@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a0ae6c62-24d3-4772-aa4d-126fdf88df72@linaro.org>
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

On 9/8/25 00:05, Pierrick Bouvier wrote:
> On 8/8/25 2:45 PM, Philippe Mathieu-Daudé wrote:
>> On 8/8/25 22:41, Pierrick Bouvier wrote:
>>> We implement tracing, following uftrace format.
>>> Trace is flushed every 32 MB, so file operations don't impact
>>> performance at runtime.
>>>
>>> A different trace is generated per cpu, and we ensure they have a unique
>>> name, based on vcpu_index, while keeping room for privilege level coming
>>> in next commit.
>>>
>>> Uftrace format is not officially documented, but it can be found here:
>>> https://github.com/namhyung/uftrace/blob/v0.18/libmcount/record.c#L909
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    contrib/plugins/uftrace.c | 150 ++++++++++++++++++++++++++++++++++ 
>>> +++-
>>>    1 file changed, 149 insertions(+), 1 deletion(-)


>>> @@ -297,6 +432,16 @@ static void vcpu_init(qemu_plugin_id_t id, 
>>> unsigned int vcpu_index)
>>>        cpu->ops.init(cpu);
>>>        cpu->buf = g_byte_array_new();
>>> +    g_assert(vcpu_index < UINT32_MAX / 100);
>>> +    /* trace_id is: cpu_number * 100 */
>>> +    uint32_t trace_id = (vcpu_index + 1) * 100;
>>> +
>>> +    g_autoptr(GString) trace_name = g_string_new(NULL);
>>> +    g_string_append_printf(trace_name, "cpu%u", vcpu_index);
>>
>>     g_autofree char *trace_name = g_strdup_printf("cpu%u", vcpu_index);
>>
>> and pass (const?) char * to trace_new().
>>
> 
> I tried to do something clean with GString everywhere for dynamic/ 
> mutable strings, and const char* for immutable ones, favoring 
> readability and clear memory ownership over C char pointer soup. It does 
> not optimize anything important in this context since it's called only 
> once during the program execution.
> 
> Thus, I would prefer to keep it as it is if that's acceptable for you.

No problem.

>>> +    cpu->trace = trace_new(trace_id, trace_name);
>>> +    /* create/truncate trace file */
>>> +    trace_flush(cpu->trace, false);
>>> +
>>>        cpu->cs = callstack_new();
>>>    }
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
> 


