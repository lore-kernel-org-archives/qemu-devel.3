Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74ABBC55ABF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrDxB-0000JX-MJ; Tue, 04 Aug 2026 08:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1wrDx2-0000Ik-6v
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 08:08:57 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1wrDwz-0007SN-EK
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 08:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=jzmu+88pQsrjR/GxDZ26L+Le++XHUDR9kjU+zjSUCr4=; b=kMW7EbBbsqpM8eQ
 0dmSYIhDYZI6dqspnTkTcBnxy/q54JgcHhlukr2MBTaWbLgxMed63FNe8dFJYatBlHPNsTkg/Npr4
 uHfU5OM/4l2yHU8bkfDKhUiVQANG6nEqVkmIKXHit+55SjYPuaH4NNSIVftyvdfjqOe+O+JlESWRO
 7s=;
Date: Tue, 4 Aug 2026 14:08:14 +0200
To: Anton Johansson via qemu development <qemu-devel@nongnu.org>
Cc: Anton Johansson <anjo@rev.ng>, brian.cain@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@mailo.com
Subject: Re: [PATCH v2 07/50] helper-to-tcg: Introduce get-llvm-ir.py
Message-ID: <20260804140814.23295a64@spawn>
In-Reply-To: <20260730031025.12926-8-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-8-anjo@rev.ng>
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

On Thu, 30 Jul 2026 05:09:41 +0200
Anton Johansson via qemu development <qemu-devel@nongnu.org> wrote:

> ---
>  subprojects/helper-to-tcg/get-llvm-ir.py | 145 +++++++++++++++++++++++
>  subprojects/helper-to-tcg/meson.build    |   8 ++
>  2 files changed, 153 insertions(+)
>  create mode 100755 subprojects/helper-to-tcg/get-llvm-ir.py
> 
> diff --git a/subprojects/helper-to-tcg/get-llvm-ir.py b/subprojects/helper-to-tcg/get-llvm-ir.py
> new file mode 100755
> index 0000000000..982b87f791
> --- /dev/null
> +++ b/subprojects/helper-to-tcg/get-llvm-ir.py
> @@ -0,0 +1,145 @@
> +#!/usr/bin/env python3
> +
> +##
> +##  Copyright(c) 2026 rev.ng Labs Srl. All Rights Reserved.
> +##
> +##  This program is free software; you can redistribute it and/or modify
> +##  it under the terms of the GNU General Public License as published by
> +##  the Free Software Foundation; either version 2 of the License, or
> +##  (at your option) any later version.
> +##
> +##  This program is distributed in the hope that it will be useful,
> +##  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +##  GNU General Public License for more details.
> +##
> +##  You should have received a copy of the GNU General Public License
> +##  along with this program; if not, see <http://www.gnu.org/licenses/>.
> +##
> +
> +import argparse
> +import json
> +import os
> +import shlex
> +import sys
> +import subprocess
> +
> +
> +def log(msg):
> +    print(msg, file=sys.stderr)
> +
> +
> +def run_command(command):
> +    proc = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
> +    out = proc.communicate()
> +    if proc.wait() != 0:
> +        log(f"Command: {' '.join(command)} exited with {proc.returncode}\n")
> +        log(f"output:\n{out}\n")

The whole program should fail if a subcommand fails, printing about it
is not enough.

> +
> +def find_compile_commands(compile_commands_path, clang_path, input_path, target):
> +    with open(compile_commands_path, "r") as f:
> +        compile_commands = json.load(f)
> +        for compile_command in compile_commands:
> +            path = compile_command["file"]
> +            if os.path.basename(path) != os.path.basename(input_path):
> +                continue
> +
> +            os.chdir(compile_command["directory"])
> +            command = compile_command["command"]
> +
> +            # If building multiple targets there's a chance
> +            # input files share the same path and name.
> +            # This could cause us to find the wrong compile
> +            # command, we use the target path to distinguish
> +            # between these.
> +            if not target in command:
> +                continue
> +
> +            argv = shlex.split(command)
> +            argv[0] = clang_path
> +
> +            return argv
> +
> +    raise ValueError(f"Unable to find compile command for {input_path}")
> +
> +
> +def generate_llvm_ir(
> +    compile_commands_path, clang_path, output_path, input_path, target
> +):
> +    command = find_compile_commands(
> +        compile_commands_path, clang_path, input_path, target
> +    )
> +
> +    flags_to_remove = {
> +        "-ftrivial-auto-var-init=zero",
> +        "-fzero-call-used-regs=used-gpr",
> +        "-Wimplicit-fallthrough=2",
> +        "-Wold-style-declaration",
> +        "-Wno-psabi",
> +        "-Wshadow=local",
> +        "-c",
> +    }

