Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AD3C54FCD
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH70-00049B-FY; Wed, 29 Jul 2026 23:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH6r-0003yv-Dj
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:01 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH6o-0002xK-Hz
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=HnCTtpuYw/p0eFuGQNJjUUucCE/tt34zGt60GfprXAY=; b=WWgc7iaoB4AC1HS
 ygbk4BuX+dtDjRW5vCx0eu+qvGLedUmxoXvzDkJoV7huHjk+WuX5NRhVvhz49p21gzIUx80wXB9Us
 A+RsFvXzzuJUj9kSzcDIZR3VstZNBQL7PXvRtClWlNXO/SZItX7lyYaBcGS2lAsf/JLqDWdcFmUQj
 Uc=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 28/50] helper-to-tcg: PrepareForTcgPass,
 identity map trivial expressions
Date: Thu, 30 Jul 2026 05:10:02 +0200
Message-ID: <20260730031025.12926-29-anjo@rev.ng>
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

Transformation of the IR, identity mapping expressions which
would amount to nothing more than a move when emitted as TCG, but is
required in LLVM IR to not break the IR.

Trivial expressions are mapped to a `@IdentityMap` pseudo instruction
allowing them to be dealt with in a uniform manner down the line.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 subprojects/helper-to-tcg/meson.build         |  1 +
 .../src/PrepareForTcgPass/IdentityMap.cpp     | 91 +++++++++++++++++++
 .../src/PrepareForTcgPass/IdentityMap.hpp     | 39 ++++++++
 .../PrepareForTcgPass/PrepareForTcgPass.cpp   |  4 +
 4 files changed, 135 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/src/PrepareForTcgPass/IdentityMap.cpp
 create mode 100644 subprojects/helper-to-tcg/src/PrepareForTcgPass/IdentityMap.hpp

diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
index 79ce0c6dd8..c88c759ba6 100644
--- a/subprojects/helper-to-tcg/meson.build
+++ b/subprojects/helper-to-tcg/meson.build
@@ -47,6 +47,7 @@ sources = [
     'src/PrepareForTcgPass/PrepareForTcgPass.cpp',
     'src/PrepareForTcgPass/TransformGEPs.cpp',
     'src/PrepareForTcgPass/CanonicalizeIR.cpp',
+    'src/PrepareForTcgPass/IdentityMap.cpp',
 ]
 
 clang = bindir / 'clang'
