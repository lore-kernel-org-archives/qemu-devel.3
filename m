Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6DBC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxqJ-00039X-0G; Tue, 11 Mar 2025 07:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxq9-00034s-R5
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxpy-0006TM-0M
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/CI14kO4UJbWg5wTu3gXivAFZrKjIYx/AgYjSxCmf0E=;
 b=Vvr7AifX7FSExaXCtCewn63AYkRfs/FAMC1J5vbP+Oh+QQbpa5MRDKC16GlkiiHWNAU4ui
 6if9G7vtZmd6dgJqHFcand1lGwl4FItWwSvL7pFonx4PL4FvFbOp3H2g0g1h8SYM8vOBAX
 8UPFh/jZYH+AE0X3b308kVlO8IajQoQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-biO4lXj7MVSTqrWZ5r4o-w-1; Tue,
 11 Mar 2025 07:31:50 -0400
X-MC-Unique: biO4lXj7MVSTqrWZ5r4o-w-1
X-Mimecast-MFC-AGG-ID: biO4lXj7MVSTqrWZ5r4o-w_1741692709
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A058718009FC
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E05418001F6
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E0E6E21E64F2; Tue, 11 Mar 2025 12:31:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 12/61] docs/qapi-domain: add :since: directive option
Date: Tue, 11 Mar 2025 12:30:48 +0100
Message-ID: <20250311113137.1277125-13-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Add a little special markup for registering "Since:" information. Adding
it as an option instead of generic content lets us hoist the information
into the Signature bar, optionally put it in the index, etc.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-15-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapi_domain.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 547040f75a..222b420d2a 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -214,6 +214,8 @@ class QAPIObject(QAPIDescription):
         {
             # Borrowed from the Python domain:
             "module": directives.unchanged,  # Override contextual module name
+            # These are QAPI originals:
+            "since": directives.unchanged,
         }
     )
 
@@ -227,7 +229,17 @@ def get_signature_prefix(self) -> List[nodes.Node]:
 
     def get_signature_suffix(self) -> List[nodes.Node]:
         """Return a suffix to put after the object name in the signature."""
-        return []
+        ret: List[nodes.Node] = []
+
+        if "since" in self.options:
+            ret += [
+                SpaceNode(" "),
+                addnodes.desc_sig_element(
+                    "", f"(Since: {self.options['since']})"
+                ),
+            ]
+
+        return ret
 
     def handle_signature(self, sig: str, signode: desc_signature) -> Signature:
         """
-- 
2.48.1


