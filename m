Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91011C79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 08:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x38T4-0004HE-KO; Sun, 06 Sep 2026 04:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38T3-0004Fo-9G
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:43:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38T0-00088W-Sw
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788684190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iPMpKNoEG3KyFVkbBdwLVVWD99p9PL/HuxMG7+GBKcg=;
 b=LhCI26KgIj3bKMlE+FuLm6FvtCgCrdARC5HWltin5pts7FQxUMqf/iElNm2UTqZ+y1MpOT
 lrZxE3rCgZqEFHiXV92Hkb0HPT8s2rTU4jRRDMKLrTiZt3UM3ji8MyVuJhn0ZjajxQFe/Y
 1KhAjpTiKuzkKcyOnvMUygc3yAVYPWI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-E2zcz9AWM8COprivv0m0Fg-1; Sun,
 06 Sep 2026 04:43:06 -0400
X-MC-Unique: E2zcz9AWM8COprivv0m0Fg-1
X-Mimecast-MFC-AGG-ID: E2zcz9AWM8COprivv0m0Fg_1788684183
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B29641955DC3; Sun,  6 Sep 2026 08:43:03 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D63B630002EC; Sun,  6 Sep 2026 08:43:01 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 06 Sep 2026 12:42:37 +0400
Subject: [PATCH 6/9] tests/drive_del-test: compile out HMP-dependent tests
 when !CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260906-nohmp-v1-6-daee96491c43@redhat.com>
References: <20260906-nohmp-v1-0-daee96491c43@redhat.com>
In-Reply-To: <20260906-nohmp-v1-0-daee96491c43@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3943;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uHA4U8b/ubjPsJR1ATJRs71puBPfZo86KasBb9wsXFs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnSd5arNkWhHOZU28utotp36EoMfT6CCAG7WVK
 VJwq48WV8KJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap0neQAKCRDa6OEJdZac
 5bw3D/9zH+w/xw7n/Afcn8HpHKF0ouKNU4uS2XG5/tmMhwBrcoHUhAfEr1TT2DMzJA2aqvGBQ+g
 5pysBQsmNn64eVblazG3W7iQzJpzv5AjddZcmpepqLAOTtGOgMyi1L2YBmAogvoCQFXUb5pXe26
 WRUdudtVmmyRN4/eBONvCSRbVAT6CIQwCePTbGoN8AgfPXIRMMoRNcLR3FKaGbIfmUyrAyhw/65
 6QFOszSwNGsS0P2m1hEDzHyvJ5cVbOyQZvP+iqpKrq7xfkVTC3EOjKgy6nmgHqK4Jrxe1DM1R7d
 UPVdC/FXgLl0f+nB9hkg8cGap6nu4nDXSpYXS8+Rba6pQk06Y5/qlJsnukLqdJlNgtncGB6NiFc
 7vXdjXwBkHWxIugVoVqz6n4ZIyemewonCVEFhkztwfFt05VwlDylDxvtwHD3te3zQmwFWGFC67j
 SPK0xLF6VzkJ16WWP1QR8inzFGv2h+KqyZyLahLfD/WT5M6A1/ITiqii58pXtBSOJas1+22tf3U
 /w1U51k9rANVBIBBv0cSbSAv6RuTve98NUr3P2sCwwqe66cmSunekDilR/PL3gF3omXhT1U0boQ
 uwPQtKVkb8eO2ZSyt8iMLmyWdbkvUN3M8hOLAT2uA3VgFg+Io29ip8KB1FIiew0N0tc6dBwbfHo
 2p0w8zyqUmU7WsA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The compiled-out functions are actually testing HMP-specific commands
and behaviour which operate on the old "drive" concept. The QMP
equivalent for block-driver nodes are already tested.

If HMP goes away, those tests should go away too. Compile them out.

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


