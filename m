Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C319CD98EE
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZk0I-00053J-1A; Wed, 17 Jun 2026 02:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wZk07-00050i-V9
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 02:43:52 -0400
Received: from [115.124.30.98] (helo=out30-98.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wZk03-00087l-Vv
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 02:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1781678614; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=CdH+sNES2FdBHJISfag0GHIwn/jVXYTmNClZbL3Udf8=;
 b=Kfj2ecmOK/hmjGVR1zEhQZ2UOleVwl7lS7D/zoXLxEYPAB9EdDGLjxkSYWOVqNxUxc4DxUz3A8Jzj8G/yHdHOrfT/a8PyGccm2R3UiYnZYRk6KkDLHDCI5I5fh2aHXxg0qnqUFmTqRuQTVbSpveborr8hdvHFNxLTlfZlum1fK0=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R811e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0X52TpQC_1781678613; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X52TpQC_1781678613 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 17 Jun 2026 14:43:33 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	lizhijian@fujitsu.com,
	farosas@suse.de
Subject: [PATCH v2 1/2] migration/rdma: honor blocking mode in QIOChannelRDMA
 readv
Date: Wed, 17 Jun 2026 14:43:31 +0800
Message-ID: <20260617064332.75618-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.98 (deferred)
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=guobin@linux.alibaba.com; helo=out30-98.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

QIOChannelRDMA's readv already blocks inside qemu_rdma_exchange_recv()
when waiting for the next RDMA SEND message.  What it did not do was
keep blocking when the bytes from a single receive were insufficient
to satisfy the full request -- it returned partial data (or EAGAIN)
instead of waiting for more.

Loop on qemu_rdma_exchange_recv() when the channel is blocking and
the receive buffer cannot satisfy the request.  This matches the
behaviour of other QIOChannel implementations, which block until
the full request is satisfied (or an error occurs).

Also remove the stale XXX comments about unimplemented blocking support.

Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 migration/rdma.c | 46 +++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 3e37a1d440..201cb9eb12 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -388,7 +388,7 @@ struct QIOChannelRDMA {
     QIOChannel parent;
     RDMAContext *rdmain;
     RDMAContext *rdmaout;
-    bool blocking; /* XXX we don't actually honour this yet */
+    bool blocking;
 };
 
 /*
@@ -2710,32 +2710,29 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
             break;
         }
 
-
-        /* We've got nothing at all, so lets wait for
-         * more to arrive
-         */
-        ret = qemu_rdma_exchange_recv(rdma, &head, RDMA_CONTROL_QEMU_FILE,
-                                      errp);
-
-        if (ret < 0) {
-            rdma->errored = true;
-            return -1;
-        }
-
         /*
-         * SEND was received with new bytes, now try again.
+         * We've got nothing at all, so lets wait for
+         * more to arrive.
          */
-        len = qemu_rdma_fill(rdma, data, want, 0);
-        done += len;
-        want -= len;
-
-        /* Still didn't get enough, so lets just return */
-        if (want) {
-            if (done == 0) {
-                return QIO_CHANNEL_ERR_BLOCK;
-            } else {
-                break;
+        do {
+            ret = qemu_rdma_exchange_recv(rdma, &head,
+                                          RDMA_CONTROL_QEMU_FILE, errp);
+            if (ret < 0) {
+                rdma->errored = true;
+                return -1;
             }
+
+            /*
+             * SEND was received with new bytes, now try again.
+             */
+            len = qemu_rdma_fill(rdma, data, want, 0);
+            done += len;
+            want -= len;
+            data += len;
+        } while (want && rioc->blocking);
+
+        if (want && done == 0) {
+            return QIO_CHANNEL_ERR_BLOCK;
         }
     }
     return done;
@@ -2771,7 +2768,6 @@ static int qio_channel_rdma_set_blocking(QIOChannel *ioc,
                                          Error **errp)
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
-    /* XXX we should make readv/writev actually honour this :-) */
     rioc->blocking = blocking;
     return 0;
 }
-- 
2.50.1 (Apple Git-155)


