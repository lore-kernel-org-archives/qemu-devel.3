Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF2CE68171
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 13:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsKqK-0005Ym-K9; Tue, 17 Feb 2026 08:10:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsKqI-0005YC-FO
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 08:10:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsKqF-0003pK-NJ
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 08:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771333814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l2EpLW/ilo7vhlBI4JW6oCCdvpOjeoHz83wOHHU0ufI=;
 b=Eu8HNoC4MQaN0CJT0UyP1B6SNt44E+wcKyKLSaJMB6J9NejPpOOdri+jmJOhhI4095ysJL
 AH4oLe2qU/vAXiIqmLVpp67YR3D7sQu/8/bEiwaPo0ofc5C1Tr3vLYkYx00x/F41AJoxUa
 FNW/QNT1/zWiD4g1iffEht5rVZ4XXy0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-amuiGJbSNcCbQ7SXfFS7EQ-1; Tue,
 17 Feb 2026 08:10:11 -0500
X-MC-Unique: amuiGJbSNcCbQ7SXfFS7EQ-1
X-Mimecast-MFC-AGG-ID: amuiGJbSNcCbQ7SXfFS7EQ_1771333810
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AF5E180025E; Tue, 17 Feb 2026 13:10:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48E521955F43; Tue, 17 Feb 2026 13:10:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C5B5121E692D; Tue, 17 Feb 2026 14:10:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  eduardo@habkost.net,
 berrange@redhat.com,  pbonzini@redhat.com,  eblake@redhat.com,
 devel@lists.libvirt.org,  hreitz@redhat.com,  kwolf@redhat.com
Subject: Re: [PATCH v10 4/8] qapi: add blockdev-replace command
In-Reply-To: <f9aed7fd-2f56-4b54-bf4f-693e0c10fb38@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Mon, 16 Feb 2026 08:48:06 +0300")
References: <20260119144941.87936-1-vsementsov@yandex-team.ru>
 <20260119144941.87936-5-vsementsov@yandex-team.ru>
 <87wm0sy9s4.fsf@pond.sub.org>
 <739edd0f-8342-418e-96bb-01bc9bd3349e@yandex-team.ru>
 <87seb3zr7j.fsf@pond.sub.org>
 <f9aed7fd-2f56-4b54-bf4f-693e0c10fb38@yandex-team.ru>
Date: Tue, 17 Feb 2026 14:10:05 +0100
Message-ID: <87seazjz2q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.754, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 14.02.26 11:04, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> On 04.02.26 15:26, Markus Armbruster wrote:
>>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>>
>>>>> Add a command that can replace bs in following BdrvChild structures:
>>>>>
>>>>>    - qdev blk root child
>>>>>    - block-export blk root child
>>>>>    - any child of BlockDriverState selected by child-name
>>>>>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[...]

