Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163C4CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUet-00071n-N4; Tue, 29 Sep 2026 06:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUet-00071Q-3T
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:59 -0400
Received: from mail-wr2-x0e.google.com ([2a00:1450:4864:30::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUeq-0008Ag-NY
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:58 -0400
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48af929e59dso110871f8f.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676115; x=1791280915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Rc4brlH3jAb6qGT7dPH+T+ifAjbCPf9UF7AiBqkGFnc=;
 b=vDcs80VxMeiot/jggCYRPxAOUCsFrSnOPqBlznF3SYXl1KJM9O92lRhmLOfgMT3kb2
 mF/ZZdD/d5UHJNijglQvbcO5RW6WwdRG6E45jyR+0gBT9w7hT9LXw/uhULlv3shFFyXP
 IJBWTmb0C6/nLqG0KVObo9mDPcm3PgJyv18+JUoxrjOboNyzOe/O1KpLkjG6BqsZRyF6
 aPFMQbTrG3sArEkfbVcEXWc8UZnKmoYHPjsDBCmkQJs8qNc45yAfZA7duVzublhjpoKT
 mz67YRfyzAIX/A54gXAWSaZt7SIZZ5szbRedMP0iG6EfXJiArQYGqO5iLMAcqteHSOHR
 yMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676115; x=1791280915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Rc4brlH3jAb6qGT7dPH+T+ifAjbCPf9UF7AiBqkGFnc=;
 b=2CQE6GfpN41BgIQFumBUgobsAQm3QqqECIii5DbeoC186P8d2ndERLfYJyZS87AJqV
 sqhJwSrDCFro2ae+zKC+n+JFP3Qaph5SqZuzSMSn/mYu601gyBMGEACepzQkinO4+eKq
 oYQzFLSfvSaxludLOUpkutvp6ROAjkqvyFgeL7/qYNFYuAxZT7LKKJ4FhflP/xE1Ae7L
 7fPdtxXRpJaiiv4vUFpBt1880VbezVrfWUAO2sGzntB6PnglRcdbf76nTti6ZoZHCOaU
 Zk1ziH7BDqUZiXjDwkrgYpYXCBm80WbD2U4yxFK0hLDFaW+vVRtRoCTpGnkCb9qO+7zw
 5clw==
X-Gm-Message-State: AFq9FYLEFRpTYFgc91cwOysLhPrBqia1D8XSNAKGkI/EZXiYTehNFpK1
 92M//Ee0KXXR1gx+bhbA+sX3ANZsSIu+loKnNg72mi8shI+/4nrcu92QTjoPOGWTT2P4pxAm0kk
 zjt07
X-Gm-Gg: AYBFou2G5mv7GrGVJ8L11Ruv94mAW2xlvtlOyJdY9Gk1FPjFVjvIaaeb/DBy4JZ92vN
 +e9qVs620f+lC5J1JE+Wpx3fzmwD1q47camAjTTFfq8uHIoDWG+BznIE0DObqk7VkyxZFRR2NvI
 AbO24xOboEtOq/JrIx4NlmsRCnaD6qbTNKsLXZ4Vsb9/AR1nd9TzsJEGb75jwyePfUabWEUuBuT
 kfLXkPNtwz3/fTwD8kbY1x9lQHzWry+l7lMBMqtHwan74ZdOh1OxWaTkFNKUTW2gDTn5E/qVq2+
 VA/JEINUwGcSLFurJH7slA2AIXN/u6ZWwpfhl6XzCdU/OKZVbDyXo757z9nwtowjyd/zufMjPni
 tGBAfpppOUgpm2VOgIksxQPTCFQAb1lrdPO2d6KTRjcMDpiqdFZr44ujZ44L+xh7niHxoN+BaQr
 DHte44kB0elcXZARKyLb6YzscpIRpA4Lq0cJodHxfJXF1c40YuUDTLgXCuXHDGoXLZ30UVBEHQd
 JuvU8gF3KnYxp8ftbocRS7JX6ubQfzCV8poksJGXFeVxKsVEYIBv3MZMguR74Lg0LESipiRDeeZ
 8jFhXa2daJFWRQ==
X-Received: by 2002:a05:6000:40dc:b0:487:ff2:12f4 with SMTP id
 ffacd0b85a97d-488717781c4mr28180615f8f.40.1790676114807; 
 Tue, 29 Sep 2026 03:01:54 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.01.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:01:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/37] target/arm: Keep the S/NS bit in migration data
Date: Tue, 29 Sep 2026 11:01:08 +0100
Message-ID: <20260929100133.2598676-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

For Arm, the format we use on the wire for migration of sysregs
(cpregs on AArch32) is a set of arrays, where cpreg_indexes[] holds
the register IDs and cpreg_values[] holds the corresponding values.
The ID format we use is KVM's ID format, which is 64 bits.  This is
not quite the same as the 32-bit ID format QEMU uses internally for
things like the coprocessor register hashtable keys, and so we have
conversion functions kvm_to_cpreg_id() and cpreg_to_kvm_id() to swap
between them.

This conversion has never handled AArch32 Secure coprocessor
registers correctly: the KVM ID format has no way to indicate a
Secure register, because KVM VMs on AArch32 were always NonSecure.
The current code doesn't touch the CP_REG_AA32_NS_MASK bit when
converting from the 32-bit ID format to a KVM ID, and it forces the
NS bit to 1 when converting from a KVM ID to a cpreg.  The effect of
this on migration is that the indexes in cpreg_indexes[] have NS = 0
for the Secure banked registers and NS = 1 for the NS banked
registers, but when we read and write the values into the CPUState by
finding the register using kvm_to_cpreg_id(cpreg_indexes[i]) we
always find the NS register, and so the S register values aren't
actually migrated.

This went unnoticed most of the time because a typical Linux guest is
running only in NS and doesn't really care about the S register
state, but it breaks migration of a guest which is running in S, such
as Linux on the imx boards.

This would be more awkward to fix if KVM still supported AArch32
hosts, but luckily that was dropped some years ago, and AArch32
guests on an AArch64 host expose the sysregs as CP_REG_ARM64, not
CP_REG_ARM32.  So the only place where we use a CP_REG_ARM32 KVM
register ID is for TCG migrations.  We can therefore (continue to)
steal a bit in the KVM format for the NS bit, with the semantics
we've given it on the wire in the past.  We just need to let
kvm_to_cpreg_id() pass it through rather than forcing it to 1.

To retain compatibility with migration from older QEMU versions
without this fix, we need to add a subsection to the migration data
that tells the destination that it can trust the values for Secure
banked registers.  For incoming migrations, if we don't see this then
we ignore all the values for Secure banked registers, giving the same
behaviour as before.  This means we continue to work for migrations
where the Secure world exists but the guest is basically not using
it, such as a direct kernel boot on boards which don't set
arm_boot_info::secure_boot to true; this includes the cubieboard,
bananapi and orangepi.

Attempting migration from a new QEMU to an older QEMU version will
now fail cleanly (because the destination doesn't recognize the new
subsection) rather than silently corrupting the Secure banked
registers.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/467
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260907130223.3148989-2-peter.maydell@linaro.org
---
 target/arm/cpregs.h  | 21 ++++++++----
 target/arm/cpu.h     |  6 ++++
 target/arm/machine.c | 80 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 9f2532fe667..ce651a4faa6 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -215,7 +215,20 @@ enum {
 
 /*
  * Convert a full 64 bit KVM register ID to the truncated 32 bit
- * version used as a key for the coprocessor register hashtable
+ * version used as a key for the coprocessor register hashtable.
+ *
+ * Note that we deviate slightly from the KVM register ID format as
+ * used by the kernel for AArch32 cpregs, by using bit 29 as "1
+ * for NonSecure, 0 for Secure". (When KVM still supported AArch32
+ * hosts it didn't set this bit; all sysregs for KVM guests are
+ * NonSecure anyway.) This shouldn't cause any issues as KVM no longer
+ * supports AArch32 hosts (and other accelerators never did), so the
+ * only thing that generates KVM regids for AArch32 cpregs is QEMU
+ * TCG.
+ *
+ * The NS bit being in the KVM ID is implicit in the fact that we
+ * don't mask out CP_REG_AA32_NS_MASK in the conversions to and from
+ * the QEMU hashtable key ID format.
  */
 static inline uint32_t kvm_to_cpreg_id(uint64_t kvmid)
 {
@@ -226,12 +239,6 @@ static inline uint32_t kvm_to_cpreg_id(uint64_t kvmid)
         if ((kvmid & CP_REG_SIZE_MASK) == CP_REG_SIZE_U64) {
             cpregid |= CP_REG_AA32_64BIT_MASK;
         }
-
-        /*
-         * KVM is always non-secure so add the NS flag on AArch32 register
-         * entries.
-         */
-         cpregid |= CP_REG_AA32_NS_MASK;
     }
     return cpregid;
 }
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f07cadb45c7..418fe78809f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1146,6 +1146,12 @@ struct ArchCPU {
     bool prop_pauth_qarma5;
     bool prop_lpa2;
 
+    /*
+     * Used only during migration, to handle back-compat with older QEMU
+     * that mishandled migration of AArch32 banked cpregs.
+     */
+    bool secure_banked_regs_ok;
+
     /* GM blocksize, in log_2(words), ie low 4 bits of GMID_EL0 */
     uint8_t gm_blocksize;
 
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 53a2734d25d..c3aef3f3301 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -979,6 +979,39 @@ static const VMStateDescription vmstate_fpmr = {
     },
 };
 
+static bool secure_banked_regs_ok_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    /*
+     * We must send this subsection if this is an AArch32 CPU with
+     * banked coprocessor registers. Older QEMU mishandled migration
+     * of these by listing both Secure and NonSecure banked registers
+     * in the cpreg_vmstate_indexes but reading and writing the
+     * NonSecure register for both indexes. Providing this subsection
+     * tells the destination that we do not have this bug and it
+     * should not ignore the Secure banked register values.
+     *
+     * We don't need the subsection for CPUs without banked registers
+     * (notably AArch64 ones and M-profile ones), and don't send
+     * it to avoid breaking migration compat for them.
+     */
+    return !arm_feature(&cpu->env, ARM_FEATURE_AARCH64) &&
+        !arm_feature(&cpu->env, ARM_FEATURE_M) &&
+        arm_feature(&cpu->env, ARM_FEATURE_EL3);
+}
+
+static const VMStateDescription vmstate_secure_banked_regs_ok = {
+    .name = "cpu/secure-banked-regs-ok",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = secure_banked_regs_ok_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL(secure_banked_regs_ok, ARMCPU),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static int cpu_pre_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -1014,6 +1047,9 @@ static int cpu_pre_save(void *opaque)
     cpu->cpreg_vmstate_values = cpu->cpreg_values;
     cpu->cpreg_vmstate_array_len = cpu->cpreg_array_len;
 
+    /* We don't have the bug where we send wrong data for Secure regs */
+    cpu->secure_banked_regs_ok = true;
+
     return 0;
 }
 
