Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1826BC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 09:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwfMC-00032Z-B1; Tue, 16 Apr 2024 05:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rwfM9-00032K-RZ; Tue, 16 Apr 2024 05:44:02 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rwfM6-00040f-Jy; Tue, 16 Apr 2024 05:44:01 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 799F94E6047;
 Tue, 16 Apr 2024 11:43:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id ynIJh2_yaMPT; Tue, 16 Apr 2024 11:43:52 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8BEAD4E601D; Tue, 16 Apr 2024 11:43:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 88C4C7456B4;
 Tue, 16 Apr 2024 11:43:52 +0200 (CEST)
Date: Tue, 16 Apr 2024 11:43:52 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org
Subject: Re: [PATCH for-9.0] ppc440_pcix: Do not expose a bridge device on
 PCI bus
In-Reply-To: <D0L6WPE1ASIP.2KG5P0WQ86AM6@gmail.com>
Message-ID: <adb592cb-f58d-1eff-56a7-70fa11339fb7@eik.bme.hu>
References: <20240409235543.0E0C34E601C@zero.eik.bme.hu>
 <D0G5YFXXNK98.3NO5536V5LC8N@gmail.com>
 <887fc804-54a6-8f00-1b62-afcf247ba319@eik.bme.hu>
 <D0L6WPE1ASIP.2KG5P0WQ86AM6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

On Tue, 16 Apr 2024, Nicholas Piggin wrote:
> On Wed Apr 10, 2024 at 9:03 PM AEST, BALATON Zoltan wrote:
>> On Wed, 10 Apr 2024, Nicholas Piggin wrote:
>>> On Wed Apr 10, 2024 at 9:55 AM AEST, BALATON Zoltan wrote:
>>>> Real 460EX SoC apparently does not expose a bridge device and having
>>>> it appear on PCI bus confuses an AmigaOS file system driver that uses
>>>> this to detect which machine it is running on. Since values written
>>>> here by firmware are never read, just ignore these writes and drop the
>>>> bridge device.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>> This is only used by sam460ex and this fixes an issue with AmigaOS on
>>>> this machine so I'd like this to be merged for 9.0 please.
>>>
>>> Is it a regression? Does it have a fixes: or resolves: tag?
>>>
>>> Unless we broke it in this cycle, I would be inclined to wait,
>>> and we can ask to put it in stable.
>>
>> It's not something that broke in this cycle but since this does not affect
>> anything else than sam460ex I think it's OK to change this for 9.0. The
>> changes to 440 tlb in this cycle made sam460ex more useful to run AmigaOS
>> and this fixes the file system driver on it so it would make 9.0 really
>> usable. Otherwise people would have to wait longer until August or install
>> a stable update. Since this has low chance to break anything (tested with
>> AmogaOS and Linux and MorphOS does not boot due to do_io changes anyway) I
>> don't think we have to wait with this.
>
> Hey, travelling / at a conference / on vacation for the next couple of
> weeks.
>
> It's just a bit late for hard freeze IMO, since we didn't break it
> before the prior release or a bad security / crash bug. Will put it in
> 9.1.

Philippe already queued this (and another) patch. This fixes AmigaOS on 
sam460ex which became usable with the tlbwe changes in this cycle but it's 
not really usable without a file system driver that this patch fixes. 
Please allow this in 9.0 so users who want to try it don't have to wait a 
few months more. Sorry for sending it this late but it was reported late 
and took time to debug it.

Regards,
BALATON Zoltan

