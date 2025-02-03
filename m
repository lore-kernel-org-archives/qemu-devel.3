Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17418C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 20:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf2cv-0001H6-56; Mon, 03 Feb 2025 15:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tf2ct-0001Gu-7B
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 15:00:59 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tf2cr-0003df-Kl
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 15:00:58 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2167141dfa1so84088645ad.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 12:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738612856; x=1739217656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Vjwj2e8YT7rnAM4x7ZWTehjC/R2pDiI/42xa7hWSuc=;
 b=Y9AUVK4gzfnTebuerQVIqV5tzqgqk/fGyfSZ9/Lma98BYaDOpF/gPZb71Vb2BfR0ML
 CxXUVWl3bgePktJ1ROK7pEv7+kSPU2Yp0EDhel/PrlzU14U7N7FWDvfdOaj7H3hdwiTQ
 u+gxpTJts0h0h75nWW810wU16WDSKgv1xm1DOsRaYZdYvMcE2ri7JMM9wVKTybyjAHBI
 FDSHhn2nMHWdhgN3FKdxqWwUFt0ws8CbQ+9Idhr0QSoJVI2DU76pToLTJL4GWV0gQTQy
 jdXO5h9ZDV5EMLHGun38HQpLcijKVSmXJf0XGZDB2rG4xnUPz3gTLbOS4x/+dKKpFtVs
 mZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738612856; x=1739217656;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Vjwj2e8YT7rnAM4x7ZWTehjC/R2pDiI/42xa7hWSuc=;
 b=TiLib3ssnmG2Prakstq/WG0QrKRx6W2JBc4QApvsOkLA4cPxGgdyRGI0x3cUMPq60j
 YYbVGKkPq7kJ2AMT6Yobp3fkEiUm9tQIB4StWR6Bl0hAdIoSeBnJw4jWwA3GPGv8gGeR
 89rcFkCu1qgwRpDtlU4XpdZHXdR73zanBN5ySUb7I5egbJjqtZCYMfM3Ooq5lpTD9Y4m
 IIB7uJiTAEUDf5EJVaWhKPtMEhufe3sYSylKGvK6zvwp3iM5Swq6UqXazNOKmMMAN8uS
 2lc24vCyuWGIC/Yef3X3VkOknRfliOjsyFRq2I4P+FNrWLmCFJSOwjijdHVHMMgTPQCL
 yeSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnoxSVst/Gy4uc5Y22L/P04zSQchN36e4GbpLgZDru22sST+BN9QsoSf5JZCY9rGNWlLmMEgDj5vX7@nongnu.org
X-Gm-Message-State: AOJu0YzdWuapaBwgv/XGy8DrEF+4MCkjbM3CqzV1NlR0BX2tF8cDciQe
 8QfAkU5H2fvgJivfftzlEiWFLen7AcH5s/pvoTNpgH6AThlitR/tt1yeUfLDqOc=
X-Gm-Gg: ASbGncup2VFmv1jk2R6faLqqUeR3q0+K1dPgBmQITcIXccXoYiMvhGdjor8AFdPTCX7
 UycS9B9ths0CLg3Q4nBP1DFhpe2ALAEzOXYc9v0+g4QAhyOMlBTmzxscv3k74qSF/IAeTmjZvRE
 69lF5O8qyKZsn9hKRtBk11jlTA+BNgAVnZoyPFW+qZb/02g6MfGAPzsPyZJgRCiY3GkSsSQZyEJ
 O8UpJSGGIxqzrV4gHJb4DPcNH+4rwUeEEmrh7WIS3gtM5daqod8RWWtOhwhRcCeIz++PqAdS/7k
 x5wJ5X02W8AxV1UhMFZd4T3twLYWUsOL6A9yW9H1M1OtTVKVx+nhBN4=
X-Google-Smtp-Source: AGHT+IGWT1fE0+267Ss+rrLQzId+z70ASlEAkhOfSVygPKZlXJr1U76E7DCx/BHDc6pbI1mc9/3jAQ==
X-Received: by 2002:a17:902:f688:b0:216:11cf:7b1 with SMTP id
 d9443c01a7336-21f01c76dbdmr2188965ad.15.1738612855597; 
 Mon, 03 Feb 2025 12:00:55 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de330386fsm80896255ad.192.2025.02.03.12.00.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 12:00:55 -0800 (PST)
Message-ID: <32f8e828-d3ce-4b8b-9268-420ac017c56a@linaro.org>
Date: Mon, 3 Feb 2025 12:00:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] accel/stubs: Expand stubs for TCG
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-8-richard.henderson@linaro.org>
 <cb6859a5-f4fc-4f7a-8e32-5aa2be3ee7be@redhat.com>
 <cfed8291-a3eb-464a-94a6-4d962c46d17a@linaro.org>
 <62edb7e7-5f3f-4f7a-825d-59291117e032@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <62edb7e7-5f3f-4f7a-825d-59291117e032@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 2/3/25 09:38, Thomas Huth wrote:
> On 03/02/2025 17.43, Richard Henderson wrote:
>> On 2/3/25 02:22, Thomas Huth wrote:
>>> On 03/02/2025 04.18, Richard Henderson wrote:
>>>> Add tcg_allowed, qmp_x_query_jit, qmp_x_query_opcount.
>>>> These are referenced when CONFIG_TCG is enabled globally,
>>>> but not for a specific target.
>>>>
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>> ---
>>>>   accel/stubs/tcg-stub.c | 24 ++++++++++++++++++++++++
>>>>   1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
>>>> index 7f4208fddf..9c2e2dc6e1 100644
>>>> --- a/accel/stubs/tcg-stub.c
>>>> +++ b/accel/stubs/tcg-stub.c
>>>> @@ -13,6 +13,18 @@
>>>>   #include "qemu/osdep.h"
>>>>   #include "exec/tb-flush.h"
>>>>   #include "exec/exec-all.h"
>>>> +#include "qapi/error.h"
>>>> +
>>>> +/*
>>>> + * This file *ought* to be built once and linked only when required.
>>>> + * However, it is built per-target, which means qemu/osdep.h has already
>>>> + * undef'ed CONFIG_TCG, which hides the auto-generated declaration.
>>>
>>> So why don't we only build this file once?
>>
>> I think we'd have to create a static library for it.
>> It didn't seem worth the effort at the time.
>> I can re-investigate if you like.
> 
> I think something like this might work:

I think we need some of Philippe's include/exec/ cleanup work first. We currently use 
exec/exec-all.h, which requires cpu.h, which requires building per-target.


r~

