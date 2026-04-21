Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FCCF94CA7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 20:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFHbF-0000zK-6M; Tue, 21 Apr 2026 16:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHbC-0000yW-Ui
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHbB-0008S4-Bs
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776802892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MP6eJHP+Kzsfxz3ElFor7EoD903ypuntI/q5FTsZpKQ=;
 b=h6iok2/vP2KYlrKShfUcINuQX+jMQTk2Z9Ygm22ncSo/hnUxZ1PiLvSwbQl8XNXO3G6/jv
 k95QWOOVD1csZAQfPYo9ds4eA4TJA8YtAoZP4My865P3Eceu3DYAzKKxam6E1pdYk2kFcG
 991p9mYTPRr+06PlX+joWAvSXYdrBhY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-oSm0CgqPMOWHfxh8k-Mx4w-1; Tue, 21 Apr 2026 16:21:31 -0400
X-MC-Unique: oSm0CgqPMOWHfxh8k-Mx4w-1
X-Mimecast-MFC-AGG-ID: oSm0CgqPMOWHfxh8k-Mx4w_1776802891
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50edf0245b0so54171811cf.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 13:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776802890; x=1777407690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MP6eJHP+Kzsfxz3ElFor7EoD903ypuntI/q5FTsZpKQ=;
 b=kNofL9P3mc1ff3iR0ggIgFliJ8YDa6RERSkPQhJ1v6LyGLVEvzs+O1yER5X7A1wlk+
 dSlO5pe9okSgIjC28rXRIebzv31JE4j67oJwvfwM646x+Sz9DWCmCZ1lX6JBSr6BfGfF
 yE3Pzr0tVeF59e6a5QbwEubATmnINJP0trvl2J7LA8mcAcx9vVVXExzPbyGFxjeO3NkD
 6pnwLM8ht4ZbxZ9qiuLfl5tdUNmhO9J2oB8AqJNAacfBmVCU5o72bzTjApo9kwStY/X0
 GP9JwbD5RBBqaTF5baaSuMYBcHfsPT6/E4eh30W3LbfLAV9LKhOsg76sj9Vav5q3Sps3
 WFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776802890; x=1777407690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MP6eJHP+Kzsfxz3ElFor7EoD903ypuntI/q5FTsZpKQ=;
 b=kf/gfpf7HM4xtAxOaoD7IWLdfWX1gsnLQp798cr1h5qbImHDCleeCX6yFEF4HpPZFL
 WC5YUBoFrDPjKg6C3ajkFHRmn52Xav8uHPlbMmawWjsMoLv0QNo6uNJcsdDDBMOLANSQ
 UJ+TkYYaz2gg4puTJns0njBZc2zft9uhBq9F3g3Px9C5SjnDP7wdEI/RwZ4OnIvBRquV
 Ds30LO1ypYhMRLsVDQwhrKgsCAi35TMXuRdZG+jXlR1jVFL69n8IkfJx5Laiq8B+DiZY
 APam6fFiGZ8gzeH+hVLPGaN1Mz8EPl1PTVxEXrOp23lW6wvEjGRrBAAAS9Bt2MYI+s37
 CrZg==
X-Gm-Message-State: AOJu0YwvuAUIa4oGwvGvGa/YHiL9MDQhUGivhptWUIBz6V+WFGdALeeG
 6hPZ/R5fQPcjPc/52/kNcZVRw79JJdb3ErNXDyF4zzRoC+kTIB9hGCnRWVKjVlp8kRAcbwZ42rK
 TRKHVkuRNy0uwdPqfYmaRvtZTxYWgcxFhnYgS1Wxc1JLt9ZiYIPdAR6yudkp17tw7ym2shAVPpN
 tHBZgjItKlnJPH3s2jkuTcRthWWjsXBj1OZi3+Bg==
X-Gm-Gg: AeBDiesymm8nNgG2H4CjG9mtUeBhk67FdrB7/y2SJ+kizpKnxyJbF7kKT2qO0wrHr2Z
 UuGjjwxytLKhciOTwcCOo2TbIwq91ZNF9UbWPMmBPdPz2K94qFPx4XNaDizS9PyyfjSK964QWGg
 lT+VjivvzSFrDXed0Lgq2kp17YpApbmzSR6DBrx0lZldZYVPF8nfO8fLPSJYtpsVs9uBYOSj/Jj
 rloP2rsRUbUdj+V71NClb+AZE6ADLCjYTmQz7/Cf/+PfguJ25G4SoYA/CYJLz1FyKCrZy09YeaY
 kUZ2d2V4eSqLuXEW4EQyZ2gskJrwhUMqj7mZW9acmE7w1MAvn4PnGmQ2iUxqGneG7HfK1rldwll
 SBcaw/O+ySxzPa3lfz738SuWDgKGAaTG8RpIx8qkO995LH8TasqIsZUhiOQ==
X-Received: by 2002:a05:622a:17c7:b0:50e:89e9:271c with SMTP id
 d75a77b69052e-50e89e92b67mr120918351cf.17.1776802890325; 
 Tue, 21 Apr 2026 13:21:30 -0700 (PDT)
X-Received: by 2002:a05:622a:17c7:b0:50e:89e9:271c with SMTP id
 d75a77b69052e-50e89e92b67mr120917561cf.17.1776802889606; 
 Tue, 21 Apr 2026 13:21:29 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae5c26csm114343556d6.31.2026.04.21.13.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 13:21:28 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Zhiyi Guo <zhguo@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 10/16] migration: Introduce a helper to return switchover
 bw estimate
Date: Tue, 21 Apr 2026 16:21:04 -0400
Message-ID: <20260421202110.306051-11-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421202110.306051-1-peterx@redhat.com>
References: <20260421202110.306051-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index e3f82baaac..caa1d13130 100644
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


