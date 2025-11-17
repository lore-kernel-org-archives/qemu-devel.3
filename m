Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92228CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 18:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL4KJ-0002c0-HX; Mon, 17 Nov 2025 13:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vL4KH-0002bb-7T
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 13:51:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vL4KE-00084g-Vl
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 13:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763405501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sKnlxMdNRwOrumbl+JG8c0k2jq6AgNvSnUaYTaCJ/Dg=;
 b=ieKpTwFjQNlFQ9G2tKLZYwHDit7LIbJ8LIdjKBRjpiFTV7+t4mDarYoEYoT3G2qa6lbipF
 ebZkdV9HGu3Vzir0K5ukc/p4L9T0uy7xBchP2GmndKxlNV+/CoEqLWW2VORQ2zLlTUFeWH
 gk5Na5IiYrn7EYcL8YIeCfNkhGOiPNA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-bDDssQFyP36_htPeynX_HA-1; Mon,
 17 Nov 2025 13:51:40 -0500
X-MC-Unique: bDDssQFyP36_htPeynX_HA-1
X-Mimecast-MFC-AGG-ID: bDDssQFyP36_htPeynX_HA_1763405499
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D55931956059; Mon, 17 Nov 2025 18:51:38 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.81.70])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 16D56180047F; Mon, 17 Nov 2025 18:51:35 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 01/22] python/mkvenv: ensure HAVE_LIB variables are actually
 constants
Date: Mon, 17 Nov 2025 13:51:09 -0500
Message-ID: <20251117185131.953681-2-jsnow@redhat.com>
In-Reply-To: <20251117185131.953681-1-jsnow@redhat.com>
References: <20251117185131.953681-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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
constants precisely once to alleviate this new nag message. Add an
ignore for this name for older versions of pylint that developers may
have installed locally.

(In other words: there is no solution that will cater to both pre- and
post- 4.x versions, so we target 4.x here and silence older versions.)

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
2.51.1


