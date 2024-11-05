Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9667D40CE0
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 23:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SYA-0005EM-I7; Tue, 05 Nov 2024 18:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SY8-00059Q-Fw
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 18:01:24 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SY6-0007Ft-G1
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 18:01:24 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43152b79d25so51818255e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 15:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730847681; x=1731452481; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EfOtEP1B9ME/jsHOqIbM51aqo6s6BqnmSrMtp7A5WuM=;
 b=nvwRmtLAprheq7fKTofG3mu8a84tbnSno/lmuYorEQVtlQ68H+sjjLC4O0vJiNQQXa
 j9pPiq1PVTMzzOHyK+TANeTz7Dy+9NpKX29YlDzuLi+mPQg2A6yzYUzBUIp1TW8l35Fc
 62YDuI9fzpsbtR1rNZkrsmGn2ZmJLdQ1z/KU8MgppTFjma39IlVUvVxREF7Ex/MGTq0Y
 CvBT0TG+0xMGp1woYgcaNTmWCo6h/nVgAL85jxTZF2tUy3EaEuae9DbtaN/DxIHrp7TR
 qV1Zm2kEb3o/8+qRoiVYMiZuCdS+4ZTWw3Tf+KdJaFP/i+MIqMC67RXotSh83CCz+8j5
 0A2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730847681; x=1731452481;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EfOtEP1B9ME/jsHOqIbM51aqo6s6BqnmSrMtp7A5WuM=;
 b=It4q7Zrhmt8TuMxLqHRGse8wOKIrNwMjhuWz6FdORQH2BJP5w5LElIDd4B+AdOl7CK
 2StC2UBNZo4G7o1SguOsbExENyQywiZMYuba6839G7ZcB49KzyOnytMLq/Dwc8XnN0i0
 VHOEPqnaweMcS2oIx+5LunA69gaesFQobEqTsz3tVGP4J5gIB+eekgj8v0iL3SeKkAM3
 pMKcl2d09fMdvhausbtYJxaN/G1DzL+/5/GCbnXIJJRn1KK6z/k3h70TH2ZWpyC54wq3
 bbfNOnUkGJNm2pbUqJS3Rja5Gmje4EgXzhjQN2BYajKk4sewEfLEY+H0pK5QS1rgvL3p
 3CBQ==
X-Gm-Message-State: AOJu0Yw858kHoGK/P5kdXffimKcNpeDHZDCjb7xbk2JFKSMnjUizQVqm
 jRnflVX3TNWdQ/T+zGU11DtvdlT8rEa5BSFL30vP/X68k7Dbw87968vwslm+OwM=
X-Google-Smtp-Source: AGHT+IHu9F8yqNTILe/h03L6+6VKtOwUGt75RWVtdNVohaBB1n5aeWqge1voj29OHY3vwnSVwAgipQ==
X-Received: by 2002:a05:6000:1a8c:b0:37d:4ebe:1650 with SMTP id
 ffacd0b85a97d-381be907958mr17696292f8f.46.1730847680422; 
 Tue, 05 Nov 2024 15:01:20 -0800 (PST)
Received: from [172.20.143.32] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116ad3fsm17231228f8f.95.2024.11.05.15.01.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 15:01:19 -0800 (PST)
Message-ID: <accdb8b5-a73e-45d0-8086-82d69c97b569@linaro.org>
Date: Tue, 5 Nov 2024 23:01:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/19] target/microblaze: Rename CPU endianness property
 as 'little-endian'
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-2-philmd@linaro.org> <ZyqiPrf2wjP1yAPz@zapote>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZyqiPrf2wjP1yAPz@zapote>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi Edgar,

On 5/11/24 23:54, Edgar E. Iglesias wrote:
> On Tue, Nov 05, 2024 at 02:04:13PM +0100, Philippe Mathieu-Daudé wrote:
>> Rename the 'endian' property as 'little-endian' because the 'ENDI'
>> bit is set when the endianness is in little order, and unset in
>> big order.
> 
> Hi Phil,
> 
> Unfortunately, these properties are not only QEMU internal these got named
> from the bindings Xilinx choose way back in time.
> 
> This will likely break many of the Xilinx flows with automatic dts to
> qemu property conversions so I don't think it's a good idea to rename it.
> If you like to clarify things perhaps we could keep an alias for the old
> one?

Adding an alias is the safest way, I'll respin this patch.

Note however I'm worried about this fragile disconnect between Xilinx
dts conversion which isn't exercised on mainstream (in particular if
you get busy and can't review).

> 
> For example:
> https://github.com/torvalds/linux/blob/master/arch/microblaze/boot/dts/system.dts#L73
> 
> Cheers,
> Edgar
> 
> 
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/microblaze/petalogix_ml605_mmu.c | 2 +-
>>   hw/microblaze/xlnx-zynqmp-pmu.c     | 2 +-
>>   target/microblaze/cpu.c             | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
>> index b4183c5267d..df808ac323e 100644
>> --- a/hw/microblaze/petalogix_ml605_mmu.c
>> +++ b/hw/microblaze/petalogix_ml605_mmu.c
>> @@ -90,7 +90,7 @@ petalogix_ml605_init(MachineState *machine)
>>       object_property_set_int(OBJECT(cpu), "use-fpu", 1, &error_abort);
>>       object_property_set_bool(OBJECT(cpu), "dcache-writeback", true,
>>                                &error_abort);
>> -    object_property_set_bool(OBJECT(cpu), "endianness", true, &error_abort);
>> +    object_property_set_bool(OBJECT(cpu), "little-endian", true, &error_abort);
>>       qdev_realize(DEVICE(cpu), NULL, &error_abort);
>>   
>>       /* Attach emulated BRAM through the LMB.  */
>> diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
>> index 1bfc9641d29..43608c2dca4 100644
>> --- a/hw/microblaze/xlnx-zynqmp-pmu.c
>> +++ b/hw/microblaze/xlnx-zynqmp-pmu.c
>> @@ -90,7 +90,7 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
>>       object_property_set_bool(OBJECT(&s->cpu), "use-pcmp-instr", true,
>>                                &error_abort);
>>       object_property_set_bool(OBJECT(&s->cpu), "use-mmu", false, &error_abort);
>> -    object_property_set_bool(OBJECT(&s->cpu), "endianness", true,
>> +    object_property_set_bool(OBJECT(&s->cpu), "little-endian", true,
>>                                &error_abort);
>>       object_property_set_str(OBJECT(&s->cpu), "version", "8.40.b",
>>                               &error_abort);
>> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
>> index 135947ee800..e9f98806274 100644
>> --- a/target/microblaze/cpu.c
>> +++ b/target/microblaze/cpu.c
>> @@ -368,7 +368,7 @@ static Property mb_properties[] = {
>>       DEFINE_PROP_UINT8("use-non-secure", MicroBlazeCPU, cfg.use_non_secure, 0),
>>       DEFINE_PROP_BOOL("dcache-writeback", MicroBlazeCPU, cfg.dcache_writeback,
>>                        false),
>> -    DEFINE_PROP_BOOL("endianness", MicroBlazeCPU, cfg.endi, false),
>> +    DEFINE_PROP_BOOL("little-endian", MicroBlazeCPU, cfg.endi, false),
>>       /* Enables bus exceptions on failed data accesses (load/stores).  */
>>       DEFINE_PROP_BOOL("dopb-bus-exception", MicroBlazeCPU,
>>                        cfg.dopb_bus_exception, false),
>> -- 
>> 2.45.2
>>


