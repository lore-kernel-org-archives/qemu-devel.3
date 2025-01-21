Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03E6C0218C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFdy-0002SC-IG; Tue, 21 Jan 2025 09:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taFdv-0002Qx-Fo
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:54:15 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taFdr-0000FV-U7
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737471252; x=1769007252;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mJcr39zVdceK26Dc3tdY0horVyumXUMgAYBKyt4SGWA=;
 b=STECxUmx+NbvnbLl10bILzm4/+b8UXsnxeqOFmXabRZr/Bd59gz05oPQ
 Q8prZM7lm3RA8mDclobxncQcY30PWzzyktPf+oFFc7KltlbpGEBntC0nl
 5+A19WNOlZ9Cw+biXxqC92YmrrYZU2clbSPjSIbarlSGALCOZPgMI15D9
 Bag3jqWmivS9K81Xyq09mpZELHaI6c+unC3jIjpFq68UPorgbsYvc9f9P
 CJt3SEdl9cCbNqjYmIPYm7KdITF4waVOvVyndJFPZiv5DpWBLsw98gtum
 hH0y05x2IdKZYUNC/heBNj4dwddb3WZ0kCNtFUHQRHhQRaMYb+hGe6v+E g==;
X-CSE-ConnectionGUID: +34F/V1zRVGG7RtnTaA9Kg==
X-CSE-MsgGUID: wv4Hl20KSWuZUeCh94pUJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37763517"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="37763517"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 06:54:10 -0800
X-CSE-ConnectionGUID: T+JeTdu9T+uyX40gzNy/UA==
X-CSE-MsgGUID: GeAscZhlSxe8R58mbAvuqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="106639887"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 21 Jan 2025 06:54:08 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=83?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 1/2] memattrs: Convert unspecified member to bool
Date: Tue, 21 Jan 2025 23:13:21 +0800
Message-Id: <20250121151322.171832-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121151322.171832-1-zhao1.liu@intel.com>
References: <20250121151322.171832-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Convert `unspecified` member of MemTxAttrs from bit field to bool, so
that bindgen could generate more ergonomic Rust binding with bool type.

As a result, MemTxAttrs needs to be expanded from 4 bytes to 8 bytes.

Therefore, move `unspecified` to after the bit fields and add reserved
members to ensure that the whole structure is packed into 8 bytes.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * Only convert `unspecified` to bool, to reserve spare space.
 * Mention the size has been changed. (I don't note the spare space
   since reserved fields are enough.)
---
 include/exec/memattrs.h | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index e27c18f3dc31..4fde4eee8439 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -23,12 +23,6 @@
  * different semantics.
  */
 typedef struct MemTxAttrs {
-    /* Bus masters which don't specify any attributes will get this
-     * (via the MEMTXATTRS_UNSPECIFIED constant), so that we can
-     * distinguish "all attributes deliberately clear" from
-     * "didn't specify" if necessary.
-     */
-    unsigned int unspecified:1;
     /*
      * ARM/AMBA: TrustZone Secure access
      * x86: System Management Mode access
@@ -57,6 +51,17 @@ typedef struct MemTxAttrs {
      * PID (PCI PASID) support: Limited to 8 bits process identifier.
      */
     unsigned int pid:8;
+
+    /*
+     * Bus masters which don't specify any attributes will get this
+     * (via the MEMTXATTRS_UNSPECIFIED constant), so that we can
+     * distinguish "all attributes deliberately clear" from
+     * "didn't specify" if necessary.
+     */
+    bool unspecified;
+
+    uint8_t _reserved1;
+    uint16_t _reserved2;
 } MemTxAttrs;
 
 /* Bus masters which don't specify any attributes will get this,
@@ -64,7 +69,7 @@ typedef struct MemTxAttrs {
  * (so that we can distinguish "all attributes deliberately clear"
  * from "didn't specify" if necessary).
  */
-#define MEMTXATTRS_UNSPECIFIED ((MemTxAttrs) { .unspecified = 1 })
+#define MEMTXATTRS_UNSPECIFIED ((MemTxAttrs) { .unspecified = true })
 
 /* New-style MMIO accessors can indicate that the transaction failed.
  * A zero (MEMTX_OK) response means success; anything else is a failure
-- 
2.34.1


