Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E652F10F995C
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXeq-00057d-SE; Wed, 08 Apr 2026 14:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAXeo-00055c-Ep
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:29:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAWCT-00029N-I7
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775667381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=35aD6ayAqevDc5Cl045Lui2nxa5WaJZTNVeaUyAZbPM=;
 b=U90wPZhb/Lp9X+QRuoYSWx0hVboxfS8AfPrnspXepUpmsZqSaAFtscsSogPrcElX1PHTXL
 V5peRqRrGF8maZrmz03p3pWEatKIlrW7yna8I17MERmUq5kcWaoEMDyZ6x8z5NsnF9wZXt
 iWDa3MaFz0WQYq747exa07kjmpJ2BJY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-qlLnRnFiOZ-h2m5az8N7Pg-1; Wed, 08 Apr 2026 12:56:19 -0400
X-MC-Unique: qlLnRnFiOZ-h2m5az8N7Pg-1
X-Mimecast-MFC-AGG-ID: qlLnRnFiOZ-h2m5az8N7Pg_1775667379
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d9a6a853bso3467411cf.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775667379; x=1776272179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=35aD6ayAqevDc5Cl045Lui2nxa5WaJZTNVeaUyAZbPM=;
 b=IAqHhfWbObbWPBaN4v2oYeuPnZHWpjIl0Rh+RXuTdFVyNzL/daxHgeGEwnr7O/xsUs
 NlzjTw/GaAXOTq2dBT00zmIK++xkk47CdSm3CHEXhHrQP7PoP/I7fqjKwG2Gc3Q0JzAb
 0G5bZsRnM3b6HgLOJXW8SmoEgCANlRjsDw0ojf/KG+4FNxF0aKJzmjTCBKzIQ7mQks7t
 I0ORukbAJ7gG/cKdZO6z9iht/xa9U6zTpFyD3mHXBNea3CBOyg11xsezK0qHKyCgkzgW
 OvRwGkmWN+dXFGGLp3J7eyzUsMW5bZCmrwwQEPUTmw4Muq8pUg9q05s9wPUlTQhw810l
 D3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775667379; x=1776272179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=35aD6ayAqevDc5Cl045Lui2nxa5WaJZTNVeaUyAZbPM=;
 b=mdVv09qvLVwgpZc0g3kNB7mHpVoMnacyFXaVvPu+5frTCuJ2ITA4VpuUpQ7DEL4QPh
 2PYoyOtgqgKCzMMYlQm0Ddp2lTnkKGfgg6K3/pdZtF2PRhxJbEQEYT63RFCyc+qIOcvu
 IEuRS4b3EZoy6QOFrcjNeNZH2vVTQKV4OrKvo1bBNdp3pzyL2iLb9OTKGMzDjXkCU4Ay
 22kOFK8Xd+qUMimQhTWCv1HiKE8lD/UHZvPFRdhQnh0KjmLuk2sZIjLfLha73hyEoJBM
 sKmffeLL5CMfWHnYeEdlmOEO4YST5g5hcLGop8jtcHxnlc3eB8vknB/lObdboCvWx6pb
 3v+g==
X-Gm-Message-State: AOJu0YxkkKy/8nCfYipONB3tVGm6+OilpANBSihn0nB/+3EQmyjY05g5
 RyEDstxDqCmN5fq2xoROu9sm0bpr3lR6B1eNYILjgs5gv9ObonY3W0CDAvfsxBstc24pDGOu+c3
 rbQ5+bhp3GPC1qV+NJkzwkSMJxyOuuqK0p0bhIUe8aVdJzo9sZL+6d9s9Wu/bqVSbKnUKNay7jZ
 mrvgJa6mTfEoV/Jh1MbFSDGO8Opq09yHfw/Xez5g==
X-Gm-Gg: AeBDietrbi54zcZv5Qihg88Xx7SMwS1EsiFchAZRW6ogXBZUoq75O/nDfgdSOXtb/57
 ktf3dE+fREJ6YXUvE/pacJmjKX4hrvofP1NJO0vDz540UZ3ddAs+dyHouE2a3zByam1F5na8AbU
 0tkbsht+7JAnRvH5r8u7UQUt91dImV38UcTshfC9f9R9xvSWvTR05xAJvSj9yuZoo7N2rESlkZO
 xcMnQNzEu1c79j/hKmdvkFespIL9baRk0Sr+lH4nLwnTFtB0wtNA4/2lAgliwT9jz4/jQoNeWnO
 WDnIk4nQf/sdC6YIShW6A6OXo3hi8PtrYtfK1329RYjyBFHUZGYllWJBZQsJODXl1nyos/dk6sZ
 ElVIhK9YQ0mXPEyB0iiRaft2nRXiuK1+xEmem4HI/zotu
