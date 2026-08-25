Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15F9C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywYB-0004qs-3M; Tue, 25 Aug 2026 15:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywY2-0004a4-Fo
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:11:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywXz-0003wy-0C
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=awsGiKws/Oc72EBonW3yVf4RQnkpQdBbgtMuliluxhg=;
 b=QR9Pkfv9FuCpRRVSddVMVzPdSHFuyaodxm8YBcmv09T5Ma52AAAkNigE6pY/XKx2xxC4uv
 f89Kq7U/rzMB/x/WQtSR5TiAdK8HhtiKVmhijGygDXwMDcsDkgaJ+Udyn3KDI7UbTm8vyx
 /spv+BOViLMgl+C+7jL0eNk/H7BpVkM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-bFGl94X-OoK8jtqsNk29AQ-1; Tue,
 25 Aug 2026 15:10:54 -0400
X-MC-Unique: bFGl94X-OoK8jtqsNk29AQ-1
X-Mimecast-MFC-AGG-ID: bFGl94X-OoK8jtqsNk29AQ_1787685053
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF5C6184B3AE; Tue, 25 Aug 2026 19:10:52 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 00FFC1944B2A; Tue, 25 Aug 2026 19:10:51 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:20 +0400
Subject: [PATCH v4 13/49] tests/qtest/qmp-test: don't depend on
 human-monitor-command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-13-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2187;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=LYlALLNnLGBmvLJkUw/CVWFy33xbwEoBffB+2rz9Cl0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiHBJXrrO8hT9LJImCxzq/rvNFPv2J4yLP+7
 OR/SYaNr3uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3ohwAKCRDa6OEJdZac
 5bdsD/0bEu+4Z/zgvGSZYEEi6qhH2oAtfw+Hba0KPRRrRcir9I2HtCTf/L2XI3V35pWlmbtfjrr
 eZBhp12TpM6keXXOWBVY8eJ3aax9gZ5gt57GJlhkkUlVoAu3mCS8SF2NQHxue04th001WkfKUs7
 g8q7uHKlWjgCEip7+qq2eKRDMjflN67EV7uJ4vEYFZKNzXWsvJDGKVsXdTOXx8qLN22xfltCakz
 q5M/1ozWx+u524c3KL9SyNOKm6di/7yRPfO9WpOkcasl7Uk2BbMBvaxHXx4R/LyfdDhns3B3VRB
 2B8FcTM6uCOTGGccYkqHJ7N1xTRLt9jKM5rgTxEdPzF2cGVn6ulSmnf/GP6pfz/5g1O18T1k53X
 kDzrrCvTbI+KPa8JNByJJYTV4X+I1tRlBT55KccdQHjG8WV4FwB/Iu/9Qfoas5DZYp/yI9NBOBN
 MIX0T71rClJgLXcRkbW92FsuxysHGja4+pn115M/hOls4RBhZVTDUOAgjea/jXDVBA+qVe7qbmO
 xp35WyoyBuwqi4mosG6FcLpDRPAkz+7CMUchvNxr/6iy3vBovxpb/bbnbhqhjiNDoYTMttdocSz
 4J54OFKAWJjquAjLSAYkx/Mf6PwYiA86OIWaRu3pAQnzpu+GJFrEC7FadnuOkbRE90lYUTlNTqf
 5/2qIV7aZ7PZC/Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The test was using 'human-monitor-command' (which requires HMP) to
verify that an integer 'id' is echoed back on failure. Replace with
'query-name' for the success case and 'block_resize' (missing
required args) for the failure case, so the test works regardless of
HMP availability.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/qmp-test.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/qmp-test.c b/tests/qtest/qmp-test.c
index 3a325a04e07b..927ab053f8ab 100644
--- a/tests/qtest/qmp-test.c
+++ b/tests/qtest/qmp-test.c
@@ -151,9 +151,14 @@ static void test_qmp_protocol(void)
     g_assert_cmpstr(qdict_get_try_str(resp, "id"), ==, "cookie#1");
     qobject_unref(resp);
 
-    /* Test command failure with 'id' */
-    resp = qtest_qmp(qts, "{ 'execute': 'human-monitor-command', 'id': 2 }");
+    /* Test integer 'id' is echoed back on success */
+    resp = qtest_qmp(qts, "{ 'execute': 'query-name', 'id': 2 }");
     g_assert_cmpint(qdict_get_int(resp, "id"), ==, 2);
+    qobject_unref(resp);
+
+    /* Test integer 'id' is echoed back on failure */
+    resp = qtest_qmp(qts, "{ 'execute': 'block_resize', 'id': 3 }");
+    g_assert_cmpint(qdict_get_int(resp, "id"), ==, 3);
     qmp_expect_error_and_unref(resp, "GenericError");
 
     qtest_quit(qts);
@@ -487,6 +492,7 @@ static void test_qmp_monitor_remove_cli(void)
     qtest_quit(qts);
 }
 
+#ifdef CONFIG_HMP
 static void test_qmp_monitor_remove_hmp(void)
 {
     QTestState *qts;
@@ -504,6 +510,7 @@ static void test_qmp_monitor_remove_hmp(void)
 
     qtest_quit(qts);
 }
+#endif
 
 int main(int argc, char *argv[])
 {
@@ -521,7 +528,9 @@ int main(int argc, char *argv[])
     qtest_add_func("qmp/monitor-chardev-in-use",
                     test_qmp_monitor_chardev_in_use);
     qtest_add_func("qmp/monitor-remove-cli", test_qmp_monitor_remove_cli);
+#ifdef CONFIG_HMP
     qtest_add_func("qmp/monitor-remove-hmp", test_qmp_monitor_remove_hmp);
+#endif
 
     return g_test_run();
 }

-- 
2.55.0.543.g5ebe2ebe4ea8


