Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4C5C83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 08:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucKFd-0005o9-2d; Thu, 17 Jul 2025 04:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ucKFR-0005h1-MQ
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:45:52 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ucKFN-0003hS-V8
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:45:48 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a4f379662cso515518f8f.0
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 01:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752741944; x=1753346744; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xZ4OUL/O6x+anLhegvg4iCGqGFbYPglXhLHI/aOL+AA=;
 b=Ls/Br589EV/4SIHc1MTa/VYeX3sVd2E+WR96A3629rTSPOLAFLYiA2tg4a24bcQtp1
 YFKlFKDc82hi38VQw/yFprTXhZ45UcPmNNjZy4Qip34jIcsw8VJSB365jMMnaVg9l52Z
 eKcv9xbdj27BHVIE9lMYSeJtVuTtiXDA3s0Gju+DGtVUYXeo1wGvlVOZ/w5GC7ymNQ4S
 yIaBcHtaqWLWtZ4t/1fuZnlh+z/dEtj2FeiG0sJ2wbRLex9RWGuG7vvzqzP8SEM3CAKl
 E+q7n+cXVZUvkygwFDbgyrvqlvpSVajUt3ZYxKhuzNKimgUy4QoxTWnYIFnM1zq8MshO
 Pn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752741944; x=1753346744;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xZ4OUL/O6x+anLhegvg4iCGqGFbYPglXhLHI/aOL+AA=;
 b=VYmoaNJKyy+JRbcjkPdjNurgzqiEGHqH7PNVqSb1BbGDF4hld9uSorlxs3nEyVFhVH
 YtOt9Rv2aS3Kzu+mkDumJqycxGHF7m+/Qj/vSfj/cDF5qrQVKAuCbSccdS0i2l0KXE24
 +aFvPZlQK857iMenchzcgqKXMrlgALFekXQ10sgBFtoTLcaLiuSI9HhjCxg4AhYiBxHd
 uPICewNJ18mTSSFgT2xRs9CYMAzmN4ecTRWX6JPHlpsY2vUb0g0QK4h385DyHtBXhL5p
 3VdF4xwBwwv7TOe5koU2WY9tUp5xbowbTk4R0NuKDehf4xle+/azKrKtJK/Fkb8Btszp
 7AxQ==
X-Gm-Message-State: AOJu0YzIdfDR3IyITVieXyMunXWYXn14mCosRTu5WeoLWZGJvwhaGvBU
 oQzfXLHi+8CgZbrtdjBpv05fxxiML3brpk2GdrT0zCdsXCheB377pdSi5G6W05M65YM=
X-Gm-Gg: ASbGncsnvswhn5PJXiVTGsaVv9stag6dxVcR6ApwKm6teJyOWkTMtCTk7T5/0mUCCn3
 IgUS/xL9rricikiijJstiqRcnY7gkvbEDHO76IzVMHqD0erkpw8UBpwYBGn2hpxJO6BdOK0nouO
 MkZu76T1q0yxfJgJifjn/w04nkKF7iG0bbp2rX0CqwVEtFRNsyWkFCw3VTYpBACJ3UZgw5wMf59
 xe3g7Ivswa9Bv9g5V6gm73zwOfOdm4ktD2EDNs7U7hcA6nW4yCnLZsLLQ9s8GW9C0AXntQFNpVL
 aAHFYgslgqp3Som0Ee4vt7W2K7/XdYrRKK7ozKWcxwpg/OMGsZ2IaDtbUkUkaU5d7RoUZuALvoT
 tgLL5w/xHQJk9zX/bSFuyF/koMsUwDFjazdBmJg7bqfCYOVVMSJvj4w179+Xns6u95g==
X-Google-Smtp-Source: AGHT+IHP1oE7whlj7bL7NxqdbKQL2B4A0lGKBZweLux3egDh4x4vy/Gg1bFMH369T+DyMv3qn9vMxg==
X-Received: by 2002:a05:6000:430b:b0:3a5:26fd:d450 with SMTP id
 ffacd0b85a97d-3b60e50ff9fmr4167896f8f.47.1752741944033; 
 Thu, 17 Jul 2025 01:45:44 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc9298sm20109523f8f.44.2025.07.17.01.45.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 01:45:43 -0700 (PDT)
