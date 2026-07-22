Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76397C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWPM-0006jp-G0; Wed, 22 Jul 2026 08:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWO6-00043t-4n; Wed, 22 Jul 2026 08:49:28 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWO1-0001vM-NN; Wed, 22 Jul 2026 08:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724390; bh=UmKhz2xvwnjZIkVWAK0A3aebKAilI8XVlQ5eyXFFtMk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PeS8VAqX5Uo52tqbnHVz2ZpN8NIMAP1bLiSnIMjz1nqKEUR89xEITWKfLmn8FZDcO
 uCCQJyqd6HTotJI8fQ8+bsf2pNdG4WQPYo+JA4LiEmciacxVCqlQ+W3lKQpm2/rhKy
 tOWifsgOmJCJsDjD/dqCrwzTk3MnO1ekcl1RZOL1fATiVRutlqMtsBrMq8O9OhH3RD
 lx3kDj7YhpU5qb5+FUabvW+mL+dAFaNQOVndyipfnwy19jx8QQpkXsccF/rDuqwRQN
 5cyqTvVKTCRI/OwNg0juJxGQgwPO3+YRZEC9Wq++Sj/mThvpuXPCRYJ36SLz8zOC0c
 a374TiY50P1DQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D43D51C3B13;
 Wed, 22 Jul 2026 15:46:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 283B93F376D;
 Wed, 22 Jul 2026 15:46:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7F86C17F0F; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Feifan Qian <bea1e@proton.me>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 106/122] hw/display/virtio-gpu: handle migration
 iov allocation failure
Date: Wed, 22 Jul 2026 15:45:55 +0300
Message-ID: <20260722124622.31034-31-mjt@tls.msk.ru>
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

An unbounded iov_cnt from the migration stream drives two g_new()
allocations whose combined size can exceed available memory, causing
GLib to abort the process.

Switch to g_try_new() and propagate the failure as a migration error.

Fixes: 0c244e50ee12 ("virtio-gpu: add live migration support")
Fixes: f66767f75c9c ("virtio-gpu: add virtio-gpu/blob vmstate subsection")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3753
Reported-by: Feifan Qian <bea1e@proton.me>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit e99488c5d4a009a156a29f9ff6a7f12d091c2646)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 0d1e991e1cb..0fa61d10972 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1336,8 +1336,15 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
             return -EINVAL;
         }
 
-        res->addrs = g_new(uint64_t, res->iov_cnt);
-        res->iov = g_new(struct iovec, res->iov_cnt);
+        res->addrs = g_try_new(uint64_t, res->iov_cnt);
+        res->iov = g_try_new(struct iovec, res->iov_cnt);
+        if (res->iov_cnt && (!res->addrs || !res->iov)) {
+            pixman_image_unref(res->image);
+            g_free(res->addrs);
+            g_free(res->iov);
+            g_free(res);
+            return -EINVAL;
+        }
 
         /* read data */
         for (i = 0; i < res->iov_cnt; i++) {
@@ -1409,8 +1416,15 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
         res->resource_id = resource_id;
         res->blob_size = qemu_get_be32(f);
         res->iov_cnt = qemu_get_be32(f);
-        res->addrs = g_new(uint64_t, res->iov_cnt);
-        res->iov = g_new(struct iovec, res->iov_cnt);
+
+        res->addrs = g_try_new(uint64_t, res->iov_cnt);
+        res->iov = g_try_new(struct iovec, res->iov_cnt);
+        if (res->iov_cnt && (!res->addrs || !res->iov)) {
+            g_free(res->addrs);
+            g_free(res->iov);
+            g_free(res);
+            return -EINVAL;
+        }
 
         /* read data */
         for (i = 0; i < res->iov_cnt; i++) {
-- 
2.47.3


