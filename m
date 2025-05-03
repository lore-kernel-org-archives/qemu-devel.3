Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E15FC369C2
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 22:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBL9h-0004Wd-4r; Sat, 03 May 2025 18:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBL9X-0004Vk-SN
 for qemu-devel@nongnu.org; Sat, 03 May 2025 18:16:15 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBL9W-0003PN-7q
 for qemu-devel@nongnu.org; Sat, 03 May 2025 18:16:11 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b1a1930a922so2257843a12.3
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 15:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746310568; x=1746915368; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xNJJtrnpFes8ekXTjTuSMN1yHRw6b+bD6cpME1WD6Xs=;
 b=hf2HVKqPD9AI9wPd34dczTiFVmUI0GrYemAg1B1abB1YpV6cvhKOwsXkj45R3rtImM
 PssWIFXYSHQF98wCKk5YL4y3jl/rxy+L2UzCdbiR4y/SxAdn+CJO28ntH6L1wsi713Lm
 Y0QnAlw1NtCH7P4FKm5ToD5oNgZsrTNxgXpoMSUtv6LjPhqVc5jLhKLfhK54rGEUwPb0
 xjeKDgNz9qWECrAZiMsZWrHek0u3xAt1Lu15l/xOP68DhQ8S8WN3fSsz1xNVUxv+tkmA
 W4Fmg4iBEQEzyo5ozsXLjoCt28LDhDHqQEguoigQTJOo6UM01AkRsAMQ2Kk4lTB1iRnS
 D3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746310568; x=1746915368;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xNJJtrnpFes8ekXTjTuSMN1yHRw6b+bD6cpME1WD6Xs=;
 b=tHzEkr8s83Oy2ItVCcQbnSisCZdDFLrhKut56e0lJKCiYqtjFCqWSyq2biDky5r1kp
 mRcQ/ClTyNdoeG1HdVQrDfB3NHtRZuScNYonzP5vjXuYfpMn/5fXOu8IPEo/9P9KYekk
 JR8Zsj8g75RFZQt10XSH97VFWzcUqsS5QjowPU9Wqdmd2AFFqTf1EncSqokn3qmCsNOV
 pSvCxxLFbNdhWvixVmbQvUafjKuOJdrAUp1VJaqeLSUagIoesblMjlk+Wky5VE0fejIY
 TbEhmQBtg1XyYcuI7WQh3VbB1oATr05hrfUUb0giMgUtmWnH+Ub9TkbP+d2gw/GYxWrw
 432w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwaBpfnI+5bPiLr5P1vIon6PVvp5J02oS5M1p0v3H6hE52HIbqEoRYE+Bp94T16XYwR3bsCyZGs4jR@nongnu.org
X-Gm-Message-State: AOJu0YyGYO0fqt3vsJP9oWp9SOvdAFD/GKRZWi0XI/B4uBjybwqz5Rqf
 Phd88lFYSIXbs3tMor3N7PT5CWZSoMxDJ+5GjuJ1vhbtb0eSELU+8QLk5LA5t9I=
X-Gm-Gg: ASbGncufkhq1QoqvFEHlzDIRwXBsvvpMIfqCT1RCqygre4AD8WF4djYlg3mWReRLiZJ
 Pc702OtfXP+tkBUU6DJKIXOHzTKSCDFxCJy+E6/pjED+fN+9rjPPevPwe4IOa69gxh2OA2UDbXI
 dHQjChVx1Qis9eP+vAS1hRjar9fyt6efKarygbEUrQjyU6e5TSXPhHvrX9zhJSm6maKvTIzBhJK
 4ALcIMvjoPoeQr1eo/TrwWDcxz6qfoeoCRbS92Efs/LMrjAq9G+wMSOnXtDngbwC8G7+IPs6NOO
 qgI/GB01MvwTt387FQdgXRM0F/C6rcu+gVNdXtRU2hj0BnttNRtu3jQyr3JCtuGQ
X-Google-Smtp-Source: AGHT+IElNjYwVrPUjFtvyA2d3knY64Cb6zZPqR97k5sUlwVVLCppxJDJZTNzGc+wxdKVsKG/xnF6dw==
X-Received: by 2002:a17:902:f693:b0:223:3bf6:7e6a with SMTP id
 d9443c01a7336-22e18b97939mr67777725ad.12.1746310568613; 
 Sat, 03 May 2025 15:16:08 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058d7adb1sm3839896b3a.36.2025.05.03.15.16.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 May 2025 15:16:08 -0700 (PDT)
Message-ID: <dfab0f03-453e-4fea-8313-05c6b08561b8@linaro.org>
Date: Sat, 3 May 2025 15:16:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/33] target/arm/debug_helper: remove target_ulong
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-18-pierrick.bouvier@linaro.org>
 <e1afdcf4-a416-4742-bef2-352a9d184ea9@linaro.org>
 <21b0915b-422f-4186-a6aa-c484f725bdc5@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <21b0915b-422f-4186-a6aa-c484f725bdc5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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

On 5/1/25 12:28 PM, Philippe Mathieu-Daudé wrote:
> On 1/5/25 17:07, Richard Henderson wrote:
>> On 4/30/25 23:23, Pierrick Bouvier wrote:
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    target/arm/debug_helper.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
>>> index 357bc2141ae..50ef5618f51 100644
>>> --- a/target/arm/debug_helper.c
>>> +++ b/target/arm/debug_helper.c
>>> @@ -381,7 +381,7 @@ bool arm_debug_check_breakpoint(CPUState *cs)
>>>    {
>>>        ARMCPU *cpu = ARM_CPU(cs);
>>>        CPUARMState *env = &cpu->env;
>>> -    target_ulong pc;
>>> +    vaddr pc;
> 
> Why not directly use the symbol type (uint64_t)?
>

IIRC, Richard mentioned "use vaddr instead of uint64_t for pc" on 
another series.

>>>        int n;
>>>        /*
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> r~
> 


