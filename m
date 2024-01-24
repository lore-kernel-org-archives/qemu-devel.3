Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C855C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 12:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rScVv-0005kh-M0; Wed, 24 Jan 2024 07:37:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rScVq-0005id-P1
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 07:37:50 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rScVo-0006Oe-Nx
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 07:37:50 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5100fd7f71dso818222e87.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 04:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706099865; x=1706704665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=anXfizGFL/FiMlPSuxh+INuOqI7Q/a7lIPZHLKwCaQ8=;
 b=rFFRj14nds/OPZGdFoRQJg9llzRp831/JEiLH5rqN/21NAI645qb8nOZUSsfEuB3bj
 T0ruDZI4PayzwbaOEd+OqiZvgeKI1IFJHg5NmHbM2TXB3NI0OIodElMuBWnyHgHUODsb
 RmiO++lCVMt/DJMEGe6XLvIcKo0c+aXlpjgLAuO6RZkdtH45xogBxoFinWyPGlI1tXQT
 GuQ3bSPBgQ6g+QFAkb/hCiOxnPlmKRUHDM5BEdG2WN7AzkJoAOAyOI17vLZd6Lmeg8Xs
 Hs+AzySPoqk6Dr/w4fqG568kGEJtVCLCeOS881CpZhKmLCMV35EE13T6yKD74mwDjWwp
 mpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706099865; x=1706704665;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=anXfizGFL/FiMlPSuxh+INuOqI7Q/a7lIPZHLKwCaQ8=;
 b=IL7OCzvfsIlEG0KdH1cLJJeLi46CR0NygwVN0jJPLLoAY1dYKsJMvP1HyggGX+rSq5
 DUpGdxtxYmuCgb5h2FBxJo13iCgI29JB6l/apcmM59+QbuaMsoq1siwdFtWkKXb7X030
 kCt5BlIkRhpaaAyuYQ1NPnDHBAjV3XZW2gR36GpNGco7CTEPLpmDLvlui1wYgd3zsbHG
 KJY6Y//B64XJDgHbfQqn/0eBt6arjlSnIYrD2Emk9EmdeWodb2Z7DetJ/Q5DCjkQpBVC
 dD6B6fT0f6aJlJ/6eJsBR3Oc6dtp93Ax8vQK6jafDMyA43cCWRsz4Xw037+KMJ39gZsH
 hWHw==
X-Gm-Message-State: AOJu0YzlLMDKyq0hEyRPd1uOdX632UOpWiYZC/VyP6l3P0AF4ljMLf1g
 ZETxS9YRXnIAuoM+l5P7C9rKa0NocfciVfJb1R313VCk/1siwYq19jVHgW2p1Qg=
X-Google-Smtp-Source: AGHT+IGR33VImbL4PW8UFMoeRUsRS6etgUcV6SIP2VnR0NI02jW2qisdew9YmFsQWaZlMgAbWWoIaQ==
X-Received: by 2002:ac2:5df0:0:b0:510:c63:8f38 with SMTP id
 z16-20020ac25df0000000b005100c638f38mr930305lfq.119.1706099864703; 
 Wed, 24 Jan 2024 04:37:44 -0800 (PST)
Received: from [192.168.69.100] (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 q9-20020aa7cc09000000b00558a3e892b3sm16257147edt.41.2024.01.24.04.37.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 04:37:44 -0800 (PST)
Message-ID: <ac17cdc2-b34b-47f9-bf5e-545e4aa4a1ca@linaro.org>
Date: Wed, 24 Jan 2024 13:37:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/cpu.h: mcountinhibit, mcounteren and
 scounteren always 32-bit
Content-Language: en-US
To: Vadim Shakirov <vadim.shakirov@syntacore.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
References: <20240124120658.695350-1-vadim.shakirov@syntacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240124120658.695350-1-vadim.shakirov@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

Hi Vadim,

On 24/1/24 13:06, Vadim Shakirov wrote:
> mcountinhibit, mcounteren and scounteren must always be 32-bit by
> privileged spec
> 
> Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>
> ---
>   target/riscv/cpu.h     | 6 +++---
>   target/riscv/machine.c | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 5b0824ef8f..3cf059199c 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -317,10 +317,10 @@ struct CPUArchState {
>        */
>       bool two_stage_indirect_lookup;
>   
> -    target_ulong scounteren;
> -    target_ulong mcounteren;
> +    uint32_t scounteren;
> +    uint32_t mcounteren;
>   
> -    target_ulong mcountinhibit;
> +    uint32_t mcountinhibit;
>   
>       /* PMU counter state */
>       PMUCTRState pmu_ctrs[RV_MAX_MHPMCOUNTERS];
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index fdde243e04..daab121799 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -398,9 +398,9 @@ const VMStateDescription vmstate_riscv_cpu = {
>           VMSTATE_UINTTL(env.mtval, RISCVCPU),
>           VMSTATE_UINTTL(env.miselect, RISCVCPU),
>           VMSTATE_UINTTL(env.siselect, RISCVCPU),
> -        VMSTATE_UINTTL(env.scounteren, RISCVCPU),
> -        VMSTATE_UINTTL(env.mcounteren, RISCVCPU),
> -        VMSTATE_UINTTL(env.mcountinhibit, RISCVCPU),
> +        VMSTATE_UINT32(env.scounteren, RISCVCPU),
> +        VMSTATE_UINT32(env.mcounteren, RISCVCPU),
> +        VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),

When changing a migrated field size, you need to bump the version_id,
see https://www.qemu.org/docs/master/devel/migration/main.html#versions.

Regards,

Phil.

