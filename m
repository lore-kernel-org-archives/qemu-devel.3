Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DE3CFD625
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 12:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdSxn-0004Tc-Qd; Wed, 07 Jan 2026 07:48:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vdSxd-0004Nw-Fk
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:48:26 -0500
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vdSxb-0004qs-If
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:48:24 -0500
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-121a0bcd376so3074527c88.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 04:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1767790102; x=1768394902; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w9dhiS2HhMosdGRog3g+FdmkD6VuCCIZWnPz0uujd4A=;
 b=GeT9A63pCUDS1DAsUmWMR0wiuM3z4okK8OBz1iBi29Criu1VtSKQArV/zDksucKW4I
 73zt4mi06phgwlRfKQ08IlGywCdO9iP0aW76Q/HBAJCkSXd238b2M+xukptbjS5L21e0
 D1zUS6pXX6qSjDyKDCjs9uk9TgCRShvEwuX66G6hVvMk7vqWumohaCY7OOzgiUVXXyWY
 FZQBVaXGdTdIMM/gSZkmhaTOiAzDIcowEvVNONpBG9tq+QqkNhktUsVWSySsC6QjSeCD
 l3QU6tHaJ/dacj40gHDt20F0MLHn8+KJXR9Yn8Apyaa2lzuR3Kzf0YZrzAwDNzhsP9yd
 OC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767790102; x=1768394902;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w9dhiS2HhMosdGRog3g+FdmkD6VuCCIZWnPz0uujd4A=;
 b=NdtluthLd6SCie4IRiWb9PKocbSI/aJXvTpFxFlRjHmwYbV8ZjwYExvf3SySShNt++
 Bj1Lej8PFcnaWI1eIGx7ogGhB1A1z4iDzEZdsc8ONsdC93x50Sz8yDKNzm7PJIB55oQE
 p/5F/P6ZLSvJvMRLdVJXJ3sv0+JdcrJvHqRssOdKH8pJaJzv/SAWgX5Kf+UXle5An5no
 936Gs1griDSiHMOn9fakEImLdE+9X4JPrRQeZRcBrGKgfVzoqJh4ZF28mV4/DEHkWG7f
 IEFIVwASOGiw4nk8ApFosRrqDClPAwTvUt57YGiTfb/PhxdCpCeNTSkqnBLIU3ttE91j
 VeWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwZ+vIeap5HGK6uOqkpHJDRNSZG4XOYGs2YDE7oD5o7/f8B28bL5m80p7P5cXnE4kZ9g9Aworvz+gx@nongnu.org
X-Gm-Message-State: AOJu0YwEHN5vEIdfBNUZ+V91DKG2kToSu3xH6RS1ZJWOjJmUQZAgaZFR
 9B09n8bHcMQQY0Ho02s2f8hidMtDPhArfsxtGF4w/sPCfQ5cfsr+Igf32yxDWIRrAFg=
X-Gm-Gg: AY/fxX6rlmELj6+aPNH3T2ARJCGdmQLE9pOYx4Q2tqRaj/r6jiAkxpbLgo6xaERRyil
 5rHH5r/o+dcXj+/rFXnNecyrx/RwL2JNzT8c5K0xoniH3S9WZjhgr4ZeuvRqAuUlSoxAzA0D62S
 NDtuyxdNyRCmhXIL9PitquS+z9oN1815kCrkNWOIxx2qlb+DbQeaaf/Ju9EnTjOkkWPbj0nU6bb
 no6rPN9rvp+ImN++700Gd7sBd6Jpk+RBVBNzo8iTLuzkzqD3XJJGfP4I9cThUA0E8HftNgA24Ka
 OxpPUMHGOh3hTG7Z9kWpnUCbchTDYA0Momec7lv2T2hNzGNK0gaftFOO9OYxOz0yDu1s5mCQ4Ui
 y6Lt8mf5+gk+rvfw++NWyYwEFLgwhHxuxOwYPGlODi6NbfwgujlqzAr3LmTMxv0gBK2XvQ7RnyU
 VqiVgp2APv9ZaZydzp1SpZIji8lmt4SsBEH0bcN5AMcO6OubSL4UszMg4PSqqi1IADwWMjxG9a6
 GA3BPeL1/Y=
X-Google-Smtp-Source: AGHT+IHjk+qPi2Yb7McUJVloebrXd/jP5uJuka/69iWmrzqQjmijRREYdhUw+uo6y1au8ZZDE3KUNg==
X-Received: by 2002:a05:7022:6998:b0:11b:bf3f:5240 with SMTP id
 a92af1059eb24-121f8ab9d46mr1824876c88.9.1767790101875; 
 Wed, 07 Jan 2026 04:48:21 -0800 (PST)
Received: from [192.168.68.110] (200-162-225-127.static-corp.ajato.com.br.
 [200.162.225.127]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-121f249894fsm7819284c88.15.2026.01.07.04.48.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 04:48:21 -0800 (PST)
Message-ID: <b1726626-ea6d-4377-91b3-c6f668b441ad@ventanamicro.com>
Date: Wed, 7 Jan 2026 09:48:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Drop stray '+' in pmp()
To: TANG Tiancheng <lyndra@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org
References: <20260107-stray-v1-1-6658efecbb0b@linux.alibaba.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260107-stray-v1-1-6658efecbb0b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1229;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-dl1-x1229.google.com
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



On 1/7/26 4:57 AM, TANG Tiancheng wrote:
> Remove an unintended leading '+' left in target/riscv/csr.c (pmp()).
> 
> Fixes: cd633bea8b0
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> ---
> This patch fixes a stray '+' character that was accidentally introduced
> in the PMP (Physical Memory Protection) CSR handling code in target/riscv/csr.c.
> 
> The issue was introduced in commit cd633bea8b0 as part of the PMP region
> count configurable feature and causes a syntax error that prevents
> compilation.
> 
> Fixes: cd633bea8b0
> Link: https://lists.nongnu.org/archive/html/qemu-riscv/2025-06/msg00089.html
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/csr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 5c91658c3dc412c6f0e6db89120b935b4c0ea6cf..8c1312ab129f4fe6a21d4dff67b3a7d9ca175415 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -743,7 +743,7 @@ static RISCVException pmp(CPURISCVState *env, int csrno)
>   {
>       if (riscv_cpu_cfg(env)->pmp) {
>           int max_pmpcfg = (env->priv_ver >= PRIV_VERSION_1_12_0) ?
> -+                              CSR_PMPCFG15 : CSR_PMPCFG3;
> +                               CSR_PMPCFG15 : CSR_PMPCFG3;
>   
>           if (csrno <= max_pmpcfg) {
>               uint32_t reg_index = csrno - CSR_PMPCFG0;
> 
> ---
> base-commit: 0fc482b73d8e085d1375b4e17b0647fd2e6fe8f0
> change-id: 20251225-stray-d48679fda4a0
> 
> Best regards,


