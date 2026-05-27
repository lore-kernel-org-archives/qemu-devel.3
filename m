Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79519CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 15:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSFus-0005Sb-0G; Wed, 27 May 2026 11:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSFuq-0005SJ-Qi
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSFuo-0005Wg-1O
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779894684;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6gEJcXPLx6uljtp8toNSGlyGTFwh0jJNdOwJtnugnvM=;
 b=fV/LWujZsJ2VcqRvOCZPwdZs+qsSF+RcxJOp5lqQ0vKc1Keioar3ko5RyV5tnudFe7U+gy
 62tiK971V0duZNJ7whbpoB48NHO1dDJxUkZmX6s7Mv/IDCU6O9vm1AKLIFZZFDxyg1qLP2
 8U2mlMo3LzGrXymPTkAknDtfOpoPaWg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-1EBGY5J_NDCn9tkez_luxQ-1; Wed, 27 May 2026 11:11:23 -0400
X-MC-Unique: 1EBGY5J_NDCn9tkez_luxQ-1
X-Mimecast-MFC-AGG-ID: 1EBGY5J_NDCn9tkez_luxQ_1779894682
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44f1b4d0fb0so7313535f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 08:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779894681; x=1780499481;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6gEJcXPLx6uljtp8toNSGlyGTFwh0jJNdOwJtnugnvM=;
 b=lPdRuLGr+ZvStuDBDrwRi/jrUH9P3Alm2y2yejjPHNZKZxzk+lo/sWfTXWk3zpqaYg
 d9anMn5fhrwX1DdTdAxX47lg+hXIBT0S9DT7syPEA/xgFrAmxA9s5V+n9RxgfZ0/yCIv
 k/JIKyQhN3wNeVOBcaYNWfJhMAKeizxIQVjqo2OeA8YaZzo33rz0acXzyf5/sLsvL8xa
 mGxju0oZSy/4N8RX+j+Gy3gk1S6et0o3BTxN5+ccP+nRNIySfLlz/vntmeiLLe0ZzcHD
 68VBREWYJ+rLzUI5lv4ResCRnXgfE1thxVZGQ2aI5e77byR3JCa6tjnti375YLQ83Vsz
 9dqw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+fpAFBQ/jC5TkyQgd3iO4LbtsaIE6YKIm5sogPzjMq4f8qX+8DVUmFM16d4EkWBI23WWD5JBl4L1jW@nongnu.org
X-Gm-Message-State: AOJu0YwFur9kSX1HdvQCbPYxrpTRSBIK8NDXK0lx8bYXsh+B7j3GyxyU
 SwqW0XGsHmner6d708GTf0AeAp602mjVPyzYsTb8Wl7WZpHjiBQPSY5VDZ86bzBPRLKSIGBNvuH
 3XKfSOmZoclrSTa+36NEW/HuTDtm4l6plh5EhcB29hePKO+aPBbHPvWtp
X-Gm-Gg: Acq92OHc1S/AOME0zMoEYfL7DKLH61J+fND5v1ytWm0L2iB+Ds/iF9QEcn4a+lBWIY9
 p/r+xO55g3kFPGarArRlIsvZr9Vndh87jUOdD6WUs0o0pRxCPf60DE5MaoLvGzbOm49OzUdtP7Z
 EsmSWgZ6P7fWrWxEcjBbg0VvdFWr827UBxpaffHR2Q0fSkRRTWiHzqZrVPGwBCoTqVuuhAKk+WI
 J7ze1aCcAUB2I/NQWySg20CAEKUliX2iew51yKaRPAXDEYcNZz+q/14cqSk7hLR3NBxe3LqVERd
 fdUp3H39Akq1/KultBhHfqyqJpHnmLKkDyZLDRjNUAIkrRFbGqFw2XcUiKA9ZTKt5XvuuFWa2RR
 yUqHKfR0DAtMP0+luChGDqc6YYpO6sZEZlBvfNzGygpYKIPHTt0FAxJoxlW1hSuVje76j/wLNmK
 P/dmSB
X-Received: by 2002:a05:6000:1888:b0:441:1e1e:a050 with SMTP id
 ffacd0b85a97d-45eb38b8a09mr40132403f8f.16.1779894681519; 
 Wed, 27 May 2026 08:11:21 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:441:1e1e:a050 with SMTP id
 ffacd0b85a97d-45eb38b8a09mr40132343f8f.16.1779894681072; 
 Wed, 27 May 2026 08:11:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb557545sm7375629f8f.12.2026.05.27.08.11.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 08:11:20 -0700 (PDT)
Message-ID: <fcc79400-aef5-4f64-b094-a2d3eb99bfa0@redhat.com>
Date: Wed, 27 May 2026 17:11:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/18] scripts: Introduce
 scripts/update-aarch64-cpu-sysreg-properties.py
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-7-eric.auger@redhat.com>
 <903E3FE0-1286-4917-8A90-5186562D3A6D@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <903E3FE0-1286-4917-8A90-5186562D3A6D@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Khushit,

