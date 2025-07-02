Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F25AC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWzFG-0006KG-Oy; Wed, 02 Jul 2025 11:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzFE-0006JR-EX
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:19:32 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzFC-0007H0-FB
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:19:32 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-61208b86d75so249496eaf.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751469568; x=1752074368; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WTsLyO0G+AS4guPqcwiOrYSY2CPwjFSsqC8+z1aGmFE=;
 b=KTjhRrZ+/8IAUw2lM8HtC6x3TopTfCkCwfvNu8iXAQPWF+notfIul2bgNiwpT5mAMt
 /JbJr6WUiXwmyq1Z8PJuj1OLv2eBSkk36AjC//6bXbT5CLqOMGfjTO+x2AumKCmuyXGg
 OxrQbx0f1FOeNqYJv1lkYPi9VuormTNy0odUtUl9AlnWSBqTvytHApP+3ZwkFXVcjNzk
 0A07YUgcl2dpJ2q7BuhJ9R/AVtmO8FyCbNQHrxT8LtMnVm4RTbstflNRVNfFwAit7SOY
 h/b1jO/TsXItlO/34ktBR/OhjqatRu80wWjeR3ihEdxEBTfq+4Ap1rStDJsXSZ4XtnDe
 R5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751469568; x=1752074368;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WTsLyO0G+AS4guPqcwiOrYSY2CPwjFSsqC8+z1aGmFE=;
 b=ZDp+JrkVUtB2Rq/cHVkF/LQLSOv1mPD1IidCy6G5ihexIqB2cR5ADgT6EqBCk8Xp2F
 PqsIrLOw37TBhsSSE90jCqI/CJJgpaOjAHU6bRvcD91cep8Xu6KEwEsU1fwpIiSJ35sq
 okxZTzlK2W85M0fZNxN2d+L7ydI50JVl71HYFBO3BPtS5HhZQyNS/zwQBkOa1eJqoH7x
 9B3oRWZhHaNAoaSThX6BwvGX9Ez4kKPDmylw3YNWeGtZf++eaSV2zUMBC4msmaxD8tzm
 msxGX9PQUxcOvy11kNZsn47/N4oNnVMvPVGjLp5SUcrTcr65EE6iYzw8sL0HzW8TvvNk
 dJLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+a8khsj9Do3t/xMqcAB0REP6Xbyrg9AJHJ22NyjyAupceZkXRaH/JxbcZuPJ+TIuSUZw4U1PyKPRh@nongnu.org
X-Gm-Message-State: AOJu0YzWtBOCdSlV1iloCQr94bGQ6tlNUkTVPbuJ+/QQ1jfIsx/0SGT6
 GuIDjXs0BuZB95TbN4pLlxwSPAHXc+DZ2nxqe53mpLR5YrHKf7IF8z0C4bwu9w7D4/s=
X-Gm-Gg: ASbGnct27HOWJFF0xrJM8waP5CR2IX1zVmCwwf+mFvmKIjV3tV74ElSjAaad4t+4Ujv
 BB7e3GR+137irtP7zpW+nsEo0rjDvdTaBFJ/CzR0fkSiWkJR9ISk27i/+HaNBlmiRmNh9uaCiPZ
 eUyfdJVy22rvmeWSClBAd3yZpqgyb3lEpgyC3dz//tmZR4d8qWlwzMIDIporouaSKxObvhht1bG
 4B5bk/ep+zUeOCJnXnClnXDt8WUYhH8Gh6FWadSsTtvVJwd+BtKOX6Tzhz1/OuCmNRWjPPCU0Zw
 uLdkGvwBJXem4XzHjjOwVmccLOl6TCpV37G/C88LYAW2+Kwoj+J225mDYZ24hKyjR2MpESdrlBy
 r
X-Google-Smtp-Source: AGHT+IFZTnJ2iUrYX2K2LLFudjrnECRSm26AbC1cGVKgStjwyDcT28xMeFqoA+OdQ51C+yfxiSt5NQ==
X-Received: by 2002:a05:6871:6183:b0:2d4:ce45:698d with SMTP id
 586e51a60fabf-2f5a8d29995mr2404318fac.4.1751469568112; 
 Wed, 02 Jul 2025 08:19:28 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd512f0cdsm3904294fac.46.2025.07.02.08.19.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:19:27 -0700 (PDT)
Message-ID: <89ceef1e-c4c1-45eb-a369-a17f711ef4ad@linaro.org>
Date: Wed, 2 Jul 2025 09:19:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 57/68] accel/tcg: Expose vcpu_[un]register() for MTTCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-58-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-58-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

On 7/1/25 08:40, Philippe Mathieu-Daudé wrote:
> Allocate ForceRcuNotifier on the Heap.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops-mttcg.c | 30 ++++++++++++++++++++++++------
>   1 file changed, 24 insertions(+), 6 deletions(-)

Please document the motivation.

r~

> 
> diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
> index 4de506a80ca..2d31b00ee59 100644
> --- a/accel/tcg/tcg-accel-ops-mttcg.c
> +++ b/accel/tcg/tcg-accel-ops-mttcg.c
> @@ -55,6 +55,27 @@ static void mttcg_force_rcu(Notifier *notify, void *data)
>       async_run_on_cpu(cpu, do_nothing, RUN_ON_CPU_NULL);
>   }
>   
> +static void *mttcg_vcpu_register(CPUState *cpu)
> +{
> +    MttcgForceRcuNotifier *force_rcu = g_new(MttcgForceRcuNotifier, 1);
> +
> +    force_rcu->notifier.notify = mttcg_force_rcu;
> +    force_rcu->cpu = cpu;
> +    rcu_add_force_rcu_notifier(&force_rcu->notifier);
> +    tcg_register_thread();
> +
> +    return force_rcu;
> +}
> +
> +static void mttcg_vcpu_unregister(CPUState *cpu, void *opaque)
> +{
> +    MttcgForceRcuNotifier *force_rcu = opaque;
> +
> +    rcu_remove_force_rcu_notifier(&force_rcu->notifier);
> +
> +    g_free(force_rcu);
> +}
> +
>   /*
>    * In the multi-threaded case each vCPU has its own thread. The TLS
>    * variable current_cpu can be used deep in the code to find the
> @@ -63,17 +84,14 @@ static void mttcg_force_rcu(Notifier *notify, void *data)
>   
>   void *mttcg_cpu_thread_routine(void *arg)
>   {
> -    MttcgForceRcuNotifier force_rcu;
> +    MttcgForceRcuNotifier *force_rcu;
>       CPUState *cpu = arg;
>   
>       assert(tcg_enabled());
>       g_assert(!icount_enabled());
>   
>       rcu_register_thread();
> -    force_rcu.notifier.notify = mttcg_force_rcu;
> -    force_rcu.cpu = cpu;
> -    rcu_add_force_rcu_notifier(&force_rcu.notifier);
> -    tcg_register_thread();
> +    force_rcu = mttcg_vcpu_register(cpu);
>   
>       bql_lock();
>       qemu_thread_get_self(cpu->thread);
> @@ -121,7 +139,7 @@ void *mttcg_cpu_thread_routine(void *arg)
>   
>       tcg_cpu_destroy(cpu);
>       bql_unlock();
> -    rcu_remove_force_rcu_notifier(&force_rcu.notifier);
> +    mttcg_vcpu_unregister(cpu, force_rcu);
>       rcu_unregister_thread();
>       return NULL;
>   }


