Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84CFCCD195
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 13:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9OTi-0006hR-7F; Thu, 16 Oct 2025 09:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v9OTg-0006gG-9n
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:57:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v9OTX-00067H-Py
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760623017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6pM9KJI9trUfzRX2fsineaVXGBm7YlWm4sFywV3AVfw=;
 b=eaLTYzT56FXYeI7w4tkgjWOvRZHmhRIqaPof4Vz6k4J2pGs2Ei0fQA33m+yEHvNLpX9Pby
 FgcvIfyKmuxWvcMH6o1UR65/sdqLVEUQkF9Yp5gK89H33lgBSH2BK89MZhUjLt8lffKAcB
 WVAcGScRrBTuMErSfwFhbQNH0e+U/Ts=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-lvLkLoQgNoO4B0FQffaLxQ-1; Thu,
 16 Oct 2025 09:56:51 -0400
X-MC-Unique: lvLkLoQgNoO4B0FQffaLxQ-1
X-Mimecast-MFC-AGG-ID: lvLkLoQgNoO4B0FQffaLxQ_1760623009
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07A0219560BD; Thu, 16 Oct 2025 13:56:49 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.238])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DB81D19560B0; Thu, 16 Oct 2025 13:56:44 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [PATCH 3/7] target/arm/kvm: Introduce the concept of enforced/fake
 registers
Date: Thu, 16 Oct 2025 15:55:15 +0200
Message-ID: <20251016135625.249551-4-eric.auger@redhat.com>
In-Reply-To: <20251016135625.249551-1-eric.auger@redhat.com>
References: <20251016135625.249551-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Newer kernels may revoke exposure of KVM regs to userspace. This can
happen when one notices that some registers were unconditionnally
exposed whether they shall be conditionnally exposed for example.

An example of such situation is: TCR2_EL1, PIRE0_EL1,  PIR_EL1.
Associated kernel commits were:
0fcb4eea5345  KVM: arm64: Hide TCR2_EL1 from userspace when disabled for guests
a68cddbe47ef  KVM: arm64: Hide S1PIE registers from userspace when disabled for guests

Those commits were actual fixes but the cons is that is breaks forward
migration on some HW. Indeed when migrating from an old kernel that
does not feature those commits to a more recent one, destination
qemu detects there are more KVM regs in the input migration stream than
exposed by the destination host and the migration fails with:
"failed to load cpu:cpreg_vmstate_array_len"

This patchs adds the capability to defined an array of enforced
register indexes that teaches QEMU that some registers must exist.
If they are not exposed by KVM qemu fakes their presence in the
preload phase by adjusting the size of the cpreg_vmstate arrays.
On postload we make sure to ignore them when analyzing potential
mismatch between registers. The actual cpreg array is never altered
meaning those registers are never accessed nor saved.

