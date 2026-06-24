Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F95CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNrM-0008KI-H2; Wed, 24 Jun 2026 09:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNr3-00080v-0d; Wed, 24 Jun 2026 09:41:25 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNr1-0001om-5M; Wed, 24 Jun 2026 09:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782308000; bh=CEWfNtl3ujQvy6+5b3hQDwhS9J6oM/M5tL9TtqaGx10=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=v04wyeFjXmqvu5F8gtSI0WXANV1U43dv3qtFeY1chhP7AneIKkMy6IzickNtqXR0f
 cCepAJBo2swUf1iQUFejCIqSf5179+ZW2zicb3j7P76Fi3tDeARqRdx5SeccX2Oaid
 tfAzWbJPvU3CQ0OJWkTse1rgb6F6xq/i+Tga+q5sTJKN7jQJicBUZYKmDCmIcxYmin
 DeCyuaRWPU5vHIC9XXoAcwpnrYvfb4Bzux/lW7g00kj63a78R0OFMPaabehVVOTVvf
 en9QbY7J6r6qvRH0XBisXZa/n9GW56NpJ1HrcT+Y/CidLdvWB8fKYfMVPGsROM8TN1
 kLqN7FimDW2aA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F30851BAA04;
 Wed, 24 Jun 2026 16:33:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 861593DEA53;
 Wed, 24 Jun 2026 16:33:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 082/107] virtio: Allow to fill a whole virtqueue in
 order
Date: Wed, 24 Jun 2026 16:31:27 +0300
Message-ID: <20260624133301.403266-82-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Eugenio Pérez <eperezma@redhat.com>

As the while steps < max_steps is already one less than the vq size, the
right maximum max_steps variable is queue length, not the maximum
possible remainder of % vq->vring.num.

Fixes: b44135daa37 ("virtio: virtqueue_ordered_fill - VIRTIO_F_IN_ORDER support")
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260304173535.2702587-2-eperezma@redhat.com>
(cherry picked from commit eceff0982f97cc79a26883b93f8eac05cd126dd8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 8fcf6cfd0b..b337c50c74 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -986,7 +986,7 @@ static void virtqueue_ordered_fill(VirtQueue *vq, const VirtQueueElement *elem,
      * We shouldn't need to increase 'i' by more than or equal to
      * the distance between used_idx and last_avail_idx (max_steps).
      */
-    max_steps = (vq->last_avail_idx - vq->used_idx) % vq->vring.num;
+    max_steps = MIN(vq->last_avail_idx - vq->used_idx, vq->vring.num);
 
     /* Search for element in vq->used_elems */
     while (steps < max_steps) {
-- 
2.47.3


