Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C758CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMMN-0004br-JQ; Tue, 05 May 2026 16:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMMD-0004Te-Hl
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMMB-0002cx-El
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778012821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7J+3/zQgM5oGZ4jYYw3SGbSGgqkUYRSROV8mmjeY+Y=;
 b=IRbRDovxjg16SX11ozbx72hRhrBsAEj48SqXKWCKNhrLSau2JsaNG0kV6pET/7UvsSIFiL
 rjvozN4cWPEl/4IcnKBFxvyEaTxDyl7a9jce1ocgRD8325eOc6rV5voc3XSxsi2L9cSVm4
 MJER4GIVbckz3mcvoXTVtAMrk/T/9D0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-Z3rVoT83MVOe8zBejjIHgg-1; Tue, 05 May 2026 16:27:00 -0400
X-MC-Unique: Z3rVoT83MVOe8zBejjIHgg-1
X-Mimecast-MFC-AGG-ID: Z3rVoT83MVOe8zBejjIHgg_1778012819
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b7e68098dcso69803716d6.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778012819; x=1778617619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7J+3/zQgM5oGZ4jYYw3SGbSGgqkUYRSROV8mmjeY+Y=;
 b=fWZlqEiIPFsfRPJSy0kZZZnNKm+JLtuqhSoXZxEwrpEGmMhZaxvL9zt7ZI7nN1FZow
 PU4OY6KSSsXIt4DsBE3un7NEu0JqtzM4yCZUKzr978EV3BXn5WPf47prcomsIbu7+dEw
 lsNwytI6qudamJc4W3AH3608kxWIuuIGW1mSst1WlbOvMD3OP2KhklPI4T4z3WnuZvL7
 kab0zhoefA2m7sYE9DGwkIqMyfTHG2k/bI9//0iIBU280TdbeB4agP6WInlM3NGRPugK
 gDrpgIn0cBrc+6yZMGSu3henpcUQIyQYomFUzRVpuDG99KHwRJ+bYgZOFP3o87Ezp0KN
 8U1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012819; x=1778617619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c7J+3/zQgM5oGZ4jYYw3SGbSGgqkUYRSROV8mmjeY+Y=;
 b=gb5sBKwkwMjheVIA85Y45PAtDbqLuTEvxX9uqQTn9IuFD7vWIFck2rSJHLBdwwTSAn
 6R2OD5EgWN6VBwbneZzZgPB0SY77FP1sDzw5tfLeTkV3BC6Io4XkmRudUvl019+Q1ie5
 aNgXcte45ujsZP2qObmndLKbWvNFZaej/g5mXu0+KW2LnoEqD0VTx5ZYn5GS3nv2EOgd
 GP/U2DSVouIfQbZRmgKZPPWeW6UME0gC8lfCT6kwfzbmoOhu3ZRXFLOIWO7QoTquHUWU
 rBlD0DCyF9aOwwR7hejS5JG9FjqdHbl1QkXib7dKRuYUv77j1+vXw7OEnozo3zN43d0c
 YKvQ==
X-Gm-Message-State: AOJu0Yzx+6ko6+Qd82dl+tsIvxPDsbZSgxp1as1aGAR6yIfJaCxyvZeK
 +aj9a9kL+jQhQJKljv2TjDGspj51mKcSTz4njK6jOPCVsZieKunZOfv6KVvBWBE/eB+eZBqhzjI
 5vjUYIunrgvF2/J5qRnJmqGL5jE707uZzFvBaJBvvZ6k3eFxKdjOPdu1XMue2OnyUKK+HncnRBg
 ZJL7fgH67z6H0sg26fl/niIxj3P+3fNxwf0bz0jw==
X-Gm-Gg: AeBDievptcF5OvarxcbtfYk2MY9szAe1ByMJirsEvXlSpouBUwmUPHJVFfJs0g/hh0O
 /YwZij3TTn152a1WnJed3IUrkEvS0iGHXmod8xs6aNi1VIbQu/2enxJbIOfa5m+NFZd0icle8Au
 1vVJfFUOY9fHpsTBgAS9xGFH1JdHaeIR9kHlRAQgx9GPyupB0IlVR31oRWc6zns0NltKfjBzHHT
 BNniX2PHPmQAbgRSm9HNqq6I5wkR99iUT5IK/Sw0CiVjYgDrkPnC85c4/1Q3alrGJKasroEP07t
 7eRje5l7COwokN8EpB+fV6GCRhOLVImLQ79ptTyMkCSD3ukebJkITYnQ6LekWDEZqvFIO5qAs3h
 vAqwtoc6AmXzTuewdSXk6gwDT7c0QG4Ajx5JLjYqzMZEnfcXBNVAXJpc=
X-Received: by 2002:a05:6214:763:b0:8b4:a0be:4b50 with SMTP id
 6a1803df08f44-8bc4517a7f1mr4398636d6.33.1778012819059; 
 Tue, 05 May 2026 13:26:59 -0700 (PDT)
X-Received: by 2002:a05:6214:763:b0:8b4:a0be:4b50 with SMTP id
 6a1803df08f44-8bc4517a7f1mr4397866d6.33.1778012818351; 
 Tue, 05 May 2026 13:26:58 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c6b8123sm155283806d6.35.2026.05.05.13.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 13:26:57 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 12/23] migration: Introduce a helper to return switchover bw
 estimate
Date: Tue,  5 May 2026 16:26:29 -0400
Message-ID: <20260505202640.1011006-13-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505202640.1011006-1-peterx@redhat.com>
References: <20260505202640.1011006-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Link: https://lore.kernel.org/r/20260421202110.306051-11-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 48 +++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8abc7e0327..4e19fe3409 100644
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
@@ -3130,37 +3145,22 @@ static void migration_update_counters(MigrationState *s,
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
@@ -3170,10 +3170,9 @@ static void migration_update_counters(MigrationState *s,
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
@@ -3182,7 +3181,8 @@ static void migration_update_counters(MigrationState *s,
 
     trace_migrate_transferred(transferred, time_spent,
                               /* Both in unit bytes/ms */
-                              bandwidth, switchover_bw / 1000,
+                              (uint64_t)s->mbps,
+                              (uint64_t)switchover_bw_per_ms,
                               s->threshold_size);
 }
 
-- 
2.53.0


