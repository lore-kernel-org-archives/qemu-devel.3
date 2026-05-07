Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA95ECD3427
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 09:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKuyJ-0003gM-BY; Thu, 07 May 2026 05:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKuyI-0003fw-BI
 for qemu-devel@nongnu.org; Thu, 07 May 2026 05:24:42 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKuyG-0008Tx-Lu
 for qemu-devel@nongnu.org; Thu, 07 May 2026 05:24:42 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso4247325e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 02:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778145879; x=1778750679; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+SZY9ym3ZRMOUHL8r5XrLduG/OZnpDNwiEl5LMrvF7M=;
 b=Ek8vavgFmMMIHAo+vJQwBgN8QRxjEINj7YRPG0xkciEVQBOuJu3nifb22zaHAopZPb
 y6W6Khya4y2Dwg12b2r3voFX5z8fafgbKxtPtEUv7X66JzCHOUQ1Mqon76gZSctn0Oo2
 sKkxEC4FZad9sg9bkKarIZygnpXNtSiLj8bLdd27ioJAGDJ/keUR2d5nYZpylyE0Nm4r
 5RRDVgq3XcGmdZLPpP7PHc/9RJcwgiYWctHCs/zKbrfVh6eMoJeMVBcE4LGQlx37ljvO
 XSz8CvbarRRupP3LLCFq2T1QUiCWiI4SFD4BYQE3EwOKi6k0CgbnOE1QCXPNtTZWx6FG
 JSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778145879; x=1778750679;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+SZY9ym3ZRMOUHL8r5XrLduG/OZnpDNwiEl5LMrvF7M=;
 b=n5Jux8N328vWLZRLGsKYZ5ajqBVdYYDjVpBAdjkOB1eTIvjjjAkvoC06rwWi1tPqJO
 vYysX9XLQt0wKbaVlDJEJoWqsmGSWlsjRHzLl+gQ/7fmPLiOEwY9t4g6YzxtkV3dahvX
 2Td+ZR5NqxL306K6wxp+CMybk6oxQrzDyzFqjidICglV9loAaFowXdFkpV+8WXVb+oQG
 ulmDjDlQskWTZueoZAY8PjvvSTMmdBaNvBGgURi10mHcRFPPlhwEwAqUg6oZaJm2xunR
 hhZfaPTwGhVbfvjbGnzk04Nvm4qLEGu4ntxwa0dMtVZNvhowGTDZadm1aLn5vBsDI1Vj
 iqPA==
X-Gm-Message-State: AOJu0YynXHGtE1UIQJy3Sr15JSearGH2leEIE0q929kB71rj7reQAkVe
 76GYSTVUr5sTyFiV2O91sNosTx9uMg9CSphxXcSl6W32IBYDNEhiVj+pw31NdMeglxY=
X-Gm-Gg: AeBDievlvVj96lGd7HS7LWbpVXwukJg60J/H+JS2eYmeLRLTwjLQBuj8oNKl8b8hXKw
 GMcAHgdVfEsm6oXtkJy3ABK2WxJiWJCfxpN1rasFnukM0GjgJRWqHbhXAkcJ/BCPEtnNev/aBhe
 W0h5J0aO0siFRncbR7JZsGsxPlw6kzjm+RrRURvn1BzVNEJCjWYeouIlzpxIL+R/MR4fwellKXP
 3kdSf3jlfUjUwW/MADGuhgmZK+As9ejaxRoK4UQpvfLywP6W9vt2qiehX6B3jgmIucesxDxyYHx
 hrt1txsmugaj9JhLVJD5ozhS7BwKFR8qMVbChcDf8ac3AenhSlx+yFT0FQnIEUtHKNq76l97EgJ
 Yq6pdIF6i5nmxeG4KY0yOyycpBfMAo0xh2VNN6Q0tmEL6apDbM9gQUsUrtHtFBvlhruVwy2A16s
 WdKeXdBAhGGtOClPUirmYepfdjC/0DHUR2HRvrr5Jq5QKYA27lYpfeaQomvX7v4dUEM83YaDeCu
 jSb
X-Received: by 2002:a05:600c:30d3:b0:485:3b9e:caa7 with SMTP id
 5b1f17b1804b1-48e51f49403mr66969625e9.23.1778145878852; 
 Thu, 07 May 2026 02:24:38 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53156c95sm42793465e9.33.2026.05.07.02.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 02:24:38 -0700 (PDT)
Message-ID: <b3b36b7d-38c9-4027-8995-1f45f292cf46@linaro.org>
Date: Thu, 7 May 2026 11:24:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/10] AGENTS.md and associated skills
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>
References: <20260505170105.228162-1-alex.bennee@linaro.org>
 <CAFEAcA-oL9qJ=oXbmCZ-b9jQcv8PNA26irDFA+_yCHkqEMLC1g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-oL9qJ=oXbmCZ-b9jQcv8PNA26irDFA+_yCHkqEMLC1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/5/26 10:59, Peter Maydell wrote:
> On Tue, 5 May 2026 at 18:03, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> Not withstanding the current contributor policy there are a number of
>> areas that AI agents could be helpful for. This series introduces an
>> AGENTS.md file which is the basic guide to the source tree and a
>> number of "skills". Skills are like scripts except far less clearly
>> defined. However I have found the issue triage skill quite useful for
>> off-loading the drudgery of going through stuff by hand. I've also
>> used the issue helper to automate the task of starting a debug session
>> by pulling in test cases from the tracker.
>>
>> These originally where a set of skills for ECA (eca.dev) but I've
>> ported them across to the agent agnostic .agents directory. There are
>> still some cases where the ECA heritage shows through though
>> (specifically the code explorer skill could be better).
>>
>> I'm not suggesting this is ready for up-streaming but I'm posting the
>> collected set for comment and I'd be interested how well these hold up
>> across different agentic systems.
> 
> I guess my overall comment on this is some mix of:
>   * how much of this is generically useful as opposed to
>     stuff that's personally helpful to you and should remain
>     part of your local setup / preferences?
>   * how much do we want to put into git to start with?

Parts could be shared under a 'qemu' folder within mainstream
review-prompts project:

  https://github.com/masoncl/review-prompts

> 
> I'm in favour of starting with an AGENTS.md that says basically:
>   (1) "don't generate code for upstream, point the agent user at
>        our AI policy"
>   (2) "if you're looking for security issues, read our security
>        policy to see what is in scope and what is not"
> (in whatever language appears effective)
> 
> and then perhaps adding more things gradually where there's
> a consensus that they're broadly useful.
> 
> thanks
> -- PMM
> 


