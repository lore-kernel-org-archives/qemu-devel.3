Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E704CCCFA1A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 14:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI60X-00040Y-B7; Sun, 09 Nov 2025 09:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vI60V-0003zq-KV
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:03:03 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vI60T-0004HV-RI
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:03:03 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-640c1fda178so3771055a12.1
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 06:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762696980; x=1763301780; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qrzRzagwL5bDzaG+Q6n8d2EmVX/zdXfhaUymKGnA4no=;
 b=ro25RNUrxECsyvrlmXemtQ2HEewg764nJtd0D3hqMRvbj3MEVzL3KjPlIZFRmxXrM8
 3h5urrlYJH2w//QKioDw9QHfAaTf2ZNXkqF2XnpkChx2q/6TGBlv7zoIjSxAbFufih8p
 E9Fhswve4ylu8HrrFaS9JmGGWjhXqVaLqmSW2GMZnkQjigK+6/XOO4nH80bXwAIb32gR
 AopHQgdKIM0fC9ThhtzGF+ZpcVVa28kVm03HhDLUweVbdGfGu/GgoXGhVrZzt5upSX4i
 KDzP1USBf9S/EILu4eIPDpOKvPrgCf8TZtW13uCCPJDGt5p+BQosXcEW0Xjzwu0rjvOj
 stFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762696980; x=1763301780;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qrzRzagwL5bDzaG+Q6n8d2EmVX/zdXfhaUymKGnA4no=;
 b=akFMjwNf/Oxa1b+ammo+9NMdGw9qEioBjJvYRQmoggVbGrVjwkrxQm5q2hwVVvEsVf
 aECCChFWWvEVm+qrPiZdx+GXbu7uOjOXjqJS9oiyOG47E4T9pacPOvGzqvqjzdS8OcLn
 pFpuWDw4Qe0SgmSkwPHpNy9HeL0U4hCfTbABCRNb0wJYuDArAcMQ4pOeE8vgV9gWUmkd
 wWJmUuEi1GFuFYpDwnqUJsyiRX3H+L60sBTLo9yJqn52BteK1hhmu4Gt3RgL8y69wYju
 bcRZuOTxKTiuJOj+wkz7oNr+nVdoZ9mpoy0kuHDVjSYDXzVIurNJTSgYMGpwAwBs34jk
 dEHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu4DMMMXyQmZ45J2IhFM3Sfb9y5U011SiFSdWH4Mfy5956q1rr766VqEwOn9w6T5PhlwvJCdkg4U9G@nongnu.org
X-Gm-Message-State: AOJu0YyckdU0w4CV2+HhVum+S1l0NJCflT8AcI8Zn4Ubl/GrQnD3+4eg
 ry8AQXzgXpDcy+31sartMeaNcbj/S0gE5gwDgKu+FOF+KAPI04FKNOMNZzwCDDlkc5LthdIFKtD
 njBpi651h7w==
X-Gm-Gg: ASbGnctK2B+6aAUY9KchnCO3+dvbYCtqWX29ILiB3nkgXqc0cBhizAY3GSnP9S1TiIv
 /Wyes9+auPAKA8F6kt3L1MhYUY/eNoWEfhSGT2iQ3vTaymTmmaeGMh+VmpWETk1zhdaA+PFGOQO
 SJaMYjnqMnLlGaygYBJtmVJhaqR7edNbRfQZAQZHZBOA3zmPDJ2RVQmEhL6S8m1pmZO2YJefY8+
 K/85p7BSz2/IoRegig2t0Zb6Y/WGq2HL+Kp+z/BWibrYFi5XcnFttoAD9ELYURuwxovWLZOCkTc
 XuDvWmjWInVKrZDFDYKWYc206lESLasOonVxeQUo5nhxy5TPxobdENZ0p595M/+9TdpR0MtZPM4
 G9vb4jSN+u1bvXGN/VXQJUioUK4s/sM+uiWGGk+rhcOe/aCpnsHMRSFruiLoAa22JFWrxXqlrSn
 Gijv8n695avvaRCOwlrGqxjklkzRsdtld5NZSjC090A3qDPF0=
X-Google-Smtp-Source: AGHT+IGFrG+0SGct9sPrlQHR8mNgW4nZ51qGGLpTPn0vGMz3Ll04Cd9+nYA379cCRViML1SwWPjExA==
X-Received: by 2002:a05:6402:278e:b0:640:d184:cf0e with SMTP id
 4fb4d7f45d1cf-6415e6edba9mr3940713a12.21.1762696980423; 
 Sun, 09 Nov 2025 06:03:00 -0800 (PST)
