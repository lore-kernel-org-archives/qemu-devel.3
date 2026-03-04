Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3C5EB7EA5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 10:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxjHb-0002Rl-6U; Wed, 04 Mar 2026 05:16:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxjHZ-0002RI-MP
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:16:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxjHX-0008Tb-Ts
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772619403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HlxXD3SwRBQxQ8pUvaYL9idlSRo9xX0PZQG86dGOGJM=;
 b=a5H0JM38IsaPBvew8eDNu1s9ynXVCk7xyVXGSrCiWunyecrw8Ag9D7QQ6v/M6Z2ROofrZ9
 ewtkLsirc0jrP6+fEqQ+oNWG29L4XlMmuwP1BIVq/QoFdszD/KV3VMim7JxuhvJNokoQTP
 l45P4p9N5t8g2uZZObG0+lp7TcBoMYM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-s8yti4ZSNE-hs-HIGf5rhA-1; Wed,
 04 Mar 2026 05:16:40 -0500
X-MC-Unique: s8yti4ZSNE-hs-HIGf5rhA-1
X-Mimecast-MFC-AGG-ID: s8yti4ZSNE-hs-HIGf5rhA_1772619399
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D22E18005B8; Wed,  4 Mar 2026 10:16:39 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.89])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0EDE7180035F; Wed,  4 Mar 2026 10:16:35 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v3 2/7] target/arm/machine: Use VMSTATE_VARRAY_INT32_ALLOC for
 cpreg arrays
Date: Wed,  4 Mar 2026 11:15:41 +0100
Message-ID: <20260304101625.1962633-3-eric.auger@redhat.com>
In-Reply-To: <20260304101625.1962633-1-eric.auger@redhat.com>
References: <20260304101625.1962633-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

This removes the need for explicitly allocating cpreg_vmstate arrays.
On post save we simply point to cpreg arrays and set the length
accordingly.

Remove VMSTATE_VARRAY_INT32 for cpreg_vmstate_array_len as now
the array is dynamically allocated.

Also add a trace point on post_load to trace potential mismatch
between the number of incoming cpregs versus current ones.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

---

v1 -> v2:
- also modifies the allocation of cpureg_vmstate_* in
  target/arm/whpx/whpx-all.c
- added Peter's suggested comment on cpu_pre_save()
- free the the vmstate arrays on post_load
- add assert on pre_load
- fix comment aboy length check in machine.c

v2 -> v3:
- clear the pointers also in post_save()
---
 target/arm/helper.c        |  5 -----
 target/arm/kvm.c           |  5 -----
 target/arm/machine.c       | 45 +++++++++++++++++++++++++++-----------
 target/arm/whpx/whpx-all.c |  7 ------
 target/arm/trace-events    |  3 +++
 5 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6bfab90981c..7389f2988c4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -265,15 +265,10 @@ void arm_init_cpreg_list(ARMCPU *cpu)
     if (arraylen) {
         cpu->cpreg_indexes = g_new(uint64_t, arraylen);
         cpu->cpreg_values = g_new(uint64_t, arraylen);
-        cpu->cpreg_vmstate_indexes = g_new(uint64_t, arraylen);
-        cpu->cpreg_vmstate_values = g_new(uint64_t, arraylen);
     } else {
         cpu->cpreg_indexes = NULL;
         cpu->cpreg_values = NULL;
-        cpu->cpreg_vmstate_indexes = NULL;
-        cpu->cpreg_vmstate_values = NULL;
     }
-    cpu->cpreg_vmstate_array_len = arraylen;
     cpu->cpreg_array_len = 0;
 
     g_hash_table_foreach(cpu->cp_regs, add_cpreg_to_list, cpu);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index eaa065d7261..555083e7aaf 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -864,12 +864,7 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
 
     cpu->cpreg_indexes = g_renew(uint64_t, cpu->cpreg_indexes, arraylen);
     cpu->cpreg_values = g_renew(uint64_t, cpu->cpreg_values, arraylen);
-    cpu->cpreg_vmstate_indexes = g_renew(uint64_t, cpu->cpreg_vmstate_indexes,
-                                         arraylen);
-    cpu->cpreg_vmstate_values = g_renew(uint64_t, cpu->cpreg_vmstate_values,
-                                        arraylen);
     cpu->cpreg_array_len = arraylen;
-    cpu->cpreg_vmstate_array_len = arraylen;
 
     for (i = 0, arraylen = 0; i < rlp->n; i++) {
         uint64_t regidx = rlp->reg[i];
diff --git a/target/arm/machine.c b/target/arm/machine.c
index bbaae344492..d3d4f2ddc15 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "trace.h"
 #include "qemu/error-report.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
@@ -984,11 +985,14 @@ static int cpu_pre_save(void *opaque)
         }
     }
 
+    /*
+     * On outbound migration, send the data in our cpreg_{values,indexes}
+     * arrays. The migration code will not allocate anything, but just
+     * reads the data pointed to by the VMSTATE_VARRAY_INT32_ALLOC() fields.
+     */
+    cpu->cpreg_vmstate_indexes = cpu->cpreg_indexes;
+    cpu->cpreg_vmstate_values = cpu->cpreg_values;
     cpu->cpreg_vmstate_array_len = cpu->cpreg_array_len;
