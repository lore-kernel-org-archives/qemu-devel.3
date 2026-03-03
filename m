Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057A5E67A92
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 08:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxKpF-0004Ub-CJ; Tue, 03 Mar 2026 03:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxKpB-0004UE-Tj
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 03:09:50 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxKow-0007pg-JP
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 03:09:37 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6238980S037594
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 3 Mar 2026 17:09:09 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=yNWw/dNZHLPaF//NvAvsMyG48E0Tz/mq7xEZ5rlUP4Y=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772525349; v=1;
 b=mrGQ0chDuUvCCra6jGWMLC9H3PpuE74iyyCdPKpUqFjMQLAysI/Q86Wv7IcgSvZK
 MG7hhQxFo2dL4iWSUnjfPqYkDzm1Dojg+opkmjSpaGi8SX6eUUS3YE4By/HyOV/O
 xjO5XR4CAqfbv/4LWYbEvbelCe09iFoLbAYu51j0nN2ea+5rYFNgRF2TmuVtY781
 r/iqZVMz3MI76Q82FoD1vdeiPhrXGIdAz3X1EE/OjQpvK/4ouQJwjuIhiBslccab
 0qqyBnsM+MThkIQWt7hK22InZCgiA+7mG981/WsTYqlmHQEraYaCCYlKlcEJFOQm
 jah5OmAT2LbsJ+LMyv++Aw==
Message-ID: <aaaa3663-29bf-485d-9406-e0a2712b4baa@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 3 Mar 2026 17:09:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] memory: Remove most _nomigrate variants
To: BALATON Zoltan <balaton@eik.bme.hu>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <cover.1770253186.git.balaton@eik.bme.hu>
 <aZ3CQw2ad5cVc-Mm@x1.local> <c8a789fa-8d16-709d-eb3f-8acd6c1d08e8@eik.bme.hu>
 <aZ8jmaB-zuBSoQXH@x1.local>
 <997bf152-3982-490b-8450-06095ffad22b@rsg.ci.i.u-tokyo.ac.jp>
 <01f28121-0306-39e9-6526-fef766388eab@eik.bme.hu>
 <0c750924-95a1-4fc8-ab7c-93ca19b791dc@rsg.ci.i.u-tokyo.ac.jp>
 <b09d2e8a-3b64-e537-b9e0-8037e2855fdc@eik.bme.hu> <aaXxS0zdMKMoyjvA@x1.local>
 <5ca90707-6feb-b382-937a-0b114a914d5d@eik.bme.hu>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <5ca90707-6feb-b382-937a-0b114a914d5d@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/03/03 6:06, BALATON Zoltan wrote:
