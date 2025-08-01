Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6C8C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 04:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhhOr-0008Ca-9O; Fri, 01 Aug 2025 00:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhhOP-0007wT-79
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 00:29:19 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhhON-00055s-EH
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 00:29:16 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-240b3335c20so8268865ad.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 21:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754022554; x=1754627354; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4w656GvqylV+9bxKFYy2Q5NDSd7DHanbKvKxgqxW1Mo=;
 b=p/3K/eEKnXEkMC+93HjX3nbIIf+GilooKwMYGUovNvzsbKGCtX8De8RWg1sOnZoek8
 hvtJIj3MQLNUhTl0mboQBfMFgCYAbf2rKr3N00DKr5NEujC3hoTQY/Pcgac3PrwvS9jQ
 st7d2gI8eDBYOq+7l+67zLhZfz5tvZZb2q3JD3zz9Hc3fe/UPM7O7WO1sYo2/7IRLx3j
 OSm7Qb8cc2tb6jysX54oMI60GqmHv69HuYjQtT0AK/h0YGPIrgmnNCiNa8Yp72iMYoph
 /4cf8TrFeMAQk6/dNrjg7KxASWUgTqzm8QkMq8R2Glfiw+0DR6BqPG2FskAtt/OSYVi/
 4TUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754022554; x=1754627354;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4w656GvqylV+9bxKFYy2Q5NDSd7DHanbKvKxgqxW1Mo=;
 b=Qt/RxwIfCsXk9aZ1oGRHUAYSuIgqgDYXNLmWa4o7LJMDl3KHEbTipeg4XSScykhbod
 nziUsxWQTtc1q3X97cyO/Pvi4teOgPZWzyiFrlNwOZbVYlPeGU6Gefk3ZadNR3dG2xl/
 LV9zT/KRr/HpdEhXaxG7HxsqyVMNXf0HHBMal7eDgGD3vkbDBjzlsNpKCmH4VXzAllwq
 RXs91M4WFxNIzI6sO8Iuz9TwO/k8YzpbWpfQ8KXrDAFggyH3b+jIv2F3H9qHUUqfvOAZ
 VBY5jkvIaECdq2cf06SVnvisANAp1xbgqWA8JoAJQASGxR0JKbPb9lEbdDmf9JebXtpM
 cVSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpbaqyUAj349XYJHjszufddPArXfbRF7G4C529j/NZJzt51jrzvigsXoKWVmXvCx+s1L9Bv6wlFy9M@nongnu.org
X-Gm-Message-State: AOJu0Ywgx4XAVZX18eokP9vb9vC1maW39gdD9Stea2toFmOsYrgf/zQs
 8EhXdBeN4agSzocfd5Xu4ukB8IoEROolrwVBSsF1rftlF5YHecXBlqjzxsi7cjYEDE8=
X-Gm-Gg: ASbGnctc480ITEoOzMh8fjeHWwiyIpHxUjLwWKXl6daQMH+3wQRglJJ0UUAagBiwR/H
 5WVzoybN+qY8YsMdgrBbJ5alCrWxdkYJQOXuNdZtXlN/4w4kiXXpYsXJ4AnQs3bv5VEt1bc2Qne
 TDMTwyJQVvOjtHKQ/llelReiUD2NdZDCWypLpu+lJMFemHwsqW7SWzZaO+RLWNj/KshsHG7dnhQ
 YRziMGWkFwoEcyRbrlKIMR+wORUe/dFDayWuOl50Yyu1rdeE2btvRx3eLll8xA1LFL1x9zL+n2A
 Gsh24RihTlweNpaT3gUFO8iXNQV+mBAvhJgVLry/SdWB+dRYho/VW8DLzscfqpBnJxmQNa4H57J
 UviscpHFK9WuuX2F5tl/nq2Bc5xoOJKWmx1ElnMqTFZ5j7yBFe8g=
X-Google-Smtp-Source: AGHT+IEXtbYpVpMS/nVuY6AEFIoFYrPk2yO0MzdxBCEVv9D10EWeM51VOmVfSRVtXtHDhqp01sNpYw==
X-Received: by 2002:a17:902:d50e:b0:240:1831:eede with SMTP id
 d9443c01a7336-24096b1784amr155507975ad.32.1754022553741; 
 Thu, 31 Jul 2025 21:29:13 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8aaadadsm31781955ad.156.2025.07.31.21.29.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 21:29:13 -0700 (PDT)
Message-ID: <f398a65b-7b1f-492d-a612-eb3d6322ae4a@linaro.org>
Date: Fri, 1 Aug 2025 14:29:08 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 47/82] target/arm: Expand pstate to 64 bits
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-48-richard.henderson@linaro.org>
 <b2e40787-6043-4d4c-9cbb-731d0e92e25c@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <b2e40787-6043-4d4c-9cbb-731d0e92e25c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/1/25 05:13, Pierrick Bouvier wrote:
>> diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
>> index 71c6c44ee8..f61adf1f80 100644
>> --- a/target/arm/tcg/helper-a64.c
>> +++ b/target/arm/tcg/helper-a64.c
>> @@ -639,7 +639,7 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
>>       ARMCPU *cpu = env_archcpu(env);
>>       int cur_el = arm_current_el(env);
>>       unsigned int spsr_idx = aarch64_banked_spsr_index(cur_el);
>> -    uint32_t spsr = env->banked_spsr[spsr_idx];
>> +    uint64_t spsr = env->banked_spsr[spsr_idx];
>>       int new_el;
>>       bool return_to_aa64 = (spsr & PSTATE_nRW) == 0;
> 
> Would that be better or worse to simply save the upper 32 bits, considering that cpsr 
> already holds the lower ones in Aarch64 mode?

I don't understand this comment.

(1) banked_spsr[] is already uint64_t
(2) SPSR_ELx is supposed to be uint64_t
(3) We were accidentally dropping the high bits of spsr here
     because the local variable had the wrong type, before it
     gets sent to pstate_write().


r~

