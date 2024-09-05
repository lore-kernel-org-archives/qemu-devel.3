Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8078CD5BB8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 19:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smHwU-0001Ka-Ko; Thu, 05 Sep 2024 15:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smHwT-0001H2-Of
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smHwS-0000Mz-AF
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725563691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zPvQpTk5rSXcciAXaX4nWK0XiQ3vCA57Wt8c7vKs+IE=;
 b=IkPWCk8WUGEzFkUFHUXvD/VcPznVDi/J5B0bLs2qJUiutvYCm6uDYalm0oiE3h5QdoF4vp
 AW02XnpuMgYl1Dnpqk02qQIiBI7UreCdsUN5ajBVRiPc+QeyOgMRXrt1ZYSkwqO8X/vCcT
 OlBE4S0DfbuywAmxH6JqR4qE7SUWUBY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-qiPNcSPtOyu_sXudurHkeg-1; Thu,
 05 Sep 2024 15:14:48 -0400
X-MC-Unique: qiPNcSPtOyu_sXudurHkeg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B8971955D4E; Thu,  5 Sep 2024 19:14:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A7F9B1956056; Thu,  5 Sep 2024 19:14:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/8] tests/qtest/boot-order-test: Make the machine name
 mandatory in this test
Date: Thu,  5 Sep 2024 21:14:29 +0200
Message-ID: <20240905191434.694440-4-thuth@redhat.com>
In-Reply-To: <20240905191434.694440-1-thuth@redhat.com>
References: <20240905191434.694440-1-thuth@redhat.com>
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
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


