Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E62C54E55
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 11:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1revo6-0008Vo-CQ; Tue, 27 Feb 2024 06:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1revo4-0008Uv-Ik
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:39:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1revnz-0005U9-OT
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709033966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wgq5a0s/a7hkcbApiEJx5CPQu9e/pbtW3qPLD2zwL2s=;
 b=a9ls5ohD5ZaFIKajQ3fhGTqPBz2vkl2q05wjhTTdUCWGGj6KHX3CrXOWsDPGdc/llTzxzc
 Jb7bjZtvLxVJRiCPMrnWlKaFwplHRgnH9dkXayEVpm4P2F+If/DRTHXD4zHS9HljZbkkLN
 quUcnQWRs2PMJe6vr2P2kH9dKjm24Xo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-1qIQzdEcMduozLv9LVFcnw-1; Tue,
 27 Feb 2024 06:39:22 -0500
X-MC-Unique: 1qIQzdEcMduozLv9LVFcnw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 656993C02757;
 Tue, 27 Feb 2024 11:39:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41E832166B33;
 Tue, 27 Feb 2024 11:39:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2DD6B21E6682; Tue, 27 Feb 2024 12:39:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, jsnow@redhat.com, eblake@redhat.com,
 kkostiuk@redhat.com
Subject: [PATCH 02/13] qapi: Slightly clearer error message for invalid
 "Returns" section
Date: Tue, 27 Feb 2024 12:39:10 +0100
Message-ID: <20240227113921.236097-3-armbru@redhat.com>
In-Reply-To: <20240227113921.236097-1-armbru@redhat.com>
References: <20240227113921.236097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
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

Change "'Returns:' is only valid for commands" to "'Returns' section
is only valid for commands".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/parser.py                   | 5 +++--
 tests/qapi-schema/doc-invalid-return.err | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index bfc47cf3cb..e4c2259e39 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -716,8 +716,9 @@ def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
 
     def check_expr(self, expr: QAPIExpression) -> None:
         if self.returns and 'command' not in expr:
-            raise QAPISemError(self.returns.info,
-                               "'Returns:' is only valid for commands")
+            raise QAPISemError(
+                self.returns.info,
+                "'Returns' section is only valid for commands")
 
     def check(self) -> None:
 
diff --git a/tests/qapi-schema/doc-invalid-return.err b/tests/qapi-schema/doc-invalid-return.err
index 3d9e71c2b3..aafd57b135 100644
--- a/tests/qapi-schema/doc-invalid-return.err
+++ b/tests/qapi-schema/doc-invalid-return.err
@@ -1 +1 @@
-doc-invalid-return.json:6: 'Returns:' is only valid for commands
+doc-invalid-return.json:6: 'Returns' section is only valid for commands
-- 
2.43.0


