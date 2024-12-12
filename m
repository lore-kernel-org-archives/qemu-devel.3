Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF93E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfoP-0002RU-4B; Thu, 12 Dec 2024 04:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tLfoN-0002R0-9j
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:48:47 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tLfoI-0002lB-GR
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:48:46 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7fd45005a09so277007a12.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 01:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1733996921; x=1734601721; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rIDz21lKrXmJBL/1OJrlbrlC5z+y28lnfGL4NFm0vSU=;
 b=UMS9Nf+tn0WEmE6aTGrEala5RpoNpCrCH8tZEQJeJl+4/9Q3OVSkfev6EbQDasnlci
 2lNC0OhgnM0yCWhLjr+CUXeWZ3GKpA/9Ui4G2G7uldAgs3b+da9tOGmnq6snjXT+PWEc
 zwPUJFGlsnU5AAIa9omieIYUEntt8SoJXtzp8jM/ne/yBoYVS9fW2oh8zb2EQqepFFBZ
 kXjVKJ+wNEj3n0ND4aumkJrkOuxbIu6mlAFAyd/xCezbbLohMhMX7qp0OBaN2cowzA2K
 hECWgUwJ2jpncOr4b/HC2AgV2F4koXVN5IrqAQf14UUbODTSZ4dRwUvk3E2mLpNCC7Yp
 WgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733996921; x=1734601721;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rIDz21lKrXmJBL/1OJrlbrlC5z+y28lnfGL4NFm0vSU=;
 b=CJVxP/4L1Rk28Th6dRRVAEklsBMUH6a7FeqhSj3ciYrQdccVIicEjIbX7XZYMq0Yuj
 gJkNj3ADpM/wbbG92BPOvU4kVL7YyQjzlMg8GLXEZoolhTxHVK6UXA5DnG6qsprPntsc
 xMWlBH4rK+TjsVcAvJfIK3qAaX+D+1nYIaYO4Rq+NHRaLElYF3SN1HfQRX/7PoZ2xUls
 HLD4pXXVkdcOjHb/s69Z7vyDwJyIs6ztpUb79ABx5uFjS6K/FMwmT6ip1gixF+wcdtEY
 y+zazIzmw71UqiofNKR6brokYgBUZoocqIpjXdzItwAZBnvJcUJc1IGSAxk07VpHewdx
 TeTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDHruEwTyg1RPsSzpDnXIdwFdp7BFI663X0DVSRZfNJGTY6gWENxODfcBO8Bixzk8MlU8+Pf97pF95@nongnu.org
X-Gm-Message-State: AOJu0YwSHo3pwTh510cSEHREFHyuEP+ZofVtY+3BF3R+WyfKhuVwRjaJ
 yavm21qXw/4RljdqY50qxdlrEi/l0HHSjYV3ojZdPBFDzf27HYB+YVitK/pnl7k=
X-Gm-Gg: ASbGnctyJClNoVSW5bW233Az0RjdJMtGWNXIGMyxztBSv4tSx46Ze52dO2sIrwQwDGf
 YoWkEvbm566920PsF7O3XYS6SjVI8l1W7AJVUWyfmrlokRGnSKgCc1WxhIMWBtF6+ONIQczG2Pf
 QqK1g67NxjwPEt51RsTe+kwNi/zaaPtWu17WQKh/qHryMNayxKiKAx1fFGDL7UVlzZXLbIafVQ8
 0IM0Ye/B/Ipnu7StywjT5nm4rZFM7vFM2Vfn/HF5xKvRnFBOwB/ObMT0kvnHsti2HSl8Q==
X-Google-Smtp-Source: AGHT+IG2BDTzyq3flsa9jNR4paMG0n5DCN5bB5H7mHWRFf2DqBtllmQp8D5Fq5aDrPFMuN91AoXTOg==
X-Received: by 2002:a05:6a20:2d0a:b0:1e1:ab63:c5e8 with SMTP id
 adf61e73a8af0-1e1ceb11828mr3765749637.26.1733996920705; 
 Thu, 12 Dec 2024 01:48:40 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-727ba09a13bsm4997043b3a.46.2024.12.12.01.48.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 01:48:40 -0800 (PST)
Message-ID: <69de5c69-1583-4a0f-9db6-c61e721adbe1@ventanamicro.com>
Date: Thu, 12 Dec 2024 06:48:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 7/7] target/riscv: Enable updates for pointer masking
 variables and thus enable pointer masking extension
To: baturo.alexey@gmail.com
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20241205112304.593204-1-baturo.alexey@gmail.com>
 <20241205112304.593204-8-baturo.alexey@gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241205112304.593204-8-baturo.alexey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x531.google.com
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



On 12/5/24 8:23 AM, baturo.alexey@gmail.com wrote:
> From: Alexey Baturo <baturo.alexey@gmail.com>
> 
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/cpu.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4e80dcd2e6..fd3ea9ce76 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -186,11 +186,14 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>       ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
>       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
> +    ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
> +    ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
>       ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>       ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>       ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
>       ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
>       ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
> +    ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),

I just realized that we're not adding "ext_supm":

"Supm Pointer masking, with the execution environment providing a means
to select PMLEN=0 and PMLEN=7 at minimum."

IIUC this is always enabled in the code so this would be a flag that would
be always enabled, i.e. it would be a ISA_EXT_DATA_ENTRY that defaults to
"has_priv_1_13". "sscounterenw" is an example of this kind of extension.

If that's really the case I believe you can add "supm" in this patch or maybe
a new patch right after. We need to advertise support for "supm" for RVA23
anyway.


Thanks,

Daniel


>       ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
>       ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>       ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
> @@ -1490,9 +1493,12 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       MULTI_EXT_CFG_BOOL("zvfh", ext_zvfh, false),
>       MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
>       MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
> +    MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
>   
>       MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
>       MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
> +    MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
> +    MULTI_EXT_CFG_BOOL("smnpm", ext_smnpm, false),
>       MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
>       MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
>       MULTI_EXT_CFG_BOOL("svade", ext_svade, false),


