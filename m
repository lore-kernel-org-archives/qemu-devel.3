Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4049C83F14
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 20:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZbRe-0000Lu-Qf; Wed, 09 Jul 2025 16:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZbQr-0008G5-EV
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 16:30:22 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZbQp-0008Kv-Ij
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 16:30:21 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-61396c3f681so106981eaf.3
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 13:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752093018; x=1752697818; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sFq1M2Yb8Dy9vxNT3yHIB7iF41fhCoqri1n1e59YlL0=;
 b=NmXkhoj+Nd3YmXLlQD5mZTNVgtozMzcEAYHmYxJiiOBYyFB/NqBMUAYzsPQ0OcFbWI
 8UI73xeNc+kXhpLC6GYC3KfvrKVteftQOUCByiuDBBmLu7avGFZZmURO0mrxTAymazyi
 /786emVc1QwlcHJTADU7nX11QhQARgdZIArbT4McDk4R6JInQJN0Yt5bxxWsyw5MYnD1
 gPvNlYonBv2lRqKRnYESqFafORQJ74Wsl/MxuIBwPuj3hJT6ebffzNU96cxh0Zz2ggEq
 g1IAZywAfgpMhs2VdqNcO82y0uYRm0DnZ0Tyaa+xJnZdzWHpwH3Lb2rnCiJT/mtyauuf
 oG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752093018; x=1752697818;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sFq1M2Yb8Dy9vxNT3yHIB7iF41fhCoqri1n1e59YlL0=;
 b=K1401hosNpIPs3vikf5IebWBihYSvB32O6KFk0ril34jOV/SYZ+7bqGzL9eE5yvV6O
 HJnvF9OGY+1GmnYMX4zqE93EIi21gWshNoKlv5AvVME5F0uM0wdzx62mumKeqtdy6lQt
 xWX4Xe7VvnQmXWT+X8BlSnD2eGD3bq6nsgkrqpeST7qEdWxtaFPOpLlZ9DEkqTpR7pI7
 qcro0vQrWCfo1UlIg4E/TrcHU9r8ML1n/uQ7PVUdpQaGngkgul4Q/rMb8feBUOjIPMli
 9OPTqjbSiRQeL3Tmv7h/4DTOES4XzgTy1d1lvgRdt8hCl2isPKUytcSpLhAXLRbQXgSe
 iTdA==
X-Gm-Message-State: AOJu0YyhxHPGSOxPgx6r2Tkfl2chx8ko/AHRLIBbF3KN0woBtGLOjIcc
 1Z6eNaBx1G36HYy3egoWmGBUBzFW28r1FAHJK5duww9dSjIX3FJh8WpR2Yy5eeeKvYw=
X-Gm-Gg: ASbGncuQH2na7MT75X4bnXv5rsLZRmMPpjdMVrg2AZAyv+zl4TI+fqwxMdXgxv5LrYA
 nQDyjZFUM5JgyRBz9gFVHWHZBtP5M0bmBnttjzz1YVM0jZOH3cpnN7ZK2fukVm5pej3kljkD16U
 UI9xYtdkWqPz5mfamV1MccY+vpIczs5NbdYOFYwUlq+23lyU+rY1GjzK9Cto62LVvBcOozc9wUx
 Iz8kwBpZXV6jPmcyBhJap1h38G4JOPlkA0jPx7Tn54QMnt6rZspY44lezlAboJ82BhzL4R7A9Lu
 O2ps+3TzkmV8OwIa/Y8API05y2cGHcSSO7dFUFv6KkbSPM0c60jNOaI/iaa1gweq2WzpPQ268Az
 Jhps2yENi8U+agQ==
X-Google-Smtp-Source: AGHT+IE6Nk5oZlVPktKzUwkwxDPNnAMmvgBOt355lPF4pVWUXI1kypJ0Cv7bo3Qb24D3Fupl7HVaUg==
X-Received: by 2002:a05:6820:6aea:b0:613:c7cd:3b2b with SMTP id
 006d021491bc7-613d6f4b94emr1027740eaf.2.1752093017701; 
 Wed, 09 Jul 2025 13:30:17 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5c1db3sm2065273eaf.35.2025.07.09.13.30.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 13:30:17 -0700 (PDT)
Message-ID: <d05d66b3-5750-49e7-8d24-c72cb7e8aece@linaro.org>
Date: Wed, 9 Jul 2025 14:30:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] target/arm: Add FEAT_SCTLR2
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org
References: <20250709180326.1079826-1-gustavo.romero@linaro.org>
 <20250709180326.1079826-4-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250709180326.1079826-4-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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

On 7/9/25 12:03, Gustavo Romero wrote:
> @@ -7816,6 +7818,78 @@ static const ARMCPRegInfo actlr2_hactlr2_reginfo[] = {
>         .resetvalue = 0 },
>   };
>   
> +static CPAccessResult sctlr2_el2_access(CPUARMState *env,
> +                                        const ARMCPRegInfo *ri,
> +                                        bool isread)
> +{
> +    if (arm_current_el(env) < 3 && !(env->cp15.scr_el3 & SCR_SCTLR2EN)) {
> +        return CP_ACCESS_TRAP_EL3;
> +    }
> +    return CP_ACCESS_OK;
> +};

Stray ;
And on every other function until sctlr2_reginfo.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

