Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F991D743FD
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwI2-0001hW-RZ; Wed, 20 Nov 2024 20:47:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwI1-0001hN-TM
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:25 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHx-0004a4-0V
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=7ZVMsM/ZVxwvDxZo9mEMb4JOOHxBreG1gQEY2DhLD5k=; b=mi4LEcTf4Dsrcx6
 ggzJOR2I1xRbZtZOs2+355YFKE5JF4CoFu5q0yWnrkIzDSSxV8PZGJIoWShfXu+koccD91N+/1bEy
 +LTGiRrG5Gl/J2R4OF+MfqvZRFJ5EAmRs9Ef3FpDjGK/oAVHSy/mkViSKKlpMy8f3S2Xp7xWem0/T
 Fk=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 28/43] helper-to-tcg: Introduce TcgType.h
Date: Thu, 21 Nov 2024 02:49:32 +0100
Message-ID: <20241121014947.18666-29-anjo@rev.ng>
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

Adds a struct representing everything a LLVM value might map to in TCG,
this includes:

  * TCGv (IrValue);
  * TCGv_ptr (IrPtr);
  * TCGv_env (IrEnv);
  * TCGLabel (IrLabel);
  * tcg_constant_*() (IrConst);
  * 123123ull (IrImmediate);
  * intptr_t gvec_vector (IrPtrToOffset).

NOTE: Patch is subject to change due to rework of the TcgV type system.
There is quite significant overlap in handling IrConst/IrImmediate and
any other type with the ConstantExpression bool set. Space required for
each TcgV can also be reduced by moving to a union.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 .../helper-to-tcg/passes/backend/TcgType.h    | 133 ++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgType.h

diff --git a/subprojects/helper-to-tcg/passes/backend/TcgType.h b/subprojects/helper-to-tcg/passes/backend/TcgType.h
new file mode 100644
index 0000000000..36ebdbe5cb
--- /dev/null
+++ b/subprojects/helper-to-tcg/passes/backend/TcgType.h
@@ -0,0 +1,133 @@
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
+#include <llvm/ADT/Optional.h>
+#include <llvm/ADT/StringRef.h>
+
+#include <assert.h>
+#include <stdint.h>
+#include <string>
+
+enum TcgVKind : uint8_t {
+    IrValue,
+    IrConst,
+    IrEnv,
+    IrImmediate,
+    IrPtr,
+    IrPtrToOffset,
+    IrLabel,
+};
+
+// Counter incremented for every TcgV created, also used in the creation of
+// unique names (e.g. varr_10 for an array).
+extern uint32_t VarIndex;
+
+struct TcgV {
+    uint16_t Id;
+    std::string Name;
+
+    uint32_t TcgSize;
+    uint8_t LlvmSize;
+    uint8_t VectorElementCount;
+
+    TcgVKind Kind;
+
+    bool ConstantExpression = false;
+
+    static TcgV makeVector(uint32_t VectorWidthBits, uint32_t ElementWidthBits,
+                           uint32_t ElementCount)
+    {
+        return TcgV("", VectorWidthBits, ElementWidthBits, ElementCount,
+                    IrPtrToOffset);
+    }
+
+    static TcgV makeImmediate(llvm::StringRef Name, uint32_t TcgWidth,
+                              uint32_t LlvmWidth)
+    {
+        return TcgV(Name.str(), TcgWidth, LlvmWidth, 1, IrImmediate);
+    }
+
+    static TcgV makeTemp(uint32_t TcgWidth, uint32_t LlvmWidth, TcgVKind Kind)
+    {
+        return TcgV("", TcgWidth, LlvmWidth, 1, Kind);
+    }
+
+    static TcgV makeConstantExpression(llvm::StringRef Expression,
+                                       uint32_t TcgWidth, uint32_t LlvmWidth,
+                                       TcgVKind Kind)
+    {
+        TcgV Tcg(Expression.str(), TcgWidth, LlvmWidth, 1, Kind);
+        Tcg.ConstantExpression = true;
+        return Tcg;
+    }
+
+    static TcgV makeLabel() { return TcgV("", 32, 32, 1, IrLabel); }
+
+    TcgV(std::string Name, uint32_t TcgSize, uint32_t LlvmSize,
+         uint32_t VectorElementCount, TcgVKind Kind)
+        : Id(VarIndex++), Name(Name), TcgSize(TcgSize), LlvmSize(LlvmSize),
+          VectorElementCount(VectorElementCount), Kind(Kind)
+    {
+        assert(verifySize());
+    }
+
+    // We make the following assumptions about TcgSize and LLvmSize:
+    //   - TcgSize either 32- or 64-bit;
+    //   - LlvmSize either 1-,8-,16-,32-,64-,or 128-bit.
+    // We also assume that there are only these valid combinations of
+    // (TcgSize, LlvmSize):
+    //   - (64, 64) uint64_t
+    //   - (64, 1)  bool
+    //   - (32, 32) uint32_t
+    //   - (32, 16) uint16_t
+    //   - (32, 8)  uint8_t
+    //   - (32, 1)  bool
+    // So we try to fit the variables in the smallest possible TcgSize,
+    // with the exception of booleans which need to able to be 64-bit
+    // when dealing with conditions.
+    bool verifySize()
+    {
+        return (LlvmSize == 1 || LlvmSize == 8 || LlvmSize == 16 ||
+                LlvmSize == 32 || LlvmSize == 64) &&
+               (LlvmSize <= TcgSize);
+    }
+
+    bool operator==(const TcgV &Other) const { return Other.Id == Id; }
+    bool operator!=(const TcgV &Other) const { return !operator==(Other); }
+};
+
+inline uint64_t llvmToTcgSize(uint64_t LlvmSize)
+{
+    return (LlvmSize <= 32) ? 32 : 64;
+}
+
+inline uint32_t vectorSizeInBytes(const TcgV &Vec)
+{
+    assert(Vec.Kind == IrPtrToOffset);
+    return Vec.LlvmSize * Vec.VectorElementCount / 8;
+}
+
+struct TcgBinOp {
+    std::string Code;
+};
+
+struct TcgVecBinOp {
+    std::string Code;
+    llvm::Optional<uint32_t> RequiredOp2Size;
+};
-- 
2.45.2


