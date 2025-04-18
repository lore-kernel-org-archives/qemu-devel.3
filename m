Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0625C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 14:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5mV5-0004LX-N2; Fri, 18 Apr 2025 10:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5mV2-0004LK-6v
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 10:15:24 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5mUp-0006fc-0m
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 10:15:23 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so1935841f8f.2
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 07:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744985682; x=1745590482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xzyt7lJ/ARbR+vqCuL1F4Sy7x4BC5zzVf755pnPqWRc=;
 b=f67bnXNcL3SzuhRkU7iiChk/ru6RJO8MkcSdZDA0kA3ErNoS4w6g4xJuydbzAMVwGm
 UySzyrsAVC4YEAcsnued2N+Ns92dXZ2T2joTyWYLFRU0RGjrd3Aa5FW4TS8Y6ZposoeB
 KsJ0YIqLDKHCcwda/pbLjZ6d+Jk7n10pFJfrowshMwMtYV/xELz/cHJ/ZF2iydo5/Hgj
 j8AWkQ0vwXN5rFcHiKQ3ermKYDtaeqwfn3ZXS208mMArpW7eUaBbbwrNyc7XFIHx5TDv
 +Aa04i2XGSwLBoOTrCi6U63b98gyhfTPQvXv4He8c/q2/UZ8c4GeaMI9YiPF4fxOb2Gc
 +69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744985682; x=1745590482;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xzyt7lJ/ARbR+vqCuL1F4Sy7x4BC5zzVf755pnPqWRc=;
 b=XQyEuUoNArFenqTP8GK8Vdi7oKMd/kIoIAVsXApqp0YT0jJJFqB1jfEQKyjXPiCAV9
 Ammf/LVYUyL5sPUVDfWMAg5DckSjfuvSnTaxGQa5uUZ+tVkp5Vh0rudzM/8NjJrasgaB
 7c9UR9gTNE0kEFItBViZR/jLJq96P/j0/vz/i0BZR9c01DovjMm09DnYWeGgA+S6AR5h
 YWnwoqMG4fWTZppII4nvDMbmy1z50rJ5EaTJJX9ejaZ5p9DyMxRaaEXfsix3DtNjgGrF
 31dVLrl7VkcE+UdtDFGQNyfkfB+csOtFNl4tZKtYF21yYZ0TyZEOlGQWNsRnEwUHhH5H
 2TMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3cYdQ4pMlqAdFV6fVwMsAEoUZyi37Om/U6mEL6bBw1Bh3eD5S95OiOcEJK0rNFCyck+h1UhwqkC+0@nongnu.org
X-Gm-Message-State: AOJu0YwXIftj7zT5eJaMzvxFAoMRxl66x3wDMrPNW0fJC9wMw7cTNhMk
 uJQn+fu/llTaVCW+bWGNv/NBiVlMShOwAW5OvrJ+MFnizrbCJNVBfErEuwIw/sOLJhmAiwaqRn/
 +
X-Gm-Gg: ASbGncs1lx9b6DARnJ15xyTwgi1/x43egOaFOHQy5K4b2Uav++pkXcqsCjJDZhsTRIl
 ZPOi3vSthRbINiA6xspUxNjo1ZxWJDGWdiNRrxYzt3gX8BcipKLS5t69++pElhJwgQ8JloP/5rh
 au/2c4y5npd77yaHSbc5teVwjTdyUnRcshFs8G01hGZybKYGau/mYsI9UzskYqZ16e9VklsW5sI
 UObb40I1ZGDkUPZmTqhYFqEk5wCG7xGwgbBzIXnC5VW8VoRqHnTZCGnqAqjxWYsfT0OPgLlsm3G
 lvHlPi8d3NFTSRI4QrgyqnBl0DP7kbTrus8NIDJyGH6rYQK4LHmP9UayhKWV+9ohdhHpXkCe9BN
 /T2ykpk8e
X-Google-Smtp-Source: AGHT+IHRPLfJWbUsXK1ZV1gpKAk+qI4TQTU1ca1m2x3ppGyRmjtiFZParkScEFJLZ7OY3FnVVeLgqA==
X-Received: by 2002:a05:6000:1acf:b0:39d:724f:a8f0 with SMTP id
 ffacd0b85a97d-39efbace61bmr2065540f8f.42.1744985681864; 
 Fri, 18 Apr 2025 07:14:41 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4a4e9esm2908343f8f.96.2025.04.18.07.14.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 07:14:41 -0700 (PDT)
Message-ID: <33deb076-968d-498e-8f25-6dcc51acf1f6@linaro.org>
Date: Fri, 18 Apr 2025 16:14:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/11] system/vl: Filter machine list available for
 a particular target binary
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
 <20250418005059.4436-4-philmd@linaro.org>
 <fc3312bf-2a79-405a-bed9-72078cd7e5f2@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <fc3312bf-2a79-405a-bed9-72078cd7e5f2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 18/4/25 05:06, Pierrick Bouvier wrote:
