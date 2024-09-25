Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F1ECF9C71
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 04:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stJHh-0008G2-FY; Wed, 25 Sep 2024 00:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1stJGr-0005nf-IL; Wed, 25 Sep 2024 00:04:58 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1stJGp-0001yg-4j; Wed, 25 Sep 2024 00:04:57 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 3C834A43B76;
 Wed, 25 Sep 2024 04:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C595C4AF09;
 Wed, 25 Sep 2024 04:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727237088;
 bh=mqIm3bJtaRAa0O4EuTpOX+hZV2xSkoWyzNnlHh1/o0Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GGczoq103eX0TVLS7G6VBiPEdadBiZAX8LkTQR7sWknvkscle5U7yxMt4VhZEgLam
 R60bkA7MtJFETB55dQRGK++A/9Lwvm9B97Cw33WIvrfnTPCVwGiKRTJZlBZ4xa3qqt
 Htym8mCD98wrfXSMzKnNaXNGP2gMWqeV+PzzRe1JSKClBTHn7w4CS4xY3t3kZN+ZaP
 W6Lnl4Ko3YT0mH9amdsKlisLgpstg+F1H1ssw6kohzdPdD2iZaC1ioAtB6ljd4E3no
 gwD76kDmPK96FJ9qIGoW9wfu/TFVS5ZUMX4KTggH93MGEqAQka1bu5PCpI/8tYTcuL
 Vhqawk4SyeweA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1stJGg-0000000828H-1KCq; Wed, 25 Sep 2024 06:04:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 10/15] acpi/ghes: move offset calculus to a separate function
Date: Wed, 25 Sep 2024 06:04:15 +0200
Message-ID: <5e8c2f0267a21d05ed09c8af616a92d94638c474.1727236561.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1727236561.git.mchehab+huawei@kernel.org>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 hw/acpi/ghes.c | 52 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 307b5a41d539..900f1571bc97 100644
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
 
@@ -396,29 +421,16 @@ void ghes_record_cper_errors(const void *cper, size_t len,
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
-                                sizeof(error_block_addr));
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
-                                &read_ack_register, sizeof(read_ack_register));
+                             &read_ack_register, sizeof(read_ack_register));
 
     /* zero means OSPM does not acknowledge the error */
     if (!read_ack_register) {
@@ -437,7 +449,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
         &read_ack_register, sizeof(uint64_t));
 
     /* Write the generic error data entry into guest memory */
-    cpu_physical_memory_write(error_block_addr, cper, len);
+    cpu_physical_memory_write(cper_addr, cper, len);
 
     return;
 }
-- 
2.46.1


