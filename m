Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E3DD743FD
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwHi-0001Xs-Qr; Wed, 20 Nov 2024 20:47:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHh-0001Wb-7z
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:05 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHd-0004WB-Ig
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=ykf5grKsmyxgbZ5tTfN/O7YybWDBo6LXCa3e2xs639g=; b=FZ8Hkca4x6ZTlwz
 EUFDklRYtIWXA6UPtidPRGHmlG43iDSTGVvYvQX3YI1yoVAjWEcSUOVycs27BEb4YCZcizd3ckkky
 FtL59DuwPGWZdpHHOWoRU2U6yMEyG/NHOw9WPg8TX41qUdFqndPY+oEw9TSB08guT1tkOMd1QXfrW
 H0=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 00/43] Introduce helper-to-tcg
Date: Thu, 21 Nov 2024 02:49:04 +0100
Message-ID: <20241121014947.18666-1-anjo@rev.ng>
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

Hi all, this patchset introduces helper-to-tcg, a LLVM based build-time
C to TCG translator, as a QEMU subproject.  The purpose of this tool is
to simplify implementation of instructions in TCG by automatically
translating helper functions for a given target to TCG.  It may also be
used as a standalone tool for getting a base TCG implementation for
complicated instructions.

See KVM forum 2023 presentation: https://www.youtube.com/watch?v=Gwz0kp7IZPE

helper-to-tcg is also applied to the Hexagon frontend, managing to
translate 1270 instructions, 160 of which are HVX instructions.  For the
time being, idef-parser remains translating 289 instructions consisting
mostly of complicated load instructions.  This count will be reduced
over time until idef-parser can be deprecated.

As an example, consider the following helper function implementation of
a Hexagon instruction for performing a 2-element scalar product, using
signed saturated arithmetic

  void HELPER(V6_vdmpyhvsat)(CPUHexagonState *env,
                             void * restrict VdV_void,
                             void * restrict VuV_void,
                             void * restrict VvV_void)
  {
      fVFOREACH(32, i) {
          size8s_t accum = fMPY16SS(fGETHALF(0,VuV.w[i]),fGETHALF(0, VvV.w[i]));
          accum += fMPY16SS(fGETHALF(1,VuV.w[i]),fGETHALF(1, VvV.w[i]));
          VdV.w[i] = fVSATW(accum);
      }
  }

which at the end of the helper-to-tcg pipeline will have been converted
to the following LLVM IR

  define void @helper_V6_vdmpyhvsat(%struct.CPUArchState* %0,
                                    i8* %1, i8* %2, i8* %3) {
      %4 = bitcast i8* %2 to <32 x i32>*
      %wide.load = load <32 x i32>, <32 x i32>* %4
      %5 = call <32 x i32> @VecShlScalar(<32 x i32> %wide.load, i32 16)
      %6 = call <32 x i32> @VecAShrScalar(<32 x i32> %5, i32 16)
      %7 = bitcast i8* %3 to <32 x i32>*
      %wide.load23 = load <32 x i32>, <32 x i32>* %7
      %8 = call <32 x i32> @VecShlScalar(<32 x i32> %wide.load23, i32 16)
      %9 = call <32 x i32> @VecAShrScalar(<32 x i32> %8, i32 16)
      %10 = mul nsw <32 x i32> %9, %6
      %11 = call <32 x i32> @VecAShrScalar(<32 x i32> %wide.load, i32 16)
      %12 = call <32 x i32> @VecAShrScalar(<32 x i32> %wide.load23, i32 16)
      %13 = mul nsw <32 x i32> %12, %11
      %14 = bitcast i8* %1 to <32 x i32>*
      ret void
  }

which, in TCG, gets emitted as

  void emit_V6_vdmpyhvsat(TCGv_env env, intptr_t vec3,
                          intptr_t vec7, intptr_t vec6) {
      VectorMem mem = {0};
      intptr_t vec0 = temp_new_gvec(&mem, 128);
      tcg_gen_gvec_shli(MO_32, vec0, vec7, 16, 128, 128);
      intptr_t vec5 = temp_new_gvec(&mem, 128);
      tcg_gen_gvec_sari(MO_32, vec5, vec0, 16, 128, 128);
      intptr_t vec1 = temp_new_gvec(&mem, 128);
      tcg_gen_gvec_shli(MO_32, vec1, vec6, 16, 128, 128);
      tcg_gen_gvec_sari(MO_32, vec1, vec1, 16, 128, 128);
      tcg_gen_gvec_mul(MO_32, vec1, vec1, vec5, 128, 128);
      intptr_t vec2 = temp_new_gvec(&mem, 128);
      tcg_gen_gvec_sari(MO_32, vec2, vec7, 16, 128, 128);
      tcg_gen_gvec_sari(MO_32, vec0, vec6, 16, 128, 128);
      tcg_gen_gvec_mul(MO_32, vec2, vec0, vec2, 128, 128);
      tcg_gen_gvec_ssadd(MO_32, vec3, vec1, vec2, 128, 128);
  }

