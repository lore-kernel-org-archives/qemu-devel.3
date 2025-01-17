Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC07C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 12:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYlds-0002U1-DD; Fri, 17 Jan 2025 07:40:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tYldp-0002TL-Hz
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 07:40:01 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tYldn-0007xR-RJ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 07:40:01 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2165448243fso46150815ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 04:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737117597; x=1737722397; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+h3KeTQFTuj6hD+7yCDC+cNM9Zms608OSpSuV8VXXAo=;
 b=YdQIb+pczylj4nKV5TkPF7rXYRn3XXeNQmxxOnQRYZubrr3CHjZdu0+RXpoxG0+Re+
 M1SaBo9w8BwZlbviASpfJW28sAA5WFumy3xfY7+JJ4LKqfN0JQlVvZOqTXM99f96NxoX
 evrgwluYwnyV+jbx775/HV/k2BJEgoLMyDr/mB42aT5MI7/bfQ7p4E1VQRV3xCbNTgl2
 A+yj6TzFcRi+/7/2ip922io4SFCVAah5oliFxh+KSoGVDUiFx/jsI+u4YQdc49ZpFb+I
 cij3/Q2hNauVxIsArVwbIwGc4Q0ZUZhShQiaW1EX6LlXIwwA5S2Djj3J/vK/5/cMYOrU
 hQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737117597; x=1737722397;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+h3KeTQFTuj6hD+7yCDC+cNM9Zms608OSpSuV8VXXAo=;
 b=On+U/bnLibOQNBAzlovhtNmUNxsKHyrKRjNa9jbK6/0KxsozKKxJKkp+ZwCe+j4f3T
 Eae7K8dt53EIFlCwcyhPEsOeLdr/P6+SvVf3mPV3ELJlq++AMVVlj0vaZLiwI6nd8mRW
 OTGsUY3w3RD6QUfKEaE920MIgjRFvq8zxotOZMyohAOOsUNqmdIZMJ9WEOpsE7gZpJfm
 5l5rioy7JaQU6dp3fjVEoaF0LBQo8EWuiLFY0shdgoGMTqAJEg9VAW1oJPE6lugBSAnV
 dkHaGXcZnVLFbC41I8/THOZh2pR0bMGd3OJ9q5YXrQ0LAoVWmd2x/ban3FIMhM4UWYOo
 ZV6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4cfJfri2Xc5MljsWWGom96fIOJcUwRh3JGnO79pwkACcLQxH/XVi9catzayE+ZjUNP78FivkgIVG3@nongnu.org
X-Gm-Message-State: AOJu0YzWB2V2+7Zp5FBC430nHnop1WwlvfntRg5UrVyxZ6/ILB27LFHu
 5+T2FbOKv3l045Bzo/9yKp7vESBrGnL6R25FRBrL5e6HqA4xNRaQ6cNNPqP7mLw=
X-Gm-Gg: ASbGncu8+2OTDzjX8NkCTnj49JFHCjkmHkNiL/1xRk2XTC9RGWEXBN4pRLF1b7rBO0a
 0UuxgIQPSv0X60Lha31LHaN7nN1oyCPZmhVS0LEM5WV/xztflXQ0KO2PV8SWJy8HSgHhwg9k1LP
 XYBb+I9PGF9WVUoWweih44ID4INkXLDllHfJbcON/Xeah/UDfKIEMWZm9WJ8NTV5+WjrW0d00/v
 vY/3o5mYem4HBF1cqtMzjtW4mlkA8vKDEo6u0D/FC7Ilcg8CzjcNrtuIr4B59cMI5myc/Y=
X-Google-Smtp-Source: AGHT+IEvMrY7bWSKcsXlM2olESM8MUnXBAjoK+kJognxeBht8TlEH6jsKwtY6l3XVQ9Sezrte/wVrg==
X-Received: by 2002:a05:6a00:a09:b0:72d:80da:aff with SMTP id
 d2e1a72fcca58-72daf9c1dfcmr3864193b3a.9.1737117597395; 
 Fri, 17 Jan 2025 04:39:57 -0800 (PST)
Received: from [192.168.68.110] ([191.202.238.10])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72dab7f3025sm1809732b3a.12.2025.01.17.04.39.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 04:39:56 -0800 (PST)
Message-ID: <c5c83e85-6c5b-4d70-be82-06eed6e63bc5@ventanamicro.com>
Date: Fri, 17 Jan 2025 09:39:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] cpus: Introduce const_cpu_env() and
 const_env_archcpu()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250116230435.87580-1-philmd@linaro.org>
 <20250116230435.87580-2-philmd@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250116230435.87580-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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



On 1/16/25 8:04 PM, Philippe Mathieu-Daudé wrote:
> const_cpu_env() is similar to cpu_env() but return a const
> CPU 'env' state.
> Same for const_env_archcpu() w.r.t. env_archcpu().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/cpu-common.h | 5 +++++
>   include/hw/core/cpu.h     | 6 ++++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index b1d76d69850..f765e97a973 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -250,6 +250,11 @@ static inline ArchCPU *env_archcpu(CPUArchState *env)
>       return (void *)env - sizeof(CPUState);
>   }
>   
> +static inline const ArchCPU *const_env_archcpu(const CPUArchState *env)
> +{
> +    return (const void *)env - sizeof(CPUState);
> +}
> +

Can't we get away with something like:
  
+static inline const ArchCPU *const_env_archcpu(CPUArchState *env)
+{
+    return env_archcpu(env);
+}
+
  

We're just adding a 'const' to a pointer that env_archcpu() already retrieves,
so might as well use env_archcpu(). The 'const' will be added by the compiler.
This code builds without warnings in gcc and clang in my env (Fedora 41).

If we want to be a bit more explicit I suggest:

+static inline const ArchCPU *const_env_archcpu(CPUArchState *env)
+{
+    return (const ArchCPU *)env_archcpu(env);
+}
+

Same observation with const_cpu_env() and cpu_env(). Thanks,


Daniel

>   /**
>    * env_cpu_const(env)
>    * @env: The architecture environment
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index c3ca0babcb3..ecb31221b26 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -588,6 +588,12 @@ static inline CPUArchState *cpu_env(CPUState *cpu)
>       return (CPUArchState *)(cpu + 1);
>   }
>   
> +static inline const CPUArchState *const_cpu_env(const CPUState *cpu)
> +{
> +    /* We validate that CPUArchState follows CPUState in cpu-all.h. */
> +    return (const CPUArchState *)(cpu + 1);
> +}
> +
>   typedef QTAILQ_HEAD(CPUTailQ, CPUState) CPUTailQ;
>   extern CPUTailQ cpus_queue;
>   


