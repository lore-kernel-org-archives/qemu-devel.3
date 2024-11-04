Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F7BD11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7ks1-0000fg-Jx; Sun, 03 Nov 2024 19:23:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7krj-00078o-RO; Sun, 03 Nov 2024 19:22:43 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7krh-0002oQ-Gn; Sun, 03 Nov 2024 19:22:43 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71e592d7f6eso2832527b3a.3; 
 Sun, 03 Nov 2024 16:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679759; x=1731284559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kaMuQFrj1YjSWPzexi6V4O755YKfOagaKHbTPKYcJJ8=;
 b=Zr/0Ryq5M24CmfDZQ2V7xKLLjbIJ2C+eU3GtCe4iB1B+rqpm9Kq9PdFrmScYPYN/JG
 E+36BBkUj5LwEcPqn/2UwOjgiHItTmF6ri50Q/tTBIoede8gtBV+TBh5XGLwMMl7KpY7
 XABbB8nxDj39sIL7+uQtjO96pQWUuMQdr7nm1zkMc4oDuWx2chY+Bavm/UZVp9AimFoh
 HA0wSGMi0qj/PLFYp8QUsnO/px4tzPB4lONUM7jQosQZQRhVlicSsH7tsQ8kgoC25szM
 B9zH2PeJ0dcQ4d900IXJxTDbNaeBrwuVwRPBBtXtU17TVo57O3ZGfAAMhJYs4HS+3jWy
 zaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679759; x=1731284559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kaMuQFrj1YjSWPzexi6V4O755YKfOagaKHbTPKYcJJ8=;
 b=UM/50rGdbomJRzE08Duz5iezVmOeodgKntNaqwQl8eMO+yPGbVTm6tJwH4I+I4SAaS
 GoHgDort7aKL0eCUpU5fGnZFDE+G9M1CiG5vRkh0egLYkIMni5dZ73ehYx0xJk/q7ink
 /0OYSt+QqyP1mO3XY49v/mm0X50XiqPsMH0N4sI++5iJ4yIfwzSZW5BZDk+RFFDyyBrU
 G/UOEKMNgPtUAkTlgkkyDCs2gc+NSGhfhygzTep7brU7u+/176SKZrFOaH1WdW+vkWFe
 Tx6v9emnimAhYtPUVi9GAvJWputEEGSyqpR0V6UnwI50Pj4HNvjjkyn55HGU5ieiT6/Z
 iuog==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDIuWdOYbPJ177N9GzX2etqzkG4oFskOYzi+37GXHZwhHNtMlYZ3xVLQRwDLXeOil9HuqMdkF0fg==@nongnu.org
X-Gm-Message-State: AOJu0YwkjnZS6w4zYSDa1aD3i5gVTslm0e+Ayei4QWNOk6j49ap21e1K
 RFzNxzIud9JiJ4LVzDjyalnPrMnWHdXqHydXWsyKQfDfTpc9kROLWmfDSQ==
X-Google-Smtp-Source: AGHT+IESmOht7Ev6bKgKP5/9c7dwScgL4JhXwAi1nzNOcYBb86Q6XT1kgoCIgwEY0AWXeCwTqrZKnQ==
X-Received: by 2002:a05:6a20:c6ca:b0:1d9:d8d:d0b0 with SMTP id
 adf61e73a8af0-1dba5620c31mr13440992637.41.1730679759501; 
 Sun, 03 Nov 2024 16:22:39 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:22:39 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 58/67] pnv/xive: Add special handling for pool targets
Date: Mon,  4 Nov 2024 10:18:47 +1000
Message-ID: <20241104001900.682660-59-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

Hypervisor "pool" targets do not get their own interrupt line and instead
must share an interrupt line with the hypervisor "physical" targets.
This also means that the pool ring must use some of the registers from the
physical ring in the TIMA.  Specifically, the NSR, PIPR and CPPR registers:

  NSR = Notification Source Register
  PIPR = Post Interrupt Priority Register
  CPPR = Current Processor Priority Register

