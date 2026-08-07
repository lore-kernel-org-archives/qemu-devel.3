Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2A0C5AC81
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 05:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsD0c-0007p3-55; Fri, 07 Aug 2026 01:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wsD0Z-0007nZ-72
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:20:39 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wsD0W-0000PX-S8
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:20:38 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6775KGOP002853
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 7 Aug 2026 14:20:23 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=5qzsfs5NY6ZMJ5+cjHOLNejKg3HUY5nl+TH/ePNqSXA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1786080024; v=1;
 b=nyIIf2eLdqT6NnQqWx9kh0oq8Ou1mJPjVLh9p5Jd0BvfjD0qKSf7Jp/kvmhs/Y/U
 k9OyHoEk2MUFLru1c3us9wrv5InWsqbtKkbccaYgTgC/U4CNpFulgmXgm+U1Pa78
 yfwo9SdnjaFGihmkSdx9moPsg3+9YLmvap9VYLC87gjeF8C/z6DfOcT56GTmUPvv
 Y7UFFTHuK39HXhsY+mypyObvreivIBFGA98bx+MVXhwKj+8iC3ZLuse5lLuh+SiW
 EcInZWSgWvJflG8tySZmKAVXawLq+eSZ/IP/afznqLXgQDCsfiRYu2pP7Uybl6iH
 F084n0Q7nSj2e6SULsFj0w==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 07 Aug 2026 14:20:05 +0900
Subject: [PATCH 2/3] hw/display/virtio-gpu: Avoid mmap() for empty blob
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-dmabuf-v1-2-d24b1331dc8a@rsg.ci.i.u-tokyo.ac.jp>
References: <20260807-dmabuf-v1-0-d24b1331dc8a@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260807-dmabuf-v1-0-d24b1331dc8a@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=811;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=dkLY0z4kRQ3/G2AKmebLi0W4pe/7F7FSUA8BZ/LwqtE=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ1ZptrDLl6IzSRl/As/fj9thyV2w0qSAc7f1Gbl9G87xm
 8fOVVjZUcrCIMbFICumyJJStJtbI7r2U2FCfAvMHFYmkCEMXJwCMBGufYwMS/iDdY+6hbwTV31x
 Ne1Gf3XFjac/ZG+vq3qc02Kz5W7ZZYZfTAKRxitevOD2L+/UuMJSfcm++1uSloF5kbdYVf429iJ
 uAA==
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
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

Calling mmap() for an empty blob will result in EINVAL and emits a
spurious warning.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu-udmabuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index 5f08c855dde1..0377a9bcb406 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -136,7 +136,7 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
     if (res->iov_cnt == 1 &&
         res->iov[0].iov_len < 4096) {
         pdata = res->iov[0].iov_base;
-    } else {
+    } else if (res->blob_size) {
         virtio_gpu_create_udmabuf(res);
         if (res->dmabuf_fd < 0) {
             return;

-- 
2.55.0


