Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D8FC624D6
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 17:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uaM-0005I2-Is; Sat, 05 Sep 2026 13:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2uaH-0005EE-CY; Sat, 05 Sep 2026 13:53:45 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2uaD-0008I7-Un; Sat, 05 Sep 2026 13:53:45 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E360144500;
 Sat,  5 Sep 2026 17:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36041F00AC4;
 Sat,  5 Sep 2026 17:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788630812;
 bh=jHK8n1qrvOc4Q7942MjOL/+nZI/aby+kUuZA3CrS3NM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DtMpxe9Tf/6MaeBUcaiX7p83EidvSXpc//F9xrdJ67NUvJM2B6RHiPWGNOhRibykW
 C0hwHR27yRNPX327s+uy0Z9nVFM7ovJEMyaZrm5zVX6QXOqh/Ehdwqr9pH+5UQ0apb
 EhAqAQl7anPVubtiyY6Q1E0qcDuGYKhZ4L+1RB7ge+YG+AF88BX8ZvUdBhXqClkUqy
 7vkas/LTfe2l4J3IimKDNzOAAnalXveRknnCyQBxSA+EVN33hPM/+P/WoQ39S2XlcS
 jExOHZHjOyB57hc/BkAl8dNKW1OJ67z2HZbkG9OQF+wwvOmCVCkjTqLqRPt19OV+Na
 XEifN6nb6Kb3w==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.5)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2ua2-0000000Bks5-3Vr1; Sat, 05 Sep 2026 19:53:30 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 7/8] tests: test GHES notifications on arm64 virt machine
Date: Sat,  5 Sep 2026 19:53:27 +0200
Message-ID: <16e6d6155893f3facb9f258103eea6f9ba4c4818.1788630333.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788630333.git.mchehab+huawei@kernel.org>
References: <cover.1788630333.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

QEMU has support for HEST table since version 9.2. Yet, it currently
lacks a test to check if the HEST table is working.

Add tests for arm64 error inject mechanism, implemented at
QEMU version 10.2.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tests/qtest/bios-tables-test.c | 80 ++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 5cc526510ac1..5582b1dd72e4 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -68,6 +68,7 @@
 
 #define MACHINE_PC "pc"
 #define MACHINE_Q35 "q35"
+#define VIRT_ACPI_GED_BASE 0x09080000
 
 #define ACPI_REBUILD_EXPECTED_AML "TEST_ACPI_REBUILD_AML"
 
@@ -913,6 +914,84 @@ static uint8_t base_required_struct_types[] = {
     0, 1, 3, 4, 16, 17, 19, 32, 127
 };
 
+static void test_acpi_ghes_v2_injection(test_data *data)
+{
+    const uint8_t cper[20] = { [0] = 2, [16] = 2 }; /* corrected GESB */
+    g_autofree char *payload = g_base64_encode(cper, sizeof(cper));
+    uint64_t status_addr, ack_addr;
+    uint8_t actual[sizeof(cper)];
+    QTestState *qts = data->qts;
+    const uint8_t *ghes = NULL;
+    AcpiSdtTable *hest = NULL;
+    AcpiSdtTable *table;
+
+    for (unsigned i = 0; i < data->tables->len; i++) {
+        table = &g_array_index(data->tables, AcpiSdtTable, i);
+
+        if (compare_signature(table, "HEST")) {
+            hest = table;
+            break;
+        }
+    }
+    g_assert_nonnull(hest);
+
+    for (unsigned i = 0; i < ldl_le_p(hest->aml + 36); i++) {
+        const uint8_t *entry = hest->aml + 40 + i * 92;
+
+        g_assert_cmpuint(lduw_le_p(entry), ==, 10); /* GHESv2 */
+        if (lduw_le_p(entry + 2) == 1) { /* QMP source */
+            ghes = entry;
+            break;
+        }
+    }
+    g_assert_nonnull(ghes);
+    g_assert_cmpuint(ghes[32], ==, 7); /* GPIO notification */
+    status_addr = qtest_readq(qts, ldq_le_p(ghes + 24));
+    ack_addr = ldq_le_p(ghes + 68);
+    g_assert_cmphex(status_addr, !=, 0);
+    g_assert_cmphex(ack_addr, !=, 0);
+    g_assert_cmpuint(qtest_readq(qts, ack_addr), ==, 1);
+
+    for (unsigned i = 0; i < 3; i++) {
+        qtest_qmp_assert_success(qts,
+            "{'execute': 'inject-ghes-v2-error', 'arguments': {'cper': %s}}",
+            payload);
+        g_assert_cmpuint(qtest_readq(qts, ack_addr), ==, 0);
+        qtest_memread(qts, status_addr, actual, sizeof(actual));
+        g_assert_cmpmem(actual, sizeof(actual), cper, sizeof(cper));
+
+        /* GED converts the GPIO notification into an Error event. */
+        g_assert_cmphex(qtest_readl(qts, VIRT_ACPI_GED_BASE), ==, 0x20);
+        g_assert_cmphex(qtest_readl(qts, VIRT_ACPI_GED_BASE), ==, 0);
+
+        /* A second injection must wait for OSPM's acknowledgement. */
+        qobject_unref(qtest_qmp_assert_failure_ref(qts,
+            "{'execute': 'inject-ghes-v2-error', 'arguments': {'cper': %s}}",
+            payload));
+        qtest_writeq(qts, ack_addr, 1);
+    }
+}
+
+static void test_acpi_aarch64_virt_ras(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "aarch64",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 128ULL * MiB,
+    };
+
+    test_vm_prepare("-cpu cortex-a57 -machine ras=on", &data);
+    process_acpi_tables_noexit(&data);
+    test_acpi_ghes_v2_injection(&data);
+    qtest_quit(data.qts);
+    free_test_data(&data);
+}
+
 static void test_acpi_piix4_tcg(void)
 {
     test_data data = {};
@@ -2922,6 +3001,7 @@ int main(int argc, char *argv[])
     } else if (strcmp(arch, "aarch64") == 0) {
         if (has_tcg && qtest_has_device("virtio-blk-pci")) {
             qtest_add_func("acpi/virt", test_acpi_aarch64_virt_tcg);
+            qtest_add_func("acpi/virt/ras", test_acpi_aarch64_virt_ras);
             qtest_add_func("acpi/virt/acpihmatvirt",
                            test_acpi_aarch64_virt_tcg_acpi_hmat);
             qtest_add_func("acpi/virt/topology",
-- 
2.55.0


