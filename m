Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7A2CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOdo-0006Zy-8i; Sat, 30 Aug 2025 12:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkcG-00045s-PS
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 17:57:08 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkcE-0000aL-Et
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 17:57:08 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45a1b0cbbbaso12329775e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 14:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756418224; x=1757023024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FfpYSdrfi4pNl2fkKCYvcekdrOfXAWNAC/gIlpg8QxA=;
 b=sfMC+//3ylqbWwabOsxAyG2PAGBA7c+jWVunLCM9YBJ8M+13OeQE2ezN5PxRelSiG3
 ZSaFB8VPTmDJUWLQic8yFz3eCbGYvutGwvZbznQOmNZJxjOyUHPhhOTiAwUE1F4yhE7n
 KcOgYf15Z4DxVYg/C8kTM3Hg1d6VtabZmRr9f2c5cWAuZg8chSCsUsRvUN8Z3Wz5/44M
 vUtXZ1BPPYqDLCTWh8WFODkTo3bvX8nREis0UcnCqHXe5qMFGn1kvjLUlqsuTnFFY8Zb
 Q1nuvr5Nkzp1ZvuR2FIqqnynkNKPr3viKNLE/VM3vHW/pAqDegDgErVRZp7ayMyMgghB
 F0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756418224; x=1757023024;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FfpYSdrfi4pNl2fkKCYvcekdrOfXAWNAC/gIlpg8QxA=;
 b=wMRZoZ5xdHBRY1t+yKDbo4m7pbEr9sTMFQ6TvxqrL1YsUzoWJE4D690zkeV3mek2X3
 Cu6eJ0OC661iCe4BfI4zVkTgX7E2+MHFEvj0nxVRk0GF1vT28qxbOqmRhCiJPeNCRCRc
 gF5HkFGPoyKySFZsZ3MFl1JA32HAO8Jo2TPyNvXk9zoN0uhwTqoL/Hmt+Rjrs02UkmmI
 uGEG0U/ZSgzoXep81YqSCl2HoAz2rF8Ax+dilQv4lavj9mx1qIh8OqXw3gpF5kXh/ez9
 tuO0Wn+W9XLLFPJwZ0l/aWGOUW/QOXWGI8Z0z9dWVISsmHe9vVUQ75BhZQchM3mF7Y8i
 HOhQ==
X-Gm-Message-State: AOJu0Yxu6lxEhs5zPCeJETstpDdd6kL0g036TrwHl+0gNvC7jywqa07J
 TeJboQqSvW5oO2kpWXw7VaGXxuEFUkhz/24me18hT5puYTx42S8QYQbSUTNd+/ReWPkVlnKpDVI
 3FAId
X-Gm-Gg: ASbGncvmqzbFjwl7dzblYJ4o6H3goHOQTdwc+mm+j4oIjYugAFtv38eTunGvUHelPYS
 1jZ2HP5hTL/f3HgXmxmCYezZMYVowvksGUEL0eTHWrn9iyVDr6Jm+ZsV1lDAoMJh41T+hLc+tdL
 BtqLiGUXVGs2ZjVLh9mdzVr1VF9ouh2Z7BrSj62/Gz0FjNRlMYr0sNTHwyBMQCg8HqIlgNLEGwR
 bH9pnPZLFGvHA+iiWIVXNLiz9HHaAFfkAD4elafedUg+Z7kmiqUjhubfj9waywZN03r0AzWnmv8
 3RPfoQerWyquahoy/WDqvLVxjfBqVvEPaNmxW88cwR+6ii4xmCqlmrCEmfSA8CqBXSjuIvykraj
 HF9VbziAiPFiOMxVc/78T2tM3+POe2ce3X9RpfMSceatmnhhh6Ut3hQx76PEiGONfha7JRF36n3
 sqgxXvudWMlK0=
X-Google-Smtp-Source: AGHT+IGEMllIfPn8029orEoVzsPXGxFO5qKjhoDSTL0/oYQE60HHGnOmtntpze37dnrddLpWslJKEA==
X-Received: by 2002:a05:6000:401e:b0:3cf:2700:6814 with SMTP id
 ffacd0b85a97d-3cf27006a1bmr481863f8f.30.1756418224065; 
 Thu, 28 Aug 2025 14:57:04 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf1a2560c3sm838302f8f.0.2025.08.28.14.57.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 14:57:03 -0700 (PDT)
Message-ID: <787f7e70-e3fb-4ab0-a879-780247066157@linaro.org>
Date: Thu, 28 Aug 2025 23:57:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/core: Dump cpu_reset in the reset.exit phase
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Henk van der Laak <henk@laaksoft.nl>
References: <20250827053822.4094239-1-richard.henderson@linaro.org>
 <20250827053822.4094239-2-richard.henderson@linaro.org>
 <CAFEAcA9YC1772qpnT4eT=WP8=pmoACkx0k-a1p8fuXYZh54z=Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9YC1772qpnT4eT=WP8=pmoACkx0k-a1p8fuXYZh54z=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 28/8/25 17:24, Peter Maydell wrote:
> On Wed, 27 Aug 2025 at 06:39, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> During reset.hold, the cpu is in an inconsistent state,
>> where the leaf class has not had a chance to initialize
>> state at all.
>>
>> This is visible as a SIGSEGV in "qemu-system-sparc64 -d cpu_reset".
>>
>> Move the dump to the exit phase, where all initialization
>> is certain to be complete.
>>
>> Reported-by: Henk van der Laak <henk@laaksoft.nl>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   hw/core/cpu-common.c | 16 +++++++++++-----
>>   1 file changed, 11 insertions(+), 5 deletions(-)


>> @@ -380,6 +385,7 @@ static void cpu_common_class_init(ObjectClass *klass, const void *data)
>>       dc->realize = cpu_common_realizefn;
>>       dc->unrealize = cpu_common_unrealizefn;
>>       rc->phases.hold = cpu_common_reset_hold;
>> +    rc->phases.exit = cpu_common_reset_exit;
>>       cpu_class_init_props(dc);
>>       /*
>>        * Reason: CPUs still need special care by board code: wiring up
> 
> If we ever have CPUs that actually update their state in
> the reset exit phase (e.g. if we manage to complete the refactoring
> that would let us implement M-profile "load starting PC and SP
> from memory" in reset-exit after rom blob loading rather than
> having a hack to do it in reset-hold), this won't capture that.
> But it's clearly better than trying to do it in the common
> reset-hold method...
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


