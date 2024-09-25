Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E54ECF58C3
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 13:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stSBI-0002QJ-Sn; Wed, 25 Sep 2024 09:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1stSBF-0002PZ-Mf
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 09:35:46 -0400
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1stSBD-0004Dc-Sn
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 09:35:45 -0400
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-84e8bb409b6so157714241.3
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 06:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727271342; x=1727876142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GG83+Wb23DqVtcPbDqqweVQ4D3Pv90RDqT6FHWTRc2o=;
 b=hJyzItnRq+xatE+6ekmgulb1x0DQJ497+J6jG9bUTulwPQC/2zfnh/5DVOaGuz1Biq
 AW1yKlPbiXY8uGPBZnTqT2Li0bxjqgbT9Cq+kH/FmR33l0e9AwLjizXfZkokJM/K/vkR
 N9LhUUAPUb4iVZYviLSmTmQHYjtMjlAaCjk38SoCKttdlMtQMEtAcAjhgE7rmr09y4GL
 KkVgFctR3OmxpOpaNQWST3QfqSBz8JiOzYxd6GMC8kTG1IIAecca/scA13cpNQCgh8I5
 7yxcVvMuGjZsujSFPnbXwpck8AekK4Sf1DVxL+l9syINLFs36ypqSQcgmrBjX69zVL1v
 1EWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727271342; x=1727876142;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GG83+Wb23DqVtcPbDqqweVQ4D3Pv90RDqT6FHWTRc2o=;
 b=gjERhj4Ooi5pHJCH9+LYffEGB9/luc0zRKZHDkrdyMoMdIzfOqgL9YMVjk07eJXVdp
 osROnUIJnQqnRNrJiOBtsTHWhr2Ez5NZbcO59QfkDEeoFhyAMe4Q5kNwYYwhIzFAScrS
 JSTfDfOT8T7aC4DiaxZkNHZGHmCch/+0pkV2VKJU1r5wC9OXR6nOkLrkbxlZSZ1wIVKM
 TZobQl82PMMRqj3Fp+wI2TjhSZkvTqycEIAhcScTUYyZZ6A/HYwYrdSUnIq3tEEXFYHQ
 gpQIIAlDS59Ut+B7osuD4XGt8A9RmcVjjo2Aelx1Tx3Lk79cT2SzLMcaAC7eGZ/2s8E5
 fVmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkzXExeHlomIzuz3bkuMIohJZLSRQA1tRZQ68tzv3pHCUzbWfi2/Y8dHUNg4TJou13AgyXg6WTJLHB@nongnu.org
X-Gm-Message-State: AOJu0YwDvuHv/fDdX/jWHNHaGnIzhOU7/rFfB7WdjEXiPJa9WZitenSj
 M8xYxhiRHI+lO3BUmAZMD5QhTNuZdXaRDLoZCijlZNttLrkjkj7iYRkIhsM9gNs=
X-Google-Smtp-Source: AGHT+IGQ5kbgBFbxqlXzuYa5f+J/glX+RkQiI3wGhwBIkW1Auk0SuuQ04R+GVqu7lvhLWuXgxpJCGw==
X-Received: by 2002:a05:6122:20a6:b0:4f5:22cc:71b9 with SMTP id
 71dfb90a1353d-505c1d96569mr2319100e0c.5.1727271342557; 
 Wed, 25 Sep 2024 06:35:42 -0700 (PDT)
Received: from [192.168.68.110] ([187.101.184.93])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-505a9f85883sm2003524e0c.31.2024.09.25.06.35.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 06:35:41 -0700 (PDT)
Message-ID: <70658cf5-4a72-4b83-8390-cb0a3506e6eb@ventanamicro.com>
Date: Wed, 25 Sep 2024 10:35:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/csr.c: Fix an access to VXSAT
To: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>, palmer@dabbelt.com
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20240925093531.382347-1-evgenii.prokopiev@syntacore.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240925093531.382347-1-evgenii.prokopiev@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ua1-x934.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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



On 9/25/24 6:35 AM, Evgenii Prokopiev wrote:
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
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/csr.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
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
>   
> @@ -727,7 +727,7 @@ static RISCVException write_vxsat(CPURISCVState *env, int csrno,
>   #if !defined(CONFIG_USER_ONLY)
>       env->mstatus |= MSTATUS_VS;
>   #endif
> -    env->vxsat = val;
> +    env->vxsat = val & BIT(0);
>       return RISCV_EXCP_NONE;
>   }
>   

