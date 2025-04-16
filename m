Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B224C369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 06:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4w6M-0003PQ-Jj; Wed, 16 Apr 2025 02:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4w6H-0003NT-1n
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 02:18:21 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4w6E-000525-JU
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 02:18:20 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so4664801f8f.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 23:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744784296; x=1745389096; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6TZqV0m/1190EkTGSdRHwFP8DoHtmDOWwbhXkWdjBig=;
 b=dN3cCYG0W+HCmBSE/+xhdQZm5HZDgtnq4kiCi7ZFGtzA7kTKnN5LVMo4mJzmzzWfFt
 QTqk3PVh7a8McmkJlVIpouo0Bc4y2YFvC1ZjqcKg1HOHU1ZpACVmOjAyD1ndswBuv0Ry
 X5X14gr4B3R6N63ltl1MU5hLRX+9ooNpAwlbpDvlKoEM70OaYXUbfS65t9FJoRORcr/E
 uqYzvuqMZyB8rW31sjABbM1CATudxC4zE/jp8gghCLctc9SbYsVk1nFaCVgYzRaeRSj1
 QVkFdPIT1FMl6q8iqF241AjCvFliEHpxViJHFrTnJ0uXzxuPX4O4Hf0GJ1FkJIunDgvy
 fLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744784296; x=1745389096;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6TZqV0m/1190EkTGSdRHwFP8DoHtmDOWwbhXkWdjBig=;
 b=Hsaz0/qYCbMn6+MQR7FQ2gEe0MPT9nZ/GtrLbwd1ljm5wVsDfpe63eBNfAbUHH33Jy
 KYDVItVRwUZ0HIK1xmPyZAfwBgH0RMCdx5eUeUhA1eTFm0UKTcu2FBa1nEZgvGNg3Uxe
 IXE41IeuI5kzvXNiipF1JaQ32P1SQjnlC4sqyG0hl4ZZhcaBTDfrkk5BOIRL26hbc9cb
 H+IjM75GSeKJ03XI36B0tCV7+MybYPnzd4KduDXghCUsjc+Zl/ZDT3fg3+a9jTcY+Rrp
 xHiYFkABTTQDfcm3f0La8+O5TB91ob7+CBjdyPnUP7FPsA1gcsSUUg+dZFStPmQcmA+y
 hexA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUjBCsJGttmylrui445I5gpb2I7TagYLIaKREQ5uRky4Y3O6mfqrhsRyopAp04cqrtH3oTBcT8OFd1@nongnu.org
X-Gm-Message-State: AOJu0YwqMa/rzd8043KAfLcDrr5ur/HogGlbaeKeV5CQ5aiLjreA9XEi
 s3/xfSR1Di1hmMvy4gzQvAyT3R4kl/uImD9LdTBYTCQ8yCxtOV8ZUqIdACBtzXE=
X-Gm-Gg: ASbGncsmiNEUEPCM21MyVcM5YLLnS0QpA04vKsHydKJsmY/Fym3Wp6qeBxTti52D6wJ
 MXO2g5TeEMaNEKfaAgH8qWDgPs6t6L+omGYrHC0vEBQmDUPtfpv0EAmYOWsczDWmF+2bwy5xQrK
 5VQ8WsOVJoXwC3FjpQj3oJHlYihho5aMk1fxpE4hzvohklSE/1rKhih4lRzkBaCDXivXm7zNLD5
 o3NdV5ZyqLaeIofb1rpH4TccRJWT5C34rh+a3VkyJiGbeiWLKyMdsIMZiu5XiYmeRQiQsH2QBiS
 DgJEp1kEZokdPQkbC4xECk7Mqpv6u82JDXSZn4chUjTWzttk7+5cKEBF2BArM4R1YadXdy0PNHi
 3gb0NYw==
X-Google-Smtp-Source: AGHT+IGfjqcRw0d8Ml1rTd1MCZ1zHM1LTCA4EYuFtVJInllZGArRHpEDpBDmX/L8xKL85QMrYg7pSw==
X-Received: by 2002:a05:6000:401f:b0:391:4674:b10f with SMTP id
 ffacd0b85a97d-39ee5bac51dmr461078f8f.36.1744784296023; 
 Tue, 15 Apr 2025 23:18:16 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39ed1652a91sm11200308f8f.75.2025.04.15.23.18.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 23:18:15 -0700 (PDT)
Message-ID: <c7588131-2c4f-4a66-8107-cba4df904278@linaro.org>
Date: Wed, 16 Apr 2025 08:18:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Hexagon (target/hexagon) Remove gen_tcg_func_table.py
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, quic_mathbern@quicinc.com,
 sidneym@quicinc.com, quic_mliebel@quicinc.com, richard.henderson@linaro.org,
 ale@rev.ng, anjo@rev.ng
References: <20250415235542.71703-1-ltaylorsimpson@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415235542.71703-1-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Hi Taylor,

