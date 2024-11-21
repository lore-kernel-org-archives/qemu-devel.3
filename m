Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC57D743FC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwI0-0001gi-QQ; Wed, 20 Nov 2024 20:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHy-0001fj-9O
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:22 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHw-0004Zz-BC
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=MxJZlENkdmUchmgfGBkk9kv4bmuX6oYA3cdwhm+q3rc=; b=hq2y0jcrCKtVUJ6
 jmSO+GqWFQJR8gyvoJMP6GPMgxeJTNZDSLuRxR7IS4Uz+6VVuiN6dc5uJ3RjsA8BL1LQvKyleaOtR
 WocUTOxAPXSFW9MaBiobApnG1GxuZHXaQheOOyLaoWVchROCGQbOmzJsJPbDrj3H2lrn7s41G/il3
 YQ=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 27/43] helper-to-tcg: PrepareForTcgPass,
 identity map trivial expressions
Date: Thu, 21 Nov 2024 02:49:31 +0100
Message-ID: <20241121014947.18666-28-anjo@rev.ng>
In-Reply-To: <20241121014947.18666-1-anjo@rev.ng>
References: <20241121014947.18666-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Transformation of the IR, identity mapping trivial expressions which
would amount to nothing more than a move when emitted as TCG, but is
required in LLVM IR to not break the IR.

Trivial expressions are mapped to a @IdentityMap pseudo instruction
allowing them to be dealt with in a uniform manner down the line.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 subprojects/helper-to-tcg/meson.build         |  1 +
 .../passes/PrepareForTcgPass/IdentityMap.cpp  | 80 +++++++++++++++++++
 .../passes/PrepareForTcgPass/IdentityMap.h    | 39 +++++++++
 .../PrepareForTcgPass/PrepareForTcgPass.cpp   |  4 +
 4 files changed, 124 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/IdentityMap.cpp
 create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/IdentityMap.h

diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
index 50bb926f49..09caa74c63 100644
--- a/subprojects/helper-to-tcg/meson.build
+++ b/subprojects/helper-to-tcg/meson.build
@@ -49,6 +49,7 @@ sources = [
     'passes/PrepareForTcgPass/PrepareForTcgPass.cpp',
     'passes/PrepareForTcgPass/TransformGEPs.cpp',
     'passes/PrepareForTcgPass/CanonicalizeIR.cpp',
+    'passes/PrepareForTcgPass/IdentityMap.cpp',
 ]
 
 clang = bindir / 'clang'
diff --git a/subprojects/helper-to-tcg/passes/PrepareForTcgPass/IdentityMap.cpp b/subprojects/helper-to-tcg/passes/PrepareForTcgPass/IdentityMap.cpp
new file mode 100644
index 0000000000..b173aeba9c
--- /dev/null
+++ b/subprojects/helper-to-tcg/passes/PrepareForTcgPass/IdentityMap.cpp
@@ -0,0 +1,80 @@
+//
+//  Copyright(c) 2024 rev.ng Labs Srl. All Rights Reserved.
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
+#include "IdentityMap.h"
+#include <PseudoInst.h>
+#include "backend/TcgType.h"
+#include <llvm/ADT/SmallVector.h>
+#include <llvm/IR/IRBuilder.h>
+#include <llvm/IR/InstIterator.h>
+#include <llvm/IR/Instruction.h>
+#include <llvm/IR/Value.h>
+
+using namespace llvm;
+
+void identityMap(Module &M, Function &F)
+{
+    SmallVector<Instruction *, 8> InstToErase;
+
+    for (auto &I : instructions(F)) {
+        auto *ZExt = dyn_cast<ZExtInst>(&I);
+        if (ZExt) {
+            auto *IntTy0 =
+                dyn_cast<IntegerType>(ZExt->getOperand(0)->getType());
+            auto *IntTy1 = dyn_cast<IntegerType>(ZExt->getType());
+            if (IntTy0 and IntTy1) {
+                uint32_t LlvmSize0 = IntTy0->getBitWidth();
+                uint32_t LlvmSize1 = IntTy1->getBitWidth();
+
+                if (LlvmSize0 == 1) {
+                    auto *ICmp = dyn_cast<ICmpInst>(ZExt->getOperand(0));
+                    if (ICmp) {
+                        auto *ICmpOp = ICmp->getOperand(0);
+                        LlvmSize0 =
+                            cast<IntegerType>(ICmpOp->getType())->getBitWidth();
+                    }
+                }
+
+                uint32_t TcgSize0 = llvmToTcgSize(LlvmSize0);
+                uint32_t TcgSize1 = llvmToTcgSize(LlvmSize1);
+
+                if (TcgSize0 == TcgSize1) {
+                    FunctionCallee Fn =
+                        pseudoInstFunction(M, IdentityMap, IntTy1, {IntTy0});
+                    IRBuilder<> Builder(&I);
+                    CallInst *Call =
+                        Builder.CreateCall(Fn, {ZExt->getOperand(0)});
+                    ZExt->replaceAllUsesWith(Call);
+                    InstToErase.push_back(&I);
+                }
+            }
+        } else if (isa<FreezeInst>(&I)) {
+            auto *IntTy0 = dyn_cast<IntegerType>(I.getOperand(0)->getType());
+            auto *IntTy1 = dyn_cast<IntegerType>(I.getType());
+            FunctionCallee Fn =
+                pseudoInstFunction(M, IdentityMap, IntTy1, {IntTy0});
+            IRBuilder<> Builder(&I);
+            CallInst *Call = Builder.CreateCall(Fn, {I.getOperand(0)});
+            I.replaceAllUsesWith(Call);
+            InstToErase.push_back(&I);
+        }
+    }
+
+    for (auto *I : InstToErase) {
+        I->eraseFromParent();
+    }
+}
diff --git a/subprojects/helper-to-tcg/passes/PrepareForTcgPass/IdentityMap.h b/subprojects/helper-to-tcg/passes/PrepareForTcgPass/IdentityMap.h
new file mode 100644
index 0000000000..b0c938c25d
--- /dev/null
+++ b/subprojects/helper-to-tcg/passes/PrepareForTcgPass/IdentityMap.h
@@ -0,0 +1,39 @@
+//
+//  Copyright(c) 2024 rev.ng Labs Srl. All Rights Reserved.
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
diff --git a/subprojects/helper-to-tcg/passes/PrepareForTcgPass/PrepareForTcgPass.cpp b/subprojects/helper-to-tcg/passes/PrepareForTcgPass/PrepareForTcgPass.cpp
index 7fdbc2a0c9..3e4713d837 100644
--- a/subprojects/helper-to-tcg/passes/PrepareForTcgPass/PrepareForTcgPass.cpp
+++ b/subprojects/helper-to-tcg/passes/PrepareForTcgPass/PrepareForTcgPass.cpp
@@ -17,6 +17,7 @@
 
 #include "CanonicalizeIR.h"
 #include <CmdLineOptions.h>
+#include "IdentityMap.h"
 #include <PrepareForTcgPass.h>
 #include "TransformGEPs.h"
 #include <llvm/ADT/SCCIterator.h>
@@ -126,5 +127,8 @@ PreservedAnalyses PrepareForTcgPass::run(Module &M, ModuleAnalysisManager &MAM)
         transformGEPs(M, F, ResultTcgGlobalMap);
     }
     canonicalizeIR(M);
+    for (Function &F : M) {
+        identityMap(M, F);
+    }
     return PreservedAnalyses::none();
 }
-- 
2.45.2


