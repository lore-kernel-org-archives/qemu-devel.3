Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4EEC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 23:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsVZ1-0005ZC-3Q; Wed, 12 Mar 2025 19:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsVYx-0005Yx-CY
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 19:32:35 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsVYv-0001QZ-6S
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 19:32:34 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso330394f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 16:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741822351; x=1742427151; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L2336frrEJWJZ2vkJIPhw+qkWjmhleCm5i7KX3YOui8=;
 b=s2/5+nn6bYnL15MfsRgYtMKIspgGBic2np8pMKb7yYgB6CaM/XTnfEzcEnxGG4LdSd
 PTPaljrN/JvflCdshOoafaCIAcKwDJ4sTCIvAW6VbjiggxF90Goww3dgmRx7rapB3czw
 nDQ+M8WIW/KUjhXa6KsXt9HFxpdB7bfFf0zJJecz7+GTsHTULV7puAU69127kb31PNun
 t/LC/vMDfClvtU2AxQlO9L817vBIjL2jAVMElakBf6GTdHJI4qk1PeSKpOnRqVgrhIDr
 5dchOL6gsy8Q7i3IahhNwaCou6t5Ko3ty8rT0HgGqg9zOLio/ZBxhjn3dxFo318Crate
 MoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741822351; x=1742427151;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L2336frrEJWJZ2vkJIPhw+qkWjmhleCm5i7KX3YOui8=;
 b=EfFbVRXIb138l/FwQpwjvZS8wGanlkAYhST9WlCz/BfnbYiQ4qoBd5jnOTOWTkIHEf
 VdXkHZIFSZeL8TmsVgLACAGsJzv9xtCL1BHyMG1xaHyvSiADsuAST9kmLEQJJS8ufSvE
 yCjSQ+8WD/j3wwdBLHo/+f4UNVq65EeI0Z8SaxJbQuZ7kvj9lyoIoCwx0OCIySgUHA+s
 hgdjkX0S/4XEow+DAPog/xZcebd1UvNJlbBnutgENuvICJXoz+vCOIeZmglCsaqiTr/J
 7uoSxtBZAUpC168h8wMWG2zXdvqN1hjP+4FOuAb8WlnRP0fCoE4cUkqVd+HfwOx2bWlA
 cnZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5OoeVuVxzoVXjZxtWODyohrRptD/ycZm1uESgWG5qNDXW6MeVHu8o14ttVeLHRarWE3ug7LXyKBMd@nongnu.org
X-Gm-Message-State: AOJu0YzBkBd1JcJtY5DVt78FO8nAECUY0ANHdBPuYuBsnyXhG1K4TAcf
 X2CYv3L3lVbL+H8cC3dmg7an8z48cuhHRRlAnuGDzRVEfiBeSmI5NsSXThtiIzM=
X-Gm-Gg: ASbGncvjP5hE2oOGe8nU4jcBnjayuZzn24mDbE6dLKUlxWGgkouNbNyhmSAtNVXoCnz
 WMAaIp3yYUugrCvyinVdCxgIiw5ibRRGqAgtFSyVuW30o9Kq9P3TgfIPkLGiicKM0tM6Kmexwex
 ilCMfqNXA1BqPqax0ojv4nwdTD9c8nPZn5mEB9DPJnzXr9s86ipmuvLXMRC8fdIKktBhYjaTTPC
 sTB+6eR3PIa93U6ibxLFzUfkrSs8Qv/L9uyvMrcwN6SM/d1ka+kFguUfJr1AUnT88alB56GdBD+
 QjiYxkN4eyGzFic4CfpY/IbWAGBiMxdfJPjItnB1NVh1UP3owWlOsD+tLnV01a5CzLe+LbM2ZFq
 Z1imkUYY8eA==
X-Google-Smtp-Source: AGHT+IGzM2FgS+ISZmaSxPP6c6RxvDwQc28jrVVFjowma4xBjiw7eTDUpJzLuZD5W2SsXJzT1qP/QA==
X-Received: by 2002:a5d:59a9:0:b0:390:ff25:79c8 with SMTP id
 ffacd0b85a97d-392641c034amr10317045f8f.20.1741822350702; 
 Wed, 12 Mar 2025 16:32:30 -0700 (PDT)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c83b6e87sm195266f8f.32.2025.03.12.16.32.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 16:32:29 -0700 (PDT)
