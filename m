Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3D5C5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAOE-0004Oy-Qm; Wed, 12 Aug 2026 10:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuANp-0004I8-JO; Wed, 12 Aug 2026 10:56:49 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuANS-0000RW-6S; Wed, 12 Aug 2026 10:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546232; bh=9Zyp9mobdYce4neiIE89VgKtflEMyoLOJFmFLPgWnuk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LI/lmWkC+e1qA3SRFSXHr+dPi1AfCpF51v6Fn1b0aOpRx045JznZSuj234k+GCdLH
 4vXgtjdt7jS3ScPeciGOwGAEtpxJb8z054RqJj7pEianiVy1sa3ZuXcIiJK+1tGacZ
 h4DPJhRzjy6131QGxg9xvzlIKRFtmo6/Pleba13+tRGk2Pi78Ylo5BSrMY83SDIujf
 FPKf0CQ0RPmym40VFG/CIcW//UrKbd+Ntn2+bnZnjHLiMhp8K393DO4b1BC5ZsPesm
 tVzBSOLcQYTHXcP8gQ4/jP3xhF54Gavpo7qWrOR/WOtVtBBK3Bxs/h7mpE45Ai7mgB
 vpQ6xGHXwpBDQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 547511CA63E;
 Wed, 12 Aug 2026 17:50:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AF646409D80;
 Wed, 12 Aug 2026 17:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 1B9DF2F9D7; Wed, 12 Aug 2026 17:50:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael S. Tsirkin <mst@redhat.com>,
 Jia Jia <physicalmtea@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 058/120] libvduse: validate vq size
Date: Wed, 12 Aug 2026 17:48:41 +0300
Message-ID: <20260812144955.649205-58-mjt@tls.msk.ru>
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

libvduse assumes that vq size (aka vq num) is below VIRTQUEUE_MAX_SIZE
and maps logs large enough based on this assumption.

However, vduse_queue_enable() accepts the vq size returned through
VDUSE_VQ_GET_INFO without validation, so a value above
VIRTQUEUE_MAX_SIZE (1024) overruns the inflight log and causes
out-of-bounds writes in vduse_queue_inflight_get().

According to the virtio spec, vq size can only be reduced, not
increased, so vq size must not exceed the previously configured
max_size, but the kernel vduse module does not validate this for us, and
we should not trust another process to follow the spec.

Validate and reject vq size values above VIRTQUEUE_MAX_SIZE.

Fixes: CVE-2026-61402
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3652
Reported-by: Jia Jia <physicalmtea@gmail.com>
Message-ID: <bf7e71b3139875e5e00fd53970c772d6c90dc2a1.1784888961.git.mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 733a98a552e4bd68932de1f58bd6ea39b57b261c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/subprojects/libvduse/libvduse.c b/subprojects/libvduse/libvduse.c
index df9ca5e56f2..712b97b4c3b 100644
--- a/subprojects/libvduse/libvduse.c
+++ b/subprojects/libvduse/libvduse.c
@@ -902,6 +902,11 @@ static void vduse_queue_enable(VduseVirtq *vq)
         return;
     }
 
+    if (vq_info.num > VIRTQUEUE_MAX_SIZE) {
+        fprintf(stderr, "vq[%d] vring num %u exceeds max %u\n",
+                vq->index, vq_info.num, VIRTQUEUE_MAX_SIZE);
+        return;
+    }
     vq->vring.num = vq_info.num;
     vq->vring.desc_addr = vq_info.desc_addr;
     vq->vring.avail_addr = vq_info.driver_addr;
-- 
2.47.3


