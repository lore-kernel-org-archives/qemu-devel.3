Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2B9C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 07:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1hFf-0001Ms-N8; Mon, 07 Apr 2025 03:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u1hFU-0001KG-Bn
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:50:30 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u1hFS-0005SK-Dq
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744012227; x=1775548227;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sVUIY4fIKGHtOSqBXZ7Rk7z5KaG5cmAGeldWUKYdfBY=;
 b=Yg5+0gYXy5Hhw63I2r4wNzq0wa3fO/pFeBY5HK2QHLBXaQLAlC5MVBw0
 BhEK/jsewrmR964/7kVT8gtL2G/BZaoASjBmAnkq042BW2GlvtMOl7M4A
 RgWiWmdg/uxG+vHSK7cToVUFemLkANrB6E4NIvVEuiX7j61+Qqa4OFNys
 1/0LGtTytdUd8ELm4E09s755hXpO4mBXX1vSNoo1FXM5zu2skgaoQ7y5e
 Xq3HkFk2bXgil+RBpXsnEb0plHJacb9YBEAhxOGwToPEZEwXZ6F9OOg6l
 GdQBwnmk2QEzwiTjPOljXbtYXZty513MyXezMxMemkF6hX0aGAq6qjnYg g==;
X-CSE-ConnectionGUID: ihGQiV/gT325HEfmbbS/gQ==
X-CSE-MsgGUID: j+HFZ04rTdiP7jA9W8XIJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="67857584"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; d="scan'208";a="67857584"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 00:50:25 -0700
X-CSE-ConnectionGUID: zVXf4v0QRxeKIUoz8K2CEQ==
X-CSE-MsgGUID: 62JTDrV0Rx+lOH8R1pgAqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; d="scan'208";a="128405674"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 00:50:22 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v4 10/13] memory: Change NotifyStateClear() definition to
 return the result
Date: Mon,  7 Apr 2025 15:49:30 +0800
Message-ID: <20250407074939.18657-11-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250407074939.18657-1-chenyi.qiang@intel.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=chenyi.qiang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
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

So that the caller can check the result of NotifyStateClear() handler if
the operation fails.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
Changes in v4:
    - Newly added.
---
 hw/vfio/common.c      | 18 ++++++++++--------
 include/exec/memory.h |  4 ++--
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 48468a12c3..6e49ae597d 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -335,8 +335,8 @@ out:
     rcu_read_unlock();
 }
 
-static void vfio_state_change_notify_to_state_clear(VFIOContainerBase *bcontainer,
-                                                    MemoryRegionSection *section)
+static int vfio_state_change_notify_to_state_clear(VFIOContainerBase *bcontainer,
+                                                   MemoryRegionSection *section)
 {
     const hwaddr size = int128_get64(section->size);
     const hwaddr iova = section->offset_within_address_space;
@@ -348,24 +348,26 @@ static void vfio_state_change_notify_to_state_clear(VFIOContainerBase *bcontaine
         error_report("%s: vfio_container_dma_unmap() failed: %s", __func__,
                      strerror(-ret));
     }
+
+    return ret;
 }
 
-static void vfio_ram_discard_notify_discard(StateChangeListener *scl,
-                                            MemoryRegionSection *section)
+static int vfio_ram_discard_notify_discard(StateChangeListener *scl,
+                                           MemoryRegionSection *section)
 {
     RamDiscardListener *rdl = container_of(scl, RamDiscardListener, scl);
     VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
                                                 listener);
-    vfio_state_change_notify_to_state_clear(vrdl->bcontainer, section);
+    return vfio_state_change_notify_to_state_clear(vrdl->bcontainer, section);
 }
 
-static void vfio_private_shared_notify_to_private(StateChangeListener *scl,
-                                                  MemoryRegionSection *section)
+static int vfio_private_shared_notify_to_private(StateChangeListener *scl,
+                                                 MemoryRegionSection *section)
 {
     PrivateSharedListener *psl = container_of(scl, PrivateSharedListener, scl);
     VFIOPrivateSharedListener *vpsl = container_of(psl, VFIOPrivateSharedListener,
                                                    listener);
-    vfio_state_change_notify_to_state_clear(vpsl->bcontainer, section);
+    return vfio_state_change_notify_to_state_clear(vpsl->bcontainer, section);
 }
 
 static int vfio_state_change_notify_to_state_set(VFIOContainerBase *bcontainer,
diff --git a/include/exec/memory.h b/include/exec/memory.h
index a61896251c..9472d9e9b4 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -523,8 +523,8 @@ typedef int (*ReplayStateChange)(MemoryRegionSection *section, void *opaque);
 typedef struct StateChangeListener StateChangeListener;
 typedef int (*NotifyStateSet)(StateChangeListener *scl,
                               MemoryRegionSection *section);
-typedef void (*NotifyStateClear)(StateChangeListener *scl,
-                                 MemoryRegionSection *section);
+typedef int (*NotifyStateClear)(StateChangeListener *scl,
+                                MemoryRegionSection *section);
 
 struct StateChangeListener {
     /*
-- 
2.43.5


