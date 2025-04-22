Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74775C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 07:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u78AW-0003pQ-Pe; Tue, 22 Apr 2025 03:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u78AV-0003pA-9e
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:35:47 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u78AS-00050J-Cb
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:35:46 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so4721341f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 00:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745307341; x=1745912141; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ijv2G7uTCUHI7oqoBvIAD04vCinJu9ODrXMDZBTurxI=;
 b=r6EmJtIHgfvFl0bKNjc6P53Ux5PoyJ+f5GTHCfDZOMFgBVl41nTuhsU0WMNCXn5llk
 ZBL0+bhZFvCOeWUO+ldqiOpiKgmUSdCui34p4VvVJNlEninWfLytz0KJLkK78jMzIQ1r
 zFex7qN9Tn3QOEWEXs1AtOxRzxx395tblmI3FJvdGU16jGEsaVaBdYMHkqBZbeckzQ22
 e2TXlfembki8UKopPmI9n5kfb3ZjyCxjbzXF2RvoaexluLami0EzERBVedNWFK3ruK5T
 MxRfguQWdIjCWpnAQ5yUEVnYwOaU+WqTAqvtR3KliRhaW39/SCEDPDAjxVD3kyZw/E9s
 SYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745307341; x=1745912141;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ijv2G7uTCUHI7oqoBvIAD04vCinJu9ODrXMDZBTurxI=;
 b=l7Y9O/XN+LbpuSxwMcnNTbHyWYhKbE5Vm7Gakcnux0xVFMvPcOnAHd60dmzgylxIcE
 9BjrnO8uOKM+s9teTHfk5VpM3s0BX5A2VcFb7uhXufYNIAeUg6i3oas13Mz/6GGOx6b7
 Ve3J+6M6VP7vEOYUzQNh1GOgkKrB9grEFhY+dMgwVrW/eb7rdtToRMRmXG3GnitEjkUB
 TcGb5838Ujg/+JH6VJkGM5L9b3Gmdze9x1h6hN97eBQIIfVqjC/E5wElBwXyMZZrz7vi
 aLKgZk+1pjxKGW0pijyOeu0qV40c9XAnkkzQOxsfu4rSL22nWpWOuaJT0kfWC+iG3CKL
 /p1Q==
X-Gm-Message-State: AOJu0Yxc5z9BIVmCmk/bMfLZsnvzaM10WLizI9F/l757wGyC/MBIIRiw
 ngTio2kD59whf27XGj3jPwXti2sHwTo+wkvkwTZA6+9/erlsYtrsThxAn4ZQm1o=
X-Gm-Gg: ASbGncsPePfzrq4NPJlskma6FnuhYr0aEmfGXJOFYHy5sZDErm+mc91GMvWSs/K09rG
 FL7QSwZ9uBqrP5D8K3pVOpDrSY5uI5mPDXnxm+N0cEJHAy6Vc8+7UPT7ryhK9gSjm+4n9Lbw122
 VWQa/zBlRDBKz9Db45q4kmpeC26eSQguLXRRcow8g6wIz0wc5VYPq2JKz6EkpdHldbAxh7tEct9
 kChfIQ4iQhTYixL0kqyss10Z4M/KayR1S/YJrQrJc1sex2CsjxruTAXDho4E0wz8DByZq3Wow95
 2BBPlxjXzLzcHOGwYa6hoIdoqGaHpu1bw4qWJHAraXzrvseLtUqrbCY7dHeN0w1fJsCbWTKUREG
 4jNcygKfl
X-Google-Smtp-Source: AGHT+IHaAkQ1bVG5FOyplMfXW8ZjkQTZtngm2Fj3WkOo2NCBC5PBogMntufAPl/Yt666C1z30acnoQ==
X-Received: by 2002:a05:6000:4812:b0:39e:db6a:4744 with SMTP id
 ffacd0b85a97d-39efba87299mr10314865f8f.32.1745307340633; 
 Tue, 22 Apr 2025 00:35:40 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4235dasm14060952f8f.9.2025.04.22.00.35.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 00:35:40 -0700 (PDT)
