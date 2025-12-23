Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B55AE6F092
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 13:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY2tY-0003Zx-Ej; Tue, 23 Dec 2025 08:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vY2tP-0003Tk-Hi
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 08:57:40 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vY2tN-0003Ra-VT
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 08:57:39 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-477b5e0323bso30644865e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 05:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766498256; x=1767103056; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0zv0VoXQw0uynzKEYuj8FiOWleU24kANb4bceU8fZX8=;
 b=OPbobBwZnNhsFeCNtmlh8UqFpQ/EKkYduJ2YVOc9lsmvi6Y3rxY9uvoJEHm/oVa/Ad
 FkQREx907JohN7t2rptCrUn0DXClWPHYOwlL5UQ+jUFof9TpYSHd05U4FDaZ4kE1NZ3z
 21sZnPjJoxBwOUUXLWvXQjcZcG66YOPt4O4Nkz/DBbUwZh/D1ueEC8WHDOaAgx7ZtL9I
 EZXTP5REh1u5yVbRjQyYCnjlog47bOseP15R5L1TahCQOsB0wmsMcPB1ZA9TIP9eiopF
 io+wD5ud+BUYpDSRVbizHDhzgwtxo/pgpDI7Iv+507tYBkzFuCjW/fDESkS71rFoSSp+
 eVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766498256; x=1767103056;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0zv0VoXQw0uynzKEYuj8FiOWleU24kANb4bceU8fZX8=;
 b=occKqfpFzmhRzpW9Yrvjy8qPWNT5UYLEgRGnrRe3xv65PqOJcvb381IUEe/N738djk
 gt+a2A+GqfFElWzuPgBpuybMBs27bw0Aab5Cm+VJ0WOwm2CrsTzzz4vNoMAa4dxIpbqI
 e6NKZ+VwsevzIe0oOzfZJ88J8whgpnnM1RHf6dzHZZlTGTayTBdrS99OaFuOZsPEhf8Z
 q7rd4FQBxvTXOjSL9N4xT26PWsU/5V4Brb3EKoXwupnZthYspWOn3WWgQyc2vMjcPwZs
 BX/jMRZ36ETEb95US2pt4JsjflXkCinWwqh/Db1GwuTrl43PWJzzESXarHJ57dwsLnCg
 ibyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/YfHH26SuD+qUzgR+bCiTHjGKUeeU7DnmJxaXwgr6lqyYHO8iq0r3xy0LUHBAAV+UfImQYwBHH+g3@nongnu.org
X-Gm-Message-State: AOJu0YxHOXPZcMRBYvcptPTvlWywXJD/iT+HnnGGaJU4SWIJAdlEy56d
 EZTBM6D53QMW3+2C3P9nZt/e5jwJP0tUqxSZrJZ3yTFx4O0qxLHS+J61hBqWP0WurAs=
X-Gm-Gg: AY/fxX5RhsIsjfBVdCqd0mp7jqcjq8W09FnPgncgbA+jhGoPjy3Yx5RyT/HCxI0LKE/
 fq7Bu/h1JmTFSrh19EFOk3RB8E2M10PwmSlAGhWnoJqY8qWSychXn5Gi4DQYcY6eTI5PqShXAoJ
 gLvkkGIv0+MmRGYFAa3crCwNg3wsG4az0ioSWCbE2HmUxYhPmH0EME0D533QUPPHUaWRC4YSQho
 vBos7JOZJxiLzgxQ7WA+TyTuIiZ5YpBUinvoibQMsBSEtn5LoNf1mio91g44HaoYHAmkJ9sZyO3
 WWJuEfNTVIY7Cqd5RUhwQGd1L1g1DXLeswCbB/hPYKR1NWlV1xslvrwoG7+C8I1F45ec3oc2XOK
 FZqimNueMVyB4zfwVgCXetCa6H0I5HB+6c11J5vMDZ1FDgH/b9ApYsYtL3bbSFTAxBxD+2220l1
 elgaJqqgVafeQf3McOi9vtvqMeKba4F0omdDSKhCS68KpZXaInwodisA==
X-Google-Smtp-Source: AGHT+IGDcscRup1A7RVk8570BcZZ1hRpyqwCBafJrzBFSK+qFgNDNp6nf6WgS0eY7YafLeAGJ7PPig==
X-Received: by 2002:a05:600c:5489:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-47d18bd5651mr148920495e9.11.1766498256109; 
 Tue, 23 Dec 2025 05:57:36 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d19352306sm237822675e9.5.2025.12.23.05.57.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Dec 2025 05:57:35 -0800 (PST)
Message-ID: <417ec469-91e3-4025-941e-f1587f5ebb15@linaro.org>
Date: Tue, 23 Dec 2025 14:57:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/core: remove duplicate include
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com
References: <20251126210832.34011-1-osama.abdelkader@gmail.com>
 <0d6a818e-1007-4e98-8504-b5e88a30b51f@linaro.org>
In-Reply-To: <0d6a818e-1007-4e98-8504-b5e88a30b51f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Hi Osama,

On 23/12/25 14:51, Philippe Mathieu-Daudé wrote:
> On 26/11/25 22:08, Osama Abdelkader wrote:
>> qemu/target-info.h is included twice.
>> ---
>>   system/vl.c | 1 -
>>   1 file changed, 1 deletion(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> 
> And queued, thanks!

Actually we can not take this because the patch is missing your
"signed-off" tag, see:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#patch-emails-must-include-a-signed-off-by-line

Replying with "Signed-off-by: Osama Abdelkader 
<osama.abdelkader@gmail.com>" would fix this :)

Regards,

Phil.

