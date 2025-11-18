Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C371CED240
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 03:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLCGd-0001JB-1V; Mon, 17 Nov 2025 22:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCGb-0001J1-R1
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:20:29 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCGa-0004Cz-1V
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763436028; x=1794972028;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8C3Jr7X1l8TpBRvZp6B109oTdbjj9lF4vCeG//3Doqk=;
 b=kEdLMrBMgV8Wl7Pi2m/fAj66XwZIPxWolo2sON9V+tDALvwQvQq9S7vD
 ljORfvixVzYjQtnOIaH+9M0Msy0R9cNacY/PvrVeWH3PYEEd1S4JTy4ek
 AFct1XjfLSIQYQz7aPeYkoqAjITAn+ImSto/0xVWlktnKpMVB8BDjhvRX
 6XMNEvkaxHAhQN9yWOk4STIyAQ/Fo8xtUh2ZyIAz50JRxstTDSNlqn6Lt
 fvr7icn6RYe1zGaWLKNWJ6fmrBjeQRyMvbJ4VL4niXfcChtZ2LMy4z48/
 7nQLUzlxlFTxl/vPGa2U7EBr39vo15X0uUap+oEEhFySqZzua+IKb2Yuw g==;
X-CSE-ConnectionGUID: 10uLzF/mSoujAzA401JzDg==
X-CSE-MsgGUID: MSP4xc5BQJqTfnxG6ZM1LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="68053745"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="68053745"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 19:20:28 -0800
X-CSE-ConnectionGUID: uSrAk/myTAuRrbqhnqyNbg==
X-CSE-MsgGUID: dL83uZetQhGlRy+SVpzJBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="221537149"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2025 19:20:24 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 03/23] i386/cpu: Reorganize arch lbr structure definitions
Date: Tue, 18 Nov 2025 11:42:11 +0800
Message-Id: <20251118034231.704240-4-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118034231.704240-1-zhao1.liu@intel.com>
References: <20251118034231.704240-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

- Move ARCH_LBR_NR_ENTRIES macro and LBREntry definition before XSAVE
  areas definitions.
- Reorder XSavesArchLBR (area 15) between XSavePKRU (area 9) and
  XSaveXTILECFG (area 17), and reorder the related QEMU_BUILD_BUG_ON
  check to keep the same ordering.

This makes xsave structures to be organized together and makes them
clearer.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.h | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c95b772719ce..a183394eca7f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1652,6 +1652,14 @@ typedef struct {
 
 #define NB_OPMASK_REGS 8
 
+typedef struct {
+    uint64_t from;
+    uint64_t to;
+    uint64_t info;
+} LBREntry;
+
+#define ARCH_LBR_NR_ENTRIES 32
+
 /* CPU can't have 0xFFFFFFFF APIC ID, use that value to distinguish
  * that APIC ID hasn't been set yet
  */
@@ -1729,24 +1737,6 @@ typedef struct XSavePKRU {
     uint32_t padding;
 } XSavePKRU;
 
-/* Ext. save area 17: AMX XTILECFG state */
-typedef struct XSaveXTILECFG {
-    uint8_t xtilecfg[64];
-} XSaveXTILECFG;
-
-/* Ext. save area 18: AMX XTILEDATA state */
-typedef struct XSaveXTILEDATA {
-    uint8_t xtiledata[8][1024];
-} XSaveXTILEDATA;
-
-typedef struct {
-       uint64_t from;
-       uint64_t to;
-       uint64_t info;
-} LBREntry;
-
-#define ARCH_LBR_NR_ENTRIES            32
-
 /* Ext. save area 15: Arch LBR state */
 typedef struct XSaveArchLBR {
     uint64_t lbr_ctl;
@@ -1757,6 +1747,16 @@ typedef struct XSaveArchLBR {
     LBREntry lbr_records[ARCH_LBR_NR_ENTRIES];
 } XSaveArchLBR;
 
+/* Ext. save area 17: AMX XTILECFG state */
+typedef struct XSaveXTILECFG {
+    uint8_t xtilecfg[64];
+} XSaveXTILECFG;
+
+/* Ext. save area 18: AMX XTILEDATA state */
+typedef struct XSaveXTILEDATA {
+    uint8_t xtiledata[8][1024];
+} XSaveXTILEDATA;
+
 QEMU_BUILD_BUG_ON(sizeof(XSaveAVX) != 0x100);
 QEMU_BUILD_BUG_ON(sizeof(XSaveBNDREG) != 0x40);
 QEMU_BUILD_BUG_ON(sizeof(XSaveBNDCSR) != 0x40);
@@ -1764,9 +1764,9 @@ QEMU_BUILD_BUG_ON(sizeof(XSaveOpmask) != 0x40);
 QEMU_BUILD_BUG_ON(sizeof(XSaveZMM_Hi256) != 0x200);
 QEMU_BUILD_BUG_ON(sizeof(XSaveHi16_ZMM) != 0x400);
 QEMU_BUILD_BUG_ON(sizeof(XSavePKRU) != 0x8);
+QEMU_BUILD_BUG_ON(sizeof(XSaveArchLBR) != 0x328);
 QEMU_BUILD_BUG_ON(sizeof(XSaveXTILECFG) != 0x40);
 QEMU_BUILD_BUG_ON(sizeof(XSaveXTILEDATA) != 0x2000);
-QEMU_BUILD_BUG_ON(sizeof(XSaveArchLBR) != 0x328);
 
 typedef struct ExtSaveArea {
     uint32_t feature, bits;
-- 
2.34.1


