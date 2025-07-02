Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892A6C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 17:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX1dg-00075e-O1; Wed, 02 Jul 2025 13:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX1de-00071V-6r
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:52:54 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX1dc-0006HE-En
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:52:53 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a525eee2e3so4519744f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 10:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751478770; x=1752083570; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EIwR6V9nYMA8INGDW0pmc9lPXYy6WzUGJoiGhNb8Ovk=;
 b=b+Fe4xl3lofXIBcxge+J+4G3AuIdhXXxIgdxK7m79MfqLy1HED1mkeRzlGQY92s4/J
 glQzWd+iXJJvsmRTQ2aoKqijWPXZq/ZsIFkGatZv+ec6Xayw5yQ+mhmQwp8mHHoPNnVg
 M0v9OwSYnduVqWZ1vVQrlYiIZi/w04nq49qGM6A9BjRSOQjSwFjhFk1AmGph//k9EeQ7
 vP4lEvHOGT8XvVrU+B+WU+Gih10PhlXVqF39Y+K+Qnn4fevvf+1jdcF3hTDCDrNHyTk8
 t3IDcyISVdVNoH+IUwT2ZTHu8/ZwbMXP1umNoEryv7XTNtJjAAoxyxCozMOJDPbzfVxI
 7ABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751478770; x=1752083570;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EIwR6V9nYMA8INGDW0pmc9lPXYy6WzUGJoiGhNb8Ovk=;
 b=NuXrdGHlijEPCi32Wv6NaMOfPz6lAYfx13JwZPvM0E7pyuCD0wUJOf8Nht3d1e88R9
 pfEsrqA2vqA2tV1Zdl0rmWQP/LmOOZMvU4MXpTHu0S3+iylUo0x6y+4XhnBAQi42hISE
 p5Q0iBGHfzJXYsxAASek5ZUDubY3pmiM/oG40blfnNSAp2M6r9V1GS2/5sKw+m63rO3Z
 NiVQPGGPYHgi1f7NttFY71brZ2zTxWFLoXW4PGihoEvDdPjPMMwjdI+yp7HyFPpl4Ze1
 XVvIMSSGEiWcDIffDXbskTAV5TDXJiAGF49N217Q5X2lkCbOCmT6Gy2N0v6gE+V8YeY7
 tCkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4ms0qzLHLXKym/axEczv7pLUB3XbAv36MCY8w49Cyvzbom0xL8EsOb+o95VXdOV+YTFtsoBC5JJyg@nongnu.org
X-Gm-Message-State: AOJu0YyLlsUB4bIMvAjwekNNiWEn5lyOwpdmlVm9OZxZ8Jk8fzGS1esv
 22ZguRmV+fZRqRB9vmlwq3gRuCMtJ/GeoZHYJa8pJ4E01wIN2eM2c3pUrjGexP9AHoE=
X-Gm-Gg: ASbGncu/Irvb8YgSvPWXyCkHNV1QBfBAiiLgQ4ZonlWk+iMEM4doxAcw0fm9AQxvcW6
 pgG2HvUtZZGXIgb0QYDIcJN78yYKI/pngHDA4Nzxn0w9xvG1i0EPLZCjnJv1LFPlKdpmz4eWAeB
 PH1RFkIh1bAFTcAUa4kG0EQyBTIMXtnSIIAvKO53/yzedip77OMegU4qsMxPamFu8CCBlDkOGuq
 8cBbup/XtX0+FSTTrQDz3/PXZh3IeMR9yt20HcsPnCESjn950oSqpIUab5SZjawnzpQT8vBs7lC
 vQPAKE/uvBspLmufZIcPmWp7C9JiZl6TzdUF+i8sqrNYcvY/NH8HEHTk4U0KRnx2/iFyU0MWdm5
 js7vjprR2ri+FT7YJtkp58Wd6twX9iZHXmt6vMqPG
X-Google-Smtp-Source: AGHT+IERMM5KO0vUZgRsawxoZ2HhiQRFQrWGtUtQEa0nJEtkXRffnVk6AublfbcBAFgTjobJ0ElKzg==
X-Received: by 2002:a05:6000:2d81:b0:3a3:6991:dcbb with SMTP id
 ffacd0b85a97d-3b32b42782amr83808f8f.12.1751478769911; 
 Wed, 02 Jul 2025 10:52:49 -0700 (PDT)
Received: from [192.168.69.166] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a99b1a5dsm4242345e9.29.2025.07.02.10.52.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 10:52:49 -0700 (PDT)
Message-ID: <860c7281-5e0d-4b6a-a728-5769453640d6@linaro.org>
Date: Wed, 2 Jul 2025 19:52:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 67/68] accel: Have each accelerator implement the
 handle_interrupt() hook
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-68-philmd@linaro.org>
 <8353d9c8-8dd6-4dd1-ade6-4dd7f5a4c8c5@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8353d9c8-8dd6-4dd1-ade6-4dd7f5a4c8c5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 2/7/25 17:30, Richard Henderson wrote:
> On 7/1/25 08:40, Philippe Mathieu-Daudé wrote:
>> Better to make the interrupt handler an explicit implementation
>> rather than depending on some generic handler.
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   accel/dummy-cpus.h                |  1 +
>>   include/system/accel-ops.h        |  1 +
>>   accel/dummy-cpus.c                |  7 +++++++
>>   accel/hvf/hvf-accel-ops.c         |  8 ++++++++
>>   accel/kvm/kvm-accel-ops.c         |  8 ++++++++
>>   accel/qtest/qtest.c               |  1 +
>>   accel/xen/xen-all.c               |  1 +
>>   system/cpus.c                     | 15 ++-------------
>>   target/i386/nvmm/nvmm-accel-ops.c |  8 ++++++++
>>   target/i386/whpx/whpx-accel-ops.c |  8 ++++++++
>>   10 files changed, 45 insertions(+), 13 deletions(-)
> 
> I had suggested exporting generic_handle_interrupt
> 
>> @@ -358,6 +365,7 @@ static void hvf_accel_ops_class_init(ObjectClass 
>> *oc, const void *data)
>>       ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
>>       ops->exec_vcpu_thread = hvf_vcpu_exec;
>>       ops->destroy_vcpu_thread = hvf_vcpu_destroy;
>> +    ops->handle_interrupt = hvf_handle_interrupt;
> 
> ... and then registering it in each accelerator,
> 
>> diff --git a/system/cpus.c b/system/cpus.c
>> index 8c2647f5f19..e217e42ba03 100644
>> --- a/system/cpus.c
>> +++ b/system/cpus.c
>> @@ -246,13 +246,6 @@ int64_t cpus_get_elapsed_ticks(void)
>>       return cpu_get_ticks();
>>   }
>> -static void generic_handle_interrupt(CPUState *cpu, int old_mask, int 
>> new_mask)
>> -{
>> -    if (!qemu_cpu_is_self(cpu)) {
>> -        qemu_cpu_kick(cpu);
>> -    }
>> -}
> 
> ... rather than removing the common implementation.

Oh I misunderstood then.


