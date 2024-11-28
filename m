Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43860D690FC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 11:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGcs8-0005b1-E7; Thu, 28 Nov 2024 06:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tGcs6-0005Zr-FG
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 06:39:46 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tGcs4-0006dP-U7
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 06:39:46 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7e9e38dd5f1so535209a12.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 03:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1732793983; x=1733398783; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PPTle694muH71SqXuAY2b6Z5zXR+XiV55VvNNcZmfig=;
 b=Y0pNlyc89US9wqa9g9Zi4jAJtUKbGkDJz0ZZhtwuK2U9ayFF8Z2hUMg6HfPwu22l/c
 qTig/S3Xx0gy2KoOZTUdkn3vHTJdDsmsu8fKYm4QC1gSUL3lYccL0xLCK6W76QNIAny+
 htRbgwO7qQkGhCQVwuv4tX8sajM5PEEoltHsJRWlrBPNDdMOhZsyVqSjCegVm1gQJeet
 9q4FC1KKykVHxC7TJawvOoG62GA5g2MzNlHloVLA6WcsX+CLRq5NZIpUB2c7v08e8E+F
 YSJw6mrf8O2tLw3iXmm+G0/6euZHgKjc/dZ6jzCAYwnc0Fv2g7JQi/7O6kSjTZRz9etn
 /gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732793983; x=1733398783;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PPTle694muH71SqXuAY2b6Z5zXR+XiV55VvNNcZmfig=;
 b=FudS8Xa+7d5NFg64gzfw0fJcTlRqrwqkpWUp9apss7lYX67cZotkIQR+YVkhjKSbNY
 5yBuba1ibnwM9fJOpzlPGDwq8dHRnnVAtoceqzuBxpwEVQYa9neG/EJh2BfzMBHQIgTP
 ma1BvA/1p5clfNIbKDJBs7IQBmN1YfJByV+K1LV9VlbqUSZE1Kbx+vtqXBA0Bv22AAv1
 eA0OurkumfcMdrGvAfF4UkRw9sDOfR3IeimwQWNq88woh1YGkDznIE13UheWoeCHk/Cj
 olWpZtWEDwwwwL5iXcDKU9rpf5HwfQrXQ5/zRdrTq0APdCHwOxgOcedTmcUj/ROEtq8F
 O4Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpp2YsDO/LLgHFznWaFJYFcL8vmzQ4AaxLdb2NnQpTiVG3fIkhuPpa+Olfryb+iOaIXbS4o1ORW2sv@nongnu.org
X-Gm-Message-State: AOJu0YwkHT8TCyhrvu2eCXLP/GB+suv0PGxJACV0duLyVl9IRzPvTy1/
 OW3kK0r5f6Dsz8B6e/4qoyCP7ULj0BHFIhtpPMoxKc8viKBmcqjM/rW5+qHBsoE=
X-Gm-Gg: ASbGnctiNqb4vzkGm6uBE+nZ/mTf4o6glg9JyduCVhDSf85re5WfAxKd9j9wnxrcYQ4
 W5HZaccyO0C7Gt4A/rhm493/5Kps/q53XqMyNFE0Ns85BDY+YHIamzT0szeMBisiUpP8WtTnVh3
 Hw8fQFeCH/+oQXt6e2A3B1ScP50XMHPmKpzsLr11zw0l1Hp/rpJ7NoYLFN+0fI2eU9T6mDXMz3v
 fqIwTEszcDGoxt33VSdfEIDm0WBKwT9Ml6GmbRz43Ky358kTHXn2HBgnJRaTHE=
X-Google-Smtp-Source: AGHT+IHyotzL1LGCNKHY8WQBLxuA8uxTXj9Atq6Fv4nKoeHFN8PenTYU40A+QQafysSI+LVNxT6V8w==
X-Received: by 2002:a05:6a20:a11e:b0:1e0:dc5b:6e21 with SMTP id
 adf61e73a8af0-1e0e0b20763mr10508115637.21.1732793983529; 
 Thu, 28 Nov 2024 03:39:43 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21521967278sm11583475ad.161.2024.11.28.03.39.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 03:39:43 -0800 (PST)
Message-ID: <417a12ac-f8be-4bb2-94b5-50f74e46a98c@ventanamicro.com>
Date: Thu, 28 Nov 2024 08:39:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] target/riscv: Add properties for Indirect CSR
 Access extension
To: Atish Patra <atishp@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, Kaiwen Xue <kaiwenx@rivosinc.com>
References: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
 <20241117-counter_delegation-v3-1-476d6f36e3c8@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241117-counter_delegation-v3-1-476d6f36e3c8@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x529.google.com
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



On 11/17/24 10:15 PM, Atish Patra wrote:
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
> 
> This adds the properties for sxcsrind. Definitions of new registers and
> implementations will come with future patches.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   target/riscv/cpu.c     | 2 ++
>   target/riscv/cpu_cfg.h | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f219f0c3b527..963f1f3af9ae 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -185,12 +185,14 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>       ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>       ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
> +    ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
>       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>       ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>       ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>       ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
>       ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
>       ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
> +    ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
>       ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
>       ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>       ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 59d6fc445d18..8b974255f6fb 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -79,6 +79,8 @@ struct RISCVCPUConfig {
>       bool ext_smstateen;
>       bool ext_sstc;
>       bool ext_smcntrpmf;
> +    bool ext_smcsrind;
> +    bool ext_sscsrind;
>       bool ext_svadu;
>       bool ext_svinval;
>       bool ext_svnapot;
> 


