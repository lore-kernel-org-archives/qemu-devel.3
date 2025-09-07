Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8218ACA1013
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Sep 2025 07:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uv9RB-00007o-2e; Sun, 07 Sep 2025 03:03:45 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv9R8-00005N-4N; Sun, 07 Sep 2025 03:03:43 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv9Qy-0004Pi-6m; Sun, 07 Sep 2025 03:03:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D4AF1151055;
 Sun, 07 Sep 2025 10:02:04 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id CC3ED2793C2;
 Sun,  7 Sep 2025 10:02:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 71/81] i386/kvm/vmsr_energy: Plug memory leak on
 failure to connect socket
Date: Sun,  7 Sep 2025 10:01:50 +0300
Message-ID: <20250907070205.135289-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.4-20250907000448@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250907000448@cover.tls.msk.ru>
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

vmsr_open_socket() leaks the Error set by
qio_channel_socket_connect_sync().  Plug the leak by not creating the
Error.

Fixes: 0418f90809ae (Add support for RAPL MSRs in KVM/Qemu)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250723133257.1497640-2-armbru@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
(cherry picked from commit b2e4534a2c9ce3d20ba44d855f1e2b71cc53c3a3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/kvm/vmsr_energy.c b/target/i386/kvm/vmsr_energy.c
index 31508d4e77..4be85f0bf2 100644
--- a/target/i386/kvm/vmsr_energy.c
+++ b/target/i386/kvm/vmsr_energy.c
@@ -67,13 +67,9 @@ QIOChannelSocket *vmsr_open_socket(const char *path)
     };
 
     QIOChannelSocket *sioc = qio_channel_socket_new();
-    Error *local_err = NULL;
 
     qio_channel_set_name(QIO_CHANNEL(sioc), "vmsr-helper");
-    qio_channel_socket_connect_sync(sioc,
-                                    &saddr,
-                                    &local_err);
-    if (local_err) {
+    if (qio_channel_socket_connect_sync(sioc, &saddr, NULL) < 0) {
         /* Close socket. */
         qio_channel_close(QIO_CHANNEL(sioc), NULL);
         object_unref(OBJECT(sioc));
-- 
2.47.3


