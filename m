Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD70CCFA13
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 05:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHy8s-0005bR-4P; Sun, 09 Nov 2025 00:39:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vHy8a-0005Wj-9e
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 00:38:53 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vHy8Y-0007Zb-LT
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 00:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762666731; x=1794202731;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4n9hck6R0svxMbk2pUnGkjTH+5x2uBEAN0/Vtq1+Rrs=;
 b=kN0Ub7IZ1dRdcTaP21WL5Q+X4xtGG8VKNvnwZ038jq3QhyNst+mTWq/A
 GWOv68NelBrd6VmLK50512uOH724hQ8Qw2cTfyb/L00LomN03ymuhspqT
 1sL8+ib498VUrDDu4mY1ruZ/T1G914kQ4voD15rC180Xsa+0tI7ENfh3T
 XuQfwwqlHX97mOeTZg7TdfOrtz3/j2BdIuC+JVOsGCYhRI17b0do+l0yU
 CdUoOAQc15Ggo9MkRwAQudMdbNGInYvq8ZwWlf0sKyKubWGFJhjL3Hy4l
 bhNahpZhXHRAHWid1BO7zRfIxrFZIcVqrSiNOFnq56E4I3yRMGhX0XDpa g==;
X-CSE-ConnectionGUID: 6GGj3kuXTByXHDVg6wK28g==
X-CSE-MsgGUID: re7dTfFmRDy8d1fbeOAbeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="63965786"
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; d="scan'208";a="63965786"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2025 21:38:40 -0800
X-CSE-ConnectionGUID: tKq7DucwRG6+ZycO2KqkTQ==
X-CSE-MsgGUID: f4HjZ8aWQpaJA4T/dgdQRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; d="scan'208";a="188129046"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2025 21:38:40 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 02/10] virtio-gpu: Find hva for Guest's DMA addr associated
 with a ram device
Date: Sat,  8 Nov 2025 21:33:45 -0800
Message-ID: <20251109053801.2267149-3-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If the Guest provides a DMA address that is associated with a ram
device (such as a PCI device region and not its system memory),
then we can obtain the hva (host virtual address) by invoking
address_space_translate() followed by memory_region_get_ram_ptr().

This is because the ram device's address space is not accessible
to virtio-gpu directly and hence dma_memory_map() cannot be used.
Therefore, we first need to identify the memory region associated
with the DMA address and figure out if it belongs to a ram device
or not and decide how to obtain the host address accordingly.

Note that we take a reference on the memory region if it belongs
to a ram device but we would still call dma_memory_unmap() later
(to unref mr) regardless of how we obtained the hva.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 199b18c746..d352b5afd6 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -798,6 +798,26 @@ static void virtio_gpu_set_scanout_blob(VirtIOGPU *g,
                               &fb, res, &ss.r, &cmd->error);
 }
 
+static void *virtio_gpu_dma_memory_map(VirtIOGPU *g,
+                                       struct virtio_gpu_ctrl_command *cmd,
+                                       uint64_t a, hwaddr *len)
+{
+    MemoryRegion *mr = NULL;
+    hwaddr xlat;
+
+    mr = address_space_translate(VIRTIO_DEVICE(g)->dma_as, a, &xlat, len,
+                                 DMA_DIRECTION_TO_DEVICE,
+                                 MEMTXATTRS_UNSPECIFIED);
+    if (memory_region_is_ram_device(mr)) {
+        memory_region_ref(mr);
+        return memory_region_get_ram_ptr(mr) + xlat;
+    }
+
+    return dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, len,
+                          DMA_DIRECTION_TO_DEVICE,
+                          MEMTXATTRS_UNSPECIFIED);
+}
+
 int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
                                   uint32_t nr_entries, uint32_t offset,
                                   struct virtio_gpu_ctrl_command *cmd,
@@ -839,9 +859,7 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
 
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


