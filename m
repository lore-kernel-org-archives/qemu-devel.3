Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DECFC591C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYD0-0003Xd-5v; Thu, 26 Feb 2026 05:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vvYCs-0003WQ-9K
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:02:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vvYCq-0000YJ-Nf
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:02:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772100172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u9Y0uHcGY2M9/Y7Y8tPz+t9U4uOAS3MeY40EsxfBOwI=;
 b=bbqrWZnNwzaevYu8fa6FP+WHMKkuyh8hyG80EmOPTURRxGh9bQvcAYm5sbvg0kVH2Lnshd
 KVLPIPkAu/CpVbHiJPfVvSMCxJhDFhBe5I3bHzYK0HouDscxZysjJLMZCrCJzs3NdsYk5n
 zM2Q8s02o38ydtEq0m8DlPpiyghniMA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-63pCFaxbOSGqbIZxsD0THw-1; Thu,
 26 Feb 2026 05:02:47 -0500
X-MC-Unique: 63pCFaxbOSGqbIZxsD0THw-1
X-Mimecast-MFC-AGG-ID: 63pCFaxbOSGqbIZxsD0THw_1772100166
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CB8C19560A6; Thu, 26 Feb 2026 10:02:46 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.35.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 91D951800370; Thu, 26 Feb 2026 10:02:43 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH 2/5] target/arm/machine: Use VMSTATE_VARRAY_INT32_ALLOC for
 cpreg arrays
Date: Thu, 26 Feb 2026 11:01:30 +0100
Message-ID: <20260226100232.500781-3-eric.auger@redhat.com>
In-Reply-To: <20260226100232.500781-1-eric.auger@redhat.com>
References: <20260226100232.500781-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 target/arm/helper.c     |  5 -----
 target/arm/kvm.c        |  5 -----
 target/arm/machine.c    | 24 +++++++++++++-----------
 target/arm/trace-events |  3 +++
 4 files changed, 16 insertions(+), 21 deletions(-)

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
index ded582e0da0..12a75f42e07 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -807,12 +807,7 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
 
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
index bbaae344492..214087111bc 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "trace.h"
 #include "qemu/error-report.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
@@ -984,11 +985,9 @@ static int cpu_pre_save(void *opaque)
         }
     }
 
+    cpu->cpreg_vmstate_indexes = cpu->cpreg_indexes;
+    cpu->cpreg_vmstate_values = cpu->cpreg_values;
     cpu->cpreg_vmstate_array_len = cpu->cpreg_array_len;
-    memcpy(cpu->cpreg_vmstate_indexes, cpu->cpreg_indexes,
-           cpu->cpreg_array_len * sizeof(uint64_t));
-    memcpy(cpu->cpreg_vmstate_values, cpu->cpreg_values,
-           cpu->cpreg_array_len * sizeof(uint64_t));
 
     return 0;
 }
@@ -1043,6 +1042,9 @@ static int cpu_post_load(void *opaque, int version_id)
     CPUARMState *env = &cpu->env;
     int i, v;
 
+    trace_cpu_post_load(cpu->cpreg_vmstate_array_len,
+                        cpu->cpreg_array_len);
+
     /*
      * Handle migration compatibility from old QEMU which didn't
      * send the irq-line-state subsection. A QEMU without it did not
@@ -1170,13 +1172,13 @@ const VMStateDescription vmstate_arm_cpu = {
         /* The length-check must come before the arrays to avoid
          * incoming data possibly overflowing the array.
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


