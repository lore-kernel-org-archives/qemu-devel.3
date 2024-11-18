Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CC5D49212
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD1AM-0003vN-PI; Mon, 18 Nov 2024 07:47:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD1AL-0003pN-Cc
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:47:41 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD1AJ-0005QQ-2R
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:47:40 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43158625112so17935415e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731934057; x=1732538857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RMNsAKsb3Qz5FWv2s5/qn+pAlL7XprZnFyQSkFTZ2s=;
 b=q1bDQdYd1hFDMex44wN3IjKwShz0w+NbbHXstuu48clkx3A5r7FZBUL1Uudgo/WGoq
 ZTZKpFHiNHzLIAOfi3PyJ8Um5waflRvGNa0xK83qAfswL4YJTp57mOU2b10W3fIv7lMV
 YSVCGCrPyjxS9pL6EyTL+Aeua0PtctKlsii9sAJiSMQ0IAPYg7hExXxJRtUpGOeq+jJ8
 YHI0ek6wOdrggeLI4KPc93KWALciKKoOguHBrmHWtA0CjC3pakMCEvzdkTCiIi8sMUZI
 aOzI4SZl0R1d8PubhpGl5WOHatJ5DHE3fD1inrXEWtHa9Ngu/Ot3vSj4hqz0PafQk9Q+
 AvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731934057; x=1732538857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4RMNsAKsb3Qz5FWv2s5/qn+pAlL7XprZnFyQSkFTZ2s=;
 b=TBC0YRIEa40KbTgQCyAo9BrxynraBodaj8DeoBl0zKcYLOEKIa3lhaQsE5BghK8TL9
 1b3NUx3LjLOU7xoajNPj1bdh3rYZUTGJvPZ0SQpwsX7CH20ZNsyqN8XgLqNQoA3QZ0YR
 mcakYTqjI9gjWiO6+ugNfNaF40IGvq0QslkkD/CNJb6WXpkPireEy0/UW6TJLcGVRVMH
 4+6Udgvku+zg/zov6PyCVDEr3uU+Hy0BUwDGxpsiv6x1COkzrpf+K8rx0+BAkfBxhcAa
 EJ/+fhXEYKye+Du4bu2vbosnnKowFiRJx0amOpnsoQ0b/O1UToImi0SZFEvUKbFV7ZUv
 xgoQ==
X-Gm-Message-State: AOJu0YwSh+m7QwQFiGdaYdjI62TWIr8OtR4cpqjQtvLOHAFVkFnBvGWc
 DxsAADWH2HDAT4bwHXRBYxmijsAnGuU1BURpuXdqsWaLsFEHhlyGC+O/jKW+5NBiXSBFyldMt/o
 B
X-Google-Smtp-Source: AGHT+IH0AQyZCKFFBKjD+MaHks98rxP+4fLTkqkhfvw2lFFAyZoT/5CiSZylIywQmXVG3klrX8FZMw==
X-Received: by 2002:a05:600c:1c23:b0:430:5846:7582 with SMTP id
 5b1f17b1804b1-432df72069amr96237215e9.7.1731934056920; 
 Mon, 18 Nov 2024 04:47:36 -0800 (PST)
