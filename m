Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278F7C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxqb-0003Eh-2P; Tue, 11 Mar 2025 07:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqD-00037e-B2
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxq2-0006V3-Gm
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8w8JPzbCqCu7+BNJ2brD8hkE/otEgSOTWftx8sadi7A=;
 b=Ni03+DA4FiaLktdK8Vl/ZtKHKSsQ6yXQcFBjoXPgrsOn/3v4k+O2JIJP2vLA8hjJYHPblf
 BYqZf7CZ5k4hR1ja1aorQ+1ut1H/WDvzIW7idea773d0K58LEjlIGe8kWtrD4CCE8WcRhr
 gtOdFpDOkmBeDvmAbUqj3P4jWdLv4O0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-n7KxawBkMxC24UgtQUOGqw-1; Tue,
 11 Mar 2025 07:31:54 -0400
X-MC-Unique: n7KxawBkMxC24UgtQUOGqw-1
X-Mimecast-MFC-AGG-ID: n7KxawBkMxC24UgtQUOGqw_1741692714
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8CB9180AF66
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CDB71828A92
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2A5D321E6187; Tue, 11 Mar 2025 12:31:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 28/61] docs/qapi-domain: warn when QAPI domain xrefs fail to
 resolve
Date: Tue, 11 Mar 2025 12:31:04 +0100
Message-ID: <20250311113137.1277125-29-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

This patch adds a warning (which is a build failure under our current
build settings) whenever a QAPI cross-reference fails to resolve.

This applies to any cross-references of the form :qapi:{role}:`foo`,
which covers all of the automatically generated references by the qapi
domain, and any such references that are manually written into the
documentation rst files.

Cross-references of the form `foo` do not use this system, but are
already configured to issue a warning (Again, a build failure) if the
cross-reference isn't found anywhere.

Adds warnings that look like the following:

docs/qapi/index.rst:48: WARNING: qapi:type reference target not found: 'footype' [ref.qapi]
docs/qapi/index.rst:50: WARNING: qapi:mod reference target not found: 'foomod' [ref.qapi]

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-31-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapi_domain.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 3b1490e29a..b23db1eba2 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -830,6 +830,29 @@ def resolve_xref(
         matches = self.find_obj(modname, target, typ)
 
         if not matches:
+            # Normally, we could pass warn_dangling=True to QAPIXRefRole(),
+            # but that will trigger on references to these built-in types,
+            # which we'd like to ignore instead.
+
+            # Take care of that warning here instead, so long as the
+            # reference isn't to one of our built-in core types.
+            if target not in (
+                "string",
+                "number",
+                "int",
+                "boolean",
+                "null",
+                "value",
+                "q_empty",
+            ):
+                logger.warning(
+                    __("qapi:%s reference target not found: %r"),
+                    typ,
+                    target,
+                    type="ref",
+                    subtype="qapi",
+                    location=node,
+                )
             return None
 
         if len(matches) > 1:
-- 
2.48.1


