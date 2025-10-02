Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE3CCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 07:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4DsD-00068h-UD; Thu, 02 Oct 2025 03:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1v4DsB-00063S-Ho
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 03:37:08 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1v4Drz-0000I3-GN
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 03:37:07 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-57b35e176dbso852784e87.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 00:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759390607; x=1759995407; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=avz7PJF/G/m4RZJqGVo0B69VQDhbRS9hvVnIkEAq1fQ=;
 b=ipppUTTcjtwQLyRDh05p+XF/XMY9edTCM9Ac8VdERWA6kRZiBNM+n38RlgVIjkKbzt
 YLZ5ZxWZivKtBx1+ns93MiNTzyHnO+BIrMq8sUkfSZVEuRIeRcvi17mNJxoPf9t1CQSn
 lPZ1EVOx0h6xZMl2i5b73jDI/2BH8VRj12qaecPdkI+9p6VG2EcFylZ4PXZHYHJlr/+E
 72UYq5zyOTJCWjhJQWIzeGubL6Ub8J7ExlbQeEO9yavn62sBpgv2Pw56/bQ0bCyWgdyS
 11yFtuCUYP39FgluKWWrZ5DjUeald02/kqt9Nw1sI/4YTj12l349er1/wgKBm2xDmqvE
 1Gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759390607; x=1759995407;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=avz7PJF/G/m4RZJqGVo0B69VQDhbRS9hvVnIkEAq1fQ=;
 b=SYFseSlF8xzqtPFS+Wg0aWSHF/yOe6b6bz8HLOffxrJmbH+CfdQF2XuCx5Odw1cnCm
 guhddbhO0v78lNk2u3mKYL5ziUuD+H2RIxGHyzUr11XrqcjAAlr6NseGsbpGjWW4Qbjl
 b7SfT+US3Td8eqQMzMjcAyAOiKTDb5r2OR+lFUAOdoB4Ol5CvLFpDahRlqVIjXGsMMrL
 tt37GK1Hty/EAGwFC2xpYrnAljV61feiwV9lrldCGvc98G3AMkuYf1DRv/y5UgOPvGLQ
 2jYEoQl70ggOh6MFssnbOYkN2Aqf5/7eC8fJrNQfkmCiMKK+H/ABweIJ869Cxwhqjccj
 1FPQ==
X-Gm-Message-State: AOJu0Yyh+pyMhGPxz4HwKVXe8YHZHfC3HFuc0S0wMaHe7AJV82bwGMki
 uio60zFMXGdZcjKJ8qKiJq4sKLFFj+UWM9nBVGDcveh/bSY2/BPEdy2R
X-Gm-Gg: ASbGncshCkzpFSEOmXoZGHJdrgET/Jzz9ASSj0aWhJ4TvWLTkpI3Ra7hp8UL2Uk7pf5
 q9gdd/3V+eCtDRFlFgRC5orYYAV0+8sMi5uqxocVLPTaJV1rgPyFJzBifZxEx8KDiP8xWzGMi+l
 TiN7Q+HcPRe9DUw5KvuznRUGGr/1bFY01ty92AswRBEIIDvarx4ijBdiryIXx+WJqUcE2bADmN8
 dbvGeDN8XTXBXH1iZeJY2qJYccIYxLhJMvZATPJhJ0/MbeRDnEFXw862I8GUh1hqAMdxyn7YYga
 tdsrG9X5sgL4e18ZzkTKKDOiKN3C7PfvXGKop1mN/kP/t7357J/Q3cNBYhBNSsHHIZnutcw0DGu
 haxwYs99RhMbQaD49FjMaQ7Lv0UEKAwOsz0tPw+tXXsuK/VvY5Hh97iejKSGrXEX2QpGiJep16i
 Uw0Lb0SaI=
X-Google-Smtp-Source: AGHT+IFnlHhwMjymn1jn1pOzGtcnt1zzBLIlTs6GmYXu4tiHUyWfXyxZbDnomQXzJvY01g1KxSm+/Q==
X-Received: by 2002:a05:6512:131a:b0:576:dc00:37cc with SMTP id
 2adb3069b0e04-58af9f40c4cmr1837340e87.34.1759390607105; 
 Thu, 02 Oct 2025 00:36:47 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-58b01124030sm598675e87.7.2025.10.02.00.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 00:36:45 -0700 (PDT)
Date: Thu, 2 Oct 2025 09:36:44 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: =?iso-8859-1?Q?Cl=E9ment?= Chigot <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 alistair@alistair23.me, Frederic Konrad <konrad.frederic@yahoo.fr>
Subject: Re: [PATCH 3/3] hw/arm/xlnx-zynqmp: wire a second GIC for the
 Cortex-R5
