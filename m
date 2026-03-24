Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1553F54AC5
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5351-0007xc-Uc; Tue, 24 Mar 2026 10:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w534z-0007x3-RW
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:50:02 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w534v-0000u5-3X
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:49:59 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5A24B5969E4;
 Tue, 24 Mar 2026 15:49:55 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 5_GfJ2Q-24rQ; Tue, 24 Mar 2026 15:49:53 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 618965968DC; Tue, 24 Mar 2026 15:49:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 601285966F4;
 Tue, 24 Mar 2026 15:49:53 +0100 (CET)
Date: Tue, 24 Mar 2026 15:49:53 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 marcandre.lureau@redhat.com, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v6 7/8] ati-vga: Simplify pointer image handling
In-Reply-To: <DHB2SIE9XM4F.38ZR2LJ2F670B@jablonski.xyz>
Message-ID: <fa102b60-4b0d-7d70-81b1-dc145ee8b5f0@eik.bme.hu>
References: <cover.1774110169.git.balaton@eik.bme.hu>
 <b9de530074b954d661a0eb9b8b4ad82a66085456.1774110169.git.balaton@eik.bme.hu>
 <DHB2SIE9XM4F.38ZR2LJ2F670B@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 24 Mar 2026, Chad Jablonski wrote:
>>      /* FIXME handle cur_hv_offs correctly */
>> +    srcoff = s->regs.cur_offset - (s->regs.cur_hv_offs >> 16) -
>> +             (s->regs.cur_hv_offs & 0xffff) * 16;
>
> This is pre-existing (and a FIXME!) but do we want to be subtracting the
> horizontal cursor offset (s->regs.cur_hv_offs >> 16) here? I think when
> it's non-zero it would mean that the first row of the cursor would be offset
> and rows would contain bytes from the next row at the end. The way I read the
> register reference is that the horizontal offset is the number of columns the
> cursor is shifted. So I don't think this would affect the source, just how it's drawn.

As you say it's preexisting and I did not try to fix that and left the 
FIXME comment there. I haven't seen anything using hv_offset so far except 
the Linux test image at the very left and top of the screen but that also 
has other problems with the mouse pointer so unless it's first confirmed 
on real hardware that it's supposed to work I won't try to fix that 
because I tested MacOS that also uses big endian frame buffer and that 
works now so it might be the Linux driver is buggy or there's some other 
swap bit somewhere we should take into account. As nothing else seems to 
use non-0 hv_offset this should not matter for most drivers so until we 
see something that needs it and we can test with I leave it a FIXME.

>> +    for (int i = 0; i < 64; i++, srcoff += 16) {
>> +        data[i] = ldq_le_p(&s->vga.vram_ptr[srcoff]);
>> +        data[i + 64] = ldq_le_p(&s->vga.vram_ptr[srcoff + 8]);
>
> Is this ldq_le_p correct here? Wouldn't this cause issues on BE hosts?

I'm not sure as I noted in commit message. According to the docs I've seen 
hw cursor data should always be little endian and if we pass these on as 
host endian data here then le should be correct but I could not test on 
big endian host so can't say for sure.

Regards,
BALATON Zoltan

