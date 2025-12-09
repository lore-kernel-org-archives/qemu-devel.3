Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AB7D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 12:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSwrm-0001WZ-5C; Tue, 09 Dec 2025 07:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSwrf-0001Vq-G2
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 07:30:47 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSwrd-0006aB-A3
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 07:30:47 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42e2e628f8aso2613190f8f.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 04:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765283443; x=1765888243; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=koqDcduY9JwQjDJi3XUVOcYumHzrBPsP8SuKbsFeapo=;
 b=s0QnNrwugBiQ5lV98OSvOHy5xbOPRt3V8tLB8XcyYomQw38bh+jAa28pSVycsuNjXh
 l07yoLDg2SgHRsL6qHrKLDPpxNzrgrrbsekYJuyaLDn8QXQNFZIOqskmf84RIR1ZwT+B
 Ej4GBx+v6NEIMqV7PiaQvxkR5LxX//yfTJvJ381OpL6Ax8tx+4s8sSwd0i2aUtQe4q/X
 WqFXZzq9pQm/SHmyS9PFFev8e1t31/4jG2Z0Z2XYn+y+ToQVSoWba3MmUdFWHqkjtPg5
 LwdFuSnubfKbpYLKYe+EGCb6h5+TP3wLYIuzSD298aCmK23je+n8XXXGx6/vlTZudcLb
 4mJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765283443; x=1765888243;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=koqDcduY9JwQjDJi3XUVOcYumHzrBPsP8SuKbsFeapo=;
 b=rl+rGyjzDYbBBBQYGrv2zaYgGzV4RIsvizaaaRu9sL1dL8uCJK9MutYJHUIR5Ocog1
 vjzErOBig6202sM22c/JIOheIjnye/Uz1YawnJ5W9zMdNZ6XTIS0ZHeSuHrKy6YSDF2/
 CDY1mbZ6f82HryZULNbEEaPB+uGPSbPcXdDxPnfPNRgCXVNrqBaRs+4Ak75U++mDep1n
 nnNYXmXyrAaZSKaWTkJPIe5uEThlAhC5CQlMfFVi5zQbnq4+ipsoQpLU/6lbyBBB7jX8
 LkO+RESUiXqsmbMi/jAonNy1v9Xsp5Tpd4+oZcyAEZP8Xs78fvNN3/Blh/8+ILpsILD2
 qtig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeSAIWDXgoInSEKxA6Nh/DfK0V94FTcZuu1CNaTRPioCMAZ8FncLSfyKP1Rex3Am4Afs8E4JZIZouv@nongnu.org
X-Gm-Message-State: AOJu0Yw8iaCu1EkM6mFo4HjabUezrlWiKcy7dpLJsXpoWoLD4cVVBv1F
 T04CqFgqzJ9khXgFLmlBYY18S+SgUeMdv0hMhih8cHOJs3JPjtYgLZH7xWmOclWT9mE=
X-Gm-Gg: AY/fxX5JwEqobs2MAZ80E/2vdFc9iJSOWEUR80QA5UfYvPqWz8pE+bezoNYWHXCfhYX
 Jz6BmrAPhe7IzugwqIbxDP0A9uXAt7Oj6/2l4LBiHAzZw5A/iiVaEzYQM4ih/+rhygsX5gUarUC
 S62q7cHK61p/F5NCJD55dcstqMjcd/HszWCOssqppAF8qfxEDzyXopiaknOkMv3lUekC8VI2DTD
 tFrhx+YqbAs3TA24rMTuHm4ypjltuTWfK6enxYQ5Qk7+okrn9C+Ux++idW9EEErz8ZNjKHS7uq4
 EbbI95nXA3Xkg3vbBaPNIEFeznp40PopkbGjKV+C30P6Xq+JTI8DbAvw0wSPqau4MY6uiiXrZXc
 PzXlpvQOVZsIAp5wvqNaYkQFzooHjudAvrQhdb+WveuWMOQ9wCJWectvIgqbhdf/mNzT1SOMflV
 EzZVyPR61BP3bAwWzG7ZPLBDPFvqCxaWlp/sYZ38qsvOqX2jgW5ZC74g==
