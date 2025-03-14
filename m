Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0B7C35FF1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 10:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt20M-0006Ke-RC; Fri, 14 Mar 2025 06:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt20F-0006Iq-11
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt20C-00023C-Mn
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741947051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=baQ+HaROmmAM+TkdGfumBlYGTIxDaOf3UHesS9VAqik=;
 b=S+mFu/zaqGtB9kcfe2HWoJVAj65fIdIekYhLUsZEox1+GtLLS8yLCEfawELnEUmQgfFA2A
 wt9x+DJKocWocUFgiiO3BD5e0mOlSfuDPlOmJCum3FweV6Kg7gUiskaZAhU4bCamQFqiY5
 IKDrei8sL9UJ+FqoHttGOeWFkI2sSlo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-RBZoqkw3Ol2flFrXXwJXQA-1; Fri,
 14 Mar 2025 06:10:49 -0400
X-MC-Unique: RBZoqkw3Ol2flFrXXwJXQA-1
X-Mimecast-MFC-AGG-ID: RBZoqkw3Ol2flFrXXwJXQA_1741947049
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E27571956048
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:10:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F8A41801756
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:10:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D28AD21E65FF; Fri, 14 Mar 2025 11:10:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 07/12] docs/qapidoc: add :namespace: option to qapi-doc
 directive
Date: Fri, 14 Mar 2025 11:10:33 +0100
Message-ID: <20250314101038.2408751-8-armbru@redhat.com>
In-Reply-To: <20250314101038.2408751-1-armbru@redhat.com>
References: <20250314101038.2408751-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: John Snow <jsnow@redhat.com>

Add a :namespace: option to the qapi-doc directive, which inserts a
qapi:namespace directive into the start of the generated document. This,
in turn, associates all auto-generated definitions by this directive
with the specified namespace.

The source info for these generated lines are credited to the start of
the qapi-doc directive, which isn't precisely correct, but I wasn't sure
how to get it more accurate without some re-parsing shenanigans.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250313044312.189276-7-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 432fef04b0..661b2c4ed0 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -451,6 +451,12 @@ def visit_entity(self, ent: QAPISchemaDefinition) -> None:
         finally:
             self._curr_ent = None
 
+    def set_namespace(self, namespace: str, source: str, lineno: int) -> None:
+        self.add_line_raw(
+            f".. qapi:namespace:: {namespace}", source, lineno + 1
+        )
+        self.ensure_blank_line()
+
 
 class QAPISchemaGenDepVisitor(QAPISchemaVisitor):
     """A QAPI schema visitor which adds Sphinx dependencies each module
@@ -496,6 +502,7 @@ class QAPIDocDirective(NestedDirective):
     optional_arguments = 1
     option_spec = {
         "qapifile": directives.unchanged_required,
+        "namespace": directives.unchanged,
         "transmogrify": directives.flag,
     }
     has_content = False
@@ -510,6 +517,11 @@ def transmogrify(self, schema: QAPISchema) -> nodes.Element:
         vis = Transmogrifier()
         modules = set()
 
+        if "namespace" in self.options:
+            vis.set_namespace(
+                self.options["namespace"], *self.get_source_info()
+            )
+
         for doc in schema.docs:
             module_source = doc.info.fname
             if module_source not in modules:
-- 
2.48.1


