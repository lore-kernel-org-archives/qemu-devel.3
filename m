Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB13C5B559
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 11:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMmkp-0005CT-9u; Wed, 04 Jun 2025 07:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMmkn-0005C0-1Q
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 07:57:57 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMmkk-0000nv-Vr
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 07:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749038275; x=1780574275;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iL6MdF/NutyJzJOosq4Y7HU+q/TMdMmP5rP3J7qCWm8=;
 b=Pd5rIF24lN8zSCzJcuRMGBJ+rjYlAdIl3NChYaejDI/UBTt633EBRFRV
 l8/lT5fNXtcTYVclyInJlORIjvjh5kCgPeQf16VNmah6KYsaNXIb4G9zl
 sXgXCfr/tMwQOveCiLCgP3Zzzjt4teHwiOzXkavfQ4cOAd7BqBkt0cyPD
 kdA++rTPTXys6xM8lR6ZNRayrBbht+GVCjX7eohLhNuc91qdSPHYvcYol
 EsYhtJ8GNBg7a3NMUJL/BtkCsFQLGZxzx6G0mayN/eZKDDRU9rITyu8Rm
 Wpi9L16oEp7/kal1A2s6vLRqkdsY+L4z4G/JFVh0c7kInjmVyBprD2qG5 A==;
X-CSE-ConnectionGUID: zCWem5SuQbWmVNjuuUbn6w==
X-CSE-MsgGUID: 3h7+Nnm+TEaPozb9kZJtUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="54915363"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; d="scan'208";a="54915363"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 04:57:53 -0700
X-CSE-ConnectionGUID: A9zbaOoLTdiTij4CRtvsiQ==
X-CSE-MsgGUID: zSu6S3xVTxCcWGoi9EiLSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; d="scan'208";a="150048289"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 04:57:51 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, david@redhat.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 2/5] virtio-pmem: Fix definition of VirtIOPMEMClass
Date: Wed,  4 Jun 2025 19:53:57 +0800
Message-Id: <20250604115400.98905-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250604115400.98905-1-zhenzhong.duan@intel.com>
References: <20250604115400.98905-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

VirtIOPMEMClass's parent is VirtioDeviceClass rather than VirtIODevice.

Fixes: 5f503cd9f388 ("virtio-pmem: add virtio device")
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/virtio/virtio-pmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-pmem.h b/include/hw/virtio/virtio-pmem.h
index fc4fd1f7fe..9cce600d0b 100644
--- a/include/hw/virtio/virtio-pmem.h
+++ b/include/hw/virtio/virtio-pmem.h
@@ -36,7 +36,7 @@ struct VirtIOPMEM {
 
 struct VirtIOPMEMClass {
     /* private */
-    VirtIODevice parent;
+    VirtioDeviceClass parent_class;
 
     /* public */
     void (*fill_device_info)(const VirtIOPMEM *pmem, VirtioPMEMDeviceInfo *vi);
-- 
2.34.1


