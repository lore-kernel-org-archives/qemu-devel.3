Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8628FE7718F
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2024 15:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRZ3J-0004bx-8R; Sat, 28 Dec 2024 10:48:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tRZ3G-0004bQ-4N
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 10:48:30 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tRZ3E-000459-Ir
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 10:48:29 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-219f8263ae0so61790875ad.0
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 07:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735400906; x=1736005706; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F+kqvBnI/ld5b8sF+f3mqrXtRvxrGQJQx+Fyoi4CE9s=;
 b=jc/oHrEOpoNlammILZIFSZ2a0soGLJWttqKvg0vG5ueFIRmCzG/Il4riBZXnnq6+sW
 b0McS4poijSap/bZu+94MXj5bEtx+Kr2KizHm7tAF4rLwxwoEOZ/6lKNkV4fjOSnOPhG
 V5O+6urwR+qXx8tYgcP9A0GKpozNAkSdV9hp5YJ6Tgy1EZ7LVBneuUGC3r+jN+W5pDBM
 55SA+/Y+HLVIjJMFMy+3QlqXeUnw7oLL8zEskx8wGRtGLZe2EKiSN5ijcE3bhy0iK3eh
 wYitfVXRfLy+zc6ek/az0VveWX0053zH+vuy7YJ6oaGIFHKX5HcUqQnzIe9Jch+vTtnn
 zkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735400906; x=1736005706;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F+kqvBnI/ld5b8sF+f3mqrXtRvxrGQJQx+Fyoi4CE9s=;
 b=BnoBaTkzq3/41jnU2E4JwKOek55tTwe6myniwA8DDGLPWkbb7XOxp/XzsLTo6DfxRh
 WeXI0HOEg1z2PjFL2azgztbg7n9rya/GI5DxepWmX18fpnW4onxMpo5SD6mIyfcxWiF4
 Qz5bIgEw0b8dbJsp7WYOkiaaTpJJTCdilcJhrWpHcoZqUVeLtq2hBMQveYTeZ6fJQitc
 O1tR7J4k2YdVMButNUyX4klbevmmNUPnkrutlsYVVTNGiLKvazYnpn2txQaDMNVt3HAh
 ZU2LisNThOeEyfoOBffTru6n9oLe7323s/j4XIkXq/MToc2EJ0PoLu698oyhhJXoAF07
 cPiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaCCHGKP4dwhGiCZkc/2KoJ63ZxHHSJj7mzRE/9vBL32kuefQFSC3QQCzeC2hUU4D+77yFKg6U7ua4@nongnu.org
X-Gm-Message-State: AOJu0YybHXebXCO1ltZXu7M0V20TD1rPHLxaFgoYcp5dxOo2dDDUhCNP
 x+lGiII2yk9vEiSPkUeS00fbIzMMzxZCg2v5MaoH2CpAm1k3xv6bV4A8nPmjQ2k=
X-Gm-Gg: ASbGncvO34QkfHUTufL0VTI466SnX0LKI0/ASGYI9AM8ZJcrb3ofpXdqhjgg9C+J1b2
 ttNHLL8/jrK9ZNRzgty9wx1wbjkSXbJce0ACeLtXfDYcva/VbHAxnjiy8f0QbUiOzBr9Wh3FfOI
 d5s40mWyxMvlCQCljJCpbi2xYpCm50S5O3f3koFNLR6Q7s7AMeU8EAjbOgR60Il3AJ8aGHdjKjS
 PLpAAXdpugLLT7XVehyl2RRFNRVduKb4kusM53SMKpXV/tszfjZuO0QfQeRjQT9hHwnpZ3XhyDa
 uytBcRg9G2A/tPO0mOpVmR+GL2XOalzOKRvMEbo=
X-Google-Smtp-Source: AGHT+IHdmQNkyvPlRvI9GFyexugwu5JZ6T78aVB9aa98+sgiM4Rx+ZtPwMxswXGaM+/cZUkoCVj9qw==
X-Received: by 2002:a17:902:db0e:b0:216:2259:a4bd with SMTP id
 d9443c01a7336-219e70dd108mr470798245ad.52.1735400905628; 
 Sat, 28 Dec 2024 07:48:25 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f4477c84d0sm17737643a91.14.2024.12.28.07.48.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Dec 2024 07:48:25 -0800 (PST)
Message-ID: <24fa3e1a-7ec8-4685-a3c0-46a3698924f1@linaro.org>
Date: Sat, 28 Dec 2024 07:48:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: Speed up hppa_is_pa20()
To: Helge Deller <deller@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
References: <Z2-nWcZ5l6oklIZW@p100>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Z2-nWcZ5l6oklIZW@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 12/27/24 23:23, Helge Deller wrote:
> Although the hppa_is_pa20() helper is costly due to string comparisms in
> object_dynamic_cast(), it is called quite often during memory lookups
> and at each start of a block of instruction translations.
> Speed hppa_is_pa20() up by calling object_dynamic_cast() only once at
> CPU creation and store the result in the is_pa20 of struct CPUArchState.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index a31dc32a9f..08ac1ec068 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -281,6 +281,7 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
>       /* Create CPUs.  */
>       for (unsigned int i = 0; i < smp_cpus; i++) {
>           cpu[i] = HPPA_CPU(cpu_create(machine->cpu_type));
> +        cpu[i]->env.is_pa20 = object_dynamic_cast(OBJECT(cpu[i]), TYPE_HPPA64_CPU);
>       }

This belongs in hppa_cpu_initfn, since it's internal to the workings of the cpu.
Otherwise,

> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> index e45ba50a59..c37a701f44 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -208,6 +208,7 @@ typedef struct CPUArchState {
>       uint64_t fr[32];
>       uint64_t sr[8];          /* stored shifted into place for gva */
>   
> +    bool is_pa20;

This placement will interact badly with your reset function.
Probably better to put it at the end of ArchCPU.


r~

