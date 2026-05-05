Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFC1CD3442
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMML-0004ZZ-R8; Tue, 05 May 2026 16:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMMD-0004T1-2n
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMMB-0002dV-FD
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778012822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WZf+roECEzrRMn9PvQ2Od9IyuK2k8H7PDFoPmYm9/54=;
 b=CV+cO9gMx+9N9G1Qg6uCVNC4ooxptbxLMwxeA7HcwN9w7d4pn2TazlbA/XvtaRUSh3D4Mc
 LcmbpW09hG7DRnmvGv6pk9RG2eNWyX6rU1enP+fFT0HWjVzAKHczKEydUifD8MvJG1TOiB
 FCgM00wLv9RZyEs7JX2drNKHtUCx4pY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-Z1ktgMWzMAWAtXN9U5DPBQ-1; Tue, 05 May 2026 16:27:01 -0400
X-MC-Unique: Z1ktgMWzMAWAtXN9U5DPBQ-1
X-Mimecast-MFC-AGG-ID: Z1ktgMWzMAWAtXN9U5DPBQ_1778012821
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50da529ff48so133026111cf.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778012820; x=1778617620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WZf+roECEzrRMn9PvQ2Od9IyuK2k8H7PDFoPmYm9/54=;
 b=QAULvYuUlFx4luh36bL8yQPWJAwdaYf1KpIcnCJmxvmjNm3we817OqVLp54TeEJrXo
 pubzMkSIlojDcNjCxUx+TsGic1ZKdzYIZOq37n3+aGvJrt3/iqB8z5xbj5eR+usCBjzI
 soQRPpl/0wo9CPRIvI4vv34/CYwhERjcrGAjau5XLWMob1TeLqinEPiHwGq5BtrA5rmm
 g5/O7mdvydOp3gm7N4WuKyS4k8O2248BCqkKMaPy2oXPfG/AqVRqJ6JhLIXWPjdLJAEs
 GRE27o2zQWgzvAPkjQnm8hnkELymhxkNKAao1UwqVWP24xGmWaak2o71BVLE2C+FCH/k
 XelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012820; x=1778617620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WZf+roECEzrRMn9PvQ2Od9IyuK2k8H7PDFoPmYm9/54=;
 b=EQXe4BuoyFKVUyx/N/gTp028Xt2Wb9/b4Cna0hz/p7douClMPZFT3WZagMqcfb/pgP
 rJEPtXeztq7oKDytXQLLWr0si0MnrroUTl1G2fjtqnLETZ/6JmZJ/GK+r0jtd8W3iHDn
 byJIQmEWk1CD5xC3M4E9Lm6MBGeKKwrRIX5Afxwcsut22HZWtuQooAQC5w2xoWlVMiDj
 Bckg5+3SsBsrlP1ioLvnIBcGx+i3UXAA0wm1xyUn1LC3LnYWGpjD/TIZSayRALk6jmY8
 SiZLppF5Bc0snDSa1ut+wFFFvhyKbCWB6S6Eoi+awqzHc8YFSNeitdCUttUqc/srqgmF
 mYDQ==
X-Gm-Message-State: AOJu0YxGUbM5v+NMZtLjy3UirLowNN7KsH6fS38SdWKrdpRzkR1H35TN
 ggOSIC8LfkAc+4Gck3U4xROLVbE4sntpOa/ocPQcdOKtxMW16QPK7Rz8CheNB2OCw/BG9x3VfhP
 dKDuqoSSFEKqZViI7KYwj4bW1NDnlVwFwTC/xPpqQg6aDLbvk5DkKfqrrrWLLvZxCAPP0u+Qt2z
 No3+LJclAiCJFZrP3ILzkBmNaU8E/XbBnrjXA6pA==
X-Gm-Gg: AeBDieuyEDGqHzH72xQSkQM8RDOGIWu81pCgds7EZQyQk8rLl+0wGh9p9vVGB00L6YX
 jvSsXINy98aEefwrfwgJ8bMdNXF/MRAjXyXv7IJlup84RfAV8TmgQ5A+RKRtaDAAurda1jWMi02
 3iwG9kvgsIRO95VKUrd4jLM9wT6ep4Rc5KuAzwmqWvtMyby7SwlIjlNN81Ox3M+Ol3vQHxBdeuk
 mQurNNm2dkgXgWRHXOtiL8HKfFCtN/yByB9vr5dK6qBTdMbCwQoyaVsDSs2PRp6Y9L4ohtvCGuI
 peVNb2OnpDxwlcV2spVBVbiA4mGVFGLPpFwRp6djB8xKZ1u50HQmzBZSiwsP2UCiFDPiaAk0ZVq
 t1K9gAUrGNGwuQRKMvPbTWbEVUHyEEmkuVtqIOX/2Vcse95Z4rQUo3qg=
X-Received: by 2002:a05:622a:242:b0:50d:a6a0:8f09 with SMTP id
 d75a77b69052e-51461f7f0c8mr9083911cf.39.1778012820262; 
 Tue, 05 May 2026 13:27:00 -0700 (PDT)
X-Received: by 2002:a05:622a:242:b0:50d:a6a0:8f09 with SMTP id
 d75a77b69052e-51461f7f0c8mr9083191cf.39.1778012819421; 
 Tue, 05 May 2026 13:26:59 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c6b8123sm155283806d6.35.2026.05.05.13.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 13:26:59 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 13/23] migration: Calculate expected downtime on demand
Date: Tue,  5 May 2026 16:26:30 -0400
Message-ID: <20260505202640.1011006-14-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505202640.1011006-1-peterx@redhat.com>
References: <20260505202640.1011006-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

This value does not need to be calculated as frequent.  Only calculate it
on demand when query-migrate happened.  With that we can remove the
variable in MigrationState.

This paves way for fixing this value to include all modules (not only RAM
but others too).

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20260421202110.306051-12-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h |  2 +-
 migration/migration.c | 25 ++++++++++++-------------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 9081e6a612..a5e064a1ac 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -359,7 +359,6 @@ struct MigrationState {
     /* Timestamp when VM is down (ms) to migrate the last stuff */
     int64_t downtime_start;
     int64_t downtime;
-    int64_t expected_downtime;
     bool capabilities[MIGRATION_CAPABILITY__MAX];
     int64_t setup_time;
 
@@ -585,6 +584,7 @@ void migration_cancel(void);
 void migration_populate_vfio_info(MigrationInfo *info);
 void migration_reset_vfio_bytes_transferred(void);
 void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
+int64_t migration_downtime_calc_expected(MigrationState *s);
 
 /*
  * Migration thread waiting for return path thread.  Return non-zero if an
diff --git a/migration/migration.c b/migration/migration.c
index 4e19fe3409..d740d9df85 100644
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
@@ -3166,15 +3176,6 @@ static void migration_update_counters(MigrationState *s,
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
@@ -3841,8 +3842,6 @@ void migration_start_outgoing(MigrationState *s)
     bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
     int ret;
 
-    s->expected_downtime = migrate_downtime_limit();
-
     if (resume) {
         /* This is a resumed migration */
         rate_limit = migrate_max_postcopy_bandwidth();
-- 
2.53.0


