Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5948C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 09:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN7wa-0005og-EG; Fri, 28 Jun 2024 05:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sN7wX-0005nM-JM
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 05:30:57 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sN7wV-0005Yz-I8
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 05:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719567056; x=1751103056;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lA2zuINPzZoggNMavj+h2yI5orhGU69Td9Lm5CUad9w=;
 b=Ho5dG2BMa1MhX/hnwtW6wql3B4OKqzODiAwkRKO2cy/U/2p0YIRf8Epv
 VuNsAZcK9yJgll77OeCMA1MVmYkF5D7QXC0UYMIMrxvUW7SscY8Rdyr6O
 VDBMK8luda2BXuw70Bgm5XmrbotrbWyxELQbs3aXp0eVwtnOa++qhAxNm
 wVLiIfrLsTe66bMiqacZY5uPCgk2DGXnpX33JcVDeXmaIZfInSoPG3nlh
 QE3wVRZoTHoSH6ba3qyDxjkTQ91qxHxlPTPPi+ju8/t1hfrYXHZxRnXbd
 Ooc+GLjPQSCje7syqHvna5wIIaJaopODsTarKO7au9VxCZz+Ys+kBz9Zg g==;
X-CSE-ConnectionGUID: n85z96lOQw2PuY+0ikBlSQ==
X-CSE-MsgGUID: 3Ebk7kuZTjuTQ/sxbctznw==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="28136022"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; d="scan'208";a="28136022"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2024 02:30:52 -0700
X-CSE-ConnectionGUID: IvJqDkC3SaCYGJQcXlxh+Q==
X-CSE-MsgGUID: pmD5I61ARPy+l7mXDTbkYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; d="scan'208";a="44677906"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2024 02:30:49 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, kraxel@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 1/2] vfio/display: Fix potential memleak of edid info
Date: Fri, 28 Jun 2024 17:28:14 +0800
Message-Id: <20240628092815.164423-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628092815.164423-1-zhenzhong.duan@intel.com>
References: <20240628092815.164423-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

EDID related device region info is leaked in three paths:
1. In vfio_get_dev_region_info(), when edid info isn't find, the last
device region info is leaked.
2. In vfio_display_edid_init() error path, edid info is leaked.
3. In VFIODisplay destroying path, edid info is leaked.

Fixes: 08479114b0de ("vfio/display: add edid support.")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/display.c | 2 ++
 hw/vfio/helpers.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 661e921616..5926bd6628 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -171,6 +171,7 @@ static void vfio_display_edid_init(VFIOPCIDevice *vdev)
 
 err:
     trace_vfio_display_edid_write_error();
+    g_free(dpy->edid_info);
     g_free(dpy->edid_regs);
     dpy->edid_regs = NULL;
     return;
@@ -182,6 +183,7 @@ static void vfio_display_edid_exit(VFIODisplay *dpy)
         return;
     }
 
+    g_free(dpy->edid_info);
     g_free(dpy->edid_regs);
     g_free(dpy->edid_blob);
     timer_free(dpy->edid_link_timer);
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index b14edd46ed..3dd32b26a4 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -586,6 +586,7 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
         g_free(*info);
     }
 
+    g_free(*info);
     *info = NULL;
     return -ENODEV;
 }
-- 
2.34.1


