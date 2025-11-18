Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE7ECEE336
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 16:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLOHw-0002tN-CZ; Tue, 18 Nov 2025 11:10:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vLOHG-0002fH-M1
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 11:09:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vLOHE-0004p7-PM
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 11:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763482196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A8cNc/bfB7vtY9DBzhrSE1weO86Qsd8+duLQHCf7npg=;
 b=h4v9b/chXXMiav+qa69mQjCoIpzQa1O4NznG5SnAy6Lhon2g4yUMApCaYrYmBiG22a4xL1
 LS/kBW2CwFnl9BMBjJTYKmvhu7/2pMjyG4aiA039RMjoqSxgzPQzMsgcDJDFP40Hu61RFU
 M1jIi9XCPz0GlU5HPcEAa+pXKIXuidU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-fi9U1NvaMeixhNlE16WEEw-1; Tue,
 18 Nov 2025 11:09:48 -0500
X-MC-Unique: fi9U1NvaMeixhNlE16WEEw-1
X-Mimecast-MFC-AGG-ID: fi9U1NvaMeixhNlE16WEEw_1763482186
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA262180123A; Tue, 18 Nov 2025 16:09:46 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 29EB119560B0; Tue, 18 Nov 2025 16:09:40 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [PATCH v2 3/8] target/arm/machine: Allow extra regs in the incoming
 stream
Date: Tue, 18 Nov 2025 17:07:33 +0100
Message-ID: <20251118160920.554809-4-eric.auger@redhat.com>
In-Reply-To: <20251118160920.554809-1-eric.auger@redhat.com>
References: <20251118160920.554809-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

---

v1 -> v2:
- get rid of the enforced/fake terminology
- remove the useless array of fake regs. Only the number of missing
  regs is needed

RFC -> v1:
- improve comment in target/arm/cpu.h (Connie)
---
 target/arm/cpu.h     | 22 ++++++++++++++++++++++
 target/arm/machine.c | 27 ++++++++++++++++++---------
 2 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0a283940be..82fc21dcc5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1056,6 +1056,15 @@ struct ArchCPU {
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
 
@@ -1207,6 +1216,19 @@ arm_cpu_hidden_reg(ARMCPU *cpu, uint64_t regidx)
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
index f06a920aba..f420879134 100644
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
@@ -1072,10 +1077,12 @@ static int cpu_post_load(void *opaque, int version_id)
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
             }
             v++;
             continue;
@@ -1101,10 +1108,12 @@ static int cpu_post_load(void *opaque, int version_id)
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
 
-- 
2.51.1


