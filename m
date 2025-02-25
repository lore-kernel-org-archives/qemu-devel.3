Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DD2C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 11:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmshM-0007d1-5D; Tue, 25 Feb 2025 06:02:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmshK-0007cC-8d
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:01:58 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmshH-0006VX-KK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:01:58 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-220d132f16dso83051395ad.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 03:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740481314; x=1741086114; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kWj4Gw4QLDavintsI+IMkllMQCDHkJAnVmtOi9brmUg=;
 b=arTqfI05qfcJ8HC3DZ0h9eki16tz/+cfhcy1E0OA6SCFLTX4Srpp/dIjPnHxM+9VQz
 leOI1V8/eVoNlK/7UkoUm+1OcbkniakSOLxbver2OR0+o9pJOk/5JYJGNfPP9Yag7CKQ
 /ht/MgRWJrMNPHbWnhqM8rk2Cg+oHqNIdZZHNviGV5wceYt2r8rB3XqKQTtyRqLTHlWl
 bdlr6itESviH/Nf02oDKkZV6+MhHhN+ul4R7MBZwrxsRwUezse3a/9ZIDLWWGwq1y63z
 axSRxgQPqxW108jQDrT83JU4LfdLYlwXCWvpLG4b/99mlogYKScCO9SXtddqzFZW128D
 s3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740481314; x=1741086114;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kWj4Gw4QLDavintsI+IMkllMQCDHkJAnVmtOi9brmUg=;
 b=E2hPnsUFR2lFcTKqXjIkfP7uRSb4DQW3LU0T64TzurQeFHstXtN6XT5AmpuyRTsL5+
 ZyZ0tKSh59Pa37x/4ICJ4m5rnBWAoVIp+lDN1f5hsXDHBQoPXUKGmHlOINEIHk+oDzlB
 ZO8z0uRG+FKHFGrHNOQUpQYAVNU6RfG+5nlMm0ovH054WQsH6x/5IuKZiAkNEZp0GkYy
 Gusk1+CzdrLkju9/eYOrLG2CTSPiKK39DDXQsD/cvnFsJI8iv/J2P/7mZ71G6Cj/+9ZK
 Ms+37t7gaDNng+KOBwT+oI+7/ygWfdegZ9tIrAPEb/t7688pJZVy3n6Y36B543rJVL0b
 YF3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdA/VgOhK7+i/2PF5xVJ+ZxiRaf6EI1AdZWnUMC7DXCWUfIbVZevTT4ZEFdjMwGr/og+uHvkmxtoev@nongnu.org
X-Gm-Message-State: AOJu0YxePOEPr7bezvPaCqVWBSbnRltgN9Z8FIRmRAPytxrT5QjKrQJF
 ONjiCWMX0t23zQRMcNbiLhI2AlX354afLsaQmhwhAyJ8tGEBeCT1z1hijGLVwK0=
X-Gm-Gg: ASbGnctz2wFhbZmg8Mc8Hi3cSFOPtvJr5Bzti6B8B2leZl6uZOy68i7NYZHvPO9UnS7
 IBFISyXy+3wgH7kYPMQBUd8fJdxM1O24Hw0mULL8fIUQAGLNOwbr+9AjE6xWT+nXXNeOfRHqehb
 63wDC8HnJgOigHxJ2kAQmhJI10hI/83PiKKwDDHGMo0Xtg6SyI+K+TtPoUm5C/IxyZjF1dUpNN0
 v54zcr2sggeGmIsnM6AQaZnhXjHgx+S7QnNtc2yOtigZyT6Ds+T/v+yOVgE1Fd9sYU3Mw33Y45h
 ROTtf+Da8QEHmNjTID+RJ7l61DifObNm217eohP6tw==
X-Google-Smtp-Source: AGHT+IHupW8diNpBgOrKQblxrnFFrKVAtuvGJSQvZ51dRGGLxWxsVmBJR2cva3uLBlaAmQPh+6j/gQ==
X-Received: by 2002:a17:902:dac5:b0:220:e991:480a with SMTP id
 d9443c01a7336-2219ff50eafmr237292495ad.15.1740481314071; 
 Tue, 25 Feb 2025 03:01:54 -0800 (PST)
Received: from [192.168.68.110] ([177.170.227.219])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a01fbeasm11367675ad.86.2025.02.25.03.01.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 03:01:53 -0800 (PST)
Message-ID: <09717c7b-e67d-477c-8939-bc32040a2b7c@ventanamicro.com>
Date: Tue, 25 Feb 2025 08:01:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/kvm: Add some exts support
To: zhouquan@iscas.ac.cn, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com
References: <303616ccad2b5309768157b50d93b3e89fecc9cb.1740371468.git.zhouquan@iscas.ac.cn>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <303616ccad2b5309768157b50d93b3e89fecc9cb.1740371468.git.zhouquan@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
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



On 2/24/25 1:39 AM, zhouquan@iscas.ac.cn wrote:
> From: Quan Zhou <zhouquan@iscas.ac.cn>
> 
> When the Sscofpmf/Svade/Svadu/Smnpm/Ssnpm exts is available
> expose it to the guest so that guest can use it.
> 
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/kvm/kvm-cpu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 23ce779359..06a9f30841 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -319,9 +319,14 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
>       KVM_EXT_CFG("zvksed", ext_zvksed, KVM_RISCV_ISA_EXT_ZVKSED),
>       KVM_EXT_CFG("zvksh", ext_zvksh, KVM_RISCV_ISA_EXT_ZVKSH),
>       KVM_EXT_CFG("zvkt", ext_zvkt, KVM_RISCV_ISA_EXT_ZVKT),
> +    KVM_EXT_CFG("smnpm", ext_smnpm, KVM_RISCV_ISA_EXT_SMNPM),
>       KVM_EXT_CFG("smstateen", ext_smstateen, KVM_RISCV_ISA_EXT_SMSTATEEN),
>       KVM_EXT_CFG("ssaia", ext_ssaia, KVM_RISCV_ISA_EXT_SSAIA),
> +    KVM_EXT_CFG("sscofpmf", ext_sscofpmf, KVM_RISCV_ISA_EXT_SSCOFPMF),
> +    KVM_EXT_CFG("ssnpm", ext_ssnpm, KVM_RISCV_ISA_EXT_SSNPM),
>       KVM_EXT_CFG("sstc", ext_sstc, KVM_RISCV_ISA_EXT_SSTC),
> +    KVM_EXT_CFG("svade", ext_svade, KVM_RISCV_ISA_EXT_SVADE),
> +    KVM_EXT_CFG("svadu", ext_svadu, KVM_RISCV_ISA_EXT_SVADU),
>       KVM_EXT_CFG("svinval", ext_svinval, KVM_RISCV_ISA_EXT_SVINVAL),
>       KVM_EXT_CFG("svnapot", ext_svnapot, KVM_RISCV_ISA_EXT_SVNAPOT),
>       KVM_EXT_CFG("svpbmt", ext_svpbmt, KVM_RISCV_ISA_EXT_SVPBMT),


