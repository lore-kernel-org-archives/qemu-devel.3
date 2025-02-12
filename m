Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC74C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 09:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti8tz-0000J4-El; Wed, 12 Feb 2025 04:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ti8tx-0000IU-9d
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 04:19:25 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ti8tu-000607-7b
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 04:19:24 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38dc6d55ebaso368948f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 01:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739351959; x=1739956759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XoWgCpDwrmO8nNKAIVklfvwLlSH3A7c6sgcpo3s2mU8=;
 b=zGkPAFXLhAoz0gkSgzTbrARveJ3VQ9Og7gk7r7AHWlVVFg97QBpcKhlBqwOeqfmgWg
 d/bNH6TN4yvPiTtsj7T6dwQpS95w77HexE764W8id3nSPlhQKQ5Jvw2Spus3o9+XzLHN
 kvMETzvnq+h7V9/dc9ghCot9ExNmss+UEhxGy0wngmXQ6AA0PQ3LdTt7M8r5lw3GIpVm
 Lnf6qzinQKaqBTRjb0x38SCKTIG/i5kqOpsIRcWYGBQK40gRwz/M6wV05Q4sOETJCeRU
 bPTK9csWQeA1q6sY4HD30iVC0BmoTb4LdElp2q10nAa6NNFM5PLSa9D0kOLIUBXRDvJb
 vTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739351959; x=1739956759;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XoWgCpDwrmO8nNKAIVklfvwLlSH3A7c6sgcpo3s2mU8=;
 b=ayyuE4mKLBZJsG+75j0bdyd1iaQAWRKypZZFI+fTAFyigovaLMnY3+srJVPjYqiG+p
 CEsdgHR+/rsi9+rDK9XtsWl3s9qPZ4Wo99jJWuhGMW/sCbjH6IqWC60vpFh6nz1Cl4qQ
 /jFjS2MOd9d2p/ymG1kmuFzBoYGaYyjIYelaf4r8OOVUkhizAT2QkJHlKMpkR5VIxEkM
 gqn/de/dkH/jsxMk+BAJBxIJMCuGNEBGJwvOJLDns/pEltBqk/+DJnPsN61D3eu+qleU
 +A9eLzXCU7mDUuomjd04KifONENRVWBVT6xZ8HsqfriO5rmgHKHf2QMjZEkTS1LrTq7i
 FbPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3qb1GLblB3SsZAB27viU36V4gE0amr6wprCiAcHtnb2E2TRK8UwF7uzFQ7/q7422XNYNczzCkTdGn@nongnu.org
X-Gm-Message-State: AOJu0Yxv4uKwYFFxe0IBs9gbiGhwQ5vqhxa4tVRIpJ4v26061EBaDWlO
 5ksnil/8km7oWh4/VO1WrMbNYXE1E8NIQSqe7j9DaJCEDIlWJofeO7+mIT1jh1o=
X-Gm-Gg: ASbGncsYDZ0HNWQad6tr+lYP/xENVn6o2YPdGkEZ7F84r+47FtHzBCrzL8MHxg39dpJ
 sdVyiLfGGFxgeL3RTvTx/dYoOQeUp7ZGAsdMSmx0dv2JpicIrHMrnr5Vwa41LfRfbIWCh9xjB7e
 Y2rio/XDEIdnImYfqUgjA8b/46BcACIzPkVYBOrUNtoTtWir0NwJVN+ElAojI2YQK1QeVdOdw7C
 z0jDLH46Uwl9LdqxuElvw2hCRWb9oitKzfMdKp62VFRf2ybI79YL5wOtwooI6YpCDW5M7+EnMl1
 /C38Q26tiukN7sOiAy11ugtO3gkooKptWqm6YgRkhneJiRBvv2/3/yQKLkE=
