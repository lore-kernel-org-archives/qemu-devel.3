Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7ECC88E6E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x697R-0003tG-Pg; Mon, 14 Sep 2026 12:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x696t-0003Ns-Qn
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:00:52 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x696q-0004eX-In
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:00:47 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f633cd78so1103802f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 09:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789401633; x=1790006433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ma7EhGHQRutJnTccF+GlJMgT+aCYxDR9KoZVGOT5NJI=;
 b=lu+zwPMs4460O2jxQTupZmvKh6LrOR0nNLhCIUqMBMOc0WWMa+zKwb06KagKfWAvZj
 tORLVZt8pUg5GAlgOW28Yt4I7TBW9gdWDNq4gGh5C1Jv5sKNvQwLxKqwxZKe7hmxCyeO
 wVaSvHuGW61733ODyZ+sEbspjm8+jcNeOKgj0JU2+rI8PMrhCwRF9rXsZAaHURaKxJ2R
 seuajVBiMn+dJM4aSTnCAw6WCm/QCCQRmrWs9yiPg1+9PSQDJMSlgpvjsJCcwYFrL5sp
 aRJNPd+183hNbw2DxwJbiWuALD+xWYcNQPSKXoxB4MmwQGCiB0YzWZ8QVe2u7jmRy2sP
 qVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789401633; x=1790006433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ma7EhGHQRutJnTccF+GlJMgT+aCYxDR9KoZVGOT5NJI=;
 b=rJ+Gu7WXmukfw8uO8HPixDuPlDs4mvKsq5NaEiTFibqsUy4XkjUiN8Ag343ehE+87U
 0gU5dDsqNHYva6Wi89lAaMSy5CrCjKZUBPaaBZRFuniGAHki/7g/Q9p6GWeO5xPOrgKN
 csquqhbpN1PKVAZ1a5SMrVr/ADsSKoI+0MnAFL8AVrx2E5WyYVkJ7WEdvBfTdEnU7nok
 B0OaHjhxeDb8agx9oPHR/rzl/M/7LJL17usSVMHC9OPbcq2tCfb28QCFHGfXqS/OdJAG
 fqN2uul9oD8XfaTQlcBj6kvRuebezUiaRRCa4fDalAqDjS3TINevywA3LkFXV7sjoQDG
 rvQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQX+UETMMr/Awzz3dKAM/b8hFKLTfX3aHWdCA0sIKFNfAM8oxvhcBjTnR53wTPn3bI5J9ZWpazCtQU@nongnu.org
X-Gm-Message-State: AFuF++m5mhgfUFX6Ft1555oLFEPy87wc+FMPtNANPz5gsWTRLF8waSM3
 +j8XBufQOwnL/BwGLp7IAMe7+xb8TYiMShlaTfdRlF4dh7NQEgvmUeUEQRVANDJj4JsS8GljF7d
 2J2GMhms=
X-Gm-Gg: AYBFou0d5BhkmnXug0MTU++t98rlXuhJKvCht26GRgJD6XgCs1vUO6C1uM1ac4LTo+S
 FW4O/96JNpHq2YzNeIiz8jJ4ziix5rFFGtakWd1DnOAiQ7SJ58zz9tLpLbj1jMUG+bVWEdFg9cS
 muHlkWRzlBbMJD72BzhPV7uH3U6iLtfF0IFFDaAXqJ2mU/gYuYbzEhyM1RTPNXMcb8TSHPGBRY6
 hV3GkptJfZq8yNuarkbVeUlEfTacV1GyCngv2FHv1ROqfGBDxXx0TMSxT1lZC13XXO/86uDVbq+
 3TK1sA6XUmI6vOahBXu8Ynb3fH31n0r/An1q5pNMiXBuE7ltNFKZZ9z5hPXREv/cj4LwYxPcN3q
 dMrWb/Zh2YS76oQoYNTnZx3NapoHlw116MJk8rIQbxEcZRNcp27gpustr8vIm/TOX8cLfTjDZi8
 wSh5nN2qpQk/hKeeFzessnP7sDyQ7EOTL0y32tFO9NfXD036NeNjYdxBbAq5GEaRRBgiWSAv51D
 ltVlPmiLLDxB1S9CEABqAaJWZIkoD9qfRFNufB5RAdoUr/hrqNuUeHJ0SEfZHZN52iXtB0mcMgS
 IIkD
X-Received: by 2002:a05:6000:41ed:b0:487:4:bd86 with SMTP id
 ffacd0b85a97d-48702b5b792mr3993303f8f.42.1789401633069; 
 Mon, 14 Sep 2026 09:00:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb350686sm30797695f8f.27.2026.09.14.09.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 09:00:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 8/9] hw/intc/arm_gicv5: Pass CPU index to CPU interface
Date: Mon, 14 Sep 2026 17:00:19 +0100
Message-ID: <20260914160020.327787-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914160020.327787-1-peter.maydell@linaro.org>
References: <20260914160020.327787-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
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

In a real hardware GICv5, the IRS knows which CPU is talking to it
because each IRS<->cpuif link is a separate 1:1 connection.  In
QEMU's implementation, the cpuif code calls functions like
gicv5_set_priority(), and currently we usually don't pass anything to
tell the IRS which cpuif is making the call, because mostly the IRS
doesn't need to care.  There are a few places where it does need to
know, notably in gicv5_get_hppi().  Here we have the cpuif pass its
IAFFID; the IRS then looks that up by doing a linear search of the
cpu_iaffids[] array to get the index of the CPU.

For virtualization, many of the stream commands which don't currently
need to say which cpuif is making the call will have to start doing
so, because changing the state of a virtual interrupt requires the
IRS to look up the VPE which is resident on the calling cpuif. This
makes the IAFFID->cpuidx lookup seem increasingly awkward.

