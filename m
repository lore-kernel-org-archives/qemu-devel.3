Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E58BE77182
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuFp-0005Yp-Uv; Thu, 12 Dec 2024 20:14:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuFn-0005YP-UX
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:14:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuFf-0000G5-5Y
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734052433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xBuIfzlqNOz/6xZ6DSHAelvGOKi8S/vFA3f21PFplt4=;
 b=PCMQE3QQLKzXaiFwRvUSUO+XqeSnNaD/VZZJWjaEXzaNb/KDzfEcsF6Mu0K82VzUxnOrKE
 p0oGcZ26jsXi2JyHt0R+9+zjFDcwIIFhItBy4KJuJ5+seMdpEmp0O1FMyn8fxTWZvBKi6b
 8HyLmthlDqTjxUuiSvQ9DRBMuwHlujk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-cezUqv8RNCW4Xxx_u0Ji2Q-1; Thu,
 12 Dec 2024 20:13:52 -0500
X-MC-Unique: cezUqv8RNCW4Xxx_u0Ji2Q-1
X-Mimecast-MFC-AGG-ID: cezUqv8RNCW4Xxx_u0Ji2Q
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3100819560A5; Fri, 13 Dec 2024 01:13:51 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 060161956089; Fri, 13 Dec 2024 01:13:48 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 07/35] docs/qapi-domain: add QAPI index
Date: Thu, 12 Dec 2024 20:12:36 -0500
Message-ID: <20241213011307.2942030-8-jsnow@redhat.com>
In-Reply-To: <20241213011307.2942030-1-jsnow@redhat.com>
References: <20241213011307.2942030-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Use the QAPI object registry to generate a special index just for QAPI
definitions. The index can show entries both by definition type and
alphabetically.

The index can be linked from anywhere in the QEMU manual by using
`qapi-index`.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi-domain.py | 74 +++++++++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 5 deletions(-)

diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index 76f10b942d7..a83041a0aac 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -12,6 +12,7 @@
     Iterable,
     List,
     NamedTuple,
+    Optional,
     Tuple,
     cast,
 )
@@ -21,7 +22,12 @@
 
 from compat import nested_parse
 from sphinx import addnodes
-from sphinx.domains import Domain, ObjType
+from sphinx.domains import (
+    Domain,
+    Index,
+    IndexEntry,
+    ObjType,
+)
 from sphinx.locale import _, __
 from sphinx.util import logging
 from sphinx.util.docutils import SphinxDirective
@@ -52,9 +58,10 @@ class QAPIModule(SphinxDirective):
     a pass-through for the content body. Named section titles are
     allowed in the content body.
 
-    Use this directive to associate subsequent definitions with the
-    module they are defined in for purposes of search and QAPI index
-    organization.
+    Use this directive to create entries for the QAPI module in the
+    global index and the qapi index; as well as to associate subsequent
+    definitions with the module they are defined in for purposes of
+    search and QAPI index organization.
 
     :arg: The name of the module.
     :opt no-index: Don't add cross-reference targets or index entries.
@@ -133,6 +140,60 @@ def run(self) -> List[Node]:
         return ret
 
 
+class QAPIIndex(Index):
+    """
+    Index subclass to provide the QAPI definition index.
+    """
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
 
@@ -160,7 +221,10 @@ class QAPIDomain(Domain):
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
2.47.0