Received: from localhost.localdomain ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da28b698sm157531375e9.27.2024.11.18.04.47.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Nov 2024 04:47:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/15] hw/sd/sdhci: Fix coding style
Date: Mon, 18 Nov 2024 13:46:36 +0100
Message-ID: <20241118124643.6958-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118124643.6958-1-philmd@linaro.org>
References: <20241118124643.6958-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Fix coding style issues from checkpatch.pl

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20241114094839.4128404-2-jamin_lin@aspeedtech.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci.c | 64 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 22 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index dbe5c2340c..37875c02c3 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -233,7 +233,7 @@ static void sdhci_raise_insertion_irq(void *opaque)
 
     if (s->norintsts & SDHC_NIS_REMOVE) {
         timer_mod(s->insert_timer,
-                       qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + SDHC_INSERTION_DELAY);
+                qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + SDHC_INSERTION_DELAY);
     } else {
         s->prnsts = 0x1ff0000;
         if (s->norintstsen & SDHC_NISEN_INSERT) {
@@ -251,7 +251,7 @@ static void sdhci_set_inserted(DeviceState *dev, bool level)
     if ((s->norintsts & SDHC_NIS_REMOVE) && level) {
         /* Give target some time to notice card ejection */
         timer_mod(s->insert_timer,
-                       qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + SDHC_INSERTION_DELAY);
+                qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + SDHC_INSERTION_DELAY);
     } else {
         if (level) {
             s->prnsts = 0x1ff0000;
@@ -289,9 +289,11 @@ static void sdhci_reset(SDHCIState *s)
     timer_del(s->insert_timer);
     timer_del(s->transfer_timer);
 
-    /* Set all registers to 0. Capabilities/Version registers are not cleared
+    /*
+     * Set all registers to 0. Capabilities/Version registers are not cleared
      * and assumed to always preserve their value, given to them during
-     * initialization */
+     * initialization
+     */
     memset(&s->sdmasysad, 0, (uintptr_t)&s->capareg - (uintptr_t)&s->sdmasysad);
 
     /* Reset other state based on current card insertion/readonly status */
@@ -305,7 +307,8 @@ static void sdhci_reset(SDHCIState *s)
 
 static void sdhci_poweron_reset(DeviceState *dev)
 {
-    /* QOM (ie power-on) reset. This is identical to reset
+    /*
+     * QOM (ie power-on) reset. This is identical to reset
      * commanded via device register apart from handling of the
      * 'pending insert on powerup' quirk.
      */
@@ -445,8 +448,10 @@ static void sdhci_read_block_from_card(SDHCIState *s)
         s->prnsts &= ~SDHC_DAT_LINE_ACTIVE;
     }
 
-    /* If stop at block gap request was set and it's not the last block of
-     * data - generate Block Event interrupt */
+    /*
+     * If stop at block gap request was set and it's not the last block of
+     * data - generate Block Event interrupt
+     */
     if (s->stopped_state == sdhc_gap_read && (s->trnmod & SDHC_TRNS_MULTI) &&
             s->blkcnt != 1)    {
         s->prnsts &= ~SDHC_DAT_LINE_ACTIVE;
@@ -548,8 +553,10 @@ static void sdhci_write_block_to_card(SDHCIState *s)
     sdhci_update_irq(s);
 }
 
-/* Write @size bytes of @value data to host controller @s Buffer Data Port
- * register */
+/*
+ * Write @size bytes of @value data to host controller @s Buffer Data Port
+ * register
+ */
 static void sdhci_write_dataport(SDHCIState *s, uint32_t value, unsigned size)
 {
     unsigned i;
@@ -594,9 +601,11 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
         return;
     }
 
-    /* XXX: Some sd/mmc drivers (for example, u-boot-slp) do not account for
+    /*
+     * XXX: Some sd/mmc drivers (for example, u-boot-slp) do not account for
      * possible stop at page boundary if initial address is not page aligned,
-     * allow them to work properly */
+     * allow them to work properly
+     */
     if ((s->sdmasysad % boundary_chk) == 0) {
         page_aligned = true;
     }
@@ -702,7 +711,8 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
         dma_memory_read(s->dma_as, entry_addr, &adma2, sizeof(adma2),
                         MEMTXATTRS_UNSPECIFIED);
         adma2 = le64_to_cpu(adma2);
-        /* The spec does not specify endianness of descriptor table.
+        /*
+         * The spec does not specify endianness of descriptor table.
          * We currently assume that it is LE.
          */
         dscr->addr = (hwaddr)extract64(adma2, 32, 32) & ~0x3ull;
@@ -977,8 +987,10 @@ static bool sdhci_can_issue_command(SDHCIState *s)
     return true;
 }
 
-/* The Buffer Data Port register must be accessed in sequential and
- * continuous manner */
+/*
+ * The Buffer Data Port register must be accessed in sequential and
+ * continuous manner
+ */
 static inline bool
 sdhci_buff_access_is_sequential(SDHCIState *s, unsigned byte_num)
 {
@@ -1206,8 +1218,10 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         MASKED_WRITE(s->argument, mask, value);
         break;
     case SDHC_TRNMOD:
-        /* DMA can be enabled only if it is supported as indicated by
-         * capabilities register */
+        /*
+         * DMA can be enabled only if it is supported as indicated by
+         * capabilities register
+         */
         if (!(s->capareg & R_SDHC_CAPAB_SDMA_MASK)) {
             value &= ~SDHC_TRNS_DMA;
         }
@@ -1279,8 +1293,10 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         } else {
             s->norintsts &= ~SDHC_NIS_ERR;
         }
-        /* Quirk for Raspberry Pi: pending card insert interrupt
-         * appears when first enabled after power on */
+        /*
+         * Quirk for Raspberry Pi: pending card insert interrupt
+         * appears when first enabled after power on
+         */
         if ((s->norintstsen & SDHC_NISEN_INSERT) && s->pending_insert_state) {
             assert(s->pending_insert_quirk);
             s->norintsts |= SDHC_NIS_INSERT;
@@ -1396,8 +1412,10 @@ void sdhci_initfn(SDHCIState *s)
 {
     qbus_init(&s->sdbus, sizeof(s->sdbus), TYPE_SDHCI_BUS, DEVICE(s), "sd-bus");
 
-    s->insert_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_raise_insertion_irq, s);
-    s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_data_transfer, s);
+    s->insert_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                   sdhci_raise_insertion_irq, s);
+    s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                     sdhci_data_transfer, s);
 
     s->io_ops = &sdhci_mmio_le_ops;
 }
@@ -1445,11 +1463,13 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
 
 void sdhci_common_unrealize(SDHCIState *s)
 {
-    /* This function is expected to be called only once for each class:
+    /*
+     * This function is expected to be called only once for each class:
      * - SysBus:    via DeviceClass->unrealize(),
      * - PCI:       via PCIDeviceClass->exit().
      * However to avoid double-free and/or use-after-free we still nullify
-     * this variable (better safe than sorry!). */
+     * this variable (better safe than sorry!).
+     */
     g_free(s->fifo_buffer);
     s->fifo_buffer = NULL;
 }
-- 
2.45.2


