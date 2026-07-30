Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32125C55160
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH5q-0001k4-VI; Wed, 29 Jul 2026 23:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH5l-0001ir-VO
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:05:53 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH5h-0002qR-Ac
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=czmrQgG4GPVicbTVj/UMFOqF3cvuZV/PLt+U0uytbNY=; b=F5f9rLrwo3unS6x
 4dVYJYIH+y9eOwdy6tgbF4hP8Pj8+izLL3sIALm9Gqk6DHTgR752oZpmjV9cS5zBVU4evolgvt1c3
 vMlaMtVa364NdZ6u1aPmltZS09PNLdkeeU0gAelXIjoPYqR2GaxrX2sVTgcOAzPY/I7KdORt8DjJo
 LM=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 00/50] Introduce helper-to-tcg
Date: Thu, 30 Jul 2026 05:09:34 +0200
Message-ID: <20260730031025.12926-1-anjo@rev.ng>
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

Hi all, this patchset introduces helper-to-tcg, a LLVM based build-time
C to TCG translator, as a QEMU subproject.  The purpose of this tool is
to simplify implementation of instructions in TCG by automatically
translating helper functions for a given target to TCG.  It may also be
used as a standalone tool for getting a base TCG implementation for
complicated instructions.

See KVM forum 2023 and 2025 presentations which give an overview of its
application to Hexagon and RISCV: 

  - https://www.youtube.com/watch?v=Gwz0kp7IZPE
  - https://www.youtube.com/watch?v=7qIwraM3-4I

helper-to-tcg is also applied to the Hexagon frontend, managing to
translate 1280 instructions, 162 of which are HVX instructions.  In the current
patchset we translate 1240 instructions due to limiting emission of the heavier
vectorized instructions which requires larger TBs and more vector temporaries.
For the time being, idef-parser remains translating 281 instructions consisting
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
  - Does not handle functions with multiple return values. On Hexagon,
    a large set of instructions still translated by idef-parser fall
    into this category.

  - Can emit complicated vector operations that are not the most
    host-friendly, identifying and emitting custom GVec patterns would
    be interesting.

Patchset overview:
  1. helper-to-tcg (patches 6-40) - Introduces the actual translator as
     a QEMU subproject.

  2. Fills gaps in TCG instructions (patches 1,2,5) - Since the tool is
     LLVM based it allows for translation of vector instructions to gvec
     instructions in Tinycode. This requires the introduction of a few
     new tcg_gen_gvec_*() functions for dealing with sign- and
     zero-extension, along with a function for initializing a vector to
     a constant, and functions for bitreversal and funnel shift.

  3. Mapping of cpu state (patch 3) - helper-to-tcg needs information
     about the offsets of fields in the cpu state that correspond to TCG
     globals, so these can be emitted in the output code.  For this
     purpose, a target may define an array of `struct cpu_tcg_mapping`
     to map fields in the cpu state to TCG globals in a declarative way.
     This global array can be parsed by helper-to-tcg, and replaces
     manually calling tcg_global_mem_new*() in frontend.

  4. Increases max size of generated TB code (patch 4) - Due to the
     power of the LLVM auto-vectorizer, helper-to-tcg can emit quite
     complicated vectorized gvec code.  Particularly for Hexagon where a
     single instruction packet can consist of multiple vector
     instructions.  A single instruction packet can in rare cases exceed
     the TB buffer size of 128 longs.

  5. Applies helper-to-tcg to Hexagon (patches 41-50) - helper-to-tcg is
     used on the Hexagon frontend to translate a majority of helper
     functions in place of idef-parser.  For the time being idef-parser
     will remain in use to translate instructions with multiple return
     values that are not representable as helper functions and therefore
     translatable with helper-to-tcg.

Changes in v2:
  - Use QEMU_ANNOTATE over introducing LLVM_ANNOTATE (Philippe);
  - Move .h -> .hpp to avoid checkpatch (Philppe);
  - Meson changes (Paolo);
  - Gvec size changing operations (zext/sext/trunc) along with constant
    vector creation has been moved from general gvec operations to being
    emitted by helper-to-tcg on demand. A simple interface for specifying
    the target vector layout is available through commandline
    options (Richard);
  - Constant vectors initialized from arrays now vectorized;
  - Introduced a model of target vector layouts;
  - Shifted LLVM version support from 10-14 to 15-21;
  - Improved end-to-end testing, now verifies output across LLVM versions,
    currently these tests along with their expected output serve as usage
    examples;
  - Added docker tests for supported LLVM versions;
  - Dropped the tcg_gen_callN dispatcher in favour of emitting gen_helper_*()
    definitions directly;
  - Optionally allow calls to declarations, custom jump instructions, and propagation of
    DisasContext to better slot into existing frontends;
  - Limit vector usage for hexagon to 8 temporaries and 16 gvec
    instructions, also use existing `tmp_VRegs[]` memory.
  - Many cleanups and bugfixes.

