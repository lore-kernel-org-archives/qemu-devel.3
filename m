Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CCECA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmWT-0005H6-Eh; Wed, 03 Sep 2025 08:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmWR-0005Gd-J9
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:23:31 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmWP-0007Iz-Lz
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:23:31 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-619487c8865so1623443a12.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 05:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756902208; x=1757507008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/k+8rBSjGUJF9A4+Bn9MdIGi+Kz7W7DP/VPMUPug8Lw=;
 b=TxvbXH3QKlkYRojZWd7hfGewGW90JRaVszhcSLPO498U4ZJJZfB+Lc93Jpjso2qpf6
 05jDU9/RijPHASBYG52w49fH9WzsDkE83MXjxbElbmOZOVkXqX7vTgjwYmTKVpw8b9s5
 Il9vyOnlFPTiFd5nfKXr/CRt0VI/+UKphTK9N7tvFP9xPTWLckirQUbnSL9LyxUVgn4N
 e7ZET0CkdDgNNuhnU7MI5GPL5jidjmFLK1FSrMZWgLIQDLgC9MrvMsG+TVr0HF0vwVfT
 QqLv0C9Jlbkiu/m6a87y6CRsNV5rx5VaJFOrT0rQGJj7D6JiWwkRY3fBO9DyKFX3HB8J
 Ygaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756902208; x=1757507008;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/k+8rBSjGUJF9A4+Bn9MdIGi+Kz7W7DP/VPMUPug8Lw=;
 b=PkqrcFQfq/tDzUS/eCEXqSjvq1maJztTnmX5cPb4CgW5ER+FpAqcvs+gXLPjuZhkHo
 ZGeiRMafRMWF0WAxqTuLdpSdQMmj32EAAVJ40XIutdZUuUuSoiVE5J0gnM2yJBvv7un7
 qW3Rm1qFs4ePd4bzqDClGl9NT6kOs6SkHzTXZsq318YkB8o73ULLsbDFuNh9XWT8KZGR
 rkxFHird/la+vD9NhkUatlUkXtjudhIOC1aAgGsMcUDEJ9xmDFaOZFxMr9AqyX7n+HcW
 sOeGdkoKsg9QErITAnf6RHyyYuGnjImEe0BhCFJ7Sy4Ve22EPaD89vHFd3+bZSam2mh7
 0Zow==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9iOXlWKYwIRP4taLL+Eh5Lq92TTzPUotL8dACcrwAiJNAnKoe1Lbp9L0YqueDCg70w3fFsqXj+QZ9@nongnu.org
X-Gm-Message-State: AOJu0YwkAecbQJhbgWAipIkbNHyGV9aURzw2t7y+oyAZehnvFqBaBP3O
 IAPvTynxe49P8YYStT4StXZ4Ldbmr1Syxh+mJ9XCVv00SqUn8ogsULDAWEppUhnBeB4=
X-Gm-Gg: ASbGncsGkAxUawNVqz0pClVUIRyFoQPW8iRzkUSKxZeGDeVUJHtpOzC4+9xa6osHatq
 bt1iKknPINZ89dNYT2tcnnr/ZHJ77RUKB7llibhOxkrpL7f0RxaRHdBvwBfmHz6Bp//nyKr6us6
 CZRTVVTXxIgRZzYSuxttJDsvq9yDpXCv/PeoGN6454/thDCHeE0oTvl/fI7WXUyvjzg9JcXF6mg
 cb0EnU6t09z9z+6kpdaxpGnK3pUCjGtlqBeYoDdxr9nWH1wDRWu3fQM+4pFbHwL7yqGCtsx4Ual
 SDua6PF+Hh/tstYf3VfQ4Qnz1CsxE/qyvGYstmlGfs/VyHtarQ8ThMzvSqH5ytmp+iTsoznO3hi
 uz3E88pvQgz9jvDQMCNkGmwKbLc3kUUQOn3sfrMwbzsmTpAMWm8SQYN3mo44fCi/ua1P4E18=
X-Google-Smtp-Source: AGHT+IFg3UnH19w0F06rzJYm3pBdqa9kd1dutriLgj9UOASkQ5V1s1hJNOLIjQwhsSjvhxWcbBbf2A==
X-Received: by 2002:a05:6402:5c9:b0:61d:3447:9375 with SMTP id
 4fb4d7f45d1cf-61d3447a7f8mr13560148a12.6.1756902207758; 
 Wed, 03 Sep 2025 05:23:27 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc1c7edcsm12057998a12.6.2025.09.03.05.23.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 05:23:27 -0700 (PDT)
Message-ID: <5e6b598e-7fd1-47d2-99e1-dfcabc35b15a@linaro.org>
Date: Wed, 3 Sep 2025 14:23:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/24] target/arm/hvf: Check hv_vcpus_exit() returned value
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903100702.16726-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x532.google.com
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

On 9/3/25 12:06, Philippe Mathieu-Daudé wrote:
> hv_vcpus_exit() returns a hv_return_t enum type (defined
> in <Hypervisor/hv_error.h>). Assert we succeeded, as we
> are not ready to handle any error path.
> 
> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c        | 5 ++++-
>   target/arm/hvf/trace-events | 1 +
>   2 files changed, 5 insertions(+), 1 deletion(-)

Tracing change not mentioned in commit message.
Split to a separate patch?

r~

> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index d67372218de..65ac0bd71aa 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1086,8 +1086,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>   
>   void hvf_kick_vcpu_thread(CPUState *cpu)
>   {
> +    hv_return_t ret;
> +    trace_hvf_kick_vcpu_thread(cpu->cpu_index, cpu->stop);
>       cpus_kick_thread(cpu);
> -    hv_vcpus_exit(&cpu->accel->fd, 1);
> +    ret = hv_vcpus_exit(&cpu->accel->fd, 1);
> +    assert_hvf_ok(ret);
>   }
>   
>   static void hvf_raise_exception(CPUState *cpu, uint32_t excp,
> diff --git a/target/arm/hvf/trace-events b/target/arm/hvf/trace-events
> index b29a995f3d3..538af6e0707 100644
> --- a/target/arm/hvf/trace-events
> +++ b/target/arm/hvf/trace-events
> @@ -12,3 +12,4 @@ hvf_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid
>   hvf_vgic_write(const char *name, uint64_t val) "vgic write to %s [val=0x%016"PRIx64"]"
>   hvf_vgic_read(const char *name, uint64_t val) "vgic read from %s [val=0x%016"PRIx64"]"
>   hvf_illegal_guest_state(void) "HV_ILLEGAL_GUEST_STATE"
> +hvf_kick_vcpu_thread(unsigned cpuidx, bool stop) "cpu:%u stop:%u"


