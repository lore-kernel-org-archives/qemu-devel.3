Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4CEC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 23:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4qnL-0001RG-Bm; Wed, 08 May 2024 19:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4qnI-0001Qf-SN; Wed, 08 May 2024 19:33:52 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4qnG-0000yV-QJ; Wed, 08 May 2024 19:33:52 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 096814E6030;
 Thu, 09 May 2024 01:33:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id aMq-XOdjxQrD; Thu,  9 May 2024 01:33:44 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1AADE4E6013; Thu, 09 May 2024 01:33:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 18A8E746E3B;
 Thu, 09 May 2024 01:33:44 +0200 (CEST)
Date: Thu, 9 May 2024 01:33:44 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 26/28] target/ppc/mmu_common.c: Move BookE MMU functions
 together
In-Reply-To: <D149IYMCXH4Z.ZPIXWOVQVOZO@gmail.com>
Message-ID: <841877bd-04d6-7608-b762-322962afad59@eik.bme.hu>
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <d5d70791bdf598cd28ee70fd058f51c257a2b969.1714606359.git.balaton@eik.bme.hu>
 <D13EMTIRPDQJ.2LCAHIOTN0W5N@gmail.com>
 <090308e7-e3c0-8129-bdae-c2e3a41a2aa5@eik.bme.hu>
 <D149IYMCXH4Z.ZPIXWOVQVOZO@gmail.com>
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

On Wed, 8 May 2024, Nicholas Piggin wrote:
> On Tue May 7, 2024 at 10:31 PM AEST, BALATON Zoltan wrote:
>> On Tue, 7 May 2024, Nicholas Piggin wrote:
>>> What do you think about adding mmu-book3e.c instead?
>>
>> I have considered that but found that some functions have to be in the
>> same file and declared static for the compiler to inline them otherwise I
>> get worse performance. Maybe after these rearrangments it's now possible
>> to move these out but as this series got a bit long already I dod not go
>> through with that and left it for a follow up but I can give it a try.
>
> It would be nice.

OK I've done that now as this also helps with some of the unint warnings 
but I could not get rid of all work arounds completely.

> What host machines are you using? I'm surprised inlining is causing
> so much performance unless it is something older or in-order.

Maybe it depends more on the compiler than host. I still use gcc 10 with 
default -O2 level. Some people found that -O3 and LTO may help a bit but I 
test with default QEMU settings as that may be what most use.

Regards,
BALATON Zoltan

