Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA19CF45D4
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQaN-0000rL-Pj; Mon, 12 Jan 2026 17:40:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfQaM-0000qd-L3
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:40:30 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfQaL-0001I8-1C
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:40:30 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-81e9d0cd082so2538087b3a.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768257627; x=1768862427; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uvH3AMq8ySRq+Nat9ZwbkgZM/PTmv6fqakWq71OFeio=;
 b=h4EUG0yfD7mdIv9Ee7ZEK7V1YO/xJ6+DKfcw54DQbuf505w+DodW3r9bVAo2aqq1/m
 VZV1KTRkG5snOTW36rKe8Y8qmO/at7dIwSMSwV3Qsc3xK/MtKF7D52jg+GBUm/Ec1snc
 OwIa9hbKlQUtjUYYqk/zAJaMTA+aHR1uQXQ1OijgT7SS2pQRUovuYf6dj2RdYpa+sG+M
 bZLWW9ga194v3+0Rujqjec+mKHSg7AGIHA3w09WApkyaueJVrbLEg+Wzro0jJs2S+mCW
 XV09PSbRJkQ9kJ51AmuE1FzzUR4crwk4aPpBzdF2MXeVeT3c1BvSFQxg7N/kWQWoqI1m
 UJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768257627; x=1768862427;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uvH3AMq8ySRq+Nat9ZwbkgZM/PTmv6fqakWq71OFeio=;
 b=QOsjepm6GTLR4OWi+f0uvo+lVGqS+yvSL+BSBRmJYUELEmwFXXgd6jPNalqTmJ0V4U
 zNR3PqEW2jKtHbFcqhwVruWsxeTuVAGuFFVxexh9/MLonONlg9z33IiSnEUW2geaFU3a
 lpNLVm3M3aPYjp/8LfBsiXLMnEm8M/EkyKZzCVlwuiQlmTaebvZHNxmCf3sDtBoJc6nK
 u0ajhOGErYeW7wiCQAbbkQ6J+aFRn/PH3RghwVEHUw7ghJoiG+kSx9ssAX83OEAOuEe6
 kYQ9MM74LYW8/Tnxrjt8REXqFYFfKwMCq5ioenWqj8kokTAWiKAyNdyqkpJvQH6R0Azl
 9+zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPNwArhhNyzPmbf/8GhPva4btO3niaBobytWPcqETgrT1YB2AJ5UAahsLMo80jmqUwj5nscXSWcSeI@nongnu.org
X-Gm-Message-State: AOJu0Yz5jnabeuqJ+pQkGjfVxOLWk3aKVeuxcmYXIapNWqfmTfqLXZTe
 aNwKuIdkkayp9Yv88w3ODl7WI2++gz0UJxgJMZ6ZxPEE6AMCBTbFYTVZGbRpp6lROVkcgHbKD8o
 YxjHg0Yk=
X-Gm-Gg: AY/fxX5wcRKiEqGBcO7ngfJApTdGgK4knzNgMH9nB1MeY39COb5AjSS9agH4rcmgdZb
 wkTOn5W5oHk/ehtbE5idLmaj8RxPjHS43QjutYbAPZjqbhi2pkL1fSoYHkU+CAn5r4zc+DnHpB8
 LAGqMkUthc+s7De2jgYNAzT8d+sfI+4/zBVCimBUZWRo9VWW2OiXCr9c3hKcIuRUAPNxD366nU5
 sJpNwhdgfSjyCzPgL/YIX3XOHKfhB32aImVXGuiC4et0q/Rk/57c6qMBHXjZIz6IA6CUTM2++bd
 VHGKXjoKcbWFeFsWDDgP1UlL5G01YcuLiqvaggC8JuPEYCSIW+68ZRttQGeGf2xsR8CAQm5BV8j
 wqCg2N0Rr7c19QWb0E3UeIFX7hkS6KerYiJZl8NNpfd0DgOxGVjYfqu89AQyX8e5Tl0WEYlKIIa
 5OosfIV6gXml2uzfCJN41xJP6Kqco=
X-Google-Smtp-Source: AGHT+IFIrDl1UcnMyr6g/sii5NZba69IyjazLhERI+42vxb6jcEPFc3/0rx5mbFX1Wq90xJtL72pXA==
X-Received: by 2002:aa7:8686:0:b0:81e:f43a:352a with SMTP id
 d2e1a72fcca58-81ef43a367bmr6052769b3a.62.1768257627236; 
 Mon, 12 Jan 2026 14:40:27 -0800 (PST)
Received: from [192.168.15.8] ([101.187.175.172])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81e9881c833sm9439409b3a.6.2026.01.12.14.40.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 14:40:26 -0800 (PST)
Message-ID: <d77cfe7f-8a7a-4cb4-a967-fe93b2f89788@linaro.org>
Date: Tue, 13 Jan 2026 09:40:22 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] loongarch queue
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
References: <20260112070904.3230440-1-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260112070904.3230440-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 1/12/26 18:08, Bibo Mao wrote:
> The following changes since commit b254e486242466dad881fc2bbfa215f1b67cd30f:
> 
>    Merge tag 'pull-riscv-to-apply-20260109' ofhttps://github.com/alistair23/qemu into staging (2026-01-10 10:31:57 +1100)
> 
> are available in the Git repository at:
> 
>    https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20260112
> 
> for you to fetch changes up to 1a8d5e95d70ab1bdbc2a39065e9864f4201e519f:
> 
>    hw/loongarch/virt: Add property highmem-mmio-size with virt machine (2026-01-12 14:58:01 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20260112 queue


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

