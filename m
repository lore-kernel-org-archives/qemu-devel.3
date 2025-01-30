Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69297C02193
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 10:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdRUm-0002Ik-DQ; Thu, 30 Jan 2025 05:10:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRUk-0002Hy-GT
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:09:58 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRUj-00074I-0A
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:09:58 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRUe-00000006TxS-0eRP; Thu, 30 Jan 2025 11:09:52 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 08/33] migration/multifd: Allow premature EOF on TLS
 incoming channels
Date: Thu, 30 Jan 2025 11:08:29 +0100
Message-ID: <baf944c37ead5d30d7e268b2a4074d9acaac2db0.1738171076.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738171076.git.maciej.szmigiero@oracle.com>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.037, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Multifd send channels are terminated by calling
qio_channel_shutdown(QIO_CHANNEL_SHUTDOWN_BOTH) in
multifd_send_terminate_threads(), which in the TLS case essentially
calls shutdown(SHUT_RDWR) on the underlying raw socket.

Unfortunately, this does not terminate the TLS session properly and
the receive side sees this as a GNUTLS_E_PREMATURE_TERMINATION error.

The only reason why this wasn't causing migration failures is because
the current migration code apparently does not check for migration
error being set after the end of the multifd receive process.

However, this will change soon so the multifd receive code has to be
prepared to not return an error on such premature TLS session EOF.
Use the newly introduced QIOChannelTLS method for that.

It's worth noting that even if the sender were to be changed to terminate
the TLS connection properly the receive side still needs to remain
compatible with older QEMU bit stream which does not do this.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 migration/multifd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index ab73d6d984cf..ceaad930e141 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1310,6 +1310,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
     Error *local_err = NULL;
     bool use_packets = multifd_use_packets();
     int id;
+    QIOChannelTLS *ioc_tls;
 
     if (use_packets) {
         id = multifd_recv_initial_packet(ioc, &local_err);
@@ -1337,6 +1338,13 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
     p->c = ioc;
     object_ref(OBJECT(ioc));
 
+    ioc_tls = QIO_CHANNEL_TLS(object_dynamic_cast(OBJECT(ioc),
+                                                  TYPE_QIO_CHANNEL_TLS));
+    if (ioc_tls) {
+        /* Multifd send channels do not terminate the TLS session properly */
+        qio_channel_tls_set_premature_eof_okay(ioc_tls, true);
+    }
+
     p->thread_created = true;
     qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
                        QEMU_THREAD_JOINABLE);

