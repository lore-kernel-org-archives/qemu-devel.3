Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27255C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 12:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD0NP-00005V-0V; Thu, 08 May 2025 08:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uD0NE-0008Uz-45
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:29:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uD0NC-0002zY-3g
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746707347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T/fMKLzDqk7k0/dxS2NZktfXwY2AOt9xTn21/ms5mwc=;
 b=a5xK7Tsum6oHlZVJpD+5gUsVfzwygug4+wKBocWRiZGcnjaeeimBKfsUM4BtcGHN/iQ8AH
 vy6weaxnBknhWxrRxpjCNG1LfHqX4Ely2efp3V/GTzrGuO9r0IoZo1UO4ZpP2J1t4EYpDa
 fC+rOf8Qx0Hqds47hU4XTFqSFMqAzwI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-pXMmY2mJM6G4fs69lqudAA-1; Thu,
 08 May 2025 08:29:05 -0400
X-MC-Unique: pXMmY2mJM6G4fs69lqudAA-1
X-Mimecast-MFC-AGG-ID: pXMmY2mJM6G4fs69lqudAA_1746707344
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0739180034A; Thu,  8 May 2025 12:29:04 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.64.196])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2667B18003FD; Thu,  8 May 2025 12:29:00 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v10 1/3] migration: enable multifd and postcopy together
Date: Thu,  8 May 2025 17:58:47 +0530
Message-ID: <20250508122849.207213-2-ppandit@redhat.com>
In-Reply-To: <20250508122849.207213-1-ppandit@redhat.com>
References: <20250508122849.207213-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

Enable Multifd and Postcopy migration together.
The migration_ioc_process_incoming() routine checks
magic value sent on each channel and helps to properly
setup multifd and postcopy channels.

The Precopy and Multifd threads work during the initial
guest RAM transfer. When migration moves to the Postcopy
phase, the multifd threads cease to send data on multifd
channels and Postcopy threads on the destination
request/pull data from the source side.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 migration/multifd-nocomp.c | 3 ++-
 migration/multifd.c        | 7 +++++++
 migration/options.c        | 5 -----
 migration/ram.c            | 5 ++---
 4 files changed, 11 insertions(+), 9 deletions(-)

v10: no change

v9:
- https://lore.kernel.org/qemu-devel/20250411114534.3370816-6-ppandit@redhat.com/

diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 88fe0f99f2..b48eae3d86 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -17,6 +17,7 @@
 #include "migration-stats.h"
 #include "multifd.h"
 #include "options.h"
+#include "migration.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
@@ -398,7 +399,7 @@ int multifd_ram_flush_and_sync(QEMUFile *f)
     MultiFDSyncReq req;
     int ret;
 
-    if (!migrate_multifd()) {
+    if (!migrate_multifd() || migration_in_postcopy()) {
         return 0;
     }
 
diff --git a/migration/multifd.c b/migration/multifd.c
index ec108af624..f18b166bcf 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1379,6 +1379,13 @@ static void *multifd_recv_thread(void *opaque)
         }
 
         if (has_data) {
+            /*
+             * multifd thread should not be active and receive data
+             * when migration is in the Postcopy phase. Two threads
+             * writing the same memory area could easily corrupt
+             * the guest state.
+             */
+            assert(!migration_in_postcopy());
             if (is_device_state) {
                 assert(use_packets);
                 ret = multifd_device_state_recv(p, &local_err);
diff --git a/migration/options.c b/migration/options.c
index b6ae95358d..3fcd577cd7 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -509,11 +509,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
             error_setg(errp, "Postcopy is not compatible with ignore-shared");
             return false;
         }
-
-        if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
-            error_setg(errp, "Postcopy is not yet compatible with multifd");
-            return false;
-        }
     }
 
     if (new_caps[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
diff --git a/migration/ram.c b/migration/ram.c
index e12913b43e..d26dbd37c4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1993,9 +1993,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
         }
     }
 
-    if (migrate_multifd()) {
-        RAMBlock *block = pss->block;
-        return ram_save_multifd_page(block, offset);
+    if (migrate_multifd() && !migration_in_postcopy()) {
+        return ram_save_multifd_page(pss->block, offset);
     }
 
     return ram_save_page(rs, pss);
--
2.49.0


