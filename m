Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DFDC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78tC-0003fw-1J; Wed, 15 May 2024 03:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s78sq-0003Ko-Is
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:17:12 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s78sk-0001UD-88
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:17:04 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-34d7a32bdd3so3821466f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1715757416; x=1716362216; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JEO5nS1Ltc6s0RRTMWU9z75YB32XaWbC0d2I6gbMByY=;
 b=FpcDilu9NzG+9Igtqllzm/TaNyOLWzwuIzBPUzJfipZGx9psytK8Obhdfohvbq0bPv
 s2H3f1Np7zHwC3hJ2r6RBaXHLShMYU1wlrTpKQ+U1vULtXX+BLIrH3NHST4/2EMMu33I
 zf9Wr6mG0ETAccINfsH8osNcj1RlQU2inZaxunhSqNKeP1CvkqF8gTtuAElrBu7ljZ5X
 vMeTCUSySjoAcezIAA1hVyRL4/zHmkJjx3HhT1uu+/AbKZABqCNKxnXYFJebW7b3k0GE
 v8sSdI7Zd7c5HW+vKLKRV5oW2ocCHfOZ7pWdbS83EtVlufVxnVTLUKoV0sEdjQ1tO7EF
 zKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715757416; x=1716362216;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JEO5nS1Ltc6s0RRTMWU9z75YB32XaWbC0d2I6gbMByY=;
 b=vfPrt9IDIh+RVKc7NEBDL+ULiOMSUObMCsN6yMDdCq06pv1+RaPcYXPQyNMhUGVmHW
 D/1Fuo1e6tYhO4SUjDxTz510arIJDAYmQkVMyadN1OmTVWVuZKNteieFVwPar9tV/307
 9pk7UUch7Pc0UBVT4Ri+uhxaG1J/AwP6HOTuMmRdAYGjGCtnD7LtZDL2TGBa9JbH76mp
 +FjGygvRcZBCAw5UYQ1ygxnP76LJaxaq8hbd8TYwAWYSFf2kncuvCoTm1t/iZwcMGfbm
 njdHjBgK6nkyfh0M+JQCpUOQ0SZ5DYUO+LNQyb+39CkdlGPedVMeIed3S2933jcUEUIq
 SB5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxwOZ9pyCBceDUpYfxC7F/wvBIyYfYzRiGlbKsVXck+dk5jJt5wX9wJ+5NZr8pHrTjPK8ahYXVHkRO2/nXx+Y8eP6hrdI=
X-Gm-Message-State: AOJu0YzcPz/RZe4fQrAwXRqBe2FqWdXMMH8Q49UUWMubILZfRbGwxEIx
 zdjKTRXH5EnEvcSxRRmtxxBSDSCtkw/UbMKIbLm/Tvmm6Nh2M62iQmD9HnNEJuc=
X-Google-Smtp-Source: AGHT+IHYHKI7oeogFK/Jyic4l2do0NwKmr34srMLA6NEg+9yCsYLDFuMq/Ju3jStsCSj9i/gmRcuzw==
X-Received: by 2002:a5d:4577:0:b0:34d:bbcf:1ef with SMTP id
 ffacd0b85a97d-3504a96d3a8mr10905267f8f.61.1715757416224; 
 Wed, 15 May 2024 00:16:56 -0700 (PDT)
Received: from localhost (cst2-173-78.cust.vodafone.cz. [31.30.173.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baacf89sm15683615f8f.83.2024.05.15.00.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:16:55 -0700 (PDT)
Date: Wed, 15 May 2024 09:16:54 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Eric Cheng <eric.cheng.linux@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, tjeznach@rivosinc.com
Subject: Re: [PATCH v2 06/15] hw/riscv/virt.c: support for RISC-V IOMMU
 PCIDevice hotplug
Message-ID: <20240515-e56bce8b02b918c106961996@orel>
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-7-dbarboza@ventanamicro.com>
 <41835d3f-d9e2-4ace-8add-f5bb6c525c5f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41835d3f-d9e2-4ace-8add-f5bb6c525c5f@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x42c.google.com
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

On Wed, May 15, 2024 at 02:25:31PM GMT, Eric Cheng wrote:
> On 3/8/2024 12:03 AM, Daniel Henrique Barboza wrote:
> > From: Tomasz Jeznach <tjeznach@rivosinc.com>
> > 
> > Generate device tree entry for riscv-iommu PCI device, along with
> > mapping all PCI device identifiers to the single IOMMU device instance.
> > 
> > Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> > Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > ---
> >   hw/riscv/virt.c | 33 ++++++++++++++++++++++++++++++++-
> >   1 file changed, 32 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index a094af97c3..67a8267747 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -32,6 +32,7 @@
> >   #include "hw/core/sysbus-fdt.h"
> >   #include "target/riscv/pmu.h"
> >   #include "hw/riscv/riscv_hart.h"
> > +#include "hw/riscv/iommu.h"
> >   #include "hw/riscv/virt.h"
> >   #include "hw/riscv/boot.h"
> >   #include "hw/riscv/numa.h"
> > @@ -1004,6 +1005,30 @@ static void create_fdt_virtio_iommu(RISCVVirtState *s, uint16_t bdf)
> >                              bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf);
> >   }
> > +static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
> > +{
> > +    const char comp[] = "riscv,pci-iommu";
> > +    void *fdt = MACHINE(s)->fdt;
> > +    uint32_t iommu_phandle;
> > +    g_autofree char *iommu_node = NULL;
> > +    g_autofree char *pci_node = NULL;
> > +
> > +    pci_node = g_strdup_printf("/soc/pci@%lx",
> > +                               (long) virt_memmap[VIRT_PCIE_ECAM].base);
> > +    iommu_node = g_strdup_printf("%s/iommu@%x", pci_node, bdf);
> > +    iommu_phandle = qemu_fdt_alloc_phandle(fdt);
> > +    qemu_fdt_add_subnode(fdt, iommu_node);
> > +
> > +    qemu_fdt_setprop(fdt, iommu_node, "compatible", comp, sizeof(comp));
> > +    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
> > +    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
> > +    qemu_fdt_setprop_cells(fdt, iommu_node, "reg",
> > +                           bdf << 8, 0, 0, 0, 0);
> > +    qemu_fdt_setprop_cells(fdt, pci_node, "iommu-map",
> > +                           0, iommu_phandle, 0, bdf,
> > +                           bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf);
> > +}
> 
> Is it really necessary to add this iommu-pci device in riscv virt machine,
> rather than other 'physical' machine type? virt machine already has its
> virtio-iommu.
>

We need both, just as the Arm virt machine has both. virtio-iommu is for
guests, but the Arm and RISCV virt machines are both also used as hosts.

Thanks,
drew

