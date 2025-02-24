Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5415EC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 20:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmfOF-0007yf-4C; Mon, 24 Feb 2025 15:49:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tmfNu-0007xe-DP; Mon, 24 Feb 2025 15:49:02 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tmfNq-0004N9-1g; Mon, 24 Feb 2025 15:48:59 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 500874E6039;
 Mon, 24 Feb 2025 21:48:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id aZlsX2szbbJY; Mon, 24 Feb 2025 21:48:51 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0EFFB4E6010; Mon, 24 Feb 2025 21:48:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0D2B174577C;
 Mon, 24 Feb 2025 21:48:51 +0100 (CET)
Date: Mon, 24 Feb 2025 21:48:51 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 0/4] ppc/amigaone patches
In-Reply-To: <ACCAE066-F36F-45DA-8768-0BBD956AA475@gmail.com>
Message-ID: <1add3042-df79-1714-d657-aed0cc0a49ff@eik.bme.hu>
References: <cover.1740243918.git.balaton@eik.bme.hu>
 <ACCAE066-F36F-45DA-8768-0BBD956AA475@gmail.com>
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

On Mon, 24 Feb 2025, Bernhard Beschow wrote:
> Am 22. Februar 2025 17:52:27 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>> Hello,
>>
>> This series adds NVRAM and support for -kernel, -initrd and -append
>> options to the amigaone machine. This makes it easier to boot AmigaOS
>> and avoids a crash in the guest when it tries to access NVRAM.
>
> Looks like the above information could be added to the changelog. While...

I tried to make changelog consise and assume people reading that are 
familiar with QEMU so know what these options do. But whoever will update 
the changelog can decide if this is worth adding, I'm OK with that.

>> While the -kernel option emulates what U-Boot passes to the kernel,
>> old Linux kernels for amigaone may not work with it because of two
>> reasons: these come in legacy U-Boot Multi-File image format that QEMU
>> cannot read and even after unpacking that and creating a kernel uimage
>> it won't find PCI devices because it does not initialise them
>> correctly. This works when booted from U-Boot because U-Boot inits PCI
>> devices. So does my BBoot loader which can be used to load AmigaOS so
>> I don't intend to emulate that part of U-Boot.
>>
>> I'd like this to be merged for the next release please. When merging
>> please update https://wiki.qemu.org/ChangeLog/10.0 with the following:
>>
>> amigaone
>>
>> Added support for NVRAM and -kernel, -initrd, -append command line
>> options.
>
> ... this:
>
>> By default the NVRAM contents are not preserved between
>> sessions. To make it persistent create a backing file with 'qemu-image
>> create -f raw nvram.bin 4k' and add -drive
>> if=mtd,format=raw,file=nvram.bin to keep NVRAM contents in the backing
>> file so settings stored in it will be preserved between sessions.
>>
>> To run AmigaOS with BBoot using the -kernel option at least BBoot
>> version 0.8 is needed. Older BBoot versions only work with -device
>> loader and cannot be used with -kernel on amigaone.
>
> ... information could be added to the amigaone section in the QEMU manual to keep the documentation in one place.

The QEMU doc specifically documents running Linux and Linux does not use 
or rely on NVRAM. But I could mention it there why you likely can't boot 
Linux with -kernel although if you try you'll get an error telling you and 
since the docs don't recommend that it's probably OK to not mention it 
just to not confuse people who only want to know what works.

I have my docs on AmigaOS and BBoot at qmiga.codeberg.page so I'll add 
info relating to these there and keep the QEMU docs for Linux. I've only 
mentioned BBoot in the changelog because people don't read docs so I 
wanted it to be everywhere so they see at least one of those before asking 
me. I've yet to update BBoot and my Qmiga pages but I'll do that for the 
QEMU release.

Regards,
BALATON Zoltan

