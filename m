Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B20D26D9F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 21:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veKCz-0006cH-Lb; Fri, 09 Jan 2026 16:39:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKCx-0006c4-Qh
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:39:47 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKCw-0004qB-6C
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:39:47 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b4755f37c3eso2785301a12.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 13:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767994785; x=1768599585; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yqKepFWYhYcQT+kIYzU7wb+I1yeEevLLT+NvKJUyFDE=;
 b=AxCNUMrZ1eOScCtKWHM27uI3zxQ+7k7Yz4pqFwLm2HVAf3FxKNIVMzHoQRluDTVQkQ
 BzLaz9ayAD0nKc03YmqhtLc+Ba2fEslrALxkYZSVL6BSvQBmBL2Xayne87XRlrosZpE7
 lXVEPEVWNXZSFrbpKMqFY/zmIbE4fJmuts6LBtcXHyskDusTTyK0e0IDlJ4dmuwnihdw
 4bFYG6YxJFESBZs90TPB6zZYojBdcpnVeNPoSqUwjZrcYFfxJfJ5ZHT/ttb3gpuoKEP0
 zMLMOoHMJbVdvw6XtUqTTRKCjP4j8xIqp3aObncPyGTXmiZv+koA//YkvGi2TTzL1Eg5
 2kiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767994785; x=1768599585;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yqKepFWYhYcQT+kIYzU7wb+I1yeEevLLT+NvKJUyFDE=;
 b=Du6jaIawrFmoTAp9b+r9V6pWXG9wkJLffZbFbUQgFGcLafi8XSnTWIfpVdtNfllbBN
 pQg+6DcTtfrK7iVkQ6RbfxqI5/zFtzNL+6n4b9ETJUF7yy756Ew67K1n0LNSPsHnlZF4
 QUTBZNL79muH5+tzjmPK2YJuGmLMBd6GxJZMlZMtQRFVQO9Xt7JytN8NmCIIGdNRwHTT
 uXhahA84fPpCQLBCfcUKy69fp78f6jnEO4X8wWuOyJyBv2hnF4b5FFrgsm0znjNOTGsi
 zUDO3C8LxvDBhW0EEnfl1sQRzJ+1jUlqT/J0jBDveCw1ZB5OKDsMy32UTFqZ0DjxGiFm
 5QFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYD9uZv3XvACR19q4+Sp0RK9ilzCb/Y4mDfbfttfdVJxVOkt7WSFtZ54utQnwdQOSPquLbWZvQaiFX@nongnu.org
X-Gm-Message-State: AOJu0YwSydPc/P1dLWwFbjpaYRp7DR27jq6zMkOi5CQV37LVrrtEBGC2
 4jVmP43QL+lvHCaoawIDO4gB7zn1lSTKwaomPTDgEf+nU4M1CZ9wSDxm6BX7KPd7BTI=
X-Gm-Gg: AY/fxX6UrwmVtfJRXz9KUzZsiHSJ8gJdfVs9gZ8PjVq5ofRjk9W7t91fzCP38ZC/uFP
 3F4ZKsURnjfmbRaDSIAlTcGNSiJ3+IwyQv6lVEPcLyHTfSgo16RIk5wwKkd1FQa2O2xGjsfjBwI
 yVwIGBnycwyHvWzTRnVXi1/ExkTYvByV/uy/9KCeNfi8TrS6Yc/zslFeNXfQz5MFxfeFOJTQvXg
 r9iCr6m8RDkoG/MFAFNLuc3oyiWpk2UfNrkc4gGW8zrrKbesWNImCANCthRE6BmekwEV1zPQviR
 r7muAfEfXkVcgryEgtTTzq7UlN0uMWN36Jxle2kMrm5kTmv7iW5XJczhvIlKg7Li3TxQmrqy+a8
 TQ6fWRsjKaKF5n2VsN43FihkT0wOBRrTjSoqHyljuFF3+zxWShAvZezzgVCFdx799TpCYVvZ7sH
 n0LSym2JDscv1vLDLbVJbgeH00tw==
X-Google-Smtp-Source: AGHT+IHdYV7IlH4wviLn1IDEnq3TlNRHRoarQFPRx1EcWA0Xrw5VtVt4MvXX7hoRjQyvaWXmSpKllA==
X-Received: by 2002:a05:6a20:7d9f:b0:350:7d78:18d9 with SMTP id
 adf61e73a8af0-3898f90887dmr9677319637.32.1767994784617; 
 Fri, 09 Jan 2026 13:39:44 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbfc2f6d3sm11386984a12.9.2026.01.09.13.39.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 13:39:44 -0800 (PST)
Message-ID: <8d75182c-6d57-4a80-a325-94e6795c1747@linaro.org>
Date: Sat, 10 Jan 2026 08:39:36 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/29] target/arm: extract helper64.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-7-pierrick.bouvier@linaro.org>
 <059994bb-41af-4fed-a058-b100b4a3734f@linaro.org>
 <e6a2191a-0b72-402e-9b06-d06269b5363e@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <e6a2191a-0b72-402e-9b06-d06269b5363e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 1/10/26 08:37, Pierrick Bouvier wrote:
> On 1/9/26 1:30 PM, Richard Henderson wrote:
>> On 1/9/26 16:31, Pierrick Bouvier wrote:
>>> --- a/target/arm/tcg/translate.c
>>> +++ b/target/arm/tcg/translate.c
>>> @@ -26,6 +26,9 @@
>>>    #include "arm_ldst.h"
>>>    #include "semihosting/semihost.h"
>>>    #include "cpregs.h"
>>> +#ifdef TARGET_AARCH64
>>> +#define HAS_HELPER64
>>> +#endif
>>>    #include "exec/helper-proto.h"
>>>    #include "exec/target_page.h"
>>> @@ -33,6 +36,12 @@
>>>    #include "exec/helper-info.c.inc"
>>>    #undef  HELPER_H
>>> +#ifdef TARGET_AARCH64
>>> +#define HELPER_H "helper64.h"
>>> +#include "exec/helper-info.c.inc"
>>> +#undef  HELPER_H
>>> +#endif
>>> +
>>>    #define ENABLE_ARCH_4T    arm_dc_feature(s, ARM_FEATURE_V4T)
>>>    #define ENABLE_ARCH_5     arm_dc_feature(s, ARM_FEATURE_V5)
>>>    /* currently all emulated v5 cores are also v5TE, so don't bother */
>>
>> In the ideal case, only the files that require the helper data will include it. So, for
>> example, the helper-sme.h data would only be included by translate-sme.c and sme_helper.c,
>> etc.
>>
>> I now see that while I planned for this with how I set up HELPER_H, I didn't follow
>> through with the cleanups anywhere.
>>
> 
> I'm ok to do this if you prefer.
> 
> In this case, may I suggest we rename helper to something different and let actual names 
> be placeholders for:
> #define HELPER_H "helper-impl*.h"
> #include "exec/helper-gen.h.inc"
> #undef HELPER_H
> 
> This way, C files don't have to deal with this, and simply see:
> #include "helper.h"
> 
> Any other name is welcome is you prefer.

That sounds fine.  I can't immediately think of better naming.


r~

