Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464CCECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 12:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so08R-0003fB-Qr; Tue, 10 Sep 2024 08:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1so08B-0002II-5K
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:38:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1so084-00059U-6u
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725971869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RtRLAuvqf+JeUxfTMm7H0IZIsVPZvbApHU6YhP9jrU0=;
 b=i5hoUJZQEjmFZpCEbWibVGDOMtPecNSYBQ8Lmlwt5oqoxtvqdJmQjofgN/A+PsvJpLHjFq
 4Y5r2ElcqYwNe8WR7L036ucsgCi1D2YA5RZ43KSapIiCg4UP3WfhBjsDRQAOU/Pxt+LqqO
 R+byrbv19mFKjYoVrRcJFyXZepzGWV8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-zyQliyLZPR23YntrdvbUhQ-1; Tue,
 10 Sep 2024 08:37:46 -0400
X-MC-Unique: zyQliyLZPR23YntrdvbUhQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A368A1944DDE; Tue, 10 Sep 2024 12:37:44 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.120])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4012B19560AB; Tue, 10 Sep 2024 12:37:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 07/22] tests/functional: Add the LinuxKernelTest for testing
 the Linux boot process
Date: Tue, 10 Sep 2024 14:37:08 +0200
Message-ID: <20240910123726.182975-8-thuth@redhat.com>
In-Reply-To: <20240910123726.182975-1-thuth@redhat.com>
References: <20240910123726.182975-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Copy the LinuxKernelTest from tests/acceptance/boot_linux_console.py
to be able to convert the related tests to the functional test framework
in the following patches.

Message-ID: <20240906180549.792832-2-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/__init__.py    |  1 +
 tests/functional/qemu_test/linuxkernel.py | 41 +++++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 tests/functional/qemu_test/linuxkernel.py

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index f33282efe8..67f87be9c4 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -12,3 +12,4 @@
     interrupt_interactive_console_until_pattern, wait_for_console_pattern, \
     exec_command, exec_command_and_wait_for_pattern, get_qemu_img
 from .testcase import QemuBaseTest, QemuUserTest, QemuSystemTest
+from .linuxkernel import LinuxKernelTest
diff --git a/tests/functional/qemu_test/linuxkernel.py b/tests/functional/qemu_test/linuxkernel.py
new file mode 100644
index 0000000000..fdd5307629
--- /dev/null
+++ b/tests/functional/qemu_test/linuxkernel.py
@@ -0,0 +1,41 @@
+# Test class for testing the boot process of a Linux kernel
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import os
+
+from .testcase import QemuSystemTest
+from .cmd import run_cmd, wait_for_console_pattern
+from .utils import archive_extract
+
+class LinuxKernelTest(QemuSystemTest):
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
+
+    def wait_for_console_pattern(self, success_message, vm=None):
+        wait_for_console_pattern(self, success_message,
+                                 failure_message='Kernel panic - not syncing',
+                                 vm=vm)
+
+    def extract_from_deb(self, deb_path, path):
+        """
+        Extracts a file from a deb package into the test workdir
+
+        :param deb_path: path to the deb archive
+        :param path: path within the deb archive of the file to be extracted
+        :returns: path of the extracted file
+        """
+        cwd = os.getcwd()
+        os.chdir(self.workdir)
+        (stdout, stderr, ret) = run_cmd(['ar', 't', deb_path])
+        file_path = stdout.split()[2]
+        run_cmd(['ar', 'x', deb_path, file_path])
+        archive_extract(file_path, self.workdir)
+        os.chdir(cwd)
+        # Return complete path to extracted file.  Because callers to
+        # extract_from_deb() specify 'path' with a leading slash, it is
+        # necessary to use os.path.relpath() as otherwise os.path.join()
+        # interprets it as an absolute path and drops the self.workdir part.
+        return os.path.normpath(os.path.join(self.workdir,
+                                             os.path.relpath(path, '/')))
+
-- 
2.46.0