Message-ID: <aN4rjMvrUdBDPial@zapote>
References: <20250930115718.437100-1-chigot@adacore.com>
 <20250930115718.437100-4-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250930115718.437100-4-chigot@adacore.com>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Tue, Sep 30, 2025 at 01:57:18PM +0200, Clément Chigot wrote:
> From: Frederic Konrad <konrad.frederic@yahoo.fr>
> 
> This wires a second GIC for the Cortex-R5, all the IRQs are split when there
> is an RPU instanciated.
> 
> Signed-off-by: Clément Chigot <chigot@adacore.com>

Acked-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> ---
>  hw/arm/xlnx-zynqmp.c         | 77 +++++++++++++++++++++++++++++++++++-
>  include/hw/arm/xlnx-zynqmp.h |  4 ++
>  2 files changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 3d8c46986e..ffed6e5126 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -384,6 +384,7 @@ static void xlnx_zynqmp_init(Object *obj)
>      XlnxZynqMPState *s = XLNX_ZYNQMP(obj);
>      int i;
>      int num_apus = MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
> +    int num_rpus = xlnx_zynqmp_get_rpu_number(ms);
>  
>      object_initialize_child(obj, "apu-cluster", &s->apu_cluster,
>                              TYPE_CPU_CLUSTER);
> @@ -397,6 +398,12 @@ static void xlnx_zynqmp_init(Object *obj)
>  
>      object_initialize_child(obj, "gic", &s->gic, gic_class_name());
>  
> +    if (num_rpus) {
> +        /* Do not create the rpu_gic if we don't have rpus */
> +        object_initialize_child(obj, "rpu_gic", &s->rpu_gic,
> +                                gic_class_name());
> +    }
> +
>      for (i = 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
>          object_initialize_child(obj, "gem[*]", &s->gem[i], TYPE_CADENCE_GEM);
>          object_initialize_child(obj, "gem-irq-orgate[*]",
> @@ -446,6 +453,15 @@ static void xlnx_zynqmp_init(Object *obj)
>      object_initialize_child(obj, "qspi-irq-orgate",
>                              &s->qspi_irq_orgate, TYPE_OR_IRQ);
>  
> +    if (num_rpus) {
> +        for (i = 0; i < ARRAY_SIZE(s->splitter); i++) {
> +            g_autofree char *name = g_strdup_printf("irq-splitter%d", i);
> +            object_initialize_child(obj, name, &s->splitter[i], TYPE_SPLIT_IRQ);
> +        }
> +    }
> +
> +
> +
>      for (i = 0; i < XLNX_ZYNQMP_NUM_USB; i++) {
>          object_initialize_child(obj, "usb[*]", &s->usb[i], TYPE_USB_DWC3);
>      }
> @@ -459,6 +475,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>      uint8_t i;
>      uint64_t ram_size;
>      int num_apus = MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
> +    int num_rpus = xlnx_zynqmp_get_rpu_number(ms);
>      const char *boot_cpu = s->boot_cpu ? s->boot_cpu : "apu-cpu[0]";
>      ram_addr_t ddr_low_size, ddr_high_size;
>      qemu_irq gic_spi[XLNX_ZYNQMP_GIC_NUM_SPI_INTR];
> @@ -517,6 +534,14 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>      qdev_prop_set_bit(DEVICE(&s->gic),
>                        "has-virtualization-extensions", s->virt);
>  
> +    if (num_rpus) {
> +        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "num-irq",
> +                             XLNX_ZYNQMP_GIC_NUM_SPI_INTR + 32);
> +        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "revision", 1);
> +        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "num-cpu", num_rpus);
> +        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "first-cpu-index", 4);
> +    }
> +
>      qdev_realize(DEVICE(&s->apu_cluster), NULL, &error_fatal);
>  
>      /* Realize APUs before realizing the GIC. KVM requires this.  */
> @@ -616,13 +641,63 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    if (num_rpus) {
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->rpu_gic), errp)) {
> +            return;
> +        }
> +
> +        for (i = 0; i < num_rpus; i++) {
> +            qemu_irq irq;
> +
> +            sysbus_mmio_map(SYS_BUS_DEVICE(&s->rpu_gic), i + 1,
> +                            GIC_BASE_ADDR + i * 0x1000);
> +            sysbus_connect_irq(SYS_BUS_DEVICE(&s->rpu_gic), i,
> +                               qdev_get_gpio_in(DEVICE(&s->rpu_cpu[i]),
> +                                                ARM_CPU_IRQ));
> +            sysbus_connect_irq(SYS_BUS_DEVICE(&s->rpu_gic), i + num_rpus,
> +                               qdev_get_gpio_in(DEVICE(&s->rpu_cpu[i]),
> +                                                ARM_CPU_FIQ));
> +            sysbus_connect_irq(SYS_BUS_DEVICE(&s->rpu_gic), i + num_rpus * 2,
> +                               qdev_get_gpio_in(DEVICE(&s->rpu_cpu[i]),
> +                                                ARM_CPU_VIRQ));
> +            sysbus_connect_irq(SYS_BUS_DEVICE(&s->rpu_gic), i + num_rpus * 3,
> +                               qdev_get_gpio_in(DEVICE(&s->rpu_cpu[i]),
> +                                                ARM_CPU_VFIQ));
> +            irq = qdev_get_gpio_in(DEVICE(&s->rpu_gic),
> +                                   arm_gic_ppi_index(i, ARM_PHYS_TIMER_PPI));
> +            qdev_connect_gpio_out(DEVICE(&s->rpu_cpu[i]), GTIMER_PHYS, irq);
> +            irq = qdev_get_gpio_in(DEVICE(&s->rpu_gic),
> +                                   arm_gic_ppi_index(i, ARM_VIRT_TIMER_PPI));
> +            qdev_connect_gpio_out(DEVICE(&s->rpu_cpu[i]), GTIMER_VIRT, irq);
> +            irq = qdev_get_gpio_in(DEVICE(&s->rpu_gic),
> +                                   arm_gic_ppi_index(i, ARM_HYP_TIMER_PPI));
> +            qdev_connect_gpio_out(DEVICE(&s->rpu_cpu[i]), GTIMER_HYP, irq);
> +            irq = qdev_get_gpio_in(DEVICE(&s->rpu_gic),
> +                                   arm_gic_ppi_index(i, ARM_SEC_TIMER_PPI));
> +            qdev_connect_gpio_out(DEVICE(&s->rpu_cpu[i]), GTIMER_SEC, irq);
> +        }
> +
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->rpu_gic), 0, GIC_BASE_ADDR);
> +    }
> +
>      if (!s->boot_cpu_ptr) {
>          error_setg(errp, "ZynqMP Boot cpu %s not found", boot_cpu);
>          return;
>      }
>  
>      for (i = 0; i < XLNX_ZYNQMP_GIC_NUM_SPI_INTR; i++) {
> -        gic_spi[i] = qdev_get_gpio_in(DEVICE(&s->gic), i);
> +        if (num_rpus) {
> +            DeviceState *splitter = DEVICE(&s->splitter[i]);
> +            qdev_prop_set_uint16(splitter, "num-lines", 2);
> +            qdev_realize(splitter, NULL, &error_abort);
> +            gic_spi[i] = qdev_get_gpio_in(splitter, 0);
> +            qdev_connect_gpio_out(splitter, 0,
> +                                  qdev_get_gpio_in(DEVICE(&s->gic), i));
> +            qdev_connect_gpio_out(splitter, 1,
> +                                  qdev_get_gpio_in(DEVICE(&s->rpu_gic), i));
> +        } else {
> +            gic_spi[i] = qdev_get_gpio_in(DEVICE(&s->gic), i);
> +        }
>      }
>  
>      for (i = 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
> diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
> index 6a407c2962..a3117bd6c5 100644
> --- a/include/hw/arm/xlnx-zynqmp.h
> +++ b/include/hw/arm/xlnx-zynqmp.h
> @@ -42,6 +42,7 @@
>  #include "hw/misc/xlnx-zynqmp-crf.h"
>  #include "hw/timer/cadence_ttc.h"
>  #include "hw/usb/hcd-dwc3.h"
> +#include "hw/core/split-irq.h"
>  
>  #define TYPE_XLNX_ZYNQMP "xlnx-zynqmp"
>  OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqMPState, XLNX_ZYNQMP)
> @@ -106,6 +107,9 @@ struct XlnxZynqMPState {
>      GICState gic;
>      MemoryRegion gic_mr[XLNX_ZYNQMP_GIC_REGIONS][XLNX_ZYNQMP_GIC_ALIASES];
>  
> +    GICState rpu_gic;
> +    SplitIRQ splitter[XLNX_ZYNQMP_GIC_NUM_SPI_INTR];
> +
>      MemoryRegion ocm_ram[XLNX_ZYNQMP_NUM_OCM_BANKS];
>  
>      MemoryRegion *ddr_ram;
> -- 
> 2.34.1
> 

