Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA58D10F4D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 13:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOFkX-00084x-Cx; Wed, 26 Nov 2025 08:40:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOFkO-00082c-8y
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 08:39:54 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOFkL-00062k-TI
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 08:39:51 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-477a219db05so40262585e9.2
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 05:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764164388; x=1764769188; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P2ShG1zP0ro5KXcn3ZzBQt2ZlDityOea7o6dsOWT+zA=;
 b=UsIrthNxjJuW4Do0ce7jP3bfnfORoMzUWH3XiePmDTOocV/tfDOGMsPj1un4mcdnF/
 yxou23FBQOMC5/4nEA+TvmkWR52GmkqrhuENn5nx8bhWorIG83CCnDPsPlXViARSAs9c
 Ndci4/dGsR7QiJZQbG+hs2F5HKx9J870Al4dGdOJLeO+FduEARLRsf8RjSEgz45PJbkL
 7ZPLtEHoisVLPAShKvRm6Kar1taAjtpKW9RWLVVIpvZQnNb6HI1iUccf32sfaL30Yzk1
 ucQRrLeWxyuzJKu0zPbQV3VSknz19JFhwPO64ld8BtzSzbaPKvJiCzYRIAIRTyXKvLCx
 4ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764164388; x=1764769188;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P2ShG1zP0ro5KXcn3ZzBQt2ZlDityOea7o6dsOWT+zA=;
 b=DmK53CGEcbEySq2Ld1IIGyxI8C52rnFip0Ab4hwEszve6T/wHSNMr9j+Qk/dgyC3J6
 NsDQvAhPeRKbmxioSZcFMBEtlTQ7SzZGpRIkap3+ebptDhMxWhYM85w50YG5ciyuKtn7
 SKaoiAjk7vWXo+V1HQCm8YFy+kwkPVX5QwUjIaQ0tZPSilsvObqJ6pzhLOVUNhQgOkM2
 u7FPGRBCoNFz/jpT5MlL+lEPh2D712bAR2QVHfk5ZhcGQap/xdvoE6S5781aorXne5ip
 ZO9qj+5YMpAG96z32liywXOmkgHvgAVEKwDiZS1pOx0uhzzPCs0xxLmPM9QEN3CkRRl9
 85qQ==
X-Gm-Message-State: AOJu0YzLQikyBhlrlvhEFXCJ2GEh2aV9XU+kRrtEu7nwlZiEH5YjwRgm
 son+M1Y84FbtE2iCSXp3r4aIBg1s9zcdZhgIhIp6/uljYvJJoaHaGVG97iEQ3AS3x30=
X-Gm-Gg: ASbGncupxi9xfq+mZZZpIojABZL3Rnv+7VptbbZc9SZo2UVFXhQzVcj8j/Wkpaba7+W
 scR5vNva4O6C8jIsXDxR10KRbioQ7q7k/5UmcSvfOGDVfBGgYUDyM+mcspC6CImQBIEKjxHyI0F
 Eh8WPs9NW+9fjwfUUuV6U6VSmseWKHYJu8YqKFwfSJwkR2A3Xs7BEMSq5yk+eIQ+Dl6gDkBFHLU
 MAUrh+J+vXbZ4bEcOnZTrZaIzNP1A6yUX7S9VglWtYPW3OyCay4VFU4umcDXrjKUup6hTT7bRfd
 y5tFwTRUvuNliMRLw7E/Nm5bfneVU0NfMFoF6KogEu/QGDbFlh/N03Z9gmtUMv0dkyxiXxwPpcp
 eAXRGNJFDK6jonkGVHrKrkpaywf1uZQLzx+Q04ijhjIWPLC3d3TMASyocuuO7p6Hc6XKbJ5YdNC
 IMYUIPmpcDb/tfSERrMEnwZJJs
X-Google-Smtp-Source: AGHT+IFlj31YhjAlLk4Jkv0WTCNVgTD+D5xMHIwQ8S41w7Bz6iEzrZyB03znS4688+s9htekMVpMlQ==
X-Received: by 2002:a05:600c:a08:b0:477:aed0:f401 with SMTP id
 5b1f17b1804b1-477c11254damr191585325e9.23.1764164388162; 
 Wed, 26 Nov 2025 05:39:48 -0800 (PST)
