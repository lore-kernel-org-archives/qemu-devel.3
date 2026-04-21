Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DE8F94CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 22:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFJGM-0000p4-1X; Tue, 21 Apr 2026 18:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFJGK-0000oh-4P
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:08:08 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFJGI-00048A-EU
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:08:07 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso24489205e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 15:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776809285; x=1777414085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VL/Yh+KkQ7HvALQGUQKGccFZ6xwoRg362K26LMJMooI=;
 b=IGfja05/ytj3OB8XZ+NQoF0R++SLuKKA0iryCcWEJC0D4ifLM3mWAhDt6GApouLiKI
 wogBAjkmbxs4ArKSF3zVz/7LInwjT6ulTrAoWev0b3RNaGuO9cciuSUaGM4KfLA9M1GQ
 vjda+tsfeWfG/uyMleQb4sYDqYRiqDdvkFbPSWBsSpQ3v1QK5ko1PStoJSyBg88XRdcM
 s1st/Vrd38c6oqQtPwdDb8xPmEDak2cvusvHyBnGwO17u7Bo+tN94L5y+JvKBOFJ9oKD
 MyUc9HJds+5exNjKjSodU3b0DX8jGSi9fNePsR0aek+zZtKeqyrS2U+q2Eam5/Nxa2O/
 ARsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776809285; x=1777414085;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VL/Yh+KkQ7HvALQGUQKGccFZ6xwoRg362K26LMJMooI=;
 b=CqkpzFlsCEaWkqh66FZLc1Dvoo1FJ5nL2TgaZAMKjwqvibfp0kVUbCCp4Jn5pTXNr8
 xALxIuac6G98Zju7msz30VEprZSpmgEJzhvsaN3yTd5mXPTQ+PF8Bc8YnGHOuD7Jez+c
 KQQ8OUkt6AEYYyEjAGVTcKYFMT0IuwJFfF7zZG/tRO2deJJfRdOQlQO/PbA8HLYOuEaC
 B5Lj9Dd4E1SvdyoFT+wFvyo1zdXT3ED10R6s2o/906Imb4ds5Bv1kjXfqKPL+DZ3iobx
 4GokBYrCuNsb2aGDPUK4zvOzSSKMBWH3U1hcKZ+J5SJyYw3K3l/p7RUQun4htCS+XR14
 Es3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ePqc5xSpO3gOxHPK21EU+8gsRWiUJzYK5RJgCuc6VYUsHUaPsETyTn1BDU3u6iWjkChqX0pBeBCMk@nongnu.org
X-Gm-Message-State: AOJu0YxqN2zAFT3TFOLE40M5jLhWA1rNJPMrsCYex7XedqhtFwUxPZC8
 k9DLxzr3A3bAhC4ElG1hIekR6au2Zz2kAO2O9MeHQhILQsqKyAlgQXrYpyrfj+uVmYo=
X-Gm-Gg: AeBDiesVrx494zajYyf4YWOv6qVyKDJj1VgwaZSbu8EmaQMRhqL8DpilAZbG4CWjIt0
 hPGp3gRc21Q+IQYPZs0VtPmFmRO/gIYs2wrt9DklXYBGfBO15ZpI+3zNC+W/Fgce0WhBbDR+9BZ
 POleo26S7vm2ztqpC9Ba3CDxlsMHJwStFWMCHKlM5rqEfMBGIJacQZfG3bo+ypu037/jXnCulnF
 jMXrtF/4Oob6BpDFFD9c4Wzv8WGNWvqtA1YsAACqYZSji5wh73aC0Z6L7mAs9+hHHd4iHgfRn8w
 833AAuW2XcoOONEdfSaANbR9+vsSEYadcHmsiASo8GpwQEUsqQPxQ36Y4FdPJStbqsXH6ieM8tQ
 vZ7Ws+JYfzebKqk/jGqvFzhD324bRnyhtcdzAVQdOebNxlBWpC4IOD1tofstmWhOlFFvxexcJ9+
 /fBU8Qrexrv1ZVao83WgqfNF/43oPltHr9Iy+NkghjR9DLsybZH+wLcRusaKD0W5l8WS3q5kFSW
 tMm
