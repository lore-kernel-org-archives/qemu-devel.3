Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE1FCD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 11:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOvj1-0006at-AX; Mon, 18 May 2026 07:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wOviw-0006YK-OU
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:01:26 -0400
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wOvit-0005iY-Ds
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1779102079; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=6zpWYZsxVFc8HgF8nKU7F6t6On57u4ibzgThAGNU7gQ=;
 b=HaU9Lpd+hVndttqzpvaSdniV98Nrh0ax64CqHRITEYTYqgEQZ5TZANnKSS7fruULLEIzardLC1/boRdk8BjPWVkCOVu7Lo60yBDpDo2zLl+MmEWQaAISg1mkg18Mtc836mTvqQeRMe8S0I5pR64JTt/yX6kP37c4I5vrXC/fUGM=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R581e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0X382z02_1779102078; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X382z02_1779102078 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 18 May 2026 19:01:18 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH 7/8] migration/multifd: cache migrate_multifd_channels() in
 send/recv hot paths
Date: Mon, 18 May 2026 19:01:11 +0800
Message-ID: <20260518110112.21395-8-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260518110112.21395-1-guobin@linux.alibaba.com>
References: <20260518110112.21395-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=guobin@linux.alibaba.com; helo=out30-97.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

multifd_send() and multifd_recv() are on the per-page-batch hot path
of live migration.  Both functions call migrate_multifd_channels()
multiple times (3-4 calls each) for modulo arithmetic in the
round-robin channel selection loop.

Each call goes through migrate_get_current() -> dereference
MigrationState -> read parameters.multifd_channels.  While each
individual call is cheap, these functions execute for every page
batch during the entire migration, easily millions of times.

Cache the return value in a local variable at function entry.  The
channel count is fixed for the duration of a migration and cannot
change mid-flight.

For multifd_send(): 3 calls reduced to 1.
For multifd_recv(): 4 calls reduced to 1.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 migration/multifd.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 67ee9bdf5e..cc2fa90204 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -362,13 +362,15 @@ bool multifd_send(MultiFDSendData **send_data)
     /* We wait here, until at least one channel is ready */
     qemu_sem_wait(&multifd_send_state->channels_ready);
 
+    int thread_count = migrate_multifd_channels();
+
     /*
      * next_channel can remain from a previous migration that was
      * using more channels, so ensure it doesn't overflow if the
      * limit is lower now.
      */
-    next_channel %= migrate_multifd_channels();
-    for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
+    next_channel %= thread_count;
+    for (i = next_channel;; i = (i + 1) % thread_count) {
         if (multifd_send_should_exit()) {
             return false;
         }
@@ -378,7 +380,7 @@ bool multifd_send(MultiFDSendData **send_data)
          * sender thread can clear it.
          */
         if (qatomic_read(&p->pending_job) == false) {
-            next_channel = (i + 1) % migrate_multifd_channels();
+            next_channel = (i + 1) % thread_count;
             break;
         }
     }
@@ -998,6 +1000,7 @@ bool multifd_recv(void)
     int i;
     static int next_recv_channel;
     MultiFDRecvParams *p = NULL;
+    int thread_count = migrate_multifd_channels();
     MultiFDRecvData *data = multifd_recv_state->data;
 
     /*
@@ -1005,8 +1008,8 @@ bool multifd_recv(void)
      * using more channels, so ensure it doesn't overflow if the
      * limit is lower now.
      */
-    next_recv_channel %= migrate_multifd_channels();
-    for (i = next_recv_channel;; i = (i + 1) % migrate_multifd_channels()) {
+    next_recv_channel %= thread_count;
+    for (i = next_recv_channel;; i = (i + 1) % thread_count) {
         if (multifd_recv_should_exit()) {
             return false;
         }
@@ -1014,7 +1017,7 @@ bool multifd_recv(void)
         p = &multifd_recv_state->params[i];
 
         if (qatomic_read(&p->pending_job) == false) {
-            next_recv_channel = (i + 1) % migrate_multifd_channels();
+            next_recv_channel = (i + 1) % thread_count;
             break;
         }
     }
-- 
2.50.1 (Apple Git-155)


