Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC56C5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 08:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMjqk-0006jd-G6; Wed, 04 Jun 2025 04:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMjqg-0006jK-Lm
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 04:51:51 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMjqe-0002E3-GB
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 04:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749027108; x=1780563108;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=msbnNfrNenAFwAh9W4xXLltKPTkAd+yAVo4Glpwk/NE=;
 b=kzsYJqgJj5aamuVu3jPg3o9kx3NuqXjFXR1TIjTglzvjRislLaDhraSa
 K55RsdliTrlxQGeyp9wAy87zgkQNX5pMd+Qtb1NsvW7Eu02WsKoT9qAkQ
 mPnshDoW0uQPGhed1Qzzkqysk42Yr7z+Qid4xrv4dlee6mcJHj3LPbazJ
 arXq58hx39oXb76+rmXjLbTOp9amPMqeCaxkBIA573ZgSL+FQ5xn4L7Xe
 8A6JUgUgCkQoPnwT/w4yYVFQptvRSlg/ma/eu1MKl6W/iYoyM7jP9tzxr
 DwTwPIg3fT7pAUKGotIk8vzMfpuXnNReFR5Iq/HP63lBm+YDPrsIMzBU5 w==;
X-CSE-ConnectionGUID: soe3RQLWQlSLBrm8m7WL2w==
X-CSE-MsgGUID: KvLUmGA+Rp6MPsJGgoZxpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68648757"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="68648757"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 01:51:45 -0700
X-CSE-ConnectionGUID: Ri+ml3JRQ6CaCJYWTtb7dw==
X-CSE-MsgGUID: cCwGzlyaSN2m4fOlFPIAUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="150279434"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 01:51:43 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio-mem: Fix definition of VirtIOMEMClass
Date: Wed,  4 Jun 2025 16:47:56 +0800
Message-Id: <20250604084757.4035354-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
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

Parent of VirtIOMEMClass is VirtioDeviceClass rather than VirtIODevice.

Fixes: 910b25766b33 ("virtio-mem: Paravirtualized memory hot(un)plug")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/virtio/virtio-mem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-mem.h
index bc4f787772..93fdf9e432 100644
--- a/include/hw/virtio/virtio-mem.h
+++ b/include/hw/virtio/virtio-mem.h
@@ -134,7 +134,7 @@ struct VirtioMemSystemReset {
 
 struct VirtIOMEMClass {
     /* private */
-    VirtIODevice parent;
+    VirtioDeviceClass parent;
 
     /* public */
     void (*fill_device_info)(const VirtIOMEM *vmen, VirtioMEMDeviceInfo *vi);
-- 
2.34.1


