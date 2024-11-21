Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E65D743FD
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwHt-0001cx-LX; Wed, 20 Nov 2024 20:47:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHr-0001bW-Nb
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:15 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHq-0004Xz-4e
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=NewhKMIelYRuDNznnvD5yTlXbeDt4XshQYjlz/pQPQs=; b=hKczrorhim53phv
 kA62HkSwy+a2H7Y7YBBwMRmuAn2jCl4sxhMrrTtMHVT3OCqMJoYbvv44OY9xkEtjafP1P94/5i7Eq
 Wx6dKEw8kGEVwheFDZm38N1KiZhyNpR3CkSIo5NYDZ/WPApzDdNcwPqIBMmAkxlIxoj7g7tRi+JSV
 IM=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 17/43] helper-to-tcg: PrepareForOptPass,
 undef llvm.returnaddress
Date: Thu, 21 Nov 2024 02:49:21 +0100
Message-ID: <20241121014947.18666-18-anjo@rev.ng>
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

Convert llvm.returnaddress arguments to cpu_[ld|st]*() to undef, causing
the LLVM optmizer to discard the intrinsics.  Needed as
llvm.returnadress is not representable in TCG, and usually results from
usage of GETPC() in helper functions.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 .../PrepareForOptPass/PrepareForOptPass.cpp   | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/subprojects/helper-to-tcg/passes/PrepareForOptPass/PrepareForOptPass.cpp b/subprojects/helper-to-tcg/passes/PrepareForOptPass/PrepareForOptPass.cpp
index 22509008c8..b357debb5d 100644
--- a/subprojects/helper-to-tcg/passes/PrepareForOptPass/PrepareForOptPass.cpp
+++ b/subprojects/helper-to-tcg/passes/PrepareForOptPass/PrepareForOptPass.cpp
@@ -23,6 +23,7 @@
 #include <llvm/IR/Function.h>
 #include <llvm/IR/Instruction.h>
 #include <llvm/IR/Instructions.h>
+#include <llvm/IR/Intrinsics.h>
 #include <llvm/IR/Module.h>
 
 #include <queue>
@@ -197,9 +198,56 @@ static void cullUnusedFunctions(Module &M, AnnotationMapTy &Annotations,
     }
 }
 
+struct RetAddrReplaceInfo {
+    User *Parent;
+    unsigned OpIndex;
+    Type *Ty;
+};
+
+static void replaceRetaddrWithUndef(Module &M)
+{
+    // Replace uses of llvm.returnaddress arguments to cpu_ld* w. undef,
+    // and let optimizations remove it.  Needed as llvm.returnaddress is
+    // not reprensentable in TCG.
+    SmallVector<RetAddrReplaceInfo, 24> UsesToReplace;
+    Function *Retaddr = Intrinsic::getDeclaration(&M, Intrinsic::returnaddress);
+    // Loop over all calls to llvm.returnaddress
+    for (auto *CallUser : Retaddr->users()) {
+        auto *Call = dyn_cast<CallInst>(CallUser);
+        if (!Call) {
+            continue;
+        }
+        for (auto *PtrToIntUser : Call->users()) {
+            auto *Cast = dyn_cast<PtrToIntInst>(PtrToIntUser);
+            if (!Cast) {
+                continue;
+            }
+            for (Use &U : Cast->uses()) {
+                auto *Call = dyn_cast<CallInst>(U.getUser());
+                Function *F = Call->getCalledFunction();
+                StringRef Name = F->getName();
+                if (Name.startswith("cpu_ld") or Name.startswith("cpu_st")) {
+                    UsesToReplace.push_back({
+                        .Parent = U.getUser(),
+                        .OpIndex = U.getOperandNo(),
+                        .Ty = U->getType(),
+                    });
+                }
+            }
+        }
+    }
+
+    // Defer replacement to not invalidate iterators
+    for (RetAddrReplaceInfo &RI : UsesToReplace) {
+        auto *Undef = UndefValue::get(RI.Ty);
+        RI.Parent->setOperand(RI.OpIndex, Undef);
+    }
+}
+
 PreservedAnalyses PrepareForOptPass::run(Module &M, ModuleAnalysisManager &MAM)
 {
     collectAnnotations(M, ResultAnnotations);
     cullUnusedFunctions(M, ResultAnnotations, TranslateAllHelpers);
+    replaceRetaddrWithUndef(M);
     return PreservedAnalyses::none();
 }
-- 
2.45.2


