Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77568C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAUH-0005zH-KH; Wed, 12 Aug 2026 11:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuASc-0004XN-5e; Wed, 12 Aug 2026 11:01:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuASQ-0002PP-Lx; Wed, 12 Aug 2026 11:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546233; bh=YNTIuVD1IOreQrX7f0m4i8AB9XD5orFEuezT+jurEm4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VV00pufLvIKGVHWV8e9wgVfOcmZedT3BaQ7bqj2qQHGcOjmSND2YevAwWNREO9lMt
 FxhnAtvbA/h2NuERHdLXkjwaXTczmOULamnngrMuIimlfTI+Fq4W4UIe0ZBudNMKA6
 onhRYds1qyH7iBPi8A8AT+tDuRWq0kvzCwIvLv7HFC+WE7VQrYB/ekyJE73ctjo6Mz
 jKZ40Pi/LWSUoi2UyI8L0QqDnl4X6ACxS/pyZb09A9uFLFDzJIo7sXFoCv4RPwMGTb
 2hSjvJkaP7uzaj8Zfxu5yEpQC4JyfnWlKA7Zsww+68libgi0D+hoJksuI+pAfpNz5O
 gQPyvgn3URIBA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E353A1CA672;
 Wed, 12 Aug 2026 17:50:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4A321409DB7;
 Wed, 12 Aug 2026 17:50:45 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A7AC42FA3F; Wed, 12 Aug 2026 17:50:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bin Guo <guobin@linux.alibaba.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 110/120] hw/display/virtio-gpu: Unmap DMA regions on
 reset
Date: Wed, 12 Aug 2026 17:49:33 +0300
Message-ID: <20260812144955.649205-110-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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

From: Bin Guo <guobin@linux.alibaba.com>

virtio_gpu_reset() freed in-flight commands without unmapping the
DMA regions acquired by virtqueue_pop().  Call virtqueue_detach_element()
before g_free() in both drain loops.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3467
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260803082158.62998-1-guobin@linux.alibaba.com>
(cherry picked from commit 5ce01c92389a422389898df481ed441a80ece3c4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 48b8b26b2cc..01675c87deb 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1725,12 +1725,14 @@ void virtio_gpu_reset(VirtIODevice *vdev)
     while (!QTAILQ_EMPTY(&g->cmdq)) {
         cmd = QTAILQ_FIRST(&g->cmdq);
         QTAILQ_REMOVE(&g->cmdq, cmd, next);
+        virtqueue_detach_element(cmd->vq, &cmd->elem, 0);
         g_free(cmd);
     }
 
     while (!QTAILQ_EMPTY(&g->fenceq)) {
         cmd = QTAILQ_FIRST(&g->fenceq);
         QTAILQ_REMOVE(&g->fenceq, cmd, next);
+        virtqueue_detach_element(cmd->vq, &cmd->elem, 0);
         g->inflight--;
         g_free(cmd);
     }
-- 
2.47.3


