Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4A41091933
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3MYY-0001QB-TR; Thu, 19 Mar 2026 19:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYX-0001Pk-I6
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYV-0001c4-V4
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773962011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ZTk3pexOhw1yn+1jhPOuPpjgi4ezlZc3e3A0v5mt6c=;
 b=HrdFn5/kaIA0AUgp9xh9QkcdksrGfdoaArTtJjn7thFfNzqK2IjyyvYhep6HjYb5XEqSLC
 u4g/OInhhzFlqiouiy/e6+dbSKuTPNRo1HgavLV4fEvb9FZ56U0h40y+JHfWaWUh+pVTRt
 /synGlJ9lyjFbdWjcSf+vJn3rIFX4VY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-NbPma5CCPAy7x8ilbiBhmA-1; Thu, 19 Mar 2026 19:13:30 -0400
X-MC-Unique: NbPma5CCPAy7x8ilbiBhmA-1
X-Mimecast-MFC-AGG-ID: NbPma5CCPAy7x8ilbiBhmA_1773962010
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50911c94db1so83492001cf.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773962009; x=1774566809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ZTk3pexOhw1yn+1jhPOuPpjgi4ezlZc3e3A0v5mt6c=;
 b=i8AdNrnFJNpRYwuRJfl6gEXiUD1H9FHvfmeqAvZoHr0Eq7osfPmN3A6IXa4sI/kSUT
 Rq3k6POBy75nC6MEDo0ywveuTsX4+8LUjkg/9QDPCn1umem2qirKt9XKsdxHU17OVGdK
 uSQGUgmKjqRWRTvMw202M4AkXWweQw+cu9DplpUXJC8des/tOwhRRbpv2ywQsquhcPn8
 IiR2TZQolcQrCHPHR3FAgh81Yoka4AbvfKwtW7CfhDt2MIWgF7lkq/mrKaC2aegoT2xT
 s4KcZ4AoocDH0CaDY/ThKAovjMhx9MIqHpXo7WNjYZVPwnZIF1qXlLnDUQUljz+lWqN/
 P+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962009; x=1774566809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1ZTk3pexOhw1yn+1jhPOuPpjgi4ezlZc3e3A0v5mt6c=;
 b=bqwT3Tdjwec/TxWkd91DJBrhej072iYOau7mHTXHa7SiKxloleaCPnP52TWZSbHaPF
 xSEeWcG0KzU4c6EPJKduSnDWbDe7m+Jk2gWe8WqmyzxtPmRXdwb4TXUruKxqSRnphjlz
 3GndJxFwQW1aGgxcprgyrg6675UqJztExCgZQAky3CsXcW2yt53qvBjdhA4nXJrozRC8
 1K0FirHboG/ya8W8isXATuH+jlLYq3CL4Lw6hNxHc+pNxGGX+Kbc63E5xwdo4sAF51sg
 zK3mV74v3jd1Y6bKAV6N3AB5Ij6eqQLHptK3jrApV0wz1QHQK9LYPa4uXzmdtNWGqqLv
 uKWg==
X-Gm-Message-State: AOJu0YyEbheKd67l4g1ha/AznCzTj2DqLCFw/zWU3X+hKfWjgCqht3AC
 +i9+7CKaV/gLQ4N1ApC9SCvpRWkp/Gfg1rd7FfYiDCAXBtAHTN+MpY9hDCxvTZIwU7OgTq7V97/
 O43iDLU2PHBXqhQv5q+EqeLK7iJfoT7fDEpY41hVGbwOy5IhhJNqMoLuM0IlwywOF39UE++ZWU/
 jOmznOA9RNqZ2OG4u4aJT1EX0ycLcAUDnlB5NM1g==
X-Gm-Gg: ATEYQzwadT5OVcrXACnd4sBPMUQsL5UoUp1hv3NrClN8yZ96fR3wKTgHkQ9VyEgeV+H
 07opwkg88Ghhh+0xhaH5OGV+LqL814OZN8Xuooa85rE/D4TDuzAuX/fYT7eRcEeCUuKcTnNu1lJ
 oa0VL6kw/mxMMJ2oZRW3SRInrFT2gazZlXjzA7ScnRoXTzIJxY7vLicyylHp4PgCcq/l5ETHzwj
 Rbz7/ZCLjZV700BxH+5V3dLFLG9vjN+a1zUiL8bOjjIQq6P7Bmajr8LEbwqasyu+nkfGzNitYjB
 B0Dg9rTPoYGcbBP2LEBkx8s/Pcl00YPVYbuCUVpaT85ZtEa042C73jShfk5zjdTrO2LZkcjhrpc
 Gs1dGmQ2IoENZZg==
X-Received: by 2002:a05:622a:1e0b:b0:4ee:13d0:d02b with SMTP id
 d75a77b69052e-50b37500cdamr14681651cf.50.1773962009566; 
 Thu, 19 Mar 2026 16:13:29 -0700 (PDT)
X-Received: by 2002:a05:622a:1e0b:b0:4ee:13d0:d02b with SMTP id
 d75a77b69052e-50b37500cdamr14681241cf.50.1773962009073; 
 Thu, 19 Mar 2026 16:13:29 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b36e5bee3sm6717161cf.21.2026.03.19.16.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:13:28 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>, Yishai Hadas <yishaih@nvidia.com>,
 Fabiano Rosas <farosas@suse.de>, Pranav Tyagi <prtyagi@redhat.com>,
 peterx@redhat.com, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH RFC 10/12] migration: Introduce a helper to return switchover
 bw estimate
Date: Thu, 19 Mar 2026 19:13:00 -0400
Message-ID: <20260319231302.123135-11-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260319231302.123135-1-peterx@redhat.com>
References: <20260319231302.123135-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add a helper to be able to return an estimate of switchover bw, called
migration_get_switchover_bw(). Use it to sligitly simplify the current
code.

This will be used in new codes later to remove expected_downtime.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h |  1 +
 migration/migration.c | 43 ++++++++++++++++++++++---------------------
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index b6888daced..bf3ee6cc07 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -586,6 +586,7 @@ void migration_cancel(void);
 void migration_populate_vfio_info(MigrationInfo *info);
 void migration_reset_vfio_bytes_transferred(void);
 void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
+int64_t migration_downtime_calc_expected(MigrationState *s);
 
 /*
  * Migration thread waiting for return path thread.  Return non-zero if an
diff --git a/migration/migration.c b/migration/migration.c
index ad8a824585..56d605ede9 100644
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
+    double switchover_bw;
 
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
+    switchover_bw = migration_get_switchover_bw(s) / 1000;
+    s->threshold_size = switchover_bw * migrate_downtime_limit();
+
     transferred_pages = ram_get_total_transferred_pages() -
                             s->iteration_initial_pages;
     s->pages_per_second = (double) transferred_pages /
@@ -3178,7 +3178,8 @@ static void migration_update_counters(MigrationState *s,
 
     trace_migrate_transferred(transferred, time_spent,
                               /* Both in unit bytes/ms */
-                              bandwidth, switchover_bw / 1000,
+                              (uint64_t)s->mbps,
+                              (uint64_t)switchover_bw,
                               s->threshold_size);
 }
 
-- 
2.50.1