X-Google-Smtp-Source: AGHT+IGSYx/2s/I77NbgXSDQzy2iKqj4kWDgfiB1BGaUemuUJwvDGAQv87P3nlZ2ToVWih0UD5QQQA==
X-Received: by 2002:a05:6000:18a3:b0:42b:3e0a:64b8 with SMTP id
 ffacd0b85a97d-42f89f142b6mr11983145f8f.24.1765283442985; 
 Tue, 09 Dec 2025 04:30:42 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d353f75sm31598530f8f.42.2025.12.09.04.30.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 04:30:42 -0800 (PST)
Message-ID: <796814e9-62c2-44d2-bd8c-39e36f17f635@linaro.org>
Date: Tue, 9 Dec 2025 13:30:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] scripts: introduce
 scripts/update-aarch64-sysreg-code.py
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, cohuck@redhat.com, sebott@redhat.com
Cc: maz@kernel.org
References: <20251208163751.611186-1-eric.auger@redhat.com>
 <20251208163751.611186-2-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251208163751.611186-2-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 8/12/25 17:37, Eric Auger wrote:
> Introduce a script that takes as input the Registers.json file
> delivered in the AARCHMRS Features Model downloadable from the
> Arm Developer A-Profile Architecture Exploration Tools page:
> https://developer.arm.com/Architectures/A-Profile%20Architecture#Downloads
> and outputs the list of ID regs in target/arm/cpu-sysregs.h.inc
> under the form of DEF(<name>, <op0>, <op1>, <crn>, <crm>, <op2>).

Great idea!

> 
> We only care about IDregs with opcodes satisfying:
> op0 = 3, op1 within [0, 3], crn = 0, crm within [0, 7], op2 within [0, 7]
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> This was tested with https://developer.arm.com/-/cdn-downloads/permalink/Exploration-Tools-OS-Machine-Readable-Data/AARCHMRS_BSD/AARCHMRS_OPENSOURCE_A_profile_FAT-2025-09_ASL0.tar.gz
> 
> Discussion about undesired generated regs can be found in
> https://lore.kernel.org/all/CAFEAcA9OXi4v+hdBMamQv85HYp2EqxOA5=nfsdZ5E3nf8RP_pw@mail.gmail.com/
> ---
>   scripts/update-aarch64-sysreg-code.py | 133 ++++++++++++++++++++++++++
>   1 file changed, 133 insertions(+)
>   create mode 100755 scripts/update-aarch64-sysreg-code.py
> 
> diff --git a/scripts/update-aarch64-sysreg-code.py b/scripts/update-aarch64-sysreg-code.py
> new file mode 100755
> index 0000000000..c7b31035d1
> --- /dev/null
> +++ b/scripts/update-aarch64-sysreg-code.py
> @@ -0,0 +1,133 @@
> +#!/usr/bin/env python3
> +
> +# This script takes as input the Registers.json file delivered in
> +# the AARCHMRS Features Model downloadable from the Arm Developer
> +# A-Profile Architecture Exploration Tools page:
> +# https://developer.arm.com/Architectures/A-Profile%20Architecture#Downloads
> +# and outputs the list of ID regs in target/arm/cpu-sysregs.h.inc
> +# under the form of DEF(<name>, <op0>, <op1>, <crn>, <crm>, <op2>)
> +#
> +# Copyright (C) 2025 Red Hat, Inc.
> +#
> +# Authors: Eric Auger <eric.auger@redhat.com>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +
> +import json
> +import os
> +import sys
> +

[*]

