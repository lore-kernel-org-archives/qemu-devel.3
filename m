Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AF0E7C708
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 07:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpLrq-0000qG-UE; Mon, 09 Feb 2026 02:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vpLrg-0000n9-RC
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:39:26 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vpLrb-0004g2-CK
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:39:23 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 9F59080764;
 Mon, 09 Feb 2026 10:39:17 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:129::1:13])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BdLXu72As8c0-MvEJukaS; Mon, 09 Feb 2026 10:39:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770622757;
 bh=8IVD7RRGiFXJE+iGcSo0Wd7WqDnfK/HeuPjO4lAO0cY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=XoFZFNDdQWKioOCimPaxqus1MTPLcRYGkQjc2HhR6eAl7H/291q7clie+sEvCScri
 /Q0qERCpCK5cdGkTHnrA9qco0lOqmS6/Y4AIH3FX18wfyKMkAVGFJC+Z7YypFz5A2/
 JsIetyrSY8b24H6vYfPASAHA7DTPj1l8QA0zQ48I=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH 07/10] vhost: stop reusing vq->desc (and friends) to store
 physical address
Date: Mon,  9 Feb 2026 10:39:04 +0300
Message-ID: <20260209073908.2125178-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260209073908.2125178-1-vsementsov@yandex-team.ru>
References: <20260209073908.2125178-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
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
index b43525da87..659efee2b0 100644
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


