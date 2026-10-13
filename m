Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83FECA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY4P-0000zY-Bn; Tue, 13 Oct 2026 04:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3g-0007g8-OG
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:28 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3d-0007vr-Lz
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:28 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a02667ccebso18658625e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880824; x=1792485624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vTvIfdyX/SM1rGf15Fby2Qgem7tDHZaoRHeVArtn0is=;
 b=Uv9Md4Bo/wJV2y1IN3oxZBgkOeaAvsqusKB0zpUJ5e+zy/7VAmQSQMHNDCl1PkjfuA
 bNXaga12nbumwQgbMgaaRYZ0LMKcfy8owDE2bugv3LHjYM1c5e5dr3ZStKE56Ja9wMhl
 neMfNFVOb2c/FrUIqd8YzTsYKks6q7Kl1cVUVE8QVXtJibcAkUQVPNaApCaMjk5vKXgH
 NmdzuOnj39Ly83D/TKxGvC6t4KrycqZUdOnkA7W5XF8a9YSZan6kf9DscLUiLstwZhio
 d2mz0D8DdxBN0MUmrY776o1W9ILuBGsvuXAONpugbXzDkI2q9ixn0qxiGR9P0MHAzfzO
 3ESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880824; x=1792485624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vTvIfdyX/SM1rGf15Fby2Qgem7tDHZaoRHeVArtn0is=;
 b=qu+TQgmoir/A/xX9m+t2eeQggBkID9ed3LOQe4GXe1YaNt00VPFxBKiega1EfG9xAl
 xPGQdZogvzrs7w1dchEbl5yKere7EAuPcfEYPdD17KxdZmw2LDGaFCfmsRGMs7xi+uM8
 8wE2p/ZzVohKjRFXg36tHDtytffUXaEJQ0iV8fzcroxEGS9+IpVg4EQrxYgsqqHO8Rqr
 b/rQyvyusdEv/izudf9sLmlSeac4Szi0/2Jlf9dtpOOdhJ411VUwy7aKRf+P3K+bVj8V
 6xlNTSPoosjsgBww4wX+N9pMZqZGGVNNT741Na7gbvXPdhfRhKZEjylzQem2CoYIb+gO
 Q3qw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkOat9uO7WVbVTkQb2TOpIVJcX/6lSNQPxeNlQbU/k+lhiT4QuGUeNkFUBmEua8Ha5kR65NzS2b/j/@nongnu.org
X-Gm-Message-State: AFq9FYJDdLa9rsKxOEBkn+tZxilQGSsblH+IO94SBjt/yWIK8YL7IhaX
 DEXt16XaqiaM2F5pnq15N75ZTYn/FXLE09NeFefOm8kxmJuOR/Bsjy7N/5nWD0Q75UU=
X-Gm-Gg: AYBFou0dnlkb8UUc/8UCnk4Rv42FSytZsId4nUmFn7nh+loSw2Le6LDxSleraOBkW8R
 UjPlIFP/sQMTow0wDnWc125tOvjoF6sC8zmu1nqdCxI6T2Vty6wHeBaYTAJT9FJHij7zDPiAGOg
 CUX5dSI0C3hEtpmqKTpnVZ8Cns2pa2wTI2b/Y/3lawURcMr399NJR5Tbd5lCB7+soK10xxefLcn
 +BGzjeMWjd6pNTH10xDqfQ3MG7xEIM7FXnff1iJu+lQPwW6wnXtNfk8LIeN93QPmLjH1ERG8Gud
 gWvxL7S17ZWHSpsPMT9iuqDwsSUvbGKwWFkfXmW0hE/VN279WxCS8uGhxVTBwP8aHD52qx+N7pP
 pHJefX/d4JuWAalre7hKulwrIs8guMImFvPSXRQa/mxykDvJk5oFUCtuEERwvq+VqoxQLAy9q4U
 DSoOJIHCLD0csqcSpnyN1ZGq7YOumwjJwNpABs2FQHUU2V+Upvm4W6QunLy6/i6J+QKp7ld1qFZ
 fdkS6mP9+HisGyXaxjd+W6iDToDVxJuDrmW/dKG3RBmULumHCzhKHlpzk3gMhNdfw7Z83NtdbfB
 T50=
