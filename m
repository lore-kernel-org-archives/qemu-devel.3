Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A96FB5E81
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 22:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2GSh-0000Tm-O5; Mon, 16 Mar 2026 18:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2GSf-0000TL-Ao
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 18:30:57 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2GSb-0006VQ-M8
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 18:30:57 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 86E555969E4;
 Mon, 16 Mar 2026 23:30:50 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id eZewdQclbidZ; Mon, 16 Mar 2026 23:30:47 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D5F895968DE; Mon, 16 Mar 2026 23:30:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D40E65968DC;
 Mon, 16 Mar 2026 23:30:47 +0100 (CET)
Date: Mon, 16 Mar 2026 23:30:47 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Xu <peterx@redhat.com>
cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] hw/display/tcx: Init memory regions in realize
In-Reply-To: <abh2ZdpzQNepUTIy@x1.local>
Message-ID: <ebd251c9-a1d1-4956-af11-ae9858e76254@eik.bme.hu>
References: <20260316130651.5C8735968DE@zero.eik.bme.hu>
 <abgqjKVFHKxuKupP@x1.local> <812f2a8d-f6bb-f127-a3f9-4629de5a03e5@eik.bme.hu>
 <abh2ZdpzQNepUTIy@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> On Mon, Mar 16, 2026 at 07:10:05PM +0100, BALATON Zoltan wrote:
>> On Mon, 16 Mar 2026, Peter Xu wrote:
>>> On Mon, Mar 16, 2026 at 02:06:51PM +0100, BALATON Zoltan wrote:
>>>> Due to aux-ram-share property qemu_ram_alloc_internal dereferences
>>>> current_machine which is not set during init when inspecting the
>>>> device. This causes the qtest/device-introspect-test to fail since a
>>>
>>> Does it has anything to do with aux-ram-share?  I thought it's because the
>>> qom introspect test will create yet another sun-tcx device, causing double
>>> registration?
>>
>> I could reproduce it like this:
>
> I would treat this one a separate bug, because it doesn't look special to
> sparc systems.

I thought this is the issue Thomas has reported. I found this command by 
looking at what the test does but looks like this gets a different error 
but the fix is the same.

