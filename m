Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94663C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxrT-000411-3k; Tue, 11 Mar 2025 07:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqu-0003ON-2X
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqC-0006XK-1E
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ADMLW+61PuWpsuphJIvWInfzcdZbDjmCvugW0JTDjWE=;
 b=fNI4z2PHEvlvy6EzOkJsUwidBJ2tARfJyRmEfB44RO0d0KX/SiNADYixaHZhClq9otsXa2
 gdNGgrnSofLSfvL2Zo4vvo4V8H9ZQ6AdNjwIWzEVaL+EfFYxoYLM1Ogtq8qUUh+g9gCaBW
 r3PYjgYzYfmxDFe3G2mAunJ4riZyhvw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-W4owZr_aPVC6a42gfFPPiA-1; Tue,
 11 Mar 2025 07:32:00 -0400
X-MC-Unique: W4owZr_aPVC6a42gfFPPiA-1
X-Mimecast-MFC-AGG-ID: W4owZr_aPVC6a42gfFPPiA_1741692719
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9693C19560A1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30D4F19560AD
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7769D21E60D8; Tue, 11 Mar 2025 12:31:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 48/61] docs/qapidoc: add visit_member() method
Date: Tue, 11 Mar 2025 12:31:24 +0100
Message-ID: <20250311113137.1277125-49-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This method is used for generating the "members" of a wide variety of
things, including structs, unions, enums, alternates, etc. The field
name it uses to do so is dependent on the type of entity the "member"
belongs to.

Currently, IF conditionals for individual members are not handled or
rendered, a small regression from the prior documentation
generator. This will be fixed in a future patch.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-52-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index eb8841099c..a8e19487d0 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -78,6 +78,16 @@
 
 
 class Transmogrifier:
+    # Field names used for different entity types:
+    field_types = {
+        "enum": "value",
+        "struct": "memb",
+        "union": "memb",
+        "event": "memb",
+        "command": "arg",
+        "alternate": "alt",
+    }
+
     def __init__(self) -> None:
         self._curr_ent: Optional[QAPISchemaDefinition] = None
         self._result = StringList()
@@ -88,6 +98,10 @@ def entity(self) -> QAPISchemaDefinition:
         assert self._curr_ent is not None
         return self._curr_ent
 
+    @property
+    def member_field_type(self) -> str:
+        return self.field_types[self.entity.meta]
+
     # General-purpose rST generation functions
 
     def get_indent(self) -> str:
@@ -202,6 +216,19 @@ def visit_paragraph(self, section: QAPIDoc.Section) -> None:
         self.add_lines(section.text, section.info)
         self.ensure_blank_line()
 
+    def visit_member(self, section: QAPIDoc.ArgSection) -> None:
+        # FIXME: ifcond for members
+        # TODO: features for members (documented at entity-level,
+        # but sometimes defined per-member. Should we add such
+        # information to member descriptions when we can?)
+        assert section.text and section.member
+        self.generate_field(
+            self.member_field_type,
+            section.member,
+            section.text,
+            section.info,
+        )
+
     def visit_feature(self, section: QAPIDoc.ArgSection) -> None:
         # FIXME - ifcond for features is not handled at all yet!
         # Proposal: decorate the right-hand column with some graphical
-- 
2.48.1


