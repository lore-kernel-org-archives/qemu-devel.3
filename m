Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FAEDC54FCD
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH5x-0001sD-IM; Wed, 29 Jul 2026 23:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH5w-0001rf-5k
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:06:04 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH5u-0002tN-MG
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=VWdBD/ZkDSAkkTaoQpaJfwXB2GjEbhoi3wL1Dg6e5rg=; b=KW22BG1RmFGHJcR
 W3fgwqUJpKeUMYDIbFmeKF7GhkWzoBzORVBGv8+Dypa+iOZzKgf8pzwAWNQPdhAH9PjbN/V34Zsu/
 J09fvKlp9CA+T/PYtoX7EaeRZ7TW1KkzCv8Vmv6hMmND0UDu9PYFc/ZGHOyKzu3T4qXwm3E7NnrZO
 Jg=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 10/50] helper-to-tcg: Add pipeline --debug and --debug-only
Date: Thu, 30 Jul 2026 05:09:44 +0200
Message-ID: <20260730031025.12926-11-anjo@rev.ng>
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

These options are normally added by LLVM, however since we want a
minimal set of options in --help we have to readd them ourselves.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 subprojects/helper-to-tcg/src/Pipeline.cpp | 25 +++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/subprojects/helper-to-tcg/src/Pipeline.cpp b/subprojects/helper-to-tcg/src/Pipeline.cpp
index f36f447fd2..4b9523ad6f 100644
--- a/subprojects/helper-to-tcg/src/Pipeline.cpp
+++ b/subprojects/helper-to-tcg/src/Pipeline.cpp
@@ -37,11 +37,14 @@
 #include <llvm/PassRegistry.h>
 #include <llvm/Passes/PassBuilder.h>
 #include <llvm/Support/CommandLine.h>
+#include <llvm/Support/Debug.h>
 #include <llvm/Support/InitLLVM.h>
 #include <llvm/Support/SourceMgr.h>
 #include <llvm/Support/TargetSelect.h>
 #include <llvm/Target/TargetMachine.h>
 
+#define DEBUG_TYPE "pipeline"
+
 using namespace llvm;
 
 cl::OptionCategory Cat("helper-to-tcg Options");
@@ -50,6 +53,16 @@ cl::OptionCategory Cat("helper-to-tcg Options");
 cl::opt<std::string> InputFile(cl::Positional, cl::desc("[input LLVM module]"),
                                cl::cat(Cat));
 
+// Debug options
+#ifndef NDEBUG
+static cl::opt<bool> Debug("debug", cl::desc("Enable debug logging (slow)"),
+                           cl::init(false), cl::cat(Cat));
+static cl::opt<std::string>
+    DebugOnly("debug-only",
+              cl::desc("Enable debug logging for a specific pass"),
+              cl::init(""), cl::cat(Cat));
+#endif
+
 // Define a TargetTransformInfo (TTI) subclass, this allows for overriding
 // common per-llvm-target information expected by other LLVM passes, such
 // as the width of the largest scalar/vector registers.  Needed for consistent
@@ -105,8 +118,18 @@ int main(int argc, char **argv) {
 
     cl::ParseCommandLineOptions(argc, argv);
 
-    LLVMContext Context;
+    // Enable debug logging, -debug and -debug-only are normally provided by
+    // LLVMs default debug options, but since we want to hide most default
+    // options and keep them visible during a debug build it's easiest to add
+    // them back manually
+#ifndef NDEBUG
+    DebugFlag = Debug;
+    if (!DebugOnly.empty()) {
+        setCurrentDebugType(DebugOnly.c_str());
+    }
+#endif
 
+    LLVMContext Context;
     SMDiagnostic Err;
     std::unique_ptr<Module> M = parseIRFile(InputFile, Err, Context);
 
-- 
2.52.0


