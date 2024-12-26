Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AAAE77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 12:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQnMs-00067G-DB; Thu, 26 Dec 2024 07:53:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tQnMq-00066N-48
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 07:53:32 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tQnMo-0000ap-IH
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 07:53:31 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2167141dfa1so72036135ad.1
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 04:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1735217609; x=1735822409; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AqdMDBBYCyktx5uPWQ1Y6mC3oSimIs/M4AtjkAhdH2E=;
 b=MmrAf48L7Yhu+6nPglusufIDRy2G4OV5l8i4I2LdBYksfQadL7fQu4DNydjYaZkYZf
 TW+SbVYJ1GAK9Wg4Fxxo7SBm43K+n+y7WAQZ6KgJMQxDmK3+X0mX8xX/15I2FqA4uIXA
 t7SHRHQT5Vn0VhMM2Gw0lLLRvu0mg5Pyxd94y34RXEIwZOJQhar9hj3ciQEdS+ZYCoXP
 ECYK1V7tjQfzVyzNnal5sBECkbTZgHBnQiSOEOWmeLoQVqrLd9/ea5OT7IU9Vm1hOeGZ
 hjqY9IMQFlEer4nMJ9aP7SqFxqFq4jmbr1535BCG0M+bCUPeNpcDocFbj3bYTW+/oYe9
 HkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735217609; x=1735822409;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AqdMDBBYCyktx5uPWQ1Y6mC3oSimIs/M4AtjkAhdH2E=;
 b=jD13RmaJmHrIimaJff1EEuRedLO+RmSntmDq699Fye2FJR2uI/QSBf+HBQ5G98oDa7
 x5bIDgTOu4m+YBduhTfIa5xfqOAq+G7YXbiuyNv9jCyQ7eK+dMh9oVDkiW3iUoCgSzKV
 0nQdg6YJQ7C/2FAy7jjNy5RBC4JUlxue5D9jUez6T+1l8DLffoQQmcS0H3D4zcK9wXJl
 83RtMzGWIGYjEzwtzmQHZFsRin03bAyBhxIJMrVbT4HspWA3mCPcsto+HGZq1DSwyX0D
 mHV13fCpqMaTHD/CnzzG09pTAodOWyesMCSaS+1RAWyeUl0U6kDUkZGpbm38SV6HdzTf
 WZiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKklf0jeVdJukuxmf6c7QQvxs6evOPevwM5+BXTIinpoVaPXGZEQzPAdD/21VDziLpEKPTfMYcnDk1@nongnu.org
X-Gm-Message-State: AOJu0Yy4AheRUYlESfWPij+/Tna9uXAzDiwknGKmerXHxV34/OWlI8r6
 8tOCeFK6Y+IaHqJwPDFgswBQevV1ikKsjsOW7/tC1ouQTOGUSdPdDZedgnr5Of4=
X-Gm-Gg: ASbGncsUgX1VTNz8AkpxXJtEhLICRK3FMXw/lFaqzS6fKLsO1W8PPvmPOD/bV9J6Cx/
 muVVLHL845dnhcFPTusU7JeS8HqXAhTDgRMdiQVa3seqt/fgYuti23tdvNFoNaPx8juCPg6lq9i
 QSw43UO5/a3u7Z+eiv/7uZeyEhrfBjzytdrHF2bf6LOBtxSOIReHcgylRUS07sSnQfDNlBFDNcV
 dHbSA3r86uGtwhNX1byeRH7y5u6zBxRzpu8Z2lnvFD/ad7jlJ/pDmx3GFJ9kZs4DDOXFg==
X-Google-Smtp-Source: AGHT+IFtaBEreoAw4DSZS87YrY9HzZpArTuwZPtP9BM2BdpKpYJcvPYEg+J9brbS+WYyy/snZutRXA==
X-Received: by 2002:a17:903:90d:b0:215:5d8c:7e46 with SMTP id
 d9443c01a7336-219e6d6b689mr371080075ad.27.1735217609148; 
 Thu, 26 Dec 2024 04:53:29 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96e585sm119617225ad.70.2024.12.26.04.53.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 04:53:28 -0800 (PST)
Message-ID: <e99fa25f-5c92-4261-828f-2351820e1806@ventanamicro.com>
Date: Thu, 26 Dec 2024 09:53:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/7] target/riscv: Add Zicfilp support for Smrnmi
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20241217062440.884261-1-frank.chang@sifive.com>
 <20241217062440.884261-7-frank.chang@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241217062440.884261-7-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
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



On 12/17/24 3:24 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Zicfilp extension introduces the MNPELP (bit 9) in mnstatus.
> The MNPELP field holds the previous ELP.
> 
> When a RNMI trap is delivered, the MNPELP is set to ELP and ELP set
> to NO_LP_EXPECTED. Upon a mnret, if the mnstatus.MNPP holds the
> value y, then ELP is set to the value of MNPELP if yLPE is 1;
> otherwise, it is set to NO_LP_EXPECTED.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu_bits.h   |  1 +
>   target/riscv/cpu_helper.c | 11 ++++++++++-
>   target/riscv/op_helper.c  |  9 +++++++++
>   3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 17787fd693..be9d0f5c05 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -643,6 +643,7 @@ typedef enum {
>   /* RNMI mnstatus CSR mask */
>   #define MNSTATUS_NMIE       0x00000008
>   #define MNSTATUS_MNPV       0x00000080
> +#define MNSTATUS_MNPELP     0x00000200
>   #define MNSTATUS_MNPP       0x00001800
>   
>   /* VM modes (satp.mode) privileged ISA 1.10 */
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index e5ffbbbd83..1fb1e31031 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1918,6 +1918,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>           env->mnepc = env->pc;
>           env->pc = env->rnmi_irqvec;
>   
> +        if (cpu_get_fcfien(env)) {
> +            env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPELP, env->elp);
> +        }
> +
>           /* Trapping to M mode, virt is disabled */
>           riscv_cpu_set_mode(env, PRV_M, false);
>   
> @@ -2085,7 +2089,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>           /* handle the trap in M-mode */
>           /* save elp status */
>           if (cpu_get_fcfien(env)) {
> -            env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, env->elp);
> +            if (nnmi_excep) {
> +                env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPELP,
> +                                          env->elp);
> +            } else {
> +                env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, env->elp);
> +            }
>           }
>   
>           if (riscv_has_ext(env, RVH)) {
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 63ec53e992..a4b625fcd9 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -402,6 +402,15 @@ target_ulong helper_mnret(CPURISCVState *env)
>   
>       riscv_cpu_set_mode(env, prev_priv, prev_virt);
>   
> +    /*
> +     * If forward cfi enabled for new priv, restore elp status
> +     * and clear mnpelp in mnstatus
> +     */
> +    if (cpu_get_fcfien(env)) {
> +        env->elp = get_field(env->mnstatus, MNSTATUS_MNPELP);
> +    }
> +    env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPELP, 0);
> +
>       return retpc;
>   }
>   


