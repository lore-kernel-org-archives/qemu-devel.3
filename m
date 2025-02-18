Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B48C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 12:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkMJE-0008Mw-Iu; Tue, 18 Feb 2025 07:02:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkMJD-0008Md-0O
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 07:02:39 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkMJ5-0003IW-0P
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 07:02:37 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38f22fe8762so2712142f8f.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 04:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739880148; x=1740484948; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iuBDeh+mJS+1P248AjzdhllCvL0Jb6J7WZ/ptKUZUQw=;
 b=ufkqeN2tkDu3QgGcJ/uUOYZCR+DkkNM61m+4LIMG12TLJH/uu66gY+ly3CVoEhIOQI
 jE/uC/ftcVw/Gb1obxp0hy1htbSfUcUUnZmKC47WcSlwC1m0cL6R/3XFz2hViVmkadyJ
 JIoGNSVN3lh8uC5iJumNatS7Zy57EzCCQR5RTCRTI3tJS9/riYb4jLr/LaKDlj5ap9I+
 sgyGBlB2RMw/E8zMQ/SIj99MpET9VpJfycm4Tbff91Pt8YTptM1fm6BXzcl4w4LoscHd
 FemJHJxySbG0CEKdY9SPcOHFZS+CqXI5Nt4pOS1ec3Z6Ia1LPz+HxrJj6OVm8bpYL7rs
 /P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739880148; x=1740484948;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iuBDeh+mJS+1P248AjzdhllCvL0Jb6J7WZ/ptKUZUQw=;
 b=wgO/O7amGaZgk6iXMKxhXlAPV+5XyrmJmPZhsJCfDnKXvb8S/u2B+3UZb/T5VhM5ye
 ftGbbNwsfYuuDx5z24hatpvJ8nA2xDM3I4np3pL7eDSlbu1C3GuT4Guh11cph+DLBe44
 Eom4hoIbwRmdjnNfkhl3LHa676I+IYj/aFskZmGBcXF/XWOOlpDqrf2yw//+C7KYu67r
 FA68oL7Rq+JKP5iARIaIYCYPusYfqtIZs2+604rknjPv9CiYKx7BIv/Qi2r9S3DCkOt+
 XE4tySFj6xojrznx694yU53thaLV/7Axf6xxd5nuH10MmgdwguIN2mc/13RkKNE/Xo8w
 cY7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv3YZbJQaqpIQAGdszcCqzdV5LJs8niCYPaKdqgvvOAVUPUCrC2ub9/OHKYptD84GFJ/Q8SBI2GbJp@nongnu.org
X-Gm-Message-State: AOJu0Yw8ZG27Pj1yxgjYIzW8XXhTZICZ2u9EjVwWXhZ5pw6bSW80UT2l
 icry6LkOyzT2nYxU954RxAh3EHWdPDoeXXIINXZPP61GqSOP0bvLSFp0JMXK7Lg=
X-Gm-Gg: ASbGncuD4DPPsolaUAWB2g2RM+yLldJiiWfsslzZt3RUtgkWVFvHundDnFquC7o/mbW
 p/0hS73kiXzx52pKD3Cn+X35NUAWfz6zKrScM4SY7veGZ8dOKDot5hK0twtUFtL6vyRedDqRNp8
 c01i8C3BrlW2rDVd/PSJwzbx1SYd1aIRaOLNihkmGyi1gRQAxAFcl32wk0qC6mMQSw2m1Ehvdg6
 36LrjLg76cK1UlmdbVnkzmBAWew5oi4fYR7R5Pz0ZrD/3TzY0O4m7HDpFp4zLiCZ4OLPIHq582S
 7kGQnYAoX1Qe0MwXAS5oTkNc4GrvL+H/Q76UeqGVoqzNpcXu4VBDo6ksI9w=
X-Google-Smtp-Source: AGHT+IEEdcu45U++3F5i4P4bJZp/5skRdH0r1WzbrdplZsdsJXL3OhztBRROTIWBQag2nN6g3n1SRA==
X-Received: by 2002:a5d:6d08:0:b0:38f:4b15:32f1 with SMTP id
 ffacd0b85a97d-38f4b1534a3mr6055221f8f.54.1739880148107; 
 Tue, 18 Feb 2025 04:02:28 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43992ad82cfsm21802165e9.37.2025.02.18.04.02.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 04:02:27 -0800 (PST)
Message-ID: <58d3fcc5-365d-4f20-ae34-5201fb9e7b3f@linaro.org>
Date: Tue, 18 Feb 2025 13:02:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v1 10/12] hw/xen: pvh-common: Add support for creating
 PCIe/GPEX
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org,
 sstabellini@kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: anthony@xenproject.org, paul@xen.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, xenia.ragiadakou@amd.com, jason.andryuk@amd.com,
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org
References: <20240904161537.664189-1-edgar.iglesias@gmail.com>
 <20240904161537.664189-11-edgar.iglesias@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240904161537.664189-11-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Hi Edgar,

