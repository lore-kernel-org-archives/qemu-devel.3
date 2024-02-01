Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19775C48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 22:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVfm3-0006Dt-9r; Thu, 01 Feb 2024 17:43:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVflu-00069U-9K
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 17:43:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVflp-0006aP-59
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 17:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706827375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uHv/vYuudgawFX8d3eCgkHFBI73VlOA6zxY7RrJbKII=;
 b=dQymRHK2k/ZM4pePb/Qn3ZVt6P8BnamrgAtVs4ZygJAkaiFK3aMOFC6QdKh5DZ2Gc67IdA
 7ByC3lTwCcYGVNx9J3qqFyQ/Cni/4baOgWSao4Wi5Nr9nD/IcSqS+pMiLYMX8eBUATgdd/
 A1Z2OBTpW4+EZMIXECc77WxCqt8NkzA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-Kv94m_YmNjumYsBJrhU-vQ-1; Thu, 01 Feb 2024 17:42:54 -0500
X-MC-Unique: Kv94m_YmNjumYsBJrhU-vQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9009811E81;
 Thu,  1 Feb 2024 22:42:53 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.18.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D76E2166B36;
 Thu,  1 Feb 2024 22:42:53 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v3 14/20] qapi/schema: Don't initialize "members" with `None`
Date: Thu,  1 Feb 2024 17:42:40 -0500
Message-ID: <20240201224246.39480-15-jsnow@redhat.com>
In-Reply-To: <20240201224246.39480-1-jsnow@redhat.com>
References: <20240201224246.39480-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Declare, but don't initialize the "members" field with type
List[QAPISchemaObjectTypeMember].

This simplifies the typing from what would otherwise be
Optional[List[T]] to merely List[T]. This removes the need to add
assertions to several callsites that this value is not None - which it
never will be after the delayed initialization in check() anyway.

The type declaration without initialization trick will cause accidental
uses of this field prior to full initialization to raise an
AttributeError.

(Note that it is valid to have an empty members list, see the internal
q_empty object as an example. For this reason, we cannot use the empty
list as a replacement test for full initialization and instead rely on
the _checked/_checking fields.)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index a459016e148..947e7efb1a8 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -20,7 +20,7 @@
 from collections import OrderedDict
 import os
 import re
-from typing import List, Optional
+from typing import List, Optional, cast
 
 from .common import (
     POINTER_SUFFIX,
@@ -457,7 +457,7 @@ def __init__(self, name, info, doc, ifcond, features,
         self.base = None
         self.local_members = local_members
         self.variants = variants
-        self.members = None
+        self.members: List[QAPISchemaObjectTypeMember]
         self._checking = False
 
     def check(self, schema):
@@ -474,7 +474,7 @@ def check(self, schema):
 
         self._checking = True
         super().check(schema)
-        assert self._checked and self.members is None
+        assert self._checked
 
         seen = OrderedDict()
         if self._base_name:
@@ -491,7 +491,10 @@ def check(self, schema):
         for m in self.local_members:
             m.check(schema)
             m.check_clash(self.info, seen)
-        members = seen.values()
+
+        # check_clash is abstract, but local_members is asserted to be
+        # List[QAPISchemaObjectTypeMember]. Cast to the narrower type.
+        members = cast(List[QAPISchemaObjectTypeMember], list(seen.values()))
 
         if self.variants:
             self.variants.check(schema, seen)
@@ -524,11 +527,9 @@ def is_implicit(self):
         return self.name.startswith('q_')
 
     def is_empty(self):
-        assert self.members is not None
         return not self.members and not self.variants
 
     def has_conditional_members(self):
-        assert self.members is not None
         return any(m.ifcond.is_present() for m in self.members)
 
     def c_name(self):
-- 
2.43.0


