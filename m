Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF243C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 10:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKE5-0004mx-G3; Tue, 20 May 2025 06:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uHKE3-0004mk-Sm
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:29:35 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uHKE1-0004gB-US
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747736974; x=1779272974;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OTa0g2q+m0xONAZ985oRQ8DaRJiUFsfwCwbWIOiPDSE=;
 b=io881stpj2+Cy1W8gnutmmBl3XYWq4Ato45kSPl68AtVEzeJCFv2zEh5
 kZQHmWcv0idcOOsQ4DOCydbeEr+QrCgPv0YuW5P1xPMmyKzJd+7PESw76
 1OGItSc34l1Lp2lpjBIs8zNhBSTgdKmDNh+KEf9oZ2TQE+96SONknRSoR
 uM23QwVbEWhWhWwNLmLJ5GRIqg5E0WM0wsOB0UZWFboFS/ikcvdzciYUc
 Jko15nRP9GQvuIEXft5y8AHH0WiKOk1nb6+XHlLBaMfR3+u82GTYupKaP
 dVyDY24nccKqa6FQSLy1xrYubvPMV6f+Lo9COrTlOiO4jvRtTR9kdfydo A==;
X-CSE-ConnectionGUID: lcx5nT/+RoOlCK93G0AcxA==
X-CSE-MsgGUID: nwDYdWHrQiOIUK+BmlQjPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49566681"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="49566681"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 03:29:34 -0700
X-CSE-ConnectionGUID: j9eFD9hUQnubW4cm6fpS2Q==
X-CSE-MsgGUID: Vyb9SCSARHefsgMJnbyKSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="144905299"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 03:29:30 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 Gao Chao <chao.gao@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v5 08/10] memory: Change NotifyRamDiscard() definition to
 return the result
Date: Tue, 20 May 2025 18:28:48 +0800
Message-ID: <20250520102856.132417-9-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250520102856.132417-1-chenyi.qiang@intel.com>
References: <20250520102856.132417-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
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

So that the caller can check the result of NotifyRamDiscard() handler if
the operation fails.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
Changes in v5:
    - Revert to use of NotifyRamDiscard()

Changes in v4:
    - Newly added.
---
 hw/vfio/listener.c           | 6 ++++--
 include/system/memory.h      | 4 ++--
 system/ram-block-attribute.c | 3 +--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index bfacb3d8d9..06454e0584 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -190,8 +190,8 @@ out:
     rcu_read_unlock();
 }
 
-static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
-                                            MemoryRegionSection *section)
+static int vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
+                                           MemoryRegionSection *section)
 {
     VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
                                                 listener);
@@ -206,6 +206,8 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
         error_report("%s: vfio_container_dma_unmap() failed: %s", __func__,
                      strerror(-ret));
     }
+
+    return ret;
 }
 
 static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
diff --git a/include/system/memory.h b/include/system/memory.h
index 83b28551c4..e5155120d9 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -518,8 +518,8 @@ struct IOMMUMemoryRegionClass {
 typedef struct RamDiscardListener RamDiscardListener;
 typedef int (*NotifyRamPopulate)(RamDiscardListener *rdl,
                                  MemoryRegionSection *section);
-typedef void (*NotifyRamDiscard)(RamDiscardListener *rdl,
-                                 MemoryRegionSection *section);
+typedef int (*NotifyRamDiscard)(RamDiscardListener *rdl,
+                                MemoryRegionSection *section);
 
 struct RamDiscardListener {
     /*
diff --git a/system/ram-block-attribute.c b/system/ram-block-attribute.c
index f12dd4b881..896c3d7543 100644
--- a/system/ram-block-attribute.c
+++ b/system/ram-block-attribute.c
@@ -66,8 +66,7 @@ static int ram_block_attribute_notify_discard_cb(MemoryRegionSection *section,
 {
     RamDiscardListener *rdl = arg;
 
-    rdl->notify_discard(rdl, section);
-    return 0;
+    return rdl->notify_discard(rdl, section);
 }
 
 static int
-- 
2.43.5


