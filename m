Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C22C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 20:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj2K1-0003ye-F8; Fri, 14 Feb 2025 15:30:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tj2K0-0003yO-ML
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:30:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tj2Jy-0001lB-RU
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739564998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z9tecBY1ateQFfirQNGI5dKfCjw9CG3z9DtUVhLANyg=;
 b=e7Cj5yJVrQk3XhFFYnswPP/rnWISGC4ONTGoU3YXWD/bJc4QnEaLfUnQcpT97WgVjHNMJs
 nFIsAhpYADnRkfLfne3S5EXxGkmJRXgIv0q3ueb1DX1O3TLGuxJWy/QZ2QINynooNXW6BI
 I7RlxvQPdLoH41HBXKUGruBCBzRWtDw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-o1ciReYhPh2am_39yQfxUw-1; Fri,
 14 Feb 2025 15:29:56 -0500
X-MC-Unique: o1ciReYhPh2am_39yQfxUw-1
X-Mimecast-MFC-AGG-ID: o1ciReYhPh2am_39yQfxUw_1739564995
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB960180036F
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 20:29:55 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D6E3C180056F; Fri, 14 Feb 2025 20:29:51 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v4 01/11] qapi: golang: first level unmarshalling type
Date: Fri, 14 Feb 2025 21:29:34 +0100
Message-ID: <20250214202944.69897-2-victortoso@redhat.com>
In-Reply-To: <20250214202944.69897-1-victortoso@redhat.com>
References: <20250214202944.69897-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
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

This first patch introduces protocol.go. It introduces the Message Go
struct type that can unmarshall any QMP message.

It does not handle deeper than 1st layer of the JSON object, that is,
with:

 1. {
      "execute": "query-machines",
      "arguments": { "compat-props": true }
    }

 2. {
      "event": "BALLOON_CHANGE",
      "data": { "actual": 944766976 },
      "timestamp": {
        "seconds": 1267020223,
        "microseconds": 435656
      }
    }

We will be able to know it is a query-machine command or a
balloon-change event. Specific data type to handle arguments/data will
be introduced further in the series.

This patch also introduces the Visitor skeleton with a proper write()
function to copy-over the protocol.go to the target destination.

Note, you can execute any patch of this series with:

    python3 ./scripts/qapi-gen.py -o /tmp/out qapi/qapi-schema.json

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/golang/__init__.py |   0
 scripts/qapi/golang/golang.py   | 135 ++++++++++++++++++++++++++++++++
 scripts/qapi/golang/protocol.go |  48 ++++++++++++
 scripts/qapi/main.py            |   2 +
 4 files changed, 185 insertions(+)
 create mode 100644 scripts/qapi/golang/__init__.py
 create mode 100644 scripts/qapi/golang/golang.py
 create mode 100644 scripts/qapi/golang/protocol.go

