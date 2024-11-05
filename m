Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55C8D1269D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 12:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Ipt-0002Ch-TM; Tue, 05 Nov 2024 07:39:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t8Ips-0002CQ-Cw
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 07:39:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t8Ipp-0007fU-0p
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 07:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730810338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y5QpxVfjZFFcg1JcaAIroD3zXBJX3sD1VXFE5X6LvY0=;
 b=R5qFAUnRl8opvJPtrR5YCB0FRifufp4CGP999aVO7oreC9TElYlUgKaXZ1gkVfWd7GxMls
 U0C3NXM7PZUB2CXxosihHU6gkIU/rS92sZJ0Ju8dIfYDzybSFgTIr5ZidCaCrz0+L5c/4o
 oygejf/DpV9Ni18Y6bjLEolTBd4DVyQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-wg2T0SYtMWu5IZigNB9Qjw-1; Tue,
 05 Nov 2024 07:38:55 -0500
X-MC-Unique: wg2T0SYtMWu5IZigNB9Qjw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30642195604F; Tue,  5 Nov 2024 12:38:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 317481956052; Tue,  5 Nov 2024 12:38:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH] tests/functional: Provide the user with hints where to find
 more log files
Date: Tue,  5 Nov 2024 13:38:49 +0100
Message-ID: <20241105123849.359391-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Since the base.log and console.log files are not referenced from the
meson test logs yet, they might be hard to find for the casual users.
Thus let's print some hints in case a test case failed. For this we
have to run unittest.main() with exit=False to get the results of the
testing. Then we can iterate through the failed test cases to print
out the information accordingly.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index aa0146265a..411978b5ef 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -45,10 +45,10 @@ def setUp(self, bin_prefix):
         os.makedirs(self.workdir, exist_ok=True)
 
         self.logdir = self.workdir
+        self.log_filename = os.path.join(self.logdir, 'base.log')
         self.log = logging.getLogger('qemu-test')
         self.log.setLevel(logging.DEBUG)
-        self._log_fh = logging.FileHandler(os.path.join(self.logdir,
-                                                        'base.log'), mode='w')
+        self._log_fh = logging.FileHandler(self.log_filename, mode='w')
         self._log_fh.setLevel(logging.DEBUG)
         fileFormatter = logging.Formatter(
             '%(asctime)s - %(levelname)s: %(message)s')
@@ -68,7 +68,14 @@ def main():
 
         tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
                                    test_output_log = pycotap.LogMode.LogToError)
-        unittest.main(module = None, testRunner = tr, argv=["__dummy__", path])
+        res = unittest.main(module = None, testRunner = tr, exit = False,
+                            argv=["__dummy__", path])
+        for (test, message) in res.result.errors + res.result.failures:
+            print('More information on ' + test.id() + ' could be found here:'
+                  '\n %s' % test.log_filename, file=sys.stderr)
+            if hasattr(test, 'console_log_name'):
+                print(' %s' % test.console_log_name, file=sys.stderr)
+        sys.exit(not res.result.wasSuccessful())
 
 
 class QemuUserTest(QemuBaseTest):
@@ -101,8 +108,9 @@ def setUp(self):
 
         console_log = logging.getLogger('console')
         console_log.setLevel(logging.DEBUG)
-        self._console_log_fh = logging.FileHandler(os.path.join(self.workdir,
-                                                   'console.log'), mode='w')
+        self.console_log_name = os.path.join(self.workdir, 'console.log')
+        self._console_log_fh = logging.FileHandler(self.console_log_name,
+                                                   mode='w')
         self._console_log_fh.setLevel(logging.DEBUG)
         fileFormatter = logging.Formatter('%(asctime)s: %(message)s')
         self._console_log_fh.setFormatter(fileFormatter)
-- 
2.47.0


