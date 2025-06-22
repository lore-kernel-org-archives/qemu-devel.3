Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14B2C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTAsc-0002nQ-TO; Sat, 21 Jun 2025 22:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAsb-0002n8-0e
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:56:25 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAsZ-0001cN-Bx
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:56:24 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-235ea292956so32151455ad.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750560982; x=1751165782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BqVw1YhJ8J4nsACOvjA2k+hoN/n4LMN5gEZ93VGxhWk=;
 b=uWW9fKdygAnmAEtKWbKM1HwJvdVsV3Rr/oneKepVWvMNU4by7kTxFztLrtuLuENSfx
 KIO0+SMYNKOoI5Jc9JKgMtTX371oVL4jg8hEkICJYQMqQbbLv1jz1nua1xz7T7cmZIjs
 Ih1J5gs4XBNL1bFyXiLXGwU2GU/ilk7IUJbW5uD4W3sf8vrt8K/jTHQcC/ojWpgDGgvU
 JKv5OIwqVR7x8cdb5etzGVILQsfHaIhQFaHkIEmN8+mtLf84n7Bj7v9bal+yZTmK+Tv5
 XUnPjEQxWCu4em3/iuU644BfcSQoiTznmycM0HDdX6aIl7Trrrrl6oCh1t7prmySJpSx
 rTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750560982; x=1751165782;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BqVw1YhJ8J4nsACOvjA2k+hoN/n4LMN5gEZ93VGxhWk=;
 b=Y3hNa66zNZ//XTS7RrCq2iHxkf2JQXydwwHXVeFgidzqAApdsGPlCuA3fD5Jn/EsB9
 qovDv+YbWhfgoCJq2s7+EmPeu4B3KB7no1NM/kOUcCAIWjDWURN/cdRe08ZMpaNRmH2d
 Di4MU/AnnoCwAa+vTZvLG79LFlzzO71fGbd0MsSQPAdirIUiW/qUHV9xQuTG6CfgM8LD
 LSe0qXWDsQMUPwXkqVbVPTqpuydlna034ajzqI8MDk9+ZmPWWfccMOeYywlxriAK6tZq
 1r0M2DKHtwSrdg1+inql6gZ795MM1cQ5T7N8BPcWNLo7O00FgMT0F4geCagWJ7ge+O3V
 YfsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb0DWZHEsFOQOnzL7nnzxvZT/jDbBmrXlm/i/xkNHvTvuoe/A5EMhE8oaCM+ObnlfpAQ2cNToANLHu@nongnu.org
X-Gm-Message-State: AOJu0YxiIpfJ+dDz4zzbBG6rsD7q81Ne0uirl03kpxSR6ZMcMGfAIpSH
 Dwk6i03ABpuXJephuQldnbJl3oyqduz9vSJwvERocbRrA8lKyU9FWSGpViWnwjDraQw=
X-Gm-Gg: ASbGncvjCFOMJoBqRawoj3KeN0JYqlBU9X6fobsicHL45b56RHmKiP10YXEMC/42gFM
 d/Zl8l20948iVP7ezD+Ow19nRE9oLReSDFfUV52LBHdTBUjdYHD6AVfXB0ScPJtytO0BCsmFfft
 JwG2aHavjigZn33sgPUik+C4GKK+JseHbT9JPDokMK1oNxYMy3HnXe4mSzS8+eyOJgNx9iMztsz
 OIlUxMYCzw6qtZOcd1f0sCRi4VYB3r2N53l0wCpfIlj2o8z4cmcEsyDP5I2WVCnN7dUgr0xq98d
 WmeTLMw8exbnlXVtr5RRXN+imy8hwE721idYl3Z901vrujAsYQvW84iJvcx9KMjp8/m3q/afZFB
 FULmbnCVXcNzDyPWv6SQxNH3Tu2a0
X-Google-Smtp-Source: AGHT+IHdMRLyFHJ9TAenTPBSL3y+kIYOEwS/bTywEyi4qfaZY9Du3lipGdaqCzjRI5WhWJFCYgLdMw==
X-Received: by 2002:a17:902:f690:b0:235:2375:7eaa with SMTP id
 d9443c01a7336-237d9881119mr122174405ad.22.1750560982018; 
 Sat, 21 Jun 2025 19:56:22 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d83932dfsm51480315ad.30.2025.06.21.19.56.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:56:21 -0700 (PDT)
Message-ID: <8503360b-92fa-48bb-ac01-048e456ef963@linaro.org>
Date: Sat, 21 Jun 2025 19:56:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 19/42] accel/split: Implement kick_vcpu_thread()
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
 <20250620172751.94231-20-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
>   accel/split/split-accel-ops.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
> index 746a6a2782d..63b6217f3fa 100644
> --- a/accel/split/split-accel-ops.c
> +++ b/accel/split/split-accel-ops.c
> @@ -136,7 +136,13 @@ static void split_cpu_reset_hold(CPUState *cpu)
>   
>   static void split_kick_vcpu_thread(CPUState *cpu)
>   {
> -    g_assert_not_reached();
> +    SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
> +    AccelClass *ac = cpu->accel->use_hw ? ACCEL_GET_CLASS(sas->hw)
> +                                        : ACCEL_GET_CLASS(sas->sw);

Move the ?: inside the ACCEL_GET_CLASS?

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> +
> +    if (ac->ops->kick_vcpu_thread) {
> +        ac->ops->kick_vcpu_thread(cpu);
> +    }
>   }
>   
>   static bool split_cpu_thread_is_idle(CPUState *cpu)


