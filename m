Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B297CD6CFD5
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 06:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjAYj-00039a-Rm; Fri, 23 Jan 2026 01:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vjAYi-00038Q-7I
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 01:22:16 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vjAYg-0000sJ-JT
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 01:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769149335; x=1800685335;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NrMNznHBXX3uPZveNVk1de9YgIFmAWj4A/wgBBPFYng=;
 b=OKmE9/iSJYFRi3pGmmqTczzc9vBalrf00FDyqli1I1AJgGSf3BeXh7Ky
 RRNQm4RVWx9WGlzyahXhdl7TUzuP4W9NLEjqvfsk4IeOwyPWTxKE9848Q
 dYK93w+HxlE0TtTML9+Z8fzHFG+zYAHCCael3eL3wg816/t6kG0oU1s2P
 iJkq6jJhh9vyoO6vTPRNkavaOTohSUOapNqGsv/BAkY0VbxW6PiUF1qQn
 GGeGulPS5aNkwOxucDldzXoCmA/kJU4imuMvccoAhc9jeDVZQQ4cNqELd
 IeGy1og4NdmK/t5atd+iat8vYmgIgcFHca2ucRDAk93xYBXKhqH20qv14 Q==;
X-CSE-ConnectionGUID: 4/oSv9P9TzWz2agJtOT5rg==
X-CSE-MsgGUID: ungv5YWvRo+QkRq5BTVnOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="74254189"
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; d="scan'208";a="74254189"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 22:22:06 -0800
X-CSE-ConnectionGUID: lQ1fkWnRQ165DyMlAyaZIw==
X-CSE-MsgGUID: p69W0Cm6TmCk9j7ETCgGgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; d="scan'208";a="207287402"
Received: from unknown (HELO vkasired-desk2.fm.intel.com) ([10.105.128.132])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 22:22:04 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 2/8] virtio-gpu: Find hva for Guest's DMA addr associated
 with a ram device
Date: Thu, 22 Jan 2026 22:17:41 -0800
Message-ID: <20260123062042.568703-3-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260123062042.568703-1-vivek.kasireddy@intel.com>
References: <20260123062042.568703-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

If the Guest provides a DMA address that is associated with a ram
device (such as a PCI device region and not its system memory),
then we can obtain the hva (host virtual address) by invoking
address_space_translate() followed by memory_region_get_ram_ptr().

This is because the ram device's address space is not accessible
to virtio-gpu directly and hence dma_memory_map() cannot be used.
Therefore, we first need to identify the memory region associated
with the DMA address and add the offset to the pointer returned
from memory_region_get_ram_ptr() to obtain the host address.

Note that we take a reference on the memory region but we would
still eventually call dma_memory_unmap() (to unref the mr).

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 3d58cebf4b..9930a21317 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -798,6 +798,23 @@ static void virtio_gpu_set_scanout_blob(VirtIOGPU *g,
                               &fb, res, &ss.r, &cmd->error);
 }
 
+static void *virtio_gpu_dma_memory_map(VirtIOGPU *g,
+                                       struct virtio_gpu_ctrl_command *cmd,
+                                       uint64_t a, hwaddr *len)
+{
+    MemoryRegion *mr;
+    hwaddr xlat;
+
+    mr = address_space_translate(VIRTIO_DEVICE(g)->dma_as, a, &xlat, len,
+                                 DMA_DIRECTION_TO_DEVICE,
+                                 MEMTXATTRS_UNSPECIFIED);
+    if (memory_region_is_ram(mr)) {
+        memory_region_ref(mr);
+        return memory_region_get_ram_ptr(mr) + xlat;
+    }
+    return NULL;
+}
+
 int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
                                   uint32_t nr_entries, uint32_t offset,
                                   struct virtio_gpu_ctrl_command *cmd,
@@ -839,9 +856,7 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
 
         do {
             len = l;
-            map = dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, &len,
-                                 DMA_DIRECTION_TO_DEVICE,
-                                 MEMTXATTRS_UNSPECIFIED);
+            map = virtio_gpu_dma_memory_map(g, cmd, a, &len);
             if (!map) {
                 qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map MMIO memory for"
                               " element %d\n", __func__, e);
-- 
2.50.1


