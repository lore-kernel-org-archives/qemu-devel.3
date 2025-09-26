Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1568CAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 08:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v23Z9-0007nV-JZ; Fri, 26 Sep 2025 04:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23Z6-0007is-EU; Fri, 26 Sep 2025 04:12:28 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23Yz-0000Z0-P8; Fri, 26 Sep 2025 04:12:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C2893157D56;
 Fri, 26 Sep 2025 11:10:31 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D5D90290C3A;
 Fri, 26 Sep 2025 11:10:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 14/60] vfio scsi ui: Error-check
 qio_channel_socket_connect_sync() the same way
Date: Fri, 26 Sep 2025 11:09:42 +0300
Message-ID: <20250926081031.2214971-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Markus Armbruster <armbru@redhat.com>

qio_channel_socket_connect_sync() returns 0 on success, and -1 on
failure, with errp set.  Some callers check the return value, and some
check whether errp was set.

For consistency, always check the return value, and always check it's
negative.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250723133257.1497640-3-armbru@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
(cherry picked from commit ec14a3de622ae30a8afa78b6f564bc743b753ee1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 2275d3fe39..2c03d49f97 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -885,7 +885,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
 
     sioc = qio_channel_socket_new();
     ioc = QIO_CHANNEL(sioc);
-    if (qio_channel_socket_connect_sync(sioc, addr, errp)) {
+    if (qio_channel_socket_connect_sync(sioc, addr, errp) < 0) {
         object_unref(OBJECT(ioc));
         return NULL;
     }
diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
index 6b86f01b01..aea751fb04 100644
--- a/scsi/pr-manager-helper.c
+++ b/scsi/pr-manager-helper.c
@@ -105,20 +105,15 @@ static int pr_manager_helper_initialize(PRManagerHelper *pr_mgr,
         .u.q_unix.path = path
     };
     QIOChannelSocket *sioc = qio_channel_socket_new();
-    Error *local_err = NULL;
-
     uint32_t flags;
     int r;
 
     assert(!pr_mgr->ioc);
     qio_channel_set_name(QIO_CHANNEL(sioc), "pr-manager-helper");
-    qio_channel_socket_connect_sync(sioc,
-                                    &saddr,
-                                    &local_err);
+    r = qio_channel_socket_connect_sync(sioc, &saddr, errp);
     g_free(path);
-    if (local_err) {
+    if (r < 0) {
         object_unref(OBJECT(sioc));
-        error_propagate(errp, local_err);
         return -ENOTCONN;
     }
 
diff --git a/ui/input-barrier.c b/ui/input-barrier.c
index 9793258aac..0a2198ca50 100644
--- a/ui/input-barrier.c
+++ b/ui/input-barrier.c
@@ -490,7 +490,6 @@ static gboolean input_barrier_event(QIOChannel *ioc G_GNUC_UNUSED,
 static void input_barrier_complete(UserCreatable *uc, Error **errp)
 {
     InputBarrier *ib = INPUT_BARRIER(uc);
-    Error *local_err = NULL;
 
     if (!ib->name) {
         error_setg(errp, QERR_MISSING_PARAMETER, "name");
@@ -506,9 +505,7 @@ static void input_barrier_complete(UserCreatable *uc, Error **errp)
     ib->sioc = qio_channel_socket_new();
     qio_channel_set_name(QIO_CHANNEL(ib->sioc), "barrier-client");
 
-    qio_channel_socket_connect_sync(ib->sioc, &ib->saddr, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (qio_channel_socket_connect_sync(ib->sioc, &ib->saddr, errp) < 0) {
         return;
     }
 
-- 
2.47.3


