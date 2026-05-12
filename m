Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB451CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMtoQ-0002Sf-Ld; Tue, 12 May 2026 16:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMtoG-0002OU-RL
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:34:35 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMtoC-0002Qg-53
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:34:31 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso51387975e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 13:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778618064; x=1779222864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KPoAYypSDNORF0pUxIKtlzts64GOfXtKmSc+PiEhbG8=;
 b=DEuUG7o2M4zgljy7owxpms3bCI71lTupK6twm+2GqgcZedmGRvqS4McPzKtyvMnvws
 LQpJCbiXhW1fFZVMnaWsKF4+Yd8HZrStjs1hVFF8fJBqb9sZ7epugnGPp7BQgIBxmho9
 ZkJUKKR2RSGLfPm3CwQII7n6tyXOohgZ22f8JFM5F4ZJGDYLWIw1gT5q2LUAEfTS33Fo
 AwhfRBWMgdKpUtvfaar/cRJutCMbJ2CkLk/Jk+XKeCioGKPmFO2LAygZosRlwy5miba/
 qhxhtkJ0nIM9YCWWv9mcQwjpIfR+vq5usbo2vK6huqerowMqool76ke24Z13OMr13Xwp
 orwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778618064; x=1779222864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KPoAYypSDNORF0pUxIKtlzts64GOfXtKmSc+PiEhbG8=;
 b=mSScFCCRmSONT9Cu5wvX/0tIhL1rKkHG0teKq1oaxk0NvHLTurygurE3L420C/PUN5
 9HRKyfm8ql5I61FYOfK03xmsh7QZ2bUYkSvbgcWlQHMi9huMJ3arj6TIrnEfF3p0MWbc
 I3//LJSyt/K9DfZk+WuS2gw1SsoRF/gMOQjcl2ohcKkMis4ImDDn5uPNu4IPgGe/wxNJ
 ucIyFZlgHDJpJmaRaFvkZCu810boFmlWVhM0fqN1qPcgAJqyg7YkgLC3U26jJEKdf6mM
 V0y1vVmaQoNn6hMksqrDX4AHBVxaQp12ghrqmOd56Aasz2z/DxfWSjQGR9MgUJo7HsdA
 Ndag==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ZgC7BVvZ3zuQ5EX6OSE7Z/7vWHDTr0LKzEDYVwVCbOe6/QjaXdTf/3ecO/Fb3ZrZOwHNF3N4yKSux@nongnu.org
X-Gm-Message-State: AOJu0YxIL6RkBB/g9NrgcLytxp5O0/b+HT/Rn8Xno7TmyV5xrxdXT8Cz
 BZeRhQqN5535SRaQmFo6BuuLUgIdJ6njniMRRXmXS9QL1nBFk6Z65FtPKxlh5WPmH/Y=
X-Gm-Gg: Acq92OF1McYoV+PRP7/yCJewczEFmSoyfGicK30VCHrVB0wotEF3Zy0WuFjoOSVp3tS
 TQEdBbB60yPZvpenZsB836YCkp7u3E99fQDDnW7ShEg8g+NGy6qzL7CWcLblmkg+nfI2sOnEjsB
 7JKLI5o6b33tcwB97SIUGX/JF8hQuG8/8odh4rGqduBCBBPx3/NRVBZZYa2Ie3zyGNbQCcYTQRm
 CAaMj/O9xuxD7d5C84JQndNAK9eHYip9Q0vSpBOCzNMdNRlH/cNn/v7AZDpVMbeUuuduUZjuXhR
 7bB5P58wI6HbgVZbAGR/T1y0cfXvZN8hK1ZiuGkShVQjLp4mQ+BRWs2Jv3qLbCGT6BkTGzx9aH/
 JFOooZk5mcBdqlRMEj9Fv2sXQJ+6ODNTJm36QGNlhgYw6qN+GvSfNQz0zXRHUdZApipWpBUfRwl
 a4i7KB7TL1267bU1ayrz/QPM2P4E92vNcROSdiLuiBf8cUFhVksqjxquFpcCtZi/5ec/zjSX1yF
 OQzVTGTB+IOuj9kgFumWVivdFYotB1JazIqqFG3Mg==
