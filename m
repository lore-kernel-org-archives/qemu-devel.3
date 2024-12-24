Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E173E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6eJ-00086m-Nm; Tue, 24 Dec 2024 10:16:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6e8-0007m0-10
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6e6-000465-CM
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735053389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2/MYYc8uXpt3vIczKYOlrLw1dmBQ3Jvm2ONQ2d5igds=;
 b=NtL+fft8YpX3GaV7/+hW6fWVRTCykr/PhcEfQNZoINn9CI7tyxh4ygwe3iJU8FKdZshuyK
 C6lkAPqGrSE12IQNVy1rrYwMFTHA2vPtCM1k+60QQaFKWvhDIBnZofRsaxTkdyzXzzlzBb
 0QzSpyaSsXb9VapLE/NrBn3Rw9kGfCQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-jBGnjJTWOAO-tBu-K_nx3A-1; Tue,
 24 Dec 2024 10:16:28 -0500
X-MC-Unique: jBGnjJTWOAO-tBu-K_nx3A-1
X-Mimecast-MFC-AGG-ID: jBGnjJTWOAO-tBu-K_nx3A
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D9F719560B1; Tue, 24 Dec 2024 15:16:27 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8BE6E3000197; Tue, 24 Dec 2024 15:16:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PULL 16/17] migration: Drop migration_is_device()
Date: Tue, 24 Dec 2024 16:15:46 +0100
Message-ID: <20241224151547.386529-17-clg@redhat.com>
In-Reply-To: <20241224151547.386529-1-clg@redhat.com>
References: <20241224151547.386529-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Avihai Horon <avihaih@nvidia.com>

After being removed from VFIO, migration_is_device() no longer has any
users. Drop it.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Tested-by: Joao Martins <joao.m.martins@oracle.com>
Link: https://lore.kernel.org/r/20241218134022.21264-7-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/migration/misc.h | 1 -
 migration/migration.c    | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 804eb23c06077bdbf1ad9873b5efa5d7770043e8..ad1e25826aebefd9f21b638a9f4be7dbc50edb95 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -54,7 +54,6 @@ void migration_object_init(void);
 void migration_shutdown(void);
 
 bool migration_is_active(void);
-bool migration_is_device(void);
 bool migration_is_running(void);
 bool migration_thread_is_self(void);
 
diff --git a/migration/migration.c b/migration/migration.c
index 056a90daafe70325934a83ce14e9e9ad02f9d30a..3606d1e26302e52de22185ba2438df1972dc0430 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1645,13 +1645,6 @@ bool migration_is_active(void)
             s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
 }
 
-bool migration_is_device(void)
-{
-    MigrationState *s = current_migration;
-
-    return s->state == MIGRATION_STATUS_DEVICE;
-}
-
 bool migration_thread_is_self(void)
 {
     MigrationState *s = current_migration;
-- 
2.47.1


