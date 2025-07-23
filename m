Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0724DC83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 16:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uecAv-0004zW-WC; Wed, 23 Jul 2025 12:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uecAk-0004ki-SL
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:18:30 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uecAi-0005ta-M1
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:18:26 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45610582d07so53435e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 09:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753287503; x=1753892303; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PgMZti/53Goy6TgiBoJAWym2zeQbCAgT/SnCcoSAQ44=;
 b=kjFMXDCAzZeO4IC2nHh9kvYivw4bkuCI1o9e2oJIGDcSL2U6LY6Sm9DlFO/0Z5obWw
 G/rNQyZ0F4dt6xjcwdzTLOKtO+ladvF77YVjUqNZ/1BvoW0CPXucX//U+7h2tikPcDKy
 V3OutIq3jFbnHZUPq7nWryjBztV1FjSx4i3ulgHNHIFK8juvP7BOJa2PmiNMjQ4mplmK
 H/CG3S75uIjb9kdk7kqhUAVBbkFxl+KZMJ7DechmIka5pj/YQDhuLfrXRTdWtlyP7V9B
 9lAtMzfKLyUJvK+CzDe6vxQF2YOwqY7/xKVI3baT2H9poYRKxkZVfPnbgxhzqqRwvaBX
 P44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753287503; x=1753892303;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PgMZti/53Goy6TgiBoJAWym2zeQbCAgT/SnCcoSAQ44=;
 b=tmfL5DiyCA8vBvo1pXN0kYPriBwG264Arh6h+T8/UOS7lkIHdB5nZGpzNIlV3wG+w4
 z0KX+mgfd2fmkdV3gfWEu6r22MISJECjA5CWT6FUFbrIp8pJ/vtbm9isrZM/+sPxbQB8
 ln3jXJi/n4QlxN3cdMGOzwvLn2U7uEJWODwwTZ1/tAcrw9a5lI1ofULBY9qTmpuMEO/q
 uQBIN81ZZskVsJUBvRPy+Ol9XzJVkQKcQMXzlVyy6iO/9pthVTydnOSE5Dt1PTzC76/P
 lF3zLesB2E9CovZTXiJZzmldI4FM8Xk/uOaB+XggTIpnHU0QT6I5TfYO1FkIiMkaPGC/
 ePZw==
X-Gm-Message-State: AOJu0Yy3waXRTMkSFitZc9LNvhwpt8DShhf9qTo/WFxWWFknDOB8jQEs
 gAUCScYfc4BETeVq9DCuP243d/M6exJ5ujvQyy0bLsZuPUSKT8aBi2uP4+YsWXyWV/0=
X-Gm-Gg: ASbGncvv0sP7Qe/S5ZwFapKXXHHSdKUk1hCLOmko8TTrMj98daClmoCF/KvC9KZP074
 zL6MmPKrCKrfDU2hBCNOC07sY4f9W+G/ScHsxNLMH5/Hc4GtIp5x8vIIsREKjteVqe4i/0ApKNK
 7Ve1ASQE/FMxfZPiSPVAmkIFRirJjZxyu6FrMlUFMumxPzB5ssF0m0dfVzTTdWCqqGd1oPjI26W
 Ml9hVELRYAklPHJKFX0Lwd5mRHbeX8uG+tMPlFQWPS38FN33epQwJrpJoVqKZGcEseANgC/FcH8
 WoFjuEVYflBk39N0RhvONlRk54XEscEvZrZ/7mus91XRuDYW25kDyMqpKECIDL9RZyjOmka9zPD
 0x179gUOJSuRBcCVj1OOMRKzTKT5pac2i5sty+DpFsukZZi9i/6go4NdzUi+UYdXjjg==
X-Google-Smtp-Source: AGHT+IGfaOIkPRvhm3A/mYHIebDUBN1xrQgbRrVr1VV0m/JQH7ejrfqw+c43QeV8vWNa0d/hhAVQxQ==
X-Received: by 2002:a05:6000:4029:b0:3a5:1cc5:aa6f with SMTP id
 ffacd0b85a97d-3b768f1627cmr3243706f8f.34.1753287502922; 
 Wed, 23 Jul 2025 09:18:22 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76773a2c2sm3728122f8f.0.2025.07.23.09.18.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 09:18:22 -0700 (PDT)
Message-ID: <fc09711d-7b1b-43fc-be0f-01663593ddf3@linaro.org>
Date: Wed, 23 Jul 2025 18:18:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v4 1/4] accel: Introduce
 AccelOpsClass::cpu_target_realize() hook
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250723135156.85426-1-philmd@linaro.org>
 <20250723135156.85426-2-philmd@linaro.org>
 <CAFEAcA-HH3pyWv4sF6ujLFdMAhtYV8H0TxjJ1Z6myHu5hbWusQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-HH3pyWv4sF6ujLFdMAhtYV8H0TxjJ1Z6myHu5hbWusQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 23/7/25 17:49, Peter Maydell wrote:
> On Wed, 23 Jul 2025 at 14:52, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Allow accelerators to set vCPU properties before its realization.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/accel/accel-cpu-ops.h | 1 +
>>   accel/accel-common.c          | 5 +++++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/include/accel/accel-cpu-ops.h b/include/accel/accel-cpu-ops.h
>> index 0674764914f..9c07a903ea0 100644
>> --- a/include/accel/accel-cpu-ops.h
>> +++ b/include/accel/accel-cpu-ops.h
>> @@ -34,6 +34,7 @@ struct AccelOpsClass {
>>       /* initialization function called when accel is chosen */
>>       void (*ops_init)(AccelClass *ac);
>>
>> +    bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
>>       bool (*cpus_are_resettable)(void);
>>       void (*cpu_reset_hold)(CPUState *cpu);
>>
>> diff --git a/accel/accel-common.c b/accel/accel-common.c
>> index 850c5ab4b8e..eecb2a292af 100644
>> --- a/accel/accel-common.c
>> +++ b/accel/accel-common.c
>> @@ -106,6 +106,11 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
>>       if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
>>           return false;
>>       }
>> +    if (acc->ops
>> +        && acc->ops->cpu_target_realize
>> +        && !acc->ops->cpu_target_realize(cpu, errp)) {
>> +        return false;
>> +    }
> 
> You don't need to check if acc->ops is NULL here: per the
> comment in accel_init_ops_interfaces(), all accelerators
> need to define ops, and we would have already crashed if
> it was NULL.

Only system-mode registers @ops, so unfortunately we need this check
for user-mode emulation... Richard and myself are aware of this and
plan to work on exposing AccelOpsClass to user code (after v10.1).

