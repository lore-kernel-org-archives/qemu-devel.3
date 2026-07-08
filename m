Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1F1C44501
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMws-0006R8-Kr; Wed, 08 Jul 2026 03:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMwj-0006AX-OX; Wed, 08 Jul 2026 03:43:54 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMwh-0004ox-MA; Wed, 08 Jul 2026 03:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496632; x=1815032632;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EEg4UHmIJ9cGzWz8agv03EEjhFqp/LixB8XZva6GMqA=;
 b=L4QM8C1z3lNLn9ao7luKqPwCxWlUGrLCCs5YOhfNp4zxU8N/aipctGN5
 kb9wkOSzJAfrbiybztOSaB4YZK3GlYQ8w8i3L37eJDtp8Xa7JYtfNoaBi
 aOWBBvtuYILP3dniLUSp8mFeFbKWLLYbdpkTGqcsewqI9oCgKR3/AYSc/
 N5OHozr+qwuoEYWJf8sSwKFujPwiRjgmCT5t1s61ff5/V7wTnQVlpFrEB
 ohuXxhJyvPJ0uEEpuQgNUzy9R13UmqBSGyzptsbKY7fW+kD6C93dGfuGo
 pmeO8SkFyb5RDAcPgs9QlCbEtl4oCPt06dloncQB99cDHHDxfEjqVjnJX Q==;
X-CSE-ConnectionGUID: sF3xLdXlTXGYSR6ZfzNziQ==
X-CSE-MsgGUID: X3nkHBTXT727jGfzAwjufA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343363"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343363"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:43:31 -0700
X-CSE-ConnectionGUID: rccK9LTHQrCmdRr/whod2A==
X-CSE-MsgGUID: M5VA6PwqR6mMtDE6Igq8Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251556024"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:43:26 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 16/26] memory: Add wrappers for intermediate read/write steps
Date: Wed,  8 Jul 2026 16:10:42 +0800
Message-Id: <20260708081052.2276617-17-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708081052.2276617-1-zhao1.liu@intel.com>
References: <20260708081052.2276617-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Add the following two wrappers to allow bindgen to generate bindings
based on MemoryRegionSection:
 * rust_section_write_continue_step()
 * rust_section_read_continue_step()

This allows the Rust side to reconstruct the full write/read process,
similar to what address_space_write() and address_space_read_full() do.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/system/memory.h | 53 +++++++++++++++++++++++++++++++++++++++++
 system/physmem.c        | 16 +++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index 18f269ac4dab..87006ce79d47 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2917,6 +2917,59 @@ bool section_covers_region_addr(const MemoryRegionSection *section,
 void section_fuzz_dma_read(MemoryRegionSection *section,
                            hwaddr addr, hwaddr len);
 
+/**
+ * rust_section_write_continue_step: Write to a #MemoryRegionSection.
+ *
+ * Note: This function should only be used by the Rust side, and callers
+ * should not invoke it directly!
+ *
+ * This function provides a wrapper for flatview_write_continue_step(),
+ * and allows the Rust side to reconstruct the full write process, similar
+ * to what address_space_write() does.
+ *
+ * Must be called within an RCU critical section.
+ *
+ * @section: The #MemoryRegionSection to be accessed.
+ * @attrs: Memory transaction attributes.
+ * @buf: Buffer containing the data to be written.
+ * @len: The number of bytes to write.
+ * @mr_addr: The address within that memory region.
+ * @l: Pointer to the actual length. On return, this is updated to the
+ * number of bytes written.
+ *
+ * Returns:
+ * A MemTxResult indicating whether the operation succeeded or failed
+ * (e.g., unassigned memory, device rejected the transaction, IOMMU fault).
+ */
+MemTxResult rust_section_write_continue_step(MemoryRegionSection *section,
+    MemTxAttrs attrs, const uint8_t *buf, hwaddr len, hwaddr mr_addr, hwaddr *l);
+
+/**
+ * rust_section_read_continue_step: Read from a #MemoryRegionSection.
+ *
+ * Note: This function should only be used by the Rust side, and callers
+ * should not invoke it directly!
+ *
+ * This function provides a wrapper for flatview_read_continue_step(),
+ * and allows the Rust side to reconstruct the full read process, similar
+ * to what address_space_read_full() does.
+ *
+ * Must be called within an RCU critical section.
+ *
+ * @section: The #MemoryRegionSection to be accessed.
+ * @attrs: Memory transaction attributes.
+ * @buf: Buffer to store the read data.
+ * @len: The expected number of bytes to read.
+ * @mr_addr: The address within that memory region.
+ * @l: Pointer to the actual length. On return, this is updated to the
+ * number of bytes read.
+ *
+ * Returns:
+ * A MemTxResult indicating whether the operation succeeded or failed.
+ */
+MemTxResult rust_section_read_continue_step(MemoryRegionSection *section,
+    MemTxAttrs attrs, uint8_t *buf, hwaddr len, hwaddr mr_addr, hwaddr *l);
+
 /* Coalesced MMIO regions are areas where write operations can be reordered.
  * This usually implies that write operations are side-effect free.  This allows
  * batching which can make a major impact on performance when using
diff --git a/system/physmem.c b/system/physmem.c
index c227d4680e33..f19709be59e5 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3398,6 +3398,14 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
     }
 }
 
+MemTxResult
+rust_section_read_continue_step(MemoryRegionSection *section, MemTxAttrs attrs,
+                                uint8_t *buf, hwaddr len, hwaddr mr_addr,
+                                hwaddr *l)
+{
+    return flatview_read_continue_step(attrs, buf, len, mr_addr, l, section->mr);
+}
+
 /* Called within RCU critical section.  */
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    MemTxAttrs attrs, void *ptr,
@@ -3987,6 +3995,14 @@ static MemTxResult address_space_write_continue_cached(MemTxAttrs attrs,
     return result;
 }
 
+MemTxResult
+rust_section_write_continue_step(MemoryRegionSection *section, MemTxAttrs attrs,
+                                 const uint8_t *buf, hwaddr len, hwaddr mr_addr,
+                                 hwaddr *l)
+{
+    return flatview_write_continue_step(attrs, buf, len, mr_addr, l, section->mr);
+}
+
 /* Called within RCU critical section.  */
 static MemTxResult address_space_read_continue_cached(MemTxAttrs attrs,
                                                       void *ptr, hwaddr len,
-- 
2.34.1


