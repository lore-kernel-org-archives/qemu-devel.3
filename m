Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC98C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxrU-000488-IJ; Tue, 11 Mar 2025 07:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxpx-00030D-EW
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:31:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxpt-0006QM-68
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4fzVBga88f/OqmMbr+swR0bwGim42s2bhCCOndnrpmU=;
 b=HPOXADD0Db3dxIIXuVhkyDEuB+8myg4DyUZu3YY6KrEQEoJI7VwLHopxmjU77qWItA5suZ
 yGa1Lu1Tkl7MQEPAzCn3R4OlCYk4rTQkFnfdypXkfpGu2SeePh1QvlPLvdta2dEoTwMP6k
 Z+/siBISQahwMSpAQgtFLWJpXVtMNbw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-tepSRSfENPSU0Qeosx15QA-1; Tue,
 11 Mar 2025 07:31:45 -0400
X-MC-Unique: tepSRSfENPSU0Qeosx15QA-1
X-Mimecast-MFC-AGG-ID: tepSRSfENPSU0Qeosx15QA_1741692704
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3425180034D
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7788F1944F12
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C19A221E66A4; Tue, 11 Mar 2025 12:31:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 04/61] docs/qapi-domain: add QAPI index
Date: Tue, 11 Mar 2025 12:30:40 +0100
Message-ID: <20250311113137.1277125-5-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: John Snow <jsnow@redhat.com>

Use the QAPI object registry to generate a special index just for QAPI
definitions. The index can show entries both by definition type and all
together, alphabetically.

The index can be linked from anywhere in the QEMU manual by using the
reference `qapi-index`.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-7-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapi_domain.py | 73 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index f3ece42bc2..3e7718d32d 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -9,12 +9,20 @@
     AbstractSet,
     Any,
     Dict,
+    Iterable,
+    List,
     NamedTuple,
+    Optional,
     Tuple,
 )
 
-from sphinx.domains import Domain, ObjType
-from sphinx.locale import __
+from sphinx.domains import (
+    Domain,
+    Index,
+    IndexEntry,
+    ObjType,
+)
+from sphinx.locale import _, __
 from sphinx.util import logging
 
 
@@ -31,6 +39,62 @@ class ObjectEntry(NamedTuple):
     aliased: bool
 
 
+class QAPIIndex(Index):
+    """
+    Index subclass to provide the QAPI definition index.
+    """
+
+    # pylint: disable=too-few-public-methods
+
+    name = "index"
+    localname = _("QAPI Index")
+    shortname = _("QAPI Index")
+
+    def generate(
+        self,
+        docnames: Optional[Iterable[str]] = None,
+    ) -> Tuple[List[Tuple[str, List[IndexEntry]]], bool]:
+        assert isinstance(self.domain, QAPIDomain)
+        content: Dict[str, List[IndexEntry]] = {}
+        collapse = False
+
+        # list of all object (name, ObjectEntry) pairs, sorted by name
+        # (ignoring the module)
+        objects = sorted(
+            self.domain.objects.items(),
+            key=lambda x: x[0].split(".")[-1].lower(),
+        )
+
+        for objname, obj in objects:
+            if docnames and obj.docname not in docnames:
+                continue
+
+            # Strip the module name out:
+            objname = objname.split(".")[-1]
+
+            # Add an alphabetical entry:
+            entries = content.setdefault(objname[0].upper(), [])
+            entries.append(
+                IndexEntry(
+                    objname, 0, obj.docname, obj.node_id, obj.objtype, "", ""
+                )
+            )
+
+            # Add a categorical entry:
+            category = obj.objtype.title() + "s"
+            entries = content.setdefault(category, [])
+            entries.append(
+                IndexEntry(objname, 0, obj.docname, obj.node_id, "", "", "")
+            )
+
+        # alphabetically sort categories; type names first, ABC entries last.
+        sorted_content = sorted(
+            content.items(),
+            key=lambda x: (len(x[0]) == 1, x[0]),
+        )
+        return sorted_content, collapse
+
+
 class QAPIDomain(Domain):
     """QAPI language domain."""
 
@@ -54,7 +118,10 @@ class QAPIDomain(Domain):
         "objects": {},  # fullname -> ObjectEntry
     }
 
-    indices = []
+    # Index pages to generate; each entry is an Index class.
+    indices = [
+        QAPIIndex,
+    ]
 
     @property
     def objects(self) -> Dict[str, ObjectEntry]:
-- 
2.48.1


