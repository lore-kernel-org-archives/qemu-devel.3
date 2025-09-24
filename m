Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60456CAC5B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 12:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1OOO-0002qp-LB; Wed, 24 Sep 2025 08:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1OOD-0002b5-Mi
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:14:31 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1OO7-0007GC-JC
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:14:28 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so29101365e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 05:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758716058; x=1759320858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UYsB8Eri/EE7M3fVD2dzBWmjHjSazmhrYsNLnMAEpCI=;
 b=iTOteq0x5jH7n5QYaixSTun9G5FUZZCU7heeljcWtbagHOlC8LojNSPm6YODWh0f2s
 vCf68eQjRgmwgJ47J04tULqBCDdaeGczkNpJOJZAeZA/q0fze9khZ1ZddRjaUoMm0Q14
 Ao7FIo1R7mvZ5Sf6sAIrhSUQg3avZBwGjJp/zVLU/E9AA7gSaAU5+nw6SMg2tlYQyrE5
 9QrKvlkRoDqSPAYQUMoaNLkwCQdHODqTm86P+RNHySAbsTYKHMVOvTAduWk8mcFEsOrt
 Jl5h3ZHt34hgt7+T41zByyhpZMlMqeQEwbIFBU3LAcdl37WB6+S5QVfY9sP2+KwNazfM
 bXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758716058; x=1759320858;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UYsB8Eri/EE7M3fVD2dzBWmjHjSazmhrYsNLnMAEpCI=;
 b=ehG6/95dnsKL8dDJ8GKhT5mXdjO0YHtSV9FpxAmISlE2oyfM3oGXeNrojLAyLEWCJm
 SH6O+Em9OJV8D6Jz6RZ2TTxD+WOI2ieSFDjEQpA4pq2WvtBiRtDHJzAACkyhbhAVLOxk
 iTil/KPADhbhYNEpu7oB11PRniyT7+nI2l7pG9LxJZUS9HOYMCwalEoY7BcXACEXzJyH
 XiPlSJHqS9OzX6oa1ZAfUfobDDSysnftbvokDu+LFVVyK04lIQ/kWkLZ9jEErKt6eNEH
 77SRiVB1rUbD97bW+TDlfZGzR/FQSGGVv52X9Ar73oshR/StYdYAIVT38VxkOi5iiJag
 d96A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIg8TixRV6tWmPyDT6sgA0AgDVzTgumG/hDzYOeorN9m8wNcUA0txME9JFMiOgVEjuzI5akvW1BHJs@nongnu.org
X-Gm-Message-State: AOJu0Yxxxrk5UOqAfNRrtOhh5ewcIRFLIldrxjCkUvZuI9Vbuu5LRmF9
 WS92WYWROd5ZzGPS7rIdB3WWWN/h2pA9cdsa/AI9Xe/P7/6gut0kP4FQaGK1kzqGY60+buVBkBy
 8k3SyqWewpQ==
X-Gm-Gg: ASbGnctUlxfbiUMp0rnOLMh8Uly+JjRBpNdmuSVWye2qAEid+cRl2FCsf1WPIdrY6cs
 fu12FvgYcUqj81g0L9cbBzMS4Y7H/5jECWLI3B+GYebNBPpu6Q5yZUbXMUfS0MLPiIK4B2kmr/h
 bR1DZDHHS+YQyP22ebH45rN+ONMDwonV3CugdKruBD5LdVuQUAzIbqrW23jcaWckmwNabVR8Ffg
 C+n8XG//Hl6TSPVQIZHKUSZ+CpwDK+qkhln0LCYD7nWkxT00JHQxf+4aGyQawKtCztBEHP25xOz
 OGGqFHq00FjrD6AK1DPfXL+h/rrXR+LKvDwWWS5Gdx6/YlQDMjdk02eOcF1P5jn9zODtOjTQTmq
 YcVjrECqhEUoGv9wzmQCBcR3n3zl5foZGy+ygQtUFaen5CGeHbfTBeZVynWVBjddNPw==
X-Google-Smtp-Source: AGHT+IESa5o1x3Y4x8p09nQ3EU99+mUIvaOF7WGh1z9ASs1ZyYa08fjvbCaieadQIoIRWjfz7xxpsA==
X-Received: by 2002:a05:600c:4e88:b0:45b:615c:cd2 with SMTP id
 5b1f17b1804b1-46e1d973c78mr76941825e9.8.1758716057686; 
 Wed, 24 Sep 2025 05:14:17 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a9ac5basm37056605e9.7.2025.09.24.05.14.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 05:14:17 -0700 (PDT)
