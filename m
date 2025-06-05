Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5327C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7oa-0001d5-Ah; Thu, 05 Jun 2025 06:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uN7oP-0001Zz-QS
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:27:08 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uN7oN-00053T-M4
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749119224; x=1780655224;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BSJZANj/wCKPPJdGoe9wGJ/+dYAD9goazUL51rpWnR8=;
 b=a35HwpwNC9LrZztYQRx+aTEpkdF99s2+dJqLJAqqLW8+Iec4fH9UrFaq
 akQ+rst5e0oug1cqmjn/5pnMjOczeWyWHMnPFkSHictiIaQc0u3RFrXFr
 /k50mXi0auJMfbMG4i1z0n1S2mE7mn6Z3DC90L3Dg6RjibZEeMQcT5PYS
 Pg4MdleCRcJ+laXsiYPrdxxsAyZkXU7SHn76953wSABB6S6cpKGJVisJ7
 wP1NpSsA6RSdwFM+qd7bka0qGN7xD/gx3XWentCXaeTRktqSs8EA+tH+0
 nAoghf7VeEg/IZSNkRcDSeMzmqTmnEJ5ffDI3+Kv1+Zaej7mSp1OOhgII A==;
X-CSE-ConnectionGUID: aMd4rn/RRzWoMW2b3dveSQ==
X-CSE-MsgGUID: 6F9gs5BVR2iChZ9vjeNxhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51325298"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="51325298"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 03:27:01 -0700
X-CSE-ConnectionGUID: c5rVclFRRsWmCbn3I1SYGw==
X-CSE-MsgGUID: oxpYSYkESKWSKoIwK43Dbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="145808618"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 03:27:00 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, david@redhat.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 1/5] virtio-mem: Fix definition of VirtIOMEMClass
Date: Thu,  5 Jun 2025 18:23:07 +0800
Message-Id: <20250605102311.148171-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250605102311.148171-1-zhenzhong.duan@intel.com>
References: <20250605102311.148171-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
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
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-mem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-mem.h
index bc4f787772..e0ab31b45a 100644
--- a/include/hw/virtio/virtio-mem.h
+++ b/include/hw/virtio/virtio-mem.h
@@ -134,7 +134,7 @@ struct VirtioMemSystemReset {
 
 struct VirtIOMEMClass {
     /* private */
-    VirtIODevice parent;
+    VirtioDeviceClass parent_class;
 
     /* public */
     void (*fill_device_info)(const VirtIOMEM *vmen, VirtioMEMDeviceInfo *vi);
-- 
2.34.1


