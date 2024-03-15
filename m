Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F873C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 15:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl9P4-0007ig-6p; Fri, 15 Mar 2024 11:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl9Oz-0007eP-An
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl9Oq-00021X-Bn
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710516191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LZgZgYfHTFdicpTgNsXXKGTnpGjPlk1Db3JCkh8LiHc=;
 b=D44LNbwRh/k4YRYnimFOCeDwc78VqHBIsKBsAnXmFo/eGsuYHrtd/TfhJFm5bqGwb2YsMF
 XWfQhpuQxkJJJEQ9DcVo1jnuyileaR2hU1uz8Qw7qPjSfWMFZ8qvZA+0KW6EjLGW+UW/H6
 YZkxOt8dLzhw5c7pdkKVj1AuybT3Nzs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-NGBzLZxuNSS_k_fF07X5BQ-1; Fri, 15 Mar 2024 11:23:07 -0400
X-MC-Unique: NGBzLZxuNSS_k_fF07X5BQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 327758007B8;
 Fri, 15 Mar 2024 15:23:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 123391121306;
 Fri, 15 Mar 2024 15:23:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 128F721E682E; Fri, 15 Mar 2024 16:23:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	peter.maydell@linaro.org,
	michael.roth@amd.com
Subject: [PATCH v5 18/25] qapi/schema: assert inner type of QAPISchemaVariants
 in check_clash()
Date: Fri, 15 Mar 2024 16:22:54 +0100
Message-ID: <20240315152301.3621858-19-armbru@redhat.com>
In-Reply-To: <20240315152301.3621858-1-armbru@redhat.com>
References: <20240315152301.3621858-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

QAPISchemaVariant's "variants" field is typed as
List[QAPISchemaVariant], where the typing for QAPISchemaVariant allows
its type field to be any QAPISchemaType.

However, QAPISchemaVariant expects that all of its variants contain the
narrower QAPISchemaObjectType. This relationship is enforced at runtime
in QAPISchemaVariants.check(). This relationship is not embedded in the
type system though, so QAPISchemaVariants.check_clash() needs to
re-assert this property in order to call
QAPISchemaVariant.type.check_clash().

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/schema.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 9c138badb0..177bfa0d11 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -716,7 +716,10 @@ def check(self, schema, seen):
     def check_clash(self, info, seen):
         for v in self.variants:
             # Reset seen map for each variant, since qapi names from one
-            # branch do not affect another branch
+            # branch do not affect another branch.
+            #
+            # v.type's typing is enforced in check() above.
+            assert isinstance(v.type, QAPISchemaObjectType)
             v.type.check_clash(info, dict(seen))
 
 
-- 
2.44.0


