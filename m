Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDE8C54FCD
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH7i-0005bN-JS; Wed, 29 Jul 2026 23:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH78-0004Tw-8A
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:19 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH6x-0002yH-HZ
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=rMhWtm9d1KNItywPdae+4X897KHvmL4Z2sSDMS5a+EM=; b=xRM3cW7JgXVVuYG
 JoXfeBm3MpujUZ31FiX1SnEIXnWwPXn3HgHAvlOqD7c5Fv/m5CQ5fOst2t5rHaLXSGa2kNxf9a/VC
 fttsrCPk5KFQ8NaLNi2B4l2SpQsxU5n1FAa2A6TWHPfWIjlxCwefMhbRPPMpty6FUKYAL3MWI2m6I
 h8=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 33/50] helper-to-tcg: TcgGenPass,
 add structs for string emission
Date: Thu, 30 Jul 2026 05:10:07 +0200
Message-ID: <20260730031025.12926-34-anjo@rev.ng>
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

Adds two new structures `TcgEmitter` and `CEmitter` with the purpose of
producing valid TCG and C expressions in string form, these will be used
in following commits.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 subprojects/helper-to-tcg/meson.build         |    1 +
 .../helper-to-tcg/src/TcgGenPass/TcgEmit.cpp  | 1203 +++++++++++++++++
 .../helper-to-tcg/src/TcgGenPass/TcgEmit.hpp  |  315 +++++
 3 files changed, 1519 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/src/TcgGenPass/TcgEmit.cpp
 create mode 100644 subprojects/helper-to-tcg/src/TcgGenPass/TcgEmit.hpp

diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
index 58e5f67153..c03a4d5df6 100644
--- a/subprojects/helper-to-tcg/meson.build
+++ b/subprojects/helper-to-tcg/meson.build
@@ -50,6 +50,7 @@ sources = [
     'src/PrepareForTcgPass/IdentityMap.cpp',
     'src/TcgGenPass/TcgGenPass.cpp',
     'src/TcgGenPass/LinearizeBlocks.cpp',
+    'src/TcgGenPass/TcgEmit.cpp',
 ]
 
 clang = bindir / 'clang'
