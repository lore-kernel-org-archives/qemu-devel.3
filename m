Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7278CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 01:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urRDJ-0008RF-0C; Wed, 27 Aug 2025 21:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1urRDF-0008Ov-N6; Wed, 27 Aug 2025 21:14:01 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1urRDC-0004go-A6; Wed, 27 Aug 2025 21:14:01 -0400
Received: from [192.168.10.111] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 57S17vjT001992
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 28 Aug 2025 10:07:57 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=lnzJaGo+S0SGnjugScrfWavDqjuQmVHGj+faDXY9nA4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1756343277; v=1;
 b=h8BhwzdkxYVQAn9gDO5rnQdqdp/dswPMsCJqTuImUzPBkeJsHyFBfwTKorO6YNQF
 JGheTbollckgcicBPG2cPjTnJni+zPZzOif/mddyhRE3DkUTAR4PIHWGYL5IH8xe
 yCQNXodVvGp0J2474gSNv8SajdeDw5rAJI5k/Tj3NhxO7kfvnO7WLA8R+aXZ+xo0
 40vJ4eyG5PxMhANC91Wl3oUz2KoQ/aM4gVrNgKPjxJYynW4vzJYq/1awF48EUQz8
 30UYMfBSzuzjCIAT32PqxO0+h54sObQUiJHIdJkYkdd/nPDHJ+hE0y8PmLHpCOdo
 4Ru8ssFH+9gT6YiHvimyxw==
Message-ID: <e4e0b75a-0990-4108-88f9-f49a346f515b@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 28 Aug 2025 10:07:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] memory: Do not create circular reference with
 subregion
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org, devel@daynix.com
References: <20250110-san-v8-0-57a5a1be1bcf@daynix.com>
 <20250110-san-v8-2-57a5a1be1bcf@daynix.com>
 <CAFEAcA-aTYebu-5s4AeBfE3oLQfxTwCpeosoj0TU8E_XPu_ZDg@mail.gmail.com>
 <CAFEAcA-ygHuA5BH+oftCGDKZOh8CHbiUKE4v=-iXvCaKzG4kHQ@mail.gmail.com>
 <aKctCjv8newNIX71@x1.local>
 <CAFEAcA8DV40fGsci76r4yeP1P-SP_QjNRDD2OzPxjx5wRs0GEg@mail.gmail.com>
 <aKdizYeNGocXvTzv@x1.local>
 <CAFEAcA8dKu3mSuD=rJkwDPcvqQASsOpFPdpG4Ht59GrTb+AywA@mail.gmail.com>
 <aK4tuhRfotpndpa8@x1.local>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aK4tuhRfotpndpa8@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/08/27 6:57, Peter Xu wrote:
