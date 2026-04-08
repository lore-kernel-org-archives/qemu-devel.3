Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB9610F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYWU-00073D-KP; Wed, 08 Apr 2026 15:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAY6y-0007Ou-HI
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:58:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAWCS-00029E-2f
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775667379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zE/OR2UJlEPUMANmN2EULG0b7Ek3BGjAQyC/gyTr4yY=;
 b=F8EGtmB8Fd4WtYSXM6Ktiji32yqMDgPfMDoC718kaDFVTYbe3RykzmjIbe7F/5bPVIJoQZ
 E5y+Mw6Xu31nyNSAKC2VF94L7hP1hUaQlf4ZKas5z0mLdqj3tk3bpSUlQqC7hUe1IMojG1
 8j2/dpwjnnFkZjH5xK6ZuIHHoTYASHo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-DLlQR6maOByv-nGFlwDZ9g-1; Wed, 08 Apr 2026 12:56:18 -0400
X-MC-Unique: DLlQR6maOByv-nGFlwDZ9g-1
X-Mimecast-MFC-AGG-ID: DLlQR6maOByv-nGFlwDZ9g_1775667378
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d6bf346adso2333351cf.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775667377; x=1776272177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zE/OR2UJlEPUMANmN2EULG0b7Ek3BGjAQyC/gyTr4yY=;
 b=NG+0FBbjo0r5wMm7BydRmLKoTG0wbI3hgXzV4E0A/6l9p+lz72gWlyJS89o8BlMfPh
 7tgWE5R4WH13EYkVas2g7IdlzNxP1BOT0X5FIGolaPOAbu5Cu/H7eF7I7zGjBWJgKrHQ
 owYkqrRBwdTMi8J9vb+f06GKFWC/q3pYbC2jFSPIoRsorQSqNGEYGXH1OudSztmSkE0G
 OjOgX/B08FVTACmUAMJe4zr5NyO++ptODiNl7TfLFIfLZizSevarLaX3xfYwj6E8dOWd
 3XVZsGIZ/ssTGmpMqeGtYiqhMXasbjOvSAuVzHvon/scHC/pakMERDaf7y9rzcoX3o3n
 twZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775667377; x=1776272177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zE/OR2UJlEPUMANmN2EULG0b7Ek3BGjAQyC/gyTr4yY=;
 b=NDrdzEnnSwow5R8k8IoQusrG2aP1aVSlzz84unirONzEHvfrKZqzr0mhphygPY7Wql
 KAB5UzauxgtBKo33QLTSUpBowPt3cMpYIfgoFQiyuL5Scp6BlHKKBGJ+y6azHBPFuHdV
 dQd6cfnLob+HLXdoF9D2vtPOfGhdWk/FLxfQUrQGP9YXWnoi6v/7PRdFz6TfVa0++L+W
 blwbf1bfBaQGYpXC4NmQ+D0dShS9Gw0HAGTZQ0UZBSaDMK0GDV1KUrFByBBJSgGb3fwD
 DcHH5WqdK4XChw2nXU+OyjYwreJiLeoJwxy8oSVT7wEXoDLUPGwqEEfKVtIYYKHEjRB+
 204g==
X-Gm-Message-State: AOJu0YxHrTyENXkjAuUrXhWuZ5mnvVwlDXaPEe6XoPNDXgRn3dbKF9C/
 n8psrZikThNGFzE3bx7jy3mK/pQErnvjbIz5EN0DwrDxugP4mGDzYeFadeTJGWYRwOtP88gszjw
 d28Eoz86fAmhrGIKkecHEr6kJO+LUUZrG6rhVBmTY40vU2K2SWvs9EsZth5kVDKTgX9/WJ0gUs2
 c822tfIrMMbXYv2M9GKgde8ZPFx+XerwKhENqmuQ==
X-Gm-Gg: AeBDieuEc8fwSrbDFQcC8h8nECkwDupmtqMDghANgyD357/1CEVUMMGRYzPf6G9+BRy
 uyjiITr7u2Iqr9oNodCkxdkqa98OP5fCnBR13yKjKnLLgHpaQBxvE9ZEqr88N5+/RCglsHzyaFl
 Czedjm6oUByLNRPD+Hj1Y9NHO6fTGpS7bkkHLfYm36BTia3iPRPxq+PyZBHMDEE6q+9rMaTg4Fa
 u3BKjcrojyGrJ5rP8QJfnTI8VX/knyKRAqqlV4vSZFEY60JvIljPr0flcYbHmxceoLWEHR5+X3o
 o5/N0sRvEBbnvQtqB+wRlYKdEZJNwQ+F6Rlkset9U8C7dHxtAyCEP22fWIuqYANBGNC3tn/b8CA
 gjZCH1LkGU+mIJAysdhjUkiwvUV46/o3VdsS/un2uBwTg
