Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12661C55160
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH7F-0004c5-RF; Wed, 29 Jul 2026 23:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH72-0004Fc-Gj
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:12 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH6x-0002yE-HK
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=k5urcBZVM2TfT4WmoKyPbJ6vR9r6kPTv/KQ5gTC9i7Y=; b=A4lyiEiA2hB6iQl
 uIqZIt0fXDyP0zx6TN14Rcd+3FmDgbK0cDieaFbk1InXNPx59R0hTQgIOuhDPwjpV2EfozhyS02F9
 SdauzE9nK8/hBrCOhgpdVdmeHaBzPubmNRNelrlySF7raCQ5YGKYeLp0J7Dxy8mKT1OkQM/of2y6I
 /s=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 32/50] helper-to-tcg: TcgGenPass,
 introduce Value <-> TcgV map
Date: Thu, 30 Jul 2026 05:10:06 +0200
Message-ID: <20260730031025.12926-33-anjo@rev.ng>
In-Reply-To: <20260730031025.12926-1-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Adds a `TempAllocationData` structure which will be the primary struct
holding information about mappings between `Value`s and `TcgV`s.

Any identified return value is also stored along with flags for easier
use by other passes.  All functions which populate `TempAllocationData`
will be declared in this header.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 .../src/TcgGenPass/ValueMapping.hpp           | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/src/TcgGenPass/ValueMapping.hpp

diff --git a/subprojects/helper-to-tcg/src/TcgGenPass/ValueMapping.hpp b/subprojects/helper-to-tcg/src/TcgGenPass/ValueMapping.hpp
new file mode 100644
index 0000000000..6aaf8acaf3
--- /dev/null
+++ b/subprojects/helper-to-tcg/src/TcgGenPass/ValueMapping.hpp
@@ -0,0 +1,110 @@
+//
+//  Copyright(c) 2026 rev.ng Labs Srl. All Rights Reserved.
+//
+//  This program is free software; you can redistribute it and/or modify
+//  it under the terms of the GNU General Public License as published by
+//  the Free Software Foundation; either version 2 of the License, or
+//  (at your option) any later version.
+//
+//  This program is distributed in the hope that it will be useful,
+//  but WITHOUT ANY WARRANTY; without even the implied warranty of
+//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+//  GNU General Public License for more details.
+//
+//  You should have received a copy of the GNU General Public License
+//  along with this program; if not, see <http://www.gnu.org/licenses/>.
+//
+
+#pragma once
+
+#include "DebugInfo.hpp"
+#include "FunctionAnnotation.hpp"
+#include "LinearizeBlocks.hpp"
+#include "TcgEmit.hpp"
+#include "TcgGlobalMap.hpp"
+#include "TcgType.hpp"
+
+#include <llvm/ADT/SmallSet.h>
+#include <llvm/ADT/StringRef.h>
+#include <llvm/IR/BasicBlock.h>
+#include <llvm/IR/Instructions.h>
+#include <llvm/Support/Error.h>
+
+//
+// Value Mapping
+//
+// Data structures and functions needed for mapping various LLVM `Value`s to
+// `TcgV`s.
+//
+
+namespace llvm {
+class Function;
+}
+
+// Flags reprensting common special cases for function return values, used when
+// emitted TCG to produce better output.
+enum TempAllocationFlags {
+    SkipReturnMov = 1,
+    ReturnsImmediate = 2,
+    ReturnsValue = 4,
+
+    HasReturn = (ReturnsImmediate | ReturnsValue),
+};
+
+// Main data structure responsible for holding mappings between LLVM `Value`s
+// and `TcgV`s, populated by functions declared below.
+struct TempAllocationData {
+    // Mapping of LLVM Values to the corresponding TcgV
+    llvm::DenseMap<const llvm::Value *, TcgV> Map;
+
+    // Whether or not the final mov in an instruction can safely
+    // be ignored or not.
+    uint8_t flags = 0;
+    TcgV ReturnValue;
+
+    inline bool hasReturnValue() const { return flags & HasReturn; }
+
+    inline TcgV map(const llvm::Value *V, const TcgV &T) {
+        return Map.try_emplace(V, T).first->second;
+    }
+};
+
+inline const llvm::iterator_range<llvm::User::const_op_iterator>
+getOperands(const llvm::Instruction *const I) {
+    switch (I->getOpcode()) {
+    case Instruction::GetElementPtr:
+        return llvm::cast<llvm::GetElementPtrInst>(I)->operands();
+    case Instruction::Call:
+        return llvm::cast<llvm::CallInst>(I)->args();
+    default:
+        return I->operands();
+    }
+}
+
+// Defined in MapArguments.cpp
+llvm::Error mapArguments(const llvm::Function &F,
+                         const AnnotationMapTy &AnnotationMap,
+                         const DebugInfoMapTy &DebugInfo,
+                         TempAllocationData &TAD);
+
+// Defined in MapConstantExpressions.cpp
+llvm::Error propagateConstantExpressions(CEmitter &C, const llvm::Function &F,
+                                         const LinearBlocks &Blocks,
+                                         const AnnotationMapTy &AnnotationMap,
+                                         const DebugInfoMapTy &DebugInfo,
+                                         const TcgGlobalMap &TcgGlobals,
+                                         TempAllocationData &TAD);
+// Defined in MapTemporaries.cpp
+llvm::Error allocateTemporaries(const llvm::Function &F,
+                                const LinearBlocks &Blocks,
+                                const AnnotationMapTy &AnnotationMap,
+                                const DebugInfoMapTy &DebugInfo, CEmitter &C,
+                                const TcgGlobalMap &TcgGlobal,
+                                TempAllocationData &TAD);
+
+// Defined MapTcgOperations.cpp
+llvm::Error mapTcgOperations(
+    const LinearBlocks &Blocks, const TcgGlobalMap &TcgGlobals,
+    const AnnotationMapTy &AnnotationMap,
+    const llvm::SmallPtrSet<llvm::Function *, 16> &HasTranslatedFunction,
+    const TempAllocationData &TAD, TcgEmitter &Tcg, CEmitter &C);
-- 
2.52.0


