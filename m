Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96703103E19B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 05:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w35qy-0004ow-IT; Thu, 19 Mar 2026 01:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w35qk-0004mv-WF
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 01:23:15 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w35qj-0007tU-Fu
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 01:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773897794; x=1805433794;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QuvOPLgWq33qfjM99tcEL47AWR773cTQyaf9yFQOg/M=;
 b=Z4ufSM8ekfXkli8kiwrYu5V4QIG4gpjk9udjuxgFaE2HFuyH2dEfxXkc
 m7HasEh2mlAFZBJBo6sV8On/oK2kgHwiJMdvmptPudiU5iS2W87yWIjrq
 nZPRI1ZOIaXlV8mTBJojEy0yncgHwj9FQxLgdYmTpZzVi6+yj2MpwQnkh
 cd8QV7ltT6F5a55s+DyY6joZ/C5as2p1CB9POanySWryrJtYAt5KrZsM0
 zgDEPi64FrZWHKsVMCatOoC6uBNKsY7MQWME0/uduu4iCc7hZzevCy7e2
 thRTERIMt/BM1TJ4i9mysgzEao7U07YvE8Z1+jgKYJiRTPVXEUJF/B9+N A==;
X-CSE-ConnectionGUID: jBtewN6hTG+YBfZsKjo/5w==
X-CSE-MsgGUID: ZSPVOkw+SD+pJxlHfGsLFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74660389"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="74660389"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 22:23:06 -0700
X-CSE-ConnectionGUID: 2/bsmXsVRWWLjwVi6/d5Qw==
X-CSE-MsgGUID: iJRmHkU7ToC42YDPKLjPMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="218355527"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 22:23:03 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v12 06/10] vfio/region: Add a helper to get VFIO region from
 memory region
Date: Wed, 18 Mar 2026 22:15:55 -0700
Message-ID: <20260319052023.2088685-7-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
References: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 9b21d4ee5b..3dd47f77f6 100644
--- a/hw/vfio/vfio-region.h
+++ b/hw/vfio/vfio-region.h
@@ -45,4 +45,14 @@ void vfio_region_unmap(VFIORegion *region);
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
+void *vfio_get_region_from_mr(MemoryRegion *mr);
+
 #endif /* HW_VFIO_REGION_H */
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 47fdc2df34..9d7ac339c9 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -539,3 +539,14 @@ void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled)
     trace_vfio_region_mmaps_set_enabled(memory_region_name(region->mem),
                                         enabled);
 }
+
+void *vfio_get_region_from_mr(MemoryRegion *mr)
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


