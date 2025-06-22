Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B92DC7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 03:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTB9v-0000rD-FW; Sat, 21 Jun 2025 23:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTB9t-0000qm-FL
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:14:17 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTB9s-0004Gy-2n
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:14:17 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b2c4476d381so2287606a12.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 20:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750562054; x=1751166854; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MUcVUHjGLbIIehp8UlYC5tIoXdAVuj8PsnbcIAYwVPg=;
 b=lZFR9vcF85WXdsK8HgBfGuaERKI+jtC0MLBENZJEHdmV/qampNcJwC9aKN3VcFmAXC
 xPFbbHmxxw24wBQk2LV1kKOvGWKZqWdKHRV8WyXV+wvb1D01/YKY4OqxUPrM7E3tHhCP
 F+qsTzNWETmgOx831adzIno/D8+ZB/UEPZhPg8/uKAedEW7Uopp2MmO8sbN2jtwinxFz
 nb2aJ+CeQ2I7r9vWLhnD3S4tSUsuFo4mRNrIxPiJfyWMa/VW8IlfDt2rcZbZAcSKDJJ4
 vuQnh8XAj+VPqqSgajaymf6/y7GIuPYAgn+yCIdeBRPUkyHW9ZmWCAHwVhMAGsmpKIVb
 Edww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750562054; x=1751166854;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MUcVUHjGLbIIehp8UlYC5tIoXdAVuj8PsnbcIAYwVPg=;
 b=ZO6MDthxOaqyNCBIXg7Ivo74Ebwie8/l4BUgVNxmOCnNRWV982GPD5nkTyNxHn4Mra
 TDoZ41NN1s2bRWvbupDLsGXfhIToPxAoQgQ15TwIEedQ9vZ0UCcWW/K5WMX1CWHDMmOJ
 xmbeD6YDsofIIcoVD0CJ7IoYyIn+H5PoodxcGrr/PaM/xmgoBzpFmdUQiTjvCDeRGTFc
 KyMU4U2W4lBZb5HO8AOBH3uVkHSgMrWD5YiPge1x9JTdOQuEc5tQb6ufXar/mdZGTumm
 3VqG4MTuXSMaxdzYYk2Dk2Ue/aUksdeysgSX2ftfnHgLheeZpo+r+Tgk/kVJertT1gX7
 bVPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQLBOPG8Su2ZGKw/DGnFRE2P/MFDjx48WqgAHYo5GaHl3t4nYPKLJtmB5b6lJuxboce258DxioM+Es@nongnu.org
X-Gm-Message-State: AOJu0Yxd0TPVqhVk5MTtwvQ5x1p7JrRsuyet+KaLws/knNS3FckiWSAN
 sLYScsw+sGsTsWZwYGBzarOygr1kBcGHL/M/IlkxWsiQZ3/7b4vBWlpDMG7lOJTOdBw=
X-Gm-Gg: ASbGncvCzbOe8AjyuGLkB5w/wB37NkeLsJL9qTc8XJbsPbIu6vRX6ZzX4dg4/Q4XdvW
 S6xVwUQ11AYZ7rbqmG2tg+/vWJIkQ5ZJbUQNVo0DsT7XBE/YF6h+bY4wfXg3ma4HKSsjainpdKK
 y3vYihrj+ctyTp7fjdqeIryLeNMKsZMwgI25UMMPBIs9Rd0M1PJWC5jukV5fQPOCWlhpk215tLS
 ACEfRe16DWjnw4xrY7AiMlKlJcrJ6P7kzZynkUSsHqp0JGDKufovNth2gnOn49QuQOQshmoYWaH
 BfceM6svYq80renC6NWKxZvqBQNQw9A9ViJD3S1uCZQn34fMxJCTxQhJwLYl5QyOv0LsASp1Fah
 kFnp616FIGDnJrOKQPWNDG06BNC81
X-Google-Smtp-Source: AGHT+IHhZ4YnWZlN2q8OzeX9uAluqiCwHNLJ2+NplsGDE01jHtmduIZs/lOnJ764NMfmqntJCIg/nQ==
X-Received: by 2002:a17:90b:43:b0:313:d7ec:b7b7 with SMTP id
 98e67ed59e1d1-3159f516c35mr11496129a91.13.1750562053773; 
 Sat, 21 Jun 2025 20:14:13 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3158a23e190sm7508644a91.13.2025.06.21.20.14.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 20:14:13 -0700 (PDT)
Message-ID: <826c2ef3-affd-46bf-9e98-799682c2fdae@linaro.org>
Date: Sat, 21 Jun 2025 20:14:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 28/42] accel/split: Empty cpu_thread_is_idle()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-29-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-29-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/split/split-accel-ops.c | 6 ------
>   1 file changed, 6 deletions(-)

Why does this not defer to the current sub-accel?

r~

> 
> diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
> index 034b5ebc96c..e1d91ace2fa 100644
> --- a/accel/split/split-accel-ops.c
> +++ b/accel/split/split-accel-ops.c
> @@ -166,11 +166,6 @@ static void split_kick_vcpu_thread(CPUState *cpu)
>       }
>   }
>   
> -static bool split_cpu_thread_is_idle(CPUState *cpu)
> -{
> -    g_assert_not_reached();
> -}
> -
>   static void split_synchronize_post_reset(CPUState *cpu)
>   {
>       SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
> @@ -291,7 +286,6 @@ static void split_accel_ops_class_init(ObjectClass *oc, const void *data)
>       ops->cpu_reset_hold = split_cpu_reset_hold;
>       ops->cpu_thread_routine = split_cpu_thread_routine;
>       ops->kick_vcpu_thread = split_kick_vcpu_thread;
> -    ops->cpu_thread_is_idle = split_cpu_thread_is_idle;
>   
>       ops->synchronize_post_reset = split_synchronize_post_reset;
>       ops->synchronize_post_init = split_synchronize_post_init;


