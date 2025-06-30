Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7099CC83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGZH-0005FC-1b; Mon, 30 Jun 2025 11:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWGYR-0004H9-EV
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:36:26 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWGYI-0000kD-VF
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:36:21 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a531fcaa05so1313604f8f.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297771; x=1751902571; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HmvWQGr0nX7fwvDER3GScHh0oc11xAW62USOyHRzhjA=;
 b=YIJNW/BL3Ot0dsMG2rkEG+/PQozuwkL0ZTRA/wRd8vSTP8lJKiDCVorODzeg2l0y/+
 yTPMX2wcGc1ziBXX9bYqfdCK9TUTuWmcnH7xeixWsi4scLf5MYY2L2PFuNm1dMuO5wqv
 LDtoq0G7U/x864qK8w/1yb+nhEYeIjw9EoMpSPhE2Gy3Y6/3nfpMNtmFsw5zfrUsH5v9
 YRqS90Bo19dzDZbN6xD5ZYzqxDSEiE4aRVBMVPWSn7Hr1KifxIOrYaOfoLA872VzdwSI
 IuyEf3Yeh1PVo2HKldjS+7bZ7TqGPtsBSoBBAh/YkOnppmxsQN/+bSnuedWCYANUKVNZ
 U2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297771; x=1751902571;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HmvWQGr0nX7fwvDER3GScHh0oc11xAW62USOyHRzhjA=;
 b=k4q+0C3HLsZgFdiRsBYkf5y9UJtRcBWYHFvCPu+DEDwvAzfdUgleFKyouuRjmkCwvn
 Hjt6b/8PpERnY48BFDZPRNVQ2C+TmaO9bmXhPM7WOWhQbttBD3keUFIuLvTW+wi5lDHP
 quypTe+VfDOxHRRRANaUqgJWRMfjlUwHKQL0QFDGG2u+BzEBR5w0DkHdE7Y1ekrP0Bef
 dHoEvKI8hriJG6HEAkU53qyW7B8n1leaBEcmQ1uPMdNm72aMtXz5X3SJyh32Tt6SJhXk
 cyIe6/LXof52uuZTQkypqm/nTtDYx52/z3i6gwVhyh109EUL6jSIKYdyQH3rxrJ3Ya0I
 ugwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZnZkkOKExwHL/0N74leHIYs1OFj6RuA58lleh2pamVyh+S8/dy92XJaiYXoHDJ+c8lQnKQoIGIJU9@nongnu.org
X-Gm-Message-State: AOJu0YyJNdjRTX48QaJz8U7SLmxq8gkIQdOD5OlKA6gPg8AzFANBhOL6
 9iV9UuVx6wraHYt0RyT+65IE8nBju5s+4YxPFSCuYfwS86BbZ/W+RtiOrCPf7ihtk+4=
X-Gm-Gg: ASbGncuu8Cl4Vgvqqgu+O7MJzdKL1OtoFbtKx/nwk1cO7arVob/HJxgHUVeo1xlzGja
 WJROnoF9nKmgdZ9MTSO9YfPIOkduc1v3G7ogUiVsP4qvB/FPGRTA/vFo2kmjgn+LMK1Zk+OHe/y
 Cx6rJidLYh9uvuU6i2OycSat9tsumbPWptHREOFYV+E2i/+Tb7bIK6Wlytb2vmQscG++c1vFIGb
 DArsqw0LQ+UN0uHAI2r9eYituM66cuyO4rDyx3Znae5HEDSmIfRq4wjf2gFciYfNpMP6pbk8Uxt
 iHfFMWHfJqJEepQ9M04ddBPj6TM0+cV/7hFUpbKPfpG/sbf3jymv4GS7dUNBgiYgef4PDialFwH
 +Og3jN06E9eB/SV1s8YuTAx/BiFCW7A==
X-Google-Smtp-Source: AGHT+IFyxdXr1TVAuaYMXZySSThIReyOR20YN+zfqG5Bc5cNyKFH49UsJ2MLsCuXWpa15ypDeck1KQ==
X-Received: by 2002:a05:6000:4109:b0:3a3:6a9a:5ebf with SMTP id
 ffacd0b85a97d-3a8f4ee1d85mr11082528f8f.20.1751297771359; 
 Mon, 30 Jun 2025 08:36:11 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c800eaasm10970133f8f.37.2025.06.30.08.36.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 08:36:09 -0700 (PDT)
Message-ID: <4f4cbc2b-ed5d-42cc-a8e7-bf9908370029@linaro.org>
Date: Mon, 30 Jun 2025 17:36:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] target/arm: Share ARM_PSCI_CALL trace event between
 TCG and HVF
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250630130937.3487-1-philmd@linaro.org>
 <20250630130937.3487-6-philmd@linaro.org>
 <3c2dac0a-8524-42f2-bc7e-b57d66699660@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3c2dac0a-8524-42f2-bc7e-b57d66699660@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 30/6/25 15:53, Richard Henderson wrote:
> On 6/30/25 07:09, Philippe Mathieu-Daudé wrote:
>> It is useful to compare PSCI calls of the same guest running
>> under TCG or HVF.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/arm/hvf/hvf.c    | 3 ++-
>>   target/arm/tcg/psci.c   | 3 +++
>>   target/arm/trace-events | 3 +++
>>   3 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index 7a99118c8c2..6309c5b872e 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -34,6 +34,7 @@
>>   #include "target/arm/multiprocessing.h"
>>   #include "target/arm/gtimer.h"
>>   #include "trace.h"
>> +#include "../trace.h"
>>   #include "migration/vmstate.h"
>>   #include "gdbstub/enums.h"
>> @@ -1149,7 +1150,7 @@ static bool hvf_handle_psci_call(CPUState *cpu)
>>       int target_el = 1;
>>       int32_t ret = 0;
>> -    trace_hvf_psci_call(param[0], param[1], param[2], param[3],
>> +    trace_arm_psci_call(param[0], param[1], param[2], param[3],
>>                           arm_cpu_mp_affinity(arm_cpu));
> 
> Lacks removal of the hvf trace?

Oops indeed...


