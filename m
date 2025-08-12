Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9C0CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 04:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulgHg-0004IK-Ie; Tue, 12 Aug 2025 00:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulgHe-0004I2-2G
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 00:06:47 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulgHZ-0003lX-6r
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 00:06:45 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b77b8750acso3052998f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 21:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754971599; x=1755576399; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u/huQhuetNRLWy3hzNz6ryzi9q+Gm/DtMcoCfprnt6U=;
 b=H1aLZxbyQOY2K+97aAWlJOxU1+7u3tEluyZJTgkD2rI5+AfvYqDhwzrEq6B4Hr0e1J
 zdzJyIweIsxIyJMni6jnDFVzOFaanxXnfKzZinBR/ShGgwMJnkv2wLuG+DV54BhBUPWg
 vD8pv5JwstmAtwMXAmoxKryVSVKe1RSqkQrHwLotXxz75T5kFCvBzqh9Pzn9+VI+rvzW
 sZHUx+0l5chOlaXa13RpczeUytLElUhqAcc/RTkUu3pShTmZ6AKQW/5JEVbPQbPj/AhD
 fdHZrLufEVD+98osv0JAhumKKA6JVLQy2WJW9xO6w1cRTNmt9Lj7KihoKvF0XVBZ7574
 wBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754971599; x=1755576399;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u/huQhuetNRLWy3hzNz6ryzi9q+Gm/DtMcoCfprnt6U=;
 b=vXIiRN5FBwnFPd9yV555zFWP7rWebduli9nD7Zulx4mGALoaB+/oKKKgdhXSfCLBBw
 STQyeksaWMzAJR4n7cnSXmCAqxGeDPme7LhBilcBKPfaq1tigIp+ZhcBMQq2vQp/KNgh
 VPar9jUwwE+UJuKLxERT/GY2As40+o/kQsZGd/uTgctohduCpGTIVAc1HB5NfjI0zOy+
 Yj1zxbSnNi2/jA9pCRZdW1TTn8fpdROukFEF7RLayEW1cQTeXLY6eOGP0foyxDyj29Y+
 PZ5J9zzGSETi1ldq1ueMupdNB0J+2gj1YdHXIQC9WKj7b6n1HrWAzEhNNf1IfZ9lC/d5
 xPMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdYyP6c62Ms90GJqwkheg6JcaD34uQUiGnZMFqk8ZfBTujnlRVe7bZDAe/UgNJqRHX6/eZB5y3yNMY@nongnu.org
X-Gm-Message-State: AOJu0Yx1uYNgrXEvBPwOaNI7emATpmH842lph01JVU+aRU/0UwNWeRDc
 BA7tuoy6cR8SrWUDvG6+c8zPomxSw9Z8P8GORg+geQogSLvqG+Ezbn180vYt2smaMyEHjaWpCir
 VtWgi
X-Gm-Gg: ASbGnctFU26T61SUL2nu77M5ZWgKA4xFzX98B/tyatiN9nNchT2Mu+2KKYJIk7quKxp
 GvjSssWm+xa9L5Dwvh3Vvg5L3mUvdJUwQyLhwJK92WTnnUlATXxAlOGtnvFvsZYZOSt8HFQDDmb
 cqQ/TJh0qh8Lp8VKXAmpuSH4N70tomm3EXplaBJFElN9/8PxE6hPm3ltU/Uqz31IRxGEvn+nV7U
 BW32z3Qpo13/18VHUB5uTPtq0106Y+BkWBEfYtAmW3h3j1VKUYoUwFPMDyuwIbYnKsS5tV2oloH
 9EHWWz97G/4M51pxaU5xrZqqrkzMIPJSH0q8cELa8ETQWGJe4q1iCzkrhpq/12YJSnj7ML5yzWg
 SnC3/5bDky2tC6f/s1b4GFAUZXx17x4N2XysMEAwJTNhBwgo6QIP62Q+yXEacaltJwA==
X-Google-Smtp-Source: AGHT+IF6HFRWQqEnFm0F29gcgD6aC+PzL9oYO9h075qSRVV0Y+lstt1hrB3dTR/J+bg8XFczqWHn+Q==
X-Received: by 2002:a05:6000:230a:b0:3b6:162a:8e08 with SMTP id
 ffacd0b85a97d-3b9111545ecmr1285382f8f.12.1754971598723; 
 Mon, 11 Aug 2025 21:06:38 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5862fd9sm298135075e9.16.2025.08.11.21.06.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 21:06:38 -0700 (PDT)
Message-ID: <ca7bf8c2-1128-4873-96fe-7bdaf2ed7fa8@linaro.org>
Date: Tue, 12 Aug 2025 06:06:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/11] target/arm: Introduce
 arm_hw_accel_cpu_feature_supported()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250811170611.37482-1-philmd@linaro.org>
 <20250811170611.37482-6-philmd@linaro.org>
 <2e5d40ac-927f-4109-b285-c0635b959066@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2e5d40ac-927f-4109-b285-c0635b959066@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 12/8/25 02:35, Richard Henderson wrote:
> On 8/12/25 03:06, Philippe Mathieu-Daudé wrote:
>> Introduce arm_hw_accel_cpu_feature_supported() helper,
>> an accelerator implementation to return whether a ARM
>> feature is supported by host hardware. Allow optional
>> fallback on emulation.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/arm/cpu.h     | 12 ++++++++++++
>>   target/arm/hvf/hvf.c | 20 ++++++++++++++++++++
>>   target/arm/kvm.c     | 22 ++++++++++++++++++++++
>>   3 files changed, 54 insertions(+)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index dc9b6dce4c9..5136c4caabf 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -2507,6 +2507,18 @@ static inline ARMSecuritySpace 
>> arm_secure_to_space(bool secure)
>>   }
>>   #if !defined(CONFIG_USER_ONLY)
>> +
>> +/**
>> + * arm_hw_accel_cpu_feature_supported:
>> + * @feat: Feature to test for support
>> + * @can_emulate: Whether Allow to fall back to emulation if @feat is not
>> + *               supported by hardware accelerator
>> + *
>> + * Hardware accelerator implementation of cpu_feature_supported().
>> + */
>> +bool arm_hw_accel_cpu_feature_supported(enum arm_features feat,
>> +                                        bool can_emulate);
> 
> internals.h.
> 
> I guess this is ok.  If we ignore xen, which is a thing of its own, we 

Does Xen manage vCPUs runtime?

> don't currently have more than one accelerator per OS.  That hasn't 
> always been true for x86, where we had 2 or 3 at once for Windows.

I felt than adding as per-target per-accel methods would be over
engineering at this point, but I can give it a try if preferred.


