Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33EF1091930
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3MYa-0001Qg-Ad; Thu, 19 Mar 2026 19:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYZ-0001QT-LC
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYY-0001cN-4N
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773962013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6RAHkTnj5upfaZ8SooBURZ2Qif/9bxeVdrP7OGRyeXk=;
 b=cV7iY6gBJWI64XcB9BhExjZ3Nktsm+SkDSkpqH+GBGW3CwDKi5eyV2VFVzTFZMUVYa/+Tb
 eEBtFwdDaz35urIzokdolN/yBc90UER6oIKR35ENR/Uo7uXNur3yI/sE0B+F6lr4Pl/rXz
 BYIbdYaMOmfXyFPTwOR+Gz1dwwbHCJ4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-rgZjUUthOei7N9FZm9bKGA-1; Thu, 19 Mar 2026 19:13:32 -0400
X-MC-Unique: rgZjUUthOei7N9FZm9bKGA-1
X-Mimecast-MFC-AGG-ID: rgZjUUthOei7N9FZm9bKGA_1773962012
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50937cf66b5so6337291cf.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773962011; x=1774566811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6RAHkTnj5upfaZ8SooBURZ2Qif/9bxeVdrP7OGRyeXk=;
 b=bqR1eNad5Fj9d26JyUbmBETAo/HJ31O3wHPCrDlQWKUeKkIVDR1tYgJiS5NqlqaF9F
 BGMtgzvvLUqPYvWV2DNbeUocKFJeEF8RyvPU4wt3gZW2S9lF/1wtbFExhgsxRmFNjIzX
 MhQChcPhgPewv+eZWkPllt2dAXq6Vee4JUMrVdXlOx8ORSgHc9z8hWipCR6vrg1GM/b5
 xAOlPxNE4euSMoWMd97adNaZ8DlN01KT4xd9s/ezZkqpE1enWEAmp0YRkonP6N8FVim5
 rd7bQEBPvPNdgJbb04eExyEqtvjrKazbj6CS6xN38bL++OXFLc2sUElG4Z9AZJmQl41n
 5reA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962011; x=1774566811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6RAHkTnj5upfaZ8SooBURZ2Qif/9bxeVdrP7OGRyeXk=;
 b=Ad75l0AxiZIykufu7FE2K8r4z1C0BstmoNcBjHmgEscy992chu5XRXOfsB0Gvqdbwu
 YMi9Q0McMmyBkGXeonDwhfKPAYCpeInd/4Tz1RCio8hCnnkwzpvyJ3GzLuhI+Y3myHyY
 f7YHB5PqmMDSnj1P1u2oHG1jCy+IbvBDRcyHFez3Vl8iReicWTfnvcoadPaeDm+MyGR4
 bh+BZyXqCC46RC1qKIwRd18yL/1qE07Yss47oVJygow3+u/GsV+8SG/KuHNXIRwQfqOc
 VtJUbQfOavDkRWU8ASn3EkMD45e8ldTIZE6EaH60c9yn/D3qnil0Ml44JUuHfrQNTfc+
 rZ9A==
X-Gm-Message-State: AOJu0YxB1QTxyoadwUj3ANsTBKcbEfLlDznmnO2oLKyf4g15advvMZgN
 zMDxFQWpAbx8Jws+TLxwY2hMwLBfmPcZy9l131TBk3GW5qKv+ZXtESSpi7zUavfD1f0VIrWBFwT
 Ir0gYeg8vwN4/yIbx2NcdaEqIZ6L8+Wwi5jSK19/lnVvZUvt6tHqtS3pY5W454TkDaq9JQGzSNo
 O70AyqjcTSUbEJNs6Fb/kUfn4yp+CygLFQNjNVCQ==
X-Gm-Gg: ATEYQzw0Quu6Lmi5g5Pf8ZQcROyttBwGJ4wEbyboXmsOWF8wD+ox0gk03/nfuPThBy0
 1P1KAupZCAPbskyQ8H8c5f7Xcsx4+K/BgGi/YuRvRHne6A6BjnfNLVoywnvnUUAeas/nyf6ayQh
 QK/Vb9ecG5AaSewO9HrK2GYrtAzWX3daVQYs687ZxQgdZohfTDqm0m9c1s3CgUbZ1QAf/KalsOp
 pzVoMIAUmbi8iK3Z9WU+EcJMWMH2nbo8W3lKE+7yXBza1+jT9nk27HxOPM0iI4c9hpOS+ktYWwM
 CNnsKlmXlOvW9HWRVijSoSoNIfzYcFR4Wq7FEIO4vorWrJSMy3ncRpIWFhBifDx5rh1c7G304ct
 AekYY1yo0Sg0GRQ==
X-Received: by 2002:a05:622a:1823:b0:501:5152:f49f with SMTP id
 d75a77b69052e-50b374e59aamr17037791cf.46.1773962011334; 
 Thu, 19 Mar 2026 16:13:31 -0700 (PDT)
X-Received: by 2002:a05:622a:1823:b0:501:5152:f49f with SMTP id
 d75a77b69052e-50b374e59aamr17037201cf.46.1773962010754; 
 Thu, 19 Mar 2026 16:13:30 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b36e5bee3sm6717161cf.21.2026.03.19.16.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:13:30 -0700 (PDT)
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
Subject: [PATCH RFC 11/12] migration: Calculate expected downtime on demand
Date: Thu, 19 Mar 2026 19:13:01 -0400
Message-ID: <20260319231302.123135-12-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260319231302.123135-1-peterx@redhat.com>
References: <20260319231302.123135-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This value does not need to be calculated as frequent.  Only calculate it
on demand when query-migrate happened.  With that we can remove the
variable in MigrationState.

This paves way for fixing this value to include all modules (not only RAM
but others too).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h |  1 -
 migration/migration.c | 26 ++++++++++++--------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index bf3ee6cc07..ba0f9e0f9c 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -359,7 +359,6 @@ struct MigrationState {
     /* Timestamp when VM is down (ms) to migrate the last stuff */
     int64_t downtime_start;
     int64_t downtime;
-    int64_t expected_downtime;
     bool capabilities[MIGRATION_CAPABILITY__MAX];
     int64_t setup_time;
 
diff --git a/migration/migration.c b/migration/migration.c
index 56d605ede9..23c78b3a2c 100644
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
+    return 1.0 * mig_stats.dirty_bytes_last_sync /
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
@@ -3162,16 +3172,6 @@ static void migration_update_counters(MigrationState *s,
     s->pages_per_second = (double) transferred_pages /
                              (((double) time_spent / 1000.0));
 
-    /*
-     * if we haven't sent anything, we don't want to
-     * recalculate. 10000 is a small enough number for our purposes
-     */
-    if (qatomic_read(&mig_stats.dirty_pages_rate) &&
-        transferred > 10000) {
-        s->expected_downtime =
-            qatomic_read(&mig_stats.dirty_bytes_last_sync) / expected_bw_per_ms;
-    }
-
     migration_rate_reset();
 
     update_iteration_initial_status(s);
@@ -3817,8 +3817,6 @@ void migration_start_outgoing(MigrationState *s)
     bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
     int ret;
 
-    s->expected_downtime = migrate_downtime_limit();
-
     if (resume) {
         /* This is a resumed migration */
         rate_limit = migrate_max_postcopy_bandwidth();
-- 
2.50.1


