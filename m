Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AB4D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 13:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSyDz-000465-K5; Tue, 09 Dec 2025 08:57:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSyDx-00045h-NV
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 08:57:54 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSyDv-0003Ys-Eh
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 08:57:53 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4779d47be12so51137225e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 05:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765288670; x=1765893470; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Lj6Cwynroty49vwh9NXFqjkMdhiMwNrXbvydn1kQYQ=;
 b=Nbvvj8+bxogfWn8g55OzvKhH407foxUXe98cPkhAUGO+94pzm41SX/s/XiEFYS50Rl
 I8vAjBx4xe1ujRLebZ8O+HeVZSEuTuF6Ej++mNrSnlE4GxgxPjJkvEZnj3m43oiyu0pe
 4N6KPIzSptJD2/WH94PMPQ0LSIknXpO0AD2y9vZkF1O3DqiTs0RJDoEmDPeleLVPtGi6
 /7YXhmIFDLw3MSzBH4KqmIkbqtvCHZSnhsVRmFV72fi+3/4f2AyObThJnZamsq3l0Dng
 Qnn4b/j61hOQg1bLMYuvm1afurWPGzPCvVPXIYgEqdwli+5dnIm9BDTFkRXLDk8HD+Ps
 UrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765288670; x=1765893470;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Lj6Cwynroty49vwh9NXFqjkMdhiMwNrXbvydn1kQYQ=;
 b=f6C+toeupjAR1+LNBCkvYNTEUrqVzvxxFLzLaGCTZ2L0M2QIEi4q4biKwqzNH1KZ7K
 h6DqLM4odfnTdMRHdGVANYlc/SStESW0/d9cYF1Hl59LBOVNytpaUmCaMItqkmQasBQG
 4PZjuIH+afwkLC9JymI7F5j74+MT6wUjuHdrgvxqgQAZ8jhy7ddCYPOcXTJAweGMZNUf
 TBdqRlb6L+OU1gv2IqP9ywj6L1eIK9bNmaeFPqCgyzuZYLl+VmSEJETE6DjUCBnHVsaI
 YkR9FGMZ517zofYhCg9Czdm5XC+7PR99Ftq5PTQucL6cBmN+IG6kWKmTFzyrS2WENAtN
 yAfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/RMY9bWZvuBJAMCqV38nLTl2LI0eyCdDPEIS8AWRxMIE4MalPxSkv/awZV8Zg33+vxNL+lXgOjrpD@nongnu.org
X-Gm-Message-State: AOJu0YyD9GN6SdoMmou8sInLUs9U3W1BHjEF3dY7SljhMO29KYh5S8j+
 /82+g+rVcwE9Ddbbk7YtyyhlINr1nNFSsObjZ1q2bWkczyvmthwvqbk7lQjBSnxB2b0=
X-Gm-Gg: ASbGnct79ApPklTw/hcpFoiHX+xsx+ft6Fm+wJqEY02wJK/l2zRvXnaUPUiiJ839JB8
 t4h/QO3i6tzsItUNJrGOJe/LHe8xY0xnAl0GpVuZnBQiVwlDM/1R6lABm8bC3fhjBA0cAMw34KQ
 lzx/9lgqJEMloT4sVjBwUwJOvezymmMLrr4K3sf3yHqd9M9060OsLKwBFaKsbAIXs4+7LKslkqu
 l/40a5K1QgQZjcCE7ncC+Cbb0HUrFXwLwcWlgRJ/TFCT1Bd6/Opc6hmD96aW1kzxDDjWwZi8w+n
 tg3+ksKPb2jCbsd4X5NY3+OKFSl+CwGOH4MJuB2xMSk6/5hy6kWbSv0X+ngo+Xx6tyCSeAGknnb
 1p/CeJSBAYi75CrQ3/EwzKqtJGPWyKry6z8/JNG5GfLs9pfPp5Q+/NWgld9gjrfrxCH/4Sf6t0m
 Zc9z3huj5QOLgl26LDA1Kh5Gz3z3CJY+CjHYKt88rr3LAFcbuM/K+Veg==
X-Google-Smtp-Source: AGHT+IFQpeoJOY7oHyI5Rar7nwjlNYAaLCIs1gKbIL//pTAPOnJCCOAx7z8qvPxR5SI2bCfKNPkx6g==
X-Received: by 2002:a05:600c:35d6:b0:477:b642:9dc6 with SMTP id
 5b1f17b1804b1-47939e48b2bmr109868225e9.34.1765288669531; 
 Tue, 09 Dec 2025 05:57:49 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d222491sm33136971f8f.22.2025.12.09.05.57.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 05:57:48 -0800 (PST)
Message-ID: <6c48d631-4433-4ec8-9726-d832dee086b6@linaro.org>
Date: Tue, 9 Dec 2025 14:57:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] scripts: introduce
 scripts/update-aarch64-sysreg-code.py
Content-Language: en-US
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, richard.henderson@linaro.org,
 cohuck@redhat.com, sebott@redhat.com
