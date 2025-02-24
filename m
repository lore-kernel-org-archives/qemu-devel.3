Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949A8C021BC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 18:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdC4-0004VU-SS; Mon, 24 Feb 2025 13:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmd4n-0008UQ-51
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:21:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmd4T-0000SH-IT
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740421241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=V2okbYWvwQq0dzjuynuNshi0SY/bcufp1gNx6gOmgII=;
 b=GmRA7vMn7epHic3Dx11yCubIcZGDuFC7YvSsteZh2czWs+qMxpC87ZuC5ygexEkkXgGHzq
 0BSo6zTZncFzD5Y831XcJyMTwdfEPH4MymGTZqKvmvkmO/Itwa4NBhjXq26HnfuW9mkXVP
 wQw6nYInQF/H+XynOF5J6bbwZBNJm6U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-3vt5p6dxMJWJmvH-HTd_iA-1; Mon,
 24 Feb 2025 13:20:36 -0500
X-MC-Unique: 3vt5p6dxMJWJmvH-HTd_iA-1
X-Mimecast-MFC-AGG-ID: 3vt5p6dxMJWJmvH-HTd_iA_1740421236
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D04119560BC; Mon, 24 Feb 2025 18:20:35 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.119])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2DE0619560A3; Mon, 24 Feb 2025 18:20:32 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Victor Toso <victortoso@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2] qapi: pluggable backend code generators
Date: Mon, 24 Feb 2025 18:20:30 +0000
Message-ID: <20250224182030.2089959-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The 'qapi.backend.QAPIBackend' class defines an API contract for code
generators. The current generator is put into a new class
'qapi.backend.QAPICBackend' and made to be the default impl.

A custom generator can be requested using the '-k' arg which takes a
fully qualified python class name

   qapi-gen.py -B the.python.module.QAPIMyBackend

This allows out of tree code to use the QAPI generator infrastructure
to create new language bindings for QAPI schemas. This has the caveat
that the QAPI generator APIs are not guaranteed stable, so consumers
of this feature may have to update their code to be compatible with
future QEMU releases.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---

In v2:

 - Create QAPISchema object ahead of calling backend
 - Use -B instead of -k
 - Fix mypy annotations
 - Add error checking when loading backend
 - Hardcode import of QAPICBackend to guarantee mypy coverage

 scripts/qapi/backend.py | 63 ++++++++++++++++++++++++++++++++++
 scripts/qapi/main.py    | 75 ++++++++++++++++++++++-------------------
 2 files changed, 103 insertions(+), 35 deletions(-)
 create mode 100644 scripts/qapi/backend.py

diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py
new file mode 100644
index 0000000000..14e60aa67a
--- /dev/null
+++ b/scripts/qapi/backend.py
@@ -0,0 +1,63 @@
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+
+from abc import ABC, abstractmethod
+
+from .commands import gen_commands
+from .events import gen_events
+from .features import gen_features
+from .introspect import gen_introspect
+from .schema import QAPISchema
+from .types import gen_types
+from .visit import gen_visit
+
+
+class QAPIBackend(ABC):
+
+    @abstractmethod
+    def generate(self,
+                 schema: QAPISchema,
+                 output_dir: str,
+                 prefix: str,
+                 unmask: bool,
+                 builtins: bool,
+                 gen_tracing: bool) -> None:
+        """
+        Generate code for the given schema into the target directory.
+
+        :param schema: The primary QAPI schema object.
+        :param output_dir: The output directory to store generated code.
+        :param prefix: Optional C-code prefix for symbol names.
+        :param unmask: Expose non-ABI names through introspection?
+        :param builtins: Generate code for built-in types?
+
+        :raise QAPIError: On failures.
+        """
+
+
+class QAPICBackend(QAPIBackend):
+
+    def generate(self,
+                 schema: QAPISchema,
+                 output_dir: str,
+                 prefix: str,
+                 unmask: bool,
+                 builtins: bool,
+                 gen_tracing: bool) -> None:
+        """
+        Generate C code for the given schema into the target directory.
+
+        :param schema_file: The primary QAPI schema file.
+        :param output_dir: The output directory to store generated code.
+        :param prefix: Optional C-code prefix for symbol names.
+        :param unmask: Expose non-ABI names through introspection?
+        :param builtins: Generate code for built-in types?
+
+        :raise QAPIError: On failures.
+        """
+        gen_types(schema, output_dir, prefix, builtins)
+        gen_features(schema, output_dir, prefix)
+        gen_visit(schema, output_dir, prefix, builtins)
+        gen_commands(schema, output_dir, prefix, gen_tracing)
+        gen_events(schema, output_dir, prefix)
+        gen_introspect(schema, output_dir, prefix, unmask)
diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
index 324081b9fc..8a8b1e0121 100644
--- a/scripts/qapi/main.py
+++ b/scripts/qapi/main.py
@@ -8,18 +8,14 @@
 """
 
 import argparse
+from importlib import import_module
 import sys
 from typing import Optional
 
-from .commands import gen_commands
+from .backend import QAPIBackend, QAPICBackend
 from .common import must_match
 from .error import QAPIError
-from .events import gen_events
-from .features import gen_features
-from .introspect import gen_introspect
 from .schema import QAPISchema
-from .types import gen_types
-from .visit import gen_visit
 
 
 def invalid_prefix_char(prefix: str) -> Optional[str]:
@@ -29,32 +25,37 @@ def invalid_prefix_char(prefix: str) -> Optional[str]:
     return None
 
 
-def generate(schema_file: str,
-             output_dir: str,
-             prefix: str,
-             unmask: bool = False,
-             builtins: bool = False,
-             gen_tracing: bool = False) -> None:
-    """
-    Generate C code for the given schema into the target directory.
+def create_backend(path: str) -> QAPIBackend:
+    if path is None:
+        return QAPICBackend()
 
