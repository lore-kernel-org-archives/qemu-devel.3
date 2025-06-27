Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50648C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 10:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV5re-0000uC-Da; Fri, 27 Jun 2025 05:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV5rV-00009A-BZ
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV5rT-0008Kv-Bd
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751018350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M9GO+cAOqe10bNsJBdFignWcaS8Shu48ZQc9EONYkr0=;
 b=NO3CjJsDAI/Pf5Mj/tqMiy7/AUYgpPYsds/wxAwceAR5jcFNQ1BuXylg5Pbnm60SymZT2N
 gUuYCJZw4MeiQ4eKpRr6wOrJ+H1ndfYz1fwbVAmZBP+zb7jyh/CaSZ53V3Oe8WFC3m85wb
 SOtzrVN0cpygbZw99btLzgQX12o8JFQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-p1lmLlWUP26elnNAp9zNOQ-1; Fri,
 27 Jun 2025 05:59:07 -0400
X-MC-Unique: p1lmLlWUP26elnNAp9zNOQ-1
X-Mimecast-MFC-AGG-ID: p1lmLlWUP26elnNAp9zNOQ_1751018346
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B29D7180028A; Fri, 27 Jun 2025 09:59:05 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9DE7E19560A7; Fri, 27 Jun 2025 09:59:00 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 gustavo.romero@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v4 31/32] tests/qtest/bios-tables-test: Add aarch64 ACPI PCI
 hotplug test
Date: Fri, 27 Jun 2025 11:55:20 +0200
Message-ID: <20250627095620.3300028-32-eric.auger@redhat.com>
In-Reply-To: <20250627095620.3300028-1-eric.auger@redhat.com>
References: <20250627095620.3300028-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

---
v3 -> v4:
- add -device pci-testdev for the first test case
- fix the chassis
- add a test for static acpi-index
---
 tests/qtest/bios-tables-test.c | 52 ++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 0b2bdf9d0d..fbb56f6422 100644
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
@@ -2580,6 +2628,10 @@ int main(int argc, char *argv[])
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


