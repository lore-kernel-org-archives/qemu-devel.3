Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F53D262B0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 07:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viSxm-0004YE-7P; Wed, 21 Jan 2026 02:49:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1viSxg-0004Wn-7H
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 02:49:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1viSxe-0003TN-9M
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 02:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768981745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3McznrCgaoKWsPWweLxrxM06lAEHxg297odhSafpSxQ=;
 b=Taxdj5oWQ2UofbbPUcoiweognSHutIWy1gesUm1RiOycm5sHQdcrFZio/aL/g1B7PNtJ3F
 RKz5jScfjR2iXx1D6tr6UehWsBxOR3Rhoo8RE+dLEuQ4adqsf9uOeOQ03I/htQgyBv/pbb
 ngZ2gU3EWKSoEis6dB6XQNsvLr7fRG8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-IdlBgsniO1S_auHnle48LQ-1; Wed,
 21 Jan 2026 02:49:04 -0500
X-MC-Unique: IdlBgsniO1S_auHnle48LQ-1
X-Mimecast-MFC-AGG-ID: IdlBgsniO1S_auHnle48LQ_1768981742
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B93B11954B0C; Wed, 21 Jan 2026 07:49:02 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.15])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D14D19560A7; Wed, 21 Jan 2026 07:48:57 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [PATCH v5 04/11] target/arm/machine: Allow extra regs in the incoming
 stream
Date: Wed, 21 Jan 2026 08:46:41 +0100
Message-ID: <20260121074834.1900677-5-eric.auger@redhat.com>
In-Reply-To: <20260121074834.1900677-1-eric.auger@redhat.com>
References: <20260121074834.1900677-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This patchs adds the capability to define an array of register indexes
that may exist in the migration incoming stream but may be not
exposed by KVM on the destination.

We provision for extra space in cpreg_vmstate_* arrays during the preload
phase to allow the state to be saved without overflow, in case the
registers only are in the inbound data.

On postload we make sure to ignore them when analyzing potential
mismatch between registers. The actual cpreg array is never altered
meaning those registers are never accessed nor saved.

The array will be populated with a dedicated array property.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---

v2 -> v3:
- add a missing_as_expected trace point

v1 -> v2:
- get rid of the enforced/fake terminology
- remove the useless array of fake regs. Only the number of missing
  regs is needed

RFC -> v1:
- improve comment in target/arm/cpu.h (Connie)
---
 target/arm/cpu.h        | 22 ++++++++++++++++++++++
 target/arm/machine.c    | 30 +++++++++++++++++++++---------
 target/arm/trace-events |  1 +
 3 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b80f77d3743..985d74b2ff6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1054,6 +1054,15 @@ struct ArchCPU {
     uint64_t *hidden_regs;
     uint32_t nr_hidden_regs;
 
+    /*
+     * Registers that are likely to be part of the migration
+     * incoming stream but not exposed on destination. If
+     * their indexes are stored in this array, it is OK to
+     * ignore those registers in the inbound data.
+     */
+    uint64_t *mig_safe_missing_regs;
+    uint32_t nr_mig_safe_missing_regs;
+
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
 
@@ -1205,6 +1214,19 @@ arm_cpu_hidden_reg(ARMCPU *cpu, uint64_t regidx)
     return false;
 }
 
+
+static inline bool
+arm_cpu_safe_missing_reg(ARMCPU *cpu, uint64_t regidx)
+{
+    for (int i = 0; i < cpu->nr_mig_safe_missing_regs; i++) {
+        if (regidx == cpu->mig_safe_missing_regs[i]) {
+            return true;
+        }
+    }
+    return false;
+}
+
+
 /* Callback functions for the generic timer's timers. */
 void arm_gt_ptimer_cb(void *opaque);
 void arm_gt_vtimer_cb(void *opaque);