-    memcpy(cpu->cpreg_vmstate_indexes, cpu->cpreg_indexes,
-           cpu->cpreg_array_len * sizeof(uint64_t));
-    memcpy(cpu->cpreg_vmstate_values, cpu->cpreg_values,
-           cpu->cpreg_array_len * sizeof(uint64_t));
 
     return 0;
 }
@@ -1001,6 +1005,9 @@ static int cpu_post_save(void *opaque)
         pmu_op_finish(&cpu->env);
     }
 
+    cpu->cpreg_vmstate_indexes = NULL;
+    cpu->cpreg_vmstate_values = NULL;
+
     return 0;
 }
 
@@ -1034,6 +1041,9 @@ static int cpu_pre_load(void *opaque)
         pmu_op_start(env);
     }
 
+    g_assert(!cpu->cpreg_vmstate_indexes);
+    g_assert(!cpu->cpreg_vmstate_values);
+
     return 0;
 }
 
@@ -1043,6 +1053,9 @@ static int cpu_post_load(void *opaque, int version_id)
     CPUARMState *env = &cpu->env;
     int i, v;
 
+    trace_cpu_post_load(cpu->cpreg_vmstate_array_len,
+                        cpu->cpreg_array_len);
+
     /*
      * Handle migration compatibility from old QEMU which didn't
      * send the irq-line-state subsection. A QEMU without it did not
@@ -1094,6 +1107,11 @@ static int cpu_post_load(void *opaque, int version_id)
         }
     }
 
+    g_free(cpu->cpreg_vmstate_indexes);
+    g_free(cpu->cpreg_vmstate_values);
+    cpu->cpreg_vmstate_indexes = NULL;
+    cpu->cpreg_vmstate_values = NULL;
+
     /*
      * Misaligned thumb pc is architecturally impossible. Fail the
      * incoming migration. For TCG it would trigger the assert in
@@ -1167,16 +1185,17 @@ const VMStateDescription vmstate_arm_cpu = {
         VMSTATE_UINT32_ARRAY(env.fiq_regs, ARMCPU, 5),
         VMSTATE_UINT64_ARRAY(env.elr_el, ARMCPU, 4),
         VMSTATE_UINT64_ARRAY(env.sp_el, ARMCPU, 4),
-        /* The length-check must come before the arrays to avoid
-         * incoming data possibly overflowing the array.
+        /*
+         * The length must come before the arrays so we can
+         * allocate the arrays before their data arrives
          */
-        VMSTATE_INT32_POSITIVE_LE(cpreg_vmstate_array_len, ARMCPU),
-        VMSTATE_VARRAY_INT32(cpreg_vmstate_indexes, ARMCPU,
-                             cpreg_vmstate_array_len,
-                             0, vmstate_info_uint64, uint64_t),
-        VMSTATE_VARRAY_INT32(cpreg_vmstate_values, ARMCPU,
-                             cpreg_vmstate_array_len,
-                             0, vmstate_info_uint64, uint64_t),
+        VMSTATE_INT32(cpreg_vmstate_array_len, ARMCPU),
+        VMSTATE_VARRAY_INT32_ALLOC(cpreg_vmstate_indexes, ARMCPU,
+                                   cpreg_vmstate_array_len,
+                                   0, vmstate_info_uint64, uint64_t),
+        VMSTATE_VARRAY_INT32_ALLOC(cpreg_vmstate_values, ARMCPU,
+                                   cpreg_vmstate_array_len,
+                                   0, vmstate_info_uint64, uint64_t),
         VMSTATE_UINT64(env.exclusive_addr, ARMCPU),
         VMSTATE_UINT64(env.exclusive_val, ARMCPU),
         VMSTATE_UINT64(env.exclusive_high, ARMCPU),
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index bb94eac7bf8..c5b108166ac 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -783,12 +783,6 @@ int whpx_init_vcpu(CPUState *cpu)
                                      sregs_match_len);
     arm_cpu->cpreg_values = g_renew(uint64_t, arm_cpu->cpreg_values,
                                     sregs_match_len);
-    arm_cpu->cpreg_vmstate_indexes = g_renew(uint64_t,
-                                             arm_cpu->cpreg_vmstate_indexes,
-                                             sregs_match_len);
-    arm_cpu->cpreg_vmstate_values = g_renew(uint64_t,
-                                            arm_cpu->cpreg_vmstate_values,
-                                            sregs_match_len);
 
     memset(arm_cpu->cpreg_values, 0, sregs_match_len * sizeof(uint64_t));
 
@@ -807,7 +801,6 @@ int whpx_init_vcpu(CPUState *cpu)
         }
     }
     arm_cpu->cpreg_array_len = sregs_cnt;
-    arm_cpu->cpreg_vmstate_array_len = sregs_cnt;
 
     assert(write_cpustate_to_list(arm_cpu, false));
 
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 676d29fe516..2de0406f784 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -26,3 +26,6 @@ arm_powerctl_reset_cpu(uint64_t mp_aff) "cpu %" PRIu64
 
 # tcg/psci.c and hvf/hvf.c
 arm_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid) "PSCI Call x0=0x%016"PRIx64" x1=0x%016"PRIx64" x2=0x%016"PRIx64" x3=0x%016"PRIx64" cpuid=0x%x"
+
+# machine.c
+cpu_post_load(uint32_t cpreg_vmstate_array_len, uint32_t cpreg_array_len) "cpreg_vmstate_array_len=%d cpreg_array_len=%d"
-- 
2.53.0


