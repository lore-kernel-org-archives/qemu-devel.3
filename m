Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCA6C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 01:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT9HU-0006w7-KO; Sat, 21 Jun 2025 21:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9HL-0006oa-KN
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:13:53 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9HK-0005hc-6I
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:13:51 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b2fca9dc5f8so2433256a12.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 18:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750554829; x=1751159629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cv09sl8SVMzT70GwdIJfG6KW0ooCMB/YOb7/Mqk4Kj8=;
 b=aTPTD+xIoSQuVJa532GA58UwsNOZEWNMp7vsaBAFP7+LK1WOM3l2F1bEA9PBdAa2Yb
 cr4pG/20tPXdLZr7jnbIP5DWYQ2nW1dngqUlqGwO9Gm01Pc6UziAha1g2e1QrNrOvicp
 LIy2FNI4TORlwB9RaS2bC1NNPboKjVN3Pc7a6yaDxkZqTJToKiQGfBC9+vaUW9Bf6H/4
 TrzuB5jmBTzBQ+YdRTpAIgN4mlgYZfTzU6Yq3OMmdVxDylDtJ3qI7Jrz4YTkFQyIsUSu
 GhxzYpq11A1nHsrPFct1R+k48JBNGcqWty/xBE4SVCSWPLPgDFonkKk6BBMWdq99bnwW
 ZU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750554829; x=1751159629;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cv09sl8SVMzT70GwdIJfG6KW0ooCMB/YOb7/Mqk4Kj8=;
 b=TvJgzEVMbT72fMpCZzimxDR22EGFtwbN7/NhW7S4uZKwXcjj1HM5qRBOBABjpmLaX3
 GkrsrdJfskVtcU1ilEEIfD7BCAeAngunQZnH4udk/MPb8+/ZvYNqO4LUnk/hIwLxnqrP
 ZNVfHbWGUii3SjhUHfC7DdxZZ1JS789CUZ8Hzcu9u+6CLXPp3q/i7kRWdZpdzD7F9axU
 t/BFmln6Z8xQ3+sNE7ZwQR1dNrVml8kG/shxWO9HitQLaPiraP3tXMliwfKUlfXf0+PX
 xJdX/fUFzhohH7FrNMfQq5iiZXXC2rt6LBFfKR9DZ0UYnmCRT6Zxe+pUBTMCrOXp4Wwg
 qdeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhxqsoyv3r6RVAlL+bX4iX4WhCjUt+84mk4ne6wyfO6gLjMdzFrcEB13dPJPkqgQ5pFKNfsw7rm+AG@nongnu.org
X-Gm-Message-State: AOJu0YwiMb/1s9yAy6ZOamu66SL70IJT9xi5spZ00U+cEVe1UQYd2qJ/
 0RyId9tNk88mKYfxvG4cIY2Z4M5g4mChUXB6qJ3cI7cP6XsFPYcqDlZYVuNOZkKlFwika45KvQ6
 biWcayGU=
X-Gm-Gg: ASbGncvFbDf4508wRDMAe4pVjw9asPA5xm59smr4H+rI59WrJHplPv3+lonhvulQTis
 7lVoQZ22qyw5EwxcYlBzdKrCXmtGZwycWSzRPj8iI7sQk1vhbnkZK3qXYC7L8CmF5fB+hM4ngK0
 fcs/lmg2i/uHYXEIusnivUxVAlq9WUAFYYSJc+HE50+79rlDAsmuKZ5j4DkBRm65H6Mp+B9iaYx
 IFB38xzmxSycpdaUPrWiMOEKnTqGgKisFAePVwdQa2HlQUxbGvWK2BpJApuTM9PS0HKwxn6C+7T
 4Das5+3CCz4QPCRHlLeYRG7C5vCC/obORCzCH7hdycf6USegznopNvZxZMc+wFBpiddEyKUO/xZ
 emdt2sOpzGcNaZ15bNA4LVo1fLJUP
X-Google-Smtp-Source: AGHT+IGyazhzeCl/ejglfZ8G7z7AKnbEAgTG+OSNYfHpYUeAXKR4DOpjh/U4WOV4BPF3QaUdcSWHJQ==
X-Received: by 2002:a17:903:32c5:b0:235:2799:61d with SMTP id
 d9443c01a7336-237d991f9b4mr127127445ad.33.1750554828736; 
 Sat, 21 Jun 2025 18:13:48 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d8393275sm50726475ad.39.2025.06.21.18.13.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 18:13:48 -0700 (PDT)
Message-ID: <11446933-6fcf-4857-8b9b-794d8682659e@linaro.org>
Date: Sat, 21 Jun 2025 18:13:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/48] accel/kvm: Remove kvm_init_cpu_signals() stub
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 6/20/25 10:12, Philippe Mathieu-Daudé wrote:
> Since commit 57038a92bb0 ("cpus: extract out kvm-specific code
> to accel/kvm") the kvm_init_cpu_signals() stub is not necessary.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/stubs/kvm-stub.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index ecfd7636f5f..b9b4427c919 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -105,11 +105,6 @@ unsigned int kvm_get_free_memslots(void)
>       return 0;
>   }
>   
> -void kvm_init_cpu_signals(CPUState *cpu)
> -{
> -    abort();
> -}
> -
>   bool kvm_arm_supports_user_irq(void)
>   {
>       return false;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

