Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16F4C4828D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 08:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWBTk-0002o5-TU; Sat, 03 Feb 2024 03:34:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWBTj-0002nm-Bw
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 03:34:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWBTg-0007I9-RO
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 03:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706949259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VovjdYc6Rk6ULtHcpGbX6C8wGB5oVnL+xYtFZYeelMs=;
 b=CiGpsfXKvUv6WJH4k5LVNWGX6MojRjDAEP9SwPpCTehOd3U+Z3t07hKGjb//M5yFvq1FYN
 IQsJCLDK3CXkWhqfDdSrn89M4c4DEqhfWNuPz7Gb8nYQ8DNQhrF+ZXRpHVR7Sqj/biFIfL
 +dpGHkq6CfDqfIIa0kVJUEbAOHW5Z2E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-gJPl_F6cODuVDD29xuPpPQ-1; Sat,
 03 Feb 2024 03:34:17 -0500
X-MC-Unique: gJPl_F6cODuVDD29xuPpPQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 429F11C05AE4;
 Sat,  3 Feb 2024 08:34:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A5832166B32;
 Sat,  3 Feb 2024 08:34:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 008EF21E66F6; Sat,  3 Feb 2024 09:34:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 3/5] qapi: Elide "Potential additional modes" from generated
 docs
Date: Sat,  3 Feb 2024 09:34:13 +0100
Message-ID: <20240203083415.2937003-4-armbru@redhat.com>
In-Reply-To: <20240203083415.2937003-1-armbru@redhat.com>
References: <20240203083415.2937003-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Documentation of BlockExportRemoveMode has

    Potential additional modes to be added in the future:

    hide: Just hide export from new clients, leave existing connections
    as is.  Remove export after all clients are disconnected.

    soft: Hide export from new clients, answer with ESHUTDOWN for all
    further requests from existing clients.

I think this is useful only for developers.  Elide it from generated
documentation by turning it into a TODO section.

This effectively reverts my own commit b71fd73cc45 (Revert "qapi:
BlockExportRemoveMode: move comments to TODO").  At the time, I was
about to elide TODO sections from the generated manual, I wasn't sure
about this one, and decided to avoid change.  And now I've made up my
mind.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240129115008.674248-4-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-export.json | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 7874a49ba7..e063e9255a 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -266,13 +266,14 @@
 #
 # @hard: Drop all connections immediately and remove export.
 #
-# Potential additional modes to be added in the future:
+# TODO: Potential additional modes to be added in the future:
 #
-# hide: Just hide export from new clients, leave existing connections
-# as is.  Remove export after all clients are disconnected.
+#     - hide: Just hide export from new clients, leave existing
+#       connections as is.  Remove export after all clients are
+#       disconnected.
 #
-# soft: Hide export from new clients, answer with ESHUTDOWN for all
-# further requests from existing clients.
+#     - soft: Hide export from new clients, answer with ESHUTDOWN for
+#       all further requests from existing clients.
 #
 # Since: 2.12
 ##
-- 
2.43.0


