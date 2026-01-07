Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52133CFD63E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTy4-0006sr-L3; Wed, 07 Jan 2026 08:52:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vdTy3-0006pE-K1
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:52:55 -0500
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vdTy2-0003Uu-3d
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:52:55 -0500
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-11b992954d4so1565385c88.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 05:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1767793972; x=1768398772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JdZU0iQ6UN0P0jLNhJhdZvN8DRdEy685uuh2AxnLKf0=;
 b=DsWqA4LGflu0twdaMfssFz1A5GPLDKFTriJaU8+RCrpwZ2ArQ/gucsW+NiUdnYhQs0
 qMUMCoQMThcLBtzN07DRk+KrbiQd+jsbA/PUgbx+HHQsNH7SVXtm6X7YUAg5GBvkZO3A
 Xhh8SiHzAuFpAwUzsS0Q/B2HF4Kmf2QVkUWxedflmpg01Yk2bdngh3jly9R3d6K66pGI
 kb6hB6otGnd+DWnA3jeOEDbkE/FmRUOtzdxSVrkO4N17MXv8xxgm+fZee36xHG8NoaEx
 XG02kS0MnSeSLptEPJzx5lJ8rZKqPVswMWNSIAiPHJXZJyJ7YS04S2dX8zCm7q2uANdR
 8YTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767793972; x=1768398772;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JdZU0iQ6UN0P0jLNhJhdZvN8DRdEy685uuh2AxnLKf0=;
 b=WKNmt5ktJXNaHDKA9rEwaG3OPvrAzXdXT0ssZw5PybSfm7L7vFX3I1udHrgcSaN25f
 uFE7gpH971rb10Rf8R6mI4i59LmN2p+i8lMBfI021mhdAOivK6G40CbbGNGcQ0I4hBo5
 3+zjSfbeVg04H5Gk6JKq8tNFlEwXnjvYwA/r9M5QQST1U74hjXNXal11sDV261OQu0BO
 hu6AFp0REuDf9awJCIbM5nhlS8A5fJjM0X4mg0WGyoqpgMTwp3wb/OgNtFh1Myb4Nh++
 +WrfP2bZjeS1gYz9LiVwBcvnL8MMOryECncH98mzoZXqicgQrhyruWh4k2LW5kJo1GLZ
 BmGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgEdjIChdm7pN8kh5O2X8DHK2gliY7T8dy9GO6w326cNSfUT9qeb96cav4Ao9PE50TJUXYMNpB207D@nongnu.org
X-Gm-Message-State: AOJu0YwdkU47Je1NCfDdKgmcbp9Bh0qZIsWCPzIWV4+5WFB+NZ4aQyR/
 RsLXQaH02NcICXrUCz7I02uVnkmHfTBRb/jk1J9H2/qiemdYmd2qmTVDX1Eg+TN0NWc=
X-Gm-Gg: AY/fxX5swCUeuymBYkXxUPEJXTBcMUi6UYq2HevB9fx5uOgli5Whn3HvShDZAf61g4a
 LTnuRm2a/hZT1wQ6lH8qC0xShqU1ZhIPBmgrZm9tQEtXCPFoM9pMUmXZ5ATDWsVF37oPQDfLsYq
 lAYqACL+zBCQe77CnG8CMmbopy3PZ4xTZb+S4kAnilz7R5xO+fvwO7gNYrQJf3XnQgCLdbgnPsF
 rpDH+gc7YytPKgATrdm2alrXTvNhTg89H67LC/xasruUXCASGjzxR8MRLVAl2AXMIQzysnmR9NE
 1cXMNK+MbIe9WPOKdTVAP6lXe6mfZiC0uwjT1+BB59CfykxfnJJaB91h2sEt3+3yV2jk5EpleBI
 kgDE8tH/kM0Q73Hczn5swv7Ozeysvuv1Pham7KFkHLO0o3+FEVQPZ0EU5IZivemmMFxf4ZOLwlA
 lzDI4LGs4uzTsTioPdjhrkvLfdyQTDJj13BQUyIUg6+x0075+LWBQA2qY8wlohWpP496iDZWT6
X-Google-Smtp-Source: AGHT+IGWtlV7paELXKfljUXHBT3rjFqI9wXhPDi46W4IU+alUe9kz8LFaemhDkFnQs8XDMr87X/GtA==
X-Received: by 2002:a05:7022:459f:b0:11b:9386:a380 with SMTP id
 a92af1059eb24-121f8b9e6aemr2092248c88.47.1767793972253; 
 Wed, 07 Jan 2026 05:52:52 -0800 (PST)
Received: from [192.168.68.110] (200-162-225-127.static-corp.ajato.com.br.
 [200.162.225.127]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-121f243496asm9978507c88.1.2026.01.07.05.52.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 05:52:51 -0800 (PST)
Message-ID: <a696a6c1-c1b0-40ed-8788-da7bd4d0d73d@ventanamicro.com>
Date: Wed, 7 Jan 2026 10:52:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv: riscv-iommu: Re-process command queue after
 clearing CMD_ILL
To: Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>
References: <20260106080520.28711-1-jay.chang@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260106080520.28711-1-jay.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-dl1-x122d.google.com
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



On 1/6/26 5:05 AM, Jay Chang wrote:
> When software clears CMD_ILL or CQMF error bits by writing 1 to CQCSR,
> the IOMMU should re-check the command queue and continue processing
> pending commands if head != tail.
> 
> Per RISC-V IOMMU specification, the software error recovery sequence:
> 
>    1. Read the head pointer
>    2. Software has two options:
>       - Option 1: Set tail = head to re-start from an empty queue
>       - Option 2: Overwrite the illegal command with a valid one
>    3. Re-enable the command queue by writing 1 to cqcsr.cmd_ill
> 
>    "At this point, IOMMU will start working on the first command
>     in the queue."
> 
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/riscv-iommu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index b46b337375..e89a262a63 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1992,6 +1992,16 @@ static void riscv_iommu_process_cq_control(RISCVIOMMUState *s)
>       }
>   
>       riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR, ctrl_set, ctrl_clr);
> +
> +    /*
> +     * After clearing error bits (CMD_ILL, CQMF), if queue is still active,
> +     * re-process pending command.
> +     */
> +    ctrl_set = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR);
> +    if ((ctrl_set & RISCV_IOMMU_CQCSR_CQON) &&
> +        !(ctrl_set & (RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_CQMF))) {
> +        riscv_iommu_process_cq_tail(s);
> +    }
>   }
>   
>   static void riscv_iommu_process_fq_control(RISCVIOMMUState *s)


