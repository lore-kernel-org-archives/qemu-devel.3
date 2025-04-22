Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7324C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 18:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7IIi-0002Nm-0Y; Tue, 22 Apr 2025 14:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7IIf-0002KD-1U
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:24:53 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7IIZ-0001DR-NJ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:24:52 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c0dfad22aso3970416f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 11:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745346279; x=1745951079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VMOH+1/FMGq12RL7nJDBTI8RREDmRkSrSBvbX3v+Hnk=;
 b=epM2wIoySt2t67GV+0Udh6lap2CnEcWdHnqmN4QeYFwjZW0WBRMqAtCX/WH5BhZFWn
 jix0CTPSTgkkMEuEEnyhd+xCoS+R99EEJso/6oyJhrY9jIln8yCm41J3l6twJFClBfSR
 YwNsjdk4m86mO92CV34u9pZDymJ6+t7X0Sf7/IckP4+yYn05Xkly/8gVAKnkmjRKM/gT
 tmXHljjjl8XLwOyLxkOy/WnQ7hFP0Bz46WirG0SM1lFR8dxkBnGVXDh4g0UUjztSQdwT
 HGnHh10tIDKOLO+aDezn8x9hX4dFQa7NFX78tWsFEOYYrc5xXQQ4YdkpUlQxFxaqkiyY
 JnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745346279; x=1745951079;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VMOH+1/FMGq12RL7nJDBTI8RREDmRkSrSBvbX3v+Hnk=;
 b=HivzFYJyxp8HW1sHU4l7dTKB7uLmxW8t/fyrkMvG0YVWFzSud0/BCPbq5/pk5+t2+T
 LI8zEc8xlprdyIUcnSgq1V7EL8JP8jxgVxg39tQieX1pqeZcZ+pj8SD7A9WjZyN3MySW
 rT4rQ+ZB4kvRli3MSv1RGr3AYsjvH138A7MDsqm90tSSHJ9w8sAxtFEo6hq3iWWj+H04
 6qMg06NPVl4b5larKSNU39w9XBnnzA6/bG9MHmMjnkokeUcAwuXZ6ZxD9TNL1K4DwuOU
 q2PWt+knqBqr2jBoGMD/7foG6MtgIv9E5QsIVtHrutBJI07YFZeecQuYEqZudAYDb7wr
 6slg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi60CGIJZ5WuguLaTyAksiTwL4dTfAS8MNX/pQxKuEOPdMlYzls69TnALijOKdI+r20T6GKY3eGeVg@nongnu.org
X-Gm-Message-State: AOJu0YwQciFcPQ9OpfC/9g7GnBNe65ytJ3XkzUuCT3/wtCglRBTJ+IOg
 R73iI3vHc2KXlRbtswLNYgBOLpf0PPNUjwyUY5ln9By7pYlu5GIre6VyOCpYqZU=
X-Gm-Gg: ASbGncvjH8ngK58SsIKB1PyqlGds935V2DtqUN+MeBA5gbOW5/HE+EKV+pTqc2Zob/C
 6R/PLyG0T1qjgIn9LULh7DX7EqVAtVZCmjPQY6l0HdD+9gnYeOua1eijpiS+ceuL6nAZSDznP+n
 qSxWdEVod7wIB+NEawU7tub8MQMV/lF/DiRLRFrX3gpDNvoprdqW3oHbhXFa8Qw6wb03TlRAgI1
 XE+2WH85jpPSdz4f5Pl6rybJWUVqvwju8TKpt2q9K/QqDdVNK/W+cAhzcJTevYcdQieR2XtREJ/
 xTaIWSL1jCWGvwg205tvG15UtS6Rrj+NygRSvmYIBCEBMtkE/jR//Xot+qY7np8GHFeocdMEz4B
 ldwx5PtRCH3NTUssBHY8=
