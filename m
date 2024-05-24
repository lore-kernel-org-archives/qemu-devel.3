Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17ABFC25B7A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 11:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sATNL-00067u-Jr; Fri, 24 May 2024 07:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sATNE-0005qC-Ts; Fri, 24 May 2024 07:46:14 -0400
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sATN5-00026b-Pn; Fri, 24 May 2024 07:46:09 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sATN2-000I1c-06; Fri, 24 May 2024 13:46:00 +0200
Received: from [82.100.198.138] (helo=mail.embedded-brains.de)
 by sslproxy02.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sATN2-000JGF-2D; Fri, 24 May 2024 13:46:00 +0200
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 8A3E64800E9;
 Fri, 24 May 2024 13:45:59 +0200 (CEST)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ZF7SOVh3qLJW; Fri, 24 May 2024 13:45:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 1A67E480197;
 Fri, 24 May 2024 13:45:59 +0200 (CEST)
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id XBrXEF1hWdfM; Fri, 24 May 2024 13:45:59 +0200 (CEST)
Received: from [10.10.171.10] (unknown [10.10.171.10])
 by mail.embedded-brains.de (Postfix) with ESMTPSA id C88354800E9;
 Fri, 24 May 2024 13:45:58 +0200 (CEST)
Message-ID: <4c09228c-55b5-48e8-8383-6edbc78dd4da@embedded-brains.de>
Date: Fri, 24 May 2024 13:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/arm/xilinx_zynq: Support up to two CPU cores
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240507130349.86851-1-sebastian.huber@embedded-brains.de>
 <20240507130349.86851-3-sebastian.huber@embedded-brains.de>
 <CAFEAcA_KBcL9UsqpOMk7GhWwokdEmC3fKZg_q7tdyt9LM7RFpA@mail.gmail.com>
Content-Language: en-US
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
In-Reply-To: <CAFEAcA_KBcL9UsqpOMk7GhWwokdEmC3fKZg_q7tdyt9LM7RFpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: smtp-embedded@poldi-networks.de
X-Virus-Scanned: Clear (ClamAV 1.0.3/27285/Fri May 24 10:30:55 2024)
Received-SPF: pass client-ip=85.10.215.148;
 envelope-from=sebastian.huber@embedded-brains.de; helo=dedi548.your-server.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Hello Peter,

thanks for the review.

On 20.05.24 15:58, Peter Maydell wrote:
> On Tue, 7 May 2024 at 14:04, Sebastian Huber
> <sebastian.huber@embedded-brains.de>  wrote:
>> The Zynq 7000 SoCs contain two Arm Cortex-A9 MPCore (the Zynq 7000S ha=
ve only
>> one core).  Add support for up to two simulated cores.
>>
>> Signed-off-by: Sebastian Huber<sebastian.huber@embedded-brains.de>
>> ---
>>   hw/arm/xilinx_zynq.c | 42 +++++++++++++++++++++++++++---------------
>>   1 file changed, 27 insertions(+), 15 deletions(-)
>>
>> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
>> index 078abd77bd..3b858e3e9a 100644
>> --- a/hw/arm/xilinx_zynq.c
>> +++ b/hw/arm/xilinx_zynq.c
>> @@ -184,6 +184,8 @@ static void zynq_init(MachineState *machine)
>>       SysBusDevice *busdev;
>>       qemu_irq pic[64];
>>       int n;
>> +    unsigned int smp_cpus =3D machine->smp.cpus;
>> +    qemu_irq cpu_irq[2];
> We prefer not to have arrays of qemu_irq like this that are
> just passing qemu_irqs from one place to another. Instead
> at the point where you want the ARM_CPU_IRQ of a particular
> CPU, call qdev_get_gpio_in() on the CPU object there.
>=20
> I suggest dropping the "ARMCPU *cpu" local from this function
> and instead adding an "ARMCPU *cpu[ZYNQ_MAX_CPUS]" array to
> the ZynqMachineState struct.

I used the hw/arm/realview.c as a template for this change. I will try=20
to implement the suggested changes.

