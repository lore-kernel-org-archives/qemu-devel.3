Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021CACCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 21:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8mr3-0001dr-9M; Tue, 14 Oct 2025 17:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8mqt-0001cu-Eb
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 17:46:39 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8mqp-0002Sa-MB
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 17:46:39 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 42508C02F4;
 Wed, 15 Oct 2025 00:46:29 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a8a::1:35] (unknown
 [2a02:6bf:8080:a8a::1:35])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id QkXv0w2FwqM0-jCxIqQ8s; Wed, 15 Oct 2025 00:46:27 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760478387;
 bh=RI8AZXAKZBawfHnvOQ56YmbOJvdf/k1bqik10VqJoLg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=JfgkE60ny62it6yiod0VFsPjnHX/aUhn3Zzfes3p+Oyt+xpEGwBhCuqEDabVRKfS9
 47oIyQ7ZHa8lRfvTP2pW9/YhXaPzHdmtj5opDzSIAxSL26eIOJA8cgceCA8NFAhYpH
 OLJ2HJP6aT46LV+8taPqMLA/USC5Xl6JR9RmSZeg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9a9ced95-583e-4c1e-84f0-af12a5800193@yandex-team.ru>
Date: Wed, 15 Oct 2025 00:46:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/19] qapi: add interface for backend-transfer
 virtio-net/tap migration
To: Peter Xu <peterx@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, farosas@suse.de, sw@weilnetz.de,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com, philmd@linaro.org,
 berrange@redhat.com, qemu-devel@nongnu.org, michael.roth@amd.com,
 steven.sistare@oracle.com, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, raphael.s.norwitz@gmail.com
References: <20251010173957.166759-1-vsementsov@yandex-team.ru>
 <20251010173957.166759-17-vsementsov@yandex-team.ru>
 <aO57SKp86zX2R8mV@x1.local>
 <6da192b9-7609-4cc8-82a9-1a445ecb10c9@yandex-team.ru>
 <aO6xqt5_1PDBwOwu@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aO6xqt5_1PDBwOwu@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 14.10.25 23:25, Peter Xu wrote:
