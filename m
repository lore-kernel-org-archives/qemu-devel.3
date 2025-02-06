Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B4FC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg2KV-0000ML-NK; Thu, 06 Feb 2025 08:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg2KT-0000LI-8e
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:54:05 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg2KQ-0004dQ-E0
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:54:05 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-437a92d7b96so9241605e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 05:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738850041; x=1739454841; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ASzU1/31udRekav0LredBl1zTrkGZo/IyaNINrQ1nRw=;
 b=ilMMGvOrfhyrnbmb4TSSKwO5vy98Xmoit4MlDDE3/lbpNkgQbcclYGstTTrm5j9/bY
 ZJ68pmmCjk9e4ul0lQLiLY5rG+H87aFR0zzyvXrTTqOawh49Sf1w4JV5Q/9Gwxlm+qze
 0/5fjEoLfJLdBPw1RGyuXf6Ay2MzO/M40knmnW2GESekrMcL0vCZ9VbSVboxcQADftFX
 Thx5BZ/0lPjG4ECFxlrIsLbeS288c1hcM4WhWrkG3MekCe7aTHNAohTc/inaqhZwKNzD
 0AoRgnfU2UGSV1nXUm3MckDtn34EloNo/ZCNrqr5X6jOs153nCCE68QYOqiABZNP+KrP
 d6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738850041; x=1739454841;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ASzU1/31udRekav0LredBl1zTrkGZo/IyaNINrQ1nRw=;
 b=UsrcdDOkAE6OLpNP0opvGXd9NqBJ9cySgGhDIAyYgpYJLLNMTe8xlpx0Pia6EgVvac
 QGYc/DbrNZMHVoIbDz86llI+yPAVLJFZlPZu8Wezsap6RPq1Hj0GmA8a1baQxI+Bx2og
 1S6DypNkXdxjs1Pq6dVeuRETcMuzp3zRJggOuh7ZazgUx9SAcKBZMGJLlOkyDPLvGi5q
 BXFxScbhPqcs6PDR/gVhdBvYO6t+STFpldrqpJJKtgqUhPzBRgGKh6Wh7N7Ray51rnRQ
 ZdjuqNvojDcJDS5BNe5tRL1A25S5JAethKCfOKk117lk58oMGV9aIwYg0kXE8gZ6krL3
 wxlg==
X-Gm-Message-State: AOJu0Yzoeco1TWz/tx4ze/eDhicfassVJwgfFF96R1/oHGo/MVNkFL0q
 ol18ImFHrJbVD8IwB9VF1PkeUgmy2bd3g+U7fu8vc98qxk9tIu+WaJ3PqZdVNKE=
X-Gm-Gg: ASbGncvxnE1171iafpgBjL0SXHRTtaXMPdia1vx8aMKVR114wIUWX/BRFC7g6PUasuj
 iOGORcId5QLDCBOVP1vCvbMxjZgPT4Be7aRTcpQeJvfXdaMfu0qt1Q3BqtmXjKnVn5qx1wRJADS
 cijpc7ZxSMG005hZN3kpC9Dqe+46QUCB2eC5nY0s4lid1mGtIXuaBtpBuZ4UUF1lA6qmlwwM3PP
 ILsgFdjoZFywh04KZHnBb/6E5p6SpFYImeqyU04ffpt0iagXQNVbmLIDyPQd5Aqq9H7NmvWwpU8
 ahuOT0cYy2jbLyFgZa/cv8/v80Cwk/p+l/Bppnhua8hJfTtxPSpzB8swfvU=
X-Google-Smtp-Source: AGHT+IF1bF2Y6o6WrgrDO2nOAr+RKu1Skrd+Sxr+4Yc3GuPCQGfxFcPT6VyJdYoTnzH5KQ2CwDzoxg==
X-Received: by 2002:a05:600c:568d:b0:438:a290:3ce0 with SMTP id
 5b1f17b1804b1-4390ef6aaadmr47753945e9.8.1738850040531; 
 Thu, 06 Feb 2025 05:54:00 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfc87desm19748475e9.25.2025.02.06.05.53.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 05:54:00 -0800 (PST)
Message-ID: <4624f149-76d0-4da5-8f13-8c015043c335@linaro.org>
Date: Thu, 6 Feb 2025 14:53:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/16] hw/microblaze: Support various endianness for
 s3adsp1800 machines
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Anton Johansson
 <anjo@rev.ng>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20250206131052.30207-1-philmd@linaro.org>
 <20250206131052.30207-12-philmd@linaro.org> <Z6S3Mgt1G7fIjeBB@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z6S3Mgt1G7fIjeBB@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Daniel,

