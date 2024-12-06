Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10090E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 19:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJeDu-0001j5-RX; Fri, 06 Dec 2024 14:42:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJeDt-0001iw-4R
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:42:45 -0500
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJeDr-0007it-LR
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:42:44 -0500
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-29e71d653fbso1313437fac.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 11:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733514162; x=1734118962; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FOSgF8zkCTzzi2NKb+iP2iacHJSxSf95nhKwpT2wqWU=;
 b=mS7mMpdoivYJ6BV5LxxkMS31UB6flwpN9bWVOFMQc4K20ZCqcb6QupLzh11Rn98mVc
 CGd1kcs69zu+xEbnvNky91jioRlNF/CFDxXqXwjCbTqv4K0202R6k3II2O5rLgsntH/S
 fC2elwlulVg6hOVXBBTYgJxHtvP8AP5BhNyajlzWj4JS4ZJC/ItSQut0K/u0n1GPTLox
 Cbz56B0PSmqTDepoZs3imOb7eU4fWfXiDhWZeX5F73rUEM6nW6bQiMVTmFir6zbzUFFk
 Co7QzNIqaw0ht5z2anRHLHiTmFQu87VxltNTLGg/q27UcKc5MYLYzUFrdGc0s8QVlEQY
 CJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733514162; x=1734118962;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FOSgF8zkCTzzi2NKb+iP2iacHJSxSf95nhKwpT2wqWU=;
 b=ZuSUxdC2E3DygpWELbV6bY4tDeN8T8gA+GvkqY29NHH9rrWvOF0NPN+uP0Cc3+8mzY
 KcCu6HMULHusH9ThL55l/j32d0FqmylPlIMGMWA7oWgR0NpHJnCrJvrGRNTB7/sxo/sC
 ognl1XAHb9IwYkoc2dWlPXPaRCpKGdJyJx2+64pvsTXbRYQp3tRa4d8cZ4SaHyLsMqAj
 KOVV0TlqSeKN7IhvoKAr/r3i15ToOBfj8DgSqtEIAyRBVNuMm6PXlUJwTjALqcw1k0TR
 jNe77wRfHlrEn54G7Y9R2YL3GI/ycs0lx8Kk8HRnCICgya6V9nkcxcQU2ovB3tu0Zs/z
 HdeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGEsnBw6+UPnQi5vwMNwnUyr5lPKij7UDiyu/vsdO+M7/ahUvsXYW1XhczHC6XlqBy7q3qac5diylx@nongnu.org
X-Gm-Message-State: AOJu0YxQaijLqUk2hj4HlVTfFwXohjoJP4zQD0VzdqJ/53tSnPj5xXGF
 0mhDjmiSDwz5lyJMdXtdaSG0XUoR/SekQ0YLgHCAqADlIApHlBazJnCjGOXTyN8=
X-Gm-Gg: ASbGncvLfWvDOV55muGH1d6VpYkD+mjJMPogkGPXSvWYkPw+1ZZMq8ZTjET0kkkR7D9
 Jw+C7JQYVZpdR5zPmyofwC/PSusSR42YNmwax41FzMXBnWW7I0jccZnl19Rlg9k5KAsNP3VfEhc
 f96f0xGSb5ycQB6JLOzoIRtDknBxQ2cq7GtG9Yocqd/CTnBlM1YKDdgMHxsZwBXLLMDFy5hCl7e
 f022SYY5dXYmfLv5zntjwwY/hKfrZ6jzPNg48Kze9cOrjKegtRp2OL7R+KtDPPHXJ3U8HQDZlD8
 K1uXdO5dODeIAeMzkLyOruReidAD
X-Google-Smtp-Source: AGHT+IGM50vRzcQLCQQ2ZFVNfT+U25ERVDjfRn1pN08iq75AN1T8Ypfw2cBhxvdw2cauP2TBhzLzpQ==
X-Received: by 2002:a05:6870:a98f:b0:287:471:41eb with SMTP id
 586e51a60fabf-29f731b2911mr4712330fac.6.1733514161982; 
 Fri, 06 Dec 2024 11:42:41 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc4a029a7sm894765a34.44.2024.12.06.11.42.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 11:42:41 -0800 (PST)
Message-ID: <b02abe90-d57b-4010-aace-1b47d92e5c26@linaro.org>
Date: Fri, 6 Dec 2024 13:42:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 11/11] tests: add plugin asserting correctness of
 discon event's to_pc
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <cover.1733063076.git.neither@nut.email>
 <36d316bf3e8b0aca778c5e8d1acde39a7f361946.1733063076.git.neither@nut.email>
 <d4b17c7d-c1d2-4e43-8eee-d1667e3ee5a2@linaro.org>
 <0e4171ca0baa8727c0bbec7a25fd72d8b8e1e4b8@nut.email>
 <997e809f-832c-4bbd-b27e-a722ac835b34@linaro.org>
 <450f3beedf979437fa3de8bfab1ee72f66c67ada@nut.email>
 <cda016be-c82e-4b54-a506-22afe6ec2eb2@linaro.org>
 <c850ee89e15d2775e7c0137a218286e7060874dd@nut.email>
 <867d8a3a-ddf4-4655-9bfc-51c1a2ad8203@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <867d8a3a-ddf4-4655-9bfc-51c1a2ad8203@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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

On 12/6/24 13:02, Pierrick Bouvier wrote:
> On 12/6/24 00:42, Julian Ganz wrote:
>> Hi Pierrick,
>>
>> December 5, 2024 at 11:28 PM, "Pierrick Bouvier" wrote:
>>> On 12/5/24 13:22, Julian Ganz wrote:
>>>>   December 5, 2024 at 6:30 PM, "Pierrick Bouvier" wrote:
>>>>> We can store the next_expected pc for each instruction (from current_instruction + 
>>>>> insn_length), and we should be able to compare that with the expected from_pc.
>>>>>   This is mostly what contrib/plugins/cflow.c does.
>>>>>
>>>>>   With that, we can test from_pc.
>>>>>
>>>>   I'm not confident that this will work reliably for branch, jump and
>>>>   other "interesting" instructions. But I can have a closer look at the
>>>>   cflow plugin and try to figure out how that plugin handles those cases.
>>>>
>>> It won't work for latest instructions in a tb (because we don't know what will be the 
>>> next one), but should be good for all the others cases.
>>
>> IIUC qemu will schedule interrupts "opportunistically" between tb
>> executions. If that's the case we'll observe interrupts exclusively
>> after the last instruction in a tb. That strikes me as a serious
>> limitation.
>>
> 
> To reuse fancy vocabulary, maybe we should have a distinction between inferable 
> interruptions (interrupt instruction) and uninferable interrupts, triggered by an external 
> event.
> 
> In the latter, it *might* be acceptable to not provide a from_pc (let's say a value 0), 
> because there is no useful information in itself, except creating random edges in the 
> control flow graph, which we don't want to do.
> 
> What do you think of it?

I think you both are over-complicating things.

Always, env->pc (or whatever) within cc->cpu_exec_interrupt *is* where the interrupt is 
recognized, and *is* where the discontinuity occurs.  Report that.

Just because some device interrupts are deferred to the end of the TB, that makes no 
difference.  There is no "right" answer for timing between execution and asynchronous 
interrupts.


r~

