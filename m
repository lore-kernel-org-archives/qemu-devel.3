Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E20C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 09:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN7wc-0005oy-5K; Fri, 28 Jun 2024 05:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sN7wY-0005nv-Ug
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 05:30:58 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sN7wV-0005ZE-Ko
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 05:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719567056; x=1751103056;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/76VxKHdez8Q9AtArS2MWAWO4b7JCMBzxTeaXLLoAlU=;
 b=nWMBMSEK71VqS3MGQQmJ027Uo7mF6RchFC7w2hKVM2hvApVfK0HL8k3Y
 YM1+oVl3jRg/evyh9YwYMJwug0eVpxxXd/kRL26a7HLzgpWv64x2mvJpp
 2VlzPfrZ+EfBWhMAexNx9qz9OoRbrpa5T7TCfpkS+oc3Q1eOGwGssurtc
 QMvl+Y/mDSRGZRgLmLAwqVpAHwfmrQeEX1PFCrv5ux68XAE/zkUtgMozZ
 YJSV5JTpXupnx5hQ3DTj1amp/88CNfYvYHHWfWeSw8PaGAU8FeiJ1NNEh
 KBGI66IWTb01srEv23UwnJbOx9UxyFrw8XyWbnK84fI2Ay4wLjufovSe4 A==;
X-CSE-ConnectionGUID: qar2CjOHTDSrhXRv1e3Yhg==
X-CSE-MsgGUID: G3PLLvb9S5+CAEX1lJfNPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="28136028"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; d="scan'208";a="28136028"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2024 02:30:54 -0700
X-CSE-ConnectionGUID: KAfSqj9zTXmuqzZ0BEAaMQ==
X-CSE-MsgGUID: WuR/3kG5TKe8/oV7rucDJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; d="scan'208";a="44677920"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2024 02:30:51 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, kraxel@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 2/2] vfio/display: Fix vfio_display_edid_init() error path
Date: Fri, 28 Jun 2024 17:28:15 +0800
Message-Id: <20240628092815.164423-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628092815.164423-1-zhenzhong.duan@intel.com>
References: <20240628092815.164423-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

vfio_display_edid_init() can fail for many reasons and return silently.
It would be good to report the error.

Old mdev driver may not support vfio edid region and we allow to go
through in this case.

vfio_display_edid_update() isn't changed because it can be called at
runtime when UI changes (i.e. window resize).

Fixes: 08479114b0de ("vfio/display: add edid support.")
Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/display.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 5926bd6628..462845ce69 100644
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
@@ -167,14 +168,15 @@ static void vfio_display_edid_init(VFIOPCIDevice *vdev)
                                         vfio_display_edid_link_up, vdev);
 
     vfio_display_edid_update(vdev, true, 0, 0);
-    return;
+    return true;
 
 err:
+    error_setg(errp, "vfio: failed to read GFX edid field");
     trace_vfio_display_edid_write_error();
     g_free(dpy->edid_info);
     g_free(dpy->edid_regs);
     dpy->edid_regs = NULL;
-    return;
+    return false;
 }
 
 static void vfio_display_edid_exit(VFIODisplay *dpy)
@@ -367,8 +369,7 @@ static bool vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
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


