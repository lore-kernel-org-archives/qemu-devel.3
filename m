Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726FDC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk1VK-0007bs-Ls; Mon, 17 Feb 2025 08:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tk1VD-0007VC-4j
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:49:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tk1V9-0004Cq-20
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739800173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IdzuMFWpd4kAOz1t2kfPk7KRkHnHHz02VGHoJeSAB4s=;
 b=TtMLnhgEDEh5ZwXSjXwS0oAIGQUp8rhyfSYi9kxEj0a8uUDNa205Wtss2XO47j1/+KWAPS
 pDHcZ5XHDuMXv4tuZ6ZxoPFoIDONaHbyKTwiI6EOAXKRPpYpAv1nIYlUDVc5jklalnefPE
 YXFUJ1HMHQ8s2Q1M1PkeBRP/y77tUH0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-ks_D4DluPrGvnHxIm3uidg-1; Mon,
 17 Feb 2025 08:49:31 -0500
X-MC-Unique: ks_D4DluPrGvnHxIm3uidg-1
X-Mimecast-MFC-AGG-ID: ks_D4DluPrGvnHxIm3uidg_1739800171
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5C21193578F; Mon, 17 Feb 2025 13:49:30 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.176])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0F88619560AB; Mon, 17 Feb 2025 13:49:28 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Victor Toso <victortoso@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] qapi: pluggable backend code generators
Date: Mon, 17 Feb 2025 13:49:27 +0000
Message-ID: <20250217134927.1288486-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The 'qapi.backend.QAPIBackend' class defines an API contract for
code generators. The current generator is put into a new class
'qapi.backend.QAPICBackend' and made to be the default impl.

A custom generator can be requested using the '-k' arg which takes
a fully qualified python class name

   qapi-gen.py -k the.python.module.QAPIMyBackend

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---

This is an impl of the idea I mentioned at:

   https://lists.nongnu.org/archive/html/qemu-devel/2025-02/msg03475.html

With this change, it is possible for the Go generator code to live
outside of qemu.git, invoked using:

  $ PYTHONPATH=/path/to/qemu.git/scripts \
    python /path/to/qemu.git/scripts/qapi-gen.py \
      -o somedir \
      -k qapi.golang.golang.QAPIGoBackend \
      /path/to/qemu.git/qga/qapi-schema.json

The external app could just expect qemu.git to be checkedout somewhere
convenient, or could use a git submodule to reference it.

 scripts/qapi/backend.py | 96 +++++++++++++++++++++++++++++++++++++++++
 scripts/qapi/main.py    | 65 ++++++++--------------------
 2 files changed, 113 insertions(+), 48 deletions(-)
 create mode 100644 scripts/qapi/backend.py

diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py
new file mode 100644
index 0000000000..b6873fd2e3
--- /dev/null
+++ b/scripts/qapi/backend.py
@@ -0,0 +1,96 @@
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+
+from abc import ABC, abstractmethod
+from typing import Optional
+
+from .commands import gen_commands
+from .common import must_match
+from .events import gen_events
+from .features import gen_features
+from .introspect import gen_introspect
+from .schema import QAPISchema
+from .types import gen_types
+from .visit import gen_visit
+
+
+def invalid_prefix_char(prefix: str) -> Optional[str]:
+    match = must_match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', prefix)
+    if match.end() != len(prefix):
+        return prefix[match.end()]
+    return None
+
+
+class QAPIBackend(ABC):
+
+    def run(self,
+            schema_file: str,
+            output_dir: str,
+            prefix: str,
+            unmask: bool = False,
+            builtins: bool = False,
+            gen_tracing: bool = False) -> None:
+        """
+        Run the code generator for the given schema into the target directory.
+
+        :param schema_file: The primary QAPI schema file.
+        :param output_dir: The output directory to store generated code.
+        :param prefix: Optional C-code prefix for symbol names.
+        :param unmask: Expose non-ABI names through introspection?
+        :param builtins: Generate code for built-in types?
+
+        :raise QAPIError: On failures.
+        """
+        assert invalid_prefix_char(prefix) is None
+
+        schema = QAPISchema(schema_file)
+        self.generate(schema, output_dir, prefix, unmask, builtins, gen_tracing)
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
+        pass
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
index 324081b9fc..35552dffce 100644
--- a/scripts/qapi/main.py
+++ b/scripts/qapi/main.py
@@ -8,53 +8,18 @@
 """
 
 import argparse
+from importlib import import_module
 import sys
-from typing import Optional
 
-from .commands import gen_commands
-from .common import must_match
 from .error import QAPIError
-from .events import gen_events
-from .features import gen_features
-from .introspect import gen_introspect
-from .schema import QAPISchema
-from .types import gen_types
-from .visit import gen_visit
+from .backend import invalid_prefix_char
 
 
-def invalid_prefix_char(prefix: str) -> Optional[str]:
-    match = must_match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', prefix)
-    if match.end() != len(prefix):
-        return prefix[match.end()]
-    return None
-
-
-def generate(schema_file: str,
-             output_dir: str,
-             prefix: str,
-             unmask: bool = False,
-             builtins: bool = False,
-             gen_tracing: bool = False) -> None:
-    """
-    Generate C code for the given schema into the target directory.
-
-    :param schema_file: The primary QAPI schema file.
-    :param output_dir: The output directory to store generated code.
-    :param prefix: Optional C-code prefix for symbol names.
-    :param unmask: Expose non-ABI names through introspection?
-    :param builtins: Generate code for built-in types?
-
-    :raise QAPIError: On failures.
-    """
-    assert invalid_prefix_char(prefix) is None
-
-    schema = QAPISchema(schema_file)
-    gen_types(schema, output_dir, prefix, builtins)
-    gen_features(schema, output_dir, prefix)
-    gen_visit(schema, output_dir, prefix, builtins)
-    gen_commands(schema, output_dir, prefix, gen_tracing)
-    gen_events(schema, output_dir, prefix)
-    gen_introspect(schema, output_dir, prefix, unmask)
+def import_class_from_string(path):
+    module_path, _, class_name = path.rpartition('.')
+    mod = import_module(module_path)
+    klass = getattr(mod, class_name)
+    return klass
 
 
 def main() -> int:
@@ -77,6 +42,8 @@ def main() -> int:
     parser.add_argument('-u', '--unmask-non-abi-names', action='store_true',
                         dest='unmask',
                         help="expose non-ABI names in introspection")
+    parser.add_argument('-k', '--backend', default="qapi.backend.QAPICBackend",
+                        help="Python module name for code generator")
 
     # Option --suppress-tracing exists so we can avoid solving build system
     # problems.  TODO Drop it when we no longer need it.
@@ -92,13 +59,15 @@ def main() -> int:
         print(f"{sys.argv[0]}: {msg}", file=sys.stderr)
         return 1
 
+    backendclass = import_class_from_string(args.backend)
     try:
-        generate(args.schema,
-                 output_dir=args.output_dir,
-                 prefix=args.prefix,
-                 unmask=args.unmask,
-                 builtins=args.builtins,
-                 gen_tracing=not args.suppress_tracing)
+        backend = backendclass()
+        backend.run(args.schema,
+                    output_dir=args.output_dir,
+                    prefix=args.prefix,
+                    unmask=args.unmask,
+                    builtins=args.builtins,
+                    gen_tracing=not args.suppress_tracing)
     except QAPIError as err:
         print(err, file=sys.stderr)
         return 1
-- 
2.47.1


