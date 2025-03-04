Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D416BC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaOk-0001Fc-HS; Tue, 04 Mar 2025 17:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaOh-00019p-Ea
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:05:55 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaOf-00012c-8x
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:05:54 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaOa-00000000LYJ-3NIL; Tue, 04 Mar 2025 23:05:48 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 12/36] migration/multifd: Make multifd_send() thread safe
Date: Tue,  4 Mar 2025 23:03:39 +0100
Message-ID: <dd0f3bcc02ca96a7d523ca58ea69e495a33b453b.1741124640.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741124640.git.maciej.szmigiero@oracle.com>
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

multifd_send() function is currently not thread safe, make it thread safe
by holding a lock during its execution.

This way it will be possible to safely call it concurrently from multiple
threads.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 migration/multifd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index 01f427d8ed03..add6f86175c2 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -50,6 +50,10 @@ typedef struct {
 
 struct {
     MultiFDSendParams *params;
+
+    /* multifd_send() body is not thread safe, needs serialization */
+    QemuMutex multifd_send_mutex;
+
     /*
      * Global number of generated multifd packets.
      *
@@ -339,6 +343,8 @@ bool multifd_send(MultiFDSendData **send_data)
         return false;
     }
 
+    QEMU_LOCK_GUARD(&multifd_send_state->multifd_send_mutex);
+
     /* We wait here, until at least one channel is ready */
     qemu_sem_wait(&multifd_send_state->channels_ready);
 
@@ -507,6 +513,7 @@ static void multifd_send_cleanup_state(void)
     socket_cleanup_outgoing_migration();
     qemu_sem_destroy(&multifd_send_state->channels_created);
     qemu_sem_destroy(&multifd_send_state->channels_ready);
+    qemu_mutex_destroy(&multifd_send_state->multifd_send_mutex);
     g_free(multifd_send_state->params);
     multifd_send_state->params = NULL;
     g_free(multifd_send_state);
@@ -887,6 +894,7 @@ bool multifd_send_setup(void)
     thread_count = migrate_multifd_channels();
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
+    qemu_mutex_init(&multifd_send_state->multifd_send_mutex);
     qemu_sem_init(&multifd_send_state->channels_created, 0);
     qemu_sem_init(&multifd_send_state->channels_ready, 0);
     qatomic_set(&multifd_send_state->exiting, 0);

