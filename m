Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D368E9E2EC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 11:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq8hQ-0003C2-OJ; Wed, 11 Feb 2026 06:48:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vq8hO-0003BY-6q
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 06:48:02 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vq8hL-0000Dz-JG
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 06:48:01 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 93355596A3F;
 Wed, 11 Feb 2026 12:47:55 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id GbCVMrcHZSCG; Wed, 11 Feb 2026 12:47:53 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7CA0D596A13; Wed, 11 Feb 2026 12:47:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7AC4C596A10;
 Wed, 11 Feb 2026 12:47:53 +0100 (CET)
Date: Wed, 11 Feb 2026 12:47:53 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 0/6] Implement memory_region_new_* functions
In-Reply-To: <CABgObfYpW0YMofv4O8gf4p-aWVxfvQ+BCMPsm2w+5MtD8-9s0Q@mail.gmail.com>
Message-ID: <42233b06-f058-152d-645e-e16528a1640d@eik.bme.hu>
References: <cover.1770753117.git.balaton@eik.bme.hu>
 <CABgObfYpW0YMofv4O8gf4p-aWVxfvQ+BCMPsm2w+5MtD8-9s0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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

On Wed, 11 Feb 2026, Paolo Bonzini wrote:
> Il mar 10 feb 2026, 21:02 BALATON Zoltan <balaton@eik.bme.hu> ha scritto:
>
>> Our documentation says that memory regions are automatically freed
>> when the owner dies and the reference counting to do this is also
>> implemented. However this relies on the QOM free funtion that can only
>> be set by creating objects with object_new but memory API only
>> provides constructors that call object_initialize which clears the
>> free function that prevents QOM to manage the memory region lifetime.
>> Implement corresponding memory_region_new_* functions that do the same
>> as the memory_region_init_* functions but create the memory region
>> with object_new so the lifetime can be automatically managed by QOM as
>> documented. The memory_region_init functions are kept because they are
>> useful for memory regions embedded in other object or managed
>> externally and not by QOM for some reason.
>>
>
> I think there was pretty much agreement *not* to do this?

Who agreed on that? So far I got concerns that this was too big (that's 
why I split it from the clean ups to show it's not that big change, less 
than 200 lines plus the docs but the clean ups removed as many lines as 
the doc comments add) and others saying this should replace 
memory_region_init altogether (that's way too much churn and not needed 
IMO) but no clear explanation of why this was *not* needed. You as 
maintainer can say no but then please give a justification for why and 
some solution to the problems this tries to fix.

Regards,
BALATON Zoltan

> Paolo
>
> v3:
>> Based-on: <cover.1770753117.git.balaton@eik.bme.hu>
>> - convert xtfpga from nomigrate as this has no migration compatibility
>> issue
>>
>> v2:
>> - rebase on master
>> - update documentation
>> - use these function to fix some leaks (there may be more, e.g. in
>> hw/pci-host/bonito but I leave that for later and/or others)
>>
>> BALATON Zoltan (6):
>>   memory: Add memory_region_new* functions
>>   memory: Update documentation for memory_region_new*()
>>   hw/ide/sii3112: Use memory_region_new to avoid leaking regions
>>   hw/pci-host/articia: Map PCI memory windows in realize
>>   hw/pci-host/articia: Add variable for common type cast
>>   hw/xtensa/xtfpga: Fix leaking memory region
>>
>>  docs/devel/memory.rst   |  21 ++---
>>  hw/ide/sii3112.c        |  30 +++----
>>  hw/pci-host/articia.c   |  22 +++--
>>  hw/ppc/amigaone.c       |  28 ++-----
>>  hw/ppc/pegasos.c        |  13 ---
>>  hw/xtensa/xtfpga.c      |   7 +-
>>  include/system/memory.h | 179 +++++++++++++++++++++++++++++++++++++++
>>  system/memory.c         | 181 ++++++++++++++++++++++++++++++++++++++++
>>  8 files changed, 407 insertions(+), 74 deletions(-)
>>
>> --
>> 2.41.3
>>
>>
>

