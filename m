Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C489CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11H-0003SP-DL; Thu, 07 May 2026 11:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11C-0003PP-Rd
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:08 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11A-0003nM-UC
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:06 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so12017605e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169123; x=1778773923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Cyw1iu3/HzLXP/SQwUPO0JA2XKkIV3045uDKDgmS9PY=;
 b=HRLzbezszKfrZfqlppxFqAghmeCZg2vfpF2IlVq6D/x9h+dLXxDIQk9Ik4jqkklJEs
 Gq57l2CLxjRKoX/VsUeEjg1utQwGtBWoLHCYHIiJWFhg7ZAKXc2tEP0O1GPLU7EzKZ3P
 xph5/aBdm3/kaJRLv1Ef2X/K42fKB4zo7EK6/4MpgzWlxKsOIEbNrSZSJ9dgc1LnYFit
 ZaA8DUf0QGbUVmOvT5k8LdODVmqF4gvrxPnQmy/d8dH0IcI3OBIujvnzBeOydWX0vQq8
 D1t1d85uT7PS2dMwecicRuAweIqMtA+iBHAc/7hfmqZFKN5fZ9nl17jFgP5REFKzM6Gm
 pfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169123; x=1778773923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Cyw1iu3/HzLXP/SQwUPO0JA2XKkIV3045uDKDgmS9PY=;
 b=dHiM4ceQnyS3tK7s146l3UyhHPPWxrk/B7bU3HvdQfPLpTfocUpl1TkRogpD9VHwae
 unFkELtaM/mpzgIeZG93a4l/CVhnrXNNVfM02wn9evuLCN5ffDaupeVI11Zp5ZpJtff8
 rAErZ0k2dVHakQqHVWyB4C/mAKBBjKyXGvw6qp8ydWLReAPfy9jm3fZvvN8Qfbhku+Nh
 y+zMpGnXOU03EzAWFGifGGk4rD9GJePDPQ7czBUVT7BGpBwudc4IVjwxsZ39Aw5chwvl
 ZUpvGy+wdsTeueh1Ac/RaUQhv1kwGXvhIXrxrijP+I3XJ6MGBcjc2YlL9IY/KREOaBr8
 MdlQ==
X-Gm-Message-State: AOJu0Yzz73YSPkFJBDU2Ia1espgCcUVITgXx/GK6lNUZyRE5a9anxS3S
 iHDwKTclzgbI+J1GCt+eQa7SK4JvJ7+NEzlTUyj+6SioDx2W6tx9tw8YophF7uyRH4suIAd2AWe
 j/qNT
X-Gm-Gg: AeBDiev/LgTqqf2tIJaf1/pza5rt0JIP6am5wINmqbs0VCWK0ApoUixZAGCJf8FBSOq
 HfmEkV4oAWCR1KmyHzmYY7gb2/M5u9XROnZSvuCknOmXWreTuc+hPE2s9R5zV7tkyaXBwZ90B86
 tG5EkniBjzlhStyeX2FjNWGRoPGCG57NYpU021npzEtBDQ+qsUZmKnDQJeC9a75v1QUmB7m0fAB
 EPknhYm+TwgIfU3cjSCEQTIYK1/zhDBfi+2Lb+7cZvxiZqS4Uhn23aX+E/4mOQgghckYmQWq/mJ
 gQ8OgkpYgEyxZzrokAYGC/cUm/OQsG9V7PwMBJePuVrxxcqlzLxH0RasAWjxFncjMlJPnf2k4W9
 L7S8p/TJ3aQIikQPQmgfPaRC4+4LV/VNKK9ATYOA2/ZVPmJbbPSqM1Huj/4KkY/K7//6foz7dym
 S9VHTyh0IAJk4JKUpRrHC4DcC+8zIIug2yIy1Htu9LTxMJ+wYrbjbYjWgIybrzJrx7uGI46Av34
 zaSlQh6nY2XHBsgCnMWFKk3hFyrgOs=
X-Received: by 2002:a05:600c:871b:b0:483:709e:f238 with SMTP id
 5b1f17b1804b1-48e51f4652fmr145322275e9.29.1778169123079; 
 Thu, 07 May 2026 08:52:03 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/67] hw/intc/arm_gicv5: Create inbound GPIO lines for SPIs
Date: Thu,  7 May 2026 16:50:55 +0100
Message-ID: <20260507155154.1886557-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

The GICv5 IRS may have inbound GPIO lines corresponding to SPIs
(shared peripheral interrupts).  Unlike the GICv3, it does not deal
with PPIs (private peripheral interrupts, i.e.  per-CPU interrupts):
in a GICv5 system those are handled entirely within the CPU
interface.  The inbound GPIO array is therefore a simple sequence of
one GPIO per SPI that this IRS handles.

