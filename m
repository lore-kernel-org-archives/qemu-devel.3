Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD15C282D9
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpfjS-0006lU-LO; Tue, 04 Mar 2025 22:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfjL-0006Ub-OB
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:47:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfjJ-00069y-Ti
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NOuPk1n5NCVsVAJdRRLy69vdaa01uAEYuIFG9s4IFjA=;
 b=UUisPXd1g5m6fwM6ZtCH83JxjLzFfbESim+3CWslCm+mEicfxWvbO52oVO728ZjLT+mRGW
 rna2tUemJD4IDPpxm24ElgBoaV6WuadsAhQo+dg63AWIzibSRpnMKlINipTsuWk1N5hhzR
 9/ikjQu46UH9MvVql4Jo5z2g3GnZx5o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-6C8053U2NQa9CfSb4GANlw-1; Tue,
 04 Mar 2025 22:47:23 -0500
X-MC-Unique: 6C8053U2NQa9CfSb4GANlw-1
X-Mimecast-MFC-AGG-ID: 6C8053U2NQa9CfSb4GANlw_1741146442
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1E7A18001CA; Wed,  5 Mar 2025 03:47:21 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED29B1956095; Wed,  5 Mar 2025 03:47:18 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 18/57] docs/qapi-domain: add qapi:alternate directive
Date: Tue,  4 Mar 2025 22:45:27 -0500
Message-ID: <20250305034610.960147-19-jsnow@redhat.com>
In-Reply-To: <20250305034610.960147-1-jsnow@redhat.com>
References: <20250305034610.960147-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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
 docs/sphinx/qapi_domain.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 66fdeec1d37..d4120fa5ac6 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -320,6 +320,23 @@ class QAPIEnum(QAPIObject):
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
@@ -483,6 +500,7 @@ class QAPIDomain(Domain):
         "module": ObjType(_("module"), "mod", "any"),
         "command": ObjType(_("command"), "cmd", "any"),
         "enum": ObjType(_("enum"), "enum", "type", "any"),
+        "alternate": ObjType(_("alternate"), "alt", "type", "any"),
     }
 
     # Each of these provides a rST directive,
@@ -491,6 +509,7 @@ class QAPIDomain(Domain):
         "module": QAPIModule,
         "command": QAPICommand,
         "enum": QAPIEnum,
+        "alternate": QAPIAlternate,
     }
 
     # These are all cross-reference roles; e.g.
@@ -500,6 +519,7 @@ class QAPIDomain(Domain):
         "mod": QAPIXRefRole(),
         "cmd": QAPIXRefRole(),
         "enum": QAPIXRefRole(),
+        "alt": QAPIXRefRole(),
         # reference any data type (excludes modules, commands, events)
         "type": QAPIXRefRole(),
         "any": QAPIXRefRole(),  # reference *any* type of QAPI object.
-- 
2.48.1


