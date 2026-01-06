Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BBDCEFCF2
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 18:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdCHC-0002Ag-0e; Tue, 06 Jan 2026 13:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vdCH9-000273-6B; Tue, 06 Jan 2026 13:59:27 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vdCH6-0002PF-P9; Tue, 06 Jan 2026 13:59:26 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AB6F9596A3F;
 Tue, 06 Jan 2026 19:59:17 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 5JMmR9F-JT53; Tue,  6 Jan 2026 19:59:15 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 90E34596A0B; Tue, 06 Jan 2026 19:59:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8F319596A0A;
 Tue, 06 Jan 2026 19:59:15 +0100 (CET)
Date: Tue, 6 Jan 2026 19:59:15 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, qemu-devel-bounces+chad=jablonski.xyz@nongnu.org
Subject: Re: [PATCH v3 11/11] ati-vga: Implement HOST_DATA flush to VRAM
In-Reply-To: <DFHPPRS7DTVW.2PTTBH4FJ3B36@jablonski.xyz>
Message-ID: <14816238-b76c-9dd8-1443-21a15aadbbf0@eik.bme.hu>
References: <20251118154812.57861-1-chad@jablonski.xyz>
 <20251118154812.57861-12-chad@jablonski.xyz>
 <52c0918b-dd96-2a47-5221-2bd34eeaa7f7@eik.bme.hu>
 <DFHPPRS7DTVW.2PTTBH4FJ3B36@jablonski.xyz>
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

On Tue, 6 Jan 2026, Chad Jablonski wrote:
>> I've tested it with MorphOS and TVPaint but it does not seem to work for
>> that driver. It never writes HOST_DATA_LAST, only 0 or 0 1 or sometimes
>> 0-7 but never LAST so it must rely on results being flushed after enough
>> writes. I got some traces like these below in case you can guess what
>> might be needed for it.
>>
>
> This has been _very_ helpful. I was able to track down a few issues
> based on this trace output. Yes, MorphOS doesn't seem to be following
> the docs and sending HOST_DATA_LAST which is unfortunate. But they do (at
> least based on these traces) seem to be sending HOST_DATA aligned to
> 128-bits. So the accumulator is flushed correctly at that point.
>
> The big issue here was that this exercised another code path by setting
> blit settings on the DP_MIX and DP_DATATYPE registers directly rather
> than through DP_GUI_MASTER_CNTL like Xorg. That surfaced an issue where
> those registers were being treated as independent state when really
> DP_GUI_MASTER_CNTL is just an alias of sorts to some DP_MIX and
> DP_DATATYPE registers. This was an existing issue so V4 will contain a
> patch early in the series that addresses it. The path I took was to
> break these fields out into their own values on the register struct.
> Which makes for less shifting and masking. Curious how you feel about it
> though when you get a chance to take a look.
>
> The second issue, which was invisible because of the first was that bit
> ordering was broken. I had made the mistake of ordering the bits across
> the entire 32-bit word rather than for each byte. Unfortunately my test
> cases were simple enough that the problem didn't become apparent until I
> saw this trace output!
>
> All that to say V4 will render bitmap fonts for TVPaint correctly. There
> are some places (like buttons) that use transparency and HOST_DATA which
> is not yet implemented but at least now we see the UNIMPL messages in
> the log.
>
> This was a great excuse to get MorphOS up and running so I'll be
> able to test against it going forward! Thanks again for capturing these
> traces.
>
> I've also addressed all of your other feedback and will send V4 shortly.

Great! Big thank you for doing this and looking forward to your patches. I 
found that it's often helpful to test with multiple different guests as 
these have different drivers that do things differently so that helps to 
identify corner cases and endian issues. Also I usually check both 
Rage128Pro and M6/RV100 docs for registers as sometimes these have 
additional info. One of those mentions that DP_GUI_MASTER_CNTL bits are 
aliases to other bits in other registers but this is not mentioned in the 
other doc. It's possible that I took shortcuts for bits that were not used 
and haven't implemented them as an alias as they should be. I'll review 
the series later.

Regards,
BALATON Zoltan

