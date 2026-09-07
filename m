Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93714C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ZBe-00056X-PF; Mon, 07 Sep 2026 09:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3ZBL-0004lS-Pv
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:14:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3ZBJ-0006aI-7u
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788786880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cr17daom5ZIwPL1Jm52XNja1f8W6vz7SjHDPV0FRzto=;
 b=cbbvtIF23QIf1B4assJKPhpANJMYtXqKDREfKadCe8OdlB0WTkoH7N78N0UC+dq/UQT01L
 RafnpLymGfzrN8hVfdrGXJ1CyfEj+aIbSWFUFfBXHcjZdajryKkS/sdWhXQoOa0ZBmSLvF
 V0Sw0lw4THBq1um6wvLL0Wchk8W0TIE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-_D3_7q06OtuGTCyig4Sddg-1; Mon,
 07 Sep 2026 09:14:36 -0400
X-MC-Unique: _D3_7q06OtuGTCyig4Sddg-1
X-Mimecast-MFC-AGG-ID: _D3_7q06OtuGTCyig4Sddg_1788786874
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2859E19540EA; Mon,  7 Sep 2026 13:14:34 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 538F41956049; Mon,  7 Sep 2026 13:14:32 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 17:14:02 +0400
Subject: [PATCH v3 8/9] tests/drive_del-test: compile out HMP-dependent
 tests when !CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-nohmp-v3-8-c11e7d0d3d7d@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3999;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=nELlHO8Wk8s5vJ916Mup0ugCUbfnyL7FDxtNlquSMtI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnriY5ksk5tlMx9HxnK7ZP5j7BgAd7gphBwgJw
 1JSb8WaMOyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap64mAAKCRDa6OEJdZac
 5eQ8D/9/nJeQ5dhyvSePSs8YQ2/dq2K4Jw599gFL81MDr6kKXKvv8yVeyqBtNL0kR5uq7MGyOx4
 Fzh4JAJsr5oZPqSgiC6A2nBdUgt7Awv9/xCCfc2H87RB7Cf4lWH8wE+NLNd8IP5yPoTfZm0qil7
 fZTowNQz43vo8QSYmJDIRDwIvX+abYTh5zFvF8JYPCzFlGTec/Q/aNwy3srWmQmqpWFW4vn8lod
 SHeTrR0C1rw4oh7HKPOOJ8obT/ASnuJAb7PqSTxvzscaMuHCG5ticwikOFClHb5KDFqI6CAmTsH
 GZCuZwhG/6TZfHpie0kpHO6WLsP8IcvIvz7gMWsttfO0ol/kXbwDCGkL0dotWz0nZD2842/QHNs
 s8cuaseITwMEbC7aC0eQ8NADxU8R7d3u/CIDiupXMGmg0azMoEBIrgaGsM+fVzvYRLbYeFdGJG7
 VjxHIi3+NUf3kaTmRHWhE51yW9g9+U4shQ+UQangR1IvzKYzrEkRaiCYhy54az3N0vZbGaY8OwK
 aKeE2AmBQq585R9sp8P2J+XOqSvRmdGnnyy87Z9hF93uIkuVtpxgxYSVnnR5wc0mOtz+AA9+Z8o
 AXeOGaBLpbgJNRlZZih31drVAiGUgCMEoSZ4sBc6MauGClvBmyrVtA1o0eJr4Fa/kHPX3E5SqFm
 frDstZYrPtwhO+g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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


