Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E157C3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 10:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQlpG-0001ei-Dh; Mon, 08 Jul 2024 06:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sQlpB-0001du-LC; Mon, 08 Jul 2024 06:42:26 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sQlp9-0004UR-33; Mon, 08 Jul 2024 06:42:24 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 326014E601D;
 Mon, 08 Jul 2024 12:42:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id AdKSJJq-3IXt; Mon,  8 Jul 2024 12:42:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 373B04E6005; Mon, 08 Jul 2024 12:42:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 34DE8746E3B;
 Mon, 08 Jul 2024 12:42:14 +0200 (CEST)
Date: Mon, 8 Jul 2024 12:42:14 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 36/43] target/ppc/mmu-hash32: Remove some static inlines
 from header
In-Reply-To: <D2JYUJXKDPRD.3DRAIXV5VMA3P@gmail.com>
Message-ID: <ee4293d1-fb98-cf56-5d3d-8aac2b90f02e@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <3b3cce4a39e0debbf6fa29d4a2ead3014898cb93.1716763435.git.balaton@eik.bme.hu>
 <D2GKNUSA4XP0.35L5LIXFHYBTB@gmail.com>
 <0ac3436c-94f1-4210-6d3f-6086a664cb90@eik.bme.hu>
 <D2JYUJXKDPRD.3DRAIXV5VMA3P@gmail.com>
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

On Mon, 8 Jul 2024, Nicholas Piggin wrote:
> On Sun Jul 7, 2024 at 6:18 AM AEST, BALATON Zoltan wrote:
>> On Thu, 4 Jul 2024, Nicholas Piggin wrote:
>>> On Mon May 27, 2024 at 9:13 AM AEST, BALATON Zoltan wrote:
>>>> Two of these are not used anywhere and the other two are used only
>>>> once and can be inlined and removed from the header.
>>>
>>> I'd prefer to put these in the .c file. Probably calculating the
>>> base once would generate marginally better code since it would not
>>> have to keep reloading it (since there is a barrier there it can't
>>> cache the value).
>>
>> These aren't even used anywhere but one function and they are inefficient
>> becuase they would call ppc_hash32_hpt_base() on each call. Next patch
>> even removes base and calculates pte_addr once before the loop, then it's
>> quite straight forward what these read from guest memory even without
>> inline functions. I see no reason to keep these inline functions.
>
> Make them take the hash base instead of cpu if that's the performance
> issue to solve. And open coded access can always be converted to use
> it.

If you look at the next patch you can see the base calculatoin is gone and 
it does pte_addr = ppc_hash32_hpt_base(cpu) + pteg_off once at the 
beginning before the loop, then the function you want to make is just: 
pte0 = ldl_phys(CPU(cpu)->as, pte_addr). I don't think it's worth making 
it a separate fucntion .The other one
pte1 = ldl_phys(CPU(cpu)->as, pte_addr + HASH_PTE_SIZE_32 / 2)
still has some calculation left but that's pretty straight forward. Maybe 
we could add a mcacro for HASH_PTE_SIZE_32 / 2 like HARH_PTE1_OFFS or 
something but I don't think that or having separate functions for this 
would add any more clarity just unnecessary complication. Yout one line 
helpers would only be used by ppc_hash32_pteg_search which is already a 
helper tp get pte values so open coding it within this function is OK in 
my opinion. There are no other places your helper functions would be 
needed.

Regards,
BALATON Zoltlan

