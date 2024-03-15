Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A962C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 15:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl9Ox-0007Yj-AR; Fri, 15 Mar 2024 11:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl9Ou-0007Ix-Od
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:23:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl9On-0001zn-SW
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710516189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tkFNeRvG3W35JOHEfrTqWwO2xhqjt542rM3ljgsYWpk=;
 b=UyCUk+B/jDo6uJSGIuPxPgz4f6+gEGDsiG7bGZPTnlRJItu1IAY/8VXSo3gN3KiQZzIn3v
 xc34uh+gK4W7NrSWJFl43ZBCilDSzAS0m0jN51BurgHqQURbI7ZfdAYWqkTwOR7zFyyZlf
 yiqZeu3jnplR2uZ6a+bJUh8d4S7c8wc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-ezUi8ZrcMQyT3QllBsve6Q-1; Fri,
 15 Mar 2024 11:23:05 -0400
X-MC-Unique: ezUi8ZrcMQyT3QllBsve6Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FAA428EC122;
 Fri, 15 Mar 2024 15:23:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E11140C6DB3;
 Fri, 15 Mar 2024 15:23:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0CD4021E682C; Fri, 15 Mar 2024 16:23:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	peter.maydell@linaro.org,
	michael.roth@amd.com
Subject: [PATCH v5 16/25] qapi/schema: Don't initialize "members" with `None`
Date: Fri, 15 Mar 2024 16:22:52 +0100
Message-ID: <20240315152301.3621858-17-armbru@redhat.com>
In-Reply-To: <20240315152301.3621858-1-armbru@redhat.com>
References: <20240315152301.3621858-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: John Snow <jsnow@redhat.com>

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
the _checked/_check_complete fields.)

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/schema.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 2c3de72ae6..74b0d7b007 100644
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
@@ -449,7 +449,7 @@ def __init__(self, name, info, doc, ifcond, features,
         self.base = None
         self.local_members = local_members
         self.variants = variants
-        self.members = None
+        self.members: List[QAPISchemaObjectTypeMember]
         self._check_complete = False
 
     def check(self, schema):
@@ -482,7 +482,11 @@ def check(self, schema):
         for m in self.local_members:
             m.check(schema)
             m.check_clash(self.info, seen)
-        members = seen.values()
+
+        # self.check_clash() works in terms of the supertype, but
+        # self.members is declared List[QAPISchemaObjectTypeMember].
+        # Cast down to the subtype.
+        members = cast(List[QAPISchemaObjectTypeMember], list(seen.values()))
 
         if self.variants:
             self.variants.check(schema, seen)
@@ -515,11 +519,9 @@ def is_implicit(self):
         return self.name.startswith('q_')
 
     def is_empty(self):
-        assert self.members is not None
         return not self.members and not self.variants
 
     def has_conditional_members(self):
-        assert self.members is not None
         return any(m.ifcond.is_present() for m in self.members)
 
     def c_name(self):
-- 
2.44.0


