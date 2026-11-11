Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1D5606A327
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CCLwG93Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR4N3-0005lt-UA; Wed, 11 Nov 2026 04:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xR4Mt-0005kd-MN
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 04:11:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xR4Mr-0000kA-DL
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 04:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794388302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SXd9A0lEhklwSD9T5LQflDDJnUtvgUNHtKQaVETWIQ8=;
 b=CCLwG93YM9Q8ChTAUaVCK8UdnzRt/qaR9Rp42G1XTzKGLj04A5c9Vigktux5aPZtxGlMk7
 +ZjDv8RCKngL+zHJIPS1vF2zU6w6Bmcvw4CopGUzygJTB882MHL7Ws4p/VQXqLYNgfih00
 ZJ3xxx8ZCtegia+WiyS9XoiscalKuzU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-jeFfFCGaN8a7cQJUyqGBiw-1; Wed,
 11 Nov 2026 04:11:38 -0500
X-MC-Unique: jeFfFCGaN8a7cQJUyqGBiw-1
X-Mimecast-MFC-AGG-ID: jeFfFCGaN8a7cQJUyqGBiw_1794388297
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6278619560BB; Wed, 11 Nov 2026 09:11:37 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E222930001BE; Wed, 11 Nov 2026 09:11:34 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2] iotests: better heuristics to find I/O tests build/source
 dirs
Date: Wed, 11 Nov 2026 09:11:33 +0000
Message-ID: <20261111091133.3527549-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently the I/O tests cannot be run if executing directly
from the source directory, even when wrapped by the 'run'
script, due to inadequate heuristics to guess the directories.

If using the 'run' script, meson can tell us exactly where the
top level build and source directories are, so we don't need
to guess. Just read MESON_BUILD_ROOT and MESON_SOURCE_ROOT
env variables if present.

If not using the 'run' script, we can do a bit better at
guessing the path from the 'check' filename. Always resolve
from sys.argv[0], even when it is not a symlink, instead of
falling back to 'cwd()' which doesn't work since we stopped
having in-tree builds. If invoked directly from the source
tree, guess that the build root is the default 'build' name
which often works.

With this change the following all work:

1. From root of build dir, with run script

  cd build
  ./run tests/qemu-iotests/check 5

2. From root of build dir, without run script

  cd build
  tests/qemu-iotests/check 5

3. From I/O tests subdir of build dir, with run script

  cd build/tests/qemu-iotests
  ../../run ./check 5

4. From I/O tests subdir of build dir, without run script

  cd build/tests/qemu-iotests
  ./check 5

5. From root of source dir, with run script

  ./build/run tests/qemu-iotests/check 5

6. From root of source dir, without run script

  tests/qemu-iotests/check 5

7. From I/O tests subdir of source dir, with run script

  cd tests/qemu-iotests
  ../../build/run ./check 5

8. From I/O tests subdir of source dir, without run script

  cd tests/qemu-iotests
  ./check 5

Before this commit, items 5-8 would always fail. Items 6 and
8 will not work if using a build directory with a name other
than the default 'build'. For those scenarios use one of the
other 6 possible variants.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build              |  1 +
 tests/qemu-iotests/check | 52 +++++++++++++++++++++++++++++-----------
 2 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/meson.build b/meson.build
index d7bcb581c18..9d15f2e9551 100644
--- a/meson.build
+++ b/meson.build
@@ -3502,6 +3502,7 @@ genh += config_host_h
 
 devenv = environment()
 devenv.set('MESON_BUILD_ROOT', meson.project_build_root())
+devenv.set('MESON_SOURCE_ROOT', meson.project_source_root())
 devenv.set('VIRTUAL_ENV', meson.project_build_root() / 'pyvenv')
 devenv.prepend('PATH', meson.project_build_root() / 'pyvenv'/ 'bin')
 devenv.prepend('PYTHONPATH', meson.current_source_dir() / 'tests' / 'functional')
diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index c8ba536970c..40baa2b4107 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -28,18 +28,42 @@ from findtests import TestFinder
 from testenv import TestEnv
 from testrunner import TestRunner
 
-def get_default_path(follow_link=False):
-    """
-    Try to automagically figure out the path we are running from.
-    """
-    # called from the build tree?
-    if os.path.islink(sys.argv[0]):
-        if follow_link:
-            return os.path.dirname(os.readlink(sys.argv[0]))
+
+def get_build_dir():
+    if "MESON_BUILD_ROOT" in os.environ:
+        br = os.environ["MESON_BUILD_ROOT"]
+        return os.path.join(br, "tests", "qemu-iotests")
+    else:
+        if os.path.islink(sys.argv[0]):
+            iobr = os.path.dirname(sys.argv[0])
+        else:
+            iobr = os.path.join(os.path.dirname(sys.argv[0]),
+                                "..", "..", "build", "tests", "qemu-iotests")
+        if (not os.path.exists(os.path.join(iobr, "check")) or
+            os.path.exists(os.path.join(iobr, "testenv.py"))):
+            raise Exception(f"MESON_BUILD_ROOT is not set, and guessed "
+                            "I/O tests build root {iobr} does not look "
+                            "valid. Please use the 'run' script to invoke "
+                            "the I/O tests")
+        return os.path.abspath(iobr)
+
+
+def get_source_dir():
+    if "MESON_SOURCE_ROOT" in os.environ:
+        sr = os.environ["MESON_SOURCE_ROOT"]
+        return os.path.join(sr, "tests", "qemu-iotests")
+    else:
+        if os.path.islink(sys.argv[0]):
+            iosr = os.path.dirname(os.readlink(sys.argv[0]))
         else:
-            return os.path.dirname(os.path.abspath(sys.argv[0]))
-    else:  # or source tree?
-        return os.getcwd()
+            iosr = os.path.dirname(sys.argv[0])
+        if not os.path.exists(os.path.join(iosr, "testenv.py")):
+            raise Exception(f"MESON_SOURCE_ROOT is not set, and guessed "
+                            "I/O tests source root {iosr} does not look "
+                            "valid. Please use the 'run' script to invoke "
+                            "the I/O tests")
+        return os.path.abspath(iosr)
+
 
 def make_argparser() -> argparse.ArgumentParser:
     p = argparse.ArgumentParser(
@@ -131,11 +155,11 @@ def make_argparser() -> argparse.ArgumentParser:
                        'middle of the process.')
     g_sel.add_argument('tests', metavar='TEST_FILES', nargs='*',
                        help='tests to run, or "--" followed by a command')
-    g_sel.add_argument('--build-dir', default=get_default_path(),
+    g_sel.add_argument('--build-dir', default=get_build_dir(),
                        help='Path to iotests build directory')
     g_sel.add_argument('--source-dir',
-                       default=get_default_path(follow_link=True),
-                       help='Path to iotests build directory')
+                       default=get_source_dir(),
+                       help='Path to iotests source directory')
 
     return p
 
-- 
2.56.0


