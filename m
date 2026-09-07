Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06226C79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Wd6-0004OQ-JX; Mon, 07 Sep 2026 06:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wd5-0004Ns-45
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wd1-0003W7-Bx
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788777065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cr17daom5ZIwPL1Jm52XNja1f8W6vz7SjHDPV0FRzto=;
 b=fGpzrdCWhnxAYa3Nj+kp2KBO2I4n+Uu/m4Bsq0Ze1Mcgimzw9fGOSxtU+K72q2B9DmuBVX
 eg3Db4gmxbeLhxQyK3amPkH+WcTFsf+Th2kda0qE1MgCOFBRThvy9VlwC3d/xagvnDAtCH
 DqotjW5wZlN9d8Ox3H+yewRck4vripc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-4c7xqn7mN2aTKFmFmQ0KTQ-1; Mon,
 07 Sep 2026 06:31:02 -0400
X-MC-Unique: 4c7xqn7mN2aTKFmFmQ0KTQ-1
X-Mimecast-MFC-AGG-ID: 4c7xqn7mN2aTKFmFmQ0KTQ_1788777060
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26DD2197703E; Mon,  7 Sep 2026 10:31:00 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 523803000223; Mon,  7 Sep 2026 10:30:58 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:30:26 +0400
Subject: [PATCH v2 08/10] tests/drive_del-test: compile out HMP-dependent
 tests when !CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-nohmp-v2-8-6d952d972c21@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3999;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=nELlHO8Wk8s5vJ916Mup0ugCUbfnyL7FDxtNlquSMtI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpJDmDcUdpf3J+Zp5LGlZt5xHWwgZq0Ag4wTG
 ZykkAAUcOKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6SQwAKCRDa6OEJdZac
 5fHGD/934pYLV5igo2E5quOb4ZE0Liiq1O+Z9KanshnSlItckgoGDdo8ekeTP5JV8fgVRTPtUcD
 8RGxAxO11sNMDmdQONg6ERxO4wWtOr/OTICocD7SuqT+PCI+agywKKVihtR30Oh6nsh+qlgFl2R
 tgLvTbnjuKG3tHBN5ImuEPJ/7iGmGMId0PvKK6zy74Tl92rByPDiR1im+Oqt0vJCZGGmaStFxlv
 WejIInGEMejJRYN9K2VZ2svHs4G6GOnQ16AcSlrlLcrldwmvxroAXPskEm6jBzXGaELZWF7FPsI
 Q/QDX0M2zpF2WmZ9tA25DdUztalSWlteecIZ/Ij3vn7EIj68x8uXc1IrXkZ0/UU8Ifax7P4w4DW
 KxexvrGgyOeNcPDVNuyLIhZJw2WoEtqxLhiMM98Brq/rk+yjVSFsdQZEIsunfLdcvVLvDPKIXri
 bOGSpIRXt+hz7AEKliAkZVMKKB5fRLdR7wDk4kSraOOMwcOUsE98+vV76wpj8DrDPbZvv3n0pSY
 rBMh0QQ+APf35KpMLwZtoOyKqi+mGZhB934enY8x25o5nynLke6cH19uDktGVke+TyF1jNmKLdr
 RJ1pBGteFGg8XoPR5eD3PXkbSXUk2p8eEqkwQB3hs6KdaCH1ETKnfteOy/z6yqG1Ob6LMQigpyi
 ZVk3L1tfW9XYstw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
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


