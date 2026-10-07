Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F56CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEY1c-0004a7-8k; Wed, 07 Oct 2026 16:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xEY1Y-0004ZU-Nq
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:14:00 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xEY1W-0002B7-S1
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791404039; x=1822940039;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=inwtww5NHwOAvlK6g7TuLU3xADf1XCgYBQ5nhrGk3Rk=;
 b=GoiBhghsxaU/pW2JLEzCdamFjsXI3ogeYYhWsxCOQNcnXgrdFVXw9WgP
 /cTP6ZOqN9esiF56LHmFR72WzICB5PFaC0b0v2TlCCHIX9efr6Y1G31DF
 Ou8eTgUpQgFttDaolBFaRFsC46rjJ2H/hBKvnv1mZdGy/X9EVgYqEpG0a
 o5GPR9p7u9tg2D7c+AQ0q3eJN9VCtikzJaasMkktNEWny0cAZ6TZTOibS
 pS8jlOvvrOFcshn2lKPkr3XewV0b/qq/FHduP+VmtH3iDXa+vuPIdVPk8
 7TrpB2FTIuLkkTbONTzNm0fQ1Nfiw7t6BfNdXdeHsHNUVcxANcfRiIRdc A==;
X-CSE-ConnectionGUID: y6fMb854Sf6E+ObFnlGwEg==
X-CSE-MsgGUID: Z1xIHdSVQrq6X2/LTPsJ8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="178480"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="178480"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 13:13:49 -0700
X-CSE-ConnectionGUID: 3Wt+APqCTJ6ey32RBaCAKA==
X-CSE-MsgGUID: SdEpRjlvQXSQ0Ya1OKIu3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="1564964"
Received: from vkasired-desk1.fm.intel.com ([10.121.64.242])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 13:13:47 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v13 5/9] vfio/region: Add a helper to get VFIO region from
 memory region
Date: Wed,  7 Oct 2026 13:09:24 -0700
Message-ID: <20261007201222.648687-6-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007201222.648687-1-vivek.kasireddy@intel.com>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Having a way to get the VFIO region associated with a memory region
is helpful in various scenarios. For example, this capability can
be useful in retrieving the region info such as index and offset
needed for mapping a part of a VFIO region or creating a dmabuf.

Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/vfio/vfio-region.h | 10 ++++++++++
 hw/vfio/region.c      | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
index 58b236f113..004be67269 100644
--- a/hw/vfio/vfio-region.h
+++ b/hw/vfio/vfio-region.h
@@ -44,4 +44,14 @@ void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
 void vfio_region_exit(VFIORegion *region);
 void vfio_region_finalize(VFIORegion *region);
 
+/**
+ * Return the VFIO region associated with a given MemoryRegion. This can
+ * be useful in retrieving region info such as index and offset.
+ *
+ * @mr: MemoryRegion to use
+ *
+ * Returns the region or NULL on error.
+ */
+VFIORegion *vfio_get_region_from_mr(MemoryRegion *mr);
+
 #endif /* HW_VFIO_REGION_H */
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 54ad11a6c8..37678aeb2d 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -528,3 +528,14 @@ void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled)
     trace_vfio_region_mmaps_set_enabled(memory_region_name(region->mem),
                                         enabled);
 }
+
+VFIORegion *vfio_get_region_from_mr(MemoryRegion *mr)
+{
+    while (mr->container) {
+        if (mr->ops == &vfio_region_ops) {
+            return mr->opaque;
+        }
+        mr = mr->container;
+    }
+    return NULL;
+}
-- 
2.53.0


