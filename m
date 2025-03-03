Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A1FC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp37w-00089I-Cg; Mon, 03 Mar 2025 05:34:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp37l-000884-0z; Mon, 03 Mar 2025 05:34:13 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp37i-00075E-A2; Mon, 03 Mar 2025 05:34:12 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2239c066347so20146285ad.2; 
 Mon, 03 Mar 2025 02:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740998048; x=1741602848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OHFuA1IDeCXzMZEWx4tiiLmvNJzkMKwGnfPjMfDjh4=;
 b=kfOETj+zdznwmPa442T0c39+F2So1dyeWi4rHOyrejPh20sAiypTw3idMghBl6OPbg
 ApnlaiT3gCZhHsIkU+mfdo5mu+ydb5mleCv9zaKER4v+q8weMvD67YA1NcxIOjeowvgL
 ZDNjVfuj7lg5hedWOLa7I6etx/WJ6qU2a3BpuY70r06xZM2HBlRZRZuCgwuXSq5sCuD9
 I0X2LX+k61kSUC7KoWiuz3o+XWqLLjkdsjBA+Ek3nr8n2ALCIRWWaiYCACN265n8a8I8
 +1c+1CB6cPJq13hhiKRyxrbgndGfxPpnTYCGBc9EtTgbCwMkwLjz9NyQdiXvPsVfILOV
 ZIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740998048; x=1741602848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9OHFuA1IDeCXzMZEWx4tiiLmvNJzkMKwGnfPjMfDjh4=;
 b=LhkyW/grpi87mx7hO6jbBBA+DGxq3gCJRSPwf7fMPNUb4zFXOPP6zT485AWw5I5RFv
 7ICVTMZBXPe9U71/znr6d/y6rZzkEsXd3W3laoIGekh5p2vOBjIM3Ic+dMWgNWK4aMcW
 UB83S44GrbzD4Nu3WeGyJG3LgowKU3pXgVjqTVcNWl++Xppl//BuvuLLQnxMmZ+rqGiH
 ZFkOVFsNhBch5NtIOtMzLUa/omoERoRGvkMef/alXnM4WmkYs97FNAF0+r6QVm/wKmug
 EGc2O2Ooxrwaj7ad/kejAsK8M81uTENbV2VkkO3hOmAaYmgVbGktScMdGG1aBYtsZTA1
 Myvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8sKvnF0FF11PZ2p5QXIfXyokald8xGKZkY9lSUsRqr4hl+q/q/Ejfx+EV7HSewDI5yIJu2XOluORL@nongnu.org
X-Gm-Message-State: AOJu0YxUsVt+9YQ94drRpEOtRMeqw1QosiGKr/6mSW9Sg6dXHYGvB+Uc
 ouF174CK1HZ6Ug0j2HL61JPrc5mlzKV/mwKiZnjpWjJC6s9a7NAhEdYQ3Q==
X-Gm-Gg: ASbGncuu4nKBIllpajlju0DHFuMJSbl/d7YKlOvbit6mo6ha2LH6kOAteLQOxmE0Kto
 dCn4JDMKGJv7pm33Oh9yibQGYw70BgEsuQRW2dL2l0IuPE6hop4XBJfXIDPbHDbYDiZYps70yIn
 Cb+Erx13bviKZmiIU0iAr2Xe7UDCiV1K/wev6g1Opj/bnBLW9CrListIPHGFRvATQIKQsvrAZAO
 omDTaknCQfaw+Rwffx2idpRjQKGS3Ic2yXPpUh/QTfowPxALVoLlz6P1sQg6kV7GoCRZBDwSQzQ
 U1v2Gn2n82vBPjUiNl9br8zTASeQFjN+Ww2E0ueSvH1scBTWj5k=
X-Google-Smtp-Source: AGHT+IGCkNLX5Vl8emdplrcLDykc/baLpTyf6zcAFdJsPlgPOQA7s8zKxPl0SRq8YY3wEuWiq06uSw==
X-Received: by 2002:a17:903:22d2:b0:220:fe51:1aab with SMTP id
 d9443c01a7336-2236924f926mr209499875ad.38.1740998048102; 
 Mon, 03 Mar 2025 02:34:08 -0800 (PST)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea698f309sm8594558a91.42.2025.03.03.02.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 02:34:07 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 1/6] ppc/pnv: Support LPC host controller irqs other than
 serirqs
