Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07177C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 10:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbH9u-00039E-LL; Fri, 24 Jan 2025 05:43:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tbH9p-000378-Cd
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 05:43:27 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tbH9n-0003qt-FE
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 05:43:25 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2161eb94cceso23453095ad.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 02:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737715400; x=1738320200; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a94Y2oA6y/JmC15kO/nfePD/EsGA0LKVOYhCU0f9NEk=;
 b=A5+mZ+t966HHpWcyWfv1Gm4aJ/x1ns032sVCsaHpFa1bD3R8pfCxpLvuuspLP4W8EJ
 QnqIQatOQJHMEhdN9hkzgeS9zBQTHKCJ4TZEyv87OFTz04dbGjgDSx6KuF2T9l9Hem3e
 I9UOBgDgZY2Fa3XujakxGi6bD2XZ+DtUYaPER6b6OP4/ZlVjvc7MAIgPllA0Q+LZNwYl
 LE/8No13Xw+5uVdKPTIGNSgsCeQw83fAaQiTo3JQR8Gt2H38B6RRbt6rwsmbQ4x52Ota
 G2kwifZ8h9VS84ZrmZISeHtaOf7HB3+76/i1fyiClVFYx9MetJ8+2HxzJ15nfWwPV4zw
 yiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737715400; x=1738320200;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a94Y2oA6y/JmC15kO/nfePD/EsGA0LKVOYhCU0f9NEk=;
 b=hTeKGoW47ubNa9FOJ6DcAL8VDAFpsFDt1+5hznUMc2RnQbbjZvEtpmueiIjj85Ek7E
 A+xbi0sDTfWo2gmIRzPp61dZmxK3c2IT3+SJ5PWTQD2e637/6q4svupuQtMfMgwQ93Ch
 qKla2yQamYJdgqryySf1aifI79S0CHn6DPuTxuFa4Ruq5Bpp68/6jwifZ7aDW616wErq
 JhPf0n9H7LNxGRpycyb40NpCZswiBzKB34jBvqxj98Qr/ST6x+LjaWYzYcHR97dq8hCX
 nMCxpdHbpR55kmGMb75cjxo7WbJuB9WrAZp/YtWhoxXgMvJAOdtvgM8yyJGf3rGXwvmJ
 c8Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4TqKi62Pi9V2fXfUN5KvGKllphOY3pfJsW95CRCv8QFTbaJwTpk5ZuttAYAy+MEJfKCyuiZMqSjvr@nongnu.org
X-Gm-Message-State: AOJu0Yxp+EG6smfFcF2Q2f8dgtMf6B+eyyb/yJFelPMUvRgs7PwmHLqx
 vHH1jMWjI2sfzyFotdBLTTsYjuvj3wxakvfxvOb1QcBLDCVTILkDnobF7GA0WAY=
X-Gm-Gg: ASbGncuQtbOG+GBfZfighQ1KpqVeKqit2xmkiGhPOlvsfQ/5UiePGWVwWUTLUpKdYyy
 H7ZNDYpYe7tEfbqvExFC22CoyqcmygmIdFCSj5t/yA+kS7N1GWWhmpyy9gXAkWCt3KYfusPDCYr
 Rd5sJJTDZFWJ6mGFiecZAFAXJGYjZmfEi57Hb043dJ+cgqzvWBDuxGr5APLZVVYKdzvCnr1xLAS
 FC0nW2PXD3hOdutuxpcUx4F7aMg2WZIK0RBERVykww9v3oknh2F/r0wIj/6sInMBbdupL7f7eXR
 ZCsjbaPQxk+PBx4V
X-Google-Smtp-Source: AGHT+IH9xdOvBCUfCc6O/KC8c3FtiYNp/uUrwW8tzCsrLnv762c2WaiPxnCm01mBkz6os3wHeuv0dw==
X-Received: by 2002:a17:902:c948:b0:211:efa9:a4e6 with SMTP id
 d9443c01a7336-21c35549ac9mr449678965ad.23.1737715400477; 
 Fri, 24 Jan 2025 02:43:20 -0800 (PST)
Received: from [192.168.68.110] ([179.93.20.76])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da414df58sm13144555ad.187.2025.01.24.02.43.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 02:43:20 -0800 (PST)
Message-ID: <eafa7909-14d8-4000-b505-ea937f21f89f@ventanamicro.com>
Date: Fri, 24 Jan 2025 07:43:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: rvv: Fix incorrect vlen comparison in
 prop_vlen_set
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20250124090539.2506448-1-max.chou@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250124090539.2506448-1-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
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



On 1/24/25 6:05 AM, Max Chou wrote:
> In prop_vlen_set function, there is an incorrect comparison between
> vlen(bit) and vlenb(byte).
> This will cause unexpected error when user applies the `vlen=1024` cpu
> option with a vendor predefined cpu type that the default vlen is
> 1024(vlenb=128).
> 

Fixes: 4f6d036ccc ("target/riscv/cpu.c: remove cpu->cfg.vlen")

> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 3d4bd157d2c..2f53acbab59 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2034,6 +2034,7 @@ static void prop_vlen_set(Object *obj, Visitor *v, const char *name,
>                            void *opaque, Error **errp)
>   {
>       RISCVCPU *cpu = RISCV_CPU(obj);
> +    uint16_t cpu_vlen = cpu->cfg.vlenb << 3;
>       uint16_t value;
>   
>       if (!visit_type_uint16(v, name, &value, errp)) {
> @@ -2045,10 +2046,10 @@ static void prop_vlen_set(Object *obj, Visitor *v, const char *name,
>           return;
>       }
>   
> -    if (value != cpu->cfg.vlenb && riscv_cpu_is_vendor(obj)) {
> +    if (value != cpu_vlen && riscv_cpu_is_vendor(obj)) {
>           cpu_set_prop_err(cpu, name, errp);
>           error_append_hint(errp, "Current '%s' val: %u\n",
> -                          name, cpu->cfg.vlenb << 3);
> +                          name, cpu_vlen);
>           return;
>       }
>   


