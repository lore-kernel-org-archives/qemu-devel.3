Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC75CCF9F2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 22:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDrnS-0005LX-7q; Tue, 28 Oct 2025 18:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vDrnO-0005J2-Jb
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 18:04:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vDrnJ-0000oa-28
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 18:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761689034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UkMwNtZzhgyOAYF6GbcNwst33FiWtSlDG8oSaqnGrio=;
 b=G2cr5dU/a/ZKayfuceB3gpXgNQjdvXIKSSTG58E6lFxYQhzbOlPY8IU5cL43Q0N9ZrN8Fc
 dXN3qG4TxDuwbhYRlJVCkKunC/+hwdtYVM1xDN8b4MLhD67RWQukgow0GolKuYFTrR3UNP
 wn0iZnJsjajWXdmMHnKZvgnjTsqdTE4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-gDsIjorDP5qZvcYSBLM_zw-1; Tue,
 28 Oct 2025 18:03:50 -0400
X-MC-Unique: gDsIjorDP5qZvcYSBLM_zw-1
X-Mimecast-MFC-AGG-ID: gDsIjorDP5qZvcYSBLM_zw_1761689028
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 624071800657; Tue, 28 Oct 2025 22:03:48 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.120])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2F3C730001A2; Tue, 28 Oct 2025 22:03:45 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH RFC 01/10] python/mkvenv: ensure HAVE_LIB variables are
 actually constants
Date: Tue, 28 Oct 2025 18:03:31 -0400
Message-ID: <20251028220342.1407883-2-jsnow@redhat.com>
In-Reply-To: <20251028220342.1407883-1-jsnow@redhat.com>
References: <20251028220342.1407883-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Pylint 4.x has refined checking for variable names that behave as
constants vs ones that do not; unfortunately our tricky import machinery
is perceived as these variables being re-assigned.

Add a temporary variable with an underscore and assign to the global
constants precisely once to alleviate this new nag message.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/scripts/mkvenv.py | 24 ++++++++++++++++--------
 python/setup.cfg         |  1 +
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index 9aed266df1b..a064709e6ce 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -92,7 +92,7 @@
 # Try to load distlib, with a fallback to pip's vendored version.
 # HAVE_DISTLIB is checked below, just-in-time, so that mkvenv does not fail
 # outside the venv or before a potential call to ensurepip in checkpip().
-HAVE_DISTLIB = True
+_import_ok = True
 try:
     import distlib.scripts
 except ImportError:
@@ -102,11 +102,13 @@
         from pip._vendor import distlib
         import pip._vendor.distlib.scripts  # noqa, pylint: disable=unused-import
     except ImportError:
-        HAVE_DISTLIB = False
+        _import_ok = False
+
+HAVE_DISTLIB = _import_ok
 
 # pip 25.2 does not vendor distlib.version, but it uses vendored
 # packaging.version
-HAVE_DISTLIB_VERSION = True
+_import_ok = True
 try:
     import distlib.version  # pylint: disable=ungrouped-imports
 except ImportError:
@@ -114,9 +116,11 @@
         # pylint: disable=unused-import,ungrouped-imports
         import pip._vendor.distlib.version  # noqa
     except ImportError:
-        HAVE_DISTLIB_VERSION = False
+        _import_ok = False
 
-HAVE_PACKAGING_VERSION = True
+HAVE_DISTLIB_VERSION = _import_ok
+
+_import_ok = True
 try:
     # Do not bother importing non-vendored packaging, because it is not
     # in stdlib.
@@ -125,20 +129,24 @@
     import pip._vendor.packaging.requirements  # noqa
     import pip._vendor.packaging.version  # noqa
 except ImportError:
-    HAVE_PACKAGING_VERSION = False
+    _import_ok = False
+
+HAVE_PACKAGING_VERSION = _import_ok
 
 
 # Try to load tomllib, with a fallback to tomli.
 # HAVE_TOMLLIB is checked below, just-in-time, so that mkvenv does not fail
 # outside the venv or before a potential call to ensurepip in checkpip().
-HAVE_TOMLLIB = True
+_import_ok = True
 try:
     import tomllib
 except ImportError:
     try:
         import tomli as tomllib
     except ImportError:
-        HAVE_TOMLLIB = False
+        _import_ok = False
+
+HAVE_TOMLLIB = _import_ok
 
 # Do not add any mandatory dependencies from outside the stdlib:
 # This script *must* be usable standalone!
diff --git a/python/setup.cfg b/python/setup.cfg
index d7f5dc7bafe..f40f11396c9 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -159,6 +159,7 @@ good-names=i,
            c,   # for c in string: ...
            T,   # for TypeVars. See pylint#3401
            SocketAddrT,  # Not sure why this is invalid.
+           _import_ok,  # For mkvenv import trickery and compatibility pre-4.x
 
 [pylint.similarities]
 # Ignore imports when computing similarities.
-- 
2.51.0


