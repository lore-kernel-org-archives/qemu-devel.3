Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A352BC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0lF2-0006fN-Ft; Fri, 04 Apr 2025 13:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0lEf-0006aF-U1
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:53:49 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0lEZ-0004BC-Cs
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:53:42 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so14744815e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743789214; x=1744394014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KMUE4ODRrZF54WVXi4MVwDmTcWaQV1A34ned5569aa4=;
 b=xitkUql2n9wzWn3GguRJP5SNT6buz1i3BnECkJT8cxVJ3Wda24IFvcy1ceFS868ImR
 OQ8F6VsC543yCkAqTKBgIlF44owGbGSlOxg7jCB4AsIVmkHt38wRYPzofoKJQmEmPpYU
 b67CY+yOfSSuvfcSpfp4clmpr737tEtqcCxSbwvRLxgJLO0H794sfiF+mEJOWGlFdKny
 ho9hdGzcZkKSLpQFGwsYT+3HK3OvMDm3Tc4f3xjyK8u95hwaQDk3zTxwwtcJSNQZUDRC
 Z+BMBA/T+qHqoY2iQtY/epjv08EAdez2S6iLkA50WsFxi1LiduCkY2sLkP93O5nX+xnX
 Q74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743789214; x=1744394014;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KMUE4ODRrZF54WVXi4MVwDmTcWaQV1A34ned5569aa4=;
 b=bCp4/7+MZIZ0NHwmMMD3lc1FAGO0Z4HyCG2wnS+bkUMJ9H4PmJAZO71mobQXqCrb8I
 s5wn/OqjlsFXtxs7zcNoh3FWIkHlpYUvNJ9kYIzGzteazgKlmZfENBPhNSYKB3+gnBIK
 8U6Orw04/lQNu/t6BZFygOAC3YUv7jkuelnxIz/MtYoRTWckfZEFSCpmKP9nCZ1i0YXY
 I/JNhlXbT8N5oHGUFUZb9N4bvpoxchGpdpVXl0XJiDYZItsVbHasihm728o1bHcjssvU
 mNd6K84TkL3wO/k593T2wQACbQHUrxxw6fnDZzQYX4zCuCHiqGgPzUebspF4F9hAyYyA
 +FjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNrDTV61OgsV2sjWVERRm2P+YcADvFK8jPThmvoyq6wkaNjQEOVAAoZ6laonELDLXnBYTXh5pj8IBu@nongnu.org
X-Gm-Message-State: AOJu0YzE+GeCF2703s/WJvWVe54n1vkt6j9VfCqnfVMAdOoIhZDkbaFY
 1fCNJZJjKe+aRXldXmRCkzMbjPvtL6vJ4bG+Z/F+GUhzql1ZiYHWshKZw4XXBGI=
X-Gm-Gg: ASbGncs5am5x9NSDTUdpqp519y7GtYM8xMk23/SF16qFMLmt030YWzdM9cxNHld1hCt
 y2RmLdOWdY4chMqCtHowJKbCaDi0DTZHOYfavX5DMv4xme019mDQxEBj73XidGokC5IUoivwua9
 5bA1G2MdtSXiElZZBzJIOuwKsKBBcFh8LxxtZUWPVo298bMEd99xINi/R7Ydy5jKonbWJgeentm
 eip4CinI5wNSUcdlf9XKMDFAA7cVsrAIIiKuyA5aH3M/C7a5KoxTUQET2Wv9Kbufyv2ekr1RF81
 cojKm9I/mTqgT4r69YpCA7BroNCaLHGY8GGdiPxKocoAfdgiqfNiDbLWcr7dQju5Pq/YKsVzlEt
 SkGP3/Lu1fHL2zhLmzA==
X-Google-Smtp-Source: AGHT+IEHfv38i57hA9vbFk6tABKt4Ej6oJZdLPC0y5Ch5WJOw6tWIlsCsaeMF35tDDrxXfcVJyyUYg==
X-Received: by 2002:a05:600c:3c89:b0:43d:b33:679c with SMTP id
 5b1f17b1804b1-43ed6f4d524mr23303265e9.14.1743789214657; 
 Fri, 04 Apr 2025 10:53:34 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec36699e0sm52097365e9.35.2025.04.04.10.53.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 10:53:34 -0700 (PDT)
Message-ID: <e1e04023-baa8-4a1f-b8b5-64e6f5830f7d@linaro.org>
Date: Fri, 4 Apr 2025 19:53:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 06/19] target/tricore: Replace
 TARGET_LONG_BITS -> target_long_bits()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-7-philmd@linaro.org>
 <58473afb-337d-40d5-933d-447531c2d52f@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <58473afb-337d-40d5-933d-447531c2d52f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 4/4/25 18:48, Pierrick Bouvier wrote:
> On 4/3/25 16:49, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/tricore/translate.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
> 
> The temptation is good, but please do not touch any target code at this 
> point. We want to focus on defining the API first, and we can perform 
> codebase changes as a second step, without letting any occurrences of 
> the old macros/functions, instead of just adding "another way to do it".

I meant to remove these patch before posting, to focus on ARM, but
apparently forgot to do so...

