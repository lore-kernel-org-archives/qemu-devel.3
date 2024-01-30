Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33269C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 08:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUjSM-0002d9-2Y; Tue, 30 Jan 2024 03:26:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUjSB-0002Ta-JB
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:26:49 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUjS9-0003Jm-RH
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:26:47 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a2f22bfb4e6so518405066b.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 00:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706603204; x=1707208004; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cRg1KPfnEeu4OlNchSDyEddHh2WugqQCGoHSXGlBAGU=;
 b=UIzcKC68spAWT/kEO29XFkWlht0wRdTvmJeWwenJXH9T495wz5e11ZP4LKXKdvMhW2
 wTmlrrgY9cFE7xSwCvK37sri86yExe10cz6C7aq2e1XXDsmuqNw8AGS/pYBr/HgBLFvN
 yg0Q7/Zpte6g4qZNiNgQTHCjh91wk3Hi5NrPRgt7220DxhnIvRtWa6shShx18lXjVg4K
 Q7wtYcnh6//AipIC+yS1OXzlKmoMCDy62G9DSg7U5bYXPoVeFMIVqBVl80FsSt2bNv0b
 dRFPE7Ws+9Cuu9i/9u2AyCefoHF4tLaoH+It9lE4exvkoQ+urZJTnilLqH+/t+3NkPmM
 t0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706603204; x=1707208004;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cRg1KPfnEeu4OlNchSDyEddHh2WugqQCGoHSXGlBAGU=;
 b=csWozWkdzRnXGvWagySlCO4kYgBLL67qdeI7Rvt/F3JT/1Kv2tzCOzzEbXtVV+WGbV
 i9ZJiobOI33j1SX9jo812cv6xKZu7xpB/Fq1Oz1EHGxgejzAqrPvR+tRp5NlewZxTRrO
 7qreC2DfJ1KGxLOJqX33gr47aNgTNOe7HPUoVAJJiNMhqKTomFg3kzl6Ed9OSlUieP/U
 JcbBenGgRCaxuNnuJR5bUAp8vZsdGEJ+v6Jcveu+j+JU/SE0MuoKLvjrVyX6n/t4qrvx
 A3dfq+5lnWvikb+be68glmgyrgCkp7E/xauDZrRolXUmHbzjRtEmRqxHg2EzTvBLqseA
 oq/A==
X-Gm-Message-State: AOJu0YxrQ7QpkbBMs+jVtWHkYF9Kuc72dLOONdYWNAgLZYMmaFx1nFum
 vwzFGksG4L2vsmGJQ8/9KB8DYp5YiIaGhCGfDWAV59xUhcrMWO8qTi1yPbxB4QDj/9i0pviT/ww
 4
X-Google-Smtp-Source: AGHT+IGrpuJnUUn5l9y48y9HxyE4iUxVYGnYVTEnPY11YgyiNKZRHlxn1lRxfFtHZybW66c5AcmARQ==
X-Received: by 2002:a17:906:6d8:b0:a36:11f:58fc with SMTP id
 v24-20020a17090606d800b00a36011f58fcmr1824317ejb.40.1706603204326; 
 Tue, 30 Jan 2024 00:26:44 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 ub11-20020a170907c80b00b00a353ca3d907sm3762676ejc.217.2024.01.30.00.26.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 00:26:43 -0800 (PST)
Message-ID: <f9558a60-ef89-4820-9c6c-8489b3e7f462@linaro.org>
Date: Tue, 30 Jan 2024 09:26:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] hw/core: Introduce CPUClass hook for mmu_index
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng
References: <20240129233043.34558-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 30/1/24 00:30, Richard Henderson wrote:
> While the primary use of mmu_index is for the softmmu index for
> system-mode tcg, it has a secondary use in encoding cpu state for
> the page table walker, and thus depending on the target may also
> be used by memory_rw_debug with kvm et al.
> 
> This is why I placed the hook in CPUClass not TCGCPUOps.
> 
> 
> r~
> 
> 
> Richard Henderson (33):
>    include/hw/core: Add mmu_index to CPUClass
>    target/alpha: Split out alpha_env_mmu_index
>    target/alpha: Populate CPUClass.mmu_index
>    target/arm: Split out arm_env_mmu_index
>    target/arm: Populate CPUClass.mmu_index
>    target/avr: Populate CPUClass.mmu_index
>    target/cris: Cache mem_index in DisasContext
>    target/cris: Populate CPUClass.mmu_index
>    target/hppa: Populate CPUClass.mmu_index
>    target/i386: Populate CPUClass.mmu_index
>    target/loongarch: Populate CPUClass.mmu_index
>    target/loongarch: Rename MMU_IDX_*
>    target/m68k: Populate CPUClass.mmu_index
>    target/microblaze: Populate CPUClass.mmu_index
>    target/mips: Pass ptw_mmu_idx down from mips_cpu_tlb_fill
>    target/mips: Split out mips_env_mmu_index
>    target/mips: Populate CPUClass.mmu_index
>    target/nios2: Populate CPUClass.mmu_index
>    target/openrisc: Populate CPUClass.mmu_index
>    target/ppc: Split out ppc_env_mmu_index
>    target/ppc: Populate CPUClass.mmu_index
>    target/riscv: Rename riscv_cpu_mmu_index to riscv_env_mmu_index
>    target/riscv: Replace cpu_mmu_index with riscv_env_mmu_index
>    target/riscv: Populate CPUClass.mmu_index
>    target/rx: Populate CPUClass.mmu_index
>    target/s390x: Split out s390x_env_mmu_index
>    target/s390x: Populate CPUClass.mmu_index
>    target/sh4: Populate CPUClass.mmu_index
>    target/sparc: Populate CPUClass.mmu_index
>    target/tricore: Populate CPUClass.mmu_index
>    target/xtensa: Populate CPUClass.mmu_index
>    include/exec: Implement cpu_mmu_index generically
>    include/exec: Change cpu_mmu_index argument to CPUState

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