X-Google-Smtp-Source: AGHT+IHrMK+aR0+KapkytzRf0g9yYdUG38YQYRpLQ5n7IQv53xLRD+dW4P5l7l61qLvcgtFG6kmQ7g==
X-Received: by 2002:a05:6000:1867:b0:386:3327:4f21 with SMTP id
 ffacd0b85a97d-38dea2689f5mr1686874f8f.27.1739351959476; 
 Wed, 12 Feb 2025 01:19:19 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd4342502sm11347783f8f.26.2025.02.12.01.19.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 01:19:19 -0800 (PST)
Message-ID: <03446903-2100-4981-831e-7ee4741ffead@linaro.org>
Date: Wed, 12 Feb 2025 10:19:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 04/32] hw/timer/xilinx_timer: Make device endianness
 configurable
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
 <20250210204204.54407-5-philmd@linaro.org>
 <678561c5-4d06-494a-b12c-6013b07f3b05@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <678561c5-4d06-494a-b12c-6013b07f3b05@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 12/2/25 09:27, Thomas Huth wrote:
> On 10/02/2025 21.41, Philippe Mathieu-Daudé wrote:
>> Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
>> of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
>> Add the "little-endian" property to select the device
>> endianness, defaulting to little endian.
>> Set the proper endianness for each machine using the device.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Message-Id: <20250206131052.30207-5-philmd@linaro.org>
>> ---
>>   hw/microblaze/petalogix_ml605_mmu.c      |  1 +
>>   hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
>>   hw/ppc/virtex_ml507.c                    |  1 +
>>   hw/timer/xilinx_timer.c                  | 35 +++++++++++++++---------
>>   4 files changed, 25 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/ 
>> petalogix_ml605_mmu.c
>> index cf3b9574db3..bbda70aa93b 100644
>> --- a/hw/microblaze/petalogix_ml605_mmu.c
>> +++ b/hw/microblaze/petalogix_ml605_mmu.c
>> @@ -127,6 +127,7 @@ petalogix_ml605_init(MachineState *machine)
>>       /* 2 timers at irq 2 @ 100 Mhz.  */
>>       dev = qdev_new("xlnx.xps-timer");
>> +    qdev_prop_set_bit(dev, "little-endian", true);
>>       qdev_prop_set_uint32(dev, "one-timer-only", 0);
>>       qdev_prop_set_uint32(dev, "clock-frequency", 100 * 1000000);
>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/ 
>> petalogix_s3adsp1800_mmu.c
>> index fbf52ba8f2f..9d4316b4036 100644
>> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
>> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
>> @@ -114,6 +114,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
>>       /* 2 timers at irq 2 @ 62 Mhz.  */
>>       dev = qdev_new("xlnx.xps-timer");
>> +    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
>>       qdev_prop_set_uint32(dev, "one-timer-only", 0);
>>       qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
>> index 23238119273..f87c221d076 100644
>> --- a/hw/ppc/virtex_ml507.c
>> +++ b/hw/ppc/virtex_ml507.c
>> @@ -230,6 +230,7 @@ static void virtex_init(MachineState *machine)
>>       /* 2 timers at irq 2 @ 62 Mhz.  */
>>       dev = qdev_new("xlnx.xps-timer");
>> +    qdev_prop_set_bit(dev, "little-endian", false);
>>       qdev_prop_set_uint32(dev, "one-timer-only", 0);
>>       qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> 
>   Hi,
> 
> with this patch applied, the ppc_virtex_ml507 functional test is now 
> failing for me ... could you please double-check whether "make check- 
> functional-ppc" still works for you?

Thanks, not this patch problem, but patch #2 misses:

-- >8 --
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 23238119273..723f62c904b 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -219,2 +219,3 @@ static void virtex_init(MachineState *machine)
      dev = qdev_new("xlnx.xps-intc");
+    qdev_prop_set_bit(dev, "little-endian", false);
      qdev_prop_set_uint32(dev, "kind-of-intr", 0);
---

Why is my CI green?