>> $ gdb --args ./qemu-system-sparc -M none -device sun-tcx,help
>> (gdb) r
>> Thread 1 "qemu-system-spa" received signal SIGSEGV, Segmentation fault.
>> 0x00005555557ad7ef in qemu_ram_alloc_internal (size=size@entry=65536, max_size=max_size@entry=65536, resized=resized@entry=0x0, host=host@entry=0x0, ram_flags=ram_flags@entry=0, mr=mr@entry=0x555555e15db0, errp=0x555555daee30 <error_fatal>) at ../../mnt/balaton/src/qemu/system/physmem.c:2487
>> 2487	        if (!share_flags && current_machine->aux_ram_share) {
>> (gdb) bt
>> #0  0x00005555557ad7ef in qemu_ram_alloc_internal
>>     (size=size@entry=65536, max_size=max_size@entry=65536, resized=resized@entry=0x0, host=host@entry=0x0, ram_flags=ram_flags@entry=0, mr=mr@entry=0x555555e15db0, errp=0x555555daee30 <error_fatal>)
>>     at ../../mnt/balaton/src/qemu/system/physmem.c:2487
>> #1  0x00005555557adc23 in qemu_ram_alloc
>>     (size=size@entry=65536, ram_flags=ram_flags@entry=0, mr=mr@entry=0x555555e15db0, errp=errp@entry=0x555555daee30 <error_fatal>)
>>     at ../../mnt/balaton/src/qemu/system/physmem.c:2565
>> #2  0x00005555557a741d in memory_region_init_ram_flags_nomigrate
>>     (errp=0x555555daee30 <error_fatal>, ram_flags=0, size=65536, name=0x555555ab1999 "tcx.prom", owner=0x555555e15a50, mr=0x555555e15db0)
>>     at ../../mnt/balaton/src/qemu/system/memory.c:1600
>> #3  memory_region_init_rom
>>     (mr=mr@entry=0x555555e15db0, owner=owner@entry=0x555555e15a50, name=name@entry=0x555555ab1999 "tcx.prom", size=size@entry=65536, errp=0x555555daee30 <error_fatal>)
>>     at ../../mnt/balaton/src/qemu/system/memory.c:3687
>> #4  0x0000555555764cde in tcx_initfn (obj=0x555555e15a50)
>>     at ../../mnt/balaton/src/qemu/hw/display/tcx.c:759
>> #5  0x0000555555893596 in object_init_with_type
>>     (ti=0x555555dffda0, obj=0x555555e15a50)
>>     at ../../mnt/balaton/src/qemu/qom/object.c:428
>> #6  object_initialize_with_type
>>     (obj=0x555555e15a50, size=<optimized out>, type=0x555555dffda0)
>>     at ../../mnt/balaton/src/qemu/qom/object.c:570
>> #7  0x0000555555893777 in object_new_with_type (type=0x555555dffda0)
>>     at ../../mnt/balaton/src/qemu/qom/object.c:774
>> #8  0x00005555558937f8 in object_new_with_class    (klass=klass@entry=0x555555e13920)
>>     at ../../mnt/balaton/src/qemu/qom/object.c:782
>> #9  0x0000555555975210 in qmp_device_list_properties
>>     (typename=typename@entry=0x555555de98b0 "sun-tcx", errp=errp@entry=0x7fffffffdc50) at ../../mnt/balaton/src/qemu/qom/qom-qmp-cmds.c:206
>> #10 0x00005555557b22fc in qdev_device_help (opts=<optimized out>)
>>     at ../../mnt/balaton/src/qemu/system/qdev-monitor.c:313
>> #11 0x0000555555a2cda1 in qemu_opts_foreach
>>     (list=<optimized out>, func=func@entry=0x55555578fed0 <device_help_func>, opaque=opaque@entry=0x0, errp=errp@entry=0x0)
>>     at ../../mnt/balaton/src/qemu/util/qemu-option.c:1135
>> #12 0x0000555555793b3f in qemu_process_help_options ()
>>     at ../../mnt/balaton/src/qemu/system/vl.c:2641
>> #13 qemu_init (argc=<optimized out>, argv=0x7fffffffdfa8)
>>     at ../../mnt/balaton/src/qemu/system/vl.c:3741
>> #14 0x00005555556cc8d9 in main (argc=<optimized out>, argv=<optimized out>)
>>     at ../../mnt/balaton/src/qemu/system/main.c:71
>>
>> where
>>
>> $ ./qemu-system-sparc -M none -monitor stdio
>> QEMU 10.2.50 monitor - type 'help' for more information
>> (qemu) info qtree -b
>> bus: main-system-bus
>>   type System
>>
>> So there seems to be no other instance but it fails due to dereferencing
>> current_machine to check aux_ram_share but that fails at this point.
>
> I don't see a major reason we should forbid qemu to alloc ram even without
> machines.
>
> One way to do this is to fallback and ignore aux-ram-share property when
> current_machine isn't available, because it's a machine property after
> all..
>
> IMHO it'll make more sense in the commit log to describe the issue that
> Thomas hit, which was specific to the sparc machine.

It's not, see this series: 
https://patchew.org/QEMU/20260316104039.195960-1-thuth@redhat.com/
so similar problems were seen with other machines but if you think 
Thomas's report is a better commit message for this change feel free to 
replace it or ammend it as you like. I'm OK with whatever commit message.

> I'm not sure if we need to fix the current_machine reference one here with
> a separate patch. If we don't have a solid reproducer elsewhere then we
> don't need to.  But if you like to send a patch it looks ok too.

I think for the freeze this fix is enough and we could look at more 
changes in next version if needed. As long as it does not cause any other 
issue I would not touch it as I'm not sure I fully understand the problem.

Regards,
BALATON Zoltan

