Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A68E64A85
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 12:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIRuX-0004b5-2J; Tue, 03 Dec 2024 07:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tIRuU-0004aZ-7u
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 07:21:46 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tIRuR-0007Cy-VD
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 07:21:45 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3A2684E602B;
 Tue, 03 Dec 2024 13:21:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id p-rOuaGTwGPl; Tue,  3 Dec 2024 13:21:36 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4C7A14E6013; Tue, 03 Dec 2024 13:21:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4A09E757B1C;
 Tue, 03 Dec 2024 13:21:36 +0100 (CET)
Date: Tue, 3 Dec 2024 13:21:36 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH-for-9.2? v2 1/2] hw/display/vga: Do not reset
 'big_endian_fb' in vga_common_reset()
In-Reply-To: <yqxiqgaazxuvvtx3onfqlndx2t2sa3i7iykufkl56r45iwyusj@xatjov5qiea2>
Message-ID: <43be4405-89a6-009a-de91-dbf3bba1b560@eik.bme.hu>
References: <20241129101721.17836-1-philmd@linaro.org>
 <20241129101721.17836-2-philmd@linaro.org>
 <21c5e930-d7ee-4dd8-a238-862f4db87849@linaro.org>
 <2f6a993cd0e12c2bf903440f9f921d7af58bee36.camel@kernel.crashing.org>
 <yqxiqgaazxuvvtx3onfqlndx2t2sa3i7iykufkl56r45iwyusj@xatjov5qiea2>
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

On Tue, 3 Dec 2024, Gerd Hoffmann wrote:
>  Hi,
>
>> For bochs and ati, there's a register to configure it as well, so there
>> *may* be an expectation that it gets reset there, I'm less certain.
>
> The default is there for backward compatibility reasons and it should
> default to machine byte order so you get something working even in case
> the guest does not explicitly set the byte order via register.  Which
> should be increasingly rare these days, the register was added in
> (checking git log) 2014: commit b5682aa4ca79 ("vga-pci: add qext region
> to mmio")
>
> The only case I'm aware of where the byte order is actually switched is
> booting a ppc64le guest in a pseries machine, where the opal firmware
> runs in bigendian mode and the linux kernel runs in little endian mode.
>
> So here the changed reset behavior could actually make a difference, but
> you will only notice if the opal firmware does *not* set the byte order
> register.

I'm not sure about ati-vga but I set the vga.big_endian_fb on mode switch 
if the guest uses big endian mode. I've added this for MacOS 9 I think 
which does use that. I've also put some notes on what I've found different 
drivers use in commit 8bb9a2b26d83a. AFAIK the ati chip starts as little 
endian so maybe reseting it in ati_vga_reset() if vga_common_reset() does 
not do that any more may be needed but I can't tell for sure that's why I 
did not comment on this patch so far.

Regards,
BALATON Zoltan

