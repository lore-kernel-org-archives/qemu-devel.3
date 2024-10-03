Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DC1CF34C3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 20:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swSD5-00070d-DO; Thu, 03 Oct 2024 16:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swSD3-000703-7g
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 16:14:01 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swSD1-0005z2-Pf
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 16:14:00 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20bb610be6aso15642045ad.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 13:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727986437; x=1728591237; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fKyZ9yVdYOlQzlf3uyZhmFnGqIRBgzBvUTn8lHAqFzU=;
 b=DJeHhQceIDbDl1LuR0bzdNYQI1KUP7s+bSLIWmXN6WGue0uL4HkVrW7dxkS/jMJEid
 ViH+zzsgqQ8+2C6kJYafYXgJF5H6V+VoI0y1tKDThyCz2a4cYDnoe3QJ/svRrA9LVAes
 V9USIJnTjsGGNCjPETc6+gD2J5j0rW/NKWEG0FomwNJpyGLNSH2NPs6hBm1GvvHw6nrO
 +b7OVJuuSAmspizgYG0IyiUDWJKHmvi8lWJWDDbzCbdNBLZW5Q2mBxTekajxhJ6o+wCp
 w8A/BBH70sc7hUFMgQtisKMRGe+1yobCj86m6DJDf3t5BNF27YaZySEx7pTDzJELZ+gO
 urzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727986437; x=1728591237;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fKyZ9yVdYOlQzlf3uyZhmFnGqIRBgzBvUTn8lHAqFzU=;
 b=i2JY6ratuMaHu6Y5cyoFqrbPre9ihOlhALeDdQ75DQNt2YkMf6uyGSULnVE1SmJAcG
 uy9SvM+YSB8L4LjPX9P9qL6ckmtycaoD7sFkn/BKIiSNEFSypiFgslYNet/US6BOcDS5
 e+3zEV/mDQpft/apahjLT+asen3zHU0lgP2e62fUqhZdI+EutWZO6YSJ8umdmaAp+qjc
 o/H7ZjT7jZCc/OPk3x4kWSA5b07G0yXzIpGftRUih8ZK6efzxO1a0B4Mz5JMBVO0NAhb
 AkXiQtg89aQ7db3mHdBxarJ5Y2KYQ06P4l0+tIg3jFGT3LO0EwfL0vsk5ImLenamKJxr
 RVaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4CSWqKl/+qYJNUFt0riG1UYFgemjuazkdB/5FJ5hAU9NoLCbUxgiHX+lI6NMwvp76wIIk0jRkCONI@nongnu.org
X-Gm-Message-State: AOJu0YwCBlkEH6oIQ86LUcfkTGvI9ZSPPLp1IQsopSW6JmKwP7tmfypi
 COFCM/kBo6SgPaq+rJRsNb4RRqIyA2NVTXm4g6p7EEeonB1eCnyJWT9dT2+2bG8j4YiKEgaGoZu
 w
X-Google-Smtp-Source: AGHT+IHmSwp0VgLVNhVl0z+b8Z/GEgFcduHi1Xqkrc5oaxbtc1PL02DnlVz43gOXBgBfR+EzDG8mvQ==
X-Received: by 2002:a17:902:c952:b0:20b:9b07:7779 with SMTP id
 d9443c01a7336-20bfdf84225mr5835355ad.15.1727986437554; 
 Thu, 03 Oct 2024 13:13:57 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20bef7fbca9sm12537755ad.238.2024.10.03.13.13.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 13:13:56 -0700 (PDT)
Message-ID: <163e6cfc-755e-487d-8653-a5524876e171@linaro.org>
Date: Thu, 3 Oct 2024 13:13:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/riscv/csr.c: Fix an access to VXSAT
To: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>, alistair23@gmail.com
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, palmer@dabbelt.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com
References: <CAKmqyKMmYPG0_jyrJFxvnxhTGTCAz4L5Lf6FouZpy3ZtywNiGA@mail.gmail.com>
 <20241002084436.89347-1-evgenii.prokopiev@syntacore.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241002084436.89347-1-evgenii.prokopiev@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 10/2/24 01:44, Evgenii Prokopiev wrote:
> The register VXSAT should be RW only to the first bit.
> The remaining bits should be 0.
> 
> The RISC-V Instruction Set Manual Volume I: Unprivileged Architecture
> 
> The vxsat CSR has a single read-write least-significant bit (vxsat[0])
> that indicates if a fixed-point instruction has had to saturate an output
> value to fit into a destination format. Bits vxsat[XLEN-1:1]
> should be written as zeros.
> 
> Signed-off-by: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> Changes since v2:
>      - Added reviewed-by tag
>   target/riscv/csr.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

New versions should not be replies to previous versions.
No need to re-spin *only* to collect tags; tools can do that.

> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index bd080f92b5..69c41212e9 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -717,7 +717,7 @@ static RISCVException write_vxrm(CPURISCVState *env, int csrno,
>   static RISCVException read_vxsat(CPURISCVState *env, int csrno,
>                                    target_ulong *val)
>   {
> -    *val = env->vxsat;
> +    *val = env->vxsat & BIT(0);
>       return RISCV_EXCP_NONE;
>   }

Nit: no need to mask on read...

>   
> @@ -727,7 +727,7 @@ static RISCVException write_vxsat(CPURISCVState *env, int csrno,
>   #if !defined(CONFIG_USER_ONLY)
>       env->mstatus |= MSTATUS_VS;
>   #endif
> -    env->vxsat = val;
> +    env->vxsat = val & BIT(0);
>       return RISCV_EXCP_NONE;
>   }

... because you know the value is already correct from the write.


r~