X-Received: by 2002:ac8:7d88:0:b0:50d:6acb:42db with SMTP id
 d75a77b69052e-50d6acb4a89mr300089221cf.23.1775667377350; 
 Wed, 08 Apr 2026 09:56:17 -0700 (PDT)
X-Received: by 2002:ac8:7d88:0:b0:50d:6acb:42db with SMTP id
 d75a77b69052e-50d6acb4a89mr300088321cf.23.1775667376464; 
 Wed, 08 Apr 2026 09:56:16 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d712c2617sm130491901cf.31.2026.04.08.09.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:56:16 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Peter Xu <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>
Subject: [PATCH 10/14] migration: Introduce a helper to return switchover bw
 estimate
Date: Wed,  8 Apr 2026 12:55:54 -0400
Message-ID: <20260408165559.157108-11-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408165559.157108-1-peterx@redhat.com>
References: <20260408165559.157108-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a helper migration_get_switchover_bw() to return an estimate of
switchover bandwidth.  Use it to simplify the current code.

This will be used in later to remove expected_downtime.

When at it, remove two qatomic_read() to shrink the lines because atomic
ops are not needed when it's always the same thread who does the updates.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 48 +++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 57d91ad9e3..a1a02e3a9f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -984,6 +984,21 @@ void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value)
     migrate_send_rp_message(mis, MIG_RP_MSG_RESUME_ACK, sizeof(buf), &buf);
 }
 
+/*
+ * Returns the estimated switchover bandwidth (unit: bytes / seconds)
+ */
+static double migration_get_switchover_bw(MigrationState *s)
+{
+    uint64_t switchover_bw = migrate_avail_switchover_bandwidth();
+
+    if (switchover_bw) {
+        /* If user specified, prioritize this value and don't estimate */
+        return (double)switchover_bw;
+    }
+
+    return s->mbps / 8 * 1000 * 1000;
+}
+
 bool migration_is_running(void)
 {
     MigrationState *s = current_migration;
@@ -3126,37 +3141,22 @@ static void migration_update_counters(MigrationState *s,
 {
     uint64_t transferred, transferred_pages, time_spent;
     uint64_t current_bytes; /* bytes transferred since the beginning */
-    uint64_t switchover_bw;
-    /* Expected bandwidth when switching over to destination QEMU */
-    double expected_bw_per_ms;
-    double bandwidth;
+    double switchover_bw_per_ms;
 
     if (current_time < s->iteration_start_time + BUFFER_DELAY) {
         return;
     }
 
-    switchover_bw = migrate_avail_switchover_bandwidth();
     current_bytes = migration_transferred_bytes();
     transferred = current_bytes - s->iteration_initial_bytes;
     time_spent = current_time - s->iteration_start_time;
-    bandwidth = (double)transferred / time_spent;
-
-    if (switchover_bw) {
-        /*
-         * If the user specified a switchover bandwidth, let's trust the
-         * user so that can be more accurate than what we estimated.
-         */
-        expected_bw_per_ms = (double)switchover_bw / 1000;
-    } else {
-        /* If the user doesn't specify bandwidth, we use the estimated */
-        expected_bw_per_ms = bandwidth;
-    }
-
-    s->threshold_size = expected_bw_per_ms * migrate_downtime_limit();
-
     s->mbps = (((double) transferred * 8.0) /
                ((double) time_spent / 1000.0)) / 1000.0 / 1000.0;
 
+    /* NOTE: only update this after bandwidth (s->mbps) updated */
+    switchover_bw_per_ms = migration_get_switchover_bw(s) / 1000;
+    s->threshold_size = switchover_bw_per_ms * migrate_downtime_limit();
+
     transferred_pages = ram_get_total_transferred_pages() -
                             s->iteration_initial_pages;
     s->pages_per_second = (double) transferred_pages /
@@ -3166,10 +3166,9 @@ static void migration_update_counters(MigrationState *s,
      * if we haven't sent anything, we don't want to
      * recalculate. 10000 is a small enough number for our purposes
      */
-    if (qatomic_read(&mig_stats.dirty_pages_rate) &&
-        transferred > 10000) {
+    if (mig_stats.dirty_pages_rate && transferred > 10000) {
         s->expected_downtime =
-            qatomic_read(&mig_stats.dirty_bytes_last_sync) / expected_bw_per_ms;
+            mig_stats.dirty_bytes_last_sync / switchover_bw_per_ms;
     }
 
     migration_rate_reset();
@@ -3178,7 +3177,8 @@ static void migration_update_counters(MigrationState *s,
 
     trace_migrate_transferred(transferred, time_spent,
                               /* Both in unit bytes/ms */
-                              bandwidth, switchover_bw / 1000,
+                              (uint64_t)s->mbps,
+                              (uint64_t)switchover_bw_per_ms,
                               s->threshold_size);
 }
 
-- 
2.53.0


