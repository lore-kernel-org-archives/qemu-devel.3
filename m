Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F2F10ED659
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65Br-0006WT-Lh; Fri, 27 Mar 2026 07:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Bh-0006Nt-Bi
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:13 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Be-0007jf-VC
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:12 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-439fe4985efso1507221f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610229; x=1775215029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZSYEcEWU8r5tbbT6wFppapn1QdgzR56tHNGZiMLYIEE=;
 b=n/TanvUfvJuYl4bXGG9Gm+67dn/ukX5VuO0DXogeN2JWgICnjnFRx7Ax/jH8rWKNk8
 QjU9rPAnZV29fzFwcqOsS1DRDTcIVsq7jOnW3ar350LP1JDWyFTTyJvdNzv9o+yKkhxh
 5+oG4qFEXhziYvR0pc2F6Lk+QOn6Y9oD4TXYLqxxJF13SFfvYj+E0vf6YwVxjFseIds9
 mZorseGYj88ZD0fwz0QtYlG1C+YiQ2PcDvRX7qGHzLw6z7a1ZeYtdIZXv2x5+N2RxXcj
 c/0Z5s7sWB3xg3z90KWI04s1e0jlB8nElP0fM/nTr7eeALCsvqNsXWMf5NbSISxCuSWT
 Aa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610229; x=1775215029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZSYEcEWU8r5tbbT6wFppapn1QdgzR56tHNGZiMLYIEE=;
 b=q2a/+aZvzJbfU830T8g6XbbA0KC3CUQujzzN9JQmFbGBetb7CjzqF8KgxxajeXLrUY
 Mc1KqIyBmMJcU1qGAnVW9km52SisGJUdg1kV/pAn3h4aoGDP9hqFmkvEP5Tl5ntJhu8/
 PMqMISBHc6GSDMk7hRstT4fl2L5WefTznUCZ6d1FdDLtjsgopB6XaZdQ9KtVAkgp2kYj
 QETu/D5V/eoP4tIK4oC3USPQaDOu5GV8hc+x7gY30AMAWSo/KPd/lsyzHTHIzW79rqUa
 bhABpihtOHVDRH9RjWR2/y4068voTC/9E8oE4rC0qY+Oy94Db10yXiF7eLveRGNdjF3o
 bwxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzzMy8y+FJv26lbqQ7JpddgUtR4kv6HSLDOJSJUcsvCKaYikmVtmxhYawriqMN9vZj5stoMbkrMLeu@nongnu.org
X-Gm-Message-State: AOJu0Yxj2+nZ3M7+vCkMJ+IToPQT9b2XeWXcPBarNmEHENd3VGE7Stx7
 XaJP2EUqZ13KvDSf6pQdZhS+tiCP+g3HSbDRvYA6Dfdl6y3B+Oi7iQX0/AdpHYnkcQo=
X-Gm-Gg: ATEYQzxpvC3N+sfnG8V96CzayTnA5cBMLSlGsi42ovKdWez/R8O+WSGZLkFO/Vcc15k
 b7BiTA2W+xzr/aDj/YFZux7iSYa91ABzTTc4lXNY1vxlSndaagKF5QiABHT37TBGtLiJuWNAfc+
 ddXxMuKhDUCWr45zJVC3gU8lnTtaxkwYo0drkigwMAq7UtvjdFQ2xx+lQ5QKA1/qPNGkYsFcuvP
 U4t47O9b7D3EfE3WRqJVsJ8mVhUauHNJPxUrBt4+PmgA42xYxsa2h5h2WmPR33XqeXQo9Jup9Go
 v8MtjATG0YrjWCtoHR0SVvXyvQ3WohIqhV4475cV7mQG+Dw/icIRSAmKpNyq3L67R2aZHc3X3DD
 yu3RqLogZ2YF//seFZYpKoP1ySYFK8upC0/0xy3lmI7M3HrO9NDkAPtYH0oHiOBDkxHNEgdYGVo
 zs4M1mOdd3jRJ8z63R0Dzt89wtutXRwDjqYDmXxzd67D9GUoFHzg2OGNHE7CAXAZKC1as5LLqAF
 HD5hBjvhSM7bsqFCRFhMB3zalnCBrY=
X-Received: by 2002:a5d:64c5:0:b0:43b:5356:a7fb with SMTP id
 ffacd0b85a97d-43b9ea775e8mr3015595f8f.49.1774610229392; 
 Fri, 27 Mar 2026 04:17:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 08/65] hw/intc/arm_gicv5: Create inbound GPIO lines for SPIs
Date: Fri, 27 Mar 2026 11:16:03 +0000
Message-ID: <20260327111700.795099-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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


