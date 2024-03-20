Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B89C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 06:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmpm5-0002K8-G5; Wed, 20 Mar 2024 02:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmpm3-0002Jh-Tp
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmpm1-0001jZ-TF
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710917404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GhGr45ifqxAAcQ1huvBMnwKbLLqkgp/CDAZ8qDfZVvY=;
 b=N/A31dasmSq/4P60NH+XyG2+71Pv8e8X5L872Pw3VUz97+xqVO1LYkjL+/LGrA4k523ZC0
 YWUgk5++YMyYi22iB/wXbjGK1qqBhizjY4VQke6yVz+AF6JQ1vSq9czkQTrWhIL7Q1kjRY
 74L+5Pm1QitsHzuPKBcmIjtIvLCqzVM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-bIc-wSzENPaRdq5_ieNe6Q-1; Wed, 20 Mar 2024 02:50:02 -0400
X-MC-Unique: bIc-wSzENPaRdq5_ieNe6Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B356B855313;
 Wed, 20 Mar 2024 06:50:01 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B90571C060A6;
 Wed, 20 Mar 2024 06:49:59 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-9.1 v5 12/14] migration: Add Error** argument to
 ram_state_init()
Date: Wed, 20 Mar 2024 07:49:08 +0100
Message-ID: <20240320064911.545001-13-clg@redhat.com>
In-Reply-To: <20240320064911.545001-1-clg@redhat.com>
References: <20240320064911.545001-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

Since the return value not exploited, follow the recommendations of
qapi/error.h and change it to a bool

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/ram.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index bade3e9281ae839578033524b800dcf3c6f486dc..26ce11a3379056d38062c1fb63166c6e3155bd8c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2780,13 +2780,13 @@ err_out:
     return -ENOMEM;
 }
 
-static int ram_state_init(RAMState **rsp)
+static bool ram_state_init(RAMState **rsp, Error **errp)
 {
     *rsp = g_try_new0(RAMState, 1);
 
     if (!*rsp) {
-        error_report("%s: Init ramstate fail", __func__);
-        return -1;
+        error_setg(errp, "%s: Init ramstate fail", __func__);
+        return false;
     }
 
     qemu_mutex_init(&(*rsp)->bitmap_mutex);
@@ -2802,7 +2802,7 @@ static int ram_state_init(RAMState **rsp)
     (*rsp)->migration_dirty_pages = (*rsp)->ram_bytes_total >> TARGET_PAGE_BITS;
     ram_state_reset(*rsp);
 
-    return 0;
+    return true;
 }
 
 static void ram_list_init_bitmaps(void)
@@ -2897,7 +2897,10 @@ out_unlock:
 
 static int ram_init_all(RAMState **rsp)
 {
-    if (ram_state_init(rsp)) {
+    Error *local_err = NULL;
+
+    if (!ram_state_init(rsp, &local_err)) {
+        error_report_err(local_err);
         return -1;
     }
 
@@ -3624,7 +3627,11 @@ void ram_handle_zero(void *host, uint64_t size)
 
 static void colo_init_ram_state(void)
 {
-    ram_state_init(&ram_state);
+    Error *local_err = NULL;
+
+    if (!ram_state_init(&ram_state, &local_err)) {
+        error_report_err(local_err);
+    }
 }
 
 /*
-- 
2.44.0


