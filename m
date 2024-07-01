Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5A8C27C4F
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 01:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO6Bv-0007Cq-Nt; Sun, 30 Jun 2024 21:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sO6Bt-0007Bm-IB
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 21:50:49 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sO6Br-0002VV-VF
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 21:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719798648; x=1751334648;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bWftXaq3bJu5ofRw1ucpxYLjBnLtyLlRDFZLb1uv9AE=;
 b=hwS465sxTSxnDYPUU4NdeXJMktNuffq10fAr8+5MxXuQP0KOjb3QyhKf
 Cfg63+zS9HMtjv9nDzLakHbi5Q34a8ob6UBT+wlLivKKwBbmMw1Ks9eyz
 L///xj0hyVv4jtjazmlo+YLdplWG0eV2or6puDYBUz/ZG9QC5yxp49U+V
 nXOvR7FiG77dEnYQLsuDqoeXMEbv3llAJENBB7LXkPfZdXtKCurWbSr6L
 b8PCYjrq4+/wXmnGgvNrkt/lVM+fee/s/DhT+TpCUcWMaf2tzy1rHUB2P
 CXLC6wT5+6wI9XPu7+aI+9DIqyBf5bjArw70cYs0B2lZGktB3NzBgeIgE Q==;
X-CSE-ConnectionGUID: Y1T7DAshRG+RQdR6jUsO0g==
X-CSE-MsgGUID: 03clJ36tTCShuPfBMv0WWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="42319512"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; d="scan'208";a="42319512"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2024 18:50:47 -0700
X-CSE-ConnectionGUID: NzAXh+XsSeyEIqHVRQj7qg==
X-CSE-MsgGUID: E9lCSA0zQJO4bM5xJvnAaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; d="scan'208";a="45331382"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2024 18:50:45 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, marcandre.lureau@redhat.com,
 kraxel@redhat.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 2/2] vfio/display: Fix vfio_display_edid_init() error path
Date: Mon,  1 Jul 2024 09:48:09 +0800
Message-Id: <20240701014809.255682-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701014809.255682-1-zhenzhong.duan@intel.com>
References: <20240701014809.255682-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

vfio_display_edid_init() can fail for many reasons and return silently.
It would be good to report the error.

Old mdev driver may not support vfio edid region and we allow to go
through in this case.

vfio_display_edid_update() isn't changed because it can be called at
runtime when UI changes (i.e. window resize).

Fixes: 08479114b0de ("vfio/display: add edid support.")
Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/vfio/display.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 9c57fd3888..ea87830fe0 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -124,7 +124,7 @@ static void vfio_display_edid_ui_info(void *opaque, uint32_t idx,
     }
 }
 
-static void vfio_display_edid_init(VFIOPCIDevice *vdev)
+static bool vfio_display_edid_init(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODisplay *dpy = vdev->dpy;
     int fd = vdev->vbasedev.fd;
@@ -135,7 +135,8 @@ static void vfio_display_edid_init(VFIOPCIDevice *vdev)
                                    VFIO_REGION_SUBTYPE_GFX_EDID,
                                    &dpy->edid_info);
     if (ret) {
-        return;
+        /* Failed to get GFX edid info, allow to go through without edid. */
+        return true;
     }
 
     trace_vfio_display_edid_available();
@@ -167,15 +168,16 @@ static void vfio_display_edid_init(VFIOPCIDevice *vdev)
                                         vfio_display_edid_link_up, vdev);
 
     vfio_display_edid_update(vdev, true, 0, 0);
-    return;
+    return true;
 
 err:
+    error_setg(errp, "vfio: failed to read GFX edid field");
     trace_vfio_display_edid_write_error();
     g_free(dpy->edid_info);
     g_free(dpy->edid_regs);
     dpy->edid_info = NULL;
     dpy->edid_regs = NULL;
-    return;
+    return false;
 }
 
 static void vfio_display_edid_exit(VFIODisplay *dpy)
@@ -368,8 +370,7 @@ static bool vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
             return false;
         }
     }
-    vfio_display_edid_init(vdev);
-    return true;
+    return vfio_display_edid_init(vdev, errp);
 }
 
 static void vfio_display_dmabuf_exit(VFIODisplay *dpy)
-- 
2.34.1


