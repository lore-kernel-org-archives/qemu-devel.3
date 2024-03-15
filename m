Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434DDC54E68
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 15:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl9Oy-0007do-9L; Fri, 15 Mar 2024 11:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl9Ow-0007TA-4X
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:23:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl9Oo-00020j-Q6
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710516190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jJUFXcmxVIK5MLu1RBih63dA9fz0z7rhjR0l0oG+UBI=;
 b=cMnWfy/9A4JMof+EeQVvYetR86oGwZjNkGpde1xRcwYUeHYQ4zNMO5hwfpdYSulGzxYXp9
 0PzigmI37uNCjFTOuvm9qaMcBHJY0alfNMbH33cYj+L5f5Q7Zmv4yhoPKwuppjFOlr5q7Y
 FAMeNaAVyNHxe0IRTbUERD3iGwotJmE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-TqOHXqJPMZavytJISSrRGg-1; Fri,
 15 Mar 2024 11:23:06 -0400
X-MC-Unique: TqOHXqJPMZavytJISSrRGg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75B103803538;
 Fri, 15 Mar 2024 15:23:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5567D17A90;
 Fri, 15 Mar 2024 15:23:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 06CEB21E682A; Fri, 15 Mar 2024 16:23:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	peter.maydell@linaro.org,
	michael.roth@amd.com
Subject: [PATCH v5 14/25] qapi/schema: assert info is present when necessary
Date: Fri, 15 Mar 2024 16:22:50 +0100
Message-ID: <20240315152301.3621858-15-armbru@redhat.com>
In-Reply-To: <20240315152301.3621858-1-armbru@redhat.com>
References: <20240315152301.3621858-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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

QAPISchemaInfo arguments can often be None because built-in definitions
don't have such information.  The type hint can only be
Optional[QAPISchemaInfo] then.  But, mypy gets upset about all the
places where we exploit that it can't actually be None there.  Add
assertions that will help mypy over the hump, to enable adding type
hints in a forthcoming commit.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/schema.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 087c6e9366..173e27d9e2 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -751,6 +751,7 @@ def describe(self, info):
             else:
                 assert False
 
+        assert info is not None
         if defined_in != info.defn_name:
             return "%s '%s' of %s '%s'" % (role, self.name, meta, defined_in)
         return "%s '%s'" % (role, self.name)
@@ -841,6 +842,7 @@ def __init__(self, name, info, doc, ifcond, features,
         self.coroutine = coroutine
 
     def check(self, schema):
+        assert self.info is not None
         super().check(schema)
         if self._arg_type_name:
             arg_type = schema.resolve_type(
-- 
2.44.0