> On 4/17/25 17:50, Philippe Mathieu-Daudé wrote:
>> Binaries can register a QOM type to filter their machines
>> by filling their TargetInfo::machine_typename field.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/qemu/target_info-impl.h |  3 +++
>>   include/qemu/target_info.h      |  8 ++++++++
>>   system/vl.c                     | 14 ++++++++++++++
>>   target_info.c                   |  5 +++++
>>   4 files changed, 30 insertions(+)
>>
>> diff --git a/include/qemu/target_info-impl.h b/include/qemu/ 
>> target_info-impl.h
>> index d5c94ed5296..990fb067d20 100644
>> --- a/include/qemu/target_info-impl.h
>> +++ b/include/qemu/target_info-impl.h
>> @@ -16,6 +16,9 @@ typedef struct TargetInfo {
>>       /* runtime equivalent of TARGET_NAME definition */
>>       const char *const name;
>> +    /* QOM typename machines for this binary must implement */
>> +    const char *const machine_typename;
>> +
>>   } TargetInfo;
>>   const TargetInfo *target_info(void);
>> diff --git a/include/qemu/target_info.h b/include/qemu/target_info.h
>> index 3f6cbbbd300..e9fd2fdd7b0 100644
>> --- a/include/qemu/target_info.h
>> +++ b/include/qemu/target_info.h
>> @@ -16,4 +16,12 @@
>>    */
>>   const char *target_name(void);
>> +/**
>> + * target_machine_interface_typename:
>> + *
>> + * Returns: Name of the QOM interface implemented by machines
>> + *          usable on this target binary.
>> + */
>> +const char *target_machine_interface_typename(void);
>> +
>>   #endif
>> diff --git a/system/vl.c b/system/vl.c
>> index d8a0fe713c9..4e43e55afe7 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -27,6 +27,7 @@
>>   #include "qemu/datadir.h"
>>   #include "qemu/units.h"
>>   #include "qemu/module.h"
>> +#include "qemu/target_info.h"
>>   #include "exec/cpu-common.h"
>>   #include "exec/page-vary.h"
>>   #include "hw/qdev-properties.h"
>> @@ -836,11 +837,17 @@ static bool usb_parse(const char *cmdline, Error 
>> **errp)
>>   static MachineClass *find_machine(const char *name, GSList *machines)
>>   {
>>       GSList *el;
>> +    const char *qom_typename_filter = 
>> target_machine_interface_typename();
>>       for (el = machines; el; el = el->next) {
>>           MachineClass *mc = el->data;
>>           if (!strcmp(mc->name, name) || !g_strcmp0(mc->alias, name)) {
>> +            if (qom_typename_filter
>> +                && !object_class_dynamic_cast(el->data, 
>> qom_typename_filter)) {
>> +                /* Machine is not for this binary: fail */
>> +                return NULL;
>> +            }
>>               return mc;
>>           }
>>       }
>> @@ -1563,6 +1570,7 @@ static void machine_help_func(const QDict *qdict)
>>       g_autoptr(GSList) machines = NULL;
>>       GSList *el;
>>       const char *type = qdict_get_try_str(qdict, "type");
>> +    const char *qom_typename_filter = 
>> target_machine_interface_typename();
>>       machines = object_class_get_list(TYPE_MACHINE, false);
> 
> We can replace change to system/vl.c with:
> 
> const char *machine_type = target_machine_interface_typename();
> machines = object_class_get_list(machine_type, false);

Clever!

> 
>>       if (type) {
>> @@ -1577,6 +1585,12 @@ static void machine_help_func(const QDict *qdict)
>>       machines = g_slist_sort(machines, machine_class_cmp);
>>       for (el = machines; el; el = el->next) {
>>           MachineClass *mc = el->data;
>> +
>> +        if (qom_typename_filter
>> +            && !object_class_dynamic_cast(el->data, 
>> qom_typename_filter)) {
>> +            /* Machine is not for this binary: skip */
>> +            continue;
>> +        }
>>           if (mc->alias) {
>>               printf("%-20s %s (alias of %s)\n", mc->alias, mc->desc, 
>> mc->name);
>>           }
>> diff --git a/target_info.c b/target_info.c
>> index 877a6a15014..226eed1fd7d 100644
>> --- a/target_info.c
>> +++ b/target_info.c
>> @@ -14,3 +14,8 @@ const char *target_name(void)
>>   {
>>       return target_info()->name;
>>   }
>> +
>> +const char *target_machine_interface_typename(void)
>> +{
>> +    return target_info()->machine_typename;
> 
> And here:
> 
> const char *machine_type = target_info()->machine_typename;
> if (!machine_type) {
>      machine_type = TYPE_MACHINE;
> }
> return machine_type;
> 
>> +}
> 
> This way, there is no special case to handle anywhere, and we can safely 
> replace occurrences of TYPE_MACHINE queries with 
> target_machine_interface_typename().
> 
> As well, just a nit, but it's not important to know it's an interface, I 
> would prefer a simpler name: target_machine_type();


