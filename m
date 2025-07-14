Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D839CC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 08:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubEdB-00065R-8H; Mon, 14 Jul 2025 04:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubEFu-00021J-HB
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubEFs-0003ms-O1
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752480584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=olVztWWHaIhDRk4yXM0ZbEs5ZLLLT9Ahs/90MUXTiyk=;
 b=BomAhPqfwXmBqV5aHua0nXp3mhJWj5O+VU017zheBWp41E021q6d+FDDHBRRFRTqBHFk+v
 8vBjk6vcDGopTEuydSqD7uCz7aqlZkyktk0Kh32ArY7CZ1tV2qtCLcnMuliK9U1IwqLDuP
 2JQsovSHBIgi7wCGVxrLVglJqBMZfd0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-fmv0fvQaOIm-V_FWCy6V8A-1; Mon,
 14 Jul 2025 04:09:40 -0400
X-MC-Unique: fmv0fvQaOIm-V_FWCy6V8A-1
X-Mimecast-MFC-AGG-ID: fmv0fvQaOIm-V_FWCy6V8A_1752480579
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4E52195608E; Mon, 14 Jul 2025 08:09:38 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.221])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6265C1977029; Mon, 14 Jul 2025 08:09:34 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 Jonathan.Cameron@huawei.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com,
	philmd@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v7 34/36] tests/qtest/bios-tables-test: Add aarch64 ACPI PCI
 hotplug test
Date: Mon, 14 Jul 2025 10:05:18 +0200
Message-ID: <20250714080639.2525563-35-eric.auger@redhat.com>
In-Reply-To: <20250714080639.2525563-1-eric.auger@redhat.com>
References: <20250714080639.2525563-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Add 2 new tests:
- test_acpi_aarch64_virt_acpi_pci_hotplug tests the acpi pci hotplug
  using -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on
- test_acpi_aarch64_virt_pcie_root_port_hpoff tests static-acpi index
  on a root port with disabled hotplug

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

---
v3 -> v4:
- add -device pci-testdev for the first test case
- fix the chassis
- add a test for static acpi-index
---
 tests/qtest/bios-tables-test.c | 52 ++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 357bcefd37..1074b8d67a 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1643,6 +1643,54 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
 
 }
 
+static void test_acpi_aarch64_virt_acpi_pci_hotplug(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "aarch64",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 256ULL * MiB,
+        .variant = ".acpipcihp",
+    };
+
+   /* Use ACPI PCI Hotplug */
+   test_acpi_one(" -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on"
+                 " -cpu cortex-a57"
+                 " -device pcie-root-port,id=pcie.1,bus=pcie.0,chassis=0,slot=1,addr=7.0"
+                 " -device pci-testdev,bus=pcie.1",
+                 &data);
+
+    free_test_data(&data);
+}
+
+static void test_acpi_aarch64_virt_pcie_root_port_hpoff(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "aarch64",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 256ULL * MiB,
+        .variant = ".hpoffacpiindex",
+    };
+
+   /* turn hotplug off on the pcie-root-port and use static acpi-index*/
+   test_acpi_one(" -device pcie-root-port,id=pcie.1,chassis=0,"
+                                          "slot=1,hotplug=off,addr=7.0"
+                 " -device pci-testdev,bus=pcie.1,acpi-index=12"
+                 " -cpu cortex-a57",
+                 &data);
+
+    free_test_data(&data);
+}
+
 static void test_acpi_microvm_prepare(test_data *data)
 {
     data->machine = "microvm";
@@ -2602,6 +2650,10 @@ int main(int argc, char *argv[])
             qtest_add_func("acpi/virt/numamem",
                            test_acpi_aarch64_virt_tcg_numamem);
             qtest_add_func("acpi/virt/memhp", test_acpi_aarch64_virt_tcg_memhp);
+            qtest_add_func("acpi/virt/acpipcihp",
+                           test_acpi_aarch64_virt_acpi_pci_hotplug);
+            qtest_add_func("acpi/virt/hpoffacpiindex",
+                          test_acpi_aarch64_virt_pcie_root_port_hpoff);
             qtest_add_func("acpi/virt/pxb", test_acpi_aarch64_virt_tcg_pxb);
             qtest_add_func("acpi/virt/oem-fields",
                            test_acpi_aarch64_virt_oem_fields);
-- 
2.49.0


