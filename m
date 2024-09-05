Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E330BCD5BB8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 19:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smHwR-00019I-VZ; Thu, 05 Sep 2024 15:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smHwQ-000146-MZ
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:14:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smHwP-0000MM-0i
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725563688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zi0CYdxWxym8829V+EQCg/iBs+guG/yyNwdj4Iy4RRQ=;
 b=YAOJCjmOb39n7zniSFFN0mt3YKynmySXrKM7rGAK58hzvXttas8TfNlZLYbmRR8uWiqLSj
 Tq2exqjcDacq0UuI2IzieWYcG1oYxW24RlooHt11u41vXRsgTlqTNUPybfrBxGnM1bAVhK
 qZ7yJ+U1GWF7eYN8qyyMRzIkwTQfjig=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-EUofr2V5MYGJyhDfmd1mZg-1; Thu,
 05 Sep 2024 15:14:46 -0400
X-MC-Unique: EUofr2V5MYGJyhDfmd1mZg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B30B19560B4; Thu,  5 Sep 2024 19:14:45 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D9C71956056; Thu,  5 Sep 2024 19:14:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/8] tests/qtest/cdrom-test: Improve the machine detection in
 the cdrom test
Date: Thu,  5 Sep 2024 21:14:28 +0200
Message-ID: <20240905191434.694440-3-thuth@redhat.com>
In-Reply-To: <20240905191434.694440-1-thuth@redhat.com>
References: <20240905191434.694440-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


