Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B13E7716A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 00:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIdcr-0003IU-PR; Tue, 03 Dec 2024 19:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdca-0003EX-2b
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:52:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdcX-0005jg-8x
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733273519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2o9Ay7I+xylCE7OLCz2N3wxn74Ig5CUQWEe8c1yR3tA=;
 b=S+R4U5DKPnNNztDp09EwjkwQwaOscF1xNuKy21d3xj7rs5kJT/UNPrYZXffVE/U5L5kfKC
 /pdVxaLhxDFvNGS9atwQzEwDYtKDD5ZR+BsfDZCXYpHpEMfi+x8uupWhz1955rowc1GWJ5
 tixJAR9XOEEhiVuSpUdnqj0zH3vIF2k=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-KAHrG_rzOdOUT933QscutA-1; Tue, 03 Dec 2024 19:51:58 -0500
X-MC-Unique: KAHrG_rzOdOUT933QscutA-1
X-Mimecast-MFC-AGG-ID: KAHrG_rzOdOUT933QscutA
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d8860ab00dso73556976d6.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 16:51:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733273517; x=1733878317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2o9Ay7I+xylCE7OLCz2N3wxn74Ig5CUQWEe8c1yR3tA=;
 b=gTVdZ70sIcOdnlVEFSwgrV5qq6lvEe4RG/2dkr20V7uV9rzbnD56h8HG0aextkm17k
 m1zX9YTrOIQNvLBqKu33SkeATLLRKFAqk8IWfOGDRi3i2dNY/PegxB1AGtlzgUYu4nbf
 FewfGNaEQrJgmsDVLD7cB+J6XfBrZTOSnUDOzZ5imJocJl+2ryaSvAHQ6xitXEqgXwhF
 Y5XIo4Qs72Bhc3FFVdQQnvvsXcw7FiKl3U+qGTBOLshcPTX2FB9Kur/SjPGlMaAvISmX
 NnTWEjTY2rYMC9DsZZOQrwR8Dse1YWQXPTs92W5FDdHokqKZvlCjVgpD7WVA86TgUdZ4
 cnRw==
X-Gm-Message-State: AOJu0YwKE4TFE7OkZfk+8PqAQ3gptGky9XZKDIuqNK6xOeBSFEpNfe+E
 BE4PKDLwpIVz2weQDBmfdCS5mMprIHyzlbahimSwXU8T3PuNsCsAur18ktFAMdlYNtOoZMxs2RE
 TeKSW02Qj1kmogySPksCWQox4MCg2kwO+vUdoA/HYFTpe2CAAgfmZABAisyPDgjDWaihnbRVK8y
 2HPpC/1CoeU8YmZyOBJ28VO9WoEiSIUIf+OA==
X-Gm-Gg: ASbGncu/zWt40junuKqoKif1JdnhDVufWRwTRaeqoOg02DbunEFjdx81a5JTTRWLqxS
 sxD2zo5GvlXVHCz4CNFMpLjfClPshLiFHmsVMiI+zaHipVaBmEzJcahCQpu94KtACC1M9Y6yhhn
 OLBpz1Tb1I59pgzbx1X5OYOLjmMV3MsF65PP9hCOtYN25hfvRMvyUu62MfofEpqz/KJmYiWyQX9
 4feo7P6p4CY07VLPomBGIHJnO7QxeaM72kUa7YWRfgvtgk8C1DhVbHkZqzJwtJ4jCuImJpd10q8
 d3cuZrKckO3/w+et7LC84iQSKQ==
X-Received: by 2002:a05:6214:c85:b0:6d8:9124:8799 with SMTP id
 6a1803df08f44-6d8b72f1f6dmr77855936d6.5.1733273516406; 
 Tue, 03 Dec 2024 16:51:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSCNQw8j7E14VNPjP3P6I4wf6VCAZ9mSIt9xG51R5aX1oKUj8/MP/VArfso8yNho0pXXHkbQ==
X-Received: by 2002:a05:6214:c85:b0:6d8:9124:8799 with SMTP id
 6a1803df08f44-6d8b72f1f6dmr77854586d6.5.1733273514563; 
 Tue, 03 Dec 2024 16:51:54 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b68492cb81sm559974785a.34.2024.12.03.16.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 16:51:53 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, peterx@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH RFC 07/11] migration/block: Apply the migration_block_* API to
 postcopy
Date: Tue,  3 Dec 2024 19:51:34 -0500
Message-ID: <20241204005138.702289-8-peterx@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Postcopy also has similar error handling for re-activation of block
devices.  Use the same API as precopy to do the re-activation, for both src
& dst sides.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 22 +++-------------------
 migration/savevm.c    | 10 ++++------
 2 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index e01264168f..1a1c570c5b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2544,7 +2544,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     QIOChannelBuffer *bioc;
     QEMUFile *fb;
     uint64_t bandwidth = migrate_max_postcopy_bandwidth();
-    bool restart_block = false;
     int cur_state = MIGRATION_STATUS_ACTIVE;
 
     if (migrate_postcopy_preempt()) {
@@ -2580,13 +2579,10 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         goto fail;
     }
 
-    ret = bdrv_inactivate_all();
-    if (ret < 0) {
-        error_setg_errno(errp, -ret, "%s: Failed in bdrv_inactivate_all()",
-                         __func__);
+    if (!migration_block_inactivate(ms)) {
+        error_setg(errp, "%s: Failed in bdrv_inactivate_all()", __func__);
         goto fail;
     }
-    restart_block = true;
 
     /*
      * Cause any non-postcopiable, but iterative devices to
@@ -2656,8 +2652,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         goto fail_closefb;
     }
 
-    restart_block = false;
-
     /* Now send that blob */
     if (qemu_savevm_send_packaged(ms->to_dst_file, bioc->data, bioc->usage)) {
         error_setg(errp, "%s: Failed to send packaged data", __func__);
@@ -2702,17 +2696,7 @@ fail_closefb:
 fail:
     migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                           MIGRATION_STATUS_FAILED);
-    if (restart_block) {
-        /* A failure happened early enough that we know the destination hasn't
-         * accessed block devices, so we're safe to recover.
-         */
-        Error *local_err = NULL;
-
-        bdrv_activate_all(&local_err);
-        if (local_err) {
-            error_report_err(local_err);
-        }
-    }
+    migration_block_activate(ms);
     migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
     bql_unlock();
     return -1;
diff --git a/migration/savevm.c b/migration/savevm.c
index a335344c75..2ce5064efc 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2120,7 +2120,6 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
 
 static void loadvm_postcopy_handle_run_bh(void *opaque)
 {
-    Error *local_err = NULL;
     MigrationIncomingState *mis = opaque;
 
     trace_vmstate_downtime_checkpoint("dst-postcopy-bh-enter");
@@ -2141,12 +2140,11 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
     if (autostart) {
         /* Make sure all file formats throw away their mutable metadata.
          * If we get an error here, just don't restart the VM yet. */
-        bdrv_activate_all(&local_err);
+        bool success = migration_block_activate(migrate_get_current());
+
         trace_vmstate_downtime_checkpoint("dst-postcopy-bh-cache-invalidated");
-        if (local_err) {
-            error_report_err(local_err);
-            local_err = NULL;
-        } else {
+
+        if (success) {
             vm_start();
         }
     } else {
-- 
2.47.0