> On Tue, Aug 26, 2025 at 06:45:43PM +0100, Peter Maydell wrote:
>> On Thu, 21 Aug 2025 at 19:18, Peter Xu <peterx@redhat.com> wrote:
>>> I remember I provided a draft somewhere during the discussion, anyway.. I
>>> redid it, and attached a formal patch below that will contain the removal
>>> of the mr->container check (plus auto-detach when it happens).  The hope is
>>> this should work.. and comparing to the v8 of Akihiko's, it won't make MR's
>>> own refcount any more complicated.
>>>
>>> If necessary, I can send a formal patch.
>>
>> This patch seems to work, in that it fixes the memory-region
>> related leaks I previously was seeing. Review comments below
>> (which are only about the commit message and docs).
>>
>> I also can't remember the details of the previous discussions about
>> these patches, so I'm reviewing the one below essentially from
>> scratch. Apologies in advance if we end up going back around
>> a conversation loop that we've already had...
>>
>>> Thanks,
>>>
>>> ===8<===
>>>  From f985c54af3e276b175bcb02725a5fb996c3f5fe5 Mon Sep 17 00:00:00 2001
>>> From: Peter Xu <peterx@redhat.com>
>>> Date: Thu, 21 Aug 2025 12:59:02 -0400
>>> Subject: [PATCH] memory: Fix leaks due to owner-shared MRs circular references
>>>
>>> Currently, QEMU refcounts the MR by always taking it from the owner.
>>>
>>> It should be non-issue if all the owners of MRs will properly detach all
>>> the MRs from their parents by memory_region_del_subregion() when the owner
>>> will be freed.  However, it turns out many of the device emulations do not
>>> do that properly.  It might be a challenge to fix all of such occurances.
>>
>> I think that it's not really right to cast this as "some devices
>> don't do this right". The pattern of "a device has a container MR C
>> and some other MRs A, B... which it puts into C" is a legitimate one.
>> If you do this then (with the current code in QEMU) there is *no*
>> place where a device emulation can do a manual "remove A, B.. from
>> the container C so the refcounts go down": the place where devices
>> undo what they did in instance_init is instance_deinit, but we
>> will never call instance_deinit because the refcount of the owning
>> device never goes to 0.
> 
> It should still be able to reach zero if we skip the refcount of internal
> MR subregions like what this patch does.
> 
> Said that, I think you're right..  the problem is we have object_deinit()
> after object_property_del_all() (in object_finalize()), which means
> memory_region_finalize() will be invoked before object_deinit()..  Then it
> looks wrong now to delete subregions in a deinit() even if reachable,
> because the MRs should have been freed..
> 
>>
>> Further, even if we had some place where devices could somehow
>> undo the "put A, B... in the container so the refcounts go down
>> correctly", it is better API design to have the memory.c code
>> automatically handle this situation. "This just works" is more
>> reliable than "this works if you do cleanup step X", because it's
>> impossible to have the bug where you forget to write the code to
>> do the cleanup step.
> 
> Fair enough.
> 
>>
>>> Without fixing it, QEMU faces circular reference issue when an owner can
>>> contain more than one MRs, then when they are linked within each other in
>>> form of subregions, those links keep the owner alive forever, causing
>>> memory leaks even if all the external refcounts are released for the owner.
>>>
>>> To fix that, teach memory API to stop refcount on MRs that share the same
>>> owner because if they share the lifecycle of the owner, then they share the
>>> same lifecycle between themselves.
>>>
>>> Meanwhile, allow auto-detachments of MRs during finalize() of MRs even
>>> against its container, as long as they belong to the same owner.
>>>
>>> The latter is needed because now it's possible to have MR finalize() happen
>>> in any order when they exactly share the same lifespan.  In this case, we
>>> should allow finalize() to happen in any order of either the parent or
>>> child MR, however it should be guaranteed that the mr->container shares the
>>> same owner of this MR to be finalized.
>>>
>>> Proper document this behavior in code.
>>>
>>> This patch is heavily based on the work done by Akihiko Odaki:
>>>
>>> https://lore.kernel.org/r/CAFEAcA8DV40fGsci76r4yeP1P-SP_QjNRDD2OzPxjx5wRs0GEg@mail.gmail.com
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>   docs/devel/memory.rst |  9 +++++++--
>>>   system/memory.c       | 45 ++++++++++++++++++++++++++++++++++---------
>>>   2 files changed, 43 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
>>> index 57fb2aec76..1367c7caf7 100644
>>> --- a/docs/devel/memory.rst
>>> +++ b/docs/devel/memory.rst
>>> @@ -158,8 +158,13 @@ ioeventfd) can be changed during the region lifecycle.  They take effect
>>>   as soon as the region is made visible.  This can be immediately, later,
>>>   or never.
>>>
>>> -Destruction of a memory region happens automatically when the owner
>>> -object dies.
>>> +Destruction of a memory region happens automatically when the owner object
>>> +dies.  Note that the MRs under the same owner can be destroyed in any order
>>> +when the owner object dies.  It's because the MRs will share the same
>>> +lifespan of the owner, no matter if its a container or child MR.  It's
>>> +suggested to always cleanly detach the MRs under the owner object when the
>>> +owner object is going to be destroyed, however it is not required, as the
>>> +memory core will automatically detach the links when MRs are destroyed.
>>
>> I think we should not say "we suggest you always cleanly detach the MRs":
>> instead we should say "you can rely on this happening, so you don't
>> need to write manual code to do it".
>>
>> The actual code changes look OK to me.
> 
> I'll send the patch out officially for review, with above point taken.
> 
> Akihiko, let me know anytime when you want to either add your SoB or take
> over the ownership of the patch.  I'll be OK with it.

I'm not in favor of the change. There was a long discussion in the past, 
but I think the following email is the most comprehensive description of 
my point and includes comparison between the two approaches:
https://lore.kernel.org/qemu-devel/2fe8b128-dda1-40af-89ac-e86ba53138f5@daynix.com/

So please check the email and reply it.

Regards,
Akihiko Odaki

