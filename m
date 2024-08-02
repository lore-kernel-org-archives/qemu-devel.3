Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4AFC52D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 21:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa04q-0004bc-Hn; Fri, 02 Aug 2024 17:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sa04j-0004PW-29; Fri, 02 Aug 2024 17:44:37 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sa04f-0001AC-TJ; Fri, 02 Aug 2024 17:44:36 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1B04C62B60;
 Fri,  2 Aug 2024 21:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3F1C4AF0F;
 Fri,  2 Aug 2024 21:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722635063;
 bh=ZSlU9yW3n4NevgGhDHVq1qOszSSTbSe+VJ0pqN5i5yU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k23NbhNcvr7qcW0xNGW/lpc063Ke8p+T3amvRCJSiFCEVRb4H7p9pBQPO4OJZjc02
 53j4U8mzbsz+hPg8IgcdmW8yhjJ0vaCvj2dpLFta0vt9caHzuWJiQ1imY+Y+6gOVhC
 Wcs6+zgkYqfLB2ebYMcPy/zpjTAyyi7UYUcsVRSxtA74T/qeBsMtWSSfnZWb10wW7l
 A8P8LlShEqoplvkwGKaAOe53Zfi/oadN4z6Exx8NDvjC7dLBgEA2uL1+ec4o4T6C+J
 qtJ0c+7W7CPQy9V+SS4KX8b/U1pk0fQaJD+/UynF0GUD+kbgw+gGNrVbCHbUt6k+F9
 GsePxlR5709Vw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1sa04T-00000002naP-2z0m; Fri, 02 Aug 2024 23:44:21 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v5 4/7] acpi/ghes: Support GPIO error source
Date: Fri,  2 Aug 2024 23:43:59 +0200
Message-ID: <5d53042ebc5bc73bbc71f600e1ec1dea41f346b9.1722634602.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722634602.git.mchehab+huawei@kernel.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add error notification to GHES v2 using the GPIO source.

[mchehab: do some cleanups at ACPI_HEST_SRC_ID_* checks]

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c         | 16 ++++++++++------
 include/hw/acpi/ghes.h |  3 ++-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 8d0262e6c1aa..a745dcc7be5e 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -34,8 +34,8 @@
 /* The max size in bytes for one error block */
 #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
 
-/* Now only support ARMv8 SEA notification type error source */
-#define ACPI_GHES_ERROR_SOURCE_COUNT        1
+/* Support ARMv8 SEA notification type error source and GPIO interrupt. */
+#define ACPI_GHES_ERROR_SOURCE_COUNT        2
 
 /* Generic Hardware Error Source version 2 */
 #define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
@@ -290,6 +290,9 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
 static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
 {
     uint64_t address_offset;
+
+    assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
+
     /*
      * Type:
      * Generic Hardware Error Source version 2(GHESv2 - Type 10)
@@ -327,6 +330,9 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
          */
         build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
         break;
+    case ACPI_HEST_SRC_ID_GPIO:
+        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_GPIO);
+        break;
     default:
         error_report("Not support this error source");
         abort();
@@ -370,6 +376,7 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
     /* Error Source Count */
     build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
     build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
+    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_GPIO, linker);
 
     acpi_table_end(linker, &table);
 }
@@ -406,10 +413,7 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
     start_addr = le64_to_cpu(ags->ghes_addr_le);
 
     if (physical_address) {
-
-        if (source_id < ACPI_HEST_SRC_ID_RESERVED) {
-            start_addr += source_id * sizeof(uint64_t);
-        }
+        start_addr += source_id * sizeof(uint64_t);
 
         cpu_physical_memory_read(start_addr, &error_block_addr,
                                  sizeof(error_block_addr));
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 6891eafff5ab..33be1eb5acf4 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -59,9 +59,10 @@ enum AcpiGhesNotifyType {
     ACPI_GHES_NOTIFY_RESERVED = 12
 };
 
+/* Those are used as table indexes when building GHES tables */
 enum {
     ACPI_HEST_SRC_ID_SEA = 0,
-    /* future ids go here */
+    ACPI_HEST_SRC_ID_GPIO,
     ACPI_HEST_SRC_ID_RESERVED,
 };
 
-- 
2.45.2


