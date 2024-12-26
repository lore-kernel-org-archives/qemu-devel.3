Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F68BE77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 12:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQnLY-0005Me-2A; Thu, 26 Dec 2024 07:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tQnLT-0005MH-Vf
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 07:52:08 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tQnLR-0000X1-0Y
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 07:52:07 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso73463145ad.1
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 04:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1735217523; x=1735822323; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LHZTCdRHQ73uSmR2VAqklpdIcw97hULw+PhyguzzYdA=;
 b=V3/IEn/hd06ZrByxDE2G/WN5VkxnPQqcYYfwTU0IwbMuE7O7FQZQehqOcVI4E0zpRG
 YdVhaBTW8LwZapt/DrBtSNrmwVpjuLHSZHjJo31m8XwpOZVzmfWb3XL5AycitN+jvyYn
 JUsZ+Z8P2lKVoOucodIvywj2v12N/rm7J+bK0esJWgm90U4SlTOomcJ3zFipV2tC0ck5
 5qOqcvBXelAHMmv9qH7UyYocc83lis9d+IClFUl4qgrIwgvi1XJkwWaNGsAlMkBchhql
 yNusPtqXg0TI15t/fjAiF5LzJbWdMSg87jpZyae81gsbuZkvff4cXzXiDtVOuouz/Mis
 rVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735217523; x=1735822323;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LHZTCdRHQ73uSmR2VAqklpdIcw97hULw+PhyguzzYdA=;
 b=bN8IU4Wjm/qvS/Jp6VB2cD930YucQTTldjOk+yLjjnVx44x2cTB1Qv4BiDfISCgVfO
 KSHznVoYXSsLlmKsLFRgyp3wz+1JeOt/3sEEFTnOErKzqXEOwcIIYnCKI5RVhptjPPBt
 9hrcK8zfS+Loy/Wewei1DXZWCYL9XVJlhR2PtBNI3xyZKljA69ZKTbXcQboPb4cyOCWc
 FgV/Rd1jytCCuL36unD6k8fTOxfGiS0FGhK4ar6uoqT9jKQ6ORiLfoW74sRBdiNfGBo1
 a871QCv6bYrLicc+G2GSm+V8yWP8Vlh1+zbfQrlde7HgP70k8ojt1nhs75gxgkY7r9Mp
 SMpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOisAoY9IwnsacJYnhad75Dp/jhUPzeKwxYVj4g8WGTAAjvcrFoMlfPDb8S8pfijq4+GgEcLf6ZIQb@nongnu.org
X-Gm-Message-State: AOJu0YzJ71u4TrhtOj4lhLhAgEuGNI7R2+5O8m4wovupSKCOwMwOpBnC
 1tz6ahWqM5X+mwvGb6vtHkorZ7oPKYTOaWTaJnlfWd39MyJcHAZKoSrU3F5H8fg=
X-Gm-Gg: ASbGncu9LAVfn1Loby8Vf0Ta8NjdsiHeBDGKKl7dBasGyvhHq+oUFgm1qW1WGs2RB4/
 8Ucdx+fYlfQ769yls/ZVzN/y75f4wTYiyPRUu8VFmU2eKMQmGgUAtVERKDa31b9x1zpyjPQ9ssu
 4PSNAL0CJqfCfqGoteaPPVg2wWOdC2716NpESSjg7t49e+hruvsPXDVk5Jbv03y0n0ojvWCZENe
 Ks2RAyo9Jf0PizRHa4CCBQjmHsYSods9JesUGp2f7gwTpeQY2xIiHmS9g44mAm9xb293Q==
X-Google-Smtp-Source: AGHT+IFJKObzwc/w6Jo+83aLDHE3espYgT//2q/iD6hVTKPgri7nLMMrSMBPcs/DTIwLLuSvamjDzA==
X-Received: by 2002:a05:6a21:6da2:b0:1db:de38:294b with SMTP id
 adf61e73a8af0-1e5e0819216mr40108545637.38.1735217523523; 
 Thu, 26 Dec 2024 04:52:03 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbbabsm13294859b3a.101.2024.12.26.04.52.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 04:52:03 -0800 (PST)
Message-ID: <26ecf1ca-07eb-4aed-9d06-a12c036c0723@ventanamicro.com>
Date: Thu, 26 Dec 2024 09:51:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 5/7] target/riscv: Add Smrnmi cpu extension
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Tommy Wu <tommy.wu@sifive.com>
References: <20241217062440.884261-1-frank.chang@sifive.com>
 <20241217062440.884261-6-frank.chang@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241217062440.884261-6-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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

Frank,

I believe patch 7 should be squashed in with this one. This patch  will break
'check-functional' because the 'max' CPU isn't able to support Smrnmi and we're
only fixing it 2 patches later. In theory this is fine but it can be problematic
when doing bisecting looking for bugs.


If you merge patch 7 with this patch please also add:

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


Thanks,

Daniel

On 12/17/24 3:24 AM, frank.chang@sifive.com wrote:
> From: Tommy Wu <tommy.wu@sifive.com>
> 
> This adds the properties for ISA extension Smrnmi.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
> ---
>   target/riscv/cpu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e6988f44c6..7a4aa235ce 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -193,6 +193,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>       ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
>       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
> +    ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
>       ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>       ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>       ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
> @@ -1621,6 +1622,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>   
>       MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
>       MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
> +    MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
>       MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
>       MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
>       MULTI_EXT_CFG_BOOL("svade", ext_svade, false),


