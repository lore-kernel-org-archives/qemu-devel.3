Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153F8EC01A9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 09:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4bRU-00037S-4t; Mon, 23 Mar 2026 05:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4bRF-00036M-1d
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:19:10 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4bRD-00064O-4w
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:19:08 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b980c65b97aso326628866b.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 02:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774257545; x=1774862345; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JmE6j+51sZw8DesHq1vtw9Wgt0FnSm/wzBYCwVR7eQg=;
 b=msEn7d5ZrpojlBAjqRKN936Dp1us8Li8JMh7FPUn2cFcKDycH0+2U0YaOH01rF/lsA
 gifzOMziM8W7X3745zuPtz0LPpV2cDW9VIsav6eNBq0R7w9kVxsDBPPNdjejJLnLJiT7
 lF8BNvK50GmW6KTIzr3tdPX1aita8aC/iKqGXLUD3iL7+7d9jPyTDXWsXt0wNpfmtHvs
 t+kPTkkp21OH6LJiUTU+hTKso0hKCWkYfFfOBjDCiSqypxKcOqmvfPzbK2URWsFqVcwa
 /bH4t1ygGkuWEeEIvofWqnwGNy1nsUI7HokMmV5OcrPOPxf4E2UJwmiOkkbLI7XQV3pw
 wHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774257545; x=1774862345;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JmE6j+51sZw8DesHq1vtw9Wgt0FnSm/wzBYCwVR7eQg=;
 b=Sxu7j5KnSyxH1ALJXF+qgHAYSpf1WuqXhX9LwHD6ui9GzNsPNJHzYB5jb5wJx8wdcu
 yu0OITOgmI4/sgCk3rjvXhEpJjrvmhs1cp8dwwi4rk4yGDtduNlJXGTrMUdZOCwdcieJ
 rOVHXQv5Dr+qSvwkRxwVj1POwHc3cOmhIC9EbCsooGrxhDLfYVDW1lrEU7MZm+HoIjAy
 IRwdIS3zW+45NEj9Hcq2ReXHaN/VaAHdxQJwqDEg2PGi6VDaSENiJzflN/WfnJLFMllM
 8WiOjkJn3V126Ga9FrtUNzFFwdGpOOtV5QVikLqIWR+pvUBKh1Qov7kuhXz0dLBzM1Qs
 UKkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO+XguwUraO7pQJ2lxKElBlWJfDIWWRfz4lTW9d4D6m5CnQRAwYdmyUGKuojOl0g1fUAIL0MAmd0e8@nongnu.org
X-Gm-Message-State: AOJu0YxshN1puS12X3/M6j9q7AGuKJuVLiZM+/QndfZ1v7qdZzoDmRtP
 P1C9YyF7N5TlFfBk9mR5nsbks+kR38JUYLyv1Dgci018lzWB8or6gf+vfzI015kNDEI=
X-Gm-Gg: ATEYQzz5hbyvGwec1OYJ8NxsWKeNcQQNujSy4yyZEfql6RquEyHtgkBfPBqvP7amnoI
 Aqp1dHQGDlIdQzdWZLY+mgRu1IG2DicbxrxsrCNfsHADXOp1v2k9Bm7NsSidvw9IOoc+izbRUm3
 HRxwEZZurytOOswlqG0C0Vf/vgBEc4xHS1Sc81/rluO75ppyNN1de6GfSKr6lq9/mwF8fcqCDRv
 tdmtEeDwXuv55kBKAKmH6OVikjLZQ489X4niheNUUchTlR/ikZ405t8t3jNyScJ3B++vY6P+jaS
 V9L7ScZNH/wUJvFtJ20hqPAIo1fLxyJ4MJ9Vn3IlwY6RZQfbGcR+ymM2UFjg54jceriU8EHmfPP
 +0KCqU8AVZ673VwFprAj0/QgL/KAeXgkQ4BqacrbhzFV9Y/PwKfhKrSMtXGFe7z+3Jo2CWbolp7
 dVXdQ5GYsGodQH3WZ4Jw+gAwmf649yXsjJM1MeC2hAq+YGCzbNqZYSIGJJ5zQ5C4YeLQ==
X-Received: by 2002:a17:907:c88d:b0:b97:98a4:1d6d with SMTP id
 a640c23a62f3a-b982f1ecf63mr720708066b.16.1774257544782; 
 Mon, 23 Mar 2026 02:19:04 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b98335de0b2sm466686166b.34.2026.03.23.02.19.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 02:19:03 -0700 (PDT)
Message-ID: <7c724cf7-c0d8-4e8b-8c74-8a78ace9f4d2@linaro.org>
Date: Mon, 23 Mar 2026 10:19:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 03/10] cpus: Introduce
 CPUClass::legacy_monitor_defs hook
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Yanan Wang <wangyanan55@huawei.com>
References: <20260320160811.28611-1-philmd@linaro.org>
 <20260320160811.28611-4-philmd@linaro.org>
 <7c54cfcf-fef6-41db-a1a8-382857371d3a@linaro.org>
 <9ed408a5-6b25-4d4e-aefc-59b413058ca6@linaro.org>
 <ada320b4-4204-43eb-a2da-5730641535de@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ada320b4-4204-43eb-a2da-5730641535de@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 21/3/26 20:51, Pierrick Bouvier wrote:
