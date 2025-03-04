Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6ADC282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 08:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpNCA-0000Iy-I0; Tue, 04 Mar 2025 03:00:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpNBl-0000BP-LX
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:59:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpNBf-0003Hx-EN
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:59:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741075170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=AiIW447JduVOgQvVDfmuHlFx2OVXVskEav105nIuDTs=;
 b=A/60pAeCjf88WClhsSOGKqr1Mk1YGv4VN/D+1E1vhZZ/OckBHbR5sETkspJ5HmmfuE/MSc
 JBHdSQdu6yX0ZHcZYBhzffvCMFJ+k+6vIQlZUSuf1+PT0morw9ab7cbu5HzcgV5hte2SEp
 m4JFKwLdj9Ex59fTIzIRAK+q5XuC1R4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-BAI_jwnNOESNHGMaOSAQ4w-1; Tue,
 04 Mar 2025 02:59:24 -0500
X-MC-Unique: BAI_jwnNOESNHGMaOSAQ4w-1
X-Mimecast-MFC-AGG-ID: BAI_jwnNOESNHGMaOSAQ4w_1741075163
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F43E1954B21
 for <qemu-devel@nongnu.org>; Tue,  4 Mar 2025 07:59:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2BB41800361
 for <qemu-devel@nongnu.org>; Tue,  4 Mar 2025 07:59:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 55A9021E65D4; Tue, 04 Mar 2025 08:59:17 +0100 (CET)
Resent-To: qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Tue, 04 Mar 2025 08:59:17 +0100
Resent-Message-ID: <87v7spusyy.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com Tue Mar  4 08:43:49 2025
Received: from imap.gmail.com ([2a00:1450:4025:402::6d]:993) by
 dusky.pond.sub.org with IMAP4-SSL getmail6 msgid:11/315751; 04 Mar 2025
 07:43:49 -0000
Received: from blackfin.pond.sub.org
 (p200300d36f33fd00dda5bc774eb05696.dip0.t-ipconnect.de.
 [2003:d3:6f33:fd00:dda5:bc77:4eb0:5696])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4795da5sm17038383f8f.15.2025.03.03.23.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 23:21:18 -0800 (PST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6174A21E65D4; Tue, 04 Mar 2025 08:21:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL v2 5/5] qapi: pluggable backend code generators
Date: Tue,  4 Mar 2025 08:21:17 +0100
Message-ID: <20250304072117.894134-6-armbru@redhat.com>
In-Reply-To: <20250304072117.894134-1-armbru@redhat.com>
References: <20250304072117.894134-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: [Gmail]/All Mail
X-GMAIL-LABELS: "\\Sent"
X-GMAIL-THRID: 1825647235166379166
X-GMAIL-MSGID: 1825647235166379166
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

From: Daniel P. Berrangé <berrange@redhat.com>

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
Message-ID: <20250224182030.2089959-1-berrange@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Error checking and messages tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/backend.py | 63 ++++++++++++++++++++++++++++++++
 scripts/qapi/main.py    | 80 +++++++++++++++++++++++------------------
 2 files changed, 108 insertions(+), 35 deletions(-)
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
index 324081b9fc..5b4679abcf 100644
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
@@ -29,32 +25,42 @@ def invalid_prefix_char(prefix: str) -> Optional[str]:
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
+    module_path, dot, class_name = path.rpartition('.')
+    if not dot:
+        print("argument of -B must be of the form MODULE.CLASS",
+              file=sys.stderr)
+        sys.exit(1)
 
-    :raise QAPIError: On failures.
-    """
-    assert invalid_prefix_char(prefix) is None
+    try:
+        mod = import_module(module_path)
+    except Exception as ex:
+        print(f"unable to import '{module_path}': {ex}", file=sys.stderr)
+        sys.exit(1)
 
-    schema = QAPISchema(schema_file)
-    gen_types(schema, output_dir, prefix, builtins)
-    gen_features(schema, output_dir, prefix)
-    gen_visit(schema, output_dir, prefix, builtins)
-    gen_commands(schema, output_dir, prefix, gen_tracing)
-    gen_events(schema, output_dir, prefix)
-    gen_introspect(schema, output_dir, prefix, unmask)
+    try:
+        klass = getattr(mod, class_name)
+    except AttributeError:
+        print(f"module '{module_path}' has no class '{class_name}'",
+              file=sys.stderr)
+        sys.exit(1)
+
+    try:
+        backend = klass()
+    except Exception as ex:
+        print(f"backend '{path}' cannot be instantiated: {ex}",
+              file=sys.stderr)
+        sys.exit(1)
+
+    if not isinstance(backend, QAPIBackend):
+        print(f"backend '{path}' must be an instance of QAPIBackend",
+              file=sys.stderr)
+        sys.exit(1)
+
+    return backend
 
 
 def main() -> int:
@@ -77,6 +83,8 @@ def main() -> int:
     parser.add_argument('-u', '--unmask-non-abi-names', action='store_true',
                         dest='unmask',
                         help="expose non-ABI names in introspection")
+    parser.add_argument('-B', '--backend', default=None,
+                        help="Python module name for code generator")
 
     # Option --suppress-tracing exists so we can avoid solving build system
     # problems.  TODO Drop it when we no longer need it.
@@ -93,12 +101,14 @@ def main() -> int:
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
2.48.1



