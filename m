Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D07C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 08:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnYwM-0008Vk-8u; Thu, 27 Feb 2025 03:08:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnYwD-0008L7-U6
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:08:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnYwB-0001fZ-C9
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740643685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ghg1+E0JdhJabwSgZMyZsM5RpsyBKY2hMAEJeHgs3yg=;
 b=JmYnJDaBcfL0Up8otRg4BhHeoVuE4Z/nO2oevR3BVekhyRheB2pWr6o/5bcwWnwkaD6C3t
 G6tjye8JLlarESnyY/OdAAkXHtaak+6rDlAtSmRdVLVeEtYScunpJuU2YrjoKJb5b3hQi0
 UHjXiH1k+tFmpAmPNnyMCfRAY7m5e3g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-8OvbpMuFNCmhS-3E-X9GOw-1; Thu,
 27 Feb 2025 03:08:01 -0500
X-MC-Unique: 8OvbpMuFNCmhS-3E-X9GOw-1
X-Mimecast-MFC-AGG-ID: 8OvbpMuFNCmhS-3E-X9GOw_1740643680
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F6D0193578F; Thu, 27 Feb 2025 08:08:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D53619560AE; Thu, 27 Feb 2025 08:08:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7C7D321E65E7; Thu, 27 Feb 2025 09:07:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com,
	jsnow@redhat.com
Subject: [PATCH 3/3] qapi/introspect: Use @dataclass to simplify
Date: Thu, 27 Feb 2025 09:07:57 +0100
Message-ID: <20250227080757.3978333-4-armbru@redhat.com>
In-Reply-To: <20250227080757.3978333-1-armbru@redhat.com>
References: <20250227080757.3978333-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

A TODO comment in class Annotated reminds us to simplify it once we
can use @dataclass, new in Python 3.7.  We have that now, so do it.

There's a similar comment in scripts/qapi/source.py, but I can't
figure out how to use @dataclass there.  Left for another day.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/introspect.py | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 42e5185c7c..89ee5d5f17 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -11,6 +11,7 @@
 See the COPYING file in the top-level directory.
 """
 
+from dataclasses import dataclass
 from typing import (
     Any,
     Dict,
@@ -79,19 +80,16 @@
 _ValueT = TypeVar('_ValueT', bound=_Value)
 
 
+@dataclass
 class Annotated(Generic[_ValueT]):
     """
     Annotated generally contains a SchemaInfo-like type (as a dict),
     But it also used to wrap comments/ifconds around scalar leaf values,
     for the benefit of features and enums.
     """
-    # TODO: Remove after Python 3.7 adds @dataclass:
-    # pylint: disable=too-few-public-methods
-    def __init__(self, value: _ValueT, ifcond: QAPISchemaIfCond,
-                 comment: Optional[str] = None):
-        self.value = value
-        self.comment: Optional[str] = comment
-        self.ifcond = ifcond
+    value: _ValueT
+    ifcond: QAPISchemaIfCond
+    comment: Optional[str] = None
 
 
 def _tree_to_qlit(obj: JSONValue,
-- 
2.48.1


