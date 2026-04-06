Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D20EE9D814
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 03:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9aXo-0007fR-05; Sun, 05 Apr 2026 23:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9aXm-0007ex-CG
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 23:22:30 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9aXi-00086o-PZ
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 23:22:29 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2aaf43014d0so24823455ad.2
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 20:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775445743; x=1776050543; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qEytGU4xpvoepTAhXAM+ud+IUga7KuFVF/pLVcaUSms=;
 b=gSCeSB5fHpdR+CtFwo5x075C6iT+cVZxqeHzInRwMfvxlZx1NVpA+YtGfhZVm5Bko9
 kVObScjQ6MLRE43elWdsoboYkp+zrNIu9/kU8vUEHZZ2PiE8QLUjgehXAEIEdQ5lFATH
 o4OILzpdlpifcALaB0tmObpJvLWH4DNQG6dAqe7cXQ7z1znAfTWCcMVSlXc6zcUCTKP2
 hysMnYlbhRpFGXucLmAuiRWQQMcLkW00qVRY8wkKoiH9c3xdOR67PC/v88dx+pfpMpNP
 ShB/+yoxBUyKxItEPUlp4qubfOq76MAAU5gRLGm5OXrLXXJDQtWPOIyJXd9KfTMXiE6O
 sOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775445743; x=1776050543;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qEytGU4xpvoepTAhXAM+ud+IUga7KuFVF/pLVcaUSms=;
 b=YDdFHrHnY9JSszcm5bS2d8p1GyVmkqvNvSZ2f00H9a7x/1/+j5fazFl7rZh4ItSFXC
 WFW4fu3u2QPV49Mz+9YVB3BVUyn/V92OVTSzidtQjzTEeGvzlmVzSU/o7vsAGRgl7UNE
 1EK2aqx1zfzVJGozbtwOiOv+v3EfyM1Si6JtLTcBCssrj+5MNmECduqrZnLI7p+p2Xgn
 ti9P+g1icnl+v2KYEhPaY64JP4Gofk+VtVSs0tHtH9MRlpKEl8Hy5bsDF9FyEK450lyh
 kwAn4WXZw++rvikxoz4G/ZF53aFYafiTctr6EB+aGohQte3WAnwpAfoGaZdNZIoUbPwq
 86Qw==
X-Gm-Message-State: AOJu0YzuHcX79KmWLgObjESHnq0aJLMU8U10inbb6DMAB2dPc2l3MqJ8
 OulK0FIpQpuWt50mE4vcYlKuqPBZTUO2WLFwatY1u/LcAY5G4WFUF9KYpZOdJ/0RGVjnj7PBIGk
 RvP98jdU=
X-Gm-Gg: AeBDietQ/8tLHLQ8si9RyJSGwgkqsUmGEMw2BtOlioRV1mfivD7Fn6uKF9RiB1yrbe1
 7UZQNJGcAYsV3bfffdSNr3n5hw3YPBB/zYD5czbE21XkR3WkzlrCbK7ZEsil1CK1rIHJCbjiqHO
 02VpNhmeQfkgkrKau13KXkJVyEuLy95bymBJSOK4laT+VjQPPkjkxuYGNeJv64eSbWAYly4I/Co
 /FDgLISgXGPSW+mYIEN3LePLSzCZRxLaZNUaR//mNGpxadA5L1RHbss6anmlva866P6FE1y2vMn
 2ZdVfbDZPCf3h+JjCtFIS2aS96C1o6ECiJAAvKJOZtJoFSes8LOjLow1Xf532lLzvXThCloDrrK
 takO92fQ6KMZZEYCZ0j2FfhCz32tJThmkR6miSG3fArz6tzE2Qx1QwG+FCco6IpaWQB2Ch3tKUU
 ZeJHw54ZCVwCSlqjskqbPk6ScZtw5ZrA0RJnbkcgFBzC9MD3pCLq9Psd+iY3gisoizZkA=
X-Received: by 2002:a17:903:2c05:b0:2b2:5840:809c with SMTP id
 d9443c01a7336-2b281828136mr120622545ad.1.1775445743363; 
 Sun, 05 Apr 2026 20:22:23 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478d329sm118667445ad.34.2026.04.05.20.22.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 20:22:22 -0700 (PDT)
Message-ID: <d6247ce5-1ff8-43a9-a824-fbe172ab7890@linaro.org>
Date: Mon, 6 Apr 2026 13:22:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 29/35] target/arm: implements SEV/SEVL for all modes
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-30-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-30-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/21/26 00:06, Alex Bennée wrote:
> Remove the restrictions that make this a M-profile only operation and
> enable the instructions for all Arm instructions.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/tcg/a32.decode      |  5 ++---
>   target/arm/tcg/a64.decode      |  5 ++---
>   target/arm/tcg/t16.decode      |  4 +---
>   target/arm/tcg/t32.decode      |  4 +---
>   target/arm/tcg/op_helper.c     |  4 +---
>   target/arm/tcg/translate-a64.c | 34 ++++++++++++++++++++++++++++++++++
>   target/arm/tcg/translate.c     | 19 ++++++++++++++-----
>   7 files changed, 55 insertions(+), 20 deletions(-)
> 
> diff --git a/target/arm/tcg/a32.decode b/target/arm/tcg/a32.decode
> index f2ca4809495..d076681bf97 100644
> --- a/target/arm/tcg/a32.decode
> +++ b/target/arm/tcg/a32.decode
> @@ -192,9 +192,8 @@ SMULTT           .... 0001 0110 .... 0000 .... 1110 ....      @rd0mn
>         WFE        ---- 0011 0010 0000 1111 ---- 0000 0010
>         WFI        ---- 0011 0010 0000 1111 ---- 0000 0011
>   
> -      # TODO: Implement SEV, SEVL; may help SMP performance.
> -      # SEV      ---- 0011 0010 0000 1111 ---- 0000 0100
> -      # SEVL     ---- 0011 0010 0000 1111 ---- 0000 0101
> +      SEV      ---- 0011 0010 0000 1111 ---- 0000 0100
> +      SEVL     ---- 0011 0010 0000 1111 ---- 0000 0101
>   
>         ESB        ---- 0011 0010 0000 1111 ---- 0001 0000

Preserve the column alignment.

> +/*
> + * Event Register signalling.
> + *
> + * A bunch of activities trigger events, we just need to latch on to
> + * true. The event eventually gets consumed by WFE/WFET.
> + *
> + * user-mode treats these as nops.
> + */
> +
> +static void gen_event_reg(void)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    TCGv_i32 set_event = tcg_constant_i32(-1);
> +    tcg_gen_st_i32(set_event, tcg_env, offsetof(CPUARMState, event_register));
> +#endif
> +}

This is obviously incorrect as a method of assigning "true" to the "bool" within that union.



r~

