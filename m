Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5FAFA1FEF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdmk-00065s-6x; Wed, 22 Apr 2026 16:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdm4-0004aQ-Cw
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:02:22 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdm2-0003LX-KX
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:02:16 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4891f625344so42777695e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888133; x=1777492933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qE0L4zwELTPdWddMD5jvlbfZqCIdrmv6K9R8Vmm5VjI=;
 b=OrrAVqtu+ST3yMDvL1GNX8dvPPxR0U0Uy6YqroaGwi+YWVXloNxq9ZmjBfY/CbmIyR
 m5CMGR2x89J7xRBVFg6nXJonZ6yZ7IsCvo0RLvONQ1eW1wzAX/W6au+PFBIVfvXcY5Rc
 f+of4HPA59O++REjzsVF2MmcDZVZL4WwgFUJKf/oEbPdh0+omXmN3LVYMveO3orXlV5C
 nbUqx1jDKrYh7IVyHgIaJjGybFFjympkSQPAHGCiCMy4GUbjY59iCF8RyUUXry2lPHWf
 6NyKt4N2So+iOnmPO/0Y/Ks10vEfTrnA6nCqPlpU9ptcpGcCbWeWokSfBg49iYRJNvAU
 Wy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888133; x=1777492933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qE0L4zwELTPdWddMD5jvlbfZqCIdrmv6K9R8Vmm5VjI=;
 b=eqUCI3SRaFyU5UTLkhYC6uEquBrStc+134cwLsQv6ebBQijaMLi+vCV9A0gYlhtA2D
 gyXJFnuizP3eqwwUqoK7GXYnp65843EPK4PqMrdm1om6MTF+mBRqcVkRbsr610NCRI8q
 mrbLneuMB9JYWMHu/tNjbOB0iOeWjenaOpq1CSgXyFJ+O7/WIez9M3g4U3RFWZj3suvw
 KZgzUWBfLGu1IpXDrhLay6G0R+5xiI+2OtAQzTYOZEgoq6hpnlt8T1SidiziPukhdWyS
 a1elfin4Vy6Jq//1MzrnPlF7eCR89UwdCIWRGr3ISMzYimGXRbOTKjF3iG9z1hAPRR0j
 8XWQ==
X-Gm-Message-State: AOJu0Yzw/3GoWTcSL+Y1VbuAJwICTBpFySgdSHlH/S54jC8UweOHPUtp
 owvPdphZWVFh6phdvvMgvxkzRS4MRB8kvW7I8nHx6uRCOaHu+gWLv+U8CI/QhJ5M/NQZ7ngIVrP
 RfYYYIAo=
X-Gm-Gg: AeBDiesY0pqu770DxlepVeV6vgrW69E/ejl/An6qM1fmnrUTTUsY5Qbqj93xiR34aw4
 r9s9Sc92VyyoiBT7lFtBAcy/6nv9KJQ6PNoRuaxL3oHzPzesbLdoMF5OF/MnmCOfts22IVaEt0j
 xKLTCSXF4DoGEgkPGdz5mbRRLRLXJkwuPwpiHkn9KQUra9dad2YyXUHpc0mMYYph70w7HAmxIxR
 4nGgS7CcNh/40DqXE2lHG6kryqB35spiCq8TV3qo+j1hiXD5NAR/MJ35fEAcQ4N3d4i+LkRS7o7
 uNiYRx4HrwCUijXlf/QxybV6is0lfrS7ns5rI/gwQ8AcfmDoyAdhbu+m80JY9vW31TGOCEwWzUz
 qYSP+N3Ee1xmoPOQZwJSctlgT4UR21LAwTcdoPiwaGNjiA5HsI+pMOUCFWJInyXvefRDscXjyb8
 InYoX+YIelyDbYdSSKtFyREbAN1gV/DThEXVLlSf6AbAexiXTr93uaTcd8uSGroV7db8dh28pBK
 500FJY/JYY=
