Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9EFC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuANh-0004Ar-01; Wed, 12 Aug 2026 10:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuANQ-0003zH-MT; Wed, 12 Aug 2026 10:56:26 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAN4-00006m-UB; Wed, 12 Aug 2026 10:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546232; bh=5aTx44/tPkjRMx1m07dr23hm/+mofZyGft8shN+lqfY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lDuOvYUagAD5CeKbcsT4gh14wk4WaO9ENjGzLq2AQbICoExQOaAQwZa7rN8nbw0c4
 zpKbT4bvDdPBse3WVXAhnK3vXExSGXyGQsTZKuwkqDeyr/yFHXO7zyYPOeO8i9Ju7w
 WCl3vn9gKXiQjWsuaWGhGozT9qTOgOvI5fdnMKcw/INcYG1o8o8ms5kJiSoOYQTeV0
 9lwuB0Zr2bahntAHZhueyx8V4AYIntuGaQyS1vkejv+ETG+DY7/civiumWCbnYTZHc
 L9dS49Ll+jUaU1iOFQl5CIsa1rGRzs9mNdDZO2EKhwVW0B1Yq9/a3bOA5UqoizgiWl
 OlxsmjqjTxjew==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 465131CA63C;
 Wed, 12 Aug 2026 17:50:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A181E409D7E;
 Wed, 12 Aug 2026 17:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 0CFE52F9D3; Wed, 12 Aug 2026 17:50:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael S. Tsirkin <mst@redhat.com>,
 Xie Yongji <xieyongji@bytedance.com>,
 Stefano Garzarella <sgarzare@redhat.com>, BB CC <wywwzjj@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 056/120] libvhost-user: validate last_batch_head in
 vu_check_queue_inflights
Date: Wed, 12 Aug 2026 17:48:39 +0300
Message-ID: <20260812144955.649205-56-mjt@tls.msk.ru>
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

From: "Michael S. Tsirkin" <mst@redhat.com>

vu_check_queue_inflights uses last_batch_head from the frontend-controlled
inflight shared memory as an index into desc[] without bounds checking.
A malicious or buggy frontend can set last_batch_head >= desc_num,
causing an out-of-bounds write.

Validate last_batch_head before using it.
Note: the value is not guest-accessible so not a security vulnerability.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3974
Fixes: 5f9ff1eff3 ("libvhost-user: Support tracking inflight I/O in shared memory")
Cc: Xie Yongji <xieyongji@bytedance.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Reported-by: BB CC <wywwzjj@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <8133770c75c9907578dd551f4d468140a0a75cd2.1784892981.git.mst@redhat.com>
(cherry picked from commit bf21298c082cc5561072bbfd79216d478861a5cd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 82e16c2c969..037c6614018 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1379,6 +1379,12 @@ vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
     vq->counter = 0;
 
     if (unlikely(vq->inflight->used_idx != vq->used_idx)) {
+        if (vq->inflight->last_batch_head >= vq->inflight->desc_num) {
+            vu_panic(dev, "vu_check_queue_inflights: last_batch_head %u "
+                     "out of range (desc_num %u)",
+                     vq->inflight->last_batch_head, vq->inflight->desc_num);
+            return -1;
+        }
         vq->inflight->desc[vq->inflight->last_batch_head].inflight = 0;
 
         barrier();
-- 
2.47.3


