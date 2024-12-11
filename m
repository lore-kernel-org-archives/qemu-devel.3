Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8E5E77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 17:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLQUj-0005Yv-KO; Wed, 11 Dec 2024 12:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLQUh-0005YT-Cj
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 12:27:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLQUf-00017x-Q9
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 12:27:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733938045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z01igLdFUBXijPmUyFdU7/BlGo4KU92GfTPKf42FCLk=;
 b=XPfEvmy6cbWp7MjFeGgq7PFO/cqkMHzrPp+PPjqXm/rZbYwaJXhgd+2QS+1jdEejczphO7
 DdenG8Jxei5mUWWJMKOhyj5z/LAIPRDhNCYLYqkdUd0G3wj0DB5cXs67hPPTt2Ro7xDsYY
 5ZjvQmZ6NI8dJO/5FIRQjx8dMM00NCA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-lEx4QoUMNVuimppVpdyXjw-1; Wed,
 11 Dec 2024 12:27:21 -0500
X-MC-Unique: lEx4QoUMNVuimppVpdyXjw-1
X-Mimecast-MFC-AGG-ID: lEx4QoUMNVuimppVpdyXjw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 158D91954B3E; Wed, 11 Dec 2024 17:27:18 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B0FD91956048; Wed, 11 Dec 2024 17:27:15 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 08/31] tests/functional: drop 'has_cmd' and 'has_cmds'
 helpers
Date: Wed, 11 Dec 2024 17:26:24 +0000
Message-ID: <20241211172648.2893097-9-berrange@redhat.com>
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

The 'which' helper is simpler and sufficient for test needs.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/__init__.py   |  2 +-
 tests/functional/qemu_test/cmd.py        | 54 ++----------------------
 tests/functional/qemu_test/tuxruntest.py | 10 ++---
 3 files changed, 9 insertions(+), 57 deletions(-)

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 7dee3522f2..fe6cbe3a8a 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -8,7 +8,7 @@
 
 from .asset import Asset
 from .config import BUILD_DIR
-from .cmd import has_cmd, has_cmds, run_cmd, is_readable_executable_file, \
+from .cmd import run_cmd, is_readable_executable_file, \
     interrupt_interactive_console_until_pattern, wait_for_console_pattern, \
     exec_command, exec_command_and_wait_for_pattern, get_qemu_img, which
 from .testcase import QemuBaseTest, QemuUserTest, QemuSystemTest
diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index 600e0509db..bebcd46dcf 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -29,52 +29,6 @@ def which(tool):
             return p
     return None
 
-def has_cmd(name, args=None):
-    """
-    This function is for use in a @skipUnless decorator, e.g.:
-
-        @skipUnless(*has_cmd('sudo -n', ('sudo', '-n', 'true')))
-        def test_something_that_needs_sudo(self):
-            ...
-    """
-
-    if args is None:
-        args = ('which', name)
-
-    try:
-        _, stderr, exitcode = run_cmd(args)
-    except Exception as e:
-        exitcode = -1
-        stderr = str(e)
-
-    if exitcode != 0:
-        cmd_line = ' '.join(args)
-        err = f'{name} required, but "{cmd_line}" failed: {stderr.strip()}'
-        return (False, err)
-    else:
-        return (True, '')
-
-def has_cmds(*cmds):
-    """
-    This function is for use in a @skipUnless decorator and
-    allows checking for the availability of multiple commands, e.g.:
-
-        @skipUnless(*has_cmds(('cmd1', ('cmd1', '--some-parameter')),
-                              'cmd2', 'cmd3'))
-        def test_something_that_needs_cmd1_and_cmd2(self):
-            ...
-    """
-
-    for cmd in cmds:
-        if isinstance(cmd, str):
-            cmd = (cmd,)
-
-        ok, errstr = has_cmd(*cmd)
-        if not ok:
-            return (False, errstr)
-
-    return (True, '')
-
 def run_cmd(args):
     subp = subprocess.Popen(args,
                             stdout=subprocess.PIPE,
@@ -254,7 +208,7 @@ def get_qemu_img(test):
     qemu_img = os.path.join(BUILD_DIR, 'qemu-img')
     if os.path.exists(qemu_img):
         return qemu_img
-    (has_system_qemu_img, errmsg) = has_cmd('qemu-img')
-    if has_system_qemu_img:
-        return 'qemu-img'
-    test.skipTest(errmsg)
+    qemu_img = which('qemu-img')
+    if qemu_img is not None:
+        return qemu_img
+    test.skipTest(f"qemu-img not found in {BUILD_DIR} or '$PATH'")
diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
index d375f2713b..2e5c6d110c 100644
--- a/tests/functional/qemu_test/tuxruntest.py
+++ b/tests/functional/qemu_test/tuxruntest.py
@@ -15,7 +15,7 @@
 from qemu_test import QemuSystemTest
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import wait_for_console_pattern
-from qemu_test import has_cmd, run_cmd, get_qemu_img
+from qemu_test import which, run_cmd, get_qemu_img
 
 class TuxRunBaselineTest(QemuSystemTest):
 
@@ -38,10 +38,8 @@ def setUp(self):
         super().setUp()
 
         # We need zstd for all the tuxrun tests
-        (has_zstd, msg) = has_cmd('zstd')
-        if has_zstd is False:
-            self.skipTest(msg)
-        self.zstd = 'zstd'
+        if which('zstd') is None:
+            self.skipTest("zstd not found in $PATH")
 
         # Pre-init TuxRun specific settings: Most machines work with
         # reasonable defaults but we sometimes need to tweak the
@@ -78,7 +76,7 @@ def fetch_tuxrun_assets(self, kernel_asset, rootfs_asset, dtb_asset=None):
 
         disk_image = self.workdir + "/rootfs.ext4"
 
-        run_cmd([self.zstd, "-f", "-d", disk_image_zst,
+        run_cmd(['zstd', "-f", "-d", disk_image_zst,
                  "-o", disk_image])
         # zstd copies source archive permissions for the output
         # file, so must make this writable for QEMU
-- 
2.46.0


