Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5ED3C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 18:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0lM3-0002aB-9E; Fri, 04 Apr 2025 14:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0lLt-0002Yk-9e
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:01:14 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0lLn-0005LA-6W
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:01:09 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso16547735e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 11:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743789664; x=1744394464; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FvAmZY1oYwmJQwv1nZAoaLIYWLv/g+mt8JvOiRxCKDU=;
 b=M4sxQpJMW0N+yUQh0oeWz5Zp2KUCbZJCvX3TKpdVnsjC2GoDbPC7Oz4DPOjeD1zCNv
 OHPdNRijsKm70hR/5SKdRC45YaxQct3ZB8OOpoSX2NDYFSB4uByYo7/5zR3plNH/N/Hc
 RWAxBzNFofdIO5sXh0M5nQ4ycRyBJWxTCn3zFkuY//I8A1m2pZ3mYdj36BOfnzNFWlTU
 RyYvmm5rY++CipXA2FNO1MR+PnAb5+z73Pd6m15xTViW5EiPAGCLedfWuX4a2T1IAk0Z
 6ojrWg6Ffr6sVqbisGiROk8inueau4HFiYwCuOR89pr3h7geG0xDtpDVpEZEybekftpp
 bGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743789664; x=1744394464;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FvAmZY1oYwmJQwv1nZAoaLIYWLv/g+mt8JvOiRxCKDU=;
 b=hIYKyUqibSFIXYEOMwqNa7mRXDOWDIydxi09zvmcwCFpEOje0Db0TUQRnnlbX3Mybm
 +b/vi8ub4LbqyFejhSiIdiK4qdc+8fW5pSfZIZqZoPHXTPaHzbcVT7lJDh0v/EvlQRyW
 Lom3IbX18HlNmoBpbKV4V0g2UpN1Vgy11vtFbmL62MV2JmiKdXJM760nJcBS0GaLJ16p
 eq1cL+Z21+ZfogZwwh+kSRbWFqGVPja5dvNB0/YwJXJboGCytd0vURcgrHLIiMekzCPJ
 2xcuLQtY/7yjOJxasJfLUmtNq/op8CGkm532th9xXhyQHVc5kbTFK7wKGOu2FkJyI0+7
 niRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3LDwKfXBupl4tGoqsN4YTJyCj5Fx9XwPB7h7aIJxQ88l6TqNHvJ8kPgvA/l7JhXGzGBLURVrzeQTI@nongnu.org
X-Gm-Message-State: AOJu0YwiuCwtUGqulgb6yU5AdjaGBuJ5dI2qfJQ6RhEIJlEN0KbouG2m
 Mmpx8ZRVGX4dnKs4Nwsic6s8EEarTBmDEERbW1MFmt28MNl9B6upJoghlITEXq8=
X-Gm-Gg: ASbGncvITm7tJsOolPcIK4CyZkOZNniMhsF0TML8tvCRQ4nOLFftJSuf5gFzQyxA8jD
 T7B9qMw9ddfetoScdcZwU2GHbS7ZFXl0phCgy+QrL36yQYprqRs60imc/2e5f98VUBRSnpXyDRl
 OIxl3Nw8fH2AK38DjM5T8grmxInocVCmz0UgSdpVzazUyhjdBMKlrIDgHYGHDycwQsgAwHiD5bq
 YKRsWN+iNyUwqVm62D6Uvz832i4DWWMhegnxKaLeCJ2mNOWrEb0Usx8uu9lNO+wrWfHu13D8O3Y
 YRYuzYwYv2BjYlpw5hfiVuma1uHYShgXDYGZTgb/5U0XSSVgiM2hGGlGYg1VGqncEMAfQgVo4V3
 N7heA0d3h7Jm8E+/iiQ==
X-Google-Smtp-Source: AGHT+IFHUcGLq1qhmRHcuazEAie2nmOy6sAdfvoK9F3lvWmSsi6dcE+sIsCijLTg6ZrLq2xqxCTp2Q==
X-Received: by 2002:a05:600c:c1a:b0:43d:45a:8fca with SMTP id
 5b1f17b1804b1-43ecfa06fd2mr50790545e9.30.1743789664083; 
 Fri, 04 Apr 2025 11:01:04 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec16313edsm55277155e9.6.2025.04.04.11.01.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 11:01:03 -0700 (PDT)
