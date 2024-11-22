Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C1CE69186
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 18:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEYBJ-0000Nb-Oz; Fri, 22 Nov 2024 13:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEYBI-0000N5-87
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 13:15:00 -0500
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEYBE-0002AR-UX
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 13:14:59 -0500
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2958ddf99a7so2274400fac.2
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 10:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732299295; x=1732904095; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WelkrKiwn0tLulTsFyNcHq5FFNkPPLRleBfrN1uHqyU=;
 b=tJvjxXaWQnm0ZWwNicPmXn3gX2HUZKNshsTt6xB9G9nbC5H9jXsXzCsQ+Rc+ooLSl6
 CcImfE64t6CGLL3pnp6lxJPQp5o6VeKmF083ma+hm9aGdR7ehUIujSL9+iJREkWZ4GUr
 SXo9vSBp5LalZWb+YEQkKtYFFvsBdmEKb2So0hrfABD94kgZy4ZxtFvzCYqXtGT07c3c
 xQ/fsMMwNnEPuSGeTbZozVoe70z93HAdnhbFJ3J5Vv0uVMBimlz5jJuJpsaGdHN8gM9Y
 aKxQOld0w8jaj7eyBJUzRgZfCwuHdMLJMviIcl+Nq8/CciQLZF8mUADFCbC8PtkK72VM
 F9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732299295; x=1732904095;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WelkrKiwn0tLulTsFyNcHq5FFNkPPLRleBfrN1uHqyU=;
 b=bhua8EvZEBtd6FkOW4iUszWAU3gOD79HdqlFlo44ziEBtF1H42nRTSiX/ZQB0xcgjN
 zTxFFUsUN8uGSdlSLNIyaIThsOaNA3/C863s30cXDNOB7IElsKEgPW6kvLlpVxtxfoO3
 C1lg5YBqJtK+Fw9lHC5R/kyyH5oiMdMX+PtsyqCa3PNhwvAOfyWkPNyT9zbQ+dmzwfCF
 rFn32fHvPGO9JmeqU4XsayVujtpbXhgk4ylfWlATjzOZNZsL3uC3o6Q8pI32VvuzqgZB
 EJ510Ln254Ocl5g5Jxu4UWoCHwQ5BifqO1Ywu4k2MCa/SxuwUj52WBWaDd5HNY4wgk3/
 Piwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZTFo7RyjwN2L8lxWoGCIuseGlG5eImGTq1a7v7eDZ9UqcQBAVnfbrQBzi5fGk1hbhmGMEQyP0v15z@nongnu.org
X-Gm-Message-State: AOJu0Yw37V2Zmj8IvIjwR11RmAWPMDvKKbpOJKyLPRPSPdXrlmWTucoT
 wBdstIWADvVk3RQLPW6X6SDtGmapRiMiQ2VDbbBH2vNECu12mK5ApnuIluagjZo=
X-Gm-Gg: ASbGnctFn1SYk7e9s91jjrpw3ZlMyV7t3lQPKUNzKWksbfu3jgq/iufaOdd5fQHSwoh
 Q/ALs3dC3vFexDy8iTloDAixD9FsaqmdIq1hmaUIK5HLw7DhVA+15FYgBduABo/QjII/mfc3Ym1
 A1zjT/jULe0U9+ryQt4HFoBYecYfEptE2LJnjM8OWs2bu606C6XHjRxBJMU4me3A8xuFzH+nOJc
 4le6RpHEvkD6iqr6LCzUQIdnfAiIcgzLl2gdIbBbppuFrCBLXBYrDDVB1ZoD7eaHoquGEI=
X-Google-Smtp-Source: AGHT+IFqoGuNmU3ChlM2xAmm0i+FlnpzJphUE//Hr6OVmCz26aS88j2Fw7+Xl4mlfth1vGagq6v8rg==
X-Received: by 2002:a05:6870:65aa:b0:296:23e2:f5f3 with SMTP id
 586e51a60fabf-29720af1221mr4509329fac.6.1732299295234; 
 Fri, 22 Nov 2024 10:14:55 -0800 (PST)
Received: from [192.168.170.227] ([187.210.107.181])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2971d88f849sm709889fac.49.2024.11.22.10.14.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 10:14:54 -0800 (PST)
Message-ID: <6b087061-fb11-4ac5-aecc-43f3324060df@linaro.org>
Date: Fri, 22 Nov 2024 12:14:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 09/43] helper-to-tcg: Introduce get-llvm-ir.py
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-10-anjo@rev.ng>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241121014947.18666-10-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/20/24 19:49, Anton Johansson wrote:
> Introduces a new python helper script to convert a set of QEMU .c files to
> LLVM IR .ll using clang.  Compile flags are found by looking at
> compile_commands.json, and llvm-link is used to link together all LLVM
> modules into a single module.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   subprojects/helper-to-tcg/get-llvm-ir.py | 143 +++++++++++++++++++++++
>   1 file changed, 143 insertions(+)
>   create mode 100755 subprojects/helper-to-tcg/get-llvm-ir.py

Is this not something that can be done in meson?


r~

> 
> diff --git a/subprojects/helper-to-tcg/get-llvm-ir.py b/subprojects/helper-to-tcg/get-llvm-ir.py
> new file mode 100755
> index 0000000000..9ee5d0e136
> --- /dev/null
> +++ b/subprojects/helper-to-tcg/get-llvm-ir.py
> @@ -0,0 +1,143 @@
> +#!/usr/bin/env python3
> +
> +##
> +##  Copyright(c) 2024 rev.ng Labs Srl. All Rights Reserved.
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
> +
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
> +    }
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
> +        "-DHELPER_TO_TCG",
> +        "-O0",
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
> +
> +
> +if __name__ == "__main__":
> +    sys.exit(main())