X-Received: by 2002:a05:600c:6291:b0:48e:6f39:f7be with SMTP id
 5b1f17b1804b1-48fc9a09fc3mr5897735e9.10.1778618063518; 
 Tue, 12 May 2026 13:34:23 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d69d0bsm16350635e9.13.2026.05.12.13.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 13:34:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 06/12] hw/arm/omap: Remove unused wakeup irq
Date: Tue, 12 May 2026 21:34:08 +0100
Message-ID: <20260512203414.3633237-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512203414.3633237-1-peter.maydell@linaro.org>
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

The OMAP code creates a qemu_irq whose set function is
omap_mpu_wakeup(), and passes that irq into omap_mpuio_init(), which
saves it in its omap_mpuio_s::wakeup field.  However nothing ever
touches that qemu_irq again, so omap_mpu_wakeup() is never called.

Remove all this as dead code.  This lets us remove a direct call to
cpu_interrupt(cpu, CPU_INTERRUPT_EXITTB) from within board/SoC code,
which is pretty ugly and might not even do the right thing these
days.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/omap1.c        | 18 ++----------------
 include/hw/arm/omap.h |  2 --
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 40ca8c9890..80168644ce 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -1846,7 +1846,6 @@ struct omap_mpuio_s {
     qemu_irq kbd_irq;
     qemu_irq *in;
     qemu_irq handler[16];
-    qemu_irq wakeup;
     MemoryRegion iomem;
 
     uint16_t inputs;
@@ -2074,14 +2073,13 @@ static void omap_mpuio_onoff(void *opaque, int line, int on)
 
 static struct omap_mpuio_s *omap_mpuio_init(MemoryRegion *memory,
                 hwaddr base,
-                qemu_irq kbd_int, qemu_irq gpio_int, qemu_irq wakeup,
+                qemu_irq kbd_int, qemu_irq gpio_int,
                 omap_clk clk)
 {
     struct omap_mpuio_s *s = g_new0(struct omap_mpuio_s, 1);
 
     s->irq = gpio_int;
     s->kbd_irq = kbd_int;
-    s->wakeup = wakeup;
     s->in = qemu_allocate_irqs(omap_mpuio_set, s, 16);
     omap_mpuio_reset(s);
 
@@ -3693,16 +3691,6 @@ static void omap_setup_dsp_mapping(MemoryRegion *system_memory,
     }
 }
 
-void omap_mpu_wakeup(void *opaque, int irq, int req)
-{
-    struct omap_mpu_state_s *mpu = opaque;
-    CPUState *cpu = CPU(mpu->cpu);
-
-    if (cpu->halted) {
-        cpu_interrupt(cpu, CPU_INTERRUPT_EXITTB);
-    }
-}
-
 static const struct dma_irq_map omap1_dma_irq_map[] = {
     { 0, OMAP_INT_DMA_CH0_6 },
     { 0, OMAP_INT_DMA_CH1_7 },
@@ -3765,8 +3753,6 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
     s->sdram_size = memory_region_size(dram);
     s->sram_size = OMAP15XX_SRAM_SIZE;
 
-    s->wakeup = qemu_allocate_irq(omap_mpu_wakeup, s, 0);
-
     /* Clocks */
     omap_clk_init(s);
 
@@ -3912,7 +3898,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
     s->mpuio = omap_mpuio_init(system_memory, 0xfffb5000,
                                qdev_get_gpio_in(s->ih[1], OMAP_INT_KEYBOARD),
                                qdev_get_gpio_in(s->ih[1], OMAP_INT_MPUIO),
-                               s->wakeup, omap_findclk(s, "clk32-kHz"));
+                               omap_findclk(s, "clk32-kHz"));
 
     s->gpio = qdev_new("omap-gpio");
     omap_gpio_set_clk(OMAP1_GPIO(s->gpio), omap_findclk(s, "arm_gpio_ck"));
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 14d6e9d214..ea5c0eff8b 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -463,8 +463,6 @@ struct omap_mpu_state_s {
 struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *sdram,
                 const char *core);
 
-void omap_mpu_wakeup(void *opaque, int irq, int req);
-
 #define OMAP_BAD_REG(paddr)        \
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad register %#08"HWADDR_PRIx"\n", \
                       __func__, paddr)
-- 
2.43.0


