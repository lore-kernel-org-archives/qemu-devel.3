Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD04C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 12:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsht3-0000XX-5J; Thu, 13 Mar 2025 08:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tshsc-0000Nl-Lj
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 08:41:44 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tshsU-0003W8-RW
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 08:41:41 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2239aa5da08so16050635ad.3
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 05:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1741869693; x=1742474493; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Eh9MpmBQRllyyK0N8kIf3ZvhQdX0d1+l007GH/cDYqM=;
 b=LXBvwV50oOU6ylbj9PXTHP6EznfWn3ww2k4ZhIU/E8APe2QmhWI1SxE+h1eubjEe/P
 GFgn7RKdlLyDcpFes7l2uDNF5F9v9cyLiio2t7hZwDfhA0EcaKt+jF7UXxXuIs+YPywr
 BZM89OAB+VMybH+QP/SLetpntfzZdtdA4hwzSJ17870PZoUcQtiVQSWfUtw7PY1VzoiO
 hECcFL8fqmzo9sORfKBb7Bm83aUIGAfvuDJ8LlWQAYp4DVnvRsdyZiXivknd5/rJHpVZ
 ulh58uLlhznPSV+quFG/nBh0xCp4miBERevwD0G3xF6cza5QYrb/JoEYC926p8bdes4I
 SuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741869693; x=1742474493;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Eh9MpmBQRllyyK0N8kIf3ZvhQdX0d1+l007GH/cDYqM=;
 b=nNyzHFJbz8n+UZ+1F6N7JP5dHGoWy9hD6fbqnO1MgE+1UVhEySEW9ozLmjjJCiUK2k
 CzztwILrKsLpv4s6ZGXLm7wLkLTh7mcwpkoC6mW4uhWUSvzvDgNYXPapnVlx60/X9Ns4
 u1u/pup/hvsoWY7hyNxLmJv0yfeF9iQmupMx6xUE7LL0p54MxAFvcpfXSonHI92X0y+a
 wwZTE+2u/tRGSTAsApwoeQ5QGH8BZnMKh9TunkaCW4ueE8dnGrd2MGPuW+7TsrZz1eRM
 Kqu3xK9ZCYiWn+tHmz7ksRkpIsipO+ip/OeRbwZntmw48MuH/X9STZ1acNxP2iLxjY/U
 QSWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwa+A/vnjoVVNB+oBjBMENHTAop4fhTnaJkABXkevq02ehSpeSSZ4zK5HytpTUJIoTa1z3EfLpXRcq@nongnu.org
X-Gm-Message-State: AOJu0Yzi3Tl911w212L5av+1HUDFwkxhVfCHieQAU38MCboS2EKEOSab
 rsjbW75z1EVrIfSOL5GK1OcaSnflx88Hiu9Mcqjafm6PNafFAB8YsWzKq0CG3DA=
X-Gm-Gg: ASbGncs28rIq3h1BgT+I1t4rgNcghycfhTUqm3puVdpMtnZYgAas66ABjSB6BFDqRNM
 Peo6cIiN1nVslWlePaDoOy5gRz7HtmXsCwnGYDhhbCAqyrGTdnYFLXfgQPDwb7J73Q4+ieng+lO
 udSzDtNiYr+Nu7PhrvOX/mq2+tgQ8pv7aI9nm6dZr4IMZzzcwL+RvuCN/FdWADpxf5lzvRGAZgo
 5f+RUEMMsFTg9/cOk4bKQ+y8N3EjvWRlMvw6vdU1RyVV98aS14KRJdCiphPq8/cDtuU5/6YdSty
 8Ycd/JhJdWIgEKSspGfFiVYki4Hu1Pl/pSe4Yha8jjrA+smPWtjZ84351HQ=
X-Google-Smtp-Source: AGHT+IGvjxb+HaM/SomSt1M+0VNyuws3nFOCzD1pP/ltJao3HNpfbG/jgnMm9L5J/He6X/vzJBWCGA==
X-Received: by 2002:a17:903:40cb:b0:21f:61a9:be7d with SMTP id
 d9443c01a7336-22428c0d519mr385201745ad.49.1741869692898; 
 Thu, 13 Mar 2025 05:41:32 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.117.79])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c68885a1sm12219615ad.13.2025.03.13.05.41.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 05:41:32 -0700 (PDT)
Message-ID: <7065e45a-bc19-4276-a8c4-12c10a3edbe1@ventanamicro.com>
Date: Thu, 13 Mar 2025 09:41:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target/riscv: pmp: exit csr writes early if value was
 not changed
To: =?UTF-8?Q?Lo=C3=AFc_Lefort?= <loic@rivosinc.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20250225160052.39564-1-loic@rivosinc.com>
 <20250225160052.39564-5-loic@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250225160052.39564-5-loic@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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



On 2/25/25 1:00 PM, Loïc Lefort wrote:
> Signed-off-by: Loïc Lefort <loic@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/pmp.c | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index e0ea436f8e..e4fee10d93 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -141,6 +141,11 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
>   static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
>   {
>       if (pmp_index < MAX_RISCV_PMPS) {
> +        if (env->pmp_state.pmp[pmp_index].cfg_reg == val) {
> +            /* no change */
> +            return false;
> +        }
> +
>           if (pmp_is_readonly(env, pmp_index)) {
>               qemu_log_mask(LOG_GUEST_ERROR,
>                             "ignoring pmpcfg write - read only\n");
> @@ -528,6 +533,11 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
>       bool is_next_cfg_tor = false;
>   
>       if (addr_index < MAX_RISCV_PMPS) {
> +        if (env->pmp_state.pmp[addr_index].addr_reg == val) {
> +            /* no change */
> +            return;
> +        }
> +
>           /*
>            * In TOR mode, need to check the lock bit of the next pmp
>            * (if there is a next).
> @@ -544,14 +554,12 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
>           }
>   
>           if (!pmp_is_readonly(env, addr_index)) {
> -            if (env->pmp_state.pmp[addr_index].addr_reg != val) {
> -                env->pmp_state.pmp[addr_index].addr_reg = val;
> -                pmp_update_rule_addr(env, addr_index);
> -                if (is_next_cfg_tor) {
> -                    pmp_update_rule_addr(env, addr_index + 1);
> -                }
> -                tlb_flush(env_cpu(env));
> +            env->pmp_state.pmp[addr_index].addr_reg = val;
> +            pmp_update_rule_addr(env, addr_index);
> +            if (is_next_cfg_tor) {
> +                pmp_update_rule_addr(env, addr_index + 1);
>               }
> +            tlb_flush(env_cpu(env));
>           } else {
>               qemu_log_mask(LOG_GUEST_ERROR,
>                             "ignoring pmpaddr write - read only\n");


