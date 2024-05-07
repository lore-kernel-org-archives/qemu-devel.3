Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702E6C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4KIR-0004vl-IL; Tue, 07 May 2024 08:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4KIH-0004i3-It; Tue, 07 May 2024 08:51:43 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4KIC-00025W-0o; Tue, 07 May 2024 08:51:39 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C35BD4E65BB;
 Tue, 07 May 2024 14:51:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id yaeOmZts5QFC; Tue,  7 May 2024 14:51:29 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D3EA84E602F; Tue, 07 May 2024 14:51:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D29D1746E3B;
 Tue, 07 May 2024 14:51:29 +0200 (CEST)
Date: Tue, 7 May 2024 14:51:29 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 00/28] Misc PPC exception and BookE MMU clean ups
In-Reply-To: <D13F89JFC1G4.2FJHXLMJWYYCC@gmail.com>
Message-ID: <3b681f1b-ffd0-8110-6333-b4b8dc241787@eik.bme.hu>
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <D13F89JFC1G4.2FJHXLMJWYYCC@gmail.com>
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

On Tue, 7 May 2024, Nicholas Piggin wrote:
> On Thu May 2, 2024 at 9:43 AM AEST, BALATON Zoltan wrote:
>> This series does some further clean up mostly around BookE MMU to
>> untangle it from other MMU models. It also contains some other changes
>> that I've come up with while working on this. The first 3 patches are
>> from the last exception handling clean up series that were dropped due
>> to some error on CI but I'm not sure if that was because of some CI
>> infrastructure problem or some problem with the patches as the error
>> did not make much sense. So these patches are only rebased now, I made
>> no other change to them until the issue is understood better. The rest
>> are new patches I've added since tha last series. Please review.
>
> Not CI infrastructure as far as I could tell it's upstream gitlab.
> But I could not figure out how to reproduce at the time... I ended
> up running out of time to look too closely though.

I could reproduce it at the end so it wasn't CI failure but I don't 
completely understand what is it.

> I think I won't take the first 2, yes arguably the CPU does execute
> the sc instruction, but it's actually a good rule for the exception
> handler to be invoked with the nip that caused the exception, and
> SRR0/1 to be set by the handler according to semantics.
>>
>> v2:
>> - Fix user mode issue in patch 1 by keeping old behaviour for user mode

I forgot to change the blurb above but in this v2 version I think I've 
solved that problem as noted here but I don't know why the user mode SC is 
different and could not find where is it handled. This version seems to 
work though.

Regards,
BALATON Zoltan

