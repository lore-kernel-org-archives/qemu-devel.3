Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2C3C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 17:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf0Gy-0007r2-PG; Mon, 03 Feb 2025 12:30:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tf0Gn-0007iw-VS
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:30:02 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tf0Gm-00057E-6c
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:30:01 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2166651f752so93929615ad.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 09:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1738603798; x=1739208598; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3M/t/6xJsZMRaArLoz+MYFzdKHqDmiLBPzLQqi5LLwM=;
 b=MgYa6fFuw64POA+hccJeyix87d+IOLLEUN4spBzgje5hX3O34rW4fg4KSlpczITB/J
 1nP6Md5LAERgeAEL1AXtoWNIgStu5ey+poEyzXdUzTyqWo2g0EKrrmSm2ctFrLP+bVHC
 7ecpoyyn2EHf8UNkb4LFEQjeaCnxncY8lbceiBas8xrfpAzrYR5vQPVGG5+59Un5z2Ii
 cR0a9kwAwGeFI77yEqyW2C08eHQ0apZhJ6zACy788g8gssk21V8hr1ZbUy9FLbTfQYLi
 Drw4JmACshtvmetLCDc/q2qmGpFQqCIeqqA6cogM/mgWfhR5Gb8Z5abXwQeEbaXqzBg6
 KL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738603798; x=1739208598;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3M/t/6xJsZMRaArLoz+MYFzdKHqDmiLBPzLQqi5LLwM=;
 b=dCzIJC8TYkDd4bychUA+3MVJ8iUs3EXWbHCeKZwsMsRwvNE2uhQMcK0dpuJ32t3Q3N
 GGBk3fFihTg8qztkCA8mje+VqinwY9F0117TusAEX02di/hP7NFtWHGWWTtI1HNh/rZu
 7zNJ5oZCV/DmIBgqgUjpcc31iqRs80qdolVZDKJ07t/6RSmjV421s6RkV2GiixMuCVlO
 9dJk5s81fpbJbgc/eqde3qh77/Z1ItkJtRGd7KW+93ZRBnWpiHX8M0iBPeCUDZkwfsLh
 hWTc8PS/22iuyrHaoEVHjVhd8xTQXUO0dBK4Ya/Hv+0EKk+oLmM8mkRmVp2QWVweQTm/
 UqIw==
X-Gm-Message-State: AOJu0YzWLvYhMb54b6G0doGFxSwL6A7sGDuqCMZe/ilG6CWVZqN8cNrK
 kYIvOzQI995hq+2hQsY99ETIWswbCkTV6ETJGHjUVmnse8MjeVL+9BCWYy89rfo=
X-Gm-Gg: ASbGnct18CAYHx8wMLUUj7ldMxVW6iVbYen1+ReCQgvM07alxiwQO94stp5tOG3rkHL
 Odn/vqGelOPCs7g6qjvM8dYVLxAmUB6Ngj33SokInioO8O7xg9cKzAa0QvMF11IDQ05SwmSNSCF
 LmAh5bpjSMApB50ECpofsBSXkC3vp09UQ0XIDX1fYNk8jooP2EBvVygQTbEcWd9w/9TsbUx3k6R
 wjEAFnJE9o1/f+J1Poy1V89xkrxFxLnHpMNuXHiN5RIMS1z6aJP2okaWu4dgVMDOT9CMBXh+OGP
 qA4L3TGwkxWZjHCIJOKcAVX5wjy/xhE=
X-Google-Smtp-Source: AGHT+IGc2dt1fa3fF1Y3CFWUpDn++9E9tNgvvIsbn7nzBDQB/d+gO7IjWLwoI3n+AQibNPjIhivptw==
X-Received: by 2002:a05:6a21:458a:b0:1e4:8fdd:8c77 with SMTP id
 adf61e73a8af0-1ed7a479222mr38592037637.8.1738603798373; 
 Mon, 03 Feb 2025 09:29:58 -0800 (PST)
Received: from [192.168.68.110] ([177.170.227.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe631bee1sm8692928b3a.2.2025.02.03.09.29.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 09:29:57 -0800 (PST)
Message-ID: <9b09777c-d1a2-43c0-b2cb-d09f4797896f@ventanamicro.com>
Date: Mon, 3 Feb 2025 14:29:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/riscv: log guest errors when reserved bits are
 set in PTEs
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Julia <midnight@trainwit.ch>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20250202051505.1846933-1-midnight@trainwit.ch>
 <20250202051505.1846933-2-midnight@trainwit.ch>
 <b76bf940-ff55-4619-a9ae-fa65c47e864f@ventanamicro.com>
 <8149beba-66b1-4707-93f1-083b8bc5ece0@app.fastmail.com>
 <87jza7azck.fsf@draig.linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <87jza7azck.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
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



On 2/3/25 11:15 AM, Alex Bennée wrote:
> Julia <midnight@trainwit.ch> writes:
> 
>>> This happens because 'pte' is a 'target_ulong' type that, for riscv32, will be
>>> interpreted as uint32_t while the FMT being used is PRIx64.
>>>
>>> You can fix it by using TARGET_FMT_lx instead of PRIx64:
>>>
>>
>> I've sent a follow-up patch fixing these build errors, it builds on 32 & 64 bit on my system. Cheers
>>
>> As for the Signed-off-by, I'd rather not, and the contributing guide
>> does not require it.
> 
> Apologies - I missed the context.
> 
>    The name used with “Signed-off-by” does not need to be your legal name,
>    nor birth name, nor appear on any government ID. It is the identity you
>    choose to be known by in the community, but should not be anonymous, nor
>    misrepresent whom you are.

That's correct.

The reason I mentioned about the "git" commands in my reply is that newcomers
aren't necessarily well versed with git and creating a patch without doing
a prior setup will, in Linux, use login_name@hostname as author. I saw the
Signed-off-by of this patch and I figured that could be the case. Apparently
I was wrong and the git identity used is intention, so we're good.

By the way I wonder if we could amend docs/devel/submitting-a-patch.rst with
a handful of lines about how to set author in git. We have docs about how to
send git send-mail, format-patch and so on, but apparently nothing about how
to set the author.


Thanks,

Daniel

> 
>>
>> Regards,
>> Julia
> 