consisting of a few vectorized shifts, multiplications, and a signed
saturated add.

For a more in-depth usage guide see `subprojects/helper-to-tcg/README.md`.

Limitations:
  * Currently LLVM versions 10-14 are supported, with support for 15+
    being in the works.

  * Exceeding TB size, for complicated vector instructions with a large
    amount of gvec instrucions, the TB size of 128 longs can sometimes
    be exceeded. Particularly on Hexagon with instruction packets.

  * Does not handle functions with multiple return values. On Hexagon,
    a large set of instructions still translated by idef-parser fall
    into this category.

Patchset overview:
  1. helper-to-tcg (patches 9-31) - Introduces the actual translator as
     a QEMU subproject.

  2. Fills gaps in TCG instructions (patches 2,3,4) - Since the tool is
     LLVM based it allows for translation of vector instructions to gvec
     instructions in Tinycode. This requires the introduction of a few
     new tcg_gen_gvec_*() functions for dealing with sign- and
     zero-extension, along with a function for initializing a vector to
     a constant, and functions for bitreversal and funnel shift.

  3. Automatic calling of generated code (patch 5) - To simplify
     integration into existing frontends gen_helper_*() calls for
     non-vector instructions can automatically be hooked to call emitted
     code for translated helper functions.  This works by allowing
     targets to define a "helper_dispatcher" function that gets called
     from tcg_gen_callN(), and can override helper function calls.
     helper-to-tcg can emit such a dispatcher which calls generated
     code.

  4. Mapping of cpu state (patch 6) - helper-to-tcg needs information
     about the offsets of fields in the cpu state that correspond to TCG
     globals, so these can be emitted in the output code.  For this
     purpose, a target may define an array of `struct cpu_tcg_mapping`
     to map fields in the cpu state to TCG globals in a declarative way.
     This global array can be parsed by helper-to-tcg, and replaces
     manually calling tcg_global_mem_new*() in frontend.

  5. Increases max size of generated TB code (patch 7) - Due to the
     power of the LLVM auto-vectorizer, helper-to-tcg can emit quite
     complicated vectorized gvec code.  Particularly for Hexagon where a
     single instruction packet can consist of multiple vector
     instructions.  A single instruction packet can in rare cases exceed
     the TB buffer size of 128 longs.

  6. Applies helper-to-tcg to Hexagon (patches 34-43) - helper-to-tcg is
     used on the Hexagon frontend to translate a majority of helper
     functions in place of idef-parser.  For the time being idef-parser
     will remain in use to translate instructions with multiple return
     values that are not representable as helper functions and therefore
     translatable with helper-to-tcg.

