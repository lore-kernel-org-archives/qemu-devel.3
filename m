Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9601EC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 19:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsRY8-0004nI-9b; Wed, 12 Mar 2025 15:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsRY4-0004iN-0O
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:15:26 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsRY1-0000tP-TB
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:15:23 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-391342fc0b5so142209f8f.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 12:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741806918; x=1742411718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=93oIOB7cTQHputsHdZrNesGvbdNwlP88xRy5tSy9OH8=;
 b=Bm4YJ5dNGSjxlBm3qtk0qFMA9E0L/gWmqkP/gKKONywi9sKNm9WcTp5XhgogH+xsbT
 U3vzvq4WmzE1UpNCmIajFL1VmJ79DIJN23Up+t1DCkxrsjATFlDJ9kkEGLJXOQ49A6Js
 ORxRXt2iOt5jXgjP3W/n4Pk/81Ux2t9qeDZd58PEiOSmu+d5w8LAoL/GiJ1TlOVs5E4v
 y9G6vJRGOnMzU9Qyu/Ax7rcstgpuDzQMkP7pOzNXozz7zhva3xztutS7CNW7rF6Ud70T
 ZT+ZWZ9F3AYT7l5gehrAMGyAm21Q1WQLIQfNNCr30+YvtxMWQRomGjpOKH4ee3DhQNVv
 lzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741806918; x=1742411718;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=93oIOB7cTQHputsHdZrNesGvbdNwlP88xRy5tSy9OH8=;
 b=gBcnRyDYVA1Xp5GDbTi/RNJQEW9tokVT2f7G16WfNfiW/PWyGzqob5ib2N+JhAy0bT
 6LF3rV2xZ+Uafl93NsfMOrw2AhYJBCroFTrdeZPYOItVPQc91zON48x3nQJd0R9AsOUm
 328zt2h/fEDIPGEO4IGFh6EW2w8pWBx218Y/NeHs1zqQHJWT7NXfeCVyLmxOOcvLkcf+
 d0GomLaJoQy2e4iH+B1B5i6O7bBwkhY2CNMt9BHfeDpg/7Sm9r9AtdNbRTR8FaJyEOSI
 YyDdNguue6xOzhz1McUhG5wh47VYN/qYvW2BkzckeaDhJ4b2dI6TosJgKGeyyIWBpac1
 m2GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3mqLrzuDGawFMfBemY/z1gQ3fGcTOHNUdY2Vg2DRtioqM50Dsj0TdLZcpulEjee38VPH09pXjIO6U@nongnu.org
X-Gm-Message-State: AOJu0YwiiD7/yuyDqBy+amqOYdZJNv6nLwr17nr+SE8bBzh1IO4DiX5e
 52SNEIc6LGZa/xbBnVVr7ibMtbJwOcN5vtQE7h1WnmauNl9DThC8xeFrVKgdv8U=
X-Gm-Gg: ASbGnctJRFvxRrMQtEt1tzzj/EarNrDduyVHbo4neUI0SHRyRwsDiasxr4bYcQtRfok
 uU77hGXPnuFhLzpEKTTgo4LyTVwgCm8cBhiLX9N0ueWN9aN4oxMA4EVWYpIT7yeObOG+pmeGerJ
 U/dMUrjBvRmK5KyIMEBZpOz/uDZtP74DpVXKxRWZrG4s+7bgTZFKJiYXFKPFsLqtX7FGNACDCPF
 gAyWwdpooJL2aC2JGHc9R9QngKSLQQDMIjZeKUsSiE+Dgdtao+cPjndtjWp77YinrXPhxtRIuCh
 dyE9IRpS+8nbDa/oQ8BjPyQXpRJggnmKywwpNtmzOysIjj54V0Rhat+00Ty45SyhFZTWgirZze8
 CQzSh6A9HwHWarR0=
X-Google-Smtp-Source: AGHT+IGDLubc5Jsbg0DMb/kfKa7F/rPy/oKqZGNvUeBRHAnzJr95sUpxYANqjie3DWvWdc27j+zQpg==
X-Received: by 2002:a5d:648b:0:b0:38d:e33d:d0eb with SMTP id
 ffacd0b85a97d-39132d093edmr21183191f8f.9.1741806918177; 
 Wed, 12 Mar 2025 12:15:18 -0700 (PDT)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2eafsm22449117f8f.68.2025.03.12.12.15.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 12:15:17 -0700 (PDT)
Message-ID: <802e6fe2-1c76-42c9-88ab-eb8239eef569@linaro.org>
Date: Wed, 12 Mar 2025 20:15:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/38] target/hexagon: Add guest, system reg number state
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng,
 anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-10-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250301052628.1011210-10-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Brian,

On 1/3/25 06:25, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.h |  8 ++++++++
>   target/hexagon/cpu.c | 17 +++++++++++++++++
>   2 files changed, 25 insertions(+)
> 
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 20ea0adcca..b7789a3c90 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -82,6 +82,14 @@ typedef struct CPUArchState {
>       target_ulong stack_start;
>   
>       uint8_t slot_cancelled;
> +
> +#ifndef CONFIG_USER_ONLY
> +    /* Some system registers are per thread and some are global. */
> +    target_ulong t_sreg[NUM_SREGS];
> +    target_ulong *g_sreg;
> +
> +    target_ulong greg[NUM_GREGS];
> +#endif
>       target_ulong new_value_usr;
>   
>       MemLog mem_log_stores[STORES_MAX];
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 0b7fc98f6c..355e1eeef3 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -288,6 +288,14 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
>       set_float_detect_tininess(float_tininess_before_rounding, &env->fp_status);
>       /* Default NaN value: sign bit set, all frac bits set */
>       set_float_default_nan_pattern(0b11111111, &env->fp_status);
> +
> +#ifndef CONFIG_USER_ONLY
> +    if (cs->cpu_index == 0) {

This doesn't scale to heterogeneous emulation.

> +        memset(env->g_sreg, 0, sizeof(target_ulong) * NUM_SREGS);
> +    }
> +    memset(env->t_sreg, 0, sizeof(target_ulong) * NUM_SREGS);
> +    memset(env->greg, 0, sizeof(target_ulong) * NUM_GREGS);
> +#endif
>   }
>   
>   static void hexagon_cpu_disas_set_info(CPUState *s, disassemble_info *info)
> @@ -313,6 +321,15 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
>   
>       qemu_init_vcpu(cs);
>       cpu_reset(cs);
> +#ifndef CONFIG_USER_ONLY
> +    if (cs->cpu_index == 0) {

Ditto.

> +        env->g_sreg = g_new0(target_ulong, NUM_SREGS);
> +    } else {
> +        CPUState *cpu0 = qemu_get_cpu(0);
> +        CPUHexagonState *env0 = cpu_env(cpu0);
> +        env->g_sreg = env0->g_sreg;
> +    }
> +#endif
>   
>       mcc->parent_realize(dev, errp);
>   }


