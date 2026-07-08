Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC97C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 06:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whLWx-0001qx-79; Wed, 08 Jul 2026 02:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1whLWq-0001o9-Gs
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 02:13:04 -0400
Received: from out-177.mta1.migadu.com ([2001:41d0:203:375::b1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1whLWo-0005vU-ND
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 02:13:04 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1783491180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nbhZAdbxxI1/a4pn8N1gZliVnKCnUpBEdqiligF4ubY=;
 b=PvBoRSaPlwNC1Irbwu+t3S/2h21PyxY1OqwMISIaIr1BLYNNCyFTyePO+mnWRnFBwkylbA
 2Xw5rg1ywvVnBingBeib0YyN1YPAXW9J6zjEN9sclrHN1JjAfYbYnCeZF74gBoWMLV8ymR
 VihuFyV92MesDiw2KLTZpOlj299N3uY=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 kvm@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v1 2/2] accel/kvm: emit KVM_VCPU_ERROR on unrecoverable vCPU
 exits
Date: Wed,  8 Jul 2026 14:12:20 +0800
Message-ID: <20260708061220.53507-3-cui.tao@linux.dev>
In-Reply-To: <20260708061220.53507-1-cui.tao@linux.dev>
References: <20260708061220.53507-1-cui.tao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::b1;
 envelope-from=cui.tao@linux.dev; helo=out-177.mta1.migadu.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_SBL_CSS=3.335,
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

From: Tao Cui <cuitao@kylinos.cn>

Emit the KVM_VCPU_ERROR event at the three points where a vCPU run
becomes unrecoverable:

  - KVM_RUN ioctl failure           (reason "ioctl-failed")
  - KVM_EXIT_UNKNOWN                (reason "unknown")
  - KVM_EXIT_INTERNAL_ERROR         (reason "internal-error",
                                     with suberror and exit-data)

The KVM_RUN loop in kvm_cpu_exec() runs without the BQL, but QMP event
emission goes through the monitor and requires it; take and release the
lock around the send, mirroring the KVM_SYSTEM_EVENT_CRASH path.

This resolves the long-standing FIXME in kvm_handle_internal_error().

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 accel/kvm/kvm-all.c | 46 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 5d55cb45cf..4f68e3b82b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -46,6 +46,7 @@
 #include "qapi/visitor.h"
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-visit-common.h"
+#include "qapi/qapi-events-run-state.h"
 #include "system/reset.h"
 #include "qemu/guest-random.h"
 #include "system/hw_accel.h"
@@ -3140,6 +3141,38 @@ static void kvm_handle_io(uint16_t port, MemTxAttrs attrs, void *data, int direc
     }
 }
 
+/*
+ * Notify the management layer that a vCPU hit an unrecoverable KVM run
+ * error.  The KVM_RUN loop in kvm_cpu_exec() runs without the BQL, but
+ * emitting a QMP event goes through the monitor and therefore requires
+ * it; take/release the lock around the send.
+ */
+static void kvm_emit_vcpu_error(CPUState *cpu, KvmVcpuErrorReason reason,
+                                bool has_suberror, int64_t suberror,
+                                uint32_t ndata, const uint64_t *data)
+{
+    g_autofree char *qom_path = object_get_canonical_path(OBJECT(cpu));
+    uint64List *exit_data = NULL;
+    uint64List **tail = &exit_data;
+    uint32_t i;
+
+    for (i = 0; i < ndata; i++) {
+        uint64List *node = g_new(uint64List, 1);
+        node->value = data[i];
+        node->next = NULL;
+        *tail = node;
+        tail = &node->next;
+    }
+
+    bql_lock();
+    qapi_event_send_kvm_vcpu_error(cpu->cpu_index, qom_path, reason,
+                                   has_suberror, suberror,
+                                   !!ndata, exit_data);
+    bql_unlock();
+
+    qapi_free_uint64List(exit_data);
+}
+
 static int kvm_handle_internal_error(CPUState *cpu, struct kvm_run *run)
 {
     int i;
@@ -3151,6 +3184,12 @@ static int kvm_handle_internal_error(CPUState *cpu, struct kvm_run *run)
         fprintf(stderr, "extra data[%d]: 0x%016"PRIx64"\n",
                 i, (uint64_t)run->internal.data[i]);
     }
+
+    kvm_emit_vcpu_error(cpu, KVM_VCPU_ERROR_REASON_INTERNAL_ERROR,
+                        true, run->internal.suberror,
+                        run->internal.ndata,
+                        (const uint64_t *)run->internal.data);
+
     if (run->internal.suberror == KVM_INTERNAL_ERROR_EMULATION) {
         fprintf(stderr, "emulation failure\n");
         if (!kvm_arch_stop_on_emulation_error(cpu)) {
@@ -3158,9 +3197,6 @@ static int kvm_handle_internal_error(CPUState *cpu, struct kvm_run *run)
             return EXCP_INTERRUPT;
         }
     }
-    /* FIXME: Should trigger a qmp message to let management know
-     * something went wrong.
-     */
     return -1;
 }
 
@@ -3508,6 +3544,8 @@ int kvm_cpu_exec(CPUState *cpu)
                             "secondary threads offline.\n");
                 }
 #endif
+                kvm_emit_vcpu_error(cpu, KVM_VCPU_ERROR_REASON_IOCTL_FAILED,
+                                    false, 0, 0, NULL);
                 ret = -1;
                 break;
             }
@@ -3543,6 +3581,8 @@ int kvm_cpu_exec(CPUState *cpu)
         case KVM_EXIT_UNKNOWN:
             fprintf(stderr, "KVM: unknown exit, hardware reason %" PRIx64 "\n",
                     (uint64_t)run->hw.hardware_exit_reason);
+            kvm_emit_vcpu_error(cpu, KVM_VCPU_ERROR_REASON_UNKNOWN,
+                                false, 0, 0, NULL);
             ret = -1;
             break;
         case KVM_EXIT_INTERNAL_ERROR:
-- 
2.43.0


