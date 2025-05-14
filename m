Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8C2C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 17:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFFYN-00022s-2j; Wed, 14 May 2025 13:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uFFY5-0001wA-Qq
 for qemu-devel@nongnu.org; Wed, 14 May 2025 13:05:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uFFY2-0007ft-CY
 for qemu-devel@nongnu.org; Wed, 14 May 2025 13:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747242336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zok49zoUTTkBlZVopW6XblcQI7eizznHl5/fscG3xOw=;
 b=SnWw7st6wmLixGSUQ4JNRLYNmXFQSb/SvfEYbDh7iZEDx0SOCss9rRmr3VlJ6s3AeGC+kG
 oXXt00t0DfuQuwABQRTyG+odknnC2Mrpbf9oIwf5ji/WobbN4bMJThXKPG8vjWa8ylt9fe
 4n2aBMD70Vln+PAiPh/qgQ9N9NHf4P8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-TTJiG-mBNd-unf1znIgM3A-1; Wed,
 14 May 2025 13:05:33 -0400
X-MC-Unique: TTJiG-mBNd-unf1znIgM3A-1
X-Mimecast-MFC-AGG-ID: TTJiG-mBNd-unf1znIgM3A_1747242331
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3620B195608C; Wed, 14 May 2025 17:05:31 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.14])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CDD2130001B0; Wed, 14 May 2025 17:05:26 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com,
	Jonathan.Cameron@huawei.com,
	philmd@linaro.org
Subject: [PATCH 10/22] hw/acpi/pcihp: Add an AmlRegionSpace arg to
 build_acpi_pci_hotplug
Date: Wed, 14 May 2025 19:00:57 +0200
Message-ID: <20250514170431.2786231-11-eric.auger@redhat.com>
In-Reply-To: <20250514170431.2786231-1-eric.auger@redhat.com>
References: <20250514170431.2786231-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On ARM we will put the operation regions in AML_SYSTEM_MEMORY.
So let's allow this configuration.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/hw/acpi/pcihp.h | 3 ++-
 hw/acpi/pcihp.c         | 8 ++++----
 hw/i386/acpi-build.c    | 4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index ec9b010e4a..525e61a2a9 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -28,6 +28,7 @@
 #define HW_ACPI_PCIHP_H
 
 #include "hw/acpi/acpi.h"
+#include "hw/acpi/aml-build.h"
 #include "hw/hotplug.h"
 
 #define ACPI_PCIHP_IO_BASE_PROP "acpi-pcihp-io-base"
@@ -73,7 +74,7 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
                                          AcpiPciHpState *s, DeviceState *dev,
                                          Error **errp);
 
-void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr);
+void build_acpi_pci_hotplug(Aml *table, AmlRegionSpace rs, uint64_t pcihp_addr);
 void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar);
 void build_append_pcihp_resources(Aml *table,
                                   uint64_t io_addr, uint64_t io_len);
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index fb54c31f77..310a5c54bd 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -629,7 +629,7 @@ static Aml *aml_pci_pdsm(void)
     return method;
 }
 
-void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr)
+void build_acpi_pci_hotplug(Aml *table, AmlRegionSpace rs, uint64_t pcihp_addr)
 {
     Aml *scope;
     Aml *field;
@@ -638,21 +638,21 @@ void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr)
     scope =  aml_scope("_SB.PCI0");
 
     aml_append(scope,
-        aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(pcihp_addr), 0x08));
+        aml_operation_region("PCST", rs, aml_int(pcihp_addr), 0x08));
     field = aml_field("PCST", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
     aml_append(field, aml_named_field("PCIU", 32));
     aml_append(field, aml_named_field("PCID", 32));
     aml_append(scope, field);
 
     aml_append(scope,
-        aml_operation_region("SEJ", AML_SYSTEM_IO,
+        aml_operation_region("SEJ", rs,
                              aml_int(pcihp_addr + ACPI_PCIHP_SEJ_BASE), 0x04));
     field = aml_field("SEJ", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
     aml_append(field, aml_named_field("B0EJ", 32));
     aml_append(scope, field);
 
     aml_append(scope,
-        aml_operation_region("BNMR", AML_SYSTEM_IO,
+        aml_operation_region("BNMR", rs,
                              aml_int(pcihp_addr + ACPI_PCIHP_BNMR_BASE), 0x08));
     field = aml_field("BNMR", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
     aml_append(field, aml_named_field("BNUM", 32));
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index ca59185aac..87bb3d5cee 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1172,7 +1172,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(dsdt, sb_scope);
 
         if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
-            build_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
+            build_acpi_pci_hotplug(dsdt, AML_SYSTEM_IO, pm->pcihp_io_base);
         }
         build_piix4_pci0_int(dsdt);
     } else if (q35) {
@@ -1216,7 +1216,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(dsdt, sb_scope);
 
         if (pm->pcihp_bridge_en) {
-            build_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
+            build_acpi_pci_hotplug(dsdt, AML_SYSTEM_IO, pm->pcihp_io_base);
         }
         build_q35_pci0_int(dsdt);
     }
-- 
2.49.0


