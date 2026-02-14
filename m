Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A90EF99FF
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 08:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrAdi-00027f-IP; Sat, 14 Feb 2026 03:04:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vrAdf-00027M-7a
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 03:04:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vrAdc-0001u0-T9
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 03:04:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771056263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q0kj/z9fIjUYCUAPcJVARMjmaYFuiBNz6JXXGGgm/O4=;
 b=YEFkfMj9zhnsFqCmkpX4E6izgkjmtc6k6X0Z9Ak8KlKapjU4ldDdB2WpLAJpVjwuzL4fjY
 /J9J8VuM2g6HeU1eExhS6IDhk1EM6CH+vwKx0JG5nnTpFz2aa7M8qomZV7Po7M6iH05TMx
 9VJz4rX5e78jWajBhgYZZ0tPo6ZejdA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-EZG59wAyPdWu6daT8jn40A-1; Sat,
 14 Feb 2026 03:04:22 -0500
X-MC-Unique: EZG59wAyPdWu6daT8jn40A-1
X-Mimecast-MFC-AGG-ID: EZG59wAyPdWu6daT8jn40A_1771056261
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 204781955D76; Sat, 14 Feb 2026 08:04:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E0DA1800464; Sat, 14 Feb 2026 08:04:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 999BA21E692D; Sat, 14 Feb 2026 09:04:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  eduardo@habkost.net,
 berrange@redhat.com,  pbonzini@redhat.com,  eblake@redhat.com,
 devel@lists.libvirt.org,  hreitz@redhat.com,  kwolf@redhat.com
Subject: Re: [PATCH v10 4/8] qapi: add blockdev-replace command
In-Reply-To: <739edd0f-8342-418e-96bb-01bc9bd3349e@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 5 Feb 2026 10:30:31 +0300")
References: <20260119144941.87936-1-vsementsov@yandex-team.ru>
 <20260119144941.87936-5-vsementsov@yandex-team.ru>
 <87wm0sy9s4.fsf@pond.sub.org>
 <739edd0f-8342-418e-96bb-01bc9bd3349e@yandex-team.ru>
Date: Sat, 14 Feb 2026 09:04:16 +0100
Message-ID: <87seb3zr7j.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On 04.02.26 15:26, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> Add a command that can replace bs in following BdrvChild structures:
>>>
>>>   - qdev blk root child
>>>   - block-export blk root child
>>>   - any child of BlockDriverState selected by child-name
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> 
>> [...]
>> 
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index b82af74256..9cc7c3d140 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -6334,3 +6334,27 @@
>>>  ##
>>>  { 'struct': 'DummyBlockCoreForceArrays',
>>>    'data': { 'unused-block-graph-info': ['BlockGraphInfo'] } }
>>> +
>>> +##
>>> +# @blockdev-replace:
>>> +#
>>> +# Replace a block-node associated with device (@parent should be
>>> +# QOM path, and @child should be "root") or with block-export (@parent
>>> +# should be export name, and @child should be "root") or any child
>>> +# of block-node (@parent should be node-name, and @child should be any
>>> +# if its children names) with @new-child block-node.
>> 
>> of its
>> 
>>> +#
>>> +# @parent: QOM path or block-export or node-name, which @child should
>>> +#     be repalced.  If several matching parents exist, the command
>> 
>> replaced
>> 
>>> +#     will fail
>> 
>> End the sentence with a period, please.
>> 
>>> +#
>>> +# @child: child to replace.  Must be "root" when parent is QOM path or
>>> +#     block-export
>> 
>> Likewise.
>> 
>>> +#
>>> +# @new-child: node-name of the block-node, which should become a
>>> +#    replacement for @child's current block-node
>> 
>> Likewise.
>> 
>> Indent one more, please.
>> 
>>> +#
>>> +# Since 11.0
>>> +##
>> 
>> Let's see whether I understand...
>> 
>> @parent determines which of the three cases mentioned in the commit
>> message it ids:
>> 
>> * If @parent is a QOM path, case 1.
>> 
>> * If @parent is a block export name (@id in BlockExportOptions and
>>   BlockExportInfo), case 2.
>> 
>> * If @parent is a block node name (@node-name in BlockdevOptions and
>>   BlockDeviceInfo), case 3.
>> 
>> Correct?
>> 
>> Problem: this is ambiguous.  A @parent "foo" could in fact be any of the
>> three cases.
>
> Yes. And we return an error in case of any ambiguity.

So, in case of ambiguity, the command does not work.

On the one hand, this is the user's doing: reusing the same ID for
multiple things has always been a bad idea.

On the other hand, we're now turning a bad idea that may cause confusion
into an bad idea that may break things.  Feels iffy.

For QOM paths, we have a workaround: avoid partial QOM paths.  Feels
okay.  Partial QOM paths are rather obscure, and best avoided entirely.

The only workaround for block export vs. block node ambiguity is to
avoid ID reuse.  By the time a user sees the command fail, the IDs are
what they are, and there's is no workaround.

Do you need blockdev-replace to work for both *now*?

At the very least, we need to document the trap and point to the
workaround.

Alternatively, come up with an interface that avoids the issue.  See
below.

>> 3. If a block node named "foo" exists, it's case 3.
>> 
>> 2. If a block export named "foo" exists, it's also case 2.
>> 
>> 1. If exactly one QOM object named "foo" exists, it's also case 1.  Why?
>>     "foo" is a syntactically valid partial QOM path.  Partial QOM paths
>>     are a convenience feature that is virtually unknown (and possibly
>>     ill-advised): you can omit leading path components as long as there's
>>     no ambiguity.
>> 
>> Peeking ahead in the series...  PATCH 8 appears to deprecate the
>> ambiguity between case 2. and 3.
>> 
>> I think we need to do better.

See review of PATCH 8 for doing better on deprecation.

>> More questions...
>> 
>> In case 1 and 2, @child "should be root".  What happens when it's
>> something else?
>
> Error returned. s/should/must/ ?

Yes, please.

>> In case 3, @child "should be any if its children names".  I figure the
>> command fails when it isn't.
>
> And here.

Likewise.

>>> +{ 'command': 'blockdev-replace',
>>> +  'data': { 'parent': 'str', 'child': 'str', 'new-child': 'str' } }
>> 
>> [...]

This interface sort of overloads @parent and @child, and overloading the
former creates ambiguity that can make the command unusable.

@parent's set of valid values is the union of QOM path, block node name,
block export ID with values occuring in more than one of them dropped.

@child's set of valid values depends on @parent: child name when it's a
QOM path, else "root".

The obvious non-overloaded interface is a union of three branches: QOM,
block node, block export.  The QOM branch has variant members @qom-path
and @child.  The block node branch has variant member @node-name.  The
block export branch has variant member @id.

This is a bit more verbose: you have to specify the union tag[*].

If we ever need to replace block nodes associated with additional
things, we simply more branches.  These branches can have arbitrary
members.  In your interface, we'd have to make do with @child, or maybe
add optional arguments.

Thoughts?  Mind, this isn't a demand!  I'm exploring the design space.


[*] We could add a "may omit union tag when the tag value can be derived
from present variant members" convenience feature to QAPI, but I'm not
sure it's worth the complexity.


