Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FE6C28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqevZ-0005xV-Oi; Fri, 07 Mar 2025 16:08:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqevW-0005wl-QO
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:08:14 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqevT-0006Z5-PN
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:08:14 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43bdcd0d97dso13531465e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741381690; x=1741986490; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wjbvp0YdwH+Kpxa+zt2G1HHNtmeli7dc8TYiy0+i2tA=;
 b=zODZVZgqKDw3GuDJvhntYI7Ij6kwErpNUNfZJHuG7WxIkkFlJS57xEpDB1xlkNMn6m
 8EDggh2du6zk4CZajzqFx73ZW1f8lIemVZxhLOVz4HHJXLSYAiCD07VP2JUlM1/Kr88f
 yjlGlhnqPu9g2ZrZLT/JzaxeJdZ/oCOYcW7slOGbqLJKUJiotKJxJj2CSmWmk8Qqv+nG
 B80L+ZpVRiOMgViN5P8GPBGZd0enTad3XUMQM/YV0WGrgKUTzOXajmtu85fW2rEqmZSa
 Y+9ChdOD4BbtYyQh/v/dhwkZdAzWK+Uyn3RhPBzh55w/DSZsnzVDEMir7qL3zRWfDtgp
 Q13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741381690; x=1741986490;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wjbvp0YdwH+Kpxa+zt2G1HHNtmeli7dc8TYiy0+i2tA=;
 b=FZeERvZCCY12rR3gA1UfQBxWOPUNnyQdoEpqJN5QbOBqCmsEHHCyuBq1MKTKA82Sm0
 Kf0Z7SRNmxYsNYTwLCkqJLjm/LHdKK83MNhOz3VkXK4viDsdoNUywmoQsNHmtR8HRpRM
 jkJ2c1cmlwCIJ4hEkhZMrHqR6X3pdoh2HpRest/GiAyuW+9sL26r4/KZKEMKMJIhHysi
 2ZcoYNQg4nsO4ySdzYYxueG+1J++MA4rQZUaS6F2H7CQMsAge80abZY9hHcsh4dIkxgQ
 HjH+RXZkrzcHtIjily0kqjEO/pUxVo1JZn+d3ta5jTb1Rzy6S+o56G24TKl7SRvUVdOB
 W5rA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/3PH+S06zsGz7Ez270yH6OXQjRkRwLtukAqnlCshOgjS62n24bma5tRdq00YTUehoH+QQHmXmnocM@nongnu.org
X-Gm-Message-State: AOJu0YzVo3y4YpsB8T7wYrkLO6uafumpjN/0uhs0GIbLBws5BXZMG9nS
 dA9zxekPeNvfiSF3G209YYmA+P9g1zP6Tp+ouafH69HDh0v0nCtA9CuXN/FHv1Y2sZmeo3jp96J
 GP1o=
X-Gm-Gg: ASbGnctc4XV6Dz1GcNUMmbd1+8B56cLt7NpgmaRy5LAVOSytJyLefiMBuXcp+Xse5E7
 j68DObU6uiCQycMyd0xEh6QMDSllcy5vzM1yyasixpDZVhzGtk8eIWUzpzM2jwOHNGsmCgC1pCi
 FyJuxm/fiAR848Rf7F7WIirjwF/fctchHou1u5CfTWLWRTtyIvtHmViobp47bXp4x8uJTPCN4BQ
 q1XVaccCpPsKTlnCvBMOw3xmlgfD5pKWV/Ap4LlMC68yS7/jcr9GT8H+dXl22v433znBXjEAEs3
 lULkYRuYPVLa4cfSNVQKTvIL3o7xsgdoTmakc9y4U14mSm+evPZioUGiYxVmQNt5Jz2tiMP0aBq
 wVgIZzRK+DrMh
X-Google-Smtp-Source: AGHT+IFMaS16wG2cPr5hxy3saIUmbSu+DPU4NNSkUqbLRImJLND/CXcKsyDpeXqHXGuuuN0fkVWtBg==
X-Received: by 2002:a05:600c:3b93:b0:43c:e70d:4504 with SMTP id
 5b1f17b1804b1-43ce70d47damr1725505e9.19.1741381689607; 
 Fri, 07 Mar 2025 13:08:09 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8b0425sm63200675e9.3.2025.03.07.13.08.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 13:08:09 -0800 (PST)
Message-ID: <32504f3a-083c-4d25-b65b-d9c60c4abd82@linaro.org>
Date: Fri, 7 Mar 2025 22:08:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] hw/vfio/ap: Check CONFIG_IOMMUFD at runtime using
 iommufd_builtin()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-13-philmd@linaro.org>
 <e4dd7393-47d4-4923-b907-dbb875821274@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e4dd7393-47d4-4923-b907-dbb875821274@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 7/3/25 21:42, Richard Henderson wrote:
> On 3/7/25 10:03, Philippe Mathieu-Daudé wrote:
>> Convert the compile time check on the CONFIG_IOMMUFD definition
>> by a runtime one by calling iommufd_builtin().
>>
>> Since the file doesn't use any target-specific knowledge anymore,
>> move it to system_ss[] to build it once.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/s390x/kvm/kvm_s390x.h |  2 +-
>>   hw/vfio/ap.c                 | 27 +++++++++++++--------------
>>   hw/vfio/meson.build          |  2 +-
>>   3 files changed, 15 insertions(+), 16 deletions(-)
>>
>> diff --git a/target/s390x/kvm/kvm_s390x.h b/target/s390x/kvm/kvm_s390x.h
>> index 649dae5948a..7b1cce3e60d 100644
>> --- a/target/s390x/kvm/kvm_s390x.h
>> +++ b/target/s390x/kvm/kvm_s390x.h
>> @@ -10,7 +10,7 @@
>>   #ifndef KVM_S390X_H
>>   #define KVM_S390X_H
>> -#include "cpu-qom.h"
>> +#include "target/s390x/cpu-qom.h"
>>   struct kvm_s390_irq;
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index c7ab4ff57ad..832b98532ea 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -11,7 +11,6 @@
>>    */
>>   #include "qemu/osdep.h"
>> -#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>>   #include <linux/vfio.h>
>>   #include <sys/ioctl.h>
>>   #include "qapi/error.h"
>> @@ -24,7 +23,7 @@
>>   #include "qemu/module.h"
>>   #include "qemu/option.h"
>>   #include "qemu/config-file.h"
>> -#include "kvm/kvm_s390x.h"
>> +#include "target/s390x/kvm/kvm_s390x.h"
> 
> Do I take from this that this is actually a target-specific device?
> Otherwise the two s390x changes are confusing.
> Is it built once already, due to only being enabled for qemu-system-s390x?
> If so, I question the need to move it out of specific_ss at all.

While it happens to be built once, we need to remove specific_ss[]
to be sure everything eventually link, right?

More generally, I'd rather to remove CONFIG_DEVICES altogether.

> Anyway, this is two changes -- one for iommufd_builtin and one for 
> meson.build.

OK.


