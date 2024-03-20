Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EB4C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 06:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmpli-00029B-IY; Wed, 20 Mar 2024 02:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmplf-00027v-QU
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:49:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmpld-0001SB-Rl
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710917381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lyLOTD8VB6laQ+b2YdcTSG0HYda5sGGDND95Gi/Sjrs=;
 b=X4NZv96pAPpzICSR3vwXAu2RDm1FW3rVoUu23KadkjfphTDQdh071bSMCNuXjkXu3s1IZr
 jPXccQpo84ioxuJV5e8kzsqFUa8DQ0FNy0vOSQ76AnRs7kTcxO3IZCFw+AsNpjvchC22eQ
 pUj22kWa8pVL9sG5o57KA2GiC2xs8Vo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-3LyjSIyvOd-rVtedAZjiOA-1; Wed, 20 Mar 2024 02:49:36 -0400
X-MC-Unique: 3LyjSIyvOd-rVtedAZjiOA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3271285A58B;
 Wed, 20 Mar 2024 06:49:36 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 39F5E1C060A4;
 Wed, 20 Mar 2024 06:49:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-9.1 v5 04/14] migration: Always report an error in
 ram_save_setup()
Date: Wed, 20 Mar 2024 07:49:00 +0100
Message-ID: <20240320064911.545001-5-clg@redhat.com>
In-Reply-To: <20240320064911.545001-1-clg@redhat.com>
References: <20240320064911.545001-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

This will prepare ground for future changes adding an Error** argument
to the save_setup() handler. We need to make sure that on failure,
ram_save_setup() sets a new error.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/ram.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 8deb84984f4a8e9bcdcbdba7d83ce56e406adddf..44d7073730c67fa09ab9a59a712e74d8b088bff4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3074,12 +3074,14 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     int ret, max_hg_page_size;
 
     if (compress_threads_save_setup()) {
+        error_report("%s: failed to start compress threads", __func__);
         return -1;
     }
 
     /* migration has already setup the bitmap, reuse it. */
     if (!migration_in_colo_state()) {
         if (ram_init_all(rsp) != 0) {
+            error_report("%s: failed to setup RAM for migration", __func__);
             compress_threads_save_cleanup();
             return -1;
         }
@@ -3116,12 +3118,14 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
 
     ret = rdma_registration_start(f, RAM_CONTROL_SETUP);
     if (ret < 0) {
+        error_report("%s: failed to start RDMA registration", __func__);
         qemu_file_set_error(f, ret);
         return ret;
     }
 
     ret = rdma_registration_stop(f, RAM_CONTROL_SETUP);
     if (ret < 0) {
+        error_report("%s: failed to stop RDMA registration", __func__);
         qemu_file_set_error(f, ret);
         return ret;
     }
@@ -3138,6 +3142,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     ret = multifd_send_sync_main();
     bql_lock();
     if (ret < 0) {
+        error_report("%s: multifd synchronization failed", __func__);
         return ret;
     }
 
@@ -3147,7 +3152,11 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     }
 
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
-    return qemu_fflush(f);
+    ret = qemu_fflush(f);
+    if (ret < 0) {
+        error_report("%s failed : %s", __func__, strerror(-ret));
+    }
+    return ret;
 }
 
 static void ram_save_file_bmap(QEMUFile *f)
-- 
2.44.0


