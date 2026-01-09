Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F42ED1D485
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBKw-0000ku-1b; Fri, 09 Jan 2026 07:11:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1veBKs-0000T4-7c; Fri, 09 Jan 2026 07:11:22 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1veBKq-0001iL-KN; Fri, 09 Jan 2026 07:11:21 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 20D7F596AC5;
 Fri, 09 Jan 2026 13:11:17 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id UXbZZBt5Yqc4; Fri,  9 Jan 2026 13:11:15 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1F97A596AC2; Fri, 09 Jan 2026 13:11:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1E0A4596AC0;
 Fri, 09 Jan 2026 13:11:15 +0100 (CET)
Date: Fri, 9 Jan 2026 13:11:15 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, qemu-devel-bounces+chad=jablonski.xyz@nongnu.org
Subject: Re: [PATCH v4 9/9] ati-vga: Implement HOST_DATA flush to VRAM
In-Reply-To: <DFJS8544JXQY.2G7AMJGW14RII@jablonski.xyz>
Message-ID: <def8653b-2fad-8039-7af0-4f5f8dc353bd@eik.bme.hu>
References: <20260106185700.2102742-1-chad@jablonski.xyz>
 <20260106185700.2102742-10-chad@jablonski.xyz>
 <246c8b76-7a62-7dc0-1f5e-52402e2ef53d@eik.bme.hu>
 <DFHZZ37UW2LJ.6K5XDSBLC354@jablonski.xyz>
 <45b2b112-ce4d-2cfa-1e48-1b30b4a09589@eik.bme.hu>
 <DFJS8544JXQY.2G7AMJGW14RII@jablonski.xyz>
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

On Thu, 8 Jan 2026, Chad Jablonski wrote:
>> Isn't that some ROP which we need to implement for blits using
>> transparency anyway? I think the host data gets either straight pixels
>> that we need to copy or some bitmask that need to be extended either with
>> fg bg or fg over existing image. The latter could be implemented by not
>> starting with empty row buffer but getting the row from the frame buffer
>> then masking and ORing or whatever combining is needed. But if we have a
>> ROP for that even for normal blits we'll need that anyway in the blit
>> function.
>>
>
> Ah, yep, very good point. I wasn't even thinking about all of the other
> ROPs that are going to need this.
>
>> Pixman has no documentation so the only info is looking at the source. But
>> maybe we don't need to change anything if the host data flush prepares the
>> source buffer by either using the data for datatype 3, adding bg/fg for
>> mono extract and either copying the dest row first into the buffer then do
>> the fg with transparency from host data bits then finally in all 3 cases
>> just call ati_2d_blt with the prepared source buffer. That way no changes
>> to ati_2d_blt is needed other than allowing it to take a state with the
>> source and dest data rather than getting it from registers. The part that
>> gets data from regs can be split out then what's left is what we need for
>> host data. I haven't thought through it in detail but I think it could
>> work and avoid duplicating the part that writes pixels to frame buffer.
>
> It took me a bit but I think I see what you mean now! Sending an RFC
> patch with a refactor that I think will set us up well to do this.

If something is not clear feel free to ask. It might be difficult to 
clearly describe vague ideas in English but as this was not clearly 
thought through yet it might not be a language issue.

Regards,
BALATON Zoltan

