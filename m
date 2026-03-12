Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3D3FED2D1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 06:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0ZZH-00028E-Mu; Thu, 12 Mar 2026 02:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w0ZZF-00027o-Q4
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 02:30:46 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w0ZZC-0002N3-Rs
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 02:30:45 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 41FC28075F;
 Thu, 12 Mar 2026 09:30:37 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b78::1:28] (unknown
 [2a02:6bf:8080:b78::1:28])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id aUALxE0AWCg0-1NqT74w0; Thu, 12 Mar 2026 09:30:36 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773297036;
 bh=IUtec4PVFoGgcpt+zAdrTEvzd+6d4J2X90EMo7y26Gk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=x8oLw3YUmOzGKvkizoizDNh4JlHHQPkSvY30LQfYRb8N7URrHGOkuguCc5eB2OU5I
 r3w/lm2aEVxcZbsbo0RiAexEUi+hNJFuTUJlRTxSt1GwIKcBtveYGXmFLVpDvvM392
 EyPdbAZyn0hrvr/XTMkjZP1ePCPgvcS3Pg/s1T5Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a6dafc1e-79d1-4380-a4da-7cbc4ff77ae4@yandex-team.ru>
Date: Thu, 12 Mar 2026 09:30:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vmstate: fix subsection load name check
To: Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>
References: <20260302070626.613396-1-dtalexundeer@yandex-team.ru>
 <87y0k5136i.fsf@suse.de>
 <714e4329-6001-4c77-b004-ed7beb11c154@yandex-team.ru>
 <e81360d5-cab4-47a4-840b-7d948b51a5c0@yandex-team.ru>
 <CAFEAcA-m+CZPUchGsh6QU4gm1dO-FP0m1w5gu6sn56wUXBbRAQ@mail.gmail.com>
 <abBcN2B4QNBT_Oh9@x1.local>
 <f37dc7af-7ffd-4a7b-b4fa-552c2d2eb888@yandex-team.ru>
 <abGEwf-AG1rZ3kam@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <abGEwf-AG1rZ3kam@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 11.03.26 18:05, Peter Xu wrote:
> On Wed, Mar 11, 2026 at 09:53:07AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 10.03.26 21:00, Peter Xu wrote:
>>> On Tue, Mar 10, 2026 at 01:39:04PM +0000, Peter Maydell wrote:
>>>> On Tue, 10 Mar 2026 at 13:28, Alexandr Moshkov
>>>> <dtalexundeer@yandex-team.ru> wrote:
>>>>> Hi, this breaks migration for s390x and ppc64:
>>>>>
>>>>> qemu-system-s390x: Missing section footer for qemu-s390-flic
>>>>>
>>>>> Thanks for reply! It happens because "qemu-s390-flic" vmsd has "qemu-s390-flic-full" subsection. I'm not sure if we can change the names of the existing subsections. Peter, what do you think?
>>>>>
>>>>> It seems to be a bigger problem that the migration framework does not document the names for subsections in any way. At the same time, the code implies that at least the names should be a substring with its parent. There is even such a code comment `subsection name has to be "section_name/a"`, that seems to imply the presence of /.
>>>>>
>>>>> Also I tried to put together a list of devices whose separator in subsections is not /:
>>>>
>>>>> or-irq
>>>>
>>>> This one and probably some of the others are my mistake, I think.
>>>> I think this is because:
>>>>    * the migration code imposes a constraint on the subsection names
>>>>    * the migration documentation does not mention this constraint
>>>>    * the migration code does not effectively enforce this constraint
>>>>      (e.g. by asserting when the vmstate with a bad name is registered)
>>>>
>>>> My assumption when writing that code was very likely that the
>>>> name of the subsection didn't have to have any relation to
>>>> the name of its parent subsection (after all, the migration
>>>> code knows it is a subsection, so if it needed to have the
>>>> name on the wire be "parentname/subsectionname" it could construct
>>>> that itself), and since it all just worked I never noticed the
>>>> mistake...
>>>
>>> Indeed, we can do better on the 2nd/3rd bullets.. so we should document it
>>> in struct VMStateDescription definition, and enforce it when registering
>>> new VMSDs.
>>>
>>> One thing to double check with Alexandr on this one:
>>>
>>>> They using `_`, `-` or `.` as separator
>>>
>>> Does it mean we also can't simply whitelist all these characters (including
>>> "/"), because it won't always work?
>>>
>>> For example in your case, it's "virtio-blk" being the parent VMSD, "virtio"
>>> being the child VMSD, followed with a subsection belongs to virtio-blk.
>>> We want to make that subsection be recognizable as virtio-blk's.
>>>
>>> Then if we treat "-" also to be a separator, then "virtio" will still
>>> mis-recognize virtio-blk's as its own (because its name is "virtio-blk/..."
>>> hence it also satisfies the "virtio" check)?
>>>
>>
>> I have an idea. What if we simply change the order, instead of
>>
>> 1. check prefix (with '/' at the end). and stop the loop if it doesn't match
>> 2. call vmstate_get_subsection(vmsd->subsections, idstr)
>>
>> do
>>
>> 0. Document, and check, that starting from 11.0 any new subsections must follow <section name>/<subsection name> notation
>>
>> in vmstate_subsection_load():
>>
>> 1. call vmstate_get_subsection, if it succeeded we are done
>> 2. check prefix with '/' at the end. If match - it's a new subsection, added after 11.0 point, in correct notation. If does not match - it's subsection of another state, stop the loop.
> 
> Yep, this sounds working.
> 
> But I wonder do we need (2) at all?  Say, can we sololy rely on
> vmstate_get_subsection() to identify if we should take it or just leave it
> for upper layers?  So we will never fail a subsection lookup, only either
> (1) load it if owned, or (2) ignore it and pop the VMSD stack.
> 
> It means in code we don't restrict subsection name to be "$PARENT_NAME/*".
> 
> However we should likely still suggest that in doc of subsections, so we at
> least avoid one parent VMSD having subsection S1, then its field having
> subsection S2, and by accident S1 and S2 has the same name..
> 
>>
>>
>> Possible problems:
>>
>> 1. may be some subsections (with wrong notation), which were added before 11.0, but then removed (we break migration from old version to new).
> 
> If a subsection with wrong notation got removed, then it should require a
> machine compat property otherwise migration should be broken anyway?
> 
>>
>> This can be checked by git-grepping for subsections through qemu releases.
>>
>> 2. may be some downstream subsections (we may break migration from some downstream versions to upstream).
>>
>> Should we care of it? Probably not.
> 
> Not sure if this is an issue if we drop (2) directly above.
> 
> There seems to have a 3rd possible "issue": the failure will be more
> obscure on a subsection that nobody recognizes; we used to try our best say
> "VM subsection '...' in '...' does not exist", but then it'll always pop
> the VMSD stack then the upper layer may read the SUBSECTION byte anywhere.
> So debugging a stream with an extra subsection can be slightly more
> awkward, but I'm not sure how much.  Meanwhile for a compatible / normal
> migration it'll be all fine.  It just means when seeing a subsection will
> try to pick it up from the inner VMSD and fallback to outter VMSD every
> time.
> 

Understand now. All this time I somehow thought, that we check this prefix to
be able to skip the subsection, if we are sure that it belong to current section
but we don't support it. But that's obviously nonsense, we can't skip, and
the code just return an error if vmstate_get_subsection() fails.

Now I see that prefix check is only to generate more accurate error message.

Yes, I agree that more correct is to drop [2] at all and simply return 0
if vmstate_get_subsection() fails, that will work for any correct migration.

---

You say

> .. always pop the VMSD stack then the upper layer may read the SUBSECTION byte anywhere.

But it actually can be anything. Of course probability is small that some another state
looks like QEMU_VM_SUBSECTION + <existing subsection name>, but we don't have actual
guarantee for it in the protocol.

Probably, we may also add a protocol change (with some global state property,
set to true in new MT) to add a number of subsections into section state, to be
sure how many of them we have in the stream.



-- 
Best regards,
Vladimir