Message-ID: <6ef7e6e1-9ac1-466d-b4bc-332e135c258e@linaro.org>
Date: Wed, 24 Sep 2025 14:14:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] accel/tcg: Improve tb_flush usage
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250923215425.3685950-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923215425.3685950-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 23/9/25 23:54, Richard Henderson wrote:
> It is too easy to mis-use tb_flush().  For instance, because of
> the cpu argument, some parts assumed that it needed to call the
> global flush function for every cpu.  It is easy to forget that
> the flush is not complete when the call returns: we have merely
> queued work to the cpu run loop.  So: remove tb_flush and expose
> only the core as tb_flush__exclusive, to be used only when we
> are already within an exclusive context.
> 
> In some cases (gdbstub, alpha, riscv, ppc spapr),
> we can eliminate the need for tb_flush completely.
> 
> Changes for v3:
>    - Rename to tb_flush__exclusive_or_serial; retain the serial
>      check within, not updating to exclusive only.
>    - Rename the existing tb_flush to queue_tb_flush; retain the
>      sequence number check for duplicated flushes.
>    - Drop EXCP_TB_FLUSH.

When using my split-accel branch, I had good results with v2.

I'm getting crashes with v3:

Termination Reason:    Namespace SIGNAL, Code 4 Illegal instruction: 4

Thread 4 Crashed:
0   ???                           	       0x34400fb00 ???
1   qemu-system-aarch64-unsigned  	       0x100fd74dc cpu_tb_exec + 160 (cpu-exec.c:441)
2   qemu-system-aarch64-unsigned  	       0x100fd829c cpu_loop_exec_tb + 32 (cpu-exec.c:897) [inlined]
3   qemu-system-aarch64-unsigned  	       0x100fd829c cpu_exec_loop + 904 (cpu-exec.c:1009)
4   qemu-system-aarch64-unsigned  	       0x100fd7a30 cpu_exec_setjmp + 48 (cpu-exec.c:1026)
5   qemu-system-aarch64-unsigned  	       0x100fd7954 cpu_exec + 496 (cpu-exec.c:1052)
6   qemu-system-aarch64-unsigned  	       0x100ff9bc4 tcg_cpu_exec + 44 (tcg-accel-ops.c:97)
7   qemu-system-aarch64-unsigned  	       0x100ffa4c4 mttcg_cpu_exec + 28 (tcg-accel-ops-mttcg.c:146)
8   qemu-system-aarch64-unsigned  	       0x10140bdac split_cpu_thread_routine + 540 (split-accel-ops.c:87)
9   qemu-system-aarch64-unsigned  	       0x10158f7e0 qemu_thread_start + 132 (qemu-thread-posix.c:393)

Thread 5:
0   qemu-system-aarch64-unsigned  	       0x100fb04e0 tcg_out_ld + 160 (tcg-target.c.inc:1268)
1   qemu-system-aarch64-unsigned  	       0x100fab3f8 tcg_reg_alloc_op + 240 [inlined]
2   qemu-system-aarch64-unsigned  	       0x100fab3f8 tcg_gen_code + 7932 (tcg.c:7018)
3   qemu-system-aarch64-unsigned  	       0x100fe9e88 setjmp_gen_code + 184 (translate-all.c:257)
4   qemu-system-aarch64-unsigned  	       0x100fe9780 tb_gen_code + 364 (translate-all.c:324)
5   qemu-system-aarch64-unsigned  	       0x100fd8138 cpu_exec_loop + 548 (cpu-exec.c:980)
6   qemu-system-aarch64-unsigned  	       0x100fd7a30 cpu_exec_setjmp + 48 (cpu-exec.c:1026)
7   qemu-system-aarch64-unsigned  	       0x100fd7954 cpu_exec + 496 (cpu-exec.c:1052)
8   qemu-system-aarch64-unsigned  	       0x100ff9bc4 tcg_cpu_exec + 44 (tcg-accel-ops.c:97)
9   qemu-system-aarch64-unsigned  	       0x100ffa4c4 mttcg_cpu_exec + 28 (tcg-accel-ops-mttcg.c:146)
10  qemu-system-aarch64-unsigned  	       0x10140bdac split_cpu_thread_routine + 540 (split-accel-ops.c:87)
11  qemu-system-aarch64-unsigned  	       0x10158f7e0 qemu_thread_start + 132 (qemu-thread-posix.c:393)