X-Received: by 2002:a05:600c:4f13:b0:489:1a65:dd6e with SMTP id
 5b1f17b1804b1-4891a65de3emr179663305e9.8.1776809284685; 
 Tue, 21 Apr 2026 15:08:04 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8188sm421242925e9.2.2026.04.21.15.08.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 15:08:04 -0700 (PDT)
Message-ID: <f01dede3-543e-440c-b556-192c3672c46c@linaro.org>
Date: Wed, 22 Apr 2026 00:08:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] hw/hexagon: Add support for cfgbase
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 pierrick.bouvier@oss.qualcomm.com, Sid Manning <sidneym@quicinc.com>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
 <20260416210305.2255579-6-brian.cain@oss.qualcomm.com>
 <cf7e3db0-777a-4dfe-ad41-ac74d992973c@linaro.org>
In-Reply-To: <cf7e3db0-777a-4dfe-ad41-ac74d992973c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 21/4/26 23:52, Philippe Mathieu-Daudé wrote:
> On 16/4/26 23:03, Brian Cain wrote:
>> From: Sid Manning <sidneym@quicinc.com>
>>
>> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>> Signed-off-by: Sid Manning <sidneym@quicinc.com>
>> ---
>>   hw/hexagon/hexagon_dsp.c | 11 +++++++++++
>>   target/hexagon/cpu.c     |  1 -
>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
>> index d5df87605f4..649cafcf8ec 100644
>> --- a/hw/hexagon/hexagon_dsp.c
>> +++ b/hw/hexagon/hexagon_dsp.c
>> @@ -73,6 +73,7 @@ static void hexagon_common_init(MachineState 
>> *machine, Rev_t rev,
>>                                   const struct hexagon_machine_config 
>> *m_cfg)
>>   {
>>       MemoryRegion *address_space;
>> +    MemoryRegion *config_table_rom;
>>       MemoryRegion *sram;
>>       DeviceState *glob_regs_dev;
>> @@ -86,6 +87,12 @@ static void hexagon_common_init(MachineState 
>> *machine, Rev_t rev,
>>       address_space = get_system_memory();
>> +    config_table_rom = g_new(MemoryRegion, 1);
>> +    memory_region_init_rom(config_table_rom, NULL, "config_table.rom",
>> +                           sizeof(m_cfg->cfgtable), &error_fatal);
>> +    memory_region_add_subregion(address_space, m_cfg->cfgbase,
>> +                                config_table_rom);
>> +
>>       sram = g_new(MemoryRegion, 1);
>>       memory_region_init_ram(sram, NULL, "ddr.ram",
> 
> Better if we can keep reference to these things in the machine
> state. We can add HexagonMachineState (or HexagonCommonMachineState)
> which expands MachineState and have those fields:
> 
> #define TYPE_HEXAGON_MACHINE  MACHINE_TYPE_NAME("hexagon-common")
> OBJECT_DECLARE_SIMPLE_TYPE(HexagonMachineState, HEXAGON_MACHINE)
> 
> struct HexagonMachineState {
>      MachineState parent_obj;
> 
>      MemoryRegion sram;
>      MemoryRegion config_table_rom;
>      ...
> };
> 
> static const TypeInfo hexagon_machine_types[] = {
>      {
>          .name           = TYPE_HEXAGON_MACHINE,
>          .parent         = TYPE_MACHINE,
>          .instance_size  = sizeof(HexagonMachineState),
>          .abstract       = true,
>      }, {
>          .name = MACHINE_TYPE_NAME("V66G_1024"),
>          .parent = HEXAGON_MACHINE,
>          .class_init = v66g_1024_init,
>      },
> };
> 
> static void hexagon_common_init(MachineState *machine, Rev_t rev,
>                                  const struct hexagon_machine_config 
> *m_cfg)
> {
>      HexagonMachineState *s = HEXAGON_MACHINE(machine);
> 
>      ...
> 
>      memory_region_init_rom(&s->config_table_rom, NULL,
>                             "config_table.rom",
>                             sizeof(m_cfg->cfgtable), &error_fatal);
>      memory_region_add_subregion(address_space, m_cfg->cfgbase,
>                                  &s->config_table_rom);
> 
>      ...
> 
> This also helps during debugging because you can easily introspect
> from the machine to the particular MemoryRegion (in this example).

And now I see you add HexagonVirtMachineState later...

Maybe the following OOP inheritance is still useful:

   HexagonVirtMachineState -> HexagonCommonMachineState -> MachineState

