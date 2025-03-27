Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F563C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 14:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txoHH-0003wI-GD; Thu, 27 Mar 2025 10:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1txoGx-0003oc-Ox
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:32:07 -0400
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1txoGu-0004uJ-VP
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1743085913; x=1774621913;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=HGvZTu3bECdECkQmWu84nE9JAc7swqFOcdhxB8Nixog=;
 b=aClR1TIDMeffLBX0qpythDMTRCRAmHGJWlsqJSKEjC0MBhY6I94qTcho
 rvgYsypBi0moud9zakrarI1gH9cdC/gFG6LQ7KD6v/q5EdboVYHb5KF62
 JlbwTdgMqf7pnNtHEOHUrbIK/FzKJCLf/a4V2iR0W/Eng64K8sdnR2ITT A=;
X-CSE-ConnectionGUID: BAxdGVdqRNi+j23/ZO1PHQ==
X-CSE-MsgGUID: KR9Y163rTymEVS2dGAbcFA==
X-IronPort-AV: E=Sophos;i="6.14,280,1736809200"; 
   d="scan'208";a="567318"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
 by drago1i.eurecom.fr with ESMTP; 27 Mar 2025 15:31:49 +0100
Received: from marco-eurecom-desktop.s3.eurecom.fr (unknown [193.55.114.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtps.eurecom.fr (Postfix) with ESMTPSA id C5EF22AD9;
 Thu, 27 Mar 2025 15:31:48 +0100 (CET)
From: Marco Cavenati <Marco.Cavenati@eurecom.fr>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
	Marco Cavenati <Marco.Cavenati@eurecom.fr>
Subject: [PATCH] migration: add FEATURE_SEEKABLE to QIOChannelBlock
Date: Thu, 27 Mar 2025 15:14:53 +0100
Message-ID: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.55.113.210;
 envelope-from=Marco.Cavenati@eurecom.fr; helo=smtp.eurecom.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Enable the use of the mapped-ram migration feature with savevm/loadvm
snapshots by adding the QIO_CHANNEL_FEATURE_SEEKABLE feature to
QIOChannelBlock. Implement io_preadv and io_pwritev methods to provide
positioned I/O capabilities that don't modify the channel's position
pointer.

Signed-off-by: Marco Cavenati <Marco.Cavenati@eurecom.fr>
---
Hello, 
Please note that this depends on my previous fix [0] (which has already
been reviewed) in order to work.

The code in this patch is inspired by commit
0478b030fa2530cbbfc4d6432e8e39a16d06865b that adds the same feature to
QIOChannelFile.

Thank you,
Regards
Marco

[0] [PATCH] migration: fix SEEK_CUR offset calculation in
qio_channel_block_seek https://lore.kernel.org/all/20250326162230.3323199-1-Marco.Cavenati@eurecom.fr/t/#u
---
 migration/channel-block.c | 48 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/migration/channel-block.c b/migration/channel-block.c
index fff8d87094..741cf6f31b 100644
--- a/migration/channel-block.c
+++ b/migration/channel-block.c
@@ -30,6 +30,7 @@ qio_channel_block_new(BlockDriverState *bs)
     QIOChannelBlock *ioc;
 
     ioc = QIO_CHANNEL_BLOCK(object_new(TYPE_QIO_CHANNEL_BLOCK));
+    qio_channel_set_feature(QIO_CHANNEL(ioc), QIO_CHANNEL_FEATURE_SEEKABLE);
 
     bdrv_ref(bs);
     ioc->bs = bs;
@@ -96,6 +97,49 @@ qio_channel_block_writev(QIOChannel *ioc,
     return qiov.size;
 }
 
+#ifdef CONFIG_PREADV
+static ssize_t
+qio_channel_block_preadv(QIOChannel *ioc,
+                         const struct iovec *iov,
+                         size_t niov,
+                         off_t offset,
+                         Error **errp)
+{
+    QIOChannelBlock *bioc = QIO_CHANNEL_BLOCK(ioc);
+    QEMUIOVector qiov;
+    int ret;
+
+    qemu_iovec_init_external(&qiov, (struct iovec *)iov, niov);
+    ret = bdrv_readv_vmstate(bioc->bs, &qiov, offset);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "bdrv_readv_vmstate failed");
+        return -1;
+    }
+
+    return qiov.size;
+}
+
+static ssize_t
+qio_channel_block_pwritev(QIOChannel *ioc,
+                          const struct iovec *iov,
+                          size_t niov,
+                          off_t offset,
+                          Error **errp)
+{
+    QIOChannelBlock *bioc = QIO_CHANNEL_BLOCK(ioc);
+    QEMUIOVector qiov;
+    int ret;
+
+    qemu_iovec_init_external(&qiov, (struct iovec *)iov, niov);
+    ret = bdrv_writev_vmstate(bioc->bs, &qiov, offset);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "bdrv_writev_vmstate failed");
+        return -1;
+    }
+
+    return qiov.size;
+}
+#endif /* CONFIG_PREADV */
 
 static int
 qio_channel_block_set_blocking(QIOChannel *ioc,
@@ -177,6 +221,10 @@ qio_channel_block_class_init(ObjectClass *klass,
     ioc_klass->io_writev = qio_channel_block_writev;
     ioc_klass->io_readv = qio_channel_block_readv;
     ioc_klass->io_set_blocking = qio_channel_block_set_blocking;
+#ifdef CONFIG_PREADV
+    ioc_klass->io_preadv = qio_channel_block_preadv;
+    ioc_klass->io_pwritev = qio_channel_block_pwritev;
+#endif
     ioc_klass->io_seek = qio_channel_block_seek;
     ioc_klass->io_close = qio_channel_block_close;
     ioc_klass->io_set_aio_fd_handler = qio_channel_block_set_aio_fd_handler;
-- 
2.43.0


