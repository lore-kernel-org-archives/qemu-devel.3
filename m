Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5928D26D64
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 15:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veE6n-0000b0-0m; Fri, 09 Jan 2026 10:09:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veE6k-0000a4-3t
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 10:08:58 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veE6i-0005pa-Cs
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 10:08:57 -0500
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-477632d9326so26645465e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 07:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767971332; x=1768576132; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k1V9jA21eUKsXvTyqQVWTpVX+kBWr0NkUICIYGuC5Zw=;
 b=fLxz8K2gM8GzkG82eWdrNFy47FJ2puCoVkowwsFNHamTUJdqwgldiUlfyWb3ZRfvnI
 Chc7IOQLIdE3hyTt4UOhk/57nUEUuUv8VCGEpFJBmjfBc0LnpT8liwopUdEWkNW04RsN
 i/1LiKZbnFlB5EMQXPOL4mK5Gz47yBWSgxy7MohEYmu8zB33YVrPeWNqk1F13gVI9KNj
 ZN7snV5zlnvKoCXtSTSYsVi+3nJWUZAgknYtypsZ45Zg7dQTDkMUJNjxMuYKU6g5AyJa
 2rGdfqpUtaUGWwOCYFK+DJZqnA2SY7miipNVg7JikfUSA7PJ5n4AZyz9iOLRDA8pbIm+
 mJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767971332; x=1768576132;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k1V9jA21eUKsXvTyqQVWTpVX+kBWr0NkUICIYGuC5Zw=;
 b=k8DJ4cj9r5Z3fjNuC7hvIIRYOAtTEgK0+e0LK1P6GCa54TPzVHPa7lywIvznQ4rZRB
 hXLTRhQkSlFaDylr47QPOUSvG9MyhUGiB45biyuDLM20vq2i53ufuxuzxndv3SG2dm8b
 q4c+VVkvugtYeTFsFE6kiZ5Z9hmM3vUmG/av5aDOJ8Zpvcwt7CRMPF0WI6VZnGHn1s85
 EOnPf4evZo+TtHRsLdK6/it6WSRpEzBSrDGMwTc9X9wz5vunIg1OY6YJeqMqDb/Mf+DA
 OhhLUMexFCQbg1BYXJRmihutp4Pm6f+ChBNfFpGtF7Ic86qvxRq4HFdzO33CLTH4WkAT
 n3wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLwSFzIWt7zsDvIFe9fALeJOeZGzWjAjOS3n5X20+QkecCzhIeb7pbblp4541gnKumyQfQjSgNSH8D@nongnu.org
X-Gm-Message-State: AOJu0Yw1hlhSIdtF2axCYK2gBQ+NWBUFEfwfsIPLynFvqFpnGkeSB+G/
 5xuFd8Few2D5EAkzEsMOiJgnrPwj7/By9WqA8chG8ecbAugleGZyzJtOGkA7LE90T0k=
X-Gm-Gg: AY/fxX4np//IfNoAFt3TIjKLUDGTjyVaXS5g4pbFC5nO0sI6X8xk3IjnQapylf9Ybp+
 niCecW9gsDC0MiWQDuoNYlwNVgOVu7yHmr4KGjc3+gwbykK9FjwRVpqCpQ5YxvjJV54AjKCNFA8
 mjhFfdTRCGvQ3XzoQMmPS89CYFgaBwBvQxjpGA2+Cir4glSNwwkWiyyp1s/bqsR405Oly7nKCtS
 6xFJs8bR1Y85bgniFiSPqYq3IIxmdl6X2E78EDO97Tvx27LRfY6g3ybObCllhlUIelQmIX48m09
 VfNCcS02hSQzP258FcTySRj9S9iGJTrSSWjWYzhzsafzLDuwhCFNiMKRoL0gAOf5DccuvMvDkvz
 Ec3clQqZf0weCIfTSjyOAamsCIWP7KoEHrxKVr1W3xqwcR2gcimhqwl8aMLKgqcAtuOtuYDfkOp
 S5Y5O2Vf1lAP6iAgL25G/WNpmZso9ogp8GIsZOaLaTpUNovG0bCP8hgg==
X-Google-Smtp-Source: AGHT+IEHK2eJJqvLCXjodRsOrgQP3Z5Zm6gvtCjUxSYoF/PJALvFDV+U2s3IUaUXBFJmmHRQ7V8sNg==
X-Received: by 2002:a05:600c:c0c7:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-47d84b33bd7mr104585865e9.22.1767971332304; 
 Fri, 09 Jan 2026 07:08:52 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f4184cbsm225094625e9.6.2026.01.09.07.08.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 07:08:51 -0800 (PST)
