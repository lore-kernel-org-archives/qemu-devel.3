Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D79E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuHz-0001s6-M2; Thu, 12 Dec 2024 20:16:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuH7-00010X-Sb
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:15:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuH6-0000wT-5C
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734052522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UI8k4bLF/f2KJ4I9nTVpY7xzkypAiwueEZlTj/biSjw=;
 b=Gs/WAa+X8YKGp8Q2XSCIoADx7nyCfiW7zavqZWzqGRbLWHoYVXI5jFaSrUoQckUpQw+Ty4
 wlcau8MWvZTVvzliBG/0P584xW1m2KRje/AYwXs2QRDVLTCVpI3nC1iOz4S6yNL3m3hPMm
 MLSfEuZk//fPUi8b/pPrgccRZv4+3cs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-pT8rdSG5M7CZRejPCBafhA-1; Thu,
 12 Dec 2024 20:15:18 -0500
X-MC-Unique: pT8rdSG5M7CZRejPCBafhA-1
X-Mimecast-MFC-AGG-ID: pT8rdSG5M7CZRejPCBafhA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5B5E1956096; Fri, 13 Dec 2024 01:15:17 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 513311956086; Fri, 13 Dec 2024 01:15:16 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 34/35] WIP: 3.x ObjectDesc compat
Date: Thu, 12 Dec 2024 20:13:03 -0500
Message-ID: <20241213011307.2942030-35-jsnow@redhat.com>
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/compat.py      | 7 +++++++
 docs/sphinx/qapi-domain.py | 9 +++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/docs/sphinx/compat.py b/docs/sphinx/compat.py
index 5126b450a5f..b2d2d1be403 100644
--- a/docs/sphinx/compat.py
+++ b/docs/sphinx/compat.py
@@ -33,15 +33,22 @@
 SOURCE_LOCATION_FIX = (5, 3, 0) <= sphinx.version_info[:3] < (6, 2, 0)
 
 
+# Alias for the return of QAPIObject.handle_signature(), which is used
+# in several places. (In the Python domain, this type is Tuple[str,
+# str] instead.)
+Signature = str
+
 space_node: Callable[[str], Node]
 keyword_node: Callable[[str, str], Node]
 
 if sphinx.version_info[:3] >= (4, 0, 0):
     space_node = addnodes.desc_sig_space
     keyword_node = addnodes.desc_sig_keyword
+    ObjectDesc = ObjectDescription[Signature]
 else:
     space_node = Text
     keyword_node = addnodes.desc_annotation
+    ObjectDesc = ObjectDescription
 
 
 def nested_parse(directive: SphinxDirective, content_node: Element) -> None:
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index 00d32d44e1d..fcda281d45e 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -26,7 +26,9 @@
 from compat import (
     Field,
     GroupedField,
+    ObjectDesc,
     ParserFix,
+    Signature,
     TypedField,
     keyword_node,
     nested_parse,
@@ -164,12 +166,7 @@ def since_validator(param: str) -> str:
     return param
 
 
-# Alias for the return of handle_signature(), which is used in several places.
-# (In the Python domain, this is Tuple[str, str] instead.)
-Signature = str
-
-
-class QAPIObject(ParserFix, ObjectDescription[Signature]):
+class QAPIObject(ParserFix, ObjectDesc):
     """
     Description of a generic QAPI object.
 
-- 
2.47.0


