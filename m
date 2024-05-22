Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCD7C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 04:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9doM-0001M9-VQ; Wed, 22 May 2024 00:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9doL-0001LW-2k
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:42:45 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9doJ-0005sK-Gf
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716352964; x=1747888964;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VtbDG/+t6qft6P8QfUBwDp+iFsdeOGEcKMeRYTvDkGE=;
 b=AaCh8no2Zh1+2RcZlZLA5hO9owpZPPM+i7DQADY3ip7Z1DCyZdmB3G1y
 MMxuZN6lIUAfJhF+S41ISzlD8sn4Uu+6h/y0AI5sGLMN82N+f8zv9FmGi
 VTbET59ZBRvWVQAdOR5yz9NIEtLCRcunQcT9FeWSLbic9AvH4+hMVrxht
 sIYj8t/+uVv/ypx9bo6llXhbOyXBzpR8yH9UOiChjPi009lWbEpIkY7QB
 2w0YRvYfhbUwfl5eUiW8SHeT0AhSNKCoRSiHvM6QpLrGtrfg0qBwv6ZOJ
 21PbUztntmq0WffMlwCX94Z9Th81E9uzR8jScC+H76dujWGF1E2ZDQygT A==;
X-CSE-ConnectionGUID: /rlMVQiISJa8CC/VEDVN0g==
X-CSE-MsgGUID: KRVCo36hR6yPJiLbQt8rOQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="23994123"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="23994123"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:42:42 -0700
X-CSE-ConnectionGUID: 3/K4b9TiRbmtptldQxtE4Q==
X-CSE-MsgGUID: lMAfGMS9QAGBIeWL3ckUkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33683636"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:42:40 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 03/20] vfio/helpers: Use g_autofree in
 vfio_set_irq_signaling()
Date: Wed, 22 May 2024 12:39:58 +0800
Message-Id: <20240522044015.412951-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522044015.412951-1-zhenzhong.duan@intel.com>
References: <20240522044015.412951-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
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

Local pointer irq_set is freed before return from
vfio_set_irq_signaling().

Use 'g_autofree' to avoid the g_free() calls.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/helpers.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 47b4096c05..1f3bdd9bf0 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -111,7 +111,7 @@ int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
                            int action, int fd, Error **errp)
 {
     ERRP_GUARD();
-    struct vfio_irq_set *irq_set;
+    g_autofree struct vfio_irq_set *irq_set = NULL;
     int argsz, ret = 0;
     const char *name;
     int32_t *pfd;
@@ -130,7 +130,6 @@ int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
     if (ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
         ret = -errno;
     }
-    g_free(irq_set);
 
     if (!ret) {
         return 0;
-- 
2.34.1


