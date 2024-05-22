Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4FDC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 04:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9doN-0001MW-Me; Wed, 22 May 2024 00:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9doL-0001Lg-Hs
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:42:45 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9doG-0005sV-9j
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716352961; x=1747888961;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WpBcaH1Tlocd9yPnXxPOtRYWcAqT14hB+2SW2lvL9mk=;
 b=MQ9JK5FiidKYOzDguouLu2xFK/laYU0Kamrjz+Ka3lhxJ0DbGj62tP42
 I7D78u7L39PA6KBflcUoKcHF0mXb3qQJ1JrxjfsaaAsKDjxM9SBLBN7Yw
 3RNwwYBlBIvw4flu9dVuUQaNTIrW85uwm8Fzp788So5iu9TJjlSTVPPKZ
 iL4h6abI3cSFDXvN2SRu9MoBeoE+P8kwwBHwi6w/qXLuubX+k2vxW5Ryx
 kh2Sx1ZL0kWvVGJJUvL05bJC04ao5MJxKuqpfdW8Y2bU0l/DCehgqB06V
 yTQTCN/jl2lLAyiLRGhUOl7EieJNBgwwi2gfGzD/2nA96gKaajcQUiCeZ w==;
X-CSE-ConnectionGUID: kH4UBvrVT0O0Ke4knxrlVA==
X-CSE-MsgGUID: gn343C2LRKSFyqV9XZM8hA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="23994113"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="23994113"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:42:37 -0700
X-CSE-ConnectionGUID: 4FMcqQU0T16SMKwDNrGSlg==
X-CSE-MsgGUID: B/RtREqcQpyyd+CL6+yzUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33683609"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:42:35 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 01/20] vfio/display: Fix error path in call site of
 ramfb_setup()
Date: Wed, 22 May 2024 12:39:56 +0800
Message-Id: <20240522044015.412951-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522044015.412951-1-zhenzhong.duan@intel.com>
References: <20240522044015.412951-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

vfio_display_dmabuf_init() and vfio_display_region_init() calls
ramfb_setup() without checking its return value.

So we may run into a situation that vfio_display_probe() succeed
but errp is set. This is risky and may lead to assert failure in
error_setv().

Cc: Gerd Hoffmann <kraxel@redhat.com>
Fixes: b290659fc3d ("hw/vfio/display: add ramfb support")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/display.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index fe624a6c9b..d28b724102 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -361,6 +361,9 @@ static int vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
                                           vdev);
     if (vdev->enable_ramfb) {
         vdev->dpy->ramfb = ramfb_setup(errp);
+        if (!vdev->dpy->ramfb) {
+            return -EINVAL;
+        }
     }
     vfio_display_edid_init(vdev);
     return 0;
@@ -488,6 +491,9 @@ static int vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
                                           vdev);
     if (vdev->enable_ramfb) {
         vdev->dpy->ramfb = ramfb_setup(errp);
+        if (!vdev->dpy->ramfb) {
+            return -EINVAL;
+        }
     }
     return 0;
 }
-- 
2.34.1


