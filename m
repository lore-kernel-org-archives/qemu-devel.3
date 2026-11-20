Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3468D606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xURTg-0006zQ-Ob; Fri, 20 Nov 2026 11:28:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>) id 1xURTe-0006zI-4w
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 11:28:42 -0500
Received: from [115.124.28.63] (helo=out28-63.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>) id 1xURTb-0001NU-Rs
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 11:28:41 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.5102722|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00777389-0.00183146-0.990395;
 FP=7954384019212824274|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033037006180;
 MF=mail@jiesong.me; NM=1; PH=DS; RN=7; RT=7; SR=0;
 TI=SMTPD_---.k6lCHAf_1795191629; 
Received: from Moon.localdomain(mailfrom:mail@jiesong.me
 fp:SMTPD_---.k6lCHAf_1795191629 cluster:ay29) by smtp.aliyun-inc.com;
 Sat, 21 Nov 2026 00:21:11 +0800
From: Jie Song <mail@jiesong.me>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, peterx@redhat.com, farosas@suse.de,
 avihaih@nvidia.com, Jie Song <songjie_yewu@cmss.chinamobile.com>
Subject: [PATCH] vfio/migration: Use qemu_put_buffer_async to avoid an extra
 copy
Date: Sat, 21 Nov 2026 00:20:26 +0800
Message-ID: <20261120162026.31245-1-mail@jiesong.me>
X-Mailer: git-send-email 2.48.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.63 (deferred)
Received-SPF: pass client-ip=115.124.28.63; envelope-from=mail@jiesong.me;
 helo=out28-63.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jie Song <songjie_yewu@cmss.chinamobile.com>

Replace qemu_put_buffer with qemu_put_buffer_async + qemu_fflush in
vfio_save_block to avoid an unnecessary memcpy of device state data
through QEMUFile's 32 KiB internal buffer.

With qemu_put_buffer_async, the data_buffer pointer is added directly
to the iov array. Since the next read overwrites the same buffer,
flush immediately so that the channel has consumed the data before
the buffer is reused.

Signed-off-by: Jie Song <songjie_yewu@cmss.chinamobile.com>
---
 hw/vfio/migration.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 69d50cebdd..e363250b79 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -476,7 +476,8 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
 
     qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
     qemu_put_be64(f, data_size);
-    qemu_put_buffer(f, migration->data_buffer, data_size);
+    qemu_put_buffer_async(f, migration->data_buffer, data_size, false);
+    qemu_fflush(f);
     vfio_migration_add_bytes_transferred(data_size);
 
     trace_vfio_save_block(migration->vbasedev->name, data_size);
-- 
2.48.1