> +# returns the int value of a given @opcode for a reg @encoding
> +def get_opcode(encoding, opcode):
> +    fvalue = encoding.get(opcode)
> +    if fvalue:
> +        value = fvalue.get('value')
> +        if isinstance(value, str):
> +            value = value.strip("'")
> +            value = int(value,2)
> +            return value
> +    return -1
> +
> +def extract_idregs_from_registers_json(filename):
> +    """
> +    Load a Registers.json file and extract all ID registers, decode their
> +    opcode and dump the information in target/arm/cpu-sysregs.h.inc
> +
> +    Args:
> +        filename (str): The path to the Registers.json
> +    returns:
> +        idregs: list of ID regs and their encoding
> +    """
> +    if not os.path.exists(filename):
> +        print(f"Error: {filename} could not be found!")
> +        return {}
> +
> +    try:
> +        with open(filename, 'r') as f:
> +            register_data = json.load(f)
> +
> +    except json.JSONDecodeError:
> +        print(f"Could not decode json from '{filename}'!")
> +        return {}
> +    except Exception as e:
> +        print(f"Unexpected error while reading {filename}: {e}")
> +        return {}
> +
> +    registers = [r for r in register_data if isinstance(r, dict) and \
> +                r.get('_type') == 'Register']
> +
> +    idregs = {}
> +
> +    # Some regs have op code values like 000x, 001x. Anyway we don't need
> +    # them. Besides some regs are undesired in the generated file such as
> +    # CCSIDR_EL1 and CCSIDR2_EL1 which are arrays of regs. Also exclude
> +    # VMPIDR_EL2 and VPIDR_EL2 which are outside of the IDreg scope we
> +    # are interested in and are tricky to decode as their system accessor
> +    # refer to MPIDR_EL1/MIDR_EL1 respectively
> +
> +    skiplist = ['ALLINT', 'PM', 'S1_', 'S3_', 'SVCR', \
> +                'CCSIDR_EL1', 'CCSIDR2_EL1', 'VMPIDR_EL2', 'VPIDR_EL2']

Since we might have to update this array, I'd move it (and the big
comment preceding) in [*].

> +
> +    for register in registers:
> +        reg_name = register.get('name')
> +
> +        is_skipped = any(term in (reg_name or "").upper() for term in skiplist)
> +
> +        if reg_name and not is_skipped:
> +            accessors = register.get('accessors', [])
> +
> +            for accessor in accessors:
> +                type = accessor.get('_type')
> +                if type in ['Accessors.SystemAccessor']:
> +                    encoding_list = accessor.get('encoding')
> +
> +                    if isinstance(encoding_list, list) and encoding_list and \
> +                       isinstance(encoding_list[0], dict):
> +                        encoding_wrapper = encoding_list[0]
> +                        encoding_source = encoding_wrapper.get('encodings', \
> +                                                               encoding_wrapper)
> +
> +                        if isinstance(encoding_source, dict):
> +                                op0 = get_opcode(encoding_source, 'op0')
> +                                op1 = get_opcode(encoding_source, 'op1')
> +                                op2 = get_opcode(encoding_source, 'op2')
> +                                crn = get_opcode(encoding_source, 'CRn')
> +                                crm = get_opcode(encoding_source, 'CRm')
> +                                encoding_str=f"{op0} {op1} {crn} {crm} {op2}"
> +
> +                # ID regs are assumed within this scope
> +                if op0 == 3 and (op1 == 0 or op1 == 1 or op1 == 3) and \
> +                   crn == 0 and (crm >= 0 and crm <= 7) and (op2 >= 0 and op2 <= 7):
> +                    idregs[reg_name] = encoding_str
> +
> +    return idregs
> +
> +if __name__ == "__main__":
> +    # Single arg expectedr: the path to the Registers.json file

Typo "expectedr".

> +    if len(sys.argv) < 2:
> +        print("Usage: scripts/update-aarch64-sysreg-code.py <path_to_registers_json>")
> +        sys.exit(1)
> +    else:
> +        json_file_path = sys.argv[1]
> +
> +    extracted_registers = extract_idregs_from_registers_json(json_file_path)
> +
> +    if extracted_registers:
> +        output_list = extracted_registers.items()
> +
> +        # Sort by register name
> +        sorted_output = sorted(output_list, key=lambda item: item[0])
> +
> +        # format lines as DEF(<name>, <op0>, <op1>, <crn>, <crm>, <op2>)
> +        final_output = ""
> +        for reg_name, encoding in sorted_output:
> +            reformatted_encoding = encoding.replace(" ", ", ")
> +            final_output += f"DEF({reg_name}, {reformatted_encoding})\n"
> +
> +        with open("target/arm/cpu-sysregs.h.inc", 'w') as f:
> +            f.write("/* SPDX-License-Identifier: BSD-3-Clause */\n\n")
> +            f.write("/* This file is autogenerated by ")
> +            f.write("scripts/update-aarch64-sysreg-code.py */\n\n")
> +            f.write(final_output)
> +        print(f"updated target/arm/cpu-sysregs.h.inc")

Fixed string (no formating) so no need for f- prefix.

Patch LGTM but it should have some unit test.

