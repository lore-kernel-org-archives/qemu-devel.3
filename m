Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0662AC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 18:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubk2L-0004VN-5n; Tue, 15 Jul 2025 14:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubjT7-00082M-Vf
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 13:29:30 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubjT5-00022p-Ky
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 13:29:29 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-451d54214adso38658845e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 10:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752600565; x=1753205365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p77qLlmQm6mw1/vACqNGs3V36Q2nIwbu1jpy4ppWkNU=;
 b=NYsICV/D9aOcew9qYoMGINIku77O12Ew6cGOCfS5fiat5HuPR0z9IwGo3feMIxJO7K
 a1U0KIHv3+egNjxDToLdtBNfV7XbBA9rde5aBL3rQ8D483RPP0IyQP5SSh2hyTc1oVmE
 EW5Hy8rYi2XnEwGHMwtHHiUYS40l6Qqwhct9CjUYR9piyeJS8ERbkSl+sIawrprp/54i
 BLl42ySlmKbN2He3q9L9lI7qnhVZbKEIhtTrW2N1ErkHFkRsbteePUU++hM9LntVy89p
 QlFoQNK/POSWtSU5T+1tgwEiDLsn8s9XKHrcLGT5fIqOmIpfqcPY0V0FB5RvUVUYyV2v
 GvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752600565; x=1753205365;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p77qLlmQm6mw1/vACqNGs3V36Q2nIwbu1jpy4ppWkNU=;
 b=dphT2H3jAWsE0s33CcGMJSRDgucz0Rf4xddyi0Qk2sL0ojHHn42vMhg0YzAPi2anQm
 wcHbI+n4//cGmFxcqyq8fBDF+yqHE3u7+2XwNAG2ZfI9LtGhwNHHswBARXW6+O38XAPp
 uNQCFdWmjs/Yj1oNe3Wy3eLDftpoNe0MqktWHe2x1ee4ZcggNWOpz6Z57K/M7u33kHw8
 OSi7NLoJAKGeg8+xD4i3yzwIG511kna4M7aLZIubnTooMUPdPxoF2/pl0LjI2+ea/aB/
 W3KbfrTsymKbwfL2CdfHKtOpGr6s2UdyPHA14zZ+uD0/x92frnRdM98OSVV/Sa5yOS2K
 mRZw==
X-Gm-Message-State: AOJu0YxeilCWYoRgzvymmybuZ3f8G0643j1tuEMq0xQR5e+OiLLb128x
 UcO124NinsotkMUH4IqzbTdGR+ehOSEi05FMDr4zEWTnmsWRCq1gaPtlbIxr8BhDvV47I+9/Fo1
 QlO6A
X-Gm-Gg: ASbGncsahreQqSOXYpN07f/kKT8C6ey7WkUhGPPbtwGO8bapzGNITce94B+exc5G9Ep
 5QxJO+g78vDJ3M79zasZTVbXz6/XxWD0sfZYcFosg1exBwwYuk977o/ij0nbcmFYyxq8lTFmsb0
 ACF3r0SGlD8qEcdfjt179ant/uPIFGQ+ngSnpm6o+TZ/anQJaAgNv+rSSHo625NJK7DNsxf7dtS
 z04/oEtMeEwQ7VvJRLxcJLFyWKSgzbPyXcpYZ9eHAOC6SUD3ltK3PF65l9gOUFkAencsp7OhDkZ
 es6W42MIUFSn/HxAWGV3W4YnKob+NqxeN24n2rDJjr+wCZHVagiDVPaoa7Db7xp/OTXqp7Pyn3U
 lszrd71pEAkvyZHMVySMWbXlpnlReEA7wvZu+c/w/tAqJSSCzP7avH5Cq5Vw4zPnWYA==
