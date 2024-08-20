Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945CEC5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 23:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgY5Q-000254-6l; Tue, 20 Aug 2024 19:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgY5N-00022c-FT
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 19:16:21 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgY5L-00053U-7r
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 19:16:20 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20230059241so24322075ad.3
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 16:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724195777; x=1724800577; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sGaIeQlGQqYKJlR12+m6pW20c0E1wJoz3l1NxNEdk7c=;
 b=XYWkfCliasqW4T+KGr8HPONus1Yw2rmLC0RhiRlGE5RmLxc2LqVBR6Dx1k1bOD77Gv
 IZvn0KQmybJk8XuUhiAKXnxvK1SFVRtbqCdFGFRP8W8LFF7ZJsA+TuKGuRWoo2acXBeb
 4VSMdw3fEuxdWK5bc4MFFIUJwarSRfBf4CF9TQx7L70WSS31jksNA+oWGw9n1FPM6esA
 yo4ar0Sc37smwXeAOT5HG+hFcsZY3RRwE92tEJ9Ej4es+nu5chl7+SeWe2QVkJJM1RyX
 YH7AmVwfvoVyK2bLA7CHm5XQSaziquiOsEz1lxM1hwllgi3wDg72z3FIWmzyJ1EOxjQW
 FXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724195777; x=1724800577;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sGaIeQlGQqYKJlR12+m6pW20c0E1wJoz3l1NxNEdk7c=;
 b=EjFDejNj6JMZ048yMHLaEwG8zDFmMCl6iowxbGB3zaNNwGBtUHr/aoSDggQcyKXzwi
 u3oLncuGU9arqmIk11ujeY5V8pdCzofXbeJzfC3AtOB1kxE+d2+qHfGgrxmKfu8S//Am
 7cUgeYe5YMo+QyF9bGx7v/GTt8tEjTj9XFeyRaLGpYXl3G/bqll+6cbBsTrmX3xn0SvP
 KdBX/8B7vVBGbqC0pAisL2zPVi9kW+/OvWJpeIcUx+0pgxitCFep5noqWVpK6L/m6eC7
 57fz+A1fcGFG1TVUpE+ZdNAT46BRQvdea/s7dopR9LgnfM2M+RDVTa+WliAO2DXCioRg
 uanQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7t0uEVZwF5O6iDc7/BcGZq1ue7aPMo06wWefz/DlbL8Z/iDV+9vDdNv9S3S7gKvOnvVa1DisBnfSs@nongnu.org
X-Gm-Message-State: AOJu0YwgmzX5gF5rSCwn9OUNVFcaxXOT9e93YL33D9Vf8C+hMmQkFE+T
 0Tl7A1fnH3TEWux3I68LzX1TDKQN5FEBgA6Gd4GX+eZ6m5JYyHc7mnbLncxngeM=
X-Google-Smtp-Source: AGHT+IEiqzOriILY6qZCn0iq1r2+voI40iFs6UPuDai3KbUb0BrwqzVx010ihUb11hl5VJgdKh7hZw==
X-Received: by 2002:a17:902:e804:b0:202:3456:b2d8 with SMTP id
 d9443c01a7336-2036819f6afmr4895305ad.65.1724195777282; 
 Tue, 20 Aug 2024 16:16:17 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.3.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2021a5fb750sm54830645ad.255.2024.08.20.16.16.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 16:16:16 -0700 (PDT)
Message-ID: <0edf7ee6-9dfe-41a3-a7ae-2f781e855b12@linaro.org>
Date: Wed, 21 Aug 2024 09:16:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] accel/tcg: clear all TBs from a page when it is
 written to
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20240809074725.320801-1-npiggin@gmail.com>
 <c098afe9-d09d-400d-8f2b-9278744a4ad4@linaro.org>
 <D3FESSMCNW22.3S68NMF7NI5KR@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <D3FESSMCNW22.3S68NMF7NI5KR@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 8/14/24 16:09, Nicholas Piggin wrote:
>>> @@ -1107,6 +1107,9 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
>>>        TranslationBlock *current_tb = retaddr ? tcg_tb_lookup(retaddr) : NULL;
>>>    #endif /* TARGET_HAS_PRECISE_SMC */
>>>    
>>> +    start &= TARGET_PAGE_MASK;
>>> +    last |= ~TARGET_PAGE_MASK;
>>> +
>>>        /* Range may not cross a page. */
>>>        tcg_debug_assert(((start ^ last) & TARGET_PAGE_MASK) == 0);
>>
>> This would definitely break SMC.
> 
> They can't invalidate the instruction currently being executed?

They can.  But that's where adjusting start/last would break things, because we've lost 
track of exactly what's being modified, which changes the result of "did we modify the 
current instruction".


r~

