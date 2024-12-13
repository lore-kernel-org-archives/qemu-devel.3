Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67378E77182
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuGS-0006Rg-CF; Thu, 12 Dec 2024 20:14:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuGJ-00068b-0p
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:14:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuGG-0000ft-Tk
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734052470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gPT+u3LXxfH0gjTJDFgoPLbgfnZcJHf1GRuIQEBj2Kk=;
 b=fIUsBlQHtCRwoRsn7wrGBq1NhmfEu3yFd2/vwBBB4IuozFXhhbbKFsolAupQ19P6yKbKh1
 FiE/DMoosc04Bz9EagbQtB7NDYqZs4//oo5tPX6WOOIQF/aJ16X5q+54yS+FA7hluQTyyn
 luKt3dNh9UQioTN1bbcTWTe15XyAX+8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-NCSidw38P52JEilwYHPknw-1; Thu,
 12 Dec 2024 20:14:28 -0500
X-MC-Unique: NCSidw38P52JEilwYHPknw-1
X-Mimecast-MFC-AGG-ID: NCSidw38P52JEilwYHPknw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBDED195609F; Fri, 13 Dec 2024 01:14:27 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A74421956086; Fri, 13 Dec 2024 01:14:25 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 19/35] docs/qapi-domain: add qapi:alternate directive
Date: Thu, 12 Dec 2024 20:12:48 -0500
Message-ID: <20241213011307.2942030-20-jsnow@redhat.com>
In-Reply-To: <20241213011307.2942030-1-jsnow@redhat.com>
References: <20241213011307.2942030-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Add the .. qapi:alternate:: directive, object, and qapi:alt:`name`
cross-reference role.

Add the "Choices:" field list for describing alternate choices. Like
other field lists that reference QAPI types, a forthcoming commit will
add cross-referencing support to this field.

RFC: In the future, it would be nice to directly inline Alternates as
part of the type information in the containing object (i.e. directly in
arguments/members) - but that's a task for another series. For now, the
branch "names" are documented just like qapidoc.py does, even though
this information is superfluous for user documentation. Room for future
improvement, but not now.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi-domain.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index e37e300e4e6..e0c31b2ee4d 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -304,6 +304,23 @@ class QAPIEnum(QAPIObject):
     )
 
 
+class QAPIAlternate(QAPIObject):
+    """Description of a QAPI Alternate."""
+
+    doc_field_types = QAPIObject.doc_field_types.copy()
+    doc_field_types.extend(
+        [
+            # :choice type name: descr
+            TypedField(
+                "choice",
+                label=_("Choices"),
+                names=("choice",),
+                can_collapse=False,
+            ),
+        ]
+    )
+
+
 class QAPIModule(SphinxDirective):
     """
     Directive to mark description of a new module.
@@ -465,6 +482,7 @@ class QAPIDomain(Domain):
         "module": ObjType(_("module"), "mod", "obj"),
         "command": ObjType(_("command"), "cmd", "obj"),
         "enum": ObjType(_("enum"), "enum", "obj", "type"),
+        "alternate": ObjType(_("alternate"), "alt", "obj", "type"),
     }
 
     # Each of these provides a rST directive,
@@ -473,6 +491,7 @@ class QAPIDomain(Domain):
         "module": QAPIModule,
         "command": QAPICommand,
         "enum": QAPIEnum,
+        "alternate": QAPIAlternate,
     }
 
     # These are all cross-reference roles; e.g.
@@ -482,6 +501,7 @@ class QAPIDomain(Domain):
         "mod": QAPIXRefRole(),
         "cmd": QAPIXRefRole(),
         "enum": QAPIXRefRole(),
+        "alt": QAPIXRefRole(),
         # reference any data type (excludes modules, commands, events)
         "type": QAPIXRefRole(),
         "obj": QAPIXRefRole(),  # reference *any* type of QAPI object.
-- 
2.47.0


