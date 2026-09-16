Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DADC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pg6-0001li-ER; Wed, 16 Sep 2026 09:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1x6pfx-0001kX-3z
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:27:50 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1x6pft-0003sS-Tu
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=1eXrWsY9QzEZjAtgFp+SDzuMxOY85sHaE+WCiHXYFPA=; b=AskOddfwJR2Qvoe
 OH6YzdFJxaAdzjN8kz743e1Pa+FJvSNRt9l1QI4Pt54ErJLO1oIW9kFy1KosZF7gKDyzzgMemCSsO
 NV0MFmTiQnao3sas4VEIGoecUdGuebKqA7iFQRjIElacFQHKaRuORxQst4HB51A2nP/IlQQYVulmR
 6Y=;
Date: Wed, 16 Sep 2026 14:42:39 +0200
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@mailo.com
Subject: Re: [PATCH v2 22/50] helper-to-tcg: Introduce PrepareForTcgPass
Message-ID: <20260916144239.4350a6ec@spawn>
In-Reply-To: <20260730031025.12926-23-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-23-anjo@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=ale@rev.ng;
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
Reply-to:  Alessandro Di Federico <ale@rev.ng>
From:  Alessandro Di Federico via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 30 Jul 2026 05:09:56 +0200
Anton Johansson <anjo@rev.ng> wrote:

> Adds a new pass over the LLVM module which runs post-optimization with
> the end-goal of:
> 
>   * Culling functions which aren't worth translating;
>   * Canonicalizing the IR to something closer to TCG, and;

When you "canonicalize" for a backend, you're doing more "instruction
selection" than canonicalization. The goal of canonicalization is to
bring the IR in the most standard, frontend- and backend-agnostic
representation you can.

I'd talk about a form of instruction selection.

>   * Extracting information which may be useful in the backend pass.
> 
> The bulk of IR transformations occur in the canonicalization phase, with
> a handful occuring later in the packend. This commits sets up a new LLVM

packend

> pass over the IR module and runs it from the pipeline.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  .../helper-to-tcg/include/CmdLineOptions.hpp  |  2 ++
>  .../include/PrepareForTcgPass.hpp             | 27 +++++++++++++++++++
>  subprojects/helper-to-tcg/meson.build         |  1 +
>  subprojects/helper-to-tcg/src/Pipeline.cpp    | 24 +++++++++++++++++
>  .../PrepareForTcgPass/PrepareForTcgPass.cpp   | 25 +++++++++++++++++
>  5 files changed, 79 insertions(+)
>  create mode 100644 subprojects/helper-to-tcg/include/PrepareForTcgPass.hpp
>  create mode 100644 subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
> 
> diff --git a/subprojects/helper-to-tcg/include/CmdLineOptions.hpp b/subprojects/helper-to-tcg/include/CmdLineOptions.hpp
> index ca1cb59835..bfdd3ebe41 100644
> --- a/subprojects/helper-to-tcg/include/CmdLineOptions.hpp
> +++ b/subprojects/helper-to-tcg/include/CmdLineOptions.hpp
> @@ -23,3 +23,5 @@
>  extern llvm::cl::list<std::string> InputFiles;
>  // Options for PrepareForOptPass
>  extern llvm::cl::opt<bool> TranslateAllHelpers;
> +// Options for PrepareForTcgPass
> +extern llvm::cl::opt<std::string> TcgGlobalMappingsName;
> diff --git a/subprojects/helper-to-tcg/include/PrepareForTcgPass.hpp b/subprojects/helper-to-tcg/include/PrepareForTcgPass.hpp
> new file mode 100644
> index 0000000000..90bc9402cb
> --- /dev/null
> +++ b/subprojects/helper-to-tcg/include/PrepareForTcgPass.hpp
> @@ -0,0 +1,27 @@
> +//
> +//  Copyright(c) 2026 rev.ng Labs Srl. All Rights Reserved.
> +//
> +//  This program is free software; you can redistribute it and/or modify
> +//  it under the terms of the GNU General Public License as published by
> +//  the Free Software Foundation; either version 2 of the License, or
> +//  (at your option) any later version.
> +//
> +//  This program is distributed in the hope that it will be useful,
> +//  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +//  GNU General Public License for more details.
> +//
> +//  You should have received a copy of the GNU General Public License
> +//  along with this program; if not, see <http://www.gnu.org/licenses/>.
> +//
> +
> +#pragma once
> +
> +#include <llvm/IR/PassManager.h>
> +
> +class PrepareForTcgPass : public llvm::PassInfoMixin<PrepareForTcgPass> {
> +public:
> +    PrepareForTcgPass() {}
> +    llvm::PreservedAnalyses run(llvm::Module &M,
> +                                llvm::ModuleAnalysisManager &MAM);
> +};
> diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
> index b3a3de6297..c2926652f3 100644
> --- a/subprojects/helper-to-tcg/meson.build
> +++ b/subprojects/helper-to-tcg/meson.build
> @@ -44,6 +44,7 @@ sources = [
>      'src/Pipeline.cpp',
>      'src/PrepareForOptPass/PrepareForOptPass.cpp',
>      'src/PseudoInst.cpp',
> +    'src/PrepareForTcgPass/PrepareForTcgPass.cpp',
>  ]
>  
>  clang = bindir / 'clang'
> diff --git a/subprojects/helper-to-tcg/src/Pipeline.cpp b/subprojects/helper-to-tcg/src/Pipeline.cpp
> index 571276de24..6058718a9c 100644
> --- a/subprojects/helper-to-tcg/src/Pipeline.cpp
> +++ b/subprojects/helper-to-tcg/src/Pipeline.cpp
> @@ -18,6 +18,7 @@
>  #include "CmdLineOptions.hpp"
>  #include "LlvmCompat.hpp"
>  #include "PrepareForOptPass.hpp"
> +#include "PrepareForTcgPass.hpp"
>  
>  #if LLVM_VERSION_MAJOR == 15
>  #include <llvm/ADT/Triple.h>
> @@ -32,6 +33,7 @@
>  #include <llvm/IR/LLVMContext.h>
>  #include <llvm/IR/Module.h>
>  #include <llvm/IR/PassManager.h>
> +#include <llvm/IR/Verifier.h>
>  #include <llvm/IRReader/IRReader.h>
>  #include <llvm/InitializePasses.h>
>  #include <llvm/Linker/Linker.h>
> @@ -43,6 +45,7 @@
>  #include <llvm/Support/SourceMgr.h>
>  #include <llvm/Support/TargetSelect.h>
>  #include <llvm/Target/TargetMachine.h>
> +#include <llvm/Transforms/Scalar/DCE.h>
>  #include <llvm/Transforms/Scalar/SROA.h>
>  
>  #define DEBUG_TYPE "pipeline"
> @@ -70,6 +73,13 @@ cl::opt<bool> TranslateAllHelpers(
>      "translate-all-helpers", cl::init(false),
>      cl::desc("Translate all functions starting with helper_*"), cl::cat(Cat));
>  
> +// Options for PrepareForTcgPass
> +cl::opt<std::string> TcgGlobalMappingsName(
> +    "tcg-global-mappings",
> +    cl::desc("<Name of global cpu_mappings[] used for mapping accesses"
> +             "into a struct to TCG globals>"),
> +    cl::Required, cl::cat(Cat));
> +

