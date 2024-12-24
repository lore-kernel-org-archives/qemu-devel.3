Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6381E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6eX-0008Mp-PR; Tue, 24 Dec 2024 10:16:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6e9-0007ux-Dk
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6e8-00046F-0R
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735053390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=egtClDkN06NWpvA3BUK2Um5Rud+el5tyQBVjbzMUUQk=;
 b=bXDaFlkv+szKRT85jLF4ZEFWp2JiULVp+rP03puJXBqYfgjs9WEbSGlxhywtF7Xxu+D5wh
 /0jMRL0sy804IYzxqN0eT05PgFbDqC7InmXR4sjuKe0yksabQ8nt5/8DqkVm0cVKh504cg
 E2ddIuNJSkxsNR096pqRp1VS4Ba9LHk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-BAr2eX90PSegq2bsuRcr_A-1; Tue,
 24 Dec 2024 10:16:26 -0500
X-MC-Unique: BAr2eX90PSegq2bsuRcr_A-1
X-Mimecast-MFC-AGG-ID: BAr2eX90PSegq2bsuRcr_A
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2510E1956048; Tue, 24 Dec 2024 15:16:24 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C7EC03000197; Tue, 24 Dec 2024 15:16:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Hyman Huang <yong.huang@smartx.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 15/17] system/dirtylimit: Don't use migration_is_active()
Date: Tue, 24 Dec 2024 16:15:45 +0100
Message-ID: <20241224151547.386529-16-clg@redhat.com>
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

vcpu_dirty_rate_stat_collect() uses migration_is_active() to detect
whether migration is running or not, in order to get the correct dirty
rate period value.

However, recently there has been an effort to simplify the migration
status API and reduce it to a single migration_is_running() function.

To accommodate this, and since the same functionality can be achieved
with migration_is_running(), use it instead of migration_is_active().

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Hyman Huang <yong.huang@smartx.com>
Tested-by: Joao Martins <joao.m.martins@oracle.com>
Link: https://lore.kernel.org/r/20241218134022.21264-6-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 system/dirtylimit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index d94b994bd81bd44b95f120a53ce83b6809e60297..7c071248bbf92389977dab8b7d4808c9f57af630 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -80,8 +80,7 @@ static void vcpu_dirty_rate_stat_collect(void)
     int i = 0;
     int64_t period = DIRTYLIMIT_CALC_TIME_MS;
 
-    if (migrate_dirty_limit() &&
-        migration_is_active()) {
+    if (migrate_dirty_limit() && migration_is_running()) {
         period = migrate_vcpu_dirty_limit_period();
     }
 
-- 
2.47.1


