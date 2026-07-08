Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C739C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMwJ-0004uG-Ml; Wed, 08 Jul 2026 03:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMwH-0004jQ-DB; Wed, 08 Jul 2026 03:43:25 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMwF-0004ox-5U; Wed, 08 Jul 2026 03:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496603; x=1815032603;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jGAaPjd4VCUL5nTjVuv77/GOZrZpCcneoRNxSWdnEMI=;
 b=Hfbv4jSDChmQJMxRWXQKD23UNZA1iKbMZbVqTzWhxBVZudoWFlFqxctB
 GzgY2xv8OtEOXq9VOazBxEYhSwEGmdt7YFL1ePOD7r0l5Ncfl5gQOAZEy
 Oq1AJQaTvA1lHH7iAXhDmM/OiB7b9GlmQY8NShoav5YHboXQkCrAvV/29
 0TZEVmc8WofjeozpZDyBp+8fuUT43jdR/cnYEaQePjzqfY+KqKGLKMc3h
 AF5dk7VC6K8vhPFTlQWizL0u0MtQ7GWYjBmcGmpWS3WKI2d0rN6vQ0zRM
 lUjzLSDFMaMrcVdRCmfDk70T0f1+cqrpGPx14sm0lhbjzVq39TGXazziq Q==;
X-CSE-ConnectionGUID: K1OwHT9yQRuyp7FQ9fwGag==
X-CSE-MsgGUID: 2OmBiKIZSZyPMxd36TjDFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343344"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343344"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:43:22 -0700
X-CSE-ConnectionGUID: sBNDDmckTcuid/io2WDkWw==
X-CSE-MsgGUID: iee9mZPWSNyQWVaojHyg6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251556005"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:43:18 -0700
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
Subject: [RFC v2 14/26] memory: Rename flatview_access_allowed() to
 memory_region_access_allowed()
Date: Wed,  8 Jul 2026 16:10:40 +0800
Message-Id: <20260708081052.2276617-15-zhao1.liu@intel.com>
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

flatview_access_allowed() takes a `MemoryRegion *` as an argument,
meaning it operates on a MemoryRegion rather than a FlatView. Therefore,
rename it to memory_region_access_allowed() to accurately reflect its
behavior.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 system/physmem.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index ff60ac7dd3aa..1162819c1080 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3210,7 +3210,7 @@ bool prepare_mmio_access(MemoryRegion *mr)
 }
 
 /**
- * flatview_access_allowed
+ * memory_region_access_allowed
  * @mr: #MemoryRegion to be accessed
  * @attrs: memory transaction attributes
  * @addr: address within that memory region
@@ -3220,8 +3220,8 @@ bool prepare_mmio_access(MemoryRegion *mr)
  *
  * Returns: true if transaction is allowed, false if denied.
  */
-static bool flatview_access_allowed(MemoryRegion *mr, MemTxAttrs attrs,
-                                    hwaddr addr, hwaddr len)
+static bool memory_region_access_allowed(MemoryRegion *mr, MemTxAttrs attrs,
+                                         hwaddr addr, hwaddr len)
 {
     if (likely(!attrs.memory)) {
         return true;
@@ -3241,7 +3241,7 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
                                                 hwaddr len, hwaddr mr_addr,
                                                 hwaddr *l, MemoryRegion *mr)
 {
-    if (!flatview_access_allowed(mr, attrs, mr_addr, *l)) {
+    if (!memory_region_access_allowed(mr, attrs, mr_addr, *l)) {
         return MEMTX_ACCESS_ERROR;
     }
 
@@ -3325,7 +3325,7 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
 
     l = len;
     mr = flatview_translate(fv, addr, &mr_addr, &l, true, attrs);
-    if (!flatview_access_allowed(mr, attrs, mr_addr, l)) {
+    if (!memory_region_access_allowed(mr, attrs, addr, len)) {
         return MEMTX_ACCESS_ERROR;
     }
     return flatview_write_continue(fv, addr, attrs, buf, len,
@@ -3337,7 +3337,7 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
                                                hwaddr *l,
                                                MemoryRegion *mr)
 {
-    if (!flatview_access_allowed(mr, attrs, mr_addr, *l)) {
+    if (!memory_region_access_allowed(mr, attrs, mr_addr, *l)) {
         return MEMTX_ACCESS_ERROR;
     }
 
@@ -3416,7 +3416,7 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
 
     l = len;
     mr = flatview_translate(fv, addr, &mr_addr, &l, false, attrs);
-    if (!flatview_access_allowed(mr, attrs, mr_addr, l)) {
+    if (!memory_region_access_allowed(mr, attrs, addr, len)) {
         return MEMTX_ACCESS_ERROR;
     }
     return flatview_read_continue(fv, addr, attrs, buf, len,
-- 
2.34.1


