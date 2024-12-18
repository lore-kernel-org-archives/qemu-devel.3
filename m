Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBBBE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNx7d-0000ru-Ih; Wed, 18 Dec 2024 11:42:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNx7Z-0000rK-4P
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:42:01 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNx7T-0004oO-E4
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:42:00 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5401c68b89eso1169972e87.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734540113; x=1735144913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=frbByNezOPWVD3e6rKFhQjbqOM/Jt1CctFqXE4ER5v8=;
 b=MA4/+4ymvbGbuBEQtwvkh5zBQzgIanoDSrm2w4kz/rl2tQsNZnxHrMAbLxlp7/nQvO
 0AhoEgvr3eDD/zER10mQhAthad0afpcMlPhiHuvYrmV41+GkzmnF2j7zfCglvmIiIYP6
 dfp98lUdI2fRdm3+dhguBtN0nnooZuUfG9k4MmpdCB4gcSRzmBggiwMVPtasClFFu4v2
 P63Uq6fkIFNIOAeQXrnbiSXDGgq0G0vxsilvnh+w82awZ0gWOW0nT8KMAwXbU3vA1L6S
 alHsB2s2ouPskSgSDidrd4fBTY8cTDWORrZLuhT/VbbSNaZpTVh8WJ0dfdwRhuxtNg92
 fO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734540113; x=1735144913;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=frbByNezOPWVD3e6rKFhQjbqOM/Jt1CctFqXE4ER5v8=;
 b=IE2YtkNm6Pkzksn5y+btvOsjT+w09OyspeL/eciSmLLCY6azjIhGwHv/2XLADbLRj+
 /NTgRd3vbk/FBdBETwXP4gqeUM1vuRUx55/KfBLCajHhBnSaZKH/o2dYqEDzEXLErS4K
 wjhGO25q7WCJYy2fHn45DG03GaXWQEcCktl04uM4nEwraGcIrJs1uuREBxw8wbSkbssc
 lcPlEEQ7eI0cskdWp54NmO7eF4s38cGFPgD20FPBVXL8xqc5mXGoXf+ZJTC9X4dNy7Xz
 zBW0V1r0eLNO4H4MglTpI1SgfM1v/RjwAVuylm3YSTgqOiuGm+mlOcdxYjHwWGyhDRoV
 QvSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhgteUzjrqx5SKHnBjgixHVU0Lv7AbosUrAqBLAfmfsRVJWq7vgwINqg9wCzKvQ8HcKkaXMSjQ9OZf@nongnu.org
X-Gm-Message-State: AOJu0Ywt+/vJgxNz48NVRlqEULiKwHSGKCWRJQvYQxYW1HCiIEQEJieO
 qD7AgkxgWoTDs3QMZAfO7Ea3MgE7LlDlnmK+Bs82QBHFhn4ygmo7fUiI/9lDFJk=
X-Gm-Gg: ASbGncuL5iw//+ENamwB0rjck1XNl/jPBkus5XGBIJ/qBF7WcyYGlXr/FtHSp4+TQ6i
 HiammuTDtmgDs1lBk7sOQwLCDTGGjQUpCJEnZ6Hhl+In0P9iOWlTDkbFXtfah/7FdEJeM6UPsCj
 PWROmB+WywKouuWMPyaZ5TFRikH+zXJ5dhT9/jSor+s0NL6H8vXm3QwtnDU3t1oADIpANgrAVaW
 MQpi5M4VmfXTRPKrVLXtxMRIHoxDcHdBaX9bGL2HY2otuoWcrXq6pJWVGYmApOK68anWF5Qnk0=
X-Google-Smtp-Source: AGHT+IFkR5j2lMtpyPqcsTEckWQCXctToYD5xA0g6xiycQ6L1llavKvBGawKmRT4sMVhF4CYiRnyMw==
X-Received: by 2002:a05:6512:3e2a:b0:53e:3852:999c with SMTP id
 2adb3069b0e04-5421b6bc283mr1250140e87.12.1734540112949; 
 Wed, 18 Dec 2024 08:41:52 -0800 (PST)
Received: from [192.168.242.227] ([91.209.212.65])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120b9f515sm1508983e87.41.2024.12.18.08.41.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 08:41:51 -0800 (PST)
Message-ID: <1b2eeff6-e559-449a-b3cf-3d1e0001f56e@linaro.org>
Date: Wed, 18 Dec 2024 10:41:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/ppc: Include missing headers in
 mmu-hash[32,64].h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org
References: <20241218155202.71931-1-philmd@linaro.org>
 <20241218155202.71931-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241218155202.71931-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/18/24 09:51, Philippe Mathieu-Daudé wrote:
> CPUState* is dereferenced, so we need the structure definition
> from "cpu.h". PowerPCCPU is declared in "cpu-qom.h". Include
> them in order to avoid when refactoring:
> 
>    In file included from ../../target/ppc/cpu_init.c:27:
>    target/ppc/mmu-hash32.h:6:23: error: unknown type name 'PowerPCCPU'
>        6 | bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
>          |                       ^
>    target/ppc/mmu-hash32.h:66:15: error: incomplete definition of type 'struct ArchCPU'
>       66 |     return cpu->env.spr[SPR_SDR1] & SDR_32_HTABORG;
>          |            ~~~^
>    target/ppc/mmu-hash64.h:173:36: error: unknown type name ‘PowerPCCPU’; did you mean ‘PowerPCCPUAlias’?
>      173 | static inline void ppc_hash64_init(PowerPCCPU *cpu)
>          |                                    ^~~~~~~~~~
>          |                                    PowerPCCPUAlias
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/mmu-hash32.h | 3 +++
>   target/ppc/mmu-hash64.h | 2 ++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
> index 2838de031c7..abbff206d4e 100644
> --- a/target/ppc/mmu-hash32.h
> +++ b/target/ppc/mmu-hash32.h
> @@ -3,6 +3,9 @@
>   
>   #ifndef CONFIG_USER_ONLY
>   
> +#include "target/ppc/cpu-qom.h"
> +#include "cpu.h"

cpu.h handles cpu-qom.h.
Do we really need both?


r~

> +
>   bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
>                         hwaddr *raddrp, int *psizep, int *protp, int mmu_idx,
>                         bool guest_visible);
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index ae8d4b37aed..b32e17c2c58 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -3,6 +3,8 @@
>   
>   #ifndef CONFIG_USER_ONLY
>   
> +#include "target/ppc/cpu-qom.h"
> +
>   #ifdef TARGET_PPC64
>   void dump_slb(PowerPCCPU *cpu);
>   int ppc_store_slb(PowerPCCPU *cpu, target_ulong slot,


