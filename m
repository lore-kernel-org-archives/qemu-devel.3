Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BD3C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 00:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgCfE-000757-G2; Mon, 19 Aug 2024 20:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sgCf4-0006CJ-Ng
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:23:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sgCf2-0003ts-9b
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724113423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3DRnrN6I6/B7gYk188UkJV+Z825z6apeSX/OAnvW++I=;
 b=DTl3J7Gn7fWO2a01AH9cFvRF7aXQJhY0QzKwpPLPeVhXCtOuchj9vYqdRQFCOL4gg3sj1n
 I94qA0Oq1F2Xf2Nntp3k1b12o6quLWEGFpDWE0fceP6DNQbjglTR22tfHSRw9S74RsLLyO
 H6ucEJkaAH6dWjwB7cgdpumbbCCaQow=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-HtTdzgVUMM-nzQUAOiZPsQ-1; Mon,
 19 Aug 2024 20:23:41 -0400
X-MC-Unique: HtTdzgVUMM-nzQUAOiZPsQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6397D1954B1F; Tue, 20 Aug 2024 00:23:40 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.8.20])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A95519560A3; Tue, 20 Aug 2024 00:23:37 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/8] python/qapi: move scripts/qapi to python/qemu/qapi
Date: Mon, 19 Aug 2024 20:23:16 -0400
Message-ID: <20240820002318.1380276-8-jsnow@redhat.com>
In-Reply-To: <20240820002318.1380276-1-jsnow@redhat.com>
References: <20240820002318.1380276-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is being done for the sake of unifying the linting and static type
analysis configurations between scripts/qapi and python/qemu/*.

With this change, the qapi module will now be checked by mypy, flake8,
pylint, isort etc under all python versions from 3.8 through 3.13 under
a variety of different dependency configurations in the GitLab testing
pipelines.

The tests can be run locally, as always:

> cd qemu.git/python
> make check-minreqs
> make check-tox
> make check-dev

"check-minreqs" is the must-pass GitLab test.
"check-tox" is the optional allowed-to-fail GitLab test.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 MAINTAINERS                                 |  2 +-
 docs/conf.py                                |  2 +-
 docs/sphinx/qapidoc.py                      |  6 ++---
 meson.build                                 | 28 ++++++++++-----------
 {scripts => python/qemu}/qapi/.flake8       |  0
 {scripts => python/qemu}/qapi/.isort.cfg    |  0
 {scripts => python/qemu}/qapi/__init__.py   |  0
 {scripts => python/qemu}/qapi/commands.py   |  0
 {scripts => python/qemu}/qapi/common.py     |  0
 {scripts => python/qemu}/qapi/error.py      |  0
 {scripts => python/qemu}/qapi/events.py     |  0
 {scripts => python/qemu}/qapi/expr.py       |  0
 {scripts => python/qemu}/qapi/gen.py        |  0
 {scripts => python/qemu}/qapi/introspect.py |  0
 {scripts => python/qemu}/qapi/main.py       |  0
 {scripts => python/qemu}/qapi/mypy.ini      |  0
 {scripts => python/qemu}/qapi/parser.py     |  0
 {scripts => python/qemu}/qapi/pylintrc      |  0
 {scripts => python/qemu}/qapi/schema.py     |  0
 {scripts => python/qemu}/qapi/source.py     |  0
 {scripts => python/qemu}/qapi/types.py      |  0
 {scripts => python/qemu}/qapi/visit.py      |  0
 python/setup.cfg                            |  1 +
 scripts/qapi-gen.py                         |  4 ++-
 tests/qapi-schema/meson.build               |  2 +-
 tests/qapi-schema/test-qapi.py              |  4 +--
 26 files changed, 26 insertions(+), 23 deletions(-)
 rename {scripts => python/qemu}/qapi/.flake8 (100%)
 rename {scripts => python/qemu}/qapi/.isort.cfg (100%)
 rename {scripts => python/qemu}/qapi/__init__.py (100%)
 rename {scripts => python/qemu}/qapi/commands.py (100%)
 rename {scripts => python/qemu}/qapi/common.py (100%)
 rename {scripts => python/qemu}/qapi/error.py (100%)
 rename {scripts => python/qemu}/qapi/events.py (100%)
 rename {scripts => python/qemu}/qapi/expr.py (100%)
 rename {scripts => python/qemu}/qapi/gen.py (100%)
 rename {scripts => python/qemu}/qapi/introspect.py (100%)
 rename {scripts => python/qemu}/qapi/main.py (100%)
 rename {scripts => python/qemu}/qapi/mypy.ini (100%)
 rename {scripts => python/qemu}/qapi/parser.py (100%)
 rename {scripts => python/qemu}/qapi/pylintrc (100%)
 rename {scripts => python/qemu}/qapi/schema.py (100%)
 rename {scripts => python/qemu}/qapi/source.py (100%)
 rename {scripts => python/qemu}/qapi/types.py (100%)
 rename {scripts => python/qemu}/qapi/visit.py (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3584d6a6c6d..1912940631d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3214,7 +3214,7 @@ F: tests/unit/test-qapi-*.c
 F: tests/unit/test-qmp-*.c
 F: tests/unit/test-visitor-serialization.c
 F: scripts/qapi-gen.py
-F: scripts/qapi/*
+F: python/qemu/qapi/*
 F: docs/sphinx/qapidoc.py
 F: docs/devel/qapi*
 T: git https://repo.or.cz/qemu/armbru.git qapi-next
diff --git a/docs/conf.py b/docs/conf.py
index 876f6768815..6600db976b3 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -46,7 +46,7 @@
 # Our extensions are in docs/sphinx; the qapidoc extension requires
 # the QAPI modules from scripts/.
 sys.path.insert(0, os.path.join(qemu_docdir, "sphinx"))
-sys.path.insert(0, os.path.join(qemu_docdir, "../scripts"))
+sys.path.insert(0, os.path.join(qemu_docdir, "../python"))
 
 
 # -- General configuration ------------------------------------------------
diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 738b2450fb1..777fd1ac836 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -33,9 +33,9 @@
 from docutils import nodes
 from docutils.parsers.rst import Directive, directives
 from docutils.statemachine import ViewList
-from qapi.error import QAPIError, QAPISemError
-from qapi.gen import QAPISchemaVisitor
-from qapi.schema import QAPISchema
+from qemu.qapi.error import QAPIError, QAPISemError
+from qemu.qapi.gen import QAPISchemaVisitor
+from qemu.qapi.schema import QAPISchema
 
 from sphinx import addnodes
 from sphinx.directives.code import CodeBlock
diff --git a/meson.build b/meson.build
index fbda17c987e..f96c9bebe0c 100644
--- a/meson.build
+++ b/meson.build
@@ -3274,20 +3274,20 @@ genh += configure_file(output: 'config-host.h', configuration: config_host_data)
 hxtool = find_program('scripts/hxtool')
 shaderinclude = find_program('scripts/shaderinclude.py')
 qapi_gen = find_program('scripts/qapi-gen.py')
-qapi_gen_depends = [ meson.current_source_dir() / 'scripts/qapi/__init__.py',
-                     meson.current_source_dir() / 'scripts/qapi/commands.py',
-                     meson.current_source_dir() / 'scripts/qapi/common.py',
-                     meson.current_source_dir() / 'scripts/qapi/error.py',
-                     meson.current_source_dir() / 'scripts/qapi/events.py',
-                     meson.current_source_dir() / 'scripts/qapi/expr.py',
-                     meson.current_source_dir() / 'scripts/qapi/gen.py',
-                     meson.current_source_dir() / 'scripts/qapi/introspect.py',
-                     meson.current_source_dir() / 'scripts/qapi/main.py',
-                     meson.current_source_dir() / 'scripts/qapi/parser.py',
-                     meson.current_source_dir() / 'scripts/qapi/schema.py',
-                     meson.current_source_dir() / 'scripts/qapi/source.py',
-                     meson.current_source_dir() / 'scripts/qapi/types.py',
-                     meson.current_source_dir() / 'scripts/qapi/visit.py',
+qapi_gen_depends = [ meson.current_source_dir() / 'python/qemu/qapi/__init__.py',
+                     meson.current_source_dir() / 'python/qemu/qapi/commands.py',
+                     meson.current_source_dir() / 'python/qemu/qapi/common.py',
+                     meson.current_source_dir() / 'python/qemu/qapi/error.py',
+                     meson.current_source_dir() / 'python/qemu/qapi/events.py',
+                     meson.current_source_dir() / 'python/qemu/qapi/expr.py',
+                     meson.current_source_dir() / 'python/qemu/qapi/gen.py',
+                     meson.current_source_dir() / 'python/qemu/qapi/introspect.py',
+                     meson.current_source_dir() / 'python/qemu/qapi/main.py',
+                     meson.current_source_dir() / 'python/qemu/qapi/parser.py',
+                     meson.current_source_dir() / 'python/qemu/qapi/schema.py',
+                     meson.current_source_dir() / 'python/qemu/qapi/source.py',
+                     meson.current_source_dir() / 'python/qemu/qapi/types.py',
+                     meson.current_source_dir() / 'python/qemu/qapi/visit.py',
                      meson.current_source_dir() / 'scripts/qapi-gen.py'
 ]
 
diff --git a/scripts/qapi/.flake8 b/python/qemu/qapi/.flake8
similarity index 100%
rename from scripts/qapi/.flake8
rename to python/qemu/qapi/.flake8
diff --git a/scripts/qapi/.isort.cfg b/python/qemu/qapi/.isort.cfg
similarity index 100%
rename from scripts/qapi/.isort.cfg
rename to python/qemu/qapi/.isort.cfg
diff --git a/scripts/qapi/__init__.py b/python/qemu/qapi/__init__.py
similarity index 100%
rename from scripts/qapi/__init__.py
rename to python/qemu/qapi/__init__.py
diff --git a/scripts/qapi/commands.py b/python/qemu/qapi/commands.py
similarity index 100%
rename from scripts/qapi/commands.py
rename to python/qemu/qapi/commands.py
diff --git a/scripts/qapi/common.py b/python/qemu/qapi/common.py
similarity index 100%
rename from scripts/qapi/common.py
rename to python/qemu/qapi/common.py
diff --git a/scripts/qapi/error.py b/python/qemu/qapi/error.py
similarity index 100%
rename from scripts/qapi/error.py
rename to python/qemu/qapi/error.py
diff --git a/scripts/qapi/events.py b/python/qemu/qapi/events.py
similarity index 100%
rename from scripts/qapi/events.py
rename to python/qemu/qapi/events.py
diff --git a/scripts/qapi/expr.py b/python/qemu/qapi/expr.py
similarity index 100%
rename from scripts/qapi/expr.py
rename to python/qemu/qapi/expr.py
diff --git a/scripts/qapi/gen.py b/python/qemu/qapi/gen.py
similarity index 100%
rename from scripts/qapi/gen.py
rename to python/qemu/qapi/gen.py
diff --git a/scripts/qapi/introspect.py b/python/qemu/qapi/introspect.py
similarity index 100%
rename from scripts/qapi/introspect.py
rename to python/qemu/qapi/introspect.py
diff --git a/scripts/qapi/main.py b/python/qemu/qapi/main.py
similarity index 100%
rename from scripts/qapi/main.py
rename to python/qemu/qapi/main.py
diff --git a/scripts/qapi/mypy.ini b/python/qemu/qapi/mypy.ini
similarity index 100%
rename from scripts/qapi/mypy.ini
rename to python/qemu/qapi/mypy.ini
diff --git a/scripts/qapi/parser.py b/python/qemu/qapi/parser.py
similarity index 100%
rename from scripts/qapi/parser.py
rename to python/qemu/qapi/parser.py
diff --git a/scripts/qapi/pylintrc b/python/qemu/qapi/pylintrc
similarity index 100%
rename from scripts/qapi/pylintrc
rename to python/qemu/qapi/pylintrc
diff --git a/scripts/qapi/schema.py b/python/qemu/qapi/schema.py
similarity index 100%
rename from scripts/qapi/schema.py
rename to python/qemu/qapi/schema.py
diff --git a/scripts/qapi/source.py b/python/qemu/qapi/source.py
similarity index 100%
rename from scripts/qapi/source.py
rename to python/qemu/qapi/source.py
diff --git a/scripts/qapi/types.py b/python/qemu/qapi/types.py
similarity index 100%
rename from scripts/qapi/types.py
rename to python/qemu/qapi/types.py
diff --git a/scripts/qapi/visit.py b/python/qemu/qapi/visit.py
similarity index 100%
rename from scripts/qapi/visit.py
rename to python/qemu/qapi/visit.py
diff --git a/python/setup.cfg b/python/setup.cfg
index 58dba90f815..d1582f74ddd 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -28,6 +28,7 @@ packages =
     qemu.qmp
     qemu.machine
     qemu.utils
+    qemu.qapi
 
 [options.package_data]
 * = py.typed
diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
index f3518d29a54..42912c91716 100644
--- a/scripts/qapi-gen.py
+++ b/scripts/qapi-gen.py
@@ -11,9 +11,11 @@
 execution environment.
 """
 
+import os
 import sys
 
-from qapi import main
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'python'))
+from qemu.qapi import main
 
 if __name__ == '__main__':
     sys.exit(main.main())
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index 0f479d93170..080444d0cd4 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -1,5 +1,5 @@
 test_env = environment()
-test_env.set('PYTHONPATH', meson.project_source_root() / 'scripts')
+test_env.set('PYTHONPATH', meson.project_source_root() / 'python')
 test_env.set('PYTHONIOENCODING', 'utf-8')
 
 schemas = [
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 7e3f9f4aa1f..dcc0d949971 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -18,8 +18,8 @@
 import sys
 from io import StringIO
 
-from qapi.error import QAPIError
-from qapi.schema import QAPISchema, QAPISchemaVisitor
+from qemu.qapi.error import QAPIError
+from qemu.qapi.schema import QAPISchema, QAPISchemaVisitor
 
 
 class QAPISchemaTestVisitor(QAPISchemaVisitor):
-- 
2.45.0