Message-ID: <b846a12d-bbe3-4a88-aecd-b62cd57d297d@linaro.org>
Date: Tue, 22 Apr 2025 09:35:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 01/14] qapi: Rename TargetInfo structure as
 BinaryTargetInfo
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250418172908.25147-1-philmd@linaro.org>
 <20250418172908.25147-2-philmd@linaro.org> <878qnsagfo.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <878qnsagfo.fsf@pond.sub.org>
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

On 22/4/25 07:55, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> The QAPI-generated 'TargetInfo' structure name is only used
>> in a single file. We want to heavily use another structure
>> similarly named. Rename the QAPI one, since structure names
>> are not part of the public API.
>>
>> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   qapi/machine.json          | 12 ++++++------
>>   hw/core/machine-qmp-cmds.c |  4 ++--
>>   2 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index a6b8795b09e..3246212f048 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -275,15 +275,15 @@
>>   { 'command': 'query-current-machine', 'returns': 'CurrentMachineParams' }
>>   
>>   ##
>> -# @TargetInfo:
>> +# @BinaryTargetInfo:
>>   #
>> -# Information describing the QEMU target.
>> +# Information describing the QEMU binary target.
> 
> What's "the QEMU binary target"?  The QEMU binary's target?

For me 'qemu-system-aarch64' is a QEMU binary, but for Pierrick and
Richard it is the QEMU target, so I merged both names ¯\_(ツ)_/¯

This structure describes the static target configuration built into
a binary, i.e. TARGET_NAME=aarch64, TARGET_BIG_ENDIAN=false.

For the forthcoming single/heterogeneous binary, we don't have a
particular restricted configuration in the binary.

What about "Information describing the QEMU target configuration
built in a binary."?

> 
>  From the QMP user's point of view, perhaps "the QEMU process's target"
> would make more sense.

So maybe ProcessTargetInfo is a better structure name.

For heterogeneous target I suppose we'll return SYS_EMU_TARGET_HETERO
and we'll provide new QMP commands, possibly returning array of
ProcessTargetInfo.

> 
>>   #
>> -# @arch: the target architecture
>> +# @arch: the binary target architecture
> 
> Are there non-binary target architectures?

:) I won't update this line.

> 
>>   #
>>   # Since: 1.2
>>   ##
>> -{ 'struct': 'TargetInfo',
>> +{ 'struct': 'BinaryTargetInfo',
>>     'data': { 'arch': 'SysEmuTarget' } }
>>   
>>   ##
>> @@ -291,11 +291,11 @@
>>   #
>>   # Return information about the target for this QEMU
>>   #
>> -# Returns: TargetInfo
>> +# Returns: BinaryTargetInfo
>>   #
>>   # Since: 1.2
>>   ##
>> -{ 'command': 'query-target', 'returns': 'TargetInfo' }
>> +{ 'command': 'query-target', 'returns': 'BinaryTargetInfo' }
>>   
>>   ##
>>   # @UuidInfo:
>> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
>> index 3130c5cd456..408994b67d7 100644
>> --- a/hw/core/machine-qmp-cmds.c
>> +++ b/hw/core/machine-qmp-cmds.c
>> @@ -132,9 +132,9 @@ CurrentMachineParams *qmp_query_current_machine(Error **errp)
>>       return params;
>>   }
>>   
>> -TargetInfo *qmp_query_target(Error **errp)
>> +BinaryTargetInfo *qmp_query_target(Error **errp)
>>   {
>> -    TargetInfo *info = g_malloc0(sizeof(*info));
>> +    BinaryTargetInfo *info = g_malloc0(sizeof(*info));
>>   
>>       info->arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
>>                                    &error_abort);
> 


