Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1C8F5A8B9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 20:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEv76-00065R-FA; Mon, 20 Apr 2026 16:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wEv6v-00061w-TG
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:20:50 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wEv6u-0006Pi-5m
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:20:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:c00c:0:640:e0de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 87DA980675;
 Mon, 20 Apr 2026 23:20:45 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:54b::1:34])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id XKYwe10MOSw0-YFD9iBMD; Mon, 20 Apr 2026 23:20:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1776716444;
 bh=64+skN4vnGayFidRB2LVJGvoXm0N9ZAGQLAilmne80Y=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=x03BX+IAOhDhlQ++TT8lr+NhEVnfIfj04nWHQGTcI63Fqk+rDeOCknytXLRI9e5fD
 ly0N4gt5MM+nbTZZRAN4/HuTJ/x5liAK42jBPG4lY5t/ixO1IB1uHNKFLYFVwQInI9
 gX6YXFgG2LjpqmYkkKPgJFPFr67D3ojMfP9CKy7I=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH v2 07/10] vhost: stop reusing vq->desc (and friends) to store
 physical address
Date: Mon, 20 Apr 2026 23:20:28 +0300
Message-ID: <20260420202032.714884-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260420202032.714884-1-vsementsov@yandex-team.ru>
References: <20260420202032.714884-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Remove the hack of storing physical addresses in vq->desc/avail/used
pointers when IOMMU is present. Instead, handle this case directly in
vhost_virtqueue_set_addr() by checking for IOMMU presence.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index cc083572f40..6bb6b07e190 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -518,9 +518,6 @@ static int vhost_vrings_map(struct vhost_dev *dev,
     }
 
     if (vhost_dev_has_iommu(dev)) {
-        vq->desc = (void *)(uintptr_t)vq->desc_phys;
-        vq->avail = (void *)(uintptr_t)vq->avail_phys;
-        vq->used = (void *)(uintptr_t)vq->used_phys;
         return 1;
     }
 
@@ -1104,7 +1101,7 @@ static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
     int r;
     memset(&addr, 0, sizeof(struct vhost_vring_addr));
 
-    if (phys) {
+    if (phys || vhost_dev_has_iommu(dev)) {
         addr.desc_user_addr = (uint64_t)(unsigned long)vq->desc_phys;
         addr.avail_user_addr = (uint64_t)(unsigned long)vq->avail_phys;
         addr.used_user_addr = (uint64_t)(unsigned long)vq->used_phys;
-- 
2.52.0


