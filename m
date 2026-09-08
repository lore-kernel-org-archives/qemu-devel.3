Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF164C79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3sVH-0004F3-G7; Tue, 08 Sep 2026 05:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3sVF-0004ET-MC
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:52:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3sVD-0002fO-VU
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788861151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cr17daom5ZIwPL1Jm52XNja1f8W6vz7SjHDPV0FRzto=;
 b=IdTDqeuC4oSlqrJ/z4Y7IGDaFUs0C5lHwgZ0Cgk6E3Q9uKLNTcyM5D8ZTyYG+KvS0Z0S9E
 4vwgdjo5yfxpO0sdXKgDcG10ZXkslVHejbT9TzzdiKGKp7lAD7ptP6vW1a1sP6+2YrxJjz
 hH0OdBLKVpSTXaMz3qF+7/A0FMI28ls=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-YTaPbeicNOSzV8ltABnHZw-1; Tue,
 08 Sep 2026 05:52:28 -0400
X-MC-Unique: YTaPbeicNOSzV8ltABnHZw-1
X-Mimecast-MFC-AGG-ID: YTaPbeicNOSzV8ltABnHZw_1788861147
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 682451834531; Tue,  8 Sep 2026 09:52:27 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D6611955F0C; Tue,  8 Sep 2026 09:52:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 13:51:57 +0400
Subject: [GIT PULL 08/10] tests/drive_del-test: compile out HMP-dependent
 tests when !CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-nohmp-v1-8-b19b693a5665@redhat.com>
References: <20260908-nohmp-v1-0-b19b693a5665@redhat.com>
In-Reply-To: <20260908-nohmp-v1-0-b19b693a5665@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3999;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=nELlHO8Wk8s5vJ916Mup0ugCUbfnyL7FDxtNlquSMtI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqn9q6lnQuthbzQGOYOTU9q35S8aROcjpK6fX7f
 Wdx8FS6cquJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap/augAKCRDa6OEJdZac
 5XcfEACPEmonqJ9mlRiuWIxbMf6ydveucWr/fOqySO3WNX98ufc1h6uBbIFG4tQGju/PJ51rlYw
 D/tkJkfDoXOmrXSoT4U3825g48FjSatOQaumlTwps8B9IHaWloc8uxTegm/6nCRzY5mD5GLK9Ql
 LTA1yv0a7TXvy67LDhbtfNWL4PK2V7gvLEardVOIHma+I+VM6Gr2FsH7j1aEO+2TnXYEZ421vUU
 3Uxg8/dQypFwB5mUR4KknZ9oRdixOR3R6tlTs3ucpECbvjC12Uq9CogbeRo1W69YCacAyNk8L49
 7PLpIZ4E55Sdwc02BlH20Q7j9TYzgDEORKajRue8GkySnaBmJI4u3KWprpzZSBM/EJKelKWBE+G
 9ergsf2KOAspsLBQ0RhutLOzmB3lUQxoSrXCEw+0S7DfQV8ZmdZxhKZyV+Ib35tOHMcTIUinOEQ
 1H7Z3o1+74vog7Th83rP+NWnmXuPcQWmQrq16Ibne2g/bK0TsRBPOkkfL2h8aQFNFQgAxnilnAm
 gyeiaWmne6GiQd+E4vrTbXlQYv7zOLZwtwsrGvcUexGjrPyhtTS0NNPmacDzluzzHpfRFtBIOlk
 U7mnk87/t852nEPioeT+iygpsZqFmOjrTeHtqrXrJynZ0T7026pia2uzcaVwyLaxn6um3kWJp48
 lqv8CiFyz6LmiRw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

The compiled-out functions are actually testing HMP-specific commands
and behaviour which operate on the old "drive" concept. The QMP
equivalent for block-driver nodes are already tested.

If HMP goes away, those tests should go away too. Compile them out.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/drive_del-test.c | 47 +++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/tests/qtest/drive_del-test.c b/tests/qtest/drive_del-test.c
index cc52c2d87936..cbf94d5b9f0f 100644
--- a/tests/qtest/drive_del-test.c
+++ b/tests/qtest/drive_del-test.c
@@ -87,6 +87,7 @@ static void blockdev_add_with_media(QTestState *qts)
     g_assert(has_blockdev(qts));
 }
 
