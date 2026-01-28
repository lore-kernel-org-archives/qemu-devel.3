Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA23D3569B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 10:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl2RT-0008IY-4w; Wed, 28 Jan 2026 05:06:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vl2RP-0008HD-Uo
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 05:06:28 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vl2RM-0008FX-Tx
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 05:06:27 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60SA5tQU017800
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 28 Jan 2026 19:06:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=MVeT2xIcyKvvgeNIc6OxzzTkqsODJl8q+V1kkxA3KPY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1769594777; v=1;
 b=bltkmtCpAmMq5hot/O5UbLVKdUzn+PWB+ig8Byg2I1AaTiWfYh1/5zIK38YobrtS
 u4ENhnRyzsqWW+mW4i+7NascKb8rvnL7kFeoj86VpYKUjvXCyPe4XM0aPhpuasE2
 WGZzoGvz6Zv/+roTCQzTPRYe/FyP95yFwyTNQACgBs5Zb3iQAtDrceas6EdKyiJV
 gpLbdZP3Q5n/PqhzW6DmnwmQ0PlDJA1sEo/8Bj4OHJh7v/d0hKg1LCQ82tbIvPY6
 m2W3iBuwk+x84nZJjfzpU6/m2Jsj8BIol9jrn2VOBs6aAPUivu1jCsaUoJirgtho
 2tbYDM+5L6RPifjFmh4NJQ==
Message-ID: <562f0e5c-7ae8-4d95-9dd4-674447362ef7@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 28 Jan 2026 19:05:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] Implement memory_region_new_* functions
To: BALATON Zoltan <balaton@eik.bme.hu>, Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <cover.1769362313.git.balaton@eik.bme.hu>
 <CAFEAcA_jS3hef=dhxZ5s7MReSW4ir+jMUGwu+RjD_JP7ZRrRXQ@mail.gmail.com>
 <0118dc9b-d467-7f6b-92a8-4f42760ecb6c@eik.bme.hu> <aXkXWGho7lnJ-gwX@x1.local>
 <2fa59d39-5634-0b8c-27ee-9e9548a7f92a@eik.bme.hu>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <2fa59d39-5634-0b8c-27ee-9e9548a7f92a@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 2026/01/28 5:22, BALATON Zoltan wrote:
> On Tue, 27 Jan 2026, Peter Xu wrote:
>> On Tue, Jan 27, 2026 at 03:10:28PM +0100, BALATON Zoltan wrote:
>>> This series does not convert everything but opens the way to do that and
>>> simplify objects by only storing things in the state that are really 
>>> needed
>>> by the object and let QOM manage what it can. I'd really like to avoid
>>> having a list of unused stuff in the state struct just because I 
>>> can't use
>>> something that works and documented just no API to actually use it. Cf.
>>> sii3112 state after this series:
>>>
>>> struct SiI3112PCIState {
>>>     PCIIDEState i;
>>>
>>>     SiI3112Regs regs[2];
>>> };
>>>
>>> vs. your standard:
>>>
>>> struct SiI3112PCIState {
>>>     PCIIDEState i;
>>>
>>>     MemoryRegion mmio;
>>>     MemoryRegion bar0;
>>>     MemoryRegion bar1;
>>>     MemoryRegion bar2;
>>>     MemoryRegion bar3;
>>>     MemoryRegion bar4;
>>>     SiI3112Regs regs[2];
>>> };
>>
>> The latter solution is fine at least to me.
>>
>> I respect your preference on how it can be done, but IMHO it is 
>> subjective,
>> and I tend to agree with Peter that we should try to stick with one 
>> way of
>> solving problems, unless very necessary.
>>
>> In the last three patches the MRs do not look need dynamic 
>> deallocation to
>> me at all..  Introducing fully dynamic MR allocations only for those 
>> is an
>> overkill to me.  I'm not fully convinced we need to merge 600+ new 
>> LOCs for
>> new APIs just for them.
> 
> It's not a new API in the sense that it's the same as existing 
> memory_region_init functions just a variant of it to allow using QOM to 
> manage the lifetime of the memory region which the current API does not 
> allow. Also this series does not introduce this dynamic lifetime 
> management, it's already implemented and documented just there's 
> currently no way to use it. The actual change is much less, most of the 
> lines are just the documentation comments. If it's a problem to increase 
> documentation size I could make it much shorter not duplicating a 
> separate doc comment for these just mention in the corresponding 
> memory_region_init doc comment that there's also an analogous 
> memory_region_new variant of it. That also shows there's no new API just 
> two ways of using the same API.
> 
>> We have real but rare users of dynamically allocated MRs, currently AFAIU
> 
> Since it's already implemented why not use it if it makes the object 
> state simpler? Adding additional fields that would already be managed by 
> QOM seems to be unnecessary duplication and complication to me so I'd 
> like to avoid that and keep the subclass simple.

I feel the discussion is going a wrong direction. This thread and the 
cover letter talks different things as the motivation of this series; 
The cover letter says the documentation mismatches with the 
implementation and that is the motivation for this series. This thread 
talks about duplicate memory management and extra fields, which is not 
mentioned in the cover letter.

Besides, the "extra fields" problem should have been already discussed 
in [1] and I don't see a new argument here. So, in summary, for a 
constructive discussion I think:
- There should be a consistent goal of discussion or patch series
   (documentation mismatch or extra fields) and
- A new point needs to be made; reminding the points of past discussion
   may be worthwhile but is insufficient.

[1] 
https://lore.kernel.org/qemu-devel/ceda4c28887c40e1c8eae3f561ee381ca98b0484.1761346145.git.balaton@eik.bme.hu/

Regards,
Akihiko Odaki

