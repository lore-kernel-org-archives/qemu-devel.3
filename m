Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0199C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 15:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tacwj-00051Y-GZ; Wed, 22 Jan 2025 10:47:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tacwS-0004x9-DX; Wed, 22 Jan 2025 10:46:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tacwQ-0006rT-27; Wed, 22 Jan 2025 10:46:56 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 232D95C6083;
 Wed, 22 Jan 2025 15:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B56C4CEE4;
 Wed, 22 Jan 2025 15:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737560799;
 bh=SDAM2Hf0+OjvENc78mlriwxC/2c7OGDKK+nhESUWpgE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WoQ5v/Rg8D57ii/NQ0uNW6JD9BzuQ1V4D89wzL2hK4zrO5HyCWSQef4TqC8edvJM2
 lKzhNp4d4kxEG6LYjj0QVncNjsVooYp7GNM93wh4lukvszBIjW+EIHIvemN6taSowR
 5n8Uze/3ee/XcI3LeTj/ekV+PV/kmkOI860gil1MjptMK/TisF/w2Dt1PDIAfg6N0X
 rMqTC+d91EOCD4gcP+kaobSknP6eXoc6/tsnpZlea/8RI+B/Oh11fUfix24YIBA5Np
 Tq4mwZpcM4RlkiJVUicNVoka8rFN44uuWy6wEl4g6GoIBTsQqbRpd6bgXb8wL0NADK
 mT3HoOrfAONgA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1tacw9-00000008ogg-3xHu; Wed, 22 Jan 2025 16:46:37 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] acpi/ghes: Cleanup the code which gets ghes ged state
Date: Wed, 22 Jan 2025 16:46:24 +0100
Message-ID: <200501cb372d5121c44128a79b8775e529dc46e6.1737560101.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1737560101.git.mchehab+huawei@kernel.org>
References: <cover.1737560101.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move the check logic into a common function and simplify the
code which checks if GHES is enabled and was properly setup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes-stub.c    |  4 ++--
 hw/acpi/ghes.c         | 33 +++++++++++----------------------
 include/hw/acpi/ghes.h |  9 +++++----
 target/arm/kvm.c       |  2 +-
 4 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
index 7cec1812dad9..fbabf955155a 100644
--- a/hw/acpi/ghes-stub.c
+++ b/hw/acpi/ghes-stub.c
@@ -16,7 +16,7 @@ int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
     return -1;
 }
 
-bool acpi_ghes_present(void)
+AcpiGhesState *acpi_ghes_get_state(void)
 {
-    return false;
+    return NULL;
 }
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 961fc38ea8f5..5d29db3918dd 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -420,10 +420,6 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
                                  uint64_t *cper_addr,
                                  uint64_t *read_ack_register_addr)
 {
-    if (!ghes_addr) {
-        return;
-    }
-
     /*
      * non-HEST version supports only one source, so no need to change
      * the start offset based on the source ID. Also, we can't validate
@@ -451,10 +447,6 @@ static void get_ghes_source_offsets(uint16_t source_id, uint64_t hest_addr,
     uint64_t err_source_struct, error_block_addr;
     uint32_t num_sources, i;
 
-    if (!hest_addr) {
-        return;
-    }
-
     cpu_physical_memory_read(hest_addr, &num_sources, sizeof(num_sources));
     num_sources = le32_to_cpu(num_sources);
 
@@ -513,7 +505,6 @@ void ghes_record_cper_errors(const void *cper, size_t len,
                              uint16_t source_id, Error **errp)
 {
     uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
-    AcpiGedState *acpi_ged_state;
     AcpiGhesState *ags;
 
     if (len > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
@@ -521,13 +512,10 @@ void ghes_record_cper_errors(const void *cper, size_t len,
         return;
     }
 
-    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
-                                                       NULL));
-    if (!acpi_ged_state) {
-        error_setg(errp, "Can't find ACPI_GED object");
+    ags = acpi_ghes_get_state();
+    if (!ags) {
         return;
     }
-    ags = &acpi_ged_state->ghes_state;
 
     if (!ags->hest_lookup) {
         get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
@@ -537,11 +525,6 @@ void ghes_record_cper_errors(const void *cper, size_t len,
                                 &cper_addr, &read_ack_register_addr, errp);
     }
 
-    if (!cper_addr) {
-        error_setg(errp, "can not find Generic Error Status Block");
-        return;
-    }
-
     cpu_physical_memory_read(read_ack_register_addr,
                              &read_ack_register, sizeof(read_ack_register));
 
@@ -605,7 +588,7 @@ int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
     return 0;
 }
 
-bool acpi_ghes_present(void)
+AcpiGhesState *acpi_ghes_get_state(void)
 {
     AcpiGedState *acpi_ged_state;
     AcpiGhesState *ags;
@@ -614,8 +597,14 @@ bool acpi_ghes_present(void)
                                                        NULL));
 
     if (!acpi_ged_state) {
-        return false;
+        return NULL;
     }
     ags = &acpi_ged_state->ghes_state;
-    return ags->present;
+    if (!ags->present) {
+        return NULL;
+    }
+    if (!ags->hw_error_le && !ags->hest_addr_le) {
+        return NULL;
+    }
+    return ags;
 }
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 2e8405edfe27..64fe2b5bea65 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -91,10 +91,11 @@ void ghes_record_cper_errors(const void *cper, size_t len,
                              uint16_t source_id, Error **errp);
 
 /**
- * acpi_ghes_present: Report whether ACPI GHES table is present
+ * acpi_ghes_get_state: Get a pointer for ACPI ghes state
  *
- * Returns: true if the system has an ACPI GHES table and it is
- * safe to call acpi_ghes_memory_errors() to record a memory error.
+ * Returns: a pointer to ghes state if the system has an ACPI GHES table,
+ * it is enabled and it is safe to call acpi_ghes_memory_errors() to record
+ * a memory error. Returns false, otherwise.
  */
-bool acpi_ghes_present(void);
+AcpiGhesState *acpi_ghes_get_state(void);
 #endif
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index da30bdbb2349..0283089713b9 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2369,7 +2369,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
 
     assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
 
-    if (acpi_ghes_present() && addr) {
+    if (acpi_ghes_get_state() && addr) {
         ram_addr = qemu_ram_addr_from_host(addr);
         if (ram_addr != RAM_ADDR_INVALID &&
             kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
-- 
2.48.1