diff --git a/subprojects/helper-to-tcg/src/TcgGenPass/TcgEmit.cpp b/subprojects/helper-to-tcg/src/TcgGenPass/TcgEmit.cpp
new file mode 100644
index 0000000000..8a39fd2589
--- /dev/null
+++ b/subprojects/helper-to-tcg/src/TcgGenPass/TcgEmit.cpp
@@ -0,0 +1,1203 @@
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
+#include "TcgEmit.hpp"
+#include "CmdLineOptions.hpp"
+#include "TcgType.hpp"
+#include "VectorLayout.hpp"
+
+#include <llvm/ADT/SmallString.h>
+
+using namespace llvm;
+
+// Function returning a TcgV representing the current MMU index.
+// Needed for memory operations.
+static const TcgV mmuindex() {
+    if (ForwardContext) {
+        return TcgV::makeImmediate("ctx->mem_idx", {T32, I32});
+    } else {
+        return TcgV::makeImmediate(
+            MmuIndexFunction + "(tcg_ctx->gen_tb->flags)", {T32, I32});
+    }
+}
+
+//
+// TcgEmitter private functions
+//
+
+void TcgEmitter::genVecUnaryCall(StringRef Name, int ElementSize,
+                                 const TcgV &Dst, const TcgV &Src,
+                                 const TcgV &Size) {
+    Out << Name << "(MO_" << ElementSize << ", " << getName(Dst) << ", "
+        << getName(Src) << ", " << getName(Size) << ", " << getName(Size)
+        << ");\n";
+
+    // Track number of vector operations
+    ++NumVectorInstructions;
+}
+
+void TcgEmitter::genVecBinaryCall(StringRef Name, int ElementSize,
+                                  const TcgV &Dst, const TcgV &Src0,
+                                  const TcgV &Src1, size_t Size) {
+    Out << Name << "(MO_" << ElementSize << ", " << getName(Dst) << ", "
+        << getName(Src0) << ", " << getName(Src1) << Size << ", " << Size
+        << ");\n";
+}
+
+void TcgEmitter::genVecCall(StringRef Name, llvm::ArrayRef<const TcgV> Args,
+                            const VectorSize OpSize, const VectorSize MaxSize) {
+    Out << "tcg_gen_gvec_" << Name << "(MO_" << (int)OpSize.ElementBitWidth
+        << ", ";
+    emitArgListTcg(Args.begin(), Args.end());
+    Out << ", " << OpSize.bytes() << ", " << MaxSize.bytes() << ");\n";
+    ++NumVectorInstructions;
+}
+
+const std::string TcgEmitter::getType(const TcgV &Value) {
+    switch (Value.Kind) {
+    case IrValue:
+        return Twine("TCGv_i").concat(Twine(Value.tcgBitWidth())).str();
+    case IrImmediate:
+        if (Value.tcgBitWidth() == 1) {
+            return "bool";
+        } else {
+            return C.intType(false, Value.llvmBitWidth());
+        }
+    case IrPtr:
+        return "TCGv_ptr";
+    case IrPtrToOffset:
+        return "intptr_t";
+    case IrLabel:
+        return "TCGLabel *";
+    default:
+        abort();
+    }
+}
+
+inline StringRef mapPredicate(const CmpInst::Predicate &Pred) {
+    switch (Pred) {
+    case CmpInst::ICMP_EQ:
+        return "TCG_COND_EQ";
+    case CmpInst::ICMP_NE:
+        return "TCG_COND_NE";
+    case CmpInst::ICMP_UGT:
+        return "TCG_COND_GTU";
+    case CmpInst::ICMP_UGE:
+        return "TCG_COND_GEU";
+    case CmpInst::ICMP_ULT:
+        return "TCG_COND_LTU";
+    case CmpInst::ICMP_ULE:
+        return "TCG_COND_LEU";
+    case CmpInst::ICMP_SGT:
+        return "TCG_COND_GT";
+    case CmpInst::ICMP_SGE:
+        return "TCG_COND_GE";
+    case CmpInst::ICMP_SLT:
+        return "TCG_COND_LT";
+    case CmpInst::ICMP_SLE:
+        return "TCG_COND_LE";
+    default:
+        abort();
+    }
+}
+
+static std::string mapBinOp(const Instruction::BinaryOps &Opcode,
+                            const TcgV &Src0, const TcgV &Src1) {
+    const bool IsImmediate =
+        (Src0.Kind == IrImmediate or Src1.Kind == IrImmediate);
+    // TODO:
+    const bool IsPtr = (Opcode == Instruction::Add and
+                        (Src0.Kind == IrPtr or Src1.Kind == IrPtr));
+    assert(IsImmediate or Src0.tcgBitWidth() == Src1.tcgBitWidth());
+    std::string Expr = "";
+    llvm::raw_string_ostream ExprStream(Expr);
+
+    // Check for valid boolean operations if operating on a boolean
+    if (Src0.llvmBitWidth() == 1) {
+        assert(Src1.llvmBitWidth() == 1);
+        switch (Opcode) {
+        case Instruction::And:
+        case Instruction::Or:
+        case Instruction::Xor:
+            break;
+        default:
+            abort();
+        }
+    }
+
+    switch (Opcode) {
+    case Instruction::Add:
+        ExprStream << "tcg_gen_add";
+        break;
+    case Instruction::Sub:
+        ExprStream << "tcg_gen_sub";
+        break;
+    case Instruction::And:
+        ExprStream << "tcg_gen_and";
+        break;
+    case Instruction::Or:
+        ExprStream << "tcg_gen_or";
+        break;
+    case Instruction::Xor:
+        ExprStream << "tcg_gen_xor";
+        break;
+    case Instruction::Mul:
+        ExprStream << "tcg_gen_mul";
+        break;
+    case Instruction::UDiv:
+        ExprStream << "tcg_gen_divu";
+        break;
+    case Instruction::SDiv:
+        ExprStream << "tcg_gen_div";
+        break;
+    case Instruction::AShr:
+        ExprStream << "tcg_gen_sar";
+        break;
+    case Instruction::LShr:
+        ExprStream << "tcg_gen_shr";
+        break;
+    case Instruction::Shl:
+        ExprStream << "tcg_gen_shl";
+        break;
+    default:
+        abort();
+    }
+
+    if (IsImmediate) {
+        ExprStream << "i";
+    }
+
+    if (IsPtr) {
+        ExprStream << "_ptr";
+    } else {
+        ExprStream << "_i" << (int)Src0.tcgBitWidth();
+    }
+
+    ExprStream.flush();
+
+    return Expr;
+}
+
+static std::string mapVecBinOp(const Instruction::BinaryOps &Opcode,
+                               const TcgV &Src0, const TcgV &Src1) {
+    const bool IsShift = Opcode == Instruction::Shl or
+                         Opcode == Instruction::LShr or
+                         Opcode == Instruction::AShr;
+
+    std::string Suffix;
+    switch (Src1.Kind) {
+    case IrPtrToOffset:
+        Suffix = (IsShift) ? "v" : "";
+        break;
+    case IrValue:
+        Suffix = "s";
+        break;
+    case IrImmediate:
+        Suffix = "i";
+        break;
+    default:
+        abort();
+    }
+
+    switch (Opcode) {
+    case Instruction::Add:
+        return "add" + Suffix;
+    case Instruction::Sub:
+        return "sub" + Suffix;
+    case Instruction::Mul:
+        return "mul" + Suffix;
+    case Instruction::And:
+        return "and" + Suffix;
+    case Instruction::Or:
+        return "or" + Suffix;
+    case Instruction::Xor:
+        return "xor" + Suffix;
+    case Instruction::Shl:
+        return "shl" + Suffix;
+    case Instruction::LShr:
+        return "shr" + Suffix;
+    case Instruction::AShr:
+        return "sar" + Suffix;
+    default:
+        abort();
+    }
+}
+
+void TcgEmitter::genSetLabel(const TcgV &L) {
+    assert(L.Kind == IrLabel);
+    Out << "gen_set_label(" << getName(L) << ");\n";
+}
+
+void TcgEmitter::defineNewTemp(const TcgV &Tcg) {
+    assert(!Tcg.ConstantExpression);
+    if (Tcg.Kind == IrPtrToOffset and !EmittedVectorMem) {
+        EmittedVectorMem = true;
+        Out << "VectorMem mem = {0};\n";
+    }
+    Out << getType(Tcg) << " " << getName(Tcg) << " = ";
+    switch (Tcg.Kind) {
+    case IrValue:
+        Out << "tcg_temp_new_i" << (int)Tcg.tcgBitWidth() << "();\n";
+        break;
+    case IrPtr:
+        Out << "tcg_temp_new_ptr();\n";
+        break;
+    case IrPtrToOffset:
+        AllocatedVectorMemory += Tcg.vecSize().bytes();
+        Out << "temp_new_gvec(&mem, " << Tcg.vecSize().bytes() << ");\n";
+        break;
+    case IrLabel:
+        Out << "gen_new_label();\n";
+        break;
+    default:
+        abort();
+    }
+}
+
+void TcgEmitter::genBr(const TcgV &L) {
+    assert(L.Kind == IrLabel);
+    Out << "tcg_gen_br(" << getName(L) << ");\n";
+}
+
+void TcgEmitter::genExts(const TcgV &Dst, const TcgV &Src) {
+    assertKinds({{Dst, IrValue}, {Src, IrValue}});
+    StackTwine<64> FuncStr = Twine("tcg_gen_ext") + Twine(Src.llvmBitWidth()) +
+                             "s_i" + Twine(Dst.tcgBitWidth());
+    emitCallTcg(FuncStr, {Dst, Src});
+}
+
+void TcgEmitter::genExtI32I64(const TcgV &Dst, const TcgV &Src) {
+    assertKinds({{Dst, IrValue}, {Src, IrValue}});
+    emitCallTcg("tcg_gen_ext_i32_i64", {Dst, Src});
+}
+
+void TcgEmitter::genExtrlI64I32(const TcgV &Dst, const TcgV &Src) {
+    assertKinds({{Dst, IrValue}, {Src, IrValue}});
+    emitCallTcg("tcg_gen_extrl_i64_i32", {Dst, Src});
+}
+
+void TcgEmitter::genExtuI32I64(const TcgV &Dst, const TcgV &Src) {
+    assertKinds({{Dst, IrValue}, {Src, IrValue}});
+    emitCallTcg("tcg_gen_extu_i32_i64", {Dst, Src});
+}
+
+void TcgEmitter::genExtrhI64I32(const TcgV &Dst, const TcgV &Src) {
+    assertKinds({{Dst, IrValue}, {Src, IrValue}});
+    emitCallTcg("tcg_gen_extrh_i64_i32", {Dst, Src});
+}
+
+void TcgEmitter::genExtract(bool Sign, const TcgV &Dst, const TcgV &Src,
+                            const TcgV &Offset, const TcgV &Length) {
+    assertKinds({{Dst, IrValue},
+                 {Src, IrValue | IrImmediate},
+                 {Offset, IrImmediate},
+                 {Length, IrImmediate}});
+    assert(Dst.tcgBitWidth() == Src.tcgBitWidth());
+    const char *SignStr = (Sign) ? "s" : "";
+    const TcgV MSrc = materialize(Src);
+    Out << "if (" << getName(Length) << " > 0) {\n";
+    Out << "tcg_gen_" << SignStr << "extract_i" << (int)Dst.tcgBitWidth()
+        << "(";
+    emitArgListTcg({Dst, MSrc, Offset, Length});
+    Out << ");\n";
+    Out << "}\n";
+}
+
+void TcgEmitter::genDeposit(const TcgV &Dst, const TcgV &Into,
+                            const TcgV &Offset, const TcgV &Length,
+                            const TcgV &From) {
+    assertKinds({{Dst, IrValue},
+                 {Into, IrValue | IrImmediate},
+                 {From, IrValue | IrImmediate},
+                 {Offset, IrImmediate},
+                 {Length, IrImmediate}});
+    assert(Dst.tcgBitWidth() == Into.tcgBitWidth());
+    assert(Dst.tcgBitWidth() == From.tcgBitWidth());
+    Out << "if (" << getName(Length) << " > 0) {\n";
+    Out << "tcg_gen_deposit_i" << (int)Dst.tcgBitWidth() << "(";
+    const TcgV MInto = materialize(Into);
+    const TcgV MFrom = materialize(From);
+    emitArgListTcg({Dst, MInto, MFrom, Offset, Length});
+    Out << ");\n";
+    Out << "}\n";
+}
+
+void TcgEmitter::genPtrToValue(const TcgV &Dst, const TcgV &Src) {
+    assertKinds({{Dst, IrValue}, {Src, IrPtr}});
+    if (Dst.tcgBitWidth() == 64) {
+        emitCallTcg("tcg_gen_ext_ptr_i64", {Dst, Src});
+    } else {
+        emitCallTcg("tcg_gen_trunc_ptr_i32", {Dst, Src});
+    }
+}
+
+void TcgEmitter::genValueToPtr(const TcgV &Dst, const TcgV &Src) {
+    assertKinds({{Dst, IrPtr}, {Src, IrValue}});
+    if (Src.tcgBitWidth() == 64) {
+        emitCallTcg("tcg_gen_trunc_i64_ptr", {Dst, Src});
+    } else {
+        emitCallTcg("tcg_gen_trunc_i32_ptr", {Dst, Src});
+    }
+}
+
+void TcgEmitter::genConcat(const TcgV &Dst, const TcgV &Src0,
+                           const TcgV &Src1) {
+    assertKinds({{Dst, IrValue}, {Src0, IrValue}, {Src1, IrValue}});
+    emitCallTcg("tcg_gen_concat_i32_i64", {Dst, Src0, Src1});
+}
+
+void TcgEmitter::genMov(const TcgV &Dst, const TcgV &Src) {
+    assertKinds({{Dst, IrValue}, {Src, IrValue | IrImmediate}});
+    assert(Dst.tcgBitWidth() == Src.tcgBitWidth());
+    const char *ImmStr = (Src.Kind == IrImmediate) ? "i" : "";
+    Out << "tcg_gen_mov" << ImmStr << "_i" << (int)Dst.tcgBitWidth() << "("
+        << getName(Dst) << ", " << getName(Src) << ");\n";
+}
+
+void TcgEmitter::genMovPtr(const TcgV &Dst, const TcgV &Src) {
+    assertKinds({{Dst, IrPtr}, {Src, IrPtr}});
+    Out << "tcg_gen_mov_ptr(" << getName(Dst) << ", " << getName(Src) << ");\n";
+}
+
+void TcgEmitter::genAddPtr(const TcgV &Dst, const TcgV &Ptr,
+                           const TcgV &Offset) {
+    assertKinds({{Dst, IrPtr}, {Ptr, IrPtr}});
+    switch (Offset.Kind) {
+    case IrPtrToOffset:
+    case IrImmediate: {
+        emitCallTcg("tcg_gen_addi_ptr", {Dst, Ptr, Offset});
+    } break;
+    case IrPtr: {
+        emitCallTcg("tcg_gen_add_ptr", {Dst, Ptr, Offset});
+    } break;
+    case IrValue: {
+        auto OffsetPtr = TcgV::makeTemp({}, IrPtr);
+        defineNewTemp(OffsetPtr);
+        genValueToPtr(OffsetPtr, Offset);
+        emitCallTcg("tcg_gen_add_ptr", {Dst, Ptr, OffsetPtr});
+    } break;
+    default:
+        abort();
+    }
+}
+
+void TcgEmitter::genBinOp(const TcgV &Dst, const Instruction::BinaryOps Opcode,
+                          const TcgV &Src0, const TcgV &Src1) {
+    auto OpStr = mapBinOp(Opcode, Src0, Src1);
+    emitCallTcg(OpStr, {Dst, Src0, Src1});
+}
+
+void TcgEmitter::genMovcond(const CmpInst::Predicate &Pred, const TcgV &Ret,
+                            const TcgV &C1, const TcgV &C2, const TcgV &V1,
+                            const TcgV &V2) {
+    const size_t OpWidth = Ret.tcgBitWidth();
+    assert(OpWidth == C1.tcgBitWidth());
+    assert(OpWidth == C2.tcgBitWidth());
+    assert(OpWidth == V1.tcgBitWidth());
+    assert(OpWidth == V2.tcgBitWidth());
+    const TcgV mC1 = materialize(C1);
+    const TcgV mC2 = materialize(C2);
+    const TcgV mV1 = materialize(V1);
+    const TcgV mV2 = materialize(V2);
+    Out << "tcg_gen_movcond_i" << OpWidth << '(' << mapPredicate(Pred) << ", ";
+    emitArgListTcg({Ret, mC1, mC2, mV1, mV2});
+    Out << ");\n";
+}
+
+void TcgEmitter::genSetcond(const CmpInst::Predicate &Pred, const TcgV &Dst,
+                            const TcgV &Src0, const TcgV &Src1) {
+    assertKinds(
+        {{Dst, IrValue}, {Src0, IrValue}, {Src1, IrValue | IrImmediate}});
+    const size_t OpWidth = Dst.tcgBitWidth();
+    assert(OpWidth == Src0.tcgBitWidth());
+    assert(OpWidth == Src1.tcgBitWidth());
+    const char *ImmStr = (Src1.Kind == IrImmediate) ? "i" : "";
+    Out << "tcg_gen_setcond" << ImmStr << "_i" << OpWidth;
+    Out << "(" << mapPredicate(Pred) << ", ";
+    emitArgListTcg({Dst, Src0, Src1});
+    Out << ");\n";
+}
+
+void TcgEmitter::genBrcond(const CmpInst::Predicate &Pred, const TcgV &Src0,
+                           const TcgV &Src1, const TcgV &Label) {
+    assertKinds({{Src0, IrValue | IrImmediate},
+                 {Src1, IrValue | IrImmediate},
+                 {Label, IrLabel}});
+    assert(Src0.tcgBitWidth() == Src1.tcgBitWidth());
+    const char *ImmStr = (Src1.Kind == IrImmediate) ? "i" : "";
+    Out << "tcg_gen_brcond" << ImmStr << "_i" << (int)Src0.tcgBitWidth();
+    Out << "(" << mapPredicate(Pred) << ", ";
+    emitArgListTcg({materialize(Src0), Src1, Label});
+    Out << ");\n";
+}
+
+std::string TcgEmitter::getMemOp(uint8_t Size, uint8_t Endianness,
+                                 uint8_t Sign) {
+    std::string MemOpStr{};
+    raw_string_ostream MemOpStream(MemOpStr);
+    MemOpStream << "MO_" << (int)8 * Size;
+    switch (Endianness) {
+    case 0:
+        break; // do nothing
+    case 1:
+        MemOpStream << " | MO_LE";
+        break;
+    case 2:
+        MemOpStream << " | MO_BE";
+        break;
+    default:
+        abort();
+    }
+    switch (Sign) {
+    case 0:
+        break;
+    case 1:
+        MemOpStream << " | MO_SIGN";
+        break;
+    default:
+        abort();
+    }
+    return MemOpStream.str();
+}
+
+void TcgEmitter::genGuestLoad(const TcgV &Dst, const TcgV &Ptr,
+                              StringRef MemOp) {
+    assertKinds({{Dst, IrValue}, {Ptr, IrValue | IrImmediate}});
+    Out << "tcg_gen_qemu_ld_i" << (int)Dst.tcgBitWidth() << "(";
+    emitArgListTcg({Dst, materialize(Ptr), mmuindex()});
+    Out << ", " << MemOp << ");\n";
+}
+
+void TcgEmitter::genGuestStore(const TcgV &Ptr, const TcgV &Src,
+                               StringRef MemOp) {
+    assertKinds({{Ptr, IrValue | IrImmediate}, {Src, IrValue | IrImmediate}});
+    Out << "tcg_gen_qemu_st_i" << (int)Src.tcgBitWidth() << "(";
+    emitArgListTcg({materialize(Src), materialize(Ptr), mmuindex()});
+    Out << ", " << MemOp << ");\n";
+}
+
+void TcgEmitter::genHostLoad(const TcgV &Dst, const TcgV &Ptr,
+                             const TcgV &Offset) {
+    assertKinds({{Dst, IrValue}, {Ptr, IrPtr}});
+    const size_t LlvmSize = Dst.llvmBitWidth();
+    const size_t TcgSize = Dst.tcgBitWidth();
+    if (LlvmSize < TcgSize) {
+        Out << "tcg_gen_ld" << LlvmSize << "u_i" << TcgSize;
+    } else {
+        Out << "tcg_gen_ld_i" << TcgSize;
+    }
+    Out << "(";
+    emitArgListTcg({Dst, Ptr, Offset});
+    Out << ");\n";
+}
+
+void TcgEmitter::genHostLoadFromVec(const TcgV &Dst, const TcgV &Offset) {
+    genHostLoad(Dst, getGlobalEnv(), Offset);
+}
+
+void TcgEmitter::genHostStore(const TcgV &Ptr, const TcgV &Src) {
+    assertKinds({{Ptr, IrPtr}, {Src, IrValue | IrImmediate}});
+    const size_t LlvmSize = Src.llvmBitWidth();
+    const size_t TcgSize = Src.tcgBitWidth();
+    if (LlvmSize < TcgSize) {
+        Out << "tcg_gen_st" << LlvmSize << "_i" << TcgSize;
+    } else {
+        Out << "tcg_gen_st_i" << TcgSize;
+    }
+    Out << "(";
+    emitArgListTcg({materialize(Src), Ptr});
+    Out << ", 0);\n";
+}
+void TcgEmitter::genFunnelShl(const TcgV &Dst, const TcgV &Src0,
+                              const TcgV &Src1, const TcgV &Shift) {
+    const size_t OpWidth = Dst.tcgBitWidth();
+    assert(OpWidth == Src0.tcgBitWidth());
+    assert(OpWidth == Src1.tcgBitWidth());
+    assert(OpWidth == Shift.tcgBitWidth());
+    if (OpWidth == 32) {
+        auto Temp = TcgV::makeTemp({T64, I64}, IrValue);
+        defineNewTemp(Temp);
+        genConcat(Temp, Src1, Src0);
+
+        if (Shift.Kind == IrImmediate) {
+            genBinOp(Temp, Instruction::Shl, Temp, Shift);
+        } else {
+            auto Ext = TcgV::makeTemp({T64, I64}, IrValue);
+            defineNewTemp(Ext);
+            genExtuI32I64(Ext, Shift);
+            genBinOp(Temp, Instruction::Shl, Temp, Ext);
+        }
+
+        genExtrhI64I32(Dst, Temp);
+    } else {
+        genCallHelper(
+            "helper_fshl_i64",
+            {Dst, materialize(Src0), materialize(Src1), materialize(Shift)});
+    }
+}
+
+void TcgEmitter::genBitreverse(const TcgV &Dst, const TcgV &Src) {
+    assertKinds({{Dst, IrValue}, {Src, IrValue}});
+    StackTwine<64> FuncName = Twine("helper_bitreverse") +
+                              Twine(Dst.tcgBitWidth()) + "_i" +
+                              Twine(Src.tcgBitWidth());
+    genCallHelper(FuncName, {Dst, Src});
+}
+
+void TcgEmitter::genCountLeadingZeros(const TcgV &Dst, const TcgV &Src) {
+    assertKinds({{Dst, IrValue}, {Src, IrValue}});
+    assert(Dst.tcgBitWidth() == Src.tcgBitWidth());
+    Out << "tcg_gen_clzi_i" << Dst.tcgBitWidth() << "(";
+    emitArgListTcg({Dst, Src});
+    Out << ", " << Src.tcgBitWidth() << ");\n";
+}
+
+void TcgEmitter::genCountTrailingZeros(const TcgV &Dst, const TcgV &Src) {
+    assertKinds({{Dst, IrValue}, {Src, IrValue}});
+    assert(Dst.tcgBitWidth() == Src.tcgBitWidth());
+    Out << "tcg_gen_ctzi_i" << Dst.tcgBitWidth() << "(";
+    emitArgListTcg({Dst, Src});
+    Out << ", " << Src.tcgBitWidth() << ");\n";
+}
+
+void TcgEmitter::genCountOnes(const TcgV &Dst, const TcgV &Src) {
+    assertKinds({{Dst, IrValue}, {Src, IrValue}});
+    assert(Dst.tcgBitWidth() == Src.tcgBitWidth());
+    Out << "tcg_gen_ctpop_i" << Dst.tcgBitWidth() << "(";
+    emitArgListTcg({Dst, Src});
+    Out << ");\n";
+}
+
+void TcgEmitter::genByteswap(const TcgV &Dst, const TcgV &Src) {
+    assertKinds({{Dst, IrValue}, {Src, IrValue}});
+    assert(Dst.tcgBitWidth() == Src.tcgBitWidth());
+    Out << "tcg_gen_bswap" << Dst.llvmBitWidth() << "_i" << Src.tcgBitWidth()
+        << "(";
+    emitArgListTcg({Dst, Src});
+    Out << ");\n";
+}
+
+void TcgEmitter::genUnsignedSatSub(const TcgV &Dst, const TcgV &Src0,
+                                   const TcgV &Src1) {
+    assertKinds({{Dst, IrValue}, {Src0, IrValue}, {Src1, IrValue}});
+    const size_t OpWidth = Dst.tcgBitWidth();
+    assert(OpWidth == Src0.tcgBitWidth());
+    assert(OpWidth == Src1.tcgBitWidth());
+    Out << "tcg_gen_ussub_i" << OpWidth << "(";
+    emitArgListTcg({Dst, Src0, Src1});
+    Out << ");\n";
+}
+
+inline TcgKind opKind(const TcgV &Dst, const TcgV &Src) {
+    return (Dst.Kind == IrPtr) ? Src.Kind : Dst.Kind;
+}
+
+void TcgEmitter::genVecBinOpStr(StringRef Op, const TcgV &Dst, const TcgV &Src0,
+                                const TcgV &Src1) {
+    assertKinds({{Dst, IrPtr | IrPtrToOffset},
+                 {Src0, IrPtrToOffset},
+                 {Src1, IrPtrToOffset | IrValue | IrImmediate}});
+    const VectorSize Size = Src0.vecSize();
+    Out << "tcg_gen_gvec_" << Op << "(MO_" << (int)Size.ElementBitWidth << ", ";
+    emitArgListTcg({Dst, Src0, Src1});
+    Out << ", " << Size.bytes() << ", " << Size.bytes() << ");\n";
+    // Track number of vector operations
+    ++NumVectorInstructions;
+}
+
+void TcgEmitter::genVecBinOp(const Instruction::BinaryOps Opcode,
+                             const TcgV &Dst, const TcgV &Src0,
+                             const TcgV &Src1) {
+    genVecBinOpStr(mapVecBinOp(Opcode, Src0, Src1), Dst, Src0, Src1);
+}
+
+void TcgEmitter::genVecSignedSatAdd(const TcgV &Dst, const TcgV &Src0,
+                                    const TcgV &Src1) {
+    genVecBinOpStr("ssadd", Dst, Src0, Src1);
+}
+
+void TcgEmitter::genVecSignedSatSub(const TcgV &Dst, const TcgV &Src0,
+                                    const TcgV &Src1) {
+    genVecBinOpStr("sssub", Dst, Src0, Src1);
+}
+
+void TcgEmitter::genVecUnsignedSatSub(const TcgV &Dst, const TcgV &Src0,
+                                      const TcgV &Src1) {
+    genVecBinOpStr("ussub", Dst, Src0, Src1);
+}
+
+void TcgEmitter::genVecOrScalarBinOp(StringRef Op, const TcgV &Dst,
+                                     const TcgV &Src0, const TcgV &Src1) {
+    assertKinds({{Dst, IrValue | IrPtrToOffset},
+                 {Src0, IrValue | IrPtrToOffset | IrImmediate},
+                 {Src1, IrValue | IrPtrToOffset | IrImmediate}});
+    switch (Dst.Kind) {
+    case IrValue: {
+        Out << "tcg_gen_" << Op << "_i" << Dst.tcgBitWidth() << "(";
+        emitArgListTcg({Dst, materialize(Src0), materialize(Src1)});
+        Out << ");\n";
+    } break;
+    case IrPtrToOffset: {
+        genVecBinOpStr(Op, Dst, Src0, Src1);
+    } break;
+    default:
+        abort();
+    }
+}
+
+void TcgEmitter::genVecSignedMax(const TcgV &Dst, const TcgV &Src0,
+                                 const TcgV &Src1) {
+    genVecOrScalarBinOp("smax", Dst, Src0, Src1);
+}
+
+void TcgEmitter::genVecUnsignedMax(const TcgV &Dst, const TcgV &Src0,
+                                   const TcgV &Src1) {
+    genVecOrScalarBinOp("umax", Dst, Src0, Src1);
+}
+
+void TcgEmitter::genVecSignedMin(const TcgV &Dst, const TcgV &Src0,
+                                 const TcgV &Src1) {
+    genVecOrScalarBinOp("smin", Dst, Src0, Src1);
+}
+
+void TcgEmitter::genVecUnsignedMin(const TcgV &Dst, const TcgV &Src0,
+                                   const TcgV &Src1) {
+    genVecOrScalarBinOp("umin", Dst, Src0, Src1);
+}
+
+void TcgEmitter::genVecMemcpy(const TcgV &Dst, const TcgV &Src,
+                              const TcgV &Size) {
+    genVecUnaryCall("tcg_gen_gvec_mov", 8, Dst, Src, Size);
+}
+
+void TcgEmitter::genVecMemset(const TcgV &Dst, const TcgV &Src,
+                              const TcgV &Size) {
+    assertKinds({{Dst, IrPtrToOffset},
+                 {Src, IrValue | IrImmediate},
+                 {Size, IrImmediate}});
+    switch (Src.Kind) {
+    case IrValue:
+        Out << "tcg_gen_gvec_dup_i" << Src.tcgBitWidth() << "(MO_"
+            << Src.llvmBitWidth() << ", ";
+        emitArgListTcg({Dst, Size, Size, Src});
+        Out << ");\n";
+        break;
+    case IrImmediate:
+        Out << "tcg_gen_gvec_dup_imm" << "(MO_" << Src.llvmBitWidth() << ", ";
+        emitArgListTcg({Dst, Size, Size, Src});
+        Out << ");\n";
+        break;
+    default:
+        abort();
+    }
+    // Track number of vector operations
+    ++NumVectorInstructions;
+}
+
+void TcgEmitter::genVecSplat(const TcgV &Dst, const TcgV &Src) {
+    const size_t Bytes = Dst.vecSize().bytes();
+    const auto Size = TcgV::makeImmediate(Twine(Bytes).str(), {T64, I64});
+    genVecMemset(Dst, Src, Size);
+}
+
+void TcgEmitter::genVecArrSplat(const TcgV &Dst, const TcgV &Src) {
+    assert(Src.ConstantExpression);
+    const VectorSize SrcSize = Src.vecSize();
+    const VectorSize DstSize = Dst.vecSize();
+    const std::string DstName = getName(Dst);
+    // NOTE: We are emitting static constant arrays of `uint64_t[]` with the
+    // purpose of initializing vectors to these constants using
+    // `tcg_gen_gvec_mov_var()`.  This should be equivalent to a vectorized load
+    // from a constant pointer into the read-only section of the binary, into a
+    // guest vector.  If this is problematic we'll have
+    // resubprojects/helper-to-tcg/passes/backend/TcgEmit.hsort to adding
+    // constant vector storage to `env` if needed.
+    const std::string ArrData = Twine(DstName).concat("_data").str();
+    Out << "static const " << C.intType(false, SrcSize.ElementBitWidth) << " "
+        << ArrData << "[] = " << getName(Src) << ";\n";
+    Out << "tcg_gen_gvec_mov_var(MO_" << (int)SrcSize.ElementBitWidth << ", "
+        << getName(getGlobalEnv()) << ", " << DstName << ", tcg_constant_ptr("
+        << ArrData << "), 0, " << SrcSize.bytes() << ", " << DstSize.bytes()
+        << ");\n";
+    // Track number of vector operations
+    ++NumVectorInstructions;
+}
+
+void TcgEmitter::genVecBitsel(const TcgV &Dst, const TcgV &Cond,
+                              const TcgV &Src0, const TcgV &Src1) {
+    assertKinds({{Dst, IrPtrToOffset},
+                 {Cond, IrPtrToOffset},
+                 {Src0, IrPtrToOffset},
+                 {Src1, IrPtrToOffset}});
+    genVecCall("bitsel", {Dst, Cond, Src0, Src1}, Src0.vecSize(),
+               Src0.vecSize());
+}
+
+void TcgEmitter::genVecCmp(const TcgV &Dst, const CmpInst::Predicate &Pred,
+                           const TcgV &Src0, const TcgV &Src1) {
+    assertKinds(
+        {{Dst, IrPtrToOffset}, {Src0, IrPtrToOffset}, {Src1, IrPtrToOffset}});
+    // NOTE: Return type of a LLVM vector compare is `<128 x i1>`, here the
+    // operand type is taken as the return type similar to how `icmp` is
+    // mapped.
+    const VectorSize Size = Src0.vecSize();
+    Out << "tcg_gen_gvec_cmp(" << mapPredicate(Pred) << ", " << "MO_"
+        << (int)Size.ElementBitWidth << ", " << getName(Dst) << ", "
+        << getName(Src0) << ", " << getName(Src1) << ", " << Size.bytes()
+        << ", " << Size.bytes() << ");\n";
+    // Track number of vector operations
+    ++NumVectorInstructions;
+}
+
+void TcgEmitter::genAbs(const TcgV &Dst, const TcgV &Src) {
+    assertKinds(
+        {{Dst, IrValue | IrPtrToOffset}, {Src, IrValue | IrPtrToOffset}});
+    switch (Dst.Kind) {
+    case IrValue: {
+        const auto FuncStr =
+            Twine("tcg_gen_abs_i").concat(Twine(Src.tcgBitWidth())).str();
+        emitCallTcg(FuncStr, {Dst, Src});
+    } break;
+    case IrPtrToOffset: {
+        genVecCall("abs", {Dst, Src}, Src.vecSize(), Dst.vecSize());
+    } break;
+    default:
+        abort();
+    }
+}
+
+void TcgEmitter::genVecNot(const TcgV &Dst, const TcgV &Src) {
+    assertKinds({{Dst, IrPtrToOffset}, {Src, IrPtrToOffset}});
+    genVecCall("not", {Dst, Src}, Dst.vecSize(), Dst.vecSize());
+}
+
+void TcgEmitter::genVecSizeChange(StringRef Name, uint8_t DstElementBits,
+                                  const TcgV &Dst, const TcgV &Src) {
+    assertKinds({{Dst, IrPtrToOffset}, {Src, IrPtrToOffset}});
+    const VectorSize Size = Src.vecSize();
+    Out << "gen_vec_" << Name << "_" << (int)Size.ElementBitWidth << "_"
+        << (int)DstElementBits << "(" << getName(Dst) << ", " << getName(Src)
+        << ", " << Size.bytes() << ");\n";
+    // Track number of vector operations
+    ++NumVectorInstructions;
+    // Indicates definitions of gen_helper_vec_[zext|trunc_sext] need to be
+    // emitted.
+    NeedVectorSizeChangeOps = true;
+}
+
+void TcgEmitter::genVecTrunc(uint8_t DstElementBits, const TcgV &Dst,
+                             const TcgV &Src) {
+    genVecSizeChange("trunc", DstElementBits, Dst, Src);
+}
+
+void TcgEmitter::genVecSext(uint8_t DstElementBits, const TcgV &Dst,
+                            const TcgV &Src) {
+    genVecSizeChange("sext", DstElementBits, Dst, Src);
+}
+
+void TcgEmitter::genVecZext(uint8_t DstElementBits, const TcgV &Dst,
+                            const TcgV &Src) {
+    genVecSizeChange("zext", DstElementBits, Dst, Src);
+}
+
+static inline size_t roundToMultiple(size_t X, size_t Multiple) {
+    return Multiple * ((X + Multiple - 1) / Multiple);
+}
+
+std::string CEmitter::intType(bool Signed, uint8_t LlvmSize) {
+    return Twine((Signed) ? "int" : "uint")
+        .concat(Twine(roundToMultiple(LlvmSize, 8)))
+        .concat("_t")
+        .str();
+}
+
+inline StringRef mapCPredicate(const CmpInst::Predicate &Pred) {
+    switch (Pred) {
+    case CmpInst::ICMP_EQ:
+        return "==";
+    case CmpInst::ICMP_NE:
+        return "!=";
+    case CmpInst::ICMP_UGT:
+        return ">";
+    case CmpInst::ICMP_UGE:
+        return ">=";
+    case CmpInst::ICMP_ULT:
+        return "<";
+    case CmpInst::ICMP_ULE:
+        return "<=";
+    case CmpInst::ICMP_SGT:
+        return ">";
+    case CmpInst::ICMP_SGE:
+        return ">=";
+    case CmpInst::ICMP_SLT:
+        return "<";
+    case CmpInst::ICMP_SLE:
+        return "<=";
+    default:
+        abort();
+    }
+}
+
+inline bool predicateNeedsSignCast(const CmpInst::Predicate &Pred) {
+    switch (Pred) {
+    case CmpInst::ICMP_EQ:
+    case CmpInst::ICMP_NE:
+    case CmpInst::ICMP_UGT:
+    case CmpInst::ICMP_UGE:
+    case CmpInst::ICMP_ULT:
+    case CmpInst::ICMP_ULE:
+        return false;
+    case CmpInst::ICMP_SGT:
+    case CmpInst::ICMP_SGE:
+    case CmpInst::ICMP_SLT:
+    case CmpInst::ICMP_SLE:
+        return true;
+    default:
+        abort();
+    }
+}
+
+enum BinOpSrcCast {
+    CastNone,
+    CastSigned,
+    CastUnsigned,
+};
+
+std::string CEmitter::mapBinOp(const Instruction::BinaryOps &Opcode,
+                               const TcgV &Src0, const TcgV &Src1) {
+    assert(Src0.Kind == IrImmediate and Src1.Kind == IrImmediate);
+    std::string Op;
+    BinOpSrcCast CastSrc0 = CastNone;
+    BinOpSrcCast CastSrc1 = CastNone;
+    switch (Opcode) {
+    case Instruction::Add:
+        Op = "+";
+        break;
+    case Instruction::And:
+        Op = "&";
+        break;
+    case Instruction::AShr:
+        CastSrc0 = CastSigned;
+        Op = ">>";
+        break;
+    case Instruction::LShr:
+        CastSrc0 = CastUnsigned;
+        Op = ">>";
+        break;
+    case Instruction::Shl:
+        Op = "<<";
+        break;
+    case Instruction::Mul:
+        Op = "*";
+        break;
+    case Instruction::UDiv:
+        CastSrc0 = CastUnsigned;
+        CastSrc1 = CastUnsigned;
+        Op = "/";
+        break;
+    case Instruction::SDiv:
+        CastSrc0 = CastSigned;
+        CastSrc1 = CastSigned;
+        Op = "/";
+        break;
+    case Instruction::Or:
+        Op = "|";
+        break;
+    case Instruction::Sub:
+        Op = "-";
+        break;
+    case Instruction::Xor:
+        Op = "^";
+        break;
+    default:
+        abort();
+    }
+
+    std::string Expr = "";
+    llvm::raw_string_ostream ExprStream(Expr);
+    ExprStream << "(";
+    if (CastSrc0 != CastNone) {
+        ExprStream << "("
+                   << intType(CastSrc0 == CastSigned, Src0.llvmBitWidth())
+                   << ") ";
+    }
+    ExprStream << getName(Src0) << " " << Op << " ";
+    if (CastSrc1 != CastNone) {
+        ExprStream << "("
+                   << intType(CastSrc1 == CastSigned, Src1.llvmBitWidth())
+                   << ") ";
+    }
+    ExprStream << getName(Src1) << ")";
+    ExprStream.flush();
+
+    return Expr;
+}
+
+// TODO:
+TcgV CEmitter::ptrAdd(const TcgV &Ptr, const TcgV &Offset) {
+    assert(Offset.Kind == IrImmediate);
+    switch (Ptr.Kind) {
+    case IrImmediate: {
+        std::string Expr = "";
+        llvm::raw_string_ostream ExprStream(Expr);
+        ExprStream << "(" << intType(false, Ptr.tcgBitWidth())
+                   << " *) ((uintptr_t) " << getName(Ptr) << " + "
+                   << getName(Offset) << ")";
+        ExprStream.flush();
+        return TcgV::makeImmediate(Expr, Ptr.intSize());
+    };
+    case IrPtrToOffset: {
+        std::string Expr = "";
+        llvm::raw_string_ostream ExprStream(Expr);
+        ExprStream << "(" << getName(Ptr) << " + " << getName(Offset) << ")";
+        ExprStream.flush();
+        TcgV Dst = Ptr;
+        Dst.Kind = IrPtrToOffset;
+        Dst.Name = Expr;
+        Dst.ConstantExpression = true;
+        return Dst;
+    };
+    default:
+        abort();
+    }
+}
+
+TcgV CEmitter::ternary(const TcgV &Cond, const TcgV &True, const TcgV &False) {
+    assert(Cond.Kind == IrImmediate);
+    std::string Expr = "";
+    llvm::raw_string_ostream ExprStream(Expr);
+    ExprStream << "(" << getName(Cond) << " ? " << getName(True) << " : "
+               << getName(False) << ")";
+    ExprStream.flush();
+    return TcgV::makeConstantExpression(Expr, True.intSize(), True.Kind);
+}
+
+TcgV CEmitter::deref(const TcgV &Ptr, ValueSize Size) {
+    assert(Ptr.Kind == IrImmediate);
+    std::string Expr = Twine("*").concat(getName(Ptr)).str();
+    return TcgV::makeImmediate(Expr, Size);
+}
+
+TcgV CEmitter::compare(const CmpInst::Predicate &Pred, const TcgV &Lhs,
+                       const TcgV &Rhs) {
+    assert(Lhs.Kind == IrImmediate and Rhs.Kind == IrImmediate);
+    const bool NeedsCast = predicateNeedsSignCast(Pred);
+    const std::string LhsCast =
+        (NeedsCast) ? "(" + intType(true, Lhs.llvmBitWidth()) + ")" : "";
+    const std::string RhsCast =
+        (NeedsCast) ? "(" + intType(true, Rhs.llvmBitWidth()) + ")" : "";
+    std::string Expr = "";
+    llvm::raw_string_ostream ExprStream(Expr);
+    ExprStream << "(" << LhsCast << getName(Lhs) << " " << mapCPredicate(Pred)
+               << " " << RhsCast << getName(Rhs) << ")";
+    ExprStream.flush();
+    return TcgV::makeImmediate(Expr, Lhs.intSize());
+}
+
+TcgV CEmitter::extend(bool Signed, const TcgV &V, ValueSize Size) {
+    assert(V.Kind == IrImmediate or
+           (V.ConstantExpression and V.Kind == IrValue));
+    std::string Expr = "";
+    llvm::raw_string_ostream ExprStream(Expr);
+    ExprStream << "((" << intType(Signed, Size.LlvmBitWidth) << ") ("
+               << intType(Signed, V.llvmBitWidth()) << ") " << getName(V)
+               << ")";
+    ExprStream.flush();
+    return TcgV::makeImmediate(Expr, Size);
+}
+
+TcgV CEmitter::binop(Instruction::BinaryOps Opcode, const TcgV &Src0,
+                     const TcgV &Src1) {
+    std::string Op = mapBinOp(Opcode, Src0, Src1);
+    ValueSize LargestSize = (Src0.llvmBitWidth() > Src1.llvmBitWidth())
+                                ? Src0.intSize()
+                                : Src1.intSize();
+    return TcgV::makeImmediate(Op, LargestSize);
+}
+
+void emitVectorMem(raw_ostream &Out) {
+    Out << "typedef struct VectorMem {\n";
+    Out << "    uint32_t allocated;\n";
+    Out << "} VectorMem;\n\n";
+
+    Out << "static intptr_t temp_new_gvec(VectorMem *mem, uint32_t size)\n";
+    Out << "{\n";
+    Out << "    uint32_t off = ROUND_UP(mem->allocated, size);\n";
+    Out << "    g_assert(off + size <= STRUCT_SIZEOF_FIELD(CPUArchState, "
+        << TempVectorBlock << "));\n";
+    Out << "    mem->allocated = off + size;\n";
+    Out << "    return offsetof(CPUArchState, " << TempVectorBlock
+        << ") + off;\n";
+    Out << "}\n";
+}
+
+static void emitVectorSizeChangeHelper(raw_ostream &OutSource,
+                                       raw_ostream &OutHeader, StringRef Name,
+                                       StringRef IntPrefix, int SrcSize,
+                                       int DstSize) {
+    const std::string NameWithTypes =
+        (Twine("vec_") + Name + "_" + Twine(SrcSize) + "_" + Twine(DstSize))
+            .str();
+
+    // Emit helper declarations.
+    OutHeader << "DEF_HELPER_FLAGS_3(" << NameWithTypes
+              << ", TCG_CALL_NO_RWG, void, ptr, ptr, i32)\n";
+
+    // Emit helper definitions.
+    OutSource << "void HELPER(" << NameWithTypes
+              << ")(void *d, void *a, uint32_t size)\n{\n";
+    OutSource << "for (intptr_t i = 0; i < (size / sizeof(" << IntPrefix
+              << SrcSize << "_t)); ++i) {\n";
+    OutSource << IntPrefix << SrcSize << "_t aa = *((" << IntPrefix << SrcSize
+              << "_t *) a + i);\n";
+    OutSource << "*((" << IntPrefix << DstSize << "_t *) d + i) = aa;\n";
+    OutSource << "}\n";
+    OutSource << "}\n\n";
+
+    // Emit gen_vec_*() function invoking helper functions.
+    OutSource << "static inline void G_GNUC_UNUSED gen_" << NameWithTypes
+              << "(intptr_t dofs, intptr_t aofs, uint32_t size)\n{\n";
+    OutSource << "TCGv_ptr d = tcg_temp_new_ptr();\n";
+    OutSource << "TCGv_ptr a = tcg_temp_new_ptr();\n";
+    OutSource << "tcg_gen_addi_ptr(d, tcg_env, dofs);\n";
+    OutSource << "tcg_gen_addi_ptr(a, tcg_env, aofs);\n";
+    OutSource << "gen_helper_" << NameWithTypes
+              << "(d, a, tcg_constant_i32(size));\n";
+    OutSource << "}\n\n";
+}
+
+static void emitVectorIndex(raw_ostream &OutSource, const VectorLayout &VL,
+                            size_t LaneSize) {
+    const size_t LanesPerColumn = 64 / LaneSize;
+    const size_t ColumnsPerBlock = VL.BlockBytes / 8;
+    OutSource << "inline size_t ind_" << LaneSize << "(size_t i) {\n";
+    OutSource << "const size_t c = i / " << LanesPerColumn << ";\n";
+    OutSource << "const size_t b = c / " << ColumnsPerBlock << ";\n";
+    OutSource << "const size_t ci = i % " << LanesPerColumn << ";\n";
+    OutSource << "const size_t bc = c % " << ColumnsPerBlock << ";\n";
+    OutSource << "return " << (8 * VL.BlockBytes) / LaneSize << " * b";
+    if (VL.HostBigEndian ^ (VL.Lane0 == MostSignificant)) {
+        OutSource << " + " << LanesPerColumn << " * (" << ColumnsPerBlock - 1
+                  << " - bc)";
+    } else {
+        OutSource << " + " << LanesPerColumn << " * bc";
+    }
+    if (VL.HostBigEndian ^ (VL.Lane0 == MostSignificant)) {
+        OutSource << " + (" << LanesPerColumn - 1 << " - ci);\n";
+    } else {
+        OutSource << " + ci;\n";
+    }
+    OutSource << "}\n\n";
+}
+
+void emitVectorSizeChangeOps(raw_ostream &OutSource, raw_ostream &OutHeader,
+                             const VectorLayout &VL) {
+    OutSource << "#define HELPER_H \"helper-to-tcg-support-helpers.h\"\n";
+    OutSource << "#include \"exec/helper-proto-common.h\"\n";
+    OutSource << "#include \"exec/helper-proto.h.inc\"\n";
+    OutSource << "#include \"exec/helper-gen-common.h\"\n";
+    OutSource << "#include \"exec/helper-gen.h.inc\"\n\n";
+
+    const uint8_t Sizes[] = {8, 16, 32, 64};
+
+    for (uint8_t Size : Sizes) {
+        emitVectorIndex(OutSource, VL, Size);
+    }
+
+    for (uint8_t SmallSize : Sizes) {
+        for (uint8_t LargeSize : Sizes) {
+            if (SmallSize >= LargeSize) {
+                continue;
+            }
+            emitVectorSizeChangeHelper(OutSource, OutHeader, "trunc", "uint",
+                                       LargeSize, SmallSize);
+            emitVectorSizeChangeHelper(OutSource, OutHeader, "zext", "uint",
+                                       SmallSize, LargeSize);
+            emitVectorSizeChangeHelper(OutSource, OutHeader, "sext", "int",
+                                       SmallSize, LargeSize);
+        }
+    }
+}
+
+void emitHelperGen(raw_ostream &Out, StringRef Name, Type *ReturnTy,
+                   ArrayRef<Type *> ArgTys) {
+    // Given LLVM Type produce the corresponding TCG type that would be expected
+    // as a helper argument.
+    auto emitType = [&](Type *Ty) {
+        switch (Ty->getTypeID()) {
+        case Type::IntegerTyID: {
+            auto IntTy = cast<IntegerType>(Ty);
+            auto Size = ValueSize::fromLlvmType(IntTy);
+            assert(Size);
+            Out << "TCGv_i" << (int)Size->TcgBitWidth;
+            return true;
+        }
+        case Type::PointerTyID: {
+            Out << "TCGv_ptr";
+            return true;
+        }
+        default:
+            return false;
+        };
+    };
+
+    // Given LLVM Type and name string produce the neccessary `TCGv` to
+    // `TCGTemp` conversion expeted by `tcg_gen_callN`.
+    auto emitTemp = [&](Type *Ty, StringRef str) {
+        switch (Ty->getTypeID()) {
+        case Type::IntegerTyID: {
+            auto IntTy = cast<IntegerType>(Ty);
+            auto Size = ValueSize::fromLlvmType(IntTy);
+            assert(Size);
+            Out << "tcgv_i" << (int)Size->TcgBitWidth << "_temp(" << str << ")";
+        } break;
+        case Type::PointerTyID: {
+            Out << "tcgv_ptr_temp(" << str << ")";
+        } break;
+        default:
+            Out << "NULL";
+            break;
+        };
+    };
+
+    Out << "extern TCGHelperInfo helper_info_" << Name << ";\n";
+    Out << "static inline void gen_helper_" << Name << "(";
+
+    bool HasRet = emitType(ReturnTy);
+    if (HasRet) {
+        Out << " ret";
+    }
+    for (int i = 0; i < ArgTys.size(); ++i) {
+        if (HasRet or i > 0) {
+            Out << ", ";
+        }
+        assert(emitType(ArgTys[i]));
+        Out << " a" << i;
+    }
+    Out << ")\n{\n";
+
+    Out << "tcg_gen_call" << ArgTys.size() << "(helper_info_" << Name << ".func"
+        << ", &helper_info_" << Name << ", ";
+
+    emitTemp(ReturnTy, "ret");
+    for (int i = 0; i < ArgTys.size(); ++i) {
+        Out << ", ";
+        emitTemp(ArgTys[i], Twine("a").concat(Twine(i)).str());
+    }
+    Out << ");\n";
+    Out << "}\n";
+}
diff --git a/subprojects/helper-to-tcg/src/TcgGenPass/TcgEmit.hpp b/subprojects/helper-to-tcg/src/TcgGenPass/TcgEmit.hpp
new file mode 100644
index 0000000000..26d0ba2afe
--- /dev/null
+++ b/subprojects/helper-to-tcg/src/TcgGenPass/TcgEmit.hpp
@@ -0,0 +1,315 @@
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
+#include "TcgType.hpp"
+
+#include <llvm/ADT/StringRef.h>
+#include <llvm/ADT/Twine.h>
+#include <llvm/IR/InstrTypes.h> // for CmpInst::Predicate
+#include <llvm/IR/Instruction.h>
+#include <llvm/IR/Value.h>
+#include <llvm/Support/raw_ostream.h>
+
+#include <string>
+
+using llvm::CmpInst;
+using llvm::Instruction;
+using llvm::raw_ostream;
+using llvm::SmallVector;
+using llvm::StringRef;
+using llvm::Twine;
+using llvm::Type;
+using llvm::Value;
+
+class CEmitter;
+
+struct VectorLayout;
+
+inline std::string getName(const TcgV &V) {
+    if (!V.Name.empty() or V.ConstantExpression) {
+        return V.Name;
+    } else {
+        switch (V.Kind) {
+        case IrImmediate:
+            return (!V.Name.empty()) ? V.Name
+                                     : Twine("imm").concat(Twine(V.Id)).str();
+        case IrValue:
+            return Twine("tmp").concat(Twine(V.Id)).str();
+        case IrPtr:
+            return Twine("ptr").concat(Twine(V.Id)).str();
+        case IrPtrToOffset:
+            return Twine("vec").concat(Twine(V.Id)).str();
+        case IrLabel:
+            return Twine("label").concat(Twine(V.Id)).str();
+        default:
+            abort();
+        };
+    }
+}
+
+// Small helper class to construct `Twine`s on the stack.
+template <size_t N> class StackTwine {
+    llvm::SmallString<N> Str;
+
+  public:
+    StackTwine() = delete;
+    StackTwine(Twine &&T) { T.toVector(Str); }
+    operator StringRef() { return Str; }
+};
+
+class TcgEmitter {
+    raw_ostream &Out;
+    CEmitter &C;
+    size_t AllocatedVectorMemory = 0;
+    size_t NumVectorInstructions = 0;
+    bool EmittedVectorMem = false;
+
+    void genVecUnaryCall(StringRef Name, int ElementSize, const TcgV &Dst,
+                         const TcgV &Src, const TcgV &Size);
+    void genVecBinaryCall(StringRef Name, int ElementSize, const TcgV &Dst,
+                          const TcgV &Src0, const TcgV &Src1, size_t Size);
+    void genVecCall(StringRef Name, llvm::ArrayRef<const TcgV> Args,
+                    const VectorSize OpSize, const VectorSize MaxSize);
+    void genVecSizeChange(StringRef Name, uint8_t DstElementBits,
+                          const TcgV &Dst, const TcgV &Src);
+
+  public:
+    bool NeedVectorSizeChangeOps = false;
+
+    TcgEmitter(raw_ostream &Out, CEmitter &C) : Out(Out), C(C) {}
+
+    inline size_t allocatedVectorMemory() const {
+        return AllocatedVectorMemory;
+    }
+    inline size_t numVectorInstructions() const {
+        return NumVectorInstructions;
+    }
+
+    const TcgV getGlobalEnv() {
+        return TcgV::makeConstantExpression("tcg_env", {}, IrPtr);
+    }
+
+    const TcgV getDisasContext() {
+        return TcgV::makeConstantExpression("ctx", {}, IrPtr);
+    }
+
+    // String representation of types
+    const std::string getType(const TcgV &Value);
+
+    inline const TcgV materialize(const TcgV &Value) {
+        if (Value.Kind != IrImmediate) {
+            return Value;
+        }
+        TcgV M = Value;
+        M.Name = Twine("tcg_constant_i")
+                     .concat(Twine((int)Value.tcgBitWidth()))
+                     .concat("(")
+                     .concat(getName(Value))
+                     .concat(")")
+                     .str();
+        M.Kind = IrValue;
+        return M;
+    }
+
+    template <typename I> void emitArgListTcg(const I Beg, const I End) {
+        auto It = Beg;
+        if (It != End) {
+            Out << getName(*It);
+            ++It;
+        }
+        while (It != End) {
+            Out << ", " << getName(*It);
+            ++It;
+        }
+    }
+
+    template <typename I>
+    void emitCall(const StringRef S, const I Beg, const I End) {
+        Out << S << '(';
+        auto It = Beg;
+        if (It != End) {
+            Out << *It;
+            ++It;
+        }
+        while (It != End) {
+            Out << ", " << *It;
+            ++It;
+        }
+        Out << ");\n";
+    }
+
+    template <typename Iterator>
+    void emitCallTcg(const StringRef S, Iterator Begin, Iterator End) {
+        assert(Begin != End);
+        Out << S << '(';
+        Out << getName(*Begin);
+        ++Begin;
+        while (Begin != End) {
+            Out << ", " << getName(*Begin);
+            ++Begin;
+        }
+        Out << ");\n";
+    }
+
+    inline void emitArgListTcg(const std::initializer_list<TcgV> Args) {
+        emitArgListTcg(Args.begin(), Args.end());
+    }
+
+    inline void emitCall(const StringRef S,
+                         const std::initializer_list<StringRef> Args) {
+        emitCall(S, Args.begin(), Args.end());
+    }
+
+    inline void emitCallTcg(StringRef S, std::initializer_list<TcgV> Args) {
+        emitCallTcg(S, Args.begin(), Args.end());
+    }
+
+    inline void genCallHelper(const StringRef Helper,
+                              const std::initializer_list<TcgV> Args) {
+        auto Func = Twine("gen_").concat(Helper).str();
+        emitCallTcg(Func, Args);
+    }
+
+    template <typename I>
+    void genCallHelper(const StringRef Helper, I Beg, I End) {
+        auto Func = Twine("gen_").concat(Helper).str();
+        emitCallTcg(Func, Beg, End);
+    }
+
+    template <typename I>
+    void genCallCFunc(const StringRef Name, TcgV Ret, I Beg, I End) {
+        if (Ret.Kind != IrInvalid) {
+            Out << getName(Ret) << " = ";
+        }
+        emitCallTcg(Name, Beg, End);
+    }
+
+    void genNewLabel();
+    void genSetLabel(const TcgV &L);
+
+    void defineNewTemp(const TcgV &Tcg);
+
+    void genBr(const TcgV &L);
+
+    void genExts(const TcgV &Dst, const TcgV &Src);
+    void genExtI32I64(const TcgV &Dst, const TcgV &Src);
+    void genExtrlI64I32(const TcgV &Dst, const TcgV &Src);
+    void genExtuI32I64(const TcgV &Dst, const TcgV &Src);
+    void genExtrhI64I32(const TcgV &Dst, const TcgV &Src);
+    void genExtract(bool Sign, const TcgV &Dst, const TcgV &Src,
+                    const TcgV &Offset, const TcgV &Length);
+    void genDeposit(const TcgV &Dst, const TcgV &Into, const TcgV &From,
+                    const TcgV &Offset, const TcgV &Length);
+
+    void genPtrToValue(const TcgV &Dst, const TcgV &Src);
+    void genValueToPtr(const TcgV &Dst, const TcgV &Src);
+
+    void genConcat(const TcgV &Dst, const TcgV &Src1, const TcgV &Src2);
+    void genMov(const TcgV &Dst, const TcgV &Src);
+    void genMovPtr(const TcgV &Dst, const TcgV &Src);
+    void genAddPtr(const TcgV &Dst, const TcgV &Ptr, const TcgV &Offset);
+    void genBinOp(const TcgV &Dst, const Instruction::BinaryOps Opcode,
+                  const TcgV &Src0, const TcgV &Src1);
+    void genMovcond(const CmpInst::Predicate &Pred, const TcgV &Ret,
+                    const TcgV &C1, const TcgV &C2, const TcgV &V1,
+                    const TcgV &V2);
+    void genSetcond(const CmpInst::Predicate &Pred, const TcgV &Dst,
+                    const TcgV &Op1, const TcgV &Op2);
+    void genBrcond(const CmpInst::Predicate &Pred, const TcgV &Arg1,
+                   const TcgV &Arg2, const TcgV &Label);
+
+    std::string getMemOp(uint8_t Size, uint8_t Endianness, uint8_t Sign);
+    void genGuestLoad(const TcgV &Dst, const TcgV &Ptr, StringRef MemOp);
+    void genGuestStore(const TcgV &Ptr, const TcgV &Src, StringRef MemOp);
+    void genHostLoad(const TcgV &Dst, const TcgV &Ptr, const TcgV &Offset);
+    void genHostLoadFromVec(const TcgV &Dst, const TcgV &Offset);
+    void genHostStore(const TcgV &Ptr, const TcgV &Src);
+
+    void genFunnelShl(const TcgV &Dst, const TcgV &Src0, const TcgV &Src1,
+                      const TcgV &Shift);
+    void genBitreverse(const TcgV &Dst, const TcgV &Src);
+    void genAbs(const TcgV &Dst, const TcgV &Src);
+    void genCountLeadingZeros(const TcgV &Dst, const TcgV &Src);
+    void genCountTrailingZeros(const TcgV &Dst, const TcgV &Src);
+    void genCountOnes(const TcgV &Dst, const TcgV &Src);
+    void genByteswap(const TcgV &Dst, const TcgV &Src);
+    void genUnsignedSatSub(const TcgV &Dst, const TcgV &Src0, const TcgV &Src1);
+
+    // Vector ops.
+    void genVecBinOpStr(StringRef Op, const TcgV &Dst, const TcgV &Src0,
+                        const TcgV &Src1);
+    void genVecBinOp(const Instruction::BinaryOps Opcode, const TcgV &Dst,
+                     const TcgV &Src0, const TcgV &Src1);
+    void genVecOrScalarBinOp(StringRef Op, const TcgV &Dst, const TcgV &Src0,
+                             const TcgV &Src1);
+    void genVecSignedSatAdd(const TcgV &Dst, const TcgV &Src0,
+                            const TcgV &Src1);
+    void genVecSignedSatSub(const TcgV &Dst, const TcgV &Src0,
+                            const TcgV &Src1);
+    void genVecUnsignedSatSub(const TcgV &Dst, const TcgV &Src0,
+                              const TcgV &Src1);
+    void genVecSignedMax(const TcgV &Dst, const TcgV &Src0, const TcgV &Src1);
+    void genVecUnsignedMax(const TcgV &Dst, const TcgV &Src0, const TcgV &Src1);
+    void genVecSignedMin(const TcgV &Dst, const TcgV &Src0, const TcgV &Src1);
+    void genVecUnsignedMin(const TcgV &Dst, const TcgV &Src0, const TcgV &Src1);
+    void genVecMemcpy(const TcgV &Dst, const TcgV &Src, const TcgV &Size);
+    void genVecMemset(const TcgV &Dst, const TcgV &Src, const TcgV &Size);
+    void genVecSplat(const TcgV &Dst, const TcgV &Src);
+    void genVecArrSplat(const TcgV &Dst, const TcgV &Src);
+    void genVecBitsel(const TcgV &Dst, const TcgV &Cond, const TcgV &Src0,
+                      const TcgV &Src1);
+    void genVecCmp(const TcgV &Dst, const CmpInst::Predicate &Pred,
+                   const TcgV &Src0, const TcgV &Src1);
+    void genVecNot(const TcgV &Dst, const TcgV &Src);
+    void genVecTrunc(uint8_t DstElementBits, const TcgV &Dst, const TcgV &Src);
+    void genVecSext(uint8_t DstElementBits, const TcgV &Dst, const TcgV &Src);
+    void genVecZext(uint8_t DstElementBits, const TcgV &Dst, const TcgV &Src);
+};
+
+class CEmitter {
+    std::string mapBinOp(const Instruction::BinaryOps &Opcode, const TcgV &Src0,
+                         const TcgV &Src1);
+
+  public:
+    CEmitter() {}
+
+    std::string intType(bool Signed, uint8_t LlvmSize);
+    TcgV ptrAdd(const TcgV &Ptr, const TcgV &Offset);
+    TcgV ternary(const TcgV &Cond, const TcgV &True, const TcgV &False);
+    TcgV deref(const TcgV &Ptr, ValueSize Size);
+    TcgV compare(const CmpInst::Predicate &Pred, const TcgV &Src0,
+                 const TcgV &Src1);
+    TcgV extend(bool Signed, const TcgV &V, ValueSize Size);
+    TcgV binop(Instruction::BinaryOps Opcode, const TcgV &Src0,
+               const TcgV &Src1);
+};
+
+// The below function deal with a lot of code generation that we expect to be
+// present in the output.
+
+// Emits `VectorMem` struct definition along with allocation funcs needed for
+// producing vector temporaries.
+void emitVectorMem(raw_ostream &Out);
+// Emit `gen_vec_zext*()` and friends for performing vector size changing
+// operations, taking target vector layout into account.
+void emitVectorSizeChangeOps(raw_ostream &OutSource, raw_ostream &OutHeader,
+                             const VectorLayout &VL);
+// Emits gen_helper_*() definition for helpers that failed to translate.
+void emitHelperGen(raw_ostream &Out, StringRef Name, Type *ReturnTy,
+                   llvm::ArrayRef<Type *> ArgTys);
-- 
2.52.0