How did you come up with this list?
We should put some indication to make its maintenance easier.
For instance, explicitly mention what part of QEMU introduced it, so
one can easily check if it's still relevant or if it disappeared.

> +
> +    # Remove
> +    #   - output of makefile rules (-MQ,-MF target);
> +    #   - output of object files (-o target);
> +    #   - excessive zero-initialization of block-scope variables
> +    #     (-ftrivial-auto-var-init=zero);
> +    #   - and any optimization flags (-O).
> +    for i, arg in reversed(list(enumerate(command))):
> +        if arg in {"-MQ", "-o", "-MF"}:
> +            del command[i : i + 2]
> +        elif arg.startswith("-O") or arg in flags_to_remove:
> +            del command[i]
> +
> +    # Define a HELPER_TO_TCG macro for translation units wanting to
> +    # conditionally include or exclude code during translation to TCG.
> +    # Disable optimization (-O0) and make sure clang doesn't emit optnone
> +    # attributes (-disable-O0-optnone) which inhibit further optimization.
> +    # Optimization will be performed at a later stage in the helper-to-tcg
> +    # pipeline.
> +    command += [
> +        "-S",
> +        "-emit-llvm",
> +        "-DHELPER_TO_TCG_IR_GEN",
> +        "-O0",
> +        "-g",
> +        "-Xclang",
> +        "-disable-O0-optnone",
> +    ]
> +    if output_path:
> +        command += ["-o", output_path]
> +
> +    run_command(command)
> +
> +
> +def main():
> +    parser = argparse.ArgumentParser(
> +        description="Produce the LLVM IR of a given .c file."
> +    )
> +    parser.add_argument(
> +        "--compile-commands", required=True, help="Path to compile_commands.json"
> +    )

I'm not super happy that we use `compile_commands.json`, however:

1. `compile_commands.json` is emitted unconditionally by meson at build
   time.

2. There's no good alternative. In rev.ng we configure a dedicated
   (throwaway) clang QEMU build with `-fembed-bitcode` and then extract
   the IR downstream.

   Maybe here we could manage to build a set of sources with
   `-fembed-bitcode`, but that won't work unless the compiler is clang.

   We could configure a temporary clang QEMU build in a subdirectory,
   but that's not very nice.

So, in the end, this makes sense to me.

The proper solution would to have `meson` provide the full invocation
used to produce a certain object file that we can then manipulate, but
AFAIU there's not such a feature.

One day we could maybe explore adjusting meson, but I'd say not today.

> +    parser.add_argument("--clang", default="clang", help="Path to clang.")
> +    parser.add_argument("--llvm-link", default="llvm-link", help="Path to llvm-link.")
> +    parser.add_argument("-o", "--output", required=True, help="Output .ll file path")
> +    parser.add_argument(
> +        "--target-path", help="Path to QEMU target dir. (e.q. target/i386)"
> +    )
> +    parser.add_argument("inputs", nargs="+", help=".c file inputs")
> +    args = parser.parse_args()
> +
> +    outputs = []
> +    for input in args.inputs:
> +        output = os.path.basename(input) + ".ll"
> +        generate_llvm_ir(
> +            args.compile_commands, args.clang, output, input, args.target_path
> +        )
> +        outputs.append(output)
> +
> +    run_command([args.llvm_link] + outputs + ["-S", "-o", args.output])

Maybe we should emit bitcode (binary form) instead of textual LLVM IR.
If you go this route, don't forget to rename the output to `.bc`.

I know this is easy for debugging, but bitcode is what one should use
"in production" and you're one `opt -S` away from getting the textual
IR again.

> +
> +
> +if __name__ == "__main__":
> +    sys.exit(main())
> diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
> index 8ab58adb39..97bce186fe 100644
> --- a/subprojects/helper-to-tcg/meson.build
> +++ b/subprojects/helper-to-tcg/meson.build
> @@ -42,6 +42,14 @@ endif
>  sources = [
>  ]
>  
> +clang = bindir / 'clang'
> +llvm_link = bindir / 'llvm-link'
> +
> +get_llvm_ir_cmd = [python, meson.current_source_dir() / 'get-llvm-ir.py',
> +                   '--compile-commands', 'compile_commands.json',
> +                   '--clang', clang,
> +                   '--llvm-link', llvm_link]
> +
>  # NOTE: Add -Wno-template-id-cdtor for GCC versions >= 14.  This warning is
>  # related to a change in the C++ standard in C++20, that also applies to C++14
>  # for some reason. See defect report DR2237 and commit
> -- 
> 2.52.0

Reviewed-by: Alessandro Di Federico <ale@rev.ng>

-- 
Alessandro Di Federico
rev.ng Labs

