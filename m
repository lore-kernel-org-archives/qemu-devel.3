Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0D9C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9emq-0007dm-Vk; Tue, 29 Apr 2025 02:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9emX-0007bh-VF
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:49:36 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9emU-0001A0-Sh
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:49:29 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39c30d9085aso4095218f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 23:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745909364; x=1746514164; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=elsPi+bnJ27NpgFB+2H2ab3o5UsW6U1n6EIhMXMY8rI=;
 b=wR6mRz1q0CETh71H3ih1mtx1UkwTzG5g5ON9V+rz1zcrt0AYyqE1kYetffoRI1Vspk
 gdjhmeyqpFP9aDznrrmWQmnaDRhi0gW7flpcI4VdCD/H3fnHMX5EZnkECy84i1MjcYjB
 FEv/PNO7xn48eYh1y28ZYfOCrLrJqiBXYvCMZ6laW7Gx4vWcJg5IqDpt5vR1OIaAdX01
 Y3GT0dxOAdd6W8J7aF1HOdtZKVKNgK8eP1LrKsUbK5QpaEpHjyeziBsnRp6RMXbPArt1
 QcP0TF2eMlqIT0WksbqqpuIHR35rJUTHXbb6Rxk1R2UX0xFI1lK6+Bw+q9rx4PVYOrot
 yyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745909364; x=1746514164;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=elsPi+bnJ27NpgFB+2H2ab3o5UsW6U1n6EIhMXMY8rI=;
 b=YpYsKhQz35dApK0cHk1q3jBKJGs9a07AEiN0C7kaUHM/XXGQNgL1LEB8c68zJqMsKF
 50ItfCUEcu/u4OYWybqsgyabu4AaomdWcWwrLKwvxb4Fi4ysPifYaQ4+5HquPXoBN9ON
 oio9V6cq+otoj/RJhasQMyzlf0iF/7rMUCBstGG4WH3RgrHTsOCiaNKELfonqZohQb6j
 2Z5+HNXcie4Beqvdu0IX5j5FY8YTZR49iStYRTBRf3Xz7XAPD4QN30h6j/k8aX1o+B54
 v5SrqhZkaLzRrabgcTyYbjc89V4RqI0brVT+2GE8dyjg0syLpe99hc26DkctUUztdy0E
 d4Ow==
X-Gm-Message-State: AOJu0YxrfQdzkdWJeYmwU08z7QMes9h4FUTKUAZp71HTozackJ5C++HQ
 cRHNQtHgRWqSR+MDT622SjbALJw/biqatJj4RZyn26rAIw4utmq6WTiQ7lKHVUk=
X-Gm-Gg: ASbGncsO9T1rc+j1MwcobKYcKSarK5KOiX3MvQPDiVBUC2ycVxxgQ3JQsgeFIJ+QZmN
 OiLyJYKoeguM0Cps3xTJ/dxdp8i+KqHyfK2+l0YbWaAHkrEabdFMxLm8m0BVt2zEFQRV6FuWEPw
 10NYkdfadb37AoetP8J7wXvMKI7TIp0N3bsg0pudHy/BI+/uQ/B3Ybmcap9sz2x62v8Siaf3uky
 Rg7ArD2qh6MtzVNgfT45gIPVc/YlMzDYZXdAkgaYZzcYroiMFj9G16KN982qL+CgHrkHQGV4OOv
 9EmpWUv6050k3sV/xTb1Udrmzfm5wM/Spa8I78c2M0m3jiXu3I/aPf1v//zqpGVqhXz/etIRdlG
 mnv+0PiFK
X-Google-Smtp-Source: AGHT+IGHR+w2ORv8MTY4hnF6bvpEAKyj9/hM/Of+5dnEne8XQYmj2k4TsrFrdcJbYcaUA+zzP0EXQQ==
X-Received: by 2002:a05:6000:2c5:b0:3a0:8a3e:cafa with SMTP id
 ffacd0b85a97d-3a08a3ecc12mr1636091f8f.33.1745909363822; 
 Mon, 28 Apr 2025 23:49:23 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5c82fsm12917352f8f.85.2025.04.28.23.49.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 23:49:23 -0700 (PDT)
Message-ID: <dd3e17d0-0005-4f8e-b049-ce8b3fa5406f@linaro.org>
Date: Tue, 29 Apr 2025 08:49:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] target/ppc: improve checkstop logging
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
 <20240521013029.30082-3-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240521013029.30082-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

(merged as commit 9728fb5c22a)

On 21/5/24 03:30, Nicholas Piggin wrote:
> Change the logging not to print to stderr as well, because a
> checkstop is a guest error (or perhaps a simulated machine error)
> rather than a QEMU error, so send it to the log.
> 
> Update the checkstop message, and log CPU registers too.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   target/ppc/excp_helper.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index b2b51537b7..17bf8df9d7 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -430,17 +430,19 @@ static void powerpc_mcheck_checkstop(CPUPPCState *env)
>       /* KVM guests always have MSR[ME] enabled */
>   #ifdef CONFIG_TCG
>       CPUState *cs = env_cpu(env);
> +    FILE *f;
>   
>       if (FIELD_EX64(env->msr, MSR, ME)) {
>           return;
>       }
>   
> -    /* Machine check exception is not enabled. Enter checkstop state. */
> -    fprintf(stderr, "Machine check while not allowed. "
> -            "Entering checkstop state\n");
> -    if (qemu_log_separate()) {
> -        qemu_log("Machine check while not allowed. "
> -                 "Entering checkstop state\n");
> +    f = qemu_log_trylock();
> +    if (f) {
> +        fprintf(f, "Entering checkstop state: "
> +                   "machine check with MSR[ME]=0\n");
> +        cpu_dump_state(cs, f, CPU_DUMP_FPU | CPU_DUMP_CCOP);

CPU_DUMP_CCOP seems unused.

> +        qemu_log_unlock(f);
> +    }
>   
>       /*
>        * This stops the machine and logs CPU state without killing QEMU


