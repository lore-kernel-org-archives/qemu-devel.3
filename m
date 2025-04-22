Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26978C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 18:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7I0n-0000VZ-2A; Tue, 22 Apr 2025 14:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7I0k-0000Qu-6g
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:06:22 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7I0i-0003JS-E8
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:06:21 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so4244808b3a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 11:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745345179; x=1745949979; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=msxJBNSDT23ekAzt8EZWHEs3wL0VguO3+u9ivFbpSb0=;
 b=Ia/D7XV4QSweo7R2N6ajspSxQRucwZqmcHgpK6c7BveP06xcy4NFndnlzGgAYYYF2A
 i4MeU41T/voMveqfgWwulzJA2xNDtyVeekgtwseEsd4Phs1FnbKoxbSFe4dbgRyR9EpT
 mEkHkISub6BYsjYUwrQ+qaBkM29PMKyxBFe/D+yYTPtEWTE3yH/IiSfNI12qxRSkvBW4
 kdCqn8v4cSbv9irCMGoLK22hyVKC6c6ndzBsEyjxR1XwL72BkoMr79j+RCPbwzhPkAfA
 8Rd+ZoY7zWSQbf30k6EOfwn1nYUC5dxzP5KxFl/SgnvNh9DX1CwmBP2HaunRfTArik82
 19Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745345179; x=1745949979;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=msxJBNSDT23ekAzt8EZWHEs3wL0VguO3+u9ivFbpSb0=;
 b=PDGAqdVwCFE4JTx99Bqc4D0GxvQiVE2aRRvn/EyKNXzaZNuZzI08FBNqJRzv1LJYPr
 V9hYdtEruSUe0/bk7CamTGS3x8KVJKCREUi9OIiy4Al7Hgja6+AHunrlMsKwk7GMPxvp
 9CSY8NH2PGNYMtpJYzhkZgh6hb7lylY3JnVt7UlF5DMf8XF5pjsrRn8Hvu+RAzyyRZ6H
 jbqOX5nst0HeqNhUqSh4TVfhHrri2H0/kNGmYN9S4n/3HQlwIlz+233gxRTmht98rrq3
 BwECwur2TkNbwTO2+SzsK+wJt7xZDBvTn8nFV7fo8vZ+fX9/Tuc6o16I4DQvXvGjh4nD
 GKcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDPS/POrT53qOVx3fPO+1IcFEIItM2voF6RyUrOHN6lvauLzpMN9gQbQDDdNsg28y0EiAUg8YyrQh4@nongnu.org
X-Gm-Message-State: AOJu0YzuU3UJQNU8LBqksdTQz+PvfuMy+ayXdOfsYxHqLOu4KKh9wCM9
 7wDbhSYsGcL0migF+7IPXx7tQly8nk5pBmeb1kiv36ZR1nrv81VM+1EkUUQmreE=
X-Gm-Gg: ASbGncsZ/jDi8vgZ7StoraEuSNQ2BTepxp9f+3T7rYpMzQaq443uQvnqrYpRcksFMtT
 GH+YrpGUiroGQQi8MBdnyZk/HSa4y/wFVqRVyHKvdKjgFJ9sEso+rp8lvqkSjZNzIrNY/+HVEmL
 rKJA8Dtx4645cDZQOSdTDdE449OeB7ejlAVQ1xH38xEuOt0iVf1nLuuuKSWFCaA3uJ66tY/hSqo
 L8dM9fLdSbGpZtARn4duhPkEbZnXcYAPnbsqBNrSv38bzpKqktRlBDJTX7TIqBLnrUKJgFTVgnZ
 VEYEgVQB1HuLx0BkWgjGc1mVS86wZDlWMr0tbS6nEdDvyeCpuZs6VnpeePmEtoXcxSuoALtqbqf
 jElTtGqI=
X-Google-Smtp-Source: AGHT+IFRA14FIsa5cGpFI8ujsiWwVlPMZ1YMsGS2dNYqJtf8A77c8kABtEq7qm66mm1Cb7frg7Qu2g==
X-Received: by 2002:a05:6a20:158f:b0:1f5:80a3:b003 with SMTP id
 adf61e73a8af0-203cbd505a0mr27624010637.37.1745345178727; 
 Tue, 22 Apr 2025 11:06:18 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db1447a11sm7547897a12.51.2025.04.22.11.06.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 11:06:18 -0700 (PDT)
Message-ID: <b883f0ef-6131-4335-b273-90fd3d8cc5e4@linaro.org>
Date: Tue, 22 Apr 2025 11:06:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 19/19] hw/arm/virt: Get default CPU type at runtime
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-20-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250422145502.70770-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 4/22/25 07:55, Philippe Mathieu-Daudé wrote:
> Prefer MachineClass::get_default_cpu_type() over
> MachineClass::default_cpu_type to get CPU type,
> evaluating TCG availability at runtime calling
> tcg_enabled().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> This removes the last use of CONFIG_TCG in hw/arm/.
> ---
>   hw/arm/virt.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 4e11272a3ac..df8dda812cc 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3131,6 +3131,12 @@ static int virt_hvf_get_physical_address_range(MachineState *ms)
>       return requested_ipa_size;
>   }
>   
> +static const char *virt_get_default_cpu_type(const MachineState *ms)
> +{
> +    return tcg_enabled() ? ARM_CPU_TYPE_NAME("cortex-a15")
> +                         : ARM_CPU_TYPE_NAME("max");
> +}
> +
>   static GSList *virt_get_valid_cpu_types(const MachineState *ms)
>   {
>       GSList *vct = NULL;
> @@ -3188,11 +3194,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>       mc->minimum_page_bits = 12;
>       mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
>       mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
> -#ifdef CONFIG_TCG
> -    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
> -#else
> -    mc->default_cpu_type = ARM_CPU_TYPE_NAME("max");
> -#endif
> +    mc->get_default_cpu_type = virt_get_default_cpu_type;

It's worth noting that this is a behavior change.
Previously only

   ./configure --disable-tcg --enable-kvm
   ./qemu-system-aarch64 -M virt -accel kvm

would default to 'max' and

   ./configure --enable-tcg --enable-kvm
   ./qemu-system-aarch64 -M virt -accel kvm

would default to 'cortex-a15'.
Afterward, -accel kvm will always default to 'max'.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

