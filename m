Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EC8CCFA05
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 11:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGbzL-0006wP-8F; Wed, 05 Nov 2025 06:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vGbyb-00064u-Tf
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 06:47:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vGbyZ-00047C-AI
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 06:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762343214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=29LUfHiShuavtJENtMDfqPVZdMKOAjQ5KT9Nqx8YzVU=;
 b=YipcYHaeo9WYTBPl7dXxGvjcaYifYogXoWg4ySbiMkFxIqRYQk44kC95V9AeeeEthFFy5O
 JuOq/cv9RLjW/NdxOJDWswucUziWZiPifNPZxGp5Fjzew0FX99La+Qar8gHwfrWrtBXRC+
 sR9k13Cl8yf3x+Soq7QhdkYzEbyt6RY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-JHugRRm5P_qQes0t7qSjWg-1; Wed,
 05 Nov 2025 06:46:51 -0500
X-MC-Unique: JHugRRm5P_qQes0t7qSjWg-1
X-Mimecast-MFC-AGG-ID: JHugRRm5P_qQes0t7qSjWg_1762343209
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2A1719560B7; Wed,  5 Nov 2025 11:46:49 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8B641800451; Wed,  5 Nov 2025 11:46:44 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v3 8/8] target/arm/kvm: Support multiple memory CPERs injection
Date: Wed,  5 Nov 2025 21:44:53 +1000
Message-ID: <20251105114453.2164073-9-gshan@redhat.com>
In-Reply-To: <20251105114453.2164073-1-gshan@redhat.com>
References: <20251105114453.2164073-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
can't deliver them one by one because we just one GHES error block,
corresponding one read acknowledgement register. It can eventually
cause QEMU crash dump due to the contention on that register, meaning
the current memory error can't be delivered before the previous error
isn't acknowledged.

Imporve push_ghes_memory_errors() to push 16x consecutive memory errors
under this situation to avoid the contention on the read acknowledgement
register.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 target/arm/kvm.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 5b151eda3c..d7de8262da 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include <sys/ioctl.h>
 
 #include <linux/kvm.h>
@@ -2432,12 +2433,59 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
 static void push_ghes_memory_errors(CPUState *c, AcpiGhesState *ags,
                                     uint64_t paddr, Error **errp)
 {
+    uint64_t val, start, end, guest_pgsz, host_pgsz;
     uint64_t addresses[16];
+    uint32_t num_of_addresses;
+    int ret;
+
+    /*
+     * Sort out the guest page size from TCR_EL1, which can be modified
+     * by the guest from time to time. So we have to sort it out dynamically.
+     */
+    ret = read_sys_reg64(c->kvm_fd, &val, ARM64_SYS_REG(3, 0, 2, 0, 2));
+    if (ret) {
+        error_setg(errp, "Error %" PRId32 " to read TCR_EL1 register", ret);
+        return;
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
+        return;
+    }
+
+    host_pgsz = qemu_real_host_page_size();
+    start = paddr & ~(host_pgsz - 1);
+    end = start + host_pgsz;
+    num_of_addresses = 0;
 
-    addresses[0] = paddr;
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
 
     kvm_cpu_synchronize_state(c);
-    acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC, addresses, 1, errp);
+    acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
+                            addresses, num_of_addresses, errp);
     kvm_inject_arm_sea(c);
 }
 
-- 
2.51.0