Anton Johansson (43):
  Add option to enable/disable helper-to-tcg
  accel/tcg: Add bitreverse and funnel-shift runtime helper functions
  accel/tcg: Add gvec size changing operations
  tcg: Add gvec functions for creating consant vectors
  tcg: Add helper function dispatcher and hook tcg_gen_callN
  tcg: Introduce tcg-global-mappings
  tcg: Increase maximum TB size and maximum temporaries
  include/helper-to-tcg: Introduce annotate.h
  helper-to-tcg: Introduce get-llvm-ir.py
  helper-to-tcg: Add meson.build
  helper-to-tcg: Introduce llvm-compat
  helper-to-tcg: Introduce custom LLVM pipeline
  helper-to-tcg: Introduce Error.h
  helper-to-tcg: Introduce PrepareForOptPass
  helper-to-tcg: PrepareForOptPass, map annotations
  helper-to-tcg: PrepareForOptPass, Cull unused functions
  helper-to-tcg: PrepareForOptPass, undef llvm.returnaddress
  helper-to-tcg: PrepareForOptPass, Remove noinline attribute
  helper-to-tcg: Pipeline, run optimization pass
  helper-to-tcg: Introduce pseudo instructions
  helper-to-tcg: Introduce PrepareForTcgPass
  helper-to-tcg: PrepareForTcgPass, remove functions w. cycles
  helper-to-tcg: PrepareForTcgPass, demote phi nodes
  helper-to-tcg: PrepareForTcgPass, map TCG globals
  helper-to-tcg: PrepareForTcgPass, transform GEPs
  helper-to-tcg: PrepareForTcgPass, canonicalize IR
  helper-to-tcg: PrepareForTcgPass, identity map trivial expressions
  helper-to-tcg: Introduce TcgType.h
  helper-to-tcg: Introduce TCG register allocation
  helper-to-tcg: TcgGenPass, introduce TcgEmit.[cpp|h]
  helper-to-tcg: Introduce TcgGenPass
  helper-to-tcg: Add README
  helper-to-tcg: Add end-to-end tests
  target/hexagon: Add get_tb_mmu_index()
  target/hexagon: Use argparse in all python scripts
  target/hexagon: Add temporary vector storage
  target/hexagon: Make HVX vector args. restrict *
  target/hexagon: Use cpu_mapping to map env -> TCG
  target/hexagon: Keep gen_slotval/check_noshuf for helper-to-tcg
  target/hexagon: Emit annotations for helpers
  target/hexagon: Manually call generated HVX instructions
  target/hexagon: Only translate w. idef-parser if helper-to-tcg failed
  target/hexagon: Use helper-to-tcg

 accel/tcg/tcg-runtime-gvec.c                  |   41 +
 accel/tcg/tcg-runtime.c                       |   29 +
 accel/tcg/tcg-runtime.h                       |   27 +
 accel/tcg/translate-all.c                     |    4 +
 include/helper-to-tcg/annotate.h              |   28 +
 include/tcg/tcg-global-mappings.h             |  111 +
 include/tcg/tcg-op-gvec-common.h              |   20 +
 include/tcg/tcg.h                             |    8 +-
 meson.build                                   |    7 +
 meson_options.txt                             |    2 +
 scripts/meson-buildoptions.sh                 |    5 +
 subprojects/helper-to-tcg/README.md           |  265 +++
 subprojects/helper-to-tcg/get-llvm-ir.py      |  143 ++
 .../helper-to-tcg/include/CmdLineOptions.h    |   38 +
 subprojects/helper-to-tcg/include/Error.h     |   40 +
 .../include/FunctionAnnotation.h              |   54 +
 .../helper-to-tcg/include/PrepareForOptPass.h |   42 +
 .../helper-to-tcg/include/PrepareForTcgPass.h |   32 +
 .../helper-to-tcg/include/TcgGlobalMap.h      |   31 +
 subprojects/helper-to-tcg/meson.build         |   84 +
 subprojects/helper-to-tcg/meson_options.txt   |    2 +
 .../PrepareForOptPass/PrepareForOptPass.cpp   |  260 +++
 .../PrepareForTcgPass/CanonicalizeIR.cpp      | 1000 +++++++++
 .../passes/PrepareForTcgPass/CanonicalizeIR.h |   25 +
 .../passes/PrepareForTcgPass/IdentityMap.cpp  |   80 +
 .../passes/PrepareForTcgPass/IdentityMap.h    |   39 +
 .../PrepareForTcgPass/PrepareForTcgPass.cpp   |  134 ++
 .../PrepareForTcgPass/TransformGEPs.cpp       |  286 +++
 .../passes/PrepareForTcgPass/TransformGEPs.h  |   37 +
 .../helper-to-tcg/passes/PseudoInst.cpp       |  142 ++
 subprojects/helper-to-tcg/passes/PseudoInst.h |   63 +
 .../helper-to-tcg/passes/PseudoInst.inc       |   76 +
 .../helper-to-tcg/passes/backend/TcgEmit.cpp  | 1074 ++++++++++
 .../helper-to-tcg/passes/backend/TcgEmit.h    |  290 +++
 .../passes/backend/TcgGenPass.cpp             | 1812 +++++++++++++++++
 .../helper-to-tcg/passes/backend/TcgGenPass.h |   57 +
 .../passes/backend/TcgTempAllocationPass.cpp  |  594 ++++++
 .../passes/backend/TcgTempAllocationPass.h    |   79 +
 .../helper-to-tcg/passes/backend/TcgType.h    |  133 ++
 .../helper-to-tcg/passes/llvm-compat.cpp      |  162 ++
 .../helper-to-tcg/passes/llvm-compat.h        |  143 ++
 .../helper-to-tcg/pipeline/Pipeline.cpp       |  297 +++
 subprojects/helper-to-tcg/tests/cpustate.c    |   45 +
 subprojects/helper-to-tcg/tests/ldst.c        |   17 +
 subprojects/helper-to-tcg/tests/meson.build   |   24 +
 subprojects/helper-to-tcg/tests/scalar.c      |   15 +
 .../helper-to-tcg/tests/tcg-global-mappings.h |  115 ++
 subprojects/helper-to-tcg/tests/vector.c      |   26 +
 target/hexagon/cpu.h                          |   16 +
 target/hexagon/gen_analyze_funcs.py           |    6 +-
 target/hexagon/gen_decodetree.py              |   19 +-
 target/hexagon/gen_helper_funcs.py            |   24 +-
 target/hexagon/gen_helper_protos.py           |    9 +-
 target/hexagon/gen_idef_parser_funcs.py       |   17 +-
 target/hexagon/gen_op_attribs.py              |   11 +-
 target/hexagon/gen_opcodes_def.py             |   11 +-
 target/hexagon/gen_printinsn.py               |   11 +-
 target/hexagon/gen_tcg_func_table.py          |   11 +-
 target/hexagon/gen_tcg_funcs.py               |   24 +-
 target/hexagon/gen_trans_funcs.py             |   17 +-
 target/hexagon/genptr.c                       |    2 +-
 target/hexagon/hex_common.py                  |  138 +-
 target/hexagon/meson.build                    |  151 +-
 target/hexagon/mmvec/macros.h                 |   36 +-
 target/hexagon/op_helper.c                    |    3 +-
 target/hexagon/translate.c                    |  116 +-
 tcg/meson.build                               |    1 +
 tcg/tcg-global-mappings.c                     |   61 +
 tcg/tcg-op-gvec.c                             |  108 +
 tcg/tcg.c                                     |    5 +
 70 files changed, 8662 insertions(+), 173 deletions(-)
 create mode 100644 include/helper-to-tcg/annotate.h
 create mode 100644 include/tcg/tcg-global-mappings.h
 create mode 100644 subprojects/helper-to-tcg/README.md
 create mode 100755 subprojects/helper-to-tcg/get-llvm-ir.py
 create mode 100644 subprojects/helper-to-tcg/include/CmdLineOptions.h
 create mode 100644 subprojects/helper-to-tcg/include/Error.h
 create mode 100644 subprojects/helper-to-tcg/include/FunctionAnnotation.h
 create mode 100644 subprojects/helper-to-tcg/include/PrepareForOptPass.h
 create mode 100644 subprojects/helper-to-tcg/include/PrepareForTcgPass.h
 create mode 100644 subprojects/helper-to-tcg/include/TcgGlobalMap.h
 create mode 100644 subprojects/helper-to-tcg/meson.build
 create mode 100644 subprojects/helper-to-tcg/meson_options.txt
 create mode 100644 subprojects/helper-to-tcg/passes/PrepareForOptPass/PrepareForOptPass.cpp
 create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/CanonicalizeIR.cpp
 create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/CanonicalizeIR.h
 create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/IdentityMap.cpp
 create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/IdentityMap.h
 create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/PrepareForTcgPass.cpp
 create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/TransformGEPs.cpp
 create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/TransformGEPs.h
 create mode 100644 subprojects/helper-to-tcg/passes/PseudoInst.cpp
 create mode 100644 subprojects/helper-to-tcg/passes/PseudoInst.h
 create mode 100644 subprojects/helper-to-tcg/passes/PseudoInst.inc
 create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgEmit.cpp
 create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgEmit.h
 create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgGenPass.cpp
 create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgGenPass.h
 create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgTempAllocationPass.cpp
 create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgTempAllocationPass.h
 create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgType.h
 create mode 100644 subprojects/helper-to-tcg/passes/llvm-compat.cpp
 create mode 100644 subprojects/helper-to-tcg/passes/llvm-compat.h
 create mode 100644 subprojects/helper-to-tcg/pipeline/Pipeline.cpp
 create mode 100644 subprojects/helper-to-tcg/tests/cpustate.c
 create mode 100644 subprojects/helper-to-tcg/tests/ldst.c
 create mode 100644 subprojects/helper-to-tcg/tests/meson.build
 create mode 100644 subprojects/helper-to-tcg/tests/scalar.c
 create mode 100644 subprojects/helper-to-tcg/tests/tcg-global-mappings.h
 create mode 100644 subprojects/helper-to-tcg/tests/vector.c
 create mode 100644 tcg/tcg-global-mappings.c

-- 
2.45.2


