Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3957BC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 11:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFWP4-0000ky-WC; Thu, 15 May 2025 07:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFWOv-0000iO-0H
 for qemu-devel@nongnu.org; Thu, 15 May 2025 07:05:21 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFWOq-0004MF-NZ
 for qemu-devel@nongnu.org; Thu, 15 May 2025 07:05:18 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so14784565e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 04:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747307111; x=1747911911; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dfCJ6+34DY18K/VCdoXvsoJY953SvtWUZZNRIUlvllU=;
 b=BSdU8D8SaO0lcErjlHeFvUWPtM8VEa6h6L/io9G2ifnDarjIFqn0Nh9jXhG9FM8+05
 n1EKoXUcbpAWL34gIFC2sJn6BKoZG6Qbow+pssUBmpbnizBSjR0Nfz4zV7bzqtlwEYLE
 fyR+nzfO4LntQy18MRcYyvOe63faRq4hhChl5XbqKN+1iCcMLVC4TohqCA04TVgSVvCl
 kt9Le0E0G3agvbTdS2mPEv5TZHSrt09aGnxDWs36E0/dV/D4eeRiqfo6XAczkweEv5wb
 +p3Mc0QymYsUMzSFdV7ZXZMw1Q8LVd/l9dV3V35WFbb1zh4Z5BupzliPehGCKoX1ts6j
 OAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747307111; x=1747911911;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dfCJ6+34DY18K/VCdoXvsoJY953SvtWUZZNRIUlvllU=;
 b=dbtE0ldPNlMLbNeszpjDbhpKRzzgNOghB+JAU2ubCGQACn6fuuYNwVPAXvKVQVJMuT
 BcSf/JpYi8eYh+aPrt7d+2LjmGfKpO4cN+ne9HTSvMrPId8SKLrGoMYRmJn4Gzfjp0vg
 XqtJn0pcZbSjuFZ1p5nz6vD8OSv0ycTDV7yqRcLXAt2ue5FgLQ00OC3NY8xUetocoE7u
 P4X+MW49XGNtakSmv+wjqf0H+SXQqBBL9ANPYFkNXRe62WbPiwFrYofrB0lEL7OVK0Cr
 XE0UtP0fWfEM0pWN2fiZBehFCaDuH3SxqFtPb+Yjx/tHp7NrDYunk18Y0J9lw0CI7yhA
 /tnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdBcQXPTBLTwX1Ka3dI8pYbGfz7bJHHP4NHs3ZQIGJOZqbYCg6OaOw5mTZqjdSyQfVCcoPSGQcR31m@nongnu.org
X-Gm-Message-State: AOJu0Yx/bCupe5Pd0M4+5Vzby6RfbZFkBg9sJnlKaImcViYI392HJyxD
 kHhqDi9Oagcdbe4ur3VyLv47Y9bBOZh0edKF0pM5+GqZB7rFWasL5aNa2QjLbnA=
X-Gm-Gg: ASbGncsF/YtNaO+aaxTtutIcrH4KT5Go+7Hd0P24248dFLC8kw93ov3BZwGYpq6urLi
 q56/ekL+zNittOmuTBLJVIcbpIKcr6MAoH13VrlRHvTg2IQSESN4dLLAM+Slh/LV9bmhBpkncoY
 mT7GjFhIcKiO6qpdQBX2pEpID4Wwhi9P7tKURGL32oD3M0praI9CrUmNBiU2oeVSb64BhmNBpX+
 Ai0lKDkOQRykdHYmr8xpExeg/QxMaPNjQRWgFgVHQoEGB2Qmr3rrzatXUPRAE9C/aWyyzy6JyQd
 FDw0Chkj+IKD01FmxiHIT3vI3ll9Lw6BmIL3+np7k9E4EEmnznrSnVbUHHNN+eNJhfYH0fIIWHr
 VE/aRu5ceDxDt
X-Google-Smtp-Source: AGHT+IFG3ZBU2XEvYEGC3mC+bs+9oyN1Li3JM6VHJFW12iZYKknR5qfHX9y6yiZxs+OOq1YjymBCKA==
X-Received: by 2002:a05:600c:1d27:b0:43b:c857:e9d7 with SMTP id
 5b1f17b1804b1-442f84d2003mr25673115e9.5.1747307111258; 
 Thu, 15 May 2025 04:05:11 -0700 (PDT)
Received: from [10.61.1.248] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f3951b62sm67170845e9.22.2025.05.15.04.05.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 04:05:10 -0700 (PDT)
Message-ID: <eff0b1a9-5267-4290-a9d4-da95179289b9@linaro.org>
Date: Thu, 15 May 2025 12:05:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/19] target/arm: Add arm_cpu_has_feature() helper
To: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org
References: <20250513173928.77376-1-philmd@linaro.org>
 <20250513173928.77376-17-philmd@linaro.org>
 <b6c81748-091b-4d61-8d34-beaa0442aab3@linaro.org>
 <f7bcd8b2-2c0c-4907-8a0e-af172c235d56@linaro.org>
 <59b1ccbe-9ddb-43f0-98c4-8000a08d27b0@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <59b1ccbe-9ddb-43f0-98c4-8000a08d27b0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 14/5/25 18:59, Pierrick Bouvier wrote:
> On 5/14/25 9:53 AM, Philippe Mathieu-Daudé wrote:
>> On 14/5/25 10:24, Richard Henderson wrote:
>>> On 5/13/25 18:39, Philippe Mathieu-Daudé wrote:
>>>> arm_cpu_has_feature() is equivalent of arm_feature(), however
>>>> while the latter uses CPUARMState so is target-specific, the
>>>> former doesn't and can be called by target-agnostic code in hw/.
>>>
>>> CPUARMState is no more target-specific than ARMCPU.
>>
>> ARMCPU is forward-declared as opaque pointer in target/arm/cpu-qom.h,
>> so we can expose prototypes using it to non-ARM units.
>> CPUARMState is only declared in "cpu.h", itself only accessible by
>> ARM-related units.
>>
> 
> Maybe we can simply postpone introduction of arm_cpu_has_feature() when 
> it will be really needed.
> 
> Patches 17 and 18 are not strictly needed, as cpu.h (which resolves to 
> target/arm/cpu.h implicitely) is perfectly accessible to code in hw/arm 
> without any problem.

OK.

Peter, would you be OK to take reviewed patches #1 up to #15 (the
previous one) or do you rather I respin them?

Regards,

Phil.

