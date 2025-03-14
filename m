Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E00C35FF1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 10:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt20K-0006J4-Tl; Fri, 14 Mar 2025 06:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt20B-0006I7-T2
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:10:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt208-00021y-NS
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741947047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bxgvXu/x8itjefbAnHJcPTUQUR6+sgtoyE3sKaeR4Gg=;
 b=GvuTdwyiz2McA+fZo9xvlHBlJoo0lFdN634PHPAVJlGChR8XtTYryLIIBZeBBbN+8NF0GI
 3urHDNYtgQhsbtkdk5IPrIZRr2arrYU7TXzd6zprpx/bvRmcd13yJux/N8ALuRx8YSMz0a
 hH/oNgd/sxfx6TRTdjdwMtgW1G6Qa5k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-oDCcOe2vMICIHmmzjoylng-1; Fri,
 14 Mar 2025 06:10:45 -0400
X-MC-Unique: oDCcOe2vMICIHmmzjoylng-1
X-Mimecast-MFC-AGG-ID: oDCcOe2vMICIHmmzjoylng_1741947044
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C56B180036E
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:10:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 012AC300377A
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:10:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BE36021E669D; Fri, 14 Mar 2025 11:10:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 02/12] docs/qapi_domain: isolate TYPE_CHECKING imports
Date: Fri, 14 Mar 2025 11:10:28 +0100
Message-ID: <20250314101038.2408751-3-armbru@redhat.com>
In-Reply-To: <20250314101038.2408751-1-armbru@redhat.com>
References: <20250314101038.2408751-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

When using the annotations feature, type hints do not need to be
imported at runtime, only at type check time. Move type-check-only
imports into a conditional to reduce the number of imports needed at
runtime.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250313044312.189276-2-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapi_domain.py | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 7ff618d8cd..d52e7df7bc 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -9,15 +9,9 @@
 
 from typing import (
     TYPE_CHECKING,
-    AbstractSet,
-    Any,
-    Dict,
-    Iterable,
     List,
     NamedTuple,
-    Optional,
     Tuple,
-    Union,
     cast,
 )
 
@@ -34,7 +28,6 @@
     SpaceNode,
 )
 from sphinx import addnodes
-from sphinx.addnodes import desc_signature, pending_xref
 from sphinx.directives import ObjectDescription
 from sphinx.domains import (
     Domain,
@@ -49,13 +42,24 @@
 
 
 if TYPE_CHECKING:
+    from typing import (
+        AbstractSet,
+        Any,
+        Dict,
+        Iterable,
+        Optional,
+        Union,
+    )
+
     from docutils.nodes import Element, Node
 
+    from sphinx.addnodes import desc_signature, pending_xref
     from sphinx.application import Sphinx
     from sphinx.builders import Builder
     from sphinx.environment import BuildEnvironment
     from sphinx.util.typing import OptionSpec
 
+
 logger = logging.getLogger(__name__)
 
 
-- 
2.48.1


