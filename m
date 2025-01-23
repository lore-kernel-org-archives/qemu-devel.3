Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90B2C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 20:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb4Ac-0002VC-4I; Thu, 23 Jan 2025 15:51:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tb4AZ-0002Un-N6
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 15:51:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tb4AX-0000P6-EP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 15:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737665475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CZrhcr0eXWBl1QZPg+jn6JBjE2nP8ZsK/Q/EafmYm8w=;
 b=Sw8eb4kH21mtdFUEQZ+7x9IBmSgyc+CK7Np/x5UHFQbl22pJJQqLYxAu5hSM06cAgdCnID
 97RC6AUYdhHxwjXp6CHHWIQ9p/MiINcGTkoSAZCYMuMAHaxgKgwGR+dzdWHEwRRbZ0jUZZ
 KzZawiWIVCGYawLZfaCXbtlU1N0NNzA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-riQZfUnsPkiN_lyaGd7aHA-1; Thu,
 23 Jan 2025 15:50:03 -0500
X-MC-Unique: riQZfUnsPkiN_lyaGd7aHA-1
X-Mimecast-MFC-AGG-ID: riQZfUnsPkiN_lyaGd7aHA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87BC81956073; Thu, 23 Jan 2025 20:50:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.98])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B77B195608E; Thu, 23 Jan 2025 20:49:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH] tests/qtest/qom-test: Test retrieval of machine class
 properties
Date: Thu, 23 Jan 2025 21:49:56 +0100
Message-ID: <20250123204956.1561463-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

There were recently some crashes that occurred when trying to
retrieve the properties of machines. Let's add a test to avoid
regression here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Based-on: <20250117192106.471029-1-thuth@redhat.com>
 Based-on: <20250123204708.1560305-1-thuth@redhat.com>
 
 tests/qtest/qom-test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index d677f87c8e..50064ed951 100644
--- a/tests/qtest/qom-test.c
+++ b/tests/qtest/qom-test.c
@@ -88,6 +88,17 @@ static void test_machine(gconstpointer data)
 
     qts = qtest_initf("-machine %s", machine);
 
+    if (g_test_slow()) {
+        /* Make sure we can get the machine class properties: */
+        g_autofree char *qom_machine = g_strdup_printf("%s-machine", machine);
+
+        response = qtest_qmp(qts, "{ 'execute': 'qom-list-properties',"
+                                  "  'arguments': { 'typename': %s } }",
+                             qom_machine);
+        g_assert(response);
+        qobject_unref(response);
+    }
+
     test_properties(qts, "/machine", true);
 
     response = qtest_qmp(qts, "{ 'execute': 'quit' }");
-- 
2.48.1


