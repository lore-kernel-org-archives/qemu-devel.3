Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E02C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 11:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Cps-0007F1-VQ; Fri, 11 Apr 2025 07:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u3Cpr-0007EZ-HK
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 07:46:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u3Cpn-0001VU-RN
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 07:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744371971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlCvESS8pRnIOQv9fXY5YAVWtJu1Ad2Rrf1r34K2cgk=;
 b=D5lqWrrhPF318DMIkKkF22WTk9bFcpxKdo1i43fCWxIaTz7oZWqp8O6T5q9QNhusz9ibTA
 f0mqliEQ43fxSXQyhHwt1gZUj5noHQRCva6m5Mh5m8abhBQ2WwE19oNHjMf8Bb6vep4Gr9
 DC/yTbv5r4jsl+kfZEi/km2I2DFH8cM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-cTTRKXmvOqOCX9WTKk3dag-1; Fri,
 11 Apr 2025 07:46:09 -0400
X-MC-Unique: cTTRKXmvOqOCX9WTKk3dag-1
X-Mimecast-MFC-AGG-ID: cTTRKXmvOqOCX9WTKk3dag_1744371968
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26C72180025F; Fri, 11 Apr 2025 11:46:08 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.160])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C48B18009BC; Fri, 11 Apr 2025 11:46:02 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, peterx@redhat.com, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v9 5/7] migration: enable multifd and postcopy together
Date: Fri, 11 Apr 2025 17:15:32 +0530
Message-ID: <20250411114534.3370816-6-ppandit@redhat.com>
In-Reply-To: <20250411114534.3370816-1-ppandit@redhat.com>
References: <20250411114534.3370816-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

v8: remove a !migration_in_postcopy() check
- https://lore.kernel.org/qemu-devel/20250318123846.1370312-1-ppandit@redhat.com/T/#t

diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index ffe75256c9..02f8bf8ce8 100644
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
@@ -399,7 +400,7 @@ int multifd_ram_flush_and_sync(QEMUFile *f)
     MultiFDSyncReq req;
     int ret;
 
-    if (!migrate_multifd()) {
+    if (!migrate_multifd() || migration_in_postcopy()) {
         return 0;
     }
 
diff --git a/migration/multifd.c b/migration/multifd.c
index 6139cabe44..074d16d07d 100644
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
index b0ac2ea408..48aa6076de 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -491,11 +491,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
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
index 753042456e..533c64b941 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1976,9 +1976,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
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