diff --git a/subprojects/helper-to-tcg/src/PrepareForTcgPass/IdentityMap.cpp b/subprojects/helper-to-tcg/src/PrepareForTcgPass/IdentityMap.cpp
new file mode 100644
index 0000000000..b9f4c8330f
--- /dev/null
+++ b/subprojects/helper-to-tcg/src/PrepareForTcgPass/IdentityMap.cpp
@@ -0,0 +1,91 @@
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
+#include "IdentityMap.hpp"
+#include "PseudoInst.hpp"
+#include "TcgType.hpp"
+
+#include <llvm/ADT/SmallVector.h>
+#include <llvm/IR/IRBuilder.h>
+#include <llvm/IR/InstIterator.h>
+#include <llvm/IR/Instruction.h>
+#include <llvm/IR/Value.h>
+
+using namespace llvm;
+
+void identityMap(Module &M, Function &F) {
+    SmallVector<Instruction *, 8> InstToErase;
+
+    for (Instruction &I : instructions(F)) {
+        auto *ZExt = dyn_cast<ZExtInst>(&I);
+        if (ZExt) {
+            auto *SrcIntTy =
+                dyn_cast<IntegerType>(ZExt->getOperand(0)->getType());
+            auto *DstIntTy = dyn_cast<IntegerType>(ZExt->getType());
+            if (!SrcIntTy or !DstIntTy) {
+                continue;
+            }
+
+            auto SrcSize = ValueSize::fromLlvmType(SrcIntTy);
+            auto DstSize = ValueSize::fromLlvmType(DstIntTy);
+            if (!SrcSize or !DstSize) {
+                continue;
+            }
+
+            // TODO: Hack again to get bit width from icmp arguments, should
+            // widen in canonicalization phase.
+            if (SrcSize->LlvmBitWidth == 1) {
+                auto *ICmp = dyn_cast<ICmpInst>(ZExt->getOperand(0));
+                if (ICmp) {
+                    auto *ICmpOp = ICmp->getOperand(0);
+                    auto OpSize = ValueSize::fromLlvmType(
+                        cast<IntegerType>(ICmpOp->getType()));
+                    if (!OpSize) {
+                        continue;
+                    }
+                    SrcSize = *OpSize;
+                }
+            }
+
+            // Only identity map when TCG sizes match.
+            if (SrcSize->TcgBitWidth != DstSize->TcgBitWidth) {
+                continue;
+            }
+
+            IRBuilder<> Builder(&I);
+            ZExt->replaceAllUsesWith(createPseudoInstCall(
+                M, Builder, IdentityMap, DstIntTy, {ZExt->getOperand(0)}));
+            InstToErase.push_back(&I);
+        } else if (auto *Load = dyn_cast<LoadInst>(&I);
+                   Load and Load->getType()->isVectorTy()) {
+            Value *Ptr = Load->getPointerOperand();
+            IRBuilder<> Builder(&I);
+            Load->replaceAllUsesWith(createPseudoInstCall(
+                M, Builder, IdentityMap, Load->getType(), {Ptr}));
+            InstToErase.push_back(&I);
+        } else if (isa<FreezeInst>(&I)) {
+            IRBuilder<> Builder(&I);
+            I.replaceAllUsesWith(createPseudoInstCall(
+                M, Builder, IdentityMap, I.getType(), {I.getOperand(0)}));
+            InstToErase.push_back(&I);
+        }
+    }
+
+    for (Instruction *I : InstToErase) {
+        I->eraseFromParent();
+    }
+}
diff --git a/subprojects/helper-to-tcg/src/PrepareForTcgPass/IdentityMap.hpp b/subprojects/helper-to-tcg/src/PrepareForTcgPass/IdentityMap.hpp
new file mode 100644
index 0000000000..25de0a2c71
--- /dev/null
+++ b/subprojects/helper-to-tcg/src/PrepareForTcgPass/IdentityMap.hpp
@@ -0,0 +1,39 @@
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
+#include <llvm/IR/Function.h>
+#include <llvm/IR/Module.h>
+
+//
+// Transformation of the IR, taking what would become trivial unary operations
+// and maps them to a single @IdentityMap pseudo instruction.
+//
+// To motivate further, in order to produce nice IR on the other end, generally
+// the operands of these trivial expressions needs to be forwarded and treated
+// as the destination value (identity mapped).  However, directly removing these
+// instructions will result in broken LLVM IR (consider zext i8, i32 where both
+// the source and destination would map to TCGv_i32).
+//
+// Moreover, handling these identity mapped values in an adhoc way quickly
+// becomes cumbersome and spreads throughout the codebase.  Therefore,
+// introducing @IdentityMap allows code further down the pipeline to ignore the
+// source of the identity map.
+//
+
+void identityMap(llvm::Module &M, llvm::Function &F);
diff --git a/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp b/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
index 71749e2f6f..4185af7956 100644
--- a/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
+++ b/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
@@ -18,6 +18,7 @@
 #include "PrepareForTcgPass.hpp"
 #include "CanonicalizeIR.hpp"
 #include "CmdLineOptions.hpp"
+#include "IdentityMap.hpp"
 #include "TransformGEPs.hpp"
 
 #include <llvm/ADT/SCCIterator.h>
@@ -142,5 +143,8 @@ PreservedAnalyses PrepareForTcgPass::run(Module &M,
         transformGEPs(M, F, ResultTcgGlobalMap, TypeIndexMap, DebugInfo);
     }
     canonicalizeIR(M, MAM, VL);
+    for (Function &F : M) {
+        identityMap(M, F);
+    }
     return PreservedAnalyses::none();
 }
-- 
2.52.0


