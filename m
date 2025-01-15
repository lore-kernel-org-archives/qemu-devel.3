Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8985BC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 08:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXz8D-0007Cf-Tc; Wed, 15 Jan 2025 03:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXz88-0007Bp-Ll
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 03:52:06 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXz86-0000Es-PO
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 03:52:04 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38789e5b6a7so3462281f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 00:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736931121; x=1737535921; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s7if4vkYI6vy13WnUU24Jcsd6oMt/MiKFZwJ84dcQU0=;
 b=dJ+PrDYKIeLxx+KJoY+k+wqNXH50cJ7NlNkG2tZpLdmi6txV/zpEpQz8IUwiZepMQi
 ElnmvfiEWn1qZbJH4bQuI+M59Sjh5bk0ivI6NzBmQV6lmJvctO3CRAMhSrPu8xePJmCZ
 vF7qVafpMZF25JCASOx1elEx3dBiNNs7Hu9Vmz8YD8V3WQPh6kZEoHnoaxLnZ5GdTDrN
 vBOcR0rv9iPF1bJpffv/EiwP5cuf7rkJuZ5fjwPd5SnJ2LAKOKCdNKup02R31awIpXXC
 IbK8C0YIcWu740uhDaDXW3NLXEqAkyMb15mIbIpmV/5WcxN9rDiKmdqCE9lRo0hEvqaA
 asdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736931121; x=1737535921;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s7if4vkYI6vy13WnUU24Jcsd6oMt/MiKFZwJ84dcQU0=;
 b=Oy84BEDGzXAnv6jkZtEv9qRYTmeWMNa6Zqdw98+WbXrgPBDjak6YT1ADbKYnSZfBjv
 41z03UZe33YCj/qI/yimgETZQlqgKZNl6prEtaTkOmPi5AtpmR2wGH9yCKT4DTWTmLUU
 QyYetX5aWHSrn6AftoXe0cVwUEuxV2o2HopWNiZSAdJMdJFKMqUyiuvKRAXWEUAJSDvr
 3cTyMGZWgeo8dN189rnwP5w7dbfUyvrPMIW4akd+1XgNi4/yfIw014GJTLKUQeDONRwM
 pG6CEjkiB2soCjwjYj9LS2vad2JQfhQ+wFaghAMev7aYwdNJ/Ge1+qjSMpo/CC2XUfRq
 6LmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFHn5xMvCAjPsviqlmPK0Nc9ojEho0QP9DxKpsd1NIM7suoGt6kK5Hv0Li6L6gw+/sfsrx7JdiGXAq@nongnu.org
X-Gm-Message-State: AOJu0Ywa9QWXxsRkUgYrdxTNkkdLp18bioMd3gcJC34c35oBqaE112nt
 NYYKx+S9MzL4QTqy0VvS6NvHlED4meroFDi/P0Ia22FuCXaCpyTyYonWVl8tqC4=
X-Gm-Gg: ASbGncsgJZweA9BwD6v8J7boBQQ9/IimG11SBDV/jFdP7gDVb/F/AjmD/GPe3Y6dePv
 mS09L5YEbDKnuIwWp+izL8ZHU/F/MATcji+MA1NTq6Xmb41XhuLHCoKBXPK3pfWJdtqU4LpnbcI
 wuwVf5aJWe5Wp3sWsSLgesklIE5fvQvKwz2gdZcBpsbl3QHuzgcG8MEY2nMSn+jEwp7f8jOMjNc
 cLCAukZ7E5fSxbFqC9OCSx3Zap6uc/WBDS31Yuqg9FVOcuPmRveX6/LES/ZGOs7V7lXgx9xIvF4
 oqwl+xwy1HIw14FZmVrFBVtB
X-Google-Smtp-Source: AGHT+IGTv9EsLHcjuUbs267rq+dKbq0PuleQSHP0RGOIa34MTvERJ7pf1SHY6vUEdWRg7TPGPHADtA==
X-Received: by 2002:a5d:6d02:0:b0:385:df43:223c with SMTP id
 ffacd0b85a97d-38a87303941mr26591847f8f.13.1736931120935; 
 Wed, 15 Jan 2025 00:52:00 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b81e4sm17302021f8f.64.2025.01.15.00.51.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 00:52:00 -0800 (PST)
Message-ID: <e23c0b2c-a3c6-4929-affb-99ce5dea047f@linaro.org>
Date: Wed, 15 Jan 2025 09:51:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/riscv/riscv-iommu: Remove redundant struct
 members
To: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>
References: <20250115064737.16350-1-jason.chien@sifive.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250115064737.16350-1-jason.chien@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 15/1/25 07:47, Jason Chien wrote:
> Initially, the IOMMU would create a thread, but this thread was removed in
> the merged version. The struct members for thread control should have been
> removed as well, but they were not removed at that time.

... in commit 0c54acb8243 ("hw/riscv: add RISC-V IOMMU base emulation").

> 
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   hw/riscv/riscv-iommu.h | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index 9424989df4..fa8a50fa24 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -58,11 +58,6 @@ struct RISCVIOMMUState {
>       /* interrupt notifier */
>       void (*notify)(RISCVIOMMUState *iommu, unsigned vector);
>   
> -    /* IOMMU State Machine */
> -    QemuThread core_proc; /* Background processing thread */
> -    QemuCond core_cond;   /* Background processing wake up signal */
> -    unsigned core_exec;   /* Processing thread execution actions */
> -
>       /* IOMMU target address space */
>       AddressSpace *target_as;
>       MemoryRegion *target_mr;


