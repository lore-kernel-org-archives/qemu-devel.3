Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4319CA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 19:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulXmy-0006hz-Hj; Mon, 11 Aug 2025 15:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ulXmw-0006hf-IJ
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 15:02:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ulXmm-00068E-8d
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 15:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754938929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2H0EHkQSGfy+ISppsZXqIk19krjD1Cr8POkfu6dtHc8=;
 b=CWfL0jVARjAahL8elFQ2u98DsZsvjZ7iM8FrRpSb2MH1T42U58qFy7YN0QAT4covp8/7PF
 1lPlYosWAfsnk66HupoqnlE5tlwJtAFT+Hk+6RaGezEVKFUJfA+TBP3y7PzZ6/LuxBbbkw
 rpO1jeNLcTRsc2f+v9AbDrj1Mchi5aE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-RAoQBiQSMD2GuHOqP77j9Q-1; Mon,
 11 Aug 2025 15:02:05 -0400
X-MC-Unique: RAoQBiQSMD2GuHOqP77j9Q-1
X-Mimecast-MFC-AGG-ID: RAoQBiQSMD2GuHOqP77j9Q_1754938924
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 685AB18002C7; Mon, 11 Aug 2025 19:02:03 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.70])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9FBF73001472; Mon, 11 Aug 2025 19:02:00 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, "Sv. Lockal" <lockalsash@gmail.com>
Subject: [PATCH] mkvenv: Support pip 25.2
Date: Mon, 11 Aug 2025 15:01:59 -0400
Message-ID: <20250811190159.237321-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 python/scripts/mkvenv.py | 64 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index 8ac5b0b2a05..f102527c4de 100644
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
2.50.1


