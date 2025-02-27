Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516E9C1B087
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 11:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbhC-0005Or-7E; Thu, 27 Feb 2025 06:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tnbgU-0004lY-FN; Thu, 27 Feb 2025 06:04:07 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tnbgR-0007Sn-Gq; Thu, 27 Feb 2025 06:04:06 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 872B85C49F4;
 Thu, 27 Feb 2025 11:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02597C4CEEF;
 Thu, 27 Feb 2025 11:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740654238;
 bh=XYmCAO03K7PjNg3F4YvDIfzrnLiWeCjqMYdceVKe+TU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TXqmDteaKPPHQ5FJ1CsXZ3js5G/Rn3n9BKvPS0epJ6FK+/vdCY7FoxkclCdvOb3LI
 vDAsaTNd5vo2Eg5s9mBVV5t1CCP3w1hvFOWx5h2/RnpgrYoVFxsiaoLRa5oMmmCgLX
 92J+Kksz5rxbagXq3Ulu7No5PveZvXBExTnzz68niRE70MDMae/U374De9L9DpXXGd
 19PUmmJC3EjxqxAAuzPbXJ69rKCjGaNfMxodv6I+aKf9hx/fPRoR+R3KAe65U9yTN/
 aaYbulm+TGxjmqxWBLKcOxCu+/0iiArkVuqjUFKs9jLXavuhrv6WImbERLvDzaoHb3
 RMP/0fIGJ3CTg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1tnbgK-00000001mQu-0gLI; Thu, 27 Feb 2025 12:03:56 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/21] acpi/ghes: add a firmware file with HEST address
Date: Thu, 27 Feb 2025 12:03:36 +0100
Message-ID: <ce0db0a85f31a58c44e25198f0ef3614c717cb07.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -74
X-Spam_score: -7.5
X-Spam_bar: -------
X-Spam_report: (-7.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

Store HEST table address at GPA, placing its the start of the table at
hest_addr_le variable.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/ghes.c         | 20 +++++++++++++++++++-
 include/hw/acpi/ghes.h |  7 ++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 9243b5ad4acb..8ec423726b3f 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -30,6 +30,7 @@
 
 #define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
 #define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
+#define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
 
 /* The max size in bytes for one error block */
 #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
@@ -341,6 +342,9 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
 {
     AcpiTable table = { .sig = "HEST", .rev = 1,
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
+    uint32_t hest_offset;
+
+    hest_offset = table_data->len;
 
     build_ghes_error_table(ags, hardware_errors, linker);
 
@@ -352,6 +356,17 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
                   ACPI_GHES_NOTIFY_SEA, ACPI_HEST_SRC_ID_SEA);
 
     acpi_table_end(linker, &table);
+
+    if (ags->use_hest_addr) {
+        /*
+         * Tell firmware to write into GPA the address of HEST via fw_cfg,
+         * once initialized.
+         */
+        bios_linker_loader_write_pointer(linker,
+                                         ACPI_HEST_ADDR_FW_CFG_FILE, 0,
+                                         sizeof(uint64_t),
+                                         ACPI_BUILD_TABLE_FILE, hest_offset);
+    }
 }
 
 void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
@@ -361,7 +376,10 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
                     hardware_error->len);
 
-    if (!ags->use_hest_addr) {
+    if (ags->use_hest_addr) {
+        fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
+            NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
+    } else {
         /* Create a read-write fw_cfg file for Address */
         fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
             NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 5000891f163f..38abe6e3db52 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -70,9 +70,14 @@ enum {
  * When use_hest_addr is false, the GPA of the etc/hardware_errors firmware
  * is stored at hw_error_le. This is the default on QEMU 9.x.
  *
- * An GPA value equal to zero means that GHES is not present.
+ * When use_hest_addr is true, the stored offset is placed at hest_addr_le,
+ * meaning an offset from the HEST table address from etc/acpi/tables firmware.
+ * This is the default for QEMU 10.x and above.
+ *
+ * Whe both GPA values are equal to zero means that GHES is not present.
  */
 typedef struct AcpiGhesState {
+    uint64_t hest_addr_le;
     uint64_t hw_error_le;
     bool use_hest_addr;         /* Currently, always false */
 } AcpiGhesState;
-- 
2.48.1


