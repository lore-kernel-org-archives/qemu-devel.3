Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0211CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 09:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3WIG-0007xS-6g; Tue, 30 Sep 2025 05:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3WIC-0007xJ-Mq
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3WI7-0004W2-Lb
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759223091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=K7OcregwWwev1spFlVX+pUwSh3UzPm2H6Gin4pIfkVk=;
 b=InLlccJ2/hgbR3xLI22r6PDoLgEBkw08Yg/n/s8nr4qpMbi6TgtBl66pOHUrz3oi/2PvJE
 sfvtK7thaz65rtHn3DFbNDO5Nf5QUvLy5fB600t/5g260a9ifBvgveFDFB0j0CoIMF9Hmg
 3FLh3RTH8xDT4wVXeZ8g3z8KK2VWeGg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-D6qYKMxyPCyBMjklBnIzwQ-1; Tue,
 30 Sep 2025 05:04:49 -0400
X-MC-Unique: D6qYKMxyPCyBMjklBnIzwQ-1
X-Mimecast-MFC-AGG-ID: D6qYKMxyPCyBMjklBnIzwQ_1759223088
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AAA618002D6; Tue, 30 Sep 2025 09:04:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.89])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 282001956095; Tue, 30 Sep 2025 09:04:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Fabiano Rosas <farosas@suse.de>,
	qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] tests/qtest: Add missing checks for the availability of
 machines
Date: Tue, 30 Sep 2025 11:04:44 +0200
Message-ID: <20250930090444.234431-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

When QEMU has been compiled with "--without-default-devices", the
machines might not be available in the binary. Let's properly check
for the machines before running the tests to avoid that they are
failing in this case.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/bios-tables-test.c | 2 +-
 tests/qtest/cpu-plug-test.c    | 2 +-
 tests/qtest/riscv-csr-test.c   | 4 +++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 4fa8ac5096a..6b892ef23e1 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2864,7 +2864,7 @@ int main(int argc, char *argv[])
                            test_acpi_riscv64_virt_tcg_acpi_spcr);
         }
     } else if (strcmp(arch, "loongarch64") == 0) {
-        if (has_tcg) {
+        if (has_tcg && qtest_has_machine("virt")) {
             qtest_add_func("acpi/virt", test_acpi_loongarch64_virt);
             qtest_add_func("acpi/virt/topology",
                            test_acpi_loongarch64_virt_topology);
diff --git a/tests/qtest/cpu-plug-test.c b/tests/qtest/cpu-plug-test.c
index 44d704680b1..0aa4ccc5b61 100644
--- a/tests/qtest/cpu-plug-test.c
+++ b/tests/qtest/cpu-plug-test.c
@@ -190,7 +190,7 @@ int main(int argc, char **argv)
         qtest_cb_for_every_machine(add_pseries_test_case, g_test_quick());
     } else if (g_str_equal(arch, "s390x")) {
         qtest_cb_for_every_machine(add_s390x_test_case, g_test_quick());
-    } else if (g_str_equal(arch, "loongarch64")) {
+    } else if (g_str_equal(arch, "loongarch64") && qtest_has_machine("virt")) {
         add_loongarch_test_case("virt");
     }
 
diff --git a/tests/qtest/riscv-csr-test.c b/tests/qtest/riscv-csr-test.c
index ff5c29e6c6f..bb1b0ffed30 100644
--- a/tests/qtest/riscv-csr-test.c
+++ b/tests/qtest/riscv-csr-test.c
@@ -50,7 +50,9 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
-    qtest_add_func("/cpu/csr", run_test_csr);
+    if (qtest_has_machine("virt")) {
+        qtest_add_func("/cpu/csr", run_test_csr);
+    }
 
     return g_test_run();
 }
-- 
2.51.0


