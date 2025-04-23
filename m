Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B5BC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7UfN-0003Je-Ve; Wed, 23 Apr 2025 03:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7UfE-0003EN-PR
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:37:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7UfC-0003Hj-7L
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745393817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QhCSieJStkW8vwRHHDq/VDpvXLt+CNcCBA2kBqyGeWw=;
 b=S/RMPdZtpPnTPJNi4NNQBF8GuYrZY8q5VfnithnFYIcZwaawOZ181aZ+d3mS+16203rfu1
 hKRlRdOxq48zTBYuDW7fJ3kDwXnWDvAKTtnEwNO1KEexhlj275xY1ftQqaoanoJN5SQGgD
 cyrSKJO3IQwtB65zU68bFnegzGfIA78=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-RJbj00fUPtmYmVfwPHoKjg-1; Wed,
 23 Apr 2025 03:36:50 -0400
X-MC-Unique: RJbj00fUPtmYmVfwPHoKjg-1
X-Mimecast-MFC-AGG-ID: RJbj00fUPtmYmVfwPHoKjg_1745393809
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82787180087B; Wed, 23 Apr 2025 07:36:49 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA05319560A3; Wed, 23 Apr 2025 07:36:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 15/29] tests/avocado: Remove the LinuxKernelTest class
Date: Wed, 23 Apr 2025 09:35:55 +0200
Message-ID: <20250423073610.271585-16-thuth@redhat.com>
In-Reply-To: <20250423073610.271585-1-thuth@redhat.com>
References: <20250423073610.271585-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

All tests that used this class have been converted to the functional
framework, so we can remove the boot_linux_console.py file now.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250414113031.151105-6-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/boot_linux_console.py | 62 -----------------------------
 1 file changed, 62 deletions(-)
 delete mode 100644 tests/avocado/boot_linux_console.py

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
deleted file mode 100644
index cbb1e2fb506..00000000000
--- a/tests/avocado/boot_linux_console.py
+++ /dev/null
@@ -1,62 +0,0 @@
-# Functional test that boots a Linux kernel and checks the console
-#
-# Copyright (c) 2018 Red Hat, Inc.
-#
-# Author:
-#  Cleber Rosa <crosa@redhat.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-
-import os
-import shutil
-
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-from avocado.utils import process
-from avocado.utils import archive
-
-class LinuxKernelTest(QemuSystemTest):
-    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
-
-    def wait_for_console_pattern(self, success_message, vm=None):
-        wait_for_console_pattern(self, success_message,
-                                 failure_message='Kernel panic - not syncing',
-                                 vm=vm)
-
-    def extract_from_deb(self, deb, path):
-        """
-        Extracts a file from a deb package into the test workdir
-
-        :param deb: path to the deb archive
-        :param path: path within the deb archive of the file to be extracted
-        :returns: path of the extracted file
-        """
-        cwd = os.getcwd()
-        os.chdir(self.workdir)
-        file_path = process.run("ar t %s" % deb).stdout_text.split()[2]
-        process.run("ar x %s %s" % (deb, file_path))
-        archive.extract(file_path, self.workdir)
-        os.chdir(cwd)
-        # Return complete path to extracted file.  Because callers to
-        # extract_from_deb() specify 'path' with a leading slash, it is
-        # necessary to use os.path.relpath() as otherwise os.path.join()
-        # interprets it as an absolute path and drops the self.workdir part.
-        return os.path.normpath(os.path.join(self.workdir,
-                                             os.path.relpath(path, '/')))
-
-    def extract_from_rpm(self, rpm, path):
-        """
-        Extracts a file from an RPM package into the test workdir.
-
-        :param rpm: path to the rpm archive
-        :param path: path within the rpm archive of the file to be extracted
-                     needs to be a relative path (starting with './') because
-                     cpio(1), which is used to extract the file, expects that.
-        :returns: path of the extracted file
-        """
-        cwd = os.getcwd()
-        os.chdir(self.workdir)
-        process.run("rpm2cpio %s | cpio -id %s" % (rpm, path), shell=True)
-        os.chdir(cwd)
-        return os.path.normpath(os.path.join(self.workdir, path))
-- 
2.49.0


