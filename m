Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E087E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 23:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTrP2-0005uB-4w; Fri, 03 Jan 2025 18:48:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTrP1-0005tx-3v
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 18:48:27 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTrOz-0000Aw-5F
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 18:48:26 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso92201225e9.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 15:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735948103; x=1736552903; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/Z63H5Y2dRM0fLkxqpv2/fBE1ce/3HniO/yMrMqJN9c=;
 b=duZVMK27AQSB49xf/BTdabQxt/VvjQLWCvhPyb4dObP0dBY0xoEJVyFb9zYD+4+RRW
 1FRQrswdS56QGFT1ytqinY2cjoz+WQBeo+kGkcALkrFp6GvQdntif9cbv+6eGvfFsbgj
 S+PdNLzVav8N6xECoR3O2WqCS8vpFTeQhCu04+73xPepLSzbPqWcJ5WZJrT2geh2Shft
 4UG+kWUQUISmMULM+nP1MYnZiHDmBVleCvARlgLMJ2uJFx5tke3jsE0aIoAmTqdyij4F
 H9x2ENe8GH08iZ5jWQguuf96CEPwnWzLVBiWaksa+TKIeBMCMWOSuKGy+FRdXGt8Bf/d
 SjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735948103; x=1736552903;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Z63H5Y2dRM0fLkxqpv2/fBE1ce/3HniO/yMrMqJN9c=;
 b=jdLjfbBE77lvOpeHhm6Li513Fewl1Jfk71wfzoLIFX2LWNdqXEisznefxBV2GabnjA
 G8Pj7cILDUK4x6RzktSmzME8wkx+nHPCg1DVJrsgkg1KYM2dIPSyueOwWGUNU2m11+Ur
 m2tcz1REzV2lxTgxm916CluVS+U4qFicKHsir/tSIrJ7IpLEpFCaXmQLE4LYwQkCl4ir
 DbR6yh8+frXaYScq6GT6vrIyWsGPj/0/DrZa+L4E7nbz7T0MJygcjDnZeZ0dUnLoHa5p
 mXP2s2skXoghCaNoFX9jHx0Er5tdudnqozhWYP3UGfRn2yObW2TksSLPoITYHMmxwsmc
 PNfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlhliaiqDOkJirJfo3r7p6sHGs4Nls3ndkoirSwhi64hdBmbkqDLT0nDG1ccPFqQ63DCCBgc8IrW18@nongnu.org
X-Gm-Message-State: AOJu0Ywx/rOaNfz0i7/Zf5kdzBXYO3QUF/omrvq6u+qR5ly9LwLn/1l+
 L2BpK872dTlukClUXmNLxSaXB9VI3bjz/IiuvfWBj5Qb6QgkOjw3/M8B9rgcf+k=
X-Gm-Gg: ASbGnct0fMZv7XZMWrhO4ITksoKUISRiQ4DXw2X1bPVeGOTc0IokiaCMzJzLuri0dCR
 8wmVmbdhQRp832AJQiz8QDhCtnWETfBqJBehll7psMSrsawatCjHPOHRjmD1xpPzjR17yRU8CwN
 cGJZWYiFvcrkVUgh9tUHkqOrpbUaCVcqFrYHc0d7b9ggjwqDJ0Lon2sNrREJ45fcgIHNrvQPKhi
 djmBrw5IqUYQyHqZQ+rjfEvRAUrDDxJ4qZ1kN2XJhDcXCyO+waAyuSsqP4vH+F5TyWCjOKNA5ve
 LIdCoAf0oIipUH7E8oYplU/Z
X-Google-Smtp-Source: AGHT+IFegF0fei7Y+VQREkQYQd3XPOq5PWmesX6460MneZXnaWiclBt2hSfG/F679q7vadTH04RIyA==
X-Received: by 2002:a05:6000:471e:b0:382:31a1:8dc3 with SMTP id
 ffacd0b85a97d-38a222007dcmr47818603f8f.35.1735948103300; 
 Fri, 03 Jan 2025 15:48:23 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a28f17315sm36371053f8f.108.2025.01.03.15.48.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 15:48:22 -0800 (PST)
Message-ID: <05820c9b-a683-4eb4-a836-e97aa708d5e5@linaro.org>
Date: Sat, 4 Jan 2025 00:48:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] qtest: Remove uses of 'first_cpu'
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Bandan Das <bsd@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20241211233727.98923-1-philmd@linaro.org>
 <5d2a536d-9b68-4b31-8d92-6cc42ed72e5c@linaro.org> <87msg884mn.fsf@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87msg884mn.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 3/1/25 13:26, Fabiano Rosas wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Hi Fabiano,
