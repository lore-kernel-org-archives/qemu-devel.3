Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D404C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 07:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1serX8-0006sa-N1; Fri, 16 Aug 2024 03:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1serX4-0006c4-UP; Fri, 16 Aug 2024 03:37:58 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1serX2-0005uJ-4T; Fri, 16 Aug 2024 03:37:58 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D509B62110;
 Fri, 16 Aug 2024 07:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C56C4AF1B;
 Fri, 16 Aug 2024 07:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723793873;
 bh=/UrLD39uTtqzLQxF34eTLlBfA+BnxRQyD1jfJGYlCXg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bmr4TPJOs8R126ZTZujoL+kcn4vqs4uJF2xQupXLwWPFzrqf73Bc6iWDbnBEsEzPA
 5Vn7z74PF+PHT8U9y9vhXVH+olR89WFT2N4yV0UptS7U4hBHn+Sif18rUMP8YHxuwP
 tMlvrX5tRlJ6NTjCPzfA80YIhvJZXihhEKsdHWZin/8oo/OUQ/U4PCkNF023/498Gp
 PTnhYX372f1bmpVv0z9OqhxR0NwEoFhCT36YVBSErUM3yvjRtoFut6N9kvHDsyJYkd
 hRxn9x+chujIKeIkBGiA60VOvsIyhRUevXnHAZnvOQNwPjXbhPxKifQWiDHMMyn1jv
 21I5Y/d2caiGg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1serWx-000000055f3-31wS; Fri, 16 Aug 2024 09:37:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v8 12/13] acpi/ghes: cleanup generic error data logic
Date: Fri, 16 Aug 2024 09:37:44 +0200
Message-ID: <d91565e9ac1c59bd2bb22b06256f5fefcb43a973.1723793768.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1723793768.git.mchehab+huawei@kernel.org>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
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

Remove comments that are obvious.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 4f7b6c5ad2b6..a822a5eafaa0 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -130,34 +130,28 @@ static void build_ghes_hw_error_notification(GArray *table, const uint8_t type)
  * ACPI 6.1: 18.3.2.7.1 Generic Error Data
  */
 static void acpi_ghes_generic_error_data(GArray *table,
-                const uint8_t *section_type, uint32_t error_severity,
-                uint8_t validation_bits, uint8_t flags,
-                uint32_t error_data_length, QemuUUID fru_id,
-                uint64_t time_stamp)
+                                         const uint8_t *section_type,
+                                         uint32_t error_severity,
+                                         uint8_t validation_bits,
+                                         uint8_t flags,
+                                         uint32_t error_data_length,
+                                         QemuUUID fru_id,
+                                         uint64_t time_stamp)
 {
     const uint8_t fru_text[20] = {0};
 
-    /* Section Type */
     g_array_append_vals(table, section_type, 16);
-
-    /* Error Severity */
     build_append_int_noprefix(table, error_severity, 4);
+
     /* Revision */
     build_append_int_noprefix(table, 0x300, 2);
-    /* Validation Bits */
+
     build_append_int_noprefix(table, validation_bits, 1);
-    /* Flags */
     build_append_int_noprefix(table, flags, 1);
-    /* Error Data Length */
     build_append_int_noprefix(table, error_data_length, 4);
 
-    /* FRU Id */
     g_array_append_vals(table, fru_id.data, ARRAY_SIZE(fru_id.data));
-
-    /* FRU Text */
     g_array_append_vals(table, fru_text, sizeof(fru_text));
-
-    /* Timestamp */
     build_append_int_noprefix(table, time_stamp, 8);
 }
 
@@ -165,19 +159,17 @@ static void acpi_ghes_generic_error_data(GArray *table,
  * Generic Error Status Block
  * ACPI 6.1: 18.3.2.7.1 Generic Error Data
  */
-static void acpi_ghes_generic_error_status(GArray *table, uint32_t block_status,
-                uint32_t raw_data_offset, uint32_t raw_data_length,
-                uint32_t data_length, uint32_t error_severity)
+static void acpi_ghes_generic_error_status(GArray *table,
+                                           uint32_t block_status,
+                                           uint32_t raw_data_offset,
+                                           uint32_t raw_data_length,
+                                           uint32_t data_length,
+                                           uint32_t error_severity)
 {
-    /* Block Status */
     build_append_int_noprefix(table, block_status, 4);
-    /* Raw Data Offset */
     build_append_int_noprefix(table, raw_data_offset, 4);
-    /* Raw Data Length */
     build_append_int_noprefix(table, raw_data_length, 4);
-    /* Data Length */
     build_append_int_noprefix(table, data_length, 4);
-    /* Error Severity */
     build_append_int_noprefix(table, error_severity, 4);
 }
 
-- 
2.46.0