> On 3/21/26 8:19 AM, Philippe Mathieu-Daudé wrote:
>> On 20/3/26 23:01, Pierrick Bouvier wrote:
>>> On 3/20/26 9:08 AM, Philippe Mathieu-Daudé wrote:
>>>> Allow targets to register their legacy target_monitor_defs()
>>>> in CPUClass; check it first in get_monitor_def() otherwise
>>>> fall back to previous per-target helper.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>    include/hw/core/cpu.h | 3 +++
>>>>    monitor/hmp.c         | 3 ++-
>>>>    2 files changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>>>> index 04e1f970caf..072f58bead5 100644
>>>> --- a/include/hw/core/cpu.h
>>>> +++ b/include/hw/core/cpu.h
>>>> @@ -148,6 +148,8 @@ struct SysemuCPUOps;
>>>>     * @max_as: Maximum valid index used to refer to the address spaces
>>>> supported by
>>>>     *          the architecture, i.e., to refer to CPUAddressSpaces in
>>>>     *          CPUState::cpu_ases.
>>>> + * @legacy_monitor_defs: Array of MonitorDef entries. This field is
>>>> legacy,
>>>> + *                       use @gdb_core_xml_file to dump registers
>>>> instead.
>>>>     *
>>>>     * Represents a CPU family or model.
>>>>     */
>>>> @@ -174,6 +176,7 @@ struct CPUClass {
>>>>        const char *gdb_core_xml_file;
>>>>        const char * (*gdb_arch_name)(CPUState *cpu);
>>>>        const char * (*gdb_get_core_xml_file)(CPUState *cpu);
>>>> +    const MonitorDef *legacy_monitor_defs;
>>>>        void (*disas_set_info)(const CPUState *cpu, disassemble_info
>>>> *info);
>>>> diff --git a/monitor/hmp.c b/monitor/hmp.c
>>>> index c63da13e310..a2b6269d0ff 100644
>>>> --- a/monitor/hmp.c
>>>> +++ b/monitor/hmp.c
>>>> @@ -24,6 +24,7 @@
>>>>    #include "qemu/osdep.h"
>>>>    #include <dirent.h>
>>>> +#include "hw/core/cpu.h"
>>>>    #include "hw/core/qdev.h"
>>>>    #include "monitor-internal.h"
>>>>    #include "monitor/hmp.h"
>>>> @@ -1603,8 +1604,8 @@ void monitor_register_hmp_info_hrt(const char
>>>> *name,
>>>>     */
>>>>    int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
>>>>    {
>>>> -    const MonitorDef *md = target_monitor_defs();
>>>>        CPUState *cs = mon_get_cpu(mon);
>>>> +    const MonitorDef *md = cs->cc->legacy_monitor_defs ?:
>>>> target_monitor_defs();
>>>>        void *ptr;
>>>>        uint64_t tmp = 0;
>>>>        int ret;
>>>
>>> I'm not very fond of the "keep legacy callback for the N targets that
>>> might require it". Either set it for every target, using a default
>>> implementation if needed, or...
>>>
>>> As an alternative, we could use a dispatch function like:
>>>
>>> const MonitorDef *target_monitor_defs()
>>> {
>>>     switch (target_arch()) {
>>>     case
>>>       SYS_EMU_TARGET_X:
>>>         return X_target_monitor_defs();
>>>       SYS_EMU_TARGET_Y:
>>>         return Y_target_monitor_defs();
>>>     default:
>>>       return default_target_monitor_defs();
>>>     }
>>> }
>>>
>>> Personally, I prefer the dispatch approach, as it's very clear to see
>>> what happens per target. This solves the symbol duplication by manually
>>> name them differently.
>>>
>>> It's just a suggestion though, and I'm ok to have a per target field, as
>>> long as we enforce it to be set for all targets, and not using a
>>> 'legacy' callback for a few of them only.
>>>
>>> Pick the one you prefer :)
>>
>> My preference would be to remove this legacy code altogether, as
>> I'm pretty sure it isn't used anymore (see for the example the
>> issues RISC-V folks had with it before giving up).
> 
> I'm not sure what you mean.
> 
> If it's not used, then we simply remove it.
> If it's used, then let's keep it, but just make it consistent with all 
> targets without having a special case named "legacy". If it's here to 
> stay, it's not legacy.
> 
> Do you have something else in mind?

As a software engineer I prefer to deal with code. Unfortunately in my
experience with QEMU development, removing legacy code means endless
bikesheeding debates. I'm not judging they are bad, just they drain my
time and energy. I agree legacy code should be removed, but again this
is the QEMU project here, where we have bad habbits of adding new APIs
with the promise of removing the previous one but never finish API
conversions, not even marking legacy one. With that in mind, I think
mentioning "legacy" is still a good first step.

Anyway, I suppose what you are asking is me starting a poll for each
target array and ask "Who is still using this SPARC 'canrestore' monitor
command?" etc., wait 2 months for replies, then if possible deprecate
them, wait 2 more releases, and eventually remove. Then we'll be able
to link this file in single binary. As of today I'm not motivated enough
for that so I'm looking for alternatives. Looking at mailing list
archives I apparently started to tackle this 9 weeks ago, long enough to
keep working on the single binary with HMP code disable until we get
a working proof of concept; then revisit.

