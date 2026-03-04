Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705EDEDEBFF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 01:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxalg-000839-CU; Tue, 03 Mar 2026 20:11:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vxald-00082i-GR
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 20:11:13 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vxalb-0006om-Db
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 20:11:13 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5C797596A10;
 Wed, 04 Mar 2026 02:11:09 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id jJlxs1EpOux0; Wed,  4 Mar 2026 02:11:07 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4CDCA596A0A; Wed, 04 Mar 2026 02:11:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4B2235969F2;
 Wed, 04 Mar 2026 02:11:07 +0100 (CET)
Date: Wed, 4 Mar 2026 02:11:07 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v10 17/17] ati-vga: Implement HOST_DATA flush to VRAM
In-Reply-To: <DGSR5S9BZKI3.3AHBP5B0P81R4@jablonski.xyz>
Message-ID: <595da7ff-7838-2cb6-fb0a-4869eea80426@eik.bme.hu>
References: <20260302180447.1078098-1-chad@jablonski.xyz>
 <20260302180447.1078098-18-chad@jablonski.xyz>
 <681a858e-1e35-aa8c-ecf9-b791438aaac5@eik.bme.hu>
 <DGSR5S9BZKI3.3AHBP5B0P81R4@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

On Mon, 2 Mar 2026, Chad Jablonski wrote:
>>> +void ati_finish_host_data(ATIVGAState *s)
>>> +{
>>> +    while (ati_flush_host_data(s)) {
>>> +        continue;
>>> +    }
>>
>> Is this while loop still needed? It looks like it will fill the rest of
>> the blit rect with the last accumulator value instead of just finishing
>> the blit in the middle. Is that what the real chip does? Otherwise this
>> could just flush once and deactivate host data, couldn't it?
>>
>
> This is how the real chip behaves, but it flushes the entire 256-bit
> accumulator wrapping around until the blit is complete. Even though

I think I now get how it may work but it's too late to try to model that 
for the next release and since the approach limited to 128 bits in v11 is 
simple enough and works well for what we need it so I think that's what we 
should include in the upcoming release. We may try to improve this in the 
future to better model the real chip but that may only really be needed 
when we make the 2D engine async which will be a bigger work so we can 
address this then.

But before I forget I write it down now. I think there may actually be 8 
32bit host data registers behind HOST_DATA0-HOST_DATA7 (that's 256 bits) 
but they are not accessed normally as registers but like a circular buffer 
or FIFO such as:

reg 0 1 2 3 4 5 6 7
wp        ^ 
rp  ^

wp is a write pointer where any data written from any register will be put 
(may actually be counted by bytes so one could push data by byte word or 
long writes) then the 2D engine is reading from the rp read pointer once 
128 bits are available (e.g. in the above figure 3 bytes were written and 
writing one more byte would start processing but writing a word would also 
store the first byte of the next chunk) so while the engine is processing 
data from regs 0-3, regs 4-7 can still accumulate data and then 2D engine 
can work on these while further data goes to reg 0-3 again. I don't know 
what happens if guest would overwrite data which is being processed but 
maybe that should not happen because 2D engine would be busy and guest 
should wait for it or these old machines were not fast enough for that? In 
any case in QEMU we can delay the write if it would overwrite the read 
pointer. So ATIHostDataState.acc should be ATIVGARegs.host_data[8] and 
there may be other regs storing the pointers but maybe those are part of 
the 2D engine and not exposed.

But anyway this is not needed for now just noted for later.

Regards,
BALATON Zoltan