@@ -1062,6 +1098,9 @@ static int cpu_pre_load(void *opaque)
     g_assert(!cpu->cpreg_vmstate_indexes);
     g_assert(!cpu->cpreg_vmstate_values);
 
+    /* So cpu_post_load() can see if we saw secure-banked-regs-ok */
+    cpu->secure_banked_regs_ok = false;
+
     return 0;
 }
 
@@ -1120,6 +1159,7 @@ static int cpu_post_load(void *opaque, int version_id)
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
     bool fail = false;
+    bool ignore_s_regs;
     int i, v;
 
     trace_cpu_post_load(cpu->cpreg_vmstate_array_len,
@@ -1142,6 +1182,21 @@ static int cpu_post_load(void *opaque, int version_id)
              CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VFIQ);
     }
 
+    /*
+     * Handle migration compatibility from an old QEMU which didn't get
+     * AArch32 Secure banked cpregs right. That QEMU will not have sent
+     * us the secure-banked-regs-ok subsection, and although its
+     * vmstate_indexes will include the S banked regs, the values in
+     * vmstate_values will be duplicates of the values of the NS banked
+     * regs. Ignore the S banked registers, which is the same effective
+     * behaviour of an old->old migration. (That is, the S regs will
+     * be at their reset values, which is usually good enough for the
+     * case of "guest is actually executing in NS and doesn't care
+     * about the S state".)
+     */
+    ignore_s_regs = secure_banked_regs_ok_needed(cpu) &&
+        !cpu->secure_banked_regs_ok;
+
     /* Update the values list from the incoming migration data.
      * Anything in the incoming data which we don't know about is
      * a migration failure; anything we know about but the incoming
@@ -1165,6 +1220,30 @@ static int cpu_post_load(void *opaque, int version_id)
             continue;
         }
         /* matching register, copy the value over */
