Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8367CE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 15:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVuPJ-0007PZ-2S; Thu, 09 Jan 2025 10:25:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVuPG-0007Oa-Sz
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 10:25:10 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVuPE-0005zx-Pq
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 10:25:10 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385dece873cso579230f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 07:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736436307; x=1737041107; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OCUJyk1ZYRLWDbnvJbJn3JTBMdTvNbnrCFvl77VNn2Q=;
 b=avfcQs6zxVWgIASQl6APG3dsjcsraa5lH6mZiODBengGt+OhjG+novLdb5x6wOKml+
 0Pt/XhzLhiB1ZDzNYeUPrzkSItgSV4ZHXjN09JFRDoU00gCjV4wrPDiUgga3ouN5vTQw
 kUwzBMTPXyEXUjt6OvE1TmWIYYU1pHl9zakwcwxGukIhVE9Vh+WZSrbOtH3jMKFDsxgw
 e0CfjnhyiFDpEPuGwFxBwuqw05IalnhGnK0jjRp4RqCrAsA8+uLjlxJuS2o6sP0cjPUB
 85qFP2n4IzhHV/0UkORa5jZ7dfq1KjChIIwdQ9zcBgXwOPG5EmOnS9vvtbblGCOvpqdc
 vjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736436307; x=1737041107;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OCUJyk1ZYRLWDbnvJbJn3JTBMdTvNbnrCFvl77VNn2Q=;
 b=GRaIG6YEp5rYuN2GNzX2xKCt7ZF08w/p3iPLz6scWsbqcrKapgk/xkGQEjaVWwT2MY
 BgPDjW1BTZAtKSREQzc7Ek8fKDOWY7gotnnH7W6meJv4gpNRJLUOyKs1Py4hO1j+vSrK
 dAH73Npvx9LfaA9aTb6OLf/3xgLxnsl1zPdn531SVhUHUjYIgI+c+bnq5oOcrKEglwm2
 xxAib2AQKZFFM1GBxNRcXq/XQH1OsOEx5dCG6D081HBuix9evLX9CMUoymHmVwMtVS71
 lDl48YdVdrjcF7vQGkqbHu+caVzVfTa2WIRJ3EC+SZk2m00/1BAIcx0xCYIXbm5zyY/t
 eozw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhY0dfLId4hBhT3vJiPmYv435OfyTE0Tn8d7EiiR0EBBdTIzvquXONGNsbX6jcW7MQleQaxFW9e/44@nongnu.org
X-Gm-Message-State: AOJu0YxpqiFVcUMPF1xRw0hS+uHFsuqca9ULRG/lTgSBZCEBEZ/Wb36d
 2PqIV/qL8J61ju4Y2n5Y3lVQ4n088/aNPSVr3nld/PGOlnHlJf5dWM93ahKjPNQ=
X-Gm-Gg: ASbGncs5YKqQavpPPvRUENxsA4Gw9bwXz0i43d3NtfQvdhWQevSsxAdE5v1gGNYjAsa
 LrMMOUPlplZWfU5t4wNDSw0dzpq+QUMWTx6Ktrr56z6rTHxUDlBVGLRv6KOYyxy3VkBlagXM8mk
 yb45eSwAshcZOj5BIe/EIDyOvMzd9IKschJMTwHkJ4GRXRyVJij/Bk6wpHpmemcE59ahrYlpdQY
 852cX2pceN+XB29fyucOMlW52VuqW/M+qRoxtPiouyRHXfxqT0/kmWDIsF4boy9jv4djmBV0+ST
 8Mdq4hpfkkrV8vjE9T3BE7XZoww=
X-Google-Smtp-Source: AGHT+IEnC2idJ71eGb3dVYRv9KYp2F6DmDa7EZwJ84/+czicVxBYfNUVs/iUO3vqRjonGKunGtEegQ==
X-Received: by 2002:a05:6000:719:b0:385:e879:45cc with SMTP id
 ffacd0b85a97d-38a873045d9mr6035262f8f.19.1736436306826; 
 Thu, 09 Jan 2025 07:25:06 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38325esm2086132f8f.27.2025.01.09.07.25.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 07:25:06 -0800 (PST)
Message-ID: <80c3d02f-30a2-4b60-ba58-c2db17d15a0c@linaro.org>
Date: Thu, 9 Jan 2025 16:25:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/qtest/stm32l4x5_usart: Avoid accessing NVIC via
 MMIO
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <lvivier@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Samuel Tardieu
 <sam@rfc1149.net>, qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250107192637.67683-1-philmd@linaro.org> <87wmf42fam.fsf@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87wmf42fam.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 9/1/25 16:11, Fabiano Rosas wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> The STM32L4x5 SoC family use a ARM Cortex-M core. Such
>> core is architecturally tied with a NVIC (interrupt controller),
>> having the NVIC MMIO mapped in the core address space.
>>
>> When using the QTest accelerator, we don't emulate vCPU, only
>> a dummy is created. For now, QTest is only supposed to access
>> MMIO devices mapped on the main 'SysBus'. Thus it shouldn't
>> be able to access a NVIC MMIO region, because such region is
>> specific to a vCPU address space, which isn't available under
>> QTest.
>>
>> In order to avoid NVIC MMIO accesses, rather than checking
>> UART IRQs on the NVIC, intercept the UART IRQ and check for
>> raised/lowered events.
>>
>> The sysbus USART1 IRQ output is wired to EXTI #26 input.
>> Use qtest_irq_intercept_out_named() to intercept it, count
>> the events with qtest_get_irq_lowered_counter() and
>> qtest_get_irq_raised_counter().
>>
>> Remove the then unused check/clear_nvic_pending() methods.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Based-on: <20241216141818.111255-7-gustavo.romero@linaro.org>
>> "tests/qtest: Add API functions to capture IRQ toggling"
>>
>> This patch is to fix the problem reported by Fabiano when
>> removing the &first_cpu global in qtest, see analysis in:
>> https://lore.kernel.org/qemu-devel/05820c9b-a683-4eb4-a836-e97aa708d5e5@linaro.org/
>>
>> Note, while writing that patch I noticed a problem with the
>> b-l475e-iot01a machine. In bl475e_init() somes output GPIOs
>> are wired twice. The EXTI outputs are passed to the SoC with
>> qdev_pass_gpios(), and few are re-wired to the various output
>> IRQ splitters. I'll open a GitLab issue so it can be cleared
>> later.
>> ---
>>   tests/qtest/stm32l4x5_usart-test.c | 33 +++++++-----------------------
> 
> What about these other ones?
> stm32l4x5_exti-test.c
> stm32l4x5_rcc-test.c

Same changes, but I'd like to get feedback on this approach first,
because we lose the NVIC coverage. If we want to keep testing it,
then we need to rework the qtest mmio API to somehow specify which
address space is to be used; or a new API to resolve a device
particular MR and access it, without using the current global
sysbus address space.

