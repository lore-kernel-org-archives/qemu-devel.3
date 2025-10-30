Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1C7CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 10:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEQ35-0008Ry-IA; Thu, 30 Oct 2025 06:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vEQ31-0008Q3-8l; Thu, 30 Oct 2025 06:38:27 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vEQ2v-0006j0-DR; Thu, 30 Oct 2025 06:38:26 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1B87459730E;
 Thu, 30 Oct 2025 11:38:11 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id PX7lzPGq0vyT; Thu, 30 Oct 2025 11:38:09 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 140D059730C; Thu, 30 Oct 2025 11:38:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 11DB759730B;
 Thu, 30 Oct 2025 11:38:09 +0100 (CET)
Date: Thu, 30 Oct 2025 11:38:09 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH 2/4] hw/pci-host/articia: Map PCI memory windows in realize
In-Reply-To: <318bf988-9035-4012-9708-40c3783803f8@redhat.com>
Message-ID: <b525a0c5-bcc0-7349-a925-6827591b7a34@eik.bme.hu>
References: <cover.1761346145.git.balaton@eik.bme.hu>
 <ceda4c28887c40e1c8eae3f561ee381ca98b0484.1761346145.git.balaton@eik.bme.hu>
 <7747275c-8e0a-4983-8613-fc39fc03bb39@linaro.org>
 <87b009e6-0d51-7409-61ad-dd65582eb13e@eik.bme.hu>
 <d23d5106-645c-466f-86e1-30ce20cc61d3@linaro.org>
 <dbdbc78f-3d4b-c0b2-87ac-85e24568a115@eik.bme.hu>
 <802b77f2-2c23-4b5a-a739-d56b09c335de@rsg.ci.i.u-tokyo.ac.jp>
 <28c6f065-ba8d-e5e2-922e-d5fd1fb58b60@eik.bme.hu>
 <db06bf5e-b7f5-4980-a054-393529e188eb@rsg.ci.i.u-tokyo.ac.jp>
 <759b6b4c-1155-184a-fa99-1df384f0fac3@eik.bme.hu>
 <aQJpDE6FvkIF6GgE@x1.local> <318bf988-9035-4012-9708-40c3783803f8@redhat.com>
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

On Thu, 30 Oct 2025, Paolo Bonzini wrote:
> On 10/29/25 20:20, Peter Xu wrote:
>> On Wed, Oct 29, 2025 at 11:30:10AM +0100, BALATON Zoltan wrote:
>>>> memory_region_new_* will work, but I don't think removing unnecessary
>>>> but harmless fields from a device state structure does not sufficiently
>>>> motivates adding them.
>>> 
>>> I haven't given up on this yet, that's why I alternatively proposed
>>> 
>>> object_alloc (same as object_new without object_initialize)
>>> memory_region_init
>>> 
>>> which is just a small change but should also work without adding
>>> memory_region_new convenience functions. Then only object_alloc needs to 
>>> be
>>> added.
>> 
>> IMHO if this will ever happen, memory_region_new*() is better, unless
>> object_alloc() can be used anywhere besides MemoryRegion..
>> 
>> It seems to me, MemoryRegion is the only one I'm aware of that may need
>> such tweak, rather than using object_new() directly.
>
> Yes, pretty much.  Anyhow, leaking on purpose with g_new is not a good idea. 
> It's g_new, not g_leak; and everyone else is using a field in the device 
> structure so I don't see why one would want to do differently.

I've tried to explain why I dislike that way in previous replies in this 
thread but here's a short summary:

- Not piling memory regions not otherwise needed in device struct makes it 
easier to understand. (Could you spot errors within the lot of boiler 
plate code before clean up? Having less code makes it more 
comprehensible.)

- Documentation says it should work this way QOM managing memory regions 
so it was meant to be that way. I'd rather fix code than documentation as 
I think if it just works that's easier than loosing that convenience.

- Allows simpler device models reusing superclasses without having to 
write much boiler plate code to create a subclass.

I'll send some patches that can be discussed later.

Regards,
BALATON Zoltan

