Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C0EC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7GU5-0002yM-O7; Tue, 22 Apr 2025 12:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GTw-0002vV-LK
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:28:25 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GTu-0007sl-9w
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:28:24 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso37888945e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 09:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745339300; x=1745944100; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=drQUt9uNdH0NbEFWsLBcl/Ay0N0ktfjkRefqgOu2tyY=;
 b=Z4j3s1pUzJF3hmH5IDzD6y7wgXTgDabde1aBFJBmQ6dErVZiDqpMj7apTnJO/zfrbm
 QUKC3Dbmo0FBKpXrftzgFOm1tBOC7j/BKkOw+x08rgR/8zIjd1jue4bd+YXsGMzyehzr
 ROqGViFUsEwvhA0oUHkUEM5YZajESuI2d/futbrJxD+TXTJu11P6rKONVcd2wpWxDdSV
 7ZVzCqVT/NW8sjTMhk81Hlv9iUVHUbV7EAEUSomBUNtl+5QJie1ywPzvmygOwVayu1Vy
 j2dL4HfwiET0PzamnfAs4pc8ae020S/Psqexyooit0Ei9oKEUjn2CBhqU+eZ6vRwYv38
 F6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745339300; x=1745944100;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=drQUt9uNdH0NbEFWsLBcl/Ay0N0ktfjkRefqgOu2tyY=;
 b=liNN6jGDQ0jNjyT/TknfPHaStXoBQcWsLJoriTJjsCaEKybW5QPVw+5rSZhznM43SC
 0/LDmuoLGM+T45h8wl3rlUrPx2u20Ec9TZazT6VxPeKQH6qMRnRBNwlqPvKaNL1SI2aD
 s5gDGOJW8zm+q1MLAbDJy7u5xhLpi1vHgbEEoC/RdvyMtomZpzlDGINDltjuAYpUpfpD
 cDbb59cd80br1Vb9Nn9Af30grgQfShDoTWC0VS2Ao8dhg1ZIPmjDJZDDOGcb7oTrj7HB
 rMC+yUmppD0YpQSL70t3I1PErqDLyV4Ol0wm5Z8I6O5KdbVv6YS45ONkU3M0tHa+JQ0k
 DefQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGZWtHLB9duibXFoBpjYeKhda+poHQ+cige77r/e2EwwZSD3Gd86SHJDeiXJsy/At5FTsT6allpFb/@nongnu.org
X-Gm-Message-State: AOJu0Yz6CqFqzwxEb+PFu7W/6ce56aGKmfqjO7Nbo2mE6ecMVBkPLV0l
 rRaP7i5XRBcc8pVdT/igVl3g+3v6ZGMofy9gHm8BFDH0HHFLUX2Q/TEth1K0f1MvCU4GGn37ZAA
 A
X-Gm-Gg: ASbGncsJVVYH6KR2VEiBzin0DsUbyI+KrB9w+EABa9NY0RBsESK6Zdt2XdO9eE/PIpL
 pu/1dA1tHSp+Pj6zohgJjMjnh36MRyDn3iYyfcCuWsHClstdR3T4iCHRjZZhMXPeJi1n52wwBsV
 B8lzMaTcEf5S/E+ZEOtUmDcJLf+NrxQ65xYaMV2gu6tF1y5s7wseKxtM1GwltfaZQ9Y8r0zy9qA
 mzl+nPeudw5sVv3VK6kLT85ixhJDbsfzin7EvBaNoLoIlimdEuPzx9a+dBDWpZb5khJR0XlEsGc
 SQIsl7NmPUfAoYbnVmqw4syw7gq181p8dG6FBErc7OK+5CzN/2xksin2w461MUBQv6QR8nSh/gr
 /G7r6W0XgnnyXG7YeZMM=
X-Google-Smtp-Source: AGHT+IHOPb5CuwgDm8cgc7bVDGYGIEYUnBd8E65UVFpYoXPaoVi/ijp2eZTGUlIIre5lcpx08WqflQ==
X-Received: by 2002:a05:600c:4ecc:b0:43c:eeee:b70a with SMTP id
 5b1f17b1804b1-4406ac0aec8mr117550475e9.22.1745339300623; 
 Tue, 22 Apr 2025 09:28:20 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d6db10csm178881855e9.27.2025.04.22.09.28.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 09:28:20 -0700 (PDT)
Message-ID: <fcb3cc9f-5742-4648-a57f-be97be14f604@linaro.org>
Date: Tue, 22 Apr 2025 18:28:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 126/163] target/microblaze: Use tcg_gen_addcio_i32
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-127-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415192515.232910-127-richard.henderson@linaro.org>
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

On 15/4/25 21:24, Richard Henderson wrote:
> Use this in gen_addc and gen_rsubc, both of which need
> add with carry-in and carry-out.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/microblaze/translate.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index b54e5ac4b2..31afd3ab5d 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -310,11 +310,7 @@ static void gen_add(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
>   /* Input and output carry. */
>   static void gen_addc(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
>   {
> -    TCGv_i32 zero = tcg_constant_i32(0);
> -    TCGv_i32 tmp = tcg_temp_new_i32();
> -
> -    tcg_gen_add2_i32(tmp, cpu_msr_c, ina, zero, cpu_msr_c, zero);
> -    tcg_gen_add2_i32(out, cpu_msr_c, tmp, cpu_msr_c, inb, zero);
> +    tcg_gen_addcio_i32(out, cpu_msr_c, ina, inb, cpu_msr_c);
>   }
>   
>   /* Input carry, but no output carry. */
> @@ -543,12 +539,10 @@ static void gen_rsub(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
>   /* Input and output carry. */
>   static void gen_rsubc(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
>   {
> -    TCGv_i32 zero = tcg_constant_i32(0);
>       TCGv_i32 tmp = tcg_temp_new_i32();
>   
>       tcg_gen_not_i32(tmp, ina);
> -    tcg_gen_add2_i32(tmp, cpu_msr_c, tmp, zero, cpu_msr_c, zero);
> -    tcg_gen_add2_i32(out, cpu_msr_c, tmp, cpu_msr_c, inb, zero);
> +    tcg_gen_addcio_i32(out, cpu_msr_c, tmp, inb, cpu_msr_c);

I was expecting a call to tcg_gen_subbio_i32() but was incorrect,
tcg_gen_addcio_i32() is what we want indeed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