Date: Mon,  3 Mar 2025 20:33:52 +1000
Message-ID: <20250303103359.578994-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303103359.578994-1-npiggin@gmail.com>
References: <20250303103359.578994-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The LPC model has only supported serirqs (ISA device IRQs), however
there are internal sources that can raise other interrupts. Update the
device to handle these interrupt sources.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_lpc.c | 64 +++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 0480a60f3f7..d0fccc165d9 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -456,46 +456,18 @@ static void pnv_lpc_eval_irqs(PnvLpcController *lpc)
 {
     uint32_t active_irqs = 0;
 
-    if (lpc->lpc_hc_irqstat & PPC_BITMASK32(16, 31)) {
-        qemu_log_mask(LOG_UNIMP, "LPC HC Unimplemented irqs in IRQSTAT: "
-                                 "0x%08"PRIx32"\n", lpc->lpc_hc_irqstat);
-    }
-
-    if (lpc->lpc_hc_irqser_ctrl & LPC_HC_IRQSER_EN) {
-        active_irqs = lpc->lpc_hc_irqstat & lpc->lpc_hc_irqmask;
+    active_irqs = lpc->lpc_hc_irqstat & lpc->lpc_hc_irqmask;
+    if (!(lpc->lpc_hc_irqser_ctrl & LPC_HC_IRQSER_EN)) {
+        active_irqs &= ~LPC_HC_IRQ_SERIRQ_ALL;
     }
 
     /* Reflect the interrupt */
-    if (!lpc->psi_has_serirq) {
-        /*
-         * POWER8 ORs all irqs together (also with LPCHC internal interrupt
-         * sources) and outputs a single line that raises the PSI LPCHC irq
-         * which then latches an OPB IRQ status register that sends the irq
-         * to PSI.
-         *
-         * We don't honor the polarity register, it's pointless and unused
-         * anyway
-         */
-        if (active_irqs) {
-            lpc->opb_irq_input |= OPB_MASTER_IRQ_LPC;
-        } else {
-            lpc->opb_irq_input &= ~OPB_MASTER_IRQ_LPC;
-        }
-
-        /* Update OPB internal latch */
-        lpc->opb_irq_stat |= lpc->opb_irq_input & lpc->opb_irq_mask;
-
-        qemu_set_irq(lpc->psi_irq_lpchc, lpc->opb_irq_stat != 0);
-    } else {
+    if (lpc->psi_has_serirq) {
         /*
-         * POWER9 and POWER10 have routing fields in OPB master registers that
+         * POWER9 and later have routing fields in OPB master registers that
          * send LPC irqs to 4 output lines that raise the PSI SERIRQ irqs.
          * These don't appear to get latched into an OPB register like the
          * LPCHC irqs.
-         *
-         * POWER9 LPC controller internal irqs still go via the OPB
-         * and LPCHC PSI irqs like P8, but we have no such internal sources
-         * modelled yet.
          */
         bool serirq_out[4] = { false, false, false, false };
         int irq;
@@ -510,7 +482,33 @@ static void pnv_lpc_eval_irqs(PnvLpcController *lpc)
         qemu_set_irq(lpc->psi_irq_serirq[1], serirq_out[1]);
         qemu_set_irq(lpc->psi_irq_serirq[2], serirq_out[2]);
         qemu_set_irq(lpc->psi_irq_serirq[3], serirq_out[3]);
+
+        /*
+         * POWER9 and later LPC controller internal irqs still go via the OPB
+         * and LPCHC PSI irqs like P8, so take the SERIRQs out and continue.
+         */
+        active_irqs &= ~LPC_HC_IRQ_SERIRQ_ALL;
+    }
+
+    /*
+     * POWER8 ORs all irqs together (also with LPCHC internal interrupt
+     * sources) and outputs a single line that raises the PSI LPCHC irq
+     * which then latches an OPB IRQ status register that sends the irq
+     * to PSI.
+     *
+     * We don't honor the polarity register, it's pointless and unused
+     * anyway
+     */
+    if (active_irqs) {
+        lpc->opb_irq_input |= OPB_MASTER_IRQ_LPC;
+    } else {
+        lpc->opb_irq_input &= ~OPB_MASTER_IRQ_LPC;
     }
+
+    /* Update OPB internal latch */
+    lpc->opb_irq_stat |= lpc->opb_irq_input & lpc->opb_irq_mask;
+
+    qemu_set_irq(lpc->psi_irq_lpchc, lpc->opb_irq_stat != 0);
 }
 
 static uint64_t lpc_hc_read(void *opaque, hwaddr addr, unsigned size)
-- 
2.47.1


