Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14474C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 12:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukLnR-0003Od-5x; Fri, 08 Aug 2025 08:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ukLnJ-0002v0-07
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:01:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ukLnE-00076G-Uc
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754654510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=imDXixPIMin3UoifJR9aHiy7BOYjvkrGESKTOnvCu/o=;
 b=Wl27C+b7dj45MqkmekCvGg921lohpY0G8qMU75F/lbbjP5/hINhiAZXlXEW0hTC1m42Meo
 HagwzF+AfvTlhunSTcLaiJ+4dv7zmnX+xmk4qC3DIsME/AFGfCcntiTbsWdy5H0pCJ5Yd4
 oHhel1TaRxD8tuZW0hdo7WVdjtco6uM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-7sD6mNIJP4WGXmhgNs_1OQ-1; Fri,
 08 Aug 2025 08:01:47 -0400
X-MC-Unique: 7sD6mNIJP4WGXmhgNs_1OQ-1
X-Mimecast-MFC-AGG-ID: 7sD6mNIJP4WGXmhgNs_1OQ_1754654506
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20068195608E; Fri,  8 Aug 2025 12:01:46 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 05AD119560AD; Fri,  8 Aug 2025 12:01:43 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, mtosatti@redhat.com
Subject: [PATCH v3 01/10] memory: reintroduce BQL-free fine-grained PIO/MMIO
Date: Fri,  8 Aug 2025 14:01:28 +0200
Message-ID: <20250808120137.2208800-2-imammedo@redhat.com>
In-Reply-To: <20250808120137.2208800-1-imammedo@redhat.com>
References: <20250808120137.2208800-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch brings back Jan's idea [1] of BQL-free IO access

This will let us make access to ACPI PM/HPET timers cheaper,
and prevent BQL contention in case of workload that heavily
uses the timers with a lot of vCPUs.

1) 196ea13104f (memory: Add global-locking property to memory regions)
   ... de7ea885c539 (kvm: Switch to unlocked MMIO)

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v3:
  add comment for 'mr->disable_reentrancy_guard = true'
    Peter Xu <peterx@redhat.com>
---
 include/system/memory.h | 10 ++++++++++
 system/memory.c         | 15 +++++++++++++++
 system/physmem.c        |  2 +-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index e2cd6ed126..d04366c994 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -833,6 +833,7 @@ struct MemoryRegion {
     bool nonvolatile;
     bool rom_device;
     bool flush_coalesced_mmio;
+    bool lockless_io;
     bool unmergeable;
     uint8_t dirty_log_mask;
     bool is_iommu;
@@ -2341,6 +2342,15 @@ void memory_region_set_flush_coalesced(MemoryRegion *mr);
  */
 void memory_region_clear_flush_coalesced(MemoryRegion *mr);
 
+/**
+ * memory_region_enable_lockless_io: Enable lockless (BQL free) acceess.
+ *
+ * Enable BQL-free access for devices with fine-grained locking.
+ *
+ * @mr: the memory region to be updated.
+ */
+void memory_region_enable_lockless_io(MemoryRegion *mr);
+
 /**
  * memory_region_add_eventfd: Request an eventfd to be triggered when a word
  *                            is written to a location.
diff --git a/system/memory.c b/system/memory.c
index 5646547940..44701c465c 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2546,6 +2546,21 @@ void memory_region_clear_flush_coalesced(MemoryRegion *mr)
     }
 }
 
+void memory_region_enable_lockless_io(MemoryRegion *mr)
+{
+    mr->lockless_io = true;
+    /*
+     * reentrancy_guard has per device scope, that when enabled
+     * will effectively prevent concurrent access to device's IO
+     * MemoryRegion(s) by not calling accessor callback.
+     *
+     * Turn it off for lock-less IO enabled devices, to allow
+     * concurrent IO.
+     * TODO: remove this when reentrancy_guard becomes per transaction.
+     */
+    mr->disable_reentrancy_guard = true;
+}
+
 void memory_region_add_eventfd(MemoryRegion *mr,
                                hwaddr addr,
                                unsigned size,
diff --git a/system/physmem.c b/system/physmem.c
index e5dd760e0b..f498572fc8 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2900,7 +2900,7 @@ bool prepare_mmio_access(MemoryRegion *mr)
 {
     bool release_lock = false;
 
-    if (!bql_locked()) {
+    if (!bql_locked() && !mr->lockless_io) {
         bql_lock();
         release_lock = true;
     }
-- 
2.47.1


