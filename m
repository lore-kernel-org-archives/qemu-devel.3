Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EBFC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 22:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s70AQ-0005kN-8y; Tue, 14 May 2024 17:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s70AO-0005iK-0C
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:58:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s70AG-0008W3-1l
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715723907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfg570U3FRLJ35JfLCL81gkmcp7TkhTnNgfcr0FLQCE=;
 b=Hvei26IP+pVxs6ZPE1LKMSujskT5Ft9ygDcAPMwSkNGIQPwYor/ERUB0N+AgYfCcqe2Xcn
 yIQHX8qYNm2f6qb/QRMNqYqA7UL9KX3wrIi1SCLsZC0IW+YX1bTVrFO7P8A7f5umpy/0YR
 vfoUtczpNIa2H8g/hnrSXCoAPk/7nfE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-8cdUitqFMY-lQQ2HJ4yOaw-1; Tue,
 14 May 2024 17:58:21 -0400
X-MC-Unique: 8cdUitqFMY-lQQ2HJ4yOaw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5AAB01C031AC;
 Tue, 14 May 2024 21:58:20 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.17.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7179C6BC0;
 Tue, 14 May 2024 21:58:17 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Markus Armbruster <armbru@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Mads Ynddal <mads@ynddal.dk>,
 Jason Wang <jasowang@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Yanan Wang <wangyanan55@huawei.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 11/20] qapi/schema: add doc_visible property to
 QAPISchemaDefinition
Date: Tue, 14 May 2024 17:57:30 -0400
Message-ID: <20240514215740.940155-12-jsnow@redhat.com>
In-Reply-To: <20240514215740.940155-1-jsnow@redhat.com>
References: <20240514215740.940155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The intent here is to mark only certain definitions as visible in the
end-user docs.

All commands and events are inherently visible. Everything else is
visible only if it is a member (or a branch member) of a type that is
visible, or if it is named as a return type for a command.

Notably, this excludes arg_type for commands and events, and any
base_types specified for structures/unions. Those objects may still be
marked visible if they are named as members from a visible type.

This does not necessarily match the data revealed by introspection: in
this case, we want anything that we are cross-referencing in generated
documentation to be available to target.

Some internal and built-in types may be marked visible with this
approach, but if they do not have a documentation block, they'll be
skipped by the generator anyway. This includes array types and built-in
primitives which do not get their own documentation objects.

This information is not yet used by qapidoc, which continues to render
documentation exactly as it has. This information will be used by the
new qapidoc (the "transmogrifier"), to be introduced later. The new
generator verifies that all of the objects that should be rendered *are*
by failing if any cross-references are missing, verifying everything is
in place.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index e15e64ea8cb..6025b4e9354 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -131,6 +131,7 @@ def __init__(
         self.doc = doc
         self._ifcond = ifcond or QAPISchemaIfCond()
         self.features = features or []
+        self.doc_visible = False
 
     def __repr__(self) -> str:
         return "<%s:%s at 0x%x>" % (type(self).__name__, self.name,
@@ -146,6 +147,10 @@ def check(self, schema: QAPISchema) -> None:
         for f in self.features:
             f.check_clash(self.info, seen)
 
+    def mark_visible(self, mark_self: bool = True) -> None:
+        if mark_self:
+            self.doc_visible = True
+
     def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
@@ -483,6 +488,10 @@ def check(self, schema: QAPISchema) -> None:
             self.info.defn_meta if self.info else None)
         assert not isinstance(self.element_type, QAPISchemaArrayType)
 
+    def mark_visible(self, mark_self: bool = True) -> None:
+        super().mark_visible(mark_self)
+        self.element_type.mark_visible()
+
     def set_module(self, schema: QAPISchema) -> None:
         self._set_module(schema, self.element_type.info)
 
@@ -607,6 +616,17 @@ def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         for m in self.local_members:
             m.connect_doc(doc)
 
+    def mark_visible(self, mark_self: bool = True) -> None:
+        # Mark this object and its members as visible in the user-facing docs.
+        if self.doc_visible:
+            return
+
+        super().mark_visible(mark_self)
+        for m in self.members:
+            m.type.mark_visible()
+        for var in self.branches or []:
+            var.type.mark_visible(False)
+
     def is_implicit(self) -> bool:
         # See QAPISchema._make_implicit_object_type(), as well as
         # _def_predefineds()
@@ -698,6 +718,11 @@ def check(self, schema: QAPISchema) -> None:
                         % (v.describe(self.info), types_seen[qt]))
                 types_seen[qt] = v.name
 
+    def mark_visible(self, mark_self: bool = True) -> None:
+        super().mark_visible(mark_self)
+        for var in self.alternatives:
+            var.type.mark_visible()
+
     def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
@@ -1056,6 +1081,13 @@ def check(self, schema: QAPISchema) -> None:
                         "command's 'returns' cannot take %s"
                         % self.ret_type.describe())
 
+    def mark_visible(self, mark_self: bool = True) -> None:
+        super().mark_visible(mark_self)
+        if self.arg_type:
+            self.arg_type.mark_visible(False)
+        if self.ret_type:
+            self.ret_type.mark_visible()
+
     def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
@@ -1112,6 +1144,11 @@ def check(self, schema: QAPISchema) -> None:
                     self.info,
                     "conditional event arguments require 'boxed': true")
 
+    def mark_visible(self, mark_self: bool = True) -> None:
+        super().mark_visible(mark_self)
+        if self.arg_type:
+            self.arg_type.mark_visible(False)
+
     def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
@@ -1488,6 +1525,9 @@ def check(self) -> None:
             ent.set_module(self)
         for doc in self.docs:
             doc.check()
+        for ent in self._entity_list:
+            if isinstance(ent, (QAPISchemaCommand, QAPISchemaEvent)):
+                ent.mark_visible()
 
     def visit(self, visitor: QAPISchemaVisitor) -> None:
         visitor.visit_begin(self)
-- 
2.44.0


