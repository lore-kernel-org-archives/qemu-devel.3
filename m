Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BF3C54FCD
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH7B-0004Vk-PT; Wed, 29 Jul 2026 23:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH72-0004FX-Fn
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:12 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH6q-0002xd-G9
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=BpKyJdGN9i5for/iI7NHXUTpC+D8XweQHkAEvI9NdOM=; b=nqDlHokHNfrGhLn
 MPhJQaZZvnE0/H7g1nPX0rV2LxHZx8a7/ao/PVjzMDOIHlHFB4jNrt8tSiwSxOWqs9F8XDsGuUYri
 PXLBTxr5BL3nIMz0v1aaEwM2H5ecm1CpphS2LCeS8tqLf8SGm0rsPfnTfXYtOeaWN7IdyHj7+qRDV
 sg=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 29/50] helper-to-tcg: Introduce TcgV structure
Date: Thu, 30 Jul 2026 05:10:03 +0200
Message-ID: <20260730031025.12926-30-anjo@rev.ng>
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

Adds a struct representing everything a LLVM value might map to in TCG,
this includes:

  * TCGv_i* (IrValue);
  * TCGv_ptr (IrPtr);
  * TCGLabel (IrLabel);
  * 123123ull (IrImmediate);
  * intptr_t (IrPtrToOffset).

Every `TcgV` value is assigned an increasing identifier, a kind
(list above), a size, and optinally a name along with some extra
flags.  Two values are considered equal if their identifiers are equal.
For instance, this can mean one identifier might describe different LLVM
sizes at different points in a function, which is very useful when mapping
semantics from LLVM IR to TCG.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 subprojects/helper-to-tcg/include/TcgType.hpp | 276 ++++++++++++++++++
 1 file changed, 276 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/include/TcgType.hpp

