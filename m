Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E323E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkfr-0008Ki-EY; Thu, 12 Dec 2024 10:00:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLkfn-0008KS-Dv
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:00:15 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLkfi-0008D7-Dt
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:00:15 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso5002205e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 07:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734015607; x=1734620407; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=noZH218afOaeqdmBzsiIKuURTCNx89ZE151jIj8wsVA=;
 b=ocA6zodaATbOX8DRhts4kLDPDEp4ATvNLykK2oZFPGewy/hAsNlIxOmfSwwd/TddMO
 WOYc5bzObS03XuHqowQQRET6aLRWGn7FiTscpO8cw0ApyTB0/KIXznc0+ibR1SXF+BnM
 2aj+/lTGJmvik2W39pUzoFTiOQtW3GvAqHPLghfZAiecG+0hqfAp58GmWjabmwji73dt
 Eb71vfY3290a3BDs6mHpUQom6HW0sIAz3D1wNUV6LmMW9MSlJG+iE5Dqv+TuPWXeOmsi
 JxlsG4+/RwDHwi/GPx/qCNnpwSxzLDkIRA7XlrP/ixJcaMzNwmXD+IX0JMRkyK6wlWKP
 8AZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734015607; x=1734620407;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=noZH218afOaeqdmBzsiIKuURTCNx89ZE151jIj8wsVA=;
 b=B5sn/qfAvYF+C/KSqO2DjtcGzPKxA/GJK2z/0V6bBa5F5KADA7X9K0uaOPD4jO7mVJ
 BpQEW953QKfqT6heuPnM/WhSaMrtAMWYG852HrHTN4OisT3XC4sdoWNF140mDb0cGxMi
 m94qBXt1S3+dJt5JlB46aaXRQpIJLjlRLxmjh1fmjAc5dCAaY0G8V/enG6EQFpxDjDXd
 ENwWoZt+muBDdXfLV9+plNgyl7XDcpJHqG0ldR2Fi8CSeEki9/kdH/pvUj6sFMZaMqkA
 SeFXa5h96tvmiujrzsS+8GIzYQfBfLFVKDIgkkHnVbDpPhU3CmgY0GnZ/ULdscatbfHF
 D3Lg==
X-Gm-Message-State: AOJu0YwOOn9LS6tDQ97xMwZbKSFSwTh6QJthINQyb0+z/4h5JTlaclD8
 RyHbvulhv0YywYm8I7xVh1UC0oNAQJlvxMbuFLd6vEj7ECAo5PLYvgpV6SSUfHJswgJyOwZRgk/
 8
X-Gm-Gg: ASbGncuAJJGY+AmBW3MSjdiRrdP43S3FUXynD3xOYFpLgdxhVu4RYHR3xs/roza3vR1
 JIT0CgYOtXBKVXQz3clEMm1Xw9ifZJouuk3oE4H/68MkPVfhGNiqYH1UjGGUDHi/oSwfcA6+lGr
 5jk5K0bFvZZs+qywKLuVk2PhWilRrJFXHrCFrp1rmK3zVSCruwwxp6sSp960iO9ROgd9LDZwFS3
 64FQcxtgE9djFabrFHOum/wzrEw+urnzSyEf8kjUhaB3lAaDiMmTT6YmliazU/Lq+eIihshpzWh
 GLVA1Q/VtKtRu80kNrivUKYw
X-Google-Smtp-Source: AGHT+IGGvy8X0cdtTSS9xwQfXnEGKNe0+7RgEhvuCfxCpDJbHTSEx/aC1bfeYVuo7E04Fkf+oqbXkw==
X-Received: by 2002:a5d:64ed:0:b0:386:2ebe:7aeb with SMTP id
 ffacd0b85a97d-3864ce937d5mr6901431f8f.44.1734015606751; 
 Thu, 12 Dec 2024 07:00:06 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878248e633sm4398671f8f.4.2024.12.12.07.00.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 07:00:06 -0800 (PST)
Message-ID: <fa492acd-9fc5-4c90-9441-aee632c8c511@linaro.org>
Date: Thu, 12 Dec 2024 16:00:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] accel/tcg: Move tcg_cflags_has/set() to
 'exec/translation-block.h'
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241212144430.66224-1-philmd@linaro.org>
 <20241212144430.66224-2-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212144430.66224-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 12/12/24 15:44, Philippe Mathieu-Daudé wrote:
> The TranslationBlock flags are defined in 'exec/translation-block.h'.
> tcg_cflags_has/set() and curr_cflags() use them, it is more logical
> to declare them in the same place. Move them there too.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/cpu-common.h               | 6 ------
>   include/exec/translation-block.h        | 6 ++++++
>   accel/tcg/cpu-exec.c                    | 1 +
>   accel/tcg/tcg-accel-ops.c               | 1 +
>   accel/tcg/watchpoint.c                  | 1 +
>   linux-user/mmap.c                       | 1 +
>   linux-user/syscall.c                    | 1 +
>   target/arm/cpu.c                        | 1 +
>   target/avr/cpu.c                        | 1 +
>   target/hexagon/cpu.c                    | 1 +
>   target/hppa/cpu.c                       | 1 +
>   target/i386/cpu.c                       | 1 +
>   target/i386/helper.c                    | 1 +
>   target/loongarch/cpu.c                  | 1 +
>   target/microblaze/cpu.c                 | 1 +
>   target/mips/tcg/exception.c             | 1 +
>   target/mips/tcg/sysemu/special_helper.c | 1 +
>   target/openrisc/cpu.c                   | 1 +
>   target/riscv/tcg/tcg-cpu.c              | 1 +
>   target/rx/cpu.c                         | 1 +
>   target/sh4/cpu.c                        | 1 +
>   target/sparc/cpu.c                      | 1 +
>   target/tricore/cpu.c                    | 1 +
>   23 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 638dc806a5f..bdeb9d68f32 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -187,12 +187,6 @@ void list_cpus(void);
>   
>   #ifdef CONFIG_TCG
>   
> -bool tcg_cflags_has(CPUState *cpu, uint32_t flags);
> -void tcg_cflags_set(CPUState *cpu, uint32_t flags);
> -
> -/* current cflags for hashing/comparison */
> -uint32_t curr_cflags(CPUState *cpu);
> -
>   /**
>    * cpu_unwind_state_data:
>    * @cpu: the cpu context
> diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
> index b99afb00779..c1e48a48aab 100644
> --- a/include/exec/translation-block.h
> +++ b/include/exec/translation-block.h
> @@ -153,4 +153,10 @@ static inline uint32_t tb_cflags(const TranslationBlock *tb)
>       return qatomic_read(&tb->cflags);
>   }
>   
> +bool tcg_cflags_has(CPUState *cpu, uint32_t flags);
> +void tcg_cflags_set(CPUState *cpu, uint32_t flags);
> +
> +/* current cflags for hashing/comparison */
> +uint32_t curr_cflags(CPUState *cpu);

Per this comment I suppose accel/tcg/tb-hash.h is better for
curr_cflags(). Also because it is internal to accel/tcg/.

> +
>   #endif /* EXEC_TRANSLATION_BLOCK_H */


