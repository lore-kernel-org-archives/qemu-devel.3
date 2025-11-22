Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08AECF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 07:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMiMF-0000U3-27; Sat, 22 Nov 2025 02:48:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vMhUR-0000lS-0t
 for qemu-devel@nongnu.org; Sat, 22 Nov 2025 01:53:00 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vMhU4-0001Uz-2n
 for qemu-devel@nongnu.org; Sat, 22 Nov 2025 01:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763794356; x=1795330356;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kMX3gK3C2jrvs4wVLl8xztI2o+0UwVJ4qGV1poeLrvc=;
 b=P1XeBPryrbtoy3ub9dhZJLx+P8uRRjLPMDk0O38Wek1WgflRGHn33UHB
 2DnXQICpkaZHJfHw884tILtqzeRgWymtErDAFa4mnnJDCTYD3MX0f7w/t
 vX4BjKKG/srnaEkNwSwd2/1cruSVMnrROGgCNhmtCQVMp/6Or8xJAGNKQ
 PGTe1tMoyVmA1ZrWF9/fOQmolg5lnxy7iYRUHXO94YjZp3YgErnbmOUB2
 gOFKVx6bjsVm9SQtb8G06Qp6KLWWuqdv97mbtt1Jork7xpsDoQxw6uTc+
 QIXq4/J++XFOsrwd4/K1bhFZCNCCnJSt/EE8yja+sO759T9TkuHLMbLC4 Q==;
X-CSE-ConnectionGUID: cIcslnDwTqyD9jVRcbAhvw==
X-CSE-MsgGUID: Gc1HiX2uRH2Qs75EvC/WoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="65924088"
X-IronPort-AV: E=Sophos;i="6.20,217,1758610800"; d="scan'208";a="65924088"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 22:50:22 -0800
X-CSE-ConnectionGUID: uCCP/QygS7OqN4c4ELGArg==
X-CSE-MsgGUID: 1KYwNuBNT8OPsvPWQ383vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,217,1758610800"; d="scan'208";a="191064624"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 22:50:23 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 8/9] virtio-gpu-dmabuf: Introduce
 ram_block_is_memfd_backed() helper
Date: Fri, 21 Nov 2025 22:46:29 -0800
Message-ID: <20251122064936.2948632-9-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251122064936.2948632-1-vivek.kasireddy@intel.com>
References: <20251122064936.2948632-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This helper function provides a way to determine if a ram block
is backed by memfd by checking the SEALS on the associated fd.
This is useful in scenarios where we need to quickly verify if
a given memory region is associated with a memfd or not.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu-dmabuf.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
index c34d4c85bc..258c48d31b 100644
--- a/hw/display/virtio-gpu-dmabuf.c
+++ b/hw/display/virtio-gpu-dmabuf.c
@@ -27,6 +27,19 @@
 #include "standard-headers/linux/udmabuf.h"
 #include "standard-headers/drm/drm_fourcc.h"
 
+static bool ram_block_is_memfd_backed(RAMBlock *rb)
+{
+    int ret;
+
+    if (rb && rb->fd > 0) {
+	ret = fcntl(rb->fd, F_GET_SEALS);
+	if (ret > 0) {
+	    return true;
+	}
+    }
+    return false;
+}
+
 static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
 {
     struct udmabuf_create_list *list;
@@ -94,20 +107,14 @@ static void virtio_gpu_destroy_dmabuf(struct virtio_gpu_simple_resource *res)
 static int find_memory_backend_type(Object *obj, void *opaque)
 {
     bool *memfd_backend = opaque;
-    int ret;
 
     if (object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)) {
         HostMemoryBackend *backend = MEMORY_BACKEND(obj);
-        RAMBlock *rb = backend->mr.ram_block;
 
-        if (rb && rb->fd > 0) {
-            ret = fcntl(rb->fd, F_GET_SEALS);
-            if (ret > 0) {
-                *memfd_backend = true;
-            }
+        if (ram_block_is_memfd_backed(backend->mr.ram_block)) {
+            *memfd_backend = true;
         }
     }
-
     return 0;
 }
 
-- 
2.50.1


