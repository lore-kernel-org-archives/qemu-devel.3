Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCC0C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDmy-0002Zr-Qf; Wed, 28 May 2025 06:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1uKDmx-0002Zj-8P
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:13:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1uKDay-0006SW-Pt
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748426472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dxkn4qLxCfduF+Ckn9JcjV37FeKi59jt7wAnZKjHoMM=;
 b=IUj/u1E2uRG6NWGgDsHlPw175P0ESK5/ziLHPJ++r0ta0G5Q/7xEKesKf5F4sPW/rzEIi5
 SInNmzq3szYLkVsOWh5bjIxEOaZbE5iDJv3l+mw04pH1YX9SHmhSuLD3vb9N6b9cCpt5uy
 9NWdOH65tkjrDEzVeaISd94pI2Id+Tw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-2Zthm1B9P2OxX2rA2hXFdQ-1; Wed,
 28 May 2025 06:01:08 -0400
X-MC-Unique: 2Zthm1B9P2OxX2rA2hXFdQ-1
X-Mimecast-MFC-AGG-ID: 2Zthm1B9P2OxX2rA2hXFdQ_1748426467
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3ECA4180098D; Wed, 28 May 2025 10:01:07 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.65])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C873919560AF; Wed, 28 May 2025 10:01:01 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com,
 mchehab+huawei@kernel.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v2 3/3] target/arm/kvm: Support multiple memory CPERs injection
Date: Wed, 28 May 2025 20:00:33 +1000
Message-ID: <20250528100033.159576-4-gshan@redhat.com>
In-Reply-To: <20250528100033.159576-1-gshan@redhat.com>
References: <20250528100033.159576-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In the combination of 64KB host and 4KB guest, a problematic host page
affects 16x guest pages. In this specific case, it's reasonable to
push 16 consecutive memory CPERs. Otherwise, QEMU can run into core
dump due to the current error can't be delivered as the previous error
isn't acknoledges. It's caused by the nature the host page can be
accessed in parallel due to the mismatched host and guest page sizes.

Imporve push_ghes_memory_errors() to push 16x consecutive memory CPERs
for this specific case. The maximal error block size is bumped to 4KB,
providing enough storage space for those 16x memory CPERs.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 hw/acpi/ghes.c   |  2 +-
 target/arm/kvm.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 34ff682048..43d52f5e2e 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -33,7 +33,7 @@
 #define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
 
 /* The max size in bytes for one error block */
-#define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
+#define ACPI_GHES_MAX_RAW_DATA_LENGTH   (4 * KiB)
 
 /* Generic Hardware Error Source version 2 */
 #define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index e31fcde797..c346bd7b49 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include <sys/ioctl.h>
 
 #include <linux/kvm.h>
@@ -2337,10 +2338,53 @@ static void push_ghes_memory_errors(CPUState *c, AcpiGhesState *ags,
                                     uint64_t paddr)
 {
     GArray *addresses = g_array_new(false, false, sizeof(paddr));
+    uint64_t val, start, end, guest_pgsz, host_pgsz;
     int ret;
 
     kvm_cpu_synchronize_state(c);
-    g_array_append_vals(addresses, &paddr, 1);
+
+    /*
+     * Sort out the guest page size from TCR_EL1, which can be modified
+     * by the guest from time to time. So we have to sort it out dynamically.
+     */
+    ret = read_sys_reg64(c->kvm_fd, &val, ARM64_SYS_REG(3, 0, 2, 0, 2));
+    if (ret) {
+        goto error;
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
+        error_report("unknown page size from TCR_EL1 (0x%" PRIx64 ")", val);
+        goto error;
+    }
+
+    host_pgsz = qemu_real_host_page_size();
+    start = paddr & ~(host_pgsz - 1);
+    end = start + host_pgsz;
+    while (start < end) {
+        /*
+         * The precise physical address is provided for the affected
+         * guest page that contains @paddr. Otherwise, the starting
+         * address of the guest page is provided.
+         */
+        if (paddr >= start && paddr < (start + guest_pgsz)) {
+            g_array_append_vals(addresses, &paddr, 1);
+        } else {
+            g_array_append_vals(addresses, &start, 1);
+        }
+
+        start += guest_pgsz;
+    }
+
     ret = acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC, addresses);
     if (ret) {
         goto error;
-- 
2.49.0