diff --git a/subprojects/helper-to-tcg/include/TcgType.hpp b/subprojects/helper-to-tcg/include/TcgType.hpp
new file mode 100644
index 0000000000..8cc46a6b1f
--- /dev/null
+++ b/subprojects/helper-to-tcg/include/TcgType.hpp
@@ -0,0 +1,276 @@
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
+#include "Error.hpp"
+#include "LlvmCompat.hpp"
+
+#include <llvm/ADT/ArrayRef.h>
+#include <llvm/ADT/StringRef.h>
+#include <llvm/IR/DerivedTypes.h>
+#include <llvm/Support/raw_ostream.h>
+
+#include <assert.h>
+#include <stdint.h>
+#include <string>
+#include <utility> // std::pair
+
+// Data representing allowed vector and value sizes.
+
+// Sizes corresponding to a TCGv_i* register.
+enum AllowedTcgSize : uint8_t {
+    T32 = 32,
+    T64 = 64,
+    T128 = 128,
+};
+
+// Sizes corresponding of allowed LLVM values, operations smaller than
+// `AllowedTcgSize` act on these sizes.
+enum AllowedLlvmSize : uint8_t {
+    I1 = 1,
+    I8 = 8,
+    I16 = 16,
+    I32 = 32,
+    I64 = 64,
+};
+
+// Despite limiting sizes to an enum, when assigned from runtime values they may
+// still differ.
+inline bool verifyLlvmSize(AllowedLlvmSize S) {
+    switch (S) {
+    case I1:
+    case I8:
+    case I16:
+    case I32:
+    case I64:
+        return true;
+    default:
+        return false;
+    };
+}
+
+// Size of an integer value, combining a TCG and LLVM size.
+struct ValueSize {
+    AllowedTcgSize TcgBitWidth;
+    AllowedLlvmSize LlvmBitWidth;
+
+    static llvm::Expected<ValueSize> fromBitWidth(size_t BitWidth) {
+        ValueSize Ret;
+        if (BitWidth <= 32) {
+            Ret.TcgBitWidth = T32;
+        } else if (BitWidth <= 64) {
+            Ret.TcgBitWidth = T64;
+        } else {
+            Ret.TcgBitWidth = T128;
+        }
+        Ret.LlvmBitWidth = (AllowedLlvmSize)BitWidth;
+        // There's no runtime sanity checks that an enum is not just any integer
+        // value, so verify manually.
+        if (verifyLlvmSize(Ret.LlvmBitWidth)) {
+            return Ret;
+        } else {
+            return mkError("Invalid bit width");
+        }
+    }
+
+    static llvm::Expected<ValueSize> fromLlvmType(llvm::IntegerType *Ty) {
+        return fromBitWidth(Ty->getBitWidth());
+    }
+};
+
+struct VectorSize {
+    uint8_t ElementCount;
+    AllowedLlvmSize ElementBitWidth;
+
+    inline size_t bytes() const { return (ElementCount * ElementBitWidth) / 8; }
+
+    static llvm::Expected<VectorSize> fromLlvmType(llvm::VectorType *Ty) {
+        auto *IntTy = llvm::dyn_cast<llvm::IntegerType>(Ty->getElementType());
+        if (!IntTy) {
+            return mkError(
+                "Vectors of non-integer element type not supported!\n");
+        }
+        VectorSize Ret{
+            (uint8_t)compat::getVectorElementCount(Ty),
+            (AllowedLlvmSize)IntTy->getBitWidth(),
+        };
+        // There's no runtime sanity checks that an enum is not just any integer
+        // value, so verify manually.
+        if (verifyLlvmSize(Ret.ElementBitWidth)) {
+            return Ret;
+        } else {
+            return mkError("Invalid bit width");
+        }
+    }
+};
+
+union TcgSize {
+    VectorSize Vec;
+    ValueSize Val;
+};
+
+// clang-format off
+enum TcgKind : uint8_t {
+    IrInvalid     = 0,
+    IrValue       = 1,  // TCG register value (TCGv_i*)
+    IrImmediate   = 2,  // Immediate argument to TCG operation ([u]int*_t)
+    IrPtr         = 4,  // TCG host pointer (TCGv_ptr)
+    IrPtrToOffset = 8,  // Target "gvec" vector (intptr_t)
+    IrLabel       = 16, // TCG label (TCGv_label)
+};
+// clang-format on
+
+// Describes a single value to be output in TCG, discriminated by `TcgKind`.
+//
+// This data is designed to be copied around and each value is identified via a
+// unique `Id`, as a result the "same" `TcgV` can take on e.g. different sizes
+// at different points in function, which allows one TCG variable to represent
+// multiple smaller "logical" LLVM sizes.
+//
+// TODO:
+//
+//   * There is overlap between `Kind == IrImmediate` and `(ConstantExpression
+//     and Kind == IrValue)` that is not obvious, the condition `!Name.empty()`
+//     is also rather similar to `ConstantExpression` in a lot of cases.
+//
+//   * `Name` should not be string, this is resulting in redundant copies and is
+//     also completely unnecessary given our usage pattern.  `Name` is never
+//     modified, and all strings are created by the same few passes.  A better
+//     solution would be to use a `StringSaver/BumpAllocator` in `CEmitter` and
+//     use `StringRef`s everywhere else.
+//
+struct TcgV {
+    uint16_t Id = 0;
+    TcgKind Kind = IrInvalid;
+    TcgSize Size;
+    bool ConstantExpression = false;
+    std::string Name = "";
+
+    // Static id used to identify `TcgV`s
+    inline static uint16_t IdCounter = 0;
+    static void resetId() { IdCounter = 0; }
+    static uint16_t getId() { return IdCounter++; }
+
+    // Helper functions for accessing size fields.
+    inline ValueSize intSize() const {
+        assert(Kind == IrImmediate or Kind == IrValue);
+        return Size.Val;
+    }
+
+    inline VectorSize vecSize() const {
+        assert(Kind == IrPtrToOffset);
+        return Size.Vec;
+    }
+
+    // Return as `int` to reduce casts when printing and to ease comparisons.
+    inline int tcgBitWidth() const { return intSize().TcgBitWidth; }
+    inline int llvmBitWidth() const { return intSize().LlvmBitWidth; }
+
+    static TcgV makeVector(VectorSize Size) {
+        return TcgV({}, {.Vec = Size}, IrPtrToOffset);
+    }
+
+    static TcgV makeImmediate(llvm::StringRef Name, ValueSize Size) {
+        return TcgV(Name.str(), {.Val = Size}, IrImmediate);
+    }
+
+    static TcgV makeTemp(ValueSize Size, TcgKind Kind) {
+        return TcgV({}, {.Val = Size}, Kind);
+    }
+
+    static TcgV makeConstantExpression(llvm::StringRef Expression,
+                                       ValueSize Size, TcgKind Kind) {
+        TcgV Tcg(Expression.str(), {.Val = Size}, Kind);
+        Tcg.ConstantExpression = true;
+        return Tcg;
+    }
+
+    static TcgV makeLabel() { return TcgV("", {.Val = {T32, I32}}, IrLabel); }
+
+    TcgV() = default;
+
+    TcgV(std::string Name, TcgSize Size, TcgKind Kind)
+        : Id(getId()), Kind(Kind), Size(Size), Name(Name) {}
+
+    // Equality between two values it determined only by the assigned id,
+    // consider a 16- to 8-bit truncation:
+    //
+    //   %1 = trunc i8, i16 %0,
+    //
+    // which after identity mapping becomes
+    //
+    //   %1 = call i8 @IdentityMap.i16.i8(i16 %0).
+    //
+    // Identity mapping will copy the `TcgV` assigned to `%0` to `%1`, but `%1`
+    // will retain its `LlvmSize` needed to emit correctly sized operations down
+    // the line.  Despite differing in `LlvmSize` both `%0` and `%1` will be
+    // emitted as the same TCG value with type `TCGv_i32`.
+    bool operator==(const TcgV &Other) const { return Other.Id == Id; }
+    bool operator!=(const TcgV &Other) const { return !operator==(Other); }
+
+    // Print out struct fields, useful for debugging.
+    inline void dump(llvm::raw_ostream &Out) const {
+        Out << "TcgV " << Id;
+        if (!Name.empty()) {
+            Out << " (" << Name << ")";
+        }
+        Out << ":\n";
+        Out << "  Kind: ";
+        switch (Kind) {
+        case IrInvalid:
+            Out << "IrInvalid\n";
+            break;
+        case IrValue:
+            Out << "IrValue\n";
+            break;
+        case IrImmediate:
+            Out << "IrImmediate\n";
+            break;
+        case IrPtr:
+            Out << "IrPtr\n";
+            break;
+        case IrPtrToOffset:
+            Out << "IrPtrToOffset\n";
+            break;
+        case IrLabel:
+            Out << "IrLabel\n";
+            break;
+        }
+        if (Kind == IrPtrToOffset) {
+            Out << "  VectorElementCount: " << (int)Size.Vec.ElementCount
+                << "\n";
+            Out << "  VectorElementBitWidth: " << (int)Size.Vec.ElementBitWidth
+                << "\n";
+        } else {
+            Out << "  TcgSize: " << (int)Size.Val.TcgBitWidth << "\n";
+            Out << "  LlvmSize: " << (int)Size.Val.LlvmBitWidth << "\n";
+        }
+        Out << "  ConstantExpression: " << ConstantExpression << "\n";
+    }
+};
+
+// Helper function for verifying that a set of `TcgV` are of acceptable types,
+// use with flags like
+//
+//   assertKinds({{Dst, IrPtr}, {Src, IrValue | IrImmediate}))
+//
+inline void assertKinds(llvm::ArrayRef<std::pair<const TcgV, uint8_t>> Pairs) {
+    for (auto &[Tcg, Flag] : Pairs) {
+        assert(Tcg.Kind & Flag);
+    }
+}
-- 
2.52.0


