Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB9CCD4855
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 09:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMja1-0008LB-1W; Tue, 12 May 2026 05:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMjZw-0008Ia-6a
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:39:05 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMjZu-0004nt-6Y
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:39:03 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-45297094718so4225726f8f.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 02:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778578740; x=1779183540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0KudvLHguH9tRc9Lgq+2mRst/v85r9PXfkOE55p48us=;
 b=oAAH7RPpQBnPLJxL8z8k+3VOC7Yzxym1W9CWMDWkis0WukHLwIjZ+t0jeXi4Kld+MX
 2qaT3bQfNDUFugW4k6J+t/2LtC1PPW89/Jp2ubDuYCcm8fv6cL7zpRzHhS8NccAh8r8g
 Gah5ciMxdRODR08eaNCmyGOX07RwDPYObLDryKYwY7PxJT/UcnJZOI3s4+R2fMo55T0C
 dVA6OmYHwBEHpDVy20yn0MZkSBZBtqW2+qzISAAAbjS7gnFUwKViSQRSkvVnUpdOKiiv
 6/1C+BmPWpUNdhTdCCY5n3YdXWFlsuglO93uXpELKBKXNXGGMfPoixRXNckOnthMFV0I
 gNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778578740; x=1779183540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0KudvLHguH9tRc9Lgq+2mRst/v85r9PXfkOE55p48us=;
 b=B4D2O8uYSN31oABuBH8a14dtnphQaZqtFNJsc7lv68q/txNG2Q62nS/2Qy3bO4NKto
 PFmGD+UtN0pwMfJkfZ/he3IqyAzySJxhvGERCAB9Rt193t9Cnt/XUfBlwb8yRQbU1K5T
 ECk8kYDhF6NQnyVgVC++omWAv27SJHanyECRvmWuEZrd924Dy5GxoVRzkyAVNviMkILs
 jtACa5FGEGPrNqnVFtGAR29eJwfQE5m5CS0ppD9UnRSmMH8U/Qf5LmGi1x4x3kdTyxs+
 EamD8HHKl35uPBdFnAbueXVCG09xX7rHmJgKByMompgrpcmqQ6j5XQ7o8MU3+sGOk7Fa
 ATsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hiIP9ErDKvu6s+eMJzs14vbFDOSY6rnLsWiPRbkXl4IGDJ1+zRfPEm9Pck7JWweiZnKI6kURhN8a6@nongnu.org
X-Gm-Message-State: AOJu0YwQdPwZzOV4WwAjC7K/cfo0ZINWaV1Fvp8Jp3+Oj9cXi4uwHuKO
 6QVICaLhwW2jepn5nulHYcfLaIT//WFYTuFvkwIarUqjjRFb+Ov4d9+g380rTSDuy7I=
X-Gm-Gg: Acq92OHQZxfUSPWBagoF3gRw2ZkZL+pyXb/E07bjGjRodFbKWOYmlKKICLeeXTnp8MS
 nT0FBPpkt7AdnJwWP1Uf6SA+1L8MmsnvE3uSSkokqPzDmEb3iUpFtIS355A1iqZJxJzxiaUx5X5
 Q0ATrrC+CfxWSlviEVYejMvF0GA2s6PMzOQgQbB2g2I0bHTt58zfMcmlfSJn+Ulje9akXIKc31/
 Rnc6dWbQt5b8Z7ONqFtUzZyJ9T53D+XhpiRXtb385tvbSXo+fMFwVfFifJtwH7znyK2+7QODT1C
 j18fO0RKgEDexMWVOhuUbNKVQ5OKkLzEw37u5acknqiea2ditCqdOpBu3PTTTEvMYzrOEpcn4YK
 hdzpGaWRi6rxYi4ij0dNhmI+5RnrxPj/jRyy+iK1TRCmpekqIIohL8MARyMf8qzXDsjXUWdhqm7
 BMSacmQcB02dfy6Vu6Z1wP5kJIW/jWTYGTAbm0kk+AYbogRLjWYxBLFR8xVqqyIOY1IAoNQWP8z
 64/VmNf/MbIhxxVHjjglDpgAYXOdag=
X-Received: by 2002:a5d:5850:0:b0:43f:e934:50ac with SMTP id
 ffacd0b85a97d-45b115c7e50mr3034894f8f.7.1778578740514; 
 Tue, 12 May 2026 02:39:00 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a6a64sm32805208f8f.6.2026.05.12.02.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 02:38:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/4] target/arm: GICv5 cpuif: Don't set HPPIV bit in
 GICv5PendingIrq::intid
Date: Tue, 12 May 2026 10:38:54 +0100
Message-ID: <20260512093856.3197700-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512093856.3197700-1-peter.maydell@linaro.org>
References: <20260512093856.3197700-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

In gic_hppi() we return the current highest priority pending
interrupt in a GICv5PendingIrq struct.  We try to set up the intid
field of that struct to be the form that is used by the ICC_HPPIR
register, which has a "valid" bit in bit 33.  Unfortunately the
GICv5PendingIrq defines the intid field as a uint32_t, so Coverity
points out that the bit doesn't actually fit.  Move the handling of
the valid bit to the callsite, and make this function report "no
pending interrupt" with GICv5PendingIrq::prio == PRIO_IDLE,
consistently with how we use this struct in other places.

CID: 1659594
Fixes: 9edad4ff3 ("target/arm: GICv5 cpuif: Implement ICC_HPPIR_EL1")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/arm_gicv5_types.h |  2 ++
 target/arm/tcg/gicv5-cpuif.c      | 18 ++++++++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/hw/intc/arm_gicv5_types.h b/include/hw/intc/arm_gicv5_types.h
index eaed42f49f..de4f78a149 100644
--- a/include/hw/intc/arm_gicv5_types.h
+++ b/include/hw/intc/arm_gicv5_types.h
@@ -97,6 +97,8 @@ typedef enum GICv5TriggerMode {
  *
  * In this struct the intid includes the interrupt type in bits
  * [31:29] (i.e. it is in the form defined by R_TJPHS).
+ *
+ * "No pending interrupt" is represented by @prio == PRIO_IDLE.
  */
 typedef struct GICv5PendingIrq {
     uint32_t intid;
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 98238ada19..dd2f696511 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -129,10 +129,9 @@ static GICv5PendingIrq gic_hppi(CPUARMState *env, GICv5Domain domain)
 {
     /*
      * Return the current highest priority pending interrupt for the
-     * specified domain, if it has sufficient priority to preempt. The
-     * intid field of the return value will be in the format of the
-     * ICC_HPPIR register (and will be zero if and only if there is no
-     * interrupt that can preempt).
+     * specified domain, if it has sufficient priority to preempt.
+     * If there is no interrupt that can preempt we signal this by
+     * returning a struct with prio == PRIO_IDLE.
      */
 
     GICv5Common *gic = gicv5_get_gic(env);
@@ -166,7 +165,6 @@ static GICv5PendingIrq gic_hppi(CPUARMState *env, GICv5Domain domain)
         best.prio >= gic_running_prio(env, domain)) {
         return (GICv5PendingIrq) { .intid = 0, .prio = PRIO_IDLE };
     }
-    best.intid |= R_ICC_HPPIR_EL1_HPPIV_MASK;
     return best;
 }
 
@@ -575,7 +573,12 @@ static uint64_t gic_icc_hppir_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     GICv5Domain domain = gicv5_logical_domain(env);
     GICv5PendingIrq hppi = gic_hppi(env, domain);
-    return hppi.intid;
+
+    if (hppi.prio == PRIO_IDLE) {
+        /* No valid interrupt */
+        return 0;
+    }
+    return hppi.intid | R_ICC_HPPIR_EL1_HPPIV_MASK;
 }
 
 static bool gic_hppi_is_nmi(CPUARMState *env, GICv5PendingIrq hppi,
@@ -602,13 +605,12 @@ static uint64_t gicr_cdia_read(CPUARMState *env, const ARMCPRegInfo *ri)
 
     bool cdnmia = ri->opc2 == 1;
 
-    if (!hppi.intid) {
+    if (hppi.prio == PRIO_IDLE) {
         /* No interrupt available to acknowledge */
         trace_gicv5_gicr_cdia_fail(domain,
                                    "no available interrupt to acknowledge");
         return 0;
     }
-    assert(hppi.prio != PRIO_IDLE);
 
     if (gic_hppi_is_nmi(env, hppi, domain) != cdnmia) {
         /* GICR CDIA only acknowledges non-NMI; GICR CDNMIA only NMI */
-- 
2.43.0


