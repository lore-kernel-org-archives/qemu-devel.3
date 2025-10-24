Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A516ACCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 06:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCBO7-0003NJ-MM; Fri, 24 Oct 2025 02:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBO4-0003Mt-S8
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:34:57 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBO3-0003kG-2i
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761287695; x=1792823695;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kkUvhWWn3x3yZVQUkN6Y01CSNllf7T4mTVcXM5cusck=;
 b=NstvUGuytaJ8FNT+QVxYH3GGDYorf0ASE3wQj9zbxvsOEEOUScCzV1q3
 iNz6KzfBjGq/y24R3QKBtpnoq9/8u9BFsAUypoA4j0Vr/zKvYX9957tVr
 DGAGGC9GFjWXeW6ZzROSLsrqiwIdHMHGz4DYb8SUL3xEIIerEqT0OE6Du
 3zRzXrHXoB6o2X1JqFK0a6Ni5R22/+qctsrIAYePgdAUsa2H4RvJOStBG
 R4zewjvl1UHbt78BdW8yErdXZymQ/ZPHndeeaRUfoA4O6cIg8A0bUt7Yb
 PeOTidmJmofDIz93Xl+9gr088/pQGgZYvjurn7i5QMjaywJarIfQeoHoe Q==;
X-CSE-ConnectionGUID: GuKcPbbAQ0WoSlgj/oF7BA==
X-CSE-MsgGUID: 7i/nOzF4QxerW9FpGZUAQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74137865"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="74137865"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 23:34:54 -0700
X-CSE-ConnectionGUID: 56FlWhHdRCS3cQObciryqw==
X-CSE-MsgGUID: 8gx1vQa2RNueRtKYOCpGPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="184275918"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 23 Oct 2025 23:34:50 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 04/20] i386/cpu: Reorganize arch lbr structure definitions
Date: Fri, 24 Oct 2025 14:56:16 +0800
Message-Id: <20251024065632.1448606-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024065632.1448606-1-zhao1.liu@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

- Move ARCH_LBR_NR_ENTRIES macro and LBREntry definition before XSAVE
  areas definitions.
- Reorder XSavesArchLBR (area 15) between XSavePKRU (area 9) and
  XSaveXTILECFG (area 17), and reorder the related QEMU_BUILD_BUG_ON
  check to keep the same ordering.

This makes xsave structures to be organized together and makes them
clearer.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.h | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 886a941e481c..ac527971d8cd 100644
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


