Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79A8C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 15:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZt3W-0003IC-K0; Thu, 10 Jul 2025 11:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZt35-0003FM-9t
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:19:02 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZt33-0000zc-HF
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:18:59 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4537fdec33bso6899635e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 08:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752160734; x=1752765534; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MfZyp+BAuA2g9PjhPJtLMHhk3jnprAKK1n7JOk5VyB0=;
 b=sWbAhtRjB11dTCnFTi/KfBy2gYiaZUrCGSp8f+dmJE9SN9uo4dNkanPRCG0HZpyvF5
 xYdap6vKVyk6dKd9ZRxOTcBg4lVgvo59enNEar4iS+M7T2e6gPnvySgy0p9het/JixKt
 8XH4ZQzWa9T/ejB+l98fMfjZey9/2dcN0RCCZLSCwrlqADH75Ay49SUz3z3goy+oPzj1
 88552hvQgBfhomZlnhxBz41yfMn4wNSZgdndfqkpu2xl2rC426OdUVhrlnL+dA+QlJJD
 +PD1YFZwcSrladY+O+OrQmMkMg0xRJwoCg7pjBeDP1pqABiRVmMx9NhwoK+uuwMFXeN7
 SD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752160734; x=1752765534;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MfZyp+BAuA2g9PjhPJtLMHhk3jnprAKK1n7JOk5VyB0=;
 b=XNbNLBfzX8ya4cp8onAyAYHmTa/Tpbw/5FF6TrFPLGMOtefbNnWGwRFKtooRFl7pSN
 OlEBF3iB2iJ7Te6g5vuO9MCpzvok6gQe3Q/cZkUQd3+VYyPkBTKPVOTpShN1sy6wB4I4
 51egD7piulRlbM8qfUoraS11CHMOg4za/AsnV47+OoKrAF3AXq9Lk8PMJwhXbjwiTR3T
 Nk3M/84qkhnKwzfk0i3NpYC/VZKupwVoXAVNJ6vqsGdJxtgdhzOiPGC/A20/JLVulshc
 JTfVW91DHQcACAhyLmDW6LnYNdjrT24/wg1amQ6qbJ0pCy8LxVu4IIWkE0mOaZEe5YWp
 hkGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpJitsGyES42BkWU7lPIERvEmzno3lXdGdeT7Ql0s0mRtE1vrEYLNk0kbytYgPJtF0yPmCQ+moVXB5@nongnu.org
X-Gm-Message-State: AOJu0YxAlj1BpDjbyp3TL3k86ctNI5saolGCBFV42fTJq9mCEsfz/OMl
 bm6zZdwuY5H+oaHybelSBKx62owkIzZb0OXooPIlPrHGYJcsCZj6GBwiI1n6AdLQL1c=
X-Gm-Gg: ASbGnctOzG/Iex+VdaMgsQ7zC0ILI9aRtQDfPVITds+YynzqSN4lf4NF4IYGgx/M37q
 G42E0AbdVv70NNpayCeuOJgCqdu8yoZDlnmrAmq6tJ2zuvziI0zyJOug2cj378dpouek0+HRUTh
 NHeDCJ2jcuEoLvU1UI8vEOcglIgSaT+me2gIMyAi6SQAO440d62GDTpq4djAcbNAnDGvJ2NfJiw
 DJgXkJGB3e4raC+r55hw4qlONOM9rpGR4A29yIzI0EUhnISe7eNztpVN9bwtY/UygrFv21MyjGY
 Fz3qGabRrRLTQ5ZfG67bXpjsJZtVRWZ3GrLxp7zEEj+pOReUrjv5QyVQM324XApSMzml6sgprB+
 Eo/PTXCl80ZhZL1ksazCCxCoaTZNXf0NaxssbaPfBbQlo2dVc+PSQ3bwkuLg=
X-Google-Smtp-Source: AGHT+IE1oZjhzQk0HmsfNxjc+2TH48TEZkrMxRycjdwmoHSN9WIEppocXlx0JxXlZZYHEo6Tvx1UdA==
X-Received: by 2002:a05:600c:1da8:b0:43d:47b7:b32d with SMTP id
 5b1f17b1804b1-454dd2ef513mr28837375e9.25.1752160733973; 
 Thu, 10 Jul 2025 08:18:53 -0700 (PDT)
Received: from [192.168.1.117] (lfbn-mon-1-970-120.w86-227.abo.wanadoo.fr.
 [86.227.5.120]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc201asm2114977f8f.22.2025.07.10.08.18.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 08:18:53 -0700 (PDT)
Message-ID: <dcaa2309-7c6d-4064-94ed-43d4c3ff2430@linaro.org>
Date: Thu, 10 Jul 2025 17:18:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/5] hw/arm/arm_gicv3_kvm: Add a migration blocker with
 kvm nested virt
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, miguel.luis@oracle.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org, gkulkarni@amperecomputing.com,
 gankulkarni@os.amperecomputing.com
Cc: hi@alyssa.is
References: <20250707164129.1167837-1-eric.auger@redhat.com>
 <20250707164129.1167837-5-eric.auger@redhat.com>
 <48fca85b-096a-4d1c-97dd-380669cb6604@linaro.org>
 <322a9301-a1ee-4cd9-b423-fbef2fc0593d@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <322a9301-a1ee-4cd9-b423-fbef2fc0593d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 10/7/25 16:10, Eric Auger wrote:
> 
> 
> On 7/10/25 4:04 PM, Philippe Mathieu-Daudé wrote:
>> On 7/7/25 18:40, Eric Auger wrote:
>>> We may be miss some NV related GIC register save/restore. Until
>>> we complete the study, let's add a migration blocker when the
>>> maintenance IRQ is set.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>    hw/intc/arm_gicv3_kvm.c | 8 ++++++++
>>>    1 file changed, 8 insertions(+)
>>>
>>> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
>>> index b30aac7aee..fccb3886bf 100644
>>> --- a/hw/intc/arm_gicv3_kvm.c
>>> +++ b/hw/intc/arm_gicv3_kvm.c
>>> @@ -827,8 +827,16 @@ static void kvm_arm_gicv3_realize(DeviceState
>>> *dev, Error **errp)
>>>        }
>>>          if (s->maint_irq) {
>>> +        Error *kvm_nv_migration_blocker = NULL;
>>>            int ret;
>>>    +        error_setg(&kvm_nv_migration_blocker,
>>> +                       "Live migration disabled due to KVM nested
>>> virt enabled");
>>
>> (mis-indentation)
> Did not notice as checkpatch does not complain.

No worry, it is a simple nudge to Peter for possible maintainer fixup.