Cc: maz@kernel.org
References: <20251208163751.611186-1-eric.auger@redhat.com>
 <20251208163751.611186-2-eric.auger@redhat.com>
 <796814e9-62c2-44d2-bd8c-39e36f17f635@linaro.org>
 <3a23f4b5-ff63-4b63-8dd3-f0bdd250c2ac@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3a23f4b5-ff63-4b63-8dd3-f0bdd250c2ac@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 9/12/25 14:40, Eric Auger wrote:
> Hi Philippe,
> 
> On 12/9/25 1:30 PM, Philippe Mathieu-Daudé wrote:
>> On 8/12/25 17:37, Eric Auger wrote:
>>> Introduce a script that takes as input the Registers.json file
>>> delivered in the AARCHMRS Features Model downloadable from the
>>> Arm Developer A-Profile Architecture Exploration Tools page:
>>> https://developer.arm.com/Architectures/A-Profile%20Architecture#Downloads
>>>
>>> and outputs the list of ID regs in target/arm/cpu-sysregs.h.inc
>>> under the form of DEF(<name>, <op0>, <op1>, <crn>, <crm>, <op2>).
>>
>> Great idea!
>>
>>>
>>> We only care about IDregs with opcodes satisfying:
>>> op0 = 3, op1 within [0, 3], crn = 0, crm within [0, 7], op2 within
>>> [0, 7]
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>
>>> ---
>>>
>>> This was tested with
>>> https://developer.arm.com/-/cdn-downloads/permalink/Exploration-Tools-OS-Machine-Readable-Data/AARCHMRS_BSD/AARCHMRS_OPENSOURCE_A_profile_FAT-2025-09_ASL0.tar.gz
>>>
>>> Discussion about undesired generated regs can be found in
>>> https://lore.kernel.org/all/CAFEAcA9OXi4v+hdBMamQv85HYp2EqxOA5=nfsdZ5E3nf8RP_pw@mail.gmail.com/
>>>
>>> ---
>>>    scripts/update-aarch64-sysreg-code.py | 133 ++++++++++++++++++++++++++
>>>    1 file changed, 133 insertions(+)
>>>    create mode 100755 scripts/update-aarch64-sysreg-code.py
>>>
>>> diff --git a/scripts/update-aarch64-sysreg-code.py
>>> b/scripts/update-aarch64-sysreg-code.py
>>> new file mode 100755
>>> index 0000000000..c7b31035d1
>>> --- /dev/null
>>> +++ b/scripts/update-aarch64-sysreg-code.py
>>> @@ -0,0 +1,133 @@
>>> +#!/usr/bin/env python3
>>> +
>>> +# This script takes as input the Registers.json file delivered in
>>> +# the AARCHMRS Features Model downloadable from the Arm Developer
>>> +# A-Profile Architecture Exploration Tools page:
>>> +#
>>> https://developer.arm.com/Architectures/A-Profile%20Architecture#Downloads
>>> +# and outputs the list of ID regs in target/arm/cpu-sysregs.h.inc
>>> +# under the form of DEF(<name>, <op0>, <op1>, <crn>, <crm>, <op2>)
>>> +#
>>> +# Copyright (C) 2025 Red Hat, Inc.
>>> +#
>>> +# Authors: Eric Auger <eric.auger@redhat.com>
>>> +#
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +
>>> +
>>> +import json
>>> +import os
>>> +import sys
>>> +
>>
>> [*]
>>
>>> +# returns the int value of a given @opcode for a reg @encoding
>>> +def get_opcode(encoding, opcode):
>>> +    fvalue = encoding.get(opcode)
>>> +    if fvalue:
>>> +        value = fvalue.get('value')
>>> +        if isinstance(value, str):
>>> +            value = value.strip("'")
>>> +            value = int(value,2)
>>> +            return value
>>> +    return -1
>>> +
>>> +def extract_idregs_from_registers_json(filename):
>>> +    """
>>> +    Load a Registers.json file and extract all ID registers, decode
>>> their
>>> +    opcode and dump the information in target/arm/cpu-sysregs.h.inc
>>> +
>>> +    Args:
>>> +        filename (str): The path to the Registers.json
>>> +    returns:
>>> +        idregs: list of ID regs and their encoding
>>> +    """
>>> +    if not os.path.exists(filename):
>>> +        print(f"Error: {filename} could not be found!")
>>> +        return {}
>>> +
>>> +    try:
>>> +        with open(filename, 'r') as f:
>>> +            register_data = json.load(f)
>>> +
>>> +    except json.JSONDecodeError:
>>> +        print(f"Could not decode json from '{filename}'!")
>>> +        return {}
>>> +    except Exception as e:
>>> +        print(f"Unexpected error while reading {filename}: {e}")
>>> +        return {}
>>> +
>>> +    registers = [r for r in register_data if isinstance(r, dict) and \
>>> +                r.get('_type') == 'Register']
>>> +
>>> +    idregs = {}
>>> +
>>> +    # Some regs have op code values like 000x, 001x. Anyway we don't
>>> need
>>> +    # them. Besides some regs are undesired in the generated file
>>> such as
>>> +    # CCSIDR_EL1 and CCSIDR2_EL1 which are arrays of regs. Also exclude
>>> +    # VMPIDR_EL2 and VPIDR_EL2 which are outside of the IDreg scope we
>>> +    # are interested in and are tricky to decode as their system
>>> accessor
>>> +    # refer to MPIDR_EL1/MIDR_EL1 respectively
>>> +
>>> +    skiplist = ['ALLINT', 'PM', 'S1_', 'S3_', 'SVCR', \
>>> +                'CCSIDR_EL1', 'CCSIDR2_EL1', 'VMPIDR_EL2', 'VPIDR_EL2']
>>
>> Since we might have to update this array, I'd move it (and the big
>> comment preceding) in [*].
>>
>>> +
>>> +    for register in registers:
>>> +        reg_name = register.get('name')
>>> +
>>> +        is_skipped = any(term in (reg_name or "").upper() for term
>>> in skiplist)
>>> +
>>> +        if reg_name and not is_skipped:
>>> +            accessors = register.get('accessors', [])
>>> +
>>> +            for accessor in accessors:
>>> +                type = accessor.get('_type')
>>> +                if type in ['Accessors.SystemAccessor']:
>>> +                    encoding_list = accessor.get('encoding')
>>> +
>>> +                    if isinstance(encoding_list, list) and
>>> encoding_list and \
>>> +                       isinstance(encoding_list[0], dict):
>>> +                        encoding_wrapper = encoding_list[0]
>>> +                        encoding_source =
>>> encoding_wrapper.get('encodings', \
>>> +
>>> encoding_wrapper)
>>> +
>>> +                        if isinstance(encoding_source, dict):
>>> +                                op0 = get_opcode(encoding_source,
>>> 'op0')
>>> +                                op1 = get_opcode(encoding_source,
>>> 'op1')
>>> +                                op2 = get_opcode(encoding_source,
>>> 'op2')
>>> +                                crn = get_opcode(encoding_source,
>>> 'CRn')
>>> +                                crm = get_opcode(encoding_source,
>>> 'CRm')
>>> +                                encoding_str=f"{op0} {op1} {crn}
>>> {crm} {op2}"
>>> +
>>> +                # ID regs are assumed within this scope
>>> +                if op0 == 3 and (op1 == 0 or op1 == 1 or op1 == 3)
>>> and \
>>> +                   crn == 0 and (crm >= 0 and crm <= 7) and (op2 >=
>>> 0 and op2 <= 7):
>>> +                    idregs[reg_name] = encoding_str
>>> +
>>> +    return idregs
>>> +
>>> +if __name__ == "__main__":
>>> +    # Single arg expectedr: the path to the Registers.json file
>>
>> Typo "expectedr".
>>
>>> +    if len(sys.argv) < 2:
>>> +        print("Usage: scripts/update-aarch64-sysreg-code.py
>>> <path_to_registers_json>")
>>> +        sys.exit(1)
>>> +    else:
>>> +        json_file_path = sys.argv[1]
>>> +
>>> +    extracted_registers =
>>> extract_idregs_from_registers_json(json_file_path)
>>> +
>>> +    if extracted_registers:
>>> +        output_list = extracted_registers.items()
>>> +
>>> +        # Sort by register name
>>> +        sorted_output = sorted(output_list, key=lambda item: item[0])
>>> +
>>> +        # format lines as DEF(<name>, <op0>, <op1>, <crn>, <crm>,
>>> <op2>)
>>> +        final_output = ""
>>> +        for reg_name, encoding in sorted_output:
>>> +            reformatted_encoding = encoding.replace(" ", ", ")
>>> +            final_output += f"DEF({reg_name},
>>> {reformatted_encoding})\n"
>>> +
>>> +        with open("target/arm/cpu-sysregs.h.inc", 'w') as f:
>>> +            f.write("/* SPDX-License-Identifier: BSD-3-Clause */\n\n")
>>> +            f.write("/* This file is autogenerated by ")
>>> +            f.write("scripts/update-aarch64-sysreg-code.py */\n\n")
>>> +            f.write(final_output)
>>> +        print(f"updated target/arm/cpu-sysregs.h.inc")
>>
>> Fixed string (no formating) so no need for f- prefix.
>>
>> Patch LGTM but it should have some unit test.
> 
> thank you for the review.
> 
> Not sure what you mean by unit test? One solution could be to diff the
> result with former bash/awk I used to generation previously [1] but i
> guess it would be awkward to upstream the awk script we did not want in
> the first place. Otherwise we could check some random opcodes but it
> wouldn't mean the others are correct. To me the best way to validate the
> python script is to do [1] once but do not upstream that. Reviewing the
> new generated files against the previous content [3/3] is the best way
> to test the result. I mean using auto generation does not prevent from
> reviewing the generated stuff, especially because the generation is
> triggered manually as scripts/update_linux_headers.sh and should not
> happen very frequenty.
> 
> Thoughts?

I was thinking something minimal like what we use for decodetree,
see these 2 files:

  - tests/decode/meson.build
  - tests/decode/err_field10.decode

