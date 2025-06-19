Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EF2C7115D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 21:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSMgL-0005pG-RU; Thu, 19 Jun 2025 17:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSMgJ-0005ol-Dy
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:20:23 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSMgH-0001Rr-Gs
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:20:23 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a589d99963so1214579f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 14:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750368019; x=1750972819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BONmKAZrZ7qkm4Zys4J3JzTXrECjuPap2Jc9qPE0Qac=;
 b=k9PltgHND3kCPdVKr9LcVViCKtSKH4OtEJaGztdakf5+/305vHbpMjSBiMZ4nXinrB
 ZbrBxUQtl42aoG2q6jNYgcMOgyi3XfTVYXHyYAcAg7Yw5LB2k34WHvRa1+p3mG+9utW8
 ItNmKlTMFxuSVptXWjF1VjukNo4cMhNWzcYPt05oP/LqH9UqJ6h8RWiy6AeCbwEiBhAS
 0K79srO3aYi/67K8g+Ul+s+kg1hd2AZHjEEoSCGigJL0v0T09Y59ZAIoTfiGmbtc1qVK
 BKetGt1Zz1aVi5ZX9vyesDwjKM8LwIws+rDX3j9sX/2YU8mJctDKcLLdGlzYn65NFnWJ
 OTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750368019; x=1750972819;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BONmKAZrZ7qkm4Zys4J3JzTXrECjuPap2Jc9qPE0Qac=;
 b=Jwcetscvgiu7VC3IJWBgkhRJ1T96HJfzmv+mda2XE74NoEdwHA/ItprwgFa+x27m6g
 Y82FaUQXo77P9dH91Sq37iRA318cMSL+LLMoDsL+23bP5Sc8giGSn2dyL0VqtukHmMf4
 R3gniH7z0lNkb5x0uYQnoUX+s5zALI6UNDMTi5Tx9Al+ljYe9HswVtk3lZdu5x6jT8cr
 0HfD9vpp3Dlc1GWGZNanfqw9BQrRXnfpHzWLTxKPI8k8HTCM6E6yg+0aWJyWb09de18W
 Tby/acirWlZoGcrAorG4t+e9eW9NK9A/cXaWYyWR0vF2ABX/YJJLTM1SDcnTMOBqIlnL
 XzMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUns/pIVFbukoykj3sE4O32hu5XPMLXPhON3aVZb2ZUSOpLxou2iOAAoK3kSx4pVR8WARE6jIYfq4zS@nongnu.org
X-Gm-Message-State: AOJu0Yz1xfMFnwNkiuKjSkef1d72GBETmtBfw9XXlSoe6J6g+I3O+8Zn
 HPfOmxASaraA0Rxe3DQsu/SnO8Dmyt4WAVvouQFx/zlgEgaGuFMRmlbS7cdlDt6ylL/kPAlPIvn
 oc4/As40=
X-Gm-Gg: ASbGncs/mQqgoYqfpouPkjSFN6WqBg9RN5NvFuWjPakFgD38zhxjIeTYq7/5j7+2yWr
 fqhnckHlhQtiDLCsgqsdp9l8L39cmo/Ri8PqcMbjDRe90aRkAiPBs2DyvnilOdGWyccbdosIUSv
 9rhTSY25VhaPf0i3p4terSngwbliiU344EJi/6XvLgWe5p/Y9SZzW+b4JfSZjRW6FZjGC3p7qYq
 ftHoAum9U09m7EDwglryeX79t2NeDqB9+JyXchXBs1FJjy5wyI+x7Yj05/I2UyVIn4Sxci0XVJ+
 gyGXDdrSKx090RUFMrDo8dTY+nlRucXmFNkgfaY27civ4g2eiw+vEGUW/Lusf7AxXUHa0Rq3gqU
 dtjramdfEPSvo+lKCii3bRP0F4IqPig==
X-Google-Smtp-Source: AGHT+IEVP2JDyMIne+sCnMrGRBm6fn/DEfOO15j7Uu6FrxZhEKj6gre/R8dizGKvJNMOpmtC8f4V1Q==
X-Received: by 2002:a05:6000:4614:b0:3a5:287b:da02 with SMTP id
 ffacd0b85a97d-3a6d12e5cfcmr351519f8f.40.1750368018768; 
 Thu, 19 Jun 2025 14:20:18 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f18215sm354766f8f.29.2025.06.19.14.20.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 14:20:18 -0700 (PDT)
Message-ID: <b3bea159-8da3-4a7d-8485-fcd6519b845d@linaro.org>
Date: Thu, 19 Jun 2025 23:20:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/20] hw/arm/sbsa-ref: Tidy up use of RAMLIMIT_GB
 definition
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250619131319.47301-1-philmd@linaro.org>
 <20250619131319.47301-20-philmd@linaro.org>
 <1e7d58dc-b348-4c6f-b7bd-e8da047e21c8@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1e7d58dc-b348-4c6f-b7bd-e8da047e21c8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 19/6/25 23:09, Richard Henderson wrote:
> On 6/19/25 06:13, Philippe Mathieu-Daudé wrote:
>> Define RAMLIMIT_BYTES using the TiB definition and display
>> the error parsed with size_to_str():
>>
>>    $ qemu-system-aarch64-unsigned -M sbsa-ref -m 9T
>>    qemu-system-aarch64-unsigned: sbsa-ref: cannot model more than 8 
>> TiB of RAM
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/arm/sbsa-ref.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
>> index deae5cf9861..3b7d4e7bf1d 100644
>> --- a/hw/arm/sbsa-ref.c
>> +++ b/hw/arm/sbsa-ref.c
>> @@ -19,6 +19,7 @@
>>    */
>>   #include "qemu/osdep.h"
>> +#include "qemu/cutils.h"
>>   #include "qemu/datadir.h"
>>   #include "qapi/error.h"
>>   #include "qemu/error-report.h"
>> @@ -53,8 +54,7 @@
>>   #include "target/arm/cpu-qom.h"
>>   #include "target/arm/gtimer.h"
>> -#define RAMLIMIT_GB 8192
>> -#define RAMLIMIT_BYTES (RAMLIMIT_GB * GiB)
>> +#define RAMLIMIT_BYTES (8 * TiB)
>>   #define NUM_IRQS        256
>>   #define NUM_SMMU_IRQS   4
>> @@ -756,7 +756,9 @@ static void sbsa_ref_init(MachineState *machine)
>>       sms->smp_cpus = smp_cpus;
>>       if (machine->ram_size > sbsa_ref_memmap[SBSA_MEM].size) {
>> -        error_report("sbsa-ref: cannot model more than %dGB RAM", 
>> RAMLIMIT_GB);
>> +        g_autofree char *size_str = size_to_str(RAMLIMIT_BYTES);
>> +
>> +        error_report("sbsa-ref: cannot model more than %s of RAM", 
>> size_str);
>>           exit(1);
> 
> Not a bug bug, but autofree has no effect because the block doesn't end 
> before the call to exit.

Right. Isn't it better to use g_autofree as a general code pattern?


