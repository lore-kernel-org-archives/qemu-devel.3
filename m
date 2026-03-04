Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E667EF8FF7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 15:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxoEC-0003ht-Oj; Wed, 04 Mar 2026 10:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vxoEA-0003hR-TK
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:33:34 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vxoE8-0007Zj-FF
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:33:34 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-439c9bdc241so533547f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 07:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772638411; x=1773243211; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CY8olNvc/9zQdb1hW0WSqp0dl0J0E5Y4Sr7RA5QqcP0=;
 b=uty61TIUxiTOF6QVQsITVwCY0wQnxePF3dl4VBXmkzud8zRLMenaMnupX2avNpSKMd
 NwiD6PH/TDcsTda7Z2LobNNgcHBImmr+EXUCx50MjqkOytcmAXvTF1IPlayjyZhKFU12
 /4mX4QmmLpVMkspVJgz+iLekU/aOgzUzTSO7vpnXNjRXFswVo+UfBBGSDyR+JI/ITJ2D
 NGnwyVcHXjVQDhU/nC8DF5o7+iRc5M3bItDwmgIaqvCRV6oUxhWeBTPNiB1iJo/h71oI
 sUO4hxmVVJ71Ds0zyPfGlvdU2SSH1gloJJmlnmzMCgcnc41QMUpaI4caDAuKWFpG66L9
 /BNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772638411; x=1773243211;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CY8olNvc/9zQdb1hW0WSqp0dl0J0E5Y4Sr7RA5QqcP0=;
 b=oR5vOhapHRB/AuH9tcemgYLrxDImuKfipmHnzhcCFeRKJ5hZfByNtcHU+A7k1LrIwu
 9kDi12XmOypaXRkmSSgsJTB4vLfDH3pcCIM15twfi+Xsi2kDZfn3dL4e4lOn/l5AIDRW
 RfcN0mFGXMMreeVxSO++eY4pWW1LulgzZ9j7GJKNeM4H+s6kCA+4WjKzyCJr1W/i18ES
 c1/05eOYTENvoPkc4IyGnSzTUx3Ax17aPhXgII8mLloFOMSClTPEDckEA1gSLr3N835p
 wI5iLKik+YBFINTKq3/TbP0GDfvJR3CpX2Ldld2rQFi9cZ7uMRGnhCiQ8G8qcTC/a2nt
 Z4KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDs0rLaBqQw52IYYSdqWacbhOcD0xiwf8wn8Yb/63MoyyhctHPKKE9zm+taTmtjBkr9xvKIh3ClXQH@nongnu.org
X-Gm-Message-State: AOJu0Yy6p/RkYe3jk9c927hnee0nPxQ1jER/Ux3P+E1CzcwOonKQoVZo
 5cwCgwC3NA2s3QTIM+hnoX2Y1ilpsOQjjkI6G/ZLZLph7YFVwQlTiYvi7M327mmJZeg=
X-Gm-Gg: ATEYQzwX/zEKS+WeRNGhUYmcWEIwENZWuV/Dj/NqW04WZ0Hoo/Fq2kzwHwlM15d3NLS
 bMQJBhoN3v9OFCnyyLA63I84lUHscVjozkx0HsxDDyhsKlT2C5ERgHUS2Pd/DuFoaLJ+dv0Sg28
 ykDPPFLXJzJKyt4vsMvMCNCyDhEvkyRJFw8dBNso0aeBOJhhX6PDOMkK2EEg+pzdZkyccONcMtK
 2c5yNIKYB2ogazYJFfS3kd63H9FgwkAPHNYO7msVL2wYlP1esIFlCibtZjKT8ySiJGUxivlEdZw
 LozGHCVsnmV9nQam0Z/ZqOn52ennooOC5QbLoOn+Mek/GGD26V/C3PLPmJksftA2/lvfGs7o+Sh
 N8KWY2dkmmF7cuICoDlqsTIaIZoQohCN2r1RN3lNwMMDRQ4YUrnxd3u3rYqj37dhuXgzQr5QIs5
 jSnpbkA6WNN2jp3P13IVjoapozVYg25/ZF87odOOdfmatBoqRD8v/zIaZQAXgSqfptnQ==
