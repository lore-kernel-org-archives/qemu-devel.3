Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE56606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=g+pMcGRw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWoz6-0004qw-VN; Fri, 27 Nov 2026 00:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoyo-0004d7-GZ; Fri, 27 Nov 2026 00:58:43 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoyl-00034X-3F; Fri, 27 Nov 2026 00:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758877; bh=fZpuf9u1CfTxyvQzKvT6r6tvgyc82du176+li/6ETIE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=g+pMcGRwax8jjqfFeVRY481b67aV/+5AlFb4oCMprNuSn7Gh7D9GuzfBOa8XyVh5g
 z6qVd0TV9656MlOUiYeOQXbTGn8r7UzC8j6hT/hsnV6Cgjn4jVUpdnlflI4FM7C3C3
 BxyaEF4ziOmkld2pokoWDSWxaYwL+ojvKYwiGxSI8KkrKMXIhSnlpl4dRa75qzyjcC
 YRk9aGesFHoRH0QYGGrUDC0y9YJDfq1i35pbTJvfF9xrDCnpiEpU+idqr/csmcywyW
 iOeEW3uuNbz4bf4HdsNGH+JnlS9T/0LN3ahcy6DnwrA65hIuBWR7ig2Sf82QpA/HDp
 dCNCG2UTposIg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C99A01EA2F2;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C750646992D;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A7DBCCF266; Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Li RongQing <lirongqing@baidu.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Michael S. Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 104/140] virtio: Reset free_head on shadow
 virtqueue start
Date: Fri, 27 Nov 2026 08:53:30 +0300
Message-ID: <20261127055421.39015-45-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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

From: Li RongQing <lirongqing@baidu.com>

free_head tracks the index of the next free descriptor in the SVQ
descriptor ring.  It is used by vhost_svq_vring_write_descs() to
choose where to place new descriptors, and is updated as descriptors
are allocated and recycled.

free_head is zero-initialized when the SVQ is created through
vhost_svq_new() (g_new0), but it is not reset in vhost_svq_start().
The start function already resets the rest of the ring state
(shadow_avail_idx, shadow_used_idx, last_used, last_used_idx and
num_free), yet free_head is left untouched.

Since an SVQ can be stopped and restarted on the same object, for
example across vDPA device migration or control virtqueue processing,
a stale free_head from the previous run survives into the new one.
This causes new descriptors to be written at the wrong position of
the SVQ descriptor ring, corrupting it.

Reset free_head to 0 in vhost_svq_start() so that descriptor
allocation always begins from the head of a fresh ring.

Fixes: 100890f7cad5 ("vhost: Shadow virtqueue buffers forwarding")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261104020053.2548-1-lirongqing@baidu.com>
(cherry picked from commit 1d0777c4b64ed0a94e0fce8165d8e080753306fc)
(Mjt: context fixup for 10.0.x)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 2481d49345d..f0535745fd7 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -688,6 +688,7 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
     svq->next_guest_avail_elem = NULL;
     svq->shadow_avail_idx = 0;
     svq->shadow_used_idx = 0;
+    svq->free_head = 0;
     svq->last_used_idx = 0;
     svq->vdev = vdev;
     svq->vq = vq;
-- 
2.47.3


