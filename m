Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6CACF9C6C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 04:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stJHP-0006yL-5t; Wed, 25 Sep 2024 00:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1stJGq-0005gk-1e; Wed, 25 Sep 2024 00:04:56 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1stJGo-0001xy-8v; Wed, 25 Sep 2024 00:04:55 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B55AAA43B50;
 Wed, 25 Sep 2024 04:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC31C4AF0E;
 Wed, 25 Sep 2024 04:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727237088;
 bh=QmS5SCan71KvTfp2vhqpTHrvyu5BMSTHUv6oVhJLzV8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uUxAnzOHABHSGnDX6tOPQMc0Hi0jOdgKacLuW5IrB/HfdmwejkLT3mf/+1mhemzpc
 5PrI3ofM7saJ5jIIuVh8QXZi6fWyXCe2sXJyLZHboiXH+Pwomo1Ri5rLt4dOHNdmQa
 PkUkjNDg3Z6YYiC1lFRHZybNX0dMxpHK6I+kmVuWKMiuXgjiehwUoaml1YghoyN/Lu
 FuwLAtiFfCzr9kDPTUB/+bL4Gr5mFCaek1oRUZRdkklK1CNoZfJ1aj8zE79060O3P8
 zyVVayZrbRoQtzqOemnlSsfADG0JiVbSg8YG+hD23DC/ZbHQm/Fm2R22S+lfOSOo7d
 VbzxdRSnIENJQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1stJGg-0000000827t-0efp; Wed, 25 Sep 2024 06:04:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 04/15] acpi/ghes: better handle source_id and notification
Date: Wed, 25 Sep 2024 06:04:09 +0200
Message-ID: <a3b54a74158fdff44e600cf0949a430891c8cb22.1727236561.git.mchehab+huawei@kernel.org>
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

GHES has two fields that are stored on HEST error source
blocks:

- notification type, which is a number defined at the ACPI spec
  containing several arch-specific synchronous and assynchronous
  types;
- source id, which is a HW/FW defined number, used to distinguish
  between different implemented hardware report mechanisms.

Cleanup the logic to fill those, as they should be handled
independently.

This is a preparation for a future patch that will shift
those fields to the HEST init function call.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

---

Chenges from v10:

- Some changes got moved to the previous patch.

Changes from v8:
- Non-rename/cleanup changes merged altogether;
- source ID is now more generic, defined per guest target.
  That should make easier to add support for 86.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 7b42ed59cd15..7460cd1a8d56 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -284,9 +284,13 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
 }
 
 /* Build Generic Hardware Error Source version 2 (GHESv2) */
-static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
+static void build_ghes_v2(GArray *table_data,
+                          BIOSLinker *linker,
+                          enum AcpiGhesNotifyType notify,
+                          uint16_t source_id)
 {
     uint64_t address_offset;
+
     /*
      * Type:
      * Generic Hardware Error Source version 2(GHESv2 - Type 10)
@@ -316,18 +320,8 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
         address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),
         ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));
 
-    switch (source_id) {
-    case ACPI_HEST_SRC_ID_SEA:
-        /*
-         * Notification Structure
-         * Now only enable ARMv8 SEA notification type
-         */
-        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
-        break;
-    default:
-        error_report("Not support this error source");
-        abort();
-    }
+    /* Notification Structure */
+    build_ghes_hw_error_notification(table_data, notify);
 
     /* Error Status Block Length */
     build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
@@ -369,7 +363,8 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
 
     /* Error Source Count */
     build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
-    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
+    build_ghes_v2(table_data, linker,
+                  ACPI_GHES_NOTIFY_SEA, ACPI_HEST_SRC_ID_SEA);
 
     acpi_table_end(linker, &table);
 }
-- 
2.46.1


