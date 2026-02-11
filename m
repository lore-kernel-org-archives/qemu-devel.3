Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E96E9E2EC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 11:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq8ld-0003qN-UF; Wed, 11 Feb 2026 06:52:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vq8lZ-0003py-Rx
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 06:52:21 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vq8lY-0000cj-41
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 06:52:21 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 742EC596A10;
 Wed, 11 Feb 2026 12:52:18 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id n1mFluJusCOg; Wed, 11 Feb 2026 12:52:16 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0C3EC596A0D; Wed, 11 Feb 2026 12:52:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0A5395969F6;
 Wed, 11 Feb 2026 12:52:16 +0100 (CET)
Date: Wed, 11 Feb 2026 12:52:16 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Howard Spoelstra <hsp.cat7@gmail.com>
cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Phil_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Implement frame number overflow event
In-Reply-To: <a319dce1e9ed3daefe744d4a198748bd5fa55b7f.camel@gmail.com>
Message-ID: <85614b26-c558-e26f-eab6-76cb2e69ab10@eik.bme.hu>
References: <20260209001836.5413F5969F2@zero.eik.bme.hu>
 <CAFEAcA-HwiOfh6sXa3OvFtrMotoaEpB9ZoLXq_5aXDoVqh8wqA@mail.gmail.com>
 <61b053d3-70e0-4b63-8b32-c8c7bef36229@eik.bme.hu>
 <04edd79e-2ec4-912e-d8ad-6012feaa3c99@eik.bme.hu>
 <a319dce1e9ed3daefe744d4a198748bd5fa55b7f.camel@gmail.com>
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

On Wed, 11 Feb 2026, Howard Spoelstra wrote:
> On Tue, 2026-02-10 at 16:40 +0100, BALATON Zoltan wrote:
>> On Tue, 10 Feb 2026, BALATON Zoltan wrote:
>>> On Tue, 10 Feb 2026, Peter Maydell wrote:
>>>> On Mon, 9 Feb 2026 at 00:19, BALATON Zoltan <balaton@eik.bme.hu>
>>>> wrote:
>>>>>
>>>>> According to specification 6.5.6 FrameNumberOverflow Event when
>>>>> bit 15
>>>>> of frame count changes (either from 1 to 0 or 0 to 1) a
>>>>> FrameNumberOverflow interrupt should be generated.
>>>>>
>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>
>>>> Is this a bug fix for some specific problem (e.g. it fixes
>>>> handling for some guest OS)? If so, we should say what it's
>>>> fixing in the commit message, so that if we ever come back
>>>> to this in future we know what we need to test to make sure
>>>> we don't re-break it.
>>>
>>> Primarily it fixes what it says in the commit message: compliance
>>> to the
>>> actual specification but it also seems to help MacOS to be able to
>>> use
>>> usb-audio which was how Howard found it. Unless there's something
>>> else to
>>> change in the patch I'm not sending a v2 feel free to tweak commit
>>> message on
>>> merge if needed.
>>
>> There's also this ticket that Howard sent me:
>> https://gitlab.com/qemu-project/qemu/-/issues/3274
>> but I don't know if we can add a Resolves to this patch for that as
>> it
>> only solves one of the issues the patch in that ticket tries to solve
>> but
>> apparently this is enough for MacOS 9. I hoped those involved in that
>> ticket could test this or comment on this patch.
>>
>> Regards,
>> BALATON Zoltan
>>
>> For Mac OS 9.x this patch is sufficient. But not for Mac OS X guests.
>> They require a second patch along the lines the one I sent earlier.
>> That second patch is also based on hcd-ohci not conforming to the
>> standard regarding (start_addr > end_addr) if these are not on the
>> same page and the start_addr is higher than the end_addr. See spec
>> 4.3.2.3.1 Buffer Addressing.
>>
>> Best,
> Howard

That change can only be merged if you make a proper patch and send it to 
the list as described here:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html
Putting the patch in the ticket won't help unless it at least has a 
signed-off-by tag but as USB is pretty much unmaintained even if you 
submit patches to the list it might take a while to get merged by 
somebody and most probably be forgotten if you just put it in a ticket.

Regards,
BALATON Zoltan