Message-ID: <118bd5fd-a340-4a27-ac3f-fb9774a65746@linaro.org>
Date: Thu, 17 Jul 2025 10:45:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 28/69] qapi: Move definitions related to accelerators
 in their own file
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>
References: <20250703105540.67664-1-philmd@linaro.org>
 <20250703105540.67664-29-philmd@linaro.org>
 <db0b2ce0-e702-4f32-b284-29cccc8d67ba@linaro.org>
 <877c08wnlt.fsf@pond.sub.org> <aHdvwYM7kXBU4cji@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aHdvwYM7kXBU4cji@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 16/7/25 11:24, Daniel P. Berrangé wrote:
> On Wed, Jul 16, 2025 at 10:23:26AM +0200, Markus Armbruster wrote:
>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>
>>> Hi Markus,
>>
>> I missed this one, sorry!
>>
>>> On 3/7/25 12:54, Philippe Mathieu-Daudé wrote:
>>>> Extract TCG and KVM definitions from machine.json to accelerator.json.
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>>
>> [...]
>>
>>>> diff --git a/qapi/accelerator.json b/qapi/accelerator.json
>>>> new file mode 100644
>>>> index 00000000000..00d25427059
>>>> --- /dev/null
>>>> +++ b/qapi/accelerator.json
>>>> @@ -0,0 +1,57 @@
>>>> +# -*- Mode: Python -*-
>>>> +# vim: filetype=python
>>>> +#
>>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>>> +
>>>> +##
>>>> +# = Accelerators
>>>> +##
>>>> +
>>>> +{ 'include': 'common.json' }
>>>
>>> common.json defines @HumanReadableText, ...
>>>
>>> [...]
>>>
>>>> +##
>>>> +# @x-query-jit:
>>>> +#
>>>> +# Query TCG compiler statistics
>>>> +#
>>>> +# Features:
>>>> +#
>>>> +# @unstable: This command is meant for debugging.
>>>> +#
>>>> +# Returns: TCG compiler statistics
>>>> +#
>>>> +# Since: 6.2
>>>> +##
>>>> +{ 'command': 'x-query-jit',
>>>> +  'returns': 'HumanReadableText',
>>>> +  'if': 'CONFIG_TCG',
>>>
>>> ... which is *optionally* used here, triggering when
>>> TCG is not built in:
>>>
>>> qapi/qapi-commands-accelerator.c:85:13: error: ‘qmp_marshal_output_HumanReadableText’ defined but not used [-Werror=unused-function]
>>>     85 | static void qmp_marshal_output_HumanReadableText(HumanReadableText *ret_in,
>>>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> cc1: all warnings being treated as errors
>>
>> This is a defect in the QAPI code generator.  More below.
>>
>>> We previously discussed that issue:
>>> https://mail.gnu.org/archive/html/qemu-devel/2021-06/msg02667.html
>>>
>>> where you said:
>>>
>>> "conditional commands returning an unconditional type is a bit
>>> of a code smell". Is it however a "non-smelly instances of this pattern"?
>>
>> The instance discussed there wasn't.
>>
>> You ran into it when you made TPM commands conditional on CONFIG_TPM
>> without also making the types they return conditional.

Indeed, I now remembered it:
https://lore.kernel.org/qemu-devel/87r1haasht.fsf@dusky.pond.sub.org/

>>  The proper
>> solution was to make the types conditional, too.  Avoided generating
>> dead code.  I told you "The user is responsible for making T's 'if' the
>> conjunction of the commands'."
>>
>> Some of the commands returning HumanReadableText are unconditional, so
>> said conjunction is also unconditional.  So how do we end up with unused
>> qmp_marshal_output_HumanReadableText()?
>>
>> A qmp_marshal_output_T() is only ever called by qmp_marshal_C() for a
>> command C that returns T.
>>
>> We've always generated it as a static function on demand, i.e. when we
>> generate a call.
> 
> ..snip..
> 
>> I need to ponder this to decide on a solution.
> 
> Functionally the redundat function is harmless, so the least effort
> option is to change the generated QAPI headers to look like
> 
>    #pragma GCC diagnostic push
>    #pragma GCC ignored "-Wunused-function"
> 
>    ... rest of QAPI header...
> 
>    #pragma GCC diagnostic pop

I agree, the same was suggested as comment in my previous patch
https://lore.kernel.org/qemu-devel/20210609184955.1193081-2-philmd@redhat.com/

Markus, WDYT?

Regards,

Phil.

