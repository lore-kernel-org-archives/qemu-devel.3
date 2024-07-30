Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58ABC52D1D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 17:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYqGs-0007cz-N8; Tue, 30 Jul 2024 13:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqGl-0007au-Ue
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:04:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqGj-0002IP-GI
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722359051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J+YO1UPg/8/0uRYe35GmtabsnQdkTvTw8bfvHDpvg7g=;
 b=BgDgLXCrNoccPdb88mzzGlc9gTs0qqWDg8wiPjJNhl5KozvIrgAgXM2dIxHVsF83ZVz9ny
 FYB6ouR/hHuTYCXN/MAQSwqZ53dC8PgDfMXqwkcr62oMuLyyoJ6TtmxaHd6Xb1p+fkVv66
 5elU8hHfj8xBBs0howSP9qOWwwldoGM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-N5oXdZfMNXuNjarBsaiOGQ-1; Tue,
 30 Jul 2024 13:04:06 -0400
X-MC-Unique: N5oXdZfMNXuNjarBsaiOGQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C090195608A; Tue, 30 Jul 2024 17:04:05 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.108])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B1D42300018D; Tue, 30 Jul 2024 17:04:01 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 03/24] tests/functional: Set up logging
Date: Tue, 30 Jul 2024 18:03:23 +0100
Message-ID: <20240730170347.4103919-4-berrange@redhat.com>
In-Reply-To: <20240730170347.4103919-1-berrange@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Thomas Huth <thuth@redhat.com>

Create log files for each test separately, one file that contains
the basic logging and one that contains the console output.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 27 +++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 82cc1d454f..27bbf4a0af 100644
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
@@ -42,6 +43,20 @@ def setUp(self, bin_prefix):
         if not os.path.exists(self.workdir):
             os.makedirs(self.workdir)
 
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
         tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
                                    test_output_log = pycotap.LogMode.LogToError)
@@ -61,6 +76,15 @@ def setUp(self):
 
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
@@ -151,4 +175,5 @@ def set_vm_arg(self, arg, value):
     def tearDown(self):
         for vm in self._vms.values():
             vm.shutdown()
+        logging.getLogger('console').removeHandler(self._console_log_fh)
         super().tearDown()
-- 
2.45.2


