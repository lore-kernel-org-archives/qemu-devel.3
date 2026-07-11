Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9841AC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 16:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wib0M-0004wx-0X; Sat, 11 Jul 2026 12:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wib0H-0004wZ-6N
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 12:56:38 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wib0E-0005mA-S6
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 12:56:36 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ccf2360620so16265175ad.3
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 09:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783788993; x=1784393793; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wcZfmofIcDrGbWmqSeB8+oYv+9SSujzRHEhb2Wp+1IA=;
 b=pGi1fZdMjlZvymgzHzXskZ1B77JwDVWs6uaHtX0giouIrI66/r7urgd5B/AwTQ5Sj3
 UH8G2lZbkVFGhoDeVkAe7J7feGA1DZ4Ovrf2hWCKhiWVTnvQpPmaWPQo4UTZgorcy1El
 yuUiNo3vEIZAs+y/Y9NAANgC1o+jiaY/G2xVdXyPEExlkPxwayRadUzep8bHFLajPanS
 nP0+ytKXdtzZbMJ5Jp3AetJE2EimfpQgbZh8poDZaF2v96SJ0/ShmzCSmMip1GuQg8Ih
 RTM1hjZ/SwTa3ycZRnqbn0px9oRmcTvV64bF2/KOfphHOfTN3UMWhLnH/N6BUZ/EOUSN
 fWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783788993; x=1784393793;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wcZfmofIcDrGbWmqSeB8+oYv+9SSujzRHEhb2Wp+1IA=;
 b=UmILjHw9+ZT5L6Mr5PxwpB5w1TmxTI11pRKqjXM9mRpKoKwVb1jKJKGndtnDiiskDK
 7lUELvHHwsEhHN+xj4QSUopanenlUm7RQacQW0pmLC03ZXw8E45ubuds/RGePiO8h3ur
 x/mq+SwQFuy03wSOTBMoqO6JfBTxuBDQCTX/WFpuJv7k0SroHnBwCdw6DJ2OgUBcfeKJ
 YgH2a68E5Dqaux0YAgxBgnSiZYGxeLIPfN7wcI0yDUT+OQxuvDYugm1OxrTQuxMlKTws
 r0QB815fwtZTHtXNxhJTI52BX0QscovwsH4gM/eOrPM8v3ub+nM+TF3wj08Tk3iF/qmB
 zVnw==
X-Gm-Message-State: AOJu0YxoNXFl3XyNRILRkW5mDEcEUMQs9xXRH4BkXILk7Co2IIhuEcoH
 +LisTm7VBOWFmHIwxALhCBeduAHlX/Nk10B9yYXoGLqzhnH1GIJb6MzgOqJl3m2sjGTWmCDfeZ9
 rYhuH
X-Gm-Gg: AfdE7ck6QIoRmfTy542XZ6NCEh/1LDDb/0NlOcuXGPXTVQKJyObacEyJ1h81KL5EhXq
 4Bi1AOxy/LkvQ86cp9FcztZiWjYlbiND1RvAkRIg0iSRBZNe6DjgomKdeBzkW7qIa70DiY9I4Yl
 L3hJqhwuQDnT7zQiIszR/mLKtbvVdCQf0uFMpBWZ1G16iqlrSUOHloSZqoj/IHOziOEPhWQ+Q4M
 R+TzCRd/6CEfiKnB2Z3f7HTgD355IUxM+8Ld4ETIdPPbaU3uW0W7DnLP86E7a0y3eAGPJJaPmUt
 SJ6wGklEUCnuqXp+GR5RjIsBOBnQnpq/UnE53tjFz8eqM8UD7jPRh4zhWKLzm5N0Umh+JxAZR3m
 lx3Ug6LHln8zj3l7Lk+Yb8I9nzMesxSASA+AtzrDLO8C/RwopiWo9YnYNElR1He6Qqw7ScuGeHA
 B1CUw0fcisV/BpgAKucga3iwDF+Q==
X-Received: by 2002:a17:903:2986:b0:2cc:f4d4:29a6 with SMTP id
 d9443c01a7336-2ce9ee1300emr36497915ad.23.1783788993235; 
 Sat, 11 Jul 2026 09:56:33 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.146.49])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bc1fsm75105795ad.55.2026.07.11.09.56.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Jul 2026 09:56:32 -0700 (PDT)
Message-ID: <d01f1efe-dcfa-4e17-9201-16f97188e1a5@linaro.org>
Date: Sat, 11 Jul 2026 09:56:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 42/51] accel/tcg: Merge CPUState.{break, watch}point_hit
To: qemu-devel@nongnu.org
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-43-richard.henderson@linaro.org>
 <3c6e2c1d-baeb-4b49-9fda-3945c73e83b2@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <3c6e2c1d-baeb-4b49-9fda-3945c73e83b2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/10/26 15:15, Philippe Mathieu-Daudé via qemu development wrote:
> On 10/7/26 22:53, Richard Henderson wrote:
>> Merge and name bp_wp_hit.  Now that all targets have been
>> converted to use debug_excp_handler hit argument, we only
>> need one pointer to an outstanding debug event.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/hw/core/cpu.h  |  3 +--
>>   accel/tcg/cpu-exec.c   |  7 +++---
>>   accel/tcg/watchpoint.c |  4 ++--
>>   gdbstub/system.c       | 50 ++++++++++++++++++++++--------------------
>>   target/arm/hvf/hvf.c   |  5 ++---
>>   target/arm/kvm.c       |  2 +-
>>   target/i386/kvm/kvm.c  |  4 ++--
>>   target/ppc/kvm.c       |  2 +-
>>   target/s390x/kvm/kvm.c |  2 +-
>>   9 files changed, 39 insertions(+), 40 deletions(-)
>>
>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>> index 1a42940d92..5401d7c14b 100644
>> --- a/include/hw/core/cpu.h
>> +++ b/include/hw/core/cpu.h
>> @@ -526,8 +526,7 @@ struct CPUState {
>>       /* ice debug support */
>>       IntervalTreeRoot breakpoints;
>>       IntervalTreeRoot watchpoints;
>> -    CPUBreakpoint *breakpoint_hit;
>> -    CPUBreakpoint *watchpoint_hit;
>> +    CPUBreakpoint *bp_wp_hit;
> 
> During the last QEMU community call Alex said these fields are for
> TCG, and this series confirms it (also this patch $subject).
> I planned to move that to the TCG accelerator state at some point,
> but then I'm confused by the uses in the hw accelerators...

They are not exclusively used by TCG.

All accelerators use bp_wp_hit, as that's what's used to communicate with gdbstub.  WHPX 
uses cpu->breakpoints for some reason, unlike other native virtualization; I haven't 
looked into that closely.


r~