>>
>> On 12/12/24 00:37, Philippe Mathieu-Daudé wrote:
>>> Replace first_cpu->as by address_space_memory.
>>>
>>> Philippe Mathieu-Daudé (2):
>>>     system/qtest: Remove uses of 'first_cpu'
>>>     qtest/fuzz: Remove uses of 'first_cpu'

>> Ping :)
> 
> Hi!
> 
> Good that you pinged, I thought you were looking into the test failures
> from v1. I copied you in this other thread that mentioned them as well:
> 
> https://lore.kernel.org/r/87y10jctbd.fsf@suse.de
> 
> Applying this series on top of master just now:
> 
> Summary of Failures:
> 
>   10/519 qemu:qtest+qtest-arm / qtest-arm/stm32l4x5_usart-test               ERROR            1.40s   exit status 1
> 165/519 qemu:qtest+qtest-arm / qtest-arm/sse-timer-test                     ERROR            0.40s   killed by signal 6 SIGABRT
> 185/519 qemu:qtest+qtest-arm / qtest-arm/stm32l4x5_exti-test                ERROR            0.19s   exit status 1
> 187/519 qemu:qtest+qtest-arm / qtest-arm/stm32l4x5_rcc-test                 ERROR            0.19s   exit status 1
> 515/519 qemu:qtest+qtest-arm / qtest-arm/microbit-test                      TIMEOUT         60.01s   killed by signal 15 SIGTERM

Hmm interesting, I have a "quick-before-posting-series" set
of tests, and a "full-before-posting-pullreq" one. The quick
is quite extensive, but only include Aarch64. I thought, since
it contains the ARM targets, they would also be tested, but
no...

All these tests use ARM Cortex-M cores, which have a particularity,
the ARM cores are tied to architectural specific HW (NVIC). We
model cores in target/arm/cpu, and HW part in hw/intc/armv7m_nvic.c.

NVIC is only 'visible' from vCPU address space, not the "main sysbus".

See this flatview diff of tcg/qtest:

@@ -1,11 +1,12 @@
  FlatView #1
- AS "cpu-memory-0", root: armv7m-container
+ AS "memory", root: system
- Root memory region: armv7m-container
+ Root memory region: system
    0000000000000000-00000000000fffff (prio 0, rom): flash
    0000000008000000-00000000080fffff (prio 0, rom): flash
    0000000010000000-0000000010007fff (prio 0, ram): SRAM2
    0000000020000000-0000000020017fff (prio 0, ram): SRAM1
-  0000000022000000-0000000023ffffff (prio 0, i/o): bitband
    0000000040000000-00000000400003ff (prio -1000, i/o): TIM2
    0000000040000400-00000000400007ff (prio -1000, i/o): TIM3
    0000000040000800-0000000040000bff (prio -1000, i/o): TIM4
@@ -52,7 +53,6 @@
    0000000040022000-00000000400223ff (prio -1000, i/o): FLASH
    0000000040023000-00000000400233ff (prio -1000, i/o): CRC
    0000000040024000-00000000400243ff (prio -1000, i/o): TSC
-  0000000042000000-0000000043ffffff (prio 0, i/o): bitband
    0000000048000000-00000000480003ff (prio 0, i/o): stm32l4x5-gpio
    0000000048000400-00000000480007ff (prio 0, i/o): stm32l4x5-gpio
    0000000048000800-0000000048000bff (prio 0, i/o): stm32l4x5-gpio
@@ -66,9 +66,4 @@
    0000000050060800-0000000050060bff (prio -1000, i/o): RNG
    00000000a0000000-00000000a0000fff (prio -1000, i/o): FMC
    00000000a0001000-00000000a00013ff (prio -1000, i/o): QUADSPI
-  00000000e0000000-00000000e000dfff (prio -1, i/o): nvic-default
-  00000000e000e000-00000000e000e00f (prio 0, i/o): nvic_sysregs
-  00000000e000e010-00000000e000e0ef (prio 1, i/o): v7m_systick
-  00000000e000e0f0-00000000e000efff (prio 0, i/o): nvic_sysregs 
@00000000000000f0
-  00000000e000f000-00000000e00fffff (prio -1, i/o): nvic-default 
@000000000000f000

So under qtest with no vcpu, the nvic is not accessible without
specifying a non-global address space.

And qtests access NVIC, see this function:

     #define NVIC_ISPR1 0XE000E204
     #define NVIC_ICPR1 0xE000E284
     #define USART1_IRQ 37

     static bool check_nvic_pending(QTestState *qts, unsigned int n)
     {
         /* No USART interrupts are less than 32 */
         assert(n > 32);
         n -= 32;
         return qtest_readl(qts, NVIC_ISPR1) & (1 << n);
     }

I tend to think the current situation works by luck, and this series
is yet another example of sysbus abuses.

I'll give it some thoughts. Maybe we can discuss it at the next
community call.

Regards,

Phil.

