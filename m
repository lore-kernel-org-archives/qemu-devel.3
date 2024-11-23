Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E86AE66887
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 21:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tExPo-0006Pg-Bi; Sat, 23 Nov 2024 16:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tExPn-0006PT-5L
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 16:11:39 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tExPl-0002CR-LF
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 16:11:38 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3e5fb8a4e53so1742716b6e.1
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2024 13:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732396295; x=1733001095; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tPKfGNEyRSY/o7QvG6NgKCJwc+Q8+6gq0AVa+kdK+sg=;
 b=gpduLBPexP+VGFITRhb8GKaCNQw5V6PMST2G1ioxwuSn04er5XESjmIgpuO/0i0Ilu
 BPT0xbwwXPsgkYsZzyTWI7qvGUeODOz+EFE+3LsaKKsxPYQO+I4I91oaYrmIALsX3D93
 DW2Cy3BT7MvcVZfcfGGsoluvY9kEE9AelAaLjMu7sA7VXhM0LPY5inZK4s1Qsbhp5gZs
 goTW2XiIdx5NOuTewwOX/GJnOT++qVlswz3mdk79CyuUItJfCT8Ojcrc8xoewEe2fXJA
 VNY5lAJr9Tmbrc7xwTk9SKQ7UHQlr7oQnHlR2kG8l9zFB8bIk4V8gwV6/6Lk3AjL5Ega
 YwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732396295; x=1733001095;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tPKfGNEyRSY/o7QvG6NgKCJwc+Q8+6gq0AVa+kdK+sg=;
 b=tROnYRGHmgDqXdHmhiEiydCkTquqwsU8QO6OEEmlLewBuPumoZ8WHsmCBy9aidmsHI
 ucdfvC+F8fhnF2D4MF8dm5bDMDGpgbvJULolb4OmjdER3FIt1jUpsHHzPhH14vtNsviw
 MAx+lZtfWuE7GPVywTolVFOqzTF8JXx0cZxAChCkH7pCIrj7Lic9DBI/4qCx5du14/Nz
 eEeH33NYXlet9sgj81Oes9A9h5uyQzGF4xno93FiLZywETJGlxui2/NbKocHTukbQT8f
 nIxFbVU/lwK+3XCvPv3m08GgnGqR67FvouwgCX+8DmHGnjI/oC0qWOypbsaSjvc0kSGJ
 qdHQ==
X-Gm-Message-State: AOJu0Yxj04oaXVKGul7mL7+OZ9Xw9+yLu8heH83EQev1jc76yTOcZPg0
 5cH2gks3Ix6c5bfgQHUH1W5zKvmStmJV0Ge6Ps9TOm36VbinCpKXaTmHv5MskDA=
X-Gm-Gg: ASbGnctftcd8xIozJNvxnfyUjumfZ34b9LG1O/XVk2LMuQiQ75+UUlcFQOIk7gwgrel
 6rVRuC7zqBuOQvXxYjzwpsrYce1WykyqJxBxnWKj/UA7kviovjS7epJJydaLgqBA9IED6ID4Ffl
 jWahbJ/TSfFLobmeb2W63MgJ7qozPHerCTbv7bkoPL+LepO23NzNKE11W3lzA/hQLSnXbtPs1td
 QvUCMHRcISJiEV6HvQ9++tF4UYK054P5U2GakB1sLMmexQ0h6gNac+xEnXDuRj9AA==
X-Google-Smtp-Source: AGHT+IHM8VovWd5A+/io+VRmgDuXhunf/gX9+yCm787a4dbIhY3aLRYnpNVve+3VR0QizxA0oGJR+A==
X-Received: by 2002:a05:6808:1b8f:b0:3e5:cf3b:4fc5 with SMTP id
 5614622812f47-3e9158214d5mr6529557b6e.15.1732396295662; 
 Sat, 23 Nov 2024 13:11:35 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e914e9dca5sm1220576b6e.22.2024.11.23.13.11.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 Nov 2024 13:11:34 -0800 (PST)
Message-ID: <80bb66bb-ea84-4902-8dfe-fd86c55a6bcd@linaro.org>
Date: Sat, 23 Nov 2024 15:11:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/openrisc: Fixed undercounting of TTCR in
 continuous mode
To: Stafford Horne <shorne@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20241123103828.3157128-1-shorne@gmail.com>
 <20241123103828.3157128-3-shorne@gmail.com>
 <0105f2c1-9390-4557-bfad-668a328ce951@linaro.org> <Z0IMyRB3O4Q9s5eG@antec>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Z0IMyRB3O4Q9s5eG@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

On 11/23/24 11:11, Stafford Horne wrote:
> On Sat, Nov 23, 2024 at 07:39:57AM -0600, Richard Henderson wrote:
>> On 11/23/24 04:38, Stafford Horne wrote:
>>> +    or1k_timer->ttcr = or1k_timer->ttcr_offset +
>>> +        (now - or1k_timer->clk_offset + TIMER_PERIOD - 1) / TIMER_PERIOD;
>>
>> Better using DIV_ROUND_UP.
> 
> Sure, I can change it to that.
> 
>>> +        /* Zero the count by applying a negative offset to the counter */
>>> +        or1k_timer->ttcr_offset += UINT32_MAX - (cpu->env.ttmr & TTMR_TP);
>>
>> Since UINT32_MAX is -1 in this context, this appears to be off-by-one.
>> I think -(ttmr & mask) alone is correct.
> 
> Thanks, I did send a mail to Joel asking about this bit.  He didn't respond for 2
> weeks to I just sent the patch as is as it appears to work.  As I understand,
> yes UINT32_MAX is just -1.  But why the -1?  I guess it's because after
> ttcr_offset is updated we call cpu_openrisc_timer_update() which calls
> cpu_openrisc_count_update() to update ttcr.  Since a few _ns would have passed
> and we are rounding up it will update ttcr to 0.
> 
> But maybe I am reading too much into it.

I think you're reading too much into it -- I just think it's a bug which isn't 
particularly noticeable because the clock is only off by 1ns.


r~

> 
> If you think that makes sense I could add a comment as such, also I would prefer
> to change to UINT32_MAX to -1.
> 
> -Stafford


