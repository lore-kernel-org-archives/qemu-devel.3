Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18643C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 11:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTgLE-0001Gp-NW; Tue, 16 Jul 2024 07:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTgKp-00010J-53
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:27:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTgKk-0003gz-EN
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721129221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tWnfJwiTMYAfP+Hg+ct7OhcKr/q01e7XtGCaGzltuGY=;
 b=eT+MHNTWOyKQ+1r1XEDoovoK5knwSg2dAUtrN2sWNSc6pR50ajPdksIxYwDZ59brVSiakR
 gV84W0sHVwrYVrvD8WeGBTqSXWRg65CSVpn0AfgQBUWVbRvmBcTDaThK7Y/lfInTCb+eMG
 UZekUnSEHKBp3a9uFDdGoo25MOgc1n8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-xGdQoJNzOGiOf-1pD98cng-1; Tue,
 16 Jul 2024 07:26:56 -0400
X-MC-Unique: xGdQoJNzOGiOf-1pD98cng-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF8E01944B30; Tue, 16 Jul 2024 11:26:55 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.154])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 42AD41955F40; Tue, 16 Jul 2024 11:26:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 09/11] tests/functional: Set up logging
Date: Tue, 16 Jul 2024 13:26:12 +0200
Message-ID: <20240716112614.1755692-10-thuth@redhat.com>
In-Reply-To: <20240716112614.1755692-1-thuth@redhat.com>
References: <20240716112614.1755692-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/__init__.py | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 77c3b14d34..cc49fd4c94 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -208,7 +208,7 @@ class QemuBaseTest(unittest.TestCase):
     BUILD_DIR = _build_dir()
 
     workdir = None
-    log = logging.getLogger('qemu-test')
+    log = None
 
     def setUp(self, bin_prefix):
         self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
@@ -218,6 +218,18 @@ def setUp(self, bin_prefix):
         if not os.path.exists(self.workdir):
             os.makedirs(self.workdir)
 
+        self.log = logging.getLogger('qemu-test')
+        self.log.setLevel(logging.DEBUG)
+        self._log_fh = logging.FileHandler(os.path.join(self.workdir,
+                                                        'base.log'), mode='w')
+        self._log_fh.setLevel(logging.DEBUG)
+        fileFormatter = logging.Formatter('%(asctime)s - %(levelname)s: %(message)s')
+        self._log_fh.setFormatter(fileFormatter)
+        self.log.addHandler(self._log_fh)
+
+    def tearDown(self):
+        self.log.removeHandler(self._log_fh)
+
     def check_hash(self, file_name, expected_hash):
         if not expected_hash:
             return True
@@ -269,6 +281,15 @@ def setUp(self):
 
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
@@ -359,4 +380,5 @@ def set_vm_arg(self, arg, value):
     def tearDown(self):
         for vm in self._vms.values():
             vm.shutdown()
+        logging.getLogger('console').removeHandler(self._console_log_fh)
         super().tearDown()
-- 
2.45.2