Message-ID: <6352d0c4-b74e-4d7f-bb23-395d000ab01d@linaro.org>
Date: Thu, 13 Mar 2025 00:32:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/38] target/hexagon: Add initial MMU model
To: Sid Manning <sidneym@quicinc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>,
 "ale@rev.ng" <ale@rev.ng>, "anjo@rev.ng" <anjo@rev.ng>,
 "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "Mark Burton (QUIC)" <quic_mburton@quicinc.com>,
 Brian Cain <bcain@quicinc.com>, Michael Lambert <mlambert@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-35-brian.cain@oss.qualcomm.com>
 <fa38864b-8dfb-4475-9bb9-44e4a0657f68@linaro.org>
 <DS0PR02MB948226A894C108BD0411E69EBED02@DS0PR02MB9482.namprd02.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <DS0PR02MB948226A894C108BD0411E69EBED02@DS0PR02MB9482.namprd02.prod.outlook.com>
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

On 12/3/25 22:15, Sid Manning wrote:
> 
> 
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Sent: Wednesday, March 12, 2025 2:20 PM
>> To: Brian Cain <brian.cain@oss.qualcomm.com>; qemu-devel@nongnu.org
>> Cc: richard.henderson@linaro.org; Matheus Bernardino (QUIC)
>> <quic_mathbern@quicinc.com>; ale@rev.ng; anjo@rev.ng; Marco Liebel
>> (QUIC) <quic_mliebel@quicinc.com>; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; Mark Burton (QUIC)
>> <quic_mburton@quicinc.com>; Sid Manning <sidneym@quicinc.com>; Brian
>> Cain <bcain@quicinc.com>; Michael Lambert <mlambert@quicinc.com>
>> Subject: Re: [PATCH 34/38] target/hexagon: Add initial MMU model
>>
>> WARNING: This email originated from outside of Qualcomm. Please be wary
>> of any links or attachments, and do not enable macros.
>>
>> On 1/3/25 06:26, Brian Cain wrote:
>>> From: Brian Cain <bcain@quicinc.com>
>>>
>>> Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>>> Co-authored-by: Michael Lambert <mlambert@quicinc.com>
>>> Co-authored-by: Sid Manning <sidneym@quicinc.com>
>>> Co-authored-by: Matheus Tavares Bernardino
>> <quic_mathbern@quicinc.com>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>    target/hexagon/cpu-param.h |   4 +
>>>    target/hexagon/cpu.h       |  13 +
>>>    target/hexagon/hex_mmu.h   |  30 +++
>>>    target/hexagon/internal.h  |   3 +
>>>    target/hexagon/cpu.c       |  27 +-
>>>    target/hexagon/hex_mmu.c   | 528
>> +++++++++++++++++++++++++++++++++++++
>>>    target/hexagon/machine.c   |  30 +++
>>>    target/hexagon/translate.c |   2 +-
>>>    target/hexagon/meson.build |   3 +-
>>>    9 files changed, 637 insertions(+), 3 deletions(-)
>>>    create mode 100644 target/hexagon/hex_mmu.h
>>>    create mode 100644 target/hexagon/hex_mmu.c
>>
>>
>>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c index
>>> 34c39cecd9..7ff678195d 100644
>>> --- a/target/hexagon/cpu.c
>>> +++ b/target/hexagon/cpu.c
>>> @@ -28,6 +28,7 @@
>>>    #include "exec/gdbstub.h"
>>>    #include "cpu_helper.h"
>>>    #include "max.h"
>>> +#include "hex_mmu.h"
>>>
>>>    #ifndef CONFIG_USER_ONLY
>>>    #include "sys_macros.h"
>>> @@ -283,6 +284,18 @@ static void
>> hexagon_restore_state_to_opc(CPUState *cs,
>>>        cpu_env(cs)->gpr[HEX_REG_PC] = data[0];
>>>    }
>>>
>>> +
>>> +#ifndef CONFIG_USER_ONLY
>>> +static void mmu_reset(CPUHexagonState *env) {
>>> +    CPUState *cs = env_cpu(env);
>>> +    if (cs->cpu_index == 0) {
>>
>> This doesn't scale to heterogeneous emulation.
> [Sid Manning]
> Heterogeneous emulation, you mean a version of QEMU with something like ARM and Hexagon configured to run concurrently?

Yes.

> I think we can substitute this with env->threadId, threadId is the same htid (hardware thread id)

That looks safer (and could be your CPUClass::get_arch_id implementation).


