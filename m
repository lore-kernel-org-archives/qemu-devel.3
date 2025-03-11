Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF692C28B30
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzDF-00044S-3r; Tue, 11 Mar 2025 09:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCh-00022J-9H; Tue, 11 Mar 2025 08:59:28 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCf-0007xX-G6; Tue, 11 Mar 2025 08:59:27 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ff69365e1dso7926330a91.3; 
 Tue, 11 Mar 2025 05:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697963; x=1742302763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fqFuEaShL7QDMXwSHtnl81qUichOoVW19OOsjZgbiVQ=;
 b=HMCa47uLlBR/MQzcTgvvhVhh+aEhgGxZpok8lelz35/E56gzpLsO5QYKrq3k/06kCG
 j6vJr8GDF+9zk14HsskZV8Uos75QQ+4m5fgkvvOa5zgVKp4pBS9PFp6BqsQe0J+1LtLG
 vC8CjhqkEbOSd/3tjKbUGlxMdzzDRi6CZNEzQJoysw17aD38RQFb75ffR398xpDlIp5N
 xMzkwVW41JDwOs6qjL4MsozOOtXPYGtiFhaz3RrXteKnamLvrqpEhy6NFaBLHJX910PO
 bIGEB9J4URYWt8yj2i8z7tcaC+270PnxeJuSv7KsSY43HHfg714MSDf8KYeEMO5b6Nxq
 B2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697963; x=1742302763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fqFuEaShL7QDMXwSHtnl81qUichOoVW19OOsjZgbiVQ=;
 b=NgyHQbOOKSlnux+/AQZVGfDWn2PHLC2KPKTeTQkFkUinkEtljz8BoE7ypapRB9rHzh
 INU4AElv+uWnLoaqqNLBJ/4utsCtjp/+b5md6YJRFLm+k1FTCttDisMZ9Q6kUcB/R/ot
 OO91S/PgmS7dtZlJixMRnjWmBCjvAFpSlLpfJUjvOI80HPlOGuaNfp09KGw6wRToC47w
 LItT3AsqIVFVzKopA0JVRzvVlwlIH3c/t32+p6j8fFEtkrgJd3QxbDeZW8yh9kI265VT
 qk6Fifmo8Ni8elLwevrVjXLPcVgqvUya9Pup9SD4ncvUoOPunMw53DSjuAgq+63yny3J
 tXRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnnVCOW45RO17P/Iaw/fn6qxP4IfBCrh+y9BEg1X03h31UDVg2U9THTWF7y8mqroLl6RvVYVlp2g==@nongnu.org
X-Gm-Message-State: AOJu0YxaTUWo0BA8d9KHU4sNX/S/G2gmnuoeaaTuuWrDYO46TbrrVV1O
 uLenap25hEoHUCZZ7FAkxzP+QbDCmdYUOs0masZbzKccp0mDEuwzlyaj9Q==
X-Gm-Gg: ASbGncs0f2NSVDC2l4dq1cSvXXbYW1y9VqzXVq6iq4UiGMnvJ3cv/KwmPk7yTXBjZ2s
 MA+I9bBFP8fRBlK9RXTIFoPo4nnM91EqHauVV05bT8lAkQOJYqb5B+BHRYRq73Pe4B8pgaQDtTr
 zD5CGkUaYvqTDQ0n+w/Rf73rgeSj2v545yr6Qig3ho7jJXxdmSoK/cypPOYj0vdmeOawH7nsnLt
 iP5rofmTEf/GSrpXfpmvMlEHAlww6XkHC092ZnBlrfp0AllpWl9i8izZa4owVj1PC3WVxF9CbOl
 VEkJ+ntETFjqcgu1rJGP3mbsqFI05Bj1Tq+iUfsuEZw4zuvghro=
X-Google-Smtp-Source: AGHT+IGI0v+NMdNqMr7la3iNW7GBB4U91RILxWfSpz+dcYrLsD/e79DcHZMqtkXSizdplmdmqa3pmA==
X-Received: by 2002:a17:90b:164f:b0:2fe:baa3:b8b9 with SMTP id
 98e67ed59e1d1-2ff7ce4f306mr25161149a91.4.1741697963258; 
 Tue, 11 Mar 2025 05:59:23 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:59:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 17/72] ppc/pnv: Support LPC host controller irqs other than
 serirqs
Date: Tue, 11 Mar 2025 22:57:11 +1000
Message-ID: <20250311125815.903177-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1029.google.com
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
index 0480a60f3f..d0fccc165d 100644
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


