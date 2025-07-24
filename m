Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207D3C87FC5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 17:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uezuo-0008Ju-6b; Thu, 24 Jul 2025 13:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uezuR-0007rF-7w
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 13:39:11 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uezuO-0000Ue-GC
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 13:39:10 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3122368d7c4so1083357a91.1
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 10:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1753378747; x=1753983547; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x0du0LYYRFJZvrVUEdmkuufspPWls3rIB5vgE9O3f6E=;
 b=o9KfMOX9VbyiSiJNPUkZdcUn8R/ye5wbxR9obFnHUQ8URTDszyATWWRizbI3oQf9EW
 7m9CVpmzFKsRuBKgR4Qnx59uyBcu61SdNtGup1T9eOsq2M/CpOKJ+K1rAyUFfhLBeLSb
 pDfW+bTdl+8h7FX1gumZWNq5Rd09tEf9IniIHhepyeFoSdQMKeo9zdTQuG9MXGVnHX6f
 vAYwaBeDPS3wAh9i57mQqhh2Eci0fxqBlSk4ubOjI12l3EaRBUOpApNyjg+pdni0LG8z
 ygSgYOfw3w0LXO5253tIDMjNnOK5T/eC5XKpZW0+oX3A2zfAtoB3FAfj7vt1uPTBEIIz
 uvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753378747; x=1753983547;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x0du0LYYRFJZvrVUEdmkuufspPWls3rIB5vgE9O3f6E=;
 b=CPWoiIfTXg3y/X5/FANe5Gh+SdeeCDlLlm6ir2Yxr1jGBEUVtFm8HXNN/ps34Y6zql
 kbvqjg+wpATVIYXRlK79XDDrFsz/53J13Xk5ZDUY4jLUVUKAIkmxoCFT/+uay/Nv679S
 iOB4e2b1DOsisJx5RJGdWAO3qu4vKjWqLQP+DJo06Wkl/TINcvt5lRQyj3K3VBJXL5Fs
 O6KL4gRyITMyvWXPvWWk3HNB1KJm/b380uAnO0d4O8DWQWFn/xYd5TATFxI1EpJT3ypy
 aPrzCNs6l9E8I1e+qszx0cXnrqY44lZtoUWWsSxdYvniNjoC8C7+Za+LrdZjn5K7uqNi
 Jzsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU74j7GUnXZvqs5yCnWLPyUby32SEUub6pSb+6pCrRrCNRRSJkx56N1t5cqQfrjxYa0xxOIoMQGURYp@nongnu.org
X-Gm-Message-State: AOJu0YxCIq+DP3RUhL2suhLoV7XBtGGIEY3KYvcfZ6LRyT+NEvaNHsgI
 L17spgqj7i00/ZOcw/O/5gFg38gMNuhkXVNnmnb6BtD3cORer4maBqFquj8u3jRTfSI=
X-Gm-Gg: ASbGncv6actRe0xlgjpHM53umeXJ0/4YWPtZRSCkwMeF2yD7BfqeGtopBJIswYZg/2G
 bEAxswWfTmnA3zKu9Yen1jLxjmBVbWq5vc7pvHNjAl3rQLnN1lXBL++TZlXdDIKYoqLl12qly31
 FihgIsqLr94spanYBbdr7Ug1UFRipAoisS8eFJmsCDVx66qdkCFhdQRGDgc/8OGK7eXXI45gT83
 12TrXXB/PKToFgdCfwUN06XRCjqRUjzNUVAxXUF4JBLiNDKuXV0OCu2mDjwhoMj9Y9GuF2h4ymq
 SB7i3wK91IA+jw43tp2paBEFiBCN8w/yox867wFJT33V7b8yztDBLbYVcsbYe1UYEdvQoYU7QFM
 uRO80iCLD5GRtgwqTIcq/TTK1ElSs8gwr7bxU8Q==
X-Google-Smtp-Source: AGHT+IER5T53oeuGsx9QICBOtD8cWXd04JSOuCeetDQT57rTumCMvTY0K230C64ZktGHPns+I3Znxw==
X-Received: by 2002:a17:90b:3809:b0:2fe:e9c6:689e with SMTP id
 98e67ed59e1d1-31e50768ab4mr10668563a91.8.1753378746781; 
 Thu, 24 Jul 2025 10:39:06 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.118.252])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662dd014sm1816136a91.30.2025.07.24.10.39.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 10:39:06 -0700 (PDT)
Message-ID: <a779c4ed-913e-4886-a2c6-7d3b505077c1@ventanamicro.com>
Date: Thu, 24 Jul 2025 14:39:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] intc/riscv_aplic: Fix target register read when source
 is inactive
To: Yang Jialong <z_bajeer@yeah.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: yangjialong@rvcore.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20250724093426.4179617-1-z_bajeer@yeah.net>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250724093426.4179617-1-z_bajeer@yeah.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102b.google.com
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



On 7/24/25 6:34 AM, Yang Jialong wrote:
> The RISC-V Advanced interrupt Architecture:
> 4.5.16. Interrupt targets:
> If interrupt source i is inactive in this domain, register target[i] is
> read-only zero.
> 
> Signed-off-by: Yang Jialong <z_bajeer@yeah.net>
> ---
>   hw/intc/riscv_aplic.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 4fa5f75..cfef69f 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -628,7 +628,7 @@ static void riscv_aplic_request(void *opaque, int irq, int level)
>   
>   static uint64_t riscv_aplic_read(void *opaque, hwaddr addr, unsigned size)
>   {
> -    uint32_t irq, word, idc;
> +    uint32_t irq, word, idc, sm;
>       RISCVAPLICState *aplic = opaque;
>   
>       /* Reads must be 4 byte words */
> @@ -696,6 +696,10 @@ static uint64_t riscv_aplic_read(void *opaque, hwaddr addr, unsigned size)
>       } else if ((APLIC_TARGET_BASE <= addr) &&
>               (addr < (APLIC_TARGET_BASE + (aplic->num_irqs - 1) * 4))) {
>           irq = ((addr - APLIC_TARGET_BASE) >> 2) + 1;
> +        sm = aplic->sourcecfg[irq] * APLIC_SOURCECFG_SM_MASK;

I believe you want '&' here:


sm = aplic->sourcecfg[irq] & APLIC_SOURCECFG_SM_MASK;

Otherwise, given that APLIC_SOURCECFG_SM_INACTIVE is 0x0, the only way

sm == APLIC_SOURCECFG_SM_INACTIVE

will happen is aplic->sourcecfg[irq] being 0.


Thanks,

Daniel

> +        if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
> +            return 0;
> +        }
>           return aplic->target[irq];
>       } else if (!aplic->msimode && (APLIC_IDC_BASE <= addr) &&
>               (addr < (APLIC_IDC_BASE + aplic->num_harts * APLIC_IDC_SIZE))) {


