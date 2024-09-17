Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F72C3600E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 10:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqVYp-0001KK-KW; Tue, 17 Sep 2024 06:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sqVYm-00014x-H5
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:35:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sqVYk-0007FS-Sv
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726569350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ufRQbjm7d7eCmJD9moGgnZPGW+ajo9ELmJ23ToN/Heo=;
 b=VvqDD3Ttpt/ZjhChmVRw6VpsUdMk3ePWfyQwzxiDvgWbiP/Xn3EjLZ6PfMHElPwnQak4/P
 ck8TYlpbQ5T1kpduWY49B/K1EmxGGBXsHO86lbzObzM3XYmAG4/+3cxxK2KlOzQ5hsOZdU
 Gi++t/WaDXVqi3QVlVvMvf7Ey15VTo4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-WrEN7D5ROD2NE5JUo1Bk8g-1; Tue,
 17 Sep 2024 06:35:46 -0400
X-MC-Unique: WrEN7D5ROD2NE5JUo1Bk8g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8F331955D4C; Tue, 17 Sep 2024 10:35:45 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.158])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6194E19560A3; Tue, 17 Sep 2024 10:35:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 01/17] tests/qtest/cdrom-test: Improve the machine detection in
 the cdrom test
Date: Tue, 17 Sep 2024 12:35:24 +0200
Message-ID: <20240917103540.149144-2-thuth@redhat.com>
In-Reply-To: <20240917103540.149144-1-thuth@redhat.com>
References: <20240917103540.149144-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When configuring QEMU with the --without-default-devices switch, these
tests are currently failing since they assume that the "pc" and "q35"
machines are always available. Add some proper checks to make the test
work without these machines, too.

Message-ID: <20240905191434.694440-3-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/cdrom-test.c | 77 ++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
index 5d89e62515..9d72b24e4b 100644
--- a/tests/qtest/cdrom-test.c
+++ b/tests/qtest/cdrom-test.c
@@ -135,13 +135,35 @@ static void add_x86_tests(void)
         return;
     }
 
-    qtest_add_data_func("cdrom/boot/default", "-cdrom ", test_cdboot);
-    if (qtest_has_device("virtio-scsi-ccw")) {
-        qtest_add_data_func("cdrom/boot/virtio-scsi",
-                            "-device virtio-scsi -device scsi-cd,drive=cdr "
-                            "-blockdev file,node-name=cdr,filename=",
-                            test_cdboot);
+    if (qtest_has_machine("pc")) {
+        qtest_add_data_func("cdrom/boot/default", "-cdrom ", test_cdboot);
+        if (qtest_has_device("virtio-scsi-ccw")) {
+            qtest_add_data_func("cdrom/boot/virtio-scsi",
+                                "-device virtio-scsi -device scsi-cd,drive=cdr "
+                                "-blockdev file,node-name=cdr,filename=",
+                                test_cdboot);
+        }
+
+        if (qtest_has_device("am53c974")) {
+            qtest_add_data_func("cdrom/boot/am53c974",
+                                "-device am53c974 -device scsi-cd,drive=cd1 "
+                                "-drive if=none,id=cd1,format=raw,file=",
+                                test_cdboot);
+        }
+        if (qtest_has_device("dc390")) {
+            qtest_add_data_func("cdrom/boot/dc390",
+                                "-device dc390 -device scsi-cd,drive=cd1 "
+                                "-blockdev file,node-name=cd1,filename=",
+                                test_cdboot);
+        }
+        if (qtest_has_device("lsi53c895a")) {
+            qtest_add_data_func("cdrom/boot/lsi53c895a",
+                                "-device lsi53c895a -device scsi-cd,drive=cd1 "
+                                "-blockdev file,node-name=cd1,filename=",
+                                test_cdboot);
+        }
     }
+
     /*
      * Unstable CI test under load
      * See https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg05509.html
@@ -150,35 +172,20 @@ static void add_x86_tests(void)
         qtest_add_data_func("cdrom/boot/isapc", "-M isapc "
                             "-drive if=ide,media=cdrom,file=", test_cdboot);
     }
-    if (qtest_has_device("am53c974")) {
-        qtest_add_data_func("cdrom/boot/am53c974",
-                            "-device am53c974 -device scsi-cd,drive=cd1 "
-                            "-drive if=none,id=cd1,format=raw,file=",
-                            test_cdboot);
-    }
-    if (qtest_has_device("dc390")) {
-        qtest_add_data_func("cdrom/boot/dc390",
-                            "-device dc390 -device scsi-cd,drive=cd1 "
-                            "-blockdev file,node-name=cd1,filename=",
-                            test_cdboot);
-    }
-    if (qtest_has_device("lsi53c895a")) {
-        qtest_add_data_func("cdrom/boot/lsi53c895a",
-                            "-device lsi53c895a -device scsi-cd,drive=cd1 "
-                            "-blockdev file,node-name=cd1,filename=",
-                            test_cdboot);
-    }
-    if (qtest_has_device("megasas")) {
-        qtest_add_data_func("cdrom/boot/megasas", "-M q35 "
-                            "-device megasas -device scsi-cd,drive=cd1 "
-                            "-blockdev file,node-name=cd1,filename=",
-                            test_cdboot);
-    }
-    if (qtest_has_device("megasas-gen2")) {
-        qtest_add_data_func("cdrom/boot/megasas-gen2", "-M q35 "
-                            "-device megasas-gen2 -device scsi-cd,drive=cd1 "
-                            "-blockdev file,node-name=cd1,filename=",
-                            test_cdboot);
+
+    if (qtest_has_machine("q35")) {
+        if (qtest_has_device("megasas")) {
+            qtest_add_data_func("cdrom/boot/megasas", "-M q35 "
+                                "-device megasas -device scsi-cd,drive=cd1 "
+                                "-blockdev file,node-name=cd1,filename=",
+                                test_cdboot);
+        }
+        if (qtest_has_device("megasas-gen2")) {
+            qtest_add_data_func("cdrom/boot/megasas-gen2", "-M q35 "
+                                "-device megasas-gen2 -device scsi-cd,drive=cd1 "
+                                "-blockdev file,node-name=cd1,filename=",
+                                test_cdboot);
+        }
     }
 }
 
-- 
2.46.0


