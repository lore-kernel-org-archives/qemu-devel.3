Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB035C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Wj8-0000Yr-36; Mon, 07 Sep 2026 06:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wit-0000RW-Fd
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:37:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wip-00049P-CD
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788777426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aoHiToUGAMMc7R5tO/URvtcB1gdA7zvemloBOxAK2DI=;
 b=gho997t8tcCWXJa1psyKtSmSfYdNHn83qzhZFq1bFifz+zOPSmUH0reDYi6eQ+E5gGKQQe
 9KC5TBZp+AB3qWqrt6apsNxbAdRfqstUWHjqFzsw+2TifhHniq2Y8uYfz5lLNCh/x5+QRv
 vxwJreDdaufwOg/+J47z9QhJ6EbaWT4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-AjuZHCY1N5CwksmNfsie7w-1; Mon,
 07 Sep 2026 06:30:58 -0400
X-MC-Unique: AjuZHCY1N5CwksmNfsie7w-1
X-Mimecast-MFC-AGG-ID: AjuZHCY1N5CwksmNfsie7w_1788777056
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91D411955BDE; Mon,  7 Sep 2026 10:30:56 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 99CCB180034F; Mon,  7 Sep 2026 10:30:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:30:25 +0400
Subject: [PATCH v2 07/10] tests/ide-test: convert to QMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-nohmp-v2-7-6d952d972c21@redhat.com>
References: <20260907-nohmp-v2-0-6d952d972c21@redhat.com>
In-Reply-To: <20260907-nohmp-v2-0-6d952d972c21@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2957;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bnu0nsKu9/3amglgx/1TloBIQkah/oVYczwxwKZZtsQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpJDIguFS6UsqZjosZ8Is5fI62UldYUvTkTV0
 VXsaBFY/MKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6SQwAKCRDa6OEJdZac
 5W74D/9uXZpMXFIx/zhfF4oy4OJ49taEpOr3v+iVrjqvOUBZYiBOYfttXxQmeFB3bVLcP64/NBQ
 ipmM+ttmXkEz1UsQQLbcg2uRXUFJsoKxLWju36TGL7pwGFf7PF/K7cnTc1224Rk+b0tZaNCsLKC
 55vtM4lhzY2e1MXFAxSgnQ9DntIVl7R5dQy3KG7ABcnL5Ay3SBH70E8G83oYsRJU2RQd8vbGviq
 EEQg9fGUeMXwAEq2uMU5g/QseSQRVJuzAnFHW15wbmvKBJSl7GtMRpPRJ/eAYsPQmbLW8JQXStW
 rAb0OzTGVzLxqsBacRcX9tpRuE7fE+xRIRo3LD7T63rdyh1QqaDKmGIMeeBo4QiJOOTJFPCjQei
 K1hDmny1jA2eEYISD3UL7BoOq1dkbtcQjK2KCfbj4nwiQN+NP5ueL8mPUnaqmzBbDqbhSVC4CYs
 TpTRwG+3X6YJv7m3NuWenKMAypll42dFoCklXg6ncA17HdbKLGcVFn4pUeiJd+3wfQ5PoT8dj64
 KGmKtmlEZg1OE8KHQ8hlds/2Cje8VHOY/XE1wrDZmS1TST2YfX8g+o9p/WrBOfCcuT4/Yhj3EiA
 DKHSwEYLK4ZX2OD/cvemjqbTrmtlNCplHcgw3HDyW6Quy/eMBNl8+mYUiNY9IV6DNalUbIcY6ru
 ZuuWQtvDZMupftQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


