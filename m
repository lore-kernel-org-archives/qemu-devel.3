Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766FEC1B087
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 08:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnYwS-00008O-6q; Thu, 27 Feb 2025 03:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnYwD-0008L8-U1
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:08:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnYwB-0001fY-D1
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740643685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XMB+4JXdPnIxG6SEB8UqGtM+jKjZl1DxQ/CtUfn5P70=;
 b=JydLpOmaTISPsF29abG2Tcza8vEM518CRyIdoyPEXhj5m1KJdD/R8EfV+ZLkZzPPB+2wza
 SMYGD9SKQ8b5MT4fxDylYjWEmGW+ueUUhvvJEEXPYwYkvPG6Xs9exvPwCII7Kyi6FpFFQS
 t92rzQG75dg3h6vnI/bnHhh4wWC3Yng=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-5MC4BHYyNESAVp8khNlVow-1; Thu,
 27 Feb 2025 03:08:01 -0500
X-MC-Unique: 5MC4BHYyNESAVp8khNlVow-1
X-Mimecast-MFC-AGG-ID: 5MC4BHYyNESAVp8khNlVow_1740643681
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FDB51954B1C; Thu, 27 Feb 2025 08:08:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11A8919560AB; Thu, 27 Feb 2025 08:08:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 78B5521E65E0; Thu, 27 Feb 2025 09:07:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com,
	jsnow@redhat.com
Subject: [PATCH 2/3] qapi: Eliminate OrderedDict
Date: Thu, 27 Feb 2025 09:07:56 +0100
Message-ID: <20250227080757.3978333-3-armbru@redhat.com>
In-Reply-To: <20250227080757.3978333-1-armbru@redhat.com>
References: <20250227080757.3978333-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We use OrderedDict to ensure dictionary order is insertion order.
Plain dict does that since Python 3.6, but it wasn't guaranteed until
3.7.  Since we have 3.7 now, replace OrderedDict by dict.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/parser.py         |  5 ++---
 scripts/qapi/schema.py         | 11 +++++------
 tests/qapi-schema/test-qapi.py | 11 +----------
 3 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index adc85b5b39..64f0bb824a 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -14,7 +14,6 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
-from collections import OrderedDict
 import os
 import re
 from typing import (
@@ -154,7 +153,7 @@ def _parse(self) -> None:
                                        "value of 'include' must be a string")
                 incl_fname = os.path.join(os.path.dirname(self._fname),
                                           include)
-                self._add_expr(OrderedDict({'include': incl_fname}), info)
+                self._add_expr({'include': incl_fname}, info)
                 exprs_include = self._include(include, info, incl_fname,
                                               self._included)
                 if exprs_include:
@@ -355,7 +354,7 @@ def accept(self, skip_comment: bool = True) -> None:
                 raise QAPIParseError(self, "stray '%s'" % match.group(0))
 
     def get_members(self) -> Dict[str, object]:
-        expr: Dict[str, object] = OrderedDict()
+        expr: Dict[str, object] = {}
         if self.tok == '}':
             self.accept()
             return expr
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 7f70969c09..cbe3b5aa91 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -19,7 +19,6 @@
 from __future__ import annotations
 
 from abc import ABC, abstractmethod
-from collections import OrderedDict
 import os
 import re
 from typing import (
@@ -557,7 +556,7 @@ def check(self, schema: QAPISchema) -> None:
         super().check(schema)
         assert self._checked and not self._check_complete
 
-        seen = OrderedDict()
+        seen = {}
         if self._base_name:
             self.base = schema.resolve_type(self._base_name, self.info,
                                             "'base'")
@@ -1141,10 +1140,10 @@ def __init__(self, fname: str):
         self.docs = parser.docs
         self._entity_list: List[QAPISchemaEntity] = []
         self._entity_dict: Dict[str, QAPISchemaDefinition] = {}
-        self._module_dict: Dict[str, QAPISchemaModule] = OrderedDict()
+        self._module_dict: Dict[str, QAPISchemaModule] = {}
         # NB, values in the dict will identify the first encountered
         # usage of a named feature only
-        self._feature_dict: Dict[str, QAPISchemaFeature] = OrderedDict()
+        self._feature_dict: Dict[str, QAPISchemaFeature] = {}
 
         # All schemas get the names defined in the QapiSpecialFeature enum.
         # Rely on dict iteration order matching insertion order so that
@@ -1454,7 +1453,7 @@ def _def_command(self, expr: QAPIExpression) -> None:
         ifcond = QAPISchemaIfCond(expr.get('if'))
         info = expr.info
         features = self._make_features(expr.get('features'), info)
-        if isinstance(data, OrderedDict):
+        if isinstance(data, dict):
             data = self._make_implicit_object_type(
                 name, info, ifcond,
                 'arg', self._make_members(data, info))
@@ -1473,7 +1472,7 @@ def _def_event(self, expr: QAPIExpression) -> None:
         ifcond = QAPISchemaIfCond(expr.get('if'))
         info = expr.info
         features = self._make_features(expr.get('features'), info)
-        if isinstance(data, OrderedDict):
+        if isinstance(data, dict):
             data = self._make_implicit_object_type(
                 name, info, ifcond,
                 'arg', self._make_members(data, info))
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 7e3f9f4aa1..8fe951c880 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -96,17 +96,8 @@ def _print_variants(variants):
 
     @staticmethod
     def _print_if(ifcond, indent=4):
-        # TODO Drop this hack after replacing OrderedDict by plain
-        # dict (requires Python 3.7)
-        def _massage(subcond):
-            if isinstance(subcond, str):
-                return subcond
-            if isinstance(subcond, list):
-                return [_massage(val) for val in subcond]
-            return {key: _massage(val) for key, val in subcond.items()}
-
         if ifcond.is_present():
-            print('%sif %s' % (' ' * indent, _massage(ifcond.ifcond)))
+            print('%sif %s' % (' ' * indent, ifcond.ifcond))
 
     @classmethod
     def _print_features(cls, features, indent=4):
-- 
2.48.1


