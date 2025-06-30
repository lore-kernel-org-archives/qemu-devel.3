Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C623DC8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 13:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWEv1-0000XL-Kb; Mon, 30 Jun 2025 09:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWEut-0000Uo-MB
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:51:27 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWEur-00039H-BM
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:51:27 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-40791b696a2so1531476b6e.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 06:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751291483; x=1751896283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yh5AkopwGV2I3q0B20LJV8uY+repWzJWZusRt50kNOs=;
 b=AkNbcZEMkJXDcPclQm+bUd61yevpo5OIg8ISVBn913R/z0ObdufXdSXYy315uCSI8V
 taIu2EuXKB1b/uS6qm4Kwu1mdbGveyXyO1ttBRGqRVO/xd+/VrGwtxYDbYtazxkN7PZr
 H6CR3HI2SzyLFZoI4AkyfgudJ83sI9J+fh9mjqhCvRXQU3X06xcfo3pehk0AUxdqUO/f
 M0etOARwJRYNJqwEAgnzHkW85emKfTwJhxmlV2AtXA/x19RPga3QfMrnQvpzkpChHa3b
 RxlvsVy54CGRt95hEso6h8KaGfxXyh4uD7dWGDrw2MqmWTX7RYjWKggtLlFVdUM3Nxt9
 4qCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751291483; x=1751896283;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yh5AkopwGV2I3q0B20LJV8uY+repWzJWZusRt50kNOs=;
 b=xJaxtGpEEC5nLCPx3DJmyOpdsTQFBQIw28Kp4rf0eMPdwmX4zwdmQdTWrriDcplUrO
 ieY2g4VjD05934dd+jqikgJeCQxoTGqzHMw601AOiKHLRpNOdZB/QprHvfYehFTbhw70
 L7/WHikgqVsnj8oCUWdBd8G5aDrNX6Jz9M/1h1D+k3MSxTNruSe3v9nXANFxsHsP3WDX
 qI3TN3hnmBP77Kak0lY/4GylTbKzPXXuKq8d+qAclaIdB8bhxCeEMiTWKOo2EMhGtyfO
 hYAKJ7zKMuHDDgg50FG3Q9GKN2gW3T2t3nqE6kwgVM63AZsFsI8eGMT54zNcIMzEPXGp
 pqgA==
X-Gm-Message-State: AOJu0Yzz+gA+4eMOZxL5s4YV8mmkhZb/b5gHC/HrG4ldSq1qBRwFA/5g
 XchaCt5R7QCp61X7afZiD9DMRWgHihOfiy0swlMdTMs728X4Gd0vFXr88ejBktCk6ROdQrZjNZF
 y+WpJ
X-Gm-Gg: ASbGncufrvxCgG8lpW9Z04H1Yn9e6JPuUysv6fscsYKQJmxFMweWYRz0qGMZsT3Suhu
 ncglRnj09ya+4oeL326E1V4I/cueypr3nOjH0IU1PY/VA3Dk5dXB8+cw5FUmO0bh6gpUfbzgF+6
 pEnNdRJjh+xQRSp8gd7ysGf44hng/rNI5RdPEksDsqw4I3Z4JCUfwPWVYo4RKsW08z/RbUhxP1i
 0/62CNz4k4Z9Ugf6EBVYrOSdsVq3mJuBORZgJ63PFQ2z1LaCFhpf0K6GrMiuIjsJUdq7fGU5r2L
 lGJkVl5qvv7g8JJjwqj78oo/1zUY3HCGAM/o7hvU2fz4GpblTYdViT2iL4zhOUF+UnerSKSMuKI
 i
X-Google-Smtp-Source: AGHT+IGy2TMbB5bvobN5AqoT8434E4di8+UAZjraudcu1cvpoOHGH/3tQIhxXDV8i/7I5QbSgiImmg==
X-Received: by 2002:a05:6808:1921:b0:40a:ba8b:ee61 with SMTP id
 5614622812f47-40b33c5d605mr10358205b6e.10.1751291482789; 
 Mon, 30 Jun 2025 06:51:22 -0700 (PDT)
Received: from [10.25.7.25] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b3241e38csm1688826b6e.34.2025.06.30.06.51.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 06:51:22 -0700 (PDT)
Message-ID: <fc2f3f7c-1778-44ed-a455-74a9bae2d86d@linaro.org>
Date: Mon, 30 Jun 2025 07:51:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] target/arm: Only allow disabling NEON when using TCG
To: qemu-devel@nongnu.org
References: <20250630130937.3487-1-philmd@linaro.org>
 <20250630130937.3487-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250630130937.3487-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

On 6/30/25 07:09, Philippe Mathieu-Daudé wrote:
> Only allow disabling NEON when using TCG.
> 
> This avoids confusing user experience:
> 
>    $ qemu-system-aarch64 -M virt -accel hvf \
>                          -cpu host,neon=off,vfp=off,vfp-d32=off
>    qemu-system-aarch64: AArch64 CPUs must have both VFP and Neon or neither
> 
>    $ qemu-system-aarch64 -M virt -accel hvf \
>                          -cpu host,neon=off,vfp=off,vfp-d32=off
>    qemu-system-aarch64: ARM CPUs must have both VFP-D32 and Neon or neither
> 
>    $ qemu-system-aarch64 -M virt -accel hvf \
>                          -cpu host,neon=off,vfp=off,vfp-d32=off
>    qemu-system-aarch64: can't apply global host-arm-cpu.vfp-d32=off: Property 'host-arm-cpu.vfp-d32' not found
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index ab5fbd9b40b..b6a8ba83a46 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1810,7 +1810,7 @@ static void arm_cpu_post_init(Object *obj)
>   
>       if (arm_feature(&cpu->env, ARM_FEATURE_NEON)) {
>           cpu->has_neon = true;
> -        if (!kvm_enabled()) {
> +        if (tcg_enabled() || qtest_enabled()) {
>               qdev_property_add_static(DEVICE(obj), &arm_cpu_has_neon_property);
>           }
>       }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