X-Google-Smtp-Source: AGHT+IEetbCw3v3Wg7oRMJ4/uLwnGdMXt+12vLUongo9duAKsyNOh2w2TBpxLD2SByXbpUz8ryFiNw==
X-Received: by 2002:a05:600c:1c10:b0:450:6b55:cf91 with SMTP id
 5b1f17b1804b1-45623234fdemr62288915e9.6.1752600565129; 
 Tue, 15 Jul 2025 10:29:25 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562797b8d2sm24769385e9.8.2025.07.15.10.29.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 10:29:24 -0700 (PDT)
Message-ID: <6b4ed606-c0d2-4dfe-8795-a2af6bc500b6@linaro.org>
Date: Tue, 15 Jul 2025 19:29:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 28/69] qapi: Move definitions related to accelerators
 in their own file
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250703105540.67664-1-philmd@linaro.org>
 <20250703105540.67664-29-philmd@linaro.org>
 <db0b2ce0-e702-4f32-b284-29cccc8d67ba@linaro.org>
Content-Language: en-US
In-Reply-To: <db0b2ce0-e702-4f32-b284-29cccc8d67ba@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 3/7/25 18:42, Philippe Mathieu-Daudé wrote:
> Hi Markus,
> 
> On 3/7/25 12:54, Philippe Mathieu-Daudé wrote:
>> Extract TCG and KVM definitions from machine.json to accelerator.json.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>> ---
>>   MAINTAINERS                |  1 +
>>   qapi/accelerator.json      | 57 ++++++++++++++++++++++++++++++++++++++
>>   qapi/machine.json          | 47 -------------------------------
>>   qapi/qapi-schema.json      |  1 +
>>   accel/tcg/monitor.c        |  2 +-
>>   hw/core/machine-hmp-cmds.c |  1 +
>>   hw/core/machine-qmp-cmds.c |  1 +
>>   qapi/meson.build           |  1 +
>>   8 files changed, 63 insertions(+), 48 deletions(-)
>>   create mode 100644 qapi/accelerator.json
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b1cbfe115bc..c3ce0d37779 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -507,6 +507,7 @@ F: accel/Makefile.objs
>>   F: accel/stubs/Makefile.objs
>>   F: cpu-common.c
>>   F: cpu-target.c
>> +F: qapi/accelerator.json
>>   F: system/cpus.c
>>   Apple Silicon HVF CPUs
>> diff --git a/qapi/accelerator.json b/qapi/accelerator.json
>> new file mode 100644
>> index 00000000000..00d25427059
>> --- /dev/null
>> +++ b/qapi/accelerator.json
>> @@ -0,0 +1,57 @@
>> +# -*- Mode: Python -*-
>> +# vim: filetype=python
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +##
>> +# = Accelerators
>> +##
>> +
>> +{ 'include': 'common.json' }
> 
> common.json defines @HumanReadableText, ...
> 
> [...]
> 
>> +##
>> +# @x-query-jit:
>> +#
>> +# Query TCG compiler statistics
>> +#
>> +# Features:
>> +#
>> +# @unstable: This command is meant for debugging.
>> +#
>> +# Returns: TCG compiler statistics
>> +#
>> +# Since: 6.2
>> +##
>> +{ 'command': 'x-query-jit',
>> +  'returns': 'HumanReadableText',
>> +  'if': 'CONFIG_TCG',
> 
> ... which is *optionally* used here, triggering when
> TCG is not built in:
> 
> qapi/qapi-commands-accelerator.c:85:13: error: 
> ‘qmp_marshal_output_HumanReadableText’ defined but not used [- 
> Werror=unused-function]
>     85 | static void 
> qmp_marshal_output_HumanReadableText(HumanReadableText *ret_in,
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> We previously discussed that issue:
> https://mail.gnu.org/archive/html/qemu-devel/2021-06/msg02667.html
> 
> where you said:
> 
> "conditional commands returning an unconditional type is a bit
> of a code smell". Is it however a "non-smelly instances of this pattern"?

For now I'm queuing this patch moving only KVM definitions,
not the conditional TCG one.

Regards,

Phil.

