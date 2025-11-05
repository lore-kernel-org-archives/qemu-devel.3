Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E524CCFA05
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 11:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGbyx-0006N5-FT; Wed, 05 Nov 2025 06:47:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vGbyV-0005vQ-TK
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 06:46:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vGbyR-0003aK-UH
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 06:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762343204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZU3GkXmIIfHWZ3UrydTfdU7hH9glzdRJ1Io68IszhhE=;
 b=O0/mxegBOnL8w/HK1d/OPQ6x8Qe0XfshAHPFUCJDGfx2NdxaypN6K6Q0ZdcyRwI3rOzE3Z
 KJoNcq47eSaLRAYW7pNiOlzTzzhnCDzU5g4mIsiz+5yLXl2+/TukxmfmrwGq0aJnfjNya7
 QzJVka9SgaHocekernkyxMgAKpwz33o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-U05nP2xtOl6WvjFiMp8Etw-1; Wed,
 05 Nov 2025 06:46:39 -0500
X-MC-Unique: U05nP2xtOl6WvjFiMp8Etw-1
X-Mimecast-MFC-AGG-ID: U05nP2xtOl6WvjFiMp8Etw_1762343198
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 253A81800250; Wed,  5 Nov 2025 11:46:38 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 037C71800451; Wed,  5 Nov 2025 11:46:32 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v3 6/8] acpi/ghes: Use error_abort in acpi_ghes_memory_errors()
Date: Wed,  5 Nov 2025 21:44:51 +1000
Message-ID: <20251105114453.2164073-7-gshan@redhat.com>
In-Reply-To: <20251105114453.2164073-1-gshan@redhat.com>
References: <20251105114453.2164073-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use error_abort in acpi_ghes_memory_errors() so that the caller needn't
explicitly call abort() on errors. With this change, its return value
isn't needed any more.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 hw/acpi/ghes-stub.c    |  6 +++---
 hw/acpi/ghes.c         | 15 ++++-----------
 include/hw/acpi/ghes.h |  5 +++--
 target/arm/kvm.c       | 10 +++-------
 4 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
index 4faf573aeb..4ef914ffc5 100644
--- a/hw/acpi/ghes-stub.c
+++ b/hw/acpi/ghes-stub.c
@@ -11,10 +11,10 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/ghes.h"
 
-int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
-                            uint64_t *addresses, uint32_t num_of_addresses)
+void acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
+                             uint64_t *addresses, uint32_t num_of_addresses,
+                             Error **errp)
 {
-    return -1;
 }
 
 AcpiGhesState *acpi_ghes_get_state(void)
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 055e5d719a..aa469c03f2 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -543,8 +543,9 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
     notifier_list_notify(&acpi_generic_error_notifiers, &source_id);
 }
 
-int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
-                            uint64_t *addresses, uint32_t num_of_addresses)
+void acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
+                             uint64_t *addresses, uint32_t num_of_addresses,
+                             Error **errp)
 {
     /* Memory Error Section Type */
     const uint8_t guid[] =
@@ -555,7 +556,6 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
      * Table 17-13 Generic Error Data Entry
      */
     QemuUUID fru_id = {};
-    Error *errp = NULL;
     int data_length;
     GArray *block;
     uint32_t block_status, i;
@@ -592,16 +592,9 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
     }
 
     /* Report the error */
-    ghes_record_cper_errors(ags, block->data, block->len, source_id, &errp);
+    ghes_record_cper_errors(ags, block->data, block->len, source_id, errp);
 
     g_array_free(block, true);
-
-    if (errp) {
-        error_report_err(errp);
-        return -1;
-    }
-
-    return 0;
 }
 
 AcpiGhesState *acpi_ghes_get_state(void)
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index f73908985d..35c7bbbb01 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -98,8 +98,9 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
-int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
-                            uint64_t *addresses, uint32_t num_of_addresses);
+void acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
+                             uint64_t *addresses, uint32_t num_of_addresses,
+                             Error **errp);
 void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
                              uint16_t source_id, Error **errp);
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 459ca4a9b0..a889315606 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2458,13 +2458,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
             addresses[0] = paddr;
             if (code == BUS_MCEERR_AR) {
                 kvm_cpu_synchronize_state(c);
-                if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
-                                             addresses, 1)) {
-                    kvm_inject_arm_sea(c);
-                } else {
-                    error_report("failed to record the error");
-                    abort();
-                }
+                acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
+                                        addresses, 1, &error_abort);
+                kvm_inject_arm_sea(c);
             }
             return;
         }
-- 
2.51.0


