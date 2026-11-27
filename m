Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82A5606A327
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=EhRA/sLB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWoz2-0004mm-Se; Fri, 27 Nov 2026 00:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoyq-0004f8-Bm; Fri, 27 Nov 2026 00:58:45 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoyo-0005ye-J7; Fri, 27 Nov 2026 00:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758877; bh=ohryyHM8xi8veBuXZW0Ev9s9KUmmeGrqP4MHu9NnNWw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EhRA/sLBgv2vae4Ug37AJG6b+3hrpeUb7n+2924Gd18Nq6qocpHFVyNr1uySqXr6H
 qH6zjP1PbJXEhpVXYsniWkGLo15uZx8OZbRtnnlWenMYL7+UT6HijJ+NxJm3tfxwl2
 ptBLprOYDEXAA8TdBL0xXqVALcv+jZESYZ0N8iQxsvJD7yCnrX5Aj8FfWYq1adtwCP
 nwTjxPWWosJpsMolbA0kZhSfd+deIdAek+Iwu7eRkt7ktjFpqqpUDnJ9N3XJtGiUoR
 TIbr20iA3s9dSyyY8LYnDB8dqhMeEvkBrW7dK1fYyDW1a2oya16EoNjeras4iUJi4I
 h34eOd+ExF6YA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CDF1B1EA2F3;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CBD5346992E;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AAA41CF268; Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, GuoHan Zhao <zhaoguohan@kylinos.cn>,
 Michael S. Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 105/140] virtio-crypto: clean up every data queue
Date: Fri, 27 Nov 2026 08:53:31 +0300
Message-ID: <20261127055421.39015-46-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

realize() creates max_queues data queues and one BH for each of them.
unrealize() decides how many to tear down from multiqueue, but nothing ever
sets that field, so it only deletes the first queue and BH.

It does not matter how many queues the guest used here.  unrealize() must
undo all the allocations made by realize(), so loop over max_queues.

Fixes: 20cb2ffd5ff3 ("virtio-crypto: using bh to handle dataq's requests")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260728111217.573046-1-zhaoguohan@kylinos.cn>
(cherry picked from commit b35d34e3ccd1d377702182d9d0f2185dc69e7ea8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 3a3de080a4b..dcff927568a 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1108,10 +1108,9 @@ static void virtio_crypto_device_unrealize(DeviceState *dev)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(dev);
     VirtIOCryptoQueue *q;
-    int i, max_queues;
+    int i;
 
-    max_queues = vcrypto->multiqueue ? vcrypto->max_queues : 1;
-    for (i = 0; i < max_queues; i++) {
+    for (i = 0; i < vcrypto->max_queues; i++) {
         virtio_delete_queue(vcrypto->vqs[i].dataq);
         q = &vcrypto->vqs[i];
         qemu_bh_delete(q->dataq_bh);
-- 
2.47.3


