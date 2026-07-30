Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B8FC55165
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH7H-0004es-Lv; Wed, 29 Jul 2026 23:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH74-0004Qq-C4
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:15 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH6z-0002yV-Q4
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=y7kRYOQZQnffNVG0Mg/57xQtZe9BL/W/UU2IwzeD6JQ=; b=QsMgZYfrTLRDoNc
 HjCkNpvPJq2oB8ZCxv+AFhAHV425dXVMvhd1YZrDMXp0parq26CPmSH+9QtAWHUgxF5bgH2Sd6YEm
 QkWaCZ06EGRSDs18LHuiaweSEVKFv1YWqumtIiajf84gVyUiIsHaAH4U+R4WMfO63lx80A5iz70C6
 oY=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 34/50] helper-to-tcg: TcgGenPass, map arguments to TCG
Date: Thu, 30 Jul 2026 05:10:08 +0200
Message-ID: <20260730031025.12926-35-anjo@rev.ng>
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

Mapping for arguments is slighty different than other `Value`s and depend
on function annotations, perform it as a separe pass.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 subprojects/helper-to-tcg/meson.build         |   1 +
 .../src/TcgGenPass/MapArguments.cpp           | 122 ++++++++++++++++++
 2 files changed, 123 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/src/TcgGenPass/MapArguments.cpp

diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
index c03a4d5df6..22190025d0 100644
--- a/subprojects/helper-to-tcg/meson.build
+++ b/subprojects/helper-to-tcg/meson.build
@@ -51,6 +51,7 @@ sources = [
     'src/TcgGenPass/TcgGenPass.cpp',
     'src/TcgGenPass/LinearizeBlocks.cpp',
     'src/TcgGenPass/TcgEmit.cpp',
+    'src/TcgGenPass/MapArguments.cpp',
 ]
 
 clang = bindir / 'clang'
diff --git a/subprojects/helper-to-tcg/src/TcgGenPass/MapArguments.cpp b/subprojects/helper-to-tcg/src/TcgGenPass/MapArguments.cpp
new file mode 100644
index 0000000000..04aa8cf10c
--- /dev/null
+++ b/subprojects/helper-to-tcg/src/TcgGenPass/MapArguments.cpp
@@ -0,0 +1,122 @@
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
+#include "DebugInfo.hpp"
+#include "ValueMapping.hpp"
+
+#include "Error.hpp"
+#include "FunctionAnnotation.hpp"
+#include "TcgType.hpp"
+
+#include <llvm/IR/Constants.h>
+#include <llvm/IR/DerivedTypes.h>
+#include <llvm/IR/Function.h>
+#include <llvm/IR/Module.h>
+
+#define DEBUG_TYPE "map-arguments"
+
+//
+// Map Arguments
+//
+// Assign `TcgV`s to function arguments, taking function annotations into
+// account to force types.  Mapping them early and separately both makes sure
+// that no other pass accidently assign to them, and separates out any special
+// case logic that's necessary.
+//
+
+using namespace llvm;
+
+static Expected<TcgV> mapIntegerArgument(TempAllocationData &TAD,
+                                         const DebugInfoMapTy &DebugInfo,
+                                         const Argument *Arg,
+                                         uint8_t Annotations) {
+    auto *IntTy = cast<IntegerType>(Arg->getType());
+    auto Size = ValueSize::fromLlvmType(IntTy);
+    if (!Size) {
+        return Size.takeError();
+    }
+
+    StringRef Name = getDebugVarName(DebugInfo, Arg);
+
+    if ((Annotations & (uint8_t)ArgumentAnnotation::Immediate) != 0) {
+        auto Tcg = TcgV::makeImmediate(Name, *Size);
+        return TAD.map(Arg, Tcg);
+    } else {
+        auto Tcg = TcgV::makeTemp(*Size, IrValue);
+        Tcg.Name = Name;
+        return TAD.map(Arg, Tcg);
+    }
+}
+
+static Expected<TcgV> mapPointerArgument(TempAllocationData &TAD,
+                                         const DebugInfoMapTy &DebugInfo,
+                                         const Argument *Arg,
+                                         uint8_t Annotations) {
+    // If the value has an associated name from the debug information, use it
+    StringRef Name{};
+    if (auto It = DebugInfo.find(Arg); It != DebugInfo.end()) {
+        Name = It->second.VarName;
+    }
+
+    if ((Annotations & (uint8_t)ArgumentAnnotation::PtrToOffset) != 0) {
+        auto Tcg = TcgV::makeVector({});
+        Tcg.Name = Name;
+        return TAD.map(Arg, Tcg);
+    } else {
+        auto Tcg = TcgV::makeTemp({}, IrPtr);
+        Tcg.Name = Name;
+        return TAD.map(Arg, Tcg);
+    }
+}
+
+static Expected<TcgV> mapArgument(TempAllocationData &Data,
+                                  const DebugInfoMapTy &DebugInfo,
+                                  const Argument *Arg, uint8_t Annotations) {
+    // We only map each argument once, assert it's not been mapped previously.
+    assert(!Data.Map.count(Arg));
+
+    Type *Ty = Arg->getType();
+    if (isa<IntegerType>(Ty)) {
+        return mapIntegerArgument(Data, DebugInfo, Arg, Annotations);
+    } else if (isa<PointerType>(Ty)) {
+        return mapPointerArgument(Data, DebugInfo, Arg, Annotations);
+    }
+
+    return mkError("Unable to map value ", Arg);
+}
+
+Error mapArguments(const llvm::Function &F,
+                   const AnnotationMapTy &AnnotationMap,
+                   const DebugInfoMapTy &DebugInfo, TempAllocationData &Data) {
+    // Map arguments
+    for (size_t I = 0; I < F.arg_size(); ++I) {
+        const Argument *Arg = F.getArg(I);
+        auto It = AnnotationMap.find(&F);
+        const uint8_t Annotations =
+            (It != AnnotationMap.end()) ? It->second.getArgFlag(I) : 0;
+        Expected<TcgV> TcgArg = mapArgument(Data, DebugInfo, Arg, Annotations);
+        if (!TcgArg) {
+            return TcgArg.takeError();
+        }
+        LLVM_DEBUG({
+            dbgs() << "Mapped argument " << *Arg << " to: \n";
+            TcgArg->dump(dbgs());
+        });
+    }
+
+    return Error::success();
+}
-- 
2.52.0


