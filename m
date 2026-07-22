Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0CBC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWWR-00075J-0d; Wed, 22 Jul 2026 08:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWT4-0006m0-Im; Wed, 22 Jul 2026 08:54:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWT3-00031x-27; Wed, 22 Jul 2026 08:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724575; bh=HXds0l3vK7n+x2gWAHEWtr1X6kDzS4jBOhaLZwrWEtY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=uEotGvWhYca8UkklUJl1lf1UWWT4u/Uyd9CZ/4UCqS3+VlFNAAi/snUuSjVlwH354
 qe+0yBVYwLJZCSsAQHEkuwPnh3S3l8l7KPbyc0xrMPnJWrMGQQwDxwMWorbisKT03V
 dYVof2UXSECoQEQlS3cfOqc/r+HBXj33Up/T8sW1luVu9JbGyMdOner+QfCob0EaTo
 Wl1STqMMrRuPpocj/L34IwRMMaj/zvNWjFXy7nE6/SjHwb214j2Crm/GjwBk/l/HYf
 Wu08E5JXm5BagTPrP70DNh4eT/6ZGfByOIbXMYn4H95t5/+pqPav1jUteW3Is+Dr8d
 iPP/z5Dnj/dXw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2AE061C3B4D;
 Wed, 22 Jul 2026 15:49:35 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 741743F379D;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id DB80D17F6F; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 112/127] hw/display/virtio-gpu: Check
 pixman_image_create_bits() results
Date: Wed, 22 Jul 2026 15:48:37 +0300
Message-ID: <20260722124859.32371-31-mjt@tls.msk.ru>
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

pixman_image_create_bits() returns NULL for allocation failures and
unaligned strides, which may be supplied by the guest with
VIRTIO_GPU_CMD_SET_SCANOUT_BLOB, and virtio_gpu_do_set_scanout()
subsequently dereferences it.

Fixes: fa06e5cb7b10 ("virtio-gpu: fix scanout rectangles")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260717-pixman-v1-1-89ea33b50b75@rsg.ci.i.u-tokyo.ac.jp>
(cherry picked from commit f1af81ba2aeec7b5a5ee8529ef55275865aea0c0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index c4d8aab365f..81d65ec57ca 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -674,6 +674,10 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
         void *ptr = data + fb->offset;
         rect = pixman_image_create_bits(fb->format, r->width, r->height,
                                         ptr, fb->stride);
+        if (!rect) {
+            *error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+            return false;
+        }
 
         if (res->image) {
             pixman_image_ref(res->image);
-- 
2.47.3


