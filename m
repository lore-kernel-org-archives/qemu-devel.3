Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EA9E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 02:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLvHa-0007oM-HM; Thu, 12 Dec 2024 21:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLvHX-0007T2-QF
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 21:19:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLvHV-0007yV-Nx
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 21:19:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734056392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xZUL+vF4/RYSQ10YJTyI5aWhNcZe8bw7gExBsWxsdtU=;
 b=CSvW0Ef/k6wbBaQUuM9fIDizHqpufc6KCS5lvZW1V8EZBTbFzi7l5wa3nP7vFmHdAXmjCE
 S7bdkpod1dJHB8kpVzbD7ki5frucn0a7cVf88gorF9MpLgWoEvataKYN9B9fCYPR9EGSR9
 42yAbKJ/BmRy9tE6R91oOzi8bbn0/ec=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-ZxeUNreCPD-c65Lwl_PC-Q-1; Thu,
 12 Dec 2024 21:19:51 -0500
X-MC-Unique: ZxeUNreCPD-c65Lwl_PC-Q-1
X-Mimecast-MFC-AGG-ID: ZxeUNreCPD-c65Lwl_PC-Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A0CF1956089; Fri, 13 Dec 2024 02:19:50 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 134BC195605A; Fri, 13 Dec 2024 02:19:48 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 19/23] docs/qapidoc: add visit_member() method
Date: Thu, 12 Dec 2024 21:18:22 -0500
Message-ID: <20241213021827.2956769-20-jsnow@redhat.com>
In-Reply-To: <20241213021827.2956769-1-jsnow@redhat.com>
References: <20241213021827.2956769-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

This method is used for generating the "members" of a wide variety of
things, including structs, unions, enums, alternates, etc. The field
name it uses to do so is dependent on the type of entity the "member"
belongs to.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 9d298117fea..fe01ee71c26 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -74,6 +74,16 @@ def dedent(text: str) -> str:
 
 
 class Transmogrifier:
+    # Field names used for different entity types:
+    field_types = {
+        "enum": "value",
+        "struct": "memb",
+        "union": "memb",
+        "event": "memb",
+        "command": "arg",
+        "alternate": "choice",
+    }
+
     def __init__(self, schema):
         self._curr_ent = None
         self._result = StringList()
@@ -84,6 +94,10 @@ def entity(self) -> QAPISchemaEntity:
         assert self._curr_ent is not None
         return self._curr_ent
 
+    @property
+    def member_field_type(self) -> str:
+        return self.field_types[self.entity.meta]
+
     # General-purpose rST generation functions
 
     def get_indent(self) -> str:
@@ -194,6 +208,19 @@ def visit_paragraph(self, section: QAPIDoc.Section) -> None:
         self.add_lines(section.text, section.info)
         self.ensure_blank_line()
 
+    def visit_member(self, section: QAPIDoc.ArgSection) -> None:
+        # TODO: ifcond for members
+        # TODO?: features for members (documented at entity-level,
+        # but sometimes defined per-member. Should we add such
+        # information to member descriptions when we can?)
+        assert section.text
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
2.47.0


