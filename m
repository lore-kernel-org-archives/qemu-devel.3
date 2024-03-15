Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC90C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 15:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl9P4-0007jM-Kv; Fri, 15 Mar 2024 11:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl9P2-0007iG-Fd
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:23:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl9Or-00021m-0S
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710516192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6xVSq5O+P87ENu9pd/RyR7CQQoVGb9o3CHPxEY2XFK4=;
 b=I2Xfdea1t857MoNv1bNIh7hiN7+Nnjty/HAPz4c7KK2Yhzx0yAo70Ne7JFYpbkBVSLeWdK
 x88Oo0/4IU2Po9NKnOzKZZ1g8Dwdp9nsrK+QgST8dh0kysqczHxLn1t0XOVqReB2haWLMq
 P2vdX7MK0uJdz8i1qvWEEay/nMY7hLs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-HTtNzD58P2G6tg2WHSZBdw-1; Fri, 15 Mar 2024 11:23:04 -0400
X-MC-Unique: HTtNzD58P2G6tg2WHSZBdw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2768E857F48;
 Fri, 15 Mar 2024 15:23:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 070E61C060A4;
 Fri, 15 Mar 2024 15:23:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E926721E68B2; Fri, 15 Mar 2024 16:23:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	peter.maydell@linaro.org,
	michael.roth@amd.com
Subject: [PATCH v5 08/25] qapi/schema: make c_type() and json_type() abstract
 methods
Date: Fri, 15 Mar 2024 16:22:44 +0100
Message-ID: <20240315152301.3621858-9-armbru@redhat.com>
In-Reply-To: <20240315152301.3621858-1-armbru@redhat.com>
References: <20240315152301.3621858-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

These methods should always return a str, it's only the default abstract
implementation that doesn't. They can be marked "abstract", which
requires subclasses to override the method with the proper return type.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/schema.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 48f157fb91..0b01c841ff 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -16,6 +16,7 @@
 
 # TODO catching name collisions in generated code would be nice
 
+from abc import ABC, abstractmethod
 from collections import OrderedDict
 import os
 import re
@@ -245,9 +246,10 @@ def visit(self, visitor):
         visitor.visit_include(self._sub_module.name, self.info)
 
 
-class QAPISchemaType(QAPISchemaDefinition):
+class QAPISchemaType(QAPISchemaDefinition, ABC):
     # Return the C type for common use.
     # For the types we commonly box, this is a pointer type.
+    @abstractmethod
     def c_type(self):
         pass
 
@@ -259,6 +261,7 @@ def c_param_type(self):
     def c_unboxed_type(self):
         return self.c_type()
 
+    @abstractmethod
     def json_type(self):
         pass
 
-- 
2.44.0


