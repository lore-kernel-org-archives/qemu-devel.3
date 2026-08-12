Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CFBC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAUE-0005tY-LD; Wed, 12 Aug 2026 11:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuASH-0004Ra-9o; Wed, 12 Aug 2026 11:01:33 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuASA-0002LT-GC; Wed, 12 Aug 2026 11:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546233; bh=cAZc/FGh/6E73nuz7jbm6MacNVpnYzCWt0Twj0MGtV8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aGF5Lh6IEgg5WmRdTrZJgtDTSfwRF7sA4knbTH1bsujhmnsyxd0wITweh3AyQJi9s
 wplj3q3qw8h9MG4jfsiQfaohR3YViccG2ROF4GqlPRbGMOx+h/kiaGg7Q4Yi8mVSXQ
 ftkecxQgDIiwBOnVGvxgMM72VWBYMMpChP6yJ9+3NTdPOtm4DbyVd3+BWHRWZWolmQ
 Lvo6w+I3XkmZmm73iqndntEDjrC3ud2GbaXg7gtdPKP28UVUXWz2oZp7ZsNuG0eNH7
 njNyU11rXL6PWc1VarUWjy/Qtd63NcSIPmu7Vkb3PheIkPPCh/fTpynZ5dk2UZcNKx
 dukWCR7eUMFnw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CAF771CA66F;
 Wed, 12 Aug 2026 17:50:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 31B46409DB4;
 Wed, 12 Aug 2026 17:50:45 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8F0312FA39; Wed, 12 Aug 2026 17:50:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cyber_black <Cyberblackk@proton.me>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 107/120] hw/display/virtio-gpu: fix offset wraparound
 in scanout_blob_to_fb
Date: Wed, 12 Aug 2026 17:49:30 +0300
Message-ID: <20260812144955.649205-107-mjt@tls.msk.ru>
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

virtio_gpu_scanout_blob_to_fb() computes the framebuffer offset from
guest-controlled offsets[0], r.x, r.y and stride using uint32_t
arithmetic. When the sum exceeds UINT32_MAX, silent wraparound lets
the guest steer the scanout to an arbitrary in-bounds region of the
blob instead of the intended rectangle.

Compute the offset in uint64_t, reject values exceeding UINT32_MAX
(the width of fb->offset), and only store into fb->offset once both
range checks pass.

("[PATCH] hw/display/virtio-gpu: Remove the bytes_pp field")

Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3871
Based-on: <20260719-bpp-v1-1-9b91946d6cf3@rsg.ci.i.u-tokyo.ac.jp>
Reported-by: Cyber_black <Cyberblackk@proton.me>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260725122734.1775774-1-marcandre.lureau@redhat.com>
(cherry picked from commit b8ef970532c30da2f3fa8985867a74f898ce96aa)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 86255d6056d..4f5716fdb82 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -777,7 +777,7 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
                                    struct virtio_gpu_set_scanout_blob *ss,
                                    uint64_t blob_size)
 {
-    uint64_t fbend;
+    uint64_t fbend, offset;
     uint32_t bytes_pp;
 
     fb->format = virtio_gpu_get_pixman_format(ss->format);
@@ -807,18 +807,20 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
         return false;
     }
 
-    fb->offset = ss->offsets[0] + ss->r.x * bytes_pp + ss->r.y * fb->stride;
+    offset = (uint64_t)ss->offsets[0] + (uint64_t)ss->r.x * bytes_pp +
+             (uint64_t)ss->r.y * fb->stride;
 
-    fbend = fb->offset;
-    fbend += (uint64_t) fb->stride * ss->r.height;
+    fbend = offset + (uint64_t)fb->stride * ss->r.height;
 
-    if (fbend > blob_size) {
+    if (offset > UINT32_MAX || fbend > blob_size) {
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: fb end out of range\n",
+                      "%s: invalid fb bounds\n",
                       __func__);
         return false;
     }
 
+    fb->offset = offset;
+
     return true;
 }
 
-- 
2.47.3


