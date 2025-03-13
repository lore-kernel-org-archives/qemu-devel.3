Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CA7C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 12:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tshpP-0006KH-DC; Thu, 13 Mar 2025 08:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tshpN-0006K2-JQ
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 08:38:21 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tshpI-0002sQ-9H
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 08:38:21 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fe9759e5c1so1575895a91.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 05:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1741869493; x=1742474293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bt4zRQBOYHSax/cei+k4mZ/WSu+wxrkNEI8A1aplspU=;
 b=LA1yYD5sk2QAzivRchr2laAxcKsDDRN0MZwJg5mARzWUp75wtbd12343h4DKOiB539
 FOOwlcrxhSscIGIae6S5GCP0Vd9RWpkCROkfzcOJGGitnOccYVtqssWqZ3SPidYvGpJM
 j8DDkEWzUMSuCeNpZOAyotkex8Ub/WE+kcaX4xTPsoEZGmxnPPlxLNK643Fo3PaTkBg2
 iBCNvhwSXlcz5SXbfZ9e/lGp/dVWDgX7xgHSO3ZdKaORiBKm85Q7cQ+IA8KpXrD1177V
 2pLaCsgtj/UCP5iN4Phg9ImHag283hCu+xgj04bzitUTQ3E3KBE5XpQleqt4TV1T2RgK
 0jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741869493; x=1742474293;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bt4zRQBOYHSax/cei+k4mZ/WSu+wxrkNEI8A1aplspU=;
 b=ntnjVILbHd1GkJAghv6QbkdAfBKRYJ9EtisIyGvEVCdvmDE2wkDZyTH0vYdvDzT1YH
 NbE3PfRGr17BWDNiBU6R6tethIsMFT9ZWBacEf8bVU9o5bW97L5yyWsydQ5hWMUBSk85
 LAUve2bwGQYJJalzOG5+3tf8zP8mVcyZhtbXcGnpPBD37QTrhg6j/F9A8o8+XmWE3kWZ
 5moz7zML02JqYTIRH6aOamzuJjK1wSu7dtesr5c3V1FwoAm8f1ZZuGnmFejyAl2XMCqS
 UkJeKR0kRMNTFKYjCdxgbwbU5ihsoyz+8Cnc+GgxTFY5TkhrNe4koh2gsgOE1r4EPAqc
 Za5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU853GU2v5Me70xSNGBWqx0Ag8Prx1tQc20xOe9EsFeX+uBN8H5sehykcv+Z2dlqPejY3d26nU14RtF@nongnu.org
X-Gm-Message-State: AOJu0Yy712fg7qx3Vq2o3Y3auKsvQqm25YM/yUwMoN3evPSabRcGullA
 C2qulwQQE4d5d/28jct21D3a793etAFxqrCR8BBYfoKbR8nmxRFB/34hFbs3sj8=
X-Gm-Gg: ASbGncvRm4MMYWEu9tiA1flAbR6QXe0YcEZBbRrgfZ+hvtrS8fd5sU3mUkyZAgps3RJ
 9hQfK3qlHv5sqzpn+DiQ3KkbbeQWRZcM4t8T/LXmOwas63JLQQFiKYcKp3BqLAOlYxt/o36S0OW
 MAnsbyl4e3T9mRmPk03TFARiblGv4p1ZWNKZlA2v8PMAwHU779FJNuNyPXA2UjPKoShGs2kjt1/
 twxZm1irEPAV090UoTqXahnex4bDAbr/htFQtQ12XL4kd8ZW56FfI4ziBjk+Z1/sOeGaSO6GwEF
 eUajl/GcZcggGAOYX2zXORT63o8iRP3hlpLbUQ7UXWtLzBLrLEDUj9ScPFE=
X-Google-Smtp-Source: AGHT+IEF4eUalHT6nffszNuhAjnWCNNoONl1J2H1VHaxg6T0KJUcji1SE9KlnWY53nzFqwLBG4ACTw==
X-Received: by 2002:a17:90b:4c48:b0:2ea:a9ac:eee1 with SMTP id
 98e67ed59e1d1-300ff0d49damr15551960a91.10.1741869493007; 
 Thu, 13 Mar 2025 05:38:13 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.117.79])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30138b5d279sm1235975a91.26.2025.03.13.05.38.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 05:38:12 -0700 (PDT)
Message-ID: <871134bb-9627-4403-80c0-ede30216e978@ventanamicro.com>
Date: Thu, 13 Mar 2025 09:38:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/riscv: pmp: move Smepmp operation conversion
 into a function
To: =?UTF-8?Q?Lo=C3=AFc_Lefort?= <loic@rivosinc.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20250225160052.39564-1-loic@rivosinc.com>
 <20250225160052.39564-3-loic@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250225160052.39564-3-loic@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102f.google.com
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



On 2/25/25 1:00 PM, Loïc Lefort wrote:
> Signed-off-by: Loïc Lefort <loic@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/pmp.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index ddb7e0d23c..b7f1430ff8 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -31,6 +31,15 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t addr_index,
>                             uint8_t val);
>   static uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t addr_index);
>   
> +/*
> + * Convert the PMP permissions to match the truth table in the Smepmp spec.
> + */
> +static inline uint8_t pmp_get_smepmp_operation(uint8_t cfg)
> +{
> +    return ((cfg & PMP_LOCK) >> 4) | ((cfg & PMP_READ) << 2) |
> +           (cfg & PMP_WRITE) | ((cfg & PMP_EXEC) >> 2);
> +}
> +
>   /*
>    * Accessor method to extract address matching type 'a field' from cfg reg
>    */
> @@ -357,16 +366,6 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
>           const uint8_t a_field =
>               pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg);
>   
> -        /*
> -         * Convert the PMP permissions to match the truth table in the
> -         * Smepmp spec.
> -         */
> -        const uint8_t smepmp_operation =
> -            ((env->pmp_state.pmp[i].cfg_reg & PMP_LOCK) >> 4) |
> -            ((env->pmp_state.pmp[i].cfg_reg & PMP_READ) << 2) |
> -            (env->pmp_state.pmp[i].cfg_reg & PMP_WRITE) |
> -            ((env->pmp_state.pmp[i].cfg_reg & PMP_EXEC) >> 2);
> -
>           if (((s + e) == 2) && (PMP_AMATCH_OFF != a_field)) {
>               /*
>                * If the PMP entry is not off and the address is in range,
> @@ -385,6 +384,9 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
>                   /*
>                    * If mseccfg.MML Bit set, do the enhanced pmp priv check
>                    */
> +                const uint8_t smepmp_operation =
> +                    pmp_get_smepmp_operation(env->pmp_state.pmp[i].cfg_reg);
> +
>                   if (mode == PRV_M) {
>                       switch (smepmp_operation) {
>                       case 0:


