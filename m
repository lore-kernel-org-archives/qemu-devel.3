Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF60EC110C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZLs-0003Mz-Hx; Mon, 23 Feb 2026 12:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKt-0002c7-LW
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:10 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKq-0000LO-TJ
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:06 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4837907f535so41157835e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866183; x=1772470983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9EclDtotkR1f0lyay0/isT6zoNQaUcu9GIY6GSoSdes=;
 b=dEbk59Bj6E87I/29t9ETR84h4MHh7p2SBt/3RjZJ6DZKpnUbLfT/sDFcZk2zo5RDq+
 dy1DqD373EBJ8wGpEJOWKUakFKkfMSJEhoZqT7YW5/viuJnatapLP00DHEzmdDEwgNrw
 KjZnEOvUioJi8OEhLrt5Fopo6nEYUUn8+hwQ+PWTk2zj9l4G2Ur1k1KCG+ngqLVLjPw7
 +fSOObDjpRuXAY8347IxdBLK6I25qpgyt1LHMOZU1+rSqJWHZvTr9Q5P+KD18vP39v9k
 +8QzydFoMbFzuUfVtAaG8jz6py6pgsqo79d4vBrXMuM9goGFcyITuOo7ayHpZFBpDt06
 pFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866183; x=1772470983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9EclDtotkR1f0lyay0/isT6zoNQaUcu9GIY6GSoSdes=;
 b=ivj0HMZtymCkH68CEeokY+E60E1xkD/saz5gUbJgF7HVIR7muBcslpwhaKYUmwd8mz
 /2LRKqsbaHrB3Evz4bE6gokHvhwZ1RGdlbfBJ6iWqdItR7+hGSk+HVGP/Wof2HSVt4HY
 yEebwJVU+ssULPaNgLsWzjCUv6gWA5BDqWbtm5z1E+wP9+TsmK4Fwf5O5prQT9ENNR8f
 pHrXgTdDs+1HJxi7lMAqHixpfBScuuxMk2gd2WClVWrYs8BRDOpzR2h+rVa/NAzDtGN4
 a0q3XlrjPKRPUYrUzWEwbMfLF6OB/H3mvYwzpc60UNAkUeFAyDvIjxjwNNwbvJK5Hq8s
 ipvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmxuI3EvsDjMUzGEj/53fWNH7MfNpiSGU8CDQcZN7Sbx6yB8dw8LcbAfF/4fgk3twTuW6ReXzIaBmj@nongnu.org
X-Gm-Message-State: AOJu0Ywz+hhakE81FJ6A7Cyh6/PXbmYM7t7NojIRhs7yvD0JPxXNDuYE
 msP94wrBYnjsPGO5wrCOz//2ZpRBjX/bZpn2rF7vlCCqc++PN6GUjcfkj/ewU08uM0Y=
X-Gm-Gg: AZuq6aLmiX5e7Et/VmAcFVKs/a52yCW58QVDs0jA3PA6K8yyuMvoNJaR2XIsevHgkZr
 1hQLH5EiJyQmfvrUmbn2kq0HQWoIlezEuz3R+RRaOzMCrAppvcaruSr1AcpNcBMnkEWeafWiyln
 nQp5lqIWyuQdRtIay9oABDQYGgjpJZNv0mS5U0M2WJ+zOjeepuY9YruKL2TLCE5EWoBQRrgXKDW
 EJk6wXkf0PoOvWCR/MQOCnYb5ApFDyvOIZt2kFxvUAq6p+uOxonyut3Mc605JZEnPu/I6yZGquY
 UGfbZ/pq45ZbTbU/o6pF1X+j9bGR24+Pebd28ZqLgXOUcIJjGLN/TSP6H/WoPCAB3vaAhcAZqXi
 UE82xLqCe2YeqtwX3O54CN4IpcRgQcwpbDgRSd97napaK8266M1XHJDVF/Hj7sVYc9iQob1riBe
 9YARkzsPwC8xx0MdpW+gMsL7k+UA4rZejZOmNQLx65XCDQxQGUL0PpLvO2MiogB1c+m24D/dCta
 dxJXXqDV3UP03+Kbdp0U5C2zt89qoU=
X-Received: by 2002:a05:600c:3115:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-483a961602dmr194341685e9.35.1771866183329; 
 Mon, 23 Feb 2026 09:03:03 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:03:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 43/65] target/arm: GICv5 cpuif: Implement ICC_CR0_EL1
