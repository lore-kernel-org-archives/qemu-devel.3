Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE39CD342E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 13:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slThs-0001DF-EA; Tue, 03 Sep 2024 09:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slThp-0001BU-7g
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 09:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slThm-0005Lj-Ni
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 09:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725370581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zPvQpTk5rSXcciAXaX4nWK0XiQ3vCA57Wt8c7vKs+IE=;
 b=SGIRkNMMw98VPim4GvP8cfRnWAUnPLoGz0ezUMg/lmagdkqaUkUDAKF5yMPhun0uHGSzCU
 XpRo9QAAUY/xI/MYPdkm+JLKKPhpE/dZ9i44geibqtvJHjXtr+P/+Go9PUCQSJNYSsohkw
 QUvEnqbgv7+IqtntXSnkskvwXX70uW8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-5Yk6umckOVCQC0IyIDDWSQ-1; Tue,
 03 Sep 2024 09:36:17 -0400
X-MC-Unique: 5Yk6umckOVCQC0IyIDDWSQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A51281954B19; Tue,  3 Sep 2024 13:36:16 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.86])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 21A791956048; Tue,  3 Sep 2024 13:36:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
	qemu-trivial@nongnu.org
Subject: [PATCH] tests/qtest/boot-order-test: Make the machine name mandatory
 in this test
Date: Tue,  3 Sep 2024 15:36:13 +0200
Message-ID: <20240903133613.204608-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Let's make sure that we always pass a machine name to the test_boot_orders()
function, so we can check whether the machine is available in the binary
and skip the test in case it is not included in the build.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/boot-order-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/boot-order-test.c b/tests/qtest/boot-order-test.c
index 8f2b6ef05a..c67b8cfe16 100644
--- a/tests/qtest/boot-order-test.c
+++ b/tests/qtest/boot-order-test.c
@@ -31,7 +31,7 @@ static void test_a_boot_order(const char *machine,
     uint64_t actual;
     QTestState *qts;
 
-    if (machine && !qtest_has_machine(machine)) {
+    if (!qtest_has_machine(machine)) {
         g_test_skip("Machine is not available");
         return;
     }
@@ -107,7 +107,7 @@ static const boot_order_test test_cases_pc[] = {
 
 static void test_pc_boot_order(void)
 {
-    test_boot_orders(NULL, read_boot_order_pc, test_cases_pc);
+    test_boot_orders("pc", read_boot_order_pc, test_cases_pc);
 }
 
 static uint64_t read_boot_order_pmac(QTestState *qts)
-- 
2.46.0


