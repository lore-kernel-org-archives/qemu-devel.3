Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5DDCD11DB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 13:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnfIw-0004xb-MQ; Fri, 22 Mar 2024 09:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfIv-0004xC-Lg
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 09:51:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfIt-0007jr-Ff
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 09:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711115485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s5uFyJj88LH3XB379jOyXeNAkkMRvMK3gINRMWY9JjU=;
 b=K9JKuhcnOHyoe/A3r+VHKVCPdrsp+pGCJIGYf3O25nvedAAiGMe2o4MaJliSFcpDd4GGMM
 DJoaJC0xXCMiO0sPqak4M9eGye/wHXa8u0bE/tvPWY3fz7mOjIhV7LTjPr0wMY2OMXmGyM
 e9hLTzGeyctbjzMRn4XrmgBcXCdu6ck=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-fI6IvNJfOFCwv0qhF_Xyng-1; Fri, 22 Mar 2024 09:51:22 -0400
X-MC-Unique: fI6IvNJfOFCwv0qhF_Xyng-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E4EF85CBAB;
 Fri, 22 Mar 2024 13:51:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D9DA111E40D;
 Fri, 22 Mar 2024 13:51:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 173C421E5D29; Fri, 22 Mar 2024 14:51:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, berrange@redhat.com,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 3/3] qapi: Fix bogus documentation of query-migrationthreads
Date: Fri, 22 Mar 2024 14:51:17 +0100
Message-ID: <20240322135117.195489-4-armbru@redhat.com>
In-Reply-To: <20240322135117.195489-1-armbru@redhat.com>
References: <20240322135117.195489-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
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

The doc comment documents an argument that doesn't exist.  Would
fail compilation if it was marked up correctly.  Delete.

The Returns: section fails to refer to the data type, leaving the user
to guess.  Fix that.

The command name violates QAPI naming rules: it should be
query-migration-threads.  Too late to fix.

Reported-by: John Snow <jsnow@redhat.com>
Fixes: 671326201dac (migration: Introduce interface query-migrationthreads)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/migration.json | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index f6238b6980..e47ad7a63b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -2419,9 +2419,7 @@
 #
 # Returns information of migration threads
 #
-# data: migration thread name
-#
-# Returns: information about migration threads
+# Returns: @MigrationThreadInfo
 #
 # Since: 7.2
 ##
-- 
2.44.0


