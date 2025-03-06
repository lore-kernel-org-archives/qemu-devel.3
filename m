Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B40EC282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 09:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq7eP-0008Tr-PK; Thu, 06 Mar 2025 04:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tq7eL-0008TC-D0
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 04:36:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tq7eG-0002AF-OD
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 04:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741253770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B41gVq3poZH6zWoP/vwNiX3KFO1r++VfzCWpsZw4Ha4=;
 b=ICcDgYtiZtrQuWvm4X4F7yy68/lIJvBvFvwf2n2O4mKrFLnR4ECqoblSkhkLNouaZusXaE
 gH1f3J9387zw7YYNEKQ9daxmZez9EpcyGou6cwPD0pru8PViWGzMlfSjVfFIHAZQT2ntGR
 Wzu6W0krFfLEooX3bxiuF0630CCe874=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-fu1hhdsSOB-MjKeDkSs4cg-1; Thu,
 06 Mar 2025 04:36:06 -0500
X-MC-Unique: fu1hhdsSOB-MjKeDkSs4cg-1
X-Mimecast-MFC-AGG-ID: fu1hhdsSOB-MjKeDkSs4cg_1741253765
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F4AA1956083
 for <qemu-devel@nongnu.org>; Thu,  6 Mar 2025 09:36:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5579D300019E
 for <qemu-devel@nongnu.org>; Thu,  6 Mar 2025 09:36:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BD28121E66BB; Thu, 06 Mar 2025 10:36:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 03/10] qapi/introspect: Use @dataclass to simplify
Date: Thu,  6 Mar 2025 10:35:54 +0100
Message-ID: <20250306093601.2264772-4-armbru@redhat.com>
In-Reply-To: <20250306093601.2264772-1-armbru@redhat.com>
References: <20250306093601.2264772-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

A TODO comment in class Annotated reminds us to simplify it once we
can use @dataclass, new in Python 3.7.  We have that now, so do it.

There's a similar comment in scripts/qapi/source.py, but I can't
figure out how to use @dataclass there.  Left for another day.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250227080757.3978333-4-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