-    :param schema_file: The primary QAPI schema file.
-    :param output_dir: The output directory to store generated code.
-    :param prefix: Optional C-code prefix for symbol names.
-    :param unmask: Expose non-ABI names through introspection?
-    :param builtins: Generate code for built-in types?
+    if "." not in path:
+        print(f"Missing qualified module path in '{path}'", file=sys.stderr)
+        sys.exit(1)
 
-    :raise QAPIError: On failures.
-    """
-    assert invalid_prefix_char(prefix) is None
+    module_path, _, class_name = path.rpartition('.')
+    try:
+        mod = import_module(module_path)
+    except Exception as ex:
+        print(f"Unable to import '{module_path}': {ex}", file=sys.stderr)
+        sys.exit(1)
+
+    if not hasattr(mod, class_name):
+        print(f"Module '{module_path}' has no class '{class_name}'", file=sys.stderr)
+        sys.exit(1)
+    klass = getattr(mod, class_name)
+
+    try:
+        backend = klass()
+
+        if not isinstance(backend, QAPIBackend):
+            print(f"Backend '{path}' must be an instance of QAPIBackend", file=sys.stderr)
+            sys.exit(1)
 
-    schema = QAPISchema(schema_file)
-    gen_types(schema, output_dir, prefix, builtins)
-    gen_features(schema, output_dir, prefix)
-    gen_visit(schema, output_dir, prefix, builtins)
-    gen_commands(schema, output_dir, prefix, gen_tracing)
-    gen_events(schema, output_dir, prefix)
-    gen_introspect(schema, output_dir, prefix, unmask)
+        return backend
+    except Exception as ex:
+        print(f"Backend '{path}' cannot be instantiated: {ex}", file=sys.stderr)
+        sys.exit(1)
 
 
 def main() -> int:
@@ -77,6 +78,8 @@ def main() -> int:
     parser.add_argument('-u', '--unmask-non-abi-names', action='store_true',
                         dest='unmask',
                         help="expose non-ABI names in introspection")
+    parser.add_argument('-B', '--backend', default=None,
+                        help="Python module name for code generator")
 
     # Option --suppress-tracing exists so we can avoid solving build system
     # problems.  TODO Drop it when we no longer need it.
@@ -93,12 +96,14 @@ def main() -> int:
         return 1
 
     try:
-        generate(args.schema,
-                 output_dir=args.output_dir,
-                 prefix=args.prefix,
-                 unmask=args.unmask,
-                 builtins=args.builtins,
-                 gen_tracing=not args.suppress_tracing)
+        schema = QAPISchema(args.schema)
+        backend = create_backend(args.backend)
+        backend.generate(schema,
+                         output_dir=args.output_dir,
+                         prefix=args.prefix,
+                         unmask=args.unmask,
+                         builtins=args.builtins,
+                         gen_tracing=not args.suppress_tracing)
     except QAPIError as err:
         print(err, file=sys.stderr)
         return 1
-- 
2.47.1


