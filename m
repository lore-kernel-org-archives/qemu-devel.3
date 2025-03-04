Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD511C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaPF-0002Ay-Pz; Tue, 04 Mar 2025 17:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaP1-0001hF-LN
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:06:16 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaOz-0001AE-69
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:06:15 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaOv-00000000LYz-1Odh; Tue, 04 Mar 2025 23:06:09 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 16/36] migration/multifd: Add
 multifd_device_state_supported()
Date: Tue,  4 Mar 2025 23:03:43 +0100
Message-ID: <1ff0d98b85f470e5a33687406e877583b8fab74e.1741124640.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741124640.git.maciej.szmigiero@oracle.com>
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Since device state transfer via multifd channels requires multifd
channels with packets and is currently not compatible with multifd
compression add an appropriate query function so device can learn
whether it can actually make use of it.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/migration/misc.h         | 1 +
 migration/multifd-device-state.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index bd3b725fa0b7..273ebfca6256 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -121,5 +121,6 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
 /* migration/multifd-device-state.c */
 bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
                                 char *data, size_t len);
+bool multifd_device_state_supported(void);
 
 #endif
diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
index 64d8ca180167..3097ffa31025 100644
--- a/migration/multifd-device-state.c
+++ b/migration/multifd-device-state.c
@@ -13,6 +13,7 @@
 #include "qemu/lockable.h"
 #include "migration/misc.h"
 #include "multifd.h"
+#include "options.h"
 
 static struct {
     QemuMutex queue_job_mutex;
@@ -111,3 +112,9 @@ bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
 
     return true;
 }
+
+bool multifd_device_state_supported(void)
+{
+    return migrate_multifd() && !migrate_mapped_ram() &&
+        migrate_multifd_compression() == MULTIFD_COMPRESSION_NONE;
+}

