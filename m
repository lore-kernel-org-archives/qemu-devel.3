Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA7FC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 18:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5U2X-0006mq-LS; Thu, 17 Apr 2025 14:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5U2W-0006mX-Qo
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:32:44 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5U2U-0007iY-Gv
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:32:44 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso6196915e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 11:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744914761; x=1745519561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3gozWWANGHKh7qyBKz63BOtA7BM13H5l1ad6B18mwq4=;
 b=GOWJx4oP9aGTXyiCWVuS1S+sfroe24ulZVrXoL+DvaN1l8YolIElhC/D56W4RwP2Xe
 BUCqKm6bFIeNsSUTfQ0Eu2eV3w5g5pCVdAaTWZccvpidEifbCyWszKZa+IKEUm1B+PAY
 8YRf17RiOvogXE3Vmu4gKeY7RFDgurWrHqBfAacgLCgQ8+K3Fi5dhCR9D3X2ddBAUMoM
 2aX/bWi74tlCn61b+EhPnTctKj+aM9lvlfLPWI/g5uZhCWVJOwA8SShPmRcpZkoJ6Rqg
 xqdGTvkWJ2XmtmWx8mHb3FeFFshISiDVm/ipC6C5gV1Pd/JTCeyzlG81Qt4ptRC02fJ3
 7pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744914761; x=1745519561;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3gozWWANGHKh7qyBKz63BOtA7BM13H5l1ad6B18mwq4=;
 b=d0n8mKbwfQEg5Lsttkri0MPqXihxwAyiEEBNCTAJ3JFO91Ve0gLSiKBhI5y1QTEWxu
 AUX7ahaChyyP1VU/EJuycsL9OfhV5IktofQjhejtsCUUC4dmLTExW2LZHKOBQzaaRonT
 HzHGNWBckwN8qywgL21CC2lRRB3WnkTz96MmqvAWbJ+5krX0hu/01FSdP/0cVJn2397t
 YRq7Jtl/uZZKbTOTjjp23PfwXAPmr8oF56hSRHKdB1Zp7bUT1yU3T5qWh4qqvVbyQ63W
 Ft51NKWQBVZWIDcq5msgsvtk+4eO6NtNJ9Mh7ZDweRCh6pL1NkLu0F5o8+ghdGvBLbkK
 xTNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR3xdKyNIArlrmqrja978fPxh2wnPfCyUgY61//T0wR92ZP9CPuKcNOS0CTKqQ0k9eyOvBd6gZVaKN@nongnu.org
X-Gm-Message-State: AOJu0YzXQKxixWY+QKIDz5Vh2WbWfJ6ON4Dr+eGR8XZVDw0YGK3OZJXi
 HK6CMeL0e4j8Terf5rQVzuAcqnRg5nDvo+Bjj7U6/XrMR/sB9yz6jDRxQODFwTU=
X-Gm-Gg: ASbGncurMoOxyrzhYow0K76H7F1icqmeFybR+XO1IuoY5Bl3nEG6J1YUsMbgOyEj89R
 O7vceNJt0JHH3FnLQ/HcfzOx0rSvXE+JrF1UkFmqJNRL7IitIQ6qgsYwquUqwT2pPnX5O6EAp9G
 ph/zZAyn9WTO8Dzwlu5ai9Q/Zrg4r5ngFHU+Vc3PmshlffWO19ypkkJXYdyOcRLxWDINqztDjYx
 gdWbKIkM4HBkY/5ES04JVG8fpAgDzH2G+WYo31OYSSg4lUSFP2FpkYGrUxcC5KrFfWuNUIp/brY
 CvuwOtSJt20m82R3gNLbtK5O0Vv50iSXpFpR9FGH7Q6tPUCOnn3z2In5UJXiPf0RfDfrElp5g3r
 3Yg2TjmE2
X-Google-Smtp-Source: AGHT+IGpq8v/6723kg7byAqGtl+Ppe7tz+hD5OJeKViug8oZ8b5Du1uGLy1u7uwlfxv+DFvELL63Hw==
X-Received: by 2002:a5d:47cf:0:b0:390:f0ff:2bf8 with SMTP id
 ffacd0b85a97d-39efba2ab65mr30344f8f.10.1744914760616; 
 Thu, 17 Apr 2025 11:32:40 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4403605892fsm47791065e9.2.2025.04.17.11.32.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 11:32:40 -0700 (PDT)
Message-ID: <12e7911f-4471-4b6b-9bf2-0a082cde3d41@linaro.org>
Date: Thu, 17 Apr 2025 20:32:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 06/19] target/tricore: Replace
 TARGET_LONG_BITS -> target_long_bits()
To: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-7-philmd@linaro.org>
 <58473afb-337d-40d5-933d-447531c2d52f@linaro.org>
 <e1e04023-baa8-4a1f-b8b5-64e6f5830f7d@linaro.org>
 <00989085-0f7a-4fc3-af66-b254b94a9701@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <00989085-0f7a-4fc3-af66-b254b94a9701@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 17/4/25 20:00, Paolo Bonzini wrote:
> On 4/4/25 19:53, Philippe Mathieu-Daudé wrote:
>> On 4/4/25 18:48, Pierrick Bouvier wrote:
>>> On 4/3/25 16:49, Philippe Mathieu-Daudé wrote:
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>   target/tricore/translate.c | 6 ++++--
>>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>
>>> The temptation is good, but please do not touch any target code at 
>>> this point. We want to focus on defining the API first, and we can 
>>> perform codebase changes as a second step, without letting any 
>>> occurrences of the old macros/functions, instead of just adding 
>>> "another way to do it".
>>
>> I meant to remove these patch before posting, to focus on ARM, but
>> apparently forgot to do so...
> 
> In this particular case TARGET_LONG_BITS is a constant 32 (and 32 is 
> present many times in the code), so it can be replaced as a cleanup.

Indeed. Richard suggested a similar cleanup (~ s/tl/i32/) for TriCore:
https://lore.kernel.org/qemu-devel/7f6fc0ae-6cdd-4996-b411-762019efb003@linaro.org/


