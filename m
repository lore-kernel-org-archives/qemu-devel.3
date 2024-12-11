Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BD0E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 17:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLQUl-0005ZR-R0; Wed, 11 Dec 2024 12:27:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLQUk-0005ZB-1h
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 12:27:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLQUi-00018F-Cx
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 12:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733938047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U9esgIthrudvDaRJ+rEBiuyKD4+iIMzGIxm2i96hJI8=;
 b=QVK0WJcKKJajbq8fZASaTZyGKLiVgPLpfn4WA9V0VgxqWeucmcfCMj51gJY65VgVdge7Re
 iFJ1e6p0b2S6oO8h/MONdedUJOoboD6RmsC0MXZGb8FPQCZ9CdLZOx0JR3/fHkshNoBbHW
 m3byMbdEepop5YXzTedaHvqogFOFLWg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-spkdExBcP5W_tsLVYoYInA-1; Wed,
 11 Dec 2024 12:27:26 -0500
X-MC-Unique: spkdExBcP5W_tsLVYoYInA-1
X-Mimecast-MFC-AGG-ID: spkdExBcP5W_tsLVYoYInA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E63A195609D; Wed, 11 Dec 2024 17:27:23 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D4141956048; Wed, 11 Dec 2024 17:27:21 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 10/31] tests/functional: switch over to using
 self.log_file(...)
Date: Wed, 11 Dec 2024 17:26:26 +0000
Message-ID: <20241211172648.2893097-11-berrange@redhat.com>
In-Reply-To: <20241211172648.2893097-1-berrange@redhat.com>
References: <20241211172648.2893097-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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

This removes direct access of the 'self.logdir' variable.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 9 ++++-----
 tests/functional/test_virtio_gpu.py    | 4 +---
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 89425b737c..2174fbb155 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -126,7 +126,7 @@ def scratch_file(self, *args):
     Returns: string representing a file path
     '''
     def log_file(self, *args):
-        return str(Path(self.logdir, *args))
+        return str(Path(self.outputdir, *args))
 
     def setUp(self, bin_prefix):
         self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
@@ -138,8 +138,7 @@ def setUp(self, bin_prefix):
         self.workdir = os.path.join(self.outputdir, 'scratch')
         os.makedirs(self.workdir, exist_ok=True)
 
-        self.logdir = self.outputdir
-        self.log_filename = os.path.join(self.logdir, 'base.log')
+        self.log_filename = self.log_file('base.log')
         self.log = logging.getLogger('qemu-test')
         self.log.setLevel(logging.DEBUG)
         self._log_fh = logging.FileHandler(self.log_filename, mode='w')
@@ -215,7 +214,7 @@ def setUp(self):
 
         console_log = logging.getLogger('console')
         console_log.setLevel(logging.DEBUG)
-        self.console_log_name = os.path.join(self.logdir, 'console.log')
+        self.console_log_name = self.log_file('console.log')
         self._console_log_fh = logging.FileHandler(self.console_log_name,
                                                    mode='w')
         self._console_log_fh.setLevel(logging.DEBUG)
@@ -269,7 +268,7 @@ def _new_vm(self, name, *args):
         vm = QEMUMachine(self.qemu_bin,
                          name=name,
                          base_temp_dir=self.workdir,
-                         log_dir=self.logdir)
+                         log_dir=self.log_file())
         self.log.debug('QEMUMachine "%s" created', name)
         self.log.debug('QEMUMachine "%s" temp_dir: %s', name, vm.temp_dir)
 
diff --git a/tests/functional/test_virtio_gpu.py b/tests/functional/test_virtio_gpu.py
index 2d298b1f02..7654421e6b 100755
--- a/tests/functional/test_virtio_gpu.py
+++ b/tests/functional/test_virtio_gpu.py
@@ -100,9 +100,7 @@ def test_vhost_user_vga_virgl(self):
         os.set_inheritable(qemu_sock.fileno(), True)
         os.set_inheritable(vug_sock.fileno(), True)
 
-        self._vug_log_path = os.path.join(
-            self.logdir, "vhost-user-gpu.log"
-        )
+        self._vug_log_path = self.log_file("vhost-user-gpu.log")
         self._vug_log_file = open(self._vug_log_path, "wb")
         self.log.info('Complete vhost-user-gpu.log file can be '
                       'found at %s', self._vug_log_path)
-- 
2.46.0


