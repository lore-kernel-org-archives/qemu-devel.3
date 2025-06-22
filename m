Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E01C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTADw-0004wv-1t; Sat, 21 Jun 2025 22:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTADu-0004wj-OQ
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:14:22 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTADt-00014h-3Z
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:14:22 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3121aed2435so3326288a91.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750558459; x=1751163259; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x9sKZ1MvG0i8wrdYlFKWcY9YXKwkFuHMM5HQB4fHaWc=;
 b=P/iSvXWOal97ThCA0oBawMLlT3anPzW3Qnj6S6pL2RZPNlAeta8d/spKmasH247/1A
 /fr0yKdPQFm+4cyVCCH+feNrNtY3AjtT3vx+UstT6w5/fsQ2x/uTMvqqc6kzsU67W9Kl
 LIpvHTUCsbT8YgKUo3iqRGgI/J2FUmBFeL6vdYfSIQGoZsPnUDF9k51ztY/1jlBqM1xU
 Wedh+2JNfUe4J6r00YbMmJ/3mNTnOczsiE7x0qOkcxv08U5Qndugipe6H8uywwVVuMuP
 ljdC9GRAaAFwbfC4QWKY3LMbLdO7v1Lk4bDPLV1maUJO+29Mo9moX7mca2Z1mYRD0sqM
 7N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750558459; x=1751163259;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x9sKZ1MvG0i8wrdYlFKWcY9YXKwkFuHMM5HQB4fHaWc=;
 b=pUb0GuNhKwCzxDOLavbNSZqE0lW3BMnjr13hntlJyzN+QOhTn0vuxQe3jYXUGRIRR2
 aPCcTiOkBPCzmqepJ9LLavG4uWCZXQUcmpY6p60HFc/WxajKaGhVbHKne6jOYdP0mFgj
 kQvBHFXTeiEFCx3BmkpINJX3YdZ1V5lTiCVw2CY2Cg5iLHZdzDw0bDm1l5WxjGH9UP34
 9Yf+WJa6yUUrPS8y75zdzM6IiGV6CHiLfmlsWzWUb4fbnN+X7zbchROfCaDB70IWuyXG
 P2OJcW+ZW3qhaPsDwC/MZhJIfxlPFNlnftr7B+hvLm/n8SXZQ2yN8QUOU8DgwJYpQIKh
 QA+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFtx+9uQN6Vk1yaWC79uqEDfGllzvzewctmmySlhf0hxG3+h6GrgNihE5IkxzQuVNIZe6ihXyKq+cx@nongnu.org
X-Gm-Message-State: AOJu0YwKxyEImf+ykpzDqch08dkI6O3aoy32R6IXt1Z6Ntt342OYkuiL
 x8dj7dkyc36YneGdB7m/auhrGuYu3yecKXljA1MObzefOK2JZv6HE8ifl/d0OCthTig=
X-Gm-Gg: ASbGncvDmkpDEZIbrJVyMKtw1btIrFnol+k7r4FJMCEKtnsapruqhZGET4Cd19nDkE+
 uH8rajGqx6VfKS0yCqFctxG8Q1XjTiKyNqrXDd02eUbuZ3BvUMkcKVzOrFuja/4wkB/fk0MI9V7
 QQPuJVZ229DyqDaYIdliOOc2GYhOqcR7b2whowVXMSU+f/ddTSldMXQpkilhAvLFe8NVLbrZcpf
 Pk72wq4sHN5jLhaVjGKHoSrU2atlUHpmKGG1LD59y70sepjrgpA87ehLUrEYRMmcKvU1nAu4/cP
 2nj/++NCnfFDXAytJNst7aDXEmiYtXyYKoQOfIzciRKAvX71Qx8fg8pYt2STHDGHAdjaHm3BJyi
 TiRAxY0LJHX75K7QVgv8JNzH+tVNP
X-Google-Smtp-Source: AGHT+IEefio9rL6xVPCOWiJwdnuXep29ZSXeb+9OnxyKdDhSjvunPcCSj98mOdAyZNfCRj7rBFjgKw==
X-Received: by 2002:a17:90b:1f8b:b0:313:279d:665c with SMTP id
 98e67ed59e1d1-3159d6196f0mr14480852a91.7.1750558459104; 
 Sat, 21 Jun 2025 19:14:19 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3159df93ae4sm4798594a91.22.2025.06.21.19.14.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:14:18 -0700 (PDT)
Message-ID: <d0990f19-0adc-4664-9119-2f7d1edf1e5b@linaro.org>
Date: Sat, 21 Jun 2025 19:14:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 40/48] accel: Factor accel_cpu_realize() out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-41-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-41-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> Factor accel_cpu_realize() out of accel_cpu_common_realize()
> for re-use.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/accel-internal.h |  2 ++
>   accel/accel-common.c   | 15 ++++++++++++---
>   2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/accel/accel-internal.h b/accel/accel-internal.h
> index d3a4422cbf7..b541377c349 100644
> --- a/accel/accel-internal.h
> +++ b/accel/accel-internal.h
> @@ -14,4 +14,6 @@
>   
>   void accel_init_ops_interfaces(AccelClass *ac);
>   
> +bool accel_cpu_realize(AccelState *accel, CPUState *cpu, Error **errp);
> +
>   #endif /* ACCEL_SYSTEM_H */
> diff --git a/accel/accel-common.c b/accel/accel-common.c
> index 24038acf4aa..0f2aa783ab2 100644
> --- a/accel/accel-common.c
> +++ b/accel/accel-common.c
> @@ -122,10 +122,14 @@ void accel_create_vcpu_thread(AccelState *accel, CPUState *cpu)
>       }
>   }
>   
> -bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
> +bool accel_cpu_realize(AccelState *accel, CPUState *cpu, Error **errp)
>   {
> -    AccelState *accel = current_accel();
> -    AccelClass *acc = ACCEL_GET_CLASS(accel);
> +    AccelClass *acc;
> +
> +    if (!accel) {
> +        accel = current_accel();
> +    }
> +    acc = ACCEL_GET_CLASS(accel);
>   
>       /* target specific realization */
>       if (cpu->cc->accel_cpu
> @@ -147,6 +151,11 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
>       return true;
>   }
>   
> +bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
> +{
> +    return accel_cpu_realize(NULL, cpu, errp);

Why pass null here, and why check for it in the new function?

r~

> +}
> +
>   void accel_cpu_common_unrealize(CPUState *cpu)
>   {
>       AccelState *accel = current_accel();