On 4/9/24 18:15, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Add support for optionally creating a PCIe/GPEX controller.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> ---
>   hw/xen/xen-pvh-common.c         | 76 +++++++++++++++++++++++++++++++++
>   include/hw/xen/xen-pvh-common.h | 29 +++++++++++++
>   2 files changed, 105 insertions(+)


> +/*
> + * We use the GPEX PCIe controller with its internal INTX PCI interrupt
> + * swizzling. This swizzling is emulated in QEMU and routes all INTX
> + * interrupts from endpoints down to only 4 INTX interrupts.
> + * See include/hw/pci/pci.h : pci_swizzle()
> + */
> +static inline void xenpvh_gpex_init(XenPVHMachineState *s,
> +                                    XenPVHMachineClass *xpc,
> +                                    MemoryRegion *sysmem)
> +{
> +    MemoryRegion *ecam_reg;
> +    MemoryRegion *mmio_reg;
> +    DeviceState *dev;
> +    int i;
> +
> +    object_initialize_child(OBJECT(s), "gpex", &s->pci.gpex,
> +                            TYPE_GPEX_HOST);
> +    dev = DEVICE(&s->pci.gpex);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_add_subregion(sysmem, s->cfg.pci_ecam.base, ecam_reg);
> +
> +    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> +
> +    if (s->cfg.pci_mmio.size) {
> +        memory_region_init_alias(&s->pci.mmio_alias, OBJECT(dev), "pcie-mmio",
> +                                 mmio_reg,
> +                                 s->cfg.pci_mmio.base, s->cfg.pci_mmio.size);
> +        memory_region_add_subregion(sysmem, s->cfg.pci_mmio.base,
> +                                    &s->pci.mmio_alias);
> +    }
> +
> +    if (s->cfg.pci_mmio_high.size) {
> +        memory_region_init_alias(&s->pci.mmio_high_alias, OBJECT(dev),
> +                "pcie-mmio-high",
> +                mmio_reg, s->cfg.pci_mmio_high.base, s->cfg.pci_mmio_high.size);
> +        memory_region_add_subregion(sysmem, s->cfg.pci_mmio_high.base,
> +                &s->pci.mmio_high_alias);
> +    }
> +
> +    /*
> +     * PVH implementations with PCI enabled must provide set_pci_intx_irq()
> +     * and optionally an implementation of set_pci_link_route().
> +     */
> +    assert(xpc->set_pci_intx_irq);
> +
> +    for (i = 0; i < GPEX_NUM_IRQS; i++) {
> +        qemu_irq irq = qemu_allocate_irq(xpc->set_pci_intx_irq, s, i);
> +
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
> +        gpex_set_irq_num(GPEX_HOST(dev), i, s->cfg.pci_intx_irq_base + i);
> +        if (xpc->set_pci_link_route) {
> +            xpc->set_pci_link_route(i, s->cfg.pci_intx_irq_base + i);
> +        }
> +    }
> +}

Some Kconfig selector seems missing here:

/usr/bin/ld: libqemu-aarch64-softmmu.a.p/hw_xen_xen-pvh-common.c.o: in 
function `xenpvh_gpex_init':
hw/xen/xen-pvh-common.c:174: undefined reference to `gpex_set_irq_num'
/usr/bin/ld: libqemu-aarch64-softmmu.a.p/hw_xen_xen-hvm-common.c.o: in 
function `pci_dev_bus_num':
include/hw/pci/pci.h:337: undefined reference to `pci_bus_num'
/usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_bus_num'
/usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_bus_num'
/usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_bus_num'
/usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_bus_num'
/usr/bin/ld: libqemu-aarch64-softmmu.a.p/hw_xen_xen-hvm-common.c.o: in 
function `cpu_ioreq_config':
hw/xen/xen-hvm-common.c:412: undefined reference to 
`pci_host_config_read_common'
/usr/bin/ld: hw/xen/xen-hvm-common.c:428: undefined reference to 
`pci_host_config_read_common'
/usr/bin/ld: hw/xen/xen-hvm-common.c:438: undefined reference to 
`pci_host_config_write_common'

The current 'XEN' key represents both the "accelerator" part and
the common Xen HW, which isn't helping to follow. Anyhow, this
snippet fixes the build issue:

-- >8 --
diff --git a/accel/Kconfig b/accel/Kconfig
index 794e0d18d2..4263cab722 100644
--- a/accel/Kconfig
+++ b/accel/Kconfig
@@ -16,4 +16,5 @@ config KVM
  config XEN
      bool
      select FSDEV_9P if VIRTFS
+    select PCI_EXPRESS_GENERIC_BRIDGE
      select XEN_BUS
---

I'll post a patch later.

Regards,

Phil.

