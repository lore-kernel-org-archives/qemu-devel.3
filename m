Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FD7C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuARO-00037I-46; Wed, 12 Aug 2026 11:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuARB-0002P5-Iw; Wed, 12 Aug 2026 11:00:13 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAR9-000211-Lj; Wed, 12 Aug 2026 11:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546233; bh=RuH3/VC+XSP6K86VR8TLpSkXB5Y10wYRD9jalb+DG9A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KjKLz+r7LnmPhYBVmvIM8UuiDRb4cYVEeVmFQzjIZi1H1ELmAwaG3XWfL1BNSfXOe
 b8zau/sf6FPeHwYDBmz6Hu8rSJGGtK73STK3RWmU7mxoO7/i2ofm4XTuDQOOtLV9FF
 QWO0pl9J2xi24m9Lc0pA9mmjL/l0q+3/R6OJsS1SBkhm2PUwIC0cYbgnxOyHVfkVRf
 FZoanx7R3p7BiOmfr04D39/D3cTSC72jwq1+TfCk3LuSfXsG7qtZAu3IflDahM5dQb
 67DiolY/fkxv5aOLizStbz2bU+P5V93R6Y8x6Ui6Zm2zkyY/fczC2Bqs4LzwwLCp6Z
 ufTQqlZmWD5Fg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7D1B41CA665;
 Wed, 12 Aug 2026 17:50:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D79BE409DA7;
 Wed, 12 Aug 2026 17:50:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 40AB92FA25; Wed, 12 Aug 2026 17:50:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Tristan Madani <tristan@talencesecurity.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 097/120] dmg: refuse to open files with no chunks
Date: Wed, 12 Aug 2026 17:49:20 +0300
Message-ID: <20260812144955.649205-97-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The dmg block driver expects the disk image file to contain at least one
chunk. Refuse to open such files. This ensures that dmg block driver
state always has non-NULL s->sectors[] and related fields.

Note that the previous commit fixed the only known way to trigger a
crash. This patch is just for defense - let's avoid opening the file and
having NULL pointers in dmg block driver state.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4021
Reported-by: Tristan Madani <tristan@talencesecurity.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20260723144519.364701-3-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit ab7b872f0c38ee2a576b93cf37b9945f622d48fb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/dmg.c b/block/dmg.c
index e325127d144..6f8120e0338 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -559,6 +559,12 @@ static int dmg_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
+    /* There must be at least one chunk */
+    if (s->n_chunks == 0) {
+        ret = -EINVAL;
+        goto fail;
+    }
+
     /* initialize zlib engine */
     s->compressed_chunk = qemu_try_blockalign(bs->file->bs,
                                               ds.max_compressed_size + 1);
-- 
2.47.3


