Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DE1C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 06:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8CBT-0008IJ-9Z; Fri, 25 Apr 2025 02:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8CBQ-0008Fh-Vs
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 02:05:09 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8CBO-0000Vc-W0
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 02:05:08 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b061a775ac3so1786458a12.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 23:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745561105; x=1746165905; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ABpbcOWjuHUUX4PFpFLH1HSDJ2yZI97EUbncpxaJW3M=;
 b=x+TXEP4Id/GWWWkINoG1z3nYiwaaheXjy1hTO0kFN/HeHGkQ/KJwUwKQQEbnLWfmPJ
 EMSXcGrJ5u4ENJQyIcJ93vXZsurRHymm0wmumyinYvnLfApNTwH18iNdjMAqT2LYMmU4
 UcWjOC+Br55JeEOOI9KVH2Jjp8UW+GbXfBRZKQkgpu4Cckk76po9e19ATqZ8WUljYAYq
 lgCDJW+TzLJF/VkUan3Yqg56lTEDxaFnh31gll3RFv+NAthIYcpVVrkNUIAw31WG8uVP
 3kGUJR9K0e4o3iiuOB4iwmSz0iPOe6Yg1iYDaoRXDGLFzkgIwtxbeLQncU1PNUNnwkxN
 EyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745561105; x=1746165905;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ABpbcOWjuHUUX4PFpFLH1HSDJ2yZI97EUbncpxaJW3M=;
 b=mENCKFsVyXRfnYTtzB7d3H2ugOFMn8Wj6heL3bwGoKEXAoAhGEL1lkKLCbReOf6gaI
 HPAXq1+lgxLefEO2KySe3qdlyj5Jbrzy7sSWhuapo9deUqb5YCoCT5245adS8krb5AeL
 eplV75SwyhaS3G+ucekLdvUDRK87TX8yxil1qf1EPh6W4PeF8Pwu9Ozlj3Dp/Oa58Fjj
 Fsz//8fOGN3G0NnINkGMvwdymEFadIYfLSFmlrCSZinV4PFjeyd/P0szDVLIqwn7Auwh
 KeiZNUScMP1Yp6gzLZ9QE208ase7Zz3G/JrxkAbiRKMyzif/39yfl73odhLJShg77kZk
 UsDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIZnwYl30DbmM8zu3Zzd3epXkCWyVNeeDJwyIi28CokeM0B2w2cGMM/qlrn9SHN4Cw0S4o9kThkMyp@nongnu.org
X-Gm-Message-State: AOJu0Yz7Noxmqgn+4ELOMucpVapdUXMzIwwVq0M0NHB1uDrppDCgr1qx
 33AQL64fekD+9Z32KGD6OOCqKSFU7bjZ14WqPNCzYKFkLu8orXzn4B2SD8NKzNM=
X-Gm-Gg: ASbGncsm8cy5eFTXyXGUbKneEuTDgToRb3DBRBmEgspb6RbmaJfgFyPkjRckdW4vLQ4
 XCQYBtj5krX4s+0eR8QKb/An5/O98ikzHG4AOxtaQ3L2DNu1kqd/Xprm4q2sXnQbhKTgetKT5t9
 437QN9yZP/O1ZmzdwToRTjJeoSJZ01ujoNlNmDoqNnWWnYTRH3XKMRmzH0AYjiio4sdApqo9Yb4
 n4m+4KfrRPeuxpqGZgyW9+bVmSyenoEvNSb05XTzPmEvaWvTM7gbJRjFWOIsPdSBaQMNfHW0a8Q
 pZ0vdaJJj/n32IpYSlZ/XrAPJXkWH8J02ExeU/2o5jmXzGsNLxYq35a+6iiFmY6U
X-Google-Smtp-Source: AGHT+IF0ny0a3YirJTRFRu8m4HDGJhYVUBY2gIKRiHfaWG/oIWLs2woM9F7MrykNpn6a5be8G1j2qg==
X-Received: by 2002:a05:6a21:3284:b0:1f5:8678:183d with SMTP id
 adf61e73a8af0-2045b6f1a80mr1567692637.14.1745561104889; 
 Thu, 24 Apr 2025 23:05:04 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912ee5sm2426497b3a.33.2025.04.24.23.05.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 23:05:04 -0700 (PDT)
