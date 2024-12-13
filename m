Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402A8E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuGD-0005uC-OV; Thu, 12 Dec 2024 20:14:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuG9-0005tT-Ee
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:14:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuG3-0000eG-4j
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734052457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+UQTiLGXqIWSEzCIAZ1iFQL8e/U6Oks1NAbc4rk+beo=;
 b=EIvLESF1B9G5H/0CM/2GSYR0AeiBdBbwmjATDL7rhbRuG/iCYtwMdI6tpxRjKMSaUutN/z
 i0PO6agq9EQLS52m7ekZ0bZ7n1QYDgmxSdR1oTKC4QqMgJBOiOyo6lxWlb5CPWvrnVDR2+
 KKikBYnC5ZPQUyXgi+Sjgv2oaGhL4SQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-c9Gca_zZMzewS6Cn_i3rnQ-1; Thu,
 12 Dec 2024 20:14:11 -0500
X-MC-Unique: c9Gca_zZMzewS6Cn_i3rnQ-1
X-Mimecast-MFC-AGG-ID: c9Gca_zZMzewS6Cn_i3rnQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F31A11955F42; Fri, 13 Dec 2024 01:14:10 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2BFE91956086; Fri, 13 Dec 2024 01:14:09 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 14/35] docs/qapi-domain: add "Features:" field lists
Date: Thu, 12 Dec 2024 20:12:43 -0500
Message-ID: <20241213011307.2942030-15-jsnow@redhat.com>
In-Reply-To: <20241213011307.2942030-1-jsnow@redhat.com>
References: <20241213011307.2942030-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Add support for Features field lists. There is no QAPI-specific
functionality here, but this could be changed if desired (if we wanted
the feature names to link somewhere, for instance.)

This feature list doesn't have any restrictions, so it can be used to
document object-wide features or per-member features as deemed
appropriate. It's essentially free-form text.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi-domain.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index 15a615d8adb..9b83262a0c6 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -34,7 +34,7 @@
 from sphinx.locale import _, __
 from sphinx.roles import XRefRole
 from sphinx.util import logging
-from sphinx.util.docfields import TypedField
+from sphinx.util.docfields import GroupedField, TypedField
 from sphinx.util.docutils import SphinxDirective
 from sphinx.util.nodes import make_id, make_refnode
 
@@ -122,6 +122,16 @@ class QAPIObject(ObjectDescription[Signature]):
         }
     )
 
+    doc_field_types = [
+        # :feat name: descr
+        GroupedField(
+            "feature",
+            label=_("Features"),
+            names=("feat",),
+            can_collapse=False,
+        ),
+    ]
+
     def get_signature_prefix(self, sig: str) -> List[nodes.Node]:
         """Returns a prefix to put before the object name in the signature."""
         assert self.objtype
-- 
2.47.0