+#ifdef CONFIG_HMP
 static void drive_add(QTestState *qts)
 {
     char *resp = qtest_hmp(qts, "drive_add 0 if=none,id=drive0");
@@ -117,6 +118,7 @@ static void drive_del(QTestState *qts)
     g_assert(!has_drive(qts));
     g_free(resp);
 }
+#endif
 
 /*
  * qvirtio_get_dev_type:
@@ -165,13 +167,9 @@ static void device_del(QTestState *qts, bool and_reset)
 
 static void test_drive_without_dev(void)
 {
+#ifdef CONFIG_HMP
     QTestState *qts;
 
-#ifndef CONFIG_HMP
-    g_test_skip("HMP not enabled");
-    return;
-#endif
-
     /* Start with an empty drive */
     qts = qtest_init("-drive if=none,id=drive0 -M none");
 
@@ -184,19 +182,18 @@ static void test_drive_without_dev(void)
     drive_add(qts);
 
     qtest_quit(qts);
+#else
+    g_test_skip("HMP not enabled");
+#endif
 }
 
 static void test_after_failed_device_add(void)
 {
+#ifdef CONFIG_HMP
     char driver[32];
     QDict *response;
     QTestState *qts;
 
-#ifndef CONFIG_HMP
-    g_test_skip("HMP not enabled");
-    return;
-#endif
-
     if (!has_device_builtin("virtio-blk")) {
         g_test_skip("Device virtio-blk is not available");
         return;
@@ -227,17 +224,16 @@ static void test_after_failed_device_add(void)
     drive_add(qts);
 
     qtest_quit(qts);
+#else
+    g_test_skip("HMP not enabled");
+#endif
 }
 
 static void test_drive_del_device_del(void)
 {
+#ifdef CONFIG_HMP
     QTestState *qts;
 
-#ifndef CONFIG_HMP
-    g_test_skip("HMP not enabled");
-    return;
-#endif
-
     if (!has_device_builtin("virtio-scsi")) {
         g_test_skip("Device virtio-scsi is not available");
         return;
@@ -259,6 +255,9 @@ static void test_drive_del_device_del(void)
     g_assert(!has_drive(qts));
 
     qtest_quit(qts);
+#else
+    g_test_skip("HMP not enabled");
+#endif
 }
 
 static void test_cli_device_del(void)
@@ -416,15 +415,11 @@ static void test_device_add_and_del_q35(void)
 
 static void test_drive_add_device_add_and_del(void)
 {
+#ifdef CONFIG_HMP
     QTestState *qts;
     const char *arch = qtest_get_arch();
     const char *machine_addition = "";
 
-#ifndef CONFIG_HMP
-    g_test_skip("HMP not enabled");
-    return;
-#endif
-
     if (!has_device_builtin("virtio-blk")) {
         g_test_skip("Device virtio-blk is not available");
         return;
@@ -450,17 +445,16 @@ static void test_drive_add_device_add_and_del(void)
     g_assert(!has_drive(qts));
 
     qtest_quit(qts);
+#else
+    g_test_skip("HMP not enabled");
+#endif
 }
 
 static void test_drive_add_device_add_and_del_q35(void)
 {
+#ifdef CONFIG_HMP
     QTestState *qts;
 
-#ifndef CONFIG_HMP
-    g_test_skip("HMP not enabled");
-    return;
-#endif
-
     if (!has_device_builtin("virtio-blk")) {
         g_test_skip("Device virtio-blk is not available");
         return;
@@ -479,6 +473,9 @@ static void test_drive_add_device_add_and_del_q35(void)
     g_assert(!has_drive(qts));
 
     qtest_quit(qts);
+#else
+    g_test_skip("HMP not enabled");
+#endif
 }
 
 static void test_blockdev_add_device_add_and_del(void)

-- 
2.55.0.543.g5ebe2ebe4ea8


