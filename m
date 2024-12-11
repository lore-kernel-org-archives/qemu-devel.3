Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0581AE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 17:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLQVG-0006fX-AB; Wed, 11 Dec 2024 12:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLQV8-0006XV-4A
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 12:27:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLQV6-0001CA-F2
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 12:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733938071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=19d1rFYwA8ktJMGhG/dmH3QFpC81HYZ9wSnuVDPNnXI=;
 b=FJmTYwYi8b4sNm9koZG3hwpyKQWfklGmY+PrQJEGlwPLGO4zRSGKVggBcWZSfHU5Rf+dXr
 sApBRkG9vJEMHI/Ee8BwjKylx81hSya/2suXnN7JQ79oAQq/90f6XIyqXn7BQ07ao055N/
 Rxtcwtn6rYFxAnveQkwHRhqhMiffO+o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-ORXrsbb_NSyGayoP01yIHQ-1; Wed,
 11 Dec 2024 12:27:49 -0500
X-MC-Unique: ORXrsbb_NSyGayoP01yIHQ-1
X-Mimecast-MFC-AGG-ID: ORXrsbb_NSyGayoP01yIHQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79D0D1955EB1; Wed, 11 Dec 2024 17:27:48 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 68C321956048; Wed, 11 Dec 2024 17:27:46 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 19/31] tests/functional: add common deb_extract helper
Date: Wed, 11 Dec 2024 17:26:35 +0000
Message-ID: <20241211172648.2893097-20-berrange@redhat.com>
In-Reply-To: <20241211172648.2893097-1-berrange@redhat.com>
References: <20241211172648.2893097-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

This mirrors the existing archive_extract, cpio_extract and zip_extract
helpers

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