Anton Johansson (50):
  accel/tcg: Add bitreverse and funnel-shift runtime helper functions
  accel/tcg: Add getpc helper
  tcg: Introduce tcg-global-mappings
  tcg: Increase maximum TB size
  tcg: Expose tcg_gen_ussub_sat()
  Add helper-to-tcg subproject
  helper-to-tcg: Introduce get-llvm-ir.py
  helper-to-tcg: Handle LLVM version compatibility
  helper-to-tcg: Introduce custom LLVM pipeline
  helper-to-tcg: Add pipeline --debug and --debug-only
  helper-to-tcg: Add simple error creation helper
  helper-to-tcg: Introduce PrepareForOptPass
  helper-to-tcg: PrepareForOptPass, demangle function names
  helper-to-tcg: PrepareForOptPass, map annotations
  helper-to-tcg: PrepareForOptPass, cull unused functions
  helper-to-tcg: PrepareForOptPass, undef llvm.returnaddress
  helper-to-tcg: PrepareForOptPass, fixup inline attributes
  helper-to-tcg: PrepareForOptPass, collect debuginfo
  helper-to-tcg: Pipeline, run optimization pass
  helper-to-tcg: Introduce pseudo instructions
  helper-to-tcg: Add guest vector layout description
  helper-to-tcg: Introduce PrepareForTcgPass
  helper-to-tcg: PrepareForTcgPass, remove functions with cycles
  helper-to-tcg: PrepareForTcgPass, demote PHI nodes
  helper-to-tcg: PrepareForTcgPass, map TCG globals
  helper-to-tcg: PrepareForTcgPass, transform GEPs
  helper-to-tcg: PrepareForTcgPass, canonicalize IR
  helper-to-tcg: PrepareForTcgPass, identity map trivial expressions
  helper-to-tcg: Introduce TcgV structure
  helper-to-tcg: Introduce TcgGenPass
  helper-to-tcg: TcgGenPass, linearize basic blocks
  helper-to-tcg: TcgGenPass, introduce Value <-> TcgV map
  helper-to-tcg: TcgGenPass, add structs for string emission
  helper-to-tcg: TcgGenPass, map arguments to TCG
  helper-to-tcg: TcgGenPass, propagate constant expresssions
  helper-to-tcg: TcgGenPass, allocate TCG registers
  helper-to-tcg: TcgGenPass, emit TCG strings
  helper-to-tcg: Add README
  helper-to-tcg: Add end-to-end tests
  test: helper-to-tcg docker tests
  target/hexagon: Add get_tb_mmu_index()
  target/hexagon: Increase VECTOR_TEMPS_MAX
  target/hexagon: Provide env to tcg global mapping
  target/hexagon: Keep gen_slotval/check_noshuf for helper-to-tcg
  target/hexagon: Emit annotations for helpers
  target/hexagon: Split probe_and_commit helper
  target/hexagon: Use helper-to-tcg helper calls
  target/hexagon: Manually call generated HVX instructions
  target/hexagon: Use idef-parser as a fallback
  target/hexagon: Use helper-to-tcg

 accel/tcg/tcg-runtime.c                       |   33 +
 accel/tcg/tcg-runtime.h                       |    8 +
 configs/targets/hexagon-linux-user.mak        |    1 +
 configs/targets/hexagon-softmmu.mak           |    1 +
 include/tcg/tcg-global-mappings.h             |  118 ++
 include/tcg/tcg-op-common.h                   |    2 +
 include/tcg/tcg.h                             |    2 +-
 meson.build                                   |   10 +
 meson_options.txt                             |    2 +
 scripts/meson-buildoptions.sh                 |    5 +
 subprojects/helper-to-tcg/README.md           |  297 ++++
 subprojects/helper-to-tcg/get-llvm-ir.py      |  145 ++
 .../helper-to-tcg/include/CmdLineOptions.hpp  |   46 +
 .../helper-to-tcg/include/DebugInfo.hpp       |   46 +
 subprojects/helper-to-tcg/include/Error.hpp   |   38 +
 .../include/FunctionAnnotation.hpp            |  104 ++
 .../helper-to-tcg/include/LlvmCompat.hpp      |  124 ++
 .../include/PrepareForOptPass.hpp             |   42 +
 .../include/PrepareForTcgPass.hpp             |   37 +
 .../helper-to-tcg/include/PseudoInst.hpp      |   75 +
 .../helper-to-tcg/include/PseudoInst.inc      |   78 ++
 .../helper-to-tcg/include/TcgGenPass.hpp      |   63 +
 .../helper-to-tcg/include/TcgGlobalMap.hpp    |   40 +
 subprojects/helper-to-tcg/include/TcgType.hpp |  276 ++++
 .../helper-to-tcg/include/VectorLayout.hpp    |  116 ++
 subprojects/helper-to-tcg/meson.build         |   86 ++
 subprojects/helper-to-tcg/meson_options.txt   |    2 +
 subprojects/helper-to-tcg/src/LlvmCompat.cpp  |   89 ++
 subprojects/helper-to-tcg/src/Pipeline.cpp    |  399 ++++++
 .../PrepareForOptPass/PrepareForOptPass.cpp   |  363 +++++
 .../src/PrepareForTcgPass/CanonicalizeIR.cpp  | 1193 ++++++++++++++++
 .../src/PrepareForTcgPass/CanonicalizeIR.hpp  |   24 +
 .../src/PrepareForTcgPass/IdentityMap.cpp     |   91 ++
 .../src/PrepareForTcgPass/IdentityMap.hpp     |   39 +
 .../PrepareForTcgPass/PrepareForTcgPass.cpp   |  150 ++
 .../src/PrepareForTcgPass/TransformGEPs.cpp   |  355 +++++
 .../src/PrepareForTcgPass/TransformGEPs.hpp   |   45 +
 subprojects/helper-to-tcg/src/PseudoInst.cpp  |  183 +++
 .../src/TcgGenPass/LinearizeBlocks.cpp        |  140 ++
 .../src/TcgGenPass/LinearizeBlocks.hpp        |   32 +
 .../src/TcgGenPass/MapArguments.cpp           |  122 ++
 .../src/TcgGenPass/MapConstantExpressions.cpp |  328 +++++
 .../src/TcgGenPass/MapTcgOperations.cpp       |  988 ++++++++++++++
 .../src/TcgGenPass/MapTemporaries.cpp         |  619 +++++++++
 .../helper-to-tcg/src/TcgGenPass/TcgEmit.cpp  | 1203 +++++++++++++++++
 .../helper-to-tcg/src/TcgGenPass/TcgEmit.hpp  |  315 +++++
 .../src/TcgGenPass/TcgGenPass.cpp             |  385 ++++++
 .../src/TcgGenPass/ValueMapping.hpp           |  110 ++
 .../helper-to-tcg/tests/call-to-declaration.c |   33 +
 .../helper-to-tcg/tests/call-translation.c    |   35 +
 subprojects/helper-to-tcg/tests/cpustate.c    |   44 +
 .../helper-to-tcg/tests/forward-context.c     |   21 +
 subprojects/helper-to-tcg/tests/ldst.c        |   17 +
 subprojects/helper-to-tcg/tests/meson.build   |  121 ++
 .../tests/ref/15/call-to-declaration.c        |   26 +
 .../tests/ref/15/call-translation.c           |   28 +
 .../helper-to-tcg/tests/ref/15/cpustate.c     |   36 +
 .../tests/ref/15/forward-context.c            |   30 +
 subprojects/helper-to-tcg/tests/ref/15/ldst.c |   21 +
 .../helper-to-tcg/tests/ref/15/scalar.c       |   21 +
 .../tests/ref/15/user-pcrel-jump.c            |   33 +
 .../tests/ref/15/vector-layout-f16L.c         |  527 ++++++++
 .../tests/ref/15/vector-layout-f16M.c         |  527 ++++++++
 .../tests/ref/15/vector-layout-f32L.c         |  527 ++++++++
 .../tests/ref/15/vector-layout-f32M.c         |  527 ++++++++
 .../tests/ref/15/vector-layout-f64L.c         |  527 ++++++++
 .../tests/ref/15/vector-layout-f64M.c         |  527 ++++++++
 .../tests/ref/15/vector-layout-f8L.c          |  527 ++++++++
 .../tests/ref/15/vector-layout-f8M.c          |  527 ++++++++
 .../tests/ref/15/vector-layout-t16L.c         |  527 ++++++++
 .../tests/ref/15/vector-layout-t16M.c         |  527 ++++++++
 .../tests/ref/15/vector-layout-t32L.c         |  527 ++++++++
 .../tests/ref/15/vector-layout-t32M.c         |  527 ++++++++
 .../tests/ref/15/vector-layout-t64L.c         |  527 ++++++++
 .../tests/ref/15/vector-layout-t64M.c         |  527 ++++++++
 .../tests/ref/15/vector-layout-t8L.c          |  527 ++++++++
 .../tests/ref/15/vector-layout-t8M.c          |  527 ++++++++
 .../helper-to-tcg/tests/ref/15/vector.c       |   31 +
 .../tests/ref/21/call-to-declaration.c        |   26 +
 .../tests/ref/21/call-translation.c           |   28 +
 .../helper-to-tcg/tests/ref/21/cpustate.c     |   36 +
 .../tests/ref/21/forward-context.c            |   30 +
 subprojects/helper-to-tcg/tests/ref/21/ldst.c |   21 +
 .../helper-to-tcg/tests/ref/21/scalar.c       |   21 +
 .../tests/ref/21/user-pcrel-jump.c            |   33 +
 .../tests/ref/21/vector-layout-f16L.c         |  527 ++++++++
 .../tests/ref/21/vector-layout-f16M.c         |  527 ++++++++
 .../tests/ref/21/vector-layout-f32L.c         |  527 ++++++++
 .../tests/ref/21/vector-layout-f32M.c         |  527 ++++++++
 .../tests/ref/21/vector-layout-f64L.c         |  527 ++++++++
 .../tests/ref/21/vector-layout-f64M.c         |  527 ++++++++
 .../tests/ref/21/vector-layout-f8L.c          |  527 ++++++++
 .../tests/ref/21/vector-layout-f8M.c          |  527 ++++++++
 .../tests/ref/21/vector-layout-t16L.c         |  527 ++++++++
 .../tests/ref/21/vector-layout-t16M.c         |  527 ++++++++
 .../tests/ref/21/vector-layout-t32L.c         |  527 ++++++++
 .../tests/ref/21/vector-layout-t32M.c         |  527 ++++++++
 .../tests/ref/21/vector-layout-t64L.c         |  527 ++++++++
 .../tests/ref/21/vector-layout-t64M.c         |  527 ++++++++
 .../tests/ref/21/vector-layout-t8L.c          |  527 ++++++++
 .../tests/ref/21/vector-layout-t8M.c          |  527 ++++++++
 .../helper-to-tcg/tests/ref/21/vector.c       |   31 +
 subprojects/helper-to-tcg/tests/scalar.c      |   15 +
 .../helper-to-tcg/tests/tcg-global-mappings.h |  118 ++
 .../helper-to-tcg/tests/user-pcrel-jump.c     |   28 +
 .../helper-to-tcg/tests/vector-layout.c       |   51 +
 subprojects/helper-to-tcg/tests/vector.c      |   34 +
 target/hexagon/cpu.h                          |    6 +-
 target/hexagon/gen_helper_funcs.py            |   17 +-
 target/hexagon/gen_helper_protos.py           |    2 +-
 target/hexagon/gen_idef_parser_funcs.py       |    9 +
 target/hexagon/gen_tcg_funcs.py               |   16 +-
 target/hexagon/genptr.c                       |    6 +-
 target/hexagon/helper.h                       |    9 +
 target/hexagon/hex_common.py                  |  103 +-
 target/hexagon/meson.build                    |  148 +-
 target/hexagon/op_helper.c                    |   17 +-
 target/hexagon/translate.c                    |  139 +-
 target/hexagon/translate.h                    |    4 +
 tcg/meson.build                               |    1 +
 tcg/tcg-global-mappings.c                     |   62 +
 tcg/tcg-op-gvec.c                             |    4 +-
 tests/docker/dockerfiles/debian-llvm.docker   |   38 +
 tests/docker/test-helper-to-tcg               |   41 +
 124 files changed, 27303 insertions(+), 122 deletions(-)
 create mode 100644 include/tcg/tcg-global-mappings.h
 create mode 100644 subprojects/helper-to-tcg/README.md
 create mode 100755 subprojects/helper-to-tcg/get-llvm-ir.py
 create mode 100644 subprojects/helper-to-tcg/include/CmdLineOptions.hpp
 create mode 100644 subprojects/helper-to-tcg/include/DebugInfo.hpp
 create mode 100644 subprojects/helper-to-tcg/include/Error.hpp
 create mode 100644 subprojects/helper-to-tcg/include/FunctionAnnotation.hpp
 create mode 100644 subprojects/helper-to-tcg/include/LlvmCompat.hpp
 create mode 100644 subprojects/helper-to-tcg/include/PrepareForOptPass.hpp
 create mode 100644 subprojects/helper-to-tcg/include/PrepareForTcgPass.hpp
 create mode 100644 subprojects/helper-to-tcg/include/PseudoInst.hpp
 create mode 100644 subprojects/helper-to-tcg/include/PseudoInst.inc
 create mode 100644 subprojects/helper-to-tcg/include/TcgGenPass.hpp
 create mode 100644 subprojects/helper-to-tcg/include/TcgGlobalMap.hpp
 create mode 100644 subprojects/helper-to-tcg/include/TcgType.hpp
 create mode 100644 subprojects/helper-to-tcg/include/VectorLayout.hpp
 create mode 100644 subprojects/helper-to-tcg/meson.build
 create mode 100644 subprojects/helper-to-tcg/meson_options.txt
 create mode 100644 subprojects/helper-to-tcg/src/LlvmCompat.cpp
 create mode 100644 subprojects/helper-to-tcg/src/Pipeline.cpp
 create mode 100644 subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp
 create mode 100644 subprojects/helper-to-tcg/src/PrepareForTcgPass/CanonicalizeIR.cpp
 create mode 100644 subprojects/helper-to-tcg/src/PrepareForTcgPass/CanonicalizeIR.hpp
 create mode 100644 subprojects/helper-to-tcg/src/PrepareForTcgPass/IdentityMap.cpp
 create mode 100644 subprojects/helper-to-tcg/src/PrepareForTcgPass/IdentityMap.hpp
 create mode 100644 subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
 create mode 100644 subprojects/helper-to-tcg/src/PrepareForTcgPass/TransformGEPs.cpp
 create mode 100644 subprojects/helper-to-tcg/src/PrepareForTcgPass/TransformGEPs.hpp
 create mode 100644 subprojects/helper-to-tcg/src/PseudoInst.cpp
 create mode 100644 subprojects/helper-to-tcg/src/TcgGenPass/LinearizeBlocks.cpp
 create mode 100644 subprojects/helper-to-tcg/src/TcgGenPass/LinearizeBlocks.hpp
 create mode 100644 subprojects/helper-to-tcg/src/TcgGenPass/MapArguments.cpp
 create mode 100644 subprojects/helper-to-tcg/src/TcgGenPass/MapConstantExpressions.cpp
 create mode 100644 subprojects/helper-to-tcg/src/TcgGenPass/MapTcgOperations.cpp
 create mode 100644 subprojects/helper-to-tcg/src/TcgGenPass/MapTemporaries.cpp
 create mode 100644 subprojects/helper-to-tcg/src/TcgGenPass/TcgEmit.cpp
 create mode 100644 subprojects/helper-to-tcg/src/TcgGenPass/TcgEmit.hpp
 create mode 100644 subprojects/helper-to-tcg/src/TcgGenPass/TcgGenPass.cpp
 create mode 100644 subprojects/helper-to-tcg/src/TcgGenPass/ValueMapping.hpp
 create mode 100644 subprojects/helper-to-tcg/tests/call-to-declaration.c
 create mode 100644 subprojects/helper-to-tcg/tests/call-translation.c
 create mode 100644 subprojects/helper-to-tcg/tests/cpustate.c
 create mode 100644 subprojects/helper-to-tcg/tests/forward-context.c
 create mode 100644 subprojects/helper-to-tcg/tests/ldst.c
 create mode 100644 subprojects/helper-to-tcg/tests/meson.build
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/call-to-declaration.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/call-translation.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/cpustate.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/forward-context.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/ldst.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/scalar.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/user-pcrel-jump.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-f16L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-f16M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-f32L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-f32M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-f64L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-f64M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-f8L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-f8M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-t16L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-t16M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-t32L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-t32M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-t64L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-t64M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-t8L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector-layout-t8M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/15/vector.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/call-to-declaration.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/call-translation.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/cpustate.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/forward-context.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/ldst.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/scalar.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/user-pcrel-jump.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-f16L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-f16M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-f32L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-f32M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-f64L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-f64M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-f8L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-f8M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-t16L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-t16M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-t32L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-t32M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-t64L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-t64M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-t8L.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector-layout-t8M.c
 create mode 100644 subprojects/helper-to-tcg/tests/ref/21/vector.c
 create mode 100644 subprojects/helper-to-tcg/tests/scalar.c
 create mode 100644 subprojects/helper-to-tcg/tests/tcg-global-mappings.h
 create mode 100644 subprojects/helper-to-tcg/tests/user-pcrel-jump.c
 create mode 100644 subprojects/helper-to-tcg/tests/vector-layout.c
 create mode 100644 subprojects/helper-to-tcg/tests/vector.c
 create mode 100644 tcg/tcg-global-mappings.c
 create mode 100644 tests/docker/dockerfiles/debian-llvm.docker
 create mode 100755 tests/docker/test-helper-to-tcg

-- 
2.52.0


