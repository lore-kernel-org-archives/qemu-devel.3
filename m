Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B12C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 10:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKED-0004sG-A1; Tue, 20 May 2025 06:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uHKEB-0004ri-Gi
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:29:43 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uHKE9-0004gB-EL
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747736982; x=1779272982;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QVe4ZfDlF+KN1Ku+/Uhd92OOHuL5O75EpmRDC6Ka9Vw=;
 b=BeJw6H15kfjwYQ/pZ2EbLDv2BQUpF4Cj6xyqzFy+berkTGk8BFkw7hhd
 A/7tn+YaII0g4OZf90NqYpTsqQMJz4iCHq+p6uRfGOMGqP5fxYaN+gprC
 uvDB1+eCZvYn4VTj4nP+an36ZpTxWDLp+1nX9LXKlzxp7y5lnXqlmu/ZN
 GnBLOab5wkd4uyt4YDrXmx51BI8Xky3X+iotScLGrXT5nZdiJj3299F7I
 v2X4fuCDkqpxX0+TWjducKRV0OzHJmXt3i51pbe1LCGVv8aJXZJ1V1T1J
 TmrycVpFqI1TeYYKYai41Y16Nwzhxoa8jggMT9Y9iImYVFHALt3ibrI3v g==;
X-CSE-ConnectionGUID: OdftwBB7Svq2Gc+Dr9TL2Q==
X-CSE-MsgGUID: SHvZauM3Qqy9PBum6iA4ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49566697"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="49566697"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 03:29:41 -0700
X-CSE-ConnectionGUID: HXt5MnjgSyC7CFljN6GtVg==
X-CSE-MsgGUID: SuPLIgPaTYODvzo/5Z8fdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="144905325"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 03:29:37 -0700
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
Subject: [PATCH v5 10/10] ram-block-attribute: Add more error handling during
 state changes
Date: Tue, 20 May 2025 18:28:50 +0800
Message-ID: <20250520102856.132417-11-chenyi.qiang@intel.com>
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

The current error handling is simple with the following assumption:
- QEMU will quit instead of resuming the guest if kvm_convert_memory()
  fails, thus no need to do rollback.
- The convert range is required to be in the desired state. It is not
  allowed to handle the mixture case.
- The conversion from shared to private is a non-failure operation.

This is sufficient for now as complext error handling is not required.
For future extension, add some potential error handling.
- For private to shared conversion, do the rollback operation if
  ram_block_attribute_notify_to_populated() fails.
- For shared to private conversion, still assert it as a non-failure
  operation for now. It could be an easy fail path with in-place
  conversion, which will likely have to retry the conversion until it
  works in the future.
- For mixture case, process individual blocks for ease of rollback.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 system/ram-block-attribute.c | 116 +++++++++++++++++++++++++++--------
 1 file changed, 90 insertions(+), 26 deletions(-)

diff --git a/system/ram-block-attribute.c b/system/ram-block-attribute.c
index 387501b569..0af3396aa4 100644
--- a/system/ram-block-attribute.c
+++ b/system/ram-block-attribute.c
@@ -289,7 +289,12 @@ static int ram_block_attribute_notify_to_discard(RamBlockAttribute *attr,
         }
         ret = rdl->notify_discard(rdl, &tmp);
         if (ret) {
-            break;
+            /*
+             * The current to_private listeners (VFIO dma_unmap and
+             * KVM set_attribute_private) are non-failing operations.
+             * TODO: add rollback operations if it is allowed to fail.
+             */
+            g_assert(ret);
         }
     }
 
@@ -300,7 +305,7 @@ static int
 ram_block_attribute_notify_to_populated(RamBlockAttribute *attr,
                                         uint64_t offset, uint64_t size)
 {
-    RamDiscardListener *rdl;
+    RamDiscardListener *rdl, *rdl2;
     int ret = 0;
 
     QLIST_FOREACH(rdl, &attr->rdl_list, next) {
@@ -315,6 +320,20 @@ ram_block_attribute_notify_to_populated(RamBlockAttribute *attr,
         }
     }
 
+    if (ret) {
+        /* Notify all already-notified listeners. */
+        QLIST_FOREACH(rdl2, &attr->rdl_list, next) {
+            MemoryRegionSection tmp = *rdl2->section;
+
+            if (rdl == rdl2) {
+                break;
+            }
+            if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+                continue;
+            }
+            rdl2->notify_discard(rdl2, &tmp);
+        }
+    }
     return ret;
 }
 
