Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4EAE64AB7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 14:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIUHp-0003si-PF; Tue, 03 Dec 2024 09:54:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIUHn-0003sT-Dj
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 09:53:59 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIUHl-0002SO-Mh
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 09:53:59 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385eb7ee7e2so1471640f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 06:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733237636; x=1733842436; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hP9xuVwFVjgtlUuY9OZlNjvreRqkwhQFYaN3gT97eGQ=;
 b=irc+43YTQrtowiRZys77r4BIJTyvpNpk4mWDizFsktcIsrjQkMpYJALHlpL/sz2XYT
 NciCmyZatXZLtHfS4IBgMn5PYABPHHjyZxSD0G0uCEhEMQy2bFR9U50cqvcZZWhUe5Ha
 kVuUzv2HZRh6D90a0cfImUfLZUFX8q8ZRIPG4eWDHicHFBNARqLZ8VPv974ewj0QCEOU
 8ujSrKpXEOnp6h1Z2IWKvNiq3PX1XTCzjrLdWHGT3uVBR9EzWggPvhaOkS+jl7i5Do8r
 77kGEwszv2wlQnWmNevq1I39TvqngyKqpNPiAbiAaXFUDghTGcf7esXWPgyLvjuliQbO
 i5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733237636; x=1733842436;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hP9xuVwFVjgtlUuY9OZlNjvreRqkwhQFYaN3gT97eGQ=;
 b=dhHazIJu3sxBxOYPlC3RLsnkc3P5t/kKHxxe6m3/WzdYw+2EpJY3Yulw5+5yFFVGH3
 8bTd+NvN8l82+AqInAOPHfLmhKfP1sxC25EwRbMriVHwF5tELgWcJ18UKU/Sno6K3Ekp
 +aYUhdYk3t27lb/hV/JqIYbzuPTWegYr6FuBD9B1DjAq8eXZa3429mEXUvsHHP3/cpJy
 5tKKxfGmYM5q6Vq79dCtGP7BZHCJwzJPLjWt7FM12VTfxhQQ2B067V5tMczSft+cT56I
 BWsJn1GA0gn8/u0IxpTMiURtNIjaFhdyWzregYgsASYeuZwleCsTm8HhuH9N1xMaQ863
 EfAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT0XIeUfZgM1VE9/kKLNebWLFAQUYQu5F0p2lP4JW2Uwf828dtVEMJC16L8EXXfCpTTQBTk4xZzCia@nongnu.org
X-Gm-Message-State: AOJu0Yy2PVG/xN3AflevqQ44KuCTORSBnUlSVWtqGad4zsyopCFpY+L+
 BAaPgYGSMVyEOAGOY2Qqtqe20W9U0UkKsRahjIyznrx0V8Xyp4gwvuR701eQ7bY=
X-Gm-Gg: ASbGncvC4LxEqzxo0gMusOzH+c27tgtaY700KWa7aqjb1QxmvFImoW0l8VzKzAdXEp1
 i1OYBjnM0L+1HWPqx8d4a4uTMaR12D4/bG1XOUWV9c1VNfyy5DKjWySu8K1lsK81z9lnwjFydZd
 4lGg1XDGgpugExFtyz3r7wAEQSbXQsOSRXX19FJmmkZhO8NVS0F8yK/fmdYMG8BrWhNT4rP7L2R
 0UTZ/SkYPwLWIi0y6PkIkek53f6qO3E5zF4MoiJkpyG6mPDoPOKUlvtKyeXlOOwhQ==
X-Google-Smtp-Source: AGHT+IFA6p7W30LCr8jweUtq/l3Sj4A4r59kbjW765hFbef3LqYHZby6CO9g7TwVBOZGLSHa//EZmQ==
X-Received: by 2002:a5d:588f:0:b0:385:f1bc:765c with SMTP id
 ffacd0b85a97d-385fd3ccaf6mr2555261f8f.6.1733237635734; 
 Tue, 03 Dec 2024 06:53:55 -0800 (PST)
Received: from [192.168.69.223] ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385d7264f27sm14843597f8f.80.2024.12.03.06.53.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 06:53:55 -0800 (PST)
Message-ID: <d06babd3-5aa9-4a6f-a265-45170edc7039@linaro.org>
Date: Tue, 3 Dec 2024 15:53:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] MAINTAINERS: update email addr for Brian Cain
To: Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Cc: Brian Cain <bcain@quicinc.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 ltaylorsimpson@gmail.com, alex.bennee@linaro.org, quic_mburton@quicinc.com
References: <20241123164641.364748-1-bcain@quicinc.com>
 <20241123164641.364748-2-bcain@quicinc.com>
 <014e9959-4995-4bf2-9a2c-ace318673804@linaro.org>
 <c559ec82-2ed2-4d38-93b4-9b5076181c9b@oss.qualcomm.com>
 <CAFEAcA_C5HXvMzVXQvQEpcFS67AZCa0dJL0Ek4X4tXtQfA6z+g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_C5HXvMzVXQvQEpcFS67AZCa0dJL0Ek4X4tXtQfA6z+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 3/12/24 15:31, Peter Maydell wrote:
> On Tue, 3 Dec 2024 at 14:23, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>>
>>
>> On 12/2/2024 2:43 PM, Philippe Mathieu-Daudé wrote:
>>> On 23/11/24 17:46, Brian Cain wrote:
>>>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>>>>
>>>> Also: add mapping for "quic_bcain@quicinc.com" which was ~briefly
>>>> used for some replies to mailing list traffic.
>>>>
>>>> Signed-off-by: Brian Cain <bcain@quicinc.com>
>>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>>> ---
>>>>    .mailmap    | 2 ++
>>>>    MAINTAINERS | 2 +-
>>>>    2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>
>> Forgive my ignorance here -- this T-b is - stronger than a R-b? or
>> weaker than a R-b?  Or wholly orthogonal to R-b?
> 
> They mean different things -- T-b says "I tested this patch
> and it works for me", and R-b says "I looked at the code
> change and think it's a good change with no bugs".
> 
> T-b is a slightly odd thing to have on a MAINTAINERS
> change, though I'm guessing Philippe might mean they tested
> that the .mailmap change affected the commits the way it
> was supposed to.

I tested oss.qualcomm.com is a valid MX and we can send
emails to it.

Then I looked at the recent github changes from quicinc
around oss.qualcomm.com, and that this email was posted
from your bcain@quicinc.com address. For that I could have
used a R-b tag I guess 🤷

> 
>> Should I still seek a R-b before making a pull request with this change?
> 
> Philippe put this into his pullreq he just sent out, so you
> don't need to do anything more on your end.

Yes, sorry I forgot to notify you here first.

> 
> thanks
> -- PMM


