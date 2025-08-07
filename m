Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AAAC87FDA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzSl-0004ZI-4n; Thu, 07 Aug 2025 08:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzSI-0003tn-BI; Thu, 07 Aug 2025 08:10:46 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzSG-0005Cn-1o; Thu, 07 Aug 2025 08:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568644; x=1786104644;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ICNg+pbeHF8H9llJc/4axDzWq6vSvnR3oi+HF/P7AgQ=;
 b=S4yhd1fKstoBo3hqWgllUKi98kRNAiLlu+qoDHhRofm5k/OcBjKSYudl
 C+Vl9rSQOFLpdAo0aLUxgh7rWlQ8ONRwWMwqaWhauQvE+7W+U1BfVFBsh
 KYbaH/WgQeWsfhT0fQ8cZqtOaJY4G95bvEUsnulEH/ZcGvdKKWLQVCucP
 8TgXXX3Bc2UYzmpOjEEEUnhHdFcPeV2nrrD7zScJuZ3KG0mOZh9EiAXaD
 TDrJAeZkBqy8EKSD07ITKznPTQqYsGzUqwXPyeDLF4UifJRwyeQhLgHVU
 3Cv1aOT2c0bqk0C8FMPut46qxxUUKyhbqazxloK+6dbzOoMRGlseMfJq4 g==;
X-CSE-ConnectionGUID: r4uizmZQScmmECee7Mlj2Q==
X-CSE-MsgGUID: 4aIVwCjcQnaT9Urz4ujh1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036861"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036861"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:10:09 -0700
X-CSE-ConnectionGUID: 0hU21DClSCOqIceceX82LQ==
X-CSE-MsgGUID: wrC6lw8VRGC/QhT8EEJ2kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701194"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:10:06 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 20/26] memory: Add wrappers of intermediate steps for read/write
Date: Thu,  7 Aug 2025 20:30:21 +0800
Message-Id: <20250807123027.2910950-21-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807123027.2910950-1-zhao1.liu@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Add these 2 wrappers to allow bindgen to generate the bindings based on
MemoryRegionSection:
 * section_rust_write_continue_step()
 * section_rust_read_continue_step()

Then Rust side could be able to re-build a full write/read processes as
address_space_write()/address_space_read_full() did.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/system/memory.h | 51 +++++++++++++++++++++++++++++++++++++++++
 system/physmem.c        | 16 +++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index 110ad0a3b590..a75c8c348f58 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -3413,6 +3413,57 @@ uint8_t *section_get_host_addr(const MemoryRegionSection *section,
 void section_fuzz_dma_read(MemoryRegionSection *section,
                            hwaddr addr, hwaddr len);
 
+/**
+ * section_rust_write_continue_step: write to #MemoryRegionSection.
+ *
+ * Not: This function should only used by Rust side, and user shouldn't
+ * call it directly!
+ *
+ * This function provides a wrapper of flatview_write_continue_step(),
+ * and allows Rust side to re-build a full write process as
+ * address_space_write() did.
+ *
+ * Should be called from an RCU critical section.
+ *
+ * @section: #MemoryRegionSection to be accessed.
+ * @attrs: memory transaction attributes.
+ * @buf: buffer with the data to be written.
+ * @len: the number of bytes to write.
+ * @mr_addr: address within that memory region.
+ * @l: the actual length of the data is written after function returns.
+ *
+ * Return a MemTxResult indicating whether the operation succeeded
+ * or failed (eg unassigned memory, device rejected the transaction,
+ * IOMMU fault).
+ */
+MemTxResult section_rust_write_continue_step(MemoryRegionSection *section,
+    MemTxAttrs attrs, const uint8_t *buf, hwaddr len, hwaddr mr_addr, hwaddr *l);
+
+/**
+ * section_read_continue_step: read from #MemoryRegionSection.
+ *
+ * Not: This function should only used by Rust side, and user shouldn't
+ * call it directly!
+ *
+ * This function provides a wrapper of flatview_read_continue_step(),
+ * and allows Rust side to re-build a full write process as
+ * address_space_read_full() did.
+ *
+ * Should be called from an RCU critical section.
+ *
+ * @section: #MemoryRegionSection to be accessed.
+ * @attrs: memory transaction attributes.
+ * @buf: buffer to be written.
+ * @len: the number of bytes is expected to read.
+ * @mr_addr: address within that memory region.
+ * @l: the actual length of the data is read after function returns.
+ *
+ * Return a MemTxResult indicating whether the operation succeeded
+ * or failed.
+ */
+MemTxResult section_read_continue_step(MemoryRegionSection *section,
+    MemTxAttrs attrs, uint8_t *buf, hwaddr len, hwaddr mr_addr, hwaddr *l);
+
 /*
  * Inhibit technologies that require discarding of pages in RAM blocks, e.g.,
  * to manage the actual amount of memory consumed by the VM (then, the memory
diff --git a/system/physmem.c b/system/physmem.c
index e06633f4d8a2..0c30dea775ca 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3119,6 +3119,14 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
     }
 }
 
+MemTxResult
+section_read_continue_step(MemoryRegionSection *section, MemTxAttrs attrs,
+                           uint8_t *buf, hwaddr len, hwaddr mr_addr,
+                           hwaddr *l)
+{
+    return flatview_read_continue_step(attrs, buf, len, mr_addr, l, section->mr);
+}
+
 /* Called within RCU critical section.  */
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    MemTxAttrs attrs, void *ptr,
@@ -3707,6 +3715,14 @@ static MemTxResult address_space_write_continue_cached(MemTxAttrs attrs,
     return result;
 }
 
+MemTxResult
+section_rust_write_continue_step(MemoryRegionSection *section, MemTxAttrs attrs,
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


