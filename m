Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A1CC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXoz-0000QZ-4K; Wed, 24 Apr 2024 04:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXoc-0000MI-Py
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXoa-0006ME-AN
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713946635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E7WcKDggn/0k8j89J15HIGYRNmBWqaoKRSQCgDhMsgw=;
 b=WZcQ4KXerqyWr6R3Orfm0ppn4982nRMEAm0fUNwhKcQQS+aMpqf5WgXHrTEuPtAfIEhYFN
 tclUVFZvkqlpfLw1BZyfCHP2U7hsA6KDVXDVR6BsyIBqKC89zjd7xIb86aAzo9WlQOT9Dr
 AaEf/WJE4GVLhgBTBqVjhhk9KZy5Vp4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-t-ZTRB0iPPKLDMgF2koD3Q-1; Wed,
 24 Apr 2024 04:17:13 -0400
X-MC-Unique: t-ZTRB0iPPKLDMgF2koD3Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 635C429ABA1C;
 Wed, 24 Apr 2024 08:17:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 441011C0666A;
 Wed, 24 Apr 2024 08:17:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EC80621D49C6; Wed, 24 Apr 2024 10:17:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 14/25] qapi/schema: assert info is present when necessary
Date: Wed, 24 Apr 2024 10:16:59 +0200
Message-ID: <20240424081710.2907748-15-armbru@redhat.com>
In-Reply-To: <20240424081710.2907748-1-armbru@redhat.com>
References: <20240424081710.2907748-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

QAPISchemaInfo arguments can often be None because built-in definitions
don't have such information.  The type hint can only be
Optional[QAPISchemaInfo] then.  But, mypy gets upset about all the
places where we exploit that it can't actually be None there.  Add
assertions that will help mypy over the hump, to enable adding type
hints in a forthcoming commit.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240315152301.3621858-15-armbru@redhat.com>
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


