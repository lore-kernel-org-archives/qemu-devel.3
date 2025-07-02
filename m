Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096F6C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWuoA-0004hX-1b; Wed, 02 Jul 2025 06:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWuo7-0004gq-PP
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:35:15 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWuo2-0007tq-P6
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:35:15 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-453426170b6so40236535e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751452506; x=1752057306; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oD0GL1nOCIqqpM8AbB0N+9qlEC+dujHTUkfaXTivkq0=;
 b=a7r/LFECIAmnRvZTUnUVTcUz/vStgdFl4LvsF4mIG8MC2GCTsfgPPCMNPwTrRXr2Gx
 t+dIkPEd9DWMM2AeK0UJu+C4hQJPwBtpmX/YjqWiIH4/JXd3D2eVpFTUiU+5S05THS5p
 1fFIF7e3xnK9BLor0xsv0qdoTB+B9kU3O43y1weQu0Ped9pJhDHrbhxfI6WIaitPs5sL
 xbv03ofMLdNo9AqcfyAuAyMTOQekFxUEHDf96LV7OaTB7a0m57BaeYUEpJ0IYrN2dL4Y
 C7ylECDahQJ+e7JuLznN5CK0ShX+3jOyWeaMCZISmgRZ0G21f5Fb4WJoDZUrgwi+fNWc
 sHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751452506; x=1752057306;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oD0GL1nOCIqqpM8AbB0N+9qlEC+dujHTUkfaXTivkq0=;
 b=kNRTHkeMMasc5nLkQId1xjXKw6uFGpSCFXAvtpV1MCYkyo2tggiFPX8FhqC7iV/1KT
 Gb+0kywbNu8p5oM0A0VLUfDVF10ceOnMl2mr9wSVpPGkUwVaO+kijJIoPd+Qj5npX9nT
 HbABX5I+P79jraKcD6+jUdHtQb+5Td40LHzAkD6Xco1GkULtQrLu7N90pHpT6X2bgWJZ
 4Uyrhmpm97OsTdHLGweAtoMLGIGNcj69S1RFD8omwdtX83o+ZvlbqjW0dfvwrACkpM1C
 AfiuPICN0PqLZMwd/oy08iLqvUBp1u+PKjxWVLiwRwIrhEtQ6I25MikS9fZjVVKCdFef
 qESg==
X-Gm-Message-State: AOJu0YwF2kfWJcm20aeVs/h4XhQlhKC09XO9c8Q/PdPuJiCR5T24L/HA
 o3oysalSow+pgo5Tz+wXJPHFKvksoMTdq4m/SqPLZt0Y6UqOdbTAEhn8qZ0fqNFN/URxk1Ce4Bq
 Pm/l9
X-Gm-Gg: ASbGncsUm/2TdL+U7dn+d4ztsI515NWDbgG1lMiLTtc56rrPP3e9FOL+D6jSilaTE7/
 qghJIGcA3Ti/Ma5xs/iy1dWobgvYctIlxU6BlXQ0JVBH4ZscrdbMiG6RWFBc57amHrzTVYVfv5Q
 DQjImDB/OHdR51D63MU6wWyOziE6EInsK6wwB6Wbp6urLqyOmXQpKsYRPG/5Bz4dd4JnvNKPy93
 RhuhgkYcjZUqPaM3jD7xEpNuZDdq9kYH6B38oqmup98MbErESToiT/wX9ix0lZ2Z5sJIgojQLub
 xVsBca12epQ0TIIb9euPC3enwjVhkZ7CuT55cjOnQDvgP5EHNKDvN1ucDmRks9zbETX2GYNLJb8
 N2wbP7wiaGMPEJN4fDnjgB2/ZIYVmXg==
X-Google-Smtp-Source: AGHT+IEXT5B3g6oO/Y/mowfgM+llMLrXIGoACospgjvHak/DXhi08Mx20MxCqUPkg5YKJdw7xHtNYQ==
X-Received: by 2002:a05:600c:3ba5:b0:439:4b23:9e8e with SMTP id
 5b1f17b1804b1-454a675e86amr8228335e9.3.1751452506255; 
 Wed, 02 Jul 2025 03:35:06 -0700 (PDT)
Received: from [192.168.69.166] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a390d4asm196708445e9.3.2025.07.02.03.35.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 03:35:05 -0700 (PDT)
Message-ID: <f5a92fea-f5ae-4bad-98c7-9b5ac6b4640a@linaro.org>
Date: Wed, 2 Jul 2025 12:35:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/68] accel: Directly pass AccelState argument to
 AccelClass::has_memory()
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-14-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250701144017.43487-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 1/7/25 16:39, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/accel.h | 2 +-
>   accel/kvm/kvm-all.c  | 4 ++--
>   system/memory.c      | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)


> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 72fba12d9fa..d56ac2a058f 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3789,10 +3789,10 @@ int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target)
>       return r;
>   }
>   
> -static bool kvm_accel_has_memory(MachineState *ms, AddressSpace *as,
> +static bool kvm_accel_has_memory(AccelState *accel, AddressSpace *as,
>                                    hwaddr start_addr, hwaddr size)
>   {
> -    KVMState *kvm = KVM_STATE(ms->accelerator);
> +    KVMState *s = KVM_STATE(accel);

s/s/kvm/


