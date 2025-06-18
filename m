Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A0FC71136
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 01:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRhqX-0003Hs-Bk; Tue, 17 Jun 2025 21:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uRhqV-0003Gs-6u
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 21:44:11 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uRhqT-0003cu-DJ
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 21:44:10 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3137c2021a0so4737818a91.3
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 18:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750211047; x=1750815847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RX+3aU0eDanYb6DkwNX/vUApo5z9SdgWf84aaYJNi0E=;
 b=scFKVGWzDSfFRwPVm2vDRBJAlyjNMUPUJGprTotuEkShXe3a2AEucX49MR13An9Zey
 vgCGvsMkDAFAG2POx0cXWD/EAQwZZ1Nuw+JIgXy4wpD7YE7gOsp9J9FwONVUU2ME532u
 N3saX1dA9RYA4WOemUPVNG8ctpDlPq0iV1E6bLfDK46/lfATuA6J3AY3UxeXP/Uc78b1
 oWn5GFepcCkJNhvUi+/YN3krgpsgULz5YadlJYcml6yrQE3j1j0WMOtuQMXKCwOPLyd+
 MNz5/cFgrYXS61VeFwRieXSY4zOZeA9B25F8SDFBlLX+0QVePcH89UP6lJf8RqhE/DJk
 n3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750211047; x=1750815847;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RX+3aU0eDanYb6DkwNX/vUApo5z9SdgWf84aaYJNi0E=;
 b=u6dxbq8VjD/8NbuSm+hOYV+bezge08mqi62zuAZUTfORmAocOXyMxa8KfqWlLZym32
 E4Zt250niPtZ3Bjc0F/zN6LSak7rZftOXINB2NUd8IpcOGhWXWX+0TDtGw28SQPiQC3v
 FTschprwSsYdNeWWz1H3bZFeiLKNSL5H2WeWPBXSaZCyta0W9GDxgrsh5dS6PtdByQQL
 IOQ1RVI1E5id0crDyj/ccoLrr/y5AvwBy1B1YyVdjDlDUKNltvDbyTnsw9sajAjoQdrT
 1eJVdgUvgyWlZ2MCkav/tK+0xFY2IvSV2uf9Er7yjD55sY9KUn962DpwqORjv8oW4qSi
 Ucfg==
X-Gm-Message-State: AOJu0YwkSRsJKIqBsmTdclw9/DE2rpkBX2XUlkVtmMYahbHkeDfMpNzD
 3K5RPm+7lLjLGQ5508QhX27xVtQaTpQm6HTiyuCWbdoUQPOVBEDOb/yPxZz77aZU69U=
X-Gm-Gg: ASbGncvNJxRuBL4eSLKpdDScFm5aEAIM7qFeRszc+Xfg2y+39h7UIEXfj6h71MH5a3c
 SbuKohGHB4zV5zQlWvJ+kI94vq/j2zuR/tcblggWmRK0oC0EmiE2QiYdQqvbgXptg7qlpvE6JyU
 X6qtazGg+wYnfXogqheaIuYGd5NHi+jgM25bdjTjPNurgdEGPHnNZWXZm90ktkXPFUZmoYiXjeP
 4z0Fb3v2w+diThtSi6eag0twut8bY4QvdcB1uQQtgJTVR4hSFDx7RAmV/OZCDCQXrKw03Fl8kxs
 Aq4VQjI0C96DKo7k1FGS/mpjlqcwhKQ4Jw6KhowSP+nqR5jFw9XorVKIkRxDqvLluwAU1VtBsUa
 IgqYYV1pC0js2q8e1nGxz1OcJ0toH
X-Google-Smtp-Source: AGHT+IHa+JxqB/74F+0abVRq/7zOyVn02Su5irAmFw7yQeTOFzyMl53KoWsxA6EG3p5DptuRicJMjg==
X-Received: by 2002:a17:90b:1e07:b0:311:f99e:7f4e with SMTP id
 98e67ed59e1d1-313f1cae835mr26944248a91.16.1750211047370; 
 Tue, 17 Jun 2025 18:44:07 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2365e0cffe6sm87274865ad.245.2025.06.17.18.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 18:44:06 -0700 (PDT)
Message-ID: <3e1e6a7f-18d4-4667-b1a7-6857bdc3de66@linaro.org>
Date: Tue, 17 Jun 2025 18:44:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU emulating ARM Neoverse N1 unexpectectly emulates `retaa`
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 root@wjsota.com, qemu-discuss@nongnu.org
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
References: <1235E663-AD2F-499E-8CF9-16E54A1C01DD@wjsota.com>
 <7d1ddf7e-b16c-4820-958c-0d03bf8479d1@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7d1ddf7e-b16c-4820-958c-0d03bf8479d1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 6/15/25 22:09, Philippe Mathieu-Daudé wrote:
> Hi Solomon,
> 
> Cc'ing the qemu-arm@ list.
> 
> On 14/6/25 06:51, root@wjsota.com wrote:
>> Hi!
>>
>> Is `qemu-aarch64 -cpu neoverse-n1` supposed to emulate the `retaa` instruction?
>>
>> I have a binary called `main_pac` compiled from https://learn.arm.com/learning-paths/ 
>> servers-and-cloud-computing/pac/example/ .
>>
>> The compiling command is `aarch64-linux-gnu-gcc -march=armv8.5-a -fPIC -pedantic -Wall - 
>> Wextra -ggdb3 -O0 -mbranch-protection=standard -fno-stack-protector -fPIE -static main.c 
>> -o main_pac`. The binary includes the `paciasp` and `retaa` instructions associated with 
>> ARM PAC.
>>
>> ```
>> (gdb) disas main
>> Dump of assembler code for function main:
>>     0x0000000000400858 <+0>:    paciasp
>>     0x000000000040085c <+4>:    stp    x29, x30, [sp, #-32]!
>>     […]
>>     0x0000000000400898 <+64>:    ldp    x29, x30, [sp], #32
>>     0x000000000040089c <+68>:    retaa
>> End of assembler dump.
>> (gdb) quit
>> ```
>>
>> When emulated using `qemu-aarch64 -cpu neoverse-n1` , the program completes without issues.
>> ```
>> user@dell-op7020:~/learning/arm_learning_path_pac$ qemu-aarch64 -cpu neoverse-n1 
>> main_pac test
>> Hello World!
>> user@dell-op7020:~/learning/arm_learning_path_pac$
>> ```
>>
>> This is the case for two versions I tested:
>> - v9.2.1 (Debian 1:9.2.1+ds-1ubuntu5)
>> - v10.0.50 (v10.0.0-1610-gd9ce74873a)
>>
>>
>> The expected behavior is for an Illegal Instruction exception to occur. Citing the Arm 
>> A-profile A64 Instruction Set Architect Version 2025-03, the `retaa` instruction should 
>> return an Undefined Instruction error when the PAC feature is not implemented.
>> ```
>> if !IsFeatureImplemented(FEAT_PAuth) then EndOfDecode(Decode_UNDEF);

Yes, trans_RETA() is missing the pauth check.


r~