Received: from [192.168.2.7] (tmo-086-152.customers.d1-online.com.
 [80.187.86.152]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6412a27d68dsm8119554a12.9.2025.11.09.06.02.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Nov 2025 06:02:59 -0800 (PST)
Message-ID: <29b2e852-f273-4c2a-b356-4380775d8f54@linaro.org>
Date: Sun, 9 Nov 2025 15:02:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] target/riscv: add the RISCVCPUTimeSrcIf interface
Content-Language: en-US
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>
References: <20251107102340.471141-1-luc.michel@amd.com>
 <20251107102340.471141-5-luc.michel@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251107102340.471141-5-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

On 7/11/25 11:23, Luc Michel wrote:
> Add the RISCVCPUTimeSrcIf QOM interface to the RISC-V target. This
> interface aims at replacing the existing env->rdtime_fn callback in the
> RISC-V CPU env. It allows to query the current number of ticks, and the
> tick frequency.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
>   target/riscv/cpu-qom.h     | 34 ++++++++++++++++++++++++++++++++++
>   target/riscv/time_helper.h | 16 ++++++++++++++++
>   target/riscv/time_helper.c | 13 +++++++++++++
>   3 files changed, 63 insertions(+)
> 
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 75f4e434085..e5bc23b2ef5 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -58,6 +58,40 @@
>   #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kunminghu")
>   #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
>   
>   OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
>   
> +#define TYPE_RISCV_CPU_TIME_SRC_IF "riscv-cpu-time-src-if"
> +
> +typedef struct RISCVCPUTimeSrcIfClass RISCVCPUTimeSrcIfClass;
> +DECLARE_CLASS_CHECKERS(RISCVCPUTimeSrcIfClass, RISCV_CPU_TIME_SRC_IF,
> +                       TYPE_RISCV_CPU_TIME_SRC_IF)
> +#define RISCV_CPU_TIME_SRC_IF(obj) \
> +        INTERFACE_CHECK(RISCVCPUTimeSrcIf, (obj), TYPE_RISCV_CPU_TIME_SRC_IF)
> +
> +typedef struct RISCVCPUTimeSrcIf RISCVCPUTimeSrcIf;
> +
> +/**
> + * RISCVCPUTimeSrcIf interface
> + *
> + * This interface is used by CPUs implementing the sstc extension. When the CPU
> + * implements this extension, it must have a time source to implement the sstc
> + * timers. Devices implementing this interface provide a monotonic tick counter
> + * and the associated tick frequency so that the CPU code can compute timer
> + * deadlines.
> + */
> +struct RISCVCPUTimeSrcIfClass {
> +    InterfaceClass parent_class;
> +
> +    /**
> +     * get_ticks: get the current value of the free running counter associated
> +     * with this time source.
> +     */
> +    uint64_t (*get_ticks)(RISCVCPUTimeSrcIf *);
> +
> +    /**
> +     * get_tick_freq: get the tick frequency of this time source.
> +     */
> +    uint32_t (*get_tick_freq)(RISCVCPUTimeSrcIf *);
> +};

Thanks for the documentation :)

> diff --git a/target/riscv/time_helper.h b/target/riscv/time_helper.h
> index af1f634f890..b51fdd96570 100644
> --- a/target/riscv/time_helper.h
> +++ b/target/riscv/time_helper.h
> @@ -26,6 +26,22 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
>                                  uint64_t timecmp, uint64_t delta,
>                                  uint32_t timer_irq);
>   void riscv_timer_stce_changed(CPURISCVState *env, bool is_m_mode, bool enable);
>   void riscv_timer_init(RISCVCPU *cpu);
>   
> +static inline uint64_t riscv_cpu_time_src_get_ticks(RISCVCPUTimeSrcIf *src)
> +{
> +    RISCVCPUTimeSrcIfClass *rctsc = RISCV_CPU_TIME_SRC_IF_GET_CLASS(src);
> +
> +    g_assert(rctsc->get_ticks != NULL);
> +    return rctsc->get_ticks(src);
> +}
> +
> +static inline uint32_t riscv_cpu_time_src_get_tick_freq(RISCVCPUTimeSrcIf *src)
> +{
> +    RISCVCPUTimeSrcIfClass *rctsc = RISCV_CPU_TIME_SRC_IF_GET_CLASS(src);
> +
> +    g_assert(rctsc->get_tick_freq != NULL);
> +    return rctsc->get_tick_freq(src);
> +}

Why inlining these functions? Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


