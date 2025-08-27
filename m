Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADA5CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHoO-0007g9-Us; Wed, 27 Aug 2025 11:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHlF-0000UT-5Z; Wed, 27 Aug 2025 11:08:33 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHlA-0005sQ-Vy; Wed, 27 Aug 2025 11:08:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4040614C560;
 Wed, 27 Aug 2025 18:03:00 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2CB98269867;
 Wed, 27 Aug 2025 18:03:27 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Sv. Lockal" <lockalsash@gmail.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 55/59] mkvenv: Support pip 25.2
Date: Wed, 27 Aug 2025 18:03:00 +0300
Message-ID: <20250827150323.2694101-55-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: "Sv. Lockal" <lockalsash@gmail.com>

Fix compilation with pip-25.2 due to missing distlib.version

Bug: https://gitlab.com/qemu-project/qemu/-/issues/3062

Signed-off-by: Sv. Lockal <lockalsash@gmail.com>
[Edits: Type "safety" whackamole --js]
Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250811190159.237321-1-jsnow@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 6ad034e71232c2929ed546304c9d249312bb632f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index 8ac5b0b2a0..f102527c4d 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -84,6 +84,7 @@
     Sequence,
     Tuple,
     Union,
+    cast,
 )
 import venv
 
@@ -94,17 +95,39 @@
 HAVE_DISTLIB = True
 try:
     import distlib.scripts
-    import distlib.version
 except ImportError:
     try:
         # Reach into pip's cookie jar.  pylint and flake8 don't understand
         # that these imports will be used via distlib.xxx.
         from pip._vendor import distlib
         import pip._vendor.distlib.scripts  # noqa, pylint: disable=unused-import
-        import pip._vendor.distlib.version  # noqa, pylint: disable=unused-import
     except ImportError:
         HAVE_DISTLIB = False
 
+# pip 25.2 does not vendor distlib.version, but it uses vendored
+# packaging.version
+HAVE_DISTLIB_VERSION = True
+try:
+    import distlib.version  # pylint: disable=ungrouped-imports
+except ImportError:
+    try:
+        # pylint: disable=unused-import,ungrouped-imports
+        import pip._vendor.distlib.version  # noqa
+    except ImportError:
+        HAVE_DISTLIB_VERSION = False
+
+HAVE_PACKAGING_VERSION = True
+try:
+    # Do not bother importing non-vendored packaging, because it is not
+    # in stdlib.
+    from pip._vendor import packaging
+    # pylint: disable=unused-import
+    import pip._vendor.packaging.requirements  # noqa
+    import pip._vendor.packaging.version  # noqa
+except ImportError:
+    HAVE_PACKAGING_VERSION = False
+
+
 # Try to load tomllib, with a fallback to tomli.
 # HAVE_TOMLLIB is checked below, just-in-time, so that mkvenv does not fail
 # outside the venv or before a potential call to ensurepip in checkpip().
@@ -133,6 +156,39 @@ class Ouch(RuntimeError):
     """An Exception class we can't confuse with a builtin."""
 
 
+class Matcher:
+    """Compatibility appliance for version/requirement string parsing."""
+    def __init__(self, name_and_constraint: str):
+        """Create a matcher from a requirement-like string."""
+        if HAVE_DISTLIB_VERSION:
+            self._m = distlib.version.LegacyMatcher(name_and_constraint)
+        elif HAVE_PACKAGING_VERSION:
+            self._m = packaging.requirements.Requirement(name_and_constraint)
+        else:
+            raise Ouch("found neither distlib.version nor packaging.version")
+        self.name = self._m.name
+
+    def match(self, version_str: str) -> bool:
+        """Return True if `version` satisfies the stored constraint."""
+        if HAVE_DISTLIB_VERSION:
+            return cast(
+                bool,
+                self._m.match(distlib.version.LegacyVersion(version_str))
+            )
+
+        assert HAVE_PACKAGING_VERSION
+        return cast(
+            bool,
+            self._m.specifier.contains(
+                packaging.version.Version(version_str), prereleases=True
+            )
+        )
+
+    def __repr__(self) -> str:
+        """Stable debug representation delegated to the backend."""
+        return repr(self._m)
+
+
 class QemuEnvBuilder(venv.EnvBuilder):
     """
     An extension of venv.EnvBuilder for building QEMU's configure-time venv.
@@ -669,7 +725,7 @@ def _do_ensure(
     canary = None
     for name, info in group.items():
         constraint = _make_version_constraint(info, False)
-        matcher = distlib.version.LegacyMatcher(name + constraint)
+        matcher = Matcher(name + constraint)
         print(f"mkvenv: checking for {matcher}", file=sys.stderr)
 
         dist: Optional[Distribution] = None
@@ -683,7 +739,7 @@ def _do_ensure(
             # Always pass installed package to pip, so that they can be
             # updated if the requested version changes
             or not _is_system_package(dist)
-            or not matcher.match(distlib.version.LegacyVersion(dist.version))
+            or not matcher.match(dist.version)
         ):
             absent.append(name + _make_version_constraint(info, True))
             if len(absent) == 1:
-- 
2.47.2


