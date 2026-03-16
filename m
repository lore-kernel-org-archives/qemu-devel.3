Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738D8F53D7E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2COZ-0007QQ-Jc; Mon, 16 Mar 2026 14:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2COU-0007Pv-88
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:10:23 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2COR-0001X1-3O
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:10:21 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 34CFC596A46;
 Mon, 16 Mar 2026 19:10:07 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Tfq9cQP6irdi; Mon, 16 Mar 2026 19:10:05 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 18576596A41; Mon, 16 Mar 2026 19:10:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 165F05969E4;
 Mon, 16 Mar 2026 19:10:05 +0100 (CET)
Date: Mon, 16 Mar 2026 19:10:05 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Xu <peterx@redhat.com>
cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] hw/display/tcx: Init memory regions in realize
In-Reply-To: <abgqjKVFHKxuKupP@x1.local>
Message-ID: <812f2a8d-f6bb-f127-a3f9-4629de5a03e5@eik.bme.hu>
References: <20260316130651.5C8735968DE@zero.eik.bme.hu>
 <abgqjKVFHKxuKupP@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Mon, 16 Mar 2026, Peter Xu wrote:
> On Mon, Mar 16, 2026 at 02:06:51PM +0100, BALATON Zoltan wrote:
>> Due to aux-ram-share property qemu_ram_alloc_internal dereferences
>> current_machine which is not set during init when inspecting the
>> device. This causes the qtest/device-introspect-test to fail since a
>
> Does it has anything to do with aux-ram-share?  I thought it's because the
> qom introspect test will create yet another sun-tcx device, causing double
> registration?

I could reproduce it like this:

$ gdb --args ./qemu-system-sparc -M none -device sun-tcx,help
(gdb) r
Thread 1 "qemu-system-spa" received signal SIGSEGV, Segmentation fault.
0x00005555557ad7ef in qemu_ram_alloc_internal (size=size@entry=65536, max_size=max_size@entry=65536, resized=resized@entry=0x0, host=host@entry=0x0, ram_flags=ram_flags@entry=0, mr=mr@entry=0x555555e15db0, errp=0x555555daee30 <error_fatal>) at ../../mnt/balaton/src/qemu/system/physmem.c:2487
2487	        if (!share_flags && current_machine->aux_ram_share) {
(gdb) bt
#0  0x00005555557ad7ef in qemu_ram_alloc_internal
     (size=size@entry=65536, max_size=max_size@entry=65536, resized=resized@entry=0x0, host=host@entry=0x0, ram_flags=ram_flags@entry=0, mr=mr@entry=0x555555e15db0, errp=0x555555daee30 <error_fatal>)
     at ../../mnt/balaton/src/qemu/system/physmem.c:2487
#1  0x00005555557adc23 in qemu_ram_alloc
     (size=size@entry=65536, ram_flags=ram_flags@entry=0, mr=mr@entry=0x555555e15db0, errp=errp@entry=0x555555daee30 <error_fatal>)
     at ../../mnt/balaton/src/qemu/system/physmem.c:2565
#2  0x00005555557a741d in memory_region_init_ram_flags_nomigrate
     (errp=0x555555daee30 <error_fatal>, ram_flags=0, size=65536, name=0x555555ab1999 "tcx.prom", owner=0x555555e15a50, mr=0x555555e15db0)
     at ../../mnt/balaton/src/qemu/system/memory.c:1600
#3  memory_region_init_rom
     (mr=mr@entry=0x555555e15db0, owner=owner@entry=0x555555e15a50, name=name@entry=0x555555ab1999 "tcx.prom", size=size@entry=65536, errp=0x555555daee30 <error_fatal>)
     at ../../mnt/balaton/src/qemu/system/memory.c:3687
#4  0x0000555555764cde in tcx_initfn (obj=0x555555e15a50)
     at ../../mnt/balaton/src/qemu/hw/display/tcx.c:759
#5  0x0000555555893596 in object_init_with_type
     (ti=0x555555dffda0, obj=0x555555e15a50)
     at ../../mnt/balaton/src/qemu/qom/object.c:428
#6  object_initialize_with_type
     (obj=0x555555e15a50, size=<optimized out>, type=0x555555dffda0)
     at ../../mnt/balaton/src/qemu/qom/object.c:570
#7  0x0000555555893777 in object_new_with_type (type=0x555555dffda0)
     at ../../mnt/balaton/src/qemu/qom/object.c:774
#8  0x00005555558937f8 in object_new_with_class    (klass=klass@entry=0x555555e13920)
     at ../../mnt/balaton/src/qemu/qom/object.c:782
#9  0x0000555555975210 in qmp_device_list_properties
     (typename=typename@entry=0x555555de98b0 "sun-tcx", errp=errp@entry=0x7fffffffdc50) at ../../mnt/balaton/src/qemu/qom/qom-qmp-cmds.c:206
#10 0x00005555557b22fc in qdev_device_help (opts=<optimized out>)
     at ../../mnt/balaton/src/qemu/system/qdev-monitor.c:313
#11 0x0000555555a2cda1 in qemu_opts_foreach
     (list=<optimized out>, func=func@entry=0x55555578fed0 <device_help_func>, opaque=opaque@entry=0x0, errp=errp@entry=0x0)
     at ../../mnt/balaton/src/qemu/util/qemu-option.c:1135
#12 0x0000555555793b3f in qemu_process_help_options ()
     at ../../mnt/balaton/src/qemu/system/vl.c:2641
#13 qemu_init (argc=<optimized out>, argv=0x7fffffffdfa8)
     at ../../mnt/balaton/src/qemu/system/vl.c:3741
#14 0x00005555556cc8d9 in main (argc=<optimized out>, argv=<optimized out>)
     at ../../mnt/balaton/src/qemu/system/main.c:71

where

$ ./qemu-system-sparc -M none -monitor stdio
QEMU 10.2.50 monitor - type 'help' for more information
(qemu) info qtree -b
bus: main-system-bus
   type System

So there seems to be no other instance but it fails due to dereferencing 
current_machine to check aux_ram_share but that fails at this point.

>> recent change to use memory_region_init_rom instead of global vmstate.
>> Fix it by removing the init method and move memory region creation in
>> realize.
>>
>> Fixes: 653c4fa5b0 hw/display/{cg3.tcx}: Do not use memory_region_init_rom_nomigrate
>> Reported by: Thomas Huth <thuth@redhat.com>
>
> Missing "-" in the tag.
>
> I can queue it for rc1 with above fixed, BALATON please help confirm.

Reported-by: Thomas Huth <thuth@redhat.com>

Regards,
BALATON Zoltan

> PS: Mark, please feel free to comment or if you want to take it.
>
> Thanks,
>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/display/tcx.c | 24 +++++++++---------------
>>  1 file changed, 9 insertions(+), 15 deletions(-)
>>
>> diff --git a/hw/display/tcx.c b/hw/display/tcx.c
>> index c8a4ac21ca..ea92a48400 100644
>> --- a/hw/display/tcx.c
>> +++ b/hw/display/tcx.c
>> @@ -751,10 +751,15 @@ static const GraphicHwOps tcx24_ops = {
>>      .gfx_update = tcx24_update_display,
>>  };
>>
>> -static void tcx_initfn(Object *obj)
>> +static void tcx_realize(DeviceState *dev, Error **errp)
>>  {
>> -    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>> -    TCXState *s = TCX(obj);
>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>> +    TCXState *s = TCX(dev);
>> +    Object *obj = OBJECT(dev);
>> +    ram_addr_t vram_offset = 0;
>> +    int size, ret;
>> +    uint8_t *vram_base;
>> +    char *fcode_filename;
>>
>>      memory_region_init_rom(&s->rom, obj, "tcx.prom", FCODE_MAX_ROM_SIZE,
>>                             &error_fatal);
>> @@ -804,16 +809,6 @@ static void tcx_initfn(Object *obj)
>>      memory_region_init_io(&s->alt, obj, &tcx_dummy_ops, s, "tcx.alt",
>>                            TCX_ALT_NREGS);
>>      sysbus_init_mmio(sbd, &s->alt);
>> -}
>> -
>> -static void tcx_realizefn(DeviceState *dev, Error **errp)
>> -{
>> -    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>> -    TCXState *s = TCX(dev);
>> -    ram_addr_t vram_offset = 0;
>> -    int size, ret;
>> -    uint8_t *vram_base;
>> -    char *fcode_filename;
>>
>>      memory_region_init_ram(&s->vram_mem, OBJECT(s), "tcx.vram",
>>                             s->vram_size * (1 + 4 + 4), &error_fatal);
>> @@ -887,7 +882,7 @@ static void tcx_class_init(ObjectClass *klass, const void *data)
>>  {
>>      DeviceClass *dc = DEVICE_CLASS(klass);
>>
>> -    dc->realize = tcx_realizefn;
>> +    dc->realize = tcx_realize;
>>      device_class_set_legacy_reset(dc, tcx_reset);
>>      dc->vmsd = &vmstate_tcx;
>>      device_class_set_props(dc, tcx_properties);
>> @@ -897,7 +892,6 @@ static const TypeInfo tcx_info = {
>>      .name          = TYPE_TCX,
>>      .parent        = TYPE_SYS_BUS_DEVICE,
>>      .instance_size = sizeof(TCXState),
>> -    .instance_init = tcx_initfn,
>>      .class_init    = tcx_class_init,
>>  };
>>
>> --
>> 2.41.3
>>
>
>