On 5/27/26 4:35 PM, Khushit Shah wrote:
>
>> On 19 May 2026, at 6:57 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> Introduce a script that takes as input the Registers.json file
>> delivered in the AARCHMRS Features Model downloadable from the
>> Arm Developer A-Profile Architecture Exploration Tools page:
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__developer.arm.com_Architectures_A-2DProfile-2520Architecture-23Downloads&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=PGWMyignA0NiDmTlyP7vOTHozBws_VN86yrVmSMkBp0&m=lifWLuAPiWiPtZHA1AnNwE36XKErpJppnuqSRce8eEXbd2seIXgOyghkIcv1h_tk&s=HRujmTCQGTPR11d90Orv_1iwKOLX_k3RFbkK_mx7A1s&e= 
>> and automates the generation of system register properties definitions.
>>
>> generates target/arm/cpu-idregs.h.inc containing definitions for
>> feature ID registers.
>>
>> We only care about IDregs with opcodes satisfying:
>> op0 = 3, op1 = {0,1,3}, crn = 0, crm within [0, 7], op2 within [0, 7]
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>> .../update-aarch64-cpu-sysreg-properties.py   | 168 ++++++++++++++++++
>> 1 file changed, 168 insertions(+)
>> create mode 100644 scripts/update-aarch64-cpu-sysreg-properties.py
>>
>> diff --git a/scripts/update-aarch64-cpu-sysreg-properties.py b/scripts/update-aarch64-cpu-sysreg-properties.py
>> new file mode 100644
>> index 0000000000..3571e228ee
>> --- /dev/null
>> +++ b/scripts/update-aarch64-cpu-sysreg-properties.py
>> @@ -0,0 +1,168 @@
>> +#!/usr/bin/env python3
>> +
>> +# This script takes as input the Registers.json file delivered in
>> +# the AARCHMRS Features Model downloadable from the Arm Developer
>> +# A-Profile Architecture Exploration Tools page:
>> +# https://urldefense.proofpoint.com/v2/url?u=https-3A__developer.arm.com_Architectures_A-2DProfile-2520Architecture-23Downloads&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=PGWMyignA0NiDmTlyP7vOTHozBws_VN86yrVmSMkBp0&m=lifWLuAPiWiPtZHA1AnNwE36XKErpJppnuqSRce8eEXbd2seIXgOyghkIcv1h_tk&s=HRujmTCQGTPR11d90Orv_1iwKOLX_k3RFbkK_mx7A1s&e= 
>> +# and outputs target/arm/cpu-sysreg-properties.c content.
>> +# There, initialize_cpu_sysreg_properties() populates arm64_id_regs array
>> +# with the name of each ID register and definition of all its fields
>> +# including their name and min/max bit under the form of the below pattern:
>> +#
>> +# /* CCSIDR2_EL1 */
>> +# ARM64SysReg *CCSIDR2_EL1 = arm64_sysreg_get(CCSIDR2_EL1_IDX);
>> +# CCSIDR2_EL1->name = "CCSIDR2_EL1";
>> +# arm64_sysreg_add_field(CCSIDR2_EL1, "NumSets", 0, 23);
>> +#
>> +# Copyright (C) 2026 Red Hat, Inc.
>> +#
>> +# Authors: Eric Auger <eric.auger@redhat.com>
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +
>> +import json
>> +import os
>> +import sys
>> +from aarch64_sysreg_helpers import extract_idregs_from_registers_json
>> +
>> +def collect_fields(item, bit_offset=0):
>> +    """
>> +    Recursively finds all field-like objects, handling Fields.Array,
>> +    Fields.ArrayField, and ConditionalField structures.
>> +    Applies bit_offset from containers to child fields.
>> +    """
>> +    fields = []
>> +    if not isinstance(item, dict):
>> +        return fields
>> +
>> +    _type = item.get('_type', '')
>> +
>> +    # Array types (for example CLIDR_EL1 Ctype<n>, Ttype<n>)
>> +    if _type == 'Fields.Array':
>> +        name_template = item.get('name') or item.get('label', '')
>> +        index_info = item.get('indexes', [{}])[0]
>> +        start_idx = index_info.get('start', 0)
>> +        count = index_info.get('width', 0)
>> +
>> +        full_range = item.get('rangeset', [{}])[0]
>> +        bit_start = full_range.get('start', 0) + bit_offset
>> +        elem_width = full_range.get('width', 0) // count if count else 0
>> +
>> +        for i in range(count):
>> +            idx = start_idx + i
>> +            # Correctly handle indexed names like Ctype1, Ctype2
>> +            field_name = name_template.replace('<n>', str(idx))
>> +            fields.append({
>> +                'name': field_name,
>> +                'rangeset': [{
>> +                    'start': bit_start + (i * elem_width),
>> +                    'width': elem_width
>> +                }],
>> +                '_type': 'Fields.Field'
>> +            })
>> +        return fields
>> +
>> +    # ConditionalFields
>> +    elif _type == 'Fields.ConditionalField':
>> +        inner_offset = bit_offset
>> +        if item.get('rangeset'):
>> +            # Parent container defines the absolute start bit
>> +            inner_offset = item['rangeset'][0].get('start', bit_offset)
>> +
>> +        for entry in item.get('fields', []):
>> +            inner = entry.get('field')
>> +            if inner:
>> +                fields.extend(collect_fields(inner, inner_offset))
>> +        return fields
>> +
>> +    # Normal Field Types
>> +    leaf_types = ['Fields.Field', 'Fields.ConstantField',
>> +                  'Fields.EnumeratedField', 'Fields.Bitfield']
>> +    if _type in leaf_types:
>> +        field_copy = item.copy()
>> +        if field_copy.get('rangeset'):
>> +            new_ranges = []
>> +            for r in field_copy['rangeset']:
>> +                nr = r.copy()
>> +                # Apply the cumulative offset to the field's start bit
>> +                nr['start'] = r.get('start', 0) + bit_offset
>> +                new_ranges.append(nr)
>> +            field_copy['rangeset'] = new_ranges
>> +        fields.append(field_copy)
>> +        return fields
>> +
>> +    # Traverse the hierarchy for other cases
>> +    for key in ['fields', 'values', 'fieldsets']:
>> +        for nested in item.get(key, []):
>> +            fields.extend(collect_fields(nested, bit_offset))
>> +
>> +    return fields
>> +
>> +
>> +def generate_sysreg_properties_from_registers_json(id_reg_names, raw_json_path):
>> +    with open(raw_json_path, 'r') as f:
>> +        register_data = json.load(f)
>> +
>> +    regs = {r.get('name'): r for r in register_data if r.get('_type') == 'Register'}
>> +
>> +    final_output = ""
>> +
>> +    for reg_name in id_reg_names:
>> +        register = regs.get(reg_name)
>> +        if not register:
>> +            continue
>> +
>> +        final_output += f"    IDREG_START({reg_name})\n"
>> +
>> +        unique_fields = {}
>> +        for fieldset in register.get('fieldsets', []):
>> +            candidates = collect_fields(fieldset)
>> +            for val in candidates:
>> +                name = (val.get('name') or val.get('label', '')).strip()
>> +                if not name or "RESERVED" in name.upper():
>> +                    continue
>> +                for r in val.get('rangeset', []):
>> +                    lsb = int(r.get('start'))
>> +                    width = r.get('width')
>> +                    msb = lsb + int(width) - 1
>> +
>> +                    # Only keep the fields with the highest MSB
>> +                    # needed fir CCSIDR_EL1
>> +                    if name not in unique_fields or msb > unique_fields[name]['msb']:
>> +                        unique_fields[name] = {'lsb': lsb, 'msb': msb, 'width': width}
>> +
>> +        # Sort decreasing lsbs
>> +        sorted_fields = sorted(unique_fields.items(),
>> +                               key=lambda x: x[1]['lsb'], reverse=True)
>> +
>> +        for name, bits in sorted_fields:
>> +            line = (f"    IDREG_FIELD({reg_name}, "
>> +                    f"{name}, {bits['lsb']}, {bits['width']})\n")
>> +            final_output += line
>> +        final_output += f"    IDREG_END({reg_name})\n"
>> +        final_output += "\n"
>> +
>> +    os.makedirs("target/arm", exist_ok=True)
>> +    with open("target/arm/cpu-idregs.h.inc", 'w') as f:
>> +        f.write("/* AUTOMATICALLY GENERATED, DO NOT MODIFY */\n\n")
>> +        f.write("/* SPDX-License-Identifier: GPL-2.0-or-later */\n\n")
>> +        f.write("/* IDREG_START(REG) */\n")
>> +        f.write("/* IDREG_FIELD(REG, FIELD, SHIFT, LENGTH) */\n")
>> +        f.write("/* ... */\n")
>> +        f.write("/* IDREG_END(REG) */\n\n")
>> +        f.write(final_output)
>> +
>> +if __name__ == "__main__":
>> +    if len(sys.argv) < 2:
>> +        print("Usage: python scripts/update-aarch64-cpu-sysreg-properties.py "
>> +              "<path_to_registers_json>")
>> +    else:
>> +        json_path = sys.argv[1]
>> +
>> +        id_regs_dict = extract_idregs_from_registers_json(json_path)
>> +        sorted_names = sorted(id_regs_dict.keys())
>> +
>> +        if sorted_names:
>> +            generate_sysreg_properties_from_registers_json(sorted_names, json_path)
>> +            print("Generated target/arm/cpu-idregs.h.inc")
>> -- 
>> 2.53.0
>>
> Hi Eric,
>
> Can we also have the arch-defined values in here? It is already available in Registers.json easily, would be great if we can validate at-least the user
> set values are architecturally valid.

Yes valid values should be easily extractable

Thanks

Eric
>
> Warm Regards,
> Khushit
>