X-Received: by 2002:a05:600c:4e0c:b0:489:1d7a:4537 with SMTP id
 5b1f17b1804b1-4891d7a463emr192281365e9.3.1776888132685; 
 Wed, 22 Apr 2026 13:02:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891cc7b2efsm148838215e9.0.2026.04.22.13.02.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:02:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/48] hw/ppc/e500: fix bus-frequency property hardcoded to
 zero in CPU FDT node
Date: Wed, 22 Apr 2026 21:57:35 +0200
Message-ID: <20260422195746.88865-38-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Vivien LEGER <vivien.leger@gmail.com>

The bus-frequency property in the CPU FDT node was hardcoded to 0.
This is incorrect - it should reflect the actual platform bus clock
frequency, as firmware and RTOSes use it to derive peripheral clock
rates.

Notably, the RTEMS QorIQ BSP uses bus-frequency to program the MPIC
global timer interval. With bus-frequency=0, the timer interval
overflows to ~85 seconds, preventing any clock interrupts from firing.

Fix by adding a bus_freq field to PPCE500MachineClass and using it in
the FDT generator. Set bus_freq = PLATFORM_CLK_FREQ_HZ (400MHz) for
existing machines, matching the existing clock_freq value.

Signed-off-by: Vivien LEGER <vivien.leger@gmail.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20260411154535.1451361-1-vivien.leger@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/e500.h      | 1 +
 hw/ppc/e500.c      | 2 +-
 hw/ppc/e500plat.c  | 1 +
 hw/ppc/mpc8544ds.c | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
index 11f8ae53177..6d56c7b4cb2 100644
--- a/hw/ppc/e500.h
+++ b/hw/ppc/e500.h
@@ -40,6 +40,7 @@ struct PPCE500MachineClass {
     hwaddr pci_mmio_bus_base;
     hwaddr spin_base;
     uint32_t clock_freq;
+    uint32_t bus_freq;
     uint32_t tb_freq;
 };
 
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index d6ca2e8563a..5be2f2095f6 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -518,7 +518,7 @@ static int ppce500_load_device_tree(PPCE500MachineState *pms,
                               env->icache_line_size);
         qemu_fdt_setprop_cell(fdt, cpu_name, "d-cache-size", 0x8000);
         qemu_fdt_setprop_cell(fdt, cpu_name, "i-cache-size", 0x8000);
-        qemu_fdt_setprop_cell(fdt, cpu_name, "bus-frequency", 0);
+        qemu_fdt_setprop_cell(fdt, cpu_name, "bus-frequency", pmc->bus_freq);
         if (cpu->cpu_index) {
             qemu_fdt_setprop_string(fdt, cpu_name, "status", "disabled");
             qemu_fdt_setprop_string(fdt, cpu_name, "enable-method",
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index ca5647284d0..85cec810d9a 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -94,6 +94,7 @@ static void e500plat_machine_class_init(ObjectClass *oc, const void *data)
     pmc->pci_mmio_bus_base = 0xE0000000ULL;
     pmc->spin_base = 0xFEF000000ULL;
     pmc->clock_freq = PLATFORM_CLK_FREQ_HZ;
+    pmc->bus_freq = PLATFORM_CLK_FREQ_HZ;
     pmc->tb_freq = PLATFORM_CLK_FREQ_HZ;
 
     mc->desc = "generic paravirt e500 platform";
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index 6a5d3edc490..a5717a9cde4 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -56,6 +56,7 @@ static void mpc8544ds_machine_class_init(ObjectClass *oc, const void *data)
     pmc->pci_pio_base = 0xE1000000ULL;
     pmc->spin_base = 0xEF000000ULL;
     pmc->clock_freq = PLATFORM_CLK_FREQ_HZ;
+    pmc->bus_freq = PLATFORM_CLK_FREQ_HZ;
     pmc->tb_freq = PLATFORM_CLK_FREQ_HZ;
 
     mc->desc = "mpc8544ds";
-- 
2.53.0