+
+        if (ignore_s_regs) {
+            /*
+             * If this is an AArch32 Secure cpreg, read the current (reset)
+             * value instead of using the migration state value. That way
+             * write_list_to_cpustate() will effectively be a NOP.
+             */
+            uint64_t kvmidx = cpu->cpreg_vmstate_indexes[v];
+
+            if ((kvmidx & CP_REG_ARCH_MASK) == CP_REG_ARM &&
+                (kvmidx & CP_REG_AA32_NS_MASK) == 0) {
+                uint32_t regidx = kvm_to_cpreg_id(kvmidx);
+                const ARMCPRegInfo *ri = get_arm_cp_reginfo(cpu->cp_regs,
+                                                            regidx);
+                /*
+                 * Missing ri or NO_RAW ri will be ignored or errored in
+                 * write_list_to_cpustate() later, so safe to skip.
+                 */
+                if (ri && !(ri->type & ARM_CP_NO_RAW)) {
+                    cpu->cpreg_vmstate_values[v] = read_raw_cp_reg(env, ri);
+                }
+            }
+        }
+
         cpu->cpreg_values[i] = cpu->cpreg_vmstate_values[v];
         i++;
         v++;
@@ -1343,6 +1422,7 @@ const VMStateDescription vmstate_arm_cpu = {
         &vmstate_pstate64,
         &vmstate_event,
         &vmstate_fpmr,
+        &vmstate_secure_banked_regs_ok,
         NULL
     }
 };
-- 
2.43.0


