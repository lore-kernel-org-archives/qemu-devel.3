Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF783C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 07:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1serXO-00083E-Lr; Fri, 16 Aug 2024 03:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1serXM-0007ts-Ox; Fri, 16 Aug 2024 03:38:16 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1serXJ-0005w9-Bn; Fri, 16 Aug 2024 03:38:16 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 78298CE1EFF;
 Fri, 16 Aug 2024 07:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD7AC4AF4D;
 Fri, 16 Aug 2024 07:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723793873;
 bh=bWfj8/aqYfKMeMa4cF07zxom827l/axtbZeMVPNCd5w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=B2vnlcYZl3B+bR6aYarmnwAA79sdioTCBa+SOqID5fEXXtFEkVqjkUzcBotpt0ACL
 /e21hSUA5dUH0FSPxM0cZGdoQ7RDCY4RDWkMbhp5rs9LRKmUiMg/4U9slpXWytFK6O
 WoBjmpSscAUCsbAetXM931E9iQajtRRCSjaQq6kssTaUm4wA3rtUWPPhH9RPP/y8Jg
 CBu2bk2FeifPx8aF7rEIQqmAE/YEKaT5eG6hPRtk5fJXDD3lI7LGC+x8+L8FFaWvpB
 DS0hpZkoJttupvKoj57wo18bynsHGVytm9k2JQJt9RPEcIAiiAaZldAAeB+1RBkQnE
 t8ij01M7lmH2w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1serWx-000000055f7-38jG; Fri, 16 Aug 2024 09:37:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v8 13/13] acpi/ghes: check if the BIOS pointers for HEST are
 correct
Date: Fri, 16 Aug 2024 09:37:45 +0200
Message-ID: <52e6058feba318d01f54da6dca427b40ea5c9435.1723793768.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1723793768.git.mchehab+huawei@kernel.org>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The OS kernels navigate between HEST, error source struct
and CPER by the usage of some pointers. Double-check if such
pointers were properly initializing, ensuring that they match
the right address for CPER.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index a822a5eafaa0..51e2e40e5a9c 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -85,6 +85,9 @@ enum AcpiHestSourceId {
 #define HEST_GHES_V2_TABLE_SIZE  92
 #define GHES_ACK_OFFSET          (64 + GAS_ADDR_OFFSET + ACPI_HEST_HEADER_SIZE)
 
+/* ACPI 6.2: 18.3.2.7: Generic Hardware Error Source */
+#define GHES_ERR_ST_ADDR_OFFSET  (20 + GAS_ADDR_OFFSET + ACPI_HEST_HEADER_SIZE)
+
 /*
  * Values for error_severity field
  */
@@ -425,7 +428,10 @@ NotifierList acpi_generic_error_notifiers =
 void ghes_record_cper_errors(const void *cper, size_t len,
                              enum AcpiGhesNotifyType notify, Error **errp)
 {
-    uint64_t cper_addr, read_ack_start_addr;
+    uint64_t hest_read_ack_start_addr, read_ack_start_addr;
+    uint64_t read_ack_start_addr_2, err_source_struct;
+    uint64_t hest_err_block_addr, error_block_addr;
+    uint64_t cper_addr, cper_addr_2;
     enum AcpiHestSourceId source;
     AcpiGedState *acpi_ged_state;
     AcpiGhesState *ags;
@@ -450,6 +456,28 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     cper_addr += ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t);
     cper_addr += source * ACPI_GHES_MAX_RAW_DATA_LENGTH;
 
+    err_source_struct = le64_to_cpu(ags->hest_addr_le) +
+                        source * HEST_GHES_V2_TABLE_SIZE;
+
+    /* Check if BIOS addr pointers were properly generated */
+
+    hest_err_block_addr = err_source_struct + GHES_ERR_ST_ADDR_OFFSET;
+    hest_read_ack_start_addr = err_source_struct + GHES_ACK_OFFSET;
+
+    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
+                             sizeof(error_block_addr));
+
+    cpu_physical_memory_read(error_block_addr, &cper_addr_2,
+                             sizeof(error_block_addr));
+
+    cpu_physical_memory_read(hest_read_ack_start_addr, &read_ack_start_addr_2,
+			     sizeof(read_ack_start_addr_2));
+
+    assert(cper_addr == cper_addr_2);
+    assert(read_ack_start_addr == read_ack_start_addr_2);
+
+    /* Update ACK offset to notify about a new error */
+
     cpu_physical_memory_read(read_ack_start_addr,
                              &read_ack, sizeof(uint64_t));
 
-- 
2.46.0