X-Received: by 2002:a05:600c:64c7:b0:4a1:8399:b74a with SMTP id
 5b1f17b1804b1-4a18e4e5c7cmr216353315e9.31.1791880823818; 
 Tue, 13 Oct 2026 01:40:23 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 35/86] target/arm: GICv5 cpuif: Implement ICH_CONTEXTR_EL2
Date: Tue, 13 Oct 2026 09:38:42 +0100
Message-ID: <20261013083933.1024405-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

The ICH_CONTEXTR_EL2 register is how the hypervisor tells the GICv5
to make a VCPU for a VM resident on a CPU, so that the IRS will
forward virtual interrupts for that VCPU to this CPU. We implement
this similarly to the GICv5 stream protocol, which uses a
SetResident command to tell the IRS to make the VCPU resident.
This will always fail until we have implemented the IRS's
end of virtualization support.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c                |   8 ++
 include/hw/intc/arm_gicv5_stream.h |  30 +++++++
 target/arm/cpu.h                   |   1 +
 target/arm/tcg/gicv5-cpuif.c       | 121 +++++++++++++++++++++++++++++
 target/arm/tcg/trace-events        |   1 +
 5 files changed, 161 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index f714add1406..5ac50acc786 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1263,6 +1263,14 @@ txfail:
                   "physical address 0x" HWADDR_FMT_plx "\n", intid, l1_addr);
 }
 
