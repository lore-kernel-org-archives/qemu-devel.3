Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3773C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 04:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkGRD-0007zY-MI; Wed, 13 Mar 2024 00:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rkGQt-0007uD-E3
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 00:41:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rkGQp-0001qv-Rt
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 00:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710304895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DTqB3WylAX51wzc5p0slRGOvWwmV6qQdPyDe8eBkKg4=;
 b=Gb5OPDFQ8JXoCVgegAjdB3Eftxaa3mW//1CLYQpDqucAaVhIvIrM0GStfyF5kCcRRFCpCU
 KcsnTtUkeR4eQdjEt4TfckfSzcTWdW4rtm3WN3BpVkW0A2ZLF7cudpEvr15+OzzzABRvjg
 NZ5QMt4GZhfAuAD4tp0+6E1gZMhJ/So=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-xgqYwJTBM_iGsyW_s6Fegg-1; Wed,
 13 Mar 2024 00:41:33 -0400
X-MC-Unique: xgqYwJTBM_iGsyW_s6Fegg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE4043C0C885;
 Wed, 13 Mar 2024 04:41:32 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.16.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F1EB111E5;
 Wed, 13 Mar 2024 04:41:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v4 12/23] qapi: use schema.resolve_type instead of
 schema.lookup_type
Date: Wed, 13 Mar 2024 00:41:16 -0400
Message-ID: <20240313044127.49089-13-jsnow@redhat.com>
In-Reply-To: <20240313044127.49089-1-jsnow@redhat.com>
References: <20240313044127.49089-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

the function lookup_type() is capable of returning None, but some
callers aren't prepared for that and assume it will always succeed. For
static type analysis purposes, this creates problems at those callsites.

Modify resolve_type() - which already cannot ever return None - to allow
'info' and 'what' parameters to be elided, which infers that the type
lookup is a built-in type lookup.

Change several callsites to use the new form of resolve_type to avoid
the more laborious strictly-typed error-checking scaffolding:

  ret = lookup_type("foo")
  assert ret is not None
  typ: QAPISchemaType = ret

which can be replaced with the simpler:

  typ = resolve_type("foo")

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/introspect.py | 4 ++--
 scripts/qapi/schema.py     | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 67c7d89aae0..c38df61a6d5 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -227,10 +227,10 @@ def _use_type(self, typ: QAPISchemaType) -> str:
 
         # Map the various integer types to plain int
         if typ.json_type() == 'int':
-            typ = self._schema.lookup_type('int')
+            typ = self._schema.resolve_type('int')
         elif (isinstance(typ, QAPISchemaArrayType) and
               typ.element_type.json_type() == 'int'):
-            typ = self._schema.lookup_type('intList')
+            typ = self._schema.resolve_type('intList')
         # Add type to work queue if new
         if typ not in self._used_types:
             self._used_types.append(typ)
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index f5c7789d98f..58ec3a7c41c 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -642,8 +642,7 @@ def check(self, schema, seen):
                     "discriminator '%s' is not a member of %s"
                     % (self._tag_name, base))
             # Here we do:
-            base_type = schema.lookup_type(self.tag_member.defined_in)
-            assert base_type
+            base_type = schema.resolve_type(self.tag_member.defined_in)
             if not base_type.is_implicit():
                 base = "base type '%s'" % self.tag_member.defined_in
             if not isinstance(self.tag_member.type, QAPISchemaEnumType):
@@ -993,7 +992,7 @@ def lookup_type(self, name):
         assert typ is None or isinstance(typ, QAPISchemaType)
         return typ
 
-    def resolve_type(self, name, info, what):
+    def resolve_type(self, name, info=None, what=None):
         typ = self.lookup_type(name)
         if not typ:
             assert info and what  # built-in types must not fail lookup
-- 
2.44.0


