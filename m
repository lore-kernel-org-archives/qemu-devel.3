Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1BFF94CAC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 20:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFHbJ-000110-8g; Tue, 21 Apr 2026 16:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHbD-0000ye-FZ
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHbB-0008SG-VV
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776802893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0sY03HVswRoPMa35yJ23Zli6bfmgoUXGAl+akL2zYOk=;
 b=TRYleeQBxzLnxCWByB3ggMkdrrmeh+8DCnP7pKZ08tDIpEhqcAkOw4bOAtqEX8Xdi6p+mX
 NC6j7ewr30EIsFY9OjowMF9wqzXbkHo/q8+2BA0x+f8b1wfHIBSIP5iIt4r/4d2JIE+mDK
 4h4VJE5azOFLkOZLT301/xdkFlSFkI0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-yV2umeW8PXSyO-bnNpiLtA-1; Tue, 21 Apr 2026 16:21:32 -0400
X-MC-Unique: yV2umeW8PXSyO-bnNpiLtA-1
X-Mimecast-MFC-AGG-ID: yV2umeW8PXSyO-bnNpiLtA_1776802892
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8acaea1ffe7so122340746d6.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 13:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776802891; x=1777407691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0sY03HVswRoPMa35yJ23Zli6bfmgoUXGAl+akL2zYOk=;
 b=eF9oV35ck3/9uFmrp4vUro3sD06Ba1kwQLf4t6WKS3HTug4QKc27inCKC6c8sPBW0h
 kWJZMBAXAUW+tG/1apBMR01hADeNbbCgURCup38Ra4tjpS9ip3LmBI7zE5eEflLPFDFi
 JJ0OGw3BT+cDSUub6Qk+rIDXiEpVeW3kkcki18yfB2auYex+QmjjoxIA1EApO4vn2pVX
 R/e0Tsf7uKeBIszUmxj0LITf38VE+SMVehSic4TLigApcpUPtXU4bjR+vdUsng1fE4sv
 c9M3JHVaeUZT34ILBbzzryRHsnSzswvlgwkTCstAEGyY/BSv80UX863678x+pluDBlHL
 W+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776802891; x=1777407691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0sY03HVswRoPMa35yJ23Zli6bfmgoUXGAl+akL2zYOk=;
 b=KDsPKIH4mMsk8KG1IBFhzejILt1G3Cy/P3fCheBfKyFxXkj6bBNinojKFzb7/NSgi6
 zPtN7f3MaLqKqli8GAliS8n/DljUOLRraJPd0S7jZT+7KFF7MS3URMp3Bp3o4tjS2M6G
 7nV3W2ddXYMWIFK04mVDmNFClLzAuKRCoqBzbgDESSsfcGi3ejrKvA4r4iJ2ZtjnJjd9
 ufh2AQQRs5iRJyAuR2w+V5WwGpNWQeSpAHy0BRrUC+n+Mg/rIRUc5uVdfh5/SPbfCVVa
 d0cqET7upJCz+85gylNtONbOtBE1++2DOnPreCpUc+BINRaRaZIlftWktK26wMzRYUaR
 5yfw==
X-Gm-Message-State: AOJu0Yw+SVrcFEHB5a+l9gA8W7e0/ajmJ+qDAkK2w/5MT+km5M+3juwY
 c73EU98509exDvTI74usQD3TANkngRwloCOdHUwdRvjvK8i8S+ofIBXAiqPcKKyO8Z+c9iQ8xiL
 kvFhjUiIUsqJZvddP6epy0FGjD812R/M0ASNzAK3afx5kll5udmxvQv3rVW/fjWdf+rgJUJ++ua
 jvIYEMCpKGvwRDWFCP5Bc4rQyg64pYKb1aoamq2g==
X-Gm-Gg: AeBDieuJUrK4XjEACP3AYMGa6H7nf+c3T2BWaOdu4Yjw26navDs/n3guu2wIlbBu1v/
 zIPIiZ3fpZPo1cJEG22qiOTvfexT0Fzj/pWflliLWqfW84l8TpSigZ14bjETF49cAIi6h3P+LcO
 JsWO9L9FIQnXVn5Qa/sjQLZ/XDIha4Tc54d+Ozc41K4fSvDsIkxkCe90V0z8XF+1NFv2Wmp/EQe
 dyLEnMtpVSQP/mxrCwIxgB9l18kA4w3UBYzrykMGP+8mBcz3HCDnhWCIF2j0mMZYGJCdfj3z24a
 xZXQ9JXcBcgZwrILehFll9+bzdfSHFPWM0yhbPbY5sDU0kArkGzB9fLv6jKcWR27wB35Px4sSj6
 AZn5IEn9zsFringNN/fIOK5dhn6c18VE/t49Y1NUNkq93jP/WFN6k+TTmvA==
X-Received: by 2002:a05:6214:451a:b0:8aa:a025:78e3 with SMTP id
 6a1803df08f44-8b027fd1cc8mr339146546d6.6.1776802891291; 
 Tue, 21 Apr 2026 13:21:31 -0700 (PDT)
X-Received: by 2002:a05:6214:451a:b0:8aa:a025:78e3 with SMTP id
 6a1803df08f44-8b027fd1cc8mr339145756d6.6.1776802890789; 
 Tue, 21 Apr 2026 13:21:30 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae5c26csm114343556d6.31.2026.04.21.13.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 13:21:30 -0700 (PDT)
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
Subject: [PATCH v2 11/16] migration: Calculate expected downtime on demand
Date: Tue, 21 Apr 2026 16:21:05 -0400
Message-ID: <20260421202110.306051-12-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421202110.306051-1-peterx@redhat.com>
References: <20260421202110.306051-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h |  2 +-
 migration/migration.c | 25 ++++++++++++-------------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index b6888daced..ba0f9e0f9c 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -359,7 +359,6 @@ struct MigrationState {
     /* Timestamp when VM is down (ms) to migrate the last stuff */
     int64_t downtime_start;
     int64_t downtime;
-    int64_t expected_downtime;
     bool capabilities[MIGRATION_CAPABILITY__MAX];
     int64_t setup_time;
 
@@ -586,6 +585,7 @@ void migration_cancel(void);
 void migration_populate_vfio_info(MigrationInfo *info);
 void migration_reset_vfio_bytes_transferred(void);
 void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
+int64_t migration_downtime_calc_expected(MigrationState *s);
 
 /*
  * Migration thread waiting for return path thread.  Return non-zero if an
diff --git a/migration/migration.c b/migration/migration.c
index caa1d13130..d4d3534cf1 100644
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
@@ -3825,8 +3826,6 @@ void migration_start_outgoing(MigrationState *s)
     bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
     int ret;
 
-    s->expected_downtime = migrate_downtime_limit();
-
     if (resume) {
         /* This is a resumed migration */
         rate_limit = migrate_max_postcopy_bandwidth();
-- 
2.53.0