> On Mon, 2 Mar 2026, Peter Xu wrote:
>> On Mon, Mar 02, 2026 at 04:20:10PM +0100, BALATON Zoltan wrote:
>>> On Mon, 2 Mar 2026, Akihiko Odaki wrote:
>>>> On 2026/03/02 21:26, BALATON Zoltan wrote:
>>>>> On Mon, 2 Mar 2026, Akihiko Odaki wrote:
>>>>>> On 2026/02/26 1:30, Peter Xu wrote:
>>>>>>> On Tue, Feb 24, 2026 at 06:44:58PM +0100, BALATON Zoltan wrote:
>>>>>>>> On Tue, 24 Feb 2026, Peter Xu wrote:
>>>>>>>>> On Thu, Feb 05, 2026 at 02:13:18AM +0100, BALATON Zoltan wrote:
>>>>>>>>>> v4:
>>>>>>>>>> - separate patch converting Sun machines from
>>>>>>>>>> memory_region_init_ram_nomigrate
>>>>>>>>>> - split helper to init ram into two functions:
>>>>>>>>>> setup and error_propagate
>>>>>>>>>> - also use memory_region_init_io in 
>>>>>>>>>> memory_region_init_ram_device_ptr
>>>>>>>>>>
>>>>>>>>>> v3:
>>>>>>>>>> - rebased on master after some patches were merged
>>>>>>>>>> - drop some more line from memory-region-housekeeping.cocci
>>>>>>>>>> - added comment to explain what factored out helper does
>>>>>>>>>> - some more clean ups included
>>>>>>>>>>
>>>>>>>>>> BALATON Zoltan (8):
>>>>>>>>>>    hw/display/{cg3,tcx}: Do not use 
>>>>>>>>>> memory_region_init_rom_nomigrate()
>>>>>>>>>>    memory: Remove memory_region_init_rom_nomigrate()
>>>>>>>>>>    sun4m,sun4u,tcx: Do not use memory_region_init_ram_nomigrate()
>>>>>>>>>>    memory: Remove memory_region_init_ram_nomigrate()
>>>>>>>>>
>>>>>>>>> Could you help explain why we need to remove the
>>>>>>>>> above two small helpers?
>>>>>>>>
>>>>>>>> Ideally we should remove all of the nomigrate variants as there 
>>>>>>>> are only
>>>>>>>> about 3 uses left, everything else is already moved to
>>>>>>>> the init_{ram,rom}
>>>>>>>> variants that register the memory region for migration.
>>>>>>>> The is probably one
>>>>>>>> legitimate use that is served by 
>>>>>>>> memory_region_init_flags_nomigrate and
>>>>>>>> other 3 uses are the xtfpga which I think is just old code and 
>>>>>>>> does not
>>>>>>>> support migration so it will be converted in the second series to
>>>>>>>> memory_region_new as the maintainers did not say anyting to that 
>>>>>>>> so far.
>>>>>>>> Then there's one in hw/display/vga but that's gated
>>>>>>>> behind a compatibility
>>>>>>>> switch that's only set in 2.12 (global-vmstate=true) and
>>>>>>>> earlier. This is
>>>>>>>> not active any more but cannot yet be removed as there
>>>>>>>> are eariler compat
>>>>>>>> props still need cleaning up but the last visible
>>>>>>>> machine version is 5.1 now
>>>>>>>> so this is long deprecated and not used. And there are
>>>>>>>> these Sun machines
>>>>>>>> that I've converted in the first version but Mark said
>>>>>>>> he'd like to keep the
>>>>>>>> current behaviour until it's the last user left. See:
>>>>>>>> https://
>>>>>>>> patchew.org/QEMU/cover.1769703287.git.balaton@eik.bme.hu/ 
>>>>>>>> b530cf54609b853c6b34306fd4aa3ce2f8087d05.1769703287.git.balaton@eik.bme.hu/
>>>>>>>>
>>>>>>>>> Not saying that we can't remove them, but I don't yet see the 
>>>>>>>>> point of
>>>>>>>>> open-code those readonly=true setup either, or any
>>>>>>>>> problem with having the
>>>>>>>>> smaller helpers when ram_flags=0.  Small helpers
>>>>>>>>> sometimes help readability.
>>>>>>>>>
>>>>>>>>> Some of them are going backwards againist what the cocci 
>>>>>>>>> scripts were
>>>>>>>>> suggesting previously, like:
>>>>>>>>>
>>>>>>>>> - memory_region_init_ram_nomigrate(E1, E2, E3, E4, E5);
>>>>>>>>> + memory_region_init_rom_nomigrate(E1, E2, E3, E4, E5);
>>>>>>>>>   ... WHEN != E1
>>>>>>>>> - memory_region_set_readonly(E1, true);
>>>>>>>>>
>>>>>>>>> So you suggest open-code instead.  Why?
>>>>>>>>
>>>>>>>> This is temporary until the usage in vga is gone with
>>>>>>>> hw_compat_2_12 then
>>>>>>>> the Sun machines will be the last users so they can also be 
>>>>>>>> converted to
>>>>>>>> init_{ram,rom} (unless Mark changes his mind and agrees
>>>>>>>> changing these now
>>>>>>>> as was in the first version).
>>>>>>>>
>>>>>>>>> Is it required for your follow up cleanups?
>>>>>>>>
>>>>>>>> It makes those simpler as then we don't need to add 
>>>>>>>> memory_region_new
>>>>>>>> variants for the nomigrate versions that we would remove later 
>>>>>>>> anyway.
>>>>>>>
>>>>>>> Personally I don't see the memory_region_new() whole thing solid 
>>>>>>> yet, but
>>>>>>> still during review.  I shared my thoughts.  So far, I'm not fully
>>>>>>> convinced, but I also don't have the full picture to say no, 
>>>>>>> either.  We
>>>>>>> can wait for others to chime in with more thoughts.
>>>>>>>
>>>>>>> For this series, I would prefer if we can discuss it separately 
>>>>>>> from the
>>>>>>> other work.
>>>>>>>
>>>>>>> Removing _nomigrate() variances makes sense to me in general, it 
>>>>>>> means we
>>>>>>> want to by default suggest new devices only use RAM regions that is
>>>>>>> migratable, with proper owner device specified along with
>>>>>>> the ramblock name
>>>>>>> (as part of migration API).
>>>>>>>
>>>>>>> However, we have two sets of these _nomigrate APIs:
>>>>>>>
>>>>>>>    (1) memory_region_init_r[ao]m_nomigrate
>>>>>>>    (2) memory_region_init_r[ao]m_flags_nomigrate
>>>>>>>
>>>>>>> What I am still confused about is why this series used (2) to 
>>>>>>> replace (1)
>>>>>>> rather than removing both.  I don't understand how this helps if 
>>>>>>> we still
>>>>>>> have (2) around: it means new devices at least can still use
>>>>>>> (2) to bypass
>>>>>>> migration.
>>>>>>>
>>>>>>> There's actually one way to enforce migratable RAMs, taking
>>>>>>> ROM as example,
>>>>>>> it could be:
>>>>>>>
>>>>>>>    memory_region_init_rom_internal(..., global_vmstate=XXX)
>>>>>>>
>>>>>>> Then memory_region_init_rom() should use that, setting
>>>>>>> global_vmstate=off.
>>>>>>>
>>>>>>> Then we can unexport/remove 
>>>>>>> memory_region_init_rom_[flag_]nomigrate() but
>>>>>>> use that _internal() in relevant paths; we should also mark
>>>>>>> the _internal()
>>>>>>> functions to say "new code is suggested to use the normal
>>>>>>> version".  But I
>>>>>>> do not know if that is a slight overkill just for this..
>>>>>>>
>>>>>>> If the other series (to avoid introducing new APIs) is the
>>>>>>> only reason for
>>>>>>> this part, then IMHO this part of the series needs to be in the 
>>>>>>> other
>>>>>>> series, not this one.  The last cleanup patches look more self 
>>>>>>> contained
>>>>>>> OTOH to me, if the whole purpose of the latter half was code
>>>>>>> dedup, then it
>>>>>>> makes more sense at least to me.
>>>>>>
>>>>>> +1 for what Peter Xu suggested. Most part of this series looks
>>>>>> independently useful, but I don't think the removal of
>>>>>> memory_region_init_ram_nomigrate() is.
>>>>>
>>>>> But if there are no useful uses why keep it? This version shows that
>>>>> converting the Sun machines as Peter Maydell suggested only leaves
>>>>> very few uses that can be removed eventually too after some further
>>>>> clean up that I don't want to take up now. Do you have any usage in
>>>>> mind that needs these nomigrate variants?
>>>>
>>>> Well, my threshold for "useful" is > 1 uses, but maintainers may have
>>>> other preferences.
>>
>> Personally I share the same preference..
>>
>> When >1 it means we can dedup some code with a function and I normally
>> think it worthwhile.  That's also why I don't understand why we need to
>> open code _set_readonly() in some of this series.
> 
> Have you read the latest v5 at all? No open coding of set_readonly or 
> useful uses of memory_region_init_r[ao]m_nomigrate left if we accept 
> converting the Sun machines now to memory_region_init_r[ao]m which they 
> should really use as everything else does that and these are the last 
> remaining uses of these nomigrate variants apart from the few special 
> cases. It seems these Sun machines were left behind when everything else 
> converted away from global vmstate and use the normal 
> memory_region_init_r[ao]m where the _nomigrate were left for backward 
> compatibility during API conversion. So it's time to finish that 
> conversion at last.
> 
>> Even if for the sake of a new set of APIs, it doesn't need to provide 
>> every
>> single API that we have had in the old set if we don't need it, IMHO.
>>
>>>
>>> After this series when converting the Sun machines as in v5 the only
>>> nomigrate variant left is memory_region_init_ram_flags_nomigrate that is
>>> equivalent to memory_region_init_ram_nomigrate with flags=0 which 
>>> appears
>>> outside of memory.c only in hw/xtensa/xtfpga.c (that will be 
>>> converted in
>>> the next series to memory_region_new) and in hw/display/vga.c that 
>>> can be
>>> removed when the hw_compat_2_12 is removed. There are two more uses of
>>> memory_region_init_ram_flags_nomigrate in backends/hostmem-ram.c and
>>> hw/m68k/next-cube.c but those have non-0 flags parameter. Therefore I 
>>> think
>>> there's no need to keep other nomigrate variants than
>>> memory_region_init_ram_flags_nomigrate as the only two uses outside of
>>> memory.c that would need memory_region_init_ram_nomigrate are to be 
>>> removed
>>> soon and can use flags=0 until then.
> 
> I tried to explain here that the two uses left that could use 
> memory_region_init_ram_nomigrate will be gone shortly so IMO not worth 
> keeping this function around for that.

