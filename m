Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E732DC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4iZ-0005y3-2M; Tue, 12 Mar 2024 12:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rk4iU-0005x1-5n
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:11:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rk4iR-000790-H4
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710259857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zrOfTp4lXNJjHFK37vxizV4ejdSxQomjIbB/lBZGO04=;
 b=igafqrvUjpq40YUBZExoEop3JK8aUaKEzOLTkx++posOchspfSLAnBW7wDwSJ6yEdnEzUb
 bBZ6r92txNnTjGhpr1sCVEpg2ihwfZjovfVMZq1kOh1dz/nDjlxZftkgLcVbVfJdcJvXXl
 Sjn3yU3v/MmJULvb9Z6eaath5aYJMpg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-Fi7SKRRVOdua3BnMuQ3EmQ-1; Tue,
 12 Mar 2024 12:10:54 -0400
X-MC-Unique: Fi7SKRRVOdua3BnMuQ3EmQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EF282804809;
 Tue, 12 Mar 2024 16:10:54 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 39B913C23;
 Tue, 12 Mar 2024 16:10:53 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, mst@redhat.com, Ani Sinha <anisinha@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: [PATCH v3 01/20] tests: smbios: make it possible to write SMBIOS only
 test
Date: Tue, 12 Mar 2024 17:10:31 +0100
Message-Id: <20240312161050.2248814-2-imammedo@redhat.com>
In-Reply-To: <20240312161050.2248814-1-imammedo@redhat.com>
References: <20240312161050.2248814-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Cureently it not possible to run SMBIOS test without ACPI one,
which gets into the way when testing ACPI-less configs.

Extract SMBIOS testing into separate routines that could also
be run without ACPI dependency and use that for testing SMBIOS.

As the 1st user add "acpi/piix4/smbios-options" test case.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
---
 tests/qtest/bios-tables-test.c | 47 +++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 21811a1ab5..b2992bafa8 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -858,16 +858,8 @@ static void test_vm_prepare(const char *params, test_data *data)
     g_free(args);
 }
 
-static void process_acpi_tables_noexit(test_data *data)
+static void process_smbios_tables_noexit(test_data *data)
 {
-    test_acpi_load_tables(data);
-
-    if (getenv(ACPI_REBUILD_EXPECTED_AML)) {
-        dump_aml_files(data, true);
-    } else {
-        test_acpi_asl(data);
-    }
-
     /*
      * TODO: make SMBIOS tests work with UEFI firmware,
      * Bug on uefi-test-tools to provide entry point:
@@ -879,6 +871,27 @@ static void process_acpi_tables_noexit(test_data *data)
     }
 }
 
+static void test_smbios(const char *params, test_data *data)
+{
+    test_vm_prepare(params, data);
+    boot_sector_test(data->qts);
+    process_smbios_tables_noexit(data);
+    qtest_quit(data->qts);
+}
+
+static void process_acpi_tables_noexit(test_data *data)
+{
+    test_acpi_load_tables(data);
+
+    if (getenv(ACPI_REBUILD_EXPECTED_AML)) {
+        dump_aml_files(data, true);
+    } else {
+        test_acpi_asl(data);
+    }
+
+    process_smbios_tables_noexit(data);
+}
+
 static void process_acpi_tables(test_data *data)
 {
     process_acpi_tables_noexit(data);
@@ -2064,6 +2077,20 @@ static void test_acpi_q35_pvpanic_isa(void)
     free_test_data(&data);
 }
 
+static void test_acpi_pc_smbios_options(void)
+{
+    uint8_t req_type11[] = { 11 };
+    test_data data = {
+        .machine = MACHINE_PC,
+        .variant = ".pc_smbios_options",
+        .required_struct_types = req_type11,
+        .required_struct_types_len = ARRAY_SIZE(req_type11),
+    };
+
+    test_smbios("-smbios type=11,value=TEST", &data);
+    free_test_data(&data);
+}
+
 static void test_oem_fields(test_data *data)
 {
     int i;
@@ -2215,6 +2242,8 @@ int main(int argc, char *argv[])
 #ifdef CONFIG_POSIX
             qtest_add_func("acpi/piix4/acpierst", test_acpi_piix4_acpi_erst);
 #endif
+            qtest_add_func("acpi/piix4/smbios-options",
+                           test_acpi_pc_smbios_options);
         }
         if (qtest_has_machine(MACHINE_Q35)) {
             qtest_add_func("acpi/q35", test_acpi_q35_tcg);
-- 
2.39.3