Date: Mon, 23 Feb 2026 17:01:50 +0000
Message-ID: <20260223170212.441276-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Implement ICC_CR0_EL1, which is the main control register.  This is
banked between interrupt domains in the same way as ICC_APR_*.

The GICv5 spec assumes that typically there will need to be a
hardware handshake between the CPU and the IRS, which is kicked off
by guest software setting a LINK bit in this register to bring the
link between the two online.  However it is permitted to have an
implementation where the link is permanently up.  We take advantage
of this, so our LINK and LINK_IDLE bits are read-only and always 1.

This means the only interesting bit in this register for us is the
main enable bit: when disabled for a domain, the cpuif considers that
there is never an available highest priority interrupt.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h             |  1 +
 target/arm/tcg/gicv5-cpuif.c | 44 ++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e0a7d02386..1263841a1d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -605,6 +605,7 @@ typedef struct CPUArchState {
         /* GICv5 CPU interface data */
         uint64_t icc_icsr_el1;
         uint64_t icc_apr[NUM_GICV5_DOMAINS];
+        uint64_t icc_cr0[NUM_GICV5_DOMAINS];
         /* Most PPI registers have 1 bit per PPI, so 64 PPIs to a register */
         uint64_t ppi_active[GICV5_NUM_PPIS / 64];
         uint64_t ppi_hm[GICV5_NUM_PPIS / 64];
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 2f6827dc13..5af9fdb1db 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -43,6 +43,12 @@ FIELD(ICC_IDR0_EL1, ID_BITS, 0, 4)
 FIELD(ICC_IDR0_EL1, PRI_BITS, 4, 4)
 FIELD(ICC_IDR0_EL1, GCIE_LEGACY, 8, 4)
 
+FIELD(ICC_CR0, EN, 0, 1)
+FIELD(ICC_CR0, LINK, 1, 1)
+FIELD(ICC_CR0, LINK_IDLE, 2, 1)
+FIELD(ICC_CR0, IPPT, 32, 6)
+FIELD(ICC_CR0, PID, 38, 1)
+
 /*
  * We implement 24 bits of interrupt ID, the mandated 5 bits of priority,
  * and no legacy GICv3.3 vcpu interface (yet)
@@ -346,6 +352,37 @@ static uint64_t gic_icc_hapr_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return gic_running_prio(env, gicv5_current_phys_domain(env));
 }
 
+/* ICC_CR0_EL1 is also banked */
+static uint64_t gic_icc_cr0_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv5Domain domain = gicv5_logical_domain(env);
+    return env->gicv5_cpuif.icc_cr0[domain];
+}
+
+static void gic_icc_cr0_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    /*
+     * For our implementation the link to the IRI is always connected,
+     * so LINK and LINK_IDLE are always 1. Without EL3, PID and IPPT
+     * are RAZ/WI, so the only writeable bit is the main enable bit EN.
+     */
+    GICv5Domain domain = gicv5_logical_domain(env);
+    value &= R_ICC_CR0_EN_MASK;
+    value |= R_ICC_CR0_LINK_MASK | R_ICC_CR0_LINK_IDLE_MASK;
+
+    env->gicv5_cpuif.icc_cr0[domain] = value;
+}
+
+static void gic_icc_cr0_el1_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /* The link is always connected so we reset with LINK and LINK_IDLE set */
+    for (int i = 0; i < ARRAY_SIZE(env->gicv5_cpuif.icc_cr0); i++) {
+        env->gicv5_cpuif.icc_cr0[i] =
+            R_ICC_CR0_LINK_MASK | R_ICC_CR0_LINK_IDLE_MASK;
+    }
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -504,6 +541,13 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .writefn = gic_icc_apr_el1_write,
         .resetfn = gic_icc_apr_el1_reset,
     },
+    {   .name = "ICC_CR0_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 1, .crn = 12, .crm = 0, .opc2 = 1,
+        .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .readfn = gic_icc_cr0_el1_read,
+        .writefn = gic_icc_cr0_el1_write,
+        .resetfn = gic_icc_cr0_el1_reset,
+    },
     {   .name = "ICC_HAPR_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 1, .crn = 12, .crm = 0, .opc2 = 3,
         .access = PL1_R, .type = ARM_CP_IO | ARM_CP_NO_RAW,
-- 
2.43.0


