Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA82FC55165
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH6E-0001um-Ek; Wed, 29 Jul 2026 23:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH6D-0001ua-92
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:06:21 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH6B-0002u4-Nv
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=uLqtHJz2VyYpgaV81tSrDoiR9LgLkEh8YUj6ngUq2x0=; b=Cb/X9U6/3LJ98P4
 zM918unr9/wVaWLsLGE4caSzrWNqlftH2N9FVgcTmJbN2qA6XyM+prGUWzQRV3zghBmliW6l9lE3r
 WHfMeVNef6xFoC45os+k84xpw56yp6Sh3b9atkv4GTlbQuv1baf4OHR3wpwXFcTRMpwRqOc2oqBQC
 mc=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 13/50] helper-to-tcg: PrepareForOptPass,
 demangle function names
Date: Thu, 30 Jul 2026 05:09:47 +0200
Message-ID: <20260730031025.12926-14-anjo@rev.ng>
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

Since input LLVM IR might come from languages which mangle function
names, e.g. C++, take extra care to demangle all function names and save
them on the side for future lookup.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 .../PrepareForOptPass/PrepareForOptPass.cpp   | 43 ++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp b/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp
index 4a7e82b7bd..c15c0af6ea 100644
--- a/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp
+++ b/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp
@@ -15,15 +15,56 @@
 //  along with this program; if not, see <http://www.gnu.org/licenses/>.
 //
 
-#include "PrepareForOptPass.h"
+#include "PrepareForOptPass.hpp"
 
+#include <llvm/ADT/StringRef.h>
+#include <llvm/ADT/StringSet.h>
+#include <llvm/Demangle/Demangle.h>
 #include <llvm/Support/Debug.h>
 
 #define DEBUG_TYPE "prepare-for-opt"
 
 using namespace llvm;
 
+static void demangleFunctionNames(Module &M) {
+    StringSet DemangledNames;
+    for (Function &F : M) {
+        const std::string DemangledName = llvm::demangle(F.getName().str());
+        if (DemangledName == F.getName()) {
+            // Name not mangled
+            continue;
+        }
+        // The resulting demangled name might look something like
+        //
+        //   namespace::subnamespace::function(...)
+        //
+        // Extract the function name and use this to replace mangled name.  If
+        // we previously encountered the same name, give up and leave the
+        // mangled name.
+        std::string FunctionName;
+        size_t Index = 0;
+        // Remove namespaces
+        Index = DemangledName.find_last_of(':');
+        if (Index != std::string::npos) {
+            FunctionName = DemangledName.substr(Index + 1);
+        }
+        // Remove arguments
+        Index = FunctionName.find_first_of('(');
+        if (Index != std::string::npos) {
+            FunctionName = FunctionName.substr(0, Index);
+        }
+
+        if (DemangledNames.contains(FunctionName)) {
+            continue;
+        }
+        DemangledNames.insert(FunctionName);
+
+        F.setName(FunctionName);
+    }
+}
+
 PreservedAnalyses PrepareForOptPass::run(Module &M,
                                          ModuleAnalysisManager &MAM) {
+    demangleFunctionNames(M);
     return PreservedAnalyses::none();
 }
-- 
2.52.0