X-Received: by 2002:ac8:5f13:0:b0:50d:6f78:39b2 with SMTP id
 d75a77b69052e-50d6f7842efmr289883931cf.38.1775667378697; 
 Wed, 08 Apr 2026 09:56:18 -0700 (PDT)
X-Received: by 2002:ac8:5f13:0:b0:50d:6f78:39b2 with SMTP id
 d75a77b69052e-50d6f7842efmr289882911cf.38.1775667377834; 
 Wed, 08 Apr 2026 09:56:17 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d712c2617sm130491901cf.31.2026.04.08.09.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:56:17 -0700 (PDT)
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
Subject: [PATCH 11/14] migration: Calculate expected downtime on demand
Date: Wed,  8 Apr 2026 12:55:55 -0400
Message-ID: <20260408165559.157108-12-peterx@redhat.com>
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

This value does not need to be calculated as frequent.  Only calculate it
on demand when query-migrate happened.  With that we can remove the
variable in MigrationState.

This paves way for fixing this value to include all modules (not only RAM
but others too).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h |  2 +-
 migration/migration.c | 25 ++++++++++++-------------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index e504df6915..32543800b6 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -359,7 +359,6 @@ struct MigrationState {
     /* Timestamp when VM is down (ms) to migrate the last stuff */
     int64_t downtime_start;
     int64_t downtime;
-    int64_t expected_downtime;
     bool capabilities[MIGRATION_CAPABILITY__MAX];
     int64_t setup_time;
 
@@ -594,6 +593,7 @@ void migration_cancel(void);
 void migration_populate_vfio_info(MigrationInfo *info);
 void migration_reset_vfio_bytes_transferred(void);
 void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
+int64_t migration_downtime_calc_expected(MigrationState *s);
 
 /*
  * Migration thread waiting for return path thread.  Return non-zero if an
diff --git a/migration/migration.c b/migration/migration.c
index a1a02e3a9f..f12cd9efd3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1041,6 +1041,17 @@ static bool migrate_show_downtime(MigrationState *s)
     return (s->state == MIGRATION_STATUS_COMPLETED) || migration_in_postcopy();
 }
 
+/* Return expected downtime (unit: milliseconds) */
+int64_t migration_downtime_calc_expected(MigrationState *s)
+{
+    if (mig_stats.dirty_sync_count <= 1) {
+        return migrate_downtime_limit();
+    }
+
+    return mig_stats.dirty_bytes_last_sync /
+        migration_get_switchover_bw(s) * 1000;
+}
+
 static void populate_time_info(MigrationInfo *info, MigrationState *s)
 {
     info->has_status = true;
@@ -1061,7 +1072,7 @@ static void populate_time_info(MigrationInfo *info, MigrationState *s)
         info->downtime = s->downtime;
     } else {
         info->has_expected_downtime = true;
-        info->expected_downtime = s->expected_downtime;
+        info->expected_downtime = migration_downtime_calc_expected(s);
     }
 }
 
@@ -1649,7 +1660,6 @@ int migrate_init(MigrationState *s, Error **errp)
     s->mbps = 0.0;
     s->pages_per_second = 0.0;
     s->downtime = 0;
-    s->expected_downtime = 0;
     s->setup_time = 0;
     s->start_postcopy = false;
     s->migration_thread_running = false;
@@ -3162,15 +3172,6 @@ static void migration_update_counters(MigrationState *s,
     s->pages_per_second = (double) transferred_pages /
                              (((double) time_spent / 1000.0));
 
-    /*
-     * if we haven't sent anything, we don't want to
-     * recalculate. 10000 is a small enough number for our purposes
-     */
-    if (mig_stats.dirty_pages_rate && transferred > 10000) {
-        s->expected_downtime =
-            mig_stats.dirty_bytes_last_sync / switchover_bw_per_ms;
-    }
-
     migration_rate_reset();
 
     update_iteration_initial_status(s);
@@ -3816,8 +3817,6 @@ void migration_start_outgoing(MigrationState *s)
     bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
     int ret;
 
-    s->expected_downtime = migrate_downtime_limit();
-
     if (resume) {
         /* This is a resumed migration */
         rate_limit = migrate_max_postcopy_bandwidth();
-- 
2.53.0


