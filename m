Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D6AC28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 03:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqWp-0003o6-7d; Mon, 10 Mar 2025 23:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqWn-0003nU-4G
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:43:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqWl-0002An-7Z
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741664613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SPN+AdqQcOZLZ0qAqGOllNYeST6xcSvGExD6rN2zgnE=;
 b=Uv1KQypJud/vWrmt+bU8F2W1T8Me+O/Ducc/huhHSw8E4uw60dTTvEVV3F/vpigRs0M3vv
 llhOqPq++pO91LHP0lW3u4mjqdt8ZEJglQO/hp8QQ+9VaEqlaqmEbBnvHsLCHTIsq6PuAW
 qKm8UGHt5Q1Si4dOT1vuxAIurJrQUFE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-PVv6m6JRNpGn_CXCsWV1hA-1; Mon,
 10 Mar 2025 23:43:29 -0400
X-MC-Unique: PVv6m6JRNpGn_CXCsWV1hA-1
X-Mimecast-MFC-AGG-ID: PVv6m6JRNpGn_CXCsWV1hA_1741664608
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE5A71800258; Tue, 11 Mar 2025 03:43:27 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 275BA1800366; Tue, 11 Mar 2025 03:43:24 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 05/63] docs/qapi-domain: add QAPI domain object registry
Date: Mon, 10 Mar 2025 23:42:03 -0400
Message-ID: <20250311034303.75779-6-jsnow@redhat.com>
In-Reply-To: <20250311034303.75779-1-jsnow@redhat.com>
References: <20250311034303.75779-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

This is the first step towards QAPI domain cross-references and a QAPI
reference index.

This patch just creates the object registry, and updates the
merge_domaindata stub method now that we have actual data we may need to
merge.

Note that how to handle merge conflict resolution is unhandled, as the
Sphinx python domain itself does not handle it either. I do not know how
to intentionally trigger it, so I've left an assertion instead if it
should ever come up ...

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi_domain.py | 77 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index a1983d94440..f3ece42bc2a 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -9,10 +9,12 @@
     AbstractSet,
     Any,
     Dict,
+    NamedTuple,
     Tuple,
 )
 
 from sphinx.domains import Domain, ObjType
+from sphinx.locale import __
 from sphinx.util import logging
 
 
@@ -22,22 +24,93 @@
 logger = logging.getLogger(__name__)
 
 
+class ObjectEntry(NamedTuple):
+    docname: str
+    node_id: str
+    objtype: str
+    aliased: bool
+
+
 class QAPIDomain(Domain):
     """QAPI language domain."""
 
     name = "qapi"
     label = "QAPI"
 
+    # This table associates cross-reference object types (key) with an
+    # ObjType instance, which defines the valid cross-reference roles
+    # for each object type.
+
+    # Actual table entries for module, command, event, etc will come in
+    # forthcoming commits.
     object_types: Dict[str, ObjType] = {}
+
     directives = {}
     roles = {}
-    initial_data: Dict[str, Dict[str, Tuple[Any]]] = {}
+
+    # Moved into the data property at runtime;
+    # this is the internal index of reference-able objects.
+    initial_data: Dict[str, Dict[str, Tuple[Any]]] = {
+        "objects": {},  # fullname -> ObjectEntry
+    }
+
     indices = []
 
+    @property
+    def objects(self) -> Dict[str, ObjectEntry]:
+        ret = self.data.setdefault("objects", {})
+        return ret  # type: ignore[no-any-return]
+
+    def note_object(
+        self,
+        name: str,
+        objtype: str,
+        node_id: str,
+        aliased: bool = False,
+        location: Any = None,
+    ) -> None:
+        """Note a QAPI object for cross reference."""
+        if name in self.objects:
+            other = self.objects[name]
+            if other.aliased and aliased is False:
+                # The original definition found. Override it!
+                pass
+            elif other.aliased is False and aliased:
+                # The original definition is already registered.
+                return
+            else:
+                # duplicated
+                logger.warning(
+                    __(
+                        "duplicate object description of %s, "
+                        "other instance in %s, use :no-index: for one of them"
+                    ),
+                    name,
+                    other.docname,
+                    location=location,
+                )
+        self.objects[name] = ObjectEntry(
+            self.env.docname, node_id, objtype, aliased
+        )
+
+    def clear_doc(self, docname: str) -> None:
+        for fullname, obj in list(self.objects.items()):
+            if obj.docname == docname:
+                del self.objects[fullname]
+
     def merge_domaindata(
         self, docnames: AbstractSet[str], otherdata: Dict[str, Any]
     ) -> None:
-        pass
+        for fullname, obj in otherdata["objects"].items():
+            if obj.docname in docnames:
+                # Sphinx's own python domain doesn't appear to bother to
+                # check for collisions. Assert they don't happen and
+                # we'll fix it if/when the case arises.
+                assert fullname not in self.objects, (
+                    "bug - collision on merge?"
+                    f" {fullname=} {obj=} {self.objects[fullname]=}"
+                )
+                self.objects[fullname] = obj
 
     def resolve_any_xref(self, *args: Any, **kwargs: Any) -> Any:
         # pylint: disable=unused-argument
-- 
2.48.1


