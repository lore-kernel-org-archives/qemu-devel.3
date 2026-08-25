Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55C6C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylbw-0005Iw-Bu; Tue, 25 Aug 2026 03:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wylbu-0005Gr-Ay
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 03:30:18 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wylbq-00026w-Is
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 03:30:17 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67P7TsR5057787
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 25 Aug 2026 16:30:03 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=xh6gmNUOMB/uRD2IO04yxiOH9Eb2pUt5NpbNm8V5uRc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1787643003; v=1;
 b=bdSPo48dNpUnH0oH6XK0mghqWR9OR3/C1b/uLOyP6w8/6QTIHqVqVWRq6SIt3b4S
 CY0ib9sn+9YEI82b7+CUhOnna6sDwA8vtcrjg4PE3InPZMKs/bG2gXkkYuZt4ko2
 Zjj8dy8Pr6lVaTBYP4GSY3fIWck/HH4VLKJjaFffwik3/6MX7TClbHpINVanr6z+
 BaJbXKCZs9b9pHHQmsef8yKkSMLLFBv4uzRDg6RtrY03+UbrRbJOeoe89oUWUqQd
 DEeMjwqZXei8lJ6qRaYISq5CSEng7QTMse6JdBEUdMfnt91SzyALCM1/gShydvlN
 52lruBK+nxRym/Bb8tJCCQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 25 Aug 2026 16:28:48 +0900
Subject: [PATCH v2 2/5] hw/display/virtio-gpu: Avoid mmap() for empty blob
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-dmabuf-v2-2-b3d64d3b9a0e@rsg.ci.i.u-tokyo.ac.jp>
References: <20260825-dmabuf-v2-0-b3d64d3b9a0e@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260825-dmabuf-v2-0-b3d64d3b9a0e@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=955;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=5ko48SofRq+K9N11681tLZ5DmDH0UWyoMwo7G18yb5s=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ1avS5mhRvTlMj6pOObZzy3YDlj8nurx6pSd1TG/o/3zq
 hse5U/vKGVhEONikBVTZEkp2s2tEV37qTAhvgVmDisTyBAGLk4BmEhcJSPDveBLGR7nT591i9w1
 d+VNgbvXRBzne/H/N/yyRb5sl7P4eYZ/uppSLiUJD313++Tpb9MoCDkxw1D99la9m20i4h+1RRs
 YAQ==
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

Calling mmap() for an empty blob fails with EINVAL, causing QEMU to
emit a spurious warning.

Fixes: e0933d91b1cd ("virtio-gpu: Add virtio_gpu_resource_create_blob")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