Message-ID: <8afeac41-72ed-4654-827a-771b3119a2e2@linaro.org>
Date: Fri, 9 Jan 2026 16:08:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/vfio/migration: Check base architecture at runtime
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Anton Johansson <anjo@rev.ng>,
 Alex Williamson <alex.williamson@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>, "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20251021161707.8324-1-philmd@linaro.org>
 <c5381a4d-74b2-4352-b3f3-c0d39a438dd6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c5381a4d-74b2-4352-b3f3-c0d39a438dd6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
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

On 21/10/25 18:31, Cédric Le Goater wrote:
> On 10/21/25 18:17, Philippe Mathieu-Daudé wrote:
>> Inline vfio_arch_wants_loading_config_after_iter() and
>> replace the compile time check of the TARGET_ARM definition
>> by a runtime call to target_base_arm().
> 
> What's the value of a runtime check of target ARM ? Please explain.

target_base_arm() returns %true when the ARM and AArch64 targets
are used.

Runtime check allow compiling this file once for all targets,
allowing to eventually have a single binary targetting them once.

Still I expect this function to be problematic on heterogenous
emulation, but we are not quite there yet.

> 
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Supersedes: <20251020222315.68963-1-philmd@linaro.org>
>> Based-on: <20251020220941.65269-1-philmd@linaro.org>
> 
> 
> OK. Will consider when this is merged.
> 
> Thanks,
> 
> C.
> 
> 
> 
>> https://lore.kernel.org/qemu-devel/20251020221508.67413-5- 
>> philmd@linaro.org/
>> ---
>>   hw/vfio/vfio-helpers.h      |  2 --
>>   hw/vfio/helpers.c           | 17 -----------------
>>   hw/vfio/migration-multifd.c | 12 +++++++++++-
>>   3 files changed, 11 insertions(+), 20 deletions(-)
>>
>> diff --git a/hw/vfio/vfio-helpers.h b/hw/vfio/vfio-helpers.h
>> index ce317580800..54a327ffbc0 100644
>> --- a/hw/vfio/vfio-helpers.h
>> +++ b/hw/vfio/vfio-helpers.h
>> @@ -32,6 +32,4 @@ struct vfio_device_info *vfio_get_device_info(int fd);
>>   int vfio_kvm_device_add_fd(int fd, Error **errp);
>>   int vfio_kvm_device_del_fd(int fd, Error **errp);
>> -bool vfio_arch_wants_loading_config_after_iter(void);
>> -
>>   #endif /* HW_VFIO_VFIO_HELPERS_H */
>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>> index 23d13e5db5f..9a5f6215455 100644
>> --- a/hw/vfio/helpers.c
>> +++ b/hw/vfio/helpers.c
>> @@ -209,20 +209,3 @@ retry:
>>       return info;
>>   }
>> -
>> -bool vfio_arch_wants_loading_config_after_iter(void)
>> -{
>> -    /*
>> -     * Starting the config load only after all iterables were loaded 
>> (during
>> -     * non-iterables loading phase) is required for ARM64 due to this 
>> platform
>> -     * VFIO dependency on interrupt controller being loaded first.
>> -     *
>> -     * See commit d329f5032e17 ("vfio: Move the saving of the config 
>> space to
>> -     * the right place in VFIO migration").
>> -     */
>> -#if defined(TARGET_ARM)
>> -    return true;
>> -#else
>> -    return false;
>> -#endif
>> -}
>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>> index e4785031a73..b0eea0de678 100644
>> --- a/hw/vfio/migration-multifd.c
>> +++ b/hw/vfio/migration-multifd.c
>> @@ -16,6 +16,7 @@
>>   #include "qemu/error-report.h"
>>   #include "qemu/lockable.h"
>>   #include "qemu/main-loop.h"
>> +#include "qemu/target-info.h"
>>   #include "qemu/thread.h"
>>   #include "io/channel-buffer.h"
>>   #include "migration/qemu-file.h"
>> @@ -44,7 +45,16 @@ bool vfio_load_config_after_iter(VFIODevice *vbasedev)
>>       }
>>       assert(vbasedev->migration_load_config_after_iter == 
>> ON_OFF_AUTO_AUTO);
>> -    return vfio_arch_wants_loading_config_after_iter();
>> +
>> +    /*
>> +     * Starting the config load only after all iterables were loaded 
>> (during
>> +     * non-iterables loading phase) is required for ARM64 due to this 
>> platform
>> +     * VFIO dependency on interrupt controller being loaded first.
>> +     *
>> +     * See commit d329f5032e17 ("vfio: Move the saving of the config 
>> space to
>> +     * the right place in VFIO migration").
>> +     */
>> +    return target_base_arm();
>>   }
>>   /* type safety */
> 


