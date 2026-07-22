Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEE5C4453E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWPf-0000O0-RS; Wed, 22 Jul 2026 08:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWNJ-0003Vz-7y; Wed, 22 Jul 2026 08:48:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWNE-0001pk-S1; Wed, 22 Jul 2026 08:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724390; bh=1seprXnsYVDP6RSygJDgnEkbj5/o825APt3WEXJncN4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BBgLG+j7x7uswCndJfVOyhg8Qr85mkgNH+zd6dllfXmOW2vsRgPihonNrNCIWHgmS
 B4o8DDistLuczJOG883PwldSA8QSdVgLq4PeK4ya/plaAjJnwpxply+g+AOnzUeUH+
 Hr8dnvYdAE1Ru0NXPn7QVCmndz/BqD+vaaY7Ha9HUN50YdJU+FUq6Indj0NiKVIWPp
 osjh5b3cf8r6pOimRwWY0IiBoJzkpYkloxX1DWmV40C/StcUjjAZAtcqTIjZ1yRGTB
 WIvoRZrTllhpGnHA8VBaXy6FyCof/g+Lf5w8QiJzNv4Lf87yhXRw0b6WtlIaghRmdj
 iMpa6NmHFP1hg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9B31D1C3B09;
 Wed, 22 Jul 2026 15:46:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E285E3F3763;
 Wed, 22 Jul 2026 15:46:47 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 67F5217EFB; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 096/122] hw/display/virtio-gpu: fix dmabuf_fd leak
 on remap failure
Date: Wed, 22 Jul 2026 15:45:45 +0300
Message-ID: <20260722124622.31034-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
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
index 85ca23cb321..44eb1f5c972 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -142,6 +142,7 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
         }
         virtio_gpu_remap_udmabuf(res);
         if (!res->remapped) {
+            virtio_gpu_destroy_udmabuf(res);
             return;
         }
         pdata = res->remapped;
-- 
2.47.3


