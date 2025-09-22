Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75674CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 12:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0fFE-0006Mr-Q3; Mon, 22 Sep 2025 08:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0fEu-0006GV-Cv
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:02:01 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0fEq-0008UD-DU
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:01:51 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ee12807d97so3717538f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 05:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758542504; x=1759147304; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L0YG7B5JvnJYsLN0FfJ0GcaU1S84QUrOiHaYJQEtYDo=;
 b=uuxNePrYPusnV4ovoGzievnSQSS1Av7eyqqLJnhCID6mumpq/x87fyy7tvTMx7j1Om
 9CHoEf5LFimPY+Rnv0wpY093ccYb2NBAHKFX6sXFzKLC7nDd/iODsQTP5wFl2mUHNBcJ
 FGSv8qKAg7TwhCUfk2BnSgrOLHEJloq4Wi0pWyfxoaPTYOkAm1wnP2nafcnPBl7ieU7R
 MaarcwOkfU5Zc5TAK44IJJ8Dv5RdK0ebT6sf5JfCEGCp9iwT+4q/QtqvYMdocQrBXGjt
 K6UI2wtFsvlF1+iW/tIQTBhO4e4ZfgJAuiK1wjQc4ECxvs+9+Bl5zp/tWfHPXtruqugU
 Yrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758542504; x=1759147304;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L0YG7B5JvnJYsLN0FfJ0GcaU1S84QUrOiHaYJQEtYDo=;
 b=p/wHqwr5mnz51kzdCWkBv7muzdh47W0Sk5okQC2q1YCqxZA8Y+0NvfDsIp4FOFWj3G
 g+hLvV1kC4zqimiGRQGl1LWaJgT/wEbn7LXQSYRKENT+cdJOBea8XNT+vZK5PHxPKsFL
 V+uo3g612iy4z1YeCQf3DGGSdHz5h132Fnaf4lc735baCUgCJY1sUrFmu338ovR3UZCo
 u2Z/KKZOO4eJDk4IH0fQK2Mwh12MVCk2Mwv8wauHxqAgEwBBOowcrFw4ZrkmW63oKF+c
 QzkmoMGB2WWel/tqwTFuqHHmqaBFwmwdQ+Z4F42fCMITufzb/X6uzGq/16M1mDUCCIeT
 jS4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdjv58meVPPiGgZzZ3xLCLVr7bhvb1gT+63C1pgHGFh4VWMu0kZ8Gp7G+3iUrX0GQkTIrl66Z3OlWz@nongnu.org
X-Gm-Message-State: AOJu0YzOwZ6IVahglgQKawd5uA0NsL0j4CdxTU8DcHBEUG+NGXGSX8RA
 y48vFiPH4LGsU0Jr/flzbUMH0bxsMuTH9TrDCsBjwZZeI1sSuE4SD6Qz1mVXMN0KdEY=
X-Gm-Gg: ASbGncvKh3DyxGClNfmXZNL2sQPAzmoPnAIWhWU7p2Yxk8OeLLur7Od3AiicnsaVTkK
 wJ3Qe8csXsBfFj0t1ARBnP2hCfZ8Fdi+PDlcN35XjisTy0hJWo/9XQkqKMchHljGycns7Y8EL7p
 JN/AEtFw1T/lZyRReIuTB3yvQJEuLWpnk6aX/CQIoHDImAgivuBU5o6kJHKH9YuUkJ2cp+sY6sd
 oO07GvGDrntm1Up96zS+C+hzirDQdTZ4AyjxvWzSnGVlUfx4seNE0C5eRxLyoPpL8tju655T9cc
 b2pAemUFeJVMcfmXgpUiZ0m7wqBU0+G4ucnK52Jza6r058ItEP8ovpXB3G7AR6BWlwmB/zVpp6I
 6BcT0AgN/I2REgwJLS4HN16wYor3x4njW12sO6NRkLixxB0QdV2ee/moDycGWzcIevQ==
X-Google-Smtp-Source: AGHT+IF6w+/lgo7Rjbj0OK4Se/O2NClMC4Ur54cAoecl6SO680Vihqv6Yyljc9VdaWwVn9FegxOPUA==
X-Received: by 2002:a05:6000:605:b0:3ea:5f76:3f7a with SMTP id
 ffacd0b85a97d-3ee7e0116d6mr7225294f8f.22.1758542504080; 
 Mon, 22 Sep 2025 05:01:44 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46139122cb5sm236583215e9.8.2025.09.22.05.01.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 05:01:43 -0700 (PDT)
