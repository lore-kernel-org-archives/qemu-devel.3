Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC39E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNa0h-0005Jb-S4; Tue, 17 Dec 2024 11:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNa0T-0004bd-5t
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:01:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNa0O-0002Bc-OH
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734451263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DfumUBoRViDE7+x3kZfqjdKrOAwIC+ZXpod5c/cGKOw=;
 b=fc0rcthigYL2DNr16jeIvDlhCoLiJTuSRP5C1fKsT8xog9fB6hkRjTko6sYEfhNWzCeuDo
 qN9DI3cb8K9fmtFudjybs9NRki4JNJ0tYQClWcl4crgKBjdiNTeA0frab/hneajwJHI3Co
 4D0qst8Cirnx0gZxCmWrp24kcCIsCC0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-Agah3EHdNcqs2Lvle3tYIQ-1; Tue,
 17 Dec 2024 11:00:57 -0500
X-MC-Unique: Agah3EHdNcqs2Lvle3tYIQ-1
X-Mimecast-MFC-AGG-ID: Agah3EHdNcqs2Lvle3tYIQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FE15195608B; Tue, 17 Dec 2024 16:00:56 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.136])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C3DE300F9B8; Tue, 17 Dec 2024 16:00:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 19/32] tests/functional: add common deb_extract helper
Date: Tue, 17 Dec 2024 15:59:40 +0000
Message-ID: <20241217155953.3950506-20-berrange@redhat.com>
In-Reply-To: <20241217155953.3950506-1-berrange@redhat.com>
References: <20241217155953.3950506-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

This mirrors the existing archive_extract, cpio_extract and zip_extract
helpers

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/archive.py     | 13 +++++++++++++
 tests/functional/qemu_test/linuxkernel.py | 13 ++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/tests/functional/qemu_test/archive.py b/tests/functional/qemu_test/archive.py
index 06b66701c0..a6fc97a557 100644
--- a/tests/functional/qemu_test/archive.py
+++ b/tests/functional/qemu_test/archive.py
@@ -12,6 +12,8 @@
 import tarfile
 import zipfile
 
+from .cmd import run_cmd
+
 
 def tar_extract(archive, dest_dir, member=None):
     with tarfile.open(archive) as tf:
@@ -37,3 +39,14 @@ def zip_extract(archive, dest_dir, member=None):
             zf.extract(member=member, path=dest_dir)
         else:
             zf.extractall(path=dest_dir)
+
+def deb_extract(archive, dest_dir, member=None):
+    cwd = os.getcwd()
+    os.chdir(dest_dir)
+    try:
+        (stdout, stderr, ret) = run_cmd(['ar', 't', archive])
+        file_path = stdout.split()[2]
+        run_cmd(['ar', 'x', archive, file_path])
+        tar_extract(file_path, dest_dir, member)
+    finally:
+        os.chdir(cwd)
diff --git a/tests/functional/qemu_test/linuxkernel.py b/tests/functional/qemu_test/linuxkernel.py
index 2e4f4e35fd..8f2810f3af 100644
--- a/tests/functional/qemu_test/linuxkernel.py
+++ b/tests/functional/qemu_test/linuxkernel.py
@@ -6,8 +6,9 @@
 import os
 
 from .testcase import QemuSystemTest
-from .cmd import run_cmd, wait_for_console_pattern
-from .utils import archive_extract
+from .cmd import wait_for_console_pattern
+from .archive import deb_extract
+
 
 class LinuxKernelTest(QemuSystemTest):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
@@ -37,13 +38,7 @@ def extract_from_deb(self, deb_path, path):
         :param path: path within the deb archive of the file to be extracted
         :returns: path of the extracted file
         """
-        cwd = os.getcwd()
-        os.chdir(self.workdir)
-        (stdout, stderr, ret) = run_cmd(['ar', 't', deb_path])
-        file_path = stdout.split()[2]
-        run_cmd(['ar', 'x', deb_path, file_path])
-        archive_extract(file_path, self.workdir)
-        os.chdir(cwd)
+        deb_extract(deb_path, self.workdir, member="." + path)
         # Return complete path to extracted file.  Because callers to
         # extract_from_deb() specify 'path' with a leading slash, it is
         # necessary to use os.path.relpath() as otherwise scratch_file()
-- 
2.46.0


