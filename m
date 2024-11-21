Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B2BD743FD
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwHv-0001e5-M7; Wed, 20 Nov 2024 20:47:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHs-0001c9-8q
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:16 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHq-0004YO-Vg
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=50Y7YhhV3UHHQ/N3ezFgY4yjynTIuC8usuDdVwJv/S8=; b=aKHl3k4bJ+dPc9c
 rHzADXC2HUzUNT4am92KCWNcEKuEwE8IVMCOx2QZQZJCwRU0nWqbuMY3y0BC7xxBjFl2sZuRSFREj
 14EhXW8AH9L7MDfUKSTPgBI1t9Eh+8HB7yTS9+ZoNtmE5vle6syyamsI4yy4y6Qki8D0EFggyW+3T
 Iw=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 18/43] helper-to-tcg: PrepareForOptPass,
 Remove noinline attribute
Date: Thu, 21 Nov 2024 02:49:22 +0100
Message-ID: <20241121014947.18666-19-anjo@rev.ng>
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

When producing LLVM IR using clang -O0, a noinline attribute is added.
Remove this attribute to not inhibit future optimization.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 .../passes/PrepareForOptPass/PrepareForOptPass.cpp         | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/subprojects/helper-to-tcg/passes/PrepareForOptPass/PrepareForOptPass.cpp b/subprojects/helper-to-tcg/passes/PrepareForOptPass/PrepareForOptPass.cpp
index b357debb5d..cfd1c23c24 100644
--- a/subprojects/helper-to-tcg/passes/PrepareForOptPass/PrepareForOptPass.cpp
+++ b/subprojects/helper-to-tcg/passes/PrepareForOptPass/PrepareForOptPass.cpp
@@ -25,6 +25,7 @@
 #include <llvm/IR/Instructions.h>
 #include <llvm/IR/Intrinsics.h>
 #include <llvm/IR/Module.h>
+#include <llvm/Transforms/Utils/Local.h>
 
 #include <queue>
 #include <set>
@@ -249,5 +250,11 @@ PreservedAnalyses PrepareForOptPass::run(Module &M, ModuleAnalysisManager &MAM)
     collectAnnotations(M, ResultAnnotations);
     cullUnusedFunctions(M, ResultAnnotations, TranslateAllHelpers);
     replaceRetaddrWithUndef(M);
+    // Remove noinline function attributes automatically added by -O0
+    for (Function &F : M) {
+        if (F.hasFnAttribute(Attribute::AttrKind::NoInline)) {
+            F.removeFnAttr(Attribute::AttrKind::NoInline);
+        }
+    }
     return PreservedAnalyses::none();
 }
-- 
2.45.2


