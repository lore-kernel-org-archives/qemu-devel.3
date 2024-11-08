Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43F9D5E154
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 10:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9MSt-0004Bo-0Q; Fri, 08 Nov 2024 05:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t9MSq-0004Ba-FJ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 05:43:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t9MSn-00069V-MO
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 05:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731062616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uI0Jru7fi/KTrKAQWqFfneZS7CgSgPA0N/dGLf3k7Tk=;
 b=EU9iczDXJk4nAu2K8G44sSrGuSkd8wihUrTRP4lyfq5rQnHZgAscU61wXGDdyCpSW9hs5/
 0YdNbw2Kv6iVxw6ZZBpv0K5/iZ7CGGZTlN1ayTiPKDxoeiazVPd7KsMZHs0+IV4bbV4GDU
 rwhiTrJg5+IvIxodTHLGLUkG5a5UJwc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-aN9jFqA3OeinSRMCJDnHiw-1; Fri,
 08 Nov 2024 05:43:33 -0500
X-MC-Unique: aN9jFqA3OeinSRMCJDnHiw-1
X-Mimecast-MFC-AGG-ID: aN9jFqA3OeinSRMCJDnHiw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EC4C1955F41; Fri,  8 Nov 2024 10:43:32 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.118])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C2CE01953880; Fri,  8 Nov 2024 10:43:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/10] tests/functional: Provide the user with hints where to
 find more log files
Date: Fri,  8 Nov 2024 11:43:05 +0100
Message-ID: <20241108104312.534448-6-thuth@redhat.com>
In-Reply-To: <20241108104312.534448-1-thuth@redhat.com>
References: <20241108104312.534448-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Message-ID: <20241105123849.359391-1-thuth@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
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