>>>> Let's see whether I understand...
>>>>
>>>> @parent determines which of the three cases mentioned in the commit
>>>> message it ids:
>>>>
>>>> * If @parent is a QOM path, case 1.
>>>>
>>>> * If @parent is a block export name (@id in BlockExportOptions and
>>>>    BlockExportInfo), case 2.
>>>>
>>>> * If @parent is a block node name (@node-name in BlockdevOptions and
>>>>    BlockDeviceInfo), case 3.
>>>>
>>>> Correct?
>>>>
>>>> Problem: this is ambiguous.  A @parent "foo" could in fact be any of the
>>>> three cases.
>>>
>>> Yes. And we return an error in case of any ambiguity.
>> 
>> So, in case of ambiguity, the command does not work.
>> 
>> On the one hand, this is the user's doing: reusing the same ID for
>> multiple things has always been a bad idea.
>> 
>> On the other hand, we're now turning a bad idea that may cause confusion
>> into an bad idea that may break things.  Feels iffy.
>> 
>> For QOM paths, we have a workaround: avoid partial QOM paths.  Feels
>> okay.  Partial QOM paths are rather obscure, and best avoided entirely.
>> 
>> The only workaround for block export vs. block node ambiguity is to
>> avoid ID reuse.  By the time a user sees the command fail, the IDs are
>> what they are, and there's is no workaround.
>> 
>> Do you need blockdev-replace to work for both *now*?
>> 
>> At the very least, we need to document the trap and point to the
>> workaround.
>> 
>> Alternatively, come up with an interface that avoids the issue.  See
>> below.
>> 
>>>> 3. If a block node named "foo" exists, it's case 3.
>>>>
>>>> 2. If a block export named "foo" exists, it's also case 2.
>>>>
>>>> 1. If exactly one QOM object named "foo" exists, it's also case 1.  Why?
>>>>      "foo" is a syntactically valid partial QOM path.  Partial QOM paths
>>>>      are a convenience feature that is virtually unknown (and possibly
>>>>      ill-advised): you can omit leading path components as long as there's
>>>>      no ambiguity.
>>>>
>>>> Peeking ahead in the series...  PATCH 8 appears to deprecate the
>>>> ambiguity between case 2. and 3.
>>>>
>>>> I think we need to do better.
>> 
>> See review of PATCH 8 for doing better on deprecation.
>> 
>>>> More questions...
>>>>
>>>> In case 1 and 2, @child "should be root".  What happens when it's
>>>> something else?
>>>
>>> Error returned. s/should/must/ ?
>> 
>> Yes, please.
>> 
>>>> In case 3, @child "should be any if its children names".  I figure the
>>>> command fails when it isn't.
>>>
>>> And here.
>> 
>> Likewise.
>> 
>>>>> +{ 'command': 'blockdev-replace',
>>>>> +  'data': { 'parent': 'str', 'child': 'str', 'new-child': 'str' } }
>>>>
>>>> [...]
>> 
>> This interface sort of overloads @parent and @child, and overloading the
>> former creates ambiguity that can make the command unusable.
>
> Is it a real problem if we do deprecate the thing, that leads to this
> ambiguity?
>
> If it is, we may mark the command "unstable" during the deprecation period.

By itself, the proposed command is a trap for the unwary.

Deprecating the usage that enables the trap makes the trap temporary.

Warning on (deprecated) usage that enables the trap helps users avoid
it.  Human users, mostly.

Marking the command "unstable" should ensure management application
avoid the command, and thus the trap.

All of the above together feels acceptable to me.  Can we do better?
Maybe, and that's discussed below.

> Or even postpone its addition up to the end of this period.

No trap, no problem :)

>> @parent's set of valid values is the union of QOM path, block node name,
>> block export ID with values occuring in more than one of them dropped.
>> 
>> @child's set of valid values depends on @parent: child name when it's a
>> QOM path, else "root".
>> 
>> The obvious non-overloaded interface is a union of three branches: QOM,
>> block node, block export.  The QOM branch has variant members @qom-path
>> and @child.  The block node branch has variant member @node-name.  The
>> block export branch has variant member @id.
>> 
>> This is a bit more verbose: you have to specify the union tag[*].
>> 
>> If we ever need to replace block nodes associated with additional
>> things, we simply more branches.  These branches can have arbitrary
>> members.  In your interface, we'd have to make do with @child, or maybe
>> add optional arguments.
>> 
>> Thoughts?  Mind, this isn't a demand!  I'm exploring the design space.
>
> Union-based solution was v9: https://lore.kernel.org/qemu-devel/20240626115350.405778-5-vsementsov@yandex-team.ru/
>
> And there was a discussion, that we may try a way without a union. And that's
> this v10.

I see Kevin suggested to explore this approach.  I certainly respect his
judgement.

> Hmm, but that had different field names for parents: qdev-id, export-id and node-name.
>
> What you suggest is to keep one filed for parent - "parent", but also add a "parent-type"
> field. This way, we may deprecate and remove "parent-type" in future. Or, we may
> add it as deprecated now (together with deprecating non-unique IDs)

We can't deprecate the union tag right away: it is *required*.

>> [*] We could add a "may omit union tag when the tag value can be derived
>> from present variant members" convenience feature to QAPI, but I'm not
>> sure it's worth the complexity.
>> 
>
> It also may be not a union, but a simple structure with optional fields:
>
> {
>     parent: str, required, qom-path, or node-name, or export name
>     child: str, optional, but required when parent is node-name, and must be 'root'
>            if present for other parent types
>     parent-type: str, optional, "qom-path" | "block-node" | "block-export", helps to
>            overcome parent ambiguity, deprecated
>     new-child: str, required node-name
> }

PRO union: which members are valid together is syntactically obvious.
With a bunch of optional members, that information is in the member
descriptions.

CON union: need to specify the union tag.  The verbosity is a non-issue
for management applications, and mildly bothersome for humans.

How important is keeping things terse for humans here?