@@ -353,6 +372,9 @@ int ram_block_attribute_state_change(RamBlockAttribute *attr, uint64_t offset,
     const int block_size = ram_block_attribute_get_block_size(attr);
     const unsigned long first_bit = offset / block_size;
     const unsigned long nbits = size / block_size;
+    const uint64_t end = offset + size;
+    unsigned long bit;
+    uint64_t cur;
     int ret = 0;
 
     if (!ram_block_attribute_is_valid_range(attr, offset, size)) {
@@ -361,32 +383,74 @@ int ram_block_attribute_state_change(RamBlockAttribute *attr, uint64_t offset,
         return -1;
     }
 
-    /* Already discard/populated */
-    if ((ram_block_attribute_is_range_discard(attr, offset, size) &&
-         to_private) ||
-        (ram_block_attribute_is_range_populated(attr, offset, size) &&
-         !to_private)) {
-        return 0;
-    }
-
-    /* Unexpected mixture */
-    if ((!ram_block_attribute_is_range_populated(attr, offset, size) &&
-         to_private) ||
-        (!ram_block_attribute_is_range_discard(attr, offset, size) &&
-         !to_private)) {
-        error_report("%s, the range is not all in the desired state: "
-                     "(offset 0x%lx, size 0x%lx), %s",
-                     __func__, offset, size,
-                     to_private ? "private" : "shared");
-        return -1;
-    }
-
     if (to_private) {
-        bitmap_clear(attr->bitmap, first_bit, nbits);
-        ret = ram_block_attribute_notify_to_discard(attr, offset, size);
+        if (ram_block_attribute_is_range_discard(attr, offset, size)) {
+            /* Already private */
+        } else if (!ram_block_attribute_is_range_populated(attr, offset,
+                                                           size)) {
+            /* Unexpected mixture: process individual blocks */
+            for (cur = offset; cur < end; cur += block_size) {
+                bit = cur / block_size;
+                if (!test_bit(bit, attr->bitmap)) {
+                    continue;
+                }
+                clear_bit(bit, attr->bitmap);
+                ram_block_attribute_notify_to_discard(attr, cur, block_size);
+            }
+        } else {
+            /* Completely shared */
+            bitmap_clear(attr->bitmap, first_bit, nbits);
+            ram_block_attribute_notify_to_discard(attr, offset, size);
+        }
     } else {
-        bitmap_set(attr->bitmap, first_bit, nbits);
-        ret = ram_block_attribute_notify_to_populated(attr, offset, size);
+        if (ram_block_attribute_is_range_populated(attr, offset, size)) {
+            /* Already shared */
+        } else if (!ram_block_attribute_is_range_discard(attr, offset, size)) {
+            /* Unexpected mixture: process individual blocks */
+            unsigned long *modified_bitmap = bitmap_new(nbits);
+
+            for (cur = offset; cur < end; cur += block_size) {
+                bit = cur / block_size;
+                if (test_bit(bit, attr->bitmap)) {
+                    continue;
+                }
+                set_bit(bit, attr->bitmap);
+                ret = ram_block_attribute_notify_to_populated(attr, cur,
+                                                           block_size);
+                if (!ret) {
+                    set_bit(bit - first_bit, modified_bitmap);
+                    continue;
+                }
+                clear_bit(bit, attr->bitmap);
+                break;
+            }
+
+            if (ret) {
+                /*
+                 * Very unexpected: something went wrong. Revert to the old
+                 * state, marking only the blocks as private that we converted
+                 * to shared.
+                 */
+                for (cur = offset; cur < end; cur += block_size) {
+                    bit = cur / block_size;
+                    if (!test_bit(bit - first_bit, modified_bitmap)) {
+                        continue;
+                    }
+                    assert(test_bit(bit, attr->bitmap));
+                    clear_bit(bit, attr->bitmap);
+                    ram_block_attribute_notify_to_discard(attr, cur,
+                                                          block_size);
+                }
+            }
+            g_free(modified_bitmap);
+        } else {
+            /* Complete private */
+            bitmap_set(attr->bitmap, first_bit, nbits);
+            ret = ram_block_attribute_notify_to_populated(attr, offset, size);
+            if (ret) {
+                bitmap_clear(attr->bitmap, first_bit, nbits);
+            }
+        }
     }
 
     return ret;
-- 
2.43.5