> On Tue, Oct 14, 2025 at 10:31:30PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 14.10.25 19:33, Peter Xu wrote:
>>> On Fri, Oct 10, 2025 at 08:39:54PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> To migrate virtio-net TAP device backend (including open fds) locally,
>>>> user should simply set migration parameter
>>>>
>>>>      backend-transfer = ["virtio-net-tap"]
>>>>
>>>> Why not simple boolean? To simplify migration to further versions,
>>>> when more devices will support backend-transfer migration.
>>>>
>>>> Alternatively, we may add per-device option to disable backend-transfer
>>>> migration, but still:
>>>>
>>>> 1. It's more comfortable to set same capabilities/parameters on both
>>>> source and target QEMU, than care about each device.
>>>
>>> But it loses per-device control, right?  Say, we can have two devices, and
>>> the admin can decide if only one of the devices will enable this feature.
>>>
>>
>> Right. But, in short:
>>
>> 1. I'm not sure, that such granularity is necessary.
>>
>> 2. It may implemented later, on top of the feature.
> 
> I confess that's not a good example, but my point was that it was
> straightforward idea to have two layers of settings, meanwhile it provides
> full flexiblity.
> 
>>
>>>>
>>>> 2. To not break the design, that machine-type + device options +
>>>> migration capabilities and parameters are fully define the resulting
>>>> migration stream. We'll break this if add in future more
>>>> backend-transfer support in devices under same backend-transfer=true
>>>> parameter.
>>>
>>> Could you elaborate?
>>>
>>> I thought last time we discussed, we planned to have both the global knob
>>> and a per-device flag, then the feature is enabled only if both flags are
>>> set.
>>
>> Right, here in v3: https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg01644.html
>>
>> Still at this point, I also needed local-incoming=true target option, so I
>> considered all the parameters like "I can't make feature without extra
>> per-device options, so here they are".
>>
>> A day later, after motivating comment from Markus (accidentally in v2),
>> I found and suggested the way:
>>
>> https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg01960.html
>>
>> And further versions v4-v7 were the realization of the idea. Still, main
>> benefit is possibility to get rid of per-device local-incoming=true
>> options for target, not about a kind of per-device "capability" flag we
>> discuss now.
>>
>> A, and here I said [1]:
>>
>>> 1. global fds-passing migration capability, to enable/disable the whole feature
>>>
>>> 2. per-device fds-passing option, on by default for all supporting
>>> devices, to be
>>> able to disable backing migration for some devices. (we discussed it
>>> here: https://lore.kernel.org/all/aL8kuXQ2JF1TV3M7@x1.local/ ).
>>> Still, normally these options are always on by default.
>>> And more over, I can postpone their implementation to separate series,
>>> to reduce discussion field, and to check that everything may work
>>> without additional user input.
>>
>> And then, went this way, postponing realization of per-device options..
> 
> Postponing the per-device flag might still break different backends if you
> specify the list with virtio-net-pci.
> 
> But only until now, I noticed you were using "virtio-net-tap" instead of
> "virtio-net-pci".
> 
> Ouch.. I think that's even more complicated. :(
> 
> Here I think the problem is, introducing some arbitrary strings into
> migration QAPI to represent some combinations of "virtio frontend F1" and
> "virtio backend B1" doesn't sound the right thing to do.  Migration ideally
> should have zero knowledge of the device topology, types of devices,
> frontends or backends.  "virtio-*" as a string should not appear in
> migration/ or qapi/migration.json at all..
> 
>>
>> And then, developing similar migration for vhost-user-blk, found
>> that I can't use on boolean capability for such features, the reason
>> in commit message, which we discuss now.
> 
> Why a bool isn't enough?  Could you share a link to that discussion?
> 
>>
>> Than, current design came in v5 (v4 was skipped).. And I even got an
>> approval from Fabiano :)
>>
>> https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg03999.html
>>
>>>
>>> If these parameters are all set the same on src/dst, would it also not
>>> break the design when new devices start to support it (and the new device
>>> will need to introduce its own per-device flags)?
>>
>> Yes, right.
>>
>> I missed, that, "postponing (probably forever)" per-device options
>> realization, I started to implement another way to solve the same
>> problem (switching from one boolean capability to a backend-transfer
>> list).
>>
>> In other words, if at some point implement per-device options, that will
>> partly intersect by functionality with current complex migration
>> parameter..
>>
>> -
>>
>> But still, I think, that parameter backend-transfer = [list of targets]
>> is better than per-device option. With per-device options we'll have to
>> care about them forever. I can't imagine a way to make them TRUE by
>> default.
>>
>> Using machine type, to set option to TRUE by default in new MT, and to
>> false in all previous ones doesn't make real sense: we never migrate on
>> another MT, but we do can migrate from QEMU without support for
>> virtio-net backend transfer to the QEMU with such support. And on target
>> QEMU we'll want to enable virtio-net backend-transfer for further
>> migrations..
> 
> So this is likely why you changed your mind.  I think machine properties
> definitely make sense.
> 
> We set it OFF on old machines because when on old machines the src QEMU
> _may_ not support this feature.  We set it ON on new machines because when
> the QEMU has the new machine declared anyway, it is guaranteed to support
> the feature.
> 
> We can still manually set the per-device properties iff the admin is sure
> that both sides of "old" QEMUs support this feature.  However machine
> properties worked like that for many years and I believe that's how it
> works, by being always on the safe side.
> 
>>
>> So, I think, modifying machine types is wrong idea here. So, we have to
>> keep new options FALSE by default, and management tool have to care to
>> set them appropriately.
>>
>> -
>>
>> Let's look from the POV of management tool.
>>
>> With complex parameter (list of backend-transfer targets, suggested with
>> this series), what should we do?
>>
>> 1. With introspection, get backend-transfer targets supported by source
>>     and target QEMUs
>> 2. Get and intersection, assume X
>> 3. Set same backend-transfer=X on source and target
>> 4. Start a migration
>>
>> But with per-device parameters it becomes a lot more complicated and
>> error prone
>>
>> 1. Somehow understand (how?), which devices support backend-transfer on
>>     source and target
>> 2. Get an intersection
>> 3. Set all the backend-transfer options on both vms correspondingly,
>>     doing personal qom-set for each device
>> 4. Start a migration
>>
>> -
>>
>> In short:
>>
>> 1. per device - is too high granularity, making management more complex
> 
> If we follow the machine property way of doing this (which I believe we
> used for years), then mgmt doesn't need any change except properly enable
> fd-passing in migration cap/params when it's a local migration.  That's
> all.  It doesn't need to know anything about "which device(s) supports
> fd-passing", because they'll all be auto-set by the machine types.
> 
>>
>> 2. per feature - is what we need. And it's a normal use for migration
>> capabilities: we implement a new migration feature, and add new
>> capability. The only new bit with this series is that "we are going to"
>> implement similar capabilities later, and seems good to organize them
>> all into a list, rather than make separate booleans.
>>
>>
>>>
>>>>
>>>> The commit only brings the interface, the realization will come in later
>>>> commit. That's why we add a temporary not-implemented error in
>>>> migrate_params_check().
>>>>
>>
>> [..]
>>
>>>> +bool migrate_virtio_net_tap(void)
>>>> +{
>>>> +    MigrationState *s = migrate_get_current();
>>>> +    BackendTransferList *el = s->parameters.backend_transfer;
>>>> +
>>>> +    for ( ; el; el = el->next) {
>>>> +        if (el->value == BACKEND_TRANSFER_VIRTIO_NET_TAP) {
>>>
>>> So this is also something I want to avoid.  The hope is we don't
>>> necessarily need to invent new device names into qapi/migration.json.
>>> OTOH, we can export a helper in migration/misc.h so that devices can query
>>> wehther the global feature is enabled or not, using that to AND the
>>> per-device flag.
>>>
>>
>> Understand. But I can't imagine how to keep management simple with per-device
>> options..
>>
>> -
>>
>> What do you think?
> 
> I feel like you wanted to enable this feature _while_ using an old machine
> type.

Exactly

> Is that what you're looking for?  Can you simply urge the users to
> move to new machine types when looking for new features?  I believe that's
> what we do..
> 
> MT properties were working like that for a long time.  What you were asking
> is fair, but if so I'd still like to double check with you on that's your
> real purpose (enabling this feature on NEW qemus but OLD machine types, all
> automatically).
> 

You made me think.

On the one hand, you are right, I agree with all arguments about migration
being separate from virtio device types, their backends and frontends.

And yes, if refuse the idea of enabling the feature in old machine types
automatically, everything fits into existing paradigm.

On the other hand is our downstream practice in the cloud. We introduce
new machine types _very_ seldom. Almost always, new features developed
or backported to our downstream doesn't require new machine type. In such
situation, creating feature, which theoretically (and more simple in API!)
may be done without introducing new MT, but creating it by introducing new
MT, postponing the moment when we start to widely use it up to the moment when
most of existing vms will die or restart naturally (as for sure, we'll not
ask users to restart them, it would be too expensive (not saying about,
is restart a safe way to change MT, or we'd better recreate a vm), seems
very strange for me. (too long sentence detector blinking).

So, finally, it's OK for me to switch to per-device properties. Then, in
downstream I may implement corresponding capabilities to simplify management.
That's rather simple.

-

Interesting, could migration "return path" be somehow used to get information
from target, does it support backend transfer for concrete device?

So that, we simply enable backend-transfer=true parameter both on
source and target. Than, source somehow find out through return path,
for the device, does target support backend-transfer for it, and decide,
what to do? Or that's too complicated?

-- 
Best regards,
Vladimir

