Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFDAC54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 15:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkmvP-0007F5-8a; Thu, 14 Mar 2024 11:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rkmvN-0007Dg-0Y
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:23:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rkmvL-0003kV-Jy
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710429794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mEysAxw1rtqLbi7QK6dBGnD+kHUMmHQF+OEuJnW7U90=;
 b=YQxgKb4Lufxo7ViCbJ26SqLTRRX7uEaaLnO5sRWAUADHLO23ljLAN1tPOcAapG7idc7vka
 6ZGkOMc2ouy4jtpFp/IG3hEzTB6B6MLnF2vIk9mWQZMPusgRrDtvMRT4nP62W6GOYVsp1U
 uaBM12BbOlYySTkfMvgOgxwArdzkPU0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-ygMa5OFzP46mBn4ww028wg-1; Thu, 14 Mar 2024 11:23:08 -0400
X-MC-Unique: ygMa5OFzP46mBn4ww028wg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 063E9185A789;
 Thu, 14 Mar 2024 15:23:08 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26A8917A8E;
 Thu, 14 Mar 2024 15:23:07 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Ani Sinha <anisinha@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: [PATCH v4 03/21] tests: smbios: add test for legacy mode CLI options
Date: Thu, 14 Mar 2024 16:22:44 +0100
Message-Id: <20240314152302.2324164-4-imammedo@redhat.com>
In-Reply-To: <20240314152302.2324164-1-imammedo@redhat.com>
References: <20240314152302.2324164-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

Unfortunately having 2.0 machine type deprecated is not enough
to get rid of legacy SMBIOS handling since 'isapc' also uses
that and it's staying around.

Hence add test for CLI options handling to be sure that it
ain't broken during SMBIOS code refactoring.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
---
 tests/data/smbios/type11_blob.legacy | Bin 0 -> 10 bytes
 tests/qtest/bios-tables-test.c       |  17 +++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 tests/data/smbios/type11_blob.legacy

diff --git a/tests/data/smbios/type11_blob.legacy b/tests/data/smbios/type11_blob.legacy
new file mode 100644
index 0000000000000000000000000000000000000000..aef463aab903405958b0a85f85c5980671c08bee
GIT binary patch
literal 10
Rcmd;PW!S(N;u;*n000Tp0s;U4

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index a116f88e1d..d1ff4db7a2 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2106,6 +2106,21 @@ static void test_acpi_pc_smbios_blob(void)
     free_test_data(&data);
 }
 
+static void test_acpi_isapc_smbios_legacy(void)
+{
+    uint8_t req_type11[] = { 1, 11 };
+    test_data data = {
+        .machine = "isapc",
+        .variant = ".pc_smbios_legacy",
+        .required_struct_types = req_type11,
+        .required_struct_types_len = ARRAY_SIZE(req_type11),
+    };
+
+    test_smbios("-smbios file=tests/data/smbios/type11_blob.legacy "
+                "-smbios type=1,family=TEST", &data);
+    free_test_data(&data);
+}
+
 static void test_oem_fields(test_data *data)
 {
     int i;
@@ -2261,6 +2276,8 @@ int main(int argc, char *argv[])
                            test_acpi_pc_smbios_options);
             qtest_add_func("acpi/piix4/smbios-blob",
                            test_acpi_pc_smbios_blob);
+            qtest_add_func("acpi/piix4/smbios-legacy",
+                           test_acpi_isapc_smbios_legacy);
         }
         if (qtest_has_machine(MACHINE_Q35)) {
             qtest_add_func("acpi/q35", test_acpi_q35_tcg);
-- 
2.39.3


