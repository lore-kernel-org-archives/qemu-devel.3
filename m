Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F306EC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHRi-0001na-Ur; Thu, 03 Jul 2025 06:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHRh-0001nA-Gv
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:45:37 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHRf-0005YE-EY
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:45:37 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-453647147c6so83716155e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751539533; x=1752144333; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/ZkHDTYnd7w9tT7FcErUb/YTrxXuUo9RA3yVDQCWTRk=;
 b=MF83emjcaM4MCC1puj8hb23JLbEp8XEfwK1Nw8WJytwMbb+VIP5jCHei/JSsMjyGMl
 bvlI6KkKUIFAZQwt3bIUixfM6uK7ssM+u3ExHnvg4o49yQe/dDs26ul21+dKfM1LuJ68
 l91GpAXIBuOTbnbjveCb0ptLU/z0DB7N2zWMRuz7tWtcxrXEql3JSpdrqidVdUS/mNjf
 vSTe2rnKOlvUyyh7v81TOutyrIiUxQu5SGMkSd4D1LIgr7Bp3lNTjlINV4FQMHntgbgd
 DeQihiPV7wUVbIBcQhVJEwcmNbbrvmfKsadpM1vaHXdTuPvlj8u6Ph6MauUUjn5WIcSQ
 L09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751539533; x=1752144333;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/ZkHDTYnd7w9tT7FcErUb/YTrxXuUo9RA3yVDQCWTRk=;
 b=Ili7hxE1MV4N3dYgDRGTtse2fTdRLnW+cgNzlJUp4o+ECcm3uaJ6eJLbd/CTS2Di63
 vg1nvQZB5Cux3l5YSEhNFqq1TDGaiyXy8erlGtPxcm6j/zz/3vZzufSA9gfvRVPuu3bd
 yBQTq46PnoQPmz2KBVc3BZVmqTDqHHQQVHshJAgMb7gSk911f8unxJmtEq2HKfPDPVm6
 Abg5dWzxeQdRHKiX0bIUzSi9vJSz5LRSs82a7HcSRdG6ogqFXY7agCyWmMBLmVh5XYPO
 fryIblVktgb3J2L5NzDr8OhJMMrR51ZNjiPzPdOJlx5QnNNpBYZ3LD/quzgdnB9IWwx1
 6uBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeUXKcnGfpty6SBZiTczhfH6UH+9VpIx7uFOLR0HpF2X7Jt75kMkbiywMKiTCAqJAAR0sXwoXsRzgC@nongnu.org
X-Gm-Message-State: AOJu0Yz5LuKjN0beix7Gt8uVnISjl9rJnKyh48siCsrBQIstvYm1O4d7
 mH1WNCxbiQaYwpZ7gkxo4eBjRsx8uz+hlZC5Whbjko4I98VJy9FhXf2lZEU4Wa0BrtBoWnaxIj6
 jP7Sf
X-Gm-Gg: ASbGncvohGfOXa3Z+v0TyGRrZ3VO3CkQN9X64EJNoUCgevyp7GpTPLFmUNsHiRDi81X
 P78Ws7bQwhx6fhfzI9+oIvO1Jy6ZLAFvZITKfxkthCHVnlWiZOsRbSEmA5H8dHvi9V9yTO0CtF0
 /PU1XrbjY/V7ge8dsh1rGOuoCfNg/5gNhXkdLenS0/cioeLZtSpRNtXRIE/ztdRuipd+UYCt50/
 /BbDvLLbLIRBcRYBYCnNPIvP4YeQY+RXS4yEYoHYaxtXLvMFyJu4pVDzgP26ZJAWmSGXxEZ0FfS
 0KYh727E1qcLZd/7l8fQVSLjTpqXDRT0bDj/QQJ+Ov/+qrepkSaPHplS1CMbnCPxV5opDzurBl2
 O
X-Google-Smtp-Source: AGHT+IElA0mswuuh9WSnt4MDEnV+aPiBDrsxNfrDJ6sq7nHox2RqriJhZeVkOckam7J4GYfITpiuOA==
X-Received: by 2002:a05:600c:4ecd:b0:442:e9eb:cba2 with SMTP id
 5b1f17b1804b1-454a9e47500mr31207415e9.0.1751539532844; 
 Thu, 03 Jul 2025 03:45:32 -0700 (PDT)
Received: from [10.79.43.25] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bcececsm23244235e9.23.2025.07.03.03.45.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 03:45:32 -0700 (PDT)
Message-ID: <d15188cb-fa33-4d94-a3d9-b0ba3b2d71da@linaro.org>
Date: Thu, 3 Jul 2025 12:45:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 57/65] accel: Always register
 AccelOpsClass::kick_vcpu_thread() handler
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-58-philmd@linaro.org>
 <5348f155-5644-497d-b9f9-89924d961cff@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5348f155-5644-497d-b9f9-89924d961cff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 2/7/25 23:26, Pierrick Bouvier wrote:
> On 7/2/25 11:53 AM, Philippe Mathieu-Daudé wrote:
>> In order to dispatch over AccelOpsClass::kick_vcpu_thread(),
>> we need it always defined, not calling a hidden handler under
>> the hood. Make AccelOpsClass::kick_vcpu_thread() mandatory.
>> Register the default cpus_kick_thread() for each accelerator.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/system/accel-ops.h | 1 +
>>   accel/kvm/kvm-accel-ops.c  | 1 +
>>   accel/qtest/qtest.c        | 1 +
>>   accel/xen/xen-all.c        | 1 +
>>   system/cpus.c              | 7 ++-----
>>   5 files changed, 6 insertions(+), 5 deletions(-)
> 
> Sounds good.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Unrelated, but I noticed that hvf_kick_vcpu_thread uses hv_vcpus_exit 
> [1] on x86 and hv_vcpu_interrupt [2] on arm64.
> I'm not even sure what's the difference when reading the Apple doc, 
> except that exit existed before interrupt.
> [1] https://developer.apple.com/documentation/hypervisor/ 
> hv_vcpus_exit(_:_:)

This is the "Apple Silicon" documentation,

> [2] https://developer.apple.com/documentation/hypervisor/ 
> hv_vcpu_interrupt(_:_:)

and the "Intel-based Mac" one ;)

> 
> It might be worth moving x86 to use interrupt also, in a future series.
> 
> Regards,
> Pierrick


