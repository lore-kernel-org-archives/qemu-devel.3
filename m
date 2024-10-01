Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AB6CF3189
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 23:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svmPK-0004Cf-Bd; Tue, 01 Oct 2024 19:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1svmPI-0004Bu-Mk; Tue, 01 Oct 2024 19:35:52 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1svmPH-0002QB-4R; Tue, 01 Oct 2024 19:35:52 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 076CD4E6004;
 Wed, 02 Oct 2024 01:35:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Uh0zQsa-bPt1; Wed,  2 Oct 2024 01:35:43 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 15B3F4E6000; Wed, 02 Oct 2024 01:35:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 13A04746F60;
 Wed, 02 Oct 2024 01:35:43 +0200 (CEST)
Date: Wed, 2 Oct 2024 01:35:43 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 1/2] hw/ppc: Consolidate e500 initial mapping creation
 functions
In-Reply-To: <AB32405D-9A0A-4332-98F6-174650648DB7@gmail.com>
Message-ID: <a44351ad-2de0-0806-34a4-2cf3f10ff855@eik.bme.hu>
References: <cover.1721131193.git.balaton@eik.bme.hu>
 <485a90bca642c894d94c8dbcadac58448c0bfa71.1721131193.git.balaton@eik.bme.hu>
 <C252CEDD-75BE-4A32-9EA3-98FECBF36BA8@gmail.com>
 <AB32405D-9A0A-4332-98F6-174650648DB7@gmail.com>
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

On Tue, 1 Oct 2024, Bernhard Beschow wrote:
> Am 15. August 2024 19:01:47 UTC schrieb Bernhard Beschow <shentey@gmail.com>:
>> Am 16. Juli 2024 12:07:57 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>>> Add booke206_set_tlb() utility function and use it to replace very
>>> similar create_initial_mapping functions in e500 machines.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
[...]
>>> -    mmubooke_create_initial_mapping(env);
>>> +    /* create initial mapping */
>>> +    booke206_set_tlb(tlb, 0, 0, map_size);
>>
>> Both invocations of booke206_set_tlb() are followed by:
>>
>>> +#ifdef CONFIG_KVM
>>> +    env->tlb_dirty = true;
>>> +#endif
>>
>> Doesn't it make sense to move these three lines into booke206_set_tlb()? The two copies you're resolving did so, too.
>
> Ping

Did not forget but had no time to look at it yet. I'll come back to it 
when I'll have time.

Regards,
BALATON Zoltan

>>
>> Best regards,
>> Bernhard

