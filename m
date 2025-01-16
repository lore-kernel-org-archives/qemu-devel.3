Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91327C02188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 17:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYTt0-0002CW-NP; Thu, 16 Jan 2025 12:42:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYTt0-0002CO-1h
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:42:30 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYTsy-0003z3-K0
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:42:29 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2164b662090so22829495ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 09:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737049347; x=1737654147; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jaxa92KSXbzMGePXLv9jWI9PU4wkSZZOFkYo3mI2weM=;
 b=aH3oXvvFfGI3bbuL6HzkAwY+lZItYLkT6PBFfx7+0g9SsjHUmiWGRqj1NLRlXjfU5O
 XHyZ2Sj8h6B16sNq2/Zu8Lb3ZH2ymcYIcSutoCxOK7sVeP3PgfW0K4CBg9X7YaBlSlYj
 pF2odOO84rxFqaFIwkpO08881ROCAiybMT3qYotx9ocU+iauVh1u8i7FAUmkq0I9VEy+
 1kPkeC9HYH8nGd0xAQBY94pA4FPM88sr5cGgK8tVFBauGPTW7n7d1VbH1oIY9hxmXDML
 HqPb0ZVnAaj56pNAw5Q0OGO2s/liyXLMFdySaCY5OQkcxbOJwMnGbU24PeEBPrc0eLyE
 6zMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737049347; x=1737654147;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jaxa92KSXbzMGePXLv9jWI9PU4wkSZZOFkYo3mI2weM=;
 b=dTpXYccilQVZiRagDqaFD+oWA+huSuAF/N4ugM1F9D5GjCPEzkJTFjKcMwCrk2VD8d
 6zHcWxpxccgZQNjLngpFLqu6YxeHqR66cWD72/6c8HVlIZwUAAATzjcJRH93oD8Dmd99
 8zQ+K3vY/pVer1Z8NEvaJc80p9GlUsyFwsLIcyf4b0LmHKWEJOxk/mKrCLXKeOcXfAcD
 70ptaSOlHcPEWtE1P731CeJ+4BbWJq1az/zOp+NDuaUpROXWI7pqa8ipa7RRgEdnbsBj
 CnmnkxsztT8JlMmR8mE5KgEQJqHndKGEloxSywMJZSTI5FFEH5Fc9p0laH92aeOwiZ2n
 EbNA==
X-Gm-Message-State: AOJu0Yy7nap7PTkfMAiDCdRsCrAqPp5NSOHGuOxBS0wI+ijFrKEyE4sG
 PWQmczxjUIugXu0/1AJKOczgtowH5av47vZqyef59yvOai990qvs7PBF5uS+6D/ltm2YNGyEKmD
 W
X-Gm-Gg: ASbGncv2lsmyFWrDMQP5iUqndaxmT82M8UxvOvauA5IoaM2oIURMIGlY0vqJRRF3vgn
 r46lHJ5+FFL+p6uddlzgg2X2qX/84uOYN8VJRHxrKpVrnohShgXhYA+iFyXxXIv7JjRiJ8Swq1I
 PpXA/3YIK1sjjroKaQR7gnE3xEag+MNM5zpZ8e65UNXO2+b/bbEUCtIeHS5AHE7XQ10RW8dhbmj
 mw8zDbi1nnBggZHiugt9wK8KLzNP02J4ACG/YIteSe0TLNYmAipo+i1vB6cQjvLehM56x3o6vTw
 5QZvb4+IkOgvTajczILjJNs=
X-Google-Smtp-Source: AGHT+IEyq0mu/V60kpszp/HMnQ1xZvH6mFOfl0JR+5TEMVvX25Q3LHMqopvJqCSE5YqLUuLKDiic6A==
X-Received: by 2002:a05:6a00:3287:b0:725:456e:76e with SMTP id
 d2e1a72fcca58-72d21fb1d3fmr46965970b3a.6.1737049347010; 
 Thu, 16 Jan 2025 09:42:27 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72daba536casm263522b3a.154.2025.01.16.09.42.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 09:42:26 -0800 (PST)
Message-ID: <4471efad-56f5-4c64-8a96-f7edd6d1a0a4@linaro.org>
Date: Thu, 16 Jan 2025 09:42:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 01/13] hw/arm/virt: Remove deprecated virt-2.6
 machine
To: qemu-devel@nongnu.org
References: <20250116145944.38028-1-philmd@linaro.org>
 <20250116145944.38028-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250116145944.38028-2-philmd@linaro.org>
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

On 1/16/25 06:59, Philippe Mathieu-Daudé wrote:
> This machine has been supported for a period of more than 6 years.
> According to our versioned machine support policy (see commit
> ce80c4fa6ff "docs: document special exception for machine type
> deprecation & removal") it can now be removed.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/virt.c | 12 ------------
>   1 file changed, 12 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 99e0a68b6c5..3bb8a9c7bd6 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3606,15 +3606,3 @@ static void virt_machine_2_7_options(MachineClass *mc)
>       mc->minimum_page_bits = 0;
>   }
>   DEFINE_VIRT_MACHINE(2, 7)
> -
> -static void virt_machine_2_6_options(MachineClass *mc)
> -{
> -    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> -
> -    virt_machine_2_7_options(mc);
> -    compat_props_add(mc->compat_props, hw_compat_2_6, hw_compat_2_6_len);
> -    vmc->disallow_affinity_adjustment = true;
> -    /* Disable PMU for 2.6 as PMU support was first introduced in 2.7 */
> -    vmc->no_pmu = true;
> -}
> -DEFINE_VIRT_MACHINE(2, 6)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

