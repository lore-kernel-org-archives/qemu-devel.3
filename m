Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306CAC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 23:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se0sF-0008Ta-T4; Tue, 13 Aug 2024 19:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1se0sD-0008Lq-Uf; Tue, 13 Aug 2024 19:24:17 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1se0sB-0006qL-8L; Tue, 13 Aug 2024 19:24:17 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 2BEBBCE183F;
 Tue, 13 Aug 2024 23:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3F3C4AF10;
 Tue, 13 Aug 2024 23:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723591451;
 bh=7SZ1So9xfJQq48rQZfysiQEF2+M+2VHIMENgBvOnmBs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nTK5MBECnzDZzBeugqMxgAZwqQ9opBQO48aKxxt9N3UW1YlqSqehUfKqEZ5x/OqUU
 B+t51h7DztOunj02fc4+x4Ywxa1GzdjB7xmbLXCLa8SZViuF/GG1rcYBY+WUemSUo9
 Ug9vyoixyBuNIHcqsPf6oYvDdglRmuzj9VYWTZ+VB9EYLCKa0+ma44n5q2ekG6hBqE
 72dE1W7Jj9rzBRsgSaawGBtPTXnpbYSsgtm8Ewj2dpVU+GCSuNu6ZiudJ51pkIHFzp
 PrfhpV5pYsOlBwED1jWw7jzBbko1BUVREF0bTjSgXLz9WtrEtddd2/mwTspYSFix15
 FYMNStd6VIINQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1se0s5-00000002asU-1mFo; Wed, 14 Aug 2024 01:24:09 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v7 06/10] acpi/ghes: add support for generic error injection
 via QAPI
Date: Wed, 14 Aug 2024 01:23:28 +0200
Message-ID: <2104a34f6233dc4a220739348f1a21689fbd3354.1723591201.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1723591201.git.mchehab+huawei@kernel.org>
References: <cover.1723591201.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
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

Provide a generic interface for error injection via GHESv2.

This patch is co-authored:
    - original ghes logic to inject a simple ARM record by Shiju Jose;
    - generic logic to handle block addresses by Jonathan Cameron;
    - generic GHESv2 error inject by Mauro Carvalho Chehab;

Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c         | 57 ++++++++++++++++++++++++++++++++++++++++++
 hw/acpi/ghes_cper.c    |  2 +-
 include/hw/acpi/ghes.h |  3 +++
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index f93499d7d647..2f6b50d57ed2 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -495,6 +495,63 @@ int acpi_ghes_record_errors(enum AcpiGhesNotifyType notify,
 NotifierList acpi_generic_error_notifiers =
     NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
 
+void ghes_record_cper_errors(uint8_t *cper, size_t len,
+                             enum AcpiGhesNotifyType notify, Error **errp)
+{
+    uint64_t cper_addr, read_ack_start_addr;
+    enum AcpiHestSourceId source;
+    AcpiGedState *acpi_ged_state;
+    AcpiGhesState *ags;
+    uint64_t read_ack;
+
+    if (ghes_notify_to_source_id(notify, &source)) {
+        error_setg(errp,
+                   "GHES: Invalid error block/ack address(es) for notify %d",
+                   notify);
+        return;
+    }
+
+    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
+                                                       NULL));
+    g_assert(acpi_ged_state);
+    ags = &acpi_ged_state->ghes_state;
+
+    cper_addr = le64_to_cpu(ags->ghes_addr_le);
+    cper_addr += 2 * ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t);
+    cper_addr += source * ACPI_GHES_MAX_RAW_DATA_LENGTH;
+
+    read_ack_start_addr = le64_to_cpu(ags->hest_addr_le);
+    read_ack_start_addr += source * HEST_GHES_V2_TABLE_SIZE + HEST_ACK_OFFSET;
+
+    cpu_physical_memory_read(read_ack_start_addr,
+                             &read_ack, sizeof(uint64_t));
+
+    /* zero means OSPM does not acknowledge the error */
+    if (!read_ack) {
+        error_setg(errp,
+                   "Last CPER record was not acknowledged yet");
+        read_ack = 1;
+        cpu_physical_memory_write(read_ack_start_addr,
+                                  &read_ack, sizeof(uint64_t));
+        return;
+    }
+
+    read_ack = cpu_to_le64(0);
+    cpu_physical_memory_write(read_ack_start_addr,
+                              &read_ack, sizeof(uint64_t));
+
+    /* Build CPER record */
+
+    if (len > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
+        error_setg(errp, "GHES CPER record is too big: %ld", len);
+    }
+
+    /* Write the generic error data entry into guest memory */
+    cpu_physical_memory_write(cper_addr, cper, len);
+
+    notifier_list_notify(&acpi_generic_error_notifiers, NULL);
+}
+
 bool acpi_ghes_present(void)
 {
     AcpiGedState *acpi_ged_state;
diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
index 92ca84d738de..2328dbff7012 100644
--- a/hw/acpi/ghes_cper.c
+++ b/hw/acpi/ghes_cper.c
@@ -29,5 +29,5 @@ void qmp_ghes_cper(const char *qmp_cper,
         return;
     }
 
-    /* TODO: call a function at ghes */
+    ghes_record_cper_errors(cper, len, ACPI_GHES_NOTIFY_GPIO, errp);
 }
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 2524b5e64624..dacd82c6857e 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -74,6 +74,9 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
 int acpi_ghes_record_errors(enum AcpiGhesNotifyType notify,
                             uint64_t error_physical_addr);
 
+void ghes_record_cper_errors(uint8_t *cper, size_t len,
+                             enum AcpiGhesNotifyType notify,Error **errp);
+
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
  *
-- 
2.46.0