Message-ID: <95370c12-4bce-41cb-a514-a41ee4595d5c@linaro.org>
Date: Mon, 22 Sep 2025 14:01:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/19] hw/i386/pc_piix.c: restrict isapc machine to
 32-bit CPUs
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, pbonzini@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, imammedo@redhat.com,
 qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-2-mark.caveayland@nutanix.com>
 <3c2e9fbc-db80-4dd6-a1a5-deeabb8c0194@intel.com>
 <58c515a4-292e-4aec-b57e-73be89b9c322@nutanix.com>
 <a37565e6-77fc-4bf2-8c6b-6f1b22f6c01f@intel.com>
 <1e005bf5-4c02-4906-bed8-7d7a55681dd1@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1e005bf5-4c02-4906-bed8-7d7a55681dd1@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 28/8/25 12:42, Mark Cave-Ayland wrote:
> On 27/08/2025 12:50, Xiaoyao Li wrote:
> 
>> On 8/27/2025 7:10 PM, Mark Cave-Ayland wrote:
>>> On 26/08/2025 08:25, Xiaoyao Li wrote:
>>>
>>>> On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote:
>>>>> The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst 
>>>>> it is
>>>>> possible to specify any CPU via -cpu on the command line, it makes no
>>>>> sense to allow modern 64-bit CPUs to be used.
>>>>>
>>>>> Restrict the isapc machine to the available 32-bit CPUs, taking 
>>>>> care to
>>>>> handle the case where if a user inadvertently uses -cpu max then 
>>>>> the "best"
>>>>> 32-bit CPU is used (in this case the pentium3).
>>>>>
>>>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>>   hw/i386/pc_piix.c | 26 ++++++++++++++++++++++++++
>>>>>   1 file changed, 26 insertions(+)
>>>>>
>>>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>>>> index c03324281b..5720b6b556 100644
>>>>> --- a/hw/i386/pc_piix.c
>>>>> +++ b/hw/i386/pc_piix.c
>>>>> @@ -436,6 +436,19 @@ static void pc_set_south_bridge(Object *obj, 
>>>>> int value, Error **errp)
>>>>>   #ifdef CONFIG_ISAPC
>>>>>   static void pc_init_isa(MachineState *machine)
>>>>>   {
>>>>> +    /*
>>>>> +     * There is a small chance that someone unintentionally passes 
>>>>> "- cpu max"
>>>>> +     * for the isapc machine, which will provide a much more 
>>>>> modern 32-bit
>>>>> +     * CPU than would be expected for an ISA-era PC. If the "max" 
>>>>> cpu type has
>>>>> +     * been specified, choose the "best" 32-bit cpu possible which 
>>>>> we consider
>>>>> +     * be the pentium3 (deliberately choosing an Intel CPU given 
>>>>> that the
>>>>> +     * default 486 CPU for the isapc machine is also an Intel CPU).
>>>>> +     */
>>>>> +    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
>>>>> +        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
>>>>> +        warn_report("-cpu max is invalid for isapc machine, using 
>>>>> pentium3");
>>>>> +    }
>>>>
>>>> Do we need to handle the case of "-cpu host"?

"host" is not in valid_cpu_types[].

>>>
>>> I don't believe so. I wasn't originally planning to support "-cpu 
>>> max" for isapc, however Daniel mentioned that it could possibly be 
>>> generated from libvirt so it makes sense to add the above check to 
>>> warn in this case and then continue.
>>
>> "host" cpu type is the child of "max", so "-cpu host" will pass in the 
>> is_cpu_type_supported(), the same as "max".
>>
>> While we are changing "max" to "pentium3", I think it needs to do the 
>> same for "host". Otherwise, "-cpu host" won't get any warning and 
>> expose the native features to the VMs that are mostly not supposed to 
>> exist for isapc, e.g., the LM CUPID bit.
> 
> That makes sense given that for compatibility we would want to hide more 
> modern features from the guest, particularly if running legacy OSs.
> 
> I'll make this change and likely post a v7 soon as there are quite a lot 
> of changes here already, and wait for any further input from Jiri or 
> Daniel.
> 
> 
> ATB,
> 
> Mark.
> 
> 