>=20
>>       /* max 2GB ram */
>>       if (machine->ram_size > 2 * GiB) {
>> @@ -191,21 +193,27 @@ static void zynq_init(MachineState *machine)
>>           exit(EXIT_FAILURE);
>>       }
>>
>> -    cpu =3D ARM_CPU(object_new(machine->cpu_type));
>> +    for (n =3D 0; n < smp_cpus; n++) {
>> +        Object *cpuobj =3D object_new(machine->cpu_type);
>>
>> -    /* By default A9 CPUs have EL3 enabled.  This board does not
>> -     * currently support EL3 so the CPU EL3 property is disabled befo=
re
>> -     * realization.
>> -     */
>> -    if (object_property_find(OBJECT(cpu), "has_el3")) {
>> -        object_property_set_bool(OBJECT(cpu), "has_el3", false, &erro=
r_fatal);
>> -    }
>> +        /* By default A9 CPUs have EL3 enabled.  This board does not
>> +         * currently support EL3 so the CPU EL3 property is disabled =
before
>> +         * realization.
>> +         */
> If you're moving comment text around checkpatch will suggest that
> you fix it up to our current coding standard, which is that
> a multiline comment has the "/*" on a line of its own.

Ok.

>=20
>> +        if (object_property_find(cpuobj, "has_el3")) {
>> +            object_property_set_bool(cpuobj, "has_el3", false, &error=
_fatal);
>> +        }
>> +
>> +        object_property_set_int(cpuobj, "midr", ZYNQ_BOARD_MIDR,
>> +                                &error_fatal);
>> +        object_property_set_int(cpuobj, "reset-cbar", MPCORE_PERIPHBA=
SE,
>> +                                &error_fatal);
>>
>> -    object_property_set_int(OBJECT(cpu), "midr", ZYNQ_BOARD_MIDR,
>> -                            &error_fatal);
>> -    object_property_set_int(OBJECT(cpu), "reset-cbar", MPCORE_PERIPHB=
ASE,
>> -                            &error_fatal);
>> -    qdev_realize(DEVICE(cpu), NULL, &error_fatal);
>> +        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
>> +
>> +        cpu_irq[n] =3D qdev_get_gpio_in(DEVICE(cpuobj), ARM_CPU_IRQ);
>> +    }
>> +    cpu =3D ARM_CPU(first_cpu);
>>
>>       /* DDR remapped to address zero.  */
>>       memory_region_add_subregion(address_space_mem, 0, machine->ram);
>> @@ -238,10 +246,14 @@ static void zynq_init(MachineState *machine)
>>       sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
>>
>>       dev =3D qdev_new(TYPE_A9MPCORE_PRIV);
>> -    qdev_prop_set_uint32(dev, "num-cpu", 1);
>> +    qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
>>       busdev =3D SYS_BUS_DEVICE(dev);
>>       sysbus_realize_and_unref(busdev, &error_fatal);
>>       sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
>> +    for (n =3D 0; n < smp_cpus; n++) {
>> +        sysbus_connect_irq(busdev, n, cpu_irq[n]);
>> +    }
> Looks like you have based this on a version of QEMU which doesn't
> have commit 68a5827b80117973 which wires up the FIQ line of the
> A9MPCORE_PRIV device to the CPUs.

Yes, indeed. I originally used a Qemu version from Xilinx. They have a=20
huge set of patches which is not integrated in Qemu.

>=20
>> +    zynq_binfo.gic_cpu_if_addr =3D MPCORE_PERIPHBASE + 0x100;
>>       sysbus_create_varargs("l2x0", MPCORE_PERIPHBASE + 0x2000, NULL);
>>       sysbus_connect_irq(busdev, 0,
>>                          qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ));
>> @@ -357,7 +369,7 @@ static void zynq_machine_class_init(ObjectClass *o=
c, void *data)
>>       MachineClass *mc =3D MACHINE_CLASS(oc);
>>       mc->desc =3D "Xilinx Zynq Platform Baseboard for Cortex-A9";
>>       mc->init =3D zynq_init;
>> -    mc->max_cpus =3D 1;
>> +    mc->max_cpus =3D 2;
>>       mc->no_sdcard =3D 1;
>>       mc->ignore_memory_transaction_failures =3D true;
>>       mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a9");
>> --
> I'm not making this a condition for accepting this patch, but
> since you're working on this board model would you consider
> writing up some documentation for it? It's one of the boards
> we do not currently have documented at all. This doesn't have to
> be very extensive: a few paragraphs describing what the board
> type is, maybe linking to a reference to the hardware, listing
> what is and isn't implemented, and (if there are some convenient
> examples available) perhaps listing some examples of use.
> docs/system/arm/xlnx-versal-virt.rst is the docs for the
> Xilinx Versal board; the rendered version of that is:
> https://www.qemu.org/docs/master/system/arm/xlnx-versal-virt.html
> orhttps://www.qemu.org/docs/master/system/arm/realview.html
> is an example of a more minimal board documentation page.

Ok, I add this to my TODO list or try to delegate this, but it will take=20
some time.

--=20
embedded brains GmbH & Co. KG
Herr Sebastian HUBER
Dornierstr. 4
82178 Puchheim
Germany
email: sebastian.huber@embedded-brains.de
phone: +49-89-18 94 741 - 16
fax:   +49-89-18 94 741 - 08

Registergericht: Amtsgericht M=C3=BCnchen
Registernummer: HRB 157899
Vertretungsberechtigte Gesch=C3=A4ftsf=C3=BChrer: Peter Rasmussen, Thomas=
 D=C3=B6rfler
Unsere Datenschutzerkl=C3=A4rung finden Sie hier:
https://embedded-brains.de/datenschutzerklaerung/

