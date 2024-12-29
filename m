Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400E2E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 01:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRiZI-0007JF-RJ; Sat, 28 Dec 2024 20:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tRiZH-0007Iq-B2
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 20:58:11 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tRiZF-0008SP-Q7
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 20:58:11 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2167141dfa1so101658685ad.1
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 17:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735437488; x=1736042288; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KtQqhO+1+d04geFXtvmTrNjeNf6ybvJ+YfozVmhg1NQ=;
 b=qKA8YPiVFh9u4QtI5OhXt4WvNL+R7LOCfD//M74YdoPoYogtkbblckGCTn1EdlDInq
 wN4fG7+pXfmpocFGhTcq3ejCVk8xPJvU+BUvfHgf1mDw8w487Erl7A+Fg93beIxzo3un
 nsdlSHHFQYdifSvda2JC5gsR4Ybh1VgrPFxCVhqLLeVuX6hmM1867RreYLPuDtWrIhoO
 ylaH5cKwV0hhMqgEXENJ8HxiSKGJ9mT6OxLYaKMB309caeVcxQS5AbKH3dPqU4b7yMTY
 6bM4Qb5/LL5NRLyVRdKDW1Z1gYqZXjudaMdBf4m7KU9bar9Cn8e+/oIrQi3r/mgW0stl
 33oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735437488; x=1736042288;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KtQqhO+1+d04geFXtvmTrNjeNf6ybvJ+YfozVmhg1NQ=;
 b=tnJKFwfISXafraHwzaNOGNuDndzaaIvNs7tm3at3rYb9vz5KJ/6erO99ONj8pXQ3Gi
 2ibEEq6JIwF5I07K4cBFsDNeuj/9kZHxdjVsSi0MLKvSUOiFA2tV5erKUI/cWB/6k8dK
 fN9Mzp/Xr+YjtM7AD/eTfbz0LWWQpYeGBQrUXG1iWM9JCaAfloptdo5vXg6NZK1iIZUN
 sqX6GEyON8F4NGewSYDpG+F57Ibp5VTexW4OVvMAX/fSgGY5uF1LFn9+AWZqeesu6GWa
 gEwFhJQehfZTh/+q08vV5WM9QHd8UdqcrA69bvLJponJZvYt0JL4WKCDzGvvsLhoJ8uP
 eyjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSdd9+ve6+1ZyjcRZ9yfhOEeyWznDsoNKYaOL+I6S9nHZKz9zP+BBN1N241NJ6wdGYJkx3hpofzR3W@nongnu.org
X-Gm-Message-State: AOJu0YxSx8jxfbP0GVXZI63YMHOYgXaZCmnBGTjFE2So7Ri/s6hlWSnx
 RlxtAHf80aUCICVr0GOpUt1gSDtkxYNeCG3jgtWtIsBY4v1BxgM7D9+JOriZtzo=
X-Gm-Gg: ASbGnctKzZhPbuiPz+wGSRZell+6Il+Ddh2qclBrgl2D5ApEj+xTUM5y+LxJ1Lxwr8V
 pwvymAdrjCdeneZ3t9LRNQ2lE/cEVvJ5T2ZFpsVH4K1QXI54yQQ6Xk0jUGzNiH1VZx+qoBMX/+m
 9M0gyuGXjcpKpngP0jlXtoaR+GyR4DqSbnPZbPwIJSE6noHJGjNP4eFKQGRUlIQJCgG5PZNrPB8
 nij8o5agzXPWI8M2TeqbX6qNuslBmEWKHjvCGz2gergXHmFygzGZr/xoNtD7FOpPBrHvZ5P8+WW
 nHHT7/m6fMmnX7n4HeNrTbUaWmT3EydVfr+A9iM=
X-Google-Smtp-Source: AGHT+IH7SsRQwi8XXBvx/zwqa0wkV0s3OCp2xe5sUo8ArtvyqdZ/aRFmSJsTb5Vv+lZVafQfAGdaiw==
X-Received: by 2002:a17:902:e850:b0:215:7e49:8202 with SMTP id
 d9443c01a7336-219e6cf8cdcmr473290175ad.13.1735437488231; 
 Sat, 28 Dec 2024 17:58:08 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eac6sm156390765ad.80.2024.12.28.17.58.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Dec 2024 17:58:07 -0800 (PST)
Message-ID: <3b0804a9-4df9-4eb0-bdc8-2745b62355e8@linaro.org>
Date: Sat, 28 Dec 2024 17:58:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/hppa: Add CPU reset method
To: Helge Deller <deller@kernel.org>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
References: <Z281jSej_buitgV8@p100>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Z281jSej_buitgV8@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 12/27/24 15:17, Helge Deller wrote:
> Add the CPU reset method, which resets all CPU registers and the TLB to
> zero. Then the CPU will switch to 32-bit mode (PSW_W bit is not set) and
> start execution at address 0xf0000004.
> Although we currently want to zero out all values in the CPUHPPAState
> struct, add the end_reset_fields marker in case the state structs gets
> extended with other variables later on which should not be reset.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> V3:
> - Call reset function from hppa_machine_reset() instead
> 
> V2:
> - Add end_reset_fields marker
> - call reset function in hppa_cpu_initfn()
...
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index c38439c180..b908cf65c6 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -235,15 +235,39 @@ static const TCGCPUOps hppa_tcg_ops = {
>   #endif /* !CONFIG_USER_ONLY */
>   };
>   
> +static void hppa_cpu_reset_hold(Object *obj, ResetType type)
> +{
> +    HPPACPU *cpu = HPPA_CPU(obj);
> +    HPPACPUClass *scc = HPPA_CPU_GET_CLASS(cpu);
> +    CPUHPPAState *env = &cpu->env;
> +    CPUState *cs = CPU(cpu);
> +
> +    if (scc->parent_phases.hold) {
> +        scc->parent_phases.hold(obj, type);
> +    }
> +
> +    memset(env, 0, offsetof(CPUHPPAState, end_reset_fields));
> +    cpu_set_pc(cs, 0xf0000004);
> +    cpu_hppa_put_psw(env, hppa_is_pa20(env) ? PSW_W : 0);
> +    cpu_hppa_loaded_fr0(env);
> +
> +    cs->exception_index = -1;
> +    cs->halted = 0;
> +}

There's also a set of exception_index in hppa_cpu_initfn.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

