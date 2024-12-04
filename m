Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB2CE77160
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 00:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIdcZ-0003EJ-Tg; Tue, 03 Dec 2024 19:52:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdcV-0003D5-9r
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:52:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdcS-0005fv-VO
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733273516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=41KR4Z+XrJCKzJDc/n7PJZw1zpTfNlrkS9eZ0Nhk9Yk=;
 b=WODDdwBVJl+da3kQiWS3VieJ2yhDxGR5186O02Di4jKhsCSJ+SREDC+pP9LI2hM7xjOpCd
 lP57OaIGW5OymvnxTkeU5Z64Arw1Q0PYEI1Ja6J+g3TBRuyqlnAV+AJksuxSlxS2wWnvik
 9K8WkjPU17fpjndqL6GXl/++snDyEZ8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-YBC6GVfXO_u10_-yLIYm_Q-1; Tue, 03 Dec 2024 19:51:54 -0500
X-MC-Unique: YBC6GVfXO_u10_-yLIYm_Q-1
X-Mimecast-MFC-AGG-ID: YBC6GVfXO_u10_-yLIYm_Q
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6732101a6so959239885a.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 16:51:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733273513; x=1733878313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=41KR4Z+XrJCKzJDc/n7PJZw1zpTfNlrkS9eZ0Nhk9Yk=;
 b=d0p0DSdvKVlNctheioq/VWlq6vFSpTBZ68bNfpsctg0bZM+MNAHdm7vzmVfReRTZLz
 EKMmP4gvN26u/t5PMYJeKXoDwmT6KC72/FCoJ76Dto1uFWR5NPAhlu4lWXA4Oo2eG+t1
 ywoYSMyDsgLwitHzFqeJIGMwZxEF+RGoW/fGc3WnKlW6ZfcmXrB7B9dvtNLJsdbRBn5G
 dBWDzWV0vsgC/BiRlIWJK6IiU46mjXX///701zjpN8gvhtKlbl49tpOigpM9G5giDyTj
 wP28W4UkbJPclYsFssKK8UWCQ+qiZjHrho7L0LrnD0f1eekZhyPa7Uq71leQ97zoaVCC
 xfNw==
X-Gm-Message-State: AOJu0Yw9DSMoDGpdRth8FqHUr3knc24miRQyE/QmG5+5L83amqyFcktO
 68Qwh/2oRPZflQmJbYihY3YWKajoRdo1wUbj3GGkCrLHWKSKT98IxQIA/HlBI2MA6CzeBVoBDFF
 9RA/hVcaJTBzmUPQGeo5EEC0n/nPeSSoQLYbzROon6YKUpMKDDN7z+VVgLZOcKEEr1drUIngezw
 k0F6TkNIGUo8auHqoHJSRkExahE6EbQvK3sQ==
X-Gm-Gg: ASbGncu5svT5pKxZi4M4lAq59HTsfiOvJdwYh+rwcMoYGCfuVLAhlHKXeXVWdv5/yJo
 ixRCL6ABbYDDWu3E+fN0/NMaQoqatzyeWvABnztH4toFgUo80tIaTc3+DIiTzMSWzbNfJAmLlcd
 oVZHSwLdPaxc2xktignnmnhyaOGX3Uw83cUsJlt++9szcMSiE7XQcEU7TyAyXxSmj9qitN6h0EP
 fKX8yirRHN87dEm6qAbFOeJs6ct0G7fN4DYeJ4Nd8YsDSgORq+TROrm+8Cq4s1gY+52hK0quJYf
 JZOfpiygLZUIrawCqwwCbEjw1w==
X-Received: by 2002:a05:620a:4486:b0:7b1:3f88:48ef with SMTP id
 af79cd13be357-7b6a617f631mr566394785a.46.1733273512783; 
 Tue, 03 Dec 2024 16:51:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOMMP8VoVIvOp3DPzYl64JgJ8DjxMRQ2g3iFH8huNDueUrBW2ZvODw/qIwsDbap+5r5Va0tA==
X-Received: by 2002:a05:620a:4486:b0:7b1:3f88:48ef with SMTP id
 af79cd13be357-7b6a617f631mr566390185a.46.1733273512324; 
 Tue, 03 Dec 2024 16:51:52 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b68492cb81sm559974785a.34.2024.12.03.16.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 16:51:51 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, peterx@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH RFC 06/11] migration/block: Extend the migration_block_* API
 to dest side
Date: Tue,  3 Dec 2024 19:51:33 -0500
Message-ID: <20241204005138.702289-7-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204005138.702289-1-peterx@redhat.com>
References: <20241204005138.702289-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Extend the usage of such API to the receiver side, because such status
maintenance is also necessary there.

It's needed to avoid bdrv_inactivate_all() not being invoked when the
drives are already inactive.  When invoked, it can crash QEMU.  See the
issue link for more information.

So it means we need to start remember the block activation status not only
on src, but also on dest.

One thing tricky here is, when we need to consider incoming QEMU, we need
to also consider its initial status as incoming side.  Due to the fact that
before switchover the incoming QEMU doesn't own the disks, we need to set
initial state to FALSE for a incoming QEMU.  In this case, postcopy recover
doesn't count.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2395
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h | 13 +++++++++++++
 migration/migration.c | 13 +++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index b71c062ad2..f477494c5d 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -380,8 +380,21 @@ struct MigrationState {
      *   switchover phase).  When that happens, we need to be able to
      *   recover the block drive status by re-activating them.
      *
+     * - Currently bdrv_inactivate_all() is not safe to be invoked on top
+     *   of invalidated drives (even if bdrv_activate_all() is actually
+     *   safe to be called any time!).  It means remembering this could
+     *   help migration to make sure it won't invalidate twice in a row,
+     *   crashing QEMU.  It can happen when we migrate a PAUSED VM from
+     *   host1 to host2, then migrate again to host3 without starting it.
+     *   TODO: a cleaner solution is to allow safe invoke of
+     *   bdrv_inactivate_all() at anytime, like bdrv_activate_all().
+     *
      * For freshly started QEMU, block_active is initialized to TRUE
      * reflecting the scenario where QEMU owns block device ownerships.
+     *
+     * For incoming QEMU taking a migration stream, block_active is set to
+     * FALSE reflecting that the incoming side doesn't own the block
+     * devices, not until switchover happens.
      */
     bool block_active;
 
diff --git a/migration/migration.c b/migration/migration.c
index 8f7d09ca84..e01264168f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -701,6 +701,12 @@ migration_incoming_state_setup(MigrationIncomingState *mis, Error **errp)
         return false;
     }
 
+    /*
+     * Newly setup QEMU, prepared for incoming migration.  Mark the block
+     * active state to reflect that the src currently owns the disks.
+     */
+    migrate_get_current()->block_active = false;
+
     migrate_set_state(&mis->state, current, MIGRATION_STATUS_SETUP);
     return true;
 }
@@ -779,7 +785,6 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
 
 static void process_incoming_migration_bh(void *opaque)
 {
-    Error *local_err = NULL;
     MigrationIncomingState *mis = opaque;
 
     trace_vmstate_downtime_checkpoint("dst-precopy-bh-enter");
@@ -810,11 +815,7 @@ static void process_incoming_migration_bh(void *opaque)
              * Make sure all file formats throw away their mutable
              * metadata.  If error, don't restart the VM yet.
              */
-            bdrv_activate_all(&local_err);
-            if (local_err) {
-                error_report_err(local_err);
-                local_err = NULL;
-            } else {
+            if (migration_block_activate(migrate_get_current())) {
                 vm_start();
             }
         } else {
-- 
2.47.0