On 16/4/25 01:55, Taylor Simpson wrote:
> This can easily be done in C with opcodes_def_generated.h.inc
> 
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>   target/hexagon/genptr.c              |  6 ++-
>   target/hexagon/README                |  1 -
>   target/hexagon/gen_tcg_func_table.py | 66 ----------------------------
>   target/hexagon/meson.build           | 10 -----
>   4 files changed, 5 insertions(+), 78 deletions(-)
>   delete mode 100755 target/hexagon/gen_tcg_func_table.py
> 
> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
> index 2c5e15cfcf..330170ab44 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -1453,4 +1453,8 @@ void gen_add_sat_i64(DisasContext *ctx, TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
>   }
>   
>   #include "tcg_funcs_generated.c.inc"
> -#include "tcg_func_table_generated.c.inc"
> +const SemanticInsn opcode_genptr[XX_LAST_OPCODE] = {
> +#define OPCODE(X)    [X] = generate_##X
> +#include "opcodes_def_generated.h.inc"
> +#undef OPCODE
> +};
> diff --git a/target/hexagon/README b/target/hexagon/README
> index ca617e3364..5af298e3ed 100644
> --- a/target/hexagon/README
> +++ b/target/hexagon/README
> @@ -47,7 +47,6 @@ header files in <BUILD_DIR>/target/hexagon
>           gen_op_attribs.py               -> op_attribs_generated.h.inc
>           gen_helper_protos.py            -> helper_protos_generated.h.inc
>           gen_tcg_funcs.py                -> tcg_funcs_generated.c.inc
> -        gen_tcg_func_table.py           -> tcg_func_table_generated.c.inc
>           gen_helper_funcs.py             -> helper_funcs_generated.c.inc
>           gen_idef_parser_funcs.py        -> idef_parser_input.h
>           gen_analyze_funcs.py            -> analyze_funcs_generated.c.inc
> diff --git a/target/hexagon/gen_tcg_func_table.py b/target/hexagon/gen_tcg_func_table.py
> deleted file mode 100755
> index 299a39b1aa..0000000000
> --- a/target/hexagon/gen_tcg_func_table.py
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -#!/usr/bin/env python3
> -
> -##
> -##  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
> -##
> -##  This program is free software; you can redistribute it and/or modify
> -##  it under the terms of the GNU General Public License as published by
> -##  the Free Software Foundation; either version 2 of the License, or
> -##  (at your option) any later version.
> -##
> -##  This program is distributed in the hope that it will be useful,
> -##  but WITHOUT ANY WARRANTY; without even the implied warranty of
> -##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -##  GNU General Public License for more details.
> -##
> -##  You should have received a copy of the GNU General Public License
> -##  along with this program; if not, see <http://www.gnu.org/licenses/>.
> -##
> -
> -import sys
> -import re
> -import string
> -import hex_common
> -import argparse
> -
> -
> -def main():
> -    parser = argparse.ArgumentParser(
> -        "Emit opaque macro calls with instruction semantics"
> -    )
> -    parser.add_argument("semantics", help="semantics file")
> -    parser.add_argument("out", help="output file")
> -    args = parser.parse_args()
> -    hex_common.read_semantics_file(args.semantics)
> -    hex_common.calculate_attribs()
> -    tagregs = hex_common.get_tagregs()
> -    tagimms = hex_common.get_tagimms()
> -
> -    with open(args.out, "w") as f:
> -        f.write("#ifndef HEXAGON_FUNC_TABLE_H\n")
> -        f.write("#define HEXAGON_FUNC_TABLE_H\n\n")
> -
> -        f.write("const SemanticInsn opcode_genptr[XX_LAST_OPCODE] = {\n")
> -        for tag in hex_common.tags:
> -            ## Skip the priv instructions
> -            if "A_PRIV" in hex_common.attribdict[tag]:
> -                continue
> -            ## Skip the guest instructions
> -            if "A_GUEST" in hex_common.attribdict[tag]:
> -                continue
> -            ## Skip the diag instructions
> -            if tag == "Y6_diag":
> -                continue
> -            if tag == "Y6_diag0":
> -                continue
> -            if tag == "Y6_diag1":
> -                continue

What about all these skipped tags? IIUC gen_opcodes_def.py doesn't skip
them. If it isn't necessary to skip, please mention it in the commit
description for clarity.

Regards,

Phil.

> -
> -            f.write(f"    [{tag}] = generate_{tag},\n")
> -        f.write("};\n\n")
> -
> -        f.write("#endif    /* HEXAGON_FUNC_TABLE_H */\n")
> -
> -
> -if __name__ == "__main__":
> -    main()
> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index bb4ebaae81..b28aeddb85 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build
> @@ -41,20 +41,10 @@ hexagon_ss.add(semantics_generated)
>   #
>   # Step 2
>   # We use Python scripts to generate the following files
> -#     tcg_func_table_generated.c.inc
>   #     printinsn_generated.h.inc
>   #     op_attribs_generated.h.inc
>   #     opcodes_def_generated.h.inc
>   #
> -tcg_func_table_generated = custom_target(
> -    'tcg_func_table_generated.c.inc',
> -    output: 'tcg_func_table_generated.c.inc',
> -    depends: [semantics_generated],
> -    depend_files: [hex_common_py],
> -    command: [python, files('gen_tcg_func_table.py'), semantics_generated, '@OUTPUT@'],
> -)
> -hexagon_ss.add(tcg_func_table_generated)
> -
>   printinsn_generated = custom_target(
>       'printinsn_generated.h.inc',
>       output: 'printinsn_generated.h.inc',


