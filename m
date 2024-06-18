Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08441C2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbTC-0005dF-3W; Tue, 18 Jun 2024 12:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sJbT2-0005K8-Ey
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:13:58 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sJbT0-0000vK-Sh
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:13:55 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sJbSm-0001dZ-Qi; Tue, 18 Jun 2024 18:13:40 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v1 10/13] migration/multifd: Add
 migration_has_device_state_support()
Date: Tue, 18 Jun 2024 18:12:28 +0200
Message-ID: <2dd6ec214193ecc7b1aba9e5f9655aeb9b213f28.1718717584.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1718717584.git.maciej.szmigiero@oracle.com>
References: <cover.1718717584.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Since device state transfer via multifd channels requires multifd
channels with packets and is currently not compatible with multifd
compression add an appropriate query function so device can learn
whether it can actually make use of it.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/migration/misc.h | 1 +
 migration/multifd.c      | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index abf6f33eeae8..4f3de2f23819 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -112,6 +112,7 @@ bool migration_in_bg_snapshot(void);
 void dirty_bitmap_mig_init(void);
 
 /* migration/multifd.c */
+bool migration_has_device_state_support(void);
 int multifd_queue_device_state(char *idstr, uint32_t instance_id,
                                char *data, size_t len);
 
diff --git a/migration/multifd.c b/migration/multifd.c
index 6a7e5d659925..e5f7021465ec 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -804,6 +804,12 @@ retry:
     return true;
 }
 
+bool migration_has_device_state_support(void)
+{
+    return migrate_multifd() && !migrate_mapped_ram() &&
+        migrate_multifd_compression() == MULTIFD_COMPRESSION_NONE;
+}
+
 int multifd_queue_device_state(char *idstr, uint32_t instance_id,
                                char *data, size_t len)
 {

