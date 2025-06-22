Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E58CC7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 03:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTBF8-0004CI-Vs; Sat, 21 Jun 2025 23:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTBF6-0004Bk-LN
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:19:40 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTBF4-0005kC-OG
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:19:40 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2349f096605so45749855ad.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 20:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750562377; x=1751167177; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rs+nJ16yplWIHdhrFfBNE1ckxbQ68iJhsh2DxaI6VzA=;
 b=GF+wXP57vn6RKqCxQ5o0T9kx09lKJE69eAi7q7WAjrvcr9zTdwxUSg3z8i45NZ1/rY
 x7jVTIYZSvpiiKpUjGYVoW/J7QaZkXrQW3RYj+kJGUbXfeKH5k5pLO6ZzdKIVKwE6rkF
 8EltG0CNiLA4R7Sbkv4pnX3LtSK+IKcaqLS5f6jQDpHeyt+jjFB7+7QFzUIK5I/iTxJ2
 paAnDfKS3bOzyq5kRuM/6DWXPrPpfIznO9Pi6osb0uIL+GPOGd2O3RwT8kv5WEQUG6og
 5gtqSnudpfE9E0dZV29p80QajFOF9a3KNQvBtKTZsm9zJGpoaMapCVLTEenJfzSkhjvG
 Hlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750562377; x=1751167177;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rs+nJ16yplWIHdhrFfBNE1ckxbQ68iJhsh2DxaI6VzA=;
 b=dWJ/mpFXGPI2rh/l2gD7p0yfzcjnBaaWddEslJIaKQqW2UAOauY6M0IGONTTeJ41Bv
 x5TMmQa+0LQ2yR8fgkea6VjtITCatWfdI2xK3kmgBDudR1NjnkWTjw6jVWYNyTSvJqPp
 B3c1HGc8ls3fjEUf79mfAzTPBicnO0MFS/Asm4bqu8/HE64YqaQArCPkQNLi0RnFA0c6
 ID/Xo0v4ZYTzNpW7JXVeRuk5BPMDcsDuNFwLF8Lyxm/CX5pdFFijjAPqUaV9R544M+Vj
 DTljxRqeRIqolQ95+KWnJ0Nsk2mZ9GSsBLsyDWZwX5vv5h9e4yltiR/VqNt8InuACfZQ
 uhuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJsfdx0zjDxAyTIt7q2POtH6M09fDG8ExEsdLNFaKW2ma28e6jEsZ4dvoKTk75Az36tdEabwQZloKt@nongnu.org
X-Gm-Message-State: AOJu0Yz3SU49gCrdep8iP3H7IQ1t3OSLScNoBmH4vhiKgRQMJOEryLZd
 yr46yENGNZGQ9UFTd3KZU40Y0agVxevXm5AgsjfPlDRwnV9CNHEAeUlnohrhRbpFu8I=
X-Gm-Gg: ASbGnctQ097Ep6QPApTbWv7KOlMLsbdXs9kQxaUAr5LCuk28/C+40pNyAhABf5BhVg2
 +E4jjlLQtwPjRcRYZTMc5scrKWKvn6qyaax+dxjLFH2UU2KdeSIxyxjgxcXHhL0c/3qwY1aJRmW
 MBFMrl4L1WbSOsN4ZRvk3zFZ5+SuM8yLPQCbYV99WoMtFSARu94h18OhHBNg/MvRRsf3MCfIouU
 jc0ENSuZeDDoeBwMsw0x7OY43al/oO3cHqiHu8rcFitO1KQBMo7pWtGW7ZQdU9EepDvINhjKmsf
 xs1Z1cv0UCSihpVisGFnbqkU2qD7Via3HUnZIR/c2I8Gtgj94rEeW8qjlEhH09FX03E3Lku+DpW
 ax5Bb+HvG4Y4naXJTTbPsdeiOXX5C
X-Google-Smtp-Source: AGHT+IG+lS2jsjE0Em6/8VWrSfHR3H2l5k/O6wxFcds8bi40GvA6MTVUFIrntrAKP+ik0OfCZ4MfJw==
X-Received: by 2002:a17:902:d58d:b0:235:ef56:7800 with SMTP id
 d9443c01a7336-237d9917c20mr109461485ad.30.1750562376791; 
 Sat, 21 Jun 2025 20:19:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d866488csm51066475ad.158.2025.06.21.20.19.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 20:19:36 -0700 (PDT)
Message-ID: <b1d14fe5-7aa9-4966-b7fb-9143b45303e3@linaro.org>
Date: Sat, 21 Jun 2025 20:19:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 34/42] accel/split: Implement get_[vcpu]_stats()
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
 <20250620172751.94231-35-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-35-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
>   accel/split/split-accel.h     |  5 +++++
>   accel/split/split-accel-ops.c | 24 +++++++++++++++++++++++-
>   accel/split/split-all.c       | 16 +++++++++++++++-
>   3 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/split/split-accel.h b/accel/split/split-accel.h
> index 8a2888507f3..80a19bbb1e5 100644
> --- a/accel/split/split-accel.h
> +++ b/accel/split/split-accel.h
> @@ -36,6 +36,11 @@ struct SplitAccelState {
>   
>       char *hw_name;
>       char *sw_name;
> +
> +    struct {
> +        unsigned transitions; /* number of HW <-> SW transitions */
> +        uint64_t exec_count[2]; /* SW:0 HW:1 */
> +    } stats;
>   };
>   
>   struct AccelCPUState {
> diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
> index d59e70e0d9b..615faf1d96b 100644
> --- a/accel/split/split-accel-ops.c
> +++ b/accel/split/split-accel-ops.c
> @@ -9,6 +9,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/main-loop.h"
>   #include "qemu/guest-random.h"
> +#include "qapi/type-helpers.h"
>   #include "exec/cpu-common.h"
>   #include "exec/cpu-interrupt.h"
>   #include "hw/core/cpu.h"
> @@ -16,6 +17,7 @@
>   #include "system/cpus.h"
>   #include "system/hw_accel.h"
>   #include "system/tcg.h"
> +#include "monitor/monitor.h"
>   #include "split-accel.h"
>   #include "trace.h"
>   
> @@ -70,6 +72,7 @@ static void *split_cpu_thread_routine(void *arg)
>                   r = swops->exec_vcpu_thread(cpu);
>                   trace_accel_split_exec_vcpu_thread_sw(r);
>               }
> +            sas->stats.exec_count[acs->use_hw]++;
>               switch (r) {
>               case 0:
>                   if (acs->use_hw) {
> @@ -103,6 +106,7 @@ static void *split_cpu_thread_routine(void *arg)
>                   assert(!acs->use_hw);
>                   trace_accel_split_hw_accelerate();
>                   acs->use_hw = true;
> +                sas->stats.transitions++;

There's also the transitions in case 0.
Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>



r~

