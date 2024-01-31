Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A4CC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 13:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVAY5-0002kS-PY; Wed, 31 Jan 2024 08:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rVAY2-0002kI-1E
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 08:22:38 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rVAXz-0007NO-8f
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 08:22:37 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 386D74E60E1;
 Wed, 31 Jan 2024 14:22:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id ChnJkloPWH4b; Wed, 31 Jan 2024 14:22:29 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id F0CA44E60E0; Wed, 31 Jan 2024 14:22:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EFA357456B4;
 Wed, 31 Jan 2024 14:22:29 +0100 (CET)
Date: Wed, 31 Jan 2024 14:22:29 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: why various devices are loading x86 roms on non-x86 architectures?
In-Reply-To: <CAFEAcA_qxALhqHgd0zO6v6ufTaHvmiyyHuCDcHZdxRvbh+x_Hg@mail.gmail.com>
Message-ID: <a2b12e13-1e6c-82d2-f1c5-63e76158945d@eik.bme.hu>
References: <8e838817-8b55-4275-a199-0562216d2d1d@tls.msk.ru>
 <CAFEAcA_qxALhqHgd0zO6v6ufTaHvmiyyHuCDcHZdxRvbh+x_Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 31 Jan 2024, Peter Maydell wrote:
> On Wed, 31 Jan 2024 at 10:29, Michael Tokarev <mjt@tls.msk.ru> wrote:
>> qemu-system-aarch64 -device virtio-vga
>>
>> this one loads vgabios-virtio.bin.  Why?
>> Does this bios work on aarch64 (or any other non-x86 arch)?
>> Should there may be some conditional in this and similar places?
>> The same is true for x86 pxe roms and other x86-only roms.
>
> For the same reason that if you plug a PCI card with an
> x86 BIOS ROM on it into a non-x86 system with a PCI bus,
> the x86 code is still on the ROM, even if it's never
> executed :-) Mostly the ROM is ignored and the guest kernel
> drives the hardware directly without it.
>
> For stuff we control like virtio-vga it would probably be
> helpful to be able to drop the requirement for the binary
> blob, just as a practical convenience for users.

One way to omit ROM per machine could be like in this patch:

https://patchew.org/QEMU/cover.1672868854.git.balaton@eik.bme.hu/e8d6aa41eeb0461d285fa4c12e0fff05d366e8fa.1672868854.git.balaton@eik.bme.hu/

maybe this could also work per device if the romfile property can be set 
from realize or reset method but would need to distinguish between default 
value or user provided value to not override the latter.

There are also some PPC machines that have BIOS emulator in firmware and 
would need the ROM to init the device but these have problems with QEMU's 
gcc compiled ROMs that contain i386 opcodes and can't run these.

Also ati-vga has some tables in the card ROM about timings that drivers 
read even if the machine did not run the ROM and there are Mac versions of 
cards with different ROMs so this may be something dependent on each 
device rather than machine architecture. We can say that devices that QEMU 
emulate are primarily PC cards so they come with a PC option ROM.

Regards,
BALATON Zoltan