Message-ID: <51f3a96b-9c7a-4242-a822-145d68e068d9@linaro.org>
Date: Thu, 24 Apr 2025 23:05:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 08/21] hw/arm: Add DEFINE_MACHINE_[ARM_]AARCH64()
 macros
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, Anton Johansson <anjo@rev.ng>
References: <20250424222112.36194-1-philmd@linaro.org>
 <20250424222112.36194-9-philmd@linaro.org>
 <1332b395-1e3e-2be7-83f2-15f2d89b0449@eik.bme.hu>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <1332b395-1e3e-2be7-83f2-15f2d89b0449@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

On 4/24/25 17:16, BALATON Zoltan wrote:
> On Fri, 25 Apr 2025, Philippe Mathieu-Daudé wrote:
>> A machine defined with the DEFINE_MACHINE_ARM_AARCH64() macro
>> will be available on qemu-system-arm and qemu-system-aarch64
>> binaries.
>>
>> One defined with DEFINE_MACHINE_AARCH64() will only be available
>> in the qemu-system-aarch64 binary.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> include/hw/arm/machines-qom.h | 13 +++++++++++++
>> target/arm/machine.c          | 12 ++++++++++++
>> 2 files changed, 25 insertions(+)
>>
>> diff --git a/include/hw/arm/machines-qom.h b/include/hw/arm/machines-qom.h
>> index a17225f5f92..6277ee986d9 100644
>> --- a/include/hw/arm/machines-qom.h
>> +++ b/include/hw/arm/machines-qom.h
>> @@ -9,10 +9,23 @@
>> #ifndef HW_ARM_MACHINES_QOM_H
>> #define HW_ARM_MACHINES_QOM_H
>>
>> +#include "hw/boards.h"
>> +
>> #define TYPE_TARGET_ARM_MACHINE \
>>          "target-info-arm-machine"
>>
>> #define TYPE_TARGET_AARCH64_MACHINE \
>>          "target-info-aarch64-machine"
>>
>> +extern InterfaceInfo arm_aarch64_machine_interfaces[];
>> +extern InterfaceInfo aarch64_machine_interfaces[];
>> +
>> +#define DEFINE_MACHINE_ARM_AARCH64(namestr, machine_initfn) \
>> +        DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, \
>> +                                       arm_aarch64_machine_interfaces)
>> +
>> +#define DEFINE_MACHINE_AARCH64(namestr, machine_initfn) \
>> +        DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, \
>> +                                       aarch64_machine_interfaces)
>> +
>> #endif
>> diff --git a/target/arm/machine.c b/target/arm/machine.c
>> index 978249fb71b..193c7a9cff0 100644
>> --- a/target/arm/machine.c
>> +++ b/target/arm/machine.c
>> @@ -8,6 +8,7 @@
>> #include "cpu-features.h"
>> #include "migration/cpu.h"
>> #include "target/arm/gtimer.h"
>> +#include "hw/arm/machines-qom.h"
>>
>> static bool vfp_needed(void *opaque)
>> {
>> @@ -1111,3 +1112,14 @@ const VMStateDescription vmstate_arm_cpu = {
>>          NULL
>>      }
>> };
>> +
>> +InterfaceInfo arm_aarch64_machine_interfaces[] = {
>> +    { TYPE_TARGET_ARM_MACHINE },
>> +    { TYPE_TARGET_AARCH64_MACHINE },
>> +    { }
>> +};
>> +
>> +InterfaceInfo aarch64_machine_interfaces[] = {
>> +    { TYPE_TARGET_AARCH64_MACHINE },
>> +    { }
>> +};
> 
> Why do you need these? If you define DEFINE_MACHINE_WITH_INTERFACES as
> OBJECT_DEFINE_TYPE_WITH_INTERFACES then you can write:
> 

This was requested in v4 by Richard to remove anonymous array 
duplication in .data.

> DEFINE_MACHINE_WITH_INTERFACES(name, initfn, { TYPE_TARGET_ARM_MACHINE },
>       { TYPE_TARGET_AARCH64_MACHINE }, { })
> 
> and no more macros needed. Ideally those places that are now blown up
> should use DEFINE_MACHINE too. Maybe they don't yet because the parent
> type  is hardcoded so we should really have
> 

Not sure what you mean by "no more macros needed".
arm_aarch64_machine_interfaces or aarch64_machine_interfaces are arrays 
(defined only once), which are passed as a parameter to 
DEFINE_MACHINE_WITH_INTERFACES, or manually set with ".interfaces =".

> DEFINE_MACHINE_EXTENDED(name, parent, initfn, interfaces...)
> 
> and remove more bolier plate that way?
> 

Could you can share a concrete example of what you expect, with the new 
macros to add, and how to use them for a given board?

> Regards,
> BALATON Zoltan


