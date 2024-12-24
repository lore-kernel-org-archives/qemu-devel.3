Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB69E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6eP-0008HU-KC; Tue, 24 Dec 2024 10:16:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6eD-00086n-Kd
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6eC-00046w-49
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735053395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FYAgSPx+tQZ1O5jCx7JvRgyXDxTkENCIvo38zAs5EIs=;
 b=F3yZ9OvI4yyz29/xLZ7TtM7CNW4SqYNyYUd9xYSKsoWg29CqVF5/HKrnXisoBH/8D2swkU
 IDRQUXFuzFGB4HZxyDzPfbdE0U/dVcXftp/ypCOkh/ZquIdyNaqnDmR90pYqtpLSnk6U3n
 r1ms/0ZuTLKqCFitFE3bTvczT3BJ/XM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-FZ4eh4TYP4CVMAJdRhWpfA-1; Tue,
 24 Dec 2024 10:16:31 -0500
X-MC-Unique: FZ4eh4TYP4CVMAJdRhWpfA-1
X-Mimecast-MFC-AGG-ID: FZ4eh4TYP4CVMAJdRhWpfA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61B7319560A2; Tue, 24 Dec 2024 15:16:29 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 72B443000197; Tue, 24 Dec 2024 15:16:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PULL 17/17] migration: Unexport migration_is_active()
Date: Tue, 24 Dec 2024 16:15:47 +0100
Message-ID: <20241224151547.386529-18-clg@redhat.com>
In-Reply-To: <20241224151547.386529-1-clg@redhat.com>
References: <20241224151547.386529-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Avihai Horon <avihaih@nvidia.com>

After being removed from VFIO and dirty limit, migration_is_active() no
longer has any users outside the migration subsystem, and in fact, it's
only used in migration.c.

Unexport it and also relocate it so it can be made static.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Tested-by: Joao Martins <joao.m.martins@oracle.com>
Link: https://lore.kernel.org/r/20241218134022.21264-8-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/migration/misc.h |  1 -
 migration/migration.c    | 16 ++++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index ad1e25826aebefd9f21b638a9f4be7dbc50edb95..c0e23fdac9d0c73a9b284b2e231990fb33464c03 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -53,7 +53,6 @@ void dump_vmstate_json_to_file(FILE *out_fp);
 void migration_object_init(void);
 void migration_shutdown(void);
 
-bool migration_is_active(void);
 bool migration_is_running(void);
 bool migration_thread_is_self(void);
 
diff --git a/migration/migration.c b/migration/migration.c
index 3606d1e26302e52de22185ba2438df1972dc0430..df61ca4e938457d5586caec08c27587b46631d0d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1139,6 +1139,14 @@ bool migration_is_running(void)
     }
 }
 
+static bool migration_is_active(void)
+{
+    MigrationState *s = current_migration;
+
+    return (s->state == MIGRATION_STATUS_ACTIVE ||
+            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
+}
+
 static bool migrate_show_downtime(MigrationState *s)
 {
     return (s->state == MIGRATION_STATUS_COMPLETED) || migration_in_postcopy();
@@ -1637,14 +1645,6 @@ bool migration_in_bg_snapshot(void)
     return migrate_background_snapshot() && migration_is_running();
 }
 
-bool migration_is_active(void)
-{
-    MigrationState *s = current_migration;
-
-    return (s->state == MIGRATION_STATUS_ACTIVE ||
-            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
-}
-
 bool migration_thread_is_self(void)
 {
     MigrationState *s = current_migration;
-- 
2.47.1


