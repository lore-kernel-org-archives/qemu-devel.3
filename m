Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0276C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ZBI-0004gY-NH; Mon, 07 Sep 2026 09:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3ZBG-0004YV-Eb
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:14:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3ZBE-0006Xf-Q0
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788786876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aoHiToUGAMMc7R5tO/URvtcB1gdA7zvemloBOxAK2DI=;
 b=cqtDd2Vu7J0B72aMdY42wH2bam0+n60KEt/1yl6ilKn7yWq69rZPnXIVsS4QhC2zHjtVPE
 MZHdCbEfEygUwBMpiWTM0j5W1RcWRJEUNFFYgmmDP+y4bPnqbKfkUfx89hhlcWEZlrItD3
 eepqe6fMwxtQQdn781DgtTU4aZ6Z+6I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-ngI4UzHXPceQ6iyR-MDQOQ-1; Mon,
 07 Sep 2026 09:14:32 -0400
X-MC-Unique: ngI4UzHXPceQ6iyR-MDQOQ-1
X-Mimecast-MFC-AGG-ID: ngI4UzHXPceQ6iyR-MDQOQ_1788786870
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5C3D1955F1D; Mon,  7 Sep 2026 13:14:30 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 62C39423; Mon,  7 Sep 2026 13:14:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 17:14:01 +0400
Subject: [PATCH v3 7/9] tests/ide-test: convert to QMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-nohmp-v3-7-c11e7d0d3d7d@redhat.com>
References: <20260907-nohmp-v3-0-c11e7d0d3d7d@redhat.com>
In-Reply-To: <20260907-nohmp-v3-0-c11e7d0d3d7d@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnriY0PUf6M8fi7Yo84q5+2kn/3saU3J0Z0lc+
 QnhKk/C2sWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap64mAAKCRDa6OEJdZac
 5bLRD/oDURKyg/Z+/r3WqZ2c/V+Et9BhE9UmWNm0XgliwVW2IC4U4iBd05/dc5Jdr5IWYJxxKOb
 VGIrvAeOL6f+PmWlf4r4zk+jmExysQ4eR/okI2hsi1/m93ZkFo+Y0vs2JbkkDy8aufUNoekEVo6
 ZYQaSYP4EgIAikqpffI8jS1heWLVDQs7KB/q0sS1c4QRHRz/71DCCGS2J1g3T+ej30/9MDW0KnA
 m+EBjkPeikVEwuFfrqDgcRSyOc6SxLL6Cvls5e+Dd+0DY+ju0FW1RNHOzLxSwVRAUkk1LaTbyo4
 todxqaV10bfzMq0M/v/SyTJZCfXPrCUBuQff2kL9neiX4uyN5PTk/aTllm0heaesruzlq5U3UbX
 N+Q1WrOrA5PIZ/hJsRhvdU9SqqTGF4dFgV27AH+upGrG+P2PlGRuc+357wDA2jdmHNttCkfQlSo
 tQl+nDRa6flu+l/ykEG1+bQGlRESlERqo8CMXvSOxsm1yiJdlrNeFtSNCZBT8VDI9o54Rwpq8CT
 O9nFcCUdqZoEzloh4nWGgO9s/rfKtlWWgrvky/NtM+SMtIa9eIXB2vCU7e5Xk0q0JztEQ9nqAtB
 hDB1/MeM0HU/rWDFAm/tVhQ17rfh5CQiNf9uy5W2jdBwzwaFWJAHyHiQKoS+Vn8clPWPs5tUSZa
 3c69NPN3yzR7PMA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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