Change gicv5_set_gicv5state() to pass the IRS's CPU index value for
the cpuif as well as the guest-visible IAFFID, and make the stream
functions identify the cpuif by CPU index rather than IAFFID, to
avoid the unnecessary IAFFID->cpuidx lookup.

As this is now three GICv5-related things that we are keeping in the
CPU state struct, we push them into a sub-struct to keep them tidy.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5_common.c         |  2 +-
 include/hw/intc/arm_gicv5_stream.h |  6 ++++--
 target/arm/cpu.c                   | 10 ++++++----
 target/arm/cpu.h                   | 10 ++++++----
 target/arm/tcg/gicv5-cpuif.c       |  6 +++---
 5 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index cc67246686e..cfadfee4f05 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -176,7 +176,7 @@ static void gicv5_common_realize(DeviceState *dev, Error **errp)
     }
 
     for (int i = 0; i < cs->num_cpus; i++) {
-        if (!gicv5_set_gicv5state(cs->cpus[i], cs, cs->cpu_iaffids[i])) {
+        if (!gicv5_set_gicv5state(cs->cpus[i], cs, cs->cpu_iaffids[i], i)) {
             error_setg(errp,
                        "CPU %d (IAFFID 0x%x) does not implement GICv5 CPU interface",
                        i, cs->cpu_iaffids[i]);
diff --git a/include/hw/intc/arm_gicv5_stream.h b/include/hw/intc/arm_gicv5_stream.h
index 3cc9f611557..f45072d8c57 100644
--- a/include/hw/intc/arm_gicv5_stream.h
+++ b/include/hw/intc/arm_gicv5_stream.h
@@ -20,7 +20,8 @@ typedef struct GICv5Common GICv5Common;
  * gicv5_set_gicv5state
  * @cpu: CPU object to tell about its IRS
  * @cs: the GIC IRS it is connected to
- * @iaffid: the IAFFID of this CPU
+ * @iaffid: the IAFFID of this CPU (guest-visible)
+ * @cpuidx: the index of this CPU for this IRS (QEMU-internal)
  *
  * Set the CPU object's GICv5 pointer to point to this GIC IRS.  The
  * IRS must call this when it is realized, for each CPU it is
@@ -29,7 +30,8 @@ typedef struct GICv5Common GICv5Common;
  * Returns true on success, false if the CPU doesn't implement the
  * GICv5 CPU interface.
  */
-bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs, uint32_t iaffid);
+bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs, uint32_t iaffid,
+                          uint32_t cpuidx);
 
 /*
  * The architected Stream Protocol is asynchronous; commands can be
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index bbf4e0aa465..a64cdb8e895 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1213,17 +1213,19 @@ static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 }
 
 #ifndef CONFIG_USER_ONLY
-bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs, uint32_t iaffid)
+bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs, uint32_t iaffid,
+                          uint32_t cpuidx)
 {
     /*
      * Set this CPU's gicv5state pointer to point to the GIC that we are
-     * connected to, and record our IAFFID.
+     * connected to, and record our IAFFID and CPU index.
      */
     if (!cpu_isar_feature(aa64_gcie, cpu)) {
         return false;
     }
-    cpu->env.gicv5state = cs;
-    cpu->env.gicv5_iaffid = iaffid;
+    cpu->env.gicv5.gicv5state = cs;
+    cpu->env.gicv5.iaffid = iaffid;
+    cpu->env.gicv5.cpuidx = cpuidx;
     return true;
 }
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e3f931dba26..41a8770b121 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -814,10 +814,12 @@ typedef struct CPUArchState {
     const struct arm_boot_info *boot_info;
     /* Store GICv3CPUState to access from this struct */
     void *gicv3state;
-    /* Similarly, for a GICv5Common */
-    void *gicv5state;
-    /* For GICv5, this CPU's IAFFID */
-    uint64_t gicv5_iaffid;
+    /* Information the GICv5 IRS passes to us */
+    struct {
+        void *gicv5state; /* GICv5Common struct */
+        uint64_t iaffid; /* this CPU's IAFFID */
+        uint32_t cpuidx; /* GIC IRS-internal index of this CPU */
+    } gicv5;
 #else /* CONFIG_USER_ONLY */
     /* For usermode syscall translation.  */
     bool eabi;
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 517c780d1f7..eea66a4140e 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -87,7 +87,7 @@ FIELD(ICC_HPPIR_EL1, HPPIV, 32, 1)
 
 static GICv5Common *gicv5_get_gic(CPUARMState *env)
 {
-    return env->gicv5state;
+    return env->gicv5.gicv5state;
 }
 
 static GICv5Domain gicv5_logical_domain(CPUARMState *env)
@@ -147,7 +147,7 @@ static GICv5PendingIrq gic_hppi(CPUARMState *env, GICv5Domain domain)
         return GICV5_PENDING_IRQ_NONE;
     }
 
-    irs_hppi = gicv5_get_hppi(gic, domain, env->gicv5_iaffid);
+    irs_hppi = gicv5_get_hppi(gic, domain, env->gicv5.iaffid);
 
     /*
      * If the best PPI and the best interrupt from the IRS have the
@@ -788,7 +788,7 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 5,
         .access = PL1_R, .type = ARM_CP_NO_RAW,
         /* ICC_IAFFIDR_EL1 holds the IAFFID only, in its low bits */
-        .fieldoffset = offsetof(CPUARMState, gicv5_iaffid),
+        .fieldoffset = offsetof(CPUARMState, gicv5.iaffid),
         /*
          * The field is a constant value set in gicv5_set_gicv5state(),
          * so don't allow it to be overwritten by reset.
-- 
2.43.0


