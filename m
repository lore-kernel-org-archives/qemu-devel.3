Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBEDCF6D24
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 13:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svzCi-0007mH-25; Wed, 02 Oct 2024 09:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1svzCZ-0007l8-IX
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:15:35 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1svzCV-0006kT-Nc
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:15:34 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e0afd945d4so4411901a91.0
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 06:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727874928; x=1728479728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tgc83BXg8hwd9CZT0qOG0SAgSPmVwE/FaBCfY1TpFqA=;
 b=c3gXO7Frvw1s0EY51phCTDOiwz7RHHgVhyh6HZewoPQW9eakrOAVSsluBr0Qu3Var1
 8gkAHm9zAPmalPV2nfnO05g9Wni8aNY/gZC7kvqaRmRHGeqysdPbONizRem1Gb5iGnsx
 9SaK3DL4HelVrY7xb6FKEILeKDZ5B/7WwBOFPgbUQR7fb7fuD7p7nq3Aqe+4Lz3Tpjz1
 5vZlHkfDWaRMV6njwQqaI3PBSsViVD4SOwKL32Hxk5RX3l0bD0cnudGlm3UvjwJtVw2r
 S+ZVq1n8nq4BNJeV4KRvO8h0rixU0jgYdKceHldbU590074GJWu6gooh0gKTzYR11uvP
 HUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727874928; x=1728479728;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tgc83BXg8hwd9CZT0qOG0SAgSPmVwE/FaBCfY1TpFqA=;
 b=uLRaQbqBm7Vo4ws+DqVX+xz8EzVpX9HfuqLms0fMPOKbJ0ZofH1HeTmkyBFVYUlKjB
 GUHomXVCGwDWBXlznwo7eCqaL/JvEnqMbwjXUkq8LvFicqOt0P1KmLQ8HX4WD29OCHtx
 CMQ/cw/sFVMSlD6ClvzrAh74sCE8yusFtUmuBRDZkwSezALo4uxNExGJbL4pXl600gAy
 WyFro5Ks4IPNWGjCaVJrbh0WVargEXrKiLnVUoNv0ZH6EErJVyYJvQ7BE1Y96elKemes
 Z9cutl53jAEvlriTp2TGGM3JT2sUofTEKJsKfM/P9cde0l5qZ+EMZM0IueOnE9NT3r2j
 +4nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsS3TCZq7L0i2hazsjweeeFtUWK9wde9+uaq+yIJ6ndpJBDnUDXy5i3srNi6iXNQwEnVv2dCUVgBop@nongnu.org
X-Gm-Message-State: AOJu0YzvQoxtNN8EmR06ml6i1E2XPUgJ/zKNo3MkkaRzBUIVSFB29Uxo
 N+oc6+Etsuid9QEMcW0GymkVc/ugMR6hGufOc3Xylabmd27BZhdZOaVPQ6u0lzM=
X-Google-Smtp-Source: AGHT+IHKigGQYpGgK1AxcJzYIsKr3wcF0VBHvvBahTXR6Gtx3JS7WMLnvbQEStaXmrGXOtgZFTSf9Q==
X-Received: by 2002:a17:90b:4a51:b0:2e0:9b50:ae28 with SMTP id
 98e67ed59e1d1-2e184901f12mr3906306a91.31.1727874928309; 
 Wed, 02 Oct 2024 06:15:28 -0700 (PDT)
Received: from [192.168.68.110] (200-206-229-93.dsl.telesp.net.br.
 [200.206.229.93]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e18fa54fe3sm1476012a91.54.2024.10.02.06.15.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2024 06:15:27 -0700 (PDT)
Message-ID: <44dae84e-b30c-48e7-a031-a19885488d66@ventanamicro.com>
Date: Wed, 2 Oct 2024 10:15:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Set vtype.vill on CPU reset
To: Rob Bradford <rbradford@rivosinc.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20240930165258.72258-1-rbradford@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240930165258.72258-1-rbradford@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102e.google.com
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



On 9/30/24 1:52 PM, Rob Bradford wrote:
> The RISC-V unprivileged specification "31.3.11. State of Vector
> Extension at Reset" has a note that recommends vtype.vill be set on
> reset as part of ensuring that the vector extension have a consistent
> state at reset.
> 
> This change now makes QEMU consistent with Spike which sets vtype.vill
> on reset.
> 
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4bda754b01..af602e3caf 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -997,6 +997,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>       cs->exception_index = RISCV_EXCP_NONE;
>       env->load_res = -1;
>       set_default_nan_mode(1, &env->fp_status);
> +    env->vill = true;
>   
>   #ifndef CONFIG_USER_ONLY
>       if (cpu->cfg.debug) {