Create the GPIO input array in gicv5_common_init_irqs_and_mmio().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260327111700.795099-9-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c                | 11 ++++++++++-
 hw/intc/arm_gicv5_common.c         |  5 +++++
 hw/intc/trace-events               |  1 +
 include/hw/intc/arm_gicv5_common.h |  4 ++++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 64bec16bdd..cb1234b022 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -160,6 +160,15 @@ static const MemoryRegionOps config_frame_ops[NUM_GICV5_DOMAINS] = {
     FRAME_OP_ENTRY(el3, GICV5_ID_EL3),
 };
 
+static void gicv5_set_spi(void *opaque, int irq, int level)
+{
+    /* These irqs are all SPIs; the INTID is irq + s->spi_base */
+    GICv5Common *cs = ARM_GICV5_COMMON(opaque);
+    uint32_t spi_id = irq + cs->spi_base;
+
+    trace_gicv5_spi(spi_id, level);
+}
+
 static void gicv5_reset_hold(Object *obj, ResetType type)
 {
     GICv5 *s = ARM_GICV5(obj);
@@ -196,7 +205,7 @@ static void gicv5_realize(DeviceState *dev, Error **errp)
      * NS domain.
      */
     cs->implemented_domains = (1 << GICV5_ID_NS);
-    gicv5_common_init_irqs_and_mmio(cs, config_frame_ops);
+    gicv5_common_init_irqs_and_mmio(cs, gicv5_set_spi, config_frame_ops);
 }
 
 static void gicv5_init(Object *obj)
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index 3448734686..b58913b970 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -38,10 +38,15 @@ static const MemoryRegionOps bad_frame_ops = {
 };
 
 void gicv5_common_init_irqs_and_mmio(GICv5Common *cs,
+                                     qemu_irq_handler handler,
                                      const MemoryRegionOps config_ops[NUM_GICV5_DOMAINS])
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(cs);
 
+    if (cs->spi_irs_range) {
+        qdev_init_gpio_in(DEVICE(cs), handler, cs->spi_irs_range);
+    }
+
     for (int i = 0; i < NUM_GICV5_DOMAINS; i++) {
         g_autofree char *memname = g_strdup_printf("gicv5-irs-%d", i);
         const MemoryRegionOps *ops = gicv5_domain_implemented(cs, i) ?
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 54777f6da3..0797a23c1a 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -232,6 +232,7 @@ gicv5_read(const char *domain, uint64_t offset, uint64_t data, unsigned size) "G
 gicv5_badread(const char *domain, uint64_t offset, unsigned size) "GICv5 IRS %s config frame read: offset 0x%" PRIx64 " size %u: error"
 gicv5_write(const char *domain, uint64_t offset, uint64_t data, unsigned size) "GICv5 IRS %s config frame write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 gicv5_badwrite(const char *domain, uint64_t offset, uint64_t data, unsigned size) "GICv5 IRS %s config frame write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u: error"
+gicv5_spi(uint32_t id, int level) "GICv5 SPI ID %u asserted at level %d"
 
 # arm_gicv5_common.c
 gicv5_common_realize(uint32_t irsid, uint32_t num_cpus, uint32_t spi_base, uint32_t spi_irs_range, uint32_t spi_range) "GICv5 IRS realized: IRS ID %u, %u CPUs, SPI base %u, SPI IRS range %u, SPI range %u"
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index ea01b2a1db..10276d652f 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -29,6 +29,9 @@
  *   IRS (this is IRS_IDR7.SPI_BASE); default is 0
  * + QOM property "spi-irs-range": number of SPI INTID.ID managed on this
  *   IRS (this is IRS_IDR6.SPI_IRS_RANGE); defaults to value of spi-range
+ * + unnamed GPIO inputs: the SPIs handled by this IRS
+ *   (so GPIO input 0 is the SPI with INTID SPI_BASE, input 1 is
+ *   SPI_BASE + 1, and so on up to SPI_BASE + SPI_IRS_RANGE - 1)
  *
  * sysbus MMIO regions (in order matching IRS_IDR0.INT_DOM encoding):
  * - IRS config frame for the Secure Interrupt Domain
@@ -91,6 +94,7 @@ struct GICv5CommonClass {
  * of MemoryRegionOps structs.
  */
 void gicv5_common_init_irqs_and_mmio(GICv5Common *cs,
+                                     qemu_irq_handler handler,
                                      const MemoryRegionOps ops[NUM_GICV5_DOMAINS]);
 
 /**
-- 
2.43.0


