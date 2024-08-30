Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C8DCA0FF1
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 13:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk1qj-0006pr-EB; Fri, 30 Aug 2024 09:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk1qh-0006i2-9z
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:39:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk1qf-0005Ea-MN
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725025173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fQSInVSD+wTiboOexxLtN6S7PAvTtzt1nd8Jy3LhkRs=;
 b=bHIUOc3A/BtKg0QGku5C3cJLAZqNsHsAl88NI0a0czwy6g1P0tDrCipKATmgEWO6qJYR0j
 LEyKvamQl2XW8KQqwvrD/6C8Rzg65GmBYBBzNoR/4CC4I98GTlkVSMwoCXPei1poYVd0/9
 eGN0r75h4t3czUutddjrTv131OxDyzU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-aiODZBxsOziW5mOMnLKmeQ-1; Fri,
 30 Aug 2024 09:39:31 -0400
X-MC-Unique: aiODZBxsOziW5mOMnLKmeQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E0AD1955D4C; Fri, 30 Aug 2024 13:39:30 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C016300019C; Fri, 30 Aug 2024 13:39:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v5 09/44] tests/functional: Set up logging
Date: Fri, 30 Aug 2024 15:38:03 +0200
Message-ID: <20240830133841.142644-10-thuth@redhat.com>
In-Reply-To: <20240830133841.142644-1-thuth@redhat.com>
References: <20240830133841.142644-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


