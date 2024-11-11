Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CCBD3ABD1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 17:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAY03-0002Ai-AN; Mon, 11 Nov 2024 12:14:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tAY01-0002AL-NQ
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 12:14:49 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tAXzz-0000XY-BQ
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 12:14:49 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20c6f492d2dso52058015ad.0
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 09:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1731345285; x=1731950085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FvJpmxn9dA9G0Hkf1psqN9azG+mbfqPnQgQV1nvDsMY=;
 b=Og2ovTJ1iFtF0MeWNAsTFEN7/RO9aaV7AB7Dq4y07zAkS3ZVJknNmQ3FsyzI/xmM95
 qvxiMDcjiqz6Sz2nLLGkHL6D404iHGvZtjKXonXK34a9nkHDpivahsuELvWH292g39rI
 3gli3hmaqHqgW6hSFsBsyUbDHSqlSNtkSu/oHayPogbynWSkwGd7dwEJ8IVZhI1b+TWX
 f0LStALS8JWo+xUUnvYllm5h2KJf9l6+68M5n2TGEhV47zn5Zj93y0+pUvQvlW5iwrN9
 pKic7+VNtbstAwBipkOMy/VZJhFAL+RBBEZalY+uF0UQ4HgnEmejo9gjrBMItcwUDviX
 D34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731345285; x=1731950085;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FvJpmxn9dA9G0Hkf1psqN9azG+mbfqPnQgQV1nvDsMY=;
 b=iCFOeFRoDhZRQAI/hOrSP+iUWz4kAqsWK7xylAHRbN0aFwOwe6yrZ7ZExYXrvLqoV/
 RAql4OqtfNn3fT2wks4ZM7NuD03dM+qiIF24VOMv6H0qLwCimMRqF8g2hpsL6T8QJ7qn
 eRI6C7qvyq0C6eS4K5L4NfDDc4FvvGrSzYblgv87nGIqQTBo6Ajylw4+OatuZ6Z8/PPU
 07Zmu9WPFBLcFoGxi+LECYGB+pInHHQSWl9d2bVb8Ok9CZZoVgFzB6XXGFfvx78ZQwiq
 a4okejwOXJaShaB1KskUk/YfYQ0t8K3ZOHj5s/eWGOKJs7XPywENTXOGk30dygXnow01
 RM9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtocDCC/PAPmj/kgPhr74TithJasls+TD5QjMyP47ndfYF9U3+qIhsSLmgusBFwRWQLBnIYzSPhqy7@nongnu.org
X-Gm-Message-State: AOJu0YxqAuLgNHHw3YNcQnUA5SjaKTaDfe0eztTpAeOABcrYDEM03Xh9
 6AZS/w/qT4ACRwnidIL9pbfnUHmP/SWfBkOR4MB2OGjGLtvnivyP0TjrOG2ssfc=
X-Google-Smtp-Source: AGHT+IGSbKDGMpEdz5F5+sU2xqZK5Eb1VDTnDouZBkPXrzdxOE8jH7YmqGtZ4cc8Lpk0jAQgoSJ96g==
X-Received: by 2002:a17:902:ea0e:b0:205:8407:6321 with SMTP id
 d9443c01a7336-211834de2a4mr193452805ad.9.1731345285215; 
 Mon, 11 Nov 2024 09:14:45 -0800 (PST)
Received: from [192.168.68.110] ([189.79.22.174])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177e42b68sm78041025ad.148.2024.11.11.09.14.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 09:14:44 -0800 (PST)
Message-ID: <1229441f-f9e1-44c0-b20e-8df3c45da5dd@ventanamicro.com>
Date: Mon, 11 Nov 2024 14:14:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] target/riscv: Enable updates for pointer masking
 variables and thus enable pointer masking extension
To: baturo.alexey@gmail.com
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20241108060116.37397-1-baturo.alexey@gmail.com>
 <20241108060116.37397-8-baturo.alexey@gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241108060116.37397-8-baturo.alexey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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



On 11/8/24 3:01 AM, baturo.alexey@gmail.com wrote:
> From: Alexey Baturo <baturo.alexey@gmail.com>
> 
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
> ---
>   target/riscv/cpu.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4e80dcd2e6..13b2c56a72 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -200,6 +200,9 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
>       ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
>       ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
> +    ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
> +    ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
> +    ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),

We need to keep these entries in order as expected by the riscv,isa DT. There's
a comment in the top of this array with the reasoning behind it.

For these extensions this would be the order:


--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -186,11 +186,14 @@ const RISCVIsaExtData isa_edata_arr[] = {
      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
      ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
+    ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
+    ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
      ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
      ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
      ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
      ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
      ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
      ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
      ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),



Thanks,

Daniel

>       ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
>       ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
>       ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
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

