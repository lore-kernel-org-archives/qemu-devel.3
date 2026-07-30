Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26415C54FCD
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH7C-0004Xw-5c; Wed, 29 Jul 2026 23:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH74-0004Qr-CV
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:15 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH6v-0002y6-EP
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=sa85oJBJiUNg1ScgRXz+lQi+m+/cKBsT1J3LdfOAYvQ=; b=g2SiWR4eSxdA1Ih
 u4SkXokLl8YQcFyyCFsOcYnPHD1cepI1e27u0Hp5UOa6Rtccz242sCW5i3QuNONYg+2ifBwgYNm8L
 UQ4X/QkMLUNe9mr6i2zr/Ta9XtHAMDcRCWawXIA2DbkagzhzePCzvc6gUwbuq/4ZdjKnFv5jczaDo
 Ro=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 31/50] helper-to-tcg: TcgGenPass, linearize basic blocks
Date: Thu, 30 Jul 2026 05:10:05 +0200
Message-ID: <20260730031025.12926-32-anjo@rev.ng>
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

Passes over the IR that will follow all depend on a specific iteration
order over the IR that must match between passes, establish that
iteration order.  Also replace conditional branches with a pseudo
instruction closer in semantics to TCG, this breaks the IR verification,
but as this is the last transformation of the IR in this tool that's
acceptable.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 subprojects/helper-to-tcg/meson.build         |   1 +
 .../src/TcgGenPass/LinearizeBlocks.cpp        | 140 ++++++++++++++++++
 .../src/TcgGenPass/LinearizeBlocks.hpp        |  32 ++++
 3 files changed, 173 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/src/TcgGenPass/LinearizeBlocks.cpp
 create mode 100644 subprojects/helper-to-tcg/src/TcgGenPass/LinearizeBlocks.hpp

diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
index 880561416a..58e5f67153 100644
--- a/subprojects/helper-to-tcg/meson.build
+++ b/subprojects/helper-to-tcg/meson.build
@@ -49,6 +49,7 @@ sources = [
     'src/PrepareForTcgPass/CanonicalizeIR.cpp',
     'src/PrepareForTcgPass/IdentityMap.cpp',
     'src/TcgGenPass/TcgGenPass.cpp',
+    'src/TcgGenPass/LinearizeBlocks.cpp',
 ]
 
 clang = bindir / 'clang'
