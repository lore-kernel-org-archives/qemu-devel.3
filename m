Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFB6CEDDA9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 01:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syhrD-0000BA-J4; Wed, 09 Oct 2024 21:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syhrB-0000Ao-4G
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 21:20:45 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syhr9-0004yg-Fg
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 21:20:44 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e28b75dbd6so372413a91.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 18:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728523241; x=1729128041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w5ioFZOdbjVsS0jGHB/HF2ynkGiaH+QupG/V7kszI2g=;
 b=sJQxT3qBl+rsYi+4IeO9IXoEikAWgNP+zz++eced0Eg0glVv4FWoHW1IgFrM+aIXmj
 d8M1o+rFQef+qKOq5+e/k8oOnwzJu8t71ec8TE29UqJAHkUB0ANpDGFSoW0S3vBDy2w7
 1M2moMDLfUhqd0m/CZIJjzMmDZBA3E7KrfDE2IBOBoTaZRj/Xp0L5hUPIdrjLjHy3MGa
 8p62RcPUFWVoKL+56RSMG958VTdQET9EkYlM29BpDydBdOerx3M/eeF3slAmCNZm0wZq
 987QKnZIuBKSDB1sfZX9CVYijHjhtVBDescG7epBwkGbmPMNzXNFwtoxfvnzjnn/wDEA
 Yq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728523241; x=1729128041;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w5ioFZOdbjVsS0jGHB/HF2ynkGiaH+QupG/V7kszI2g=;
 b=pzpGKjm7QGmUy+bMtXTwSwAhEU1atgmIxHSEeNYsHTaDKow0hTK7TU7tkCG8WaD4ws
 2TGtqc3WKiWBa0zuB4FpdwwLU87vIBV7wLIKvZDeHZqUDoaveJfYj0lkBJtThRUN5dcU
 GwBO/3vHdFOgWBDdcL+a49EUMEq/kSmLNPVpaVkXg2qXFHAKUQmql3tsVfUZTcU8qjUq
 euJYmJNlQ4APSSgW/KPQl2+F1bkDOFyxkCQT/jOk05LMC+fonobeigNDpTej7S/+orYY
 SBGsSGU+n2wUQP7OaYxgfzDisR8ydzqd8akQbqnBIW8cSwsJXswOL0ZVFdzj7piVXtIy
 VZUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+Op5+2t1Bx4jbcuzlucKsMd4+ZhKFrvoY8kW2mLqJQ9PExBR9189v2nwsMCyYFlNmRzI3a0/oqNDf@nongnu.org
X-Gm-Message-State: AOJu0YyyKlTLIdaIf3ykdGsm44BVJ0nnq+0C594BQ03RCt9jjKqu/8Tv
 ZACX3mvgm+tbhIEcCxCKfyvFmLHn3iseZSeFVcA7YxypewrrYSfZJzcxvjqSspA=
X-Google-Smtp-Source: AGHT+IHkDd7+rBaKX+NsJVUfKspOedGlETti41lwv4HwKpGJTfb7Vknt90RXyg25S2/TRk5AXH2u0Q==
X-Received: by 2002:a17:90a:d98e:b0:2e2:bb22:eb59 with SMTP id
 98e67ed59e1d1-2e2bb22ecd4mr2893466a91.41.1728523241213; 
 Wed, 09 Oct 2024 18:20:41 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5dd4110sm91774a91.1.2024.10.09.18.20.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 18:20:40 -0700 (PDT)
Message-ID: <2daacd1c-1efb-4990-852b-a7e6ae1bd1d4@linaro.org>
Date: Wed, 9 Oct 2024 18:20:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/23] accel/tcg: Split out tlbfast_flush_range_locked
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-5-richard.henderson@linaro.org>
 <8bbac2bf-704a-4c4c-ae7a-996f5a04038f@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <8bbac2bf-704a-4c4c-ae7a-996f5a04038f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 10/9/24 16:05, Pierrick Bouvier wrote:
>> @@ -720,13 +728,10 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
>>           return;
>>       }
>> +    tlbfast_flush_range_locked(d, f, addr, len, mask);
>> +
>>       for (vaddr i = 0; i < len; i += TARGET_PAGE_SIZE) {
>>           vaddr page = addr + i;
>> -        CPUTLBEntry *entry = tlb_entry(cpu, midx, page);
>> -
>> -        if (tlb_flush_entry_mask_locked(entry, page, mask)) {
>> -            tlb_n_used_entries_dec(cpu, midx);
>> -        }
>>           tlb_flush_vtlb_page_mask_locked(cpu, midx, page, mask);
>>       }
>>   }
> 
> Why don't we have the same kind of change for tlb_flush_vtlb_page_mask_locked?
> 
> We know have two loops (for entry mask, and for page mask).

It goes away in patch 15.

r~

