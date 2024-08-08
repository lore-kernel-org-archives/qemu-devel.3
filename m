Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FAEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 12:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc2EG-0000BQ-58; Thu, 08 Aug 2024 08:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sc2EB-0008PE-DE; Thu, 08 Aug 2024 08:26:47 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sc2E9-0005xM-7q; Thu, 08 Aug 2024 08:26:46 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7270F615E1;
 Thu,  8 Aug 2024 12:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25FAC4AF0D;
 Thu,  8 Aug 2024 12:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723120002;
 bh=6/P38/7rRzxEe+1VVilVCabjUis4nPl0EUCTfasTwqg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NSbMU3s/OpMWBkLfM5zDOw4cy59etPtjJ2dOSt0soGSsXPtQrHyLnKkSL+wQ2v31M
 r9MyazEC6q6Brqylp1n15hrHR/wd0YgUO3YztLdENrb9dRAuyi+hPl+jZ6HH+++ggF
 iKJMkP+iS0oKx74sPK3U9e4elk7JoxvLLBBC813gdfvPRLen6eceMzCnWZYk4+Dg/f
 vv4XgpwqQvkkq7hFdWwGqLAWYsNVLJehNvxxtd4T3qVEVNVxd4+Juy4BNaAd2JB5GD
 Nn8e4wl4iUFvVudsYA8ou4upGfHT+NN0d9wCaC7qIb1fwKYxx9QDjAeHDkzIPFOros
 QJL7scZJH6VSw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1sc2E4-00000000oDW-43xD; Thu, 08 Aug 2024 14:26:40 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v6 06/10] acpi/ghes: add support for generic error injection
 via QAPI
Date: Thu,  8 Aug 2024 14:26:32 +0200
Message-ID: <ab419c5dda274a94eefb6eaf9fecab3197f87fe1.1723119423.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1723119423.git.mchehab+huawei@kernel.org>
References: <cover.1723119423.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
 hw/acpi/ghes.c         | 78 ++++++++++++++++++++++++++++++++++++++++++
 hw/acpi/ghes_cper.c    |  2 +-
 include/hw/acpi/ghes.h |  3 ++
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 26e93dd0f6e2..8525481bb828 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -534,6 +534,84 @@ int acpi_ghes_record_errors(enum AcpiGhesNotifyType notify,
 NotifierList acpi_generic_error_notifiers =
     NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
 
+void ghes_record_cper_errors(AcpiGhesCper *cper, Error **errp,
+                             enum AcpiGhesNotifyType notify)
+{
+    uint64_t cper_addr, read_ack_start_addr;
+    uint64_t read_ack = 0;
+    uint32_t data_length;
+    GArray *block;
+    uint32_t i;
+
+    if (ghes_get_hardware_errors_address(notify, NULL, &read_ack_start_addr,
+                                         &cper_addr, NULL)) {
+        error_setg(errp,
+                   "GHES: Invalid error block/ack address(es) for notify %d",
+                   notify);
+        return;
+    }
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
+    /*
+     * Invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
+     * Table 17-13 Generic Error Data Entry
+     */
+    QemuUUID fru_id = {};
+
+    block = g_array_new(false, true /* clear */, 1);
+    data_length = ACPI_GHES_DATA_LENGTH + cper->data_len;
+
+    /*
+     * It should not run out of the preallocated memory if
+     * adding a new generic error data entry
+     */
+    if ((data_length + ACPI_GHES_GESB_SIZE) >
+        ACPI_GHES_MAX_RAW_DATA_LENGTH) {
+        error_setg(errp, "GHES CPER record is too big: %d",
+                   data_length);
+    }
+
+    /* Build the new generic error status block header */
+    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
+                                    0, 0, data_length,
+                                    ACPI_CPER_SEV_RECOVERABLE);
+
+    /* Build this new generic error data entry header */
+    acpi_ghes_generic_error_data(block, cper->guid,
+                                ACPI_CPER_SEV_RECOVERABLE, 0, 0,
+                                cper->data_len, fru_id, 0);
+
+    /* Add CPER data */
+    for (i = 0; i < cper->data_len; i++) {
+        build_append_int_noprefix(block, cper->data[i], 1);
+    }
+
+    /* Write the generic error data entry into guest memory */
+    cpu_physical_memory_write(cper_addr, block->data, block->len);
+
+    g_array_free(block, true);
+
+    notifier_list_notify(&acpi_generic_error_notifiers, NULL);
+}
+
 bool acpi_ghes_present(void)
 {
     AcpiGedState *acpi_ged_state;
diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
index 7aa7e71e90dc..d7ff7debee74 100644
--- a/hw/acpi/ghes_cper.c
+++ b/hw/acpi/ghes_cper.c
@@ -39,7 +39,7 @@ void qmp_ghes_cper(CommonPlatformErrorRecord *qmp_cper,
         return;
     }
 
-    /* TODO: call a function at ghes */
+    ghes_record_cper_errors(&cper, errp, ACPI_GHES_NOTIFY_GPIO);
 
     g_free(cper.data);
 }
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 2fcfa1cc8090..5a7bdb08f8e2 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -79,6 +79,9 @@ typedef struct AcpiGhesCper {
     size_t data_len;
 } AcpiGhesCper;
 
+void ghes_record_cper_errors(AcpiGhesCper *cper, Error **errp,
+                             enum AcpiGhesNotifyType notify);
+
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
  *
-- 
2.45.2


