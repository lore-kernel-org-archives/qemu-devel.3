Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9B3C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 04:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2LbE-0001Cl-QF; Fri, 04 Sep 2026 00:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <getshell@seu.edu.cn>)
 id 1x2KnQ-0004eN-0P
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 23:40:56 -0400
Received: from mail-m49197.qiye.163.com ([45.254.49.197])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <getshell@seu.edu.cn>)
 id 1x2KnO-0003C2-6D
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 23:40:55 -0400
Received: from LAPTOP-99KJFSET (unknown [36.153.54.56])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4c80ae3a8;
 Fri, 4 Sep 2026 11:33:46 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, Hongyan Xu <getshell@seu.edu.cn>
Subject: [RFC PATCH] virtio-gpu: drop scanouts and clear res->blob when
 backing is detached
Date: Fri,  4 Sep 2026 11:33:46 +0800
Message-ID: <20260904033346.2-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa06a7ac3be03a1kunmea67113224206
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTRodVk0aSkJLGEgdHU0YGFYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VTk1ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
 NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=jcnAqeUoB39K7tLg2HvXwsKld0tI3Lzha5KlNfsdWFmnhybeTQMy70WUPek+Gi0D4TkIBIp8unjf6Q7/7WlS9DW7mvOTGobXRAw5L1oXoIIU69TGIwjhVS/MvtZ0yWpKWvFMhj1ukpN9cgNytLaII1Q1RBfg63Ef+a4W/P/Nvh4=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=ssTdha+mU4tTbzla/OzbtzpVKPAJ0UTLhozF3AhCiJs=;
 h=date:mime-version:subject:message-id:from;
Received-SPF: pass client-ip=45.254.49.197; envelope-from=getshell@seu.edu.cn;
 helo=mail-m49197.qiye.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 04 Sep 2026 00:32:22 -0400
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

virtio_gpu_resource_detach_backing() releases a resource's mapping
through virtio_gpu_cleanup_mapping(), which for a blob resource unmaps
and releases the udmabuf backing.  Two lifetime problems follow:

1. A blob resource may currently back a scanout: do_set_scanout()
   creates a pixman surface that aliases res->blob memory
   (scanout->ds -> data inside res->blob).  detach does not drop those
   scanouts, so after cleanup_mapping() releases the backing, a later
   display refresh reads freed memory (use-after-free).  Drop every
   scanout that still references the resource before unmapping,
   mirroring what virtio_gpu_resource_destroy() already does before it
   frees a resource.

2. cleanup_mapping() never clears res->blob after fini_udmabuf(), so
   the resource keeps a dangling pointer to released memory while it
   stays on reslist (detach does not remove the resource; the guest can
   re-attach backing later).  NULL it out so code that consults
   res->blob (e.g. cursor/scanout paths) cannot touch freed memory.

RFC: this overlaps the upstream virtio-gpu blob/DETACH_BACKING fix
series (CVE-2026-66020 family); confirm it does not duplicate an
in-flight version before applying.

Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 hw/display/virtio-gpu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 55a1c7f80f..d0d15deb28 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1030,6 +1030,7 @@ void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
 
     if (res->blob) {
         virtio_gpu_fini_udmabuf(g, res);
+        res->blob = NULL;
     }
 }
 
@@ -1096,6 +1097,23 @@ virtio_gpu_resource_detach_backing(VirtIOGPU *g,
     if (!res) {
         return;
     }
+
+    /*
+     * A blob resource may be backing a scanout: the scanout's surface
+     * aliases res->blob memory (do_set_scanout).  cleanup_mapping()
+     * below unmaps/releases that memory, so drop every scanout that
+     * still references this resource first, mirroring what
+     * virtio_gpu_resource_destroy() does before it frees a resource.
+     */
+    if (res->scanout_bitmask) {
+        int i;
+
+        for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
+            if (res->scanout_bitmask & (1 << i)) {
+                virtio_gpu_disable_scanout(g, i);
+            }
+        }
+    }
     virtio_gpu_cleanup_mapping(g, res);
 }
 
-- 
2.50.1.windows.1