Message-ID: <e334621a-db20-45f1-853f-0f341af2ad8f@linaro.org>
Date: Fri, 4 Apr 2025 20:01:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 19/19] system/vl: Filter machine list for
 binary using machine_binary_filter()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-20-philmd@linaro.org>
 <5fa51205-4172-41d4-8bd9-5a95e8da24c2@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5fa51205-4172-41d4-8bd9-5a95e8da24c2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Hi Pierrick,

On 4/4/25 19:10, Pierrick Bouvier wrote:
> On 4/3/25 16:49, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   system/vl.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/system/vl.c b/system/vl.c
>> index d8a0fe713c9..554f5f2a467 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -27,6 +27,8 @@
>>   #include "qemu/datadir.h"
>>   #include "qemu/units.h"
>>   #include "qemu/module.h"
>> +#include "qemu/target_info.h"
>> +#include "qemu/target_info-qom.h"
>>   #include "exec/cpu-common.h"
>>   #include "exec/page-vary.h"
>>   #include "hw/qdev-properties.h"
>> @@ -833,14 +835,29 @@ static bool usb_parse(const char *cmdline, Error 
>> **errp)
>>   /***********************************************************/
>>   /* machine registration */
>> +static char *machine_binary_filter(void)
>> +{
>> +    if (target_info_is_stub()) {
>> +        return NULL;
>> +    }
>> +    return g_strconcat(TYPE_LEGACY_BINARY_PREFIX,
>> +                       "qemu-system-", target_name(), NULL);
> 
> No, we should not have such things.
> We can make it work with proper QOM types, defined by target, instead of 
> relying on string construction/compare like this.

I am not understanding you, do you mind sharing code snippets of what
you have in mind?

> 
>> +}
>> +
>>   static MachineClass *find_machine(const char *name, GSList *machines)
>>   {
>>       GSList *el;
>> +    g_autofree char *binary_filter = machine_binary_filter();
>>       for (el = machines; el; el = el->next) {
>>           MachineClass *mc = el->data;
>>           if (!strcmp(mc->name, name) || !g_strcmp0(mc->alias, name)) {
>> +            if (binary_filter && !object_class_dynamic_cast(el->data,
>> +                                                            
>> binary_filter)) {
>> +                /* Machine is not for this binary: fail */
>> +                return NULL;
>> +            }
>>               return mc;
>>           }
>>       }
>> @@ -1563,6 +1580,7 @@ static void machine_help_func(const QDict *qdict)
>>       g_autoptr(GSList) machines = NULL;
>>       GSList *el;
>>       const char *type = qdict_get_try_str(qdict, "type");
>> +    g_autofree char *binary_filter = machine_binary_filter();
>>       machines = object_class_get_list(TYPE_MACHINE, false);
> 
> If we define a proper TYPE_TARGET_MACHINE per target, and we add this to 
> TargetInfo, this can become:
> 
> machines = object_class_get_list(target_machine_type(), false);
> 
> And we don't need any other string hack to detect what is the correct type.
> 
>>       if (type) {
>> @@ -1577,6 +1595,12 @@ static void machine_help_func(const QDict *qdict)
>>       machines = g_slist_sort(machines, machine_class_cmp);
>>       for (el = machines; el; el = el->next) {
>>           MachineClass *mc = el->data;
>> +
>> +        if (binary_filter && !object_class_dynamic_cast(el->data,
>> +                                                        
>> binary_filter)) {
>> +            /* Machine is not for this binary: skip */
>> +            continue;
>> +        }
> 
> With the approach above, this is not needed anymore.
> 
>>           if (mc->alias) {
>>               printf("%-20s %s (alias of %s)\n", mc->alias, mc->desc, 
>> mc->name);
>>           }
> 
> I think we are missing a commit here, defining a proper 
> TYPE_TARGET_MACHINE_PREFIX, that is target dependent, instead of the 
> TYPE_LEGACY_BINARY_PREFIX.
> 
> And we should include in this type in TargetInfo, the same way it was 
> done for cpus.