+bool gicv5_set_resident(GICv5Common *cs, GICv5Domain domain, bool valid,
+                        uint32_t vpeid, bool db, uint8_t dbpm, uint32_t vmid,
+                        uint32_t cpuidx)
+{
+    /* Until we implement virtualization, SetResident always fails */
+    return true;
+}
+
 /* Data we need to pass through to irs_clean_lpi_cache_entry() */
 typedef struct CleanLPICacheUserData {
     GICv5Common *cs;
diff --git a/include/hw/intc/arm_gicv5_stream.h b/include/hw/intc/arm_gicv5_stream.h
index 21be859a233..162d55a8e6b 100644
--- a/include/hw/intc/arm_gicv5_stream.h
+++ b/include/hw/intc/arm_gicv5_stream.h
@@ -229,4 +229,34 @@ GICv5PendingIrq gicv5_get_hppi(GICv5Common *cs, GICv5Domain domain,
 void gicv5_deactivate(GICv5Common *cs, uint32_t id, GICv5Domain domain,
                       GICv5IntType type, bool virtual);
 
+/**
+ * gicv5_set_resident
+ * @cs: GIC IRS to send command to
+ * @domain: interrupt domain to act on
+ * @valid: true if setting resident VPE, false to clear it
+ * @vpeid: identifier of the VPE to make resident
+ * @db: true to request a doorbell
+ * @dbpm: doorbell priority mask
+ * @vmid: Virtual Machine identifier
+ * @cpuidx: IRS CPU index of this CPU interface
+ *
+ * Tell the IRS to make the specified VPE resident for this CPU. This
+ * corresponds approximately to the stream protocol SetResident command.
+ *
+ * Returns the Fault state: false if the SetResident operation
+ * succeeded, true if the VPE could not be made resident. Clearing the
+ * VPE always succeeds and returns false.
+ *
+ * For QEMU this is a synchronous operation: the function does not return
+ * until the IRS has either succeeded or failed in making the VPE resident
+ * (including identifying whether there is a pending virtual interrupt for
+ * the VPE and forwarding it by calling gicv5_forward_interrupt() if so).
+ *
+ * Unlike the stream protocol (where the IRS knows which CPU it is talking
+ * to), we have to pass the cpuidx to tell the IRS which CPU we are.
+ */
+bool gicv5_set_resident(GICv5Common *cs, GICv5Domain domain, bool valid,
+                        uint32_t vpeid, bool db, uint8_t dbpm, uint32_t vmid,
+                        uint32_t cpuidx);
+
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index abaee5fc3a0..0d8c2176a43 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -599,6 +599,7 @@ typedef struct CPUArchState {
         /* And for the virtual interrupt domain */
         GICv5PendingIrq virt_ppi_hppi;
 
+        uint64_t ich_contextr_el2;
         uint64_t ich_apr_el2;
         uint64_t ich_vctlr_el2;
         uint64_t ich_vmcr_el2;
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index a938428b20a..2eb8184e329 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -73,6 +73,14 @@ FIELD(ICH_VMCR_EL2, VMPR, 27, 5)
 FIELD(ICH_VCTLR_EL2, EN, 0, 1)
 FIELD(ICH_VCTLR_EL2, V3, 1, 1)
 
+FIELD(ICH_CONTEXTR_EL2, VM, 0, 16)
+FIELD(ICH_CONTEXTR_EL2, VPE, 32, 16)
+FIELD(ICH_CONTEXTR_EL2, DBPM, 55, 5)
+FIELD(ICH_CONTEXTR_EL2, DB, 60, 1)
+FIELD(ICH_CONTEXTR_EL2, IRICHPPIDIS, 61, 1)
+FIELD(ICH_CONTEXTR_EL2, F, 62, 1)
+FIELD(ICH_CONTEXTR_EL2, V, 63, 1)
+
 /*
  * We implement 24 bits of interrupt ID, the mandated 5 bits of priority,
  * and no legacy GICv3.3 vcpu interface (yet)
@@ -821,6 +829,110 @@ static void gic_ich_vmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gicv5_update_virq_vfiq(env);
 }
 
+static void gic_ich_contextr_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   uint64_t value)
+{
+    GICv5Common *gic = gicv5_get_gic(env);
+    GICv5Domain domain = gicv5_logical_domain(env);
+    bool valid = FIELD_EX64(value, ICH_CONTEXTR_EL2, V);
+    uint32_t vpe = FIELD_EX64(value, ICH_CONTEXTR_EL2, VPE);
+    bool db = FIELD_EX64(value, ICH_CONTEXTR_EL2, DB);
+    uint8_t dbpm = FIELD_EX64(value, ICH_CONTEXTR_EL2, DBPM);
+    uint32_t vm = FIELD_EX64(value, ICH_CONTEXTR_EL2, VM);
+    uint32_t cpuidx = env->gicv5.cpuidx;
+    bool fault;
+    uint64_t oldval = env->gicv5_cpuif.ich_contextr_el2;
+    bool vm_vpe_changed = (oldval ^ value) & (R_ICH_CONTEXTR_EL2_VM_MASK |
+                                              R_ICH_CONTEXTR_EL2_VPE_MASK);
+    bool valid_changed = (oldval ^ value) & R_ICH_CONTEXTR_EL2_V_MASK;
+
+    /*
+     * DB and DBPM are RAZ: they are write-only fields that have
+     * an effect when V is changed from 1 to 0.
+     */
+    value &= ~(R_ICH_CONTEXTR_EL2_DB_MASK | R_ICH_CONTEXTR_EL2_DBPM_MASK);
+
+    raw_write(env, ri, value);
+
+    trace_gicv5_ich_contextr_write(cpuidx, value);
+
+    /*
+     * Changing V definitely causes us to make a new VPE resident, or
+     * remove the old one.
+     *
+     * Changing VPE or VM while V=1 is CONSTRAINED UNPREDICTABLE
+     * (R_VFKHN): we choose to make the new VPE resident so that we
+     * can trust that the information we have in the register matches
+     * what the IRS thinks the resident VPE is.
+     *
+     * For writes that don't trigger a change of resident VPE, we only
+     * need to update our copy of the register, and recalculate
+     * interrupts if IIRICHPPIDIS changed.
+     *
+     * If we do change the resident VPE, the interrupt recalculation
+     * will happen when the IRS calls gicv5_forward_interrupt().
+     */
+    if (!(valid_changed || (valid && vm_vpe_changed))) {
+        if ((oldval & value) & R_ICH_CONTEXTR_EL2_IRICHPPIDIS_MASK) {
+            gicv5_update_virq_vfiq(env);
+        }
+        return;
+    }
+
+    if (valid) {
+        /* Doorbell info is only relevant when clearing the VPE */
+        dbpm = 0;
+        db = false;
+    } else {
+        /* The IRS knows what the VPE is so we don't need to tell it */
+        vm = 0;
+        vpe = 0;
+    }
+
+    fault = gicv5_set_resident(gic, domain, valid, vpe, db, dbpm, vm, cpuidx);
+
+    if (valid) {
+        /*
+         * We only update F for a VPE set, not a clear.
+         *
+         * On a failure, it is CONSTRAINED UNPREDICTABLE whether V
+         * reads as 0 or 1 (R_NHCGW); we choose to set it to 0 so we
+         * can reliably use it to track whether a VPE is resident.  We
+         * use this for instance in GIC VDPEND: we trust the V and VM
+         * fields to be accurate.
+         */
+        value = env->gicv5_cpuif.ich_contextr_el2;
+        value = FIELD_DP64(value, ICH_CONTEXTR_EL2, F, fault);
+        if (fault) {
+            value = FIELD_DP64(value, ICH_CONTEXTR_EL2, V, 0);
+        }
+        env->gicv5_cpuif.ich_contextr_el2 = value;
+    }
+}
+
+static void gic_ich_contextr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /*
+     * This register resets to zero, which includes telling the IRS
+     * that there is no longer a resident VPE for it.
+     *
+     * It doesn't matter if the domain we pass here doesn't match the
+     * domain of the VM/VPE: as with the GIC stream interface (see
+     * rule R_PYWKM) our IRS ignores the mismatch for a SetResident
+     * request with valid = false.
+     *
+     * As this is a reset fn we may get here before the GIC pointer
+     * has been set up yet, so unusually we need to check for NULL>
+     */
+    raw_write(env, ri, 0);
+    GICv5Common *gic = gicv5_get_gic(env);
+
+    if (gic) {
+        gicv5_set_resident(gic, gicv5_logical_domain(env),
+                           false, 0, false, 0, 0, env->gicv5.cpuidx);
+    }
+}
+
 /*
  * ICC_APR_EL1 is banked and reads/writes as the version for the
  * current logical interrupt domain.
@@ -1500,6 +1612,15 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ich_vctlr_el2),
         .writefn = gic_ich_vctlr_write,
     },
+    {   .name = "ICH_CONTEXTR_EL2", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 11, .opc2 = 6,
+        .access = PL2_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .nv2_redirect_offset = 0xb08,
+        .accessfn = access_gicv5_ich_reg,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ich_contextr_el2),
+        .writefn = gic_ich_contextr_write,
+        .resetfn = gic_ich_contextr_reset,
+    },
     {   .name = "ICH_VMCR_EL2", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 11, .opc2 = 7,
         .access = PL2_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
diff --git a/target/arm/tcg/trace-events b/target/arm/tcg/trace-events
index 71f1369fcda..75f40c44f26 100644
--- a/target/arm/tcg/trace-events
+++ b/target/arm/tcg/trace-events
@@ -11,3 +11,4 @@ gicv5_cddi(int domain, uint32_t id) "domain %d CDDI deactivating interrupt ID 0x
 gicv5_update_irq_fiq(bool irq, bool fiq, bool nmi) "now IRQ %d FIQ %d NMI %d"
 gicv5_update_virq_vfiq(bool virq, bool vinmi) "now VIRQ %d VINMI %d"
 gicv5_update_ppi_state(int ppi, bool level) "PPI %d source level now %d"
+gicv5_ich_contextr_write(uint32_t cpuidx, uint64_t value) "cpuidx %d ICH_CONTEXTR_WRITE 0x%" PRIx64
-- 
2.43.0


