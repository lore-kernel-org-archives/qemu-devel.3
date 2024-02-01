Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D4CC48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 22:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVfm3-0006Dw-Ey; Thu, 01 Feb 2024 17:43:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVflx-0006Bz-2Q
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 17:43:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVflr-0006aL-J2
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 17:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706827374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VO6Tg5Bm7WbLg6VzQBIxawZaW/wjLRsVQZdk4LDa/CY=;
 b=RqghsHFMQ1YCLxwexYZJqfOFa3/aVuqfRZFNrMDUnjkvT8yb9K5rh/NHyOFrUrV+SAQ0Y/
 6lytl3UFwkoPGFUqp+dDswsx3P/U1+C918H7d2YNOvGkZO4jwASeLwb3dLgr4N9iIDbFFz
 3KIJI9CZJS4h7ogSImcQkYI4wex6uwE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-W6gyoZvFMlexXHbjCr-rgw-1; Thu, 01 Feb 2024 17:42:52 -0500
X-MC-Unique: W6gyoZvFMlexXHbjCr-rgw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CF6D85A589;
 Thu,  1 Feb 2024 22:42:52 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.18.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D555B2166B33;
 Thu,  1 Feb 2024 22:42:51 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v3 06/20] qapi/schema: make c_type() and json_type() abstract
 methods
Date: Thu,  1 Feb 2024 17:42:32 -0500
Message-ID: <20240201224246.39480-7-jsnow@redhat.com>
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

These methods should always return a str, it's only the default abstract
implementation that doesn't. They can be marked "abstract", which
requires subclasses to override the method with the proper return type.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index ac34e2781de..8abcd4a86cb 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -16,6 +16,7 @@
 
 # TODO catching name collisions in generated code would be nice
 
+from abc import ABC, abstractmethod
 from collections import OrderedDict
 import os
 import re
@@ -253,9 +254,10 @@ def visit(self, visitor):
         visitor.visit_include(self._sub_module.name, self.info)
 
 
-class QAPISchemaType(QAPISchemaDefinition):
+class QAPISchemaType(QAPISchemaDefinition, ABC):
     # Return the C type for common use.
     # For the types we commonly box, this is a pointer type.
+    @abstractmethod
     def c_type(self):
         pass
 
@@ -267,6 +269,7 @@ def c_param_type(self):
     def c_unboxed_type(self):
         return self.c_type()
 
+    @abstractmethod
     def json_type(self):
         pass
 
-- 
2.43.0


