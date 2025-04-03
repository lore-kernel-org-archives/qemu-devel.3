Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293D9C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 19:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0QHu-0008Ve-F6; Thu, 03 Apr 2025 15:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0QHt-0008Un-4z
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 15:31:41 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0QHr-0004ar-Bv
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 15:31:40 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c0e0bc733so1074564f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 12:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743708697; x=1744313497; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9g7eG4ybf9Oeu2+Xs4DMroYWMhfhe3xlvcVpLg8lncg=;
 b=Wtm7W/dp/C8U0pNOYKSVzYhy+sV0buHPl11BEjfbMkMkqlJOc86cEanVqz7t4xE3k5
 b4D0QK+5WYgpNATfsi4p+jL2XjvVv5nuK7uoFOyhC0wt7mge0SVzp7Yz+WH1wwgp7PL3
 pk1zDJHN2M4cL/mSYkrYiCxe0l1cxLlJHRf67ceTTkyeAi1TOVKF3nn9eB6oB78BpEMF
 IeOC2HcRvYHbT9FzD5qGtnOEeDDR0NXZdtjGJfoG3QX/ABvSawJ0q3X/qAGVkj1VWhox
 MEWq2m081I8Q/8bZ+882gmgF4yDqfGjVqSJvZ9HD2XiF6zrOoXzbipb2Lf0BKyHToGb+
 bFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743708697; x=1744313497;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9g7eG4ybf9Oeu2+Xs4DMroYWMhfhe3xlvcVpLg8lncg=;
 b=b188MQzS1zI1teobKBZh1f7+/7gOz5L8+COfZ6FswtKw3Y+1pkRujotBj4mYy+DiMM
 XJXUSl5AIPYeD5eOq7NRyH+9HYeAy65gqAPfq7v5LZTNq0cSsfTSPojSacgyBPjbHW9Q
 IP07OrNQpy3AITDoQGufCLvXkyd5+A9E+o4qlPvWBQq9OKYJ2z4bxJaSK4vtdUnr/r0+
 vZyyuPkuOkm+lbW/TOl9bli8bw325dA67vNzo/3Ofn16dc9PhjkBmW+vBxTfQTTqVOPc
 Nqn0HUFlJ+heUP+ph0Jj9EnFa+SfNkylFEk6eFP/SxU+lAwqcC+UwA5d1f9TVuB1FoSN
 z5Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvqbAqHxxwnfl4Ty4PYpp0DHREK7aV+lSTUObJQWEl6nNes2t2xFD4dET+NXRHbCX+HVz730xo418X@nongnu.org
X-Gm-Message-State: AOJu0Yyz9DQjVbLIvCzz11gt2zdbU7RHpd5udMycbYa4Dm+kKtTyKWZc
 b8A2RWcGBnaoOdeSqsSFeizUIy6RSoNt+lDFEqSHb46IukJL8HidTky/4p0qcyI=
X-Gm-Gg: ASbGncvYCPLqwbTVvT+c8TuUWfzAWBfYhOYP8u7Zekhp8zDuR80T9iBHQMLhyS2CcEq
 8V7wIT29wBx8qJEUsHvnwzzS9fmG9tHy3wOutcIJCaXyP9KNw7NxqeBNBnY/sh4SS4vOjx12Owt
 3wRarTcv1wJdR/uKL3JHpoSZPekR/NXZHPS6LIMk+/upDy8ENw3JxS2HQwonisMWsVQAowyrCNb
 Fz3vVhqI1/DdzQIekVLR2IAo6prWiGhCgQoKqgRgdt9KWKC6thUq/3RJpmyC7Iuee9voO/CMPil
 j1q990OTQVzXagXyjeu8Bxyc6vDQX/XJ1lNWyGuDp6SYuVy7+Yn6QoSpt0oQEd2QPJHxmzM7UR3
 4noxwxkMPoTGXJXmn1Q==
X-Google-Smtp-Source: AGHT+IFCPlo+tTL9NTpLgWX7MIIzaHPIEo0e/smlUP9LfQE4KxP7qetx/p0eTHqZpe++e9yMdd+pMQ==
X-Received: by 2002:a05:6000:4401:b0:39c:1f10:c74c with SMTP id
 ffacd0b85a97d-39cba93d069mr297130f8f.35.1743708697343; 
 Thu, 03 Apr 2025 12:31:37 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1630de9sm29596965e9.1.2025.04.03.12.31.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 12:31:36 -0700 (PDT)
Message-ID: <0ddb4f55-853b-4f52-935c-51ebed73d38b@linaro.org>
Date: Thu, 3 Apr 2025 21:31:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 00/13] arm: Spring header cleanups
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250402222334.66511-1-philmd@linaro.org>
 <cecbab0f-56f2-434a-8508-8a4df2992259@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cecbab0f-56f2-434a-8508-8a4df2992259@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 3/4/25 20:22, Pierrick Bouvier wrote:
> On 4/2/25 15:23, Philippe Mathieu-Daudé wrote:
>> This series is more useful for heterogeneous emulation preparation
>> than single binary, because it allows non-ARM hw/ code to configure
>> ARM cores, so not using target-specific APIs. I figured some
>> patches could be useful to Pierrick "build hw/arm once" series (in
>> particular arm_cpu_has_feature).
>>
> 
> I'm ok with the cleanup part, as I sent a reviewed-by.
> 
> However, I'm not sure in which context non-ARM hw/ code will really need 
> to do it. It would be better if we stick to mandatory changes for now, 
> instead of anticipating future needs, which might be real or not.
> We can implement those changes only as part of a series that really 
> needs it.

I understand your view. I had to rebase these now old patches, and
figured it will cost me less if I get them merged, rather than
keeping rebasing them for 4 or 5 releases.

Single binary effort is just a milestone toward heterogeneous emulation.

