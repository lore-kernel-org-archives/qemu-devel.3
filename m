Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372E6C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 05:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXvjA-0002RU-4x; Wed, 15 Jan 2025 00:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tXvj8-0002Qb-9C
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:14:02 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tXvj6-0006Fh-J4
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:14:02 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2164b662090so109072115ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 21:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736918039; x=1737522839; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+/wkunj/yJbOnuXe0UdLmAlLrPhzDZ4YeY/oldOSZK4=;
 b=NlFgXOrlS9N8bLnziqsa/Q3sCcpPtOOf18eYTreQfJSboMPMDFMOLC1FLJ1Yx8BFDV
 iFDFRO4hboqtPVMpaN5eUAvZpY0Sx73wlMYvEyVyvCD8BDQsGLq/GZxY4b+JUoZUd9C/
 8py8NZNxquSsX2A4VDRiPgHd1uVpWUcHo79zr7whJjv82zoL3JmMv4rQVVBwnFpeqViv
 4aiUFurtuNg4uTpZXKcgGiZRaxoMCFEi5hhv7FMOszfOpQwGceUgmAC46EhrmcuCBO6i
 zBQNSWmVubq1eS3WIeGIn0QqoRKawks31Dlee4w8+IdGWivSnMtv3h1xdjXX9QvwbW81
 tV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736918039; x=1737522839;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+/wkunj/yJbOnuXe0UdLmAlLrPhzDZ4YeY/oldOSZK4=;
 b=oy5gbq3rykPmwADgrMyzTTnR1OS8xEMPzn/Jky7PkIVJ7miJRuwAXCEW2e9Ae10qLd
 THTAWes4ckbFIrCEWRsE00cGduMxr7kNioHP7/Jm64KNPBnX8rm+pXjlhXiRXTkDCGED
 afMUCPOvUMi3IyFM8m+CQzTFZZNXz0uWA42D2I5uYbBFA113KKNNw8fFoU8LK16ciSz/
 zggCUYuUVKzOJaWrzwDJsTpdZW3OpntKeXsNs26HxSLM/g4aV/FERY9OvaRY8fNvUnD2
 mO4dSjqkogOuWRhpVgUg/R8mzdjl1hhCDYICWik43eOGGj2nYqsbE9u4L5zkiJkc/Q6f
 u9cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWpWt5aX7E/rlRFQkIp6ZktdbX7SvcwfIu39tJuZAU/Bl0upZEa7zKWQ7XIzpMYgFDZCWbDk2t3tr/@nongnu.org
X-Gm-Message-State: AOJu0YyL9QWtZdHOtzZNRBWKZIAVwFK1qVy9alm30hbQ9AYeCHhCqbjO
 XSKuY++Bv2xXUYfHXR4XNgo1bYQOXbZtuHOZaDGo2/QQZKgWT5PenMgcnw+xi9w=
X-Gm-Gg: ASbGncsMyQTJrM+h8N7KERWlXFupWXB4Oe6Wr+CXbgg4xuHwMAGTk4sV12I/sqzdTmX
 tEdnzL0E+TnXfSQMTmaNby/E84rIbWrGHCFYtdEgQnjzvlhUXOVyIJl3QPTtqLlCMyC4jbpRbuQ
 U/0FpKskwDMuwnF4Qr3qv2Es3zxjCTrIHffVuJH9DxfOVWWqO5hR0okHoCZScoQdBII78rd4QPa
 3XF658TOUaYBqT1gLKmkbnzc7UKYZXd5qaDGFeeyLJy5vCiztGuKTqvwK+wYvHvH4AOPMv1/JlS
 n7RhGwQi08lZ5zW+2uB3hz0=
X-Google-Smtp-Source: AGHT+IFfqEG4JgRiSyNe3B7W8dwoQew9UAl5dkHTrEjoD6noqRHWRuVwwskTtKfr6P2ELNYGFDQ0fA==
X-Received: by 2002:a05:6a00:410a:b0:72a:9e3c:920d with SMTP id
 d2e1a72fcca58-72d220583c7mr40580893b3a.22.1736918039251; 
 Tue, 14 Jan 2025 21:13:59 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d40658c4bsm8483403b3a.100.2025.01.14.21.13.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 21:13:58 -0800 (PST)
Message-ID: <11c1037f-272b-4fe9-a733-44d797d60b84@linaro.org>
Date: Tue, 14 Jan 2025 21:13:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] hw/mips/loongson3_virt: Propagate cpu_count to
 init_boot_param()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250112215835.29320-1-philmd@linaro.org>
 <20250112215835.29320-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250112215835.29320-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 1/12/25 13:58, Philippe Mathieu-Daudé wrote:
> Remove one use of the 'current_machine' global.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/mips/loongson3_virt.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> index af1937455b0..a240662016b 100644
> --- a/hw/mips/loongson3_virt.c
> +++ b/hw/mips/loongson3_virt.c
> @@ -173,7 +173,7 @@ static uint64_t get_cpu_freq_hz(const MIPSCPU *cpu)
>       return DEF_LOONGSON3_FREQ;
>   }
>   
> -static void init_boot_param(void)
> +static void init_boot_param(unsigned cpu_count)
>   {
>       static void *p;
>       struct boot_params *bp;
> @@ -184,8 +184,7 @@ static void init_boot_param(void)
>       bp->efi.smbios.vers = cpu_to_le16(1);
>       init_reset_system(&(bp->reset_system));
>       p += ROUND_UP(sizeof(struct boot_params), 64);
> -    init_loongson_params(&(bp->efi.smbios.lp), p,
> -                         current_machine->smp.cpus,
> +    init_loongson_params(&(bp->efi.smbios.lp), p, cpu_count,
>                            loaderparams.cpu_freq, loaderparams.ram_size);
>   
>       rom_add_blob_fixed("params_rom", bp,
> @@ -645,7 +644,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
>           loaderparams.kernel_entry = load_kernel(&cpus[0]->env);
>   
>           init_boot_rom();
> -        init_boot_param();
> +        init_boot_param(machine->smp.cpus);
>       } else {
>           filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
>                                     machine->firmware ?: LOONGSON3_BIOSNAME);