Received: from [10.79.43.20] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47905303963sm42057905e9.7.2025.11.26.05.39.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 05:39:47 -0800 (PST)
Message-ID: <8f6eb2ec-d6a7-49dd-b425-ee771d2f9be3@linaro.org>
Date: Wed, 26 Nov 2025 14:39:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix i386 HVF compilation failures
Content-Language: en-US
To: phind.uet@gmail.com, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org
References: <20251126094601.56403-1-phind.uet@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251126094601.56403-1-phind.uet@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 26/11/25 10:46, phind.uet@gmail.com wrote:
> From: Nguyen Dinh Phi <phind.uet@gmail.com>
> 
> Recent changes introduced build errors in the i386 HVF backend:
> 
> - ../accel/hvf/hvf-accel-ops.c:163:17: error: no member named 'guest_debug_enabled' in 'struct AccelCPUState'
>    163 |     cpu->accel->guest_debug_enabled = false;
> 
> - ../accel/hvf/hvf-accel-ops.c:151:51
>    error: no member named 'unblock_ipi_mask' in 'struct AccelCPUState'
> 
> - ../target/i386/hvf/hvf.c:736:5
>    error: use of undeclared identifier 'rip'
> 
> - ../target/i386/hvf/hvf.c:737:5
>    error: use of undeclared identifier 'env'
> 
> This patch corrects the field usage and move identifier to correct
> function ensuring successful compilation of the i386 HVF backend.
> 
> These issues were caused by:
> 
> Fixes: 2ad756383e1b (“accel/hvf: Restrict ARM-specific fields of AccelCPUState”)
> Fixes: 2a21c9244740 (“target/i386/hvf: Factor hvf_handle_vmexit() out”)

Oops.

> 
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> ---
>   accel/hvf/hvf-accel-ops.c | 5 +++--
>   target/i386/hvf/hvf.c     | 6 ++----
>   2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> index 3e5feecd8a..e2cb8f202b 100644
> --- a/accel/hvf/hvf-accel-ops.c
> +++ b/accel/hvf/hvf-accel-ops.c
> @@ -148,19 +148,20 @@ static int hvf_init_vcpu(CPUState *cpu)
>       sigact.sa_handler = dummy_signal;
>       sigaction(SIG_IPI, &sigact, NULL);
>   
> +#ifdef __aarch64__
>       pthread_sigmask(SIG_BLOCK, NULL, &cpu->accel->unblock_ipi_mask);
>       sigdelset(&cpu->accel->unblock_ipi_mask, SIG_IPI);
>   
> -#ifdef __aarch64__
>       r = hv_vcpu_create(&cpu->accel->fd,
>                          (hv_vcpu_exit_t **)&cpu->accel->exit, NULL);
>   #else
>       r = hv_vcpu_create(&cpu->accel->fd, HV_VCPU_DEFAULT);
>   #endif
>       assert_hvf_ok(r);
> +#ifdef __aarch64__
>       cpu->vcpu_dirty = true;

Don't we want the ifdef *after* this line?

> -
>       cpu->accel->guest_debug_enabled = false;
> +#endif
>   
>       return hvf_arch_init_vcpu(cpu);
>   }
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index 16febbac48..2023a7bfbb 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -728,7 +728,8 @@ static int hvf_handle_vmexit(CPUState *cpu)
>       uint64_t exit_qual = rvmcs(cpu->accel->fd, VMCS_EXIT_QUALIFICATION);
>       uint32_t ins_len = (uint32_t)rvmcs(cpu->accel->fd,
>                                          VMCS_EXIT_INSTRUCTION_LENGTH);
> -
> +    CPUX86State *env = &x86_cpu->env;
> +    uint64_t rip = 0;
>       uint64_t idtvec_info = rvmcs(cpu->accel->fd, VMCS_IDT_VECTORING_INFO);
>       int ret = 0;
>   
> @@ -966,10 +967,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
>   
>   int hvf_arch_vcpu_exec(CPUState *cpu)
>   {
> -    X86CPU *x86_cpu = X86_CPU(cpu);
> -    CPUX86State *env = &x86_cpu->env;
>       int ret = 0;
> -    uint64_t rip = 0;
>   
>       if (hvf_process_events(cpu)) {
>           return EXCP_HLT;

Otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