On 6/2/25 14:20, Daniel P. Berrangé wrote:
> On Thu, Feb 06, 2025 at 02:10:47PM +0100, Philippe Mathieu-Daudé wrote:
>> Introduce an abstract machine parent class which defines
>> the 'little_endian' property. Duplicate the current machine,
>> which endian is tied to the binary endianness, to one big
>> endian and a little endian machine; updating the machine
>> description. Keep the current default machine for each binary.
>>
>> 'petalogix-s3adsp1800' machine is aliased as:
>> - 'petalogix-s3adsp1800-be' on big-endian binary,
>> - 'petalogix-s3adsp1800-le' on little-endian one.
> 
> Does it makes sense to expose these as different machine types ?
> 
> If all the HW is identical in both cases, it feels like the
> endianness could just be a bool property of the machine type,
> rather than a new machine type.

Our test suites expect "qemu-system-foo -M bar" to work out of
the box, we can not have non-default properties.

(This is related to the raspberry pi discussion in
https://lore.kernel.org/qemu-devel/20250204002240.97830-1-philmd@linaro.org/).

My plan is to deprecate 'petalogix-s3adsp1800', so once we
remove it we can merge both qemu-system-microblaze and
qemu-system-microblazeel into a single binary.

If you don't want to add more machines, what should be the
endianness of the 'petalogix-s3adsp1800' machine in a binary
with no particular endianness? Either we add for explicit
endianness (fixing test suites) or we add one machine for
each endianness; I fail to see other options not too
confusing for our users.

This approach is the same I took to merge MIPS*, SH4* and
Xtensa* machines in endianness-agnostic binaries.

Also the same I'm using to merge 32/64-bit targets into the
same binaries.
Assuming we have a qemu-system-x86 binary able to run i386 and
x86_64 machines, what do you expect when starting '-M pc'? How
to not confuse users wanting to run FreeDOS in 32-bit mode?

Again, IMO having '-M pc,mode=32' is simpler, but that breaks
the test suites assumptions than machines can start with no
default values (see QOM introspection tests for example).

> 
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/microblaze/petalogix_s3adsp1800_mmu.c | 62 +++++++++++++++++++-----
>>   1 file changed, 51 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
>> index 96aed4ed1a3..aea727eb7ee 100644
>> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
>> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
>> @@ -55,8 +55,17 @@
>>   #define ETHLITE_IRQ         1
>>   #define UARTLITE_IRQ        3
>>   
>> +typedef struct PetalogixS3adsp1800MachineClass {
>> +    MachineClass parent_obj;
>> +
>> +    bool little_endian;
>> +} PetalogixS3adsp1800MachineClass;
>> +
>>   #define TYPE_PETALOGIX_S3ADSP1800_MACHINE \
>> -            MACHINE_TYPE_NAME("petalogix-s3adsp1800")
>> +            MACHINE_TYPE_NAME("petalogix-s3adsp1800-common")
>> +DECLARE_CLASS_CHECKERS(PetalogixS3adsp1800MachineClass,
>> +                       PETALOGIX_S3ADSP1800_MACHINE,
>> +                       TYPE_PETALOGIX_S3ADSP1800_MACHINE)
>>   
>>   static void
>>   petalogix_s3adsp1800_init(MachineState *machine)
>> @@ -71,11 +80,13 @@ petalogix_s3adsp1800_init(MachineState *machine)
>>       MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
>>       qemu_irq irq[32];
>>       MemoryRegion *sysmem = get_system_memory();
>> +    PetalogixS3adsp1800MachineClass *pmc;
>>   
>> +    pmc = PETALOGIX_S3ADSP1800_MACHINE_GET_CLASS(machine);
>>       cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
>>       object_property_set_str(OBJECT(cpu), "version", "7.10.d", &error_abort);
>>       object_property_set_bool(OBJECT(cpu), "little-endian",
>> -                             !TARGET_BIG_ENDIAN, &error_abort);
>> +                             pmc->little_endian, &error_abort);
>>       qdev_realize(DEVICE(cpu), NULL, &error_abort);
>>   
>>       /* Attach emulated BRAM through the LMB.  */
>> @@ -95,7 +106,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
>>                             64 * KiB, 1, 0x89, 0x18, 0x0000, 0x0, 1);
>>   
>>       dev = qdev_new("xlnx.xps-intc");
>> -    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
>> +    qdev_prop_set_bit(dev, "little-endian", pmc->little_endian);
>>       qdev_prop_set_uint32(dev, "kind-of-intr",
>>                            1 << ETHLITE_IRQ | 1 << UARTLITE_IRQ);
>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>> @@ -107,7 +118,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
>>       }
>>   
>>       dev = qdev_new(TYPE_XILINX_UARTLITE);
>> -    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
>> +    qdev_prop_set_bit(dev, "little-endian", pmc->little_endian);
>>       qdev_prop_set_chr(dev, "chardev", serial_hd(0));
>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, UARTLITE_BASEADDR);
>> @@ -115,7 +126,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
>>   
>>       /* 2 timers at irq 2 @ 62 Mhz.  */
>>       dev = qdev_new("xlnx.xps-timer");
>> -    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
>> +    qdev_prop_set_bit(dev, "little-endian", pmc->little_endian);
>>       qdev_prop_set_uint32(dev, "one-timer-only", 0);
>>       qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>> @@ -123,7 +134,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
>>       sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
>>   
>>       dev = qdev_new("xlnx.xps-ethernetlite");
>> -    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
>> +    qdev_prop_set_bit(dev, "little-endian", pmc->little_endian);
>>       qemu_configure_nic_device(dev, true, NULL);
>>       qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
>>       qdev_prop_set_uint32(dev, "rx-ping-pong", 0);
>> @@ -133,26 +144,55 @@ petalogix_s3adsp1800_init(MachineState *machine)
>>   
>>       create_unimplemented_device("xps_gpio", GPIO_BASEADDR, 0x10000);
>>   
>> -    microblaze_load_kernel(cpu, !TARGET_BIG_ENDIAN, ddr_base, ram_size,
>> +    microblaze_load_kernel(cpu, pmc->little_endian, ddr_base, ram_size,
>>                              machine->initrd_filename,
>>                              BINARY_DEVICE_TREE_FILE,
>>                              NULL);
>>   }
>>   
>> -static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc, void *data)
>> +static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc,
>> +                                                    bool little_endian)
>>   {
>>       MachineClass *mc = MACHINE_CLASS(oc);
>> +    PetalogixS3adsp1800MachineClass *pmc = PETALOGIX_S3ADSP1800_MACHINE_CLASS(oc);
>>   
>> -    mc->desc = "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800";
>>       mc->init = petalogix_s3adsp1800_init;
>> -    mc->is_default = true;
>> +    pmc->little_endian = little_endian;
>> +    mc->desc = little_endian
>> +        ? "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800 (little endian)"
>> +        : "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800 (big endian)";
>> +    if (little_endian == !TARGET_BIG_ENDIAN) {
>> +        mc->is_default = true;
>> +        mc->alias = "petalogix-s3adsp1800";
>> +    }
>> +}
>> +
>> +static void petalogix_s3adsp1800_machine_class_init_be(ObjectClass *oc, void *data)
>> +{
>> +    petalogix_s3adsp1800_machine_class_init(oc, false);
>> +}
>> +
>> +static void petalogix_s3adsp1800_machine_class_init_le(ObjectClass *oc, void *data)
>> +{
>> +    petalogix_s3adsp1800_machine_class_init(oc, true);
>>   }
>>   
>>   static const TypeInfo petalogix_s3adsp1800_machine_types[] = {
>>       {
>>           .name           = TYPE_PETALOGIX_S3ADSP1800_MACHINE,
>>           .parent         = TYPE_MACHINE,
>> -        .class_init     = petalogix_s3adsp1800_machine_class_init,
>> +        .abstract       = true,
>> +        .class_size     = sizeof(PetalogixS3adsp1800MachineClass),
>> +    },
>> +    {
>> +        .name           = MACHINE_TYPE_NAME("petalogix-s3adsp1800-be"),
>> +        .parent         = TYPE_PETALOGIX_S3ADSP1800_MACHINE,
>> +        .class_init     = petalogix_s3adsp1800_machine_class_init_be,
>> +    },
>> +    {
>> +        .name           = MACHINE_TYPE_NAME("petalogix-s3adsp1800-le"),
>> +        .parent         = TYPE_PETALOGIX_S3ADSP1800_MACHINE,
>> +        .class_init     = petalogix_s3adsp1800_machine_class_init_le,
>>       },
>>   };
>>   
>> -- 
>> 2.47.1
>>
>>
> 
> With regards,
> Daniel


