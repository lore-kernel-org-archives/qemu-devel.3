Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FA6C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 06:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmpmL-0002XR-JP; Wed, 20 Mar 2024 02:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmpm8-0002Ni-KD
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:50:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmpm7-0001mE-14
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710917410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rQYri4x9zoiEmnX7+Ww1MDVHOzi45PAKj/KXcfEnRmA=;
 b=VKOBFMyf54Kyxz3FBiFxRmGE6lf3E6Pvm/La8lxAbU93GTm8MG3Hhki7dc6kbIBKI/7jXq
 zygFdsty0bh5k9iY4FHDd2h87YoB64FNt/GEIoINf7GeImfWpN2LcDZ0JZY4SQfoMLsbD5
 JQ/HavZ+OowYFwD11GKeMGZhDwbH51o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-zz3GZXo3M-iLVkW9jqvo5w-1; Wed, 20 Mar 2024 02:50:06 -0400
X-MC-Unique: zz3GZXo3M-iLVkW9jqvo5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B66D101A588;
 Wed, 20 Mar 2024 06:50:06 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4346D1C060A4;
 Wed, 20 Mar 2024 06:50:04 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-9.1 v5 14/14] migration: Modify ram_init_bitmaps() to
 report dirty tracking errors
Date: Wed, 20 Mar 2024 07:49:10 +0100
Message-ID: <20240320064911.545001-15-clg@redhat.com>
In-Reply-To: <20240320064911.545001-1-clg@redhat.com>
References: <20240320064911.545001-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The .save_setup() handler has now an Error** argument that we can use
to propagate errors reported by the .log_global_start() handler. Do
that for the RAM. The caller qemu_savevm_state_setup() will store the
error under the migration stream for later detection in the migration
sequence.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Changes in v5:

 - Took into account changes of ram_state_init() and xbzrle_init() to
   propagate the error.
   
 migration/ram.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 70797ef5d80c6ccf61fee987bbe3969041664c69..daffcd82d4f15a2defc66059e967092ebc3ec055 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2857,9 +2857,8 @@ static void migration_bitmap_clear_discarded_pages(RAMState *rs)
     }
 }
 
-static void ram_init_bitmaps(RAMState *rs)
+static bool ram_init_bitmaps(RAMState *rs, Error **errp)
 {
-    Error *local_err = NULL;
     bool ret = true;
 
     qemu_mutex_lock_ramlist();
@@ -2868,10 +2867,8 @@ static void ram_init_bitmaps(RAMState *rs)
         ram_list_init_bitmaps();
         /* We don't use dirty log with background snapshots */
         if (!migrate_background_snapshot()) {
-            ret = memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION,
-                                                &local_err);
+            ret = memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, errp);
             if (!ret) {
-                error_report_err(local_err);
                 goto out_unlock;
             }
             migration_bitmap_sync_precopy(rs, false);
@@ -2882,7 +2879,7 @@ out_unlock:
 
     if (!ret) {
         ram_bitmaps_destroy();
-        return;
+        return false;
     }
 
     /*
@@ -2890,24 +2887,23 @@ out_unlock:
      * containing all 1s to exclude any discarded pages from migration.
      */
     migration_bitmap_clear_discarded_pages(rs);
+    return true;
 }
 
-static int ram_init_all(RAMState **rsp)
+static int ram_init_all(RAMState **rsp, Error **errp)
 {
-    Error *local_err = NULL;
-
-    if (!ram_state_init(rsp, &local_err)) {
-        error_report_err(local_err);
+    if (!ram_state_init(rsp, errp)) {
         return -1;
     }
 
-    if (!xbzrle_init(&local_err)) {
-        error_report_err(local_err);
+    if (!xbzrle_init(errp)) {
         ram_state_cleanup(rsp);
         return -1;
     }
 
-    ram_init_bitmaps(*rsp);
+    if (!ram_init_bitmaps(*rsp, errp)) {
+        return -1;
+    }
 
     return 0;
 }
@@ -3104,8 +3100,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
 
     /* migration has already setup the bitmap, reuse it. */
     if (!migration_in_colo_state()) {
-        if (ram_init_all(rsp) != 0) {
-            error_setg(errp, "%s: failed to setup RAM for migration", __func__);
+        if (ram_init_all(rsp, errp) != 0) {
             compress_threads_save_cleanup();
             return -1;
         }
-- 
2.44.0


