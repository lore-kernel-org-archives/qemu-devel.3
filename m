Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A563CC0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 07:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcJtD-0003Xv-Px; Mon, 27 Jan 2025 02:50:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcJtB-0003Xd-30
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 02:50:33 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcJt8-0001DA-22
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 02:50:31 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3862ca8e0bbso3585896f8f.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 23:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737964227; x=1738569027; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xqxrY7CJUWJqaUwf9NqB7WHQSEoMMiX/6GgCODIwrAA=;
 b=t/DVvnt75I+elbUFxLSJXEB5uLNSmUZU0gcc5xu3FqjDB34FPVBMGTrBdDqDJJOKuE
 LmNTxWAgCLbICL043/xG7MSeZns5717uK+RqtFJdq1CDOLzLOdPbOwyAsArtO11S1fSI
 cm04SIB+wtTsyxjbXIx5cPv+gHyoZ1/Pf5ntVWGmsegjD6pV/EjWeFQW8+AZNIglzZ+Y
 hPBX9ySdESrMqk+Os7hd8j9mae1edgKeXJ7tytPDrYXXrA+oJyAnQQfw+CRcKSdAoFxc
 IL07CX6G26FdUII2qtRKykwSg5+9ckoG17Wf7YFFmchkay6NLSRzpA/XjQ4vUsYhGq3d
 9/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737964227; x=1738569027;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xqxrY7CJUWJqaUwf9NqB7WHQSEoMMiX/6GgCODIwrAA=;
 b=YxFPlDsdULFRmvFZtB6kwasRsia2ciNVUPFSS8+1xJGyOb4gYvk+sW47WBtEM7Uceq
 hBklzeys6SxHgvZCAb3E1OpdD615Ib86kw9SUxiXebsgK5pOId/KdHMDYs5e6EdluK6e
 aZfKlAbTOJgdqYcJU/s6hXxb62p5o5OlY/9nmbEUkSr6du8/39i5Fn2IH2+Fu17viFDw
 bgUKuCJcXsibzXxETEMzLC0rwfxPuQkCookLmLAWsYoOCQgouxSCYOLQnfTg9TXf4/Hi
 UX2iQiHrts3Nt+w0Ym+IpvbLpEvPfdgFwCco1zV9QYG952NB+6II/9aaTUbJMHr9mdad
 oWyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvpJQM+1+i8SpfbkbR5vHB9N7NC2Qxqw3CdkFz+8P0oQH5qFTC0OGGe+FFkbUF1nkOhJ+/EXKLLDeB@nongnu.org
X-Gm-Message-State: AOJu0YyZFE52+RmGflsLKFMEOHumUmzu3H625k+5FnfPEn83Fjo7nDTK
 I4fxzsXDrnuUvCMQvyPyqZSojOEaytBuiEAtyQIsSMPp6fsFSZ5GzRWNI7/Y/MSbZKzZaGkEJvx
 E7NA=
X-Gm-Gg: ASbGnctS0zSDUgKDqQjXR6iwViQrFaqge1lBxD4QULkMg6W8cv21quB+UhAzxtyQeY8
 OCoE313deWqTxEsuF3eO+GK+psNGPbdBBkIdeIOT3g4sVcuIkB3Digd3Lf6oh7a4vJlUHY0DI8p
 RzhHTd07rm5h6pHLqy0LOMFEwLJiiPT9OFBHM9IWJPew5nMQwqBQXmwtzMElv2W0gmJtlShABlq
 BbM1oZH9WwaoTgzzfzeb7x1LfNqxShCwUBoxIy/VNoUfSqsV9YZZsnC0Ngfk6nd3EHNX5zAb2J1
 gO+btbgM39w1oCP8XL/7i5EE3gmj5DSOVlifrNytik9U7UmQ
X-Google-Smtp-Source: AGHT+IHLIteo38YZs3mQYbCDTQri74RaLgE+CKK9TQ3Ta7VqDPyTkhTXAsHk3SE8ymH+ek32R6Y44g==
X-Received: by 2002:a5d:64c3:0:b0:38c:3fab:3def with SMTP id
 ffacd0b85a97d-38c3fab419cmr3174950f8f.10.1737964227332; 
 Sun, 26 Jan 2025 23:50:27 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188928sm10163351f8f.45.2025.01.26.23.50.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 23:50:26 -0800 (PST)
Message-ID: <8da57d8a-a42a-446e-ad5b-a6ab07c65647@linaro.org>
Date: Mon, 27 Jan 2025 08:50:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/24] cpus: Remove CPUClass::has_work() handler
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250125170125.32855-1-philmd@linaro.org>
 <20250125170125.32855-25-philmd@linaro.org>
 <cbd78ef0-c06e-4a6a-8c17-1072fc58c777@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cbd78ef0-c06e-4a6a-8c17-1072fc58c777@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 26/1/25 13:31, Richard Henderson wrote:
> On 1/25/25 09:01, Philippe Mathieu-Daudé wrote:
>> diff --git a/cpu-target.c b/cpu-target.c
>> index 98e9e7cc4a1..778f622b07a 100644
>> --- a/cpu-target.c
>> +++ b/cpu-target.c
>> @@ -230,6 +230,14 @@ void cpu_class_init_props(DeviceClass *dc)
>>       device_class_set_props(dc, cpu_common_props);
>>   }
>> +void cpu_exec_class_post_init(CPUClass *cc, void *data)
>> +{
>> +#ifndef CONFIG_USER_ONLY
>> +    /* Check mandatory SysemuCPUOps handlers */
>> +    g_assert(cc->sysemu_ops->has_work);
>> +#endif
>> +}
>> +
> 
> Does this really need to be split from...
> 

 > diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
 >
>> @@ -319,6 +313,11 @@ static void cpu_common_class_init(ObjectClass 
>> *klass, void *data)
>>       dc->user_creatable = false;
>>   }
>> +static void cpu_common_post_class_init(ObjectClass *klass, void *data)
>> +{
>> +    cpu_exec_class_post_init(CPU_CLASS(klass), data);
>> +}
> 
> ... here?

cpu-target.c is in specific_ss[], cpu-common.c in common_ss[]
where CONFIG_USER_ONLY is not available thus defined.

We could define cpu_common_post_class_init() in cpu-target.c,
which is odd because not common; or name it differently 
(cpu_exec_post_class_init?) and have it registered as common
post_init handler but again it seems a dirty API mismatch, so
I went this way, hoping that eventually cpu-common.c ends
better abstracted and cpu-target.c disappearing...

