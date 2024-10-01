Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665C4CEACD5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveAn-00047R-3b; Tue, 01 Oct 2024 10:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab@kernel.org>)
 id 1sveA7-000327-Ku; Tue, 01 Oct 2024 10:47:42 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab@kernel.org>)
 id 1sveA4-0004VG-JM; Tue, 01 Oct 2024 10:47:39 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 417695C5491;
 Tue,  1 Oct 2024 07:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1BFC4CEDA;
 Tue,  1 Oct 2024 07:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727766252;
 bh=+WtTbHUT4iomth9t7xJ9WDT5mR2fPZd0bO/qGgVR9tM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HgmzsIvm5QyXVzHLRaeBRKGpkQJrMe/MLnxCciIFIsBApB3e3K7ZHsbmocw3fuanZ
 etV4wAB0vARrPBdx+eMRIDhivDKJmw76U0c1+qZ3dkpIhqhKZ0yvNW6/UENFUBszb5
 NeNobPOuTFA9uQMoCMJEIz2EvuO2g2CzlbHScQ6mqT4uwBMchJxP+DzdZ8HX4VDtkY
 f/lXr10EJJRtuWg1GXhE45SAgRJ7QSRCvvIt6B4MTQ5f3KoTZU9SnH8nY7kYJ2GqXK
 Ftuo09HWmVwcy4ryIIIgyXBFIya3rl4BQI2LeCqUS6fOP3G/5kkp+ur3LoynoJ3gzh
 rJeKufAR9GLVQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab@kernel.org>) id 1svWvY-00000001V10-2ucP;
 Tue, 01 Oct 2024 09:04:08 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 10/15] acpi/ghes: move offset calculus to a separate
 function
Date: Tue,  1 Oct 2024 09:03:47 +0200
Message-ID: <84226f5976fd29e23ce47d3a5cd311821c8111f8.1727766088.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1727766088.git.mchehab+huawei@kernel.org>
References: <cover.1727766088.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Currently, CPER address location is calculated as an offset of
the hardware_errors table. It is also badly named, as the
offset actually used is the address where the CPER data starts,
and not the beginning of the error source.

Move the logic which calculates such offset to a separate
function, in preparation for a patch that will be changing the
logic to calculate it from the HEST table.

While here, properly name the variable which stores the cper
address.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/acpi/ghes.c | 50 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 628fa9b22f4b..900f1571bc97 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -378,11 +378,36 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     ags->present = true;
 }
 
+static void get_ghes_offsets(uint64_t ghes_addr,
+                             uint64_t *cper_addr,
+                             uint64_t *read_ack_register_addr)
+{
+    if (!ghes_addr) {
+        return;
+    }
+
+    /*
+     * non-HEST version supports only one source, so no need to change
+     * the start offset based on the source ID. Also, we can't validate
+     * the source ID, as it is stored inside the HEST table.
+     */
+
+    cpu_physical_memory_read(ghes_addr, cper_addr,
+                             sizeof(*cper_addr));
+
+    *cper_addr = le64_to_cpu(*cper_addr);
+
+    /*
+     * As the current version supports only one source, the ack offset is
+     * just sizeof(uint64_t).
+     */
+    *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
+}
+
 void ghes_record_cper_errors(const void *cper, size_t len,
                              uint16_t source_id, Error **errp)
 {
-    uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
-    uint64_t start_addr;
+    uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
     AcpiGedState *acpi_ged_state;
     AcpiGhesState *ags;
 
@@ -396,27 +421,14 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     g_assert(acpi_ged_state);
     ags = &acpi_ged_state->ghes_state;
 
-    /*
-     * Current version supports only one source, as assured during table build,
-     * so no need to change the start offset based on the source ID.
-     */
-    start_addr = le64_to_cpu(ags->ghes_addr_le);
+    get_ghes_offsets(le64_to_cpu(ags->ghes_addr_le),
+                     &cper_addr, &read_ack_register_addr);
 
-    cpu_physical_memory_read(start_addr, &error_block_addr,
-                             sizeof(error_block_addr));
-
-    error_block_addr = le64_to_cpu(error_block_addr);
-    if (!error_block_addr) {
+    if (!cper_addr) {
         error_setg(errp, "can not find Generic Error Status Block");
         return;
     }
 
-    /*
-     * As the current version supports only one source, the ack offset is
-     * just sizeof(uint64_t).
-     */
-    read_ack_register_addr = start_addr + sizeof(uint64_t);
-
     cpu_physical_memory_read(read_ack_register_addr,
                              &read_ack_register, sizeof(read_ack_register));
 
@@ -437,7 +449,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
         &read_ack_register, sizeof(uint64_t));
 
     /* Write the generic error data entry into guest memory */
-    cpu_physical_memory_write(error_block_addr, cper, len);
+    cpu_physical_memory_write(cper_addr, cper, len);
 
     return;
 }
-- 
2.46.0


