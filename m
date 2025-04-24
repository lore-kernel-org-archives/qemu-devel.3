Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2689C369D5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u85Nb-0002JS-Pw; Thu, 24 Apr 2025 18:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85NT-0002IH-8k
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:49:08 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85NR-0003pi-Lo
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:49:07 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b061a775ac3so1502021a12.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745534943; x=1746139743; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AbBmbgvjkhL8nVWvJw08tnE3/rL/PUHv7LxMjlyVi8c=;
 b=fHSezZev6U3byox2vqzDk+yVLN3a0Oapgu3wB29b9tWC3UtAK9+CbVCLyjxqBKbY97
 dBErjSDqBoIxUs2l16SoRjbQRAGC/YpqHC6yfGAlshaATKRRMvYSuuTk6dg+7fwsE/NB
 1Wdro9SouPm84WcNN+cQ2bIUZxkw+ifv/2t24CSUmZG1hANfsWTbsJsRcb+UCg2He3w6
 BSMXY+QPXRORftrwPQ5AlhfdB3YNhLpXbzxGEVvJ30xhPu44B9df8SN0S7sCHHDskbsQ
 p3cByZJZ4ULtZq+CL0InkMOUgXPD7tFLf+jKmRxa3emZ6tceknWKuRKr53Dm8zD/A2qO
 9U2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745534943; x=1746139743;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AbBmbgvjkhL8nVWvJw08tnE3/rL/PUHv7LxMjlyVi8c=;
 b=eN1upPuRkglLHJ8Dk6ubxwORs3j94Rgbzd93P1LrWve8Euvkx1G/Pyv1767/NQsi1E
 nRJGYdq5X5VlEYjAkikrYLgK/khZcXiZhtc3OMH5AYAWIWmpOYdnhwMUPviNOZ9Q4QRF
 Pkw3K+7zFKFvpPDfArGKgrbDAnTawTGCPvsa9U4eA6wQaCG7CpN+trz+FC5A6AJRPXaP
 M5YEbAmvboMtzZJtjqo3/GUrekgWq7BH3jVUwzqPheULYmNtj5uZ9R0Ud7Qu3Xum30a9
 RINypsCWK1WGbyoKDDGJq+Gau+vGl5aIPGVeTGUxuv7fLCvJlAoi9Y9LED2O3S9wtiKk
 gjgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7EhySKAzJOnjn/qoizWn1Lgwam03750EsuGA4A3yKpQ6cnIk/gefmqYXPii7gcMF1Q+z5fUxn0jPe@nongnu.org
X-Gm-Message-State: AOJu0YwQugJO3/oxpyyySmef36Dw/6MlCLn4TaNbpPKYSU243OpxrCvh
 dP7Dqz+QOWnSPRqxQeWKKyQ695IoKeGco5v+osh3tTjPQOEwfgqq8DPNOh3q5Kc=
X-Gm-Gg: ASbGncvNQloR9kiYl0S5RalCJ3Ste6x1ajnXHbiGIVZfZJzWq4iNGNsK4xzmvD5cKLu
 G4qgH31WeeR0Kss9ei8XTvpe7gjLB4BBe105SByQRUcxrHsmy80a38tctT5gf/RNzvpSkH6C96T
 //Zj/iTL3X9kLoXAf8dAGtomZlLO44qf8ZpTKjfu+fIpIb9g8ZBxDzAG9B6nXs5f2o59aVLx6VA
 cl9X8p45yyEby4+8p95I8cxChEJ8CamuerW21TXwWvqh9uOkiougDiqa572V4Gp78OtBRbS6+Vu
 UXgHB5Ur7F5gC92K49UQWfIxbC5pthowtPelz9oAPCpq/HXDCpN/Zg==
X-Google-Smtp-Source: AGHT+IGSkAd26KaLd0Vs9YMvKZcAXCefF/ykXdlk9DuxifgkFLv4c268Dp5PeQSQRpEr0D1Y9fGPzw==
X-Received: by 2002:a05:6a21:3386:b0:1f5:8d30:a4db with SMTP id
 adf61e73a8af0-20456589fd7mr1210701637.9.1745534943607; 
 Thu, 24 Apr 2025 15:49:03 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15faded711sm1755744a12.66.2025.04.24.15.49.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 15:49:03 -0700 (PDT)
Message-ID: <cafc8d52-ee0e-4c21-aee3-906264c85f69@linaro.org>
Date: Thu, 24 Apr 2025 15:49:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 04/21] hw/core/null-machine: Define machine as
 generic QOM type
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>
References: <20250424222112.36194-1-philmd@linaro.org>
 <20250424222112.36194-5-philmd@linaro.org>
 <8c32913f-5ee4-4f17-8fee-908c48dc4506@linaro.org>
 <f35fc475-87de-4071-a183-c12d44a52790@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <f35fc475-87de-4071-a183-c12d44a52790@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

On 4/24/25 15:47, Philippe Mathieu-Daudé wrote:
> On 25/4/25 00:30, Pierrick Bouvier wrote:
>> On 4/24/25 15:20, Philippe Mathieu-Daudé wrote:
>>> While DEFINE_MACHINE() is a succinct macro, it doesn't
>>> allow registering QOM interfaces to the defined machine.
>>> Convert to the generic DEFINE_TYPES() in preparation to
>>> register interfaces.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>    hw/core/null-machine.c | 14 ++++++++++++--
>>>    1 file changed, 12 insertions(+), 2 deletions(-)
>>>
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> Maybe you can integrate your other series changing existing arm machines
>> also, so it's easy to apply this series without the other dependency.
> 
> I discarded the other series due to Zoltan comments, and only
> salvaged this single patch (the others aren't needed since this
> series introduces and uses DEFINE_MACHINE_WITH_INTERFACES).
> 

Thanks, I noticed that later while reading the rest of this series.

