Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F60CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 06:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v60sd-0003Yf-FJ; Tue, 07 Oct 2025 02:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1v60sb-0003Xv-4m
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 02:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1v60sZ-0005nS-9e
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 02:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759817327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FguozCBKeoOdAW9m6oAdXIJUCJ82FAHXhKW1Qjiutv8=;
 b=DQR23+/86kBZ9hSOkxKVjQ1bqDYUfKZyjKLh5wgCE97mp0LKJ2y1UrfnxOaIRtty9TykwG
 Xu5R/2l7LRISU5G+n9E2CwCVhtcE8LhfsAuD5zJHmRLXpsTm3bCZ8/gqFIodathVkOjTBx
 Ce8fT4RBxicIkYGQkdPhvJTtI97fyi0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-rb9jrtNuOn6h02YJGoiSUQ-1; Tue,
 07 Oct 2025 02:08:43 -0400
X-MC-Unique: rb9jrtNuOn6h02YJGoiSUQ-1
X-Mimecast-MFC-AGG-ID: rb9jrtNuOn6h02YJGoiSUQ_1759817322
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 066E91800286; Tue,  7 Oct 2025 06:08:42 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC1EC1800576; Tue,  7 Oct 2025 06:08:36 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, mchehab+huawei@kernel.org,
 Jonathan.Cameron@huawei.com, shan.gavin@gmail.com
Subject: [PATCH RESEND v2 3/3] target/arm/kvm: Support multiple memory CPERs
 injection
Date: Tue,  7 Oct 2025 16:08:10 +1000
Message-ID: <20251007060810.258536-4-gshan@redhat.com>
In-Reply-To: <20251007060810.258536-1-gshan@redhat.com>
References: <20251007060810.258536-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
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
index 045b77715f..5c87b3a027 100644
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
index c5d5b3b16e..3ecb85e4b7 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include <sys/ioctl.h>
 
 #include <linux/kvm.h>
@@ -2433,10 +2434,53 @@ static void push_ghes_memory_errors(CPUState *c, AcpiGhesState *ags,
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
2.51.0


