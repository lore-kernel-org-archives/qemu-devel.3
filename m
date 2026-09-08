Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4C6C79FAD
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3sVE-0004ED-2k; Tue, 08 Sep 2026 05:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3sVC-0004Do-El
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3sVA-0002eR-TC
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788861148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xyU9QwTUbB5vxuqM2nqh/iZX1DasxSImd4r33FMozgY=;
 b=QLQhqnxM0ZoEmUwZhOCgSqE/l5ux8bHFnPjq4DHGxQo75NT5KVAdoTt7u1NJ6iyaSETPY6
 V/WNyWPg2FvVDTy09IVEnGp8+BSMrd/patgByn8U8nQE6Dlx4EiWxXXLWxSDAkJ9NY1tKU
 +2groAj2u01OtkJyjg77PKMqHX0s+3w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-uoOTYNKnMk2M5RGn34n4eQ-1; Tue,
 08 Sep 2026 05:52:25 -0400
X-MC-Unique: uoOTYNKnMk2M5RGn34n4eQ-1
X-Mimecast-MFC-AGG-ID: uoOTYNKnMk2M5RGn34n4eQ_1788861144
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA860195E93F; Tue,  8 Sep 2026 09:52:23 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 285911955F0C; Tue,  8 Sep 2026 09:52:22 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 13:51:56 +0400
Subject: [GIT PULL 07/10] tests/ide-test: convert to QMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-nohmp-v1-7-b19b693a5665@redhat.com>
References: <20260908-nohmp-v1-0-b19b693a5665@redhat.com>
In-Reply-To: <20260908-nohmp-v1-0-b19b693a5665@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, John Snow <jsnow@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=3003;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=kpIFIaEUDafx8nYOdubWPhRUqetRVB530kKQpNu5xqU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqn9q6+jW/Bh32/LImquaBaSsXUkWL425dBUDnc
 pTScJd7GieJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap/augAKCRDa6OEJdZac
 5VRUD/4pfBQq6kL/MpcRo+ExGhoCmyA8Z3jLnXYbNCwvrjVa9+9xyRL2TkUIgv6adBtjxQ7CFR5
 ead+zge6M1OkAwdlM6R12dksOhdKl6L/WgM91Bbvewz155jSivNGBhsnX2rrgqpNu2p0NBJey2F
 7Xl4OBCE9nXyf3It0HHsxwXCeTKq29eIKW41O6iMEhSYUOfn/N9yRictd0roONL/7/k02Wy3hD+
 lwduGQhRBTQRxtnjd2h6LUU7xgLhhdfk2cNPPOjTNwJNQwejmhymJ9TTWIP+/zha6itP97ijGRT
 UPRcVApLErcbHM5ji2q74CIXr1wh0cSslomclYCrl3idye8T0reTGQ2Bo3gJzPfsrH7Un+Hrsmf
 O2i/VkWutPxfJhl+KtMzMOe7nlWYqvzzZxsiFHkbLF1P5PLh1crhpwkp4RTGX02f7CQBmRiIt0d
 HToNVA/XXyycWu8TSqY81D+GhG90LVVnqmxqFh0gBrOve/27mcZYqbqNMJNNFv/8lyLetb2oHST
 Spy8AMBASOqJE2BKqphbAtQdHaEMvkTEC3WXoBaztoD0kP7wVStNAHMruC0KC0sQWUVrqK445Yl
 Aai13knJWCCqp3KA/6tAmajlqig4qJqrxC6M7mS5MIoDqNVIfFp01t2gbHp8+QrAeskEZnwf1VM
 0O1C/JKdnEbwLuw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The QMP command is explicit, specify both the vmstate and devices.
We use the helper introduced previously to wait for job completion.

Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/ide-test.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index 895fec6d0806..cf109b079982 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -1345,11 +1345,34 @@ static void ide_prepare_markers(QTestState *qts, QPCIDevice *dev,
     ide_write_marker(qts, dev, ide_bar, 63, CHS_MARKER_DEFAULT);
 }
 
-static void ide_hmp_quiet(QTestState *qts, const char *command)
+static void ide_snapshot_save(QTestState *qts, const char *tag,
+                              const char *vmstate, const char *device)
 {
-    g_autofree char *out = qtest_hmp(qts, "%s", command);
+    qtest_qmp_assert_success(qts,
+        "{ 'execute': 'snapshot-save',"
+        "  'arguments': {"
+        "    'job-id': 'save0',"
+        "    'tag': %s,"
+        "    'vmstate': %s,"
+        "    'devices': [%s]"
+        "  }"
+        "}", tag, vmstate, device);
+    qtest_qmp_job_wait(qts, "save0");
+}
 
-    g_assert_cmpstr(out, ==, "");
+static void ide_snapshot_load(QTestState *qts, const char *tag,
+                              const char *vmstate, const char *device)
+{
+    qtest_qmp_assert_success(qts,
+        "{ 'execute': 'snapshot-load',"
+        "  'arguments': {"
+        "    'job-id': 'load0',"
+        "    'tag': %s,"
+        "    'vmstate': %s,"
+        "    'devices': [%s]"
+        "  }"
+        "}", tag, vmstate, device);
+    qtest_qmp_job_wait(qts, "load0");
 }
 
 static char *ide_migration_status(QTestState *qts)
@@ -1455,10 +1478,6 @@ static void test_migrate_chs_snapshot(void)
     char marker[9];
     int fd;
 
-#ifndef CONFIG_HMP
-    g_test_skip("HMP not enabled");
-    return;
-#endif
     if (!have_qemu_img()) {
         g_test_skip("QTEST_QEMU_IMG not set, snapshots need a qcow2 image");
         return;
@@ -1480,13 +1499,13 @@ static void test_migrate_chs_snapshot(void)
     /* Snapshot taken while the default translation is in effect */
     ide_read_chs_marker(qts, dev, ide_bar, 0, 1, 1, marker);
     g_assert_cmpstr(marker, ==, CHS_MARKER_DEFAULT);
-    ide_hmp_quiet(qts, "savevm s0");
+    ide_snapshot_save(qts, "s0", "hda", "hda");
 
     ide_set_translation(dev, ide_bar, 8, 32);
     ide_read_chs_marker(qts, dev, ide_bar, 0, 1, 1, marker);
     g_assert_cmpstr(marker, ==, CHS_MARKER_CUSTOM);
 
-    ide_hmp_quiet(qts, "loadvm s0");
+    ide_snapshot_load(qts, "s0", "hda", "hda");
 
     ide_read_chs_marker(qts, dev, ide_bar, 0, 1, 1, marker);
     g_assert_cmpstr(marker, ==, CHS_MARKER_DEFAULT);

-- 
2.55.0.543.g5ebe2ebe4ea8