I'd drop this and go by convention (i.e., just assume the name) +
documentation.
If you think this is useful for debugging purposes, at least give it a
default so we don't need to specify the parameter in the regular invocation.

If you keep this, introduce it in the first commit using it
TcgGlobalMappingsName.

>  // Define a TargetTransformInfo (TTI) subclass, this allows for overriding
>  // common per-llvm-target information expected by other LLVM passes, such
>  // as the width of the largest scalar/vector registers.  Needed for consistent
> @@ -214,5 +224,19 @@ int main(int argc, char **argv) {
>      MPM.addPass(
>          PB.buildModuleOptimizationPipeline(compat::OptimizationLevel::Oz, {}));
>  
> +    //
> +    // Next, we run our final transformations, including removing phis and our
> +    // own instruction combining that prioritizes instructions that map more
> +    // easily to TCG.
> +    //
> +
> +    MPM.addPass(PrepareForTcgPass());
> +    MPM.addPass(VerifierPass());
> +    {
> +        FunctionPassManager FPM;
> +        FPM.addPass(DCEPass());
> +        MPM.addPass(createModuleToFunctionPassAdaptor(std::move(FPM)));
> +    }
> +
>      return 0;
>  }
> diff --git a/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp b/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
> new file mode 100644
> index 0000000000..cea6573e41
> --- /dev/null
> +++ b/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
> @@ -0,0 +1,25 @@
> +//
> +//  Copyright(c) 2026 rev.ng Labs Srl. All Rights Reserved.
> +//
> +//  This program is free software; you can redistribute it and/or modify
> +//  it under the terms of the GNU General Public License as published by
> +//  the Free Software Foundation; either version 2 of the License, or
> +//  (at your option) any later version.
> +//
> +//  This program is distributed in the hope that it will be useful,
> +//  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +//  GNU General Public License for more details.
> +//
> +//  You should have received a copy of the GNU General Public License
> +//  along with this program; if not, see <http://www.gnu.org/licenses/>.
> +//
> +
> +#include "PrepareForTcgPass.hpp"
> +
> +using namespace llvm;
> +
> +PreservedAnalyses PrepareForTcgPass::run(Module &M, ModuleAnalysisManager &MAM)
> +{
> +    return PreservedAnalyses::none();
> +}
> -- 
> 2.52.0

Reviewed-by: Alessandro Di Federico <ale@rev.ng>

-- 
Alessandro Di Federico
rev.ng Labs

