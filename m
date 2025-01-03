Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96223E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 14:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTine-0000ow-R1; Fri, 03 Jan 2025 09:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTina-0000ls-UA
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:37:16 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTinY-0004XS-LY
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:37:14 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso81488125e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 06:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735915030; x=1736519830; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DfEnmb8Rktf9iJVdyHrY6P07HXSwQD2OcWlB2ELuINs=;
 b=rp31yQ/2O9FdxQbsnoJLDTU61qKusxedAwXJGzAghHknSfiUDGlg3SNusNXOYJ+sPr
 57rRR2YPQDSz5znx7WilpdFijLU4dy2gnWeCfyJ4La07fxXH98NiV8D9xOQMft/gLeOp
 lLu/YZE5Tc+minr8beh6mm57HefpSKmlg7eb4tc8hc55L18wq6wc2F5oPHOQgkv+25FZ
 X3gCwzcGRkMAaxSoA8kv2iY4KoqnLsptUcF5p8sbAPKr3b0PCwnc6MfEu5BxfbJnJizo
 5vDXCqvtMH/KwOdcYxFqAIN23jdTjtI9Gdl8pGQ4+DoX1iETyPftBQOgqQ6ebOtAKfRN
 ruDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735915030; x=1736519830;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DfEnmb8Rktf9iJVdyHrY6P07HXSwQD2OcWlB2ELuINs=;
 b=Sg1WIbVhs825dgn6+CZv5zvWJKNDZd73HjreKCmLWiFB8ew2SVbJRqXOhNl1NZdtcd
 IRnx50GzJkkiyTHqbM4d8Ak5TFK8wvkWmu24IBvcQn8IDOlWBbKD5azWJx8IuwqkVmCC
 M3vsl1w3aVsj08AKhJa+jlVORyPjt4hmeQ7LgmcR2Z/jcJD4ZhLSVkDxjUi0gSh99dbh
 fEKQ1uMJNvWZkdOQSTPdBjpVMQHqFfbgmG2ioK+Lu8MO/HyBg1ahN74gK33Y+L0SM6EH
 Mg0U60ia02K+rsKMmPalSwe5OQpdyaT1Y0Z7wKycyE0xm5CQiKKrBwZZ8Y6AS6deooBL
 /PZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW91hWLcCTn+oLB+Ef0zzXmVOdQhWrGAw/x61m3d0vJsnCSxV04VT7a+/rtFiAgwfBWKCttbOBSpFH9@nongnu.org
X-Gm-Message-State: AOJu0Ywug/get8qM6a5iJaL28urWaxLp+GBSFv7vr92lnJyjBMW/CjjN
 EefEvkwfpwSPLIxOKsn3a3zz0FdrqTr/gzWz6aRUSqjpyJPxxKGZGooQK764l4U=
X-Gm-Gg: ASbGncsAtR2m63k0jFk/WcdyKESc7LWExl7cgn3IBtW6nE2jI48anxwQw46mFSFNrJg
 o31Ka4mheJJLxgmgMXLU+LA42bUJbU1HvIMHg4W7LaNKG146vinhzqsyMId0w7SuyZj1yXly/23
 BQFgaCNCFwTwlVC/HmiKjbLqSvdS52p4gNS1UD40ZWwPa8eyYJSHe4Gr+FtVHA1+HD0H11XjjIC
 7BSXPpTsOe/ccWU/JK8VFc4atbciHrggUm2KYUgDWyQB00E/GvT5sIlsCJzX7KKbKT6XQvn9jjL
 c2rBQGRommE+gnWHhIHkeG71
X-Google-Smtp-Source: AGHT+IHJApoX633yVMi64TCcPSEABuvSmCnn0zU4TTAlYwRFgWx1uHokAuFwKJheOGUgBZVPaxBJPg==
X-Received: by 2002:a05:600c:3ca4:b0:434:fe4b:be18 with SMTP id
 5b1f17b1804b1-436686468fcmr451577385e9.18.1735915029644; 
 Fri, 03 Jan 2025 06:37:09 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661218f43sm488105015e9.19.2025.01.03.06.37.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 06:37:09 -0800 (PST)
Message-ID: <673f7002-9ee8-403c-960f-e4f79058ff99@linaro.org>
Date: Fri, 3 Jan 2025 15:37:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] qdev: Implement qdev_create_fake_machine() for
 user emulation
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eduardo Habkost <eduardo@habkost.net>
References: <20250102211800.79235-1-philmd@linaro.org>
 <20250102211800.79235-2-philmd@linaro.org>
 <87603a20-8c61-454e-9f05-bff7823f69e7@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87603a20-8c61-454e-9f05-bff7823f69e7@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/1/25 15:24, Richard Henderson wrote:
> On 1/2/25 13:17, Philippe Mathieu-Daudé wrote:
>> When a QDev instance is realized, qdev_get_machine() ends up called.
>> In the next commit, qdev_get_machine() will require a "machine"
>> container to be always present. To satisfy this QOM containers design,
>> Implement qdev_create_fake_machine() which creates a fake "machine"
>> container for user emulation.
>>
>> On system emulation, qemu_create_machine() is called from qemu_init().
>> For user emulation, since the TCG accelerator always calls
>> tcg_init_machine(), we use it to hook our fake machine creation.
>>
>> Suggested-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/qdev-core.h | 10 ++++++++++
>>   accel/tcg/tcg-all.c    |  8 +++++++-
>>   hw/core/qdev-user.c    | 21 +++++++++++++++++++++
>>   hw/core/meson.build    |  1 +
>>   4 files changed, 39 insertions(+), 1 deletion(-)
>>   create mode 100644 hw/core/qdev-user.c
>>
>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>> index e6ef80b7fd0..b83b1439968 100644
>> --- a/include/hw/qdev-core.h
>> +++ b/include/hw/qdev-core.h
>> @@ -1027,6 +1027,16 @@ const char *qdev_fw_name(DeviceState *dev);
>>   void qdev_assert_realized_properly(void);
>>   Object *qdev_get_machine(void);
>> +/**
>> + * qdev_create_fake_machine(): Create a fake machine container.
>> + *
>> + * .. note::
>> + *    This function is a kludge for user emulation (USER_ONLY)
>> + *    because when thread (TYPE_CPU) are realized, qdev_realize()
>> + *    access a machine container.
>> + */
>> +Object *qdev_create_fake_machine(void);
>> +
>>   /**
>>    * qdev_get_human_name() - Return a human-readable name for a device
>>    * @dev: The device. Must be a valid and non-NULL pointer.
>> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
>> index c2565758876..95adaacee82 100644
>> --- a/accel/tcg/tcg-all.c
>> +++ b/accel/tcg/tcg-all.c
>> @@ -35,7 +35,9 @@
>>   #include "qemu/atomic.h"
>>   #include "qapi/qapi-builtin-visit.h"
>>   #include "qemu/units.h"
>> -#if !defined(CONFIG_USER_ONLY)
>> +#if defined(CONFIG_USER_ONLY)
>> +#include "hw/qdev-core.h"
>> +#else
>>   #include "hw/boards.h"
>>   #endif
>>   #include "internal-common.h"
>> @@ -124,6 +126,10 @@ static int tcg_init_machine(MachineState *ms)
>>       tcg_prologue_init();
>>   #endif
>> +#ifdef CONFIG_USER_ONLY
>> +    qdev_create_fake_machine();
>> +#endif
> 
> No need to return the fake machine, it seems.

My first reasoning was about avoiding ASan leak warnings, planning
to release that container on exit(), but I'm clearly over-engineering
what is meant to be a kludge.

>  With that,
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I'll remove and merge directly, thanks!


