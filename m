Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A17C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWT8-0006w7-08; Wed, 22 Jul 2026 08:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWRn-0002yY-Le; Wed, 22 Jul 2026 08:53:15 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWRm-0002WM-2v; Wed, 22 Jul 2026 08:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724574; bh=MuV1oD5RodqMA6o5+FYCUAy4Fie0JGoNBFuB3N1Fy3k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RWjLToWqjRPzY79PbnkIT4ryEYbe9ryHMWmblyDbNmXg1hDxshg4xZJHnzokx15KJ
 hmH35iEo3LUo/6qBLbsh4IMedK6R4snc1b2xXV6LYdmlgSzJ2fW3nK6luvluxNDDBu
 oUvQBfGIdoYNmdn9++4XEALyhYjUsDwgAdiWA9NQ4YIv6hOfFFai0pxtJ1nHwy237j
 /5ioztSV3ewTceCvaAI4Nx6zXtrgWmioyD5/InRv/K7LQyJj9jzHW6hW60XtX5kDka
 Q9DX0jHTehIghHkoVjwyF4HdXSPJGezrWNHApdML7gGYqLU9A+e37nnMpqkFQOAMa8
 Z3GSkRCShFWVw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DDF071C3B41;
 Wed, 22 Jul 2026 15:49:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 330473F3791;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BF0D617F57; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 100/127] hw/display/virtio-gpu: fix dmabuf_fd leak
 on remap failure
Date: Wed, 22 Jul 2026 15:48:25 +0300
Message-ID: <20260722124859.32371-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When virtio_gpu_create_udmabuf() succeeds but virtio_gpu_remap_udmabuf()
fails (mmap returns MAP_FAILED), virtio_gpu_init_udmabuf() returns early
without closing the dmabuf fd. Since res->blob is never set in this
path, later cleanup via virtio_gpu_cleanup_mapping() skips
virtio_gpu_fini_udmabuf() entirely, leaking the file descriptor.

Call virtio_gpu_destroy_udmabuf() before the early return to close
the fd. This function already handles partial state correctly: it
skips the munmap when res->remapped is NULL and closes the fd when
res->dmabuf_fd >= 0.

Fixes: 9b60cdf98723 ("virtio-gpu: Add udmabuf helpers")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260713125622.111513-1-marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 564c4d7e99d87b39c3faea52ef8759df7f786f61)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index 74b6a7766af..20884f397e9 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -143,6 +143,7 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
         }
         virtio_gpu_remap_udmabuf(res);
         if (!res->remapped) {
+            virtio_gpu_destroy_udmabuf(res);
             return;
         }
         pdata = res->remapped;
-- 
2.47.3


