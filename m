Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E19CD2FEDE
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 20:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkpa1-0002Zp-1y; Tue, 27 Jan 2026 15:22:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vkpZw-0002YM-QZ
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 15:22:24 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vkpZu-0004rF-La
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 15:22:24 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D142E5969FA;
 Tue, 27 Jan 2026 21:22:17 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id E-6mGHxVwq4l; Tue, 27 Jan 2026 21:22:15 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C4EC55969F3; Tue, 27 Jan 2026 21:22:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C31785969F0;
 Tue, 27 Jan 2026 21:22:15 +0100 (CET)
Date: Tue, 27 Jan 2026 21:22:15 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Xu <peterx@redhat.com>
cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 00/10] Implement memory_region_new_* functions
In-Reply-To: <aXkXWGho7lnJ-gwX@x1.local>
Message-ID: <2fa59d39-5634-0b8c-27ee-9e9548a7f92a@eik.bme.hu>
References: <cover.1769362313.git.balaton@eik.bme.hu>
 <CAFEAcA_jS3hef=dhxZ5s7MReSW4ir+jMUGwu+RjD_JP7ZRrRXQ@mail.gmail.com>
 <0118dc9b-d467-7f6b-92a8-4f42760ecb6c@eik.bme.hu> <aXkXWGho7lnJ-gwX@x1.local>
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

On Tue, 27 Jan 2026, Peter Xu wrote:
> On Tue, Jan 27, 2026 at 03:10:28PM +0100, BALATON Zoltan wrote:
>> This series does not convert everything but opens the way to do that and
>> simplify objects by only storing things in the state that are really needed
>> by the object and let QOM manage what it can. I'd really like to avoid
>> having a list of unused stuff in the state struct just because I can't use
>> something that works and documented just no API to actually use it. Cf.
>> sii3112 state after this series:
>>
>> struct SiI3112PCIState {
>>     PCIIDEState i;
>>
>>     SiI3112Regs regs[2];
>> };
>>
>> vs. your standard:
>>
>> struct SiI3112PCIState {
>>     PCIIDEState i;
>>
>>     MemoryRegion mmio;
>>     MemoryRegion bar0;
>>     MemoryRegion bar1;
>>     MemoryRegion bar2;
>>     MemoryRegion bar3;
>>     MemoryRegion bar4;
>>     SiI3112Regs regs[2];
>> };
>
> The latter solution is fine at least to me.
>
> I respect your preference on how it can be done, but IMHO it is subjective,
> and I tend to agree with Peter that we should try to stick with one way of
> solving problems, unless very necessary.
>
> In the last three patches the MRs do not look need dynamic deallocation to
> me at all..  Introducing fully dynamic MR allocations only for those is an
> overkill to me.  I'm not fully convinced we need to merge 600+ new LOCs for
> new APIs just for them.

It's not a new API in the sense that it's the same as existing 
memory_region_init functions just a variant of it to allow using QOM to 
manage the lifetime of the memory region which the current API does not 
allow. Also this series does not introduce this dynamic lifetime 
management, it's already implemented and documented just there's currently 
no way to use it. The actual change is much less, most of the lines are 
just the documentation comments. If it's a problem to increase 
documentation size I could make it much shorter not duplicating a separate 
doc comment for these just mention in the corresponding memory_region_init 
doc comment that there's also an analogous memory_region_new variant of 
it. That also shows there's no new API just two ways of using the same 
API.

> We have real but rare users of dynamically allocated MRs, currently AFAIU

Since it's already implemented why not use it if it makes the object state 
simpler? Adding additional fields that would already be managed by QOM 
seems to be unnecessary duplication and complication to me so I'd like to 
avoid that and keep the subclass simple.

Regards,
BALATON Zoltan

> we're leaning towards having an object wrapping the MRs needed, when one
> wants to provide a complete lifecycle for the MR so the memory backing the
> MRs can be freed completely separately from the parent object.
>
> Thanks,
>
>

