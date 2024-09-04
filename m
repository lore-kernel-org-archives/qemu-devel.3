Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41905CD4847
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slnQj-0001a7-77; Wed, 04 Sep 2024 06:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnQh-0001Se-38
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:40:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnQf-0008Qq-Cj
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725446400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eA70RjLMwjhSKYetHU4kGXKYbe96+LASEXjZNrX3yCc=;
 b=CfyWn6K5jtX4oAbKlhz+f1D7h1S6LBwp8oZcjWBThCXjKB7O2qIu9DSmAPTWmPvWNEfTru
 jGwAKzitb/lbtE/y8G1UHthuzpPSwoIBcjnizxjjwaO31VF/j+E7SMdA8ndY1kHeLJyIbJ
 3uiOQF61v0uhW2WSqzOWk/wBIDVVIR0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-Kn-XUo0FPtGiGjNrPOBWNg-1; Wed,
 04 Sep 2024 06:39:57 -0400
X-MC-Unique: Kn-XUo0FPtGiGjNrPOBWNg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 982071954B16; Wed,  4 Sep 2024 10:39:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 32192195605A; Wed,  4 Sep 2024 10:39:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 09/42] tests/functional: Set up logging
Date: Wed,  4 Sep 2024 12:38:44 +0200
Message-ID: <20240904103923.451847-10-thuth@redhat.com>
In-Reply-To: <20240904103923.451847-1-thuth@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Create log files for each test separately, one file that contains
the basic logging and one that contains the console output.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240830133841.142644-10-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 27 +++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 6905675778..b2dd863c6e 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -31,7 +31,8 @@ class QemuBaseTest(unittest.TestCase):
     arch = None
 
     workdir = None
-    log = logging.getLogger('qemu-test')
+    log = None
+    logdir = None
 
     def setUp(self, bin_prefix):
         self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
@@ -41,6 +42,20 @@ def setUp(self, bin_prefix):
                                     self.id())
         os.makedirs(self.workdir, exist_ok=True)
 
+        self.logdir = self.workdir
+        self.log = logging.getLogger('qemu-test')
+        self.log.setLevel(logging.DEBUG)
+        self._log_fh = logging.FileHandler(os.path.join(self.logdir,
+                                                        'base.log'), mode='w')
+        self._log_fh.setLevel(logging.DEBUG)
+        fileFormatter = logging.Formatter(
+            '%(asctime)s - %(levelname)s: %(message)s')
+        self._log_fh.setFormatter(fileFormatter)
+        self.log.addHandler(self._log_fh)
+
+    def tearDown(self):
+        self.log.removeHandler(self._log_fh)
+
     def main():
         path = os.path.basename(sys.argv[0])[:-3]
         tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
@@ -60,6 +75,15 @@ def setUp(self):
 
         super().setUp('qemu-system-')
 
+        console_log = logging.getLogger('console')
+        console_log.setLevel(logging.DEBUG)
+        self._console_log_fh = logging.FileHandler(os.path.join(self.workdir,
+                                                   'console.log'), mode='w')
+        self._console_log_fh.setLevel(logging.DEBUG)
+        fileFormatter = logging.Formatter('%(asctime)s: %(message)s')
+        self._console_log_fh.setFormatter(fileFormatter)
+        console_log.addHandler(self._console_log_fh)
+
     def set_machine(self, machinename):
         # TODO: We should use QMP to get the list of available machines
         if not self._machinehelp:
@@ -150,4 +174,5 @@ def set_vm_arg(self, arg, value):
     def tearDown(self):
         for vm in self._vms.values():
             vm.shutdown()
+        logging.getLogger('console').removeHandler(self._console_log_fh)
         super().tearDown()
-- 
2.46.0


