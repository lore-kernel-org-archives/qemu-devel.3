Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EF9C02199
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 23:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfodC-0003KY-MJ; Wed, 05 Feb 2025 18:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfod7-00030r-9t
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:16:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfocp-0006Y2-Sj
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738797367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZ4ptJK3jOz6/9nCnwYuhTipEGLIpTu/jDPEuN8oFBM=;
 b=NLjCBsrkmTESOt9IDVObqAJY9tQ2xA+DzDN6tNhcF6CnYyPGmsOYvmMHl9JCanoJcvJVCW
 oPZ1om1Vv1frCdzgk1PmJzIcOpmfic6VsBx7xNb1l2HI7ObhHi22Z7T7T0Hl+cX/R/IeUA
 A9lbB6l/ocMydPpb4d9ivm6Ws7YwF4o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-8QRaCY-GOLK8tkrfdah5Lw-1; Wed,
 05 Feb 2025 18:16:05 -0500
X-MC-Unique: 8QRaCY-GOLK8tkrfdah5Lw-1
X-Mimecast-MFC-AGG-ID: 8QRaCY-GOLK8tkrfdah5Lw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1531819560B6; Wed,  5 Feb 2025 23:16:04 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.104])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 91FB21800570; Wed,  5 Feb 2025 23:15:58 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Lukas Straub <lukasstraub2@web.de>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 37/42] qapi/schema: add __iter__ method to QAPISchemaVariants
Date: Wed,  5 Feb 2025 18:12:03 -0500
Message-ID: <20250205231208.1480762-38-jsnow@redhat.com>
In-Reply-To: <20250205231208.1480762-1-jsnow@redhat.com>
References: <20250205231208.1480762-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

This is just semantic sugar that makes it easier to do something like:

for var in variants:
    ...

Instead of the more cumbersome and repetitive:

for var in variants.variants:
    ...

Especially in conjunction with entities that aren't guaranteed to have
variants. Compare:

for var in variants.variants if variants else []:
    ...

against:

for var in variants or []:
    ...

Update callsites to reflect the new usage pattern.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py     | 2 +-
 scripts/qapi/introspect.py | 4 ++--
 scripts/qapi/schema.py     | 8 ++++++--
 scripts/qapi/types.py      | 4 ++--
 scripts/qapi/visit.py      | 4 ++--
 5 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 81133b9b441..755eb0fa0ec 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -695,7 +695,7 @@ def _nodes_for_members(self, doc, what, base=None, branches=None):
                                         None)
 
         if branches:
-            for v in branches.variants:
+            for v in branches:
                 if v.type.name == 'q_empty':
                     continue
                 assert not v.type.is_implicit()
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index ac14b20f308..6ec34e055d3 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -342,7 +342,7 @@ def visit_object_type_flat(self, name: str, info: Optional[QAPISourceInfo],
         }
         if branches:
             obj['tag'] = branches.tag_member.name
-            obj['variants'] = [self._gen_variant(v) for v in branches.variants]
+            obj['variants'] = [self._gen_variant(v) for v in branches]
         self._gen_tree(name, 'object', obj, ifcond, features)
 
     def visit_alternate_type(self, name: str, info: Optional[QAPISourceInfo],
@@ -353,7 +353,7 @@ def visit_alternate_type(self, name: str, info: Optional[QAPISourceInfo],
             name, 'alternate',
             {'members': [Annotated({'type': self._use_type(m.type)},
                                    m.ifcond)
-                         for m in alternatives.variants]},
+                         for m in alternatives]},
             ifcond, features
         )
 
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index e97c978d38d..4c55f7640b6 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -26,6 +26,7 @@
     Any,
     Callable,
     Dict,
+    Iterator,
     List,
     Optional,
     Union,
@@ -669,7 +670,7 @@ def check(self, schema: QAPISchema) -> None:
         # so we have to check for potential name collisions ourselves.
         seen: Dict[str, QAPISchemaMember] = {}
         types_seen: Dict[str, str] = {}
-        for v in self.alternatives.variants:
+        for v in self.alternatives:
             v.check_clash(self.info, seen)
             qtype = v.type.alternate_qtype()
             if not qtype:
@@ -700,7 +701,7 @@ def check(self, schema: QAPISchema) -> None:
     def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
-        for v in self.alternatives.variants:
+        for v in self.alternatives:
             v.connect_doc(doc)
 
     def c_type(self) -> str:
@@ -726,6 +727,9 @@ def __init__(
         self.tag_member: QAPISchemaObjectTypeMember
         self.variants = variants
 
+    def __iter__(self) -> Iterator[QAPISchemaVariant]:
+        return iter(self.variants)
+
     def set_defined_in(self, name: str) -> None:
         for v in self.variants:
             v.set_defined_in(name)
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 0dd0b00ada3..ad36b55488f 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -166,7 +166,7 @@ def gen_object(name: str, ifcond: QAPISchemaIfCond,
     objects_seen.add(name)
 
     ret = ''
-    for var in variants.variants if variants else ():
+    for var in variants or ():
         obj = var.type
         if not isinstance(obj, QAPISchemaObjectType):
             continue
@@ -234,7 +234,7 @@ def gen_variants(variants: QAPISchemaVariants) -> str:
 ''',
                 c_name=c_name(variants.tag_member.name))
 
-    for var in variants.variants:
+    for var in variants:
         if var.type.name == 'q_empty':
             continue
         ret += var.ifcond.gen_if()
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 12f92e429f6..1eca452378c 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -141,7 +141,7 @@ def gen_visit_object_members(name: str,
 ''',
                      c_name=c_name(tag_member.name))
 
-        for var in branches.variants:
+        for var in branches:
             case_str = c_enum_const(tag_member.type.name, var.name,
                                     tag_member.type.prefix)
             ret += var.ifcond.gen_if()
@@ -246,7 +246,7 @@ def gen_visit_alternate(name: str,
 ''',
                 c_name=c_name(name))
 
-    for var in alternatives.variants:
+    for var in alternatives:
         ret += var.ifcond.gen_if()
         ret += mcgen('''
     case %(case)s:
-- 
2.48.1