diff --git a/scripts/qapi/golang/__init__.py b/scripts/qapi/golang/__init__.py
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/scripts/qapi/golang/golang.py b/scripts/qapi/golang/golang.py
new file mode 100644
index 0000000000..333741b47b
--- /dev/null
+++ b/scripts/qapi/golang/golang.py
@@ -0,0 +1,135 @@
+"""
+Golang QAPI generator
+"""
+
+# Copyright (c) 2025 Red Hat Inc.
+#
+# Authors:
+#  Victor Toso <victortoso@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+
+# Just for type hint on self
+from __future__ import annotations
+
+import os, shutil
+from typing import List, Optional
+
+from ..schema import (
+    QAPISchema,
+    QAPISchemaBranches,
+    QAPISchemaEnumMember,
+    QAPISchemaFeature,
+    QAPISchemaIfCond,
+    QAPISchemaObjectType,
+    QAPISchemaObjectTypeMember,
+    QAPISchemaType,
+    QAPISchemaVariants,
+    QAPISchemaVisitor,
+)
+from ..source import QAPISourceInfo
+
+
+def gen_golang(schema: QAPISchema, output_dir: str, prefix: str) -> None:
+    vis = QAPISchemaGenGolangVisitor(prefix)
+    schema.visit(vis)
+    vis.write(output_dir)
+
+
+class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):
+    # pylint: disable=too-many-arguments
+    def __init__(self, _: str):
+        super().__init__()
+        gofiles = ("protocol.go",)
+        self.schema: QAPISchema
+        self.golang_package_name = "qapi"
+        self.duplicate = list(gofiles)
+
+    def visit_begin(self, schema: QAPISchema) -> None:
+        self.schema = schema
+
+    def visit_end(self) -> None:
+        del self.schema
+
+    def visit_object_type(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        features: List[QAPISchemaFeature],
+        base: Optional[QAPISchemaObjectType],
+        members: List[QAPISchemaObjectTypeMember],
+        branches: Optional[QAPISchemaBranches],
+    ) -> None:
+        pass
+
+    def visit_alternate_type(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        features: List[QAPISchemaFeature],
+        variants: QAPISchemaVariants,
+    ) -> None:
+        pass
+
+    def visit_enum_type(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        features: List[QAPISchemaFeature],
+        members: List[QAPISchemaEnumMember],
+        prefix: Optional[str],
+    ) -> None:
+        pass
+
+    def visit_array_type(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        element_type: QAPISchemaType,
+    ) -> None:
+        pass
+
+    def visit_command(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        features: List[QAPISchemaFeature],
+        arg_type: Optional[QAPISchemaObjectType],
+        ret_type: Optional[QAPISchemaType],
+        gen: bool,
+        success_response: bool,
+        boxed: bool,
+        allow_oob: bool,
+        allow_preconfig: bool,
+        coroutine: bool,
+    ) -> None:
+        pass
+
+    def visit_event(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        features: List[QAPISchemaFeature],
+        arg_type: Optional[QAPISchemaObjectType],
+        boxed: bool,
+    ) -> None:
+        pass
+
+    def write(self, outdir: str) -> None:
+        godir = "go"
+        targetpath = os.path.join(outdir, godir)
+        os.makedirs(targetpath, exist_ok=True)
+
+        # Content to be copied over
+        srcdir = os.path.dirname(os.path.realpath(__file__))
+        for filename in self.duplicate:
+            srcpath = os.path.join(srcdir, filename)
+            dstpath = os.path.join(targetpath, filename)
+            shutil.copyfile(srcpath, dstpath)
diff --git a/scripts/qapi/golang/protocol.go b/scripts/qapi/golang/protocol.go
new file mode 100644
index 0000000000..4ff8d2f3fb
--- /dev/null
+++ b/scripts/qapi/golang/protocol.go
@@ -0,0 +1,48 @@
+/*
+ * Copyright 2025 Red Hat, Inc.
+ * SPDX-License-Identifier: MIT-0
+ *
+ * Authors:
+ *  Victor Toso <victortoso@redhat.com>
+ *  Daniel P. Berrange <berrange@redhat.com>
+ */
+package qapi
+
+import (
+	"encoding/json"
+	"time"
+)
+
+/* Union of data for command, response, error, or event,
+ * since when receiving we don't know upfront which we
+ * must deserialize */
+type Message struct {
+	QMP       *json.RawMessage `json:"QMP,omitempty"`
+	Execute   string           `json:"execute,omitempty"`
+	ExecOOB   string           `json:"exec-oob,omitempty"`
+	Event     string           `json:"event,omitempty"`
+	Error     *json.RawMessage `json:"error,omitempty"`
+	Return    *json.RawMessage `json:"return,omitempty"`
+	ID        string           `json:"id,omitempty"`
+	Timestamp *Timestamp       `json:"timestamp,omitempty"`
+	Data      *json.RawMessage `json:"data,omitempty"`
+	Arguments *json.RawMessage `json:"arguments,omitempty"`
+}
+
+type QAPIError struct {
+	Class       string `json:"class"`
+	Description string `json:"desc"`
+}
+
+func (err *QAPIError) Error() string {
+	return err.Description
+}
+
+type Timestamp struct {
+	Seconds      int `json:"seconds"`
+	MicroSeconds int `json:"microseconds"`
+}
+
+func (t *Timestamp) AsTime() time.Time {
+	return time.Unix(int64(t.Seconds), int64(t.MicroSeconds)*1000)
+}
diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
index 324081b9fc..af315c1ad1 100644
--- a/scripts/qapi/main.py
+++ b/scripts/qapi/main.py
@@ -16,6 +16,7 @@
 from .error import QAPIError
 from .events import gen_events
 from .features import gen_features
+from .golang import golang
 from .introspect import gen_introspect
 from .schema import QAPISchema
 from .types import gen_types
@@ -55,6 +56,7 @@ def generate(schema_file: str,
     gen_commands(schema, output_dir, prefix, gen_tracing)
     gen_events(schema, output_dir, prefix)
     gen_introspect(schema, output_dir, prefix, unmask)
+    golang.gen_golang(schema, output_dir, prefix)
 
 
 def main() -> int:
-- 
2.48.1


