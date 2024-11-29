Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61834D729E7
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 17:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH4rF-0004Qx-7D; Fri, 29 Nov 2024 12:32:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4qk-0003n0-10
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:32:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4qi-00014z-7V
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732901530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sux808zrkHdt32pEDIjc5mJX+mxJhiB1+QIujRoog80=;
 b=amMR0dIDeZkyuHmFaXBPj1Xd5KTBCVxhdL/7WFCf+k4ilCtkeo8imoRuscl4CLx8r8DdVB
 o3uKI/KG9n5W8GOURDthNgxfJDHeAs5atYVmaZhtAmb933zd2WZ16wsp6cljfaZ/8XyBv9
 nyOy00FkQrlRdhv5ifxiM2ZoicbqIf8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-T67vVfZUPj-UE3jTXE-vMw-1; Fri,
 29 Nov 2024 12:32:07 -0500
X-MC-Unique: T67vVfZUPj-UE3jTXE-vMw-1
X-Mimecast-MFC-AGG-ID: T67vVfZUPj-UE3jTXE-vMw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22C481956095; Fri, 29 Nov 2024 17:32:06 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 112FB1955F2D; Fri, 29 Nov 2024 17:32:03 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 16/22] tests/functional: add common deb_extract helper
Date: Fri, 29 Nov 2024 17:31:14 +0000
Message-ID: <20241129173120.761728-17-berrange@redhat.com>
In-Reply-To: <20241129173120.761728-1-berrange@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 tests/functional/qemu_test/linuxkernel.py | 15 +++++----------
 tests/functional/qemu_test/utils.py       | 13 +++++++++++++
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/tests/functional/qemu_test/linuxkernel.py b/tests/functional/qemu_test/linuxkernel.py
index a6525f9dd6..fb6a158d36 100644
--- a/tests/functional/qemu_test/linuxkernel.py
+++ b/tests/functional/qemu_test/linuxkernel.py
@@ -6,8 +6,8 @@
 import os
 
 from .testcase import QemuSystemTest
-from .cmd import run_cmd, wait_for_console_pattern
-from .utils import archive_extract
+from .cmd import wait_for_console_pattern
+from .utils import deb_extract
 
 class LinuxKernelTest(QemuSystemTest):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
@@ -37,16 +37,11 @@ def extract_from_deb(self, deb_path, path):
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
+        relpath = os.path.relpath(path, '/')
+        deb_extract(deb_path, self.workdir, member="." + path)
         # Return complete path to extracted file.  Because callers to
         # extract_from_deb() specify 'path' with a leading slash, it is
         # necessary to use 'relative_to()' to turn it into a relative
         # path for joining to the scratch dir
-        return os.path.normpath(self.scratch_file(os.path.relpath(path, '/')))
+        return os.path.normpath(self.scratch_file(relpath))
 
diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
index 41bd1df666..bafe7fb80e 100644
--- a/tests/functional/qemu_test/utils.py
+++ b/tests/functional/qemu_test/utils.py
@@ -15,6 +15,8 @@
 import subprocess
 import tarfile
 
+from .cmd import run_cmd
+
 """
 Round up to next power of 2
 """
@@ -53,6 +55,17 @@ def zip_extract(archive, dest_dir, member=None):
         else:
             zf.extractall(path=dest_dir)
 
+def deb_extract(archive, dest_dir, member=None):
+    cwd = os.getcwd()
+    os.chdir(dest_dir)
+    try:
+        (stdout, stderr, ret) = run_cmd(['ar', 't', archive])
+        file_path = stdout.split()[2]
+        run_cmd(['ar', 'x', archive, file_path])
+        archive_extract(file_path, dest_dir, member)
+    finally:
+        os.chdir(cwd)
+
 def gzip_uncompress(gz_path, output_path):
     if os.path.exists(output_path):
         return
-- 
2.46.0


