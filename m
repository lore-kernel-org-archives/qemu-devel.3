Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22791FD7076
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 10:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2RlN-0007Rp-2M; Tue, 17 Mar 2026 06:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2RlL-0007Re-5H
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:34:59 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2RlI-0001za-MD
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:34:58 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 079E7596DF7;
 Tue, 17 Mar 2026 11:34:54 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id KHGz_docVbJm; Tue, 17 Mar 2026 11:34:52 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 06B62596ADE; Tue, 17 Mar 2026 11:34:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 053E0596ABE;
 Tue, 17 Mar 2026 11:34:52 +0100 (CET)
Date: Tue, 17 Mar 2026 11:34:51 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 marcandre.lureau@redhat.com, Chad Jablonski <chad@jablonski.xyz>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 4/4] ati-vga: Avoid warning about sign extension
In-Reply-To: <CAFEAcA99ZqUsaW+NWMHAWz88tuDx8-hj=u-k9mBpEQFLw=QJdw@mail.gmail.com>
Message-ID: <ba05fa2c-c3e2-de3e-1f3f-06c3296c4d05@eik.bme.hu>
References: <cover.1773618848.git.balaton@eik.bme.hu>
 <0cc6620e1d15af6ef465e2322dce6d4c79ad0793.1773618848.git.balaton@eik.bme.hu>
 <CAFEAcA99ZqUsaW+NWMHAWz88tuDx8-hj=u-k9mBpEQFLw=QJdw@mail.gmail.com>
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

On Tue, 17 Mar 2026, Peter Maydell wrote:
> On Mon, 16 Mar 2026 at 00:06, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> Coverity reports possible sign extension error (CID 1645615) when
>> reading DEFAULT_SC_BOTTOM_RIGHT register. It cannot happen because the
>> values are limited when writing the register but change the code to
>> match other similar registers and to avoid this warning.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/display/ati.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>> index 1a6a5ad4fd..d194f15002 100644
>> --- a/hw/display/ati.c
>> +++ b/hw/display/ati.c
>> @@ -513,8 +513,8 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>>          val |= s->regs.default_tile << 16;
>>          break;
>>      case DEFAULT_SC_BOTTOM_RIGHT:
>> -        val = (s->regs.default_sc_bottom << 16) |
>> -              s->regs.default_sc_right;
>> +        val = s->regs.default_sc_right;
>> +        val |= s->regs.default_sc_bottom << 16;
>
> I don't think this is going to make Coverity any happier, because
> we're still doing:
> * take a value in a 16-bit unsigned type
> * shift it without a cast, giving a 'signed int' (32-bit)
> * promote that to 64-bits to do the |=, because 'val' is
>   64 bits, causing a potential sign extension
> The rephrasing of the code doesn't avoid the sign-extension.

OK then I'd additionally change val to uint32_t which should avoid it 
then. Would that work?

> Indeed there are other (previously dismissed as false positives
> years ago) issues in the coverity DB for the other cases in this
> switch where we put together values like this without a cast.

I'll try to have a look but I'm new to Coverity and have not checked it 
yet.

> But as you say this is a "can't happen" case for this register,
> so I've already marked CID 1645615 as a false positive.
> We should do whatever we think is reasonable and readable for
> this code.

At least this matches what other places in this device do so good for 
consistency and we generally avoid casts in QEMU, I think changing val to 
uint32_t would help all of these as it does not have to be 64-bit, it's 
just what the ops callback interface has.

Regards,
BALATON Zoltan

