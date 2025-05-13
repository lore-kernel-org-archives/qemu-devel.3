Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329A2C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 01:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEe9N-0000aO-I1; Mon, 12 May 2025 21:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEe9L-0000aD-0k
 for qemu-devel@nongnu.org; Mon, 12 May 2025 21:09:39 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEe9J-0007Vr-28
 for qemu-devel@nongnu.org; Mon, 12 May 2025 21:09:38 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22e09f57ed4so63355555ad.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 18:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747098575; x=1747703375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IucEarXOtKA9poYfriYqz/NwE8BeB84Fmpm/n5ypRo8=;
 b=m3bAg2kDd/unMxYPWgLpY8ZCe2mk531r7qFsK7SwPIN4KbDRCh5yyN7Lfs4N+CmaQl
 g9o91myCkQG+32uoovsqkK8Hh4fBHux+Z5PkqG42aUf8I5pXutO24cw/USBlqE5P9VEr
 mEiSxh29dtfCaEPURUsp69LRMyzU0cckkBk6ngRC8lojT+Nqnp1GLgUv055ids5UnW33
 QIZTCpkXnUrcaMdIEdv6pS8dQWAQ1jf3rgBSnAtl1kUfH/j2avc71DQ1j2enHkoIOfrY
 RkQsqV4vXWj4sp6IdKiU2dKeJp8SN6L1Zr+R1+8sN7c/pEAuYLhAJmHo9cyUr1B0ZJZI
 cURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747098575; x=1747703375;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IucEarXOtKA9poYfriYqz/NwE8BeB84Fmpm/n5ypRo8=;
 b=tDFD8p6t/e3WGdkwK+TNGruS4BQUqb3RqAB9JY32uOKvy7e1/vArFQB57+bRpGHqVF
 QFNTyAUHQzsK8Tfqlwks77H3pRUHtioWepCoY989zoS7/4BQlyH11NqfeAq8kKwPyxVU
 zAR3Xq8P1LrwjtIeugJs5uoBaX7canFfxWVl22q3KrQrukZPtv4tjwm7JpITnbLbpmRM
 d0R7WDpLeahLkvC73SQh8hm5xScDqmK6DMMXZWUvwI8INfkfK0iBE4hLvkY193hI50dZ
 yNuE+s42pvCnsAdGrkyKtS92mEPfL7Rl3qlfeBBl0Vm11rkXsb+g21N7zjhVxHdEOilQ
 2QYw==
X-Gm-Message-State: AOJu0YxlcmnZyPTogVSB3nVsC4CGsnazocUYhZ8Qb4nqN2LLquGqQ3IW
 NYoc9kdd+EVtF3xIld7MkDV8qb+eEodKHRSl4LZQ6Lu335vcyskzRKRgicBJrvw=
X-Gm-Gg: ASbGncuppGAqGe/GSUD9n+P/JQUBjINP/PFU7Ksb0DcI4EX4GcxGf64R6Pg3xcKgUi9
 QL9yHX9dCtt1K+wbjmhntJIc/x1jmVlTBKAwHODc8q0WudQXWq4hGP152JLjlfttLVkQVS1r4Gp
 BjXR1aHHIAPG8ODMh6D/HUJQ7c/ggzVUs4beWJ9SsURMjfgDUOgj9uNh2IOI2b6wyrJ3GiJTdgw
 PPbGs7GFM71kDdMDrf+fmgANH+gO61sPdawYzD084TLUsUKrihuYSLcasNOZ0OxF4DjFP5DHoka
 QAAMV471FUIaZT5RmU9aVvwG3NhoLHiKUbQ+avR08kh8SD0TTYyWMh123qO7T+KArC71am7cVx8
 =
X-Google-Smtp-Source: AGHT+IHLljqlLUz8Xf7xSNuqKZ0/Rl3jEV8KUvpcEZIofO5TFa1JNb6lpdByZsqxIJSD42zKG6D+8w==
X-Received: by 2002:a17:903:4043:b0:22e:3d2e:d94f with SMTP id
 d9443c01a7336-2317c41c093mr15829465ad.0.1747098575179; 
 Mon, 12 May 2025 18:09:35 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc828944fsm69612435ad.163.2025.05.12.18.09.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 18:09:34 -0700 (PDT)
Message-ID: <3be5c74d-ab52-451b-ae27-de4615ac3432@linaro.org>
Date: Mon, 12 May 2025 18:09:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] qapi: expose rtc-reset-reinjection command
 unconditionally
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250508135816.673087-1-berrange@redhat.com>
 <20250508135816.673087-2-berrange@redhat.com> <87ldr4zt3d.fsf@pond.sub.org>
 <aCI_A7ymWf-f3fOT@redhat.com>
 <b57200ba-4a5f-4788-b38c-2af064a15439@linaro.org>
In-Reply-To: <b57200ba-4a5f-4788-b38c-2af064a15439@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 5/12/25 5:54 PM, Pierrick Bouvier wrote:
> On 5/12/25 11:33 AM, Daniel P. Berrangé wrote:
>>>> diff --git a/stubs/monitor-i386-rtc.c b/stubs/monitor-i386-rtc.c
>>>> new file mode 100644
>>>> index 0000000000..ee2e60d95b
>>>> --- /dev/null
>>>> +++ b/stubs/monitor-i386-rtc.c
>>>> @@ -0,0 +1,10 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +#include "qapi/error.h"
>>>> +#include "qapi/qapi-commands-misc-i386.h"
>>>> +
>>>> +void qmp_rtc_reset_reinjection(Error **errp)
>>>> +{
>>>> +    /* Nothing to do since non-x86 machines lack an RTC */
>>>> +}
>>>
>>> I think I'd create one stub file per qapi/<foo>-<target>.json.
>>
>> That's what I started doing but I forgot that doesn't work out well
>> with the linker.
>>
>> The linker's granularity for dropping stubs is per-file, not per-symbol.
>>
>> If /any/ method in a stub/nnn.c file is needed, the linker will pull in
>> all methods. This results in duplicate symbol errors if only a subset
>> of stub methods were actually needed.
>>
> 
> Richard mentioned this behaviour as well, but I could not see where it
> is implemented in our build system.
> 
> The only thing possibly related is the undefsyms mechanic, but from what
> I understand, it's only for ensuring modules can be linked.
>

Answer: it's an implicit behaviour, due to the fact libqemuutil is built 
as a (real) static library, so the linker only adds code as needed.

>> This forces us to have a separate stub file per build configuration
>> scenario that can affect use of stubs.
>>
>> With regards,
>> Daniel
> 


