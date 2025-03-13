Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A769C2BA1B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 04:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsaQG-0008IZ-S4; Thu, 13 Mar 2025 00:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsaPz-0008Cx-U4
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 00:43:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsaPx-0006y8-5D
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 00:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741841016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jFGI/jGuLp7KfXOYAGZb+QBrJhbw7lTOKRb3oci5EKo=;
 b=bCi9A9Op0ZHGLF8SdJOtf7b4Zek5bVcM+yOvxYHFUMUJhzOGU9qpFhhqyiRWr8PQZRvtA+
 +dtWiar3BJtE7/ymwrJdsWpFUEQC1TqO6l9XpNckEIkthNecRx67hw4lrCtmSaZjjlxyv0
 jPLbVcBZiOjCdrKkjgy0j0jzcgWwbjU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-TUnx1MtBPnafs7V9_dExpQ-1; Thu,
 13 Mar 2025 00:43:34 -0400
X-MC-Unique: TUnx1MtBPnafs7V9_dExpQ-1
X-Mimecast-MFC-AGG-ID: TUnx1MtBPnafs7V9_dExpQ_1741841013
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B52E51801A06; Thu, 13 Mar 2025 04:43:33 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.62])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 76B4D1944EAA; Thu, 13 Mar 2025 04:43:25 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 01/11] docs/qapi_domain: isolate TYPE_CHECKING imports
Date: Thu, 13 Mar 2025 00:43:02 -0400
Message-ID: <20250313044312.189276-2-jsnow@redhat.com>
In-Reply-To: <20250313044312.189276-1-jsnow@redhat.com>
References: <20250313044312.189276-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

When using the annotations feature, type hints do not need to be
imported at runtime, only at type check time. Move type-check-only
imports into a conditional to reduce the number of imports needed at
runtime.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi_domain.py | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 7ff618d8cda..d52e7df7bc7 100644
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


