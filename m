Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29958C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 15:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl9PD-0007sZ-L0; Fri, 15 Mar 2024 11:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl9PC-0007s2-8s
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:23:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl9P9-00026g-NH
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710516210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XUbETe0HpQ0ytMGrfpXOdJAYxPuTEstiv/nvtKZ5VoY=;
 b=EJEiVDQrLYBOkaBUwMjpkkIcIWJ1YBiO1IRECu0AqokUbekHNzbBstTA1G4P1gxTyE4PKR
 //CJSyNQ+W1yrPrVU2mhu8H4vetGeu9f/fxBKFX+68nyxdW4rq6T85/0mbMmU6Lm0/WkXW
 ar8eaIv6IzPz/xtMuAI6wG/X+3S1gJw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-BRVrsVTFO-2dEyPEnM4jvg-1; Fri,
 15 Mar 2024 11:23:04 -0400
X-MC-Unique: BRVrsVTFO-2dEyPEnM4jvg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5610D3803532;
 Fri, 15 Mar 2024 15:23:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 03E41492BC6;
 Fri, 15 Mar 2024 15:23:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E617D21E6891; Fri, 15 Mar 2024 16:23:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	peter.maydell@linaro.org,
	michael.roth@amd.com
Subject: [PATCH v5 07/25] qapi/schema: declare type for
 QAPISchemaArrayType.element_type
Date: Fri, 15 Mar 2024 16:22:43 +0100
Message-ID: <20240315152301.3621858-8-armbru@redhat.com>
In-Reply-To: <20240315152301.3621858-1-armbru@redhat.com>
References: <20240315152301.3621858-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

A QAPISchemaArrayType's element type gets resolved only during .check().
We have QAPISchemaArrayType.__init__() initialize self.element_type =
None, and .check() assign the actual type.  Using .element_type before
.check() is wrong, and hopefully crashes due to the value being None.
Works.

However, it makes for awkward typing.  With .element_type:
Optional[QAPISchemaType], mypy is of course unable to see that it's None
before .check(), and a QAPISchemaType after.  To help it over the hump,
we'd have to assert self.element_type is not None before all the (valid)
uses.  The assertion catches invalid uses, but only at run time; mypy
can't flag them.

Instead, declare .element_type in .__init__() as QAPISchemaType
*without* initializing it.  Using .element_type before .check() now
certainly crashes, which is an improvement.  Mypy still can't flag
invalid uses, but that's okay.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/schema.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 307f8af01a..48f157fb91 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -381,7 +381,7 @@ def __init__(self, name, info, element_type):
         super().__init__(name, info, None)
         assert isinstance(element_type, str)
         self._element_type_name = element_type
-        self.element_type = None
+        self.element_type: QAPISchemaType
 
     def need_has_if_optional(self):
         # When FOO is an array, we still need has_FOO to distinguish
-- 
2.44.0


