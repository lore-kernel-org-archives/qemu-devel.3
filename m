Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A964E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 02:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLvHV-0007LF-F1; Thu, 12 Dec 2024 21:19:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLvHQ-0007H9-SA
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 21:19:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLvHP-0007xU-Bl
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 21:19:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734056385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gp5mQeEOdsiA1ZBEDmZNFbst0HIqxLpcEhdeB3yCV3Y=;
 b=UMciVT0h/g3r0VrSkKexFukSl2xij5LvhB6TVnvDxZpeg7Um4pVOB30C28Cj1NwcrrryvA
 +yfU77K8ivZzUsGOHjXVc8V7ymfnA1O16aamdaYzUa79FPONzHcS9oQ8m7ZhtAqQzhCSON
 Z461paQz6Bz+pC/D78aUtV6XOkfvLWw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-7_rThSSLNTCGfRZ6V6SiJQ-1; Thu,
 12 Dec 2024 21:19:39 -0500
X-MC-Unique: 7_rThSSLNTCGfRZ6V6SiJQ-1
X-Mimecast-MFC-AGG-ID: 7_rThSSLNTCGfRZ6V6SiJQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C73D01956048; Fri, 13 Dec 2024 02:19:38 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F2D41955F40; Fri, 13 Dec 2024 02:19:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 15/23] docs/qapidoc: add add_field() and generate_field()
 helper methods
Date: Thu, 12 Dec 2024 21:18:18 -0500
Message-ID: <20241213021827.2956769-16-jsnow@redhat.com>
In-Reply-To: <20241213021827.2956769-1-jsnow@redhat.com>
References: <20241213021827.2956769-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

These are simple rST generation methods that assist in getting the types
and formatting correct for a field list entry. add_field() is a more
raw, direct call while generate_field() is intended to be used for
generating the correct field from a member object.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 1c83d1b7aac..7efe2d656c0 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -44,6 +44,7 @@
     QAPISchemaEntity,
     QAPISchemaEnumMember,
     QAPISchemaFeature,
+    QAPISchemaMember,
     QAPISchemaObjectTypeMember,
 )
 from qapi.source import QAPISourceInfo
@@ -132,6 +133,20 @@ def ensure_blank_line(self) -> None:
             # +2: correct for zero/one index, then increment by one.
             self.add_line_raw("", fname, line + 2)
 
+    def add_field(
+        self,
+        kind: str,
+        name: str,
+        body: str,
+        info: QAPISourceInfo,
+        typ: Optional[str] = None,
+    ) -> None:
+        if typ:
+            text = f":{kind} {typ} {name}: {body}"
+        else:
+            text = f":{kind} {name}: {body}"
+        self.add_lines(text, info)
+
     def format_type(self, ent) -> Optional[str]:
         if isinstance(ent, (QAPISchemaEnumMember, QAPISchemaFeature)):
             return None
@@ -151,6 +166,16 @@ def format_type(self, ent) -> Optional[str]:
 
         return ret
 
+    def generate_field(
+        self,
+        kind: str,
+        member: QAPISchemaMember,
+        body: str,
+        info: QAPISourceInfo,
+    ) -> None:
+        typ = self.format_type(member)
+        self.add_field(kind, member.name, body, info, typ)
+
     # Transmogrification helpers
 
     def visit_paragraph(self, section: QAPIDoc.Section) -> None:
-- 
2.47.0