Whether it will be gone shortly or not requires reviewing additional 
change to remove the two use cases.

> 
>>> I don't know if the other two uses with non-0 flags can be replaced and
>>> memory_region_init_ram_flags_nomigrate made internal to memory.c but 
>>> that's
>>> beyond the scope of this series and could be considered separately. 
>>> Creating
>>> nomigrate memory region is not something that should be done or need 
>>> several
>>> functions and the very few cases where this might be needed can use
>>> memory_region_init_ram_flags_nomigrate.
>>
>> The hostmem-ram.c one is slightly special, when created as an object it
>> still doesn't know its parent device.
> 
> Yes so there might be some special cases but for those it's enough to 
> have a single nomigrate variant which this series proposes.
> 
>> I still think it might be helpful if you can split your "cleanup" patches
>> out of this series.  Note that softfreeze will be next week.
> 
> This series _is_ the clean up part split from the add memory_region_new 
> functions series so these are all clean ups and the rest is in the other 
> series. I don't theres much more to split. Maybe you missed some patch 
> emails. Here's the clean up series:
> 
> https://patchew.org/QEMU/cover.1772397447.git.balaton@eik.bme.hu/
> 
> and here's the rest of my original series based on these clean ups that 
> continue with adding and using the memory_region_new functions added in 
> that series:
> 
> https://patchew.org/QEMU/cover.1770753117.git.balaton@eik.bme.hu/
> 
> I'm not sure what do you want to split.

In that case, I suggest moving this particular patch into the 
memory_region_new() series (or whichever series reduces the use cases to 
one or zero). That way, each series remains a self-contained logical 
unit for review.

Regards,
Akihiko Odaki

