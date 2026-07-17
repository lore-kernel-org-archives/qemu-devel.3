Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD91C4450F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 07:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkce4-00021u-Jp; Fri, 17 Jul 2026 03:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkce0-00021g-7t
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 03:06:00 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkcdw-0007zw-F6
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 03:05:58 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66H75c1e072590
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 17 Jul 2026 16:05:41 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=972nJ+1aycihhlt+QBGrwwxqoVzCrYMfoRD6Xfb0rk8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1784271941; v=1;
 b=wGHYLRF1C9bABcYUtli0eSn5wf84ajFdo4Baw6LqQT38if5M7IIBucxbDh7iaRxo
 eEDF5jiIz+n+eD14wO80N50gA+xZq33byH75mS8IP48AXwXz/vhSMgxUwjKDMS6e
 O04xo5FDH77MCW9xXvqgJYlxmTCHykqHwL6kTE2Ap1/5R84XzerhZ2d3Wc3YrkrT
 sL6hBES4uow9W5WqyrK7NVkclrM9lGvKUn8Zi8hXOIxaPePQfWntIdhRwiMlLBu0
 cld0YCJ7Fw1V+Yaz+5Bs+jdaSmZ8ZKsJLfvKk5OhwUEjhO5AtXyDtlzoYFQppC8Z
 /5koEYe2DiwEvw4KAJty8w==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 17 Jul 2026 16:05:23 +0900
Subject: [PATCH] hw/display/virtio-gpu: Check pixman_image_create_bits()
 results
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-pixman-v1-1-89ea33b50b75@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0Mz3YLMitzEPF1TCwMjA0tzIxNz0xQloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0AJvpnx2oAAAA=
X-Change-ID: 20260716-pixman-58020972475d
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=VjDzd8f7MsL3xhOmeYPJGGMLAqp+JiQcTshENuQb2C0=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ1bkFRdts/KI+YxfJvum/WGX061fzyXSvK+xkp1lWfgC7
 cyv2nc7SlkYxLgYZMUUWVKKdnNrRNd+KkyIb4GZw8oEMoSBi1MAJpJ8jpHh86Rbma845mjdmjrl
 om1Vms6as2+5Ofr8+x13vl6eK1unyciw9JPl7oOMix/ziOnP+rqu9rOMjYx1SMzSjin3snlSGo0
 ZAA==
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

pixman_image_create_bits() returns NULL for allocation failures and
unaligned strides, which may be supplied by the guest with
VIRTIO_GPU_CMD_SET_SCANOUT_BLOB, and virtio_gpu_do_set_scanout()
subsequently dereferences it.

Fixes: fa06e5cb7b10 ("virtio-gpu: fix scanout rectangles")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 88526051a992..edbb02ee0516 100644
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

---
base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05
change-id: 20260716-pixman-58020972475d

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


