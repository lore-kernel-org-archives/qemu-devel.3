Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C297EE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNa03-0004Ko-Eo; Tue, 17 Dec 2024 11:00:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNZzq-0004GD-En
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:00:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNZzo-00027c-PI
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734451228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ELr/rM7FSdeA0GsZz078xGh7Vop7TiEuEBNFFMFo/R8=;
 b=ZEvew5ZIDqNb20wCLfDVl2Qc/w10oTckRmCiW9HD9vIrls9URxW2HIj3XqdGRlFtqLJjYT
 CikA2PYniJ+0mx6zJjvTMDZLp25VbN4l3B4gW1IuKGNhW7Z22wp2jWFmHBJfEjSKcguFHh
 hr6JwHTnOpcT4lTfuNcMsCme3aBNH/U=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-ccDHzOj-OW21ZdNZzgs5rg-1; Tue,
 17 Dec 2024 11:00:24 -0500
X-MC-Unique: ccDHzOj-OW21ZdNZzgs5rg-1
X-Mimecast-MFC-AGG-ID: ccDHzOj-OW21ZdNZzgs5rg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E6E11955F3F; Tue, 17 Dec 2024 16:00:23 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.136])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE2B730044C1; Tue, 17 Dec 2024 16:00:20 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 09/32] tests/functional: drop 'has_cmd' and 'has_cmds'
 helpers
Date: Tue, 17 Dec 2024 15:59:30 +0000
Message-ID: <20241217155953.3950506-10-berrange@redhat.com>
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
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The 'which' helper is simpler, not depending on the external 'which'
binary, and is sufficient for test needs.

Reviewed-by: Thomas Huth <thuth@redhat.com>
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


