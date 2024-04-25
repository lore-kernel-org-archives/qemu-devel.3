Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F80EC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWc-0002Gz-N2; Thu, 25 Apr 2024 06:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWV-00021v-6r
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:15 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWS-0007Cu-FZ
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:14 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ddc2ea2091so7426381fa.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041611; x=1714646411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TcVIi1Iki/Qk61vaJOYOc4vy8G4AM5CFxMYdxYS702I=;
 b=P+5csmjlMROUsDSESrcVVFNoB0E+N0bEwrfZ43vy0RQEGzNtUG1Uv0cFOjCTM+E+1t
 AQdgLqEuPkS64gpyxEVXbzxZA70D6FvMvl3nGXkEUtvKS94m2s9dQqbsSQa+XTbtD5sg
 dCa6HT3IEiMhekPWEd1P2NsjrjSbnaN8V8CTblHhY+Mbv+aRFXBmuGofoZXNTbfxait2
 bbHwboDVraVeglNSnSuICcSqclOIVMsy5g4u4cOLN2pC6pNCspzM3E2VwVR1EznThIPq
 s6XcapzDGO69MDIYE1dXuh07PY4unP07f2cVpXt6q+iGi9SADKF5cnHevyGkyaq2wG1I
 MEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041611; x=1714646411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TcVIi1Iki/Qk61vaJOYOc4vy8G4AM5CFxMYdxYS702I=;
 b=cNNymXMoChNyO0ineBUD9Bt9NdMdLKYpdA+Gg/lPqm+ECIBwIvLv8BO5B5KAWzdhGh
 kEhHy0JhTEGXek6M8YOpm+2mhjeYJMSKpmnzUzxmJM9jnUtX5S5fW8H0QTSLCIijnjYm
 3Ovj8tmL7d8hilX0MyPKRqdlYui9GPGuayQqPAFUnUCxqsEktwOudMIHGMmsNw1bnf1O
 DmkJLvk3YGqPAADr4MN0tphA3/Z26y6ySxfvofC2jCGSbqGPfGvdM9x5PlG+ZkL/LdxB
 yGpLIj+CfajQGCL3/k1wn/JmQWtEyhVyVWJU9SiymoBzYQfayC95lfsMc0NkmLLMQZxs
 6HaA==
X-Gm-Message-State: AOJu0YxDDSjC01Q66QBwVzdZxfKwRWgBN4bl8RB+NR9Num+mValhEjuu
 GK6XkgebNC5AcJ/xjKVOClQmklURCQF+V8E5DW7gbpldbY7UN+3ELsvofd0O2Gx1fj+7QWsRIwy
 N
X-Google-Smtp-Source: AGHT+IEXtggfNVRWgg18ufH+640YVZHhUbKX20Jfm1rsiqKcXMaZ2Nn7ovev3rqMClavSXPA9GXYnw==
X-Received: by 2002:a2e:8846:0:b0:2d4:1fa4:9eb8 with SMTP id
 z6-20020a2e8846000000b002d41fa49eb8mr3636830ljj.40.1714041610725; 
 Thu, 25 Apr 2024 03:40:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/37] hw/intc/arm_gicv3: Implement NMI interrupt priority
Date: Thu, 25 Apr 2024 11:39:41 +0100
Message-Id: <20240425103958.3237225-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

If GICD_CTLR_DS bit is zero and the NMI is non-secure, the NMI priority is
higher than 0x80, otherwise it is higher than 0x0. And save the interrupt
non-maskable property in hppi.nmi to deliver NMI exception. Since both GICR
and GICD can deliver NMI, it is both necessary to check whether the pending
irq is NMI in gicv3_redist_update_noirqset and gicv3_update_noirqset.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240407081733.3231820-21-ruanjinjie@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3.c        | 67 +++++++++++++++++++++++++++++++++-----
 hw/intc/arm_gicv3_common.c |  3 ++
 hw/intc/arm_gicv3_redist.c |  3 ++
 3 files changed, 64 insertions(+), 9 deletions(-)

diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
index 0b8f79a1227..58e18fff54f 100644
--- a/hw/intc/arm_gicv3.c
+++ b/hw/intc/arm_gicv3.c
@@ -21,7 +21,7 @@
 #include "hw/intc/arm_gicv3.h"
 #include "gicv3_internal.h"
 
-static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio)
+static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio, bool nmi)
 {
     /* Return true if this IRQ at this priority should take
      * precedence over the current recorded highest priority
@@ -30,14 +30,23 @@ static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio)
      * is the same as this one (a property which the calling code
      * relies on).
      */
-    if (prio < cs->hppi.prio) {
-        return true;
+    if (prio != cs->hppi.prio) {
+        return prio < cs->hppi.prio;
     }
+
+    /*
+     * The same priority IRQ with non-maskable property should signal to
+     * the CPU as it have the priority higher than the labelled 0x80 or 0x00.
+     */
+    if (nmi != cs->hppi.nmi) {
+        return nmi;
+    }
+
     /* If multiple pending interrupts have the same priority then it is an
      * IMPDEF choice which of them to signal to the CPU. We choose to
      * signal the one with the lowest interrupt number.
      */
-    if (prio == cs->hppi.prio && irq <= cs->hppi.irq) {
+    if (irq <= cs->hppi.irq) {
         return true;
     }
     return false;
@@ -129,6 +138,40 @@ static uint32_t gicr_int_pending(GICv3CPUState *cs)
     return pend;
 }
 
+static bool gicv3_get_priority(GICv3CPUState *cs, bool is_redist, int irq,
+                               uint8_t *prio)
+{
+    uint32_t nmi = 0x0;
+
+    if (is_redist) {
+        nmi = extract32(cs->gicr_inmir0, irq, 1);
+    } else {
+        nmi = *gic_bmp_ptr32(cs->gic->nmi, irq);
+        nmi = nmi & (1 << (irq & 0x1f));
+    }
+
+    if (nmi) {
+        /* DS = 0 & Non-secure NMI */
+        if (!(cs->gic->gicd_ctlr & GICD_CTLR_DS) &&
+            ((is_redist && extract32(cs->gicr_igroupr0, irq, 1)) ||
+             (!is_redist && gicv3_gicd_group_test(cs->gic, irq)))) {
+            *prio = 0x80;
+        } else {
+            *prio = 0x0;
+        }
+
+        return true;
+    }
+
+    if (is_redist) {
+        *prio = cs->gicr_ipriorityr[irq];
+    } else {
+        *prio = cs->gic->gicd_ipriority[irq];
+    }
+
+    return false;
+}
+
 /* Update the interrupt status after state in a redistributor
  * or CPU interface has changed, but don't tell the CPU i/f.
  */
@@ -141,6 +184,7 @@ static void gicv3_redist_update_noirqset(GICv3CPUState *cs)
     uint8_t prio;
     int i;
     uint32_t pend;
+    bool nmi = false;
 
     /* Find out which redistributor interrupts are eligible to be
      * signaled to the CPU interface.
@@ -152,10 +196,11 @@ static void gicv3_redist_update_noirqset(GICv3CPUState *cs)
             if (!(pend & (1 << i))) {
                 continue;
             }
-            prio = cs->gicr_ipriorityr[i];
-            if (irqbetter(cs, i, prio)) {
+            nmi = gicv3_get_priority(cs, true, i, &prio);
+            if (irqbetter(cs, i, prio, nmi)) {
                 cs->hppi.irq = i;
                 cs->hppi.prio = prio;
+                cs->hppi.nmi = nmi;
                 seenbetter = true;
             }
         }
@@ -168,9 +213,10 @@ static void gicv3_redist_update_noirqset(GICv3CPUState *cs)
     if ((cs->gicr_ctlr & GICR_CTLR_ENABLE_LPIS) && cs->gic->lpi_enable &&
         (cs->gic->gicd_ctlr & GICD_CTLR_EN_GRP1NS) &&
         (cs->hpplpi.prio != 0xff)) {
-        if (irqbetter(cs, cs->hpplpi.irq, cs->hpplpi.prio)) {
+        if (irqbetter(cs, cs->hpplpi.irq, cs->hpplpi.prio, cs->hpplpi.nmi)) {
             cs->hppi.irq = cs->hpplpi.irq;
             cs->hppi.prio = cs->hpplpi.prio;
+            cs->hppi.nmi = cs->hpplpi.nmi;
             cs->hppi.grp = cs->hpplpi.grp;
             seenbetter = true;
         }
@@ -213,6 +259,7 @@ static void gicv3_update_noirqset(GICv3State *s, int start, int len)
     int i;
     uint8_t prio;
     uint32_t pend = 0;
+    bool nmi = false;
 
     assert(start >= GIC_INTERNAL);
     assert(len > 0);
@@ -240,10 +287,11 @@ static void gicv3_update_noirqset(GICv3State *s, int start, int len)
              */
             continue;
         }
-        prio = s->gicd_ipriority[i];
-        if (irqbetter(cs, i, prio)) {
+        nmi = gicv3_get_priority(cs, false, i, &prio);
+        if (irqbetter(cs, i, prio, nmi)) {
             cs->hppi.irq = i;
             cs->hppi.prio = prio;
+            cs->hppi.nmi = nmi;
             cs->seenbetter = true;
         }
     }
@@ -293,6 +341,7 @@ void gicv3_full_update_noirqset(GICv3State *s)
 
     for (i = 0; i < s->num_cpu; i++) {
         s->cpu[i].hppi.prio = 0xff;
+        s->cpu[i].hppi.nmi = false;
     }
 
     /* Note that we can guarantee that these functions will not
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 9810558b076..207f8417e1f 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -536,8 +536,11 @@ static void arm_gicv3_common_reset_hold(Object *obj)
         memset(cs->gicr_ipriorityr, 0, sizeof(cs->gicr_ipriorityr));
 
         cs->hppi.prio = 0xff;
+        cs->hppi.nmi = false;
         cs->hpplpi.prio = 0xff;
+        cs->hpplpi.nmi = false;
         cs->hppvlpi.prio = 0xff;
+        cs->hppvlpi.nmi = false;
 
         /* State in the CPU interface must *not* be reset here, because it
          * is part of the CPU's reset domain, not the GIC device's.
diff --git a/hw/intc/arm_gicv3_redist.c b/hw/intc/arm_gicv3_redist.c
index ed1f9d1e444..90b238fac0b 100644
--- a/hw/intc/arm_gicv3_redist.c
+++ b/hw/intc/arm_gicv3_redist.c
@@ -120,6 +120,7 @@ static void update_for_one_lpi(GICv3CPUState *cs, int irq,
         ((prio == hpp->prio) && (irq <= hpp->irq))) {
         hpp->irq = irq;
         hpp->prio = prio;
+        hpp->nmi = false;
         /* LPIs and vLPIs are always non-secure Grp1 interrupts */
         hpp->grp = GICV3_G1NS;
     }
@@ -156,6 +157,7 @@ static void update_for_all_lpis(GICv3CPUState *cs, uint64_t ptbase,
     int i, bit;
 
     hpp->prio = 0xff;
+    hpp->nmi = false;
 
     for (i = GICV3_LPI_INTID_START / 8; i < pendt_size / 8; i++) {
         address_space_read(as, ptbase + i, MEMTXATTRS_UNSPECIFIED, &pend, 1);
@@ -241,6 +243,7 @@ static void gicv3_redist_update_vlpi_only(GICv3CPUState *cs)
 
     if (!FIELD_EX64(cs->gicr_vpendbaser, GICR_VPENDBASER, VALID)) {
         cs->hppvlpi.prio = 0xff;
+        cs->hppvlpi.nmi = false;
         return;
     }
 
-- 
2.34.1


