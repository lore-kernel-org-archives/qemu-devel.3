Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4D5EC110C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKE-0001Kz-W2; Mon, 23 Feb 2026 12:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKD-0001Ib-EV
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:25 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKB-0008WQ-L7
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:25 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48374014a77so47446135e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866142; x=1772470942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pgbI5Qqmzf+DxfEbRHQMqpET1e5tAlZwB7KWYK/P7d0=;
 b=k5HXl6gExcFnJ1fxyB00K45ax3M6VPMupSnznJe3Phfg1a3vgyXE0Gz627KoJInyNW
 yoXsv4hX1qVtyLhKyi3CXNGWhk0bnscbL7T22OY5bRnoKKxgYQSJ9OdELhNl7gKWciU5
 emxeftfebOEXqAIBNcAgbGH+svNGv/BW8I8AuNevVc9Uetwe4GtV7pU1ml1Gcyx5TITm
 Yu4XfJYLW0QutTwGxpOiBFb80D16zpGr75ns7ciij4N3ufH4E2fvBAkNd+UnWy2bbbPa
 5R1TqugnIYrZ4sVw6Xv+djSgTuYA0pxjWMT0Oh3QZxJDLi9XT/QW9SPXzTnHaGA2nn11
 nDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866142; x=1772470942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pgbI5Qqmzf+DxfEbRHQMqpET1e5tAlZwB7KWYK/P7d0=;
 b=u2UNBtZnlW0fgI7jACZ5iL23exE0+yN5s8zsHObZXDq1qnM6yp4Hu7TWr9gE/BlhVX
 yw75v4PzQtdl1lurF6saPhhj1/nb6o4jccqn1P9Okio2yZw6qXgRAPxE+B4SvvNUlCPQ
 Ph3vMGRQ8+jAbWJ79CeSNJB4CTFX824+k0tRsuIyxhQWce6r5bfMC3cAHr2uOl9+MgW2
 ycKFOLHAWTM1c4ddPALD2Vvobkwgii2eJqlbfgeDfHwcUpPLkXDzACvB6vIzpD9wc9Lw
 8Pe5NHOacgdne9WvlZzFSWm+37dKvWz06z4hBC+fA2ZDp2X0lmMtVl/TQLWaCPVAN2of
 xbWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrp3tmHDfXLS9k7fcVCjio2E2Kp3qf9DLbeY3FNNOb+IbPdJEuolvyr7aiVix6Oi/dTO92sKs4V4f1@nongnu.org
X-Gm-Message-State: AOJu0YwVwLv68V3cjonciv1xO2dEdUthesW0eOeh0NeOXws4n3GnPgK6
 e9kETWQsi1Koy8zxe5Ty2aTKkCZhqJNHS8cf+UlByzcwAqBWuQBALmcGe/LCUzZDIue02Uvixi9
 6Bgr/
X-Gm-Gg: AZuq6aIvds08pNbfQ3NkRmoFGRF1CK36RnLam/y6lF6MYMdVUJDJLuy+x8HZ7Y/2FZ3
 85tCRZjRgkM9IT65ZoeqvNpt2eEBBt9dyPSdg5F/1pKFe9BeNzueG+eZBX0QWj8atJAArJ8JefY
 8VbO2wrXYUK8rOTIWl0/5s8mpn9sueQFh6UL8q/PW3vT4KNn+BR1ItFHmfSVbaWEAD/W1aBq6Fo
 Ml4Ay/bfTi5F/r+zrCi9j5jPe7kDhPwlThUXXRkVN9pUdDyvlLDFY/B3EfUl4MOu4ZsLt418qE/
 HNYpa94i+K84uvsHgfqC1YYg80x/KkvqzVPkJ95CD9RsY+tXiNmA430MvMKq3SA8HXaqGnk6tsO
 WjS/rdOA6cJFFJsEmgxmMxPUaBKFRnKIupo2rRkpoakcWHyzB7TqVpkAkUBQLHrtMplYl1UcIxV
 R1mmbIyBIJ5jFIW/jFjmGNd1smrsbAFBwrxv1DgvMupVKI5X0HAomSv1U+3MttpIjGEACNSu8d1
 RRUsKEikVufkvlk64wen10v24JxZF0=
X-Received: by 2002:a05:600c:3e05:b0:483:6fc6:1e20 with SMTP id
 5b1f17b1804b1-483a95b5410mr161846545e9.9.1771866141963; 
 Mon, 23 Feb 2026 09:02:21 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 07/65] hw/intc/arm_gicv5: Create inbound GPIO lines for SPIs
Date: Mon, 23 Feb 2026 17:01:14 +0000
Message-ID: <20260223170212.441276-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

The GICv5 IRS may have inbound GPIO lines corresponding to SPIs
(shared peripheral interrupts).  Unlike the GICv3, it does not deal
with PPIs (private peripheral interrupts, i.e.  per-CPU interrupts):
in a GICv5 system those are handled entirely within the CPU
interface.  The inbound GPIO array is therefore a simple sequence of
one GPIO per SPI that this IRS handles.

Create the GPIO input array in gicv5_common_init_irqs_and_mmio().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c                | 11 ++++++++++-
 hw/intc/arm_gicv5_common.c         |  5 +++++
 hw/intc/trace-events               |  1 +
 include/hw/intc/arm_gicv5_common.h |  4 ++++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 73a6e629df..7ef48bb450 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -181,6 +181,15 @@ static const MemoryRegionOps config_frame_ops[NUM_GICV5_DOMAINS] = {
     },
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
@@ -217,7 +226,7 @@ static void gicv5_realize(DeviceState *dev, Error **errp)
      * NS domain.
      */
     cs->implemented_domains = (1 << GICV5_ID_NS);
-    gicv5_common_init_irqs_and_mmio(cs, config_frame_ops);
+    gicv5_common_init_irqs_and_mmio(cs, gicv5_set_spi, config_frame_ops);
 }
 
 static void gicv5_init(Object *obj)
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index c8b6704fe4..0f966dfd1b 100644
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
index b22f020a53..be898abcd5 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -29,6 +29,9 @@
  *   IRS (this is IRS_IDR7.SPI_BASE); default is 0
  * + QOM property "spi-irs-range": number of SPI INTID.ID managed on this
  *   IRS (this is IRS_IDR6.SPI_IRS_RANGE); defaults to value of spi-range
+ * + unnamed GPIO inputs: the SPIs handled by this IRS
+ *   (so GPIO input 0 is the SPI with INTID SPI_BASE, input 1 is
+ *   SPI_BASE+1, and so on up to SPI_BASE + SPI_IRS_RANGE - 1)
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


