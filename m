Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0767AC36017
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 18:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0375-00024Q-92; Wed, 02 Apr 2025 14:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0373-00024H-4l
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 14:46:57 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0371-0004ql-7I
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 14:46:56 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-301cda78d48so110505a91.0
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 11:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743619613; x=1744224413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vxlw/s5TBPHPDgBN6dH3va8ipvQhBKGJZCm70ndnHek=;
 b=dEKy7vp32HQZXufhfyz3PTjUp/zSSaA8Ntx4i620y34Bd6NPIuUbku7q90PlRuMi3U
 pnOeiEAG+ds0B65DmRgmX9fr7I7BULw7X2G2QxgejxGJnUG9/whI9TBKStjWNLv6rpwE
 Ux56WkPsa65u5pknSACQUwj9Y2ay6ywj4cPT5a9jfOGJUk7syobCKl0ksmjCn5Lzivbi
 mQHM4s/uqM3R+1q/YV8Jv23DrZCSA+UyXSpnQYmMa2wi/DB0RytBwJlAOuJM0WUBPBSJ
 d0KR0WWqkm4wRACCjKRbqF1d8U5gNkOkZFEBSTJaXqrkTR6RJW0p8ZLlIc+wl7i2X8b6
 c+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743619613; x=1744224413;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vxlw/s5TBPHPDgBN6dH3va8ipvQhBKGJZCm70ndnHek=;
 b=DeO8r29YBHWW+hF/i51xvsDM9gtBo/HQSiMKrMU+NY7By80nRHqp5WhhIbhDJtAM8d
 CSuVL5Eisa5Re1ft/4M02D42GA8l9apaz1dZ6YL4/uHpX2ioqyxcQ/rnr6sx5wUMHBCy
 9uTK9UBzme1Xn/k5N2E7P2VvhPSeBkifwZJogzOjoqnwZkIUWbu5jQRhVu2hlxaVLIQf
 KU/nwY99Po3bDqCjAekFJm60nqOanm4CT2RllDb83UWS5XrKT5Fh6z/aRUOekEu0IJVj
 Lojhq0y+kPFlnITv7o0CoA8eUFU8tqlP1xk82RlamE451KGAkfXuJIuPZSbpP2q8tGbp
 FJKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5hq39xxh/xsmOGU5Iz59cz3VvMpUsDC7PRJRl0/DQd9CinwjNtloWASKvZV/ZtYg2awgTM8RuLo1S@nongnu.org
X-Gm-Message-State: AOJu0YxKOMXMPY18qKQB5I2+HtjnITYElJLJf/ZrpIUa6j5rquOzC8To
 yftCTZknImV4rNiUG0GtyhvaEzUfCHp5KjZEaHjvkfv2HtC++eXF/38okmdECH8=
X-Gm-Gg: ASbGncsk/cfK6zLAPyONUolgCcAZoYCMV+0YoSFfK1ZVdBSoonpRZcaoNX4bqZsar94
 6lhaAQkTxknP+0JLHPvL5m0zPWkSZugoIiJ7nx9SgD6gs5CqIfBaALm1va+IqiMbOFeJo/L82St
 WwLvJ/9aCp5LJVoakAWN1iwwyyNgKrV9cbyxdk7wNzFFuJ0v5vsL1oHVyrmCshj4ljhDjyjWjLf
 StcNYuML4kkZoDhgZ+GOx9btPvJMTuXLAIWerr5QnretZXhw9oLXb0zauKI6FE1+De9TamudYjE
 BZjxHyKRc27WmmhxbuUTKc8k9PsWUzJS2k990wWgedSWYKvbagihoVvb0MDUBwV7gR/LmWB4RP5
 xIw2uODUg
X-Google-Smtp-Source: AGHT+IHHWGZeOeFsdcUiMN5bIvoMYfHOkuywhM1qi+QIoIJsefmwo8dbZxzatJTathTElPO4cL94gA==
X-Received: by 2002:a17:90b:2b88:b0:2ff:62f3:5b31 with SMTP id
 98e67ed59e1d1-3053216ddc9mr27135014a91.29.1743619613274; 
 Wed, 02 Apr 2025 11:46:53 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3056f83ba71sm2191691a91.13.2025.04.02.11.46.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 11:46:52 -0700 (PDT)
Message-ID: <6b3e4490-781f-4337-837c-3ed38483332a@linaro.org>
Date: Wed, 2 Apr 2025 11:46:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 04/23] include/exec: Split out exec/cpu-interrupt.h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
 <20250308225902.1208237-6-richard.henderson@linaro.org>
 <b240dea4-082c-4bdd-8dfb-45d444ae12ef@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b240dea4-082c-4bdd-8dfb-45d444ae12ef@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 4/2/25 03:17, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 8/3/25 23:58, Richard Henderson wrote:
>> Some of these bits are actually common to all cpus; while the
>> reset have common reservations for target-specific usage.
>> While generic code cannot know what the target-specific usage is,
>> common code can know what to do with the bits, e.g. single-step.
>>
>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/exec/cpu-all.h       | 53 +--------------------------
>>   include/exec/cpu-interrupt.h | 70 ++++++++++++++++++++++++++++++++++++
>>   include/exec/poison.h        | 13 -------
>>   3 files changed, 71 insertions(+), 65 deletions(-)
>>   create mode 100644 include/exec/cpu-interrupt.h
> 
> 
>> diff --git a/include/exec/poison.h b/include/exec/poison.h
>> index 35721366d7..8ed04b3108 100644
>> --- a/include/exec/poison.h
>> +++ b/include/exec/poison.h
>> @@ -46,19 +46,6 @@
>>   #pragma GCC poison TARGET_PHYS_ADDR_SPACE_BITS
>> -#pragma GCC poison CPU_INTERRUPT_HARD
>> -#pragma GCC poison CPU_INTERRUPT_EXITTB
>> -#pragma GCC poison CPU_INTERRUPT_HALT
>> -#pragma GCC poison CPU_INTERRUPT_DEBUG
>> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_0
>> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_1
>> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_2
>> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_3
>> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_4
>> -#pragma GCC poison CPU_INTERRUPT_TGT_INT_0
>> -#pragma GCC poison CPU_INTERRUPT_TGT_INT_1
>> -#pragma GCC poison CPU_INTERRUPT_TGT_INT_2
> 
> If I understood correctly yesterday's discussion, these
> definitions are internal to target/ and shouldn't be used
> by hw/ at all. If this is right, then we need to keep them
> poisoned for hw/ code.

No.  They are used by generic code to mask CPU_INTERRUPT_TGT_EXT_* during single-stepping. 
  We don't know what they mean, but they're all external interrupts.


r~

