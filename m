Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95486C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 08:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE3LP-0004dQ-3e; Mon, 03 Jun 2024 04:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE3LI-0004Zx-KZ
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 04:47:02 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE3LG-0002qk-DQ
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 04:46:59 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4213373568dso20225075e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 01:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717404416; x=1718009216; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LY3WpWuYpcyY3Py2xT9CgoOQWRCKpg8NMhoOciOHDWw=;
 b=SB3DXKJJqlsDXgHMMlu3ralV97vbGtSmSzMyVh9OaipmtewKkbGwFKz8++s9Ucsu0s
 tdFLRiOokduoXB6MB/5UDK77L5LhyEoLP071enhyFZB8vbVZgJBAfl/I4qqRHKj1Oesw
 5JsSrW4eQ2+034mB5fGelmuWGyt/Wy1/wlMQzOe9GUYWw1KHWd2R7+Evm48nMSwZBWSm
 1XJ9T/HDMo7vsJq13i0w3XgKRmKM+evlfhdnmlNatWJ7blev+iG7S7pihdLqvrLMljLa
 4Aurjz+nxBB2FSI0PZF7ElYM515UdWORfFWvZB5YMK5lcHjr0ZoMDpmYax2jxwL0MGhE
 RRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717404416; x=1718009216;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LY3WpWuYpcyY3Py2xT9CgoOQWRCKpg8NMhoOciOHDWw=;
 b=iJdOGiEDA8ph7EuEcuF+sFih0DLAC4gYmq8z49QfCrLUHY/8YUZTnfQsVCdVJirs4e
 f3sdaYlyvkMXIAavlvVOocIiMn/DzjoVc+r2qoGbvT1OKDTnjtEixNotMshVApOe2ZLX
 7rHoy5MEJRaP0k/74ZW0hw2fo5BFSDPlE0ZHqs/3S3UfFM3+/ShXs0Q7Aaw5WJJWTcMF
 SFhzEbMrKvEQNQ8AMISJ71AiJ1tbGUPj0aZd6RzVu4ImzYhgk3hr03925saP7n32tnnX
 VRcIcC7SEFx3n8Ea04ySWgwanqXmsZ14DoB05BQ7bOTtX/mJ1N9vzw5ljVcj80YspH5l
 XhAA==
X-Gm-Message-State: AOJu0Yx/ujts5um8wMp8XUA3NbGqfKYvwZ6P5z/Cku7Cs6XMKTijgQIa
 f8CcWI4gVUQFsAXk7gaSsRzgXpKeJYvJo5mpQZc6PJXT0LVG6xVziVabgIVWF3A=
X-Google-Smtp-Source: AGHT+IG9T1XT6mriX6omnS7HYRjP6yaCbrvRp2v3AbYwi33JZ5Oj+Oo4zqBmvkaCD5Ub4YBy915C9g==
X-Received: by 2002:a05:600c:3b0d:b0:41b:aa11:29b3 with SMTP id
 5b1f17b1804b1-4212e0b54c4mr58960575e9.35.1717404416442; 
 Mon, 03 Jun 2024 01:46:56 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b84de44sm108963615e9.11.2024.06.03.01.46.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 01:46:55 -0700 (PDT)
Message-ID: <1bafa185-25bd-44d2-8f4b-51ca28125115@linaro.org>
Date: Mon, 3 Jun 2024 10:46:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] Add an "info pg" command that prints the current
 page tables
To: "Dr. David Alan Gilbert" <dave@treblig.org>, Don Porter <porter@cs.unc.edu>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org
References: <ZiKkWCjreGOMFX5p@gallifrey>
 <20240524170748.1842030-1-porter@cs.unc.edu>
 <20240524170748.1842030-2-porter@cs.unc.edu> <ZlnajZpUHyGDTgNx@gallifrey>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZlnajZpUHyGDTgNx@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 31/5/24 16:11, Dr. David Alan Gilbert wrote:
> * Don Porter (porter@cs.unc.edu) wrote:
>> The new "info pg" monitor command prints the current page table,
>> including virtual address ranges, flag bits, and snippets of physical
>> page numbers.  Completely filled regions of the page table with
>> compatible flags are "folded", with the result that the complete
>> output for a freshly booted x86-64 Linux VM can fit in a single
>> terminal window.  The output looks like this:
>>
>> VPN range             Entry         Flags            Physical page
>> [7f0000000-7f0000000] PML4[0fe]     ---DA--UWP
>>    [7f28c0000-7f28fffff]  PDP[0a3]     ---DA--UWP
>>      [7f28c4600-7f28c47ff]  PDE[023]     ---DA--UWP
>>        [7f28c4655-7f28c4656]  PTE[055-056] X--D---U-P 0000007f14-0000007f15
>>        [7f28c465b-7f28c465b]  PTE[05b]     ----A--U-P 0000001cfc
>> ...
>> [ff8000000-ff8000000] PML4[1ff]     ---DA--UWP
>>    [ffff80000-ffffbffff]  PDP[1fe]     ---DA---WP
>>      [ffff81000-ffff81dff]  PDE[008-00e] -GSDA---WP 0000001000-0000001dff
>>    [ffffc0000-fffffffff]  PDP[1ff]     ---DA--UWP
>>      [ffffff400-ffffff5ff]  PDE[1fa]     ---DA--UWP
>>        [ffffff5fb-ffffff5fc]  PTE[1fb-1fc] XG-DACT-WP 00000fec00 00000fee00
>>      [ffffff600-ffffff7ff]  PDE[1fb]     ---DA--UWP
>>        [ffffff600-ffffff600]  PTE[000]     -G-DA--U-P 0000001467
>>
>> This draws heavy inspiration from Austin Clements' original patch.
>>
>> This also adds a generic page table walker, which other monitor
>> and execution commands will be migrated to in subsequent patches.
>>
>> Signed-off-by: Don Porter <porter@cs.unc.edu>
>> ---
>>   hmp-commands-info.hx              |  26 ++
>>   include/monitor/hmp-target.h      |   1 +
>>   target/i386/arch_memory_mapping.c | 486 +++++++++++++++++++++++++++++-
>>   target/i386/cpu.h                 |  16 +
>>   target/i386/monitor.c             | 380 +++++++++++++++++++++++
>>   5 files changed, 908 insertions(+), 1 deletion(-)
>>
>> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
>> index 20a9835ea8..918b82015c 100644
>> --- a/hmp-commands-info.hx
>> +++ b/hmp-commands-info.hx
>> @@ -237,6 +237,32 @@ ERST
>>           .cmd        = hmp_info_mtree,
>>       },
>>   
>> +#if defined(TARGET_I386)

FYI in order to unify all QEMU system binaries as a single
one, we are trying to remove target-specific bits in monitor.

How 'info pg' should work in a binary supporting heterogeneous
emulation?

>> +    {
>> +        .name       = "pg",
>> +        .args_type  = "",
>> +        .params     = "",
>> +        .help       = "show the page table",
>> +        .cmd        = hmp_info_pg,
>> +    },
>> +#endif
> 
> So that looks OK


