Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E4DCD342D
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 17:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJEdC-0006WN-ID; Wed, 12 Nov 2025 12:27:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vJEcq-0005gZ-Qw
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 12:27:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vJEco-00008x-UY
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 12:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762968438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sRH6WvKIOLV1t+w1QeJew958DbYgl8cdX+R9ufIFR0c=;
 b=HJaE3VBWszmzkYg3hKs4gyrYZYy/N/LyVLkqbSaeMTVy9/eQNUGJ3uyjB5yN8+BDYyUJp+
 dJhCoZnZGuxIRZWABeIiPCmZ1ekHWE0nun64glnE1vqRNJxv72bnlNVv0sb1WV9UG5gjao
 6aV1tqDZlQYxCdcTcguIklypp2UlrQ0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-boNtZXG7OX-0yTDAytemJA-1; Wed,
 12 Nov 2025 12:27:14 -0500
X-MC-Unique: boNtZXG7OX-0yTDAytemJA-1
X-Mimecast-MFC-AGG-ID: boNtZXG7OX-0yTDAytemJA_1762968433
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D79C019560B2; Wed, 12 Nov 2025 17:27:12 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.14])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F12AE1955F1A; Wed, 12 Nov 2025 17:27:04 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 imammedo@redhat.com, armbru@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v4 8/8] target/arm/kvm: Support multiple memory CPERs injection
Date: Thu, 13 Nov 2025 03:25:35 +1000
Message-ID: <20251112172535.403042-9-gshan@redhat.com>
In-Reply-To: <20251112172535.403042-1-gshan@redhat.com>
References: <20251112172535.403042-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

In the combination of 64KiB host and 4KiB guest, a problematic host
page affects 16x guest pages that can be owned by different threads.
It means 16x memory errors can be raised at once due to the parallel
accesses to those 16x guest pages on the guest. Unfortunately, QEMU
can't deliver them one by one because we just have one GHES error block,
corresponding to one read acknowledgement register. It can eventually
cause QEMU crash dump due to the contention on that register, meaning
the current memory error can't be delivered before the previous error
isn't acknowledged.

Move the logics of sending ACPI GHES memory errors and injects SEA
exception to a newly added helper push_ghes_memory_errors(). Improve
push_ghes_memory_errors() to push 16x consecutive memory errors if
needed to avoid the contention on the read acknowledgement register,
thus the exceptional termination on QEMU.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 target/arm/kvm.c | 70 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 6 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b8c3ad2ad9..3da97664eb 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include <sys/ioctl.h>
 
 #include <linux/kvm.h>
@@ -2429,12 +2430,73 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     return ret;
 }
 
+static bool push_ghes_memory_errors(CPUState *c, AcpiGhesState *ags,
+                                    uint64_t paddr, Error **errp)
+{
+    uint64_t val, start, end, guest_pgsz, host_pgsz;
+    uint64_t addresses[16];
+    uint32_t num_of_addresses;
+    int err;
+    bool ret;
+
+    /*
+     * Sort out the guest page size from TCR_EL1, which can be modified
+     * by the guest from time to time. So we have to sort it out dynamically.
+     */
+    err = read_sys_reg64(c->kvm_fd, &val, ARM64_SYS_REG(3, 0, 2, 0, 2));
+    if (err) {
+        error_setg(errp, "Error %" PRId32 " to read TCR_EL1 register", err);
+        return false;
+    }
+
+    switch (extract64(val, 14, 2)) {
+    case 0:
+        guest_pgsz = 4 * KiB;
+        break;
+    case 1:
+        guest_pgsz = 64 * KiB;
+        break;
+    case 2:
+        guest_pgsz = 16 * KiB;
+        break;
+    default:
+        error_setg(errp, "Unknown page size from TCR_EL1 (0x%" PRIx64 ")", val);
+        return false;
+    }
+
+    host_pgsz = qemu_real_host_page_size();
+    start = paddr & ~(host_pgsz - 1);
+    end = start + host_pgsz;
+    num_of_addresses = 0;
+
+    while (start < end) {
+        /*
+         * The precise physical address is provided for the affected
+         * guest page that contains @paddr. Otherwise, the starting
+         * address of the guest page is provided.
+         */
+        if (paddr >= start && paddr < (start + guest_pgsz)) {
+            addresses[num_of_addresses++] = paddr;
+        } else {
+            addresses[num_of_addresses++] = start;
+        }
+
+        start += guest_pgsz;
+    }
+
+    kvm_cpu_synchronize_state(c);
+    ret = acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
+                                  addresses, num_of_addresses, errp);
+    kvm_inject_arm_sea(c);
+
+    return ret;
+}
+
 void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
 {
     ram_addr_t ram_addr;
     hwaddr paddr;
     AcpiGhesState *ags;
-    uint64_t addresses[16];
 
     assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
 
@@ -2455,12 +2517,8 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
              * later from the main thread, so doing the injection of
              * the error would be more complicated.
              */
-            addresses[0] = paddr;
             if (code == BUS_MCEERR_AR) {
-                kvm_cpu_synchronize_state(c);
-                acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
-                                        addresses, 1, &error_fatal);
-                kvm_inject_arm_sea(c);
+                push_ghes_memory_errors(c, ags, paddr, &error_fatal);
             }
             return;
         }
-- 
2.51.1


