Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FFACD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 11:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOvj3-0006dO-CE; Mon, 18 May 2026 07:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wOviy-0006Zc-2r
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:01:28 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wOviu-0005ia-QW
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1779102079; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=GazgXwplieYD1E3kZIynTm21GjivhQWz7Fa/Q3ZVKPM=;
 b=lm3hx3GQdoJ8ovvNAcwKAkxxJan5a5qNVdlJRzY0Gn7XRl7NEVuXc0+7A8+OuNaO8mZnYCFy4dfta3c8Z1vo2Lt+G4KjXWvicF4SizvbB3YAMM4Hlq0Uz4gRlhJ4mh3Qm/VSjFUKYdFtNa0asWgBrqgKLSAsP+LWNOZ7oPeD20w=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0X38-ooA_1779102078; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X38-ooA_1779102078 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 18 May 2026 19:01:19 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH 8/8] migration/multifd: cache channel count in
 multifd_send_sync_main
Date: Mon, 18 May 2026 19:01:12 +0800
Message-ID: <20260518110112.21395-9-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260518110112.21395-1-guobin@linux.alibaba.com>
References: <20260518110112.21395-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
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

multifd_send_sync_main() is called once per RAM synchronization round
during live migration.  It iterates over all multifd channels twice
(signal loop + wait loop), calling migrate_multifd_channels()
independently in each loop header.

Cache migrate_multifd_channels() in a local thread_count variable at
function entry, matching the pattern already used in
multifd_send_setup() and multifd_recv_setup().  This eliminates 2
redundant config lookups per sync call.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 migration/multifd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index cc2fa90204..bc8aacd660 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -611,13 +611,15 @@ static int multifd_zero_copy_flush(QIOChannel *c)
 int multifd_send_sync_main(MultiFDSyncReq req)
 {
     int i;
+    int thread_count;
     bool flush_zero_copy;
 
     assert(req != MULTIFD_SYNC_NONE);
 
+    thread_count = migrate_multifd_channels();
     flush_zero_copy = migrate_zero_copy_send();
 
-    for (i = 0; i < migrate_multifd_channels(); i++) {
+    for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
         if (multifd_send_should_exit()) {
@@ -634,7 +636,7 @@ int multifd_send_sync_main(MultiFDSyncReq req)
         qatomic_set(&p->pending_sync, req);
         qemu_sem_post(&p->sem);
     }
-    for (i = 0; i < migrate_multifd_channels(); i++) {
+    for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
         if (multifd_send_should_exit()) {
-- 
2.50.1 (Apple Git-155)


