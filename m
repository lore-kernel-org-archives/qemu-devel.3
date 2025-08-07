Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56339C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzSR-0004J3-Fg; Thu, 07 Aug 2025 08:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzRw-000248-OQ; Thu, 07 Aug 2025 08:10:24 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzRu-0005Bt-Gc; Thu, 07 Aug 2025 08:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568622; x=1786104622;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jlCpSuQ5mesdc7DN+lFSCnjeGwm6BIOjo3EmPFLXWfU=;
 b=hA61kyzr5o5BNZF3jq6WJW6xX/W8b2K5fnQ6Zeg3v3ablYb4hXOfcsUS
 AoReDmvfDPcJO/mElCME1lyh+fw2SciLauo8MZe1hQdypXXwY1W15r3LW
 QQPfTKZgg4SCTqfrVGiTp++xQ/cfP53XNAbrfh/VjRzyHrMtasXZ4iLSV
 fENATiYpbDYAsDPHZmz+3Y26FpNdhFnQ8sGzj2dPjkXVo5EOlPXcUrsMb
 V7wZrdgxgyAI/54RmxYjgX7lWa8EjE/0a02dI10adyx8CHtFx3pEo7YpR
 ya7+/HmmsX1S6GgMYtciJeuk6OHJrfdO3FG8+qllm8te7aLNvJ4QEEYy1 g==;
X-CSE-ConnectionGUID: ZaMb5jFKShK/twOHL8LGUQ==
X-CSE-MsgGUID: VLv08JK5QQaJJx+6ZswO5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036840"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036840"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:10:01 -0700
X-CSE-ConnectionGUID: Vs+/5aMoRbmJvyuCzG9nRA==
X-CSE-MsgGUID: o3hYrEH1SBCKzHJQIf7SGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701151"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:09:59 -0700
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
Subject: [RFC 18/26] memory: Rename flatview_access_allowed() to
 memory_region_access_allowed()
Date: Thu,  7 Aug 2025 20:30:19 +0800
Message-Id: <20250807123027.2910950-19-zhao1.liu@intel.com>
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

flatview_access_allowed() accepts `MemoryRegion *mr` as an argument, so
it's based on MemoryRegion and should be named as
memory_region_access_allowed().

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 system/physmem.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index d2106d0ffa87..8aaaab4d3a74 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2921,7 +2921,7 @@ bool prepare_mmio_access(MemoryRegion *mr)
 }
 
 /**
- * flatview_access_allowed
+ * memory_region_access_allowed
  * @mr: #MemoryRegion to be accessed
  * @attrs: memory transaction attributes
  * @addr: address within that memory region
@@ -2931,8 +2931,8 @@ bool prepare_mmio_access(MemoryRegion *mr)
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
@@ -2952,7 +2952,7 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
                                                 hwaddr len, hwaddr mr_addr,
                                                 hwaddr *l, MemoryRegion *mr)
 {
-    if (!flatview_access_allowed(mr, attrs, mr_addr, *l)) {
+    if (!memory_region_access_allowed(mr, attrs, mr_addr, *l)) {
         return MEMTX_ACCESS_ERROR;
     }
 
@@ -3036,7 +3036,7 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
 
     l = len;
     mr = flatview_translate(fv, addr, &mr_addr, &l, true, attrs);
-    if (!flatview_access_allowed(mr, attrs, addr, len)) {
+    if (!memory_region_access_allowed(mr, attrs, addr, len)) {
         return MEMTX_ACCESS_ERROR;
     }
     return flatview_write_continue(fv, addr, attrs, buf, len,
@@ -3048,7 +3048,7 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
                                                hwaddr *l,
                                                MemoryRegion *mr)
 {
-    if (!flatview_access_allowed(mr, attrs, mr_addr, *l)) {
+    if (!memory_region_access_allowed(mr, attrs, mr_addr, *l)) {
         return MEMTX_ACCESS_ERROR;
     }
 
@@ -3127,7 +3127,7 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
 
     l = len;
     mr = flatview_translate(fv, addr, &mr_addr, &l, false, attrs);
-    if (!flatview_access_allowed(mr, attrs, addr, len)) {
+    if (!memory_region_access_allowed(mr, attrs, addr, len)) {
         return MEMTX_ACCESS_ERROR;
     }
     return flatview_read_continue(fv, addr, attrs, buf, len,
-- 
2.34.1


