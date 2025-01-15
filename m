Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13C7C02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 12:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY2sD-0008EA-7x; Wed, 15 Jan 2025 07:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tY2rQ-0007ee-B1; Wed, 15 Jan 2025 07:51:06 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tY2rM-0006sO-M9; Wed, 15 Jan 2025 07:51:02 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 11BCCA41F4A;
 Wed, 15 Jan 2025 12:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B003C4CEEB;
 Wed, 15 Jan 2025 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736945441;
 bh=C2mXxM1hfVaEkYu3ugfE5aqpQfBVVNOvxF5g2WH4gn8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mBQvI+xInCbMm+72IfLG8Rqly+cLgd+C5hMom/9J3G69fr00xiaZWb7xqjk56jMRv
 jbpiYBJoBzbjCVTr3Pxjb+b1zPr7/j/XpH5VH/nTp26b2RrHYQtknBVxQWj0izEA6M
 3YhOV3G0rqgvUG9N64ztgb31oSwQurMWO1lngOgKKJ7taWrI6DPRwPG+1yPU/OG2FK
 Scg49oHmBrjJIqVamK0+rWlpAVbWUvdzQYZXaWK2HSQK4mAxeSWfRXU/ivoJEI8Hb6
 Ii8XQcpCBv8abyeStQwCHrTjRxEbBxj7/YNzRhx4388AM94yfs2sQxOPp0mMX28XFT
 yqxj+InBPjFrg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1tY2r1-00000004yG2-1CGN; Wed, 15 Jan 2025 13:50:39 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v7 10/16] acpi/ghes: better name GHES memory error function
Date: Wed, 15 Jan 2025 13:50:26 +0100
Message-ID: <35b59121129d5e99cb5062cc3d775594bbb0905b.1736945236.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736945236.git.mchehab+huawei@kernel.org>
References: <cover.1736945236.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

The current function used to generate GHES data is specific for
memory errors. Give a better name for it, as we now have a generic
function as well.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes-stub.c    | 2 +-
 hw/acpi/ghes.c         | 2 +-
 include/hw/acpi/ghes.h | 4 ++--
 target/arm/kvm.c       | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
index 2b64cbd2819a..7cec1812dad9 100644
--- a/hw/acpi/ghes-stub.c
+++ b/hw/acpi/ghes-stub.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/ghes.h"
 
-int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
+int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
 {
     return -1;
 }
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 6f40cd35a94f..66bd98337ac7 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -415,7 +415,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     return;
 }
 
-int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
+int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
 {
     /* Memory Error Section Type */
     const uint8_t guid[] =
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 8859346af51a..21666a4bcc8b 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -74,15 +74,15 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
+int acpi_ghes_memory_errors(uint16_t source_id, uint64_t error_physical_addr);
 void ghes_record_cper_errors(const void *cper, size_t len,
                              uint16_t source_id, Error **errp);
-int acpi_ghes_record_errors(uint16_t source_id, uint64_t error_physical_addr);
 
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
  *
  * Returns: true if the system has an ACPI GHES table and it is
- * safe to call acpi_ghes_record_errors() to record a memory error.
+ * safe to call acpi_ghes_memory_errors() to record a memory error.
  */
 bool acpi_ghes_present(void);
 #endif
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index a9444a2c7a86..da30bdbb2349 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2387,7 +2387,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
              */
             if (code == BUS_MCEERR_AR) {
                 kvm_cpu_synchronize_state(c);
-                if (!acpi_ghes_record_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
+                if (!acpi_ghes_memory_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
                     kvm_inject_arm_sea(c);
                 } else {
                     error_report("failed to record the error");
-- 
2.47.1


