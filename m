Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADA6C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWyyF-0007lW-RY; Wed, 02 Jul 2025 11:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWyy2-0007hh-TT
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:01:53 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWyxz-0006sQ-Fv
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:01:46 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-72c09f8369cso2139861a34.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751468501; x=1752073301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oeJe0oqfOhiN2o7Np90JWZ2zQvTHoFlGF/pBFTZuXwY=;
 b=cePCklfjpUywfY6XII4h7JQ5+mxshj0oS+q5CHcYlSzAZ7SSgP+4mYJcD86jppFlsW
 5X6l9W/b3+zfTtuygNQQIfnL2ZTDkKTB1TxWjiIWsXDlHt4sJd601Rj5jJJQ2bDMfSRg
 OmOkIDBlB7iD1rGLEgmCUIiC2hRSXFEhEmKDu1Sb5pp1CDqh5hsy0xGol29UYbtoWlJw
 J3YnkJBxWVZGsPIF+3pn7WJdRiwCVOe3dnqaAintA+T4NAadZ0obrAV4+//OTVRjqAkV
 oTFEnZxbNaaP2JLFT4fHdO2Agx8yQ3SlW1DskRGlmDYCz8AkbpaWu0ch5xvs9AsxumH7
 yR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751468501; x=1752073301;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oeJe0oqfOhiN2o7Np90JWZ2zQvTHoFlGF/pBFTZuXwY=;
 b=DD1ALHkOMyaG3g9Y7Zo53HWrgCD6mlOT+CU6eH7wyxl5U2RN7Z6vPXxJRyLhzjrzhs
 aPVXFKQbK19v++NKAYQBjZBeVNqM5hiTLyKLgRg5thhYeMQgE2DK+Yg4oBq2FA4LhnXC
 WI7+Rr1fuefUYc2T0AVFyGwACUr3OSp5eElCWLMbqZyD6y9l5MUZhiebcqCz3ncTSAAA
 gW4eV8ozvLr7itwS8O/hyV7I6rUcoLC25q5ZwL684TJnIq0vjhYOLsOuibO+n0fRhNck
 evg0pSmsz26yE82FIGLdXzpgQiNi/8CLPXHFXMbTr/iZZCdTB3kjXHIVjh+fRoXr8NNJ
 j+2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzOd8RJKJHx+oOvorAtu4ily8DwSv3ee/EMc9OO3D++kYTdjMkKJDghH517RSkbdfVGs0HkA5trxhR@nongnu.org
X-Gm-Message-State: AOJu0Yy00ZwuPct2xocbmcRwzoxI29PeVZMx3SU8Sh0gaMsHTufBxm94
 k82p/tu+GDZ/Hg32HXmbG5MiVWJarjdCa7l3b903fjngzvTI2E1LYTM78RFesgl2m/HqElchOVk
 EwcHjbWA=
X-Gm-Gg: ASbGnct6nRlQ8nQt2joRVvClGlcescQkETk4+JM1AwxqIHI/MhVur5BA/5e/IN2A3QY
 q2rTH/ojb/DIlmGHKHkjSiCtnmyXJ5OtSSwfdJawrtjzkr8tf6OD/2RKrhX+HOkx4dDFu+rhBjW
 kZ1CRxiPT7kO7n0/r69Eh0I2Ac14tQL/JJUhCRUHGf5//kGHzRC+vLOIATVBH2RwOkujjP3uraA
 PJZo2cdonMHHyhGa19g5Kyvw+wCIEPYg9jChh7kKgzmbEnQEzYWKABq7v8g8KD1+o88N1lakbP+
 +A/HTZ7HNobdzsV77/f+fdO3oflVJtcZ5d8JmXvWaj7VE5mlZXhuOOSdY0Uz04bS4RCce+vKiGd
 6
X-Google-Smtp-Source: AGHT+IG58qJQw3+FriXEZcXhV55HTRdIxEh5oA2F9aZw4Sa6bfdhDoXMoo0zn3PNZS7nXMQs8MA0Jg==
X-Received: by 2002:a05:6830:7204:b0:735:afba:baae with SMTP id
 46e09a7af769-73b4cc2296bmr1820431a34.17.1751468499838; 
 Wed, 02 Jul 2025 08:01:39 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb122b39sm2514304a34.64.2025.07.02.08.01.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:01:39 -0700 (PDT)
Message-ID: <779058e1-489b-414d-81ef-5108684c3646@linaro.org>
Date: Wed, 2 Jul 2025 09:01:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/68] accel/whpx: Convert
 ops::synchronize_pre_resume() -> pre_resume_vm()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-22-philmd@linaro.org>
 <f7319740-882c-49f5-90ae-79832d99996b@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f7319740-882c-49f5-90ae-79832d99996b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

On 7/2/25 01:20, Philippe Mathieu-Daudé wrote:
> On 1/7/25 16:39, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/i386/whpx/whpx-accel-ops.h | 1 -
>>   target/i386/whpx/whpx-accel-ops.c | 1 -
>>   target/i386/whpx/whpx-all.c       | 3 ++-
>>   3 files changed, 2 insertions(+), 3 deletions(-)
> 
>> diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
>> index b8bebe403c9..011810b5e50 100644
>> --- a/target/i386/whpx/whpx-accel-ops.c
>> +++ b/target/i386/whpx/whpx-accel-ops.c
>> @@ -95,7 +95,6 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
>>       ops->synchronize_post_init = whpx_cpu_synchronize_post_init;
>>       ops->synchronize_state = whpx_cpu_synchronize_state;
>>       ops->synchronize_pre_loadvm = whpx_cpu_synchronize_pre_loadvm;
>> -    ops->synchronize_pre_resume = whpx_cpu_synchronize_pre_resume;
>>   }
> 
>> @@ -2703,6 +2703,7 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
>>       AccelClass *ac = ACCEL_CLASS(oc);
>>       ac->name = "WHPX";
>>       ac->init_machine = whpx_accel_init;
>> +    ac->pre_resume_vm = whpx_pre_resume_vm;
>>       ac->allowed = &whpx_allowed;
>>       object_class_property_add(oc, "kernel-irqchip", "on|off|split",
> 
> If preferred I can squash 20-22. The point here is this method does not
> belong to AccelOpsClass (with vcpu argument) but AccelClass because only
> requiring the (unique) AccelState argument.

That might be nicer.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

