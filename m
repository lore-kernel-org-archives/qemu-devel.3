Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D0FCD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 07:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSrGx-0000WC-54; Fri, 29 May 2026 03:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wSrGm-0000VY-4D
 for qemu-devel@nongnu.org; Fri, 29 May 2026 03:04:37 -0400
Received: from [115.124.30.101] (helo=out30-101.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wSrGj-0008BE-Ks
 for qemu-devel@nongnu.org; Fri, 29 May 2026 03:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780038251; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=7+C14dR0GlrhuSHKR315K7FEJDVBDQmOfdM8LokophA=;
 b=sTPFqc5/FuqCA8Zvi1LlnGf9MIkfZytsOLxbU8T1IbOCP/bM5QeeXSTnyeKaVhJux6Ns5f4/allQ6NXo7kX1bILYrppbx0TsNBOY4RcaoIWhXRjOR9muYf2qE3offQeWWxl3pwFd7JWrWRqE0yVRaB5oh1jQWY/VNgi6ixzE2uA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0X3ofNIT_1780038250; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X3ofNIT_1780038250 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 29 May 2026 15:04:10 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 1/2] migration/rdma: honor blocking mode in QIOChannelRDMA
 readv
Date: Fri, 29 May 2026 15:04:07 +0800
Message-ID: <20260529070408.92651-2-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260529070408.92651-1-guobin@linux.alibaba.com>
References: <20260529070408.92651-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.101 (deferred)
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
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

QIOChannelRDMA's readv ignored the blocking flag set via
io_set_blocking.  In blocking mode it returned immediately instead
of waiting for data, unlike other QIOChannel implementations.

Loop on qemu_rdma_exchange_recv() when the channel is blocking and
the receive buffer cannot satisfy the request.  Also remove the
stale XXX comments about unimplemented blocking support.

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


