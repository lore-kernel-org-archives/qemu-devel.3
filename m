Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D7AD743F5
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 23:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDuQq-000527-1d; Wed, 20 Nov 2024 18:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tDuQn-00051u-W3
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 18:48:22 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tDuQm-0008Oc-9x
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 18:48:21 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21288ce11d7so712105ad.2
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 15:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732146497; x=1732751297; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ceBQ1WcQEgmnf4PreZghL4q47Ad34jNn+y/3w+0J9cU=;
 b=rElyIeQqdGdhFR8mzUPnDt0Egs7wbdGIMmJ37onWg4PM/UzXOUkcU4C6OBLZuTNeS6
 /HtZpIESvkWw2T33R0MFn+pCbtcAVjmJRKtkgyfBlksN0AUFNID6Fuy60TkrR97/unfe
 QNOqjqlMJTN4IO9CbvaXCEJUalaLYCuSNCWXyO/VpTl7o5u+M3R0DNGL02/CJHNgbkwe
 QaSV85uzdz3ys1Lnpr+GMrQvtcz7bcwzWYKZyl2WZ+1Od6HwzfglpTE2XVW5HzvOJ9MD
 1G1X3gHx6YiTq7bdWP/HO9+zU2PO7CfTIVdutckal1J3vOt1Ho0wOoM0SZ0VkBN+T8Jv
 pegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732146497; x=1732751297;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ceBQ1WcQEgmnf4PreZghL4q47Ad34jNn+y/3w+0J9cU=;
 b=Xu5kp15KDcIrRBE1QZ+2X0Zhv4n8PFJPLDPW8wQBmo3tVSCjJOSlcyIyaYpMtMhl6z
 E5skRRPYWGvuSXGS/fhz32S3Ne3VcBVqR2QVr3uOtfOxKjJnza+EcDiLBalipSJSXPgv
 A1stZrkcMz7cHfiHUCDoH0Xs3PNs7rL2nrp+mnylI+qHdN7OXNn3/H3Z2rS+Wzae1guR
 v9LBz9GgNgUxt/jA84TDqUYpgWJU3Qn666AzLqpI83BJHzxeC5jkFArYVBehW7rN0cZ/
 9NF+S9lGI+dMiXVpwsiLD44IRxlg8N3Jnpz3Y6nBGtpR8mD8Wyi+eZ6GAKjI9HL+iYeY
 Gh/g==
X-Gm-Message-State: AOJu0YyVVbMer1xG/GsnQ3SVWzKHYo5c8b9Cdp3N8Ld2m9nF3Gvkuqz6
 BrPYeSF7PFEwJez3yVzFWeFJwH8pHkJ6nSiUz+cUUSZn85Xi9hz006x/c8t9SJM=
X-Gm-Gg: ASbGncuwmKmVST7DyFua7FRMRNTEpRSbXDcaCmhSx9MVAHxjhZnsdxg2TnFymEzYBM3
 vNhcVv2uIb/MeG+1pe77X8ZWD629TMH+wateOe3aKFlUPKYbUGEQOIt62GClLs5G+eggFisw4Ex
 r0qGh9U/89kohEzY2neD9JEeBv98jPOmP8jAzUXTDfY/xrq0FRJGQB63H5v4cQfVIDFRgoJvO6p
 pwLIXOyV4zPrm0VzTzrq2l6UVeQ7+QVvLn/tC+CXRyWwlpflPYZagw7NDqs2/SHAEafM0B/URCr
 MyG4LyrCWKZ84BC4nrZJcw==
X-Google-Smtp-Source: AGHT+IHmTrfreGM1ooW2AADnYL9VGLRBDkPQvmuHFXmFsrSxQKnIjKTt7ZGar4hzuP0Hxqinz5+urg==
X-Received: by 2002:a17:902:da87:b0:212:5b57:80eb with SMTP id
 d9443c01a7336-2126a373878mr57178525ad.1.1732146497367; 
 Wed, 20 Nov 2024 15:48:17 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-212878b7046sm1263195ad.107.2024.11.20.15.48.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 15:48:16 -0800 (PST)
Message-ID: <94d13e1f-aeaa-4d17-bc51-469e14d3a8ca@linaro.org>
Date: Wed, 20 Nov 2024 15:48:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Status of some Arm features
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <51442716-467b-46c2-b2f7-8ffdeeca320e@linaro.org>
 <CAFEAcA_eL+F572fZpFW2+Tz6xx5Mx5ux-axe3HR_fEf43_GLRA@mail.gmail.com>
 <CAFEAcA_nBH0E6-0rnsMj6sGo+2i23kk59LJwoRyASaee3P=6+w@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA_nBH0E6-0rnsMj6sGo+2i23kk59LJwoRyASaee3P=6+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 11/19/24 02:54, Peter Maydell wrote:
> On Tue, 19 Nov 2024 at 10:09, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Mon, 18 Nov 2024 at 23:33, Pierrick Bouvier wrote:
>>> 8.4:
>>> - FEAT_CNTSC, Generic Counter Scaling (hw/timer/sse-counter.c)
>>
>> This is optional, and we don't implement it yet. (There's an
>> open ticket for it in Linaro JIRA at
>> https://linaro.atlassian.net/browse/QEMU-309 )
> 
> Oh, and I didn't notice you mentioning sse-counter.c here.
> That source file is for an M-profile device, which performs
> a similar function to but is not the same as the A-profile
> memory-mapped counter which FEAT_CNTSC is an extension for.
> 
> The A-profile memory-mapped counter is technically architecturally
> required but in practice none of the guest software we're
> running on the board models we implement cares about it.
> 
> We don't model the A-profile memory mapped counter, because
> so far we haven't had a real need to. Modelling this is not
> completely trivial, because in a system with the memory
> mapped architectural counter/timer modules, all the CPU
> generic timers (accessed via system registers) are supposed
> to take their source of time from the memory-mapped
> counter (and so for instance if you write to the memory mapped
> counter to stop it from counting then the CPU generic timers
> also must stop counting). So you need something similar to
> what I implemented in sse-counter.c where it provides an
> interface that other timer devices can use to consume its
> count (sse_counter_register_consumer(), sse_counter_for_timestamp(),
> sse_counter_tick_to_time() -- these are used by the M-profile
> hw/timer/sse-timer).
> 
> I do actually have a hacked-together prototype of this for
> A-profile that I did for something a while back, but it's not
> really in a state to be able to post upstream currently
> (I just did the bits I needed and didn't really finish it
> out or test it very much). So if we need this (e.g. if
> we decide it makes sense to implement in the sbsa-ref
> board) we could do it. But there doesn't really seem to
> be any requirement to do this work right now.
> 

Thanks for the insight Peter, it's very helpful to understand.

> -- PMM