The NSR specifies that there is an active interrupt.  The CPPR
specifies the priority of the context and the PIPR specifies the
priority of the interrupt.  For an interrupt to be presented to
a context, the priority of the interrupt must be higher than the
priority of the context it is interrupting (value must be lower).

The existing code was not aware of the sharing of these registers.
This commit adds that support.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 951aaf5279..baad7129ca 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -74,33 +74,49 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
 
     if (regs[TM_NSR] & mask) {
         uint8_t cppr = regs[TM_PIPR];
+        uint8_t alt_ring;
+        uint8_t *alt_regs;
+
+        /* POOL interrupt uses IPB in QW2, POOL ring */
+        if ((ring == TM_QW3_HV_PHYS) && (nsr & (TM_QW3_NSR_HE_POOL << 6))) {
+            alt_ring = TM_QW2_HV_POOL;
+        } else {
+            alt_ring = ring;
+        }
+        alt_regs = &tctx->regs[alt_ring];
 
         regs[TM_CPPR] = cppr;
 
         /* Reset the pending buffer bit */
-        regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
-        regs[TM_PIPR] = ipb_to_pipr(regs[TM_IPB]);
+        alt_regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
+        regs[TM_PIPR] = ipb_to_pipr(alt_regs[TM_IPB]);
 
         /* Drop Exception bit */
         regs[TM_NSR] &= ~mask;
 
-        trace_xive_tctx_accept(tctx->cs->cpu_index, ring,
-                               regs[TM_IPB], regs[TM_PIPR],
+        trace_xive_tctx_accept(tctx->cs->cpu_index, alt_ring,
+                               alt_regs[TM_IPB], regs[TM_PIPR],
                                regs[TM_CPPR], regs[TM_NSR]);
     }
 
-    return (nsr << 8) | regs[TM_CPPR];
+    return ((uint64_t)nsr << 8) | regs[TM_CPPR];
 }
 
 static void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring)
 {
+    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
+    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
+    uint8_t *alt_regs = &tctx->regs[alt_ring];
     uint8_t *regs = &tctx->regs[ring];
 
-    if (regs[TM_PIPR] < regs[TM_CPPR]) {
+    if (alt_regs[TM_PIPR] < alt_regs[TM_CPPR]) {
         switch (ring) {
         case TM_QW1_OS:
             regs[TM_NSR] |= TM_QW1_NSR_EO;
             break;
+        case TM_QW2_HV_POOL:
+            alt_regs[TM_NSR] = (TM_QW3_NSR_HE_POOL << 6);
+            break;
         case TM_QW3_HV_PHYS:
             regs[TM_NSR] |= (TM_QW3_NSR_HE_PHYS << 6);
             break;
@@ -108,8 +124,8 @@ static void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring)
             g_assert_not_reached();
         }
         trace_xive_tctx_notify(tctx->cs->cpu_index, ring,
-                               regs[TM_IPB], regs[TM_PIPR],
-                               regs[TM_CPPR], regs[TM_NSR]);
+                               regs[TM_IPB], alt_regs[TM_PIPR],
+                               alt_regs[TM_CPPR], alt_regs[TM_NSR]);
         qemu_irq_raise(xive_tctx_output(tctx, ring));
     }
 }
@@ -217,14 +233,14 @@ static uint64_t xive_tm_vt_poll(XivePresenter *xptr, XiveTCTX *tctx,
 static const uint8_t xive_tm_hw_view[] = {
     3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-0 User */
     3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-1 OS   */
-    0, 0, 3, 3,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL */
+    0, 0, 3, 3,   0, 3, 3, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL */
     3, 3, 3, 3,   0, 3, 0, 2,   3, 0, 0, 3,   3, 3, 3, 0, /* QW-3 PHYS */
 };
 
 static const uint8_t xive_tm_hv_view[] = {
     3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-0 User */
     3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-1 OS   */
-    0, 0, 3, 3,   0, 0, 0, 0,   0, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL */
+    0, 0, 3, 3,   0, 3, 3, 0,   0, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL */
     3, 3, 3, 3,   0, 3, 0, 2,   3, 0, 0, 3,   0, 0, 0, 0, /* QW-3 PHYS */
 };
 
-- 
2.45.2