X-Google-Smtp-Source: AGHT+IFqtcbUgAaOCnu96R1Y8kry+ZqdX15igPMgwo8lofEjJEUrz73ArYyG6hg9tgO/0l9iRvpMnA==
X-Received: by 2002:a5d:64a3:0:b0:39f:e4a:d262 with SMTP id
 ffacd0b85a97d-39f0e4ad270mr5425968f8f.9.1745346278808; 
 Tue, 22 Apr 2025 11:24:38 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa420816sm16322569f8f.15.2025.04.22.11.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 11:24:38 -0700 (PDT)
Message-ID: <a8a701b4-9da5-45d1-88e2-6a708b425146@linaro.org>
Date: Tue, 22 Apr 2025 20:24:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 14/19] qemu/target_info: Add %target_arch field to
 TargetInfo
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-15-philmd@linaro.org>
 <cc5114fe-c17d-4e02-96f2-135ee1c7fa09@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cc5114fe-c17d-4e02-96f2-135ee1c7fa09@linaro.org>
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

On 22/4/25 20:20, Pierrick Bouvier wrote:
> On 4/22/25 07:54, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/qemu/target-info-impl.h   | 4 ++++
>>   configs/targets/aarch64-softmmu.c | 1 +
>>   configs/targets/arm-softmmu.c     | 1 +
>>   target-info-stub.c                | 1 +
>>   4 files changed, 7 insertions(+)
>>
>> diff --git a/include/qemu/target-info-impl.h b/include/qemu/target- 
>> info-impl.h
>> index 4ef54c5136a..e5cd169b49a 100644
>> --- a/include/qemu/target-info-impl.h
>> +++ b/include/qemu/target-info-impl.h
>> @@ -10,12 +10,16 @@
>>   #define QEMU_TARGET_INFO_IMPL_H
>>   #include "qemu/target-info.h"
>> +#include "qapi/qapi-types-machine.h"
>>   typedef struct TargetInfo {
>>       /* runtime equivalent of TARGET_NAME definition */
>>       const char *const target_name;
>> +    /* related to TARGET_ARCH definition */
>> +    SysEmuTarget target_arch;
>> +
>>       /* QOM typename machines for this binary must implement */
>>       const char *const machine_typename;
>> diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/ 
>> aarch64-softmmu.c
>> index 375e6fa0b7b..ff89401ea34 100644
>> --- a/configs/targets/aarch64-softmmu.c
>> +++ b/configs/targets/aarch64-softmmu.c
>> @@ -13,6 +13,7 @@
>>   static const TargetInfo target_info_aarch64_system = {
>>       .target_name = "aarch64",
>> +    .target_arch = SYS_EMU_TARGET_AARCH64,
>>       .machine_typename = TYPE_TARGET_AARCH64_MACHINE,
>>   };
>> diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm- 
>> softmmu.c
>> index d4acdae64f3..22ec9e4faa3 100644
>> --- a/configs/targets/arm-softmmu.c
>> +++ b/configs/targets/arm-softmmu.c
>> @@ -13,6 +13,7 @@
>>   static const TargetInfo target_info_arm_system = {
>>       .target_name = "arm",
>> +    .target_arch = SYS_EMU_TARGET_ARM,
>>       .machine_typename = TYPE_TARGET_ARM_MACHINE,
>>   };
>> diff --git a/target-info-stub.c b/target-info-stub.c
>> index 218e5898e7f..e573f5c1975 100644
>> --- a/target-info-stub.c
>> +++ b/target-info-stub.c
>> @@ -12,6 +12,7 @@
>>   static const TargetInfo target_info_stub = {
>>       .target_name = TARGET_NAME,
>> +    .target_arch = -1,
> 
> I think we should have a full ifdef ladder here, to handle all 
> architectures. Setting -1 is not a safe default.

TargetInfo definition is internal to "qemu/target-info-impl.h",
otherwise its type is forward-declared as opaque.

> 
>>       .machine_typename = TYPE_MACHINE,
>>   };
> 


