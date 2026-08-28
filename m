Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA1BC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvLA-0007Mu-66; Fri, 28 Aug 2026 08:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvL0-0006zn-3F
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:05:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvKy-0002ij-Ej
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=awsGiKws/Oc72EBonW3yVf4RQnkpQdBbgtMuliluxhg=;
 b=Sm+8he8GnlPi2ZakUHNUYi1XfyZb8334tWU+it6xtGtOm2vuZzags1HVpDdnEoGdTBxUk1
 gXF628dK6AyKCD64XDIMjBeQMCs4lonQEB5gj6efCEPbKwKQ/KQFy2ptzv5Jl8g3Spw22i
 OCBAWDrVUJe1UWZse5l6nd4HtfwUXN0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-PgcfouBfNn-G0HC1jXgi-A-1; Fri,
 28 Aug 2026 08:05:31 -0400
X-MC-Unique: PgcfouBfNn-G0HC1jXgi-A-1
X-Mimecast-MFC-AGG-ID: PgcfouBfNn-G0HC1jXgi-A_1787918730
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39591180256E; Fri, 28 Aug 2026 12:05:30 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C0A351800644; Fri, 28 Aug 2026 12:05:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:10 +0400
Subject: [PATCH v5 13/50] tests/qtest/qmp-test: don't depend on
 human-monitor-command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-13-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk4RX9vAYTAUmIc90G2PglkkEG8Pk8uk5ap1
 JGwxw/I3zyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OAAKCRDa6OEJdZac
 5QrjD/9sD5NlORoj6lFzlP2AZGdT12ITV+5we6YPiH5cnajy1cZEmcoRb+ttwF5hsC9jP4F8/N5
 /tjCvhKVK+TZDXDzyz/uBlzLuusEeBh1NxkeRnN5AM+vuH/QB8TEiVokiILdzWVworX8wTFZkgU
 UastcGTX8xybImMEiFaxiiUr1iW75cv6tpyXIjT3AIJ3fABbySx04Tn9AAfiR7L6UywhqLsiW4E
 QMLhygxJmBoiN4u/CESX14SsVcn6PBIPrXKq1vuIvsCisSygOtJ4F4gx2L4nLRG0Sp9zv2lebrr
 jg6FIpI843B8SVrOEMWp/TOLjUlq2dJm+WkUmrLdHt3RmKIDZ4EbQKXwnZVDHKEUMCtZxoHEjnM
 LMOyUEyFDeR+oLcQ8npN10L8JGExhBL7L7VzkNA6Th/pDLSjRMLN24CWAvPuXbKTRginDX7sozq
 3HKT8EFydg7yqV0YBsdKP8Om7/JKVLeSM7TZG0vDpcyL4yUpqlTZzoX/E7Qso8btnplmSjtrLqq
 vvDrzBQQfS1KCNG40UqBMZbTZwoXbiDv0UvxZLTLx2YnzbJzF+NG6hfjAQHccc9f5L8wWl/vKmV
 2awsA7rKleu+xlOyw8eiT/M5Drjfk8nveiOPU3Jg9HvBC8P5o63No+9aC1awF+sBOrMCpcy7m8e
 Z331FI/h/Eyuvgw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


