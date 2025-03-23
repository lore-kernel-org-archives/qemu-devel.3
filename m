Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74B7C36008
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 19:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twQmE-0001gj-PM; Sun, 23 Mar 2025 15:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twQmD-0001gR-1p
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:14:29 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twQmB-0006A3-Et
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:14:28 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-227b828de00so4464295ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 12:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742757266; x=1743362066; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sBgoBeLuNtfZnQHpV6zP6H2Y7aCSLgpraQG0ZX7Npz4=;
 b=hUUgnRekSeYcP+4f41skCWMBvq5VcALOKGbDCGjopGBCFfCGjF522BVEsoWfAVL5Lq
 CRUhhX2ITThocPqQTxc7+0/PZE4ZuO3gvF6l2E0qsl79f5AbPIwLQpsVNsPJ0EoWdTjo
 WQ0G8RkMCuaTr1gMNPnAOd3vHItqzJWjSQIEkc+0b0cLPE1bXLUMKWdmemPRkd59iMQ5
 GfeNxkgvvDKn+GJQQsMZOk5U4n4p1t75kN/lJZPerA9CyQKWepC0V3oT2Jhoj5eQnixg
 egLyyhlYhBSIryEj8tcpszMhIi9NVNAnIULQyGkbq0/sB+q5ww57Az7diUVAwCS2RiAJ
 Dfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742757266; x=1743362066;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sBgoBeLuNtfZnQHpV6zP6H2Y7aCSLgpraQG0ZX7Npz4=;
 b=IUxlMtNkkNTSuMVPzRYdFg9OsTxkJBaj5KInmK1WLMjI48rRn96hPHgbWwLCVekBBm
 NCtkNWPNrIdq6nSlnlR9v/3YcdKohDh81/qzsuPVzm5A868TDoGftEgmqk1Xzkd/oh5o
 EOMU0r0qPeFQMzFoB0v0Sd/M4myxRIoC4+5BGloPcZ+gaY+RGY74l3w9Gtc5bL6MvF1r
 HaGjbr8HjRr1XVXoE6LAdtj4qqWUsVgPJxOrpom3dvU788P2vheMIxdo2bfSbRBRMW65
 JYSzTqtMiiFpl0F1JejqoBhkDKo5thMlE4LjJo3O+OYod8z2aUIQfNaWNG2MMdDhI+sJ
 rk9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJiwsvYmSycpYWmkvy11GU1QULdJ8MtWuXWrxnlSyIW6Q6GXAeyhStD2UsORZ1jgc7wfVLuR9ZoPmO@nongnu.org
X-Gm-Message-State: AOJu0Yy73LVs435rHlY6MjoovgmX09iTMzjdDef6irmpVyUsiBJY38bE
 Th0JYLa6q6pZ386pfCfr6hpg539x4PWHsd0p+qp3E9fQb8hnfNHTBJOKFtpNM2E=
X-Gm-Gg: ASbGncv5EYjYpB1ujFrhzBnu+NnBj88Ud4g/KwQIF+EcMcsqbHdT1gWRiiuFxsbxeCw
 D8qzbahEGQuZxlkS7b/r0HCZHwviholnW9uIuOdH0yLeMAdh2bJ5S7dIFH9Xk0K6hVV9yTnKE+M
 P1lNa4hMXFeQixVonD/OLU19fcJUrFHtabnkwlu+uH0L62NyWkMJ75599cvO43URDavOsAPoOuE
 2A28gEI4ug+nYM5T4BGJgkrjG25rXhV4NK3Qm4BMyTFc//NJqaAGR4LsT3jvtcVQq1BFauH/rQw
 WDT8/utqfcoGKOb5LRr9nUboy2RIaTk1ymgtYZOkriegWOttSQar7uoz53UPD9lr5W2CblL5mAf
 aLz1J4gnZipHZyRjmB/s=
X-Google-Smtp-Source: AGHT+IHq89nsDL6kUvSB8RUTH39OPr/tTOsBJpxo5N6AqtJaIloN0lZwo7KDAE4w5s9VqtO/Glab1Q==
X-Received: by 2002:a17:903:1a2f:b0:210:fce4:11ec with SMTP id
 d9443c01a7336-22780c69ce3mr160371905ad.1.1742757265738; 
 Sun, 23 Mar 2025 12:14:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811f9a68sm55302125ad.241.2025.03.23.12.14.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 12:14:25 -0700 (PDT)
Message-ID: <25865601-e81f-4b89-bc72-0e8bb8195585@linaro.org>
Date: Sun, 23 Mar 2025 12:14:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: Remove duplicated CPU_RESOLVING_TYPE
 definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20250321184200.4329-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250321184200.4329-1-philmd@linaro.org>
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

On 3/21/25 11:42, Philippe Mathieu-Daudé wrote:
> The CPU_RESOLVING_TYPE definition was added in commit
> 0dacec874fa ("cpu: add CPU_RESOLVING_TYPE macro"), but
> then added again in commit d3ae32d4d20. Remove the
> duplication.
> 
> Fixes: d3ae32d4d20 ("target/hppa: Implement cpu_list")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/hppa/cpu.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> index 7be4a1d3800..8b36642b591 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -391,6 +391,4 @@ void hppa_cpu_alarm_timer(void *);
>   #endif
>   G_NORETURN void hppa_dynamic_excp(CPUHPPAState *env, int excp, uintptr_t ra);
>   
> -#define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
> -
>   #endif /* HPPA_CPU_H */

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

