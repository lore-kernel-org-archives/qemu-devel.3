Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C606BC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 13:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkNNn-0005TP-4Q; Tue, 18 Feb 2025 08:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tkNNl-0005T1-03
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 08:11:25 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tkNNi-00057w-5T
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 08:11:24 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E3C044E6019;
 Tue, 18 Feb 2025 14:11:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Vi3XJX2vrPrq; Tue, 18 Feb 2025 14:11:16 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A75804E6013; Tue, 18 Feb 2025 14:11:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A554774577C;
 Tue, 18 Feb 2025 14:11:16 +0100 (CET)
Date: Tue, 18 Feb 2025 14:11:16 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: ROM files and non-x86
In-Reply-To: <ezfslatmgi6ixk6hoofubw2qtf6qis3mbgcpvy6cp25cwwl2k7@o4t4qfwzhcj6>
Message-ID: <1400a488-0ee2-05d4-6d69-71c2896bdb1d@eik.bme.hu>
References: <a430de0f-1c27-4c52-97d4-b881efa47131@tls.msk.ru>
 <ezfslatmgi6ixk6hoofubw2qtf6qis3mbgcpvy6cp25cwwl2k7@o4t4qfwzhcj6>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 18 Feb 2025, Gerd Hoffmann wrote:
> On Tue, Feb 18, 2025 at 01:38:42PM +0300, Michael Tokarev wrote:
>> Hi!
>>
>> Qemu system-mode emulation, when used with a NIC, loads a ROM file
>> for network booting (and fails to start if such file is not provided).
>> ROMs shipped in the source tarball are x86-only, so such loading does
>> nothing on non-x86, where we just wasting guest memory, - since the
>> ROM code can not be executed on the target architecture anyway.
>>
>> These days, ipxe provides (UEFI) ROM files for architectures other than
>> x86.  And these ROMs actually works, making it possible to network-boot
>> qemu guests in UEFI mode.
>
> edk2 ships a virtio-net driver, so network boot support does not depend
> on ipxe.
>
> Using nics other than virtio-net on aarch64/riscv64/loongarch64 looks
> pointless to me.  All these architectures are younger than virtio-net,
> so there are no compatibility concerns.
>
>> Would it be possible to make ROMs target-arch-specific, and drop the
>> ROM dependency/loading on non-x86 if there's no arch-specific ROM found?
>
> I think this can be done with compat properties today.  IIRC this is
> already done for one of the VGA devices to load a macos driver instead
> of vgabios into the rom bar.

Unfortunately it's not. I proposed such patch which I think would have 
simplified this and allowed real Mac ROM to work eventually but it wasn't 
accepted in OpenBIOS so instead the driver is still passed through fw_cfg. 
But this would be possible and I've tested that before and submitted 
patches for Mac machines emulation.

> Given that the roms are mostly needed on x86 I think the simplest
> approach would be to turn them off by default and enable for x86
> machine types using compat properties.

I don't know if anything uses NIC ROMs, some drivers may need some data or 
get MAC address from there or something like that so maybe not all ROMs 
can be disabled but maybe could be done one by one for each card after 
testing. Or just disable it for virtio-net?

For VGA cards some ROM is usually needed and machine firmwares may have 
BIOS and x86 emulation to run them even on non x86 machines. All the old 
PPC machines I emulate have such emulator in firmware but they can't run 
the current QEMU supplied ROMs so this is mostly relevant for passed 
through cards. It works with Bochs vgabios as documented here:
https://www.qemu.org/docs/master/system/ppc/amigang.html#eyetech-amigaone-mai-logic-teron-amigaone

Regards,
BALATON Zoltan

