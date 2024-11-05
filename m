Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A493D12689
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HgF-0002U8-Su; Tue, 05 Nov 2024 06:25:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Hfe-00025t-KR
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:24:30 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Hfa-0007Y6-UY
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:24:24 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a99fa009adcso342823966b.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805861; x=1731410661; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MCROoq1589SjqNt5Av7Z/cCUzbMf65DfGC3yHMtUPR0=;
 b=M8bEWfScOqguxqmsEDYQq6ptSXFr5HTfvIeXEo8PmGrWqdJ4FjAv385+7agseLx8Zr
 UdeAUy9s4F9o76E1sGAUIABmF6ySKOCgh9IHgDRg6zg22edAkMuM9XECsrsrpFfpzOsF
 egOb0YmwOwdQMWwyVIbrHahJkphL7YeVAn/2syWTf7ao+amaqOZBdcLF0/3VilUeCMzY
 3W4w7xS861arzir1+vqoR+WP0HifITARcvA931YJs2jfRTFyiRw/sjVnvSI6SS8iElC/
 SwtlhgDICPl45Z8XQ2BoWNb+pDy/D7/9Hvjpm6Mx2LXLanvF3PaYywnb+SUeutH65skC
 M2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805861; x=1731410661;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MCROoq1589SjqNt5Av7Z/cCUzbMf65DfGC3yHMtUPR0=;
 b=Gjva2IDaa42wTGmc6OvRBfLotSRhSc9RLSoQNeNORhUadTUbeFSMWGs2VWlnSEYW67
 g+9JSg/3z0yJGl38Olg0i4exrbFbUy/Acp276qw2SLNpwL1c/Kd+n7z5UiQMdatP57QK
 yrLn2ac+bqEY/bQuMW9w+TuzkxSxyimf2AqRANmiUiU0NfE+oNL/ONv6+oTro52g4tT0
 okXwuiMYh2Am7JR/S+4ILjJiXXYECH3esjCAtQYO0lFWkenEzcpzbsmXYdI4NL+bEIDH
 ad38VVBde4szaZjlrVPh9oVdMknvAoHVuaFINFDrENkff38xVxks0Dc1KpPCBu+e4a8k
 rk8w==
X-Gm-Message-State: AOJu0YzzO8FU9A2zoA93NfgDwFf+REuHhm+MKKyP1UZEWsdk0CelX1IQ
 5TjO+IyHuUyq2KrcKnB1vvEjJy/vblPSlxTxejLw687d7SRkrAl7uPFYp3pCbpvOg3r/++ulFTe
 kwgdXdfWetHkpFYkHTHGTR9BivC3oOGbPUeNmBw==
X-Google-Smtp-Source: AGHT+IFwUa7dkdStqALDTBnnkLGdxgQjMNEV5hs8YJ+89MKYIARdHdFkJ9VsdVApdvYDmw1IIqk1NKYc6bHPop4yEL0=
X-Received: by 2002:a05:6402:280a:b0:5c9:45b5:6077 with SMTP id
 4fb4d7f45d1cf-5ceb935bc94mr15646578a12.23.1730805860961; Tue, 05 Nov 2024
 03:24:20 -0800 (PST)
MIME-Version: 1.0
References: <20241104123839.533442-1-dbarboza@ventanamicro.com>
In-Reply-To: <20241104123839.533442-1-dbarboza@ventanamicro.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2024 11:24:08 +0000
Message-ID: <CAFEAcA_=VSVZP5p5zeJpP6K8ucJgsEdbUWc5P6KPO6FtSaE_5Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/riscv/riscv-iommu: Coverity fixes
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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

On Mon, 4 Nov 2024 at 12:38, Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> This series fixes two issues detected by Coverity in the riscv-iommu
> code that just went upstream.
>
> Peter,
>
> I'm fixing only 2 CIDs because the third one is a false positive:
>
> *** CID 1564781:  Integer handling issues  (INTEGER_OVERFLOW)
> /builds/qemu-project/qemu/hw/riscv/riscv-iommu-pci.c: 97 in riscv_iommu_pci_realize()
> 91
> 92         /* Set device id for trace / debug */
> 93         DEVICE(iommu)->id = g_strdup_printf("%02x:%02x.%01x",
> 94             pci_dev_bus_num(dev), PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
> 95         qdev_realize(DEVICE(iommu), NULL, errp);
> 96
> >>>     CID 1564781:  Integer handling issues  (INTEGER_OVERFLOW)
> >>>     Expression "memory_region_size(&iommu->regs_mr) + 4096UL", which is equal to 4095, where "memory_region_size(&iommu->regs_mr)" is known to be equal to 18446744073709551615, overflows the type that receives it, an unsigned integer 64 bits wide.
> 97         memory_region_init(&s->bar0, OBJECT(s), "riscv-iommu-bar0",
> 98             QEMU_ALIGN_UP(memory_region_size(&iommu->regs_mr), TARGET_PAGE_SIZE));
> 99         memory_region_add_subregion(&s->bar0, 0, &iommu->regs_mr);
> 100
> 101         pcie_endpoint_cap_init(dev, 0);
> 102
> ----------
>
> The reason is that is that iommu->regs_mr is being initialized in riscv_iommu_realize()
> with 'RISCV_IOMMU_REG_SIZE':
>
>     memory_region_init_io(&s->regs_mr, OBJECT(dev), &riscv_iommu_mmio_ops, s,
>         "riscv-iommu-regs", RISCV_IOMMU_REG_SIZE);
>
> And we're doing "qdev_realize(DEVICE(iommu), NULL, errp);" right before
> the snippet Coverity found as problematic so it's guaranteed to be
> initialized. I ran it with a debugger and verified that
> QEMU_ALIGN_UP(memory_region_size(&iommu->regs_mr), TARGET_PAGE_SIZE) is
> in fact equal to 'RISCV_IOMMU_REG_SIZE' at that point, as intended.
>
> I was going to set it as false positive in Coverity but decided to
> verify with you first. If you agree I'll update the ticket.

Yes, this is a false positive. Coverity has a habit of
assuming that because in some cases a function can return
a particular constant value that it's therefore possible
at any callsite. I just marked this false-positive in the UI.

Thanks for the prompt fixes for the other two!

-- PMM

