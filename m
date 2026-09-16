Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F979C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ldw-0006Is-DQ; Wed, 16 Sep 2026 05:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6ldt-0005yM-EK; Wed, 16 Sep 2026 05:09:25 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6ldq-0007VE-7z; Wed, 16 Sep 2026 05:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549562; bh=6ibJYDh910YOpNAnSA9vZ8CdyRDluSyl3/eUKfEtaiI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=uilCdOSI4Qr4/KaqNO9x+ZUZESEtCBGgUiLc83O/AbmO71BhqIRuMxgFhRSFQPdF4
 CE+7FY11VPB5Ptqt5qztlDZMcztE2uKTT4/tWueCrCF9eT+qLnESbmdRev0Ff7JlaA
 o1j0eMCYKs2aQkhRgNg2wNCu18X8yQW40SjxhOzmGiVPa00w6+HhmBhXCSPIv1qaaW
 g7XLd/Lvsb6/bBrsjyl3V66HyY6hnv2qSLyYvlCEP7CQV6zKIOPbEqjdpqIjpOZvee
 Z1qo0wnNLTkhEBnyodfTNRofTWNe9aZYDR30ZbbJCmhmswjjEIAzIr2DbMOgGcM/o7
 22AmSFhO4rL8Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2A0F51D56DE;
 Wed, 16 Sep 2026 12:06:02 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C9F1A429E3A;
 Wed, 16 Sep 2026 12:06:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C347C5A7AB; Wed, 16 Sep 2026 12:06:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 swing <swing@mail.exp.sh>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 41/57] virtio-gpu: clear res->blob on mapping cleanup
Date: Wed, 16 Sep 2026 12:04:05 +0300
Message-ID: <20260916090516.677749-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
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

d3c2da174ca6 ("hw/display/virtio-gpu: Check cursor data presence")
already prevents the use-after-free on blob cursor after detach.

Clear res->blob in virtio_gpu_destroy_udmabuf() to keep init/fini
symmetric, and add LOG_GUEST_ERROR messages in
virtio_gpu_update_cursor_data() for missing or undersized blobs.

Fixes: bdd53f739273 ("virtio-gpu: Update cursor data using blob")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3881
Reported-by: 章鱼哥@aipy (www.aipyaipy.com)
Reported-by: swing <swing@mail.exp.sh>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit c7254cd584bb667c3f01f95b94c64970b6944452)
(Mjt: fixup across v11.1.0-574-gd3c2da174ca6
 "hw/display/virtio-gpu: Check cursor data presence"
 (this commit re-does v11.1.0-574-gd3c2da174ca6))
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index b1519254582..86335341de7 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -92,6 +92,7 @@ static void virtio_gpu_destroy_udmabuf(struct virtio_gpu_simple_resource *res)
         close(res->dmabuf_fd);
         res->dmabuf_fd = -1;
     }
+    res->blob = NULL;
 }
 
 static int find_memory_backend_type(Object *obj, void *opaque)
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 1cf2adeebbd..b2232709516 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -63,8 +63,16 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
         }
         data = pixman_image_get_data(res->image);
     } else {
+        if (!res->blob) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: resource %d has no blob\n",
+                          __func__, resource_id);
+            return;
+        }
         if (res->blob_size < (s->current_cursor->width *
                               s->current_cursor->height * 4)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: blob size too small for resource %d\n",
+                          __func__, resource_id);
             return;
         }
         data = res->blob;
-- 
2.47.3


