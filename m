Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A401FD88E1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 02:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w09kW-0000Qc-2y; Tue, 10 Mar 2026 22:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w09kU-0000QS-Ei
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:56:38 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w09kO-000630-KR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773197792; x=1804733792;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lYWaP1kFmLOPTRi7iW/x1sxii0x816fC62gZjXLi8LA=;
 b=ieMFoNZ/bvReUDuOeEK7ir71r3uYxA6pDiG52Ibc4yJsONa2qHvwMSmz
 gke9t4TNLnEg/sOnBaRbJSxYizssXKpIyg7fAZEIR4KueUJZmMVwRcdk7
 oWovE0LeKrL80P86gE/v9eQH7Ku8kfqX+7jXEbM9kSo0YxQ+9fSv1xsRv
 wWdjavHW/D9kyfpuTLShYw23pS/qFawOmD+NAhJ0Lj30NhrzLcYAn1FuU
 gpn5OzieImpDhtXboxxYXGQugvefosebxhYbXNH49PIOZM4EJQMVQ+wkW
 NuhxewRTDEzkiupZiMRlarEClpMWrWQ3a+q5XmSRmRqt9gwgHETWiupVG w==;
X-CSE-ConnectionGUID: HLsgR1urRtu4cCrteRVg6g==
X-CSE-MsgGUID: AZyBCrv5TuKrNoo/pFGF2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="76867892"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="76867892"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 19:56:29 -0700
X-CSE-ConnectionGUID: gmbXk+O+TRCrJAg1E1kIvg==
X-CSE-MsgGUID: cKPQ7BIlQGmFYCmGCSJ+oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="215611435"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 19:56:29 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v11 02/10] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
Date: Tue, 10 Mar 2026 19:50:44 -0700
Message-ID: <20260311025340.1335673-3-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311025340.1335673-1-vivek.kasireddy@intel.com>
References: <20260311025340.1335673-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
device (such as a VFIO PCI device region and not its system memory),
then we can obtain the hva (host virtual address) by invoking
address_space_translate() followed by memory_region_get_ram_ptr().

We cannot use dma_memory_map() because for memory regions that do
not support direct access, it would create bounce buffers instead
of returning the actual hva, which is not desirable here. And, since
VFIO device regions are not considered directly accessible (because
they are mostly MMIO based), virtio-gpu cannot invoke dma_memory_map()
to obtain the hva in this case.

Therefore, in order to handle addresses associated with VFIO devices,
we need to use the address_space_translate() API to first identify
the right memory region and the appropriate offset within that
region and then use memory_region_get_ram_ptr() to get the hva.
This approach also works for addresses associated with the system
memory region.

Note that, although we take an explicit reference on the memory
region, we would still rely on dma_memory_unmap() to drop that
reference when the dma mapping is eventually unmapped.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index f20111fa57..f5c6a7deb9 100644
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
2.53.0


