Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18CFC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhrQp-0008Jb-I9; Wed, 06 Mar 2024 08:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrQm-0008Ir-5X
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:35:36 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrQb-0005Et-9e
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:35:34 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TqYMt45yWz4wyg;
 Thu,  7 Mar 2024 00:35:22 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqYMq2kXZz4wcF;
 Thu,  7 Mar 2024 00:35:19 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 08/25] migration: Always report an error in ram_save_setup()
Date: Wed,  6 Mar 2024 14:34:23 +0100
Message-ID: <20240306133441.2351700-9-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306133441.2351700-1-clg@redhat.com>
References: <20240306133441.2351700-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Changes in v4:

 - Fixed test on error returned by qemu_fflush() 
 
 migration/ram.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 003c28e1336a5fbe7a3877512b8fc3cf62f1bab3..3ac7f52a5f8e2c0d78a8cf150b3fa6611e12ffcc 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3057,12 +3057,14 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
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
@@ -3099,12 +3101,14 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
 
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
@@ -3116,6 +3120,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     ret = multifd_send_sync_main();
     bql_lock();
     if (ret < 0) {
+        error_report("%s: multifd synchronization failed", __func__);
         return ret;
     }
 
@@ -3125,7 +3130,11 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
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