diff --git a/target/arm/machine.c b/target/arm/machine.c
index f06a920aba1..98851afc615 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -991,7 +991,8 @@ static int cpu_pre_load(void *opaque)
 {
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
-    int arraylen = cpu->cpreg_vmstate_array_len + MAX_CPREG_VMSTATE_ANOMALIES;
+    int arraylen = cpu->cpreg_vmstate_array_len +
+                   cpu->nr_mig_safe_missing_regs + MAX_CPREG_VMSTATE_ANOMALIES;
 
     cpu->cpreg_vmstate_indexes = g_renew(uint64_t, cpu->cpreg_vmstate_indexes,
                                          arraylen);
@@ -1058,6 +1059,10 @@ static int cpu_post_load(void *opaque, int version_id)
      * entries with the right slots in our own values array.
      */
 
+    /*
+     * at this point cpu->cpreg_vmstate_array_len was migrated with the
+     * actual length saved on source
+     */
     trace_cpu_post_load_len(cpu->cpreg_array_len, cpu->cpreg_vmstate_array_len);
     for (; i < cpu->cpreg_array_len && v < cpu->cpreg_vmstate_array_len;) {
         trace_cpu_post_load(i, v , cpu->cpreg_indexes[i]);
@@ -1072,10 +1077,15 @@ static int cpu_post_load(void *opaque, int version_id)
         }
         if (cpu->cpreg_vmstate_indexes[v] < cpu->cpreg_indexes[i]) {
             /* register in their list but not ours: those will fail migration */
-            trace_cpu_post_load_unexpected(v, cpu->cpreg_vmstate_indexes[v], i);
-            if (k < MAX_CPREG_VMSTATE_ANOMALIES) {
-                cpu->cpreg_vmstate_unexpected_indexes[k++] =
-                    cpu->cpreg_vmstate_indexes[v];
+            if (!arm_cpu_safe_missing_reg(cpu, cpu->cpreg_vmstate_indexes[v])) {
+                trace_cpu_post_load_unexpected(v, cpu->cpreg_vmstate_indexes[v], i);
+                if (k < MAX_CPREG_VMSTATE_ANOMALIES) {
+                    cpu->cpreg_vmstate_unexpected_indexes[k++] =
+                        cpu->cpreg_vmstate_indexes[v];
+                }
+            } else {
+                trace_cpu_post_load_missing_as_expected(v, cpu->cpreg_vmstate_indexes[v],
+                                                        i);
             }
             v++;
             continue;
@@ -1101,10 +1111,12 @@ static int cpu_post_load(void *opaque, int version_id)
      * still regs in the input stream, continue parsing the vmstate array
      */
     for ( ; v < cpu->cpreg_vmstate_array_len; v++) {
-        if (k < MAX_CPREG_VMSTATE_ANOMALIES) {
-            trace_cpu_post_load_unexpected(v, cpu->cpreg_vmstate_indexes[v], i);
-            cpu->cpreg_vmstate_unexpected_indexes[k++] =
-                cpu->cpreg_vmstate_indexes[v];
+        if (!arm_cpu_safe_missing_reg(cpu, cpu->cpreg_vmstate_indexes[v])) {
+            if (k < MAX_CPREG_VMSTATE_ANOMALIES) {
+                trace_cpu_post_load_unexpected(v, cpu->cpreg_vmstate_indexes[v], i);
+                cpu->cpreg_vmstate_unexpected_indexes[k++] =
+                    cpu->cpreg_vmstate_indexes[v];
+            }
         }
     }
 
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 20f4b4f2cd0..2e22012c692 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -35,3 +35,4 @@ cpu_post_load_len(int cpreg_array_len, int cpreg_vmstate_array_len) "cpreg_array
 cpu_post_load(int i, int v, uint64_t regidx) "i=%d v=%d regidx=0x%"PRIx64
 cpu_post_load_missing(int i, uint64_t regidx, int v) "missing register in input stream: i=%d index=0x%"PRIx64" (v=%d)"
 cpu_post_load_unexpected(int v, uint64_t regidx, int i) "unexpected register in input stream: v=%d index=0x%"PRIx64" (i=%d)"
+cpu_post_load_missing_as_expected(int v, uint64_t regidx, int i) "register missing as expected in input stream: v=%d index=0x%"PRIx64" (i=%d)"
-- 
2.52.0