X-Received: by 2002:a05:6000:268a:b0:439:be86:5051 with SMTP id
 ffacd0b85a97d-439c8020c62mr4652858f8f.59.1772638410377; 
 Wed, 04 Mar 2026 07:33:30 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b130abfasm26701098f8f.34.2026.03.04.07.33.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 07:33:29 -0800 (PST)
Message-ID: <233e0a3c-9174-48d6-88af-93e291fad172@linaro.org>
Date: Wed, 4 Mar 2026 16:33:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] hppa: Restructure CPU Class heirarchy
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
References: <20260303-hppa-c3600-v5-0-277bfe6b40b8@rev.ng>
 <20260303-hppa-c3600-v5-1-277bfe6b40b8@rev.ng>
 <977a9933-caf9-4fb0-823a-cd8503d5e25f@linaro.org>
In-Reply-To: <977a9933-caf9-4fb0-823a-cd8503d5e25f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 4/3/26 16:31, Philippe Mathieu-Daudé wrote:
> On 3/3/26 17:11, Anton Johansson via qemu development wrote:
>> Clarifies current CPU model names, assuming 32-bit HPPA runs a PA-7300LC
>> whereas 64-bit runs a PA-8700.  The PA-8500 model is added, which will
>> later be used by the A400 machine.  All CPU models are made into children
>> of the now abstract TYPE_HPPA_CPU base class.
>>
>> References to "hppa/hppa64" models in test cases are also updated.
>>
>> Reviewed-by: Helge Deller <deller@gmx.de>
>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>> ---
>>   target/hppa/cpu-qom.h           |  8 +++++++-
>>   hw/hppa/machine.c               | 21 +++++++++++++--------
>>   linux-user/hppa/elfload.c       |  2 +-
>>   target/hppa/cpu.c               | 25 ++++++++++++++++++++-----
>>   tests/qtest/machine-none-test.c |  2 +-
>>   5 files changed, 42 insertions(+), 16 deletions(-)
> 
> 
>> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
>> index 714f3bbdaf..910a919923 100644
>> --- a/target/hppa/cpu.c
>> +++ b/target/hppa/cpu.c
>> @@ -207,7 +207,9 @@ static void hppa_cpu_initfn(Object *obj)
>>   {
>>       CPUHPPAState *env = cpu_env(CPU(obj));
>> -    env->is_pa20 = !!object_dynamic_cast(obj, TYPE_HPPA64_CPU);
>> +    env->is_pa20 = !!object_dynamic_cast(obj, TYPE_HPPA_CPU_PA_8500) ||
>> +                   !!object_dynamic_cast(obj, TYPE_HPPA_CPU_PA_8700);
> 
> Don't we have an architectural bit to test? Does this scale? Could we
> propagate in per-CPU_TYPE class_init handler?

I just read the following patch. Maybe squash together for clarity?
> 
>> +
>>   }
> 
> 
>>   #ifndef CONFIG_USER_ONLY
>> @@ -314,12 +321,20 @@ static const TypeInfo hppa_cpu_type_infos[] = {
>>           .instance_size = sizeof(HPPACPU),
>>           .instance_align = __alignof(HPPACPU),
>>           .instance_init = hppa_cpu_initfn,
>> -        .abstract = false,
>> +        .abstract = true,
>>           .class_size = sizeof(HPPACPUClass),
>>           .class_init = hppa_cpu_class_init,
>>       },
>>       {
>> -        .name = TYPE_HPPA64_CPU,
>> +        .name = TYPE_HPPA_CPU_PA_7300LC,
>> +        .parent = TYPE_HPPA_CPU,
>> +    },
>> +    {
>> +        .name = TYPE_HPPA_CPU_PA_8500,
>> +        .parent = TYPE_HPPA_CPU,
>> +    },
>> +    {
>> +        .name = TYPE_HPPA_CPU_PA_8700,
>>           .parent = TYPE_HPPA_CPU,
>>       },
>>   };


