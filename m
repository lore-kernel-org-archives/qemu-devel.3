Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C3EC83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 14:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXLDG-0006r3-22; Thu, 03 Jul 2025 10:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXLDD-0006ou-QF
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 10:46:56 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXLDB-0005qM-MG
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 10:46:55 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-453634d8609so58636885e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 07:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751554011; x=1752158811; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BcGz55w59YWt1Euim5nr6K8+orikmC4If+SmL5rAAME=;
 b=BA5j5FGz64+2WomAB8+1QMcS93QOXZgJ+ashk3FLrrmOPP/lcNPQeNV/DLJeGA89rL
 9uTmY7X9RjwLpg6kVww91SkrrUxCwXAEBnIR0iLMBQq5+PzG7LnkuD2ZIrGYebfPxphS
 ZgfSiwmvhOCgV+RF0GUIhPPpIlRGjjIszu3nIJfVpSr2UHotuOnkYcnZ2IA3jIGCyZPv
 pxtbZhtCNGkr7giT5Bp3FHRy+SjpAwQA51Yycqy/K4k75zJGq7NSvl8Rp0h/jQKxAfcu
 ZTTo9LkujHvnDXuDTeQbCZiPSgdbGt7afM4liRKz81SPdetVsnLyniQ7v85yCznQtfVd
 361A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751554011; x=1752158811;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BcGz55w59YWt1Euim5nr6K8+orikmC4If+SmL5rAAME=;
 b=WVQuESUb2o5vHdxnwB31GLAx1T4HWBs81/l+s3UbowdeSYECuWBMorhq1j1hs39FbP
 61ouIx4ZJf2g7+kNlxGLemKtc+ldLrMM5WyvlJv/gOaDxs72HacIwsU4fnH34NSVIscw
 kmQoFuS74QOE5YJQaFWvrdHREOxRmzNprUNLHXFLQPDR7KS2IEtVVGJpxheUHWOIWhZp
 YVX+nliYbH28IzjIxvcZ6K8kPaNXt+jytPX7zan/r23Dj+U86smoTotQhny4cMibIlq3
 YtQJkXnmxH993dTAZ9d55NHFwWoO9ywVeAwq4PFN+OK02/YVf8+PTeIWRAAe0+v9Jpz5
 U42Q==
X-Gm-Message-State: AOJu0YxV+Bt/r5TiFrhgwmhSqI7AYe6BcI/HBEtXY8wkl4X/ojxm32lF
 LYnbL8vYWOjYhhsFy+gBzEPJUrB2cBriMdwxos9FaK569UReXNH/eSuRiN8LWQw8rzk=
X-Gm-Gg: ASbGncsa2UkMyHv43pjGKVOVRbmFXcPa1wJAx5zaf4fiRD+kyuVm5WBByUf1pEsEoXA
 Puc4P/PkNuu2kP9fxRrL1rmRt5JMBiVF9ImahZE4SEOCWk/bz+yUlHCF1ijdphFXosLCka6/J7s
 3cc/neEbN/SXyHJWg2NVATM9w7PWHy7DsKPGZVgrAXwp6TUTiBlAc+RYYe9CrorIVNcN/8B8T01
 ZEbXbPab44YRFVcARXfeklSF9wP/iZWAXjW8rooL/T1p9qHfiJ59dAToqmdwpjj/xBmSrzRmlB9
 2+L+D8eawq8MVFbb/jgsG3yPkeHomf1q3XyZt9A2gKSWY7wD8RqQN9NzobnIjVfZbEuwKYBmf9E
 GtRZAGVkpvc9vm3kaj3xMiVwgaLzHLw==
X-Google-Smtp-Source: AGHT+IHvMWtjH1+AiR8aOx6oFZN4XcRnQW05gxpTDKHmHDoS6vbn6KlCaKQgBpMcCZmZSsP/tHlapA==
X-Received: by 2002:a05:600c:4754:b0:453:1058:f8c1 with SMTP id
 5b1f17b1804b1-454ac6122a3mr32948425e9.3.1751554011011; 
 Thu, 03 Jul 2025 07:46:51 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52ad2sm18590233f8f.48.2025.07.03.07.46.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 07:46:50 -0700 (PDT)
Message-ID: <e9d806f6-95e1-4bee-be41-46baee9a251c@linaro.org>
Date: Thu, 3 Jul 2025 16:46:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 47/69] target/arm: Use generic hwaccel_enabled() to
 check 'host' cpu type
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
References: <20250703105540.67664-1-philmd@linaro.org>
 <20250703105540.67664-48-philmd@linaro.org>
 <364dc354-ba78-47c6-ac65-2c0282e28733@linaro.org>
 <CAFEAcA8-ucEJPgVLpBfNyMo8ax-sR6iYr5Zk4DJavYaOkQnfDA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8-ucEJPgVLpBfNyMo8ax-sR6iYr5Zk4DJavYaOkQnfDA@mail.gmail.com>
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

On 3/7/25 15:46, Peter Maydell wrote:
> On Thu, 3 Jul 2025 at 14:45, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 3/7/25 12:55, Philippe Mathieu-Daudé wrote:
>>> We should be able to use the 'host' CPU with any hardware accelerator.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>    target/arm/arm-qmp-cmds.c | 5 +++--
>>>    target/arm/cpu.c          | 5 +++--
>>>    2 files changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
>>> index cefd2352638..ee5eb1bac9f 100644
>>> --- a/target/arm/arm-qmp-cmds.c
>>> +++ b/target/arm/arm-qmp-cmds.c
>>> @@ -30,6 +30,7 @@
>>>    #include "qapi/qapi-commands-misc-arm.h"
>>>    #include "qobject/qdict.h"
>>>    #include "qom/qom-qobject.h"
>>> +#include "system/hw_accel.h"
>>>    #include "cpu.h"
>>>
>>>    static GICCapability *gic_cap_new(int version)
>>> @@ -116,8 +117,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>>>            return NULL;
>>>        }
>>>
>>> -    if (!kvm_enabled() && !strcmp(model->name, "host")) {
>>> -        error_setg(errp, "The CPU type '%s' requires KVM", model->name);
>>> +    if (!hwaccel_enabled() && !strcmp(model->name, "host")) {
>>> +        error_setg(errp, "The CPU type 'host' requires hardware accelerator");
>>>            return NULL;
>>>        }
>>
>> Consider the following hunk squashed:
>>
>> -- >8 --
>> diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
>> index eb8ddebffbf..bdd37cafecd 100644
>> --- a/tests/qtest/arm-cpu-features.c
>> +++ b/tests/qtest/arm-cpu-features.c
>> @@ -456,7 +456,8 @@ static void test_query_cpu_model_expansion(const
>> void *data)
>>                     "ARM CPU type", NULL);
>>        assert_error(qts, "max", "Parameter 'model.props.not-a-prop' is
>> unexpected",
>>                     "{ 'not-a-prop': false }");
>> -    assert_error(qts, "host", "The CPU type 'host' requires KVM", NULL);
>> +    assert_error(qts, "host",
>> +                 "The CPU type 'host' requires hardware accelerator",
>> NULL);
> 
> Grammar nit: either "a hardware accelerator" or "hardware acceleration".

Fixed, thanks :)