The array will be populated with a deficated array property.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- improve comment in target/arm/cpu.h (Connie)
---
 target/arm/cpu.h        | 23 +++++++++++++++++++++++
 target/arm/kvm.c        | 24 ++++++++++++++++++++++++
 target/arm/machine.c    | 31 ++++++++++++++++++++++---------
 target/arm/trace-events |  2 ++
 4 files changed, 71 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 75cf7ee506..30d59a51d6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1052,6 +1052,19 @@ struct ArchCPU {
     uint64_t *kvm_hidden_regs;
     uint32_t nr_kvm_hidden_regs;
 
+    /*
+     * KVM registers whose presence must be enforced
+     * Either they must be exposed to user space by KVM or
+     * they must be faked for migration sake because the source does
+     * feature them.
+     */
+    uint64_t *kvm_enforced_regs;
+    uint32_t nr_kvm_enforced_regs;
+
+    /* registers that must be be faked */
+    uint64_t *kvm_fake_regs;
+    uint32_t nr_kvm_fake_regs;
+
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
 
@@ -2652,6 +2665,16 @@ static inline uint64_t *aa64_vfp_qreg(CPUARMState *env, unsigned regno)
 /* Shared between translate-sve.c and sve_helper.c.  */
 extern const uint64_t pred_esz_masks[5];
 
+static inline bool is_fake_reg(ARMCPU *cpu, uint64_t regidx)
+{
+    for (int i = 0; i < cpu->nr_kvm_fake_regs; i++) {
+        if (regidx == cpu->kvm_fake_regs[i]) {
+            return true;
+        }
+    }
+    return false;
+}
+
 /*
  * AArch64 usage of the PAGE_TARGET_* bits for linux-user.
  * Note that with the Linux kernel, PROT_MTE may not be cleared by mprotect
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 60fb743423..7551c43e79 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -788,6 +788,7 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
     struct kvm_reg_list rl;
     struct kvm_reg_list *rlp;
     int i, ret, arraylen;
+    int nr_fake_regs = 0;
     CPUState *cs = CPU(cpu);
 
     rl.n = 0;
@@ -801,6 +802,29 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
     if (ret) {
         goto out;
     }
+
+    /*
+     * Identify which registers belonging to the enforced list
+     * need to be faked because they are not exposed to userspace
+     * by KVM
+     */
+    cpu->kvm_fake_regs = g_new(uint64_t, cpu->nr_kvm_enforced_regs);
+    for (int j = 0; j < cpu->nr_kvm_enforced_regs; j++) {
+        uint64_t v64;
+        int r;
+
+        r = kvm_get_one_reg(cs, cpu->kvm_enforced_regs[j], &v64);
+        if (errno != ENOENT) {
+            /* enforced register exists, no need to fake */
+            trace_kvm_arm_init_cpreg_exposed(cpu->kvm_enforced_regs[j], v64, r);
+            continue;
+        }
+        cpu->kvm_fake_regs[nr_fake_regs] = cpu->kvm_enforced_regs[j];
+        trace_kvm_arm_init_cpreg_fake(cpu->kvm_fake_regs[nr_fake_regs]);
+        nr_fake_regs++;
+    }
+    cpu->nr_kvm_fake_regs = nr_fake_regs;
+
     /* Sort the list we get back from the kernel, since cpreg_tuples
      * must be in strictly ascending order.
      */
diff --git a/target/arm/machine.c b/target/arm/machine.c
index b7a655b066..fcf2dd8315 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -990,7 +990,8 @@ static int cpu_pre_load(void *opaque)
 {
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
-    int arraylen = cpu->cpreg_vmstate_array_len + MAX_CPREG_VMSTATE_ANOMALIES;
+    int arraylen = cpu->cpreg_vmstate_array_len +
+                   cpu->nr_kvm_fake_regs + MAX_CPREG_VMSTATE_ANOMALIES;
 
     cpu->cpreg_vmstate_indexes = g_renew(uint64_t, cpu->cpreg_vmstate_indexes,
                                          arraylen);
@@ -1057,6 +1058,10 @@ static int cpu_post_load(void *opaque, int version_id)
      * entries with the right slots in our own values array.
      */
 
+    /*
+     * at this point cpu->cpreg_vmstate_array_len was migrated with the
+     * actual length saved on source
+     */
     trace_cpu_post_load_len(cpu->cpreg_array_len, cpu->cpreg_vmstate_array_len);
     for (; i < cpu->cpreg_array_len && v < cpu->cpreg_vmstate_array_len;) {
         trace_cpu_post_load(i, v , cpu->cpreg_indexes[i]);
@@ -1071,10 +1076,14 @@ static int cpu_post_load(void *opaque, int version_id)
         }
         if (cpu->cpreg_vmstate_indexes[v] < cpu->cpreg_indexes[i]) {
             /* register in their list but not ours: those will fail migration */
-            trace_cpu_post_load_unexpected(v, cpu->cpreg_vmstate_indexes[v], i);
-            if (k < MAX_CPREG_VMSTATE_ANOMALIES) {
-                cpu->cpreg_vmstate_unexpected_indexes[k++] =
-                    cpu->cpreg_vmstate_indexes[v];
+            if (is_fake_reg(cpu, cpu->cpreg_vmstate_indexes[v])) {
+                /* this absence was expected as the reg was tagged as fake */
+            } else {
+                trace_cpu_post_load_unexpected(v, cpu->cpreg_vmstate_indexes[v], i);
+                if (k < MAX_CPREG_VMSTATE_ANOMALIES) {
+                    cpu->cpreg_vmstate_unexpected_indexes[k++] =
+                        cpu->cpreg_vmstate_indexes[v];
+                }
             }
             v++;
             continue;
@@ -1100,10 +1109,14 @@ static int cpu_post_load(void *opaque, int version_id)
      * still regs in the input stream, continue parsing the vmstate array
      */
     for ( ; v < cpu->cpreg_vmstate_array_len; v++) {
-        if (k < MAX_CPREG_VMSTATE_ANOMALIES) {
-            trace_cpu_post_load_unexpected(v, cpu->cpreg_vmstate_indexes[v], i);
-            cpu->cpreg_vmstate_unexpected_indexes[k++] =
-                cpu->cpreg_vmstate_indexes[v];
+        if (is_fake_reg(cpu, cpu->cpreg_vmstate_indexes[v])) {
+            /* this absence was expected as the reg was tagged as fake */
+        } else {
+            if (k < MAX_CPREG_VMSTATE_ANOMALIES) {
+                trace_cpu_post_load_unexpected(v, cpu->cpreg_vmstate_indexes[v], i);
+                cpu->cpreg_vmstate_unexpected_indexes[k++] =
+                    cpu->cpreg_vmstate_indexes[v];
+            }
         }
     }
 
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 31386cc1f2..fa9d721339 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -16,6 +16,8 @@ kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is
 kvm_arm_cpu_post_load_missing_reg(char *name) "Missing register in input stream: %s"
 kvm_arm_init_cpreg_list_arraylen(uint32_t arraylen) "arraylen=%d"
 kvm_arm_init_cpreg_list_skip_hidden_reg(uint64_t regidx) "hidden 0x%"PRIx64" is skipped"
+kvm_arm_init_cpreg_exposed(uint64_t regidx, uint64_t val, int ret) "enforced reg 0x%"PRIx64" is already exposed by KVM: value=0x%"PRIx64 " ret=%d: nothing to do"
+kvm_arm_init_cpreg_fake(uint64_t regidx) "register 0x%"PRIx64 " is not exposed and is faked"
 
 # cpu.c
 arm_cpu_reset(uint64_t mp_aff) "cpu %" PRIu64
-- 
2.49.0


