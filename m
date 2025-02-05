Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8B3C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 21:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfmXy-0005Hu-Qi; Wed, 05 Feb 2025 16:02:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfmXr-0005Gi-Qd
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 16:02:51 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfmXq-00039M-6H
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 16:02:51 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso1243245e9.3
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 13:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738789368; x=1739394168; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kVTTRuKxiK4eclC7iB33EPkPJ9W261XxA792rlYhJ4I=;
 b=DZ4plyuHCk4Xj6Tq6Eb5nkUNVgU4o345nLA6CSmOQ2YunmZCPjBTHb4Kv1NEZTVbER
 MGTrahrGx9CVjPigBlne/fhrSJFMsntxVmO+weADFauy3h4sUYwZQNwaT9G+qtOYTQqL
 hyrhkYFfoR/IHFC5lwmLclo4Kx2A9WxVlvfdlLLPjwNn0ozK0hql38OuMyD8zfNTyaEK
 WWb/1OZNfWcdu2x2uBvijDYxHO2fV+5kzItDFl/qrhzJIOnlJM8RezzoXqN7wNjMtH9n
 tyJVoXp+GdNWJL9rjc71/iJFa/eJibJr3yqAgB5Bywvv1W86ROK18SoB743L87ZOAvAE
 87aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738789368; x=1739394168;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kVTTRuKxiK4eclC7iB33EPkPJ9W261XxA792rlYhJ4I=;
 b=DXn2wHvu1EmXqS3sll+9akpdNaU2hwew4fTS/0sucbVL+6G9VtlAxVfJ79s9R39557
 vOT197WiOQ1hE6T72d6BQMzq0mRS0wKC1JBS2otFHl0wnqPn5O3AnoU/MMqIu/0IkDH/
 ezal4b4H3mosxAhGthp3bhjJELviYk2yeeDiYKLdIp0hL+HTzNILv58lEj8Qvmtb9G5b
 QAHkDZP3ArpVtNgOzVDrm9gv1ZwA10CP3Q3c2kTH/oun6RgTuG7fiGqltAjkXtkzq0gO
 Nx8W+HIbvowAumPzmv1v8YnaLIUNuXQzSeXyAH5RTXJVrGtA/+CHQ1ZZMu0PHJBHZASO
 +Uqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdQj0tSioUse7QsPBTqO/k/96u4Zc1Me0z/gIQlXTos9xqtvJJBuTtQ3LhkAUBK6gkKD35eV5mAmbC@nongnu.org
X-Gm-Message-State: AOJu0Yy4tDe+gLJG0UQ+dxEupYjMq9lyuhrT3ac1YqPeHfDo/kEmTXTv
 PsbAi9XeFGxLvqrkZdr1nRRqoy32iLxaKMPrvIr0ELNGtnjBTQ4qPwkV3wQ3TBc=
X-Gm-Gg: ASbGncttqghd7MPlAALwKlJf7gGxurjIFaVwOS/txcZxgtFGZ56kMjRO6yuVGWM/5BN
 RlFJi/KcBkMEc12O3DvYXTPH6a7x/SXPvCQrvxWfqkcunSpLLByJENsd5gK/mjtVScFa7cU4CMx
 3kKGnGGTizlJLwoezuQJgIPYYXRgClFh7kEJutxH+9qZlQQlWcCkONhHh2qHVywI5CBJX/jc4G8
 Odvk8MQ9xE22tt5S2Dp4ASr+i5HgV0UlLX9m95PcQn/4BhpuJ7pbU7LJSfmn+6VpPTU6ialh7Hn
 10A3IzYFkLAk4rqW87niV02AKU73MtlGDnHFBTSqdCoGgotO+tY659agnRI=
X-Google-Smtp-Source: AGHT+IFTm7e/p+gCQ6rcKLnXGePmLjqvH1tKLKGI6n02NSO/EkLo+jiErptJIs3rfry/IvaFqw94cA==
X-Received: by 2002:a05:600c:4fcf:b0:434:f623:9fe3 with SMTP id
 5b1f17b1804b1-4390d43f12cmr43210915e9.16.1738789368560; 
 Wed, 05 Feb 2025 13:02:48 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dac89b519sm5559913f8f.100.2025.02.05.13.02.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 13:02:47 -0800 (PST)
Message-ID: <64671a22-a1d3-4d76-839c-287e5cf2390b@linaro.org>
Date: Wed, 5 Feb 2025 22:02:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] hvf: Add facility for initialisation code prior to
 first vCPU run
To: phil@philjordan.eu, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
References: <20241209203629.74436-1-phil@philjordan.eu>
 <20241209203629.74436-2-phil@philjordan.eu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241209203629.74436-2-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

+Igor

On 9/12/24 21:36, phil@philjordan.eu wrote:
> From: Phil Dennis-Jordan <phil@philjordan.eu>
> 
> Some VM state required for fully configuring vCPUs is only available
> after all devices have been through their init phase. This extra
> function, called just before each vCPU makes its first VM entry,
> allows us to perform such architecture-specific initialisation.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>   accel/hvf/hvf-accel-ops.c | 5 +++++
>   include/sysemu/hvf_int.h  | 1 +
>   target/arm/hvf/hvf.c      | 4 ++++
>   target/i386/hvf/hvf.c     | 4 ++++
>   4 files changed, 14 insertions(+)
> 
> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> index d60874d3e6..c17a9a10de 100644
> --- a/accel/hvf/hvf-accel-ops.c
> +++ b/accel/hvf/hvf-accel-ops.c
> @@ -442,6 +442,11 @@ static void *hvf_cpu_thread_fn(void *arg)
>       cpu_thread_signal_created(cpu);
>       qemu_guest_random_seed_thread_part2(cpu->random_seed);
>   
> +    if (!cpu_can_run(cpu)) {
> +        qemu_wait_io_event(cpu);
> +    }
> +    hvf_vcpu_before_first_run(cpu);

Could this be fixed by the cpu_list_add() split?
https://lore.kernel.org/qemu-devel/20250128142152.9889-1-philmd@linaro.org/

>       do {
>           if (cpu_can_run(cpu)) {
>               r = hvf_vcpu_exec(cpu);

