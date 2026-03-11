Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8008FD063C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 06:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0DRg-0001nC-RL; Wed, 11 Mar 2026 02:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w0DRY-0001lz-EO
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 02:53:21 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w0DRT-0007Ag-Rb
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 02:53:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id F3C508068E;
 Wed, 11 Mar 2026 09:53:08 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b78::1:28] (unknown
 [2a02:6bf:8080:b78::1:28])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 7r9pvc1AqqM0-Z33lFZkm; Wed, 11 Mar 2026 09:53:08 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773211988;
 bh=R9fg6ze1624pdkvVUPykpTsA1PENJHK1k97SNOPBtv0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=0VL6u3DoxHU0fc9gNEWNyqqsBP60vkJRZOE0+qQfD38dwA/bHu3uQ81v6wf4gSviR
 beJyC2FtQQ3j1pwUQl4C4mCfdHvBoWMpS35rens9SUZuC7/sBETLhyOoV0eiDTzgxH
 lMlspcJQvTzzf3aj9/AHU6KmtmgfhoM6NaikXgoc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f37dc7af-7ffd-4a7b-b4fa-552c2d2eb888@yandex-team.ru>
Date: Wed, 11 Mar 2026 09:53:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vmstate: fix subsection load name check
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>
References: <20260302070626.613396-1-dtalexundeer@yandex-team.ru>
 <87y0k5136i.fsf@suse.de>
 <714e4329-6001-4c77-b004-ed7beb11c154@yandex-team.ru>
 <e81360d5-cab4-47a4-840b-7d948b51a5c0@yandex-team.ru>
 <CAFEAcA-m+CZPUchGsh6QU4gm1dO-FP0m1w5gu6sn56wUXBbRAQ@mail.gmail.com>
 <abBcN2B4QNBT_Oh9@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <abBcN2B4QNBT_Oh9@x1.local>
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

On 10.03.26 21:00, Peter Xu wrote:
> On Tue, Mar 10, 2026 at 01:39:04PM +0000, Peter Maydell wrote:
>> On Tue, 10 Mar 2026 at 13:28, Alexandr Moshkov
>> <dtalexundeer@yandex-team.ru> wrote:
>>> Hi, this breaks migration for s390x and ppc64:
>>>
>>> qemu-system-s390x: Missing section footer for qemu-s390-flic
>>>
>>> Thanks for reply! It happens because "qemu-s390-flic" vmsd has "qemu-s390-flic-full" subsection. I'm not sure if we can change the names of the existing subsections. Peter, what do you think?
>>>
>>> It seems to be a bigger problem that the migration framework does not document the names for subsections in any way. At the same time, the code implies that at least the names should be a substring with its parent. There is even such a code comment `subsection name has to be "section_name/a"`, that seems to imply the presence of /.
>>>
>>> Also I tried to put together a list of devices whose separator in subsections is not /:
>>
>>> or-irq
>>
>> This one and probably some of the others are my mistake, I think.
>> I think this is because:
>>   * the migration code imposes a constraint on the subsection names
>>   * the migration documentation does not mention this constraint
>>   * the migration code does not effectively enforce this constraint
>>     (e.g. by asserting when the vmstate with a bad name is registered)
>>
>> My assumption when writing that code was very likely that the
>> name of the subsection didn't have to have any relation to
>> the name of its parent subsection (after all, the migration
>> code knows it is a subsection, so if it needed to have the
>> name on the wire be "parentname/subsectionname" it could construct
>> that itself), and since it all just worked I never noticed the
>> mistake...
> 
> Indeed, we can do better on the 2nd/3rd bullets.. so we should document it
> in struct VMStateDescription definition, and enforce it when registering
> new VMSDs.
> 
> One thing to double check with Alexandr on this one:
> 
>> They using `_`, `-` or `.` as separator
> 
> Does it mean we also can't simply whitelist all these characters (including
> "/"), because it won't always work?
> 
> For example in your case, it's "virtio-blk" being the parent VMSD, "virtio"
> being the child VMSD, followed with a subsection belongs to virtio-blk.
> We want to make that subsection be recognizable as virtio-blk's.
> 
> Then if we treat "-" also to be a separator, then "virtio" will still
> mis-recognize virtio-blk's as its own (because its name is "virtio-blk/..."
> hence it also satisfies the "virtio" check)?
> 

I have an idea. What if we simply change the order, instead of

1. check prefix (with '/' at the end). and stop the loop if it doesn't match
2. call vmstate_get_subsection(vmsd->subsections, idstr)

do

0. Document, and check, that starting from 11.0 any new subsections must follow <section name>/<subsection name> notation

in vmstate_subsection_load():

1. call vmstate_get_subsection, if it succeeded we are done
2. check prefix with '/' at the end. If match - it's a new subsection, added after 11.0 point, in correct notation. If does not match - it's subsection of another state, stop the loop.


Possible problems:

1. may be some subsections (with wrong notation), which were added before 11.0, but then removed (we break migration from old version to new).

This can be checked by git-grepping for subsections through qemu releases.

2. may be some downstream subsections (we may break migration from some downstream versions to upstream).

Should we care of it? Probably not.

-- 
Best regards,
Vladimir