diff --git a/subprojects/helper-to-tcg/src/TcgGenPass/LinearizeBlocks.cpp b/subprojects/helper-to-tcg/src/TcgGenPass/LinearizeBlocks.cpp
new file mode 100644
index 0000000000..28dff1c572
--- /dev/null
+++ b/subprojects/helper-to-tcg/src/TcgGenPass/LinearizeBlocks.cpp
@@ -0,0 +1,140 @@
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
+#include "LinearizeBlocks.hpp"
+#include "PseudoInst.hpp"
+
+#include <llvm/ADT/PostOrderIterator.h>
+#include <llvm/ADT/SmallPtrSet.h>
+#include <llvm/ADT/SmallSet.h>
+#include <llvm/ADT/SmallVector.h>
+#include <llvm/Analysis/RegionInfo.h>
+#include <llvm/Analysis/VectorUtils.h>
+#include <llvm/IR/Constants.h>
+#include <llvm/IR/DerivedTypes.h>
+#include <llvm/IR/Dominators.h>
+#include <llvm/IR/Function.h>
+#include <llvm/IR/IRBuilder.h>
+#include <llvm/IR/InstIterator.h>
+#include <llvm/IR/InstrTypes.h>
+#include <llvm/IR/Instruction.h>
+#include <llvm/IR/Instructions.h>
+#include <llvm/IR/Intrinsics.h>
+#include <llvm/IR/Module.h>
+#include <llvm/IR/PassManager.h>
+#include <llvm/IR/PatternMatch.h>
+#include <llvm/Support/Casting.h>
+
+using namespace llvm;
+using namespace PatternMatch;
+
+// Needed to track and remove instructions not handled by a subsequent dead code
+// elimination, this applies to calls to pseudo instructions in particular.
+using EraseInstVec = SmallVector<Instruction *, 16>;
+
+static void convertICmpBrToPseudInst(LLVMContext &Context, RegionInfo &RI,
+                                     EraseInstVec &InstToErase, Module &M,
+                                     Instruction *I, BasicBlock *NextBB) {
+    auto *ICmp = dyn_cast<ICmpInst>(I);
+    if (!ICmp) {
+        return;
+    }
+
+    // Since we want to remove the icmp instruction we ensure that
+    // all uses are branch instructions that can be converted into
+    // @brcond.* calls.
+    for (User *U : ICmp->users()) {
+        if (!isa<BranchInst>(U)) {
+            return;
+        }
+    }
+
+    Value *Op0 = ICmp->getOperand(0);
+    Value *Op1 = ICmp->getOperand(1);
+    auto *CmpIntTy = dyn_cast<IntegerType>(Op0->getType());
+    if (!CmpIntTy) {
+        return;
+    }
+    for (User *U : ICmp->users()) {
+        auto *Br = cast<BranchInst>(U);
+
+        BasicBlock *True = Br->getSuccessor(0);
+        BasicBlock *False = Br->getSuccessor(1);
+
+        IRBuilder<> Builder(Br);
+
+        // TODO: This is strange, indeally the unreachable branch should have
+        // been optimized out, here we invert the conditional branch if we can
+        // fallthrough to the reachable branch.
+        bool TrueUnreachable =
+            True->getTerminator()->getOpcode() == Instruction::Unreachable and
+            False->getTerminator()->getOpcode() != Instruction::Unreachable;
+
+        // If the next basic block is either of our true/false
+        // branches, we can fallthrough instead of branching.
+        bool Fallthrough = (NextBB == True or NextBB == False);
+
+        // If the succeeding basic block is the true branch we
+        // invert the condition so we can fallthrough instead.
+        ICmpInst::Predicate Predicate;
+        if (NextBB == True or (TrueUnreachable and NextBB == False)) {
+            std::swap(True, False);
+            Predicate = ICmp->getInversePredicate();
+        } else {
+            Predicate = ICmp->getPredicate();
+        }
+
+        createPseudoInstCall(M, Builder, Brcond, Builder.getVoidTy(),
+                             {Builder.getInt8(Fallthrough),
+                              ConstantInt::get(CmpIntTy, Predicate), Op0, Op1,
+                              True, False});
+
+        InstToErase.push_back(Br);
+    }
+    InstToErase.push_back(ICmp);
+}
+
+LinearBlocks linearizeBlocks(Module &M, FunctionAnalysisManager &FAM,
+                             Function &F) {
+    assert(!F.isDeclaration());
+
+    LinearBlocks Blocks{};
+
+    LLVMContext &Context = F.getContext();
+    EraseInstVec InstToErase;
+    auto &RI = FAM.getResult<RegionInfoAnalysis>(F);
+
+    ReversePostOrderTraversal<Function *> RPOT(&F);
+    for (auto BBIt = RPOT.begin(); BBIt != RPOT.end(); ++BBIt) {
+        Blocks.push_back(*BBIt);
+    }
+
+    for (int i = 0; i < Blocks.size(); ++i) {
+        BasicBlock *BB = Blocks[i];
+        BasicBlock *NextBB = (i + 1 < Blocks.size()) ? Blocks[i + 1] : nullptr;
+        for (Instruction &I : *BB) {
+            convertICmpBrToPseudInst(Context, RI, InstToErase, M, &I, NextBB);
+        }
+    }
+
+    // Finally clean up instructions we need to remove manually
+    for (Instruction *I : InstToErase) {
+        I->eraseFromParent();
+    }
+
+    return Blocks;
+}
diff --git a/subprojects/helper-to-tcg/src/TcgGenPass/LinearizeBlocks.hpp b/subprojects/helper-to-tcg/src/TcgGenPass/LinearizeBlocks.hpp
new file mode 100644
index 0000000000..8d9a1afc54
--- /dev/null
+++ b/subprojects/helper-to-tcg/src/TcgGenPass/LinearizeBlocks.hpp
@@ -0,0 +1,32 @@
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
+#include <llvm/ADT/SmallVector.h>
+#include <llvm/IR/PassManager.h>
+
+namespace llvm {
+class BasicBlock;
+class Function;
+class Module;
+} // namespace llvm
+
+using LinearBlocks = llvm::SmallVector<llvm::BasicBlock *, 16>;
+LinearBlocks linearizeBlocks(llvm::Module &M,
+                             llvm::FunctionAnalysisManager &FAM,
+                             llvm::Function &F);
-- 
2.52.0


