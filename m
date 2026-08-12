Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FA3C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8on-0006zF-7o; Wed, 12 Aug 2026 09:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8kq-0003d7-MQ; Wed, 12 Aug 2026 09:12:32 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8kh-0006Qb-2Z; Wed, 12 Aug 2026 09:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=kZblVJ3X3izdrsChWS2kwPvYy2L4WGgwsQTZfu0rPFo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KKTw5rOhxybQqlhwYGjL/SSc7X1esiXY57l2dhmqqYDsmTeBCN8YCIqcGyDOhCYWD
 /2CfXiEvtZFaBtnXANRexjIizANB4EbqWqCW/EAZ+olDLrMBb1Nxw8BQEAW0OZk4JY
 Qs7sCdEYDFf+joiKJfgQzi2ImvVoKpMzlX8oJhedVWw/XI/VzXPaCgosUKEnu421L/
 D0OTeSv/WAvEgfZPeam1qGsLTCvnL6yRefpspPgyFC95rgjkmjeif9GhLFcK8zJ/Mx
 bGp2j2taB9nJ2Pni2FS8j6KsnKnoblaiOj+7Os4py7ElEijP6b8ZCMMUNTTq8EWlN4
 GM97oOwrrHxNw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BD6621CA4DD;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id F3E26409BC0;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C72A92F950; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bin Guo <guobin@linux.alibaba.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 094/102] hw/display/virtio-gpu: Unmap DMA regions on
 reset
Date: Wed, 12 Aug 2026 16:02:09 +0300
Message-ID: <20260812130233.621965-94-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
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
index 4f1c6e64b12..930b069c7ec 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1695,12 +1695,14 @@ void virtio_gpu_reset(VirtIODevice *vdev)
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


