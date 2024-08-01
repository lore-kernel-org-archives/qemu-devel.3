Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C969C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 18:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZa5X-00028K-Q9; Thu, 01 Aug 2024 13:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZa5U-0001x9-Vi
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZa5T-0005vG-6e
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722535177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SasQSSECtI5DkO6YiV8MC31dvU9pBpDLxRDKkUkwUys=;
 b=Mv4dAPr21h29YuATuoR7b1gitMTvTOxs0WOndaxrUOai8+xY0i1qWGlNLF6lrk2SGMXTtK
 76Z2T+CRtZV7frpiwTQZhh+7fyzzRD3/8H0v7LoBaiHSvqEYP3waFfefqcRvtZuflAJQGd
 r7BxcaRj/hnBwm22oY8Dy/eT/B5piJs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-iut_6S-ROiy00YWqmBTNdA-1; Thu,
 01 Aug 2024 13:59:35 -0400
X-MC-Unique: iut_6S-ROiy00YWqmBTNdA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73A7A1955D4D; Thu,  1 Aug 2024 17:59:34 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.17])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB95B195605A; Thu,  1 Aug 2024 17:59:30 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 5/6] qapi: apply schema prefix to QAPI feature enum constants
Date: Thu,  1 Aug 2024 18:59:12 +0100
Message-ID: <20240801175913.669013-6-berrange@redhat.com>
In-Reply-To: <20240801175913.669013-1-berrange@redhat.com>
References: <20240801175913.669013-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This allows us to include multiple QAPI schemas in the same file.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/qapi/commands.py | 7 ++++---
 scripts/qapi/events.py   | 3 ++-
 scripts/qapi/gen.py      | 6 +++---
 scripts/qapi/types.py    | 5 +++--
 scripts/qapi/visit.py    | 5 +++--
 5 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index d629d2d97e..81134de6c0 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -280,7 +280,8 @@ def gen_register_command(name: str,
                          success_response: bool,
                          allow_oob: bool,
                          allow_preconfig: bool,
-                         coroutine: bool) -> str:
+                         coroutine: bool,
+                         prefix: str) -> str:
     options = []
 
     if not success_response:
@@ -298,7 +299,7 @@ def gen_register_command(name: str,
 ''',
                 name=name, c_name=c_name(name),
                 opts=' | '.join(options) or 0,
-                feats=gen_features(features))
+                feats=gen_features(prefix, features))
     return ret
 
 
@@ -407,7 +408,7 @@ def visit_command(self,
             with ifcontext(ifcond, self._genh, self._genc):
                 self._genc.add(gen_register_command(
                     name, features, success_response, allow_oob,
-                    allow_preconfig, coroutine))
+                    allow_preconfig, coroutine, self._prefix))
 
 
 def gen_commands(schema: QAPISchema,
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index d1f639981a..8a489e559a 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -218,7 +218,8 @@ def visit_end(self) -> None:
         self._genh.add(gen_enum(self._event_enum_name,
                                 self._event_enum_members))
         self._genc.add(gen_enum_lookup(self._event_enum_name,
-                                       self._event_enum_members))
+                                       self._event_enum_members,
+                                       self._prefix))
         self._genh.add(mcgen('''
 
 void %(event_emit)s(%(event_enum)s event, QDict *qdict);
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 036977d989..399a0ae62d 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -41,9 +41,9 @@
 from .source import QAPISourceInfo
 
 
-def gen_features(features: Sequence[QAPISchemaFeature]) -> str:
-    features = [f"1u << {c_enum_const('QAPI_FEATURE', feat.name)}"
-                for feat in features if feat.is_special()]
+def gen_features(prefix, features: Sequence[QAPISchemaFeature]) -> str:
+    features = [f"1u << {c_enum_const(prefix + 'QAPI_FEATURE', feat.name)}"
+                for feat in features]
     return ' | '.join(features) or '0'
 
 
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index ade6b7a3d7..b2d26c2ea8 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -43,6 +43,7 @@
 
 def gen_enum_lookup(name: str,
                     members: List[QAPISchemaEnumMember],
+                    modprefix: str,
                     prefix: Optional[str] = None) -> str:
     max_index = c_enum_const(name, '_MAX', prefix)
     feats = ''
@@ -61,7 +62,7 @@ def gen_enum_lookup(name: str,
                      index=index, name=memb.name)
         ret += memb.ifcond.gen_endif()
 
-        features = gen_features(memb.features)
+        features = gen_features(modprefix, memb.features)
         if features != '0':
             feats += mcgen('''
         [%(index)s] = %(features)s,
@@ -331,7 +332,7 @@ def visit_enum_type(self,
                         prefix: Optional[str]) -> None:
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.preamble_add(gen_enum(name, members, prefix))
-            self._genc.add(gen_enum_lookup(name, members, prefix))
+            self._genc.add(gen_enum_lookup(name, members, self._prefix, prefix))
 
     def visit_array_type(self,
                          name: str,
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 8dbf4ef1c3..883d720e36 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -62,6 +62,7 @@ def gen_visit_members_decl(name: str) -> str:
 
 
 def gen_visit_object_members(name: str,
+                             prefix: str,
                              base: Optional[QAPISchemaObjectType],
                              members: List[QAPISchemaObjectTypeMember],
                              branches: Optional[QAPISchemaBranches]) -> str:
@@ -103,7 +104,7 @@ def gen_visit_object_members(name: str,
 ''',
                          name=memb.name, has=has)
             indent.increase()
-        features = gen_features(memb.features)
+        features = gen_features(prefix, memb.features)
         if features != '0':
             ret += mcgen('''
     if (visit_policy_reject(v, "%(name)s", %(features)s, errp)) {
@@ -402,7 +403,7 @@ def visit_object_type(self,
             return
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_visit_members_decl(name))
-            self._genc.add(gen_visit_object_members(name, base,
+            self._genc.add(gen_visit_object_members(name, self._prefix, base,
                                                     members, branches))
             # TODO Worth changing the visitor signature, so we could
             # directly use rather than repeat type.is_implicit()?
-- 
2.45.2


